Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539264BDFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356002AbiBULSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:18:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345915AbiBULPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB0D57
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i10so12612857plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UEo/Stc+iYNXbwbi51AqwpgyfC/DeYqJj3Sep1UETg=;
        b=TQt9smYJlqZvzDOc9o4bZM6zroYbhcyVxV0DCbsexdb+fnHDrG3ZNC1Q19EAk0Ao63
         62jNfhPKSpSYPZTo+tuDPbrYVI4z300rrE2lkOz0yuGIFjjjg2R8aSc/LGuUyT6n3/wa
         tEWUlZkuCKsHGUD7VwVlHgOJDLPU97mLW2j0c0+kdZeCY5TJr7TPVUi0+R1hqlrfuTmd
         h/X2ZsALJKksPfhJw9pnNn3+Er5/IYKz2nhA93DkEGGq3O1L+pd5bROH6NkpKr2NIVif
         ch3qRTEBpyHSOR5lP5Kk1eLqF5vseOBeoEP2WSgyUfOIDrJDCoGFqzsdpLf2IkArULuB
         cEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UEo/Stc+iYNXbwbi51AqwpgyfC/DeYqJj3Sep1UETg=;
        b=KM4dxW/Hw3V/dQnx665FCV/+96jZqmooRnofV3YAPrqldvU6kMyL5s/CSqUcxfTN5C
         N7qdojZOvshU/W3YIVLVP5q2gLy3tMcoRFa5cE0w6tZBnBgek0+7vDL19ieHUHtF9/Ee
         /CMKGqPwXsjnpJagnU350EC0R1r7QxSTwsyY/ex8h82rcYssaKEeJFDuwsfuw33u1/KX
         lEaBzf4Yyu2YbgV1q5SEpVrtVlDUwsPb7GVn8HhVL723lD20gnzF95EF3CNNHum5tcLx
         TfUJJHQoZACMnPmqQ9VYlqllrKWb3RRw7GveH/QdzXqTJr4OT2PBIvRz9imN7vLKZfUK
         XD6g==
X-Gm-Message-State: AOAM532vW3Z3wdJt3rTI9qU7uf2HeW7yKsYZhUJYLUA6vHY3fN/LdSy7
        mwh5dhjCuEd5mtZniipLUMM=
X-Google-Smtp-Source: ABdhPJyoPW7XVnrEz+Uimph+0Op7tRbd6nES2sCgwyi1ygR/jFYNy8MlQDyqUcT1S8O4S6ye7lb0dQ==
X-Received: by 2002:a17:90b:2390:b0:1b9:c392:ab8d with SMTP id mr16-20020a17090b239000b001b9c392ab8dmr20876794pjb.30.1645440845915;
        Mon, 21 Feb 2022 02:54:05 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:54:05 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 4/5] mm/slub: Limit min_partial only in cache creation
Date:   Mon, 21 Feb 2022 10:53:35 +0000
Message-Id: <20220221105336.522086-5-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220221105336.522086-1-42.hyeyoo@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
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

SLUB sets number of minimum partial slabs for node (min_partial) using
set_min_partial(). SLUB holds at least min_partial slabs even if they're empty
to avoid excessive use of page allocator.

set_min_partial() limits value of min_partial between MIN_PARTIAL and
MAX_PARTIAL. As set_min_partial() can be called by min_partial_store()
too, Only limit value of min_partial in kmem_cache_open() so that it
can be changed to value that a user wants.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3a4458976ab7..a4964deccb61 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4002,10 +4002,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 
 static void set_min_partial(struct kmem_cache *s, unsigned long min)
 {
-	if (min < MIN_PARTIAL)
-		min = MIN_PARTIAL;
-	else if (min > MAX_PARTIAL)
-		min = MAX_PARTIAL;
 	s->min_partial = min;
 }
 
@@ -4184,6 +4180,8 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 {
+	int min_partial;
+
 	s->flags = kmem_cache_flags(s->size, flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
@@ -4215,7 +4213,10 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	 * The larger the object size is, the more slabs we want on the partial
 	 * list to avoid pounding the page allocator excessively.
 	 */
-	set_min_partial(s, ilog2(s->size) / 2);
+	min_partial = min(MAX_PARTIAL, ilog2(s->size) / 2);
+	min_partial = max(MIN_PARTIAL, min_partial);
+
+	set_min_partial(s, min_partial);
 
 	set_cpu_partial(s);
 
-- 
2.33.1

