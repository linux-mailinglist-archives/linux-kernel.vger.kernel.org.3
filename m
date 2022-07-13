Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108AF572E49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiGMGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiGMGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F04AEF43;
        Tue, 12 Jul 2022 23:36:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2386361C3C;
        Wed, 13 Jul 2022 06:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F180BC34114;
        Wed, 13 Jul 2022 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657694216;
        bh=CMSUMXXc0AsUsrZXjzn8tfNp/uCoq+3nHhn43pNXTGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTbE6ou8P+9zj6YYBv9iwaxMHtMGeVaBVrSHr9RQ8rZntNrZuVrw5hA8hT/p6wa7i
         H9ENdl+UOuWkotdda8l1x5N29KuAYVw1hkd5Nax5wbE2unYPcMhfSUowiJTRtp5YWI
         GhSEIuMjc3vJJSvXN4qyof96Fd+PxZjUYWt3Do/o=
Date:   Wed, 13 Jul 2022 08:36:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v16 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <Ys5oBTeIcLjf7gnX@kroah.com>
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <0bd85140-f006-8b29-0a43-500733f1654c@roeck-us.net>
 <Ys16lEvhVSSSRMP7@kroah.com>
 <20220713062845.GB2788915@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713062845.GB2788915@anxtwsw-Precision-3640-Tower>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:28:45PM +0800, Xin Ji wrote:
> On Tue, Jul 12, 2022 at 03:43:48PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 12, 2022 at 06:31:22AM -0700, Guenter Roeck wrote:
> > > On 7/12/22 02:05, Xin Ji wrote:
> > > > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > > > and a port controller (TCPC) - may require that the driver for the PD
> > > > controller accesses directly also the on-chip port controller in some cases.
> > > > 
> > > > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > > > 
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > 
> > > > ---
> > > > V9 -> V10: Rebase on the latest code
> > > > V8 -> V9 : Add more commit message
> > > > V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> > > 
> > > We are now at v16. The change log has not been updated since v10,
> > > making it all but worthless.
> > 
> > It's also already in my tree for a while, so I have no idea what this is
> > being generated against :(
> Hi all, I'm little confused, do I need update change log from v11 to
> v16? There is no changes since v10.

I'm confused, why are you sending a patch over that is already in my
tree and in linux-next?  You got an email saying it was merged, see
commit 7963d4d71011 ("usb: typec: tcpci: move tcpci.h to
include/linux/usb/").

thanks,

greg k-h
