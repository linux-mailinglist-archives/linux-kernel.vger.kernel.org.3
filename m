Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A84B769D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbiBORHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:07:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbiBORHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:07:36 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ACAB8205;
        Tue, 15 Feb 2022 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644944846; x=1676480846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+JpbIHuzke99VLBmFb4jp6NSmY6YzdO9Kn149zGqUsA=;
  b=KihhB+g/MM2z0bBKVUK1uf1spEFXtmee5LSJ4XS+wzKOijjtW5Y5bORA
   K89d6JbwJowzxfqoAN/ordIXIFnp1zyUODfd2KYx07wRV1vDyXzuiN4QY
   cfC8vvSLP+JxOt9H8BjOwjPFUjCv+O7mlcwwLlsQFZMQUg1LbdmdcCIk8
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 09:07:25 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 09:07:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 09:07:25 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 09:07:22 -0800
Date:   Tue, 15 Feb 2022 22:37:18 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ugoswami@quicinc.com>, Jung Daehwan <dh10.jung@samsung.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <20220215170718.GF31021@hu-pkondeti-hyd.qualcomm.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
 <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
 <20220214135310.GC31021@hu-pkondeti-hyd.qualcomm.com>
 <1b9e7641-2ae9-0f81-2ad9-18340d5e148f@linux.intel.com>
 <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220215104920.GE31021@hu-pkondeti-hyd.qualcomm.com>
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

On Tue, Feb 15, 2022 at 04:19:20PM +0530, Pavan Kondeti wrote:
> Hi Mathias,
> 
> On Tue, Feb 15, 2022 at 12:16:12PM +0200, Mathias Nyman wrote:
> > On 14.2.2022 15.53, Pavan Kondeti wrote:
> > > Hi Mathias,
> > > 
> > > On Mon, Feb 14, 2022 at 02:51:54PM +0200, Mathias Nyman wrote:
> > >> On 14.2.2022 14.20, Pavankumar Kondeti wrote:
> > >>> From: Daehwan Jung <dh10.jung@samsung.com>
> > >>>
> > >>> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> > >>> controller reset and controller ready operations can be fatal to the
> > >>> system when controller is timed out. Reduce the timeout to 1 second
> > >>> and print a error message when the time out happens.
> > >>>
> > >>> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > >>
> > >>
> > >> The commit 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
> > >> intentionally increased the timeout to 10 seconds as that host might take 9
> > >> seconds to complete reset. This was done almost 10 years ago so I don't know
> > >> if it really is an issue anymore.
> > >>
> > >> Anyways, your patch might break Renesas 72021 instead of fixing it.
> > > 
> > > Unfortunately, yes :-( . We have this reduced timeout patch in our previous
> > > commercialized products so thought this would be a good time to fix this
> > > once for all. Since this patch has been 10 years long, not sure if any other
> > > controllers also need 10 sec timeout. It would probably better
> > > 
> > >>
> > >> I agree that busylooping up to 10 seconds with interrupts disabled doesn't make sense.
> > >>
> > >> Lets see if there is another solution for your case.
> > >>
> > >> - Does a "guard interval" after writing the reset help?
> > >>   For example Intel xHCI needs 1ms before touching xHC after writing the reset bit
> > > 
> > > I will ask this question to our hardware team. Setting that one quirk from
> > > DWC3 host might require other changes like this [1].
> > >>
> > >> - Is it the CNR bit or the RESET bit that fails? could be just stuck CNR bit? 
> > > 
> > > The RESET bit never gets cleared from USBCMD register.
> > > 
> > >>  
> > >> - we only disable local interrupts when xhci_reset() is called from xhci_stop(),
> > >>   and sometimes from xhci_shutdown() and xhci_resume() if some conditions are met.
> > >>   Have you identified which one is the problematic case?
> > > 
> > > The crash reports I have seen are pointing to
> > > 
> > > usb_remove_hcd()->xhci_stop()->xhci_reset()
> > 
> > Ok, so xhci_stop() and xhci_shutdown() both may call xhci_reset() with interrupts
> > disabled and spinlock held. In both these cases we're not that interested in the
> > outcome of xhci_reset().
> > 
> > But during probe we call xhci_reset() with interrupts enabled without spinlock,
> > and here we really care about it succeeding.
> > I'm also guessing reset could take a longer time during probe due to possible recent
> > BIOS handover, or firmware loading etc.
> > 
> > So how about passing a timeout value to xhci_reset()?
> > Give it 10 seconds during probe, and 250ms in the other cases.
> > 
> 
> Thanks for this suggestion.
> 
> This sounds better compared to the quirks approach. xhci_resume() also seems
> to be calling xhci_reset() in the hibernation path, I believe we should treat
> this like probe()/startup case and give larger timeout.
> 
I will test the below patch as per Mathias suggestion.

Thanks,
Pavan

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index df3522d..031fe90 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -762,7 +762,7 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
 	}
 	pm_runtime_allow(xhci_to_hcd(xhci)->self.controller);
 	xhci->test_mode = 0;
-	return xhci_reset(xhci);
+	return xhci_reset(xhci, false);
 }
 
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 0e31206..174dccd 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2583,7 +2583,7 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 
 fail:
 	xhci_halt(xhci);
-	xhci_reset(xhci);
+	xhci_reset(xhci, false);
 	xhci_mem_cleanup(xhci);
 	return -ENOMEM;
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index f5b1bcc..2137581 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -162,7 +162,7 @@ int xhci_start(struct xhci_hcd *xhci)
  * Transactions will be terminated immediately, and operational registers
  * will be set to their defaults.
  */
-int xhci_reset(struct xhci_hcd *xhci)
+int xhci_reset(struct xhci_hcd *xhci, bool must_succeed)
 {
 	u32 command;
 	u32 state;
@@ -195,8 +195,16 @@ int xhci_reset(struct xhci_hcd *xhci)
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		udelay(1000);
 
+	/*
+	 * xhci_reset() can be called with interrupts disabled, use
+	 * 10 seconds timeout during start/resume only. stop/shutdown
+	 * can get away with lower timeout as controller reset failure
+	 * is not fatal.
+	 */
 	ret = xhci_handshake(&xhci->op_regs->command,
-			CMD_RESET, 0, 10 * 1000 * 1000);
+			CMD_RESET, 0, must_succeed ?
+			10 * 1000 * 1000 :
+			250 * 1000);
 	if (ret)
 		return ret;
 
@@ -210,7 +218,9 @@ int xhci_reset(struct xhci_hcd *xhci)
 	 * than status until the "Controller Not Ready" flag is cleared.
 	 */
 	ret = xhci_handshake(&xhci->op_regs->status,
-			STS_CNR, 0, 10 * 1000 * 1000);
+			STS_CNR, 0, must_succeed ?
+			10 * 1000 * 1000 :
+			250 * 1000);
 
 	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
 	xhci->usb2_rhub.bus_state.suspended_ports = 0;
@@ -731,7 +741,7 @@ static void xhci_stop(struct usb_hcd *hcd)
 	xhci->xhc_state |= XHCI_STATE_HALTED;
 	xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
 	xhci_halt(xhci);
-	xhci_reset(xhci);
+	xhci_reset(xhci, false);
 	spin_unlock_irq(&xhci->lock);
 
 	xhci_cleanup_msix(xhci);
@@ -784,7 +794,7 @@ void xhci_shutdown(struct usb_hcd *hcd)
 	xhci_halt(xhci);
 	/* Workaround for spurious wakeups at shutdown with HSW */
 	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		xhci_reset(xhci);
+		xhci_reset(xhci, false);
 	spin_unlock_irq(&xhci->lock);
 
 	xhci_cleanup_msix(xhci);
@@ -1163,7 +1173,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		xhci_dbg(xhci, "Stop HCD\n");
 		xhci_halt(xhci);
 		xhci_zero_64b_regs(xhci);
-		retval = xhci_reset(xhci);
+		retval = xhci_reset(xhci, true);
 		spin_unlock_irq(&xhci->lock);
 		if (retval)
 			return retval;
@@ -5308,7 +5318,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	xhci_dbg(xhci, "Resetting HCD\n");
 	/* Reset the internal HC memory state and registers. */
-	retval = xhci_reset(xhci);
+	retval = xhci_reset(xhci, true);
 	if (retval)
 		return retval;
 	xhci_dbg(xhci, "Reset complete\n");
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5a75fe5..331a38f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2087,7 +2087,7 @@ int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void xhci_quiesce(struct xhci_hcd *xhci);
 int xhci_halt(struct xhci_hcd *xhci);
 int xhci_start(struct xhci_hcd *xhci);
-int xhci_reset(struct xhci_hcd *xhci);
+int xhci_reset(struct xhci_hcd *xhci, bool must_succeed);
 int xhci_run(struct usb_hcd *hcd);
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_shutdown(struct usb_hcd *hcd);

