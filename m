Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7F477C76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbhLPTXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbhLPTXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:23:36 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B13C061401
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:23:36 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m25so228745qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYRnV1Ist1vARSPSnF2rw/yrtuWCrI0ayDUHb4fDzqo=;
        b=NqdUyJ0fkymx2bWJQqVppi5GHARZFYiofUfvh7C/vceya1eazbzPrH2fBj+hVh20/8
         7O+pBl4+8E3mEdBNVIwU1F8mFjKcQOLpF1ypjahvUReRTnriZphkIQFZ90UCOAl1t2qu
         E/LFk6NoEWloNdXo663jzI8YtCtuXLm32wrs5LvEcNC/5O58nftOwEaLnqjMjdlTEjfn
         d9b70QaFBMywS6+AEJ1zLavVJ38f/ZoiWEcMxU8+gNMece0UlRw42450a5panFd3Us98
         V3btDBbUvaN5vrBqeF3gi7f017VzHn8v22PNDZs8EIKLfukpTXS20jFimgOpA2YXFUcY
         pdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYRnV1Ist1vARSPSnF2rw/yrtuWCrI0ayDUHb4fDzqo=;
        b=pm0eX/vA+UGzC+3zqbRZ+zHnIcW3YBGcfpZ0JUTHRGiNl3XveoyClo9jkqwioctcNG
         WzuNMf79jS1OS6OKQC99sZa47HH2uFGQqrU0X4Rd/8OF9s9JgexWkPkzDoH8lXPsRY1a
         lf37MorcdadUSI9kYf9JOzXR/FGqlzJQVR6yKvCEYEG8hMnwO5sXs1wYCp3OIHcMs6IR
         O2STxlFSbYelXAxfe+ZyGsXlwZgqFG6QuLnMnn/fr2P0EXz7HlwgofrZMrirGdUHEhrM
         cJYQPytHBI4LdMkfd0PGZfh39UPCXQLLVWpx9xwQ9+BtHMR1p589RyKG9WDmwqkIX1bT
         0OBg==
X-Gm-Message-State: AOAM530dDaaXrSlpxH21soR0y9m4Kll8Ait/qQlCbNT6+vER5wNpxMkk
        CEni8N5USuFk6I7imlTrNv8Y+w8BTm5hszViX9SzWEVHW9KIgOswsYvvOFhdl4ChCPzvwr/KH5b
        el8AbnXrv+H/i8weBTr6zAC6Ag/rKVbzZ9JZkO/tfRaz9SZ4pFaWI2vZXEpuFfEUaUDqI7nIWDV
        33jWXChTY0FHyY9Aed
X-Google-Smtp-Source: ABdhPJzrATHu7/Qb3mo5AZkbwLUvNkMIaupJj2XmlMygFBz8HXJMDQ6R+KamB+AhkTshWyuZJkoqPQ==
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr18685008qtd.359.1639682615191;
        Thu, 16 Dec 2021 11:23:35 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id j9sm3351985qkp.111.2021.12.16.11.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:23:34 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v4 4/5] x86/efi: Tag e820_entries as crypto capable from EFI memmap
Date:   Thu, 16 Dec 2021 16:22:21 -0300
Message-Id: <20211216192222.127908-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
References: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to iterate over the EFI Memory Map and mark the regions
tagged with EFI_MEMORY_CPU_CRYPTO in the e820_table; and call it from
efi_init if add_efi_memmap is disabled.

Also modify do_add_efi_memmap to mark the regions there.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/platform/efi/efi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..ce2f9d38fe36 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -184,6 +184,8 @@ static void __init do_add_efi_memmap(void)
 		}
 
 		e820__range_add(start, size, e820_type);
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_mark_as_crypto_capable(start, size);
 	}
 	e820__update_table(e820_table);
 }
@@ -441,6 +443,23 @@ static int __init efi_config_init(const efi_config_table_type_t *arch_tables)
 	return ret;
 }
 
+static void __init efi_mark_e820_regions_as_crypto_capable(void)
+{
+	efi_memory_desc_t *md;
+
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_mark_as_crypto_capable(md->phys_addr,
+							   md->num_pages << EFI_PAGE_SHIFT);
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
@@ -494,6 +513,13 @@ void __init efi_init(void)
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

