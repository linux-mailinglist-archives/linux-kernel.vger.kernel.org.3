Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391D51D064
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389039AbiEFE5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiEFE5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:57:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BF359B86;
        Thu,  5 May 2022 21:53:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso9859528pjb.1;
        Thu, 05 May 2022 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=41Uma7d/lsP3xWQWON3zs2lM1iFrEwZBoddB2x0AtvY=;
        b=BzVTl2LuhCPXAqqoulaqr9MzM70I/beRIqODBjPIFD/qx3Qb7jCfDg5/E3NEr/8ZQi
         /RBEAx3lwKDca3OJZvqhc7AEyvFHg0pjbCGeyu+fE9pf6w5vIdKntZaIZ7DX+WV+Dptr
         HpIi4jtkMOclerDN2pGbe/ih5+SWdIwQRqfVGt1Ym0bxJhS/3GnBEzgDpoRmZ0FVPvzP
         G6Ovf1dMWM2BVBtc962h/p9b64Ag1FTwv9e935kU3pfi5+KlSnLOoXATuA7wWNtTPAdk
         0WpYnYvMJ0iYpdTDQdgL8FsECqlx+3f2jpLTyfdKxxP3jx6IvoCbQTzkRwJv3SVvZed+
         JOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=41Uma7d/lsP3xWQWON3zs2lM1iFrEwZBoddB2x0AtvY=;
        b=sn/GnpBhVptZhrvVGIWJPeFkDNgQaWt1yBfydOn7T6ytOYHWez4TjMXhmilte/OOzz
         R1ItPDsFhxg6H+bTT4YF9CjdYHHMYOm+DgaXJuniyvcKTAy8Uy9RBKsJpdhW6iIXOH4B
         0WKl66QKZ/SPCxly7JQBEcEFU/7U5UwFdT2v/aVGpol4q57rePMeu/LYpHQUK/Moqf/F
         xYF+zFqgM7Af7X1uyMprO4oKIQjur9quEJIFtaYPH6PgDj0Bkya8usclaUb1FlLPlPOX
         mpb8TAjpj9hD0NBzZy70w0s1W+9465qmjrb8cZ4obyFHjncr3hgbU7bmIpypKMbRx/XV
         UbpA==
X-Gm-Message-State: AOAM533I8QPnNqw9EmN44Ldj+8Tl1bX6YGl7bELQVPla7OnBBV19+2JL
        OT7eRB7RHtt1kJqNIuVVTt2agiIxluQ6Nskw
X-Google-Smtp-Source: ABdhPJxfTgk4uyAUPrKDtPW31a21tb7MCHQtb7y3sM4z36e/Qe1Mwsx+aKcd/H+fJlk8KDu+N+5ltw==
X-Received: by 2002:a17:90b:4ac1:b0:1dc:20c4:6363 with SMTP id mh1-20020a17090b4ac100b001dc20c46363mr10218435pjb.79.1651812802680;
        Thu, 05 May 2022 21:53:22 -0700 (PDT)
Received: from localhost ([118.33.58.98])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902b08100b0015e8d4eb1e1sm562212plr.43.2022.05.05.21.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:53:22 -0700 (PDT)
Date:   Fri, 6 May 2022 13:53:19 +0900
From:   Paran Lee <p4ranlee@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: [PATCH] slub: kunit catch kmem_cache_alloc failed
Message-ID: <20220506045319.GA28237@DESKTOP-NK4TH6S.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catch kmem_cache_alloc failed on slub kunit test.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 lib/slub_kunit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 8662dc6cb509..7b80241dd498 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -32,6 +32,11 @@ static void test_next_pointer(struct kunit *test)
 	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
 				SLAB_POISON, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(s);
+		return;
+	}
 	unsigned long tmp;
 	unsigned long *ptr_addr;
 
@@ -77,6 +82,11 @@ static void test_first_word(struct kunit *test)
 	struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
 				SLAB_POISON, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(s);
+		return;
+	}
 
 	kmem_cache_free(s, p);
 	*p = 0x78;
@@ -92,6 +102,11 @@ static void test_clobber_50th_byte(struct kunit *test)
 	struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
 				SLAB_POISON, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(s);
+		return;
+	}
 
 	kmem_cache_free(s, p);
 	p[50] = 0x9a;
@@ -108,6 +123,11 @@ static void test_clobber_redzone_free(struct kunit *test)
 	struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
 				SLAB_RED_ZONE, NULL);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(s);
+		return;
+	}
 
 	kasan_disable_current();
 	kmem_cache_free(s, p);
-- 
2.25.1

