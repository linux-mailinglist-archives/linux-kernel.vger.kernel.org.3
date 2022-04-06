Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96E4F6722
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiDFR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiDFR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:26:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF933205BDF;
        Wed,  6 Apr 2022 08:25:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so4646090lfa.12;
        Wed, 06 Apr 2022 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buklFgMo3io8o1oTm+e0Xy6mGquidMcjQ+rAVmjF0R0=;
        b=IpUBnNb1wMpq3Z33rLXUmoesOPAyubbH73r3NT6CG2VFE7ISsrjIUEOS4mq1gMPJ0/
         y/P3ojZkkt5w1AXkNY2BYWBVLXwhiaiDchr3olLAUF1lLuK/mxEVqh5ainO6buKOAQcW
         cUQazL0acLThFgQpSb6DFLnF60L9LGJUgO4uNUxz397btFBQeiciuYcoqB1UwvkYTjgM
         +GYm8SLvp98Oka8FJutNz86JOqwL1MFh3KNAjkKuYRl8NwT6VNsNLWKpihRnTNa/pYmg
         vT3st63NFAB33DNhWFfKe4Gm/CQd4KYl+hY5lpXmcLaexYpP63+/ZlNXrr/DUxmdlVw5
         rGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buklFgMo3io8o1oTm+e0Xy6mGquidMcjQ+rAVmjF0R0=;
        b=aMertZ/mQXLyIblB4e74SqA18SJZWGbjak87x6yz1Bfbicq0v+a/Dqn39uCyEXx+yc
         8wZ+uHmXEA6Uhrs1BYb51/2FEiICW6jUlRuw3rlpY1f88oVpAucMtE7r1ZdPNnLTBA7S
         DzOoKvw9IOvLy47QsAWDzph+1ofIUeEHv2qtSIz7EoBL+LntTOVjRV1SdO7A8KBHOJR3
         VSqTnzFA8JSMrhrjANqQk7wMSDwJLVyvMJLl2+dxp288H2RPBvAW+JIC+ihXtAElWUkM
         69XY79T3faOMz/7cKCI/VU3Vi3Irqh4KSHEyCsji3MnlR8H+N8Cwf7T4V/kWfX4Jyd1G
         gJhA==
X-Gm-Message-State: AOAM531xNrDOgn1cNe86d/Fm4MxQfGBUTYrCi5xBZDYgCfCpd/XlG+SA
        5a0sq3ZO/CQjz/v/MZfTIlA=
X-Google-Smtp-Source: ABdhPJw+wxyyrmHkxuNDGzpTAjtnLv+6MCubb/xVpbVgTR8NNXWidB7jX7O3yhmXgjH6l8xw/z/JWg==
X-Received: by 2002:a05:6512:3dab:b0:44a:247:2d8 with SMTP id k43-20020a0565123dab00b0044a024702d8mr6374447lfv.628.1649258723148;
        Wed, 06 Apr 2022 08:25:23 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a2e3205000000b0024b045e3b18sm1557359ljy.66.2022.04.06.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:25:22 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Tom Rini <trini@konsulko.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u-boot@lists.denx.de, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding
Date:   Wed,  6 Apr 2022 17:25:15 +0200
Message-Id: <20220406152515.31316-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom uses U-Boot for some of their recent platforms like BCM4908.
They decided to use modified environment variables variables format
though. Their header includes 2 extra 32 b fields at the beginning.

The first field meaning is unknown, the second one stores length of env
data block. Example (length 0x4000):
$ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|

Add a custom "compatible" value to allow describing Broadcom devices
properly.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index e70b2a60cb9a..6a6b223be4a0 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -36,6 +36,8 @@ properties:
         const: u-boot,env-redundant-bool
       - description: Two redundant blocks with active having higher counter
         const: u-boot,env-redundant-count
+      - description: Broadcom's variant with custom header
+        const: brcm,env
 
   reg:
     maxItems: 1
-- 
2.34.1

