Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418004B6C39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiBOMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:41:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiBOMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:41:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B813D69
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:41:34 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 97AB44004A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644928893;
        bh=QbUWVDT9IJnNp0UgiXgiKB5Xmj3424bun3vMscrN3aE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TFPtg0WJBrYSJ2P15fg/xN9D1E5lxKdg1tIibrsFIefaXqW0YeHuDZQ9XzBxoHAVQ
         EtdJTSUvSGvV/8VbDFJU0WT5noPpuHs7XfXsDjp2lZMrfToeqO6ybqlAe5gVJIfNjc
         GAhoKYBeE5oZPU5Qae7hZcRrBTDkd3/2C4G9feBiaVfHD1wLQ4J7APrGZVw+Uwb+PY
         yL7ubUkT0MutH05lkeerixqm+tunyla0+5dfsgsy3kh0I5zKr7SW7MI4pWeN+9KBxA
         jlzspvRnyaRfSNKHX2wZ9tftMCHuKk+B9eXSxcr+CLLPNTkmU+wogtMR+hE7cTLJge
         NIHp+/wm8/AbA==
Received: by mail-ej1-f70.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso2354706ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QbUWVDT9IJnNp0UgiXgiKB5Xmj3424bun3vMscrN3aE=;
        b=Wr4/HMHg0UOGLkXRC776WPHKfJqmCUwNr7HYDJByooAVR2rZ8t2oszxeBhLj5dAVDS
         kuJ4eUh7tsWEHYJ7HI0XurJEq+j98i4QZlOdRCXB3vRMFd3CY/JY8Bak3LHaFovYd3dV
         Jt7MqSL7B6ZwxBSI0uBK4Fu3/kABLg+xx8MGHZoMv6x9SFpX0spl4PcrFPamwyckvp/9
         REk0Ui1FlZJX7UF/jAHAuOhCkGcUVH0CTeP1CRL5iNi5mu4x+PzkeCSEMG68+C1S8atH
         pFjNxkjb0yYPUrqcirR643pkxcGbjK+7ksEwxyCfrHaK/OvjJiUsKDxvSGA4nYNEsj+W
         AOIA==
X-Gm-Message-State: AOAM5306cqloHqUbOD30JbCLlE5Di/iNDJoJfDj9PEcVJC5ZgCPOlmN1
        LMAM2oR762Ih8w2GclXgCMxgKoYYIIeVzIzctQuwOYOEqmyDGlbv+g6K9gDtvMpOhksrT6E+nep
        dEekro+hv/WSSP8OIJxf91xRUrr9MR0oVjZOVsiehpQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr3170168wro.192.1644928882831;
        Tue, 15 Feb 2022 04:41:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynosHfXmu54wEOehuRxyBrBBX/omTI+7jbTvJMV3zxiDGYGIyyPYwfwd8vXYZelAX0aR/OBQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr3170158wro.192.1644928882614;
        Tue, 15 Feb 2022 04:41:22 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id u15sm37548631wrs.18.2022.02.15.04.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:41:21 -0800 (PST)
Message-ID: <d042abb2-e5df-42b9-824a-6fc3b9c6df6c@canonical.com>
Date:   Tue, 15 Feb 2022 13:41:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv@lists.infradead.org, Vignesh R <vigneshr@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeff LaBundy <jeff@labundy.com>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220215074030.3nugwproxjh3lwhl@pengutronix.de>
 <CA+Eumj42Hojp1m4deuWnqMOaaNaupTSkzPaNbL_0eyBL-aDi_g@mail.gmail.com>
 <7df71f8d-cdc3-4b2e-cf0a-7112eff28142@canonical.com>
 <20220215094106.k35pmoxt2nk44dsj@pengutronix.de>
 <20220215104952.3z7y2t5udwab64kh@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215104952.3z7y2t5udwab64kh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 11:49, Uwe Kleine-König wrote:
> On Tue, Feb 15, 2022 at 10:41:06AM +0100, Uwe Kleine-König wrote:
>> On Tue, Feb 15, 2022 at 09:02:25AM +0100, Krzysztof Kozlowski wrote:
>>> On 15/02/2022 08:59, Krzysztof Kozlowski wrote:
>>>> On Tue, 15 Feb 2022 at 08:40, Uwe Kleine-König
>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> [dropped Anson Huang and Yash Shah from Cc: which were not reachable for
>>>>> my last mail]
>>>>>
>>>>> On Mon, Feb 14, 2022 at 10:21:39PM +0100, Krzysztof Kozlowski wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Changes since v1:
>>>>>> 1. Add tags.
>>>>>> 2. Adjust subject (Uwe).
>>>>>
>>>>> However you only took a part of my suggestion ...
>>>>>
>>>>>> Krzysztof Kozlowski (15):
>>>>>>   dt-bindings: pwm: allwinner,sun4i-a10: Include generic pwm schema
>>>>>>   dt-bindings: pwm: imx: Include generic pwm schema
>>>>>>   dt-bindings: pwm: intel,lgm: Include generic pwm schema
>>>>>>   dt-bindings: pwm: iqs620a: Include generic pwm schema
>>>>>>   dt-bindings: pwm: mxs: Include generic pwm schema
>>>>>>   dt-bindings: pwm: rockchip: Include generic pwm schema
>>>>>>   dt-bindings: pwm: sifive: Include generic pwm schema
>>>>>>   dt-bindings: pwm: renesas,pwm: Include generic pwm schema
>>>>>>   dt-bindings: pwm: toshiba,visconti: Include generic pwm schema
>>>>>>   dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
>>>>>>   dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice
>>>>>
>>>>> ... The actual patch has a space after the comma, I like this variant
>>>>> without comma better as this is a compatible string.
>>>>
>>>> I am confused. My patch does not have comma after space. Your reply
>>>> had such in the subject, but not in the proposed new subject you wrote
>>>> in msg, so I left it as is. Without comma. If you still see comma, it
>>>> is something with your mail client.
>>>>
>>>> See:
>>>> https://lore.kernel.org/linux-devicetree/20220214212154.8853-12-krzysztof.kozlowski@canonical.com/T/#u
>>>>
>>>> Also reply from Vijayakannan does not have comma:
>>>> https://lore.kernel.org/linux-devicetree/20220214081605.161394-11-krzysztof.kozlowski@canonical.com/T/#m80af695f2c751341bc971114aefa00ccc929a3ec
>>
>> Strange: I have this mail four times in my mailboxes (via
>> linux-arm-kernel, linux-pwm, kernel@pengutronix.de and directly). In the
>> two latter the Subject line is broken in two:
> 
> I was wrong. The ones to kernel@pengutronix.de and the linux-arm-kernel
> one are the ones with the linebreak.
> 
> Hmm,
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/717310.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/717304.html
> 
> has the linebreaks, too. Still I wonder what is different between
> kernel@pengutronix.de and u.kleine-koenig@pengutronix.de.

Other threads - not only mine - are also affected:
http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714311.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714316.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714364.html


Best regards,
Krzysztof
