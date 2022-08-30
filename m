Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54CD5A6182
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH3LT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3LT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:19:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3EDEF8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:19:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y64so1922449ede.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kqQ0qbomdfX0BOZnqhPH85joV3W+LPv5L8gaweOCmBc=;
        b=rldjZ2K7q386hU77K/ohx+FiOePVGg4NurnZ+PCVVhCk/+feGzkTI7qkj/K6J0iNQE
         FeGKDMxPMKuPylgh/I6n7bpschRl2/rR88TeejVCwpwlqh/D7Yt2kEicWSNPclCDrhhP
         2E12m9/7c41VMfx7som6TktA09rVG1N87NM7TqXFypTssnS/OXzeGmV5owa6VeT/dj3J
         I1PfbN0T+W9Dc00NgoQh31JJ9zJQ3vvvuVFX9B2X8OcxU6VeOx3m+y5N7MleLUC1ZjdW
         hhI+cbgt2OnKnyMPiHL90bQeg90l0SR3bXSx2ZicDAta2UIZGcPvT8oYZqyg7nRZ37u8
         o5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kqQ0qbomdfX0BOZnqhPH85joV3W+LPv5L8gaweOCmBc=;
        b=o03WO+6xnFGlMxyzNTDh7B4pNkH20YE/uj4vCS04SA99EdKRDGOEPHztLuL06C6j1G
         Rjr8kxJBx58AWUMif701a7nQzTjIzyTMtc2TzwsmApSzEaLz5O6LhjyQF6hXcGfE9Cgm
         F3hgFDG5pu8HRKdxKNK+VyK1pra+3JVpdoX6oMTp/g0cPHnCuvpTADP+FZyC2oeqRkxe
         OhqP1mS7Ji5JtuZ/zyzINIU8V1AVxjtBzbzqMybtDDZdX6k+Q2W2sdM8WJJ/r6SjS1FY
         Arei2e+ouk4n64mSTlgi981iKNAgyF4TL7I/RV9SnAV5b2m0OpL+yoy1Ln90rkLKdtMh
         uc2A==
X-Gm-Message-State: ACgBeo3hzK8vA4daDy+loh+vY2cEo1jAeZFfNQ0a1qTU4r1MSLqLgzFK
        CtLL9y3YRbHPNte/pmeeqV5E4XhLdyYDkaiJbavtuQ==
X-Google-Smtp-Source: AA6agR4pW261lKKTZ+bA5Kw0vNoubbqIm1bE4vD4Op/JPsqDCkg62BRVariXHCii6pivfV4J4XVoSsMGHgNtxIwU428=
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id
 w17-20020a056402269100b0043dba10854bmr19322240edd.158.1661858393781; Tue, 30
 Aug 2022 04:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk> <b120e94b-4b43-6d8a-a136-41417cb250cc@huawei.com>
 <Yw3hfGV4DYyJ0Gno@shell.armlinux.org.uk> <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
 <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
In-Reply-To: <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Aug 2022 13:19:41 +0200
Message-ID: <CACRpkdYhx4zT9F1CTEvAPjB1EmBD6CFenTJpwQ-KPg1+zCsYGg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in amba_probe()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>
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

On Tue, Aug 30, 2022 at 12:37 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> >         ... ...
> >         driver_probe_device(drv, dev);
> >              ......
> >                   dev->bus->probe
>
> And that makes no sense, is an already known issue, and there is a patch
> to fix it:
>
> https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/

This patch to the driver core fixes my QEMU issue as well, I'll try
to reply in-thread. Thanks for pointing this out Russell!

Yours,
Linus Walleij
