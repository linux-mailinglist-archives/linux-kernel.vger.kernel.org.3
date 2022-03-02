Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6E4CACDD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbiCBSDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244398AbiCBSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:03:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B81D32A;
        Wed,  2 Mar 2022 10:02:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b5so4065747wrr.2;
        Wed, 02 Mar 2022 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLfjD749xSnL6xg2oAyC7SKFLVc/brW6p/9hUhDG8k=;
        b=YzBwb+1Gi/Isd4K6+XoKfHngkObvdDjfOMeTAf9cbaKPpz/n9eGDMAufz7dq4Q8Wlf
         uCJebMTuBQJnRvgFsS0ByF72owbw9eSp1477MHGZRq7Up3jkkfHVWhIrxbNK+6sbvf/Y
         SbbNQ3arejFoEpc0YyexG0QgJ9jEkrY5qUumnx/KJt9nrJR+E87NT5eaNkDUZ5/428eI
         nTgLenBBT7H9nYdMdKDDrB1p71yuLqAGNtiv5M12lokHmGrbNaDIdrd/sZ1Pxn/56+5/
         Vp3hR0R2vgIeV/CdNBG6xsvLOHFmU9bnMtYlq8lefHRs/zx+Sh5KdSv262if3fo7H8eD
         y9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLfjD749xSnL6xg2oAyC7SKFLVc/brW6p/9hUhDG8k=;
        b=UdlrS/Rv87cHELpCtYN0JZa/co+xsb6Rn9xp65cGRDaB7393+ojZd7258/Nu/WzlUN
         e27AtwWaadh+HcNXegDCWA/NCWM8A4zFzykT6dIV59A/NGqWPGLmfRmIdvPKyTI+mWdC
         gcCMSz63Zi36rYedhNJRUlnqXJbIW2S8Kumd/vA05Oeoq5T0CLkrwlawvZCvbyovZbeJ
         EGR6D7wabQY+VtSczb59GVuccM9W/FPmMG1plSpFf5qEQdEQLTQ/aoYIAAmxmnskJmCP
         unmmlwHuamkH/MLQsQ5/QL5Z7CHHq1J0MxDBfdntGJ7NbpFuIuIdUyaSwnHtKpzNGdG8
         XnLg==
X-Gm-Message-State: AOAM532VDZIY/3B4ZY7yeMKJPTi0ZkrnbegQpcLLPTgWp2s6k0Aq8Ig6
        ZGthjhLKS+9yHItcr0rRhnlyqZm/0DeCRQ==
X-Google-Smtp-Source: ABdhPJxHQ7Py2A1/Xrj9k1ikIUZwbzyE7O+78XWO4g23mCyJzGBqZytwDf8Rr/KkRHc+5rXedOYG1w==
X-Received: by 2002:adf:eb44:0:b0:1f0:483c:f015 with SMTP id u4-20020adfeb44000000b001f0483cf015mr1334771wrn.397.1646244173507;
        Wed, 02 Mar 2022 10:02:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c1c9100b00386bb6e9c50sm1068631wms.45.2022.03.02.10.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:02:53 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs: Fix an array out-of-bounds read error due
Date:   Wed,  2 Mar 2022 18:02:52 +0000
Message-Id: <20220302180252.1099406-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an off-by-one error in the upper limit to a for-loop that
causes an out-of-bounds read error on the array
damon_sysfs_wmark_metric_strs. Fix the comparison by replacing
the <= operator with <.

Fixes: 8f614da9d987 ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 32a9d21c0db5..fda2506c676f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -266,7 +266,7 @@ static ssize_t metric_store(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_watermarks, kobj);
 	enum damos_wmark_metric metric;
 
-	for (metric = 0; metric <= NR_DAMOS_WMARK_METRICS; metric++) {
+	for (metric = 0; metric < NR_DAMOS_WMARK_METRICS; metric++) {
 		if (sysfs_streq(buf, damon_sysfs_wmark_metric_strs[metric])) {
 			watermarks->metric = metric;
 			return count;
-- 
2.34.1

