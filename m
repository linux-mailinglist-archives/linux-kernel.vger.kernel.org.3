Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9C4FB172
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiDKBm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiDKBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:42:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C2BE25
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:40:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id a10so822018qvm.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/L0IJbKP3lY8e64VY887AJTXuXf2o/pfs3vhcd0kvnE=;
        b=HhYHV7+QfjbR22YueWQ1hQZtsxTdvw/eZ6GfITrRKFrLEeACNJgbCR4+7DYTSzJBe1
         U4WPtA6Act49/sbSLA6NfesOygapuDKRVR1xbnvCRADDdlbIYOh8MOdgnCpYdR6W5giX
         t0gQyzcnnyVbbTfDPZCG0GgQ+HAxUXQRyE6R8y+Js/t7HiS2RoBzcRHnsJnYEqTrZJpT
         BAO7zUXZHyUcJdiUfwDLHMbMeLKEnfYaIXZMybPWsfz64AiY8UtyM2/AqSn996bCc0qL
         HzDY05oRMyG6lb0XQyrdHswhtqcycGgFTkETY50WEvXAU4YNvd7hrfg6oS6JzG+UIK57
         tOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/L0IJbKP3lY8e64VY887AJTXuXf2o/pfs3vhcd0kvnE=;
        b=Ai9vDiWrlay0Z87t1mwV4sDTlz0SxNQVxIlp7spw5x+nUxhdjO0BV97RuBax5/Ka6A
         RRAsIhDSvVbDEqSg6VCiK/jlKQ8sKfPFdPXZXmlz4s6+KFQ3BIEzxcM+vVyweG6iSjso
         jPVOA2TOlCDgEqWfAa1k6EiQiZLVtCR/5qCGo8hriZTu/jbjxvwDrxuZmteY6NKoeewU
         J+Knc9hV6h8kCPmwsvEqx5kq/zq9iUOmdN1cinGt5nnMHNw8DQG6c2He4/ubnTAIC8Xd
         qFQeoDDfDOfRJdyaYMrdXV11KsJmUvKjWFw6AnXvvpnQ/OpwIzMSQv76LVmU666XR4Aa
         U+KA==
X-Gm-Message-State: AOAM530UHeuGbjJEMhtP4dYLHEht9GtzEYc7fFms2l7zNMJGPn08p+GD
        102AbdWD2w7ObIYLIhklwcPT7Wn2mfM=
X-Google-Smtp-Source: ABdhPJyCH0ppaYsNBhewXEFOiq5v2TU2uFGojChUWvu5CZozFizhuWfhmnoqp1oR3PhffwrPZMKz0Q==
X-Received: by 2002:a05:6214:5185:b0:444:38ef:5942 with SMTP id kl5-20020a056214518500b0044438ef5942mr6086252qvb.42.1649641242598;
        Sun, 10 Apr 2022 18:40:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k20-20020a05622a03d400b002ec16d2694fsm8811022qtx.39.2022.04.10.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 18:40:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] nvmem: qfprom: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 11 Apr 2022 01:40:36 +0000
Message-Id: <20220411014036.2517274-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/nvmem/qfprom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 162132c7dab9..c1e893c8a247 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -217,9 +217,8 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 		goto err_clk_rate_set;
 	}
 
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
 		dev_err(priv->dev, "Failed to enable power-domain\n");
 		goto err_reg_enable;
 	}
-- 
2.25.1

