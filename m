Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE54E89D9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiC0UAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiC0UAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:00:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5A10FDC;
        Sun, 27 Mar 2022 12:58:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c62so14746735edf.5;
        Sun, 27 Mar 2022 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJC0OBpbo1wPJs92walEXwvuMKGL+QuVz9UtNgWIQO4=;
        b=cbr7IATfDrBAabV81aPZWOvIUBIUIpSdkVpz3wjkORMU+Td/ujiwFi9ZmSk3nHQVca
         qjNhZ+aFm+JtQYK//RiGq1gFJxM3cmSauYqUO2zFMLO92vxv2idh3/kJkah5hdsKpIGu
         ohyvdc6aUDzyrgxarmcXEakKWBjWYqlfE3WMVENslcooChfSlJsQNnzSyLyNuECHCTUB
         bRs1z9EhRBXqUQTHHRdq+XJEiCuxMkMsGkp4wRMPUhOZcZzxM7/lQ4CY1YO15gUoudXV
         1CUzBCwGedNlRNVXhiCntP139L693MrUoHassTyuCBVby16DlShHN5rHMaHEZH4B0VAv
         665A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJC0OBpbo1wPJs92walEXwvuMKGL+QuVz9UtNgWIQO4=;
        b=maE2XiZjyIWwtC1kvyMwVbkX1blPYeqn9P4I0203gUyw5Q+9KQp6i67r2JgRLTD742
         YISsvPI2blRXvnCpMA0ncxL2axDFErJ1CcLngxEiI8qEMmOYef3igiq8/s2l9wPAjBja
         FHL9RWQO9rSksUtEVFiGVdEAVHgpNNXyvoAxPhAw7BP9I4fQglmmFJD+Apiovc4+ab9e
         zFzDmcx5Gj6Dr6QWC6LUzvbLAMvobQXbgE8Z5zLAoEHDE8UuqB5vGQOZO9QNHlPjN/Mp
         Bk6mxyI4nZ6meIugTFRhU6d8Ep/UcUvmMSgFWN/Xm7ddeeHCkxGwksiCROk+mlt9nNPv
         SLvQ==
X-Gm-Message-State: AOAM532xXqQQsRaRgctGY2PK1R7r3yavjgCIE84TsCA4E8YF58tGlS4i
        0quytp79VMqt5H7RQBUoNhJC8dltcrK2/sjcmIo=
X-Google-Smtp-Source: ABdhPJwgGCwymYiuaBSFEllOtIN0gwhVm7kC5VU8kOJXl9C6VXio0PVhOi6MtGOhiTL4+DgFpjcuqUXIPq2NqVcjDUg=
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id
 l15-20020aa7c30f000000b0041902af4845mr12139494edq.296.1648411122928; Sun, 27
 Mar 2022 12:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
 <20220325200338.54270-5-andriy.shevchenko@linux.intel.com> <3415996d-e8b5-2416-fb66-e65779a9b507@omp.ru>
In-Reply-To: <3415996d-e8b5-2416-fb66-e65779a9b507@omp.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:58:07 +0300
Message-ID: <CAHp75VdoKOqaR5XuBvZ9EBPRE+ULvXf+B3sh1rQ6RXt_ovcsbw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] pinctrl: armada-37xx: Replace custom code by
 gpiochip_count() call
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Sat, Mar 26, 2022 at 7:02 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> On 3/25/22 11:03 PM, Andy Shevchenko wrote:
>
> > Since we have a generic function to count GPIO controller nodes
> > under a given device, there is no need to open-code it. Replace
> > custom code by gpiochip_count() call.

...

> > +     nr_child_nodes = of_irq_count(np);
>
>    Mhm, 'np' is no longer assigned to it at this point...

Good catch! We may retrieve it by calling

  np = to_of_node(device_get_named_child_node(dev, "gpio-controller"));

like it's done in the previous patch in the series.

--
With Best Regards,
Andy Shevchenko
