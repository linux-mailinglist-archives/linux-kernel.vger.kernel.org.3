Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4503849775F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiAXCcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbiAXCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:52 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B77C061744;
        Sun, 23 Jan 2022 18:31:51 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 9so2141751iou.2;
        Sun, 23 Jan 2022 18:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wM27uiC4jZN6SIACqztmxLT6jE1eUS0JxDrZiiXzyRg=;
        b=OeEzUz+xSnEJ37CVSWNU73LKZ0yZoFVZW300ZrxE0zAlrUsF5B00SQDxDtIgduR0qe
         wjo+DFeHXaKCvIpUxXIFbK4SgqgFafQY2aFDBZtoanjokOm2VxhV7DApE36kYOI+qqk3
         qXdObbAmy7fUyTuApsbsl8TCJxZuO/SnVDPIuV+Dstc4lZg2GlxRZUcgU9Y20Hji7HZ4
         wzL/MIagejiycvC0z9eb39TB+hjzYvTywl7dF52F2Q+xmkcVkngQAHohfaqN2TiMSoKF
         kqZB5Unnk90Jlk5hThs1ymZYgncn4s9DwQzGWnmiI/JdMHdhBPu4x4TEj4WuUQ6wN4cS
         uOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wM27uiC4jZN6SIACqztmxLT6jE1eUS0JxDrZiiXzyRg=;
        b=DAu3EyAji5mA5hoTF7sCBjeSrD8x179HmrCHV3wb+TlouICUxTr+CMjo45BYD7Q8ew
         m+U0yRsogBu82YEq/UOrIX8dQQuo4zJ98JgHLY9+QgDAQAdB0VfOI+c3eUwjiM0IsFNJ
         kea1V436Vk5R+3K6Zw+9EmCIjY0/auIOR+RRvMcslpJ+f2ai9V2SvWoiJih/2iPZQziW
         bPeLRXZUdsDalhKFoE2vi5VfJfqhARV5cwJudx43AZoHOSO3kqZMlsGcm/99FclvX9OX
         wD8xO5h8jQtbmNXKb7YNRVHg8SBQO8Syfh0V2mZib0OJRmcpOXbVh4Eu7MQKLbf6AiCa
         7tpg==
X-Gm-Message-State: AOAM530ytGOcgHsUBPm1O0oZU7IlHLLWThTtREEKTFK7MgPznp1qZH/i
        +ax37iFot6nbY1+sfnIkxZ/2PX/YNG0=
X-Google-Smtp-Source: ABdhPJwVCAXerAQEZRw1wksjIQuYDlek3Gm5nUOSoAy/LVpBfHxOaxA2QAELIH/ZTZREKTlcu6u43w==
X-Received: by 2002:a02:3904:: with SMTP id l4mr5957775jaa.161.1642991510607;
        Sun, 23 Jan 2022 18:31:50 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:50 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 08/10] dt-bindings: media: nxp, imx8mq-vpu: Add support for G1 on imx8mm
Date:   Sun, 23 Jan 2022 20:31:22 -0600
Message-Id: <20220124023125.414794-9-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M mini appears to have a similar G1 decoder but the
post-processing isn't present, so different compatible flag is required.
Since all the other parameters are the same with imx8mq, just add
the new compatible flag to nxp,imx8mq-vpu.yaml.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index 9c28d562112b..7dc13a4b1805 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -5,7 +5,7 @@
 $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
+title: Hantro G1/G2 VPU codecs implemented on i.MX8M SoCs
 
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
@@ -20,6 +20,7 @@ properties:
         deprecated: true
       - const: nxp,imx8mq-vpu-g1
       - const: nxp,imx8mq-vpu-g2
+      - const: nxp,imx8mm-vpu-g1
 
   reg:
     maxItems: 1
-- 
2.32.0

