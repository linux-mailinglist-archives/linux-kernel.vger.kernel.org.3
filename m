Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88A58CD3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiHHSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHHSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:00:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE4017A9A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:59:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so9918737pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=hxCHtD0gO8RvEjmMgvObKSgjhrVeOCskJfVgBY9P5Ys=;
        b=Po5YVO9LkStuglGPnIeU9tH1rUzpcRyw97vPaRamsdd1v2/Pgp9I+Jml094y16Mxk/
         +AHELcEaO50YPB4vRLMBP8rYzcvn93Sj4smgBuPV7//N2pcoOQSp75UOHGACTW+mfGOu
         1NU8Ol0wM+seyb3tMto2MguuaNUPUptyEsz1Vz9Grueo0hNFzE4+GvGRfpYTId1PH9Mq
         5PyryyPu7j1sH1+mEdy8vNibt1N7syRUJPtjrHC8rg/rtenGx1oI4UqIhtMEH0yyc26G
         fXjbsY2uIMSEyt3nr+FI+F0R1z8s8oaw+bpDQUmi18+8towG7PuakbowRC3a1qyIHa4Q
         ywWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=hxCHtD0gO8RvEjmMgvObKSgjhrVeOCskJfVgBY9P5Ys=;
        b=FS9y2eCuwbD9cHrN2/dJy2GiMuD1tpkrersmzwgxcSYS8wUjnxGKBgcFgigmH2fF3A
         CCbGygjkceO2FrGXWEjV86uiU4U96asWLtjaly/JjgAEQW/gt731SP+OUAECbUwTiSHP
         1ugIb9EVPqyPWgCgV3yzy74vwwZ/HRZ//0ptIk28iyfaD4HXapqWuT24jDEEg8oiQyS0
         euQ8/H4XntsflQ3cpyJB2wvQXyfJIpDuPTyl0Cmy2i458UYdvr29c3nezfiVhzEN50EX
         H9lAvCNb/TK79qvzpmaj3Wi3H7CRCvbM90fW9NJyVTbMi+mEWGv3gv3dJzOi0bUcux8t
         M6eA==
X-Gm-Message-State: ACgBeo1T9T9HPFcpRYS2r261TTDduSOrCtAtSw3qRvA0jnjtWrHxIw+w
        td8528cld4r4WoBIuGupozo=
X-Google-Smtp-Source: AA6agR52Hgyr/dKBRgfulVzs791jG32bTrE+okm/YW2FDnflpQiZQwA2EqLUVsSSTo5b3qsSBWAMyg==
X-Received: by 2002:a17:902:ccc9:b0:16c:f878:163 with SMTP id z9-20020a170902ccc900b0016cf8780163mr19195293ple.170.1659981598507;
        Mon, 08 Aug 2022 10:59:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:4d4b:1a9e:22cf:3f7e])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b00170a6722c79sm3112587pln.247.2022.08.08.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:59:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] locking: Add __lockfunc to slow path functions
Date:   Mon,  8 Aug 2022 10:59:56 -0700
Message-Id: <20220808175956.592707-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we can skip the functions in the perf lock contention and other
places like /proc/PID/wchan.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/locking/qrwlock.c   | 4 ++--
 kernel/locking/qspinlock.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 2e1600906c9f..d2ef312a8611 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -18,7 +18,7 @@
  * queued_read_lock_slowpath - acquire read lock of a queued rwlock
  * @lock: Pointer to queued rwlock structure
  */
-void queued_read_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
 {
 	/*
 	 * Readers come here when they cannot get the lock without waiting
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  * queued_write_lock_slowpath - acquire write lock of a queued rwlock
  * @lock : Pointer to queued rwlock structure
  */
-void queued_write_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	int cnts;
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 65a9a10caa6f..2b23378775fe 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
-- 
2.37.1.559.g78731f0fdb-goog

