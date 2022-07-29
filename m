Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27D584E20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiG2JhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiG2JhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 397244F674
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659087437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/azwi5xIgQ96LQP0a/nNpm5S5erGJtWP4pb2ZOi6mo=;
        b=MZzY1n9GbXo1U8clsgoqHOr3H+pkwFfQodM8MrsyQwNjeIqFig60bpy59hxXFxBGl5GmbT
        8owjrJfdk25uEi1qTYjvVwH9H+Kdi3SrQTT55a84alIedvIpv4X4xhxlI0COTy1fHg/5OC
        dwp70s87N5vNDhGXVVGtFcKT4buqIeQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-TDIjoKAEOAG_Runqcbo-fA-1; Fri, 29 Jul 2022 05:37:07 -0400
X-MC-Unique: TDIjoKAEOAG_Runqcbo-fA-1
Received: by mail-ed1-f70.google.com with SMTP id r6-20020a05640251c600b0043c1883836cso2612480edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T/azwi5xIgQ96LQP0a/nNpm5S5erGJtWP4pb2ZOi6mo=;
        b=RC6IQO4GnQFZ0fjpZ1FZDhgEnRTZKfwbv2ELEqlzfXmLPaECEh/VXlbn7TMGW//Xw3
         8Ch756FlmSEugi47yXyaUdfgXxV2xzObiROv/3L8J+O89nUu/2kF1yMXq3l67sUDsPdX
         cku1TTP9d5uZwE0Zr/ucrS0NEi2IbEbHrkqovxTCQ4eAY6/XPPg5lG7lbS/ZJDp5kq6/
         EPoKqyIkLuihSa7h4Tys5Ghh/kNiRwB1vOQy0BFF52W+mWTqOElOAA5/WNYFm7nQ9yiR
         xoS8aySTde4iD0S8b1NnH2Cgq82ryObCL8ZDqwSVwp7qMk8X9Z05O/iKZdbJV5duU7GQ
         OGTQ==
X-Gm-Message-State: AJIora9MzL5pplBJYFHArWxhmc0m2EFBqBApFyEW1wvjiZkhegy/l+p0
        RDfyQ/AWvAnbiSsvY0MSyB/6e5Ox9hZsscQcvVkwcgptB4cXWNq6HWtE2cXpaESmE5v2q1I8rUM
        ubGpFTEYnZg4L+3rDScpZVPjC
X-Received: by 2002:a17:906:cc5d:b0:72b:1313:cd09 with SMTP id mm29-20020a170906cc5d00b0072b1313cd09mr2251994ejb.482.1659087426145;
        Fri, 29 Jul 2022 02:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s51YOo+r58iUpfCWiOhjJpZG04z8VDPZ8mhA7GfyhtmLhHCcOW3IpvQv/CpeLKODkvc4jx9w==
X-Received: by 2002:a17:906:cc5d:b0:72b:1313:cd09 with SMTP id mm29-20020a170906cc5d00b0072b1313cd09mr2251981ejb.482.1659087425976;
        Fri, 29 Jul 2022 02:37:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7dc16000000b0043d2424aeefsm545033edu.87.2022.07.29.02.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 02:37:05 -0700 (PDT)
Message-ID: <6dba3316-ddb9-c876-06ea-90312fda0ffb@redhat.com>
Date:   Fri, 29 Jul 2022 11:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Input: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725042903.4954-1-wangborong@cdjrlc.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220725042903.4954-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/25/22 06:29, Jason Wang wrote:
> The double `we' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/input/touchscreen/chipone_icn8505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
> index f9ca5502ac8c..ea98657e6e49 100644
> --- a/drivers/input/touchscreen/chipone_icn8505.c
> +++ b/drivers/input/touchscreen/chipone_icn8505.c
> @@ -285,7 +285,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn8505)
>  
>  	/*
>  	 * Always load the firmware, even if we don't need it at boot, we
> -	 * we may need it at resume. Having loaded it once will make the
> +	 * may need it at resume. Having loaded it once will make the
>  	 * firmware class code cache it at suspend/resume.
>  	 */
>  	error = firmware_request_platform(&fw, icn8505->firmware_name, dev);

