Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2744F85E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346228AbiDGRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbiDGRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:24:00 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A913F42;
        Thu,  7 Apr 2022 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=vUaTkhLKpC517uBr5V8nSaXBUclETbcgKiMjxeP1Ciw=; b=sg+YjSBPnepVHG/AtlVk/OqAQm
        0WF5GZz2jT1Gy/kUHruPwf2d3Oo1U7JsNLSLga+7ccr65ElJtOB/6sevZhXobr2cDVSBj7yEucyUA
        bkVleLBuhQNr5L/Oc0mY2AXuj/PGlbxhV/jTDSE7967CEcPuS4iQyhPzkKGkL0NLG8gtnAfhxp0cl
        sLD3G1xic607XPD/M1oeqgA0lepnwC+Bn4fgj45BYXaDt3p5nSqnNYO/E0kFZxJoaIMq/302KjX4r
        L2v8/2d23s+q1C2kpnsYTfHF/nXPTfZoNFA+ar5PB/wMI0uJ6juFckmAPBfOTGLY2KPFfpeJ2tvFu
        lYz1oT0A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-002CRf-HG; Thu, 07 Apr 2022 10:57:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRe-0002Q1-SN; Thu, 07 Apr 2022 10:57:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:07 -0600
Message-Id: <20220407165713.9243-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407165713.9243-1-logang@deltatee.com>
References: <20220407165713.9243-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 1/7] md/raid5: Cleanup setup_conf() error returns
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be more careful about the error returns. Most errors in this function
are actually ENOMEM, but it forcibly returns EIO if conf has been
allocated.

Instead return ret and ensure it is set appropriately before each goto
abort.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 351d341a1ffa..c0e373a02d3a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7166,7 +7166,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	int i;
 	int group_cnt;
 	struct r5worker_group *new_group;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (mddev->new_level != 5
 	    && mddev->new_level != 4
@@ -7225,6 +7225,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	spin_lock_init(&conf->device_lock);
 	seqcount_spinlock_init(&conf->gen_lock, &conf->device_lock);
 	mutex_init(&conf->cache_size_mutex);
+
 	init_waitqueue_head(&conf->wait_for_quiescent);
 	init_waitqueue_head(&conf->wait_for_stripe);
 	init_waitqueue_head(&conf->wait_for_overlap);
@@ -7302,11 +7303,13 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 
 	conf->level = mddev->new_level;
 	conf->chunk_sectors = mddev->new_chunk_sectors;
-	if (raid5_alloc_percpu(conf) != 0)
+	ret = raid5_alloc_percpu(conf);
+	if (ret)
 		goto abort;
 
 	pr_debug("raid456: run(%s) called.\n", mdname(mddev));
 
+	ret = -EIO;
 	rdev_for_each(rdev, mddev) {
 		raid_disk = rdev->raid_disk;
 		if (raid_disk >= max_disks
@@ -7370,6 +7373,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	if (grow_stripes(conf, conf->min_nr_stripes)) {
 		pr_warn("md/raid:%s: couldn't allocate %dkB for buffers\n",
 			mdname(mddev), memory);
+		ret = -ENOMEM;
 		goto abort;
 	} else
 		pr_debug("md/raid:%s: allocated %dkB\n", mdname(mddev), memory);
@@ -7383,7 +7387,8 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	conf->shrinker.count_objects = raid5_cache_count;
 	conf->shrinker.batch = 128;
 	conf->shrinker.flags = 0;
-	if (register_shrinker(&conf->shrinker)) {
+	ret = register_shrinker(&conf->shrinker);
+	if (ret) {
 		pr_warn("md/raid:%s: couldn't register shrinker.\n",
 			mdname(mddev));
 		goto abort;
@@ -7394,17 +7399,16 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	if (!conf->thread) {
 		pr_warn("md/raid:%s: couldn't allocate thread.\n",
 			mdname(mddev));
+		ret = -ENOMEM;
 		goto abort;
 	}
 
 	return conf;
 
  abort:
-	if (conf) {
+	if (conf)
 		free_conf(conf);
-		return ERR_PTR(-EIO);
-	} else
-		return ERR_PTR(-ENOMEM);
+	return ERR_PTR(ret);
 }
 
 static int only_parity(int raid_disk, int algo, int raid_disks, int max_degraded)
-- 
2.30.2

