Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8A511AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiD0Orh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiD0Ore (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA61B377EC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651070662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WES/DONTscNIee2b1p9QAIv6eWVgPRSNblxExvEsu6U=;
        b=MR3eenXa0Pg1atRmasXJwGy3h7c+hxXCmSUD+DeX7AGZ6MyJdLxr1Q6OFGYdGz/MlWUCtX
        91lOXjsT+bfIRYfqXoarKy8XkoWK1W/WkXYit7Aoqd0CNE0hdZ824bC9g0H0TXAx8Wu5hA
        Q4eEoVz6eZ99pg5yqN2Gj5wmfYIGYDk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-b7E6QFFTNvCeDSdOBLHH5g-1; Wed, 27 Apr 2022 10:44:21 -0400
X-MC-Unique: b7E6QFFTNvCeDSdOBLHH5g-1
Received: by mail-ed1-f72.google.com with SMTP id ec44-20020a0564020d6c00b00425b136662eso1124306edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WES/DONTscNIee2b1p9QAIv6eWVgPRSNblxExvEsu6U=;
        b=go92LLYMAxZThVpVVmJas3nGLcbFDhbBRqmzWPgAxxjnL34Gqca5uGECFAZcs5SZ0o
         8gw7yLFpysDHedm3jbFZ6Ue3G9sIujifqGG0Xc1ahMiJ4jGjaAT/VmnSeIjQGSRForAk
         rk6fhSpTuHpRbyU1jKsw6i6OoTHt2zt1DaKnFl5epREelCNpMv/YWwY8LoYvRDZFsXv/
         smUsiVzRwi9VdK8tmMAPuwaZf8MrKijvXIgYh4M+tmL5y+1npuHHdowMyHAbt6EtKEm9
         oPJzkQ5i68S5EK9Cl0elb/wZv5EPbvK99EePcmjc3YirUsfT3BKLJlSKw9UXYtuucA8c
         5m9g==
X-Gm-Message-State: AOAM530dBnnhIUhN4nSjD1ohC12r/aLcOJ72j9Qt8gTV7sDmPN3FRwOU
        fY7K3dtdMWxAEPgfPhGBUJheWsNdlvP397IUeC21o3UXvweLG4j1NBPnPp5JDBunD7nACNOtUDK
        l8s25uqDkEVX4w98WWaQFXOEP
X-Received: by 2002:a17:907:105d:b0:6f3:a3ea:cdfd with SMTP id oy29-20020a170907105d00b006f3a3eacdfdmr11621186ejb.704.1651070660013;
        Wed, 27 Apr 2022 07:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIHorRKmbjkRUTiIiR2TjeGeYIOAx/VsJ3BxkFfj+YydEkiklsh8Wd8ujfHxW2QKyaCdSLtg==
X-Received: by 2002:a17:907:105d:b0:6f3:a3ea:cdfd with SMTP id oy29-20020a170907105d00b006f3a3eacdfdmr11621170ejb.704.1651070659831;
        Wed, 27 Apr 2022 07:44:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fy3-20020a170906b7c300b006f3bbd17e3csm2305543ejb.155.2022.04.27.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:44:19 -0700 (PDT)
Message-ID: <5f434529-2dfb-71c6-4fc2-20dbb5cb68a8@redhat.com>
Date:   Wed, 27 Apr 2022 16:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86/intel: pmc/core: change pmc_lpm_modes to
 static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220423123048.591405-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220423123048.591405-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/23/22 14:30, Tom Rix wrote:
> Sparse reports this issue
> core.c: note: in included file:
> core.h:239:12: warning: symbol 'pmc_lpm_modes' was not declared. Should it be static?
> 
> Global variables should not be defined in headers.  This only works
> because core.h is only included by core.c. Single file use
> variables should be static, so change its storage-class specifier
> to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

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
>  drivers/platform/x86/intel/pmc/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index a46d3b53bf61..7a059e02c265 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -236,7 +236,7 @@ enum ppfear_regs {
>  #define ADL_LPM_STATUS_LATCH_EN_OFFSET		0x1704
>  #define ADL_LPM_LIVE_STATUS_OFFSET		0x1764
>  
> -const char *pmc_lpm_modes[] = {
> +static const char *pmc_lpm_modes[] = {
>  	"S0i2.0",
>  	"S0i2.1",
>  	"S0i2.2",

