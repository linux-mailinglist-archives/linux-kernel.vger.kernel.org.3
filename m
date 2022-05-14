Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382A526FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiENHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiENHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 03:52:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36866A1B1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:52:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so9758678pji.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9kAA0uCEYwZFDz59hPllk4M4/jt+7xzfL8ut7F5jG6Q=;
        b=i8f3tAxBvaDfFYiDPd/kfXBTvmRLxSQjGJwGgd5Lla/1qNwGm2bvlqEn8+j5k4OyEY
         Ys0QQQ+aUww+WnvB3a4WEcH/rBiotPA6kXy4PZnHQbuvi8QNQ6EophHw03VlSHuqfYYT
         RL9314D8x5C5lBSGjf+JJ1XrJ+WzLviQuzh7jvANHHGJH9Tu6Ep4/mJ6JD54Oiv4jMun
         Fwv+HC5Vo/D9pV+8xZg6/FAsQCaqVLKpTIPcdX1lKLPBeFz44pd1FlRq9dmThQBcFVvc
         /Gr3DVI/RrZ8xWlEKVI86S7SFzIrjkJ9R9nQLFYlQ5lYBsRLIMVw/p0t0NKNuETI6Dxp
         85xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9kAA0uCEYwZFDz59hPllk4M4/jt+7xzfL8ut7F5jG6Q=;
        b=SHORAHIocXtGkLQLNRaKDddOlC0DVVvtDdgjfqV91czyFWQsjx7flSDKtQHCGrBnDY
         Y4sG0W0SJB6P1bu28a7MimnATcJijRjgYKOBUXNj7fqiDg3PGjT5D7SR/F2jjiNomX5m
         o71d1JvJMd8Ebo/qJPL9g6olxkzNpxiRxfH/i07uBc0RsR+uvk8Ec096sJIRD7F45xeh
         N0RyEnbrFqJvR8TMbpDcu7AwWehgRzdCMisbSWjKxHag8oCp/Krc7woV8fW1C3rcVZ1B
         iMNarQ5Hh0WCPMf14S8Kvygy+iDeFX8XxfSLbr+1i044Trt4Cn6dT95aJp7vfApepaVI
         xwiQ==
X-Gm-Message-State: AOAM533t2yNFEzde4WTkjOneHNCe7QAGDMpvATNfm5hHg+IVif063XDT
        /r0VfhUyppt+hSXJSyYIwtM=
X-Google-Smtp-Source: ABdhPJwALc97+Ztc4kOjUbmkvfnjzktBbydfixTh093DwDApZfPo7PIKJ5gqQv7GyZie3g2/VhqGLA==
X-Received: by 2002:a17:90b:350d:b0:1dc:6680:6f1d with SMTP id ls13-20020a17090b350d00b001dc66806f1dmr19966890pjb.27.1652514755798;
        Sat, 14 May 2022 00:52:35 -0700 (PDT)
Received: from pc ([199.15.76.19])
        by smtp.gmail.com with ESMTPSA id ij16-20020a170902ab5000b0015e8d4eb209sm3104746plb.83.2022.05.14.00.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 May 2022 00:52:34 -0700 (PDT)
Date:   Sat, 14 May 2022 15:52:28 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/oom_kill: break evaluation when a task has been selected
Message-ID: <20220514075223.GA11384@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oom points no longer need to be calculated if a task is oom_task_origin(),
so return 1 to stop the oom_evaluate_task().

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 mm/oom_kill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3996301450e8..b407fba21d19 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -308,7 +308,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 static int oom_evaluate_task(struct task_struct *task, void *arg)
 {
 	struct oom_control *oc = arg;
-	long points;
+	long points = 0;
 
 	if (oom_unkillable_task(task))
 		goto next;
@@ -349,7 +349,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	oc->chosen = task;
 	oc->chosen_points = points;
 next:
-	return 0;
+	return points == LONG_MAX;
 abort:
 	if (oc->chosen)
 		put_task_struct(oc->chosen);
-- 
2.17.1

