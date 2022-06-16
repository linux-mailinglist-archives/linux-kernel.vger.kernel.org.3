Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57254EB96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378783AbiFPUsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378680AbiFPUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A61580A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i15so2200118plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HwpxIRU1YP5mS7rI722x2pEGkj9mnH3zkSIGF4XZfkw=;
        b=H+GEZ/oe8IQJ/JYfvS4J32+1xZWVlN42/Sof7T3f6SQnLjA4UioVEfZv2XNGnwY5ld
         HBCN2J06JdSnY66BOnK8GIig2rncTQDRrAtVkUq2BbKa4NNOMZiieuP50/5EOc+kwyyb
         E0ZWVFtJI9CMiTTztMqsbsijtJhKnG+JSAtnzLkIX16lVTd/5PEa9Y6fJNmkz6EzmxYK
         wAv5k8BoyAc9R7tNFWBaSjp/t1VCTwNE38E0i2LuTUZu7AjbpfbmzrYKKASxEahmNpRT
         2CW4GfcIH/sYLAKYWzb4nadM6fhpBUTEdbzhUuLnJ3mJLTzK1worzCc/Jbv4fmjfNCvd
         uUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwpxIRU1YP5mS7rI722x2pEGkj9mnH3zkSIGF4XZfkw=;
        b=FVD0WBbT/vhlvVcFbH1XuiTP9gUJIENnP0eApWxXV2/aXtZRssYpOuxHAoymE+jd3I
         s7ZFNx2b/ox9JMJ9XoHrFMHWVfSaX5xL+eIx2WsRBHUzCbSYEVT1ZjlSc4Dxc4JPMsTV
         vDVv3TfjRCjJ9P4YIWz3ZfIVQicK4XTa4dXM6b+d8vAOQxW2plwlYvFZLzcE0FrYdq21
         V04WLAKQzpCDHcuIgNgs34DLaN5lxLnmjQ27p1tyGsLlaTZtImGLwi7Sptz1Pic3SdVf
         785STFDXAdmopqDZQCwDmPpa2sN72npVPIgkeHme5KBjw+J4S0djELDsmBp1JxN6BHYM
         7Zdw==
X-Gm-Message-State: AJIora8WlR2wFt3+U15vI2CX8glBBVCPxLRaxFw2Nk25fv9VaHby6omA
        Dp9C0OPFY/fkdBa/DpMn3p5W1g==
X-Google-Smtp-Source: AGRyM1sr3digqWzsuQHcTLrp1uORT1LTuFJyjqrjB6rUq0i7WEUzZYw28ca4WoTNzfL00h0uYD102g==
X-Received: by 2002:a17:90b:1c86:b0:1ea:4ceb:2788 with SMTP id oo6-20020a17090b1c8600b001ea4ceb2788mr17942171pjb.16.1655412472175;
        Thu, 16 Jun 2022 13:47:52 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 5/5] arm64: dts: lg: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:12 -0700
Message-Id: <165541242280.9040.13928331829387540336.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204606.833054-5-krzysztof.kozlowski@linaro.org>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org> <20220526204606.833054-5-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:46:06 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[5/5] arm64: dts: lg: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/b88d11f84da6dd41dbbd4e20a889182aba634b95

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
