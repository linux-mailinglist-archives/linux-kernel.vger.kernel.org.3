Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD05323F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiEXHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiEXHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52EFA68FBF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653376933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGpRKfeqQD5xtli8NfArxAht9/xTK9Q3vgrY1z7EGsQ=;
        b=St4HcUyEm6Et3cpA/3k8GxaB58M62ZkIDuFLQoAU1a+jpNrNeQrxbZsBGiN6+7XiAiVYJC
        ghpUFJTb41LI2RMJr68dzseqVXVLAhdEVnHnKI97tQtbOMmQfdXiIVBC9oF/t2rwL3Cp8A
        NejRP9mBbkwuITEn5izU1wIeMkNRbqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-3MBe5_j4OOOfYiJny23A1w-1; Tue, 24 May 2022 03:22:11 -0400
X-MC-Unique: 3MBe5_j4OOOfYiJny23A1w-1
Received: by mail-wm1-f70.google.com with SMTP id l16-20020a05600c1d1000b003974df9b91cso872301wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cGpRKfeqQD5xtli8NfArxAht9/xTK9Q3vgrY1z7EGsQ=;
        b=NlEW2Zgd/LwTqZXiE1XbbV9aRPHmiGpPb/LuabrkGWIvRbRSIzhjOPZ/EC9o8O3qf6
         8wNTCChdcs82AitglfNTxzfwRpvLtJiyGQPTtoq1hq8M2GExaYwiAn7MH+1eoqNVcosD
         SzK1ndMLc7xzl8k71F5m9HoB+kqfimRK9JuqghAicAzIfAaxGqNxlIktIGbnqeCfhBTB
         egnTCLIzIL9PMTMzmy0ZlOnvlpmiD0Sd47JlPi1+zQzNxSAzqHA4cnQBavXtOrwYjDg0
         7Qvze9mb204GuSyoNWvb75eqpRr3wyPxM0GRrYEc74pGz0bA5377yqCulsYHw8IzM3zt
         gTuQ==
X-Gm-Message-State: AOAM531+cN32FU+v7KOLIzXaHcCZ7URpM/MqoD8bLpLVy8iHh7lukK4F
        uvd1ib0vznNxoetF55/TdGCBAv40UiuktUjgJnsB+BTJ6brSHNNuPh76mi7rDoZ94BqAGJ/cSRM
        JbIMfAmTdGGcDWpmSwn1qBM/O
X-Received: by 2002:adf:f2cb:0:b0:20f:d291:7064 with SMTP id d11-20020adff2cb000000b0020fd2917064mr9675528wrp.319.1653376929867;
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmsxx6H53W1/fydQLyoNgRCIIqy+M82z+0WVSUrKl9Ph2oPwoPovgb6FKlTBu3g1EoNZa7g==
X-Received: by 2002:adf:f2cb:0:b0:20f:d291:7064 with SMTP id d11-20020adff2cb000000b0020fd2917064mr9675508wrp.319.1653376929652;
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b003973b9d0447sm1294064wmr.36.2022.05.24.00.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
Message-ID: <f8a95dcd-4a9f-ddd2-b322-96720f666b37@redhat.com>
Date:   Tue, 24 May 2022 09:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] efi: EFI_DISABLE_RUNTIME should depend on EFI
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 5/24/22 08:54, Geert Uytterhoeven wrote:
> The EFI_DISABLE_RUNTIME config option controls the use of Extensible
> Firmware Interface (EFI) runtime services, which matters only if EFI
> support is enabled.
>

Indeed. Sorry for forgetting that dependency when adding the symbol.
 
> Hence add a dependency on EFI, to prevent asking the user about this
> control knob when configuring a kernel with EFI support.
>

I think you wanted to write here "without EFI support" ?
 
> Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

