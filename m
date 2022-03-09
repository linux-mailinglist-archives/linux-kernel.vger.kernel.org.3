Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451524D302F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiCINop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCINoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDB71123BCD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646833404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNwPCyT8wmbEfZK8P/i6Q32UvGlt9pDVFx+4Sf2sAjk=;
        b=SH+j8ZaidiY3ujgsXtr1hUOwLlbG1ilNMfkWt2oplXs8A4tnxU70cGauNWR9id/n+CY/AM
        0SVweOq2iaCKG8MQxkBL0yXO3fMG9U0Rd2jtt62ZRUcwMZcJRmpCwT3a1LXgGS/KxZhP7t
        01x2wptcVEhYji33bs04m+ZrtsCJ1OA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-pfiraGKHMNSZcIOcPVbF_Q-1; Wed, 09 Mar 2022 08:43:23 -0500
X-MC-Unique: pfiraGKHMNSZcIOcPVbF_Q-1
Received: by mail-wm1-f71.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso809173wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DNwPCyT8wmbEfZK8P/i6Q32UvGlt9pDVFx+4Sf2sAjk=;
        b=iv2QATaOzx238xW7qSmIsV7tb33qKGAsLLozcdnDK6Av3o9en9xHk3i2RlcmPBNp9a
         cg6CKgkqM8zhdG/+Fac5iPt7i8mgQgMBhOCBGQr0a+Ln+7+dSkvwwowoTwIVFpdioBuh
         SLJqVQQG6TLYPjterACzLpw8Ui1pX1HpdXtRp1qAb4LpPod2VSpRJi73ADT7dwWS2SZh
         zyH4lu7PPyy97wuQao9jvjL3i49mD98N5piQkyDgCVNue4Bx+Q6bHKhUw8WBW7hiHOGV
         olwApzS+q72GXkh2t1i0qa05Agt8RTgDZV/Ihm2BhuiJ023AXa6OZ/DhHykP/3aFgJxQ
         0jhg==
X-Gm-Message-State: AOAM531wmhgj0qqqmKVORnT6Abh+iDlgfCHeRMHV/fb/hguzKYVk0Uu6
        fXqQ9Gn8pnpk9EMY1CRDxZQZeSH5iSFy3RSRtj2Yhiq7Gc71wbu7nkbe/SyGFK2Ufg4Q4WLTQMn
        mrqiA2Fh+TWWWYHKN06Z3S0t5
X-Received: by 2002:a7b:c8c2:0:b0:389:9746:847c with SMTP id f2-20020a7bc8c2000000b003899746847cmr7696226wml.156.1646833402442;
        Wed, 09 Mar 2022 05:43:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSJ8Ywl1f4YowLEemqy29qqclDeVGuf5169bKODTz+Q+zNq8dX3nn3Xb5FN4RwNdJP8Nhbdw==
X-Received: by 2002:a7b:c8c2:0:b0:389:9746:847c with SMTP id f2-20020a7bc8c2000000b003899746847cmr7696194wml.156.1646833402233;
        Wed, 09 Mar 2022 05:43:22 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020adf9d8b000000b001f063deef80sm1653234wre.86.2022.03.09.05.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:43:19 -0800 (PST)
Message-ID: <bbb4f088-e6f8-52b6-c673-6e30583cbe57@redhat.com>
Date:   Wed, 9 Mar 2022 14:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-4-javierm@redhat.com>
 <CAMuHMdU+29x4ZHLAiPiReyLKw_VYBCCLw0bCoQmw9s6sQ4Bxcw@mail.gmail.com>
 <fd6ec463-f46d-0813-5d87-a00c07739e01@redhat.com>
 <CAMuHMdUVWKee+Wm=EP49=5TAgqodPsMjkC2MHUfnyBDF_zt_Zg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdUVWKee+Wm=EP49=5TAgqodPsMjkC2MHUfnyBDF_zt_Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 3/9/22 13:56, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Wed, Mar 9, 2022 at 1:14 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> On 3/8/22 17:30, Geert Uytterhoeven wrote:
>>> Unfortunately a regression was introduced since your v3: printed
>>> text is mirrored upside-down. I.e. "E" is rendered correctly, but "L"
>>> turns into "Γ" (Greek Gamma).
>>> I suspect something went wrong with the display initialization
>>> sequence.
>>>
>>
>> Could you please try Chen-Yu's fix for the COM scan direction mask ?
>>
>> https://lists.freedesktop.org/archives/dri-devel/2022-March/345915.html
>>
>> I made a mistake when converting to use the GENMASK() and FIELD_PREP()
>> macros in v4 as suggested by Andy. The SSD130X_SET_COM_SCAN_DIR_MASK
>> wasn't correct which would explain the output to be vertically flipped.
> 
> Thanks, confirmed fixed.
> 

Great, thanks a lot for testing and the confirmation!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

