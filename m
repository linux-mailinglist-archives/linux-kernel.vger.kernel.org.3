Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F24584962
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiG2BlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiG2Bkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307091EC58
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659058851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHCAtjKZb2F/RWm6an0jiLe9Ivmk/LTJJW/gUBH3IyE=;
        b=UMtlD86tCEgq4P5alY/2+yqc4dUS0/WHWGAy0si/33cKjFYIA6aiRjwijjt9O1aPx4PHIM
        RiafF0BqwnaucU88bHOvKZh96pse6zh/glNZyLZjYwdPvC7PUdPUOqiwsuI8P6fAFPBxkd
        WQ4M0+HLqD+F1goX/NP8WoKKhGgGhnA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-2up3VAdDNV6kIKSK3g5i8A-1; Thu, 28 Jul 2022 21:40:50 -0400
X-MC-Unique: 2up3VAdDNV6kIKSK3g5i8A-1
Received: by mail-qt1-f197.google.com with SMTP id ay25-20020a05622a229900b0031ef5fdf8f8so2064316qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHCAtjKZb2F/RWm6an0jiLe9Ivmk/LTJJW/gUBH3IyE=;
        b=gNLMprhRm0psrNX8cdUYPh1DK26BBg2sySTsXW5cVHy4MDMz54z48kUYzHnmawtlJv
         TWGPIaiJnHvO9GNx8Di7E23ZQZ7MaUBGqSubUnSMSw3RWsLNyA56oMBqoHjn1E0rhkAB
         xqQf6Z/NeYr/7fAo8gMatlEXxs8C2Nk6Rj/3CAKWcwPgbzS7eJVoplYaxODmL2bpA1Nn
         8y2GK+fujTmJmdBuW3n87QSrNiUZyB8GKNUtp051Oq3t4nLsLwBtaNzEiiT2Wb4gRlZb
         L1PRfUP+SSa5w1INvJnMXqoFLNfy89rzHvqJQfsY4DPkD0mYcbNdMYJOAgRm8uIuTPfv
         Qi6Q==
X-Gm-Message-State: AJIora+zWRSKDjD2kgM8z9bB0SRo3UWJsfJyWWpAgovyFES+Gmp0A7nS
        IGt7QgcrCOItojTVjrRi4+EbspR541EhCyQR/BPYGAKSjKEoO4H8Pih5NaYRypCNz4g6cDmkQyv
        8UnKn6G18KlTqeC7g484pkflL
X-Received: by 2002:a05:620a:440e:b0:6b2:82cf:d7f9 with SMTP id v14-20020a05620a440e00b006b282cfd7f9mr1167965qkp.761.1659058849549;
        Thu, 28 Jul 2022 18:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfN//pDoVVznadr+/YqP0HOgEHhd9oPJGkyGyuWdvXw2h2kgiA9ytnZN60UnD+9V24+DCcyQ==
X-Received: by 2002:a05:620a:440e:b0:6b2:82cf:d7f9 with SMTP id v14-20020a05620a440e00b006b282cfd7f9mr1167951qkp.761.1659058849320;
        Thu, 28 Jul 2022 18:40:49 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a454900b006b259b5dd12sm1584531qkp.53.2022.07.28.18.40.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 18:40:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 4/4] mm/x86: Define __ARCH_SWP_OFFSET_BITS
Date:   Thu, 28 Jul 2022 21:40:41 -0400
Message-Id: <20220729014041.21292-5-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com>
References: <20220729014041.21292-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will enable the new migration young bit for all x86 systems for both
32 bits and 64 bits systems (including PAE).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable-2level.h | 6 ++++++
 arch/x86/include/asm/pgtable-3level.h | 7 +++++++
 arch/x86/include/asm/pgtable_64.h     | 5 +++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 60d0f9015317..6e70833feb69 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -95,6 +95,12 @@ static inline unsigned long pte_bitop(unsigned long value, unsigned int rightshi
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 
+/*
+ * This defines how many bits we have in the arch specific swp offset.
+ * For 32 bits vanilla systems the pte and swap entry has the same size.
+ */
+#define __ARCH_SWP_OFFSET_BITS	(sizeof(swp_entry_t) - SWP_TYPE_BITS)
+
 /* No inverted PFNs on 2 level page tables */
 
 static inline u64 protnone_mask(u64 val)
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 28421a887209..8dbf29b51f8b 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -287,6 +287,13 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 #define __pte_to_swp_entry(pte)	(__swp_entry(__pteval_swp_type(pte), \
 					     __pteval_swp_offset(pte)))
 
+/*
+ * This defines how many bits we have in the arch specific swp offset.
+ * Here since we're putting the 32 bits swap entry into 64 bits pte, the
+ * limitation is the 32 bits swap entry minus the swap type field.
+ */
+#define __ARCH_SWP_OFFSET_BITS	(sizeof(swp_entry_t) - SWP_TYPE_BITS)
+
 #include <asm/pgtable-invert.h>
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index e479491da8d5..1714f0ded1db 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -217,6 +217,11 @@ static inline void native_pgd_clear(pgd_t *pgd)
 
 /* We always extract/encode the offset by shifting it all the way up, and then down again */
 #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT+SWP_TYPE_BITS)
+/*
+ * This defines how many bits we have in the arch specific swp offset.  64
+ * bits systems have both swp_entry_t and pte in 64 bits.
+ */
+#define __ARCH_SWP_OFFSET_BITS	(BITS_PER_LONG - SWP_OFFSET_SHIFT)
 
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
 
-- 
2.32.0

