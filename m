Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B3523035
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiEKKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiEKKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC35E80
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652263375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMjB2G7unPPwPenmqo3rYuStQgbqeYx/VKs8u/BpsWU=;
        b=gnTPIJieJ6rTOtYA3lo+/GyvejEyYuVsw52nFT/WvG2+Q3VPU1zweHzuGeX7NRPZO76ffc
        2lm4CiHQxapBCP9aL4L3RsrR5JupRjhl3hBCRPAGGPRRNhxrvISkl8wMmbkJj152H4mvjU
        rbxjmkTPQ17lc/6K5pkM4ya9BxMv7ec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-_Eb3aYL2MWeCYP83h5yX-w-1; Wed, 11 May 2022 06:02:54 -0400
X-MC-Unique: _Eb3aYL2MWeCYP83h5yX-w-1
Received: by mail-wr1-f70.google.com with SMTP id u11-20020a056000038b00b0020c9ea8b64fso651696wrf.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hMjB2G7unPPwPenmqo3rYuStQgbqeYx/VKs8u/BpsWU=;
        b=JTxMGAdFooCj+N/k0kPUyuzcjc7Jm9DQoObcUKnSVgAMqYJthaR2lGUa6g38++W6Z6
         eQFttZu3LwmS48s0Aqgyo6MiNKH8xZUPCCz6ZIxIoDvS1fvNydEdrvDM0Bx/DnjQuhTY
         vUdC2Q4XHHZf7LlEMIpABpF3lNbGPeH4VyPDWvhZG6BNFHEB2Sfk8y6HItW6QuQg18Bu
         KieBpXrlHNYkrAXo4XhYssRi/izPQfCvQuDv/O6S0FY4+S8Ti42OdDZxWYtYfg65VPmd
         8Sf3M6axMGoHwCEnzKfBlue/1l/fddZRlrvYDXOEv/hj5MNFtcNHzKfRaBoRjRcfYWli
         qU9Q==
X-Gm-Message-State: AOAM532m05xROSgGHTkIfsDZk1+9B27s61ojAvO9sFpSxz3zVrmI+q6o
        erXO777W+jSZDy6GPlw0Zq+CpCOogAcnXIQGtJeM5OKZTxKM9CLAmosGAh4C99y9mwGBjbRXArR
        Df5fqFjMSens2cgPRdAlzB0Q4cuR9ANvHQH2YKZuu17szTJ4esRo+/clQLkHu/X76kv0v6sXWVV
        U=
X-Received: by 2002:a05:600c:2216:b0:394:54e4:ac9 with SMTP id z22-20020a05600c221600b0039454e40ac9mr4011054wml.47.1652263372661;
        Wed, 11 May 2022 03:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBrUeSkbT+4BLrmflKUrHND/RUBjX08SqbSZAl0SlOD/xx+nWkDhsOnzXIoctbZYlHxbFdYw==
X-Received: by 2002:a05:600c:2216:b0:394:54e4:ac9 with SMTP id z22-20020a05600c221600b0039454e40ac9mr4011006wml.47.1652263372241;
        Wed, 11 May 2022 03:02:52 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c384b00b003942a244f57sm4864259wmr.48.2022.05.11.03.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 03:02:51 -0700 (PDT)
Message-ID: <1f5fbef3-d098-6235-0fda-2fcd81bade9c@redhat.com>
Date:   Wed, 11 May 2022 12:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] MAINTAINERS: Add simpledrm driver co-maintainer
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220505172610.338299-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220505172610.338299-1-javierm@redhat.com>
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

On 5/5/22 19:26, Javier Martinez Canillas wrote:
> Thomas asked me to serve as co-maintainer for the simpledrm driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed this to drm-misc (drm-misc-next).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

