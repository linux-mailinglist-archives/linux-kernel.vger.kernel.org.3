Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5481A4AB0F7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiBFRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344299AbiBFRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:34:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B332C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:34:52 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1203D3F32B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644168891;
        bh=z5izoBPa4R9EwBL70QufFWzK1TBtESD+9kJEsHX6Aho=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
         In-Reply-To:Content-Type;
        b=uBwxlO0UKJmu31G9VrVDi8iTmmxGurF9M0Hm4ZeZSKmTkLhdYHPUKkvEYX1Q/u/0m
         5pMhD3f1K0c6ZWJPdOQQpszGl5XeKXnKFlV8PXFn0q0WAW6vSd/vrZUKPv1ZALOR+f
         nT8w9mP0eIU4RH6rxmf7Ed210fKPeJVY1V9oRR+3tXu4Qp5yT1PS6Xr5RvEjLdX9+P
         FA+pbpm0lITg2DNq6DPRUNFu6vG0+DILD5DaxewoZs06WiZQivd11KpHjUYw8nKSxN
         UGNkjPUvwAvcRgTRaHI1hK6s1wtXeZP/PKWMBzCSkuLvm5HuRjZkJQZiXgzHMp5Mmb
         7P/nmheI4TUnA==
Received: by mail-wr1-f72.google.com with SMTP id e11-20020adf9bcb000000b001e316b01456so102158wrc.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=z5izoBPa4R9EwBL70QufFWzK1TBtESD+9kJEsHX6Aho=;
        b=eABdCzyXZgPMu7sKtf3FIpVRJgJjOg3Z1BKml6XZo3fWwL0ABwo8cuvGj6wjbtO41P
         WUFXWTLpX07l180ckr+x+ebTrdNRb/gnHvwMByWueeE65uGI126co1OKwWgOep+QOU4d
         MAZkafuKE6UrChDOAWsI0yFkHqTwZYONS+8au6u/ansdXG21U9oK1LBgi5emYxOKuuql
         Lkp3u0/B7UbvYg/2ZJa2Ln+hPwLmzrdGMMvwrKuVwTV+mEX6cf3K0cMxIztsVAMMy8q5
         C9eXQZvymiNE+wz+48U5XCeTmE03Xllnj5QCoB6PTXdeCr0wWX03ilwGW7XrkOQlgjGF
         /A8Q==
X-Gm-Message-State: AOAM531fPTxxXDZVduXkOVcYq0kAoX02utBCwr0LE2lgzqncw8vR0y2/
        pECAovWYHoIrMF72WmrRGm5JODoN5fqBHJslr424WELuelKPEuOqiAV8HVm1eUyb51OaFeBHWNv
        XRJhs3GJjhqNhO548zzRdl+rSH7OF4WYp28djlJp5VA==
X-Received: by 2002:a05:600c:510e:: with SMTP id o14mr7785314wms.163.1644168890673;
        Sun, 06 Feb 2022 09:34:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1rOAFnc0rXLk6obrEoY0IBwhFxEnLcHOsLdWK71QDzzC6xlUe0hnU8CgHpqzZIXOQQqmMLg==
X-Received: by 2002:a05:600c:510e:: with SMTP id o14mr7785295wms.163.1644168890461;
        Sun, 06 Feb 2022 09:34:50 -0800 (PST)
Received: from [192.168.0.86] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ay29sm6975979wmb.38.2022.02.06.09.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 09:34:49 -0800 (PST)
Message-ID: <f0a9e656-cf18-f212-b701-a1c9d10c4a59@canonical.com>
Date:   Sun, 6 Feb 2022 18:34:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/3] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
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

On 11/01/2022 18:54, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v1
> ================
> 1. MFD: Use absolute path to schemas.
> 2. Regulator: skip properties.
> 
> Dependencies
> ============
> 1. DTS patch: nothing depends on it, sending here so Rob's automatic
>    checker won't complain about DTS.
>    I will take it via Samsung SoC tree.
> 
> 2. Final MFD patch depends on regulator, so the two last patches could
>    go via Rob's, Mark's or Lee's trees.
> 

Dear Lee,

This patchset was reviewed and there are no outstanding issues. Could
you pick up entire set via MFD tree?

Best regards,
Krzysztof
