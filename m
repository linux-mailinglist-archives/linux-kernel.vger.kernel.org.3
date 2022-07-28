Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29F583AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiG1JAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiG1JAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:00:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7B655B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:00:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so1312508wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version;
        bh=r0KkVkVfudOsZa8bt775hkQQT4bXWpl6svhyGVd6ieQ=;
        b=KA2+5rXbBP1kJXeW6hiBXH2pt90gqNXRRgOvI9OI4R4XpmjEaLf1UIiUGZyGlOxFHC
         ykYgfhTnrP+POspD23CY/8v9+X5DsIrqFYaRgocVqdCuB5PMK30TxTNWlnsBNrR8Fank
         ragjMrJgixERVOzTdYl1vzqJHh/eAYZtDZScJ/nKWzR1FObowBVnVPGrXruSlc/bjvqk
         BdHd48UjYmjvkbYL4wG52xrLfmK0zE+IupWNAU/TK4zqXTdUcv2OSQKwTjP8kCljGM11
         /FXwhX5sr/1imuYz7tqOErnW+wJY4f6z3OpQRPzEFDa229eSksGSQ2K87rJflO6gQNJi
         V56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version;
        bh=r0KkVkVfudOsZa8bt775hkQQT4bXWpl6svhyGVd6ieQ=;
        b=Vbr0mZHglZvI4DyuX5YsAQullkwvTZPFEjWKuoK5Sh7Ha2s7hrFG8nZZ7FJ5Pn3Fed
         7wS2OPT7fIBtU//o6Pe0diKe7h2vIMpUehP9oIJrbwjByff46/xT0YR18iLfE1vj5mPF
         IHY/+p5XBWxaQpP7A9GoLjQzWRADyXnk9Qncs3qbSchun3l4T64QkarEVKy9WmkrAWbg
         u0maEJ0wVdHXDkj7nnPjJIQtILqDqtOpk7OIY1jO/UNmp1MMhuiB16g4b2rAoyR+AHmv
         61Bt93n6LNRY7CiMF06m+VB0+WchDv1ShDBZZ6mZPJM2bMyxvh8FAIAjwwhpTX2HoWHJ
         t4hA==
X-Gm-Message-State: AJIora9sZRawltl14n595fZSG8IHmfQUi9cJB6IDcH2IbrueYFXrstRc
        +Ua4bc93S3GNJC2nN5CgPoM5nQ==
X-Google-Smtp-Source: AGRyM1vJ9qug6pEGy6DgN4WD7c36nLypVRFi2FQDF34WxBfiQss+w86zHbsxaCj2bnKZVMdA3qxhgw==
X-Received: by 2002:adf:ecc5:0:b0:21e:b73f:e33d with SMTP id s5-20020adfecc5000000b0021eb73fe33dmr6349761wro.223.1658998800870;
        Thu, 28 Jul 2022 02:00:00 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b0021eb309c97dsm398706wrr.25.2022.07.28.02.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:00:00 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
 <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock
 controller bindings
Date:   Thu, 28 Jul 2022 10:50:50 +0200
In-reply-to: <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
Message-ID: <1jv8rhfw8h.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 10:41, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/07/2022 07:42, Yu Tu wrote:
>> Add new clock controller compatible and dt-bindings header for the
>> Everything-Else domain of the S4 SoC.
>> 
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>
>
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c1abc53f9e91..f872d0c0c253 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>>  F:	drivers/clk/meson/
>>  F:	include/dt-bindings/clock/gxbb*
>>  F:	include/dt-bindings/clock/meson*
>> +F:	include/dt-bindings/clock/s4-clkc.h
>>  
>>  ARM/Amlogic Meson SoC Crypto Drivers
>>  M:	Corentin Labbe <clabbe@baylibre.com>
>> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
>> new file mode 100644
>> index 000000000000..b686c8877419
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/s4-clkc.h
>
> Filename with vendor prefix, so:
> amlogic,s4-clkc.h
>
>> @@ -0,0 +1,146 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_S4_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_S4_CLKC_H
>> +
>> +/*
>> + * CLKID index values
>> + */
>> +
>> +#define CLKID_FIXED_PLL			1
>> +#define CLKID_FCLK_DIV2			3
>> +#define CLKID_FCLK_DIV3			5
>> +#define CLKID_FCLK_DIV4			7
>> +#define CLKID_FCLK_DIV5			9
>> +#define CLKID_FCLK_DIV7			11
>
> Why these aren't continuous? IDs are expected to be incremented by 1.
>

All clocks have IDs, it is one big table in the driver, but we are not exposing them all.
For example, with composite 'mux / div / gate' assembly, we usually need
only the leaf.

Same has been done for the other AML controllers:
For ex:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/clock/gxbb-clkc.h

>> +
>> +#endif /* _DT_BINDINGS_CLOCK_S4_CLKC_H */
>
>
> Best regards,
> Krzysztof

