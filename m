Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FEC48DFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiAMVbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiAMVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:31:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717F9C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:31:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s22so9630024oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYRnV1Ist1vARSPSnF2rw/yrtuWCrI0ayDUHb4fDzqo=;
        b=SMckg/nzX83RUT38HDVqXqL/+USSoRNwE2qeb9u2fYcDf+eHn88PcolAkaromVaRG0
         X9VARu1HxmUUQ+XnYnc8deAHrPHJMxBP/1z8wreMqEXwVx/hvMJmU06GCgHeA/6VOm2Y
         dat7Xi9MT9cyH7FmNRqX48xelGVsT2QmygWkut/XwSUtbg3La7lqRzsF+VomJc0W+1ja
         CsLbpSGOM33Rx28bmwbanQ7ojQNPBvOh4uIVreW2qM+AdaszzP/K5bFlUU6f8JEjuI6c
         XMeDY4gmsPzxHxeKqh3QO/CCvk8naON6KAe+OyK3/iV/j4dl+Pd8xNw2MeZyWFUfGxOT
         f4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYRnV1Ist1vARSPSnF2rw/yrtuWCrI0ayDUHb4fDzqo=;
        b=U6qp8tD26x5mB4qFWCQ06ofDiHPbfIalbtDqq+uryyBlP39sPcR3R/0K+/f7Z4k3TB
         wMhj37Q0XO2HMkBU/J9NLqsrdiXWGdXQpb4xaN9pbo+UwYVUZjPoc8ynWUnED+qYul6i
         D/FWxbcPHGFbLDlL2Ji9dOH87bKgCjKdRWuR0vE44ABehNBnzIuf3B+qvY9cytJ8s8wj
         EF/D//gYQ4koyIQMmfTt098Hj3yhI1k//Vm+mwoNlMMYSkp2rIp5Ll9nFsHkU3EPi96W
         t1WPVr9kJEgQsA4611NJe7SrIi/0SCTpLea841DcYv8I25gBL/LdlkRP2joe+CsIDbkZ
         0JTw==
X-Gm-Message-State: AOAM532b2/KRlP768BrJ22rbQlY+lWvnhHsg/JfduD1X3wEkkPCxeqpk
        YOK07XFGuwzZuqtj6MY0aaUR8penbN/J42SkiX17AKX1mdmVh03Jt2Pb+Wd96377rkJ2P/GRwRu
        WhZiFQpz3TrpoJIIX7/VkW3jk3DdUXpOmfIn91qEDjAzasCO6uNcEhrHwSx/L9dxsT1H1HkxWq6
        SeV/ORVsSZeI1902zwSNg=
X-Google-Smtp-Source: ABdhPJwEYr2CLO1fRtR6rM6IJUk2OdrzSIfOZW8PCuyuo97iz5DyT8grICu19f+pXA46UCcnMK86AQ==
X-Received: by 2002:a05:6808:2382:: with SMTP id bp2mr5091455oib.164.1642109469690;
        Thu, 13 Jan 2022 13:31:09 -0800 (PST)
Received: from localhost (115-127-16-190.fibertel.com.ar. [190.16.127.115])
        by smtp.gmail.com with ESMTPSA id i7sm908931oot.17.2022.01.13.13.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 13:31:09 -0800 (PST)
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
Subject: [PATCH v5 4/5] x86/efi: Tag e820_entries as crypto capable from EFI memmap
Date:   Thu, 13 Jan 2022 18:30:26 -0300
Message-Id: <20220113213027.457282-5-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
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

