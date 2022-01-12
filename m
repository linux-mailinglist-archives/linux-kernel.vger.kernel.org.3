Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3748BD08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiALCSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:18:23 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:35454 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiALCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:18:22 -0500
Received: by mail-oo1-f47.google.com with SMTP id q15-20020a4a6c0f000000b002dc415427d3so258304ooc.2;
        Tue, 11 Jan 2022 18:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BO8Ck/GGtQHl3h6eStim8WA1eqAvMlyV0nmG424orR4=;
        b=kePL2SCJkQF/Z4trVtpT8tnWTjiiQMCt+D0aJ5j4sMMEzW73Azgh4RY0S1geEhqSyh
         kuJLQZGPuXTPI2wZhYSsyQRIfb0s90D7O4VPkoYYU3BxbqjdscD9YVJSuV/QLU9iD6NT
         X+JzvwjgJHryIBjWIBWkqTGHAun/qC5SMAvT+P6NvxSmz3STGwZybO7MkkQmPQxtSOdi
         qgh889xmrgs6D4ObvaUrEtFevUXtBQ85IRlR+xj9rUe/vyeRkdehWnwpDSWNZGc8fYKJ
         RATXqr1WZuPvSBmh0oamWtOkPITyybiP41IdHbT2r1u+1c1JTFi4LIuqfuVyjF7+VaZ5
         YFkg==
X-Gm-Message-State: AOAM5306wY0LdnLQONd0VUXdn5ZFT5a7LgFnkeowGoFNsa7ZIKRtGPpJ
        clr/xbmbRTq5ZTn23m3Vx/Ynkcs4lQ==
X-Google-Smtp-Source: ABdhPJzpfe+rU+Xszas4yAs90JejNxO5tFbDzjU5Jmj+x0bVLjCaBSYH2hZ8uOd/leZ6ggwmU+nP0w==
X-Received: by 2002:a4a:d248:: with SMTP id e8mr4922072oos.5.1641953901346;
        Tue, 11 Jan 2022 18:18:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w14sm2289381oou.24.2022.01.11.18.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:18:20 -0800 (PST)
Received: (nullmailer pid 3939569 invoked by uid 1000);
        Wed, 12 Jan 2022 02:18:19 -0000
Date:   Tue, 11 Jan 2022 20:18:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: gpio-restart: Correct default
 priority
Message-ID: <Yd46ayLnvT/3ch9e@robh.at.kernel.org>
References: <20220110214456.67087-1-sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110214456.67087-1-sander@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 22:44:56 +0100, Sander Vanheule wrote:
> Commit bcd56fe1aa97 ("power: reset: gpio-restart: increase priority
> slightly") changed the default restart priority 129, but did not update
> the documentation. Correct this, so the driver and documentation have
> the same default value.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> This is a resubmission of RFC:
> https://lore.kernel.org/all/cfcd00257daba5aa30b8d20a62ba542be1a6914c.1640887456.git.sander@svanheule.net/
> 
> The commit message for bcd56fe1aa97 mentions that it is a workaround for
> rk3288-veryon boards. However, commit e28ea9dbc52d3 ("ARM: dts:
> rockchip: add shared rk3288-veyron files") later adds a gpio-restart
> node with a priority value of <200> for those boards, effectively
> rendering bcd56fe1aa97 obsolete (for their use case).
> 
> Perhaps bcd56fe1aa97 could just be reverted instead of updating the
> documentation.
> 
> An argument against reverting (a 6 year old patch) is that other boards
> may have come to depend on the default value of 129. I don't know about
> out-of-tree user of gpio-restart, but there are a few in-tree users of
> gpio-restart /without/ an explicit priority:
> 
> arch/arm/boot/dts/imx53-ppd.dts (commit 2952d67637716)
>   DTS submitted after changed default, but DTS copyright predates the
>   changed default.
> 
> arch/microblaze/boot/dts/system.dts (commit 7cca9b8b7c5bc)
>   The original DTS commit predates the changed default, but didn't use
>   gpio-restart. The commit adding gpio-restart appears to indicate no
>   other restart handlers are present on this platform, although it could
>   be these were just being shadowed by the custom restart code.
> 
> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts (commit 0a91330b2af9f)
>   Recently added board; couldn't find any obvious alternative restart
>   handlers.
> 
> Best,
> Sander
> 
>  .../devicetree/bindings/power/reset/gpio-restart.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
