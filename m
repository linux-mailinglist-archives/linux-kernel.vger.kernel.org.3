Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF657F68E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiGXSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGXSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 837E5DF08
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658688116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIe4/7e2xCRrMXD7HUhMOPa/pdJzjLUmsuMLjrqfl6A=;
        b=IE2KQqX/YT6s9pbtw7utDFBTycezBUd1Zf8bsV/NGc1DVX7lH2wPG7lwrGhwJED+bp3qpf
        ojhH93qer4CO6iMeJrCbIMAI3PcdmpAq/YUr0y0NxD2WCZ5wTcJO6Ty3Jyvyeh2TgaDF+n
        NSOqPBASXTyA98Heym4E793lhdfKpo0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-7WZdxT8zPH2TD2RjyeEWKQ-1; Sun, 24 Jul 2022 14:41:55 -0400
X-MC-Unique: 7WZdxT8zPH2TD2RjyeEWKQ-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b003a30d86cb2dso7484632wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 11:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gIe4/7e2xCRrMXD7HUhMOPa/pdJzjLUmsuMLjrqfl6A=;
        b=CFT1mwZOb/0IicDAbcqGNeHXgvrAH2N73pmD5AS60uWkFiizyX1hlcd8kFR+c1z1or
         /zQhP8Xbkgf0tjmVTqjkV7EwiPtqzpMHx+PEgbIztD6LPEii6kGXAtbPOEw9z+AZqmQc
         LwVZki6/SabPT0xWa4Wwxg9LZZ2jOWlWsOEvKI8XIUyQXmCdSb4iJsoMV0eSGVkhM/XP
         QuSkldHnpqhniOjv65Lum6QsF9w3KTrWVdbYmt+SBaSYmt6CsQIRTTKbwjAQrBc1LQOh
         absbC13VfSpEf2WoqxDGVSlH/nFgeJG5Nl7/8o11OnYidZi4+r/8d6YC1/DIDKLb+/Hi
         dL0g==
X-Gm-Message-State: AJIora8aZp23O7g1aUmtfyPLXShImWoj9+AkLhBphmPIvH2NlHEO1zQt
        kLKJQudmbke+TpftiZbBtcikL2XocTVFSJXyHYUY38yS3ZzTRPFHQG9v2SzpYgFsF98p8qF2bwe
        /pE5j8yNFF6ERZyc2NKNLxO6d
X-Received: by 2002:a5d:6dae:0:b0:21d:ac34:d087 with SMTP id u14-20020a5d6dae000000b0021dac34d087mr6121753wrs.336.1658688113625;
        Sun, 24 Jul 2022 11:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sm5M97cVJghcjpTtHe7vDZxpG3Ni/nmo/EqvERBxjz+1W4Vb+26sc27+eLVyAgJWACpipLGg==
X-Received: by 2002:a5d:6dae:0:b0:21d:ac34:d087 with SMTP id u14-20020a5d6dae000000b0021dac34d087mr6121744wrs.336.1658688113431;
        Sun, 24 Jul 2022 11:41:53 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b6-20020a056000054600b0021badf3cb26sm12426838wrf.63.2022.07.24.11.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:41:53 -0700 (PDT)
Message-ID: <38128880-5b47-7ba0-54f3-97c4d6e04028@redhat.com>
Date:   Sun, 24 Jul 2022 20:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: Prevent modeset helpers to access an uninitialized
 drm_mode_config
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220724123741.1268536-1-javierm@redhat.com>
 <e6ed25b0-49d2-7e3b-91e5-72e431310610@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e6ed25b0-49d2-7e3b-91e5-72e431310610@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for your feedback.

On 7/24/22 20:24, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 24.07.22 um 14:37 schrieb Javier Martinez Canillas:
>> DRM drivers initialize the mode configuration with drmm_mode_config_init()
>> and that function (among other things) initializes mutexes that are later
>> used by modeset helpers.
>>
>> But the helpers should only attempt to grab those locks if the mode config
>> was properly initialized. Otherwise it can lead to kernel oops. An example
>> is when a DRM driver using the component framework does not initialize the
>> drm_mode_config, because its .bind callback was not being executed due one
>> of its expected sub-devices' driver failing to probe.
>>
>> Some drivers check the struct drm_driver.registered field as an indication
>> on whether their .shutdown callback should call helpers to tearn down the
>> mode configuration or not, but most drivers just assume that it is always
>> safe to call helpers such as drm_atomic_helper_shutdown() during shutdown.
>>
>> Let make the DRM core more robust and prevent this to happen, by marking a
>> struct drm_mode_config as initialized during drmm_mode_config_init(). that
>> way helpers can check for it and not attempt to grab uninitialized mutexes.
> 
> I disagree. This patch looks like cargo-cult programming and entirely 
> arbitrary.  The solution here is to fix drivers.  The actual test to 
> perform is to instrument the mutex implementation to detect 
> uninitialized mutexes.
>

While I do agree that drivers should be fixed, IMO we should try to make it
hard for the kernel to crash. We already have checks in other DRM helpers to
avoid accessing uninitialized data, so I don't see why we couldn't do the
same here.

I wrote this patch after fixing a bug in the drm/msm driver [0]. By looking
at how other drivers handled this case, I'm pretty sure that they have the
same problem. A warning is much better than a kernel crash during shutdown.

[0]: https://patchwork.kernel.org/project/dri-devel/patch/20220724111327.1195693-1-javierm@redhat.com/
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

