Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3D58E24D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiHIWBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHIWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C48DE06
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViWF5oZvZDnfPWYKxgTTuTS7ZUI2Vs+P8BNbSIRNDkc=;
        b=Wtx9ntMVoao6aSfVQwtkLU6f3kgNof32gE01lYNzjtbXaad5b65BSH0SQc9lObdlVr9ErG
        QyNdDX0H6a9FJwg3A25sIXJH1/HjzyeYhN7t6Q1bsWrqcFWYcYjsw8aOE1h/dmTEpRS95l
        w3R0PyIGHncqnJrsT3iqo1hi4geM6Bk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-B9-a_gNlORGc0xyM_TTrtQ-1; Tue, 09 Aug 2022 18:01:05 -0400
X-MC-Unique: B9-a_gNlORGc0xyM_TTrtQ-1
Received: by mail-qv1-f70.google.com with SMTP id cz12-20020a056214088c00b004763e7e7d81so7006852qvb.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ViWF5oZvZDnfPWYKxgTTuTS7ZUI2Vs+P8BNbSIRNDkc=;
        b=uezud8FCXyFM9JD+W7M/1Snj//sv2xM4+FEVUZEVk5qfRUJu7VKmsGxAbHCmCemHRP
         sH/GHYItVz7kPBIRd+3Yt8uQ55oquUq/P1TYkhk8Rlw3udiA+ByNGaYIvCodcebxTyeo
         ZpvXtZafJFzHCrA7nUntKLVnJ/cbZ7d5SS5qUrlvYweQlekM2DJDgquJTtwifSLTjAMw
         MZW66vlLZmDfjOTU7LuEbVp9+CXMZeuKIRrf7LHqZ3h82r3kw/mcCAyVwu68iJadzjOm
         6UJ6DM4u+nyja2xc8F66YgMwjZdY0GNf4CORfS/9DPuxcqpnyvs16wzH9oiSv5ImYk+n
         j01g==
X-Gm-Message-State: ACgBeo1DEcAJqNk5OqY9eqLEmv/vY323C1zLTW4WJX4rpETs/eqtIGES
        um80k0K9wi93ltx6QWTJYQPIQrBROQgpi0YAH9hMLM6jEDgH3G9dMKDrBNJ38nVCDX5uGlbEork
        vKWUh/SiWGpihy+txQcywYjbw
X-Received: by 2002:a05:620a:2552:b0:6b4:8dbf:8992 with SMTP id s18-20020a05620a255200b006b48dbf8992mr18881455qko.109.1660082464662;
        Tue, 09 Aug 2022 15:01:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6dluwUjmka3W+U32hW/DI5Wis2lr4liBhxv8a6zycyIUy5OEofCGKK4slj2jFFitTD8LOwnA==
X-Received: by 2002:a05:620a:2552:b0:6b4:8dbf:8992 with SMTP id s18-20020a05620a255200b006b48dbf8992mr18881433qko.109.1660082464471;
        Tue, 09 Aug 2022 15:01:04 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b16-20020a05622a021000b0031eddc83560sm10563383qtx.90.2022.08.09.15.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Aug 2022 15:01:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 1/7] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
Date:   Tue,  9 Aug 2022 18:00:54 -0400
Message-Id: <20220809220100.20033-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220809220100.20033-1-peterx@redhat.com>
References: <20220809220100.20033-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all the magic "5" with the macro.

Reviewed-by: David Hildenbrand <david@redhat.com>
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

