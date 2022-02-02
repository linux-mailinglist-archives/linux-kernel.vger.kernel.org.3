Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652234A791C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbiBBT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiBBT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:58:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D70C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:58:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i65so209190pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=f3tBDDMz1Cl7wSR0qYXsf1pk6gj1XoAYJtYA02SWsWc=;
        b=ERt7l2GrHpmbR9DfZcfO/4G0u2ftbECA90n/T2MYtJcF7KHFBaulB2Y3elqwXaErj1
         SgvMX6enKgKi6ipwi3GMJOLq7A0vUuj+OsY4FTRYGfXeeKMbMo5SyR8KcChUElrIWjP9
         IpVaglb+4cq+qD6XUS4B5zEK/B8IayPMTqhDakgUHyry0Qxa2ItcvneZnv5x2qc46k/8
         A4UpBr5ygkm0tyA0ul4/XSajfr/oc0EOYQuT0FLTZsqNS6z0Bm7NgJmChV/kC881wVL1
         R62PgB5ZIfasDbZ0uRPC0crSVv72woWDxTwCwfMvG3Yi3hUIqeHQq7rAUtZ0br6HfozV
         89eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f3tBDDMz1Cl7wSR0qYXsf1pk6gj1XoAYJtYA02SWsWc=;
        b=Pk3/jfUVZ9vuyi4Cd39vtcooxFh+WbYRx9Wi/fB5IzQiJqvd70lwY9o5Yu9HmxIdRt
         RJInKJGbx/qW4Dv1n9OlVzAYE8njO9Pahg/2X7eKiuaR/Qphv5qN8qISfmvutqlRygap
         Y3FLuJGnuQEV16IvBohBi1agLE1Z44pw7a8fxppQdFDoWYNu5mCsqlCFo+ndhZML2IaF
         h9dGbQftUzHlliBcKEhBchNRJIBw6DDmAfEp7/ClGYwsyuJqyahGnb+RK2//SjW9+984
         1I02PQHxq+olHzwARrCEtYy8T0H6MUZwEzh4IAvR+7CQYQyjhfYPGUyBefd2dJUcLbDW
         ay8w==
X-Gm-Message-State: AOAM532qitVrkzqNkAA3tuU6ZLXPPvSL5Aht59Gp1eNALqFGMFh7+P29
        9oyhucCbp9dMwqB4m8UbCgY7fw==
X-Google-Smtp-Source: ABdhPJz4O1XMyNrRMSsccUAwZX/YKxQmjX8hl66qxIZUzVjXNWSKEFQOBJlAS5f+CRg6eHpU2klvjw==
X-Received: by 2002:a63:6586:: with SMTP id z128mr26035966pgb.103.1643831939129;
        Wed, 02 Feb 2022 11:58:59 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id nu15sm8160658pjb.5.2022.02.02.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 11:58:58 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v4 1/2] drivers: bus: simple-pm-bus: Add support for
 probing simple bus only devices
In-Reply-To: <7hee4mmo2s.fsf@baylibre.com>
References: <20210929000735.585237-1-saravanak@google.com>
 <20210929000735.585237-2-saravanak@google.com>
 <7hk0efmfzo.fsf@baylibre.com>
 <CAGETcx_YEUxEBSBnzFaBxW=9=jO6BO0GuThaMGF+JPkDeC-ivw@mail.gmail.com>
 <7hee4mmo2s.fsf@baylibre.com>
Date:   Wed, 02 Feb 2022 11:58:58 -0800
Message-ID: <7hpmo5kpkt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Saravana Kannan <saravanak@google.com> writes:
>
>> On Mon, Jan 31, 2022 at 7:18 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>>
>>> Hi Saravana,
>>>
>>> Saravana Kannan <saravanak@google.com> writes:
>>>
>>> > fw_devlink could end up creating device links for bus only devices.
>>> > However, bus only devices don't get probed and can block probe() or
>>> > sync_state() [1] call backs of other devices. To avoid this, probe these
>>> > devices using the simple-pm-bus driver.
>>> >
>>> > However, there are instances of devices that are not simple buses (they get
>>> > probed by their specific drivers) that also list the "simple-bus" (or other
>>> > bus only compatible strings) in their compatible property to automatically
>>> > populate their child devices. We still want these devices to get probed by
>>> > their specific drivers. So, we make sure this driver only probes devices
>>> > that are only buses.
>>> >
>>> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
>>> > Fixes: c442a0d18744 ("driver core: Set fw_devlink to "permissive" behavior by default")
>>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> > Tested-by: Saravana Kannan <saravanak@google.com>
>>> > Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> This patch landed in stable/linux-5.10.y as commit d5f13bbb5104 and it
>>> broke suspend/resume on at least one TI AM335x board I'm testing on:
>>> upstream dts: arch/arm/boot/dts/am335x-icev2.dts, upstream defconfig:
>>> arch/arm/configs/omap2plus_defconfig.
>>>
>>> Bisecting between vanilla v5.10 (good) and stable/linux-5.10.y (bad)
>>> pointed me to this patch, and I confirmed that reverting just this patch
>>> on top of stable/linux-5.10.y makes it work again.
>>>
>>> Also interesting, this same platform works fine on vanilla v5.15, which
>>> also includes this patch.  That suggests that either 1) this patch
>>> should not have been backported to v5.10 stable or 2) there are some
>>> other dependencies that are missing in v5.10.
>>>
>>> Since vanilla v5.10 works fine, I'm leaning towards (1), but if you have
>>> any ideas for deps that need backporting, I'm happy to try.
>>
>> Oh wow! I didn't realize I made so many changes AFTER 5.10! Unless I'm
>> doing something wrong with my git commands.
>> $ git log v5.10..v5.15 --oneline -- drivers/of/property.c
>> $ git log v5.10..v5.15 --oneline --author=saravanak -- drivers/base/
>>
>> If you don't think I got my git command completely wrong, yeah, way
>> too many patches are missing on 5.10. I'd go with the option of
>> dropping this patch on 5.10.
>
> I agree.  Could you submit a revert for v5.10 stable?  As the patch
> author, it's probably better if it comes from you.

Nevermind, I'm impatient and submitted a revert to stable[1] :)

Kevin

[1] https://lore.kernel.org/stable/20220202195705.3598798-1-khilman@baylibre.com/
