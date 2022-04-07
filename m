Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31F94F7D14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiDGKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244503AbiDGKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:36:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0018A7A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:34:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so4506461plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujLNXWvcoTkgsry9MTgtB72dmND/1PFu6sESLiS4+5Q=;
        b=IRSMB39q0CkKZ7RhIs/Puw/gDrCfZqc84S2LziFCQ2v31cXA038xuV2TnDuQwdTqtX
         oQP68wBFvqS0P67Wu65Z1ImXWFUJ5J5ZmMDfviT2s2FvkOXcaaRb68QMHqSwDC9mHzXp
         bZfCENUVcTaBnAzz4hEQbHsNxqap60kTK+AMSq9SR1uBOqhBPoVbu1L7cUHTbQw4s+g8
         Jm8KHgQHc5pS6caVI17xlHNuxOkF9d5Fmxqg/T7252I14hURjFA9vGMAYyZX1ERKOHHp
         AiHo3lBLT7yjAoYjQB2YZsRZCCDvQL2A1MnEJlHEC38o9O8oV4kD+NuoA+1joxlTgFx2
         nrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujLNXWvcoTkgsry9MTgtB72dmND/1PFu6sESLiS4+5Q=;
        b=Z2e0laXKlUDa/jZg5tolT/v43GBApi3cxCssA3FtpkGKrETReA+8vSkN1omMYwnWqy
         iTNAvkCfk0Gygmgc20liqsI3L+aszttV2P2DwIz3QtY7GIaagAYu6c7BDvMhwNZzcDPO
         FEIbnelskKlL4/9zoHu/p2z/3zkB3XkRJAVPrAkyBqUeBVps6+QfrcGUq64c6nv5isIX
         aD9R+fnG8CChothlae6DylpN9tU7MdgvrEAy1/J4grkE/jq0VYoalP+0jidjIZhdFwQE
         DLbga9H8wQh4IcVwvQEaE35saYVylsVPWjGPA0g90L5D9m9xOVeuphtYrC4n5fkl5Wi9
         MpeQ==
X-Gm-Message-State: AOAM530KCwm3dcGSJjfUy/Wi0iTQX9iZaEoy7KqiFG4z/3nAx27/Bee+
        nWNXPaGKRAzv0TFOVPNQX872vA==
X-Google-Smtp-Source: ABdhPJwoETx1Gs+umqB0Nk2NhJr5PIpA6CfK0Uc2IZapKwxyVzkhpH2VfsDLbd7RH2LZx2NVXkGLMA==
X-Received: by 2002:a17:902:f2d3:b0:156:a551:fba3 with SMTP id h19-20020a170902f2d300b00156a551fba3mr13033984plc.64.1649327644604;
        Thu, 07 Apr 2022 03:34:04 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a0022c400b004fb2292cd74sm22601362pfj.206.2022.04.07.03.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:34:04 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put() completes
Date:   Thu,  7 Apr 2022 18:33:35 +0800
Message-Id: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
before calling percpu_ref_put(), which will cause the value of
percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
returns.

	CPU0				CPU1

percpu_ref_switch_to_atomic_sync(&ref)
--> percpu_ref_switch_to_atomic(&ref)
    --> percpu_ref_get(ref);	/* put after confirmation */
	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);

					percpu_ref_switch_to_atomic_rcu
					--> percpu_ref_call_confirm_rcu
					    --> data->confirm_switch = NULL;
						wake_up_all(&percpu_ref_switch_waitq);

    /* here waiting to wake up */
    wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
						(A)percpu_ref_put(ref);
/* The value of &ref is unstable! */
percpu_ref_is_zero(&ref)
						(B)percpu_ref_put(ref);

As shown above, assuming that the counts on each cpu add up to 0 before
calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
to atomic mode, percpu_ref_is_zero() can return true. But actually it will
return different values in the two cases of A and B, which is not what
we expected.

Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
just to ensure that the conversion to atomic mode is completed, but it
should not return with an extra reference count.

Calling wake_up_all() after percpu_ref_put() ensures that the value of
percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
So just do it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index af9302141bcf..b11b4152c8cd 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -154,13 +154,14 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 
 	data->confirm_switch(ref);
 	data->confirm_switch = NULL;
-	wake_up_all(&percpu_ref_switch_waitq);
 
 	if (!data->allow_reinit)
 		__percpu_ref_exit(ref);
 
 	/* drop ref from percpu_ref_switch_to_atomic() */
 	percpu_ref_put(ref);
+
+	wake_up_all(&percpu_ref_switch_waitq);
 }
 
 static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
-- 
2.20.1

