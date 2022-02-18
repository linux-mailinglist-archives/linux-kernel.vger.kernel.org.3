Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F44BB9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiBRNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:05:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiBRNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:05:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D082B461C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:04:55 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AEB5E3F32C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645189488;
        bh=+odAnFUpRotjyHmxRngOmP1U54MSnL1E+iRodbsJpEQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gI9K6l+YpdYDzkLSKf5zXWXXw1Bamq0+jHqL1mZdq8y59cRI2tlf6wQpGn9+1gAyi
         3b5LN871ELt1zS7JZRz8OAv8LNxHXPyJ86LZQshjGX+NpZ3ev/iH20QPU0YMMuVRai
         xSSFUYaK1puzi2kyoFf0nky7GGAp5CbywtzlINoUXXDInDnGYfB+Fkoa5l+u7SklJV
         q/KMDvrlwd+O8u+AeO1EEVBX0Dr+phVeAND9IUg4apVrEUqvgyIdlchGfZyD15F4IU
         ia6e15fNoj3n11DcLjv+QRUtWvA5Fk1KjfANZ5Cle7GpHQLzht3ulbHIU+IjTq/gdK
         ldXkLwezCFc+g==
Received: by mail-ej1-f70.google.com with SMTP id q3-20020a17090676c300b006a9453c33b0so2992360ejn.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+odAnFUpRotjyHmxRngOmP1U54MSnL1E+iRodbsJpEQ=;
        b=Fr2I4PsFCZ2ZZGxs2k5+OpsyzONaEhmP6dskObXR9fzppQ3vtHDjgwyybLUCcSzXne
         6FdTPLt5FVLR4a+vJC04GTk1u0rnWdveXByt1/1q+f1mi9OrmQ993w9ZETSiGBypGtXE
         6jHIfWnCVi6ya6NxqVBKQa5YPvGmk4Pz914pA5e/uW5YCv1154IO6G4dL6tAwTEe06Yk
         7NCQbBvuh8PrgGrCdtc615vry2xQmceQlKjEQmi1w8NvQmoDanD+To9NABnsYxtiS/1v
         bpj3hg4g5bFXXT/60ckzuUCyIIy11cwJyn/6DkfXLfRdTon0e7D8PUFbduAAS2PZOgwW
         ZvSQ==
X-Gm-Message-State: AOAM531xlKPRNM7jM/GoV/Inv7xt06k7QcKYIHM1XNZT4qyny2dQSqIA
        TkB+WpGRG7UotYXPZxx6/1BIiFZIvYyncqqLPHrdKDwNoJE4xYw9VOtx5Qsqobm5VtUgcBpC444
        VHUe8u4JPIrtIIYofFZfdkiEFunm8WoLdrXSnliIZQA==
X-Received: by 2002:a05:6402:1684:b0:410:bb26:eb0d with SMTP id a4-20020a056402168400b00410bb26eb0dmr8266801edv.449.1645189488081;
        Fri, 18 Feb 2022 05:04:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvXxpsh7iz0pdqJwwrlptZe6U4CiyjPefOD8G89XYUluWuRDjSANbzlcyjvg3sshclFXdY5Q==
X-Received: by 2002:a05:6402:1684:b0:410:bb26:eb0d with SMTP id a4-20020a056402168400b00410bb26eb0dmr8266780edv.449.1645189487873;
        Fri, 18 Feb 2022 05:04:47 -0800 (PST)
Received: from [192.168.0.115] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id pg26sm312856ejb.194.2022.02.18.05.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 05:04:47 -0800 (PST)
Message-ID: <028f766d-e5ba-fc12-665c-8f65d6bdf817@canonical.com>
Date:   Fri, 18 Feb 2022 14:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] memory: tegra: Add APE memory clients for Tegra234
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1645186589-25118-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 13:16, Sameer Pujar wrote:
> Add the memory clients on Tegra234 which are needed for APE
> DMA to properly use the SMMU.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  Please note that this patch depends on the DT binding patches of series
>  https://patchwork.kernel.org/project/alsa-devel/list/?series=609494&state=*.
>  So please consider this patch once Thierry picks up DT binding patches and
>  provides ACK on this.

I was not Cced on that patchset. Could you use
scripts/get_maintainers.pl for obtaining list of people and lists to Cc?

If Thierry picks up dt-bindings patch and I take this one, does it
compile? No, I don't think so. The order is screwed. This should be sent
together to make such dependencies obvious.

Anyway, I cannot take it so:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


>  drivers/memory/tegra/tegra234.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 


Best regards,
Krzysztof
