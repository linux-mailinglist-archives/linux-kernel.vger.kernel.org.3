Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255DC49EA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiA0S3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231827AbiA0S3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643308152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOwmBaoQYc9ipxJsD5Xp8lQm0++NvPyuGzOAK0NnjAs=;
        b=V74EcNmaaPHYsO1/s1k2oeuAZhaCZul6uOzaYN5K4Ajy2leissLK7L01+6mleVIOUvBFXF
        atIEkAT44PFtnVLMWekAT8cVtt754Pv+8TVj5SN2Od9qdProAGxaUdZl7sJf/ctrWES0RJ
        a21aZIzEYkLNfefhDTYeYdrhu8uVCkk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-5F4esgkaMiK3kBuBdLVqVg-1; Thu, 27 Jan 2022 13:29:11 -0500
X-MC-Unique: 5F4esgkaMiK3kBuBdLVqVg-1
Received: by mail-wm1-f71.google.com with SMTP id q71-20020a1ca74a000000b003507f38e330so4519175wme.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VOwmBaoQYc9ipxJsD5Xp8lQm0++NvPyuGzOAK0NnjAs=;
        b=pz+Vt6dr1qgnB65OlEzBTsdp0pAVHeGT9J+lu8Py1vKNQ4j+MetWXF8h2G0TB+sj7Z
         hcA9yYlMtxLdQVFUFKbXIl9aAIqjWCNUqy4x50B8USbDNBEQq6/ffmZzM6mrr1PQKVcv
         UOg8maeevF8yS8Xs+m5yKCZl7EnqGkbZmhJF6klEnV3VcWouRoeE3N4fbfEHcHSVbpol
         1jKEvPy/LgLVtG8DnO10yFmsmmckTnzrUQV9MouybyOPXBb/I5ilYwOXtp3DOf4AFrB5
         9Ctllbf5KnNbCZGiUT5akJqDcDlIoT/lL2CToVATABJ0sQ7KiZIUqhsle/N8qOTmhP1j
         Xtog==
X-Gm-Message-State: AOAM530gn1yYlsQm3CqJCcUJ0l3eoPpRnl9eZCZzxpXnjmeeg3O5bzUK
        hpVhGwuX8692jiYFqyHQlzr/Px/q5YjPr6tuakvsVuUrJlinKXJ1ouBQ8EozF2WigaE+5oO2lKi
        dwTnZC4vGlotMMOJdFGYOnz5M1jr0wYpnd15t4FWLmSXX2LqS3DlMWvq0bt89fMU7N94RB8S50b
        8=
X-Received: by 2002:adf:90ec:: with SMTP id i99mr4246373wri.484.1643308150421;
        Thu, 27 Jan 2022 10:29:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWB8J69usKDani3SgGZH67M+S5JrzOq9AWvBqm+JPvJVzt8o/DJlUEg++S01dqSOe3YsZ/fA==
X-Received: by 2002:adf:90ec:: with SMTP id i99mr4246313wri.484.1643308150088;
        Thu, 27 Jan 2022 10:29:10 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a3sm3391827wri.89.2022.01.27.10.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:29:09 -0800 (PST)
Message-ID: <c5948761-c031-f9a4-2459-37bb5b40fda9@redhat.com>
Date:   Thu, 27 Jan 2022 19:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/37] drm: Make drivers to honour the nomodeset
 parameter
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Inki Dae <inki.dae@samsung.com>, Joel Stanley <joel@jms.id.au>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <sean@poorly.run>,
        Stefan Agner <stefan@agner.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 01:37, Javier Martinez Canillas wrote:
> The nomodeset kernel command line parameter is used to prevent the KMS/DRM
> drivers to be registered/probed. But only a few drivers implement support
> for this and most DRM drivers just ignore it.
> 
> This patch series is a v2 to make DRM drivers to honour nomodeset. It is
> posted as separate patches to make easier for drivers maintainers to ack
> or pick them independently at their own pace.
> 

Pushed the remaining of the drivers patches from this set to drm-misc-next.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

