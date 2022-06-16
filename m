Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE45A54D63B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347931AbiFPAs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348260AbiFPAs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:48:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906056C12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:48:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u37so106122pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qp3edhQcRtMcVJoA9hlhbeV2zjC7yml5vSoU96PZRCs=;
        b=L+UOgh6JQRaNTE/JReN21PZAoB/6nnToA8fEWd5A+dV/kER0XwItK85xWljunHAbTj
         gOaYlkoLs9AiT21Vx1wjmuduTErEd1/98fh87mBOcBvIwRDs7OMQg+T9OkjjR38w5sga
         LmpXul/uvGcZVf+0MZIjD0IOMj5eNX1KXKh9uEOiRQP1MphFTgqUEf/wocXBm9tkhGOs
         3oVI5BeEmbGRlqhvnxG5msKYLs4O6Y39pClLn2jaUo+RbTZoTSNpakdN7Wus8OCgGfgP
         /RTmsCBnKxT9chsIAsIQHwGGdaZs/ySBEqpyKS8SMvKvTZZUxNMPQI63L5K188AIDF2J
         i1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qp3edhQcRtMcVJoA9hlhbeV2zjC7yml5vSoU96PZRCs=;
        b=jjVkQLNBFIWTv0Yabapb5KmKBF1E+fBjw/yB0XDEDF3teMssGE9009xyF8VpIN2bep
         UY5JFJ2ir1fwgFVwhtQ5p1TLPqKm2wPxOfZ4LJ6SnPEfrWJMkIdMLPKr+DUEKE2qj7lW
         GluTMMXteWfbe7YUcMZKEllnouIiG3iVvUSptoPuPxmo+GzGxPvV3UJNOZlt10Vxg4MY
         2q5SMxXOK2N3ZsiXboyv0uKsLiWFwYHT6VQbhHFj/+bVTG8j4kXfpfKSXaVgw3KVi9O5
         F4ZpMQ3y0mdSPEyVl26PS/7DbwTN9ROUStSt6/wrmjAm4nHn76wSLBDNT2zIZ7JuAnDE
         fsHg==
X-Gm-Message-State: AJIora9MB73542LkK7jDWuI6mO4RZJiMBp+JOCRw2KvPyMaU+tWGTdpX
        6440QIM4dttApfk6Oc4kI1tgcEVD8XsfJg==
X-Google-Smtp-Source: AGRyM1ueSK+tw3uFtmBZQL6kWbqp7RpDDRh7PzZWAcZOgdQZukfyMUyAAaRPhzF5ukPOnTqzdqLexw==
X-Received: by 2002:a63:6f0b:0:b0:408:b8d9:f491 with SMTP id k11-20020a636f0b000000b00408b8d9f491mr2152776pgc.496.1655340505789;
        Wed, 15 Jun 2022 17:48:25 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b001635c9e7f77sm253518pln.57.2022.06.15.17.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:48:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        soc@kernel.org
Subject: Re: (subset) [PATCH v2 48/48] ARM: dts: s5pv210: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:48:22 -0700
Message-Id: <165534049853.17040.18012306290229997818.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609114047.380793-9-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609114047.380793-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Thu, 9 Jun 2022 13:40:47 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[48/48] ARM: dts: s5pv210: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/8b86f733c0e512f92e43a9db1559498ef64d244e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
