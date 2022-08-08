Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEBB58CAAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiHHOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiHHOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:41:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254D2673
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:41:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u12so6654649qtk.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mIzohpbiUmJX9nGPYgN9+exYHlIDv5oNe6ODo+LqlJA=;
        b=RxZkUXxlbEvCaMa/oNaFKJD8uphAMDk2F6ttIF+7T5xv1klYfAcFE58UibDZRPgkoW
         if6iJozliiSK9S+8GHqS5kypgVGFJ1vwbz15lFIjVFqSMdK59whtwBKfQYuVAnC+fCtX
         BlJqehIxWjFSUJq9l4+08v50/qvdX36xn4qj5pxPBS3zJIf1AL5PXsR0uEeLwWvnAY9g
         4KWVkY7qHFVmvHzK1aBHficRzbGDm+RPOUOsoWxRf/tGEBr2H7uHfL51b2Sazypxu5fo
         A+ifH2HVzQQodKbYDvduf7SKlY+qkx/X3VCxPp+nrXYeZr9zktSzq9n2WAruz6sieXiq
         +pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mIzohpbiUmJX9nGPYgN9+exYHlIDv5oNe6ODo+LqlJA=;
        b=OG/XqPtVFWjrITCzZfiGZCqj6ufXxeFGvrliN4+6Gp0sSsE/eVQZhFJqtF7mKu5o5I
         RPT8Y/dtcnckM3PvfJclP26JnoKrm7xROrTmifNX0RiKzHtVtaGh7A8gUW74OUZIFTNj
         VH0wKIARpahwE5+tz22/7T6lFahH4KQWMKyNyxohUQ1fLxfzG/nXPermUxdgYUH29mj2
         oKLaGNtN/xyZvrZP7dpxEVUesZWdGqhse54v39gFHR7N8oTxXikHEj4yWd1cJWWvLUJP
         SKO8wz4IIlUZs0S7oYd5E9mBlw2pzOuY7vuISrWsKDAxcNME9u/6hrrHW2rkufwFJUN8
         suBg==
X-Gm-Message-State: ACgBeo0FvOkREMJnFH0JdpDDq9CTRuZbQgO7X3YcU8F/QHM+71DcxjEB
        PP2cH7wlTvJWw+itakuQN7zilsTi7QljMp+9X2I6Z/iDshY=
X-Google-Smtp-Source: AA6agR7hId4a/vfUJiRNX5YqLe4MF1peOiYTF0AuRNnOrdzLE3OOCxjGT3HaD1D2BluzPv8B2O3UMWcUzXDr/gP8uLA=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr16335757qta.429.1659969662433; Mon, 08
 Aug 2022 07:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-5-andriy.shevchenko@linux.intel.com> <YvENHSRQuwAzfQJW@sirena.org.uk>
In-Reply-To: <YvENHSRQuwAzfQJW@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 16:40:26 +0200
Message-ID: <CAHp75VeA8tA-m_gHu5iuhriSfm_qo1PRnUWe7kQ68CCm+UCgHA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can talk
 to IO port
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Mon, Aug 8, 2022 at 3:31 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 05, 2022 at 11:53:21PM +0300, Andy Shevchenko wrote:
>
> > Currently regmap MMIO is inconsistent with IO accessors. I.e.
> > the Big Endian counterparts are using ioreadXXbe() / iowriteXXbe()
> > which are not clean implementations of readXXbe(). Besides that
> > some users may use regmap MMIO for IO ports, and this can be done
> > by assigning ioreadXX()/iowriteXX() and their Big Endian counterparts
> > to the regmap context.
>
> Have you validated that nothing is relying on whatever the problem is
> with using the io versions?

I have cross-checked 1) the architectures that are BE and have IO port
capability, and 2) the drivers that are using regmap MMIO with a
big-endian setting. I found no driver is mapping IO ports and uses
regmap MMIO at the same time. The architecture wise the x86 and ia64
are not in question, I think. And alpha is more academical nowadays.
Did I miss anything?

That said, I'm 99.999% sure there is no problem with that.

...

> > That said, reimplement current Big Endian MMIO accessors by replacing
> > ioread()/iowrite() with respective read()/write() and swab() calls.
> > While at it, add IO port support with a corresponding flag added.
>
> This should be a separate patch.

OK! Then we remove some code and (re-)add it later. Do we need this churn?
Another way is to add IO port accessors and then fix the MMIO.

...

> > +                     if (config->io_port) {
> > +                             ctx->reg_read = regmap_mmio_ioread8;
> > +                             ctx->reg_write = regmap_mmio_iowrite8;
> > +                     } else if (config->use_relaxed_mmio) {
>
> If these options are mutually exclusive we should validate that they are
> not simultaneously set.

Yes, the validation is missed. I will add it.

-- 
With Best Regards,
Andy Shevchenko
