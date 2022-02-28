Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D84C7C04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiB1V35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiB1V3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:50 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02112F409
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:29:09 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 6006 invoked from network); 28 Feb 2022 22:29:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083746; bh=R47dyKXhZrNyWcaemDPWHPDh8RGtge9AC+8p1bH68C8=;
          h=From:To:Cc:Subject;
          b=O81dfkknIQLl4uFEAPyeeveVT720KcbY/1fWYAPXRhlTS+jq/gq5uChYssCRdF7nD
           vOmmaDqXKCVd+Gb5iOytNEyJjSu8AKIizSlPq31XtYzi8Iyn7gkkZrjOqM1XYaLcLz
           5ArdYboVfbfVWbKCNAiD9BpWSEnFCjFiNooQWJ/E=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:29:05 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 07/10] x86/Kconfig: add help text to CONFIG_PCI_MMCONFIG
Date:   Mon, 28 Feb 2022 22:28:23 +0100
Message-Id: <20220228212826.27080-8-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c422f2b36ff4682aedc7c1c31297ae52
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gSM0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration option had no help text, so add it.

CONFIG_EXPERT is enabled on some distribution kernels, so people using a
distribution kernel's configuration as a starting point will see this
option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

---
I would like someone to confirm that PCI Express is required for
MMCONFIG support.
---
 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c55a837a00ab..27d21ef518b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2645,6 +2645,19 @@ config PCI_MMCONFIG
 	default y
 	depends on PCI && (ACPI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
+	help
+	  Add support for accessing the PCI configuration space as a memory
+	  mapped area. It is the recommended method if the system supports
+	  this (it must have PCI Express and ACPI for it to be available).
+
+	  In the unlikely case that enabling this configuration option causes
+	  problems, the mechanism can be switched off with the 'pci=nommconf'
+	  command line parameter.
+
+	  Say 'n' only if you are sure that your platform does not support this
+	  access method or you have problems caused by it.
+
+	  Say 'y' otherwise.
 
 config PCI_OLPC
 	def_bool y
-- 
2.25.1

