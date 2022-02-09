Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB824AF149
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiBIMTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiBIMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:18:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF07C1DF8EA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:08:02 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B2983F1E9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644408475;
        bh=pRag9cOIM4CLzsxK+XeyiBU0JF+YtVMAHEpcyJclBbk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eutYFcrDeQWYaWKeSxfij60ntNujIsdOmJn6dmAGzbtYz/wyAbht+ifROc2jobVXm
         ZYCXHVMRSzc0aHSDRn+ElmFe7K/Cg5QxoPRs0zLGyMlwGAreTVXTTjCBpQOUPTsfHf
         PerN3rV2uSf3nrxD/RNVLUr5Hifrb1ygENinXEfQ239kt57BEC927j/m4LEUk1seWQ
         Ze+4idO4qkUQ5aNPISo5dFpfuqLjyCksb13JHu4irO+kZ0iJbrjJ9fGQLBC/fwKCEH
         kq/N7RaR/hgJM+sN2cEwoP2vz1FQFl1gDpOfsW1l5BssQIjeT3IMADW3w3QhFJV7eS
         h8DyV/liDHzrQ==
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1073075ejk.16
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pRag9cOIM4CLzsxK+XeyiBU0JF+YtVMAHEpcyJclBbk=;
        b=cop4Di3OgClW5PH1gukB3dWyHMP27mMv956mirr/voITdKRzNP/18T0i4NJ6ivWNmY
         04N2eSg/ILuhCIoU3YbbhZ0ShHGZDUn6yH4xKoxix5u69DLfv1j/LB8nAsftHhywmXFk
         V2yZXveDE1widcMcDd92f9B/s71EfwGn6p01jrtzFElAYYPLqFnhZqgyqGx3+psx3bnv
         F+09EyOZDT3bx+raOsAbxkWKiXT5TiGnuojXpInUXIJq0vfmKSoKw3T3qXsWAgsHqwf8
         ddW3k3PLGS0oAtaKW8a82aPuNoUkOHkFCd+hrdaM9uA0zKZKB5ymR5CWjg1k9+qRRk7K
         NyLA==
X-Gm-Message-State: AOAM532qpQRZCRIOP8UcX72VunT1x8Erzw7GtEp6PUIzw84wzMHuBZnX
        7IesTzw6rDcF/XEFQWPFY7TdZigHeaBny8F5fBI3YxODtMJwnKnZQOilBLbD33yZgIcPKO2rlSO
        rQncnLWDndSJJ3VUCd2fJ+On9tZj1OqRAmc3xL2lmfg==
X-Received: by 2002:a05:6402:38e:: with SMTP id o14mr2091377edv.414.1644408474769;
        Wed, 09 Feb 2022 04:07:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzp9D9NxZvABqtfCoI3O1I7fzjAY50tR61mEZ09BQntiUDHsfbJQz2CU099/mXih6rck2X3sw==
X-Received: by 2002:a05:6402:38e:: with SMTP id o14mr2091370edv.414.1644408474596;
        Wed, 09 Feb 2022 04:07:54 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g19sm3119597ejd.62.2022.02.09.04.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:07:53 -0800 (PST)
Message-ID: <d4291c95-64dd-f860-da9a-0f11d44ecae3@canonical.com>
Date:   Wed, 9 Feb 2022 13:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ARM: dts: rk3288: fix a typo on crypto-controller
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20220209120355.1985707-1-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209120355.1985707-1-clabbe@baylibre.com>
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

On 09/02/2022 13:03, Corentin Labbe wrote:
> crypto-controller had a typo, fix it.
> In the same time, rename it to just crypto
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - rename crypto-controller to crypto
> 
>  arch/arm/boot/dts/rk3288.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
