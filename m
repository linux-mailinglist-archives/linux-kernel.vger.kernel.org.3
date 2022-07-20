Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383357BAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiGTPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiGTPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:47:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE943307
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:47:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x91so24329835ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayP9OITtlZ1Sfv3DXFuDs6ga9EFZSP50v8E/pG2VTJc=;
        b=E9knl/VlfLTd2IbwDY32bAF+kgg3HA1KulcjPuas6rjhQy8DGJI7SZFw8Y4aNspZyN
         FNEHKR4YQEoBTy3i4+CG4OK+xUgZpCEH2RdO9xz9wyk4SSbIyVbd3+A2TUZ/9udXN9Zu
         gBwtsWvPAXR+W0/RfJ8eB3ttcy6ObVFy4UQ71HaO6NbLlsAurfPQgnmw+IGQGx9ovhoL
         53g/WitqT3e4lxeBqNuRYc2yE1isAf3SpiGceM5pkLLFzggEfFCzz2zufW+l5B5Y3cCQ
         8Lh2jPy+PCxNK/5n2n+xpqi/pGFV4h08Cxy+PA6u/mi4Pi0Eq6mr9VFssAkJg2H6xnHa
         KXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayP9OITtlZ1Sfv3DXFuDs6ga9EFZSP50v8E/pG2VTJc=;
        b=4gOJLLY0lLIpROYeO2cuSq2zGMSPCM3g4314CLtlxobc+lMA1OaBw5OSpiNacgBjk2
         hsqUti7UylulSptmsFZHW4Hx5NoqCG+UuPgxCoRtn3e0b6Q0pf5dw8T1bHeAz3ppCacx
         G0uaAjtX9doX4JcHfz1xNJ/AOe4xHVN56JOPlicV6CDqjrCC2Q18iiXT0oSXg0NCvX8u
         X28yt8XCrd9oQv/HyFkBERLapt3uuCSFQsBA+CV8uW2nmdE4K42fdPILOymcfNCLTtWl
         dI7fYzNrHMhCpKoefi9U2vx8lmbyvczVOZLrOSaohBmr0Fdhdm2vLTc8y0jyd/vE/FrV
         g9QA==
X-Gm-Message-State: AJIora/vWj3ChYWCm/1+pfkFasu45fF1CLqCWuNd/DMbW4/ZJYHiUPwv
        JGDF+VHbk/bqh18VFw8KYlyVs3Za5xbmWgWv6dVoeg==
X-Google-Smtp-Source: AGRyM1sAFrAYciyv+PMKNN2ctXQA73XSZ1h6i4SOsSame6eLarenMzNhZX0BAVBl1GQpEDOUqEpy5wkeUBkrD4iONcU=
X-Received: by 2002:aa7:d8d4:0:b0:43b:bc29:de65 with SMTP id
 k20-20020aa7d8d4000000b0043bbc29de65mr2114508eds.82.1658332066375; Wed, 20
 Jul 2022 08:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658324498.git.william.gray@linaro.org>
In-Reply-To: <cover.1658324498.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 20 Jul 2022 17:47:35 +0200
Message-ID: <CAMRc=MfSap-FNM0zXEcRBD6KJRTE-yqYnjJ+X_MuKuKma=FSFQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/6] gpio: Implement and utilize register
 structures for ISA drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 3:46 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Rebased onto the gpio/for-next branch.
>
> Changes in v4:
>  - Cleanup superfluous header includes from drivers
>  - Add note to CONFIG_GPIO_I8255 Kconfig that if built as a module the
>    name will be 'gpio-i8255'
>  - Remove 'const' from '__iomem' pointers
>  - Replace ambiguous 'group' terminology with more understandable 'bank'
>  - Use more natural '>= 4' expression to represent upper nibble
>  - Refactor i8255_set_port() to take more common pattern of mask and
>    bits
>
> The PC104/ISA drivers were updated to use I/O memory accessor calls such
> as ioread8()/iowrite8() in a previous patch series [0]. This
> patchset is a continuation of the effort to improve the code readability
> and reduce magic numbers by implementing and utilizing named register
> data structures.
>
> One of the benefits is that we can now observe more easily similarities
> in devices that share similar interfaces; such as the i8255 interfaces
> used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
> the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers.
>
> A new module supporting the Intel 8255 interface is introduced to
> consolidate the common code found among the 104-DIO-48E, 104-IDI-48, and
> GPIO-MM drivers.
>
> [0] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/
>

Series applied, thanks!

Bart
