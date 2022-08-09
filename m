Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F10558D663
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiHIJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiHIJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:23:16 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6293B48E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:23:15 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3B2611E80D95;
        Tue,  9 Aug 2022 17:21:30 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f-ePpt-1Iq8Y; Tue,  9 Aug 2022 17:21:27 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7F9431E80D70;
        Tue,  9 Aug 2022 17:21:27 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] drivers/md/dm-kcopyd.c: remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 17:23:10 +0800
Message-Id: <20220809092310.5603-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 4d3bbbea2e9a..65ed3e574c7e 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -513,7 +513,7 @@ static int run_complete_job(struct kcopyd_job *job)
 
 static void complete_io(unsigned long error, void *context)
 {
-	struct kcopyd_job *job = (struct kcopyd_job *) context;
+	struct kcopyd_job *job = context;
 	struct dm_kcopyd_client *kc = job->kc;
 
 	io_job_finish(kc->throttle);
@@ -689,7 +689,7 @@ static void segment_complete(int read_err, unsigned long write_err,
 	/* FIXME: tidy this function */
 	sector_t progress = 0;
 	sector_t count = 0;
-	struct kcopyd_job *sub_job = (struct kcopyd_job *) context;
+	struct kcopyd_job *sub_job = context;
 	struct kcopyd_job *job = sub_job->master_job;
 	struct dm_kcopyd_client *kc = job->kc;
 
-- 
2.18.2

