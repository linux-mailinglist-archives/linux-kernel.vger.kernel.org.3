Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79F5B257B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIHSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIHSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:17:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C58EA635
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:17:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id by6so20905043ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vHTTeB+5l7uNHvfzSP9bEhvHS2VR7qKzMkrLhrmym2o=;
        b=ebynjaknAItswLH0ca5KRpPDT+8Gmin2NRF8pHEmYJFJxSzxHDiMnF5hSFF1pqI+6H
         AAwclXdZ9kym+xAvf+qmLMuEGSrXoW5UuTnJ7SYtZfOaGxKebmjTMtJ3Fn+lYDPxnqDC
         TSjwYv9svQ+8g+BOqsvEDSO61O7COW2LHZg5UnX61jHk/8euroaqfm1H88FnezHFO0K7
         HiVGjNGdEzPAC6ihr89/IDmmSJh101c58bJNWtFSVZ0Xrwl4zB+64BfQKpppZRma3B6F
         egqFZx628xRUNXM04yL9CU68VT9T//twTXxwPjDyeGKnsC9SZi6sW/Ar+LWK8A6/ub1G
         untA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vHTTeB+5l7uNHvfzSP9bEhvHS2VR7qKzMkrLhrmym2o=;
        b=am2EhrGa4QAZDLcL+ZQ0wrq/0UICC+PJpTwwrNt0ti7ml/Ymw2/wj6cCHcL0n2SdWk
         uxLau3w6Cq6fGj/FES4bdgihGlqSQ7ZmWKj+2lsWGLw0gOcbEYgEgWEvRlnTNuEDgitv
         VCUcjcDJmDFp1hZ09FKHu1rreUuy2dlk5ngKwh31sm/MPOQXuacI0Gs3v6AsEPin9C5j
         4qH49wCfDmiCg7h7tEpTfz777YXfeFlFbHj61ERvmJn7QgsH7xpCCmY2dsqpBuezUZIu
         HW5kG5ry5g8YmcOZuTTsTkN+qOJ9xieeh2kxzPzc68eqaYVtqt52+VxOzqQS3HmwLkEd
         xvjQ==
X-Gm-Message-State: ACgBeo0HdUVa2YIH5o4r2+ktGH16RnXvH6ibXtrtsyI8sm23VY9NPx+m
        Y4ihhz7n4IX/QjqKVbGEMnCITw==
X-Google-Smtp-Source: AA6agR6Ex7n8iF7H0X4UPk5I9N9WPNpWVDGhFyrsVCfzPjIYINq5UWayVSWQXlINNonGWply1KJtWA==
X-Received: by 2002:a2e:3a09:0:b0:25e:4212:5628 with SMTP id h9-20020a2e3a09000000b0025e42125628mr2712563lja.68.1662661065170;
        Thu, 08 Sep 2022 11:17:45 -0700 (PDT)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512070300b00492e3c8a986sm3121418lfs.264.2022.09.08.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:17:44 -0700 (PDT)
Date:   Thu, 8 Sep 2022 20:17:42 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        michael@walle.cc, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: enable ARCH_BCM
Message-ID: <20220908181742.GA69385@mutt>
References: <20220906033957.4377-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220906033957.4377-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-05 20:39, Florian Fainelli wrote:
> Commit 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom
> menu") introduced a new symbol ARCH_BCM and made all of the Broadcom
> SoCs Kconfig depend on it, but did not enable it in the defconfig.
> Thus, now the defconfig doesn't include support for any Broadcom
> architectures anymore. Fix it.
> 
> Fixes: 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom menu")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 91e58cf59c99..4c8b09c6b49f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -33,6 +33,7 @@ CONFIG_ARCH_ACTIONS=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
>  CONFIG_ARCH_APPLE=y
> +CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM2835=y
>  CONFIG_ARCH_BCMBCA=y
>  CONFIG_ARCH_BCM_IPROC=y
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
