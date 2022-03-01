Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9164C93A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiCAS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCAS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:57:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDE60CDB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D0C7B81CB0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFE8C340EE;
        Tue,  1 Mar 2022 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646160985;
        bh=usfHRRJQxk5ZPBBjY5lM+QOMJJruSA25LZ2RYqAjsk8=;
        h=From:To:Cc:Subject:Date:From;
        b=boS0m3SGvvVYdSDPMbk2vmPxKby2L4qP2A0CRlh1JLasCXH718Gwc5zuNqHnFHDDo
         1bS2HQCfW730Eb+VPYoyxy7qyvC0X4GRiFaOTQiRRcwzEnto9FfSjh8juc7OiGgVWa
         7kCGiW0awUpro2719e0IwyMHrcZDNvpDf2PCYtkGX8RIYBeLD4rYxYmYOo5LCJcztA
         6Dc+k0R8Jhd0M5cN49XzxpxULfU/yV76oE8PlIKTpI4uxs+MS+vyLv2pLZinng0u12
         9ZoVseoreMsjOmJZXMzMLgWxjewxjnyfBXMDH0DTSdkA4bV/FKZPfrw37po1BURHgz
         Zaw4XH5rzM/1g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm] mm/damon/sysfs: Fix out-of-bound array access for wmark_metric_strs[]
Date:   Tue,  1 Mar 2022 18:56:19 +0000
Message-Id: <20220301185619.2904-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a8630be880e ("mm/damon/sysfs: support DAMOS watermarks") on -mm
tree which introduced by a patch[1] titled
mm-damon-sysfs-support-damos-watermarks.patch allows out-of-bound access
to damon_sysfs_wmark_metric_strs[] array due to wrong bound check.  This
commit fixes the wrong bound check.  The issue has found by Coverity
report for linux-next.

[1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-damon-sysfs-support-damos-watermarks.patch

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 7a8630be880e ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: SeongJae Park <sj@kernel.org>
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
2.17.1

