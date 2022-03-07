Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0B4CF02B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiCGD0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiCGD0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:26:51 -0500
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Mar 2022 19:25:58 PST
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F95D5F3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:25:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 85BCB2B0024D;
        Sun,  6 Mar 2022 22:17:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 06 Mar 2022 22:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=LC0j3/G2hKvPK3P9v7Jsob3YP1xJDOoZkhPu00702s4=; b=QPTYc
        E4lBWiR740zuP/i60F10qhDc1am8plxYD/7WQYz4BBt6pBGPt/etw7bjGqy4lmOG
        EDfAmZ9dIPUNTuklrE/XHnt6Ag1xaIXQ+geGFsvWjgSjM/XOrYe5ehzGWKdE4Twt
        cTsJ5lM3fQX5BBD/vq+nfW3pLMBNt3VCWwept2TbZnHqO9zKE2bkh6AsFD6+Of88
        88WP6T4cdByGqBu/YvQ1MDrFeK3RohU5mXdhtB8r7IRu9bU1bcpnjq9/WNw1rYjG
        qdzFAeA88S1ITo3R8Kx/qzz8C8PNcuvofgo9B1WjI9noZiAoofr39xWB4rlvmBE1
        zR6tgi7ihpOJs8+aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=LC0j3/G2hKvPK3P9v7Jsob3YP1xJD
        OoZkhPu00702s4=; b=Yay/FmVJlDDIGi6wv7Px8BgByxqqqwxrkj621ZIewzHx0
        IkrM4mw57T/tB3idZ0M2hddtZnrZW8fAnnNN36GQ5gAeXoMydQ/VZLevMCeRXSe6
        H2HgdPgFIR9ZxDsTmWCIA/WIyYujZ+G3s+uVidum00Sb4rEz0VWtIiwXcQSsz9O9
        2B9vp3eCFYn4rZyIc079GTfMfhdG6bC4AfcrGQ8mNff/LtJC4utBWqraSE8Dnv+C
        VA1gEMQYnb//k1TCDYqbDMhHFRgRu4DYBhQiZeKxo8wnphnvf51HiPsPax294CJy
        GIR+G4R8wbDC+8K8apQ/s3fmQl4S3Izk7WsBzTjZQ==
X-ME-Sender: <xms:PHklYjmfgLPrTInusPVVgSfgrAeLbJbFfV40JHVmHNwNBM1S3vIdhQ>
    <xme:PHklYm0dU3vtRde3yjyuxBNRyfkM2NGiPQCv9-QM6q8MDH5-HobavezShP_vJzj_q
    D3Z82HCn0GOWsCpefU>
X-ME-Received: <xmr:PHklYprNr8x0hqaqkaLWcNboLh-KGSpzRyvV9RoJs7KzY4KOLEPGmEUwD4lJ4okyPavw_q4UxvViWWejGqFT-jzIzlikevuFDaNI-Zfd2bZHCU6TjLYzdmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddufedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcuvehi
    lhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnh
    epheduveehtdelfeekgfejudevhffghfehvdetffehgfelteelheelgefftdffudehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkse
    ihohhtshhusggrrdhnlh
X-ME-Proxy: <xmx:PHklYrlSbnQ0QCQUfLr4PM7wIgUeYbfnPMhmQ7C6YatxRiWdgVoQsw>
    <xmx:PHklYh0zG54sMTjDBj5i4K9evQStg5FtktS-hDoZHPG_MW_2Y-I7oA>
    <xmx:PHklYqttI4cFfwGHDxoRK-nYZF9L36XkyB3kkQLjLnr5xLAcO5g8jg>
    <xmx:PXklYitB7KbLgauQHVjOnBsmkd7TMGJ-ZLLgqkFc6eo1S5paXw2qZv_u7ys>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Mar 2022 22:17:14 -0500 (EST)
From:   Mark Cilissen <mark@yotsuba.nl>
To:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Cilissen <mark@yotsuba.nl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board
Date:   Mon,  7 Mar 2022 04:16:58 +0100
Message-Id: <20220307031658.81285-1-mark@yotsuba.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
but the XSDT points to a truncated FADT. This causes all sorts of trouble
and usually a complete failure to boot after the following error occurs:

  ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
  ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
  ACPI: Unable to start ACPI Interpreter

This leaves the ACPI implementation in such a broken state that subsequent
kernel subsystem initialisations go wrong, resulting in among others
mismapped PCI memory, SATA and USB enumeration failures, and freezes.

As this is an older embedded platform that will likely never see any BIOS
updates to address this issue and its default shipping OS only complies to
ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
top of Linux 5.10.102, was confirmed on real hardware to fix the issue.

Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v3:
- Change DMI matching criteria as per Hans's suggestion

v2:
- Reduce DMI match count to 4 to not overflow dmi_system_id structure
Reported-by: kernel test robot <lkp@intel.com>
- Change board ident to correct name
- Fix small style issue
- Fix up subject as per Rafael's changes
---
 arch/x86/kernel/acpi/boot.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 5b6d1a95776f..0d01e7f5078c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1328,6 +1328,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
+{
+	if (!acpi_force) {
+		pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
+		acpi_gbl_do_not_use_xsdt = TRUE;
+	} else {
+		pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
+	}
+	return 0;
+}
+
 static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
@@ -1451,6 +1462,19 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	/*
+	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
+	 */
+	{
+	 .callback = disable_acpi_xsdt,
+	 .ident = "Advantech DAC-BJ01",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
+		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
+		     },
+	 },
 	{}
 };
 

base-commit: 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
-- 
2.28.0

