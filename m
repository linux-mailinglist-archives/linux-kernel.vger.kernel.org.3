Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1A53D89D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbiFDVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiFDVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:25:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCCA1B9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 14:25:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so2275737ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJxJdrXsAlevZ6Hhiwi7jR0T9GEMmV4ic+Z8SgmWMA0=;
        b=cISCrhjSRz3qYBG22x8Zqp7UFanpp9Iq+pVaqyGoatF1dKG9I/kJRajz+Hu/fBumZm
         vAm8Vn7DID282FhV1b33GM1q1+skBynh4nTZpZx4MsNSVlGDDUcDXii9YcQzXCZklZQv
         6QLQt0vmwX+ihIxvSIZpy/9fO7GpeuhdAlk3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJxJdrXsAlevZ6Hhiwi7jR0T9GEMmV4ic+Z8SgmWMA0=;
        b=QjCwu/W6+40glQi+uVcU3HzFjlFjo8HvSicnc+L7VmR6JR3E4MowiwrvSrDGFMAivt
         eWuw7Sd481krkCXlYmbylmykoac96niaSLEQADzqAf9ovowueC6VcKxR4ewvFYugSqU8
         kx+6SKib0of5P+Y9I3j0R16tZQFeT3COicHmekfUSX8NCUFOvtAV0CCxv0Y36eo5NiUp
         DE09Du6tcmbAiDRSXuU4uQ2I+X1kAuGv1BwZY58DOyq9vTSufvu0pSo1oKM055PllPq5
         UpIlvnmf5U7FMncDKAfEMja9E9OyXFVnrdbqxFrIgmvO83HhO2EByH0m1UfNyoaj65aX
         X31w==
X-Gm-Message-State: AOAM532G7u1L9z8GqbR98I7GtbFDkVEzVRLktU8xKwH3JRETF5ibcjlt
        H8fsZB2qhIj1xD5X4wVRB1OQ8IXf2WVPEvUw
X-Google-Smtp-Source: ABdhPJyY3uC8vbG7snMBX3ThwtmoehgHW78D5UiFraRQ/q6DLWFzIzXQNnVOJ0e92BzOynIceQCxaw==
X-Received: by 2002:a17:907:97c7:b0:6fe:f7eb:be67 with SMTP id js7-20020a17090797c700b006fef7ebbe67mr15096282ejc.559.1654377909514;
        Sat, 04 Jun 2022 14:25:09 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id h10-20020aa7de0a000000b0042dd1584e74sm5833991edv.90.2022.06.04.14.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 14:25:09 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id m26so3322059wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 14:25:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr14025902wrz.281.1654377908538; Sat, 04
 Jun 2022 14:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <Yppk/mN+KYTDkvz3@yury-laptop>
In-Reply-To: <Yppk/mN+KYTDkvz3@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Jun 2022 14:24:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibRs6NXp1JXA58+cHcgQNDiAtdOTR7kieG5P=NOtWRGA@mail.gmail.com>
Message-ID: <CAHk-=wibRs6NXp1JXA58+cHcgQNDiAtdOTR7kieG5P=NOtWRGA@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v5.19-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 12:48 PM Yury Norov <yury.norov@gmail.com> wrote:
>
>       arch/ia64: replace cpumask_weight with cpumask_empty where appropriate

As you can tell from the pr-tracker-bot reply, I've pulled this.

But I did want to point out that this patch should probably have gone further.

That first argument to per_cpu_scan_finalize() is kind of ugly, but it
should probably have been something like

    n = cpumask_weight(&early_cpu_possible_map) ? : 32;

instead of doing *both* cpumask_weight() and cpumask_empty().

The only case cpumask_empty() can be optimized if it's not entirely
empty, but that's the also the case where that code then ends up
calling cpumask_weight() to get the final result.

Note: I don't really care. This is ia64 boot-time setup code, so it's
not like performance matters. It's dead and irrelevant. I just reacted
to "that patch tries to micro-optimize the code, but is missing the
forest for the trees".

                     Linus
