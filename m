Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A685AA2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiIAWSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiIAWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074F58091
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l5so238841qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8tBDdZaeoT3b5CBzqvW/ZB2aZTVcUlmvdmlRm1sAyM4=;
        b=QBkSAea3WwRWmhiRWRuvpOfEw+FTTLufqMSEdc1gAtyAq+xBunox+Nuh8C6IUqQDo1
         +LxFhVcyiQIx4jvB2azfPR7AmGcN5zZvubRtp5adhPS46cT5+VACoX35Em9rNj9ukK+M
         L11Wz8mOl+0mNcbPFv1bMoPDD7RhIAz59Gntw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8tBDdZaeoT3b5CBzqvW/ZB2aZTVcUlmvdmlRm1sAyM4=;
        b=tibIpqqbxmT2x6BuQQK1w54RI93xQjWD/EZSBoX8EmbEOVeRyVMzZkBMQSNbBrZeg5
         dGhdZTPk+TkUs/5tlw4iK33GxQXGFegz4DSiGoI9bisVixAZt12K95i07qiynJmG4L/I
         2BX1IIbPwmy6YpnLPCMH68iHAJrEWrbR9dZeWhycD9EYWabK5ua6knEHSP58QbFiyIf+
         8AJkf2TeKEMou9jhCpZi4ZTflvLGhDy2PmjgHv6lpGBUZD9S1s9Yvnw4wxmGp/RiRiRV
         y34tPepGSiyKafsRByvk6SzI2Hut8wrDG7UxILxARb7UTkT0Cj061UGznewUp1DzOmXi
         /xrg==
X-Gm-Message-State: ACgBeo2fNhQ2262CYFWGr9CNO6+7iPNXh9x4B0fGOc6WgUXwiz3Ex3Cd
        bhmx5PZ0M70XD79uhgOmzNELI+M9Ma1oFw==
X-Google-Smtp-Source: AA6agR4RLjnlk0HhdTMZyE6uJDeBeCmArIKBraVqa1sV/k/4xV1xpnGzfyzL2EqEG8NqbDqWrq33bg==
X-Received: by 2002:a05:622a:649:b0:343:7b74:5cd1 with SMTP id a9-20020a05622a064900b003437b745cd1mr26095535qtb.407.1662070680221;
        Thu, 01 Sep 2022 15:18:00 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist happens
Date:   Thu,  1 Sep 2022 22:17:06 +0000
Message-Id: <20220901221720.1105021-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
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

When the bypass cblist gets too big or its timeout has occurred, it is
flushed into the main cblist. However, the bypass timer is still running
and the behavior is that it would eventually expire and wake the GP
thread.

Since we are going to use the bypass cblist for lazy CBs, do the wakeup
soon as the flush happens. Otherwise, the lazy-timer will go off much
later and the now-non-lazy cblist CBs can get stranded for the duration
of the timer.

This is a good thing to do anyway (regardless of this series), since it
makes the behavior consistent with behavior of other code paths where queueing
something into the ->cblist makes the GP kthread in a non-sleeping state
quickly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..31068dd31315 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the ->cblist.
+		// However, the bypass timer might still be running. Wakeup the
+		// GP thread by calling a helper with was_all_done set so that
+		// wake up happens (needed if main CB list was empty before).
+		__call_rcu_nocb_wake(rdp, true, flags)
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.37.2.789.g6183377224-goog

