Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1518059A728
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351982AbiHSUuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351704AbiHSUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72677BFC7E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j17so4210481qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6M/kEQXI6tA+u5+q0q3BfPnsnjCNXvNhf8n1k8Caals=;
        b=G4RH/9CKm7jJBfWPa3xTDK0qYze8HQ31EQsg72UX6wDKbasiRRCXhvuugbCwbLm31P
         5TGYIRvZ06nuvqEvU0IRARdrxjuSNS1BbQ/ZZrrV3Jm4MJxp/6fa30p/OFvXnu5mRbSo
         aOHwkSMPTBQ0nsadszNSKzfIkSPtFP8lxf7mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6M/kEQXI6tA+u5+q0q3BfPnsnjCNXvNhf8n1k8Caals=;
        b=Nw4AU8oNfKMkyIk3kTbGe1DJL/zAArjlX1bLOGjm07terXwyGXw1Pwth433m4Dazng
         /WBG2FoWdLRHd35n9RqR7SpNuJutAx3OySkP+MJtYtMWJ40Pk3wSxXWVNBGzoemC2TZT
         jZFa5AokVGK0jkijY5gi7TH3JvCG91uExiVyNSePEjnbIy+u427oI7nZYJ5fvGSmyRbs
         EBKeCwaqeqavHQLXwKW3ZrRNs0kATuq9z/dwyo2EK5BaybbTGvuee8XN2OEnClUNAeBN
         61wXxDKAeBLwIab+smfuowe3QDYlYYcZ6h2hqhCvUk8AZKkir3iiRB12IlPU9ad2FpA3
         X47Q==
X-Gm-Message-State: ACgBeo0k1ssg49y5dOiCAj7bp3d9+k7+5UbWLRhgeAociHWnfBBn0ZGD
        /hPZy72Nn4aBbrKPqtu7gvanZviVKceF1g==
X-Google-Smtp-Source: AA6agR5WaU1OuwtlNb5E8x5UWuI4aQIOzMrkS+bdJ4qsVwxVLpQSeA2Msl6wE+7uTnDjr6siJ+hX/Q==
X-Received: by 2002:ac8:5f0d:0:b0:343:6e79:f1a2 with SMTP id x13-20020ac85f0d000000b003436e79f1a2mr7981121qta.657.1660942154287;
        Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 14/14] rcu/tree: Move trace_rcu_callback() before bypassing
Date:   Fri, 19 Aug 2022 20:48:57 +0000
Message-Id: <20220819204857.3066329-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If any CB is queued into the bypass list, then trace_rcu_callback() does
not show it. This makes it not clear when a callback was actually
queued, as you only end up getting a trace_rcu_invoke_callback() trace.
Fix it by moving trace_rcu_callback() before trace_rcu_nocb_try_bypass().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 67026382dc21..6e14f0257669 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3101,10 +3101,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
@@ -3113,6 +3110,11 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+		return; // Enqueued onto ->nocb_bypass, so just leave.
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
 	/* Go handle any RCU core processing required. */
-- 
2.37.2.609.g9ff673ca1a-goog

