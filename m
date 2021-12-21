Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41B747C1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhLUOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhLUOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:42:42 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE09C061574;
        Tue, 21 Dec 2021 06:42:41 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id n15so13097836qta.0;
        Tue, 21 Dec 2021 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D31zelEVktxk1zVBP/e569ZOieN3IU0DvIddUF6p1ZM=;
        b=eiwe50TFlZDlaDlCkbz6L0i7iHgSm249T64gND2w03zqTyS2mJCA70hsfEf/pH+W0u
         OD9kBLd1flhOakQJrfkZHHhVur8gnqkAPZGL/CKfLQFi6proAqbGYcaRp37eb4s0K+Qg
         qW8ALuwdGcJ5fdocA9zAJG65LBi5mlEYo9AFgwyDxsciX78ksoV0C2dg1gdjJ7uEUpoY
         fBGew3DkTgoaMcBQzfKFKlSZ9uLESHVKbmR2rsQ1PgYu/GGuKCUutYo3/f3PUPYLh1ud
         plaOJ4TuyEOx3FvxzD96C3388WT+yT3EW2fh+O4eqmCmlIwqGXvGCnShOSmWHPY7AdZS
         TS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D31zelEVktxk1zVBP/e569ZOieN3IU0DvIddUF6p1ZM=;
        b=Nw/yDkgaWfOpMbhORGzRZEVzgxKydkuyhZYnF660yzTNEhbtbqxKXtXJbWozlW2ZTW
         i72liCKyfBkgCgATHmS5496vMNUIXx5kCemlCbrVDmS+hNsfNq5HR9nSZ7vAl6vgYDZ3
         NCcNRKTmp7sPU+f1PqJ9L34uH6n9Ey/fz5pdGeuQtMQdkJM0VY/HbFmdfAGR8ugYaSkT
         BVazXvKDBTQq4+/484x8l+b6pJjdna8SAjAYAi0/FBLJ72ZpZXLzXtEA8uGgYnjQeGbm
         m1u5PJrplQd67rQKcY7pjh4C0Xlke2vrxDx3/IN9vQzhsbBC1OVtzi5/8f6h/Fj2hb60
         DXwA==
X-Gm-Message-State: AOAM530awfyo+iv28Hk8ByQ3JjNhkRbjvLp6prOOH0do5ATTtID9SERs
        Q1JNTa6tK9E4Di4A1fIhE5c=
X-Google-Smtp-Source: ABdhPJyAwIC+hNgSxPfn11Ky2iXQXAmqJxFVzzNjAb5C2gvg6ijvzxuCuNZ8rvQFcyt6gcSDkXyfSA==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr2443070qtw.242.1640097761140;
        Tue, 21 Dec 2021 06:42:41 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v4sm14130108qkp.118.2021.12.21.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:42:40 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/msm: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Tue, 21 Dec 2021 14:42:34 +0000
Message-Id: <20211221144234.480618-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck warning:
./drivers/gpu/drm/msm/msm_debugfs.c: 132: 0-23: WARNING: shrink_fops
should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
debugfs files.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 956b1efc3721..91fb0c83b600 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -129,9 +129,9 @@ shrink_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(shrink_fops,
-			shrink_get, shrink_set,
-			"0x%08llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(shrink_fops,
+			 shrink_get, shrink_set,
+			 "0x%08llx\n");
 
 
 static int msm_gem_show(struct seq_file *m, void *arg)
-- 
2.25.1

