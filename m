Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAA51CC15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386319AbiEEWgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386276AbiEEWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB045AE9;
        Thu,  5 May 2022 15:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DBD461E05;
        Thu,  5 May 2022 22:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A86C385AF;
        Thu,  5 May 2022 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651789986;
        bh=nI5TfZ+O5Xvzg7yEHblugPWPUU9wcy1OYsHpnvSqpXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrY7wwzVtmUQFp0Y9furkeCM71/j4gJg+eRrhodsRPPykVtpLWt3lS3pDBv2Z+/gW
         9LSxXLuZ57P7gsEcrpJ4i6ZWxeaPk0I++GdQFQ5rDt3prQT14MTmbnrDaLIyATBb1Q
         JBKV0TqP8yPk7Y23LAYJ6YxLnTeGnAn7Bwuih6JY=
Date:   Thu, 5 May 2022 21:31:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        linux-usb@vger.kernel.org, Jun Li <jun.li@nxp.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to
 composite EP number
Message-ID: <YnQmLfmHQCJX3seH@kroah.com>
References: <20220427163525.1129887-1-Frank.Li@nxp.com>
 <Yml16DvnUR/tJSCO@kroah.com>
 <CAHrpEqQzBpNej+z6Td-snWtP1OqE8u_DAB6jAs-KAUBHmKcYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqQzBpNej+z6Td-snWtP1OqE8u_DAB6jAs-KAUBHmKcYkg@mail.gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:03:22PM -0500, Zhi Li wrote:
> On Wed, Apr 27, 2022 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 11:35:25AM -0500, Frank Li wrote:
> > > Some devices have USB compositions which may require multiple endpoints.
> > > To get better performance, need bigger CDNS3_EP_BUF_SIZE.
> > >
> > > But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
> > > multiple endpoints.
> > >
> > > By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.
> > >
> > > Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
> > > Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
> > > ecnds3_device:ep_iso_burst
> > >
> > > Using a simple algorithm to calculate ep_buf_size.
> > > ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
> > > 1).
> > >
> > > Test at 8qxp:
> > >
> > >       Gadget                  ep_buf_size
> > >
> > >       RNDIS:                          5
> > >       RNDIS+ACM:                      3
> > >       Mass Storage + NCM + ACM        2
> > >
> > > Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
> > > exceed FIFO memory.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2:
> > >  Add safe check for mult, buffering and maxburst
> >
> > that's nice, but this is v8, not v2?
> 
> Sorry, It should be v2. I made a mistake with the title.

Ok, the next version needs to be 9 to keep everything from getting
really confused.

thanks,

greg k-h
