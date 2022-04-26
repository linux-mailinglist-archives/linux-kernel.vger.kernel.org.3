Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6B50F2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbiDZHwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344308AbiDZHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:52:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5F1A824
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:49:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g6so11493915ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tkdbdbYIojPDmAwAZfQ+/1PtTpdhxbxhefzw8NVXbmI=;
        b=lsoAHvuLO5ZBJ4I/wuHwichXMdTcoJfnk3G3OoqzyCNh8rOUA8VOLNYg+dQMzb2K7j
         4ueimla2x0izZUtnUG6xK37caGlNxFlhCZcW1yj2ex7hbTnAIaW+i11NCReKt383VldV
         Prq2GGKPcADkiCEghOz0MkHKBz8Rrptkt0eP8DwSOv37J2BOh+9X1y3M/uDfs+QMEVES
         z74SrKfVEHZsvbNPjnH93krRO7evsEDJ/Eyuu4+8PImgT2Ws94RKgp0rTCl/YzO4vRlW
         Q97zO4DaFE7g85EOiF3v/IbdYcRIGFON33PATzH0nui+MMLzE8MTUIIr2RiZhTq8GsUV
         zCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkdbdbYIojPDmAwAZfQ+/1PtTpdhxbxhefzw8NVXbmI=;
        b=FNYTvtUnOBWW+AgHOcn//G1pHoholsL/bIWY60jpE3168UM1UXvsKyEJVl+o0N5t4K
         8qxKDtaFBuIJD3PSrOToo4imhBeWkDX7Z3mq2rt3EvZCuQgtp1kQ89XcijdDBp1FPB0w
         IkSq0czRaWd2xqMPag2ZPiqCMnMOnbRlss3PpwQeK9RUCRvPpUNAaUbzbCg7q7zF5XAm
         1E+R+D3J1vpsCddG3bNsXMJSbjBMyZmWJOEFAnX5om274bl+VKo/ebWqD9RtymdXjVr4
         +ZluwLaTehZ3qROGh7h0EXAtIK5MOrRhcaH6dQt5CQsZ6JNGwUCr0RAVkD0YqtUbJqHS
         oHUA==
X-Gm-Message-State: AOAM533SvuBELRGeBWgBLEnOj2dT5suQcxdWkySuUtyDFSDWD9YJoZXH
        z4Q3C7fjSXuTKivZV1R//Nwiiw==
X-Google-Smtp-Source: ABdhPJxTyGPlzI2jDh7Y3jEnEkPP0vlIb+Ra5+WjH8jUqaMY60F9ggg2IAVzuebLAJBqHUQCnWhTWg==
X-Received: by 2002:a17:906:9f27:b0:6ef:af55:6fb with SMTP id fy39-20020a1709069f2700b006efaf5506fbmr19774809ejc.185.1650959355101;
        Tue, 26 Apr 2022 00:49:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a94-20020a509ee7000000b00425e7035c4bsm2609198edf.61.2022.04.26.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:49:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] memory: da8xx-ddrctl: simplify platform_get_resource()
Date:   Tue, 26 Apr 2022 09:49:12 +0200
Message-Id: <165095934975.35085.8323122039661278218.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
References: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 16:28:53 +0200, Krzysztof Kozlowski wrote:
> Use devm_platform_get_and_ioremap_resource() instead of
> platform_get_resource() and devm_ioremap_resource().
> 
> 

Applied, thanks!

[1/7] memory: da8xx-ddrctl: simplify platform_get_resource()
      commit: 933713f5f49b816aa13a6441e41d98febef84dbe
[2/7] memory: emif: simplify platform_get_resource()
      commit: 734058b14de27682a176331ddd49fbdacdac1f46
[3/7] memory: ti-emif: simplify platform_get_resource()
      commit: 083008defd83cb1ab6f9efaef6396bf4534ac6eb
[4/7] memory: ti-emif-pm: simplify platform_get_resource()
      commit: 8e6a257a173378d0fb42d64865545286f1f84ef6
[5/7] memory: tegra: mc: simplify platform_get_resource()
      commit: dab022f22e3769260ef803eb7b70ec59df796a5a
[6/7] memory: brcmstb_dpfe: simplify platform_get_resource_byname()
      commit: ef231fefa47f9c694a8a5bbe16cb43b5db62d6d6
[7/7] memory: renesas-rpc-if: simplify platform_get_resource_byname()
      commit: 2ca47b33a7794ce92ae881d6d62affea953814cd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
