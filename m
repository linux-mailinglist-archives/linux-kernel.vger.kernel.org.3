Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B25904EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiHKQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiHKQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D55BA5C4E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfi/Ecb+oYo1RXzYzaJhIF6aEHnKWbHUlt161URhhFA=;
        b=GhsOGOx+UWqgdk2hLvFdA/eje74sCFQsPeRXdDNjHvzK3Otd+Mrpav1B0lpKp30PgCg2wa
        btm7fZwBHcS040weXYswe/FFkU71n+WM5P4a7vtmKfZUZm+OaoHQgl3n8ew5BA36ineajT
        YGPkKdNXFqkbrkRMUQfoWriJsUbg+Qo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-0DYtKXsdMQ2QSdY2jwh4QA-1; Thu, 11 Aug 2022 12:13:36 -0400
X-MC-Unique: 0DYtKXsdMQ2QSdY2jwh4QA-1
Received: by mail-io1-f72.google.com with SMTP id f4-20020a5d8784000000b00684f917b026so5683668ion.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nfi/Ecb+oYo1RXzYzaJhIF6aEHnKWbHUlt161URhhFA=;
        b=0MsanOpOrzrOYhyUyYK0EWnUi65FCAhSN4IHpM0W+Ag+kg5gF6KKNlU0Fw9FAysWeG
         FzrYy3UpaUNRCSZ9UlBTfOq6/ekyPDkVSyS0byUdBAplyuQT/ZRu9/9YO3Vw+frRGFnJ
         c9BJQfaKHPvzIbMWGuMTA96747U72Q65Sq6/hSx/rW7nLIvu74EeVKWcnziAOoIDMp30
         fFiPONi9SrcVDm3nio62SvPTmUB3k4FgoyGs44z32AujcShneUimI3ysWsGJkrQrFiEo
         yv+ZE5Ji+zSAH4tysKCfCcXh3m96sHHgQS3LuGLUnORdhuT3Oxsp3NAP93uNfTzGAg4K
         40oA==
X-Gm-Message-State: ACgBeo3QcOMw6hcm3vrzhY0MmsNqJKVTqK4/0SEw7utD9lG5bfgySFTd
        i6vNVWiyx9jIu3ArzY5JxihXGbnNuoxV1H4jtH8NvigcoB5R+yxlSpbylczY152dlIFVMUXQqtJ
        zjHCMki0m90X4oj84cKRcU3XF
X-Received: by 2002:a05:6602:4019:b0:684:4cde:9e74 with SMTP id bk25-20020a056602401900b006844cde9e74mr16654iob.53.1660234415563;
        Thu, 11 Aug 2022 09:13:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6aerHoxC67XZ45dRi+nnFHBgH3aaV4pC70vmG8Qq33dGhvpVJki9kiKQSL4lwRWMdaL0bZUw==
X-Received: by 2002:a05:6602:4019:b0:684:4cde:9e74 with SMTP id bk25-20020a056602401900b006844cde9e74mr16649iob.53.1660234415385;
        Thu, 11 Aug 2022 09:13:35 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id t1-20020a92ca81000000b002dd1c3c5c46sm3415429ilo.73.2022.08.11.09.13.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 09:13:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 1/7] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
Date:   Thu, 11 Aug 2022 12:13:25 -0400
Message-Id: <20220811161331.37055-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220811161331.37055-1-peterx@redhat.com>
References: <20220811161331.37055-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all the magic "5" with the macro.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
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

