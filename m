Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B2564051
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGBNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 09:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 09:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F7A7237
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656767875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wQWnDeTi8uNY3ltPnFoch0K9/rDLf1kzMqZRJMA7Nw=;
        b=jUL/xrKZ/5z3WzRoNVE38XIZ/M+o7MCBClN0GR4ZZB9RpoNAvftyOCybiZmSM/wmhKL9n0
        EZm4iPZ0PfV1gL2FQ4FQ3u7b1sAI2ult6jsBjGLcsofFjeASNjco1hf1CE+BmwyGXXcJ1X
        qoqsH1xTOeckMrUrmwWeoIXb2KWUwR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-rq0_VJPoO2yJh2rBahDrSg-1; Sat, 02 Jul 2022 09:17:54 -0400
X-MC-Unique: rq0_VJPoO2yJh2rBahDrSg-1
Received: by mail-wm1-f69.google.com with SMTP id az40-20020a05600c602800b003a048edf007so2122540wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7wQWnDeTi8uNY3ltPnFoch0K9/rDLf1kzMqZRJMA7Nw=;
        b=jOMD1/cUTtq43dN6bOCEp7I8T9nAUr7acy9j9Qov7/X65aG2xR39DYO+ls9dpA65vc
         VOSYZXaPOc9HnguPAIUjPs62P2yyOg4iAtHWSARfanWIAh5z9m1p4WcwVEUh3YKuVn1A
         eBEi8AicbHJP6AYzb4ZWdKTWxzLKS27q356Sfus3UJhxDCL4G4fw2B532lLBriTsjBdp
         JlzY5XwUvN5lTk6utlx5ml6Qobj1dlbhYsfpcxNp27jsdZJoAp49A6ek1/VIXqCZfaUj
         Y3PIIoCCmOwEBNvObaHTKBrr0fsaAQjdaPk294RAvhK/u4FRiPOMAxChqK37MircW6UU
         WUQA==
X-Gm-Message-State: AJIora9e9mCxCcdDk6IIFWEJ5AmsDna++H0d/JfQdsi4v1jNA/tlDRj0
        aU2SS1rfebLyUhiMCUINVXH3NSQAaymMvtzctJaoDKEdyPa+rGKt059N4+kHZhX0DMcm4lsESen
        4pKRoSkXuomv4tKKh3reTEJ+7
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr21754914wmb.199.1656767873520;
        Sat, 02 Jul 2022 06:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vu2EJ+eqiyEMxGUkvKkZOQdhu9zVQtQLZAzTQirdJVvvl4MeRJd20akcdE/RUh+2SrmUL0sA==
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr21754878wmb.199.1656767873173;
        Sat, 02 Jul 2022 06:17:53 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d10-20020adff2ca000000b0021a38089e99sm24999260wrp.57.2022.07.02.06.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 06:17:52 -0700 (PDT)
Message-ID: <4c2dc8cd-56c4-6e15-d76e-429dba87407c@redhat.com>
Date:   Sat, 2 Jul 2022 15:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/9] drm: selftest: Convert to KUnit
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220702131116.457444-1-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220702131116.457444-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maíra,

On 7/2/22 15:11, Maíra Canal wrote:
> Hi everyone,
> 
> Here is the v4 of the conversion of selftests to KUnit. Since the v3, there
> have been minor fixes, asked by Javier. Basically, fixes on the SoB chain and
> addition of Copywrites.
> 
> Thanks for your attention and any feedback is welcomed!
>

Thanks a lot for the quick re-spin of the series! I'll wait a few days in case
someone else has additional feedback and then push to drm-misc (drm-misc-next).
 
> Best Regards,
> - Maíra Canal
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

