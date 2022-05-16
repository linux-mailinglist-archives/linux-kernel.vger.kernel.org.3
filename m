Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727C527E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiEPHcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiEPHcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:32:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A8BE33;
        Mon, 16 May 2022 00:32:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v11so13290482pff.6;
        Mon, 16 May 2022 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqDqf9Ouh9kt7IzDhnAUWG94jCCiPx6/C4Y9VUOo8Og=;
        b=i+Dp67aT9+OEtCYWkwWzHaG8m0BapotR432HsMZsaY4yaPW1ifUEszS3KpDMqtbQ4/
         UVoW9Zcvh62VZ80yYOl4t9nXM7QRkOByEqBleCDOvlY2K6EdUTOUNfiKhJJFkLR54CPk
         r+QGEv4Vyog5w3Y1rgqVPHLSIeEIPP128hdXtZ06MBAXywtGcY56uxw8DBlGGZcfzfZY
         p2LjGT+iaNiVkhCeemrwCHmx6gj624vkK85gQY7OBEIr7a/yVFTdf26K9jdMZ/p5cTxk
         GlXrg0kF403Ad3tVZPXx9oboJqpKaIHcbMnpVPvHc6sKZ5l0mwrZx+jcfGPPGb+NdXbm
         rYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cqDqf9Ouh9kt7IzDhnAUWG94jCCiPx6/C4Y9VUOo8Og=;
        b=gUFBUsSYt0HNC15RvqOP+hgWCUGMHDiH3xys2LTCV5SPodRi9VQ+/CT0W/tSfRKbO3
         iwkrmCJkik4vdebucR4nO6Od8wPrmCzpkFF/+xKEa+d71aA4E5thYnkwXV7cDJH20ScH
         yUIomIDMCRKdsOQGGMEsxeD3Kyd+kbhOWDoQdZtyuJxKd00b90V0TFmOEq9Vf6F9nazX
         9blfQhchIEQRcUnAgNaMamRTQBC6PRDzgaUzCYzsgqkNkJgllzCmcTr1vxFTCYeiyhYW
         bXnBujyzt9yBPtd128pNVEFXMaXAopsBUt9zmZhqauIR7VUjsMTBQlPerdbVe9rOvDkO
         OmFg==
X-Gm-Message-State: AOAM530p+uUSpaEnBg9Z1DAh6YsquKqM35DmJN+1cXeT5v4oJK++tlCZ
        DYhOcydK44z/yuY2tYoBJCs=
X-Google-Smtp-Source: ABdhPJyqMgJSYlcjnJe4wGk/9qhyBD9+IH8uogJM4OSRWjtfartQPb74T6UmFqSmsN20Apd6pFv0dQ==
X-Received: by 2002:a65:6946:0:b0:39d:a0c3:71f with SMTP id w6-20020a656946000000b0039da0c3071fmr14008974pgq.160.1652686321095;
        Mon, 16 May 2022 00:32:01 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y124-20020a62ce82000000b0050dc762812bsm6167647pfg.5.2022.05.16.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:32:00 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] thermal: imx_sc_thermal: Fix refcount leak in imx_sc_thermal_probe
Date:   Mon, 16 May 2022 11:31:50 +0400
Message-Id: <20220516073151.25918-1-linmq006@gmail.com>
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

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: e20db70dba1c ("thermal: imx_sc: add i.MX system controller thermal support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/imx_sc_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 8d76dbfde6a9..1ab854c228e5 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -95,6 +95,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		if (!sensor) {
 			of_node_put(child);
 			of_node_put(sensor_np);
+			of_node_put(np);
 			return -ENOMEM;
 		}
 
@@ -125,6 +126,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	}
 
 	of_node_put(sensor_np);
+	of_node_put(np);
 
 	return ret;
 }
-- 
2.25.1

