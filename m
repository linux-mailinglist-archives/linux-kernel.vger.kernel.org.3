Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F95283A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiEPL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiEPL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1A15A0B;
        Mon, 16 May 2022 04:59:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p26so1751259eds.5;
        Mon, 16 May 2022 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1BYS9UgVZFFyEZ8wlaCzvbMmLIqMqA+LjVcM1kOh4o=;
        b=cNQJV+Bs81tLUSH7A4R/Nso8Qnlmlps7sPTj/74fJT7Ex2wxjlHjoZ4ycHtI5X9OKk
         VSdQj/HodJ66vn35VzMA9/mTsHAWG10IhOipRamiGrGuFRMU9QiJf/o9CmZsu1vKKQXb
         5uaB0xmGAwaB9a89o/dT7NYlVeszWou/egVivAlFc8/Qryf2MRx1V2GJQoU8uNMYvNFU
         pPoGkXS5XUqrYkiuVIr0zTqrNyQKFyiGCgCtOpecAa9H0nS+rIpYJMcG5PpLDoKBe1eE
         oWblulcouHJ2VpKn32llYcGibqENOHoILKmrYZShFtpsJD1QK/75rFipZQiExBbXZuvs
         gViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1BYS9UgVZFFyEZ8wlaCzvbMmLIqMqA+LjVcM1kOh4o=;
        b=zpdpHfDkr/VEh1JbBAtjTGFbaHK0rzF0q+IdsmlFhtix0+pjp+IDaYoc85eVQ8h/tH
         C8u8/UC++WtGMBkSbjInHcvAyzUtKXWJlII3XNV4i/h9+l221Rq92e7hmKkX80BxHp6j
         5Cpb0H0pHKNJbVpQ29Lxj6gXITB6/knwAUSKnGqymPhODPvcGJFF+88Dy9r9IAlaJrQq
         Od9T+7Dpt1kfcVOo/BK1v+H3stI514neyYTpvU+b5qg428CSP+xdddBZ1bHXDC4c4X77
         13DB8U6n5gMvDdluLsjv+ahsFj9jgIEldba7tF2BNy1/SnFi8AI8cuL3Tql2Lj3tl3np
         yvHQ==
X-Gm-Message-State: AOAM531ihDM9CFhPlnsoFmMrvDAQqPZ4AdRDjSzcSfQZgQUrd+FjEGOp
        OyyGLcVgq5Q5V1dHaL+b9Nc=
X-Google-Smtp-Source: ABdhPJzg5eVFZfUYNcIyON++UrT9fMivCPU5hqFmSyaJ/kDkchFAcT6BpW1+45v57xquAfSHt6eVKA==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr12857396edc.86.1652702359489;
        Mon, 16 May 2022 04:59:19 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:19 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/17] dt-bindings: arm: fsl: Add carrier for toradex,apalis-imx6q
Date:   Mon, 16 May 2022 13:58:29 +0200
Message-Id: <20220516115846.58328-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..eb090372dd23 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -320,6 +320,7 @@ properties:
           - enum:
               - toradex,apalis_imx6q-ixora      # Apalis iMX6Q/D Module on Ixora Carrier Board
               - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6Q/D Module on Ixora V1.1 Carrier Board
+              - toradex,apalis_imx6q-ixora-v1.2 # Apalis iMX6Q/D Module on Ixora V1.2 Carrier Board
               - toradex,apalis_imx6q-eval       # Apalis iMX6Q/D Module on Apalis Evaluation Board
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
-- 
2.20.1

