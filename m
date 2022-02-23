Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA784C191C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiBWQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbiBWQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D62522528
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645635299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGsFxlL4JeFa1QdhcUJScvi/ilLeoFbRM78k1G2b9hU=;
        b=Tl1J67Jeoh2rJl6U0NNdA9vnV/A4XRdzrKJNx9hLLlIAz6ri0ZsyDGfzBbgwuuaWYNaRso
        B4x9wgRfbJpfKf45gIMZ72wSExzLJcJEe45iJdloLsKezWYDu7PHVgjUFSYmuChyogVGRr
        biImOL2eyRnNSj3ZXm2UYusa1brmJWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-ZOdIgtb1Pbe3i77SU-WHzw-1; Wed, 23 Feb 2022 11:54:57 -0500
X-MC-Unique: ZOdIgtb1Pbe3i77SU-WHzw-1
Received: by mail-wm1-f70.google.com with SMTP id q17-20020a1ca711000000b0037be98d03a1so1377690wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VGsFxlL4JeFa1QdhcUJScvi/ilLeoFbRM78k1G2b9hU=;
        b=PppRMao7JejgqO8hu/7cfiHUZnJShzgVEq3NRIK4eh7qw3RdG2+3vvZIDe5HH1bKjb
         AqRzsn7/ZJBJFX/egenDTwr8mT+kfodwjV1Pr+pyG9YXebqUCy1wL4L6OFwiB81lRFcx
         dNvio/TQuvxVkEyYJzQ8Ig/72ya4GTzCu0eReuQ/9Z3JbS/70mPvvR/ZhuTAUN6Ou6+3
         Sph5WQUt3A6YlDlnusixuIUwOJkOcFi4zOaLTuOjXHNw6ZxXrnkCaiT2nWO59Kxlzo8C
         +3dcqpfSulKOyGttZRM1gpXGpKFLyPBwuydUgwrGexG/irqGo+PpzJVNz9g6np9l7ive
         fSOA==
X-Gm-Message-State: AOAM530LG7Vw9gNvJjSRouFUr9kEeus0XKiOTDIARMDGP9G12K3tGlbA
        0y+C7cNq5lRDKFIBXWWRGJ2HQfG4qLjl1eKSopHSu7AiegqqqIZjXCsPNj+XH7sS6R+FNJDYEKn
        IT59goKEF6SFtVhTBCBVfdYUN
X-Received: by 2002:a05:6000:11c9:b0:1ed:b92d:8c68 with SMTP id i9-20020a05600011c900b001edb92d8c68mr387257wrx.692.1645635296722;
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh2m/1l5+uIPpemZfPkQyC83sbpmuOCBmgtWvmNNgg8mQBYxAIW77Ao8GytoqMFEHFUp6k6Q==
X-Received: by 2002:a05:6000:11c9:b0:1ed:b92d:8c68 with SMTP id i9-20020a05600011c900b001edb92d8c68mr387231wrx.692.1645635296423;
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2sm79430wmq.6.2022.02.23.08.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
Message-ID: <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
Date:   Wed, 23 Feb 2022 17:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
 <20220223164528.GE3113@kunlun.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223164528.GE3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 17:45, Michal Suchánek wrote:

[snip]

>>>
>>> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
>>
>> I think you meant "VESA modes with the sysfb driver" ? or something like
>> that since otherwise it seems that you meant to use it with the simplefb
>> (drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
>> "vga=" param as far as I understand (it just uses whatever was setup).
> 
> And the vga= is whatever was set up by the realmode code. And the config
> option for realmode code to do that is selected by vesafb and not
> simplefb so it does not wotk for simplefb/simpledrm/whatewer when efifib
> is not built into the kernel.
>

Yes, that's what I tried to say. But your commit message says "To enable
use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
accurate AFAIU (unless you meant sysfb instead).
 Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

