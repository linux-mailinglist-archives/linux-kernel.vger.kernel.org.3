Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EE4B964C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiBQDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:04:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiBQDEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:04:04 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9523BF2B;
        Wed, 16 Feb 2022 19:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645067031; x=1676603031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RhyL2jS7+HJqsAu/LNZglEPwWlKDeA0PnF0rf3RKWIE=;
  b=LBdqe75HzcKWXh88Tf03GMmhEx1yoOZUVua/ymKWjdh2u3f6gNg7uvzx
   lfQQOlA9D7yrp01Uad7EQgzAQtOeWHtotUwQ3cZ/UMFC8QE3ERhh7JwyM
   bPoMCz7/bpCOkfDE9OY0hbALJeMrnsaSShZkpdmNCqBCDnd5xSpMEU2P6
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Feb 2022 19:03:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 19:03:51 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 19:03:50 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 19:03:47 -0800
Date:   Thu, 17 Feb 2022 08:33:43 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220217030343.GA32039@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
 <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
 <20220215170718.GF31021@hu-pkondeti-hyd.qualcomm.com>
 <70ebdb8c-1ea5-1a3e-046e-5e457f54726d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70ebdb8c-1ea5-1a3e-046e-5e457f54726d@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
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

On Wed, Feb 16, 2022 at 05:58:15PM +0200, Mathias Nyman wrote:
> On 15.2.2022 19.07, Pavan Kondeti wrote:
> >>>>
> >>>> The crash reports I have seen are pointing to
> >>>>
> >>>> usb_remove_hcd()->xhci_stop()->xhci_reset()
> >>>
> >>> Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
> >>> disabled and spinlock held. In both these cases we're not that interested in the
> >>> outcome of xhci_reset().
> >>>
> >>> But during probe we call xhci_reset() with interrupts enabled without spinlock,
> >>> and here we really care about it succeeding.
> >>> I'm also guessing reset could take a longer time during probe due to possible recent
> >>> BIOS handover, or firmware loading etc.
> >>>
> >>> So how about passing a timeout value to xhci_reset()?
> >>> Give it 10 seconds during probe, and 250ms in the other cases.
> >>>
> >>
> >> Thanks for this suggestion.
> >>
> >> This sounds better compared to the quirks approach. xhci_resume() also seems
> >> to be calling xhci_reset() in the hibernation path, I believe we should treat
> >> this like probe()/startup case and give larger timeout.
> >>
> > I will test the below patch as per Mathias suggestion.
> > 
> > Thanks,
> > Pavan
> > 
> > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > index df3522d..031fe90 100644
> > --- a/drivers/usb/host/xhci-hub.c
> > +++ b/drivers/usb/host/xhci-hub.c
> > @@ -762,7 +762,7 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
> >  	}
> >  	pm_runtime_allow(xhci_to_hcd(xhci)->self.controller);
> >  	xhci->test_mode = 0;
> > -	return xhci_reset(xhci);
> > +	return xhci_reset(xhci, false);
> 
> Maybe just pass the timeout value directly to xhci_reset().
> Looks like readl_poll_timeout_atomic() uses u64 for timeout_us,
> makes sense to use the same.
> 
> Sergey also pointed out xhci_handshake() incorrectly uses a signed integer for timeouts.
> This could be changed to u64 as well.
> 
> I'll write a patch that does all above
> 
Thank you. I will look forward to your patch and provide the test results with
it.

Thanks,
Pavan
