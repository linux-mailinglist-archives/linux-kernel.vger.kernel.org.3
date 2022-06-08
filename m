Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61450542B11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiFHJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiFHJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:55 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9D71A20;
        Wed,  8 Jun 2022 01:38:10 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id d18so1857298uaw.2;
        Wed, 08 Jun 2022 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCnLOphCt+08rnW6Bf3ZKVI97neHMvVrCCr7P8qrig8=;
        b=T/mtcnXDFJH60GsSRYEsBUujNzgVT76/u1USMBiIx3o3Ayte3GQfzAfNn9dTxzi+ns
         OfA8nfJVohF3xMJd8Cj3Z1ZMRFlIMNMju7RfsHwVCtJcqhzvC0tYaycakQYjBttp+5KA
         fW+XajdjvZJ+VhJlY1XG0ubIarM8bnsl7eWbfp5wGwl1ywJbStgbA4feFlC6616eR+9y
         FeJkiH6tn+nx6uTEdqpor2joDIEwJALUr9QSbQAyeIrGHgLZiSQJUgF8RPIZyYf3smrR
         9YS51LjZKSOaA6ArwJfT+y4ota0EPk/RwGtFPV2KLeRg/R2gs6cpBYxqeDQXsVJQvSOu
         LO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCnLOphCt+08rnW6Bf3ZKVI97neHMvVrCCr7P8qrig8=;
        b=oZNyGHdeVKDqt+yzszTBvZf4Hoh/r8ak9O0aKo1RiR4WaW2lTThqMArxK/1aXR5vUq
         77rUYiNIVgCQUDcZjngT1YbZIfQsmVkKL/AdYYbHyJ0qWsdpxm8o2Kyc8iP8ZBsG1U77
         L9WDzNTWHbc6UP74Sms1VaYeHL7/X0zTCp5z4hYSMyp+Iug9LiPcZC/Wh2ZulkRd6glN
         Re3DGdaELxpTOT94KN7j5f2f0BA0EXCyQt7WvDHpAb+kSpzkxjd6k+yHh45smUjC4efi
         G2xFqqYYmUUrpzkR/b37m9Ry0yQk5m4auYDWTa2WukulECNq3Uhzaj6Y51ruG9tTOxF6
         ZTXQ==
X-Gm-Message-State: AOAM533BBiHib4Gu57qGZGDQpefu9GnGEKV3vrbm2kFlUVGiTaWLQnMz
        OQxNcuz0pONy1hYhGF2aO9Q=
X-Google-Smtp-Source: ABdhPJwsGbuEbEEjCwAe2JBcis0lWobPPTWrd9HB07Brj0SatLkx5Rmp7cU+9oa95Z4Bor/oG1YMWQ==
X-Received: by 2002:a05:6130:90:b0:362:891c:edef with SMTP id x16-20020a056130009000b00362891cedefmr36593654uaf.106.1654677489598;
        Wed, 08 Jun 2022 01:38:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g26-20020a056102245a00b00349dedb879esm2215310vss.1.2022.06.08.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:38:09 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        florian.fainelli@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm64: add BCM6858 soc
Date:   Wed,  8 Jun 2022 01:38:06 -0700
Message-Id: <20220608083806.1451393-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601131944.v3.2.I2bc1418dd24a902e941c7073bbadab00568b4f5d@changeid>
References: <20220601201958.3072173-1-anand.gore@broadcom.com> <20220601131944.v3.2.I2bc1418dd24a902e941c7073bbadab00568b4f5d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jun 2022 13:19:57 -0700, Anand Gore <anand.gore@broadcom.com> wrote:
> Add BCM6858 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
