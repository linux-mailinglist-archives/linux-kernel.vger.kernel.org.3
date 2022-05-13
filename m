Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA65261DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380258AbiEMM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380250AbiEMM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9813F5BD2A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUx2v8qsPenRXH9JcXLDmo2qkX4LLDjdAwjr1Yz2a/c=;
        b=ZfHbEc9eH0brNZ7Aoyiv3kHp0y5XZHy37hfLGLfBnxxwiUV0V1Oj13TyHa5Fr6BkPmOOPs
        QFx1zgBCeSXJoW6CQzwr8DFAJEPMpEzxq1ZQOXpoPV7W29lntHvlS1ZpcU5HFRMQkfe5t0
        /LoWnOAGKk4vY5sHh4hyulplWfcTuzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-rL-OIEZLO9m-ZGrtdcm9mw-1; Fri, 13 May 2022 08:29:29 -0400
X-MC-Unique: rL-OIEZLO9m-ZGrtdcm9mw-1
Received: by mail-wm1-f69.google.com with SMTP id g3-20020a7bc4c3000000b0039409519611so2869870wmk.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUx2v8qsPenRXH9JcXLDmo2qkX4LLDjdAwjr1Yz2a/c=;
        b=KwgtDRzTTIv6/THLNB/hMXluTDITmCcDXEQrvx1JYv6TRVHn2yci9+Ivdx05qzioiG
         n+e+pCpSq2zqnfBXtJJgtrszRBbyLeWTAXYO+aAiBbm9Y3n2Nmy8P2q6vhP9sIkBCrSO
         yWQ8cbrYQ0pYSnF80RS7itLf7/B1O/cQURnXSdPDlKgCN9XKz+oqS7HQ4GaecYJ8PdzZ
         nxwHxV4KKN5tAqNKJ/A8SS6O3XPcK5KtdVFIE8HOud/fnjS4/bycweNRvp68Nv0e21C2
         VMGnBa0ipg08TH5iOFarmcRMf1vhLSLn+aTGuRzBUKRiv9mZsU8bF7II/q7Rm87lSI/r
         EEmA==
X-Gm-Message-State: AOAM530pGwiT2aM6o4NT84Bj1iTnNT8OCmupdIR9swI8WicN92rb76VJ
        U7+wrkQKUp5OMESKamlxWVAWy6UgD8GtWzq2ThgrN7yzqQvApdnLOlP8q4NY26CkvXFhqAZ5eeh
        1+iw2iQB2TrEe2MRTJSQbyakpDSUnKgqSItDUzW1ovDOHNiOUtAqt/FXsdFoRs7laPyAGYvBHDD
        c=
X-Received: by 2002:a05:600c:3ba5:b0:394:6a82:8dbe with SMTP id n37-20020a05600c3ba500b003946a828dbemr4251412wms.185.1652444968370;
        Fri, 13 May 2022 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZHiFgsQEc6o9p9wXNxY7rLpgdqYrrRy8dqWoxDl7lbXz2Av9EzL6Uyc1s2ZY/cv0n+100bQ==
X-Received: by 2002:a05:600c:3ba5:b0:394:6a82:8dbe with SMTP id n37-20020a05600c3ba500b003946a828dbemr4251399wms.185.1652444968161;
        Fri, 13 May 2022 05:29:28 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o42-20020a05600c512a00b003942a244f49sm5910754wms.34.2022.05.13.05.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 05:29:27 -0700 (PDT)
Message-ID: <0876d022-f6e2-a0cf-0e16-d6a19aec0a48@redhat.com>
Date:   Fri, 13 May 2022 14:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: vesafb: Allow to be built if COMPILE_TEST is
 enabled
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220505120419.314136-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220505120419.314136-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 14:04, Javier Martinez Canillas wrote:
> The driver has runtime but no build time dependency with X86, so it can
> be built for testing purposes if the COMPILE_TEST option is enabled.
> 
> This is useful to have more build coverage and make sure that the driver
> is not affected by changes that could cause build regressions.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed this to drm-misc (drm-misc-next) with Thomas a-b tag provided over IRC.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

