Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D14F615A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiDFOJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiDFOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:08:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1E49E435
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:57:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso3976396pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=3qKR+9UnHfH7y3GmZazKtwO1JgDzyIRfNNCTfPUQzPQ=;
        b=T3HnXpLMVHF84AhdAnlosPkOaV9Jf1AjBveZ6piPcw9aDZW1oz4WzNV2VhuUNw/R2C
         J+zpHigYJ7kSTbrfi/JOJd/Ye1VvqmGmrrnv4r4BlvLI7X2At5ameEPt54Wou+JUQxrp
         ibuMUAdTv4PeAIClj6apPHezgvlvgWZzZv7mAA4vnm9EEeqx1QyTxrTI5RVOSI1jz65E
         a12ad43olBO8boyJ+XDOVKvfUeGq+qikcUCOeNeKotPR7Cdw1PGt5rTIZYF8LbiXXJxD
         jqV5SdO3xpqL9bxSS2rvIZUbIISbhzGKCFeogBLA4+pz90zogiw7/xDsQwBhe4kX5ZFQ
         cZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=3qKR+9UnHfH7y3GmZazKtwO1JgDzyIRfNNCTfPUQzPQ=;
        b=2OeQ46q7paymPBXfyy5kM9DD6bmjiTaYZQp4GiOs+e53eSQpFR6Cct8D/Dupc+Yms7
         /+kJeSzADnRnk1zFQPgXjYW5GZhwOyVQ+gcdEJJr1qzOpHYjuIyI9v7WUre64wSL4FOh
         7B0U2sQ1fxz1KsYd7uCmdu58QIbHfK4/auNgvPR49uY92Qp+Td9JfXq2PD4ziCCTpLrg
         0DnsLdM9t8lR5nCbUv5FU7M4yNq2kJUEzTsRStnPav9gtXcszq2RHuHwSSlUKaahubJg
         fR26tDo+BEKXYDbgdmppEefAF+eznb6sLsmG5vRhnyiG5bINBDGil8OKBNJEjASAPmes
         9o6A==
X-Gm-Message-State: AOAM532Y+/aTVIRaxmneBCl44Cgdd0yGGMJUogGTPU5ROz5smypTt5/5
        mnDPhb+SKnY2xovPGffg8Do=
X-Google-Smtp-Source: ABdhPJyaTfQXuOcyyB4tlk7RTPW0lnRDh830vmHgHzSF2CCzCjDUWDY2jx4oMSGO99Ww3z/x8GSojw==
X-Received: by 2002:a17:902:a588:b0:156:599c:6278 with SMTP id az8-20020a170902a58800b00156599c6278mr7641266plb.109.1649239029282;
        Wed, 06 Apr 2022 02:57:09 -0700 (PDT)
Received: from localhost.localdomain ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001c9ada2f28fsm5581497pjb.8.2022.04.06.02.57.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:57:08 -0700 (PDT)
From:   zgpeng <zgpeng.linux@gmail.com>
X-Google-Original-From: zgpeng <zgpeng@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Move calculate of avg_load to a better location
Date:   Wed,  6 Apr 2022 17:57:05 +0800
Message-Id: <1649239025-10010-1-git-send-email-zgpeng@tencent.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In calculate_imbalance function, when the value of local->avg_load is
greater than or equal to busiest->avg_load, the calculated sds->avg_load is
not used. So this calculation can be placed in a more appropriate position.

Signed-off-by: zgpeng <zgpeng@tencent.com>
Reviewed-by: Samuel Liao <samuelliao@tencent.com>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299..601f8bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9460,8 +9460,6 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		local->avg_load = (local->group_load * SCHED_CAPACITY_SCALE) /
 				  local->group_capacity;
 
-		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
-				sds->total_capacity;
 		/*
 		 * If the local group is more loaded than the selected
 		 * busiest group don't try to pull any tasks.
@@ -9470,6 +9468,9 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->imbalance = 0;
 			return;
 		}
+
+		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
+				sds->total_capacity;
 	}
 
 	/*
-- 
2.9.5

