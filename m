Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932B5658D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiGDOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiGDOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC68DF1D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so9112984pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3vZsiiHeLdWlriZeHfJHXGRio5cCE6j1rfnsSoRqsw=;
        b=kHaopAihyE/nO3+lgLXeoOf+vHGg+EnpfYQEIqMtVAgok67vFg7RkZFX5AurqesDmd
         Va/7byZR7sPYp8k6miFOW3N8wSbxVWAD3s09CECDgXjF649bgie+9Sf4pWomXlHzDPcg
         hxIN2mpdlwFfinWQyv1NIAO7brvnHW10AqdDnSoS9Gq9yrvcRUE7FrD0UA1EEJagcM3Y
         1jLvs0fitrTHXYeq82/awdHX836trFf9XaN48SqpFYeU7w6hHcyT0T1U40k5Duu/UXl9
         FO0BwuuYYLuloQsbSUncZCz4+Rn6jJgosrBvooEn136CBYKAtd5Ggeh9Ghg2IBv0tzeo
         M82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3vZsiiHeLdWlriZeHfJHXGRio5cCE6j1rfnsSoRqsw=;
        b=jypzjSecoLbGuIs9oD+ePJ6R2jLDiAKKFe7QAAeSJw82pdmmWCm9gYPbd9KvVYpyLb
         17uTCwhYnOaUrT284b3elc3tA1umx0VN32tqbrv+H4Firn6Chu2zrANq4wcHSfJLCJNE
         OVhRKqd0+QA0lGJjM47zkN35NPMpuO6NOWVH2At/EBylPWBHSc1ZLD9bei20tSV8M2jU
         8dLb4sZ8m37Wknolc74/WtfzCSXlFzSQQZ2U//XS3T5IO8kga/4B4SG//wni1iLx9MZm
         U30vJKU49YmtUmJkPMu01uz+Gsu9QGkOY5aKwM81Ucw42MQ9wxwDZUSK44Ll3fmYQbVw
         KBVw==
X-Gm-Message-State: AJIora+WbVfiLWUUkMS5vFINsWH/nTA1bmSsQ9LUhkphX3DSD0gQMx6E
        cArKa/fEfE2HmZsOgyis3sOrN+OLs/4=
X-Google-Smtp-Source: AGRyM1tGv39z6d1FCO96hMCb97W+vTPVOrGKw/EqQYXSN6tTY/EMQsWHdDI6HjPBMUBU5xJzZAr/FA==
X-Received: by 2002:a63:2c89:0:b0:411:66bf:9efc with SMTP id s131-20020a632c89000000b0041166bf9efcmr25069380pgs.589.1656945552669;
        Mon, 04 Jul 2022 07:39:12 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:12 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] locking/qspinlock: separate pv_wait_node from the non-paravirt path
Date:   Tue,  5 Jul 2022 00:38:19 +1000
Message-Id: <20220704143820.3071004-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pv_wait_node waits until node->locked is non-zero, no need for the
pv case to wait again by also executing the !pv code path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 9db168753124..19e2f286be0a 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -862,10 +862,11 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool parav
 		/* Link @node into the waitqueue. */
 		WRITE_ONCE(prev->next, node);
 
+		/* Wait for mcs node lock to be released */
 		if (paravirt)
 			pv_wait_node(node, prev);
-		/* Wait for mcs node lock to be released */
-		smp_cond_load_acquire(&node->locked, VAL);
+		else
+			smp_cond_load_acquire(&node->locked, VAL);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
-- 
2.35.1

