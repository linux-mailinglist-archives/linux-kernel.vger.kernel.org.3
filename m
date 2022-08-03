Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101758855B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiHCBWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiHCBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:22:33 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB42558ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:22:27 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r12so6464094uaf.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ITpkVFpZTEOr7H3hLAH+IjHKqxmma2AE7dBVpPoRYGA=;
        b=HpG5WSCwsGRjjqu54sW2P1QDucvfmK8QVIxvPRNgVla6hDbVoYWpuV+imCirfFsDeT
         rc4ufWqtdcYeBXNURHnW80vIBfqnK4D9XDPzA9gKynFUSA3DNFGdffREjwN0yZ2U6NpW
         /ZXfWEKixLko8eyAOclnafMUncDdpY+FUGb8axnj8chhOA+PuHvo7JS47ffLRbXq49/c
         sJcZc3pCNT9wsgrpZDXFd/JT2mA9rztItR6Cycu+timeyZKyloRe6Z2Qtgdy9BM2jLuZ
         FqPe/9DFGQ3dRWTKU3Y5ttwmM/5vGyOpeOhKt7Pnyi1xffnSiLpsmO/xrqO8n8b42T6Y
         YU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ITpkVFpZTEOr7H3hLAH+IjHKqxmma2AE7dBVpPoRYGA=;
        b=RVYhjVpiC7Jcu2cV/a/jEbdFvmbkkiyfRLbOlZorkzMKuwj4Hcyi87CcYMZrt1g5Lj
         VVKW3TUBwdoHIa1hZl08sav2Oyn2yFOnxzw8cz1XnhQ5TrClVSh8BN5FrO1e7oxOLzas
         eKyx4imEmsdxoKbKf9i87p7gnZrYhUgWE7oiRql108HMax9tFfgyXBc5k5b4x2A3maWy
         u8luZQXTrS5PHfeIzQWVe9wXzoXgg7pYGWWXai+/EIY94QTccFr8O0RjbLTt535v4kk5
         /OpUigzCK6QxD0BRqwqaW06K4fhQyJ63uGB0VzzljhoHp0523HmqzqRF9298ttzvzF0t
         WxQQ==
X-Gm-Message-State: ACgBeo2P4shgCPbAjWCtPVZ2plPxkUwr/J/YuLRPhv1oj5DOL9UqFzqd
        LzthT17/etTXKJHg6CtBASQ4IFHj4sSK2u2c+dNPkNNZTRA=
X-Google-Smtp-Source: AA6agR7U6JR4xSEchf/0U6jxcPPI1bHZLrUYuyY5z/SmDFQn/pPFn7t3MFc4QqfWSWsgftpTI/0aIwtMIORXWz7g4WQ=
X-Received: by 2002:ab0:7a69:0:b0:384:dc02:a08e with SMTP id
 c9-20020ab07a69000000b00384dc02a08emr9217815uat.4.1659489746713; Tue, 02 Aug
 2022 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214041.2656586-1-neelnatu@google.com>
In-Reply-To: <20220802214041.2656586-1-neelnatu@google.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 2 Aug 2022 18:22:15 -0700
Message-ID: <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
Subject: Re: [PATCH] sched, cpumask: don't leak impossible cpus via for_each_cpu_wrap().
To:     Neel Natu <neelnatu@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 2, 2022 at 2:41 PM Neel Natu <neelnatu@google.com> wrote:
>
> The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
> This in turn can change the set of cpus visited by for_each_cpu_wrap()
> with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).
>
> Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
> over cpus outside the 'cpu_possible_mask'.
>
> Fix this to make its behavior match for_each_cpu() which always limits
> the iteration to the range [0, nr_cpu_ids).
>
> Signed-off-by: Neel Natu <neelnatu@google.com>

The patch itself doesn't look correct because it randomly switches a piece
of cpumask API from nr_cpumask_bits to nr_cpu_ids, and doesn't touch
others.

However...

I don't know the story behind having 2 variables holding the max possible
number of cpus, and it looks like it dates back to prehistoric times.  In
modern kernel, there are 2 cases where nr_cpumask_bits == nr_cpu_ids
for sure: it's CONFIG_CPUMASK_OFFSTACK=y and
CONFIG_HOTPLUG_CPU=y. At least one of those is enabled in defconfig
of every popular architecture.

In case of HOTPLUG is off, I don't understand why we should have nr_cpu_ids
and nr_cpumask_bits different - what case should it cover?... Interestingly, in
comments to cpumask functions and in the code those two are referred
interchangeably.

Even more interestingly, we have a function bitmap_setall() that sets all bits
up to nr_cpumask_bits, and it could trigger the problem that you described,
so that someone would complain. (Are there any other valid reasons to set
bits behind nr_cpu_ids intentionally?)

Can you share more details about how you triggered that? If you observe
those bits set, something else is probably already wrong...

So, if there is no real case in modern kernel to have nr_cpumask_bits and
nr_cpu_ids different, the proper fix would be to just drop the first.

If there is such a case, this is probably your case, and we'd know more
details to understand how to deal with that.

Thanks,
Yury
