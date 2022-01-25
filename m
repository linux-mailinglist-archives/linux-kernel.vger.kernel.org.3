Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7D49B25D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377822AbiAYKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376709AbiAYKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:47:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158ECC061773;
        Tue, 25 Jan 2022 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k6IRqDL20I9/iZr4XnUVcjDnXG5tq+iBxynWuS6ogdg=; b=sdd4cTeba7EfOnTUHsQgRgl0Lv
        eIss2FIPzU3hfEPkDFpHRm2xCR3QcmnLDXmalTGNvTpiD/E3/LgDpd+HtX48Ru88P3pYxE1y9tjcs
        a/3TeB9NXCiocertZo0e6m3v86japXVQaYTAUPWR1Cnn2wV/obfZ1uq5ai0FATcmxciOTnr7B0SQy
        gHNrl6Dz8k6fChu8LkKltP17m7/yEpIlExGMDXu3RxR8rQUQRvsqAFfHHDZJI4egePfIAn1R9GeSr
        KMTx/UjupI9BrCuuOsrJAfAKvrd2OvQvxb6fGLYX4Q0x8NCJaGPQPG1GHsXdrH2h9u5uhTIBgW+95
        lkRdC2VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCJM0-002Z23-Tx; Tue, 25 Jan 2022 10:47:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A02C300296;
        Tue, 25 Jan 2022 11:47:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F515201A0863; Tue, 25 Jan 2022 11:47:11 +0100 (CET)
Date:   Tue, 25 Jan 2022 11:47:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Ye/VL4b1PUCsCeds@hirez.programming.kicks-ass.net>
References: <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye7WLM+NyVQlEMXN@hirez.programming.kicks-ass.net>
 <Ye7X5I4lm8gtRaBv@hirez.programming.kicks-ass.net>
 <6e2700c4-07dd-76ac-cd8f-d9e5b9b24e74@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e2700c4-07dd-76ac-cd8f-d9e5b9b24e74@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:51:00AM +0200, Mathias Nyman wrote:
> On 24.1.2022 18.46, Peter Zijlstra wrote:

> > FYI, I'm thinking early_xdbc_parse_parameter should've now given
> > dpgp_num: 1 ?
> > 
> 
> Yes, it should. 
> 
> Looks like there's a parsing issue.
> "earlyprintk=xdbc1,keep" fails on our Tigerlake as well.
>   
> Without the "keep" option it works for me:
> 
> [    0.000000] Command line: console=ttyS0,115200n8 buildroot_hostname=tgl04 earlyprintk=xdbc1 dmi_entry_point=0x74374000
> [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 1

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0+ root=UUID=a652986c-fbc6-4341-85c3-b4ad4402f130 ro debug ignore_loglevel sysrq_always_enabled usbcore.autosuspend=-1 earlyprintk=xdbc1,keep force_early_printk sched_verbose ft
race=nop mitigations=off nokaslr

[    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 1

[    0.399988] xhci_dbc:xdbc_start: DbC is running now, control 0x8d000003 port ID 15
[    0.399998] xhci_dbc:xdbc_handle_port_status: connect status change event
[    0.399999] xhci_dbc:xdbc_handle_port_status: port reset change event
[    0.431217] printk: console [earlyxdbc0] enabled

Success!! I'll go submit proper patches for this then.

---

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index d3c531d3b244..68b38925a74f 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -387,7 +387,7 @@ static int __init setup_early_printk(char *buf)
 #endif
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
 		if (!strncmp(buf, "xdbc", 4))
-			early_xdbc_parse_parameter(buf + 4);
+			early_xdbc_parse_parameter(buf + 4, keep);
 #endif
 
 		buf++;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a698196377be..9bf3872895ab 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1505,6 +1505,7 @@ void __init tsc_early_init(void)
 	loops_per_jiffy = get_loops_per_jiffy();
 
 	tsc_enable_sched_clock();
+	use_tsc_delay();
 }
 
 void __init tsc_init(void)
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 4502108069cd..a40db9618e8e 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -29,11 +29,15 @@
 static struct xdbc_state xdbc;
 static bool early_console_keep;
 
+#if 0
 #ifdef XDBC_TRACE
 #define	xdbc_trace	trace_printk
 #else
 static inline void xdbc_trace(const char *fmt, ...) { }
 #endif /* XDBC_TRACE */
+#else
+#define xdbc_trace	pr_err
+#endif
 
 static void __iomem * __init xdbc_map_pci_mmio(u32 bus, u32 dev, u32 func)
 {
@@ -417,9 +421,11 @@ static void xdbc_ring_doorbell(int target)
 
 static int xdbc_start(void)
 {
+	bool first_try = true;
 	u32 ctrl, status;
 	int ret;
 
+retry:
 	ctrl = readl(&xdbc.xdbc_reg->control);
 	writel(ctrl | CTRL_DBC_ENABLE | CTRL_PORT_ENABLE, &xdbc.xdbc_reg->control);
 	ret = handshake(&xdbc.xdbc_reg->control, CTRL_DBC_ENABLE, CTRL_DBC_ENABLE, 100000, 100);
@@ -429,13 +435,21 @@ static int xdbc_start(void)
 	}
 
 	/* Reset port to avoid bus hang: */
-	if (xdbc.vendor == PCI_VENDOR_ID_INTEL)
+	if (xdbc.vendor == PCI_VENDOR_ID_INTEL && first_try)
 		xdbc_reset_debug_port();
 
 	/* Wait for port connection: */
 	ret = handshake(&xdbc.xdbc_reg->portsc, PORTSC_CONN_STATUS, PORTSC_CONN_STATUS, 5000000, 100);
 	if (ret) {
-		xdbc_trace("waiting for connection timed out\n");
+		xdbc_trace("waiting for connection timed out, DCPORTSC:0x%x\n",
+				readl(&xdbc.xdbc_reg->portsc));
+		if (first_try) {
+			first_try = false;
+			/* Toggle DCE and retry without port reset */
+			writel(0, &xdbc.xdbc_reg->control);
+			handshake(&xdbc.xdbc_reg->control, CTRL_DBC_ENABLE, 0, 100000, 10);
+			goto retry;
+		}
 		return ret;
 	}
 
@@ -599,23 +631,26 @@ static int __init xdbc_early_setup(void)
 	return 0;
 }
 
-int __init early_xdbc_parse_parameter(char *s)
+int __init early_xdbc_parse_parameter(char *s, int keep_early)
 {
 	unsigned long dbgp_num = 0;
 	u32 bus, dev, func, offset;
+	char *e;
 	int ret;
 
 	if (!early_pci_allowed())
 		return -EPERM;
 
-	if (strstr(s, "keep"))
-		early_console_keep = true;
+	early_console_keep = keep_early;
 
 	if (xdbc.xdbc_reg)
 		return 0;
 
-	if (*s && kstrtoul(s, 0, &dbgp_num))
-		dbgp_num = 0;
+	if (*s) {
+	       dbgp_num = simple_strtoul(s, &e, 10);
+	       if (s == e)
+		       dbgp_num = 0;
+	}
 
 	pr_notice("dbgp_num: %lu\n", dbgp_num);
 
diff --git a/include/linux/usb/xhci-dbgp.h b/include/linux/usb/xhci-dbgp.h
index 0a37f1283bf0..01fe768873f9 100644
--- a/include/linux/usb/xhci-dbgp.h
+++ b/include/linux/usb/xhci-dbgp.h
@@ -15,7 +15,7 @@
 #define __LINUX_XHCI_DBGP_H
 
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
-int __init early_xdbc_parse_parameter(char *s);
+int __init early_xdbc_parse_parameter(char *s, int keep_early);
 int __init early_xdbc_setup_hardware(void);
 void __init early_xdbc_register_console(void);
 #else
