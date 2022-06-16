Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741DB54D687
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348429AbiFPAxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348823AbiFPAxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:53:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9325536E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:53:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i64so99172pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qwwQJJVg91/nnmcAMwyXvHYok0DyJzSkywxG0QwUEU=;
        b=xaURczxPMBttLVmTmtGaORZcEYgKETRyblkz+ZCrDhSyDx2Tunc/S2v8DC6VVYxdqK
         sRYGcjKJkLZD2qlzFfenHjs4qBn6hPw5b4IK7kPrM9ujAYOCNJATsV5dBU/o215GwiWs
         Y4mVuoaR/mKo2TTBKc4n+bFkeF3Z+V77bUy6so1KRprO3lBj5ovtvXtmyk1rWLtmw0Tw
         uVcOPE0LvTostMvW0hrjQfH7aRN1s9fJ/m8qN8u3k1UgWCk53kA03nG4zENG4/WdKUU0
         v8/TRoGNfK638qSEbnBztIgwoL343SvYPGytjPwWSOlFI/Bnx+hHLBRQQJjMcekGRxNC
         bYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qwwQJJVg91/nnmcAMwyXvHYok0DyJzSkywxG0QwUEU=;
        b=CVnfl7EIKQPj4azU08H74Ly7WZnh7Dl9q3sox3oSy2HEyGSqQlzcCUMp5hHyo9VmYO
         f3HzeUkNy6ormecWNYmP0AYcDU3wc8z7xBIbLUUguDHospsi2SpRDeq1gjRQn1dIbb58
         W6l5/BaDRuPxQG5kae3x+tDosJoAeuKXLtfNzVZZhqd4XYN775M731i/FI0tLPJ43RnO
         06yUzsaliCMeD8m9FYs2H885pE3E6i3vumgaMqb3vHeZYDSjUFIiTdC1OY5bXKA0icm3
         Tqiz1TWgQM6ZiUVR5Yo7ygSDcxUfe+MAT1l7wx/+xEAj4HWASAn7SxOIzsBBjtO4yvWO
         Dorw==
X-Gm-Message-State: AJIora/qyXz0816QlBvS9sdy/TCchIp8hzWeop+wO62wtdpawM7pGg5x
        RMjkmxEOYMU0VFAWmh7bYJKGaA==
X-Google-Smtp-Source: AGRyM1tlL6hO/EWZAR4S1GVC5e2TtQKXy+/+OmKG6Mf2UDs62lOXQ/aqvgoOhUOd/krZOVlMkKPPHQ==
X-Received: by 2002:a63:4e62:0:b0:398:cb40:19b0 with SMTP id o34-20020a634e62000000b00398cb4019b0mr2136424pgl.445.1655340831593;
        Wed, 15 Jun 2022 17:53:51 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:53:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/40] dt-bindings: input: gpio-keys: accept also interrupt-extended
Date:   Wed, 15 Jun 2022 17:52:56 -0700
Message-Id: <20220616005333.18491-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each key device node might have interrupts-extended instead of
interrupts property:

  fsl-ls1028a-kontron-sl28-var1.dtb: buttons0: power-button: 'anyOf' conditional failed, one must be fixed:
    'interrupts' is a required property
    'gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index e722e681d237..17ac9dff7972 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -92,6 +92,8 @@ patternProperties:
     anyOf:
       - required:
           - interrupts
+      - required:
+          - interrupts-extended
       - required:
           - gpios
 
-- 
2.34.1

