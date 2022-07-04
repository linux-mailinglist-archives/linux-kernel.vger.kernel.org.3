Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B65565F40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGDV6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiGDV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:58:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712312624;
        Mon,  4 Jul 2022 14:58:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b85so5540213yba.8;
        Mon, 04 Jul 2022 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aX4msgN1b6B4E4WJ19/77nMyu3z3AuscBwv+NzJVFAs=;
        b=pxocR5fcb/eN8OBfibNhCE8C51JiWomfEbeMlgefujdpH5XNv6i9nU0YoDEPq+UmL+
         uwkb/0qFuGEQgkyQXb95m/T19xiLxZd5QK6/hFOLb1x3ezQJXo/l/71CEm71s0dn87PT
         05vb4dU5Z4msXQJ0ojRC6NYCh8H7UjFgurCeYziZ+4S/reeW7HXxxJqan4y7yzuixbgx
         lkbGdra3NXvtrZvxuP24Q/SjzrcNjK0ve+oP2IBeB0Gy/CzVjWYE//KzJYhqqGBDvrkg
         B9mdZ8UqRgnAtNn6DGXAcD6Ydsa0xiLGn+5G6Zh3PAOWosT7wkqEiuihEfQ5DDm2ONRx
         SlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aX4msgN1b6B4E4WJ19/77nMyu3z3AuscBwv+NzJVFAs=;
        b=q0j5LJzUFoXtu3CGx7pd5rPTuLBcgi/r7cRls48yMBztttuwSZu500B64/vLT6g86a
         7U9fSS9gjMYQI1lcv0SWl0CBcQcQOw7a2PHPbZGPtBCtjL6qwxyjlYgeimg3SyGLNf3r
         gYfJM0eraFNegwBcjhLDRrXglbYeRQOreP0D7UKh/Nx2VVdLcbuwg93Fmb4hanQJ+kso
         8h7viPs1h9BjhEZJKz/sj1wLZDARxHnM72d1IiXxaC06f8/ENKR5qfO5xArd1juUwbu9
         vaetPhnbz891cFhwS/gPuvWpZUgzmsutadfj0X4Z0EikGmmZxh+BwYFA5rhvN7XLzUOY
         O3Ig==
X-Gm-Message-State: AJIora8RbcaeMRbeBxEB3g8aA7//c2tiagcnwIiLxkcGExRs7dfBcNuE
        rtLBrlD+2LmVKfX2xjYJPavbUx3GExHszvJTvpnqDyiFhhisUA==
X-Google-Smtp-Source: AGRyM1t/9z9b6uGG5VgQIWg4GoZ+wA/U092ZWBOTi6Odm0JKng78m/z+5bkZVjP23n2tYU11nS7qu3LcXyVWbSKmgJ0=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr3662717ybt.385.1656971894641; Mon, 04
 Jul 2022 14:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220704172116.195841-1-marcus.folkesson@gmail.com> <20220704172116.195841-7-marcus.folkesson@gmail.com>
In-Reply-To: <20220704172116.195841-7-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:57:37 +0200
Message-ID: <CAHp75VeqAJK_jBmF5zb3NACS0JJvzWQ8HAgpDFcXPAQiozp94g@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] iio: adc: mcp3911: add support for interrupts
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Mon, Jul 4, 2022 at 7:21 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Make it possible to read values upon interrupts.
> Configure Data Ready Signal Output Pin to either HiZ or push-pull and
> use it as interrupt source.

...

> +               /*
> +                * The device generates interrupts as long as it is powered up.
> +                * Some platforms might not allow the option to power it down so
> +                * don't enable the interrupt to avoid extra load on the system

Missed period.

> +                */

-- 
With Best Regards,
Andy Shevchenko
