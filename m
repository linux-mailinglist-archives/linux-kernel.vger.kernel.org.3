Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566EA4A9AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359238AbiBDOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359229AbiBDOMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643983941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KItnbBDoQWGxAStE9x/Omo/R1q/taazm8Gbl7PqYOjc=;
        b=Iu+McOYBk1NKxVrMiAES6qF0s6asngAZKoj9ef/3UuDd3UJPnaTIt+mBgNoj3LCip8vdez
        JQSql+ucyWioZWW/QMBh7ziitMNpyJ9zuJHyzYsaA6S2OQCymBs7MEVjyUUoCLBnClyOGD
        4EFiIPUNLxG8sXXHmE6DgjrAdGIYOAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-0Aiy9KUBOq-xAmDLar4lRA-1; Fri, 04 Feb 2022 09:12:20 -0500
X-MC-Unique: 0Aiy9KUBOq-xAmDLar4lRA-1
Received: by mail-wm1-f69.google.com with SMTP id r66-20020a1c4445000000b00355272f7d08so640956wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KItnbBDoQWGxAStE9x/Omo/R1q/taazm8Gbl7PqYOjc=;
        b=4IBxB/QjzycySg674epLVRxuOihUWFnw7OTUWuoCUeOPRDUFyOE2powVZb3bG567sY
         fL9k6wHDOlwJ2blcG2s+G7KqbUvKMoP9CKrG5qCsR4eYmLyIOaj1eJF4tLjNvqpcLNjU
         vWNZLZNB6ncMQmPaEMhAiVwR36l2oUi01hYLve+OEaZIoerMUr+mIbvl/UGca2JZA9wg
         Lmg3p8P5AjUV9RlFHCyU4NtGD+9EBF8lcy9Gwc7Za00EP58eyVYk41+9bHPOzeLN0BuS
         94WV3Tqu9I7ByosxV1E9I4ZoJXtFoRKJNqDIMJ3SHVFxFbn4Wxt9dgn/bnIYBEjzwqMh
         mLww==
X-Gm-Message-State: AOAM533HC/jc91UJy+AdR8soAcSbXWfUsrToZSwmYWLrIK8RoZhUxud5
        AKVptN3eYvSvqhUDNTxRr1kCEDvKN8j7WlKPKwIsXHxhwKx6wfvFE1n2n6BJmfjYuOsmOp6D5nJ
        Lj42uoNw8hjzTQTBmG6iU+vEe
X-Received: by 2002:a05:600c:1d8b:: with SMTP id p11mr2385834wms.115.1643983939111;
        Fri, 04 Feb 2022 06:12:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztIKbYGGYYsqOYvoXlouVCeffwnsLMQlwE5LqaJBGhLKzE5ulVDx77gLhM4YlpnNr0MzeTyg==
X-Received: by 2002:a05:600c:1d8b:: with SMTP id p11mr2385818wms.115.1643983938849;
        Fri, 04 Feb 2022 06:12:18 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m12sm2480308wrp.61.2022.02.04.06.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:12:18 -0800 (PST)
Message-ID: <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
Date:   Fri, 4 Feb 2022 15:12:17 +0100
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On 2/4/22 14:57, Andy Shevchenko wrote:
> On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> ...
> 
>>  drivers/gpu/drm/drm_format_helper.c | 2 +-
> 
> Nothing about this in the commit message...
> 
> Stray change?
> 

Sigh, I'm not sure how added that change. Just ignore it, I'll fix it
on v3 or when applying if there isn't another revision of this series.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

