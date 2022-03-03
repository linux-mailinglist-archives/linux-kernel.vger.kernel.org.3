Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535354CB6E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiCCGYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiCCGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:24:48 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351CE15C9DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:24:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id u17-20020a056830231100b005ad13358af9so3727037ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 22:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTAaJqVx+g0L5JChfp/fev9G6j9NqJ9mgoa/6NPnewI=;
        b=JsAr0un9vpUk/FOo92FA4yZQMG3qwq2KxW6PjSNvQCxdyJoEweD1jZQAJoie/fcSdy
         l0Dapen9U2y5Ffmgn3hxRwFADdbGDXqAALpJeCTu3t1zAFXQnoN06Zv89C1HVSMlGRIW
         gf+Cbe+baFZHUWRwBo/28Ysdt16NlkJjS6CbhfARKOrOzpwDUmkQ9O2r31uL/Uma/XIf
         fgzLuHOrL2+8qEd6UHtA9BsOZvlhOw5r9mOEsJfcUcm6Nn4n3x18ZzmQtSDROXP2Sb8g
         ilVkpB+3I7DKeqel63k1NMQWHIBaF0UBiofy+DEPPAuSi79HUP2LmHQD114bclPQks9b
         Y15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RTAaJqVx+g0L5JChfp/fev9G6j9NqJ9mgoa/6NPnewI=;
        b=jBTFGl+0V8ge/cdco+fcCkZ6MDd248f/p73BR35sgsYHWqYi4SGdrxuPN2atKB3LeD
         4PzO78d9wAv2F/nBGcXdvwcuCO3HR/TuCgwjX4Endw5SZ3M9p0YHxaIPoBTX2BvrgALS
         D4Tsjsm7OHSFoGnwFVAVV4pTggUnOUVnO/EdxPUM++ChcrnpbFmKl+9Y3OFzU5ROkNbW
         B/kRu/h/KWY9/JMjrqXMOohMGXNmrZtMh/JuetRaKGCfnOitGoWGDVovWi67scx+OVnW
         6VSDqyR095KfoGg28yhpeKxYxdtftatee4l7mMFCbIJ/8MP/rK48K+MsXOvFFe/E4Hjb
         Mwdg==
X-Gm-Message-State: AOAM531dCkz0IByih3mjstT4af6sMWX/K4Rs317FBp+iZnfYbGS8CjBJ
        muZ1uos5GhJPv0uv//qpIkA=
X-Google-Smtp-Source: ABdhPJxeF/aDCtUEPgc69fQDujQNI0Rt769/bO40LhlXDfdb/2ZAhxnoW+eMykPKVv83EnGiBypqQw==
X-Received: by 2002:a05:6830:9c4:b0:5af:2866:2884 with SMTP id y4-20020a05683009c400b005af28662884mr17603949ott.258.1646288643544;
        Wed, 02 Mar 2022 22:24:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6-20020a4a2c06000000b0031c0514194fsm515777ooo.31.2022.03.02.22.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 22:24:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Mar 2022 22:24:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aashish Sharma <shraash@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        groeck@chromium.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix no previous prototype error in drm_nomodeset.c
Message-ID: <20220303062401.GA3284490@roeck-us.net>
References: <20220302170902.752687-1-shraash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302170902.752687-1-shraash@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:39:02PM +0530, Aashish Sharma wrote:
> Fix this kernel test robot error:
> 
> drivers/gpu/drm/drm_nomodeset.c:8:6: error:
> no previous prototype for 'drm_firmware_drivers_only'
> 
> Including drm_drv.h in drm_nomodeset.c which contains
> drm_firmware_drivers_only's declaration.
> 
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/gpu/drm/drm_nomodeset.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
> index f3978d5bd3a1..9402deb4985f 100644
> --- a/drivers/gpu/drm/drm_nomodeset.c
> +++ b/drivers/gpu/drm/drm_nomodeset.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <drm/drm_drv.h>
>  
>  static bool drm_nomodeset;
>  
> -- 
> 2.35.1.574.g5d30c73bfb-goog
> 
