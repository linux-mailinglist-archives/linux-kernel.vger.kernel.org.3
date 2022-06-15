Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5E54C7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbiFOLuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbiFOLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85114B87F;
        Wed, 15 Jun 2022 04:50:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so22683633ejb.11;
        Wed, 15 Jun 2022 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/+El1RbXEno0PmTWmHthMoKqcv8hQ3TpxlThfX8oNc=;
        b=ld7NS/6t8p1aLSY4sodAPu7l1sxt7NqNpqMYVF8XpeB0j+H6cH1okJ7WXK3fQozb7S
         UmihxyQwbGY388j9gJ8cLeVFPMfe1cEMgnvfTiwtV5YHAIvR9TaQbXOs5sPmkbPAFLjr
         BuVcfYNJKnnr3tE8FntfnwHvGEQIwKBxqLJYTQo+NPH68Nic8qO2UydyrpJt956CdUHw
         AMppTShvmHqmQ1ScyZ4S7er7mAyIOmE7kaBjLE9pi9RINNpO/1PDVr+GsnRH49BTPipY
         C6d6uLJ6r1p7il0YaB2qCv9uTQFdMptXwFa4hcExC9ZHhh/LCHLSva6F1r8zM8RayL91
         jjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/+El1RbXEno0PmTWmHthMoKqcv8hQ3TpxlThfX8oNc=;
        b=mG2QBiSjhdj0g9nvzij8Noet37tNlB/fVd9DlkuQVk7QKBldf6ZfcIWruPny95UTjc
         9XEEPInMfJsRECy7Bu9DJpTTfhwhkN7nh+PsLX9PVqq1hp868tOv+UbQ1Xy8442Fbkp3
         3XlJUm0+HisgVmI8z11EhVmuc73+WIaCwS0QfRrE2GprUpoSYib8O4Ow8NqxurVxpJsu
         7gZC7ZM4lxwjoQbdE0O/gmn+ge+nPfMA/SzifU/TNqCg35YFmnxisAW28ODCOOiCvPTQ
         kpWXznCHyIWz+SBY9R9Yq32WfsWYymTfY/Nt1obgARYBzIDaJeidpYRYij2Wj04aMCQ+
         Vfmw==
X-Gm-Message-State: AOAM530PAH9VJWXMYCJyl7JqtSASHoAxNsfEsFceMAoV2LMZIReEis4N
        V34BAgV2WQ+NShyRD04dGcw=
X-Google-Smtp-Source: ABdhPJwH1Xjd8RKyfxooVYqDSVHMq6xPEhlSfpAF6+uiTfC9Bzctbk5X2SQllnFj+BOrm/VNj96KxA==
X-Received: by 2002:a17:907:90c4:b0:710:456a:6981 with SMTP id gk4-20020a17090790c400b00710456a6981mr8623001ejb.484.1655293845238;
        Wed, 15 Jun 2022 04:50:45 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:44 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/18] dt-bindings: arm: fsl: Add carrier for toradex,apalis-imx6q
Date:   Wed, 15 Jun 2022 13:49:49 +0200
Message-Id: <20220615115006.45672-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
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

Add binding for the Ixora V1.2 carrier board our Apalis iMX6D/Q
may be mated with.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- add Rob's reviewed-by tag

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..b964eba212f7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -321,6 +321,7 @@ properties:
           - enum:
               - toradex,apalis_imx6q-ixora      # Apalis iMX6Q/D Module on Ixora Carrier Board
               - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6Q/D Module on Ixora V1.1 Carrier Board
+              - toradex,apalis_imx6q-ixora-v1.2 # Apalis iMX6Q/D Module on Ixora V1.2 Carrier Board
               - toradex,apalis_imx6q-eval       # Apalis iMX6Q/D Module on Apalis Evaluation Board
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
-- 
2.20.1

