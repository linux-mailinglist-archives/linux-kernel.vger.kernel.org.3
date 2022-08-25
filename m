Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C915A16F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbiHYQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbiHYQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:43:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA2ABB038
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 67so12136011pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HEbBlNE74XAOeDaqxFIrSXJjdeTVN4APARuNyd0Kkrc=;
        b=cIO/d1BGqL6fFstMorhflZg+vJ9obx8pMQqBtB2zXIPXvMogHPeMsu0jrMv3o/VTJZ
         IBkJf62+3rnapmZ4QtajmqxNiCKCoJpFUWP5Aj+4N2faq+JVYEs0jc7ZNWjuyG1nRM4X
         bG+zNO+sE24Jhpk3TgvTfkthoBCFGUujC2Zb58e5p7FLK/XotEpTJEWCcKgLCmbqgujF
         2omehs8EXzqBUnztnRg0Tg4+J3IhJW7PuV1Uhz8xpCunXu90C2TIFPpCGuP+8zZtnPgn
         eqzv/Ei/WX+oIjQ+VhIURYRrhU3nKqOCCdinlLLYeuDtRbLKy3hIv9MJ/xYh3I+q5Cwx
         epJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HEbBlNE74XAOeDaqxFIrSXJjdeTVN4APARuNyd0Kkrc=;
        b=JaNIh5FuHifYRekfI7UJwepwLNI+Cv8qASCytLhJwjo34TTTDJCnIwq7BGR0NYTV1+
         mtL96mYOXjkP2fs4TlI58YO81q6JGMrLjVeszl4ylb0+C3Cgr1b+dfSuxILGYbFEaof5
         rlMA/98B0vXL1+APWRwc+Eb5xQCDLq42PDDcP3r/XX0EgVvkJAnR6pUXJUyLigiwJ6W9
         otlxP/ArnuIFxMTzdQIonxzSyb7gxJ8JlWPLM7+EF1PX6WYtag37vX0Kv/eHVP2FlY2C
         PjVo3praJ3oDPX1RRvT2LRXucu0K1zJb0Yt3UzNgERFbmKDEVcdTllQ9COgW1/V/iAVp
         ddyA==
X-Gm-Message-State: ACgBeo3AMt4xRnAu6SLV6usyVEJlmNzMkhlEbsAiLCTKGjgzsYs7crmt
        dp0lRry+Z5S8RmjtpYinjKmMfA==
X-Google-Smtp-Source: AA6agR7DaINFBPuM/7F9bdN/GnJGUkNZ1zOAW5PM+T8a3FN4i4YkOwbmC4mTqFPVZ4HbR+7ywDSOhg==
X-Received: by 2002:a62:17c8:0:b0:537:b287:3ef8 with SMTP id 191-20020a6217c8000000b00537b2873ef8mr623736pfx.40.1661445765140;
        Thu, 25 Aug 2022 09:42:45 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:44 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 02/10] sched/psi: don't create cgroup PSI files when psi_disabled
Date:   Fri, 26 Aug 2022 00:41:03 +0800
Message-Id: <20220825164111.29534-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI can be configured to skip per-cgroup stall accounting. And
doesn't expose PSI files in cgroup hierarchy.

This patch do the same thing when psi_disabled.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/cgroup/cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 03dbbf8a8c28..2f79ddf9a85d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3748,6 +3748,9 @@ static void cgroup_pressure_release(struct kernfs_open_file *of)
 
 bool cgroup_psi_enabled(void)
 {
+	if (static_branch_likely(&psi_disabled))
+		return false;
+
 	return (cgroup_feature_disable_mask & (1 << OPT_FEATURE_PRESSURE)) == 0;
 }
 
-- 
2.37.2

