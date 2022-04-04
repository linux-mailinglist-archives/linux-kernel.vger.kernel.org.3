Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD44F165A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358437AbiDDNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358273AbiDDNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:47:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270031215
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:45:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d10so6350310edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ag4NtuXcd337V7EAqGGmB9o5JEXFbkeH+3FIqIGxGO0=;
        b=F0mJ7WcX4xs/jOWKodEod/6QWP7Ws2vdXT+KJwA3bipp69Y294eucyZJIPupeUKJ8N
         6Aq2+S80bx6u/ZqROwVieqoEL5yAoKEH0GMrrOc4VbJ9BcKW8Jlm02idcWjg1ImRzOjO
         bu38z/dqyZkTVu0lEJFBfXU6zPJWisFE+Rj1f4OhydFYaC40Ih+a1Q9WitQg/0+CTKmk
         Z2zFcgSVry7N1yP7lLhh0JOUzlHQkLPivo6PVGj2GbDIV88pXNWs4sa8Yq54kyIHdF3G
         mVquOW9lHC2ZyikW2VMY0M8K7F7859m/dHqLXvahTivFjkmaMXM3nusALXtOVmLfj7Ln
         k5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ag4NtuXcd337V7EAqGGmB9o5JEXFbkeH+3FIqIGxGO0=;
        b=uGX2G1xEs2jz4dwOxdAy131okKZeSujKCXD4MI5XISojZpYaRWw/h3twwp/NomBoin
         /ZS8qvwYE+NEk4EyEZeS+5S1KZdFucbyjkNv7Ld4uFhjs7/s1lxnMT/wvBrxwZonrFe3
         dfIksGIFTyOwp89EvmUfjBvEan8njbEjfzTJRyXY6KI+4xWmpzvGIfk622o64P088X5F
         eAeSE9op5fGqjbiSdJqr65OKncLOBSpfWn6Unq0nHduv7KBQh8YzpQuxWCzSAL29xeNG
         FC/BX3mnJgEYWbYLGROWq8sw866FLzSPDZWt62VBTBXJsVYsE0n8QCiki9I5OOaoDfVi
         INfQ==
X-Gm-Message-State: AOAM5313p+vRooGc5a2IqooS/P63oKRg4jHye4XSJo8gQvNz7Dl6H8DL
        r/seh4pvaU4uHDBaPGjAED9C4w==
X-Google-Smtp-Source: ABdhPJwys+HV9TUCHNVVEmCAx3DDsJ2cNjVstxGVCnIgM8Bc/ms4M+z4PvyJ39/sEk8Lu/e3YL4/Mg==
X-Received: by 2002:a05:6402:5201:b0:419:4c82:8f11 with SMTP id s1-20020a056402520100b004194c828f11mr77514edd.133.1649079905006;
        Mon, 04 Apr 2022 06:45:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm4409273ejc.174.2022.04.04.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:45:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     netdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/2] MAINTAINERS/dt-bindings: changes to my emails
Date:   Mon,  4 Apr 2022 15:45:02 +0200
Message-Id: <164907989905.809631.16161802401962719876.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330074016.12896-1-krzysztof.kozlowski@linaro.org>
References: <20220330074016.12896-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 30 Mar 2022 09:40:14 +0200, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Hi,
> 
> I can take both patches via my Samsung SoC tree, if that's ok.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: update Krzysztof Kozlowski's email
      commit: 8a1e6bb3f78f06432e095758476358d8cb63c03d
[2/2] MAINTAINERS: update Krzysztof Kozlowski's email to Linaro
      commit: 1a9f338f9cf96f8338d5592dee5fce222929e4f7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
