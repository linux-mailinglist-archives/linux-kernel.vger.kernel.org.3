Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559D1471249
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhLKG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 01:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKG6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:58:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527ACC061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 22:58:47 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so11011076pja.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 22:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gS0rNDUvVIV9tNkl78h/S/h2hs4kimVtUAJ2UWN3E+I=;
        b=NNYzx9YaTUXGdPZvdUWZZKbrKM7rpyQVzQdjL/zTHVNkYubyxUE8eERPewh37g9oPE
         rJ6rTeMwgVELYujyJp+qIQWy2dFhKI4pYrlGt48ehzqlqHY9f5sj6I2ctyd5ZDjGaNnH
         TtgCG1j/oxxaFU/eY8aeGcI3cTrLLi2ZHDLOcqGkdsGzndJR/3qzFgLE162tFnDw/Eg8
         Fx/Rjm3N+KW3n2I1WSjEQ0O1G2xyCWcuOdGgCttGU+Maa3oheDilUYmKkDONXc/qejD0
         /1HpZZsJEQNDZsyW0Q+WgcBPirgEnsqXJDNWw3xNP2J6BrXXNCo/GnveZFG5sHwuEAdq
         DNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gS0rNDUvVIV9tNkl78h/S/h2hs4kimVtUAJ2UWN3E+I=;
        b=azxNeXIpvzHuZWboC0UCjhiUFhAJ5bJx6VsigNpGLMRvM8CFwbvdxqtMYYJMbR20/n
         6jKFbEaxscq0h6m8nb5wS6T4XIqvYC2M6yYYsUUx9Cyoo3bKiPq5GMyf0xBOtxaZYxru
         CImBSDoQwk9TcBj0zFUlQzvGrKRkXjupUNsPd4J3Yv18B6kNZdamrpf6/t1mjtk5Sh4s
         iKxJAZ5d48KXirIHhsB8uzV8d5NBhQXN6vUhNnNw4jN1VIzoNJKbPMANoW8l3OPPtOrN
         gJrsPqLFAj1DS5eYpdrhhRLiyEkLg6CVGbSABrNN05nphCg1YHJ24rCSE9ELaPnsdCd6
         CkBw==
X-Gm-Message-State: AOAM53027MwEiupOXktp8uKwDh1mzuVfUsRI39LRuoceOks+SVSZGcAf
        mmbAn0k7zAV/6JS7dIfedi4=
X-Google-Smtp-Source: ABdhPJzdsTpQuL+Is7ao51DxNCu52hYshuHKkA0nKX1SfEk7j0Jo5ur3We8Xv3msiHDMMidBexkiUg==
X-Received: by 2002:a17:90a:909:: with SMTP id n9mr29696435pjn.1.1639205926893;
        Fri, 10 Dec 2021 22:58:46 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k11sm5006681pff.6.2021.12.10.22.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:58:46 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qdsp6: Fix an IS_ERR() vs NULL bug
Date:   Sat, 11 Dec 2021 06:58:29 +0000
Message-Id: <20211211065840.1221-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function gpr_alloc_port return ERR_PTR on errors, it doesn't return
null.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 13598ef5bacb..3e007d609a9b 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -630,9 +630,9 @@ struct q6apm_graph *q6apm_graph_open(struct device *dev, q6apm_cb cb,
 	init_waitqueue_head(&graph->cmd_wait);
 
 	graph->port = gpr_alloc_port(apm->gdev, dev, graph_callback, graph);
-	if (!graph->port) {
+	if (IS_ERR(graph->port)) {
 		kfree(graph);
-		ret = -ENOMEM;
+		ret = PTR_ERR(graph->port);
 		goto err;
 	}
 
-- 
2.17.1

