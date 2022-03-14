Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA84D891D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiCNQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiCNQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DD213D1C;
        Mon, 14 Mar 2022 09:30:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso9028wms.1;
        Mon, 14 Mar 2022 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mm5BPHHve/qDzxBF84siO+rAM1VKpcqsQMTnWzDJDFQ=;
        b=NFm6j70jtZAWm3BgKx+ZAlXiH6JL5ckNesHN4Hbu5p/ZpKKpDfrs1h9v1UFnbWCXAB
         uVmK9WvTzP86Hhdk0MgFqIt6X1elglNSg66gJzHKkx0XmI4XMkBYqINeJhTVDv0KEa+x
         /KmI0cg3rd3BUHfAL7+rYOKl4FqYN5Ts+E2Mp/knvkX2Y1HPRQr/+oOwdAtk2TC3ckwh
         ZhgiHVCLHttYMY+7e5KLUxFIcL78X0P5kEP4WqNlqfoyEcxFgL3x0sEXWVfd6wI+5+u2
         ypeV29SWx+BKw7VcwLqbhFKsF1cE/Ql0KbAoQMQ61hrrFzODEwA/eeB1X407//JjaK3y
         ydnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mm5BPHHve/qDzxBF84siO+rAM1VKpcqsQMTnWzDJDFQ=;
        b=l8630tknASrKq1vhMUHa4WiDNoFbp+VzYyrARXp5zMQp7erOAGSn0Yfy2WsHsv17mz
         GXmO1h/32LJQzSZ1Jbh51roPAMKqfr8973nPt9lb8dhNrVqP8HaA8Dh0Nj7dJasDqChl
         Fq4bjwcrjSz5pCcaL+J00T3s8SkLqlWck+tmzG51N5GBpdlbawHHfpU1pFivOx71Zq15
         /YxNS25VW452P0bOqkwoD+Jud7sN9hSbWE2vKi/uYJ8kJajo8merWMAVfSZgY+V11p9u
         8/8ObMRofErVDKHrClbkY9Vade3t0cKeWjtbQeacdu0aWM0jeP4koeCtZXjT1HicYGGz
         IKPw==
X-Gm-Message-State: AOAM531yxoXDWI4OO98dIsBbsILP9/qE1Ud7b3W6yYti0ETQuJcdWtvJ
        nOl3MxrhDPdUD4bxRLdsbaI=
X-Google-Smtp-Source: ABdhPJywK/BLx3YOys/rp6f5E+efWbOOiPp0/7zXiQwgcx1fqiQZl3eQmVe5G6ljwDu2+yuKYSWTQQ==
X-Received: by 2002:a05:600c:a53:b0:38a:fc5:3a90 with SMTP id c19-20020a05600c0a5300b0038a0fc53a90mr20448wmq.15.1647275412844;
        Mon, 14 Mar 2022 09:30:12 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:12 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>, Lucas Stach <dev@lynxeye.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/14] dt-bindings: arm: fsl: imx6dl-colibri: Drop dedicated v1.1 bindings
Date:   Mon, 14 Mar 2022 17:29:45 +0100
Message-Id: <20220314162958.40361-2-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

The dedicated device tree for V1.1 modules has been dropped. Remove
its bindings too.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 97f6eebad76a..cf854203bfb1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -411,7 +411,6 @@ properties:
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
               - toradex,colibri_imx6dl      # Colibri iMX6 Modules
-              - toradex,colibri_imx6dl-v1_1 # Colibri iMX6 V1.1 Modules
               - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
               - vdl,lanmcu                # Van der Laan LANMCU board
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
@@ -492,13 +491,6 @@ properties:
           - const: toradex,colibri_imx6dl           # Colibri iMX6DL/S Module
           - const: fsl,imx6dl
 
-      - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S V1.1 Modules
-        items:
-          - enum:
-              - toradex,colibri_imx6dl-v1_1-eval-v3 # Colibri iMX6DL/S V1.1 M. on Colibri Evaluation Board V3
-          - const: toradex,colibri_imx6dl-v1_1      # Colibri iMX6DL/S V1.1 Module
-          - const: fsl,imx6dl
-
       - description: i.MX6S DHCOM DRC02 Board
         items:
           - const: dh,imx6s-dhcom-drc02
-- 
2.20.1

