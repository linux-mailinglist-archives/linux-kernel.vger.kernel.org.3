Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54004F18DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378729AbiDDPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378822AbiDDPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1442F42487
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649087479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztkMzR6AFKFUbWj3TFBCPhwIkZT9lK3mwv6qAxrBqJQ=;
        b=JBDUJ1GxCHT9QCr1f/s65/VverP7Qll7hY9l5L2xvyGPwopde+Bx/0mU720r9AKap2Yay3
        5MJbEwLxhZny7LkwBR6otjVP6GFO4j5oB0IdvqAkIgqdK4wWY9wVYykMW9WljiQvEWq3R8
        z34xRJK+pMmEfKqkzfXjE54R2Zx4L/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-A-li_wFZNTG85ufnnoH2vw-1; Mon, 04 Apr 2022 11:51:18 -0400
X-MC-Unique: A-li_wFZNTG85ufnnoH2vw-1
Received: by mail-wm1-f71.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so155875wmr.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ztkMzR6AFKFUbWj3TFBCPhwIkZT9lK3mwv6qAxrBqJQ=;
        b=O5zcURxTX378rT9qEDN2/DPWZbaIDCRZavX1OXig9480gxYR/Y6+qrzx6DrBg4iEoY
         6WwfRFzc/YSJrAOQRKrjkDjnqZBxnX0ear6i04eRqDo6ZcsZQQZZmcaPYC5KCY77HlYu
         ubeg/VAelI5vegdNQdet5NfKWBkSAuwxYE97tFIWhtmMGownX2FWnHz1GHYCDLIs7Lp8
         7Tjn1sK4OlN7W6yZ2KiegqZfZOt+gRjn4ipUmEtncvJ+7P/OZBVeNaOl95Lz+a1Qjb97
         TAQSoqicY5ShJ1Pnti6105zVFxY89gCYTLcki+oLO8Csy3XZz37B5Ewcnr4b/wpgv5ne
         VDNQ==
X-Gm-Message-State: AOAM530UOgTiXlYs0NNA5Un/c/1f7CRgnRKZmmo5GMsJju8RtyxkeTlE
        KH/2Qgoxn/fn5FeaMh4Zh8FsPZFAi3jpoizIccXvAou4laLFUKE+rFcZDP6F9DdWCzViIZDpaSi
        4GRdEV6p+3sG2pcu5Dzb4KE2h
X-Received: by 2002:a1c:7204:0:b0:38e:70f4:edf1 with SMTP id n4-20020a1c7204000000b0038e70f4edf1mr171672wmc.18.1649087476769;
        Mon, 04 Apr 2022 08:51:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqPFQoBH+n99pHf4G9kdT6j9HVXw0NXVS9LNUOgzNhNzUFeYqWv2Xi/awInhum+eCt95wBfA==
X-Received: by 2002:a1c:7204:0:b0:38e:70f4:edf1 with SMTP id n4-20020a1c7204000000b0038e70f4edf1mr171657wmc.18.1649087476512;
        Mon, 04 Apr 2022 08:51:16 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w12-20020adf8bcc000000b002060e3da33fsm4500411wra.66.2022.04.04.08.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:51:15 -0700 (PDT)
Message-ID: <bf917bf0-a380-6689-95cd-77ff0317f578@redhat.com>
Date:   Mon, 4 Apr 2022 17:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220403232902.1753-1-rdunlap@infradead.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220403232902.1753-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

On 4/4/22 01:29, Randy Dunlap wrote:
> It looks like the incorrect name of a function parameter was used
> in the kernel-doc notation, so just change it to the function's
> parameter name to quell the kernel-doc warning.
> 
> drivers/gpu/drm/drm_format_helper.c:640: warning: Function parameter or member 'vaddr' not described in 'drm_fb_xrgb8888_to_mono_reversed'
> drivers/gpu/drm/drm_format_helper.c:640: warning: Excess function parameter 'src' description in 'drm_fb_xrgb8888_to_mono_reversed'
> 
> Fixes: bcf8b616deb8 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for the patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

