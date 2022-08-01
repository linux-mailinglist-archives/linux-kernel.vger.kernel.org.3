Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA7586682
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiHAIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHAInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:43:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6152F668
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:43:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p8so9805314plq.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qtCFUiSlY6lJ/aXJnd6fr2hStSXov8dE2EzHxWqEyIg=;
        b=2RwEtdtl4E1aRxbENPLkwq3Lrm8t+tLiZrQ/ikpUivzerzB3j1S6rP1B3pvMqB1CHR
         MoY7Ritl2tvSA2izf4J/Ei7hI/+FVQWrR+wcsYYmAGHHS75RF5skPAksoA3Y04ImxuBX
         M68bJ+dZMJ8YjlTuhC0P1zBFcfNK4NnJ2gAyZqCOfTIIy1zBmNuL9aGttqqEnuPj+WYg
         e7W6a9PyipGs6qiQi51Du+byR9x7lssC/GLxtgvWTaP2Q82qUBctVeu7aWk5yUQmSZsj
         +68qMNOpm5ciS4IB4ls+WwBTyQ1xALHkGlHKCJcM6yvxCK7HgYBmV6ywJgOm6pc/Pv1v
         2PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qtCFUiSlY6lJ/aXJnd6fr2hStSXov8dE2EzHxWqEyIg=;
        b=OL1mx4EJ6wzRCuwUa6YdkOkzb66CEgRoB8cvclBklLoYVqMJewOTABpKmDtEOv0KwK
         ITyZQN8NC9Jyw+XqRDR7SsY91ylEY5Kep2/quynoyzNqzQfI11/HsgMpSvGsDIYJH5IS
         xunwIhqm13iAsJ5NUV9Z9Hlj56VYh0YypORzt06vYmv52jJieO3kJAfWjnPU7laSIFHJ
         HeRFSPY5nBpRZj7iMi7NpkZqyMeAFEg6ZumswtC0ogQTSpcmU5Qi+jKBMireNQBj04rI
         iae/CkghGohfwEvKIqRdop5CLzqvP3ArI3GcBucwLohTpNyqdtjDjMTcVpOiI03Zzihc
         1esQ==
X-Gm-Message-State: ACgBeo2flcuT9+CqYis1kTyDIIhgwE9KKmv1skFFnthzNh2SvlH+KEgy
        ACSvIBNoLz30tw4Grp0XkjuiFw==
X-Google-Smtp-Source: AA6agR6zTozq1E06rEH33OfjNTim5CXg32Nr1pv/teCYOEhBmNrAQCy5Nj76HGMXwdxdNdECFznnCA==
X-Received: by 2002:a17:90a:1943:b0:1ef:8146:f32f with SMTP id 3-20020a17090a194300b001ef8146f32fmr18027396pjh.112.1659343403411;
        Mon, 01 Aug 2022 01:43:23 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id z3-20020a1709027e8300b0016dafeda062sm8826393pla.232.2022.08.01.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 01:43:23 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, bwidawsk@kernel.org, mhocko@suse.com,
        dave.hansen@linux.intel.com, feng.tang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: mempolicy: fix policy_nodemask() for MPOL_PREFERRED_MANY case
Date:   Mon,  1 Aug 2022 16:42:07 +0800
Message-Id: <20220801084207.39086-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
for filtering nodes for page allocation, which is a hard restriction (see the user
of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
since all of the users already have handled the case of MPOL_PREFERRED_MANY before
calling it.  BTW, it is found by code inspection.

Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mempolicy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6c27acb6cd63..4deec7e598c6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
 
-	if (mode == MPOL_PREFERRED_MANY)
-		return &policy->nodes;
-
 	return NULL;
 }
 
-- 
2.11.0

