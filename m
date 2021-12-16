Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A94766D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhLPAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhLPAOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639613642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7W3D6aipQ7MmiTWUNGcz4ziDpKJUEwSYTscXbSv+wq0=;
        b=DD04rvZe7U3wHykwQqa2P8NWhzX5WajhVcarMhDlLh8QiJigwc5RKGiwZEljSBYdzEmBfh
        JhexM94FQEXPIiRzJwfdL3bWGCB8QBbZiFapPNzHwJvAsny9M4Cqp1BtgZ1gdBO5sbqdMY
        cZsdr/WAZh/SRhE9hS360UjRa8pazs0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-WdL31S9PMXKGSqjS1pdOGw-1; Wed, 15 Dec 2021 19:14:01 -0500
X-MC-Unique: WdL31S9PMXKGSqjS1pdOGw-1
Received: by mail-wm1-f69.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so396851wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7W3D6aipQ7MmiTWUNGcz4ziDpKJUEwSYTscXbSv+wq0=;
        b=Q7g0gSf7eUEklupebYwSaCDD7SzREad8mBN+L8wUPkJnGNu/kU0Prhi7zgMTHMZ2cl
         aAsSIDNaiVaHBQneUUVcDt5Ch7axaox13iZAI0akVQVhLza7IqO4vthwQ+1S41emLMEW
         jLcpO/gsxRd2xXPK+HPfOTIdrPagjSTAwDvUak58xsW4KGK8WepO9NgR2meChgrfgzzK
         MpaYjLVTQ6gBRWAK4PV2s8bQ/XUcCRX0xRD3SfFgNzfQY+DcqBxAJSKuG9iLH98KFV6F
         XrKwcrEg5ctUFAhVSEU6D9a6kMt+GuSt8KbjELfyUoT7l478cKOyXKx+J8LWEIhcintq
         cQug==
X-Gm-Message-State: AOAM532UyQflVLTbuSrB0OEa70louy7WRGHHQuCacLFeI7UGDm1aUgj7
        1LvTC3NAfxho0TncVIkl1NeDzmL9bqljkUIBMqIbfkxVjYDwAm1rQ6eHqyHA9vwMwm6fq2fmXSC
        iUCJZ4b5IoSNkCJ4x3l5PLKFJ
X-Received: by 2002:a5d:6988:: with SMTP id g8mr1098800wru.280.1639613640361;
        Wed, 15 Dec 2021 16:14:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtFiQlo1OWJszH9sLjS9VrT9U/5Ah9t5B3NSP9Pp5WGOewg/23R8Cbq/5aTDTBp3WEMBppdA==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr1098754wru.280.1639613640157;
        Wed, 15 Dec 2021 16:14:00 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b10sm3464915wrg.19.2021.12.15.16.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 16:13:59 -0800 (PST)
Message-ID: <91c6b455-62cd-cec7-8445-e93c99230a03@redhat.com>
Date:   Thu, 16 Dec 2021 01:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/60] drm: Make all drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Lechner <david@lechnology.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Emma Anholt <emma@anholt.net>,
        Erico Nunes <nunes.erico@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <Ybp7qDs1p3x5GzNJ@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Ybp7qDs1p3x5GzNJ@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On 12/16/21 00:35, Laurent Pinchart wrote:

[snip]

>>
>> I've built tested with 'make allmodconfig && make M=drivers/gpu/drm/', but
>> only booted in a few devices with and without nomodeset in the cmdline. So
>> testing and reviewing for all the drivers would be highly appreciated.
> 
> The fact that the series is so big makes me think it would be better to
> handle this in the DRM core. Is there any way we could do so ? Otherwise
> we'll chase this issue forever in new drivers, and will be plagued with
> cargo cult problems.
> 

Yes, what Thomas suggested is to add a set of drm_module_{pci,platform}_driver()
macros in include/drm/drm_drv.h, that will just check whether the driver should
be registered or not and call the {pci,platform}_register_driver() functions.

That way the change in the drivers would just be something like the following:

-module_platform_driver(malidp_platform_driver);
+drm_module_platform_driver(malidp_platform_driver);

There are some drivers that still need a custom module init functions for various
reasons (e.g: register a set of devices/drivers, need to be a late init call, etc)
but at least for most drivers this should be handled transparently as long as they
use these drm_*_register_driver() macros.

So just ignore this series and I'll post a v2 soon.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

