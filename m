Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EE524499
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiELE4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348361AbiELE4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:56:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F654BF5;
        Wed, 11 May 2022 21:56:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q18so3797725pln.12;
        Wed, 11 May 2022 21:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZ7RH5y817mnOLvwZ/IWQwDogZf8paE6rFGK50oQ3hw=;
        b=kSgCCRJfGlri5OPnAl2kKgMp2k12cg/wAIHEe2ZMTVC9jrSvfAr0vtxm8gj9Aao9El
         cN+MwYEm0Fd+4rKh1l4IaFbOzSIH0I8koYvdxAx/BCwEM2bmiabFENahaG/NsxXIZUlt
         koyy20Dn/zohBPUFje7cHQBvqb3IepUcVONmfe5uD73Dd0dr9zGlxLS7bZgWO0FjPiBL
         C5QvjjpsMWZ4JO17gjZkjbqOXgcjgGc9PrYSYCbSt5GDavPG7MSl7v+Yfle383l+d1rT
         Njtbz4iiAH1dvptThir0yDJV2Vb+o0/y07yjNhoxwcPHm6qYY2tlHazz0XcsYf9JENGt
         8a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cZ7RH5y817mnOLvwZ/IWQwDogZf8paE6rFGK50oQ3hw=;
        b=1XvB5L8Y/l61Ob8CW+Y1p5egSrDs3D36wwjYkZHCBzMj9wZW4keHl4rcymOSU/MfsA
         m72F3jRv2bsZ6NBgXv7MzCOymc2rqTZqSiiiJa5JukQE1e48QQiGPGj0e4Zu9CDVSoEg
         qOlDzIg9Fq1YZsHpRyo+Mf2MG7ZolDXSExaA6tsV0umQsB0lTEX9e8g8HPSut+rhqqI/
         uXXaHHQr00x3QxgtFyS/b+kBIa4ouG/XTL/26b1qXzQxXkRFyp+vpFMPLvhAhG5AY4WO
         GDOegDtXhrUa9qLO0OJXzrz286h1fi5ASWWjoRpwTqjlqrdugIjZSkWyFUmrePilpaKP
         xtOQ==
X-Gm-Message-State: AOAM533pLCQpvZhDOHN1yKXveG3taX7LseGdRu8/LPIfNiZdRvFscfOq
        iuRcPIc4PTlDB/jFNh0ver266yVvfNEB339lYkw=
X-Google-Smtp-Source: ABdhPJwS5r880J33xg84nWBQFByYbOqZGu+xxskLSLSXWmhYjYDOkdBsbL0MU/qQBlBpo8BX7HDIXA==
X-Received: by 2002:a17:902:e94e:b0:154:3a4:c5e8 with SMTP id b14-20020a170902e94e00b0015403a4c5e8mr29117459pll.19.1652331368911;
        Wed, 11 May 2022 21:56:08 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170902dad000b0015e8d4eb1bdsm3032954plx.7.2022.05.11.21.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:56:08 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init
Date:   Thu, 12 May 2022 08:55:58 +0400
Message-Id: <20220512045558.7142-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.
This function has two paths missing of_node_put().

Fixes: 6e962bfe56b9 ("remoteproc: imx_rproc: add missing of_node_put")
Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/imx_rproc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7a096f1891e6..6363ed40854a 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -559,16 +559,17 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 
 		node = of_parse_phandle(np, "memory-region", a);
 		/* Not map vdevbuffer, vdevring region */
-		if (!strncmp(node->name, "vdev", strlen("vdev")))
+		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
+			of_node_put(node);
 			continue;
+		}
 		err = of_address_to_resource(node, 0, &res);
+		of_node_put(node);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
 			return err;
 		}
 
-		of_node_put(node);
-
 		if (b >= IMX_RPROC_MEM_MAX)
 			break;
 
-- 
2.25.1

