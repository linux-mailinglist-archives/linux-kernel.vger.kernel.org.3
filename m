Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309984D517D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiCJTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiCJTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:31:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4296675C27
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:30:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bi12so14416242ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKNb2woAN/ogVBDtyGjLgMM8TFR85EErV6rTyMqQOHE=;
        b=hJ8wYHPm1Vu4JRAQiYGwZ1DLPZl09RsonpRp0w7gH5eEFpRYQx0FS6Ds4afFYEqboG
         Acp+mv2OQZre2lMbttv8IaeieOPvw5YNWyeeuIbUKm4k1k0VrnZF3mvkDLo5+IW1t8E/
         MZKup0cf9OPXpi2ixIYyswpBjY5/PGndXIv+CCXCZ0uRVXbFEi+3T5aV5GaYYYBobj0c
         +ETsbwu9zzvMFf6UrhgDAF1mSFUBjUw5YG8CSPEFRPMn1q/ZyamKbQxKiTZgRo/VdjuE
         nelyILS9Z8vwgohGg+61iaVmrtJTxoVSWOVnmh9XuGRLTz35NR/kU+ROw8LfAS+8j+5a
         FieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKNb2woAN/ogVBDtyGjLgMM8TFR85EErV6rTyMqQOHE=;
        b=a2jac+7s3MOd/Obqoi11mwsryeb99NyvfCE/ahL+Q3Rl0Bzia2+9KnKxdR+YwS88LW
         9+TqDixDApr2RmP9+dMhKs1LPBqiA8GXnXonx2jTxJXFTjyBVCLtG3KVbdvGguugNAv8
         cKQKlNWFEXsjU5PCvAYlIbZSTSsRCSl/Qd6mIWRBGIn0ee+IIE4wv17oUUyw2P0k6u8g
         ZXxP0HZC2mwBMPVP/TOxLbF3q/9Eay42etCPlw7CVutaj2ADt7Ky5+BjgSbu99PDh6Md
         R+BAeXg6n6Df71ph2G0xOlao3jaiP2sXDveeo/S6emQ2YDsnZMtlRVvHHG+WTSoyVFGr
         uQQQ==
X-Gm-Message-State: AOAM530XClVJ95tCTpDdPe0LbVDuOO01GTxc9/ueTTA4Pfsc9w0fezVi
        oR7nWnCK8VZdZQ4qadDSXPekVu6BoFA9owxBBpVk8A==
X-Google-Smtp-Source: ABdhPJxjlJm4ZlcYdr0irGLNCOsqGAyohlNGd1x2M7njvASMS9LrOXfsKcv51bZZWjaJ3FT9bKlCflPB1qUxdvkX03M=
X-Received: by 2002:a17:907:72c3:b0:6da:c277:8c62 with SMTP id
 du3-20020a17090772c300b006dac2778c62mr5643087ejc.492.1646940633807; Thu, 10
 Mar 2022 11:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20220310011617.29660-1-kris@embeddedTS.com> <20220310011617.29660-2-kris@embeddedTS.com>
 <CAHp75Vdu1r0S2ZCjH2mjToYZiwQTOiUAvY5v-T7f=u28tVuxcQ@mail.gmail.com> <1646933773.2804.1.camel@embeddedTS.com>
In-Reply-To: <1646933773.2804.1.camel@embeddedTS.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 10 Mar 2022 20:30:23 +0100
Message-ID: <CAMRc=MerqLPZSCd8+YSAwJPe1_zpOYQK5C-DXirC6dvR4Yss5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:36 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> On Thu, 2022-03-10 at 16:48 +0200, Andy Shevchenko wrote:
> > On Thu, Mar 10, 2022 at 2:22 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > >
> > > From: Mark Featherston <mark@embeddedTS.com>
> >
> > Same comments as per v2.
> >
>
> Thanks, I'll get a v4 put together shortly to clean that up.

Hey Kris,

I already sent it out to Linus, please create a follow-up patch for that.

Bart
