Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281056C86A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiGIJqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGIJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978CB6E885
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657359932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iWvnBMFObBlyOO6QJSeCElG9d75fpXtdy6dwQMRWtN0=;
        b=a2kjd0JTWyqi/pv55ettf9OJ5Y7bk7abqQtPYMt1NIG2bvhtUS6+esZQdmZLnrc9yyObFn
        UwBxVYhRgO13Ol5KjV8ccT6EOLCJ89bOgxHpMQrsUV0nxEpdV7i8ifHgPG8/B6FEZPn1zt
        KoQknbZBpu+HbuTwzhz65LhwmcawxoM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-GBVTXI-zPLSeLOnUDG7C7A-1; Sat, 09 Jul 2022 05:45:30 -0400
X-MC-Unique: GBVTXI-zPLSeLOnUDG7C7A-1
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a05640250d000b00435bab1a7b4so825431edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iWvnBMFObBlyOO6QJSeCElG9d75fpXtdy6dwQMRWtN0=;
        b=K+DBF9vvYRML6PB/9BePFyWZVEmVekB6E6DCSRRyzr0eC57uylTFHxoldjX14FFAFL
         DNJRxcCPPQ5KYUz9mFRP77BUtDRCcu2+oRda9gjHO0LOWFNoIroqfzDJX6TKscXWQSSJ
         Ns6mDRx3BCjNwh9KwAL/UoIi6KZPT+p/891fhF0qQR8p9UjomKI8V0hFXvCJc6LsafkU
         BZzRMH01v7hEgDqy7Y21RWDqJ8F22UHm3sczdXrq9mj2/LNLJkBD60k/78qzruscRFeA
         s7LlF0nLcbOYuBGX7wLsTxsQGO08EwZFcgZsy6OT1PUEBLpsP1xM4bJOvqpVKjBjJxW2
         lrEA==
X-Gm-Message-State: AJIora+ZcwegeJPwfUX0mdMSMp616wGLpgwZtDz/CHaC8ybhHAiF/2Rt
        Lz94DOKrVaQIvn+F+soztQMIJ6s77uar0f12nxmmK35NIPUqhhfm2UuDpsYINY7jcERVQVajo4T
        kLpXijOgEZHphyERGgtWAVMQ6
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr10338733edx.128.1657359929498;
        Sat, 09 Jul 2022 02:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sktFAj695Q1qN3O0qx1hrC8DPFEhPTFugT3sudOcjMzshgtIOXHdA/+MZHh2dgOnE5u3d0qw==
X-Received: by 2002:a05:6402:5c9:b0:420:aac6:257b with SMTP id n9-20020a05640205c900b00420aac6257bmr10338720edx.128.1657359929354;
        Sat, 09 Jul 2022 02:45:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072aebed5937sm415607ejc.221.2022.07.09.02.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 02:45:28 -0700 (PDT)
Message-ID: <929f8a53-0529-a4fe-699a-18e8f106368e@redhat.com>
Date:   Sat, 9 Jul 2022 11:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/7] platform/x86: serial-multi-instantiate: return
 -ENOENT when no resources found
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220709000636.35550-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 7/9/22 02:06, Andy Shevchenko wrote:
> Distinguish the case when device is present, but there are no resources.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

IMHO it would have been better to squash this together with patch 2/7,
but think patch 2/7 should be dropped, so this one should be dropped
to IMHO.

Regards,

Hans


> ---
>  drivers/platform/x86/serial-multi-instantiate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 1e8063b7c169..97db23243018 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -100,7 +100,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct acpi_device *adev,
>  	if (ret < 0)
>  		return ret;
>  	else if (!ret)
> -		return -ENODEV;
> +		return -ENOENT;
>  
>  	count = ret;
>  
> @@ -184,7 +184,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev,
>  	if (ret < 0)
>  		return ret;
>  	else if (!ret)
> -		return -ENODEV;
> +		return -ENOENT;
>  
>  	count = ret;
>  

