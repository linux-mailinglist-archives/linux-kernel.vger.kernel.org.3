Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61684BF81E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiBVMjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBVMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:39:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6A10C531
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:38:39 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4BDE3FCAC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645533517;
        bh=tCoZe2yzRkWx7YBNb8KVNP+e9eczVEpZUbOGuRodh+c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=E1cyq17LN9Gbq6HFbjl0wlrrZ9GSSuV/g8M6d/YVuyFCKEhfS6oIxkqJN1kC2Dprh
         IWzirtTidad3oZnB8EtGIR3E+FDBQGlC1zvq++jTfDpZyDyXyy1dHFd/UKtqA6BH5j
         J9vGSWRMojzrRMw0t5g+xn0EGF/aumJDG13d4wYe0xLheVSv05isf8Rp+AcQkNynWH
         K4y7J0GdmyMKMg22ELXjOM/WUXL7YFlpoVPiczVq9jTOD4of5mwqu9hi4rn+wytFk/
         63EiCxe7nBHc3qcZX/Yg/iewFpIvx69bXw9yMVYd8hBNFk4Z7lqrdy05LtsJeb2qep
         rHUF7uWpjWlIA==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso5685485ejc.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCoZe2yzRkWx7YBNb8KVNP+e9eczVEpZUbOGuRodh+c=;
        b=tURnebzIDR1g08r/IHrntVrzsgFVP+nFtem8Sxw0rQod2gFxDaV88Vr/lDVDIszTcv
         cwH1vMCEpgYG/QyXXP90h28R2sjQAWHj3yeklSEty8y9BWk/RxDrwx++OHKYIvypQiUh
         DFLtX3Yo28/AttjEyLIwnSE3rxDPmcMT7gd9/sonMBiRydDsGIH/18rNdOgrwiJEAGAJ
         8gPgXcoVKVYUbsONHHp16ZPxJljXDo6cKxKX1XikPrBiUZFDPpp8FNhJ0DCG72p3XOcq
         J6KBWoYqeTTaABKnP7DytY4T7IFVZPuNcbwTic+6beep5A/FejQMHrJ+VH+BaF5h4wdW
         Rw5A==
X-Gm-Message-State: AOAM533jFeXxU49YmXaDi1YbxcKPjRrVP73UwHwHPxkoYbvjZ1eZnbTp
        FLrZ+vD92gUiXNDqRBu22UNS0vY6DQvQpLpzTrqHtiBsVg3L+xFx6HnnKXFMsjhwUAzDE1+Ft8b
        toh1fwN0U3nffp9xDDpeSBDPcw3kgacqRYg8a76x7Lg==
X-Received: by 2002:a50:f159:0:b0:411:29b9:1323 with SMTP id z25-20020a50f159000000b0041129b91323mr25718217edl.258.1645533517381;
        Tue, 22 Feb 2022 04:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZVSJL6nHxnMssJcXHLs+QBrBhBgOHNGm9aPdXJN3nivIczMccX7Nia80GPAGsF7xhGVVojg==
X-Received: by 2002:a50:f159:0:b0:411:29b9:1323 with SMTP id z25-20020a50f159000000b0041129b91323mr25718207edl.258.1645533517239;
        Tue, 22 Feb 2022 04:38:37 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s11sm6401498edt.10.2022.02.22.04.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 04:38:36 -0800 (PST)
Message-ID: <83aa53cb-e444-9397-96d2-eaeb92db6492@canonical.com>
Date:   Tue, 22 Feb 2022 13:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: samsung: i2s: check the return value of kstrdup()
Content-Language: en-US
To:     xkernel.wang@foxmail.com, tiwai@suse.com, perex@perex.cz
Cc:     s.nawrocki@samsung.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <tencent_5F9F4223DC44A9ECBF02649AF934F786E305@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <tencent_5F9F4223DC44A9ECBF02649AF934F786E305@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 12:53, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is a memory allocation function which can return NULL when
> some internal memory errors happen. It is better to check the return
> value of it to catch the error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  sound/soc/samsung/i2s.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
