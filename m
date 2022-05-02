Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA57517431
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiEBQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiEBQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:24:45 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848F260FE;
        Mon,  2 May 2022 09:21:16 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e2fa360f6dso14756736fac.2;
        Mon, 02 May 2022 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=07ttqxmw9Tgzs/otLu70fpu68lese2xZKpYJru056xw=;
        b=jy9E7l+rL1TgCHIvbD0ta0+BUYEXDLF/i3F63YbUk1XnWLjC+IN6NhmtHLVZZlpzL6
         52U6ec1A9U5D9SrMGM19cx2KWfUoX+G4I7Gfi70EEpS+h0WNighyncCVXYaHKbEaCj7c
         vWq241+pTE5DqFqE1SGO76ZUiR7cGPbWcZAwt0DREesxMyST15CjZzRBi39BOCfimxKf
         C6nNPadQE5ogr81i57RL15m/CFm4dI0NDm4c5b00NTy9+tljZTSDuQrBNU3mPv93mL5v
         16CgMCWZ7qA/vf47NCzs1TNL0phomiI77BJb8BmnHjKNArlLpABOtp7CE/lQKd7wm2wh
         Rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=07ttqxmw9Tgzs/otLu70fpu68lese2xZKpYJru056xw=;
        b=8Jvnx68R/ehTpUA2QaQ+MiE3xnCmqEX5BDb2ZiXxi0KPKj2W95lK81OXKSM9jlogy7
         7+Yi/1xPC0VOciVpg+vQ2cf2FhXndZYfePXVBYxnKrpw/HjBgbXvZcRw701triJhB74Q
         Tym40KkUO2Yrz3eyfpLtmmHBCqv22qf4Gjxto59VekC43s5wh4Md71tDGKcQxrlvAT5J
         c7+H7BHLtZczXMcCSvDEq1zZ0p/XfCskYlPsuv8f5KZbLR9/QUW3vu8bZpwtBlDTQODT
         N+Ltb4BJfKDW5SE4fjf32YRCCwSPDwKvd17IsrljB++ygALb732xo9wIUsPfPp+5Cxcz
         pqgQ==
X-Gm-Message-State: AOAM533Lds87IsBjaPYIdT5VzD54QbBIPTUGFEEKrKasC53i50YC8qKF
        7Jml8kwOhYFO4Zpu/fRtHE/VEIsIU6E2Bw==
X-Google-Smtp-Source: ABdhPJzACJWLWcXwtSQ+DACm4Sy5HVUiUoRxy4xKvja2xujgNRuIzQlLNku8Uwc9UKAzK9KLvs2VLQ==
X-Received: by 2002:a05:6870:15c3:b0:ed:9980:db99 with SMTP id k3-20020a05687015c300b000ed9980db99mr3672873oad.154.1651508475920;
        Mon, 02 May 2022 09:21:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13-20020a05683014cd00b0060603221245sm3008226otq.21.2022.05.02.09.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 09:21:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a58097d-5c18-cee5-133b-18c61e94c62c@roeck-us.net>
Date:   Mon, 2 May 2022 09:21:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Ruslan Zalata <rz@fabmicro.ru>, Jean Delvare <jdelvare@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <21a89ae0-7152-49eb-7500-7d46dfb259f6@roeck-us.net>
 <20220502133927.4wqhru4es32gws2b@houat>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220502133927.4wqhru4es32gws2b@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 06:39, Maxime Ripard wrote:
> On Mon, May 02, 2022 at 06:31:56AM -0700, Guenter Roeck wrote:
>> On 5/2/22 04:00, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
>>>> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
>>>> low rate (6 bit) ADC that is often used for extra keys. There's a driver
>>>> for that already implementing standard input device, but it has these
>>>> limitations: 1) it cannot be used for general ADC data equisition, and
>>>> 2) it uses only one LRADC channel of two available.
>>>>
>>>> This driver provides basic hwmon interface to both channels of LRADC on
>>>> such Allwinner SoCs.
>>>>
>>>> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
>>>> ---
>>>>    MAINTAINERS                       |   6 +
>>>>    drivers/hwmon/Kconfig             |  13 ++
>>>>    drivers/hwmon/Makefile            |   1 +
>>>>    drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++
>>>>    4 files changed, 300 insertions(+)
>>>>    create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 5e8c2f61176..d9c71e94133 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -18861,6 +18861,12 @@ S:	Maintained
>>>>    F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>>>>    F:	drivers/input/keyboard/sun4i-lradc-keys.c
>>>> +SUN4I LOW RES ADC HWMON DRIVER
>>>> +M:	Ruslan Zalata <rz@fabmicro.ru>
>>>> +L:	linux-hwmon@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
>>>> +
>>>>    SUNDANCE NETWORK DRIVER
>>>>    M:	Denis Kirjanov <kda@linux-powerpc.org>
>>>>    L:	netdev@vger.kernel.org
>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>> index 68a8a27ab3b..86776488a81 100644
>>>> --- a/drivers/hwmon/Kconfig
>>>> +++ b/drivers/hwmon/Kconfig
>>>> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>>>>    	  This driver can also be built as a module. If so, the module
>>>>    	  will be called sis5595.
>>>> +config SENSORS_SUN4I_LRADC
>>>> +	tristate "Allwinner A13/A20 LRADC hwmon"
>>>> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
>>>> +	help
>>>> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
>>>> +	  Both channels are supported.
>>>> +
>>>> +	  This driver can also be built as module. If so, the module
>>>> +	  will be called sun4i-lradc-hwmon.
>>>> +
>>>> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
>>>> +	  of these must be used at a time.
>>>
>>> How do you plan on enforcing that?
>>>
>> 	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
> 
> Right, but that just doesn't fly for any generic distro / build-system.
> 

That is correct. Alternative might be to use devicetree bindings, which
presumably will be needed anyway to tell the driver(s) what to bind to.

Guenter
