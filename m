Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDC4CD3E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiCDMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCDMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:01:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2F1AAA62
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:00:41 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A4AE33F615
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646395239;
        bh=UrJN5AN1a+sk4or2TpxPGO7Gz6uzi1pVJsgwdCKsk30=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=G8r57PjHUKHSkrFrDPiTi+x5TOEA6FPWThqprje0oRlqKsE3JnsyT8T7TVlkywqvD
         UXmq9suwHcAIHs3H2u2uXnGQcD6f4v+AeAwOpf1XilAcGZi3rM1CUJRjXeGTNw9CoM
         mO3UpssyGKwnaiTy7E8tr90Wj/gONTOcXP46osO0hHGwtql3qwGCuDcZDuvXNjjg+h
         uVn1qVlYOFg5JmV3WLsnjzbbAZ6CxRN8GZ2NgRN78WQJ+OQyxU+1zwC/rlIuc+k9jj
         0RH3m23bIASWljDFQwirj4v567ytnC+Sqo6gtpBaIiZaKSYq42pszJjySUMJZRbqES
         CGhimXbwN9X7w==
Received: by mail-ej1-f69.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so3033048ejz.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UrJN5AN1a+sk4or2TpxPGO7Gz6uzi1pVJsgwdCKsk30=;
        b=0C9q9k3UdDNHheIUyGdGIHS8UjVvy6+DTMC7b0C64x2kup0KyP5ew6OqZKMJ8iPbDJ
         CApTWIkd2gmPrnGuQO0xfAkK6i96/QwqdP8RKx5TuqjZ09CyiCXNda6HXcaeoAkTkkYg
         ZvBkz2TzKNK9MPv21ule/xwX5bo1ZdAHp9JfN/mS4wpuPNpn8KEQdAz40Pqh9PheisgY
         HDwdCEyIZ4xJwg5W7y+Tcvxdjir4FKZOzEIQllqAXLTL11CeGyIekQYVlCY61fdQM9JH
         Y/d2CQVmVP6xFpx/MFGhOD5at0nM3g+dMuaHIX76frZeieFHRIdlqtxX07UqQoAm50+u
         y64A==
X-Gm-Message-State: AOAM532XGQDT71hI565aHLXytbdhDDgF8jnPUTmArpBv8WvtPgaiET57
        clBvwJTlDTsmPmUj4KDegQF0sGYjKc9OinY+agCguw+lUCqnxKO/YM5ZQGBHNrH1LuuLcRjLAew
        Qi6j7Gg1hNURZKhlS04cWCdoDbCgZgBZtsvvnHE8nkA==
X-Received: by 2002:a05:6402:5107:b0:412:8530:3ba9 with SMTP id m7-20020a056402510700b0041285303ba9mr38867813edd.264.1646395238744;
        Fri, 04 Mar 2022 04:00:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI7OQeP0JPom8EPn2tKAhFBCBK+BonDWpzzmv+CL9Xbt+L/Z8IeRUd83dFajGjOSo8dY104Q==
X-Received: by 2002:a05:6402:5107:b0:412:8530:3ba9 with SMTP id m7-20020a056402510700b0041285303ba9mr38867791edd.264.1646395238510;
        Fri, 04 Mar 2022 04:00:38 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bt10-20020a170906b14a00b006d89fc82497sm1682564ejb.126.2022.03.04.04.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 04:00:37 -0800 (PST)
Message-ID: <747fc6f2-0d9e-d0d4-877a-cb3d4bfda6bd@canonical.com>
Date:   Fri, 4 Mar 2022 13:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: dts: exynos: add a specific compatible to MCT
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Rob Herring' <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
 <CGME20220225180502epcas5p4a8126555d09513b92fb1947669529176@epcas5p4.samsung.com>
 <20220225153650.289923-3-krzysztof.kozlowski@canonical.com>
 <000201d82fb6$9b672090$d23561b0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <000201d82fb6$9b672090$d23561b0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 11:57, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>> Sent: Friday, February 25, 2022 9:07 PM
>> To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
>> <tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski@canonical.com>; Alim Akhtar
>> <alim.akhtar@samsung.com>; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> samsung-soc@vger.kernel.org
>> Subject: [PATCH 3/3] arm64: dts: exynos: add a specific compatible to MCT
>>
>> One compatible is used for the Multi-Core Timer on most of the Samsung
> Exynos
>> SoCs, which is correct but not specific enough.  These MCT blocks have
> different
>> number of interrupts, so add a second specific compatible to Exynos5433 and
>> Exynos850.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 3 ++-
>> arch/arm64/boot/dts/exynos/exynos850.dtsi  | 3 ++-
>> 2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> index 661567d2dd7a..017ccc2f4650 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> @@ -806,7 +806,8 @@ tmu_isp: tmu@1007c000 {
>> 		};
>>
>> 		timer@101c0000 {
>> -			compatible = "samsung,exynos4210-mct";
>> +			compatible = "samsung,exynos5433-mct",
>> +				     "samsung,exynos4210-mct";
> 
> Just a though, do we still need to keep Samsung,exyno4210-mct compatible?
> In anyway:
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Yes, otherwise we break all other projects using DTS from Linux kernel.
Also keeping it allows to apply DTS patches independently without
breaking bisectability.


Best regards,
Krzysztof
