Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210925658D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiGDOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiGDOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7EDE9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 145so9074859pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLW2WGrfQ+doVQUh0tyNSCbcxWX6xMHulu7+fCXRtVo=;
        b=ZuwmvAD45+wZDM3dtZpxq7LZCjkFamhBYDnZJYSDO7ZdrXvAI65ppdF25k0P2CcK2j
         7O9WWzwoomQL7M3D9mjSp3BiQLJpRYg6cPPuM/C5539DROqrFDQ0aQgDHRz8FNWj5GR2
         +pF+para3eTvzPxsqSVdcNQC1Gia5sz5DB9M5VSuMi4HoIAyeB5tzJmMxom0SRUjVvSw
         HAnOzgxYHOCKPk399VLcP2bRn60d0wr/c6yS6ZQMcyroMW8QBLeJdjc3YUJvW27nP6dF
         SPB9MaRZe7mBcOFsXAZx9UMLrY+WR2EjT631DcEinbji3qEDf50cIjZGvOml2VABe5iS
         2IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLW2WGrfQ+doVQUh0tyNSCbcxWX6xMHulu7+fCXRtVo=;
        b=ZAji8QG8XKW/m41xPwtxPs9RKkZuhoqpMA677rLShDPolg7agUKpMM/VF+OH9PrDh5
         BefufV3rJDXcEgBHUhGoUB3ROt3WF29+1BGoKfBtMR9274gmW0aUstrcNteGPFelDjxU
         uSTxWYpYQu3cyfh4R32S6RONVBCLzbxyX0zdXVTi7zdo5MHN1l0RodXULcGqTIl7UWSC
         pQrfwOalMOKKH816/6ElxOENLJ+86HEAwOKPzvlTxLSkriDnrup4PJmcisXSJ65VM1CW
         hCiwq9RWfJDgTkePthobH3tH+NtRGJ9g1MYtCb3o3GOYCJvBRwrhYqdYZdPfO59dKzuW
         AiKA==
X-Gm-Message-State: AJIora/59n8SRoRqot2ejgPoH0lCHVE2mAzkXdfKVQr5EJSz2Mrgp7Hd
        nGgBe5HxUjGPgazhurUGYlE=
X-Google-Smtp-Source: AGRyM1u+1lQNYQetil64G1gF6mIS/beTLZhsEjukcaF81n5cqkdmrpDxLlKNapApZstM6OS0vxZCOA==
X-Received: by 2002:a63:90c1:0:b0:40d:3be3:5609 with SMTP id a184-20020a6390c1000000b0040d3be35609mr25018499pge.421.1656945549245;
        Mon, 04 Jul 2022 07:39:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:08 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] locking/qspinlock: Use queued_spin_trylock in pv_hybrid_queued_unfair_trylock
Date:   Tue,  5 Jul 2022 00:38:18 +1000
Message-Id: <20220704143820.3071004-12-npiggin@gmail.com>
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

Rather than open-code it as necessitated by the old function-renaming
code generation that rendered queued_spin_trylock unavailable to use
here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cef0ca7d94e1..9db168753124 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -357,7 +357,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
 		int val = atomic_read(&lock->val);
 
 		if (!(val & _Q_LOCKED_PENDING_MASK) &&
-		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
+				queued_spin_trylock(lock)) {
 			lockevent_inc(pv_lock_stealing);
 			return true;
 		}
-- 
2.35.1

