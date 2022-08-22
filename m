Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB80B59CB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiHVW3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHVW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:29:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A94DF24;
        Mon, 22 Aug 2022 15:29:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so15727357edd.13;
        Mon, 22 Aug 2022 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/3thP+mHORVN1UNe40EhQ8iMMZcP1HoSVYhpg6mkUhc=;
        b=hupnvRuYarDUj8pqHqorOQ6o0gOjPEws5p1WxCanT8igi8mAc8W+7UkWfwnGO0yBkv
         /irhwCeNMPVMzzKRl1CMI+GYLW2AqTq77plpW+DQOxSK65ZTCS9gjjEeyk0HDEydiP0E
         qRWHVwuxc11uPoqPbDZmmNRzDF/wg6eT8n7BKdfQriUf/TDqZ7QXlqKmbBeUenVGZtYe
         J8sxezLzTP9oI38EapP17ri9CTKq1cf6iBdqjXL6q/J/Gtb1jWTeyt1IYwFhFUxHKekU
         hQkdpdqCErpmLZRb2YKhgC0KZYzG98MR/dWHNM4tdCHjdLfMN6jISSTlvpV7e3k8ax3g
         3iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/3thP+mHORVN1UNe40EhQ8iMMZcP1HoSVYhpg6mkUhc=;
        b=2qpautWU4p3W4SfiN1zVd2FN5E0DrvfsygIeOz/i0COPXO4y8tzswzeR6JZ9UTKwCK
         Z6CO1XI1V3W5ztDRudLx81qXKdSCVy0z40LzeeQXNHGV6TJ08G9n6CmFTk1oUpvp5w+3
         VBV0pD/9J2IS2S4+HMyOQyyMRjo1GQTxTVrroaUmmib44sV/ipjJs/I6XiiZ8cygI3no
         xOgqIlVch8u9EGxZxXjE3pxD4N7CgQsVFSDzViBBGTlQHbgnOJcIcaMs4upOMrlWn38t
         ZnPQ0KmpDOy0W6o6bpSr779hF+mlyBu3sjibG6cyXWUJ8h76KfrxgUb/8ZmJLnkNhRF/
         rXgA==
X-Gm-Message-State: ACgBeo2rWe2KZvymqo8RbmpGhfPhDd6+zvcZSFvU1VrHJ82t6lRBFag1
        iEIyFg1GGdruPZp2lM8PHme2DxMbUv4NLDktbDM=
X-Google-Smtp-Source: AA6agR6exfNNZZYmvy4j+IlG1xxaLbf/OSs9Pl6Hic+tGxiQJAKjYcSUq33M5bsYi1c0NyB+wbgFKBBmk0PE7BDNzSo=
X-Received: by 2002:a05:6402:ca4:b0:446:540b:3486 with SMTP id
 cn4-20020a0564020ca400b00446540b3486mr1002770edb.392.1661207390101; Mon, 22
 Aug 2022 15:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220815131250.34603-1-tony@atomide.com>
In-Reply-To: <20220815131250.34603-1-tony@atomide.com>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Tue, 23 Aug 2022 00:29:38 +0200
Message-ID: <CAGfqbt5R3LEECvzpGZOx5pB+iL=B+hptLTkBLNk6MBHWZoW-yQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Clean-up timer-ti-dm a bit
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Monday, 15 August 2022 15:12:41 CEST Tony Lindgren wrote:
> Hi all,
>
> This series of changes cleans up timer-ti-dm a bit. After this series we
> can start replacing the custom PWM related functions with standard
> Linux frameworks and use things like clk_set_duty_cycle().
>
> I have only tested this on K3 and omap2+ devices, I don't have any
> omap1 devices online right now. Aaro & Janusz, if you could give this
> series a quick boot test for omap1 that would be great.

AFAICS, OMAP1 timer-ti-dm compatible "omap_timer" device requires OMAP16xx
at least, while I only have OMAP15xx.  Then, my testing (successful) was
limited to a single function -- omap_dm_timer_modify_idlect_mask() -- which
is called on any OMAP1 as long as CONFIG_OMAP_DM_TIMER is set (requires
CONFIG_COMPILE_TEST).  However, I've reviewed the series and it looks good
to me.  I'm only not sure if we may expect any external users of
omap_dm_timer_get_irq(), if not than we could make it local to the driver while
being at it.

For the whole series:
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz


>
> The patches are against v6.0-rc1.
>
> Regards,
>
> Tony
>
>
> Tony Lindgren (9):
>   clocksource/drivers/timer-ti-dm: Drop unused functions
>   clocksource/drivers/timer-ti-dm: Simplify register reads with
>     dmtimer_read()
>   clocksource/drivers/timer-ti-dm: Simplify register writes with
>     dmtimer_write()
>   clocksource/drivers/timer-ti-dm: Simplify register access further
>   clocksource/drivers/timer-ti-dm: Move private defines to the driver
>   clocksource/drivers/timer-ti-dm: Use runtime PM directly and check
>     errors
>   clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to
>     driver
>   clocksource/drivers/timer-ti-dm: Add flag to detect omap1
>   clocksource/drivers/timer-ti-dm: Get clock in probe with
>     devm_clk_get()
>
>  drivers/clocksource/timer-ti-dm.c | 681 +++++++++++++++++++-----------
>  include/clocksource/timer-ti-dm.h | 112 -----
>  2 files changed, 429 insertions(+), 364 deletions(-)
>
>
