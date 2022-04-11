Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9D4FC069
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347887AbiDKPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347862AbiDKPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761C3BBFC;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i20so10441359wrb.13;
        Mon, 11 Apr 2022 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98+3Jf2K+lmlSYcf3ZsTlyGvLJddS6p5aEwgVTSRiyI=;
        b=qoYhO9y5TGkppGOwhVpfSntyUfR1NJuqvhMVLa1hK6imOHPuTjYku+IMM33/j/YNEK
         OD/re5RFObqBDPTVHYwMpLXmFMW0BMAc1XjmUcBlKWpWQWwWKTgkDvJyISTj/4M9ONz3
         9Mp+vmQPfFQNSGwmGW9GSTBv+gkcWrpIe/iegwx2mrWQBFlfcs1En1EEvb7N9ouCHN06
         FBuZnwQuDYz6S9WPXU29yMroKX8ksVd+m2fzHZxvSh0FNSOCobJvi76cBA0F77g6POA1
         QieVpyAmg02KT+abROjkMbNFJtgTT5zVEl17eNjTUKlmCwFECSG/VODPmnrFKngCtex3
         AIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98+3Jf2K+lmlSYcf3ZsTlyGvLJddS6p5aEwgVTSRiyI=;
        b=fhk1LZ+VsZoe4k5hC3HaFbFKV3HKfVGJlfkG5mbkn6vq3Yt8Nl6tvNTP2p+i8riXmS
         ftoUiNi4HL+RyvHjmgUSezeWX08BG1S1uMt06qEMu+Ozz69YoOqpHeg2/4VvMmAAxm5v
         iMFtYvW5/9njcnvBRCQwl4DQJmqLqUiTUicVdZpwF/DiernmTEhDHGYWjEEHZwL5Xghw
         VgGbiUq90G9fNMPD2ZCCg12n5uB5/0jbD2AgoEbb7MF7MVslKdQsjj/fnyLFihUcPhmj
         icd8lUvJKo9O7kBpWEbw9O7V3AbMigC1y8AcUlXSDUsVDdUN2FX50wK3HqgpIxxKM86k
         JNbg==
X-Gm-Message-State: AOAM533MzcgLPSosytBHGLF/3+lpZE7Pjd0dJDvHr2jW+pih3KQMsOJW
        It4YQn59s6BmiDeq+2Wl/wc=
X-Google-Smtp-Source: ABdhPJxHWoBHrbANz5Osu0lavpckNM1zlutikUlIMHjC+atykoAiJKYZOm0NXbcD7yl3o3pyUHHS5A==
X-Received: by 2002:a5d:5955:0:b0:207:8444:203b with SMTP id e21-20020a5d5955000000b002078444203bmr17881793wri.433.1649690569370;
        Mon, 11 Apr 2022 08:22:49 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:48 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] dt-bindings: arm: fsl: Add carriers for toradex,colibri-imx6dl
Date:   Mon, 11 Apr 2022 17:22:22 +0200
Message-Id: <20220411152234.12678-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Add bindings for Aster, Iris and Iris V2 carrier boards our
Colibri iMX6S/DL may be mated with.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- Added Rob's Ack

 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cf97171506ca..5c365e738b05 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -487,7 +487,10 @@ properties:
       - description: i.MX6DL Boards with Toradex Colibri iMX6DL/S Modules
         items:
           - enum:
+              - toradex,colibri_imx6dl-aster        # Colibri iMX6DL/S Module on Aster Board
               - toradex,colibri_imx6dl-eval-v3      # Colibri iMX6DL/S Module on Colibri Evaluation Board V3
+              - toradex,colibri_imx6dl-iris         # Colibri iMX6DL/S Module on Iris Board
+              - toradex,colibri_imx6dl-iris-v2      # Colibri iMX6DL/S Module on Iris Board V2
           - const: toradex,colibri_imx6dl           # Colibri iMX6DL/S Module
           - const: fsl,imx6dl
 
-- 
2.20.1

