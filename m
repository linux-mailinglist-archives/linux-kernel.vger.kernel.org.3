Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6424DD5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiCRISL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiCRIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:17:56 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D72DD9BD;
        Fri, 18 Mar 2022 01:16:36 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 25so10325286ljv.10;
        Fri, 18 Mar 2022 01:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gdJy8KDJJqmZ9B5JDH3Ed9jqDYHGnMTV1QhHIxa70VU=;
        b=GVM42SLm2lGCheCmSygx2ufuVdNvkgpp7NOnZxDwrfAZ0IMawN8wuuTFTeLufayWrt
         OTG3ri8PSqJqEO59RmC9Rksu4cdinWSPqEovriMnuun9btG+POeEDBUbc+I0gORWPMcw
         KWbZkfqzTxYK2H4pXJnjpgVarEStfgOHHWIYyqXuGHpEOvXtSqO5ueABE4J7v5A2RqUB
         2OxD9UBcY3pqyTsI5gX0J74ki8bLm2SIs5GktoR7Pgzb4PcHpM4e04Qoy8MdJq4rST/Y
         djuHNI+91ZPW19t2kPOXb4/qzMLqcJzswLkZT+tDFVO0mt95hoGn22iTnvpu7fUofAKy
         tLRw==
X-Gm-Message-State: AOAM532agG29LLzg6LeP5BTMfoqXFERPRrpWLfjPkx0HOWVqXz/cMmHa
        vGXo6w/4R0klIoVQr4aftH4=
X-Google-Smtp-Source: ABdhPJz7A6Ubxp/taJytZpn2KcwTH1dwwAdR5Al82fKyO+424DvYHLnCmfgjQ9zxdQvi7bmGxxt0Qg==
X-Received: by 2002:a2e:9bd7:0:b0:248:ca3:ecf1 with SMTP id w23-20020a2e9bd7000000b002480ca3ecf1mr5678862ljj.66.1647591394254;
        Fri, 18 Mar 2022 01:16:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id d12-20020ac241cc000000b004437eab8187sm743539lfi.73.2022.03.18.01.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:16:33 -0700 (PDT)
Message-ID: <97d88728-4e73-0820-07e7-199377ebff2a@kernel.org>
Date:   Fri, 18 Mar 2022 09:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion
 macros
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> Instead of sprinkling the code with magic numbers, put the unit
> definitions used by the gauge into a set of macros. Macros are
> used instead of simple defines in order to not require floating
> point operations for divisions.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 40 +++++++++++++++----------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index ab031bbfbe78..c019d6c52363 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -51,6 +51,15 @@
>  
>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>  
> +#define MAX17042_CURRENT_LSB		1562500ll /* µV */

Is this really long long? The usage in max17042_get_status() is with int
operand and result.

> +#define MAX17042_CURRENT_RSENSE(x)	(x * MAX17042_CURRENT_LSB) /* µV */
> +#define MAX17042_CAPACITY_LSB		5000000ll /* µVh */
> +#define MAX17042_CAPACITY_RSENSE(x)	(x * MAX17042_CAPACITY_LSB) /* µVh */
> +#define MAX17042_TIME(x)		(x * 5625 / 1000) /* s */
> +#define MAX17042_VOLTAGE(x)		(x * 625 / 8) /* µV */
> +#define MAX17042_RESISTANCE(x)		(x / 4096) /* Ω */
> +#define MAX17042_TEMPERATURE(x)		(x / 256) /* °C */

Please enclose the "x" in (), in each macro


Best regards,
Krzysztof
