Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A834CEA7F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiCFK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 05:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCFK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 05:28:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E435D23BF4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 02:27:14 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A4F73F5F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646562433;
        bh=6KkTN0LeArjXAcefIpdLmm7qeM+MQdTOUpPRHb6gxxw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YxeGsVkaRHIk6qcVjMnRU+7g5+LBiDRkBKMIxI1h16qdNvDOziJSSqeLAxYF7p+5/
         h/58CeJKxqAc1Rg+UVjVKDcXakrcVrS1me8gFkI8vs2j8MPEPaHpPmIqXmtQybExDi
         KOFGFkaj/m7X0BOT0LU7qVegmjWa7ycQ8qutsLTAlLGqSXGk/IxuYG3jNXqx95ikH8
         pZRtQDLiZsa3btvlsIHz4oap6CvvGhUiSnyIuDUQhwN9f9xHH9Qrw6DrKJHqKo+4ql
         vtRYu4HWLqmfY1bKdeEWnzICiqMGkFDgG0i4PGngdLRCwDecIEh4fDHl2xssQMgff2
         eAhUmQfYm06Aw==
Received: by mail-ed1-f72.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so6735496edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 02:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6KkTN0LeArjXAcefIpdLmm7qeM+MQdTOUpPRHb6gxxw=;
        b=NJHs88LqZ11FVdqhm0C6zlaEX71AmMIczNuchIiGtJv9z21nQCGOR8BqmAm1FG60EH
         8hsTV6nx6lu1ZEgS4uX4Wptvz1OjI6r66Hsb/L25BUl1aa9beD3xoEZDtkTzDeLWcYlG
         ow+o/pG9fZu9ZpwQX7aJe2l9Npem8MvZ40NrIF8X4vhD/mL6Fjbybgb636Xa63NIQRTh
         ss/vOVGpvdtjXnYKpJoYIrrjaV146ji0XWcaRBPE55fSToIRaDYDUehHrB6YU0SdMY4t
         Nc6ykoNyiguMrHCou2Y0S0gYAcE8yi9TasYeGRjoDFaHiSorPyidkE8cIjMC3RuQxVtK
         rr5w==
X-Gm-Message-State: AOAM532jyYyRElFJ2sWDitEj7ItlKKDE6jIg5Co8Uwb949NMzybpBzbr
        z+trtWryHBCZDjEP8CY1YusG6kwpYV2BnMKD9SYXYN2zGrMYRC04DhhbsHv4T4/pUjanYw15hLA
        /303w29V1yfBiaQDaGs+uyb4ROAAHnK2fIUTkwkDqww==
X-Received: by 2002:aa7:c6d7:0:b0:415:a0fc:1dcd with SMTP id b23-20020aa7c6d7000000b00415a0fc1dcdmr6450187eds.266.1646562432669;
        Sun, 06 Mar 2022 02:27:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrMAcoAWXRgn7hEJ+8qeDd+XTUIfibTrmckOKcKkYM9sj7Odn7MupwEm9OyZsbxgGfqv/5+w==
X-Received: by 2002:aa7:c6d7:0:b0:415:a0fc:1dcd with SMTP id b23-20020aa7c6d7000000b00415a0fc1dcdmr6450173eds.266.1646562432464;
        Sun, 06 Mar 2022 02:27:12 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm3692555ejc.24.2022.03.06.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 02:27:11 -0800 (PST)
Message-ID: <b8553651-3cd0-845c-efbf-d2341d5506b3@canonical.com>
Date:   Sun, 6 Mar 2022 11:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: [PATCH v5 1/5] dt-bindings: ata: ahci-platform: Convert
 DT bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-2-linux@fw-web.de>
 <a2839b00-d195-131f-b2a7-d2f030a5bd95@canonical.com>
 <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-9ef9e0d3-e70c-45d9-bdd8-e43d1c89a8c9-1646560070497@3c-app-gmx-bs46>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 10:47, Frank Wunderlich wrote:
> Hi Krzysztof,
> 
> have seen some warnings in Robs bot for arm.
> 
> imho have fixed them (and the indention you've mentioned already squashed) in my tree [1].
> 
>     add compatibles used together with generic-ahci
>       - marvell,berlin2-ahci

This is fine, just mention it in commit msg.

>       - qcom,apq8064-ahci
>       - qcom,ipq806x-ahci

These you need to consult with qcom-sata.txt. This could be a following
commit which will integrate qcom-sata.txt and remove it. Either you have
binding document for all devices or you create a common part, like for UFS:
https://lore.kernel.org/linux-devicetree/20220222145854.358646-1-krzysztof.kozlowski@canonical.com/
https://github.com/krzk/linux/commits/n/dt-bindings-ufs-v2

The choice depends more or less on complexity of bindings, IOW, how big
and complicated bindings would be if you combine everything to one YAML.

In the case of UFS, the devices differ - by clocks, resets, phys and
sometimes supplies. Therefore it easier to have one common shared part
and several device bindings.

AHCI looks more consistent - except that Qualcomm - so maybe better to
have one document.

>     increase reg-count to 2 (used in omap5-l4.dtsi)
>     increase clock-count to 5 (used in qcom-apq8064.dtsi)

This would need allOf+if.

> 
> can i still add you reviewed-by to v6?

Keeping reviewed-by would be fine when adding compatibles and bumping
maxItems, but in your case you need to rework these bindings. Either by
growing document with several "if:" or by splitting them, so it will be
significant change. Skip my review then.

> 
> [1] https://github.com/frank-w/BPI-R2-4.14/commits/5.17-next-20220225
> 
> regards Frank
> 
> 
>> Gesendet: Samstag, 05. März 2022 um 18:43 Uhr
>> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
>>
>> Thanks for the changes, all look good except now I noticed that
>> indentation of example is unusual. It's not consistent. Starts with four
>> space (correct) but then goes to 7 spaces. Please adjust entire example
>> to use 4 spaces indentation.
>>
>> With that:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> 


Best regards,
Krzysztof
