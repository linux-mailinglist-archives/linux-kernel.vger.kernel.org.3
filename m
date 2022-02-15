Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A224B69B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiBOKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:49:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiBOKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:49:38 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898ABB56D;
        Tue, 15 Feb 2022 02:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644922168; x=1676458168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8wfwR/uCveJ2Q94/EFl7igRbByuFJMssLIeSVMsf1s=;
  b=Xd9HPtVv6QpbV4HWuI4bTcqWrv1KyCDoj4d/3QeAXiWQvsjy5VI6iZU6
   bgrDjFeM9tiZiS5TrDuwdnUSvVuTMcemvX3sTYwjArx5wbjn2uarhk5A6
   KxHEKI6vJ+hWMXHtqFjooL6GSjSstm0pVHFqWREQTtBq2wKq6YUecnonh
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 02:49:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:49:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 02:49:27 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 02:49:24 -0800
Date:   Tue, 15 Feb 2022 16:19:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
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

Hi Mathias,

On Tue, Feb 15, 2022 at 12:16:12PM +0200, Mathias Nyman wrote:
> On 14.2.2022 15.53, Pavan Kondeti wrote:
> > Hi Mathias,
> > 
> > On Mon, Feb 14, 2022 at 02:51:54PM +0200, Mathias Nyman wrote:
> >> On 14.2.2022 14.20, Pavankumar Kondeti wrote:
> >>> From: Daehwan Jung <dh10.jung@samsung.com>
> >>>
> >>> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> >>> controller reset and controller ready operations can be fatal to the
> >>> system when controller is timed out. Reduce the timeout to 1 second
> >>> and print a error message when the time out happens.
> >>>
> >>> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> >>
> >>
> >> The commit 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> >> intentionally increased the timeout to 10 seconds as that host might take 9
> >> seconds to complete reset. This was done almost 10 years ago so I don't know
> >> if it really is an issue anymore.
> >>
> >> Anyways, your patch might break Renesas 72021 instead of fixing it.
> > 
> > Unfortunately, yes :-( . We have this reduced timeout patch in our previous
> > commercialized products so thought this would be a good time to fix this
> > once for all. Since this patch has been 10 years long, not sure if any other
> > controllers also need 10 sec timeout. It would probably better
> > 
> >>
> >> I agree that busylooping up to 10 seconds with interrupts disabled doesn't make sense.
> >>
> >> Lets see if there is another solution for your case.
> >>
> >> - Does a "guard interval" after writing the reset help?
> >>   For example Intel xHCI needs 1ms before touching xHC after writing the reset bit
> > 
> > I will ask this question to our hardware team. Setting that one quirk from
> > DWC3 host might require other changes like this [1].
> >>
> >> - Is it the CNR bit or the RESET bit that fails? could be just stuck CNR bit? 
> > 
> > The RESET bit never gets cleared from USBCMD register.
> > 
> >>  
> >> - we only disable local interrupts when xhci_reset() is called from xhci_stop(),
> >>   and sometimes from xhci_shutdown() and xhci_resume() if some conditions are met.
> >>   Have you identified which one is the problematic case?
> > 
> > The crash reports I have seen are pointing to
> > 
> > usb_remove_hcd()->xhci_stop()->xhci_reset()
> 
> Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
> disabled and spinlock held. In both these cases we're not that interested in the
> outcome of xhci_reset().
> 
> But during probe we call xhci_reset() with interrupts enabled without spinlock,
> and here we really care about it succeeding.
> I'm also guessing reset could take a longer time during probe due to possible recent
> BIOS handover, or firmware loading etc.
> 
> So how about passing a timeout value to xhci_reset()?
> Give it 10 seconds during probe, and 250ms in the other cases.
> 

Thanks for this suggestion.

This sounds better compared to the quirks approach. xhci_resume() also seems
to be calling xhci_reset() in the hibernation path, I believe we should treat
this like probe()/startup case and give larger timeout.

Thanks,
Pavan
