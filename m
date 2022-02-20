Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656574BCF67
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiBTPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:33:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiBTPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:33:34 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64387369C4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:33:13 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F2CB33F1CA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645371191;
        bh=AIbRyeLNfvFJg7VRCeqPL8tDv5fvQyhxI4o53shpmgE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JnVOcFQGXl0uHF05zYFja0a22VaygreL71FZsAkgKA1sRNZZ6TFfPMNkRGyKaJu62
         /lZZ2YjsH5er7UrMB2PN9LHC68+2g5tvRe4jm2sWt5D881Gc+efLHAam07jxxhIzUi
         2zTuKhl7dpplH5LkgZQX5p5suQ81qYRdQAxmnc1bQtbqyIntpk8LayCPaQR+bAxQXj
         8th+dzfSXl4bcYE4giBIwDJqGbiMmeQ+qdSrKHh8fjURzj8HIUAnXnq+Zh8Tg0KXLu
         Fb7W23csfbBjuRUOxXbaMg0WWdQeGGleWDvbYmFxYCcSH22jKR8GbpWOqeMctX70gU
         w72HDxSuumjkQ==
Received: by mail-wr1-f71.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so6022913wra.16
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AIbRyeLNfvFJg7VRCeqPL8tDv5fvQyhxI4o53shpmgE=;
        b=GZl+sOC4sKn4T5w3i+yra2JuqVT8OV6IKc/7wMry0MKzNMpZyCFa74ynHQB8vUNsBv
         XRwbcnkgjuYRBbpUxiFUUYOzF48PLpYkHG0J0CqQF2I00VOrIjgqT9Q+SPhxsX+a91eQ
         rZjgZZWigVJ4e4p3g0o657Vwga7mTW4ft6+05gBVBED+1iYwO03q9Oa0Eni/qCoQ/Vze
         l6PrssRVsazWlLyUrQqkSZ/4n2bz/pkBNYnDgqspDvDVHvpQSauJtTYDxFl0euYlzSaU
         6QxC2AwSbhfJiI3RdYaE729QGteFB6rbql4QJ4C42c8cPUIX6t9PpJ4PleTwOWyeMjiE
         GdvQ==
X-Gm-Message-State: AOAM533MIIQZ9dtADNbXOc4cj+IdQqLfle5Znm3CTC9y7Jyqe58kvMpe
        Oku+S4RmdZyh/Ebg2ezK3asESKi2jxVHf9cMj+/LrVzNy0/3p0rh+8zDy+RgDY9vzUncTEDzKPZ
        uBE8GyXIiE6Qlp3OvExn8EgLLWEyg9hWRRT5u60XLjQ==
X-Received: by 2002:a05:600c:3d13:b0:37b:b8e5:ed80 with SMTP id bh19-20020a05600c3d1300b0037bb8e5ed80mr17813260wmb.183.1645371191710;
        Sun, 20 Feb 2022 07:33:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCtRKlz0JOjn2Q3UB31SmB1c1DuPa7CzF/yZujcaVE0jtuArXWTGSPrQnG/QGaa9mTDvdfNw==
X-Received: by 2002:a05:600c:3d13:b0:37b:b8e5:ed80 with SMTP id bh19-20020a05600c3d1300b0037bb8e5ed80mr17813249wmb.183.1645371191472;
        Sun, 20 Feb 2022 07:33:11 -0800 (PST)
Received: from [192.168.0.117] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c300700b0037bf8c6ee5bsm5748991wmh.45.2022.02.20.07.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 07:33:11 -0800 (PST)
Message-ID: <fc8f6c95-e37f-0dc8-c50d-48cadffcaa98@canonical.com>
Date:   Sun, 20 Feb 2022 16:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] clocksource/drivers/exynos_mct: bump up number of
 local timer
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com
References: <20220220133824.33837-1-alim.akhtar@samsung.com>
 <CGME20220220132643epcas5p39d48a27bb3fcde2ea3a01a260b46e1a0@epcas5p3.samsung.com>
 <20220220133824.33837-3-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220220133824.33837-3-alim.akhtar@samsung.com>
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

On 20/02/2022 14:38, Alim Akhtar wrote:
> As per the dt binding, maximum number of local timer can be
> up to 16. Increase the array size of the _name_ variable
> which holds the number of local timer name per CPU to
> reflect the binding. While at it, change the magic number to a
> meaningful macro.

This still does not make sense. Let's say you have 16 local timers, so
why the name of clock event device should be maximum 16? How are these
related?

> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 0c7931f7f99a..8d63a9376701 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -66,6 +66,8 @@
>  #define MCT_L0_IRQ	4
>  /* Max number of IRQ as per DT binding document */
>  #define MCT_NR_IRQS	20
> +/* Max number of local timers */
> +#define MCT_NR_LOCAL_TIMERS	16
>  
>  enum {
>  	MCT_INT_SPI,
> @@ -80,7 +82,7 @@ static int mct_irqs[MCT_NR_IRQS];
>  struct mct_clock_event_device {
>  	struct clock_event_device evt;
>  	unsigned long base;
> -	char name[10];
> +	char name[MCT_NR_LOCAL_TIMERS];
>  };
>  
>  static void exynos4_mct_write(unsigned int value, unsigned long offset)


Best regards,
Krzysztof
