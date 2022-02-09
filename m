Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED854AEE32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiBIJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:40:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiBIJhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:37:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC02E01565D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:37:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k25so5542518ejp.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wSk9Xt36kV2FvjM9SY4Lo33UdRRx+CQTWW3YPXvCO0=;
        b=n+2+K1LbOOGjMhhnhmy75fEPspPfelWutSaVthdX8ZH/jfoZRfKHhJImYbGd/NgGb1
         oJHmrkMdLvp5lh+dhqCRvSmG/BW9ejhZyHVXox8zD3O92aYkYGwv5q4GkaIyOLTWHTtX
         V/6g3kQlYq4xaR0ahQdbrAoSbWco0zq+eVCpxfluOJQv2Yu5O4LtHXSvrDDn6KOsQRaq
         fnR3uFQxk4R6KNMXwqe53CVUxBnMOQzxWuWbKhcjeqW1/SGSbXDti54VeMsKL0uCd/Gd
         nw+jTZHyER3+vj7Q7ctdc68UmXaqG19apfrvZI6iWm4K9SnAKOtL8sbP67rZyqeak/pe
         uuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wSk9Xt36kV2FvjM9SY4Lo33UdRRx+CQTWW3YPXvCO0=;
        b=skgF7x+9U0oA8oJrqtXVLxaFTh9AMvcecqYGYmS33Ft/NEtGdbS2a8ofnz8gcaa2mN
         aSOKX4hZJujTen76SGFqV+H+5+sep/6t4ngsKy5bJhA+aHGCWDIjGCXM3yQbcSkawCPG
         /jgnWRAGa1wBSdIVztkgDLvh02DKfudBdpFL3/MKsBNnvhLsVTWStInR/tntrdT7Eu+k
         C/PmSvoTZrXECGAIXOK72aPN+Z72j0Z9Y/I8ytwNDl6EjJuUo4b+IsuU8ypKU/bfi/PJ
         PbwuCV7KFM5tqTAOcLNxDibuK00PpXBRndnRihv69NAZDd0MuF7rD7aJQ5wEkK5vOgCs
         3ZhQ==
X-Gm-Message-State: AOAM533Xziqjumb2F26W4G2oNStq0wwiS057W+vlRTWF9DW1ve2nRyZt
        QV7IxSTiUOV3auWPEdRI2GE=
X-Google-Smtp-Source: ABdhPJwcnYNE2AzwYK9ERVMWT8V7BA7ZG0ZB+m32USahYgA7PpW7yWLUPnjZUE9xN6SJHE/1varxSg==
X-Received: by 2002:a17:907:e91:: with SMTP id ho17mr1149690ejc.442.1644399447527;
        Wed, 09 Feb 2022 01:37:27 -0800 (PST)
Received: from centennial.enunes.eu (ip-78-45-67-25.net.upcbroadband.cz. [78.45.67.25])
        by smtp.gmail.com with ESMTPSA id j24sm397106ejo.106.2022.02.09.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 01:37:27 -0800 (PST)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2] drm/lima: avoid error task dump attempt when not enabled
Date:   Wed,  9 Feb 2022 10:37:00 +0100
Message-Id: <20220209093700.30901-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently when users try to run an application with lima and that hits
an issue such as a timeout, a message saying "fail to save task state"
and "error task list is full" is shown in dmesg.

The error task dump is a debug feature disabled by default, so the
error task list is usually not going to be available at all.
The message can be misleading and creates confusion in bug reports.

We can avoid that code path and that particular message when the user
has not explicitly set the max_error_tasks parameter to enable the
feature.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Qiang Yu <yuq825@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
v2:
- collect review tags
- update summary line to "drm/lima:"
---
 drivers/gpu/drm/lima/lima_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 5612d73f238f..12437e42cc76 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -409,7 +409,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 
 	drm_sched_increase_karma(&task->base);
 
-	lima_sched_build_error_task_list(task);
+	if (lima_max_error_tasks)
+		lima_sched_build_error_task_list(task);
 
 	pipe->task_error(pipe);
 
-- 
2.34.1

