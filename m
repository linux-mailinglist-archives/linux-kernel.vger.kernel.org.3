Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE795AA2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiIAWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIAWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44A58091
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:17:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l5so143142qvs.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+2CQoWOzORwmFm7W8hobFnBssU2v8aOfIo1J22tLn5A=;
        b=gYFVtvH6IT88YOW+VuemDQdOw9jN1vrqUhqD4F59DGDWIburm49TpkXGVQY87YJ84L
         qH6wa/UO5erX3ioCJY2/tLyTnBhtQ1+KSn2ciZl3SpPmczkva7MHX/hbiZhzntNqv0Q4
         KArjDPxW26NuxuN0qO1Zj5kVlXjgrE+8nGLpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+2CQoWOzORwmFm7W8hobFnBssU2v8aOfIo1J22tLn5A=;
        b=siDCCNGXXe00suQrnc4aSn0ZAQAyOaR7STGYwzhmn0/bq+PxiL3NJv0FJqm/wtXYe7
         JyCVaTaACoX19TxXXGD8Pe3ivwWLTvOJ6vzAh7TQKyRUWNO3+s8WZ/azQJX7IvxY6ffK
         iBvKygp2hw2UTVZpeZeUf/Q9D+b9j4S87IAtSrcw/WrucSNCahyrPIpr/kBkqt52re73
         7LLwj5GmSZ5qktF+2Ibw5i/RmlHNUorR2NnZN5ZfJdVAxar4WA5RIAkYtxIdHV38ibQn
         sW0PKa6kVZBuC7DJSIXaDx0nudHR7WkI/xc2HS5KdrBw1v/xZzrEyYwsO0B8XCuHAF1M
         TTGw==
X-Gm-Message-State: ACgBeo1zKQ+LPw0AIRwKkeS3RC7AnCDDWnA61JoskztuQ3D9xSfWxjYA
        HRmNGgTwO/aev2LUOvUUKD/7xi8m3NeD6Q==
X-Google-Smtp-Source: AA6agR4kxLtEYufGPqZXnLYzR+tmjfowzJgSuRNILICeEUEdChLKGM9hmPATH/Xdqmcnc+IW5AQBNw==
X-Received: by 2002:a05:6214:2a4b:b0:499:eb9:6ed3 with SMTP id jf11-20020a0562142a4b00b004990eb96ed3mr14878236qvb.66.1662070678188;
        Thu, 01 Sep 2022 15:17:58 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 01/18] mm/slub: perform free consistency checks before call_rcu
Date:   Thu,  1 Sep 2022 22:17:03 +0000
Message-Id: <20220901221720.1105021-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

For SLAB_TYPESAFE_BY_RCU caches we use call_rcu to perform empty slab
freeing. The rcu callback rcu_free_slab() calls __free_slab() that
currently includes checking the slab consistency for caches with
SLAB_CONSISTENCY_CHECKS flags. This check needs the slab->objects field
to be intact.

Because in the next patch we want to allow rcu_head in struct slab to
become larger in debug configurations and thus potentially overwrite
more fields through a union than slab_list, we want to limit the fields
used in rcu_free_slab().  Thus move the consistency checks to
free_slab() before call_rcu(). This can be done safely even for
SLAB_TYPESAFE_BY_RCU caches where accesses to the objects can still
occur after freeing them.

As a result, only the slab->slab_cache field has to be physically
separate from rcu_head for the freeing callback to work. We also save
some cycles in the rcu callback for caches with consistency checks
enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..d86be1b0d09f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2036,14 +2036,6 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int order = folio_order(folio);
 	int pages = 1 << order;
 
-	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
-		void *p;
-
-		slab_pad_check(s, slab);
-		for_each_object(p, s, slab_address(slab), slab->objects)
-			check_object(s, slab, p, SLUB_RED_INACTIVE);
-	}
-
 	__slab_clear_pfmemalloc(slab);
 	__folio_clear_slab(folio);
 	folio->mapping = NULL;
@@ -2062,9 +2054,17 @@ static void rcu_free_slab(struct rcu_head *h)
 
 static void free_slab(struct kmem_cache *s, struct slab *slab)
 {
-	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
+	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
+		void *p;
+
+		slab_pad_check(s, slab);
+		for_each_object(p, s, slab_address(slab), slab->objects)
+			check_object(s, slab, p, SLUB_RED_INACTIVE);
+	}
+
+	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
 		call_rcu(&slab->rcu_head, rcu_free_slab);
-	} else
+	else
 		__free_slab(s, slab);
 }
 
-- 
2.37.2.789.g6183377224-goog

