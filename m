Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8B58610F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiGaT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:29:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1866AE5B;
        Sun, 31 Jul 2022 12:29:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p5so11306785edi.12;
        Sun, 31 Jul 2022 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Lw53LGjMYk2wKLkpCkMzhMU/ERzJG+2KOxxgSH1zgdU=;
        b=gXJcNmTRLXg/V8KJAfyYmV8b/EUlRYeownvd/IMNCvFNgDUMdjWMQ47IKipedORKt3
         KPm9oNNTQ72x7FrQlo3Sy02e3QYfZF1fEp9J121zyxI7wtvyjq7XqlEirBR1ny9GWGE7
         N6R3ge4woduU2DwUjjyND3UO613tbNcj6EBzreM2yBLI66+yeXXbzkimbq6QgffMGyyI
         kEF923EcPSoY7BXCvUZNbKUe9V3zSwbJhj+pfu+O5C0VM+p81FE6ix4mwpeTtIa2ToGJ
         oCkzE19sWu6fIPKpO90qB0Ed54UWX7w4KkzS2le0nzOP8Ox6amRwEq8hkr8yqq9EI5su
         D2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Lw53LGjMYk2wKLkpCkMzhMU/ERzJG+2KOxxgSH1zgdU=;
        b=JqD3P8dLZk7amgyeNhEEyxeHbdBdqy3MSu8njO0T8qKnmVk89dDJpAYCqPbeOrHF6h
         Btf43dqtDg41gGbVwKjTvExdIGyVEo+oGexKziAoAYx+7WkTCJrOL2qXQI3aTEHlDFma
         SVAIyzit2iPtKWJbHuP7rbfroQe5cRDaqn0JA+WIEn9BdnClPR4DgdynV194hspe9Pvt
         W+9Wjeb5vt2rBDs+fwY43yjyjIesYGxZgJy4A6t/FrN+gAkPmxMPt4SwOdkM1C5TiQ8g
         72ZO27++ishOtWdpsVIQXWDLk/qKB8gm17E+Am7nWozHoL197B8YkNVgZGPSZF3PHjuL
         vjPA==
X-Gm-Message-State: AJIora+0G9pf5/MLm7LKpLvQgO7LbIUfCMthHKsBIcb5g9LgCZ65AgVS
        ZMhQE7DpKCUycgl/BDYcZxJOSnfLTdICtacArC8=
X-Google-Smtp-Source: AGRyM1siBEDUKXsqCVV9//5tCubg3Fw94xh7Rjz+bbW/JNpAinjTAn3FAq+ICWEuaWlDhIQtOz/jrTFJpc6CcbvxVWs=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr12887191edb.380.1659295766127; Sun, 31
 Jul 2022 12:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081146.47262-1-jjhiblot@traphandler.com> <20220722081146.47262-3-jjhiblot@traphandler.com>
In-Reply-To: <20220722081146.47262-3-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Jul 2022 21:28:49 +0200
Message-ID: <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED controller
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> The TLC5925 is a 16-channels constant-current LED sink driver.
> It is controlled via SPI but doesn't offer a register-based interface.
> Instead it contains a shift register and latches that convert the
> serial input into a parallel output.
>
> Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Sorry for my slowpokeness, but I just realized that this driver may
not be needed. What is the difference to existing gpio-74x164?

-- 
With Best Regards,
Andy Shevchenko
