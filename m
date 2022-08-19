Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052259A720
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbiHSUuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351684AbiHSUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93712BFABF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y18so4222854qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eOVP7uxcuakWCkD5+BqZt5+xcwwCNJthr/gxNxOlHcg=;
        b=TbqfUYYOBRlQM1AsIY4GgE+2GpQ/GkZpdyKoO5F732/uJp6Il9dKitV7sHVM1cA9rC
         RRFRRBgNtpaHAmgnmmdaHwkZAVJ47CrSC6J+Z5mx1DKVwYKo7bCgePitrBl0iQ1ONj5z
         kVNnqB403PU8vOH/tLiG3e5URPaaC2NwHeDgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eOVP7uxcuakWCkD5+BqZt5+xcwwCNJthr/gxNxOlHcg=;
        b=Gsq0Nxqc/CFbNCnJiORrmoUl6w1bj9kjgF1a5fDNsE1jC2Qzfhn1qCNaXbcIUxyMY8
         2d9E4DX+9YaKjAIRRKUbTpfaVW+dveK38wiW1AUv7CpIYSdaAQsN/013eElXYS0ha1+S
         M5cBxClWtclR69JQr/4yc5KgpGoVIpZIObJF5gVyIcn86dsz8Df4D2wSWvTOymVvDdFx
         bHIt3cgCaC8Y6U43hIeg9I0ylyFaJ2xLXGCaAkFb5X4zAzdDCiU81tac5T3v1Eb6Y4rF
         dkKew2pAr4JzXC7870sDwP387DTxNI6JxT4Hex4shaVhUmg27JVn+f31n9FIbDS9qnWf
         UMZQ==
X-Gm-Message-State: ACgBeo1c5Gp6lU07/8lWxNvK1jj+vrk6BzyKyaCIAlCFpCq8Wop/+aVo
        R9pXNhX77My1KlzWr1d2JTdv+XKwct4OWw==
X-Google-Smtp-Source: AA6agR4jfVHEKJ7HKI1Pca8LM6+bM5tC6NBQKXVudmLfwSZfaIKrw8QW130ggamnP9whdSSpTKpeRA==
X-Received: by 2002:ac8:5889:0:b0:344:57e5:dc54 with SMTP id t9-20020ac85889000000b0034457e5dc54mr8038436qta.465.1660942153560;
        Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:13 -0700 (PDT)
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
Subject: [PATCH v4 13/14] fork: Move thread_stack_free_rcu to call_rcu_lazy
Date:   Fri, 19 Aug 2022 20:48:56 +0000
Message-Id: <20220819204857.3066329-14-joel@joelfernandes.org>
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
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c9a2e19d67e5..a4535cf5446f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -227,7 +227,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 	struct vm_stack *vm_stack = tsk->stack;
 
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
-	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+	call_rcu_lazy(&vm_stack->rcu, thread_stack_free_rcu);
 }
 
 static int free_vm_stack_cache(unsigned int cpu)
@@ -354,7 +354,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 {
 	struct rcu_head *rh = tsk->stack;
 
-	call_rcu(rh, thread_stack_free_rcu);
+	call_rcu_lazy(rh, thread_stack_free_rcu);
 }
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
@@ -389,7 +389,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 {
 	struct rcu_head *rh = tsk->stack;
 
-	call_rcu(rh, thread_stack_free_rcu);
+	call_rcu_lazy(rh, thread_stack_free_rcu);
 }
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
-- 
2.37.2.609.g9ff673ca1a-goog

