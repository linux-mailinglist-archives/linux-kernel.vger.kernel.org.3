Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDF4D4192
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiCJHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiCJHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:10:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F542A1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:09:02 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 142503F30F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646896141;
        bh=7PoHCaYhO0ZxRHvRnDZS7rrKxerm9Vdgnt5jQv1JQww=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=sFQ7oRN2EQVQ7OXnmnMzCV0z8/tLb2ZKginiDlnnk4ZoEKc6I9hpZcGCAxglbBIx1
         FouJTA88TsgOr21mPf3fIhLpkflJ7t8qgaKtsa+itSjc1Rre9g0BV8MjRwbDesSfY3
         mo6j8Hmm7vZgwQqmEbhrlKX3Az6Zyb5ilXjefdRScdXQ2AXe4dOdHibjb4v6Umxad1
         698r8UEychBGHeM7MWIU72Mkdx/9OXBrwcq6BuTR0CnPAZt356Y/tH7ckoO+Yqx9ET
         N26neSXxVV7K8HBXxnSHf7/4rCgEL54/MR6cUUbVCwD9YXze9sc+5oOvPE5J97y/4g
         vjxWlOhYYlVoA==
Received: by mail-ej1-f69.google.com with SMTP id lf15-20020a170906ae4f00b006da86a43346so2593526ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7PoHCaYhO0ZxRHvRnDZS7rrKxerm9Vdgnt5jQv1JQww=;
        b=weTLN15he2B5FxAKZedQWckQRyV25w3t4o5242UuvgH1varbDsxPyFIFLCOva8Qzz2
         8EUz0IXzV0E+MqyMa+cHF2EJywdLZXCQ65UDYuYqUBcHhZG4joKaHHWzRw4CIUplT0bs
         vOZzn/EMN/zsJB1UiEXULJ8yWqj63s6Md8SlQYx7dK3ATk6zfm6I50kykJd6lPMQPfoo
         eG6AqnG5pe5FTzvKBVPkCUdXLHkmKB01EAfoXqgS+czgpx7oK9BzeFkj9Ivgs6pZB3qM
         C8NSdOjtfCcyDOBoQltVFpuqKNud0T44wNL582ZMBnWO31KadEGQ4ZYxNcPd3e2ohIRm
         1t7Q==
X-Gm-Message-State: AOAM532KkdVjGcgl6JCo/ijlHPFXfdnZsK01pZGKgDOHh3lEBNc6r3UV
        dxzu6H/9aHZ3XlhvPdmmGKjBowAv8YrD3wjlEoSa06ocSWyQFLTt/TzoYza4Zk/8oYo6YKYn7Ur
        2pcf4CHPpz2FyIyCthL70BV6gN6Z+vQVNqQdbd+mKOQ==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id mu6-20020a1709068a8600b006ae9c3535c7mr3078943ejc.494.1646896140614;
        Wed, 09 Mar 2022 23:09:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytbR3Jw1opqa8aq2Mu9idG3Ib4RiXFm+gINlCW4vL3ZOCeIc9CZZRitsV1zmpLO5YExfgGiA==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id mu6-20020a1709068a8600b006ae9c3535c7mr3078930ejc.494.1646896140455;
        Wed, 09 Mar 2022 23:09:00 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm1485544ejc.42.2022.03.09.23.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:08:59 -0800 (PST)
Message-ID: <8d050ef4-a8d9-833b-bc8b-63c94d12711b@canonical.com>
Date:   Thu, 10 Mar 2022 08:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] thermal: artpec8-tmu: Add tmu driver for artpec8
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220310013140.127026-3-hypmean.kim@samsung.com>
 <20220310013140.127026-1-hypmean.kim@samsung.com>
 <CGME20220310013130epcas3p2f4a45192b643d348aa2824cfbea47ba4@epcms2p1>
 <20220310015722epcms2p1572aeba5201a70f5aaf94ba0b01f3723@epcms2p1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310015722epcms2p1572aeba5201a70f5aaf94ba0b01f3723@epcms2p1>
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

On 10/03/2022 02:57, Sang Min Kim wrote:
>  
> Add tmu driver to handle thermal management for artpec8 SoC.
>  
> This driver is derived from the tmu of exynos and additionally supports
> the thermal zone of multiple remote sensors of artpec8.
>  
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>
> ---
>  drivers/thermal/samsung/artpec8_tmu.c | 754 ++++++++++++++++++++++++++++++++++
>  1 file changed, 754 insertions(+)
>  create mode 100644 drivers/thermal/samsung/artpec8_tmu.c
>  
> diff --git a/drivers/thermal/samsung/artpec8_tmu.c b/drivers/thermal/samsung/artpec8_tmu.c
> new file mode 100644
> index 0000000..d973827
> --- /dev/null
> +++ b/drivers/thermal/samsung/artpec8_tmu.c
> @@ -0,0 +1,754 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  artpec8_tmu.c - Samsung TMU (Thermal Management Unit)
> + *
> + *  Copyright (C) 2014 Samsung Electronics
> + *  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> + *  Lukasz Majewski <l.majewski@samsung.com>
> + *
> + *  Copyright (C) 2011 Samsung Electronics
> + *  Donggeun Kim <dg77.kim@samsung.com>
> + *  Amit Daniel Kachhap <amit.kachhap@linaro.org>
> + */
> +

This does not look like a need for a new driver. Please extend existing
one. Quickly going through the source code also supports it - no need
for new driver.


Best regards,
Krzysztof
