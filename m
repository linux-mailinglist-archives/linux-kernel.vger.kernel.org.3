Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000124A9B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359338AbiBDOdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359328AbiBDOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643985213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YE+7dcKVrnsXlJFwi4qc611YF3e/nMZjJd0WuHXGT7w=;
        b=DQxhyBGsZrIDFqF5CisQw36xF7ZViW78rfpUJHMQ4Z/lePoteFg8E1BYyHrPI+s/BSCZYx
        Qr8zFmKYyfS2+TcDTBeGAMfp7yG+kd7cKKQIYTh9zmiNJfLk6AejdYMlSfiQhavCo1SMgy
        oJH/DKyl5zr2j8KKnv9VKk6kVc64ZEk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-SOmmRtwcPRWaulvj-1HaiQ-1; Fri, 04 Feb 2022 09:33:32 -0500
X-MC-Unique: SOmmRtwcPRWaulvj-1HaiQ-1
Received: by mail-wr1-f69.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso2084914wra.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YE+7dcKVrnsXlJFwi4qc611YF3e/nMZjJd0WuHXGT7w=;
        b=2nvwH6owQbgMcWlyEWFEGFwqN2gKJ2/ayOvtapaeXZxP9LWFrUnB3dcqY2FhUzllpr
         0bL34ke3wFk8qLcsWOLVt2t7EbAkkiQmlE5xyGrGWVNsxpzwxwaSaCH7b+DnWgy3jIri
         gTxUa6d0xTmuQu5y/KuQ+LP+GrQlA610ieoCdDmcJ2wApHMpQ7KM/cHzAj/d5Enj6uxI
         sIgA0/pUUc60QixMzCmrbBn/YYaVqpZbkRA6NrLrqKOaWWoHN74z7zLWR0rhzJ2j1wBT
         3zyadHnC6YgaXCLUbZpqYSCdGAegTSW5hGEqQyyr7r9+syGGJ9wOgToDwSilJuu6+Pef
         q2+g==
X-Gm-Message-State: AOAM533fVa7UsrBt497eny7ab69Ku9vI+M2PHGYxeJsbQZU7MabYo9aZ
        9IBs1X4gfuR9vcObkKbzX7JvfiCqFQcua+KjK/7X6k/XYo/dF2SzmV4Iu61X1bHSeQqsPjqbQ9U
        7qyycfSDlOJwf8JWhrCEZfX3j
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr2506719wmf.42.1643985211601;
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8Sf3LjiYWLzwA9+5siU+yJFBE/sxFNsjVMYQtNMWsluGofgOGAh6oxxtKiSCC9coLkWjFOA==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr2506694wmf.42.1643985211382;
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a9sm1992289wmm.32.2022.02.04.06.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
Message-ID: <f7a5d15f-3a02-5698-01f9-e79970180d99@redhat.com>
Date:   Fri, 4 Feb 2022 15:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED
 displays DRM driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-4-javierm@redhat.com>
 <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
 <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
 <Yf03+MsbqRp+uQff@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yf03+MsbqRp+uQff@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 15:28, Andy Shevchenko wrote:
> On Fri, Feb 04, 2022 at 03:12:17PM +0100, Javier Martinez Canillas wrote:
>> On 2/4/22 14:57, Andy Shevchenko wrote:
>>> On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> Stray change?
>>
>> Sigh, I'm not sure how added that change. Just ignore it, I'll fix it
>> on v3 or when applying if there isn't another revision of this series.
> 
> I believe v3 is warranted due to the other patch review.
> 

Agreed. Thanks a lot for your feedback and comments.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

