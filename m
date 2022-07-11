Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A75703E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiGKNMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:12:01 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34CB32BA0;
        Mon, 11 Jul 2022 06:12:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31bf3656517so47981867b3.12;
        Mon, 11 Jul 2022 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3hw6BXOnJJA/B1/8AwjpeEcbM/baHIGT7ARnD85NyI=;
        b=FTNuNnuyAredYrCdM1vdFkJJ9TPqQx1ss4cqvqqdCFeVHvpnxDoHoC28BnaL48nRu8
         Tc+JdV9RyjJ6v9Z1myqifaTO6D2fF/fDkGoMoOb40Ckwukd2Gg0A/RN+d4ghchQJy5ut
         OwnLWPbPlgAEDdpMi9aruCC369vpKzY1dDauw00hImuvXrJQikU99isR7DvgduL7ZJrP
         eMQ7TL0yNhykAqwsT0mmju2Uzpq/xKU9bLDC1J2i1u6roN5FatUDIoJQSs6YS5u7QZt7
         VzG7zH2ZkDk83YSNaJAhSh3Bpn492Yvpr8OoM1+vdo//zYvISlgSpSvx1fcH/I5cZX8G
         wviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3hw6BXOnJJA/B1/8AwjpeEcbM/baHIGT7ARnD85NyI=;
        b=Wi6360BS29VWvmeLKgJluCKbYyoQ6TCnXi0zJLjsjO9kThxOjsqzg3T9sX0dhLIO6j
         2RBDRCFv/FOa2hk+/fAb8/FUbMSq5WKlvQepHZOOlo9/e4pMH6e6YYI1D59WtHW5nXK0
         NGm2O+ybAroii9UeCaccy6qasRgFmCZTqTdpCx+9LM7ILpOTsU0sjCmU+4WOvUBSY5lZ
         V7u0HoOlP3boLpdN1dumBnFA87ZKFKftnmJfcWvDegHT3JBWa8pSyWA/Y8pltkAPPRmc
         dGn+Pnrw8gk/Tg43XwZNB69lOT5EKwdvBTxifgCyBAbcuj7afhYXKKJdzzJWTBauSn07
         z3Nw==
X-Gm-Message-State: AJIora+YRGPQCm9MiJcr4jDaGFZuawn7P4FD8oVEEpT7vz4326sdTN0v
        +AIX05L+HCbOMiRXwRmWkIOIK23Yv9ry/PE8c8s=
X-Google-Smtp-Source: AGRyM1sgyS2IJO19mUsfBZR68VCEihUvKKYyQDmJj51tYgf9YH5TX1xKQ8I3vt1IfCU6XnO1fK2F1u0IoSv+MhIIjZc=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr18769185ywq.18.1657545119722; Mon, 11
 Jul 2022 06:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220710091708.15967-1-ang.iglesiasg@gmail.com>
 <YssdPch7dVmRWDbB@smile.fi.intel.com> <046a29a5191c53813ce9477000b07c21ca5699fc.camel@gmail.com>
In-Reply-To: <046a29a5191c53813ce9477000b07c21ca5699fc.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:11:23 +0200
Message-ID: <CAHp75VfYVVPuNmukq9Civ2vHu_au5Nj-MPm5JXDHiTaMXpyzUQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: pressure: bmp280: simplify driver
 initialization logic
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Mon, Jul 11, 2022 at 2:46 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> On dom, 2022-07-10 at 21:41 +0300, Andy Shevchenko wrote:

> > It seems you somehow managed to send patches separately from email
> > perspective.
> > Make sure you pass parameter --thread to `git format-patch`, so it will create
> > a proper chain of emails.
>
> How should I proceed to fix this issue? Should I wait for more feedback and send
> a new revision of the patches, now as a proper mail chain? Or should I resend
> current patchset as a chain? I don't want to spam the mailing list more due to
> my inexperience contributing.

Since there are already comments and more might come, wait a few days
and send a new version.

-- 
With Best Regards,
Andy Shevchenko
