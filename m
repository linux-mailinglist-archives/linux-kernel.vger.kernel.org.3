Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B945955C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiHPJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiHPJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:03:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1F8277D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:14:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u6so9780790ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LbMDJXoS9x8FpYW6Y68J+/9gNIBvbIu8BeEES1UgWL0=;
        b=Lit+hPTJkMv/nc3d5jswLDaYKakT9vO0wN4wfwHnePRwFwPHCeqsVIMTTJbAM6Mx+G
         QhXJsYBnl9jtPOPEu9+s9v9F5RQ/Dc5lZEPO1yR3UsPD5jEvB1+ctVH0s5imKLsu51Tg
         zt0YK0Vqwz3FBmWw1h+HxBYEaKFreVkp0nUDLUmi9Aw0XeXOui6UOc8RxGar7x7GLZPM
         1CJ+suebgiU2dpXN6T5rVpJ8aiFLqThTAWuh34P6FPWY6oHBaBDBVBMttb1bp/80pZ95
         VZ5d9uYJtlIPVD++6X5wSUPm2HxUW/ySnRSQ82NR8Q8TLH4lq5E4n5CN0wk9O41abqA0
         sjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LbMDJXoS9x8FpYW6Y68J+/9gNIBvbIu8BeEES1UgWL0=;
        b=qgBvC5OpJB2OOvwweCG0qJmn9EN1FOgjklza1NPJ7LgOmNzB71dQxzzNPCB/4Nlm4T
         8meWSuAWSlB6/Jg+FoMi+qrOtVY+EM2ryJyUYAtehdMp69IXE+01s77GsUf16IqArnzj
         MZfRCirP9ZdDDm3398Fjw80tTK/BvG17sET8kdoStPodysKnF2tr+GuHTLtnI0px7tOW
         A0iP9bIMurpz2enN1AdGM4gcehQZ7YL2lXt5/xrZ02N7a6Lr8+jdxZzbnV9Tn5+cKDG9
         Wtas+v4BNZvP8OKAOPJV2AsS3fd0EYua3NG8BBtlbKUr0OrCfPR1CKqD6l24zPZxUdR+
         csyA==
X-Gm-Message-State: ACgBeo01DaoiSAYZEdGM81TMQ3VRadq+1kWxalWPiE2Rsj9S8mIILIKL
        1bysLJ8Fz6xlKtPUtpZyJxn2AQ==
X-Google-Smtp-Source: AA6agR7r6LX7onIecIEwrZ1MFUwbK40aVSeFO4I1RAeHNwRERE+rCTKnJJNtq9s/rXjWpnTCNslVEw==
X-Received: by 2002:a2e:bf29:0:b0:25f:fbd5:b693 with SMTP id c41-20020a2ebf29000000b0025ffbd5b693mr6292721ljr.372.1660634097606;
        Tue, 16 Aug 2022 00:14:57 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z4-20020a056512370400b0048b06f34566sm1299951lfr.76.2022.08.16.00.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:14:57 -0700 (PDT)
Message-ID: <c411c5c5-0a8b-c85c-2d57-1a387eb0d28f@linaro.org>
Date:   Tue, 16 Aug 2022 10:14:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for pinctrl
 nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220815122503.2768-1-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815122503.2768-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 15:25, Allen-KH Cheng wrote:
> There are 8 GPIO physical address bases in mt8186, corresponding to the
> items of 'reg-names' with the pinctrl driver. but the order of

New sentences start with capital letter.

> 'reg-names' is not correct. The mt8186 pinctrl driver would get the
> wrong address, causing the system to restart when regulator initializes
> . we 

^^^ Something is missing. Sentence looks unfinished, full stop is in new
line, next sentence does not start with capital letter.


> fix 'reg-names' for pinctrl nodes and the pinctrl-mt8186 example
> in bindings.
> 
> Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
Best regards,
Krzysztof
