Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8131497E49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiAXLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232727AbiAXLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643025025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnozPUrejpB8IY9KHbWAe0uFCpl2C3OVRF4UKq2Q7OA=;
        b=JVTEjfW/LMZ7ET7+DToX28Y9KUrB0pHMR2Si9QwtKiOtVZXKU8dQ4/Tu1SU3qwnaK568rf
        2cjMT1E1bxNKwxaoTyqLhdI5dbYh+qTntTW912HUVojVZvnd0e3pc7IXRWpUTm+ZUpt/2v
        Fn0bty+/AahGfeTKUHr+RUlnYsVFNZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-x7h2y1_WMWuJmnQqXXIWPw-1; Mon, 24 Jan 2022 06:50:24 -0500
X-MC-Unique: x7h2y1_WMWuJmnQqXXIWPw-1
Received: by mail-wr1-f70.google.com with SMTP id a6-20020adfbc46000000b001d7370ace6eso1770367wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SnozPUrejpB8IY9KHbWAe0uFCpl2C3OVRF4UKq2Q7OA=;
        b=jHi6VadODXiQgeEp+UrnQpsseLDOAqNfKB02ppPht1oYOu7ew2N8gue4kO+A/KEhzu
         uJhGphkd8WRYfP5OYW0Pz9hYxu/xVDU0y/9CojyZ2ekJCSF4SkQbDGldRgsGfc4sAczP
         zGMu+h5NEpOqflZbXBEMk9Mh9K5EOxmdbguhe/nzjLWQitJpgxLCgGzifLnBJLVatgjS
         dqSYy3R+QzbhPpe95Mfu4u+vmddQUkUvltnH3QONy+FZ0+xcyYQTsm33yg3UTmMn1okb
         Bnq/zMTVOVFsFRc3mC55k5zmoo08erWgG82K8x7rDZqLZyb4DpmLXfammgd6ACMerom1
         dmWg==
X-Gm-Message-State: AOAM530OhUwJBv3kjbZ6h6C59XghrggUsrb7JYl+f7GJyTgeuFBL9BiG
        E6Knbb23IHDtZP3U3vOcqyIZYDhxdtY5nZb1BZZ7t5VJ9UEw/2iXXD5OU9zUjzQ440e8w37Crna
        xULhG3knNzChrORm6PEtry57o
X-Received: by 2002:a5d:588d:: with SMTP id n13mr14154334wrf.153.1643025022929;
        Mon, 24 Jan 2022 03:50:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc+T8f2EA0pQatiSUAYWsweg14f3Fap55QqOPYFQTgJZjANOOALIERHOvplEdlRysuwhZ5oQ==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr14154313wrf.153.1643025022753;
        Mon, 24 Jan 2022 03:50:22 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o12sm6904445wry.115.2022.01.24.03.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:50:22 -0800 (PST)
Message-ID: <2fc200bb-4b40-7833-31c9-90a78512b601@redhat.com>
Date:   Mon, 24 Jan 2022 12:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220119110839.33187-1-deller@gmx.de>
 <20220119110839.33187-3-deller@gmx.de> <YelyGDNDTn1Aq/hm@phenom.ffwll.local>
 <6c000477-002b-d125-b945-2c4831bad8a5@gmx.de>
 <20220121072006.ylw2hdl7jbkbwnre@sirius.home.kraxel.org>
 <64fd46cb-9746-3fd0-ec92-c64dba76875a@gmx.de>
 <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <d23800b4-503c-a6e2-2c51-2c07a736dffc@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 12:33, Thomas Zimmermann wrote:

[snip]

>> Thoughts?
> 
> I can't say I approve keeping fbdev alive, but...
> 
> With fbdev emulation, every DRM driver is an fbdev driver too. So 
> CONFIG_FB_DRIVER is somewhat misleading. Better add an option like 
> CONFIG_FBCON_HW_SCROLLING and have it selected by the fbdev drivers that 
> absolutely need HW acceleration. That option would then protect the rsp 
> code.
>

Agreed that this option would be better and allow distros
to disable the code that was reverted.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

