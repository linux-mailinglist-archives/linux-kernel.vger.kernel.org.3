Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801D5563FEE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiGBLsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C286F12082
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656762518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsk5LtoJ5L3Sna553tYxn8C/ppvSkfs3ONiQ9booEt0=;
        b=BWKaOLNJeLWWQHtJdq1HeRFoSRjp7Zh/Urb8aVf7vkNRKPQI+Te6u3zMgy4b6+M0u1CQ5D
        NkEVK+9XsHZ2WvYHbaftHulKovwht0k5vStn+Ih4caPYrwKcIWTFb2ZdWgNNLGPaHQBZL+
        n+EAyDMNmpFfarPtK2jX3st1O0eGyOc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-uTgpg3AFNYm8RSK663_70Q-1; Sat, 02 Jul 2022 07:48:37 -0400
X-MC-Unique: uTgpg3AFNYm8RSK663_70Q-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so2671364wmj.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wsk5LtoJ5L3Sna553tYxn8C/ppvSkfs3ONiQ9booEt0=;
        b=0+J5w67z5hq/dp1teueE/rbWBSYKzncgrfwdcFarn9TrXrWin0+SPaQjtzLMfhEYZf
         EEFDuJ+sK3tvUxkwUWrThiFGxU5ykDJt6CaAMiubKPiOHsezv77qEUA7mcPT/uuLiWkz
         4q6admJJbYwccuD2GXjAriK9V6zg/I7ip3O8e7V9zLNgFOeuVZk1E9/9ai5G1yidagqn
         FGg713wPk5sHIi4bXezicMKbtcKrhnxuo4Y88vAADVyeEdU2+juXZzD5n/52J0QCaN0i
         h656SPM4tquC3GFxWCnapJB+SKhsSFgMayxzaMzfwPGg20lCMdcLr/w81boq5h50etU8
         ghhw==
X-Gm-Message-State: AJIora+H7C1uXDRHdE2UakeCEvSmzL3qDBeCq4Y3Qdxsr6VdTu1GPemq
        7Z6sBZOm03eoqDP3bq5GCSyFnPhAaJBnwgDo0F8mwOcSwNBwR25fg8vKS6e/oLFNwahxuCKc5+n
        JY88jFFa/X03PIZcEBRfDP8lF
X-Received: by 2002:a5d:598c:0:b0:21d:26b6:ee94 with SMTP id n12-20020a5d598c000000b0021d26b6ee94mr17887651wri.457.1656762516673;
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ttlfskSCAotB8xeeIXxHixn2sjYEgxtb1ckGEMA1lPqvwqnqGgGkPjbHj3Rl/IhS7i3ZNuuA==
X-Received: by 2002:a5d:598c:0:b0:21d:26b6:ee94 with SMTP id n12-20020a5d598c000000b0021d26b6ee94mr17887631wri.457.1656762516436;
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b0039c4d022a44sm13621989wmq.1.2022.07.02.04.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 04:48:36 -0700 (PDT)
Message-ID: <7ebde68e-7710-d0da-dff8-a06e1b6ba870@redhat.com>
Date:   Sat, 2 Jul 2022 13:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/9] drm: selftest: convert drm_plane_helper selftest
 to KUnit
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
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Djakson C . G . Filho" <djakson.filho@gmail.com>,
        Anderson Fraga <aaafraga@gmail.com>
References: <20220630004611.114441-1-maira.canal@usp.br>
 <20220630004611.114441-6-maira.canal@usp.br>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220630004611.114441-6-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 02:46, Maíra Canal wrote:
> Considering the current adoption of the KUnit framework, convert the
> DRM plane helper selftest to the KUnit API.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Tested-by: David Gow <davidgow@google.com>
> Co-developed-by: Djakson C. G. Filho <djakson.filho@gmail.com>
> Signed-off-by: Djakson C. G. Filho <djakson.filho@gmail.com>
> Co-developed-by: Anderson Fraga <aaafraga@gmail.com>
> Signed-off-by: Anderson Fraga <aaafraga@gmail.com>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

