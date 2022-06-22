Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D53556EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376482AbiFVWwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358800AbiFVWvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:47 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490084199E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:46 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cs6so22935352qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vd4a4Sb5uy4qMpkEMdY0l97I8Oa96Mx9jouj7Tqv17A=;
        b=m94cURFdCK6y/WgXeNVeJSsjpwtrlSDB3PxHYiJdPWnOgrL7pP1TMYNYz1W7b+MV+D
         o4mjJJIuJZdtP6EZIKXzc4DK8WuAV8kIBrLtnHGBvt0N/j4sCit/6477vompbS+f68Rl
         jrHVbbjKj6qyxBdoOzjlkNClgq4YCQxnGirjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vd4a4Sb5uy4qMpkEMdY0l97I8Oa96Mx9jouj7Tqv17A=;
        b=PKhypLLQDk1HnxebfLhea+VW9veoR5wdbH1QcMbAq9yGFHrEBza4BfOGhPtamRaJ+q
         OxqMaTKNcBVs7/CP08NEUI+vU5oIFCoYtZOvAaLYradMEDjDwcuF78lzNoF7yELSt9Tl
         8IWpiLNrWbGVsSjvDZveoRk8JARgAZA0/wXydNWIvE/IkwgW/15EU/6+XHWQBCYU05jX
         hb8gwFY7Pj32Ue6FSjBFlklT6ljPItU2Vw08PhLEExCG6sAP3xSKIAETg0ay6KLdk32u
         u5YrNMthze0nu9VxorNUZtTuo9hlNvpGY64ZGMyc1QzszsmWqHmYFusCZs8uyRYiLE9a
         Frcw==
X-Gm-Message-State: AJIora9g2bxYv/NWHm6pSs8/nJbnLDQoKjhrgcvWplWzO0bxogU/7/Ob
        A49SxDCC/nP41VFdJki34GDPBg==
X-Google-Smtp-Source: AGRyM1sVrXdFvKoX00v5/yoAGUyGmQGrFinrp1P16vG+Qt7RLn229XFOM58LGmehXc+yFXMyMumP1g==
X-Received: by 2002:a05:622a:148d:b0:305:1a61:1003 with SMTP id t13-20020a05622a148d00b003051a611003mr5335099qtx.269.1655938305958;
        Wed, 22 Jun 2022 15:51:45 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Date:   Wed, 22 Jun 2022 22:50:59 +0000
Message-Id: <20220622225102.2112026-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We notice that rcu_barrier() can take a really long time. It appears
that this can happen when all CBs are lazy and the timer does not fire
yet. So after flushing, nothing wakes up GP thread. This patch forces
GP thread to wake when bypass flushing happens, this fixes the
rcu_barrier() delays with lazy CBs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2f5da12811a5..b481f1ea57c0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -325,6 +325,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
 	rcu_nocb_bypass_unlock(rdp);
+
+	wake_nocb_gp(rdp, true);
 	return true;
 }
 
-- 
2.37.0.rc0.104.g0611611a94-goog

