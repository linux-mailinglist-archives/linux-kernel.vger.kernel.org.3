Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3172B5090EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbiDTT7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381885AbiDTT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:58 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBF14003;
        Wed, 20 Apr 2022 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=vIG3yPf6Z99Rw9//hJOFyO9CpFp0TwWujYCD5Vmfae0=; b=GECck8rsp4SiCN2EXz5B+wiOFG
        cY766AErBfJij2w+ZMA2+8K+VTGYY+cHEBRPPaQk4PpoRYt4ccFR0cZ2lE4XdidyMuI0BCCtBl4Tr
        bXF2zwojxkMXDih+s0NGHK4qyzsghjfSEVPITAF5FuPLIJ5I8QLjTsu6mtYFKiiUgVxAVFNV0qWmN
        yHLXEuZJn1ou1mlY4safFGzHQDZhRGBz06MXV6OsWKnrHDKEz0RO3Uo+6v/uZ5E0UeQpF6wwY1Aya
        6LBn318x5xcU1CbLVKos1EUSFvcZtxo9HMU+2R3MjHQiMqBFn7OkIl/jgDG3iQx849/qViQ5MUTXg
        QsIy386g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPr-00CRsO-K5; Wed, 20 Apr 2022 13:55:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00096W-UT; Wed, 20 Apr 2022 13:55:05 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 20 Apr 2022 13:54:21 -0600
Message-Id: <20220420195425.34911-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
References: <20220420195425.34911-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 08/12] md/raid5: Refactor for loop in raid5_make_request() into while loop
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The for loop with retry label can be more cleanly expressed as a while
loop by moving the logical_sector increment into the success path.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 1bce9075e165..0c250cc3bfff 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5971,20 +5971,21 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	}
 	md_account_bio(mddev, &bi);
 	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
-	for (; logical_sector < last_sector; logical_sector += RAID5_STRIPE_SECTORS(conf)) {
-	retry:
+	while (logical_sector < last_sector) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
 		if (res == STRIPE_FAIL) {
 			break;
 		} else if (res == STRIPE_RETRY) {
-			goto retry;
+			continue;
 		} else if (res == STRIPE_SCHEDULE_AND_RETRY) {
 			schedule();
 			prepare_to_wait(&conf->wait_for_overlap, &w,
 					TASK_UNINTERRUPTIBLE);
-			goto retry;
+			continue;
 		}
+
+		logical_sector += RAID5_STRIPE_SECTORS(conf);
 	}
 
 	finish_wait(&conf->wait_for_overlap, &w);
-- 
2.30.2

