Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72E589133
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiHCRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiHCRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:22:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BEC51421;
        Wed,  3 Aug 2022 10:22:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gj1so2206099pjb.0;
        Wed, 03 Aug 2022 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=rm9GxJHf4bMp41yMMJ7kHX0LNzG+Q8tVx0zjX0fL5Eg=;
        b=Q+y4N05F6bbrA0KTd1dyGcJCIJqVn7sRmV5SaPGauTQkvOrW8lcA1nzpq/Cnxtyten
         B+WTtQBhfxWMiIY9oD+v+Hv3yz+BgMc41r3ruHOBd4emBH1YkkVHLhkyNZ27Io6wmG1b
         kvqztKsDuYNfSI2qsQiYSV1OmEMziJqAql3pq7UMLCMKePIqDag6k1WgqX3lSf9BcACr
         54OyYAsmrzS92zZWS90j1oEKOd61FN3KxENQXcnnAVjORamMdsjKB7bFXJOczf1idzbY
         9Tut5EM5VdPAmX1rKNperE0sVDqZfCx/FSUo9jAMMd8AheD5tLphb43lbsDCDtHLbJUE
         cinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rm9GxJHf4bMp41yMMJ7kHX0LNzG+Q8tVx0zjX0fL5Eg=;
        b=oJvRynix1/KshLwkmXO//wlMZmZGWT4i3qB+JvnMhT3blii9FsOyOvW1gDApHCEMY1
         iGPrh7WZUBrWXFMnqIpITltQtx6pfvwV06Uf0AlfXess+9pPd8l5CKgl5GvqDq9B9BvL
         EZUV00JEA0eofRo3DV6sN9MMozhLXviSiNE+5PCC+Uc2aSFc483I9LLcEBQfiRARExsT
         XHJz/fSDf6dzOIuG217jXDTByyIQiWtj/xzu4AD65rXIHF2aiuZB4vuqtfgg1+aujonV
         cvYsoYelwTWB19OucaOuREMzhLkW5WTG4wtL7TjyIfvyC+dDE74ZI0QQ0bZpDtrPf7Mh
         mbgA==
X-Gm-Message-State: ACgBeo1H70umpA6aXNAfANfd/DVmhcsGOYhtgqH+jGRakmgHk0x0fR9Y
        alMWPbgnLquuocf3S207j+c=
X-Google-Smtp-Source: AA6agR6pXPAuirMDUgBbJXkQS1bmQjv10jiSXKUS29WnbnLBrvkAXU7IYSzphYn8d1V5pdrLO2khRQ==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id z4-20020a170902ccc400b001565d37b42fmr27186057ple.157.1659547349427;
        Wed, 03 Aug 2022 10:22:29 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a4bc500b001f239783e3dsm1857657pjl.34.2022.08.03.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:22:28 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Move hangcheck timer restart
Date:   Wed,  3 Aug 2022 10:23:01 -0700
Message-Id: <20220803172302.1976981-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Don't directly restart the hangcheck timer from the timer handler, but
instead start it after the recover_worker replays remaining jobs.

If the kthread is blocked for other reasons, there is no point to
immediately restart the timer.  Fixes a random symptom of the problem
fixed in the next patch.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fba85f894314..8f9c48eabf7d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -328,6 +328,7 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
 }
 
 static void retire_submits(struct msm_gpu *gpu);
+static void hangcheck_timer_reset(struct msm_gpu *gpu);
 
 static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
 {
@@ -420,6 +421,8 @@ static void recover_worker(struct kthread_work *work)
 	}
 
 	if (msm_gpu_active(gpu)) {
+		bool restart_hangcheck = false;
+
 		/* retire completed submits, plus the one that hung: */
 		retire_submits(gpu);
 
@@ -436,10 +439,15 @@ static void recover_worker(struct kthread_work *work)
 			unsigned long flags;
 
 			spin_lock_irqsave(&ring->submit_lock, flags);
-			list_for_each_entry(submit, &ring->submits, node)
+			list_for_each_entry(submit, &ring->submits, node) {
 				gpu->funcs->submit(gpu, submit);
+				restart_hangcheck = true;
+			}
 			spin_unlock_irqrestore(&ring->submit_lock, flags);
 		}
+
+		if (restart_hangcheck)
+			hangcheck_timer_reset(gpu);
 	}
 
 	mutex_unlock(&gpu->lock);
@@ -515,10 +523,6 @@ static void hangcheck_handler(struct timer_list *t)
 		kthread_queue_work(gpu->worker, &gpu->recover_work);
 	}
 
-	/* if still more pending work, reset the hangcheck timer: */
-	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
-		hangcheck_timer_reset(gpu);
-
 	/* workaround for missing irq: */
 	msm_gpu_retire(gpu);
 }
-- 
2.36.1

