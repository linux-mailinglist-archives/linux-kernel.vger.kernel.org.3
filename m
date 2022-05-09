Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93D851FB9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiEILu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiEILuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:50:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CBC18430F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:46:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so19084227wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=misjj5JTB12DlyGFP9aFMSgV8RGVVP30IJPFNdnpF+w=;
        b=vcm8ol+n0vdvHjNkmFysmqfoMdnJAXp0XlqQZH4Vey9RcGcNJYWaS3XbqMxl2oE5Ka
         sdrAxxme+/ilEdnK5OjXbaxee9lypHPC6Gd51l99xsBDm+of2Ag4mLmqoI0FKRbADWD0
         ydvpxq8FdJ2SfX123spAoSTnX8V6mldE3qgEdwODYSq+9hEg+xu+h9urKS4lhOg10ip/
         JFOIFtCvPRUQ366h67ipFMukKFsmeK2MqkRPel8OaskasEol/nzbbGxPInvorMO1YBcs
         HIngSiNh2hwhybpxoltaFRL7ZpWfXMWyOqQMtTijw0rWYE6lR/bDb33jywYpO4OjriOP
         +0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=misjj5JTB12DlyGFP9aFMSgV8RGVVP30IJPFNdnpF+w=;
        b=eYN71BwYGcXs62lanW/laLh97bM0yEy7p1QPEX8WOMzFTykv3R3rhYQ/OYcEUHoiyE
         gT06hfUXEolOGfjJ5p8GcNQfJiHsHtjNFlhYd8x0rhwxa99/d2HvvoMRJ+NYGoi3sM88
         Wp2JPgQDXFYkdT/cEKOm97xkcWIyfrrfRqapFOFMEKZy1ptT2PUyFBJdEzApyf6spc98
         7gmTqtEnYjAywNz8K9kuvmLcAxeLmiZPNeLY/MVJyBsTetnEErviNz8ccpJQ0amzQpny
         fiP9QaSV0p/qin5aR0W6buhf12VUlPilk4iN0d2is22jPTAxUN0F+qnexq2UvKrweJUg
         VOKA==
X-Gm-Message-State: AOAM5338LhP+V1P5XA6pW/753329tN+cJ3giKxPNe+Qj5dMbnMeP/r/V
        MKxXpltlovt8LT5GjzJrztd/KA==
X-Google-Smtp-Source: ABdhPJxUHknTccYYo0FBvjr+ROc0w77xQIpr0J50KwaOVb50UXG/NivSAf3PnGfF/UHaxiJloSJzOg==
X-Received: by 2002:a05:6000:136b:b0:20a:c416:e914 with SMTP id q11-20020a056000136b00b0020ac416e914mr13382462wrz.167.1652096787075;
        Mon, 09 May 2022 04:46:27 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id b12-20020adfc74c000000b0020c5253d8e8sm11399633wrh.52.2022.05.09.04.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:46:26 -0700 (PDT)
Message-ID: <a1d44fbb-c2a9-e422-8ce8-2a3982a75bb8@linaro.org>
Date:   Mon, 9 May 2022 13:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] clocksource/drivers/sp804: avoid error on multiple
 instances
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220506162522.3675399-1-andre.przywara@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220506162522.3675399-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 18:25, Andre Przywara wrote:
> When a machine sports more than one SP804 timer instance, we only bring
> up the first one, since multiple timers of the same kind are not useful
> to Linux. As this is intentional behaviour, we should not return an
> error message, as we do today:
> ===============
> [    0.000800] Failed to initialize '/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000': -22
> ===============
> 
> Replace the -EINVAL return with a debug message and return 0 instead.
> 
> Also we do not reach the init function anymore if the DT node is
> disabled (as this is now handled by OF_DECLARE), so remove the explicit
> check for that case.
> 
> This fixes a long standing bogus error when booting ARM's fastmodels.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
