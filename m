Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069E598570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiHROI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245644AbiHROIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:08:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DFDB1E1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:08:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx38so1816015ljb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wZWNoQ9jd+6KChF/G6GSiaIJiZ5G1cdiC7iDuKt3ngk=;
        b=HreSCQJ90vEq7WkznNLaMC0IwyxoaF+IfY3cbQy/wkbPnMAjP0JrAJjwuhoqx1fadt
         uiNqJYxUlx4ualcpm853nUFXy0FuqI3+uxTfsbZGURUY7MNUt1/33mybDV/Sct2Ue2/9
         44er/C4IewcSggLnCX+yiLk5qBdQDEgbgxNGzYUblO5d2pjFvEb+hmL+YwprHJEH+y19
         uh8Py0MZ/ws3AzlzpU+bHr1ORP5MvtSaohDChaLlyVRq0Ap4Ej3vrlvliPtNS2Xu9Q3i
         H6ZvYpN71ghNWnAORAOgwfKgZhkKBMlmzQ5WVASLEOQOSvIjjeAMQPlHTfOlua8KaXQQ
         X5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wZWNoQ9jd+6KChF/G6GSiaIJiZ5G1cdiC7iDuKt3ngk=;
        b=PrWghA0QJ1rMiKWNw9Dy2eaoYi0xZbEbd7H4K+fWwOZApA7aaV2VDnpu1HizteHH+P
         qtCK7jOViDvrGiLbUoLLkWQ46xZ2lOxjGPgajC6mJ+0GXWVWx1IHzR7h8lngPfw+0cdE
         AHeh7NtQWmpl152il0nccLPPogbIuwqmzcmepH9pN/gpIXbwN3dU6C9Gsf7ACLiVWGb+
         sRYBv5EJjaZFQiwwUO907sES+z57T6+xYoyK3LpSdjq0/aE3XN20xquc67gunAoMK/e9
         1ul3zSNKlJ/cnimVpW+8qKEWIG04jY68WTZynFCcnrJnqyxjObhNvT+0w4Cq2Hvm+x24
         hD3g==
X-Gm-Message-State: ACgBeo0c/2L+tHR0IVEo9+2P9t3ey1PIhyQl+5st625JsQuaukX/oPtv
        A64asFz7Kpqyi0vNsjXvlarLOA==
X-Google-Smtp-Source: AA6agR59qSIqkgbq9ojwDm4Du9sO6w1tJlH1W4lPC5yGAGaKd/MzRdSsesks158T6ARTDgpH3PMJVg==
X-Received: by 2002:a2e:a99b:0:b0:261:b1a1:4ee9 with SMTP id x27-20020a2ea99b000000b00261b1a14ee9mr1009801ljq.366.1660831697519;
        Thu, 18 Aug 2022 07:08:17 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id z24-20020ac25df8000000b0048b16d0b7b7sm232318lfq.135.2022.08.18.07.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 07:08:16 -0700 (PDT)
Message-ID: <3b4fd920-1f9e-de43-b436-85d73cf12f8c@linaro.org>
Date:   Thu, 18 Aug 2022 17:08:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-3-bchihi@baylibre.com>
 <18164de9-ad28-939c-a802-69647fc65a37@linaro.org>
 <CAGuA+op3tFL6M=H2rzAB4DJn+7ve4W5vUuRc+zBrq7zQY2CX7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGuA+op3tFL6M=H2rzAB4DJn+7ve4W5vUuRc+zBrq7zQY2CX7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 17:04, Balsam CHIHI wrote:
> Hi Krzysztof,
> 
> Thank you for the reviews.
> Would you please explain the meaning of "Rebase your patchset on
> decent kernel tree. You seem to use something a bit old"?
> It is rebased on top of linux-6.0.0-rc1.
> Am I missing something?

You Cc-ed me based on old maintainers entry, so either you did not use
scripts/get_maintainer.pl or you used that tool on some old kernel If
you used that tool on decent kernel, you would get different email
address. That's why I asked.

Best regards,
Krzysztof
