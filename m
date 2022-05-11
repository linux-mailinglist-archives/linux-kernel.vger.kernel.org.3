Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23A1523804
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiEKQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344248AbiEKQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9606E19C761
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652285041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byqMNSdf6bnIBh4DurWrX7V2g59mmEQr+NLKUpUehNY=;
        b=YwLm3LRryiAZpCgQSixWOYRfaZK7gwW1UwCQLxIFiQbgVBdJdhsfxrOZ5eraL+XeVF/txB
        dqALLKMGP7x4vfyosESCskMmiRgUMA/JM2a7uEAjboX0Rwp5x4wW3CFNs9jjWgjSD48VzG
        11XEFkZltNp3MQyr3w8q93B8tancaBM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-nm2EX3_DNRKBmNFPfaNvXw-1; Wed, 11 May 2022 12:04:00 -0400
X-MC-Unique: nm2EX3_DNRKBmNFPfaNvXw-1
Received: by mail-ed1-f71.google.com with SMTP id a19-20020aa7d913000000b004284eecb34aso1607183edr.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=byqMNSdf6bnIBh4DurWrX7V2g59mmEQr+NLKUpUehNY=;
        b=HBqWNTDh8JmH8VoTxdBLZY3nlp7CbAImGRsSjlBvoT57IF3zKkwbWxNDQc+4nNhtW9
         AlMKcICV2LLfnzcn6ltieI6w+0u6KnhxHJpXAScYAWDSbgu3MFv2IHPO2n05ik+OYIXg
         yzSAJ2iKWfkIHRWjlhC9HMfqLXyaf5gsVQgVTT42NXxwvMFNsZI7jjKG6XnSfTBzZkJv
         jOe2SauGUmuebwQ57fQwhsjIAxkxXPBswzEJH3zYjONk+IhjlnMDAb/789SG0PRyOymb
         PO3GKoFXSR98PnUjRokt8+a/CSYThWsXg9vXUVJxClbfLxUmzI/Vyl+Fg1FIDqIhVrwn
         yXTw==
X-Gm-Message-State: AOAM533XmgL9qY/h2M1gKiY9gFF96m+US6oiybY7aToDGKIjS412YA07
        qU+YS1tnBx/F7xreQ6sEcwP22Ehp60pB4UnppSi5sHAT2tAlhqGM786q4VC44s/3aJpjLNuEWys
        VXHtSrTC8egcSjz4k7Oc1h7f2
X-Received: by 2002:a17:906:3e05:b0:6f3:a14a:fd3f with SMTP id k5-20020a1709063e0500b006f3a14afd3fmr24340209eji.640.1652285038872;
        Wed, 11 May 2022 09:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz57bRJ8Xm97UzTQ6gASlTYMO34H4z/Jt5jP3gub5wjACPTo4dTYHQBBEZVD8jqkcn8T3Pliw==
X-Received: by 2002:a17:906:3e05:b0:6f3:a14a:fd3f with SMTP id k5-20020a1709063e0500b006f3a14afd3fmr24340190eji.640.1652285038652;
        Wed, 11 May 2022 09:03:58 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7d9d6000000b0042617ba6392sm1337013eds.28.2022.05.11.09.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:03:58 -0700 (PDT)
Message-ID: <1bdf6cfd-7690-f949-8eee-e545af979a3a@redhat.com>
Date:   Wed, 11 May 2022 18:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] samsung-laptop: use kobj_to_dev()
Content-Language: en-US
To:     cgel.zte@gmail.com, andy.shevchenko@gmail.com
Cc:     chi.minghao@zte.com.cn, corentin.chary@gmail.com,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, zealci@zte.com.cn
References: <CAHp75Vc+G1JNkxBcpyXge9qsGpT0m4erBV1aEi4bMHDYfE-JOw@mail.gmail.com>
 <20220511021522.1488373-1-chi.minghao@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220511021522.1488373-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/22 04:15, cgel.zte@gmail.com wrote:
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
>  drivers/platform/x86/samsung-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index 19f6b456234f..c187dcdf82f0 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1208,7 +1208,7 @@ static int __init samsung_backlight_init(struct samsung_laptop *samsung)
>  static umode_t samsung_sysfs_is_visible(struct kobject *kobj,
>  					struct attribute *attr, int idx)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct samsung_laptop *samsung = dev_get_drvdata(dev);
>  	bool ok = true;
>  

