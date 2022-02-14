Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC384B4182
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiBNFxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:53:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiBNFxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:53:14 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F1C5007A;
        Sun, 13 Feb 2022 21:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644817987; x=1676353987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1w/3HQfAzk9kDPixP2ODj7i3Qd2EPVt0FxpEGfaxRI=;
  b=hYu/pQ73W4mQ85tnCpWgqKpH+b5hnvxDQgZ/WLettH7TeafcBUkyNs31
   vWXj6uTshIgd7ZSSXo51R2rGkE2wLClZckRd3DrtjPu+ZvpsjiALDdsCb
   GYBTxASEdZzIRJfOxfdjIkVcDR/uq1IFwRMu5zimGY/ceT0m1qSEF2Q7O
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Feb 2022 21:53:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 21:53:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 21:53:06 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 13 Feb 2022 21:53:03 -0800
Date:   Mon, 14 Feb 2022 11:22:59 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jung Daehwan <dh10.jung@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>
Subject: Re: usb: host: Reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220214055259.GA19990@hu-pkondeti-hyd.qualcomm.com>
References: <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
 <YNJAZDwuFmEoTJHe@kroah.com>
 <20210628022548.GA69289@ubuntu>
 <YNlxzj7KXG43Uyrp@kroah.com>
 <20210628065553.GA83203@ubuntu>
 <496c9d86-70d7-1050-5bbb-9f841e4b464a@intel.com>
 <20220211064630.GA20567@hu-pkondeti-hyd.qualcomm.com>
 <20220211074331.GA12625@hu-pkondeti-hyd.qualcomm.com>
 <20220214040838.GA8039@hu-pkondeti-hyd.qualcomm.com>
 <YgnnCOwmrPprkWoJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YgnnCOwmrPprkWoJ@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Feb 14, 2022 at 06:22:16AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 14, 2022 at 09:38:38AM +0530, Pavan Kondeti wrote:
> > Hi Greg,
> > 
> > On Fri, Feb 11, 2022 at 01:13:31PM +0530, Pavan Kondeti wrote:
> > > Sorry for the spam. I have added an incorrect email address in my previous
> > > email.
> > > 
> > > On Fri, Feb 11, 2022 at 12:16:30PM +0530, Pavan Kondeti wrote:
> > > > On Mon, Jun 28, 2021 at 10:49:00AM +0300, Mathias Nyman wrote:
> > > > > On 28.6.2021 9.55, Jung Daehwan wrote:
> > > > > > On Mon, Jun 28, 2021 at 08:53:02AM +0200, Greg Kroah-Hartman wrote:
> > > > > >> On Mon, Jun 28, 2021 at 11:25:48AM +0900, Jung Daehwan wrote:
> > > > > >>> On Tue, Jun 22, 2021 at 09:56:20PM +0200, Greg Kroah-Hartman wrote:
> > > > > >>>> On Tue, Jun 22, 2021 at 08:24:56PM +0900, Daehwan Jung wrote:
> 
> <snip>
> 
> > Can you please consider including this change? Let us know if you want this
> > patch to be resent again with error message and Fixes tag included.
> 
> You are responding to an email thread from 6 months ago, without any
> change in it at all, so I have no idea what you are referring to here,
> sorry.
> 
> Please resend any patch you wish to have reviewed, as obviously it is no
> longer in our queue and might not even be relevant anymore (you have
> tested 5.17-rc4, right?)

Thanks Greg for the reply. We will test the patch on the latest tree and
resend it.

Thanks,
Pavan
