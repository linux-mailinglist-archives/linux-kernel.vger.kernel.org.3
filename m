Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D417F50FB23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbiDZKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349365AbiDZKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:38:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC49E63;
        Tue, 26 Apr 2022 03:25:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so11775161ejb.8;
        Tue, 26 Apr 2022 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3GiU4VgA4X0FVG9Q0HUFWR78xcN+9K+AQZgrStd20Q=;
        b=CqFomzrJcPjoOLCpk2zbMHsv8s4gpt3ktEOcbqKM6d/FBoOtD162g1SitcHKd5PByk
         suRxgZLOxEcLtTnne2ZL5e33i5js7iU4Usk44bOXl9eMekMOjP4BBExt+1l94b+4ZW1x
         3KbOzjNgjZHgZk9PIe8VNP4PcKpVxPsMiCv9L7rNy9JCscKBN7X7YgF3t4VDA4abwdTH
         wJMBKu5z5Swresr5lB1ZQTWORt1kt5ewc+QqNpXpMnEuZ5OY2BWsL2UfeB9h/oHySeAe
         9VM8P6oOc/aSpYDNuFbu5UHHt0oFmrU6l5Rpe+LsVYVIAgKMvTxlt9BzjZ4G2j66QbCA
         8now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3GiU4VgA4X0FVG9Q0HUFWR78xcN+9K+AQZgrStd20Q=;
        b=HlIwJNlqNsjAOvbvQw9L/jYZIAiu8MGiN9cYvvHm8tgouiiLq9DPB/pyMLmBHNQtkJ
         F2dvtrQ7aYypFxgv/aCJCyx2R46yhqoKG93wMY93gi2fovbvJEz4oGkpYMRFTTJU2BlW
         mvNjD4H6BKh4JBoqAYGJOyTKXrLwvZL317mxKMFk5Qav1ggWeBWU8SX01dCRF/on6uBM
         fdbP4LpzP3J1o4QJt9QBxNIApaEwgzsqH6na1RyjBE6MOikOkqzzpflfiZPYD1HfeOzh
         zUbGiDc3pnD7h1aRr7kLWjt7WPwVrRQ5oPV3+6/9PEum7F8enNvCUU30GCWwwOJqcoND
         HjYQ==
X-Gm-Message-State: AOAM530ZhnhU28zeGXHYQDoi5N85MnWw6/3OxQE/ggf++og7yo84f5m6
        jDMJb7C6vP0C1BeUQ16/z9CxRvEoWrFawtE9p2g=
X-Google-Smtp-Source: ABdhPJz8BmGLAmH9fEGi0KuLOTUtQRadgcrFFvw87vyemx36ybgw9064Ch2gGNh59MOiJlvtRR/goPKKu8WsaV94ZpM=
X-Received: by 2002:a17:907:7d8c:b0:6f2:476d:fde4 with SMTP id
 oz12-20020a1709077d8c00b006f2476dfde4mr19555140ejc.497.1650968710844; Tue, 26
 Apr 2022 03:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141846.598305-1-maz@kernel.org> <CACRpkda3L_itpqcnPq6xDoJtNHt8NuvE1MZk1bCNR+u2KKUpBA@mail.gmail.com>
 <874k2kccse.wl-maz@kernel.org>
In-Reply-To: <874k2kccse.wl-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:24:31 +0200
Message-ID: <CAHp75VcKNurETpNtrZM7SN2XEtLM6ZYFrS-gKr6r55Lc37gKQQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 12:30 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 22 Apr 2022 22:24:22 +0100,
> Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Tue, Apr 19, 2022 at 4:19 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > > This is a followup from [2].
> > >
> > > I recently realised that the gpiolib play ugly tricks on the
> > > unsuspecting irq_chip structures by patching the callbacks.
> > >
> > > Not only this breaks when an irq_chip structure is made const (which
> > > really should be the default case), but it also forces this structure
> > > to be copied at nauseam for each instance of the GPIO block, which is
> > > a waste of memory.
> > >
> > > My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
> > > which does what it says on the tin: don't you dare writing to them.
> > > Gpiolib is further updated not to install its own callbacks, and it
> > > becomes the responsibility of the driver to call into the gpiolib when
> > > required. This is similar to what we do for other subsystems such as
> > > PCI-MSI.
> > >
> > > 5 drivers are updated to this new model: M1, QC, Tegra, pl061 and AMD
> > > (as I actively use them) keeping a single irq_chip structure, marking
> > > it const, and exposing the new flag.
> > >
> > > Nothing breaks, the volume of change is small, the memory usage goes
> > > down and we have fewer callbacks that can be used as attack vectors.
> > > What's not to love?
> > >
> > > Since there wasn't any objection in the previous round of review, I'm
> > > going to take this series into -next to see if anything breaks at
> > > scale.
> >
> > The series:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Bartosz: if you're happy with this can you apply it to an immutable branch
> > from v5.18-rc1 and merge that into the GPIO for-next and then I can also
> > pull that into pinctrl?
>
> For what it is worth, I've pushed this branch into irqchip-next.
>
> You can pick it up from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gpio-immutable
>
> but I can also drop it from the irqchip tree.
>
> Just let me know.

I would prefer it if it goes as is now and every stakeholder can just
pull it. As far as my drivers are concerned I also want to convert
them sooner than later, meaning I want to pull this into my little
tree as well. Bart, Linus, would it be also preferable for you?


-- 
With Best Regards,
Andy Shevchenko
