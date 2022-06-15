Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6A54CD99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiFOPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiFOPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:55:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCDE31233;
        Wed, 15 Jun 2022 08:55:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 25so16785107edw.8;
        Wed, 15 Jun 2022 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUGdgMjv/uN9brWO8I+WFFAoYBEHwe0F9oQEUQeidNw=;
        b=FkhsuK11nNIPM7VsfrpcVZUU1M1Y1phXG7I0XOyq/g5nalnbEVvMGzIKmla4ZE4lXd
         uw0/m5WmKzUz441fq6If9dv3crn9K6Sh4duGwYbiVpaNSCOY6iphSDwt9g31jjffrqOF
         yEl5/8jYHU5EKvT+i1ItGGYyiRYDbirGhXOcWOqlng427Wn04GDaYPna/T+ttssnuh3G
         BOo/3HpJVRoA0/8/ZPoTjl9rjLIWe7deqYYpHLsp4bTO6brUg6ixMtrXb7aweS8YDOQ6
         zbKyVcslieDnJYBgQd+7ZUn8cf9VfoeTCrvn2YRsr99bDSvnHUzIA9+7pAqB44fthQVK
         pBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUGdgMjv/uN9brWO8I+WFFAoYBEHwe0F9oQEUQeidNw=;
        b=4g9n/jBHUlGPCkeUrPRl3zxNfvKaaGcz7q8W4vMHCwlGObCcqYNkaCfde7vDX3QkM0
         WhO/O0mCNCd2eQmfl+3PAEK8WXJArPAKXyRWLpY6SHz154LHGj8Q/NheBPH5r5qWLkJo
         aQIkjWG8BJWWMonnMaumiYVpQVlAyQfbNskbbhtExSaABjsmWyZ7jUX/1hSxRJpcddtP
         Y4yPsUG6GGLlN3lYxKGUL/DpUhXDHbu1aQvpW33Xgb+V0OnrC5Egfv6/NuKclAjVFsh7
         e9dEoSrcMWz0FyHVvfNFf+AeXVrxUVJQoBadb2D09Kp30tL5LvNTQXPb1I927/wOrUEZ
         acNA==
X-Gm-Message-State: AJIora/2dlZ51GeQGmqoJB7eF4yjugDLf/sgup7M+D+sgF6X03u4MKpM
        X6cz3ExZiOLutN0OcFU83CvZ0H5FvrUc813G38E=
X-Google-Smtp-Source: AGRyM1urC7GMplKnfhs5wa1aIfgNn/kP+MXWv1Yukvb5szoYY8Sf4KayQnYLCJjPaYJ5AvMv9amu+2USWBQCkqkRuug=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr480840edc.97.1655308526784; Wed, 15 Jun
 2022 08:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220615154918.521687-1-jjhiblot@traphandler.com> <20220615154918.521687-3-jjhiblot@traphandler.com>
In-Reply-To: <20220615154918.521687-3-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 17:54:49 +0200
Message-ID: <CAHp75VfnSKadgE1=awBGjseU2mcky3FbLXXZ6S_qxPEpt9hmCw@mail.gmail.com>
Subject: Re: [PATCH 2/4] led: class: Add devm_fwnode_led_get() to get a LED
 from a firmware node
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        johan+linaro@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 5:49 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Same functionality as devm_of_led_get(), but it takes a firmware node
> as a parameter.
> This mimic devm_fwnode_pwm_get() found in the PWM core.
>
> The ACPI implementation is missing and the function returns -EOPNOTSUPP
> when the firmware node is actually an ACPI node.

...

> +       if (is_of_node(fwnode))
> +               led = of_led_get(to_of_node(fwnode), index);
> +       else if (is_acpi_node(fwnode))
> +               /* ACPI support is not yet implemented */
> +               led = ERR_PTR(-EOPNOTSUPP);
> +       if (IS_ERR(led))
> +               return led;

Yeah, acpi.h is needed here and it needs to be ordered, I guess should
be added somewhere at the top of the header block.

-- 
With Best Regards,
Andy Shevchenko
