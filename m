Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668864AAC2C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354872AbiBETCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 14:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382678AbiBETBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 14:01:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C21C043187
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 10:59:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id og43so5640764ejc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 10:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOFeBJ64dmtg1TOUySBDnDMIhOcmOEsctVk6jKGZNmc=;
        b=mJ/l/5BNvplluvVRHfQCGUGai4Et4wivja4WsJcPMQiIktN5h5BlHUAFjt95NET7B4
         0f1SOpnaRjI6s/AbCBk+mKXJNR5J4bWApl+zF6R2rE6Ih1FvbeOam2O8Nkc7lnu62S8I
         rv0xqW7gmIOccm/3W2YAuEOlvYDPNq5ba9DxLHb8+W/Te9UPvPEO57RziSCYiwFUijRh
         du8ktgyvd9zpzLamY86iOZYeBL9okci2KKunoZr3vjND3wxCwa958WC1u8eejYiESN7S
         QVQ8JwGHZxiBdPslVznkerIZoKKYa/V/LNoeNWbZbvRh0aRKEsHzwfpNHiYvo36VR0yC
         IgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOFeBJ64dmtg1TOUySBDnDMIhOcmOEsctVk6jKGZNmc=;
        b=XkiCfs3dSSUk+R/Ga4mJf6ylmaUaXxqGgihWucmXlFlRnmb3GYJ1s2Ho+Hjch9JwVf
         i5WESDYFuiy/616JQXGB8H2/1Ca3eG69C4PZagUUWG5hfdiZfhNYZ5KGmzzz7AMWLBQi
         70Z40LcDBePIsSyJ3VvZzlD9NgQM3/5vbPN6lKb+eDSBQYAg2zeZ+VvK9mMKNpqGM6/P
         2DUyPd6Bqy2Wv24pz8vXAcfQFa/1An9jwzGb1VogW1yxCnOxgCNA+J2LAB2Jr1wDBSbB
         Ic65cQa2WNnIpPwypHj+A6xplpHerGv/eoPqTqN6+Wy9YMeS4lCn9HUAsWhj3YbCZ5xM
         2KuQ==
X-Gm-Message-State: AOAM530w4taURyoGZpfXzRZy6ZGFHA/iEVNRbQpri6s9TkN3mqux7dFB
        Cp7SGsiNU5Rdtca2A/OBrBs=
X-Google-Smtp-Source: ABdhPJztCj/bhSAnQQ9Tckgi7fi8+cgHDPhHTqKvRATOgSl8JYf40cmKzDW8CsNRoq76vWqfbS/6ww==
X-Received: by 2002:a17:907:97c9:: with SMTP id js9mr3944342ejc.351.1644087583420;
        Sat, 05 Feb 2022 10:59:43 -0800 (PST)
Received: from centennial.enunes.eu (ip-78-45-67-25.net.upcbroadband.cz. [78.45.67.25])
        by smtp.gmail.com with ESMTPSA id c20sm720474edy.41.2022.02.05.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 10:59:43 -0800 (PST)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH] lima: avoid error task dump attempt when not enabled
Date:   Sat,  5 Feb 2022 19:59:09 +0100
Message-Id: <20220205185909.878643-1-nunes.erico@gmail.com>
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

