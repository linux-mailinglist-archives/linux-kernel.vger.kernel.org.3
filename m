Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90E4E4621
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbiCVSir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiCVSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:38:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C5349F91
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:36:37 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A72883F1AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647974194;
        bh=5jtpXxEom/a/jiH/sFwvBmFkIoAoceZfaQ8rDmnOzv8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=o79mDLORM2nA8Epl2qL9p2El4lPMXlCz0ngDd1wsJfuU9PkrtMXdV2mp7aMyBSvXB
         eFnOdt47JGKzN7TttxrefIuL49kZO3GD5OyX0glAqB+hHcTT9u/jUp9dRo5M0JKHnN
         /55EcfsQNWsUAWFWWtgdzqo2i0JKNKuyCl3f3yasYgCzea2PfUO0zGh/borlLeVG5b
         DKRLsAIDd0VRUS8/wgHLdcUw3gAoiFieoAiG/j29NPG1YrIQaubp/kV3g3B6KEyG7/
         8HsCDC85gUPF5FrmX8WjlSB1kiDXRF0PL305GbwSRogr1Ce53/u5HhrYdFWNtrdJq3
         3yiQfvK612dhQ==
Received: by mail-ej1-f71.google.com with SMTP id ml20-20020a170906cc1400b006df8c9357efso7688474ejb.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5jtpXxEom/a/jiH/sFwvBmFkIoAoceZfaQ8rDmnOzv8=;
        b=4RnxjAqGa0Dj2I/gWWCvl2el5FaUbnZLRP6clsXBu63H7GLJBhWdnh92Cc6Rui1HGl
         Sypcq/o66K68ipVhMVsAsApgTxJiHHpPQIK8uaqJhTAH94evC3OHSBODhNS5uQXgXBi1
         jTZLAGxlj172pSKwDqYUV76JVSha/UP+op5+1rz4PNy6f7qg9nTsGvezvQG01Hzua+mw
         j1NPYlNuyhdQGv1f59lU2C1eFLltLzI7uoBnbjGKGJ0pFuG/oaWe/xBF4M5wKqJWWBUP
         TBH+XGLH9UDxfsZ4MUyWAB1vOVf3MVTZ96LR4OYR60u/+sPEQhB7W/2c/cGZ5tj2C7cB
         YzsA==
X-Gm-Message-State: AOAM531mBkE894Grclsp+yXzSpUNQksPxGKHHhmuPMmE0ZVgKUOW6G0v
        e2SbJsRXZssUv2fzel6bA33LeTfDQiviV76oMwkH9LN68H+nzJMZKMun5sHwUUTVOl09S4A1LEq
        i4Ae/s6Q04Ipz3+sgfCkecoYtp2KbLpVwUQiYispgaw==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr30164496edz.164.1647974184176;
        Tue, 22 Mar 2022 11:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXjJuzBLH9hbRDSjsXFrbLCVkaIICKYGv+IQ5EfXGkXfhv1U2vMFYP/O//lEDRT2Fv/Gfc1w==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr30164440edz.164.1647974183906;
        Tue, 22 Mar 2022 11:36:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm8816466ejo.198.2022.03.22.11.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:36:23 -0700 (PDT)
Message-ID: <ff8da126-8eac-7b72-c992-3b4223f2b077@canonical.com>
Date:   Tue, 22 Mar 2022 19:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/18] dt-bindings: irqchip: include generic schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
 <YjjJpxLWJ/YOe0OX@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YjjJpxLWJ/YOe0OX@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 19:53, Rob Herring wrote:
> On Thu, Mar 17, 2022 at 12:55:24PM +0100, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> The DTS patches can be picked up independently.
>>
>> Best regards,
>> Krzysztof
>>
>> Krzysztof Kozlowski (18):
>>   ARM: dts: nspire: use lower case hex addresses in node unit addresses
>>   ARM: dts: ox820: align interrupt controller node name with dtschema
>>   ARM: dts: socfpga: align interrupt controller node name with dtschema
>>   dt-bindings: irqchip: actions,owl-sirq: include generic schema
>>   dt-bindings: irqchip: fsl: include generic schema
>>   dt-bindings: irqchip: ingenic: include generic schema
>>   dt-bindings: irqchip: intel,ixp4xx: include generic schema
>>   dt-bindings: irqchip: kontron,sl28cpld: include generic schema
>>   dt-bindings: irqchip: loongson: include generic schema
>>   dt-bindings: irqchip: microchip,eic: include generic schema
>>   dt-bindings: irqchip: mrvl,intc: include generic schema
>>   dt-bindings: irqchip: mstar,mst-intc: include generic schema
>>   dt-bindings: irqchip: mti,gic: include generic schema
>>   dt-bindings: irqchip: nuvoton,wpcm450-aic: include generic schema
>>   dt-bindings: irqchip: realtek,rtl-intc: include generic schema
>>   dt-bindings: irqchip: renesas: include generic schema
>>   dt-bindings: irqchip: sifive: include generic schema
>>   dt-bindings: irqchip: ti: include generic schema
> 
> I'm somewhat on the fence about these. Originally only devices with a 
> bus or child nodes included a common schema. For 'simple' providers 
> with mainly a '#<provider>-cells' property, we had to set the 
> constraints on the number of cells anyways, so referencing another 
> schema doesn't save anything. It is nice to declare the 'class' of the 
> device though.
> 
> It makes the schema be applied twice (if the node name matches). That's 
> not all bad because it finds cases of wrong node name. However, 
> sometimes we have devices which are multiple providers and can't set the 
> node name. So those can't reference interrupt-controller.yaml.

Indeed there were cases of MSI and interrupt controller.

> 
> It also means that 'interrupt-map' for example is now valid. That could 
> be fixed by splitting 'interrupt-map' related properties to its own 
> schema. 

Yes, that's a side effect. Maybe my series should be abandoned.

Best regards,
Krzysztof
