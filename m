Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6BC5A9ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiIAOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiIAOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD58284B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662043749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uk0C29fiL+AzkuoowXwRDI+XMcePXXYzJkfkzAMCoHc=;
        b=duU4EbjTFXfnA7NE1cxIdv0GQUI1SQmGGtCFisS0pGX/8kpCGwYufO/oP9rRK+4V6FCGaC
        wgt11Wtj7rIhG/egtgz45jxilnwq1COxeuFrenhqoYO2PT014QgjuhiQHF2rm6Mpc1JQrR
        rVqiYz2t0TJFWqtAq9wR+Z2Xv3TFpZ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-ij-KrUtZOoSQJD6WUu5Ofg-1; Thu, 01 Sep 2022 10:49:08 -0400
X-MC-Unique: ij-KrUtZOoSQJD6WUu5Ofg-1
Received: by mail-ej1-f70.google.com with SMTP id gn30-20020a1709070d1e00b0074144af99d1so6197820ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Uk0C29fiL+AzkuoowXwRDI+XMcePXXYzJkfkzAMCoHc=;
        b=zd+UrOxVZCKbbIuOBXt4tfQ5bsCAcIwHH1hZJGhN2DwZSajvDf9oD5nNL0kPwbSKzt
         uBMZpBQD94n1sCDH7m6LLnnT8zbr5Akv5wKHVJRZsz79WyOqoBFFPdTyb0iyUMBpOsAi
         s7Cqqkk4jUx6G2Akh14kvJoZZBHOHJeCRafg84OInFu86ulCge2aTb9qJnsqf9lEdIZ3
         LHXzNRDCzStjpnB5+oRGXEPoz9YIytIncdTcMuZIB0WzEAvC/bttrpYlMcTMKIVNqMGY
         3f0Yuh7PgHiq1wmrlAz0UfjuWTjFLRkmGwYBDE6BInnkInX4eYT7q/FTE5xUyrXLhJh3
         nD0A==
X-Gm-Message-State: ACgBeo2Vw72u0yyGTmzM6q3ahgGAw3qHI/h+vO/XC5eb+HUvScMaPMAg
        IUTiyuNGdq00cwfRex5iYAk/Mh9O0ceBeaqG6v9Qhbz4RhNo7XtZqzSUQgsLLHOFbGfyEGcdYsC
        NyCZjOQOLBvhDu0YMSurbYarE
X-Received: by 2002:a05:6402:292c:b0:448:353d:1c2b with SMTP id ee44-20020a056402292c00b00448353d1c2bmr20040211edb.232.1662043746950;
        Thu, 01 Sep 2022 07:49:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Y7uV293KVblWlaz11RPwsowZQwvzuU/5aZq/Da7twN16+T8438u6ttpnZgY3+nedQwb2Cog==
X-Received: by 2002:a05:6402:292c:b0:448:353d:1c2b with SMTP id ee44-20020a056402292c00b00448353d1c2bmr20040202edb.232.1662043746774;
        Thu, 01 Sep 2022 07:49:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y7-20020a50bb07000000b0044790836307sm1489915ede.85.2022.09.01.07.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:49:06 -0700 (PDT)
Message-ID: <0cf9b1f8-96c5-3d4d-d922-96dc1ef69d10@redhat.com>
Date:   Thu, 1 Sep 2022 16:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] virt: vbox: Remove unproper information
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20220901144619.3550352-1-jiasheng@iscas.ac.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220901144619.3550352-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/22 16:46, Jiasheng Jiang wrote:
> When drivers are working properly, they are quiet.
> Therefore, the vbg_info() should be removed.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/virt/vboxguest/vboxguest_linux.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
> index 6fc81347ae72..c47e62dc55da 100644
> --- a/drivers/virt/vboxguest/vboxguest_linux.c
> +++ b/drivers/virt/vboxguest/vboxguest_linux.c
> @@ -398,10 +398,6 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  
>  	pci_set_drvdata(pci, gdev);
>  
> -	vbg_info("vboxguest: misc device minor %d, IRQ %d, I/O port %x, MMIO at %pap (size %pap)\n",
> -		 gdev->misc_device.minor, pci->irq, gdev->io_port,
> -		 &mmio, &mmio_len);
> -
>  	return 0;
>  
>  err_unregister_misc_device_user:

