Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0E52380A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiEKQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiEKQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5687419CECC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652285056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5E5ae+fiX+8fhds4+yHVslnnnzZ+qVMHnlGIRP/rgo=;
        b=OtxltTT9GD8rlYeUvSWVBdmXHc2GykIiWQq7CFseHY+ywjhvt6MylqJkikMFVQYaEgc9rJ
        ThNXqdgWBcL964UcqsQbrDnXXEGGbiArzFe7OR8MqgMd08hfxUkOn0hWc5qpXdHxEP/sWd
        uD0ODCtYZ3rnQ0XZdQ7GrYbj0nk8BrI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-dU1fsjFGNTaCZ6Q27RdIcA-1; Wed, 11 May 2022 12:04:13 -0400
X-MC-Unique: dU1fsjFGNTaCZ6Q27RdIcA-1
Received: by mail-ed1-f70.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so1613039edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/5E5ae+fiX+8fhds4+yHVslnnnzZ+qVMHnlGIRP/rgo=;
        b=HmNrnt5qH+HNioVvWxDMjXpEXLaJ96/PZzdPZimBce8RTeLYEHC78yz2HFmQ4mkjJ3
         XKaKLJiVa0uA4A9C34eNGw8vKe0kW2KNH6tknz1tnUlxXgVmsfszHvpD9si1P1OQbhKC
         auQKMeuwwj9U9PrN4b2NzEYuDBxPmAVdln95XgJMN8zduBy3oXFeQ2a5vdv75Um9xxZa
         1GHJumDz+AihzL+GO2OOwNlUVyWpm4aDy7KcH94maguCUi7uD6RDPGiTX/0lXUjYgKv5
         OxhbsFhqJlis/Dth83gYEH54OG27cVxju5NfRNAEUNB1veToK7jcMdPxzIjyJP6MOwH0
         7oXA==
X-Gm-Message-State: AOAM530jBu8Tvl1RfkJ0ZHB0JV7SKGv2ZnOqhlzT9P8WMuOkHOeLdDiz
        5hl4waAl00B6ph5TCbEwG7G0w+3f/5/0e+maYlPX/DP9PaXYTqcxK4TkR46KF7A+WwarMHZ9mqB
        AqyMEu/6NwoIXVacYCn7BeHPy
X-Received: by 2002:a17:907:2cc4:b0:6f5:28ea:83f with SMTP id hg4-20020a1709072cc400b006f528ea083fmr24163748ejc.255.1652285052540;
        Wed, 11 May 2022 09:04:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4FYhwaUmeTEVBmeSUYIufRa7f3HQ22CFzDmAHIL5LOnpIxLtX0aUZqjA+oZOOPoQ2QWcJwg==
X-Received: by 2002:a17:907:2cc4:b0:6f5:28ea:83f with SMTP id hg4-20020a1709072cc400b006f528ea083fmr24163736ejc.255.1652285052373;
        Wed, 11 May 2022 09:04:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709065fc800b006f3ef214e71sm1121435ejv.215.2022.05.11.09.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:04:12 -0700 (PDT)
Message-ID: <6c848c9f-5099-b565-0d33-2ab4c6b9fff0@redhat.com>
Date:   Wed, 11 May 2022 18:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] toshiba_acpi: use kobj_to_dev()
Content-Language: en-US
To:     cgel.zte@gmail.com, andy.shevchenko@gmail.com
Cc:     chi.minghao@zte.com.cn, coproscefalo@gmail.com,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, zealci@zte.com.cn
References: <CAHp75VfzbWAS6phV3eB7ehe50NrXitkuS54sYjdVK-OqqYVieA@mail.gmail.com>
 <20220511021638.1488650-1-chi.minghao@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220511021638.1488650-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/22 04:16, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use kobj_to_dev() instead of open-coding it.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> v1->v2:
> 	remove Reported-by: Zeal Robot <zealci@zte.com.cn>
> 
>  drivers/platform/x86/toshiba_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c
> b/drivers/platform/x86/toshiba_acpi.c
> index f113dec98e21..0fc9e8b8827b 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2353,7 +2353,7 @@ static struct attribute *toshiba_attributes[] = {
>  static umode_t toshiba_sysfs_is_visible(struct kobject *kobj,
>  					struct attribute *attr, int idx)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct toshiba_acpi_dev *drv = dev_get_drvdata(dev);
>  	bool exists = true;
>  

