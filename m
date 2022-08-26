Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245C05A2894
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiHZNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiHZNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:30:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD4DC086
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:30:52 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-33dc31f25f9so35743457b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0ooGIQ5Kg7jlU4lI2Cbblsvn4XORFVsSck/7vKrYV5k=;
        b=RthvJZDD6WkH/T8xq6gxuM0kxfn7dYAeAVlAoyWlAGa6oC5TBs3ldeTFWpU5c2ojYk
         6C8+ArPTWOen8U0ibf8dSx+uOdtUUhhuiEeVvE5EHccd+rLY5LQCY7kioajwXmfDlU7D
         jvP9UeVcAIVfqtPPvTIiyBekGgNpgL0dZTrABnoHSISTEiX8svH0SChx20NSoDQS3nT/
         lhGy68aW6si8WsUJAMdM34A8/CtXlDWDSRwyy9Twsy/STg5EBfH06dDm+b6vY0Kt3hjw
         kBpSy17EFr7e2h76G1xdsb+qg7Nn5MgIsnGv7xDl1BLksZ4cnIik9I2LbHS4n118sSr4
         EHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0ooGIQ5Kg7jlU4lI2Cbblsvn4XORFVsSck/7vKrYV5k=;
        b=iGeQqUu2fDP4gC4AilJNHXEhy9r9nEjvCZSLKOeLA9KUxngnDINjWpnvS+Uwi9jNB6
         Q20oNMM2ZuD6XYYK62z7V2d08ovYg8CBg/MtLR5SNh9o4HI4SEbM1Z91ubDWAml+RAl7
         I8uTHxDb30xZrSHAzu566ClVgJq8VhJ7VZr9dbcH4XoNkxrKi58wiTW+mKJiIANC4iYi
         Rx4eRjf8VxKd+6xVPJVK8EJoJxVoc0z5fJouxzr+WonDZ7FXqquzVeF0DhgIMFFXPR5Y
         wuHvNnCxjscpRxGZTSOlFLc0rJn/bEjUAmCyDcVIW1urZRuOboutuMkiODXa9reA7CQt
         Nceg==
X-Gm-Message-State: ACgBeo0FIDJcPYGl4myFvt/V86z0jyZJZLKTfI3aUu7VvhmWqUPTyYyW
        cdFiTBH2U7ZEz2/eP+dztz2Fi3U8kLdq7L/tE0v8BQ==
X-Google-Smtp-Source: AA6agR5YXZgq6kN4fV1MxKqyc0vTIjMz0GJ4TdquA00/dxmzeThXpKF5sia/6ppI0ut+CScaGfjZ9OH1Rt8W2wuX5a4=
X-Received: by 2002:a81:594:0:b0:33d:a498:167c with SMTP id
 142-20020a810594000000b0033da498167cmr8974402ywf.59.1661520651973; Fri, 26
 Aug 2022 06:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220823102344.17624-1-henning.schild@siemens.com>
 <20220823102344.17624-2-henning.schild@siemens.com> <YwToilxquEZGqzQD@smile.fi.intel.com>
 <20220823165459.143e1c30@md1za8fc.ad001.siemens.net> <YwYjXzsSHNe+J3aO@76cbfcf04d45>
 <20220824155038.5aa19495@md1za8fc.ad001.siemens.net> <a001efb5-95a3-d89d-32bd-557b6f11bb80@redhat.com>
 <20220824161757.4ca3bb97@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220824161757.4ca3bb97@md1za8fc.ad001.siemens.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:30:39 +0200
Message-ID: <CACRpkdbKzoVoch+hRJtp=vaCQvKSt+=HMJYZ4WxWjFr+-tZ4KQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, simon.guinot@sequanux.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:18 PM Henning Schild
<henning.schild@siemens.com> wrote:

> > You did not write it, but you are using it to do hw-enablement for
> > your company's products. So being asked to also some touch-ups
> > left and right while you are at it really is not unexpected IMHO.
>
> Sure thing. Dropping a few characters from a line i touch anyhow is
> easy enough. But i.e a refactoring to pr_fmt would feel like asking too
> much in my book. That feels like work of the author or maintainer.
>
> In fact i am just doing the homework of what i think should have long
> been done by Nuvoton.

A lot of vendors don't have much active upstream participation, they
outsource that work to people like yourself by just ignoring it.

> I hope that v5 will be acceptable.

Bartosz is applying GPIO patches now, but my principle was that
when I feel a patch makes the kernel look better after than before the
patch and no new version is coming, I just apply the patch.
This is how we deal with "perfect is the enemy of good" in practice.
That said, we are all grateful for any improvements you manage to
sneak in!

Yours,
Linus Walleij
