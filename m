Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4593B5755FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiGNTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiGNTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C3DA1CB10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657828147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iO6/U5jvOEkMN6+5jOvymgFCuk9/AsH1Vqtm0cSdhzI=;
        b=T8wQYcAQ1sgnX9mVCHZDF3k9xifz4CfR8+4QcBYvPqBYxpv7ilfOYyAXPX71JnaHJY3DO2
        K6JYSe2WtwuJeKw5JZRAxKjYYC94L0uU+z1RS03FG/FO689wqxP+/L9I/1fYE11fgNl1WX
        NJX8XCAGX4DaNCkVFFzNqbWM6l/Itgw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-dH-EZd_wNAOpWhy-sd82dg-1; Thu, 14 Jul 2022 15:49:05 -0400
X-MC-Unique: dH-EZd_wNAOpWhy-sd82dg-1
Received: by mail-ed1-f69.google.com with SMTP id j6-20020a05640211c600b0043a8ea2c138so2083493edw.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iO6/U5jvOEkMN6+5jOvymgFCuk9/AsH1Vqtm0cSdhzI=;
        b=4zGPkZuEh+csi4Q9xd2IsUUgOg8SmSHLQKReRfZH98L7zhG2Vri5HCfOB10TTwiSqs
         IVsQ5AthsKHvqfdCrZv1hqiBVuu7Trhmd771CTc0uN0c4kQOdvYhWNRI5xogubo1BUVh
         0ZTxqGxnR5jQsxa0IlRtT24CWPGX6ILKdlTdVxDY+jlXcTdIV1GrZ9VExwVpz/zxNFVj
         69e6yX6F2tTuVOEI/2jeIDihHOPbXeSFQg30DyTnZJrOpWF9weC02gnL+yZqmVblTIK8
         EPp2dQ1E2KCQDFcUTAs74QRJpSji3TEbjhsRVvoB4QKCsm6WZ1mI9j4FxQo5RgQZQ0mg
         BUZw==
X-Gm-Message-State: AJIora8o2NLc1ezWrT3+1WWrVvH1zHd0xgeaR/mVJ+tDUqCzoFCuLC2j
        l9yQeLaOfq/I3TQqW8RPYSmoD5EvNLxx+rU0zcMp1R7d5+hTLMdp8FjNeRAaBf5UgHUm6WNkljl
        yq2dje15GphxB5y2OJ4yLNDLc
X-Received: by 2002:a05:6402:2b93:b0:43a:5aad:73c2 with SMTP id fj19-20020a0564022b9300b0043a5aad73c2mr14541026edb.300.1657828144210;
        Thu, 14 Jul 2022 12:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t6OV1MCd6iZ5F7vvMF70fnIVQq31vYx/5mlv1ubca/PFvaEM7yPGw1QWqENjFZz6d/CKYr4w==
X-Received: by 2002:a05:6402:2b93:b0:43a:5aad:73c2 with SMTP id fj19-20020a0564022b9300b0043a5aad73c2mr14541003edb.300.1657828143987;
        Thu, 14 Jul 2022 12:49:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a8-20020a056402168800b00435726bd375sm1596009edv.57.2022.07.14.12.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 12:49:03 -0700 (PDT)
Message-ID: <2c7d7615-9861-2b1c-d086-2c3eae3e6f82@redhat.com>
Date:   Thu, 14 Jul 2022 21:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] MAINTAINERS: repair file entry in MICROSOFT SURFACE
 AGGREGATOR TABLET-MODE SWITCH
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/22 06:09, Lukas Bulwahn wrote:
> Commit 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch
> driver") adds the section MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
> with a file entry, but the file that is added with this commit is actually
> named slightly differently.
> 
>   file entry name: drivers/platform/surface/surface_aggregator_tablet_switch.c
>   added file name: drivers/platform/surface/surface_aggregator_tabletsw.c
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file entry to the actual file name added with the commit above.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

With the requested Fixes tag added.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bfd69e2b83d..9ec738419526 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13440,7 +13440,7 @@ MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> -F:	drivers/platform/surface/surface_aggregator_tablet_switch.c
> +F:	drivers/platform/surface/surface_aggregator_tabletsw.c
>  
>  MICROSOFT SURFACE BATTERY AND AC DRIVERS
>  M:	Maximilian Luz <luzmaximilian@gmail.com>

