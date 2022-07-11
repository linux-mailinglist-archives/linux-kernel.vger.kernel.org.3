Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455E65703BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiGKNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGKNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:02:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A264CE6B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:02:22 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 6so8575004ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBLM5Pi9tPv6vKM0pZCCueIUCFwTFpFPFADh+Fgewz0=;
        b=SNjylM88LckGpiE4V/QUaMe32JWa/uYAO8RGp/aAtFaJRJpGCN6w0mykgjuvUSGDur
         lrFqFOwDHaoNloZrphn14yC0t+vufFpHzADq4YWaNThEc1Ugi/ioeS7l8Z+iO7+ClNyY
         f2j/Rg8i1AOf7VlII+FHdmrOtQ3JfUygah2qq1q8P6/sXeEg5FItPM52F1ecGvQO9c0L
         6cwowVtD0lP3a0eu8KH6kAVi5VceEXcC9flnLWL2cU7eTUyLFebg8dGbRlajiXYcvrw+
         4oCWvmmlOeSQMQd8juIi+UUOMtqwlE+OP258+eVPXXHf9WqrIOgfscAvF6CJA2vvda/1
         10dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBLM5Pi9tPv6vKM0pZCCueIUCFwTFpFPFADh+Fgewz0=;
        b=vsXFo6ypXqrpM9uHh9LDN3wNY8TwY6uO+VmrXleXAgrfJ2iOcWDiKC07dJ/zp49yzZ
         7nkCj5WNwKlOdQrQl1qUK3SHP7qBoLw4Y+dHdVYfoitkcqDfiEfbGWlEEzXVQ6WOnkyW
         gubR4fBZtm/mpfIqFu5KBhgQ2+ucodhlpAGEIHQCv2qFfjwngDqni029CUq66S6vpHim
         M6M7JwsFMQ4qhWf7PZS/d4MccS9BQUQM5SszsmwgZ2VwmudhKWAE6GVl97BvH3PP0yn4
         Vut6CMXusFfVVtR52CA1VT9ZHDTE35CMSEooX4ZEs7PH3w57F4xcT/IT5jo0u4vfUnVR
         mf7w==
X-Gm-Message-State: AJIora+QTuJo7pcq6lZ6K8XeiETcCWKsQ5epLNKP91A9rwNnfaQOrVV/
        WG8+i1O524iP0pLojKE7VzLNnWZ16P45MGOmCECSfqP4hXo=
X-Google-Smtp-Source: AGRyM1t29T3PB4THchLEbX8ZYCRztrVQWphL7uBS+Yep1DzncLFf/md0RvUmi8E6sALH+K4tBCYHuiDNW0qA8+E+wqw=
X-Received: by 2002:a05:6902:1184:b0:66e:756d:3baa with SMTP id
 m4-20020a056902118400b0066e756d3baamr16793466ybu.533.1657544541545; Mon, 11
 Jul 2022 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657216200.git.william.gray@linaro.org> <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
In-Reply-To: <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 15:02:10 +0200
Message-ID: <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
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

On Fri, Jul 8, 2022 at 1:16 AM William Breathitt Gray
<william.gray@linaro.org> wrote:

> Exposes consumer functions providing support for Intel 8255 Programmable
> Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
> introduced; modules wanting access to these functions should select this
> Kconfig option.
>
> Tested-by: Fred Eckert <Frede@cmslaser.com>
> Cc: John Hentges <jhentges@accesio.com>
> Cc: Jay Dolan <jay.dolan@accesio.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

This chip is like 50 years old, but so am I and I am not obsolete, it's about
time that we implement a proper driver for it!

But I suppose you are not really using the actual discrete i8255 component?
This is certainly used as integrated into some bridge or so? (Should be
mentioned in the commit.)

> +config GPIO_I8255
> +       tristate

That's a bit terse :D Explain that this is a Intel 8255 PPI chip first developed
in the first half of the 1970ies.

> +++ b/include/linux/gpio/i8255.h

You need to provide a rationale for the separate .h file in the commit
message even if it is clear
how it is used in the following patches.

Yours,
Linus Walleij
