Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAC4DE86F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbiCSOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiCSOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:34:07 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DD4757D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:32:45 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF7873F200
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647700357;
        bh=InJ6U8UY4RvOMrjUqvHcPUsxjjC+YOW7qw9OrXO0LoU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TnPxsSSRaYAiIAmhjWt/sdjcsApjpnG0K0K5zZmwFM4YZhG+RzCyjHuL6bbQ/jadZ
         qR21Kn1UkyYTrxfUz2sHtlymHEB+c1QIL0JF6QFiHppfCQbfmNPoqqt/kDO0vngJt5
         R7T+guAnj1DL05Af08mqGiZuc0BpzbCx/wdFzjNRdNGvb6L6xVsgRja1zeszBtHxUw
         z7gc/zScZqox5J5bOzLw96+253oQA6Ok6ccfSEbKud9o9Rgw66bR4hDGTH/xyYbF7k
         hHGc2JuSbUNEXwQ2v9rTzi6ZvAWguQ9o0rujpXWNMgO1HQ7h9EXryz8tNdd7StvPeX
         R4B8ATp3IQ5Dg==
Received: by mail-ed1-f69.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so6576368edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 07:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=InJ6U8UY4RvOMrjUqvHcPUsxjjC+YOW7qw9OrXO0LoU=;
        b=jq4WLJHvNOlqnLpydks/oaq1W5rvVHeY72wPqW04bKuaA3+Rwq536JkOki5XwRfKHq
         KCYNRiQx3Tjku3eHeQ8LrhWXtjcL9628E/dFr6uIJxRhv9nee3xGv9OpISHgSzXnkc9f
         5g1sLmLLFELPf620OpDxMcMGlJKLBl20TrIRtEQJbURtu5w40Q8Q/w5UuP9ixKFQMdi4
         2SIklWvhQExw8aSrOhZ0DtopxkTvUro4QwF0OW2LqMJ2GcR/FozY87Y4xJlkfzVeJlDG
         eR60K6RN865yph1heBoGo2hI6yaswgJF7zAl7af726L8kz3FqBna8/IWAzSXdZPwLUoK
         9gUg==
X-Gm-Message-State: AOAM532URRSYSBIekbwpmMeB4qAsBo/uz4TJL31Rvclw+BU2A3pwwaGg
        6g4HFnsD5e4yJnpw2IaFA4xpAa04OdMW4JpazRHRukqXbIA8+uqakqxBJvj+zv4XQURfnwj6Mkt
        OmyPiDgEGaB1l7gAcVqRjKo73uduWCAgr/rSGitedhw==
X-Received: by 2002:a17:906:4fd3:b0:6db:d516:482b with SMTP id i19-20020a1709064fd300b006dbd516482bmr13152554ejw.257.1647700357274;
        Sat, 19 Mar 2022 07:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVb8tBWJhUve4OkGMJFk96Be1+NNOMYjq7KlZTc41lXFIP+5LABT8Na15QuJicto28O3mFWA==
X-Received: by 2002:a17:906:4fd3:b0:6db:d516:482b with SMTP id i19-20020a1709064fd300b006dbd516482bmr13152518ejw.257.1647700357014;
        Sat, 19 Mar 2022 07:32:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id e6-20020a056402190600b00413d03ac4a2sm3593767edz.69.2022.03.19.07.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:32:36 -0700 (PDT)
Message-ID: <b6648c94-9316-d815-893f-7d7cad01edc6@canonical.com>
Date:   Sat, 19 Mar 2022 15:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/8] MIPS: mscc: ocelot: fix load/save GPIO pinctrl
 name
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-5-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220318202547.1650687-5-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 21:25, Michael Walle wrote:
> The pinctrl device tree binding will be converted to YAML format. All
> the pin nodes should end with "-pins". Fix them.
> 
> Fixes: 15324652f612 ("MIPS: dts: ocelot: describe the load/save GPIO")

There is no bug here, so no need for fix.

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/mips/boot/dts/mscc/ocelot_pcb120.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
> index cda6c5ff58ad..d348742c233d 100644
> --- a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
> @@ -27,7 +27,7 @@ phy_int_pins: phy-int-pins {
>  		function = "gpio";
>  	};
>  
> -	phy_load_save_pins: phy_load_save_pins {
> +	phy_load_save_pins: phy-load-save-pins {
>  		pins = "GPIO_10";

This should be squashed with previous patch or with the next one. There
is no point to align names with dtschema/dt spec one by one. Make the
conversion per entire board file or SoC.


Best regards,
Krzysztof
