Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25B4F949A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiDHL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiDHL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:56:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E0103D8F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:53:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md4so125625pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BAbyawp6X1dszxQsJjNUW3vfgOBhltv9zN2kFx5i8o=;
        b=K927yCSU9vg8aMl5TyqAXZktJioqWJPVD5H37YnztNu/6ZRiFt3TSoOPWoFvV8ZEO8
         wIGv1ojYV3cpvegcZR/6/ja4zSgAjdwlgjYWawDdS+GCCTKwR8AQTdYYb6N93Qlzkl1s
         /JDbDCpsKq69rFq2QZiF0GRB2bSZuBdUMlbxWxPkmnJAPS4Mizq2/EeEi8XOaRIEDaVR
         Amsf1tnMBlyRi26XmGYIEzyeZc/lxkmmji7WohcHZhTH2PytoMLYvmYilSbn8oJxwNuk
         ZMe0PQzV3Vk4U3wuCD2rvH01heMTgMXoy8SP+tVlSGAp3M5iAz6ICdVl7dTMtaVZerFb
         O6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BAbyawp6X1dszxQsJjNUW3vfgOBhltv9zN2kFx5i8o=;
        b=Y3qt9teVZj3rP223KBjIMdHC3s5bqzlOEmKirlWlu9ykciVj5WDOMegdiobpzvS2xb
         wisbxCW/GllDV21mJxG15ZZffwH6HiQd9xwWlqQHuVHTlh+O4WvB0MLKRI+8AS0WRPKS
         XxAjA8eaUBB1GPZOnwsPhHaW8Awf+8b1fAVUIf4iOe01Lu4Ni6TV/pAJm731gslrckJs
         hWXKf+w96Lgy7/DJC+lVBZqyZ8QIQZBJ1QGLetoXMafHgqWfjbF9tgFxTndyB4tJ+yN/
         2uYN0xlHCDYWxd0ndquqgpIPXkG9+z4zraz5VQcuwpRMZy4rU5gXW27C+b0+CP9oUitv
         ARgQ==
X-Gm-Message-State: AOAM530IDGitEYQygwN4D8EYEMQI3j/At4UV2m4uiVzOi7Raqo034TOn
        jZO0ezBph8R8Oneq5u4KlPk+OQ==
X-Google-Smtp-Source: ABdhPJziO7rKhLl4Cx1JV/Moyb7zDjXxgc4+475kX5ADu8km2tZQtNX4yjh+ex8e5Eg41ehMU8+11w==
X-Received: by 2002:a17:90b:1b03:b0:1c7:778b:d4ce with SMTP id nu3-20020a17090b1b0300b001c7778bd4cemr21442114pjb.128.1649418832752;
        Fri, 08 Apr 2022 04:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:a5e3:608e:7730:5b8e])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm5185409pfw.77.2022.04.08.04.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:53:51 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/2] sched/fair: Delete useless condition in tg_unthrottle_up()
Date:   Fri,  8 Apr 2022 19:53:09 +0800
Message-Id: <20220408115309.81603-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408115309.81603-1-zhouchengming@bytedance.com>
References: <20220408115309.81603-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have tested cfs_rq->load.weight in cfs_rq_is_decayed(),
the first condition "!cfs_rq_is_decayed(cfs_rq)" is enough
to cover the second condition "cfs_rq->nr_running".

Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - improve the commit message.
 - add Reviewed-by tags.
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dc73c3b500a5..64186ea245c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4850,7 +4850,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 					     cfs_rq->throttled_clock_pelt;
 
 		/* Add cfs_rq with load or one or more already running entities to the list */
-		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
+		if (!cfs_rq_is_decayed(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-- 
2.35.1

