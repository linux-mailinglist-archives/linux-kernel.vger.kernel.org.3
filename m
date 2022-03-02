Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3540C4CAF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiCBTsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiCBTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E0D3A718
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646250469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ndR+qkKf8IiCmXwP6/0TLhJyNK+iAc9DAT0Oa/pgpY=;
        b=bEQu/eDpX2c1362jIYKSMea7mUpwv4MazescCBcIAqXlJacy8FV8okttZfNbEle8fO/zKd
        +9oBTyudOcFqQtKznL8qGWJSt8JwvuUqaUCoaZl4QqM4A7x3KhzLxW5seam0eFqFZZePZX
        tsC5nLZSrIoCl5Y5atg+2VwrBXQYFHY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-WbOJVkcBMIi9ejUU8YJ7zg-1; Wed, 02 Mar 2022 14:47:44 -0500
X-MC-Unique: WbOJVkcBMIi9ejUU8YJ7zg-1
Received: by mail-wm1-f71.google.com with SMTP id p35-20020a05600c1da300b0038151176781so1219751wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ndR+qkKf8IiCmXwP6/0TLhJyNK+iAc9DAT0Oa/pgpY=;
        b=R+J5HZfeib0gUhbHYvg5Lx9Zf8BdAbrV1HFFmxUZ2KGzfetmBvRcwRoAouri9mlNSp
         7SI0Y2cabn4NjH2WwHpOTEPXsLUKurJKBvSMGJWzUuRzaywVrk1twWUbPZMYMg4skfHs
         5kI9oeU4CCyBh5wNVTV7cSe/wTyvvmDevuWBprv9pYPlwhFsvlTt8uE4Ni95FUQT0hyI
         kYteciqMJgx8qqAkjatooHDe60Xz6zr+oOz+HqYnlnO4YlfyvxUvtMv/ryQ4eSRKh5wf
         n8xBOlWhtPUZZk/xPFndEmZmk8jDzGlKT6eAC0CilHwcDvLTAU2zCQodRjILexWWKj09
         pvAw==
X-Gm-Message-State: AOAM531X/sJ78Sli6HWt/YiOOrrsyMl88k+5QRHi970oITQnscoRTmDQ
        yGhckpPMXrUYE/KWise9HA5zx+iA1Cpk5+Cz9u+P7fGLH7Fw5RWp5j2NvZk0klGMzRSjoZ0UkW/
        zrQHbWFeJuPHk36xW0mkWGMhe
X-Received: by 2002:adf:a749:0:b0:1ef:7d81:f4cd with SMTP id e9-20020adfa749000000b001ef7d81f4cdmr17935829wrd.133.1646250463116;
        Wed, 02 Mar 2022 11:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytQkVIbt3RjmxG7srv9p6KdE7ADQdJ/WVQfRQmhaoGILBPTLLpENUyF/E4HqcmI+2MYZN+gw==
X-Received: by 2002:adf:a749:0:b0:1ef:7d81:f4cd with SMTP id e9-20020adfa749000000b001ef7d81f4cdmr17935812wrd.133.1646250462893;
        Wed, 02 Mar 2022 11:47:42 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm8935824wmp.44.2022.03.02.11.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:47:42 -0800 (PST)
Message-ID: <2ba8497f-ba6d-558b-d782-bb3ee67d23ec@redhat.com>
Date:   Wed, 2 Mar 2022 20:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-video@atrey.karlin.mff.cuni.cz,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Maxime Ripard <maxime@cerno.tech>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Mack <daniel@zonque.org>
References: <20220218093334.24830-1-msuchanek@suse.de>
 <354f3cfd-bfa0-3ebe-3d67-705423d9294e@suse.de>
 <20220302193846.GT3113@kunlun.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220302193846.GT3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 3/2/22 20:38, Michal Suchánek wrote:
> Hello,
> 
> On Wed, Mar 02, 2022 at 08:31:25PM +0100, Thomas Zimmermann wrote:
>> Hi,
>>
>> is this ready to be merged?
> 
> The objections raised so far have been addressed in v4.
>
> I think this is good to merge.
>

The v4 patches looks good to me and have provided my Reviewed-by to all of them.
 
> Thanks
> 
> Michal
> 
>>
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

