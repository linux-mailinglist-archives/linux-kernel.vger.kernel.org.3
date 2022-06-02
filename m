Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FD53BC80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiFBQ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiFBQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C88F550E17
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654187221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mygmPhKiJi7o/hltZa2N+7CYRMGUR5v63WXlkfkXj6Q=;
        b=R6MSc+KJrBbbE3GeKudpgQvp9VRbZk0FLo8PO4hD0U24mAmERU7y+7rXDyqfvTUqInwQ6n
        6H9QpDT6Vek6fXfRsw9IrP9DMpUVPYNu2r2+Pxo+VrUlLwM1uBGu6TbyPttgdyrybybRFH
        5h09P5ITHuYTkiVjxrc0SodgcVti5Y8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-oGYZcEttNWa1pAkqpJ5lfg-1; Thu, 02 Jun 2022 12:27:00 -0400
X-MC-Unique: oGYZcEttNWa1pAkqpJ5lfg-1
Received: by mail-wr1-f69.google.com with SMTP id n3-20020a5d5983000000b0021021e3036eso836680wri.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mygmPhKiJi7o/hltZa2N+7CYRMGUR5v63WXlkfkXj6Q=;
        b=pgR4Zl7cDJONIo7vHSWe3tsqVAOujvZCIyrqiw8Ih7D5WJIJ17WmVEv/22q9B2lIDs
         aRoZK/gPuUWcm/UbqpdZ+ycFbxZsKUsNOss+IOoalw5dUMNBeSoGJs7Ss5nPb7H6qlpq
         /FuXzXz3fn3WFfF6Yo0SIZCTmxsH1pLdMfmWInF/030oFeJ0YfTsjH8QENrz73uI/PzC
         os/A+ZHlHsanoahM8n2jUX5KAfFoIdwRwXSTzSJIBc5iUXxbZUV586uqhZNKtmOR04qz
         NHrNEUfPtpMyoZDLPXnwRmk+UpVaYJ4r1TpeakqyMJxtrRinz5uRQbU2E91cf7BHMzSr
         Hzag==
X-Gm-Message-State: AOAM530KwP0fYpRDHolRYSZTe9ayDX9Tajffgk4p9zVn57UnTQTNjiYh
        ePRIemGUAJjd6oIXpOGn3WaxeAMyHMplfoW6XkzAvf52FnbNbRQpoy5TQ+F+Sy7AXnqO9ypCXr8
        TvFiCDhx5O/MG8jtZZuqHQ0ng
X-Received: by 2002:a05:6000:1887:b0:20f:e155:9db4 with SMTP id a7-20020a056000188700b0020fe1559db4mr4296985wri.243.1654187219644;
        Thu, 02 Jun 2022 09:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz3mxXpaL3a1n46/Ak3TghAtlxNB5xnz5LUKaE7clzJo3LROi83rBH+pU6l0xxChUwQLHFIg==
X-Received: by 2002:a05:6000:1887:b0:20f:e155:9db4 with SMTP id a7-20020a056000188700b0020fe1559db4mr4296961wri.243.1654187219328;
        Thu, 02 Jun 2022 09:26:59 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l65-20020a1c2544000000b00397393419e3sm8948736wml.28.2022.06.02.09.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 09:26:59 -0700 (PDT)
Message-ID: <e26de140-afb7-7b1b-4826-6ac4f3a4fe02@redhat.com>
Date:   Thu, 2 Jun 2022 18:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220530102017.471865-2-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello José,

On 5/30/22 12:20, José Expósito wrote:
> Test the conversion from XRGB8888 to RGB332.
> 
> What is tested?
> 
>  - Different values for the X in XRGB8888 to make sure it is ignored
>  - Different clip values: Single pixel and full and partial buffer
>  - Well know colors: White, black, red, green, blue, magenta, yellow
>    and cyan
>  - Other colors: Randomly picked
>  - Destination pitch
> 
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---

Thanks a lot for working on this! It's very cool to see the first KUnit
tests added to DRM :)

>  drivers/gpu/drm/Kconfig                  |  12 ++
>  drivers/gpu/drm/Makefile                 |   3 +
>  drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_format_helper_test.c
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e88c497fa010..d92be6faef15 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -76,6 +76,18 @@ config DRM_KMS_HELPER
>  	help
>  	  CRTC helpers for KMS drivers.
>  
> +config DRM_FORMAR_HELPER_TEST

I wonder if we want this level of detail for the test Kconfig symbols.
Maybe we could just have a DRM_KUNIT_TEST symbol that will enable all
the KUnit test suites for DRM ?

> +	bool "drm_format_helper tests" if !KUNIT_ALL_TESTS
> +	depends on DRM && KUNIT=y
> +	select DRM_KMS_HELPER

Daniel didn't like this `select DRM_KMS_HELPER` and I think that we can avoid
it if instead drm_format_helper_test.c is included in drm_format_helper.c, i.e:

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index a3ccd8bc966f..d63e02da528f 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -692,3 +692,7 @@ void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *vadd
        kfree(src32);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono);
+
+#ifdef DRM_KUNIT_TEST
+#include "drm_format_helper_test.c"
+#endif

This also has the advantage that will allow to have KUnit tests for the static
functions that are only available in the drm_format_helper.c compilation unit.

>  obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
> +obj-$(CONFIG_DRM_FORMAR_HELPER_TEST) += drm_kms_helper.o \
> +		drm_format_helper_test.o

And doing that will also allow you to get rid of this, since just selecting
CONFIG_DRM_KUNIT_TEST=y would be enough for the tests built and run by KUnit.

> +CFLAGS_drm_format_helper_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>

A comment on why this is needed would useful.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

