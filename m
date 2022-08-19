Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5059A724
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbiHSUt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351662AbiHSUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C5BE4C8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y18so4222842qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F8eqajEJ1oxnqHr7+lKrv0iQaE0C9fuKhV4+YpdptQc=;
        b=thJJdMHDttiQHWHA9YMQ6t8JnYuDXswlIU6Fd+r+vPkOe/Ek1KbSL/8SQcoZu2Q1dm
         a6l64ZImF9AQuS+8r2YgWRnXA993zdsdBeTloskJo8YE3oISzmLAx3TnSZz5CXa4vi2n
         6l+d+3Ebcjv72aP2LdFQGNu2iIZgKzSg77Fq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F8eqajEJ1oxnqHr7+lKrv0iQaE0C9fuKhV4+YpdptQc=;
        b=45gWJxeuVDlw28f0eJzHku+4/1vTG5ErUpkS0GV5kx79BrRitynuyaaNx4jdIsQZCX
         UV3gjPZwj8KxNbnjkPPt9oyEwV0K/XtpbtQ45Iuc+5wDiL9O7X1q0r6LeFGarei7Q14C
         rPUNjsSl/G19FMC6JjhqWkuGbhfbTUg0SXlDjEYgH1Pjf89ZJ1zulwB/XPSka2OyY3Oe
         mDAgVhoRjwbTvzGWdiUgCltOwCu1OeC/LRNN1obPRMt7ZROoFhY2xBXQADq93f2APdXV
         /wPbU3YHix49KUvxEXWA2dL3J36BqaVp6wPdBXkwQIM5j4l5ecwY1weHsp+JquzYYFs5
         sllw==
X-Gm-Message-State: ACgBeo36kAcwvR8so8dYwHOyLxb4e1MZsXVw64vP7kLGpOvZM8LO2TZY
        CHP0BD814T/4RLnMIF1Sc7AvoQJK6buK3w==
X-Google-Smtp-Source: AA6agR4uPFXBKcvKDD94qylED1tqBj5WVVD6PD6c49FLD/T+dqSi7r/B+UGnudkd1B7IAJicQq6Yxg==
X-Received: by 2002:a05:622a:1048:b0:344:9494:3617 with SMTP id f8-20020a05622a104800b0034494943617mr6809664qte.143.1660942152841;
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
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
Subject: [PATCH v4 12/14] i915: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:55 +0000
Message-Id: <20220819204857.3066329-13-joel@joelfernandes.org>
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

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 06b1b188ce5a..74f4b6e707c2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -343,7 +343,7 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
 		__i915_gem_free_object(obj);
 
 		/* But keep the pointer alive for RCU-protected lookups */
-		call_rcu(&obj->rcu, __i915_gem_free_object_rcu);
+		call_rcu_lazy(&obj->rcu, __i915_gem_free_object_rcu);
 		cond_resched();
 	}
 }
-- 
2.37.2.609.g9ff673ca1a-goog

