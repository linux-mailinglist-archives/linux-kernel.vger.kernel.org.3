Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221B04EB5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiC2W2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiC2W2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:28:21 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6380F18D9A6;
        Tue, 29 Mar 2022 15:26:37 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id p25so15299648qkj.10;
        Tue, 29 Mar 2022 15:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3foGavVNwfbREiKmr8AbNd4bifzDoligkt5atunexc=;
        b=J1ALKYPb4gnohsP4AJkNNz0pE2Y7AB9omrosmGi1KjZ8Z5FPTCDjAwtAaRfKeDCVH3
         goDKd55ZIr3Bg5ARTzrP4GkudWn+D0To+1PnXttK3+H4lLmNprgyCBG3819raKODpRod
         aFqDJ/o/j5PWEUsuLztSyDXFqdEO8YruMPol9pajrEDKAGBtZbs0nG7eHavjkM+MftZh
         yc+zxyTu/OSwwh2vZCfw+GNMlJQY6jZljA5NIyblYl5S5tSBXArjpjSqdth7t9Uxn63F
         pq8299TFZGTPPZ9+jrugSP/EiT8n90vCiQRPumHaSzOCy19X3Trtmg+rKyllU/GuYYTM
         1ncg==
X-Gm-Message-State: AOAM5312Put3DvhTiYAV1Jyw13Y4O4zQ/urhhIwo8VuEE4/Jz2zell+U
        QTJc6+b1Z3KYzc3SieM4+Oo=
X-Google-Smtp-Source: ABdhPJx6vBYBzYBY5PYN3s/bKFLNClcQvdisQY9+ZzrlmCGx1ilSLJpdGJ5aJ12Hrp9UY8lkCB/WzA==
X-Received: by 2002:a37:a54b:0:b0:67b:309c:e9e1 with SMTP id o72-20020a37a54b000000b0067b309ce9e1mr22707924qke.178.1648592796253;
        Tue, 29 Mar 2022 15:26:36 -0700 (PDT)
Received: from localhost (fwdproxy-ash-008.fbsv.net. [2a03:2880:20ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87f45000000b002e125ef0ba3sm16026890qtk.82.2022.03.29.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:26:35 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        rostedt@goodmis.org
Subject: [PATCH] rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior
Date:   Tue, 29 Mar 2022 15:26:13 -0700
Message-Id: <20220329222612.1001586-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_sync_enter() is an rcu_sync API used by updaters which forces RCU
readers (e.g. percpu-rwsem) to take a slow-path during an update. It does
this by setting the gp_state of the rcu_sync object to GP_ENTER (i.e. > 0).
In this state, readers will take a "slow path", such as having percpu-rwsem
readers wait on a semaphore rather than just incrementing a reader count.
When the updater has completed their work, they must invoke rcu_sync_exit()
to signal to readers that they may again take their fastpaths.

rcu_sync_enter() currently has a comment that stipulates that a later call
to rcu_sync_exit() (by an updater) will re-enable reader "slowpaths". This
patch corrects the comment to properly reflect that rcu_sync_exit()
re-enables reader fastpaths.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 33d896d85902..5cefc702158f 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -111,7 +111,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
  * a slowpath during the update.  After this function returns, all
  * subsequent calls to rcu_sync_is_idle() will return false, which
  * tells readers to stay off their fastpaths.  A later call to
- * rcu_sync_exit() re-enables reader slowpaths.
+ * rcu_sync_exit() re-enables reader fastpaths.
  *
  * When called in isolation, rcu_sync_enter() must wait for a grace
  * period, however, closely spaced calls to rcu_sync_enter() can
-- 
2.30.2

