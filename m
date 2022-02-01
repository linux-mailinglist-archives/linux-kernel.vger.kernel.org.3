Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84BA4A56F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiBAFav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiBAFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:30:46 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:30:46 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so47612264ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kydovGavYpv7Z8Qzla4H6f1AHt/32IxvvPG5ynaWbE=;
        b=U77UZ+D4xbTT9TJN9/zszI5V0tEXwMdM+BFvx6Nb9KJU883KTTg8RWJqW4u+rENsbc
         mTJr60YFHw5Cyrrca0pMlnzqqtKSvEDubI0G2fZza/uyEvwpK6LDHKbyuL1pAKlu+isx
         5Rnhlftwp2yqp8HSPx5SIs3NWouiN3k6iuUSYGxj7wdtzs4LuWuXt7HF6nYvE8dm6UJf
         J1nVZTCZUchtA+Hnhbrnp4yi2zYEiIcOXsDJBByWDsZQcVGxuYwU+aPi9Twkd3NAAQyx
         7zDPjux6Iu/hWafBsPTXIjefy75b3o6mwNorP1BcbZabndECDeiebZm9E9u4xH8uPY2J
         Pp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kydovGavYpv7Z8Qzla4H6f1AHt/32IxvvPG5ynaWbE=;
        b=G4PVvt3VX6od6+TPE8c/mqx2mLp+WjmSbHWj4FH1/9YE03K9iSn3MQf7yVNj9w6GvK
         p8MY6gFccsyn/C0XarLcBGb4w+58isJTFiT8bf3sMEzXbXUyV6R3wOOJpEytOltTBTiS
         QQA6JAtIdGRnn3JHn9304P2uTuH9IXbR9icCt4rUaBz73zRVikOp4s5fo9MrylyRKYwP
         NWPVPky1xjM+E5zIh1pWrY0AMp2eVHuMFOYhIq4BjnDnQ5ocPOA1uPSy5uPcgte5p0kF
         1xhmxdwnibwvUIVpjE/h9KR08GdqzRALcacfjVIRoLUGRwfvI/IKlrlKJlrPIwpm9AfC
         T1FA==
X-Gm-Message-State: AOAM53025f9qPC1eMk1t81EPl2XAIGKuO2+hCL9BySM2QIk2W6sd6vm0
        cSDpHisOiViESOqtbv1ja+W2mTnnicV1XoOOIY/CwQ==
X-Google-Smtp-Source: ABdhPJynKbsLj1UEZZnKfLzmdFbVdxNi6pGBmrFfyYXto1lhLijfs+2rVmbRV30Q7qVZQAskM2peIoEkaBltQtJKHlQ=
X-Received: by 2002:a25:50c7:: with SMTP id e190mr33046695ybb.324.1643693445559;
 Mon, 31 Jan 2022 21:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20210929000735.585237-1-saravanak@google.com> <20210929000735.585237-2-saravanak@google.com>
 <7hk0efmfzo.fsf@baylibre.com>
In-Reply-To: <7hk0efmfzo.fsf@baylibre.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 31 Jan 2022 21:30:09 -0800
Message-ID: <CAGETcx_YEUxEBSBnzFaBxW=9=jO6BO0GuThaMGF+JPkDeC-ivw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drivers: bus: simple-pm-bus: Add support for
 probing simple bus only devices
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-oxnas@groups.io, linux-renesas-soc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:18 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Hi Saravana,
>
> Saravana Kannan <saravanak@google.com> writes:
>
> > fw_devlink could end up creating device links for bus only devices.
> > However, bus only devices don't get probed and can block probe() or
> > sync_state() [1] call backs of other devices. To avoid this, probe these
> > devices using the simple-pm-bus driver.
> >
> > However, there are instances of devices that are not simple buses (they get
> > probed by their specific drivers) that also list the "simple-bus" (or other
> > bus only compatible strings) in their compatible property to automatically
> > populate their child devices. We still want these devices to get probed by
> > their specific drivers. So, we make sure this driver only probes devices
> > that are only buses.
> >
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Fixes: c442a0d18744 ("driver core: Set fw_devlink to "permissive" behavior by default")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patch landed in stable/linux-5.10.y as commit d5f13bbb5104 and it
> broke suspend/resume on at least one TI AM335x board I'm testing on:
> upstream dts: arch/arm/boot/dts/am335x-icev2.dts, upstream defconfig:
> arch/arm/configs/omap2plus_defconfig.
>
> Bisecting between vanilla v5.10 (good) and stable/linux-5.10.y (bad)
> pointed me to this patch, and I confirmed that reverting just this patch
> on top of stable/linux-5.10.y makes it work again.
>
> Also interesting, this same platform works fine on vanilla v5.15, which
> also includes this patch.  That suggests that either 1) this patch
> should not have been backported to v5.10 stable or 2) there are some
> other dependencies that are missing in v5.10.
>
> Since vanilla v5.10 works fine, I'm leaning towards (1), but if you have
> any ideas for deps that need backporting, I'm happy to try.

Oh wow! I didn't realize I made so many changes AFTER 5.10! Unless I'm
doing something wrong with my git commands.
$ git log v5.10..v5.15 --oneline -- drivers/of/property.c
$ git log v5.10..v5.15 --oneline --author=saravanak -- drivers/base/

If you don't think I got my git command completely wrong, yeah, way
too many patches are missing on 5.10. I'd go with the option of
dropping this patch on 5.10.

> I haven't debugged exactly where it's hanging yet, but, enabling
> CONFIG_DEBUG_DRIVER=y, and suspending with "no_console_suspend" on the
> command line, the last line before it hangs is:
>
>    [   28.129966] simple-pm-bus ocp: noirq power domain suspend
>
> Any ideas?

I'd guess it's either a sync_state() happening too soon since some of
the dependencies aren't tracked. Or some dependency cycle that'd be
handled correctly if the rest of the patches were picked up. Yeah, a
pretty broad/vague answer.

-Saravana
