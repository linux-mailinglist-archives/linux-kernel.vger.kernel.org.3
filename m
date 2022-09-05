Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67E5AD41F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIENiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbiIENiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:38:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC904D811;
        Mon,  5 Sep 2022 06:37:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i9so358287qka.0;
        Mon, 05 Sep 2022 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y+KBK6xhZs559H3MgneEVbpSntlTH5gyHXvs8az7EvI=;
        b=I+FYPiMu0YegkQdnnyoV9RHVpH5IFzPD8tdowmtGi6qcwtGpOJc9BAHZMbWFb0LE/p
         mEhQZWj6ITZBPDnLYJMfv4ouclOrF1OhwhWvUr9YxvXsB4CMpPhPxM5muqGTkdePbjeL
         6gzTB4ZE6xLdK+DpXtGYM+08x6WeGMdc2H5ivtbPZFvcOaNIQ/q+TSgBgyujEbhI7Omy
         SBzagyWkvKfrieBF5m1gBncPrDQcBSwBVUVnMLijiIf4PdKn3wVWuYFWSUvJtJhkPjE1
         y4NUaDr5FggZ/Z93kPZ8D+LrsIO75QcGpbWBqMgFHkuGBoVpq4PXY5cWsWP6kvSL7XId
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y+KBK6xhZs559H3MgneEVbpSntlTH5gyHXvs8az7EvI=;
        b=YB+K9dEZQwX+HOiKbf9biNvFo8g6Yl3jWeHWSVgtePmXzBeQu3FhVQesoJuo9V8USr
         RVw664ocsBh1Zsr0o+elRIBKy7exvZsqmpFbxyuB0C9z/prRsUe/IdWC/HqFhQl9YBLl
         wKYtldz2wcxuB9IU7xIBDqt6woQOLktnx5tN0B5TkrqDGcm6SwsRRlv8HYMfzFeD95Q8
         oJoMS7/E1jHkNp9Mse836lIVWOn4J7n/6cDROFBqhgYheGanhYHExO5NQ5SIVZAHKS2i
         3A8MFzsPUdQvYDa4/zeBcAmidAOGp7OrOuQltfsf37KizsrN/7MilPmX5oreN6JRkjjn
         mmaw==
X-Gm-Message-State: ACgBeo1d1JBijYnV8mcTBb6V32PtESwlvgUiqO7TFDzdBEEg0ApXf9vh
        GkstTNG6d9fBwFNep4InfYDFmCyM1lCXtHWn0RJ92A/eShw=
X-Google-Smtp-Source: AA6agR6q36mc5BlhueksftcZiElaRMf1LqXvGugwSjBcFVdztilDasrj9TjqrJ0/D323fTBWLhNZZXiESljkQyZM9VM=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr33278028qkp.504.1662385073762; Mon, 05
 Sep 2022 06:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
 <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
 <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
 <YxXyTCSKzL42PF1D@smile.fi.intel.com> <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
In-Reply-To: <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 16:37:17 +0300
Message-ID: <CAHp75VcbucZ_3+bvJCsLk78D6egwckN=rMAdttmVwt8H9MfCSw@mail.gmail.com>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Mon, Sep 5, 2022 at 4:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 5, 2022 at 2:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 02, 2022 at 09:42:00PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > It's unclear why many of static registers were marked as volatile.
> > >
> > > the static (yeah, forgot it)
> > >
> > > > They are pretty much bidirectional and static in a sense that
> > > > written value is kept there until a new write or chip reset.
> > > > Drop those registers from the list to allow them to be cached.
> > >
> > > This patch is not correct due to indexing access. It's sneaked since I
> > > forgot I added it into my main repo. The proper approach should be to
> > > create virtual registers and decode them before use. This allows to
> > > cache all ports and as a benefit to debug print all port actual
> > > statuses.
> >
> > To be clear: With this one removed from the bunch the rest can be applied w.o.
> > any change.
>
> I'll give Patrick a day or two to test/review and then I'll just apply
> them all except this one, they are all pretty self-evident

Sure!

> except ACPI
> things which have obviously been tested on hardware

Yes, I have a Galileo Gen 1 board which has been used for testing.

>  so from my
> point of view it's good to merge.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
