Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A51591B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiHMPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHMPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:19:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264213FA3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:19:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y141so3339061pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=sczWzcrWCAkWB34nYrTJR/7dpANVkwOeC+sp+t0HVfg=;
        b=Ch2VEMqApEF7lOYCvApzId+CrqdLxAbsPRAJozfJeo2VvHdNDkJNgIpVgnWA6pGh4l
         i6xU7XYij8JJaJZNCCMT9pmc94GhY8UqOZMtIPeAmX0BizsVH6iUV/Nsc54Dv4pEF6A8
         Xb/6Xv0X8th6wday3v0NwrfxCHBjl4PGgPaiY0Vd7Gz8Etubp20Be6PmftqNqPnETYXq
         bzZnjCbNcaShGvoKRUc6sPjytSEcIe3Yuk5/BPy+6Da0a7IkdIo4B9iQZOSzdVKmjBUJ
         Hsi6XuSfWIRp/5OXmgBqWwRSLjPAqFRpt5QPYPzDYTTBIYCmR8D23vltAKb9nLCfmlRr
         IO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sczWzcrWCAkWB34nYrTJR/7dpANVkwOeC+sp+t0HVfg=;
        b=DWH6gJulmiSzKcWt+tDfDLQvCEczSFUMEA6WdF7DHo9nA7RN7vhhkrr77gncxDuKaP
         wCA+5PRkVuUgY4QqLW91AN4OQzGBy9pp4dqOl+vvLY52+zyDc4PXYUE7OKL7Wvw+PslN
         VZHVjKFg3THnUcyuuMyGZGbgiaYSkSme5ObxtKItfbHSojT8wzdR3qEfGqK8csVvCqDN
         55/NlgK1ULLvmJZhn8eebi/VFgfEHsUNfyiKxzzZH/8I9INfgwP4PWso4AY/82RVgyHC
         21K3/HSuF1k6vTy1SkCZMFJLrovWBD5i0w1oLbtq5FLO0udji14YsCcgrIhjGV6rRFA8
         KshQ==
X-Gm-Message-State: ACgBeo3mAXt924+L5xERNhgtoxPQQyhJdJaASC8DPn03MofSq9hCeS8l
        NEAJ/zVRT+B7KPRrN5GEbO98dxsY+g==
X-Google-Smtp-Source: AA6agR6Xb4TLm7ioMv+Cf/enVJM4Y6+9baENFEq59DyweBo1Hi/1Ds5xYTCCuHuBvnOT3fZMGNL2vA==
X-Received: by 2002:a63:e016:0:b0:427:e7f2:32b3 with SMTP id e22-20020a63e016000000b00427e7f232b3mr16970pgh.194.1660403967376;
        Sat, 13 Aug 2022 08:19:27 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id a22-20020aa795b6000000b0052dab7afa04sm3666619pfk.47.2022.08.13.08.19.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Aug 2022 08:19:26 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH V2] mm/damon/core: simplify the parameter passing for region split operation
Date:   Sat, 13 Aug 2022 23:19:03 +0800
Message-Id: <1660403943-29124-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' is unnecessary in damon region
split operation, so we can remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2:
 -fix both the build error reported by kernel test robot and commit message.

 mm/damon/core-test.h |  6 +++---
 mm/damon/core.c      | 21 +++++++++------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 573669566f84..45db79d28fdc 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -126,7 +126,7 @@ static void damon_test_split_at(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 100);
 	damon_add_region(r, t);
-	damon_split_region_at(c, t, r, 25);
+	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -219,14 +219,14 @@ static void damon_test_split_regions_of(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 22);
 	damon_add_region(r, t);
-	damon_split_regions_of(c, t, 2);
+	damon_split_regions_of(t, 2);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
 	r = damon_new_region(0, 220);
 	damon_add_region(r, t);
-	damon_split_regions_of(c, t, 4);
+	damon_split_regions_of(t, 4);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 	damon_destroy_ctx(c);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..9964b9d00768 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -658,9 +658,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 	}
 }
 
-static void damon_split_region_at(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		unsigned long sz_r);
+static void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r);
 
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
@@ -726,7 +725,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						continue;
 					sz = DAMON_MIN_REGION;
 				}
-				damon_split_region_at(c, t, r, sz);
+				damon_split_region_at(t, r, sz);
 				r = damon_next_region(r);
 				sz = r->ar.end - r->ar.start;
 			}
@@ -745,7 +744,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 						DAMON_MIN_REGION);
 				if (!sz)
 					goto update_stat;
-				damon_split_region_at(c, t, r, sz);
+				damon_split_region_at(t, r, sz);
 			}
 			ktime_get_coarse_ts64(&begin);
 			sz_applied = c->ops.apply_scheme(c, t, r, s);
@@ -928,9 +927,8 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
  */
-static void damon_split_region_at(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		unsigned long sz_r)
+static void damon_split_region_at(struct damon_target *t,
+				  struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
 
@@ -947,8 +945,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-static void damon_split_regions_of(struct damon_ctx *ctx,
-				     struct damon_target *t, int nr_subs)
+static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 {
 	struct damon_region *r, *next;
 	unsigned long sz_region, sz_sub = 0;
@@ -969,7 +966,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(ctx, t, r, sz_sub);
+			damon_split_region_at(t, r, sz_sub);
 			sz_region = sz_sub;
 		}
 	}
@@ -1004,7 +1001,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
-		damon_split_regions_of(ctx, t, nr_subregions);
+		damon_split_regions_of(t, nr_subregions);
 
 	last_nr_regions = nr_regions;
 }
-- 
2.27.0

