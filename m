Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFE4B5ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiBOAIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:08:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiBOAIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:08:41 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD497BAC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:08:29 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A4B572C0C53;
        Tue, 15 Feb 2022 00:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1644883703;
        bh=gPwrPAgNGK0ENjZaVwmkgXwqjgAIhSwb6KNoN1gsLaE=;
        h=From:To:Cc:Subject:Date:From;
        b=nHXkNQHU3yHsMfbmdO7V0bciwBRugsWCDiwoJlrIXNwSmKH9w49K5xfBXx2n2NrQF
         KqcW2yApjY67AAGQmH44LBBmhima1RSwWIHSZe9KfP/E1QPz7Zf0KbJ8Bw6JIbUoEa
         yphVDggtmjZLh2pEbqLW4HT5eUFmJuGaDXQSupSQnt3SjC8SRX+GzfKlXqLPggkt9N
         2WXdoomxUcRbbzrrejmGLkh3gMuH2vKMpVESZXFP2DHy9tAj4amR6Kx65jcJKFpDcT
         R/5O0zBWe1xsdGNbEEyVMlC1Ysx5ofUglUYRK6+qduI1q+iC9iajnTx04p2kgF8Vev
         BnkV3LPoWw3pw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B620aeef70000>; Tue, 15 Feb 2022 13:08:23 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 750BA13EE1E;
        Tue, 15 Feb 2022 13:08:23 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1B9132A00D0; Tue, 15 Feb 2022 13:08:19 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] usb: host: ehci-platform: Update brcm, xgs-iproc-ehci workaround
Date:   Tue, 15 Feb 2022 13:08:13 +1300
Message-Id: <20220215000813.1779032-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=c43Vvi1l c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oGFeUVbbRNcA:10 a=PL-y3ZX0Tm02xq-3140A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original workaround was added prior to commit e4788edc730a ("USB:
EHCI: Add alias for Broadcom INSNREG"). Now that brcm_insnreg exists in
struct ehci_regs we can use that instead of having a local definition.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/usb/host/ehci-platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index c3dc906274d9..1115431a255d 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -43,7 +43,6 @@
 #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)=
->priv)
=20
 #define BCM_USB_FIFO_THRESHOLD	0x00800040
-#define bcm_iproc_insnreg01	hostpc[0]
=20
 struct ehci_platform_priv {
 	struct clk *clks[EHCI_MAX_CLKS];
@@ -81,7 +80,7 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
=20
 	if (of_device_is_compatible(pdev->dev.of_node, "brcm,xgs-iproc-ehci"))
 		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
-			    &ehci->regs->bcm_iproc_insnreg01);
+			    &ehci->regs->brcm_insnreg[1]);
=20
 	return 0;
 }
--=20
2.35.1

