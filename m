Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034654B1F71
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbiBKHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiBKHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:40:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9352F4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:40:45 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF12D402E0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644565237;
        bh=Kv1h0VSTo+y1KIWyLqXo+zKdHA28wssinzCl3m6t9NE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=OYbmNvooadK5juLkPe6TJPEfgxgOnhU5jMX9E35/J28eeNwioO2Xt2ilVZfaexxby
         PFTEBT53t8aQ7MNlWoopW2RwwXthV8iDPi4IVmt8BkE9H+3r8p9HFwjJtgD79rTeiG
         gu+sJyYzfd7SyyCbX3ipxlqZs7k7gAEbkkWmPE9+8MQYm1AbRa686X+0IDGmLGoXSW
         mCZG9kHrcpYetnxRS09J6xJ5l3y4O91xl0G6tzmbSECH2zF53OPM0xp0kdH8Crnru9
         C2c8q0X/LVzI+p6MnsI/mGXa89ZzLqjwosqm4/rodB3K0L5jST5zMPtrIKRfvGXlX3
         qF1VPFr2rcA4g==
Received: by mail-ej1-f71.google.com with SMTP id mp5-20020a1709071b0500b0069f2ba47b20so3674692ejc.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kv1h0VSTo+y1KIWyLqXo+zKdHA28wssinzCl3m6t9NE=;
        b=mKq+ms/3koDp/aUXLLfxYtnrzdV/u6IVf+yBYKTJcR9koeyZTriJLVVqrYKszw5Ctv
         Nf2V5PvvHkardyEfbxUyFYv4dhAkyxRWvTbsPR2CRl11G3Gzuqc4PdqCu2Q94UR6qMll
         hRpYRHROAGVMgL4m9xmXG/uD+uIhyqswEZW4XUfh1mwFcdC284URcIC+/ihROOKW+wk5
         lkU/t3CEQW7R9dSMkhvg2pzCYD2SfZsyUBpNCnL7lKtcKMEUSBbMtp95U0vKDInRwWec
         VJ6d79tA1XAt1llWJw7yRdZuNB/Wkd75mjfMhShocV8xN0n+ip87oir5MTM1oK/uWQgz
         +h1w==
X-Gm-Message-State: AOAM5320jaInjugUagsZ20bOLa639IyYO0l5WEnSgBhsxnoRuLEjtVB0
        c9XeSWp2Z7RUAOEmgU8rXsMXNnBOxTpy7zLGbZLaKccNdgUyfF1Wl3VWn4LOtoNojrD8At6udVg
        SL3wKa2tfySIdlqByuSBPCUMBScrpEF0E7YXOw8wLjQ==
X-Received: by 2002:a17:907:9494:: with SMTP id dm20mr332745ejc.148.1644565236869;
        Thu, 10 Feb 2022 23:40:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe6Cr/fobWoIGuYaAC7gTvhZZRWiObYqT+pEfyWLxdNfwPpukri+jSGsSnIAJmOkFEfDnbKQ==
X-Received: by 2002:a17:907:9494:: with SMTP id dm20mr332733ejc.148.1644565236638;
        Thu, 10 Feb 2022 23:40:36 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b17sm6171404ejd.34.2022.02.10.23.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 23:40:36 -0800 (PST)
Message-ID: <905a8063-8d84-698c-d45e-0acb0f7b0ebe@canonical.com>
Date:   Fri, 11 Feb 2022 08:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v1]dt-bindings: vendor-prefixes: add HPE Prefix
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <nick.hawkins@hpe.com>
 <20220210175912.102159-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220210175912.102159-1-nick.hawkins@hpe.com>
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

On 10/02/2022 18:59, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: This patch adds the Hewlett Packard Enterprise prefix
> that will be used for upcoming support in the HPE BMC GXP.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
