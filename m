Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984A4DCDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiCQSqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCQSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:46:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355AD5559;
        Thu, 17 Mar 2022 11:45:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s72so610246pgc.5;
        Thu, 17 Mar 2022 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8frA8T51BfSTppCN6qAkZ99su7zckg/tQTH5hUyS8LQ=;
        b=RyIndbofKYuCI2lbzTuwvX6FW6aLSdrSsTOTwX+0PpMG1tVUS6nBiZpd2wOMB7K7ay
         4TXEw9HIMq4ArLr+GY+kFHSa3rtOKuWQ87s/u9R2D32lRmCq3j6CFhCFxtPjLOd7b/hs
         DJMpaqjupWPONWXTRQ/l751ZZyaMTn81HGy5UFIHeDiX+ffcb16r2eiSWfF+XjtYoJZf
         iy49l9+lkoIEIRCzKoPdQj6f3X7G7il+VGeOHiFvt6MQbKpAGVI/tIWH/GoBh+5/obmw
         wmcY4pCIn1cM15qgfWs4J/FM/wtfVB0ze3e4oDlIlB2hRiPbQyL9YIGv9n6Gl0rtTJWn
         V+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8frA8T51BfSTppCN6qAkZ99su7zckg/tQTH5hUyS8LQ=;
        b=eSNZt+r0Dy4O+9jJFa/cooGSBvv2Q7WAgJdrqoPGCADfGJL2Om7omHTZB5K/Du2NTq
         Q9SYbucDJA4pLbOaOccL/vkU9W9fdTjmsaYgsFNwYXPaS1dn1EgXNHF4nXE2RlJ3xZD8
         Q55JhwYg4FlZr6sRBa7tWxy7dDIOab3874H2g8hFkVOktZs4jQ7RJ84em6RhBPvzKonK
         qdqXPy2Np3SAec5718Vx9oOZMjHEjV+IMQ7mE0opwhd2MAU0GtssZOeDbr3JWl2J5cFP
         fi8lXZh2wfKprbfDxFV97q7q5Tdx4FJdb/lDPNYAnPbC1mUfZTcZNC306/C6mMxnHivh
         qQaQ==
X-Gm-Message-State: AOAM530s56f28d/VbtJHQTiXWAsvoNn26HyTH1eMd+Jkdr3RfoRncsTU
        YwZn/Cnv7rnsfpy63NCbu7Q=
X-Google-Smtp-Source: ABdhPJw2Sgwey2XM0AbmtVD8ylMFuv07FxKNo/PyLtYEDBPs6DlFa+Py7zEbtBRkZ2Tx6uUEyf0HUQ==
X-Received: by 2002:a63:ab47:0:b0:375:5d05:9f79 with SMTP id k7-20020a63ab47000000b003755d059f79mr4900716pgp.192.1647542703366;
        Thu, 17 Mar 2022 11:45:03 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a560100b001bf72b5af97sm6285380pjf.13.2022.03.17.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:45:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Add missing put_task_struct() in debugfs path
Date:   Thu, 17 Mar 2022 11:45:49 -0700
Message-Id: <20220317184550.227991-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Rob Clark <robdclark@chromium.org>

Fixes: 25faf2f2e065 ("drm/msm: Show process names in gem_describe")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 02b9ae65a96a..a4f61972667b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -926,6 +926,7 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
 					get_pid_task(aspace->pid, PIDTYPE_PID);
 				if (task) {
 					comm = kstrdup(task->comm, GFP_KERNEL);
+					put_task_struct(task);
 				} else {
 					comm = NULL;
 				}
-- 
2.35.1

