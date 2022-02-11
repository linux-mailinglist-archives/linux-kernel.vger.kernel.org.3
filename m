Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAD4B26BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbiBKNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbiBKNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:06:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA0F3E;
        Fri, 11 Feb 2022 05:06:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m18so16404065lfq.4;
        Fri, 11 Feb 2022 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+bxWvATPkNOJhL/LdCmA0xomBxVYCMbyohvhLg0UcI=;
        b=U31jAZBh+UkPdAsdfXxNqS06v5iv4Kmb619Q0qXa5b4daXQDdI6iKCr40v3fjPF1r1
         L0+nZvCrzpR8LroM6/TPlloZH9EBRY58oHBMdHmNfPXJPBOMlTZr6M9Uw2jHlsucW0R+
         CYwGyi06XQn+TXUWHqpiRlYgfAAe9y8CQ4rAgsm5NJLgq1C+JquOzdtk0WlFdahCwldN
         f9UcuCvgiA91r6BTgN8spISIu7KNVPCJfD84WMxdpQUKmWfriSjrvHlx/t6NSJgIns9b
         lqo/WnA709FXhudPc6C4aA0DZlueBaZSL3THgXasy/TRimaRAUXzM0kBvIuvyVYUYkFn
         4q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+bxWvATPkNOJhL/LdCmA0xomBxVYCMbyohvhLg0UcI=;
        b=IGd3e9uuzNjNl9QWG8+9wiKSXWT5e4BPGbD567sT96U4Bv+mrZF6GLYRb3m/HUbEYm
         lUyAfjVqcCH2DGc/VriXeOQEre7bAuq6j+u5a7nChnOq0HzlDY7ZewQSe/xPL/tW5eiy
         GHc7DiKt6WSoK9lwjHymfAoFiHE4uYadPgJ+b86XocMuxseT9pyUT5E62wmwYagdZqCv
         seUMffEc5RKm3pSwXgQhDR3LxIkbDys00IJqnXwWgTfH/7Wk6V0jPjQNrOBFKrcx6CEh
         JIqz0DIlzYaaLkWS1vzI27PP2kF6d7+ICikHcPBeR4gibu3N2Z5QjV4+itDlLWxmnCXR
         SALA==
X-Gm-Message-State: AOAM532dzuP9Q9p6801r7BGnCdH6jF5AnUejDuxf3cD18YFZS5SlxOsl
        jHse9phq4vlmZ+xYtP7k2EQ=
X-Google-Smtp-Source: ABdhPJyANwpxODf7FJd9LpX2QULdfogZP9CIp2POXVV9rIbBeWcAw6Pa79ERcCDcf6OALw6cAbfTmQ==
X-Received: by 2002:a05:6512:3d0e:: with SMTP id d14mr1122587lfv.165.1644584768402;
        Fri, 11 Feb 2022 05:06:08 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b13sm3111094lfv.175.2022.02.11.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:06:07 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 1/3] dt-bindings: nvmem: make "reg" property optional
Date:   Fri, 11 Feb 2022 14:05:52 +0100
Message-Id: <20220211130554.13062-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211130554.13062-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220211130554.13062-1-zajec5@gmail.com>
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

Most NVMEM providers have cells at hardcoded addresses however there are
some exceptions. Some devices store cells layout in internal structs
using custom formats.

It's important to allow NVMEM consumers to still reference such NVMEM
cells. Making "reg" optional allows defining NVMEM cells by their names
only and using them with phandles.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 43ed7e32e5ac..3bb349c634cb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -60,9 +60,6 @@ patternProperties:
             description:
               Size in bit within the address range specified by reg.
 
-    required:
-      - reg
-
 additionalProperties: true
 
 examples:
-- 
2.34.1

