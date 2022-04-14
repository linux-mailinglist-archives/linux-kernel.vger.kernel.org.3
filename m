Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F2500924
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiDNJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiDNJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AD924F00
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so5055540pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ymqE8aSZCiNLvHohw2uieveIBfmHm8/fdfrtfycEzo=;
        b=BNp7lubm9luWUadkoruGrkWyZeX14FCIDVbhrURd/EYMzs8Uf9+XvrpzFO+zj+lSi0
         3gp2UIVZcmFXPrWdKlwIaQkB5vLE6ekBrPk/5Iqyf877O/Bg0CYPAiNskXSoKK+k34je
         YaL9R/FGVqKMw2gdzmEI5Nrp6xXP7b2Gmegco9aG6a4hTMccW0/6xD8WA22KHoLcpeIf
         AWgKjiSwmbZXXoo/wP33cOi8k7q2vChCIYCPcmkl7eunwbeeNMVVzb8wywQ0xd0sb3Ng
         5MX5vuwtYpxE9oINP/ziInmjJyC0j+Mg/UUAmavLToQ6WKEVprrWQDux/KIw6PLWZWyd
         70PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ymqE8aSZCiNLvHohw2uieveIBfmHm8/fdfrtfycEzo=;
        b=fCFFAGPVJFTJPWRW8tXEOnKvQCFOkIzHYDn44bE7u8MdNG95JUpDrTKg8wEi74sTYM
         aatYlVihlOrSfMwXES/HS2b2dk8d3MPFyR2aeYfwiLv9e7cGxNqz6La6x/qzjdRkB+Td
         l8W8ZhM8rsZ4TwRl2HAnuVUFPMDea3MBk9YPe3G+zh3ueRJvRkz4UXCPC+2Urr/a8W3B
         2rYXxMZnPT8W4yyU7pRgPEZKr1KB38X88hbCafi/wq6Q6h0NmP5LS4FM8rxP2bVDGP1w
         3XBuH2GpXOBiolsFNKxtL13ivhv2I37MxR3hZ0Ru5s285WoCMfIL4KET2CXTPlEUUv2L
         twUQ==
X-Gm-Message-State: AOAM530J+bWp/+fVe0SKOs2vK5/pgxnOeU/d3qGtEbg3a83pIgM1e7RN
        5kqJV2ZC8GbgMkBtbp/Pycs=
X-Google-Smtp-Source: ABdhPJzxK3hu1hp4jfT79xykHhdty1oOVUP8hCbv9UW6qC8LenmkzadyvtoVNShK+XHTT4d4iMJpsg==
X-Received: by 2002:a17:903:1c7:b0:158:5ada:8876 with SMTP id e7-20020a17090301c700b001585ada8876mr20359165plh.122.1649926777087;
        Thu, 14 Apr 2022 01:59:37 -0700 (PDT)
Received: from hyeyoo.. ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id p9-20020aa79e89000000b00505fada20dfsm1403537pfq.117.2022.04.14.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:59:35 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/23] mm/slab_common: add kasan_kmalloc() in __kmalloc_node_track_caller()
Date:   Thu, 14 Apr 2022 17:57:23 +0900
Message-Id: <20220414085727.643099-20-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kasan_kmalloc() in __kmalloc_node_track_caller().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a3eb66e5180c..6abe7f61c197 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -954,6 +954,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 		return s;
 
 	ret = __kmem_cache_alloc_node(s, NULL, gfpflags, node, caller);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 
 	return ret;
 }
-- 
2.32.0

