Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F34C8B64
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiCAMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiCAMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:20:27 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64CB8B6DC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:19:46 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id u3so26831484ybh.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 04:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g2ZNVVCbLbWFvHoFdGGw62aXjqOkohSTObIxoEgWGUA=;
        b=gix1vsY2RfCg5rYq4KwA43bmZ3RwluQY2zRNMsUm3HFjGzu6kXGzw8E5AnFbdH1W4W
         JmuUAniBKPQLTsDZhs0ShrkyYXN4tP1Xd07Uf/DuHqPkVJ1Sgu73p+ie4VmDyCBXbOAZ
         DxI9hW087f7paMRXscpnr4TKGnKrd06W8nEccLJojJP+czW5WoNHQGKebjZmuoKxXLnw
         IHW015G6V7IPJ6hEDgUlXywPATd//YdwfU4l8YGW8Zu8qegZY+7D7NccaNrl34Nayy3B
         wrqmLzOx3+zufEdsX8ch8BRM046OZStZwhCPInE7PbaXxDryokYJKi7tjUv4yOcPfcCg
         vxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g2ZNVVCbLbWFvHoFdGGw62aXjqOkohSTObIxoEgWGUA=;
        b=Av/yiyphilZDc1JIgOUC1+bX4WNhcWNLpBQtzYhbtOOIWzjn61GkrXCNTuHN6ICd0g
         IYKb8VrlRnJiyrKV8ohnl+UJmUwcKvxzTj32ENGo2lr/7RVcHs7X1l/OzZ+T3EKep8+H
         DYxRVC+lgjEQaOLe1TOPgEMbSFEguEVjOrd+xB/eDIEYDSIIlBhuUC3dmf9aV3Dba2rj
         zqIrFAT6RCLacMb15MPJIMUdKT1V7jnf7cLn1gNqv6cPeUOAEp0pfkSI3gqWYXq/IvGw
         LEeM7MOTbByjlMP/yv0bvSrdY0qEEmxKh+felUAVpL+fX0KqpdhsdYg+VZzWM15X/uhg
         GMMQ==
X-Gm-Message-State: AOAM53134O/Q/RCfqi9XrnBcULpcZJU0pa6rdRvwWyvfCBzkQDicx3Dg
        yywLMS8GNCyGcHyYVFVm7E9eacrNISXvOAhJHIe3/ItldTZlokOX
X-Google-Smtp-Source: ABdhPJxir7Iw04CbEhZhYBqHEUpAGK0Kl6rlU9aXJwfJs8ZPFHXTW0ItNAj1KDgiIQcsP7+MLdr1dyrz0vdBDp7plfc=
X-Received: by 2002:a25:c592:0:b0:628:9263:38ba with SMTP id
 v140-20020a25c592000000b00628926338bamr215069ybe.291.1646137185832; Tue, 01
 Mar 2022 04:19:45 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Mar 2022 13:19:34 +0100
Message-ID: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
Subject: Question on expiring HRtimer in-kernel
To:     linux-power <linux-power@fi.rohmeurope.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with a premature expiring HRtimer.

The HRtimer hrtimer_set_expires_range() is used in two places in
the upstream kernel:
kernel/futex/core.c
drivers/power/supply/ab8500_chargalg.c

Now I am testing the code in the latter, and it has seen some
bitrot since merged in 2012. Maybe it was correct at one point.
The timer is started like this:

    hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
(...)
    hrtimer_set_expires_range(&di->safety_timer,
        ktime_set(timer_expiration * ONE_HOUR_IN_SECONDS, 0),
        ktime_set(FIVE_MINUTES_IN_SECONDS, 0));
    hrtimer_start_expires(&di->safety_timer, HRTIMER_MODE_REL);

What the author wanted to achieve is a very definitive callback in one
hour relative to now +/- 5 min, and that is one hour later in the
physical world,
as this deals with battery charging.

However sometimes this fires almost immediately rather than in an hour.

My first thought is to pass HRTIMER_MODE_REL also to init as
hrtimer_set_expires_range() could make things happen immediately
if we have ABS set, but this is all just intuitive.

Any hints? Better ways to create a definitive event in one hour?

Yours,
Linus Walleij
