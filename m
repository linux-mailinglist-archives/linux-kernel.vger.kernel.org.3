Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B988B4B415F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiBNFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:22:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiBNFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:22:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C254E38D;
        Sun, 13 Feb 2022 21:22:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2743611B9;
        Mon, 14 Feb 2022 05:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98835C340EB;
        Mon, 14 Feb 2022 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644816145;
        bh=CQfQZ3f9RQT0yD3JRDy/qWCxhyDYYYvRdkfkmt0M/yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctt3oT6ij3pbBY8F7sOXeGTPlfXgqoV90FnzOP2y/jMgCPdpQTmo3RrMQMjkqh6vG
         KpXse+PtZhYUj49ZkOkxxBfcm1rxxQTZvgQ2+6gIga5qrM+jB0+FCb709tGQZ2Zq1C
         BFXDFN7aQBcS3SrSJO9CTLSOMKFe67Zt9kbAkZmI=
Date:   Mon, 14 Feb 2022 06:22:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jung Daehwan <dh10.jung@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <YgnnCOwmrPprkWoJ@kroah.com>
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
 <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
 <YNJAZDwuFmEoTJHe@kroah.com>
 <20210628022548.GA69289@ubuntu>
 <YNlxzj7KXG43Uyrp@kroah.com>
 <20210628065553.GA83203@ubuntu>
 <496c9d86-70d7-1050-5bbb-9f841e4b464a@intel.com>
 <20220211064630.GA20567@hu-pkondeti-hyd.qualcomm.com>
 <20220211074331.GA12625@hu-pkondeti-hyd.qualcomm.com>
 <20220214040838.GA8039@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214040838.GA8039@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:38:38AM +0530, Pavan Kondeti wrote:
> Hi Greg,
> 
> On Fri, Feb 11, 2022 at 01:13:31PM +0530, Pavan Kondeti wrote:
> > Sorry for the spam. I have added an incorrect email address in my previous
> > email.
> > 
> > On Fri, Feb 11, 2022 at 12:16:30PM +0530, Pavan Kondeti wrote:
> > > On Mon, Jun 28, 2021 at 10:49:00AM +0300, Mathias Nyman wrote:
> > > > On 28.6.2021 9.55, Jung Daehwan wrote:
> > > > > On Mon, Jun 28, 2021 at 08:53:02AM +0200, Greg Kroah-Hartman wrote:
> > > > >> On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
> > > > >>> On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> > > > >>>> On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:

<snip>

> Can you please consider including this change? Let us know if you want this
> patch to be resent again with error message and Fixes tag included.

You are responding to an email thread from 6 months ago, without any
change in it at all, so I have no idea what you are referring to here,
sorry.

Please resend any patch you wish to have reviewed, as obviously it is no
longer in our queue and might not even be relevant anymore (you have
tested 5.17-rc4, right?)

thanks,

greg k-h
