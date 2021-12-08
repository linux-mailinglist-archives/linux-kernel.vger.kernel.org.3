Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3D46DA5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhLHRx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:53:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58052 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhLHRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:53:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D30FEB82211
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91765C341D2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638985790;
        bh=AGydzqEFWVHgqNEZ+C88aMeHTaF6GU2hGPjbdQmpbzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qto/lwUN/THC7My6nqaLTvNaqrlsqYKGKvvI6XZZ0zmjxrLcTTn28gxdydxMiuV+O
         /+3+2OZox5HHn2y4sZHJqsRFP+QoSqujZMgSNXlZyOGEt+OwfRLifahBAF05lg93/W
         pC81H7go2tx1Nxwujo0TtTImlGQzQinKfndmgwa0sKcqF5ehdal1igURriTpmns3y7
         JG+FDDhtkekngV+PH0SQZ2+AN7Lk/d0eBaCIfoAq4BXLKEm0Q4GHwJUrkaRWWQDMKX
         33CtuROckXU2lLtFglw9FgoYo7erPaYX4CJBOFhVBkz28cgiMmN6JLz5oURsIrFcAN
         +MFVoDR9/9a9g==
Received: by mail-ed1-f53.google.com with SMTP id x15so11167245edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:49:50 -0800 (PST)
X-Gm-Message-State: AOAM532O4auHe8aDDQL0geVCTta5gLiAMm81n9/qSRrVp17NdSAuggUA
        tsAqndpj+Mlk3eIsfZ0FBCBie6y291Jx0/SQCw==
X-Google-Smtp-Source: ABdhPJx1e0Ud4kjI07LFQQXJazxoN7MV+mUWa0KW1RZJUKKGvwAO1S9SN6vkvBvz/qeVUpYnazWDheggEV6oN3oFbrE=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr20989688edx.306.1638985788722;
 Wed, 08 Dec 2021 09:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20211207072943.121961-1-marcan@marcan.st> <20211207072943.121961-2-marcan@marcan.st>
In-Reply-To: <20211207072943.121961-2-marcan@marcan.st>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Dec 2021 11:49:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+G4mv9Xuy1B--TvJNcNv0z3pRZAQPkA-T+aF8rZMrjkA@mail.gmail.com>
Message-ID: <CAL_Jsq+G4mv9Xuy1B--TvJNcNv0z3pRZAQPkA-T+aF8rZMrjkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 1:31 AM Hector Martin <marcan@marcan.st> wrote:
>
> This code is required for both simplefb and simpledrm, so let's move it
> into the OF core instead of having it as an ad-hoc initcall in the
> drivers.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/of/platform.c          |  5 +++++
>  drivers/video/fbdev/simplefb.c | 21 +--------------------
>  2 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b3faf89744aa..e097f40b03c0 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -540,6 +540,11 @@ static int __init of_platform_default_populate_init(void)
>                 of_node_put(node);
>         }
>
> +       for_each_child_of_node(of_chosen, node) {
> +               if (of_device_is_compatible(node, "simple-framebuffer"))

node = of_get_compatible_child(of_chosen, "simple-framebuffer");
of_platform_device_create(node, NULL, NULL);
of_node_put(node);

Please Cc the DT list. Looks like this patch can be applied
independently. (Better get the other 2 into drm-misc soon or it will
miss 5.17).

Rob
