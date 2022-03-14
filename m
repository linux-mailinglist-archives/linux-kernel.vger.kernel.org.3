Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AED4D8928
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiCNQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbiCNQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E013CC6;
        Mon, 14 Mar 2022 09:30:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r6so24470246wrr.2;
        Mon, 14 Mar 2022 09:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMc3hS2nDWt/VXm5icHS8ZJSiGOmlimiAqvNkgMungw=;
        b=FWhw21EHb3m7gdC6Uw0D41cyneQjt8svu9OnP66NKKCG5bsYZglzbotQaPr9ch9rhJ
         fYyknDE1iR2b6HM1B74m/J3IzO7xP7bMj3qsQ7oPWU1S9Jkzx+hmaPbk2uekuTLrsyRD
         FnT51d/5GtMr0wrkkpMth2GCHjQWlE/Ui1gJ2pdfGhg3lHM7vDetGzHUTLe5ArpYztji
         PnKvjMHjbFG9PGltFvxg+JH3/ODsWPApXbB191L5VEx5f4aXeFaATy4h7pqtlltZfhZP
         BO5HXs8bE31Fk4MBUkBdmIxnGZPt8n9nhNFnFOAzXCjGmG4jTe0SDC5SbyH8KufKZqOD
         ihPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMc3hS2nDWt/VXm5icHS8ZJSiGOmlimiAqvNkgMungw=;
        b=B8y1Ov8U8Khmkp+O16xbBRY+17yCGPWIkwGuOoHOvS3QaGepCg4OJGFic0fQIhP2HL
         9+QAb05rvmOfSOKnv5MU3a7LjQDEURZDFOWCh1vsYTRugxs1mGxvtQ4n1dURwvsxVju7
         d2Pygm0d5jYOwhMne4OWqe+GuNZi0TZrffCwKVriGDr4y9alyZbpoAHmOdQD5zEjMagw
         utWCDF0HBGIvKyit/eZkgjUJt4EWSjtZs7ex3FWhe3nLhwqsg3r+unQa5nZaxLPWdKGo
         HI+a5NiTh0YvrvihDu9syp4nE2mv7roum4M/vpENXDHH987Tt1+fcqKbn3GRQnJvMvnO
         TBdw==
X-Gm-Message-State: AOAM533Nrn9TO4Ng8ZwMqUbNYP/uBdhKKnzLU384JumkwkrmGOTS0SZW
        h9MDpCYe8te2VjzHQAg/0fY=
X-Google-Smtp-Source: ABdhPJziYFYPW1Mgb5QuOeK4LqzQRP8CBE70psNXE7EhaFJ5MTl7KLaHGhs5KX1ppQG3v/sg4Rgo4w==
X-Received: by 2002:a05:6000:144c:b0:1f1:f24b:a70b with SMTP id v12-20020a056000144c00b001f1f24ba70bmr17595685wrx.541.1647275414911;
        Mon, 14 Mar 2022 09:30:14 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:14 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/14] dt-bindings: arm: fsl: Add carriers for toradex,colibri-imx6dl
Date:   Mon, 14 Mar 2022 17:29:46 +0100
Message-Id: <20220314162958.40361-3-max.krummenacher@toradex.com>
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

Add bindings for Aster, Iris and Iris V2 carrier boards our
Colibri iMX6S/DL may be mated with.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index cf854203bfb1..fefbc13f3928 100644
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

