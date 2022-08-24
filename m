Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2759F490
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiHXHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHXHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:53:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A5C83F06
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:53:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 10so12784423iou.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9r/o+kbVQuRgd3he3vY5TSCEIo6rMCGZbm88wIqFP8Q=;
        b=eMXIxPRGdnHxWWurrEzfpDzZsVgdUEI1TRoy42m0Dzr7/LEOSVr0qgBLVn2S4cdjNg
         8NNplilxBrpW4w2v/+0aYUstSMgr6x114Xh5WblS6A781kvgUwgoepfN2jxcjHdvN/zf
         ieSXvQh3KEV7EdsSt/U71vN6Bxvan0bGM0hOq/3BV71XvylDtFvnoj6V6uFVeyP+ZEtF
         7fGtUUOQa7bk3lWTEh2JROmiGw0qRkcPwjRqUO/49Lb35nrCUhS2zXshjXZoHAUdbJkW
         nZSI5huxEmCPfjOG/GV0m8XuNP0eIZs4Kp5dOxVfAA7IYIJYUt7Lf4fZx7N1fTmGCBhc
         UTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9r/o+kbVQuRgd3he3vY5TSCEIo6rMCGZbm88wIqFP8Q=;
        b=RmqZQ8VZ04qt69Qdj+8DlON3fdPL+jk2ol3K0L1hkzbgR22MmkBn3hKf5owUVkhmYo
         9x9HVExZFhe6WiGCnRbpatjOcgg0dYeY20WH+eVhxNleBd3qXDtqlnRBuekWf1XpAXtV
         4i3/CnwhuAacwV3QbFay7yEZci9VvOsHFwoORip60Et3otSS6nLodGjTb/RuNb976xRN
         UVYDP7l16uaKHsvKvwVPSv0jak8YbN/SH8xvPL0qSZfhKHEmoaBY0UvIl88pOnIO5PcC
         I5gzTZ+HrXhj/XQLrOUsuzDyFJ9p9Vu875Nqa9jUjuKGUaTDwAZwLNyNX3A4xV8Sbbpm
         7xRw==
X-Gm-Message-State: ACgBeo0XW0b5yZvlHimocH+5kDcUd2Mj2bBSaH74MzjRX3uv40TjFXEF
        C8VODQaZK3wotrAsRsKgZwfsJogb2E2bnZh4c6i47Q==
X-Google-Smtp-Source: AA6agR4mfF2ro5+qjUp49hz4FOBZZAOyRo1US7nx2yAd8Tst61WFeQtDsY3aU2BgycMHgnUiI9L+G/cYdPQyHt3NXsQ=
X-Received: by 2002:a02:3f63:0:b0:349:cef9:d8c2 with SMTP id
 c35-20020a023f63000000b00349cef9d8c2mr7667351jaf.231.1661327583663; Wed, 24
 Aug 2022 00:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220527102900.144894-1-iivanov@suse.de> <20220823230842.AB8BAC433C1@smtp.kernel.org>
 <20220824074443.nvrnqhpvqrtn72p4@suse>
In-Reply-To: <20220824074443.nvrnqhpvqrtn72p4@suse>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Wed, 24 Aug 2022 08:52:53 +0100
Message-ID: <CAMEGJJ3mh1UFTQhyDLnr1ztZccH8LKmz83_jcTYrSF11TWgbfw@mail.gmail.com>
Subject: Re: [PATCH v3] clk: bcm2835: Round UART input clock up
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan.

On Wed, 24 Aug 2022 at 08:44, Ivan T. Ivanov <iivanov@suse.de> wrote:
>
> On 08-23 16:08, Stephen Boyd wrote:
> > Date: Tue, 23 Aug 2022 16:08:40 -0700
> > From: Stephen Boyd <sboyd@kernel.org>
> > To: Albert Ou <aou@eecs.berkeley.edu>, Broadcom internal kernel review list
> >  <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
> >  <f.fainelli@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>, Michael
> >  Turquette <mturquette@baylibre.com>, Nicolas Saenz Julienne
> >  <nsaenz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
> >  <paul.walmsley@sifive.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
> >  <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
> > Cc: "Ivan T. Ivanov" <iivanov@suse.de>, Phil Elwell <phil@raspberrypi.org>,
> >  kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
> >  linux-rpi-kernel@lists.infradead.org,
> >  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
> >  linux-riscv@lists.infradead.org
> > Subject: Re: [PATCH v3] clk: bcm2835: Round UART input clock up
> > Message-Id: <20220823230842.AB8BAC433C1@smtp.kernel.org>
> >
> > Quoting Ivan T. Ivanov (2022-05-27 03:29:00)
> > > It was reported that RPi3[1] and RPi Zero 2W boards have issues with
> > > the Bluetooth. It turns out that when switching from initial to
> > > operation speed host and device no longer can talk each other because
> > > host uses incorrect UART baud rate.
> > >
> > > The UART driver used in this case is amba-pl011. Original fix, see
> > > below Github link[2], was inside pl011 module, but somehow it didn't
> > > look as the right place to fix. Beside that this original rounding
> > > function is not exactly perfect for all possible clock values. So I
> > > deiced to move the hack to the platform which actually need it.
> > >
> > > The UART clock is initialised to be as close to the requested
> > > frequency as possible without exceeding it. Now that there is a
> > > clock manager that returns the actual frequencies, an expected
> > > 48MHz clock is reported as 47999625. If the requested baud rate
> > > == requested clock/16, there is no headroom and the slight
> > > reduction in actual clock rate results in failure.
> > >
> > > If increasing a clock by less than 0.1% changes it from ..999..
> > > to ..000.., round it up.
> > >
> > > [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> > > [2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> > >
> > > Cc: Phil Elwell <phil@raspberrypi.org>
> > > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> > > ---
> >
> > This is waiting for someone like Stefan to review. It's customary to
> > include previous reviewers on new versions of patches.
>
> Thanks for fixing me mistake.

If I am going to be mentioned in the commit (and I'm not bothered
either way), I would prefer it to be as phil@raspberrypi.com - the
.org address will expire at some point.

Thanks,

Phil
