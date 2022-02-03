Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741944A88DF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352391AbiBCQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352381AbiBCQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:44:21 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E175C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:44:21 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id j185so2091414vkc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=IAiLk5cjQwcE3yLS3aO2GBCqcyaetSmqrMvYHWmRcTBrX/70H06j9PR2aE3QGP81gN
         G6QDkvipCsGgjSUtRGArhWJu9iDWKOYWnm+NZ0aqk4cri2wqtuUQX+b9q3EK3qLf7feX
         OImmnQkBiMNjk2/7Ue9/B8Qdinvi+e/rlfFOS1vMUliTuXgm65EiqOAZE9CaQY4tGH/U
         /17cWo3icgYBFxnClGbVhoptcy+1QRAjpqIMCkUQhjxF94o8InjEYUfRnEDRxY6mI8V3
         60dkSPCH/hnp20RoME00w3RlqarwXBsRUPrQ7hYsR3fup3yBWAysWmRuspyPg2EBrkB9
         r+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=YS+cW0eBxZ5N+ZlC6ceMgAh9qyTsVrDBJTJiDCvvtV4fwnpXfMYzJz2cbLkvsEq+sA
         TdpfatTJXBLQP4W9sn2rRPZxy3/jIIBu6S84leW+U534+bf2qIuwQ8bm4nXUG1x0yU6m
         wc1cVQNCkbk1p3Ie7E+BLPhYx/QuZKbPogyPL+tUHkiSZBUNV2FNIEcuvoCcxt/Fj3wn
         jZVSbAyMWiYXZRMEg8DEe6baS3MqpgOFlVss2NyuojDFgajin74H0Kr4aLM6bRuohfcg
         HUL0tQVAiMKDAMxxJojBqNA5KQCzJ3G+w9Q2HGAHPrSZQtHCcn8L8Rb6IqNQ0DSLnJdF
         ChLA==
X-Gm-Message-State: AOAM531Fyrc4YMSYtZT/cPPbpUN7lPEzcZATy2SSugLMiRXZ32+Wdq6M
        e8ZvplfirMyiWqzy1zObq9XVI2OFLEDxOp6IgbQ9esIbbLs/DPPGexF60zE7Ziz8CW9iRz70aet
        eiQt3azTPrndjn+WmHo8PUHoGp0rLpNemgdUjkjPTJ0E2ZAsRKrqVSc/4mmUL1hcDxF4lBHE3Vv
        +UPKrssL+EV643HETY
X-Google-Smtp-Source: ABdhPJzsOFFOqxgDzTCzuaTzUcSCoJoy32VcScNJTJMZP7zNyU9OfyuKOow2hpJD7GfcAiCruPNRVA==
X-Received: by 2002:a05:6122:c90:: with SMTP id ba16mr15282992vkb.39.1643906660499;
        Thu, 03 Feb 2022 08:44:20 -0800 (PST)
Received: from localhost (host8.190-224-49.telecom.net.ar. [190.224.49.8])
        by smtp.gmail.com with ESMTPSA id s11sm6623102vke.47.2022.02.03.08.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:44:20 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v6 5/6] x86/efi: Tag e820_entries as crypto capable from EFI memmap
Date:   Thu,  3 Feb 2022 13:43:27 -0300
Message-Id: <20220203164328.203629-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to iterate over the EFI Memory Map and mark the regions
tagged with EFI_MEMORY_CPU_CRYPTO in the e820_table; and call it from
efi_init if add_efi_memmap is disabled.

Also modify do_add_efi_memmap to mark the regions there.

If add_efi_memmap is false, also check that the e820_table has enough
size to (possibly) store also the EFI memmap.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/platform/efi/efi.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..3efa1c620c75 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -184,6 +184,8 @@ static void __init do_add_efi_memmap(void)
 		}
 
 		e820__range_add(start, size, e820_type);
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(start, size);
 	}
 	e820__update_table(e820_table);
 }
@@ -441,6 +443,34 @@ static int __init efi_config_init(const efi_config_table_type_t *arch_tables)
 	return ret;
 }
 
+static void __init efi_mark_e820_regions_as_crypto_capable(void)
+{
+	efi_memory_desc_t *md;
+
+	/*
+	 * Calling e820__range_set_crypto_capable several times
+	 * creates a bunch of entries in the E820 table. They probably
+	 * will get merged when calling update_table but we need the
+	 * space there anyway
+	 */
+	if (efi.memmap.nr_map + e820_table->nr_entries >= E820_MAX_ENTRIES) {
+		pr_err_once("E820 table is not large enough to fit EFI memmap; not marking entries as crypto capable\n");
+		return;
+	}
+
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(md->phys_addr,
+						       md->num_pages << EFI_PAGE_SHIFT);
+	}
+
+	/*
+	 * We added and modified regions so it's good to update the
+	 * table to merge/sort
+	 */
+	e820__update_table(e820_table);
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
@@ -494,6 +524,13 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	/*
+	 * If add_efi_memmap then there is no need to mark the regions
+	 * again
+	 */
+	if (!add_efi_memmap)
+		efi_mark_e820_regions_as_crypto_capable();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.30.2

