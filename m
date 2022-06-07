Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B053FC19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbiFGKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbiFGKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:48:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3C3136E;
        Tue,  7 Jun 2022 03:47:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg6so14520050ejb.0;
        Tue, 07 Jun 2022 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=Pgq5MawNxPb77sAjnIPnFN2fq8aE2jaJNXvjUTWy23s=;
        b=e3kfSjAbsoTviVaMNfjdVxtoKtiTjcV2OsAN+3ENsSb1F1CXz9kskNbi+nMmkBTb/J
         Sbq0w4htYEMnZCTs6zWgagvMnfgGN+3xv7XxOzRm52lyYk6bhPMqQZhG+mx4BUOmXi3u
         4FGmSXXppL8R3yiREC0BCqDKgRRYUXzQJD41n2DgxSk+vvv1mTFB6mpGACcPD/4sk4pY
         EbiG2y5lsTTNsY04+HxZUNXVC9tlDAC7dPO6TF9m3f2++E5OmgGg0gNSdAGuwEwB+TKf
         5P6orTIcfqMHiDeQEMyYp2zYx/lcXShUu7Ls+evt7DXJZl6LcmY9kLURrzNePpq6h8qQ
         CHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=Pgq5MawNxPb77sAjnIPnFN2fq8aE2jaJNXvjUTWy23s=;
        b=suNR+cxqIlBNJ18JrA/2un55tHxdfv4rdHKjWbDKfE4jylDTWQkOA7z8QdvtNIcVkr
         jvGgv/dfhD9QnVmMV5JQNk7/0e+dXkhARKFf5Vl9AKQpfV+bS6HH2lW18+iTsh0zdY/E
         k+I8HRLtAce8crUbrDu/uQOhPI6mM7x3ke+NSAH0BmeSH9u5AMQyo7ZUUCtosGAzP9vy
         lGKFTiiYhdZmwh2hlGnZiKou50ol/AjNWNIaF69+PgvdiVZmbmIvShuJHSjDBWTcBDtg
         /FWlvOlIQJ9zulGqFE2U9MzSPSusz2Q9MdDb7AqtemcUsFGBJF67ZMqB2qWFBGDoa74M
         5E1A==
X-Gm-Message-State: AOAM533IJUl15eAX+TSYqgo8kAI3n1lMUo+nSOO6heB5lHgM0YPg3DRS
        VO34Y4GSpqGUNJAWcNjDzIs=
X-Google-Smtp-Source: ABdhPJwE12iAv0pTVW95ulxsPwHuM4wYaFcQKpFYRThN/bNbeSFLp8E2X/JkdJoBlaXq5YK50hXBCw==
X-Received: by 2002:a17:906:a188:b0:70c:1e17:b833 with SMTP id s8-20020a170906a18800b0070c1e17b833mr22500662ejy.271.1654598846780;
        Tue, 07 Jun 2022 03:47:26 -0700 (PDT)
Received: from localhost (92.40.203.113.threembb.co.uk. [92.40.203.113])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm10044086edq.15.2022.06.07.03.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:47:26 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-2-aidanmacdonald.0x0@gmail.com>
 <20220606174320.GA16522@quicinc.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] regmap-irq: Add get_irq_reg to support unusual
 register layouts
Date:   Tue, 07 Jun 2022 11:46:54 +0100
In-reply-to: <20220606174320.GA16522@quicinc.com>
Message-ID: <shCOrWuZYFlO3x9fYvGVQDCINY4Z8d5E@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guru Das Srinagesh <quic_gurus@quicinc.com> writes:

> On Fri, Jun 03, 2022 at 02:57:05PM +0100, Aidan MacDonald wrote:
>> Add a new callback, get_irq_reg, for regmap IRQ chips, to support devices
>> with unusual register layouts. This is required in the rare cases where
>> the offset of an IRQ register is not constant with respect to the base
>> register. This is probably best illustrated with an example:
>> 
>>             mask    status
>>     IRQ0    0x40    0x44
>>     IRQ1    0x41    0x45
>>     IRQ2    0x42    0x46
>>     IRQ3    0x43    0x47
>>     IRQ4    0x4a    0x4d
>> 
>> If we set mask_base = 0x40 and status_base = 0x44, the offsets of each
>> register relative to the base are:
>> 
>>             mask    status
>>     IRQ0    0       0
>>     IRQ1    1       1
>>     IRQ2    2       2
>>     IRQ3    3       3
>>     IRQ4    10      9
>> 
>> The existing mapping mechanisms can't include IRQ4 in the same irqchip
>> as IRQ0-3 because the offset of IRQ4's register depends on which type
>> of register we're asking for, ie. which base register is used.
>> 
>> The get_irq_reg callback allows drivers to specify an arbitrary mapping
>> of (base register, register index) pairs to register addresses, instead
>> of the default linear mapping "base_register + register_index". This
>> allows unusual layouts, like the one above, to be handled using a single
>> regmap IRQ chip.
>> 
>> The drawback is that when get_irq_reg is used, it's impossible to use
>> bulk reads for status registers even if some of them are contiguous,
>> because the mapping is opaque to regmap-irq. This should be acceptable
>> for the case of a few infrequently-polled status registers.
>
> This patch does two things:
>
> 1. Add a new callback `get_irq_reg`
> 2. Replace unmask_offset calculation with call to sub_irq_reg()
>
> Could you please split the patch into two to better reflect this?
>
> Thank you.
>
> Guru Das.

No problem, I'll do that in my v2.

Regards,
Aidan
