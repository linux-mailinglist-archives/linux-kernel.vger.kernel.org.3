Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C74D0815
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiCGUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbiCGUBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:01:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7446E367
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:00:12 -0800 (PST)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3C1B3F7E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646683210;
        bh=wYDSBk7iUMWwKBfS03BdFKJC7SiK0s9WxGrCHtrTAag=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cbZzHdVIq2LW2d3snlpxiCgpN4bW5uC9o0r7LudazHkxaKEUxoXC5vnyfQsUUnRXo
         bV8toV53GIUEtWlqaZ8bZ6Ip4o1E3fjkr03nWngeHZ/w6bYdO/Qpb6nUZaOG2mlNgu
         xT42K3L69jNVlHVJb7et+S5CAgV/okKr7ZwB2f09bAclz8TfBIoA0RQCZvCohlg/lM
         FHwEfSlmBtiSH8XReRL9mRHE04Ss8Z8phBVvoroKKXOn69EPFzE9b35LONl3pRgsoY
         lH8InKPLE2AjzeMuEGrjxkAssSLmx37ybEvGiv3DgFs6e9TorPji7GoLedzW8K+0f2
         86HnPnaTyRhfA==
Received: by mail-il1-f199.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso11013605ili.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 12:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYDSBk7iUMWwKBfS03BdFKJC7SiK0s9WxGrCHtrTAag=;
        b=OIDBQ39plrXZkdjSkfNal3kHFIaZnAOQ9mre7H2ZjqeSxsIOKjXExdNoGlugU0t9bN
         tpjSF7NxJpXcrF1bHwMmOPYWGtSyaFuU+lHqfumJV0zcqpNZmKwFowbsWQAuYjaDrVgW
         ubiwEZ2kMgJiKDI6R8p8e1Kx0lTggb1vkBNl8UNj9vgU5HFkKNdU8xKOZycyO/o9Jzt6
         yGqsALoaGqknbdsVuxE38vCdyMjC4Pw+UOwueZZOUhCgWJicM/GuyByYuCSxecAihSmI
         uF/5rNMQNNc3GVHrh2nXzn3DfflBhcfMSGU1xZtbCktpIeMONfCKKv15lpx5eW8MguVn
         /nCw==
X-Gm-Message-State: AOAM533kALRngIYlOVVhmoA5yr9ULs013de5XHp079Yrgj5kKEN1+CLg
        PlUzapvriM/3EPpd6DxW8/2Q+Lnxl1sveLDnNw7G5pkaNod4bicWjNB3QDGwZpigv1x+D02ZZ70
        Y/LcwS1GI/PRS3XMCDTQWqW7K3uq+1IMTDdsPKJHoUA==
X-Received: by 2002:a05:6e02:1445:b0:2c2:ea36:dcab with SMTP id p5-20020a056e02144500b002c2ea36dcabmr12631737ilo.200.1646683209809;
        Mon, 07 Mar 2022 12:00:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbeq+Fz7xNxAbYLluyLiyZsv49d7uCqaI9YqSyxJQyitO22Zue0ppVtoVt+VkT1pgMZIoG+w==
X-Received: by 2002:a05:6e02:1445:b0:2c2:ea36:dcab with SMTP id p5-20020a056e02144500b002c2ea36dcabmr12631715ilo.200.1646683209602;
        Mon, 07 Mar 2022 12:00:09 -0800 (PST)
Received: from localhost (c-71-196-238-11.hsd1.co.comcast.net. [71.196.238.11])
        by smtp.gmail.com with ESMTPSA id w6-20020a056e021c8600b002c602537ab9sm11255624ill.54.2022.03.07.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:00:05 -0800 (PST)
From:   dann frazier <dann.frazier@canonical.com>
To:     stable@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 2/3] sched/topology: Fix sched_domain_topology_level alloc in sched_init_numa()
Date:   Mon,  7 Mar 2022 12:59:40 -0700
Message-Id: <20220307195941.459076-3-dann.frazier@canonical.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307195941.459076-1-dann.frazier@canonical.com>
References: <20220307195941.459076-1-dann.frazier@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

commit 71e5f6644fb2f3304fcb310145ded234a37e7cc1 upstream.

Commit "sched/topology: Make sched_init_numa() use a set for the
deduplicating sort" allocates 'i + nr_levels (level)' instead of
'i + nr_levels + 1' sched_domain_topology_level.

This led to an Oops (on Arm64 juno with CONFIG_SCHED_DEBUG):

sched_init_domains
  build_sched_domains()
    __free_domain_allocs()
      __sdt_free() {
	...
        for_each_sd_topology(tl)
	  ...
          sd = *per_cpu_ptr(sdd->sd, j); <--
	  ...
      }

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Barry Song <song.bao.hua@hisilicon.com>
Link: https://lkml.kernel.org/r/6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0826f3f4920a..02e85cd233d4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1428,7 +1428,7 @@ void sched_init_numa(void)
 	/* Compute default topology size */
 	for (i = 0; sched_domain_topology[i].mask; i++);
 
-	tl = kzalloc((i + nr_levels) *
+	tl = kzalloc((i + nr_levels + 1) *
 			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
-- 
2.25.1

