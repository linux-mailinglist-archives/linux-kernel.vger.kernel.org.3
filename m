Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956CB50E6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiDYRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiDYRTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:19:45 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904032AE1A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:16:31 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id f13-20020a4aa68d000000b0033a2c53d0baso2911880oom.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=hzdDmfKq8Bk9MII6db84BuRQTA/8rrlJsMn81H+8Z6fmZowtvXXor0jrWgoYGoELCw
         IsIzz074TMbE9AtUH2hfNN9cl4+cL2kALjO15QlLwx+J7IiSpWMDUQXN1ky+b6TyHLgV
         g8ZcTwU6ddQZlGfTw3ZExEZZIipHXbZS7hfXg/PZIIxAaplsyeLYNZu3Ph7olpJmw70s
         T5p5+74Sg002Z8SZlFK2U93bEY/7rC/66iOkS3hLBRCcIohkPQmE2rwS/StCBweQD5LG
         fGpr/YgqwEmPUoDwJp0CpaEWHLvQxyCttWiqadb6WN/2/2KYX9p/eIOXN7IoM+YLhNc3
         l0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VGMhr11GA+eGLRm5CsL28eo528BHkwYTiIF+ncvNsE=;
        b=oNTiJJSuZ+Fev7zatjvlw5uULZ/VO8hEyu9o2R6iqrkJgL3wL0jy3i2u55/1WWX96V
         Kiv6yGdFVtNJyagOjE+Qr5Y+jYiVeULbn66jdcWwLJu8LZa26rOXxSuT25nO2Efl0xng
         8EG5NCUwDik9SP/C1dRLCSMc8kjrVc8ZZsHIkSJ++RsHN5wnbumdbZKZb20Hxp2Hvykb
         DdCqTh/7SCIAB9GS9CoThDxy4il0YvMniCow8udx/CXzgTxRuaK5vKYKsQLpuxYNJy9j
         PAd7eYlUM/1eOYbZXPFLe0fiMWC7sWRV775pdZwwnR5m1J8nZ37GOYRDR0/BaNt7HQ3Z
         0U6g==
X-Gm-Message-State: AOAM531Y7dPMwMoOPKqm5b6e0yihEd4+zaKh7qJ9L8n5EeAz7QjRIHyy
        JB0QsZUCWIdjTpRsOoyNYejEM9uJ8aCO3dXaNdhLli6sGCtwHr/LAoCWTEHEbG/7IyQgcTvOvnJ
        vJJL4sl2Y84m1l/DztZ+U8pzZxTC0g0IqtjdwPJ0tJTxbUCuWTUYleUgE4Y+Dq0BVnwQlY13YUe
        bKZbk+qQUXAdr1HAUrjbc=
X-Google-Smtp-Source: ABdhPJw+qg0OrSQnHpLZqEEKRtsnl5QwBjo+IrjHQ4B0lUJPMGV26uBWO99+0KzzBzURpIrWg8ExmQ==
X-Received: by 2002:a4a:92d4:0:b0:33a:3d7d:fe5 with SMTP id j20-20020a4a92d4000000b0033a3d7d0fe5mr6747103ooh.83.1650906990628;
        Mon, 25 Apr 2022 10:16:30 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id w8-20020a056830410800b00605b48122eesm1191834ott.14.2022.04.25.10.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:16:30 -0700 (PDT)
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
Subject: [PATCH v7 7/8] x86/efi: Mark e820_entries as crypto capable from EFI memmap
Date:   Mon, 25 Apr 2022 14:15:25 -0300
Message-Id: <20220425171526.44925-8-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

