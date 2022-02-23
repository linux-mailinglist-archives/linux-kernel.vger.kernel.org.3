Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E094C1980
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbiBWRIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiBWRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 349F96949D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645636072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/lDTI0t8i1/9SFZQVCSdA4ArXAFqxYpZ/S4YM79am4=;
        b=a2HcX/Mr+u0yvCBj3OIOE4UjYukz4bhtqDwafnRuLbk8MfSQGnLc0jgnyxDegav8o0GCmh
        1yk0FcOidDYn/UN0srXKrngiOTxmL5l8DtK6vpDERjVm0OrwYTcbxq1jFHt5z8vMCoA25V
        kEZA80J1gybsEJuA+snDqZorlrAJXa4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-KVfexLjHMI-oIyFv_bQb6g-1; Wed, 23 Feb 2022 12:07:51 -0500
X-MC-Unique: KVfexLjHMI-oIyFv_bQb6g-1
Received: by mail-wr1-f69.google.com with SMTP id q12-20020adfbb8c000000b001ea938f79e9so2432346wrg.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y/lDTI0t8i1/9SFZQVCSdA4ArXAFqxYpZ/S4YM79am4=;
        b=VrtqcGz+p9pFLpk83MaAMrSl+eY0QpwOsRjvgzFOsu85t0b1MQgyMckXDLR6CyQq4R
         RpUaEKIEnd+xR1O7GZsG3hbdbMDBLgkh/RrmMS8ZH3A8IQHCOiikuqvKBMSi8im+Gi49
         X3BeFe0C42tp7Yw9B8JHM9hMX7pnU1sRa0Hm/3m1hVfyJgfWxFCwNSOV6iL7R+fgaWor
         SKVnLVCrjVvj9mJPx5nIJKi9r89hPY66Kz8oE6XURgLUpB0gSjieKyvDH6J4d6+LMLPU
         owu9oNGnBf1iw5ikK3D+CKj4fY0Kz2N3zTtnvUnAQapN82t2eLpfXENjsr1oE9aVyqF8
         1YVA==
X-Gm-Message-State: AOAM533d1peVQkCtzzgwzxHZrEFzug5xKKB6cIV+M5KTiplpu0fcH94w
        uYtIakRc3AH7oL1GBIuO4x/vskwXE8DBr0cC/8+UnUGmwezYxP6vZgucrnSSiT1CS2TB8oturpP
        VOklZqqA44FjJVZtC77m1Emi9
X-Received: by 2002:a5d:6d8c:0:b0:1ea:7d52:c05c with SMTP id l12-20020a5d6d8c000000b001ea7d52c05cmr419033wrs.663.1645636069897;
        Wed, 23 Feb 2022 09:07:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKZR4WkrB+FwsLwgzEloqYu3XoJEbjd0+5Z1wDhDJLU+YlKf5ciM8sXEoYOr7Uc1PYibAXgw==
X-Received: by 2002:a5d:6d8c:0:b0:1ea:7d52:c05c with SMTP id l12-20020a5d6d8c000000b001ea7d52c05cmr419005wrs.663.1645636069646;
        Wed, 23 Feb 2022 09:07:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j10sm102001wmq.20.2022.02.23.09.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:07:48 -0800 (PST)
Message-ID: <15d5a0ce-ca58-e670-99e4-a79e07a0fe22@redhat.com>
Date:   Wed, 23 Feb 2022 18:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
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
 <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
In-Reply-To: <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 17:54, Javier Martinez Canillas wrote:
> On 2/23/22 17:45, Michal Suchánek wrote:
> 
> [snip]
> 
>>>>
>>>> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
>>>
>>> I think you meant "VESA modes with the sysfb driver" ? or something like
>>> that since otherwise it seems that you meant to use it with the simplefb
>>> (drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
>>> "vga=" param as far as I understand (it just uses whatever was setup).
>>
>> And the vga= is whatever was set up by the realmode code. And the config
>> option for realmode code to do that is selected by vesafb and not
>> simplefb so it does not wotk for simplefb/simpledrm/whatewer when efifib
>> is not built into the kernel.
>>
> 
> Yes, that's what I tried to say. But your commit message says "To enable
> use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
> accurate AFAIU (unless you meant sysfb instead).

In fact, probably the subject line should also be something like following:

firmware: sysfb: Enable boot time VESA graphic mode selection

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

