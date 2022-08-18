Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A98598211
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiHRLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbiHRLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:13:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A7DEBB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:13:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so2576596ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=w+4+2WtxvO1cqI4byafyu81xZCbJaUxCOsxyNdwBfJI=;
        b=ObRzc2BAQc6+LGmzsb5py6+CSBSMikoI60uVFFy62jeF+aDW4APgEMWqYHsm7W5OP5
         2Z7c9h5e24WRMP68wi6PFroY7Q3m7Wtc3l5ZZCy8xLko9Vwyp5xzoFRUJkuDgQVPp+E3
         4YAtzSn44vk8sAdb1OXUoAjOqHf/wX7bWysuruUsigstR4S4U7H1A2761PZAKGJxkKE7
         kwg9LFXUHMmx/y9rB0wQEdHRPq6b3KxLbxEmslolKyQckRD3WL2U8gbMuiYc8zil9fCk
         2HXLEuH0YTozklKWAUoF2e5ng2cDru7fVp+1BBN0aSYvwIdKoNSqcc6w5+3iF7d2B8iL
         YTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=w+4+2WtxvO1cqI4byafyu81xZCbJaUxCOsxyNdwBfJI=;
        b=fx2SJa+VPASaTzOOOXUORhW4wGQ8/6JajsXwamAEhlJhgXqmTMmLpsLAV5SamCZPES
         dk+BwIyBlOdOCYdtbQRJxJfr84SRzP3v24/BLry0fQwuDsFfPuowm8H4JbkNATT0D5Tx
         lHapToTRC5GJP1xTk9F8iCAzfMJGyeT92qSm/34xc0jtbI5KjImSH7ejuH86yKwoDsW1
         x9D0OlJuxwLTT1QojRxDjExNpGsKxIIuy4v62qyGVUYa578Gycl2q6X/OdTretE+PKMm
         AB2rS01Xwtsw3ToFYrr0D0B5uEA9oB46U3Gyhwq7xaMy5ASa3VjnCt1cFclVna8SDYvp
         33wA==
X-Gm-Message-State: ACgBeo1drWkmc9H1dJkCdZtECvNAbATMgYgQP4q/19AlPrOS5k06zYai
        Hpim1dd20q5nGDFRbbvZG1klWrYGl6FdVjwJHLONPw==
X-Google-Smtp-Source: AA6agR5zJ/Z0L9Dg2ANnUTeKyjlDNjqAeobhWSyUgHdidQmKPp6qQcplExCAQbfLn2w9QejtrP2j9riElrr6L7TbR8M=
X-Received: by 2002:a17:907:a055:b0:730:a432:99d3 with SMTP id
 gz21-20020a170907a05500b00730a43299d3mr1473227ejc.690.1660821221116; Thu, 18
 Aug 2022 04:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com> <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
In-Reply-To: <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 18 Aug 2022 13:13:30 +0200
Message-ID: <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:48 AM Arnd Bergmann <arnd@arndb.de> wrote:

> As I understood, the problem that Christophe ran into is that the
> dynamic registration of additional gpio chips is broken because
> it unregisters the chip if the number space is exhausted:
>
>                 base = gpiochip_find_base(gc->ngpio);
>                 if (base < 0) {
>                         ret = base;
>                         spin_unlock_irqrestore(&gpio_lock, flags);
>                         goto err_free_label;
>                 }
>
> From the git history, it looks like this error was never handled gracefully
> even if the intention was to keep going without a number assignment,
> so there are probably other bugs one runs into after changing this.

Hm that should be possible to get rid of altogether? I suppose it is only
there to satisfy

static inline bool gpio_is_valid(int number)
{
        return number >= 0 && number < ARCH_NR_GPIOS;
}

?

If using GPIO descriptors, any descriptor != NULL is valid,
this one is just used with legacy GPIOs. Maybe we should just
delete gpio_is_valid() everywhere and then drop the cap?

I think there may be systems and users that still depend on GPIO base
numbers being assigned from ARCH_NR_GPIOS and
downwards (userspace GPIO numbers in sysfs will also change...)
otherwise we could assign from 0 and up.

Right now the safest would be:
Assign from 512 and downwards until we hit 0 then assign
from something high, like U32_MAX and downward.

That requires dropping gpio_is_valid() everywhere.

If we wanna be bold, just delete gpio_is_valid() and assign
bases from 0 and see what happens. But I think that will
lead to regressions.

Yours,
Linus Walleij
