Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14094A705F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiBBLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237857AbiBBLyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643802876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bL5rgnJNtTCmd2esmcO6OG/N+9v3ttozfnd4SZakfGQ=;
        b=hcaa9dCAp+0ejVhy5Si3NvBgyZAOq3Yq7JwkNYlaEUnEcJ0B0cFGKL+0X+qKFT0jMmqYr/
        9CRRXeSTTiIWCQp2RDx8U65N6TLrQgm712aZ7hzzEQNhRIZAhI1nFbG8ZRq0mxmyWq9i2/
        NR1gv90BlL150MxQnr9KRJaf2kUnWoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-zc_09NvbOqWAUpmCaY-GIw-1; Wed, 02 Feb 2022 06:54:35 -0500
X-MC-Unique: zc_09NvbOqWAUpmCaY-GIw-1
Received: by mail-wr1-f72.google.com with SMTP id r27-20020adfb1db000000b001d7567e33baso6738453wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bL5rgnJNtTCmd2esmcO6OG/N+9v3ttozfnd4SZakfGQ=;
        b=6DoLGnOBkDUEGSyS0R2jSqvrQxHQZDDDAWnZdy5qHY9NqXfECSqyBVA6Y1GpQcf3JE
         v3iIIeMGnyeIH8vHNdZxdKENlWY2YLfVgwdNqycVAePJZTHQ9VUfoFT0J8kYjpzUECd4
         TjMFxnd8e1zz7s18MzSwEmtuiaDMfcYc2KGeUtGi0FIKA40LQtXlM5PurSqgCqjnLYGA
         oMOZ7YL8NgExc3CAdpuZYrvaeJKCxCS9BDJve5Ds9b/uyN/hkH/w09lpOR2E/guAA9bL
         VxKJGgemfjJLeb9tMn4Jss9xYa+63x7gTYm/URT8yfV5/9YTtwVnhng6+DdNyBEHCvl3
         ptFQ==
X-Gm-Message-State: AOAM531BjEtp8Ynvkg1wKZ5Ed1NMYZYMMYaA6AcBvge3PzLSMUQFaJwx
        C8jZpMhftb38oKKeeKltTih95EZjg4dIyt7NWwlYWC/eNrQTXX9a1qP3XKAFpyzaqRNhBFXaNlX
        tv7lLx9SSpUVW1fOYjZXs3h73
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr1969721wry.191.1643802874129;
        Wed, 02 Feb 2022 03:54:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9uaj1noGIyEUrpXHbn9QwweYL02b/7HPtTFauTRqXOp7zTH9jXowWwcKexaK5dPFtRxWRqw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr1969689wry.191.1643802873900;
        Wed, 02 Feb 2022 03:54:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j5sm1444854wrq.31.2022.02.02.03.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 03:54:33 -0800 (PST)
Message-ID: <a3a06362-ab9f-e29b-4f03-968e3f1865ba@redhat.com>
Date:   Wed, 2 Feb 2022 12:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
References: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
 <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
 <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 12:50, Andy Shevchenko wrote:

[snip]

>> What's your suggestion then to solve the issue mentioned above ? With my distro
>> maintainer hat I don't care that much, since the fbdev drivers will be disabled.
> 
> I think both of them can work together. If user doesn't care, the first one wins.
> 

I don't think this is a good idea but as mentioned I don't really care that much
since we will disable all fbdev drivers anyway. So I'm happy to allow them both.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

