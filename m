Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A24A6CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiBBI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244908AbiBBI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643790571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0bztKGpIcohzL9Sc0p+LBRUNxZykmedDS+Nu+iWafY=;
        b=jP3FogmUpSQMnIc6qVTwgcY24oY0sPwkWTyVBBlp0tOfuO3iA/WzHUzaOolZWeby4SgYkj
        Ez4/ND3mxocMHMyu2Bn5MopW+LzXO9ndUHqYZX0fgI9AnKoK13DcHQl1UJj1OtnNlUrg/b
        MSfcchOM9iypwh+AdVKzLhc6dBwDrDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-kWGLCcueMmWaO8DBKQ1waA-1; Wed, 02 Feb 2022 03:29:30 -0500
X-MC-Unique: kWGLCcueMmWaO8DBKQ1waA-1
Received: by mail-wm1-f72.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so3422736wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W0bztKGpIcohzL9Sc0p+LBRUNxZykmedDS+Nu+iWafY=;
        b=1SO7k24gG50jH718mQjCjQqiyNZEoeKmYlqeeXXd6X5HwgdeC8hOqbWnR+cZfLTnX7
         r1ICM1RSlIa9L2J2EkynWCi+JjcgN13mGLK9zpD2ByTRXRXKfxCrgYaC3V/qzpFBvwRY
         CcAhC5ttc4Nb26viytVByf9MNHv5Wq7CU9Ma3XBsqgI0OtxwWXlT/z5okTF1yEaFcap5
         UaKHaWmTmAZev31WbuyjVOgZt1yvz01oNNZ7BjtZvS8H4w3k/dkcLAy3SXesRNcoSyL5
         cusxbZdzZPoB8eFavSzoejt3UE6nFbYTtSzmnbqzZyxyTndFgUui0zA3eRyk8pScVB5y
         x8NA==
X-Gm-Message-State: AOAM531f9n7WsxxZvaGMdbfGoqJcHt9X1QrN0t3fkDXNikZREM1ujTtR
        pyao3ECX0SehKbmCYMrcA5Iz1nYjX/yEeLz9ykEcAar6FXE9lu3gFqTfviVWL2tsARoeniZg0GH
        jG2kNWoG6lwUFNsi67OCTu2jE
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr14123802wrw.483.1643790569358;
        Wed, 02 Feb 2022 00:29:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyZ+ZXpYCgyI5AjaHIrkAs/aXj0KAcVKPE7/o7d9nr5TSaq8+Wpfx9p5zSxXVdSNWJTBqZEw==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr14123791wrw.483.1643790569132;
        Wed, 02 Feb 2022 00:29:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13sm4185614wms.8.2022.02.02.00.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:29:28 -0800 (PST)
Message-ID: <042a42a9-0446-1b29-beae-493882cc18ca@redhat.com>
Date:   Wed, 2 Feb 2022 09:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <cc093cd5-fba1-5d84-5894-81a6e1d039ff@suse.de>
 <73dbc5c7-b9e2-a260-49a6-0b96f342391e@redhat.com>
 <CAMuHMdUJpoG=XChpqNotfEDrWCxFUqyhjW2JW1ckAyKcWXvAUw@mail.gmail.com>
 <3df2add7-6034-0527-825a-74e62e76dace@redhat.com>
 <946f8fbb-cd64-12d0-ecd9-13af18a00590@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <946f8fbb-cd64-12d0-ecd9-13af18a00590@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 2/2/22 09:23, Thomas Zimmermann wrote:

[snip]

> 
> Thanks to both of you. I was asking because I found the code to be 
> repetitive and it's not clear that these 3 statements belong together.
> 
> I'd like to suggest to add a function
> 
>    ssd1307_write_cmds(client, len, const u8 *cmds)
> 
> that loops through cmds and sends the values one by one. A call would 
> look like this:
> 
>    const u8 set_col_range[] = {
>      SSD1307_SET_COL_RANGE,
>      col_start,
>      col_end
>    };
> 
>    ssd1307_write_cmds(client, ARRAY_SIZE(set_col_range), set_col_range);
> 
> AND/OR
> 
> You could have functions that take a command with arguments; either as 
> va_args or with one function per number of arguments. Or you could 
> combine all these somehow.
>

Thanks for the suggestion, that a makes sense to me. I'll look into
it when working on v2. Probably during the weekend.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

