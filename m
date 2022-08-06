Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC258B550
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiHFMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiHFMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:05:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572B14083
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:05:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d16so4727837pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=B0kDW3n73/YJtEBYuBAaHlkDVhHbuG8uEXjeR76NRXQ=;
        b=HOwD30nidxj8TRJDvMEt7DZGPmPNIskaCEBYf1vaxK0PzNO2rKRfzG+oRA6qxPhcEg
         5TC2eJOwOeOMvsNkH6tzSx7/9oc01PLAmMwADbzOXdlNneii9Of5+K8RSI8HmgZx+vY5
         3OwTdPgX1+T6KF8ezLYrYhzwvJbUJ2Yqvs6+70IuTU3ZEMRy9IzczEPZs0YQjuLsLN+P
         GISNPGjyj2EjJ69BVyurbVefNQJPXvk/wVvx93nFVf0x6vLTyPJ4JmF8l7DdPOHDQ7nY
         kz3i+iFswlPHCSJqkg1iBmYwv0zo3+Ny62myGSTCwTbWhXyF7/MJqHh/xIk2yCZ1yfqj
         d2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=B0kDW3n73/YJtEBYuBAaHlkDVhHbuG8uEXjeR76NRXQ=;
        b=7soO+3fWtI92wzM0AvcOlaBVgt4GeqkO7kI4RAsHm1ph45ivzHcJd6Es2IF34nr3vV
         89a/F3aJaahWFEna2LCShrQMxRYX93/0hEklMZA+ghWvEJMumGuRFnoTTaiQn7mCsOZh
         IQHW2/yes7fIth8XqX5NTDJDDPYRtmJfIm/Q2w7U1mmAcSnKDHr0GjKZHZdsg7LuUFA/
         ZQaOYWhOIACxKY4zHGtJLwe0BCkkKoeXq1/6zTGsZO4HRekbZ188YmHguit5Fz0sxPTt
         9dwTuop/MQ6xTLUC/TElSXt2lppDaOSJvslsmqQ1gAYmx1a5ZkyVHK7ZrDEIzfOAVwwS
         auWw==
X-Gm-Message-State: ACgBeo26qVAcGVx/jhuJWpOoKXnoRD5ip+T+XuZoJI9c+fzu6xM5PVAc
        dvTdUGQhsCvivtaIV8u/6MFswQ==
X-Google-Smtp-Source: AA6agR53D0SuL1XIiR+rmxRcrxKX+bO+Lb2m0Cq+adYY3x4InNWOF1SlBkF/3RyQ8MzUoqWY7Rk0fA==
X-Received: by 2002:a17:90b:3892:b0:1f5:8be1:d8a0 with SMTP id mu18-20020a17090b389200b001f58be1d8a0mr7396598pjb.162.1659787547075;
        Sat, 06 Aug 2022 05:05:47 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t4-20020a63eb04000000b003db7de758besm3035003pgh.5.2022.08.06.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:05:45 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 3/3] sched/psi: Remove redundant cgroup_psi() when !CONFIG_CGROUPS
Date:   Sat,  6 Aug 2022 20:05:10 +0800
Message-Id: <20220806120510.96131-4-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220806120510.96131-1-jiahao.os@bytedance.com>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup_psi() is only called under CONFIG_CGROUPS.
We don't need cgroup_psi() when !CONFIG_CGROUPS,
so we can remove it in this case.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 include/linux/cgroup.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe7c46c..ac5d0515680e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -734,11 +734,6 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 	return NULL;
 }
 
-static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
-{
-	return NULL;
-}
-
 static inline bool cgroup_psi_enabled(void)
 {
 	return false;
-- 
2.32.0

