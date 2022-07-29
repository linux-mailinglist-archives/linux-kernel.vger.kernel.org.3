Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB29584963
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiG2BlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiG2Bkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 989611B7BA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659058849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNwWCoZOuwPxSYyDQ6YzxKBvZEYHs5K0G6f2+t5kiFc=;
        b=Hei0UT4Xd2mE/KvgiXPoUYwRf8LcHMnsIAYyKx3VYOUDowJ4sIG4/NCdm4sHIbbDP68BPh
        simTkoYPrE9PrlvnvIpuaj3IWCqck0EGcKDSKxBxHO06O7DFqmTh3GINtDFFVX6HX2FcYL
        tlWqYIaDMgP1r/wcHzWy4yQeFZkfcFQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-n5qBaePBMnONndw_VG8pPA-1; Thu, 28 Jul 2022 21:40:48 -0400
X-MC-Unique: n5qBaePBMnONndw_VG8pPA-1
Received: by mail-qk1-f199.google.com with SMTP id bj26-20020a05620a191a00b006b5c4e2dc77so2622011qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNwWCoZOuwPxSYyDQ6YzxKBvZEYHs5K0G6f2+t5kiFc=;
        b=Euq+szraIul2ixTE5lXtzEtGxYe2VGYjtYT19bzQzAp5Imo3izoSapG/8AqQyofUND
         oHWPzi23G0VKENuQkvHaAu+Ihwng4ZHAtgUWwf4Zf+hxkCXEEW3N6nnmCPE/F+ytHw+b
         VJnc573aqsMkCYF2B5zdMSl6WjJxrrPJSigsRtPfLCTa2J2U7+uPQ/6Fvn365KSe35HD
         HIiCobvVoaJBbicahM8SkJXO0Pj4e6vay0XHnrvKiE0s6MZyGzp6c1IKTOZuB7LKisj5
         UoYJ2RifaNOrD97/Yt9YqBAEuOxg3zVp/mOjm5+YSqrcHd0LWGR0rj83eNQiK7SDqmBc
         yGQQ==
X-Gm-Message-State: AJIora/whCMiLqW6rtlxK41ykBs3GQ68Oqd5GVb44xAMx5VmLC2jv9jC
        8dnc/sAgb+t+TBVY2ulYdQ1rpQFXxTyP/szmgaOgThMS8j+g96Cb2hlk9OYvYIoI9BnTNIrLn6M
        Ad5XlxXmhO5POMEIl3lOK5pZ9
X-Received: by 2002:a05:620a:19a7:b0:6b6:b88:3c77 with SMTP id bm39-20020a05620a19a700b006b60b883c77mr1212517qkb.128.1659058848047;
        Thu, 28 Jul 2022 18:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZayzexwXnoLh2k6d3k24YaRhYz1essZsiXQQVUsnUpgPU7CF4SN2TaMXPZPqXjes7ezd3dQ==
X-Received: by 2002:a05:620a:19a7:b0:6b6:b88:3c77 with SMTP id bm39-20020a05620a19a700b006b60b883c77mr1212495qkb.128.1659058847825;
        Thu, 28 Jul 2022 18:40:47 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a454900b006b259b5dd12sm1584531qkp.53.2022.07.28.18.40.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 18:40:47 -0700 (PDT)
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
Subject: [PATCH RFC 3/4] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
Date:   Thu, 28 Jul 2022 21:40:40 -0400
Message-Id: <20220729014041.21292-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220729014041.21292-1-peterx@redhat.com>
References: <20220729014041.21292-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all the magic "5" with the macro.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable-3level.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index e896ebef8c24..28421a887209 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -256,10 +256,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 /* We always extract/encode the offset by shifting it all the way up, and then down again */
 #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
 
-#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
-#define __swp_type(x)			(((x).val) & 0x1f)
-#define __swp_offset(x)			((x).val >> 5)
-#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
+#define __swp_type(x)			(((x).val) & ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_offset(x)			((x).val >> SWP_TYPE_BITS)
+#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << SWP_TYPE_BITS})
 
 /*
  * Normally, __swp_entry() converts from arch-independent swp_entry_t to
-- 
2.32.0

