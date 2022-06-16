Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096FE54EB86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378777AbiFPUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378607AbiFPUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F113F49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2519512pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yUT12NimfSVxM1vXKEVoh3l1sSHT4i0/7W+Lzsy3qfU=;
        b=jAjhIgCqZS0WdZhuO5o8Wv8KaZh3USMck9BM9t0zeFoDE+7PJj+335s0L+SjMAtHct
         cRTA9U6KYYJ2HqIQyuADAfBnbeIHv7ZL0nKY8G31R6Uja6fKosCqAzWQlRVbPCLd0R2n
         L5CsjA76V7Dj8jlz740Nf6CggZNRG/XyRWZG5Wu2ErDJ+ccSKrASnlVL4huYSYQ/y3LV
         8RUiOHKdrGg+dOIQwe30hlspE+WW9wn1UfcFzDfVzA3/Fa0ywD3f7cxOIuG28EgKar9M
         iSedGHkdYP8IojJoAzkxNjzh67DowLc4QPIt1kpoakJ8BcF5U1Eq8J4VcEvNaTXIViEx
         W6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUT12NimfSVxM1vXKEVoh3l1sSHT4i0/7W+Lzsy3qfU=;
        b=bsc9lzIGc6LY5XkkbvMybtj0DJn6rJiydGwSOP5HL5f1xKkb3uP+3vTISr0bFRnq+B
         TRKziWlMzaQt69ONDuMi6U4+PSM3rWNBzceii7WmsbSFPqZalCvp5O+jXUkC54Gh1ioL
         O36xmScnIYIfOorPtP34VbnPkgnXQLWprLdV9ijQxxOZPrRJ8gI9T5sqFBelRZa3PU74
         JuENaouHuoybLarGzj2ingoQAAR+zhssBsFpJfV0NTA8MRGTx8E4M9awb7VuDtx6SRC2
         80eqAp1WmLze9J+8ooQsUQt/DzgLcQnUnXUKXTdcIDInyNZYtURaNQ/ogkOP0ibqbAX5
         qkHw==
X-Gm-Message-State: AJIora/vtdmOCzVK5xMyDhDa65n6p4KRWfXBBahUV8Ozm4NUgxgCQdZT
        ouu3/CFbadnPETJOe0KZkFLOcw==
X-Google-Smtp-Source: AGRyM1vGMUJykCffSieo+KG9Kp9I4qtTDoyFIcjZuSRpxKr47F2zSqYhefxpprMNRLzX4BnlSHeSMg==
X-Received: by 2002:a17:903:40c4:b0:163:df09:904e with SMTP id t4-20020a17090340c400b00163df09904emr6234179pld.155.1655412471343;
        Thu, 16 Jun 2022 13:47:51 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        arm@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 3/5] arm64: dts: apm: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:11 -0700
Message-Id: <165541242280.9040.8399919480828171223.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204606.833054-3-krzysztof.kozlowski@linaro.org>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org> <20220526204606.833054-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 22:46:04 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[3/5] arm64: dts: apm: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/d57cc3b903db4524c556325008071a7223690083

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
