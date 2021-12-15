Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D747549B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhLOIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhLOIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:52:35 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:52:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id g28so19343547qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3xqEFCnUeJ8vvB6oqGl3RWteLibojQLIPJLALa9AL4=;
        b=LWvCWYu5dd7SpqDfLhzfKe/gM68KLGz+a8UD4ROmRR+SiNgJaYC0CO+GKngxadcs+B
         jw7au6+Czw16h/I5TzQ59+Nhjegs38s7HrW6EGV2ePYGKmPPj/dVe2CpsVbGEI2JLc+d
         KbZG+3Lo+NdSqaOFyZXv59ka5U6J6QpALFB7fHX4OR2pn0mzNe8S8Y6EHZ7Mko9eDC7O
         YYgD+iPDbUfxJaKgozd6Osl2u+gsPGwNmtov25jPzMffqa6qQzv+h+qJtdIlPe10WNwV
         SRt3rKe6NB+OMgcd/b0vLs78iVPf63mrDLHlwM5YGE9mGEjEqerTd32oYqH/sr84Z/Da
         Q8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3xqEFCnUeJ8vvB6oqGl3RWteLibojQLIPJLALa9AL4=;
        b=nHkeNy8BD4b6HbtsVHj7j9sZ0Il4zpLiNrLisSq6Qf5yaWjJipmX9PhCu/iB4qLnYc
         S54f+bOencaN3ctZq120rxsGXSdIrs69zSXN4noWHA3QUpNyE2zy0zxhla3PgjdETzPy
         Kk3haApJTmnwhFqHO2Uxo6Ce2CE7D4U2Nh6car1D+xTUvmraABEMiQF6aCIJZtwQ6ILr
         DPHLJFVhGHsGb7YvzFUfag41jRV5muueZDIw7rvYjlcuGB/0CcNMl4/cJs8cM4K6YNTr
         x7xwYeLX3sEnF00kA9IO9JtZDSY9U/LSvgN7mFEktx9JFf1WJe4A+k6cursvo0Zg+Lcj
         HQjQ==
X-Gm-Message-State: AOAM5310RaPCRsXuupjCCE6VjSQ+2GqRrLWdDylHBLMMfFw0GkTiC3gL
        YQ468D4QZlo9WTrmsoyajc8=
X-Google-Smtp-Source: ABdhPJxbuYNNH89Hh5DonCAoPvklNGqdaYuC30FlbEHaKHj3JDfq8kkAx1hTE8+V67UMKVqj2+s/9w==
X-Received: by 2002:a05:620a:66e:: with SMTP id a14mr7842353qkh.496.1639558354245;
        Wed, 15 Dec 2021 00:52:34 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t15sm1039864qta.45.2021.12.15.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 00:52:33 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Felix.Kuehling@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdkfd: use max() and min() to make code cleaner
Date:   Wed, 15 Dec 2021 08:52:26 +0000
Message-Id: <20211215085226.444116-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use max() and min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7e92dcea4ce8..c6d3555b5be6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2254,8 +2254,8 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	start = mni->interval_tree.start;
 	last = mni->interval_tree.last;
-	start = (start > range->start ? start : range->start) >> PAGE_SHIFT;
-	last = (last < (range->end - 1) ? last : range->end - 1) >> PAGE_SHIFT;
+	start = max(start, range->start) >> PAGE_SHIFT;
+	last = min(last, range->end - 1) >> PAGE_SHIFT;
 	pr_debug("[0x%lx 0x%lx] range[0x%lx 0x%lx] notifier[0x%lx 0x%lx] %d\n",
 		 start, last, range->start >> PAGE_SHIFT,
 		 (range->end - 1) >> PAGE_SHIFT,
-- 
2.25.1

