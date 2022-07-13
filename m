Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A1572ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGMHIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiGMHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:08:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46377E1925
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so2244758pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkGCZt24/wM/viMu6gJ/6hAx3oCXgMtSYE11mElSvVY=;
        b=BNn49egqVlLLnQFFlawyOMHUv7VlexlZy3atxaH2y6tB+YWZkjWCFTL6SA0j/4q4Ve
         oQNkHqzZbeYjrY4Y3lNjzlrBJxWoT6E5PGyd0osFQgQQw0PbZfMDU56swh1zOFnRW7YW
         RmABL9KxdFk/FRIk8G+OydUgOlgxwuQTWmrhKcFPyFG229pJPtgBhpwsMgRmwL1IZtW3
         cpmj2vKnlllS44kw50D+xhtG8uM5ogpJOGM46NJFXE0iy7g6xLZl8Q7AnSX8FOnfYmdw
         hMYuLWqj6Zj/8rWIiqhawavc0sFgIuNQsiFlDw/cvDc6k2LpaUTPnWbxfGAw+pACexfB
         goIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkGCZt24/wM/viMu6gJ/6hAx3oCXgMtSYE11mElSvVY=;
        b=SNE6/9HstwPuBzphbFkZGCGi1ws4rAUs1J2VSL7w3V45xO9/mVpH1EcPkwDGwUAGVk
         +JmNNv2s1IjQx1Wxde4xlTbzK4+06rsKwXAOqz1vQ2GgTZeWol/iDSEJfSsIaWPe7AhK
         is/apgxuSKmC/NCPhfExqouepsuPlCOBqHgyM0XqA0yyElwvO0T5uQcP5RSl/7G9mNy6
         Ygl1gohJprAaTVBjSxkEkVrHtuBjpUrXGKyLvXErQOvp+a/ANSxIjbSaiN7xSHrKGEYy
         Ycml/MJWhUrs1P51c/3JsIUnGvlFsuNMPlP3D4e/uJa33RfX5lyUX1w2BPqYSAJV3qwi
         OjpA==
X-Gm-Message-State: AJIora94ObTMfo+EHEOblP2WGSeZvbdct/1AqPTFhlbGJVUoQ+IcyDtW
        qJWt+74S0rvm+X41FMLaBRk=
X-Google-Smtp-Source: AGRyM1upUIcpNOC2xFkUOzlCnjteo/Jph0OGSqNgdYn+pxj4Vk9L2GVp2BLSeIAqjFFS/RnUkhOgOg==
X-Received: by 2002:a17:90a:4809:b0:1f0:59d7:7ee2 with SMTP id a9-20020a17090a480900b001f059d77ee2mr2271401pjh.240.1657696069824;
        Wed, 13 Jul 2022 00:07:49 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:49 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/12] locking/qspinlock: paravirt use simple trylock in case idx overflows
Date:   Wed, 13 Jul 2022 17:07:02 +1000
Message-Id: <20220713070704.308394-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713070704.308394-1-npiggin@gmail.com>
References: <20220713070704.308394-1-npiggin@gmail.com>
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

The mcs node overflow fallback locking case does not have to use
pv_hybrid_queued_unfair_trylock as the trylock, which reduces the
differences between pv and !pv cases.

This was likely an artifact of function renaming making it use the pv
trylock, which is not a bug but it is unexpected.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/qspinlock.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index df6d8af8f2a9..2ebb946a6b80 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -800,13 +800,8 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		if (paravirt) {
-			while (!pv_hybrid_queued_unfair_trylock(lock))
-				cpu_relax();
-		} else {
-			while (!queued_spin_trylock(lock))
-				cpu_relax();
-		}
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
 		goto release;
 	}
 
-- 
2.35.1

