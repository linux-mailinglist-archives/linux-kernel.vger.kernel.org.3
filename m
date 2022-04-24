Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EAB50D157
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiDXK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiDXK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:57:07 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C12494F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:54:06 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 220CA82A77;
        Sun, 24 Apr 2022 10:54:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 97E6718;
        Sun, 24 Apr 2022 10:54:03 +0000 (UTC)
Message-ID: <92734c71f40541a5e8b4af16c5c4f1563660fa92.camel@perches.com>
Subject: Re: [PATCH] tty/hvc_opal: simplify if-if to if-else
From:   Joe Perches <joe@perches.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Date:   Sun, 24 Apr 2022 03:54:02 -0700
In-Reply-To: <20220424092511.100309-1-wanjiabing@vivo.com>
References: <20220424092511.100309-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: ipzcjh49t4bqqwpjuot4qwkemmewgkxe
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 97E6718
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Ywp7PsG3t9mCNnY0D/c9qTE7hc2KP1mk=
X-HE-Tag: 1650797643-85386
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-24 at 17:25 +0800, Wan Jiabing wrote:
> Use if and else instead of if(A) and if (!A).
[]
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
[]
> @@ -344,14 +344,15 @@ void __init hvc_opal_init_early(void)
>  		opal = of_find_node_by_path("/ibm,opal/consoles");
>  		if (opal)
>  			pr_devel("hvc_opal: Found consoles in new location\n");
> -		if (!opal) {
> +		else {
>  			opal = of_find_node_by_path("/ibm,opal");
>  			if (opal)
>  				pr_devel("hvc_opal: "
>  					 "Found consoles in old location\n");
> +			else
> +				return;

A few things:

o add {} braces to first block before else
o see about using pr_fmt to prefix the pr_<level> output
o reverse the test and unindent the pr_devel

			if (!opal)
				return;
			pr_devel("...);

Maybe a few more just to quiet checkpatch noise.  Something like:
---
 drivers/tty/hvc/hvc_opal.c | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 84776bc641e6b..a42d5697ae198 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -5,6 +5,8 @@
  * Copyright 2011 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #undef DEBUG
 
 #include <linux/types.h>
@@ -43,6 +45,7 @@ struct hvc_opal_priv {
 	hv_protocol_t		proto;	/* Raw data or HVSI packets */
 	struct hvsi_priv	hvsi;	/* HVSI specific data */
 };
+
 static struct hvc_opal_priv *hvc_opal_privs[MAX_NR_HVC_CONSOLES];
 
 /* For early boot console */
@@ -124,7 +127,7 @@ static int hvc_opal_hvsi_tiocmget(struct hvc_struct *hp)
 }
 
 static int hvc_opal_hvsi_tiocmset(struct hvc_struct *hp, unsigned int set,
-				unsigned int clear)
+				  unsigned int clear)
 {
 	struct hvc_opal_priv *pv = hvc_opal_privs[hp->vtermno];
 
@@ -167,8 +170,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		proto = HV_PROTOCOL_HVSI;
 		ops = &hvc_opal_hvsi_ops;
 	} else {
-		pr_err("hvc_opal: Unknown protocol for %pOF\n",
-		       dev->dev.of_node);
+		pr_err("Unknown protocol for %pOF\n", dev->dev.of_node);
 		return -ENXIO;
 	}
 
@@ -195,15 +197,16 @@ static int hvc_opal_probe(struct platform_device *dev)
 				     termno, 0);
 		}
 
-		/* Instanciate now to establish a mapping index==vtermno */
+		/* Instantiate now to establish a mapping index==vtermno */
 		hvc_instantiate(termno, termno, ops);
 	} else {
-		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
+		pr_err("Device %pOF has duplicate terminal number #%d\n",
 		       dev->dev.of_node, termno);
 		return -ENXIO;
 	}
 
-	pr_info("hvc%d: %s protocol on %pOF%s\n", termno,
+	pr_info("hvc%d: %s protocol on %pOF%s\n",
+		termno,
 		proto == HV_PROTOCOL_RAW ? "raw" : "hvsi",
 		dev->dev.of_node,
 		boot ? " (boot console)" : "");
@@ -211,13 +214,13 @@ static int hvc_opal_probe(struct platform_device *dev)
 	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
 	if (!irq) {
 		pr_info("hvc%d: No interrupts property, using OPAL event\n",
-				termno);
+			termno);
 		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
 	}
 
 	if (!irq) {
-		pr_err("hvc_opal: Unable to map interrupt for device %pOF\n",
-			dev->dev.of_node);
+		pr_err("Unable to map interrupt for device %pOF\n",
+		       dev->dev.of_node);
 		return irq;
 	}
 
@@ -275,7 +278,7 @@ static void udbg_opal_putc(char c)
 		udbg_opal_putc('\r');
 
 	do {
-		switch(hvc_opal_boot_priv.proto) {
+		switch (hvc_opal_boot_priv.proto) {
 		case HV_PROTOCOL_RAW:
 			count = opal_put_chars(termno, &c, 1);
 			break;
@@ -288,7 +291,7 @@ static void udbg_opal_putc(char c)
 		 * when there aren't any interrupts.
 		 */
 		opal_flush_console(termno);
-	} while(count == 0 || count == -EAGAIN);
+	} while (count == 0 || count == -EAGAIN);
 }
 
 static int udbg_opal_getc_poll(void)
@@ -297,7 +300,7 @@ static int udbg_opal_getc_poll(void)
 	int rc = 0;
 	char c;
 
-	switch(hvc_opal_boot_priv.proto) {
+	switch (hvc_opal_boot_priv.proto) {
 	case HV_PROTOCOL_RAW:
 		rc = opal_get_chars(termno, &c, 1);
 		break;
@@ -313,6 +316,7 @@ static int udbg_opal_getc_poll(void)
 static int udbg_opal_getc(void)
 {
 	int ch;
+
 	for (;;) {
 		ch = udbg_opal_getc_poll();
 		if (ch != -1)
@@ -342,16 +346,14 @@ void __init hvc_opal_init_early(void)
 		 * path, so we hard wire it
 		 */
 		opal = of_find_node_by_path("/ibm,opal/consoles");
-		if (opal)
-			pr_devel("hvc_opal: Found consoles in new location\n");
-		if (!opal) {
+		if (opal) {
+			pr_devel("Found consoles in new location\n");
+		} else {
 			opal = of_find_node_by_path("/ibm,opal");
-			if (opal)
-				pr_devel("hvc_opal: "
-					 "Found consoles in old location\n");
+			if (!opal)
+				return;
+			pr_devel("Found consoles in old location\n");
 		}
-		if (!opal)
-			return;
 		for_each_child_of_node(opal, np) {
 			if (of_node_name_eq(np, "serial")) {
 				stdout_node = np;
@@ -359,9 +361,9 @@ void __init hvc_opal_init_early(void)
 			}
 		}
 		of_node_put(opal);
+		if (!stdout_node)
+			return;
 	}
-	if (!stdout_node)
-		return;
 	termno = of_get_property(stdout_node, "reg", NULL);
 	index = termno ? be32_to_cpup(termno) : 0;
 	if (index >= MAX_NR_HVC_CONSOLES)
@@ -372,9 +374,8 @@ void __init hvc_opal_init_early(void)
 	if (of_device_is_compatible(stdout_node, "ibm,opal-console-raw")) {
 		hvc_opal_boot_priv.proto = HV_PROTOCOL_RAW;
 		ops = &hvc_opal_raw_ops;
-		pr_devel("hvc_opal: Found RAW console\n");
-	}
-	else if (of_device_is_compatible(stdout_node,"ibm,opal-console-hvsi")) {
+		pr_devel("Found RAW console\n");
+	} else if (of_device_is_compatible(stdout_node, "ibm,opal-console-hvsi")) {
 		hvc_opal_boot_priv.proto = HV_PROTOCOL_HVSI;
 		ops = &hvc_opal_hvsi_ops;
 		hvsilib_init(&hvc_opal_boot_priv.hvsi,
@@ -382,9 +383,10 @@ void __init hvc_opal_init_early(void)
 			     index, 1);
 		/* HVSI, perform the handshake now */
 		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
-		pr_devel("hvc_opal: Found HVSI console\n");
-	} else
+		pr_devel("Found HVSI console\n");
+	} else {
 		goto out;
+	}
 	hvc_opal_boot_termno = index;
 	udbg_init_opal_common();
 	add_preferred_console("hvc", index, NULL);
@@ -397,6 +399,7 @@ void __init hvc_opal_init_early(void)
 void __init udbg_init_debug_opal_raw(void)
 {
 	u32 index = CONFIG_PPC_EARLY_DEBUG_OPAL_VTERMNO;
+
 	hvc_opal_privs[index] = &hvc_opal_boot_priv;
 	hvc_opal_boot_priv.proto = HV_PROTOCOL_RAW;
 	hvc_opal_boot_termno = index;
@@ -408,6 +411,7 @@ void __init udbg_init_debug_opal_raw(void)
 void __init udbg_init_debug_opal_hvsi(void)
 {
 	u32 index = CONFIG_PPC_EARLY_DEBUG_OPAL_VTERMNO;
+
 	hvc_opal_privs[index] = &hvc_opal_boot_priv;
 	hvc_opal_boot_termno = index;
 	udbg_init_opal_common();

