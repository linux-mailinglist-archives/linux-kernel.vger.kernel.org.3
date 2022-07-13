Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80E573D45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiGMThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiGMThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:37:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280762B1AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:37:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t1so5900487ejd.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HoAbDIhN0wIvuBzIf7PXjfvUQchgB2xoehfek+ArK5Q=;
        b=Tlb8RLYE4eUtO3febqnZ3zs/xCAod6r+5u7XYX7K2st0NgU18fCImdG+9sO63aYPGA
         6/mDqerxkiMl9azFBWP8UVQmsxvzHu4Oy+RYuI1N8tYvZ4kNa/itnwE+60YnKDLuWp9E
         2lFLqb6uQwjJG29KsTfqJvqtE+QYMzxxaAHmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoAbDIhN0wIvuBzIf7PXjfvUQchgB2xoehfek+ArK5Q=;
        b=zY6gtA4nR/0tG7P4whpnpmJXtucP54yyxzvuKsPZBabjCPRXiqo3jT6IQPf14q2L3V
         Fgd+Nd3W8bc8YeEDqkak6hoHqMrsnEr4Olx7Vyqc+BKZcbDz1fA/VdOqO9NswJ39J9oW
         fQV86qcuKwOmhVmqMTIjRQrzYPcw1zjgsAt6GrtxloCT78mI22doSC0zv4N0PRbZFnzx
         kjBXolIgSQ4UxAxWCS96e0N/3BQpW79dtTtprrLDZKOymNLgRgqRDjYGoia7VCUKL6mk
         zjDvbkx9YItvXIy0dgRnoyeOx8g2Bj/KP7mHs5hSHJZrQOwiSrRT4axWjQ4uL12i8RL/
         OghA==
X-Gm-Message-State: AJIora9kBylvVvlzQwYdJJ6FP3toL0jiSTUKV8CrvHkeagnmCtdyKcjU
        9jnIbMeInzHpN5L4X1pg2W0n4FOB4T+GLnZzQik=
X-Google-Smtp-Source: AGRyM1tdS2PQjkZq0awfZ8kLylr1dEqo9Z/9XRxqP2kt/gAUfSpb/Y1twU5VQGEc/xaZW9jXETEyKQ==
X-Received: by 2002:a17:907:3f02:b0:6f3:5c42:321a with SMTP id hq2-20020a1709073f0200b006f35c42321amr4950179ejc.521.1657741029486;
        Wed, 13 Jul 2022 12:37:09 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b00704fa2748ffsm5356939ejh.99.2022.07.13.12.37.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 12:37:07 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id o4so16918179wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:37:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr4621239wrb.442.1657741026295; Wed, 13
 Jul 2022 12:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
In-Reply-To: <20220713050724.GA2471738@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 12:36:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Message-ID: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Same problems as every week.
>
> Building powerpc:allmodconfig ... failed

Ok, this has been going on since -rc1, which is much too long.

From your patch submission that that was rejected:

> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> 64-bit outline-only KASAN support") which adds support for KASAN. This
> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> compiled which lack the selection of hard-float.

And considering that neither the ppc people nor the drm people seem
interested in fixing this, and it doesn't revert cleanly I think the
sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
entirely.

IOW, does something like this (obviously nor a proper patch, but you
get the idea) fix the ppc build for you?

  @@ -6,7 +6,7 @@ config DRM_AMD_DC
          bool "AMD DC - Enable new display engine"
          default y
          select SND_HDA_COMPONENT if SND_HDA_CORE
  -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
!(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
  +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS)
          help
            Choose this option if you want to use the new display engine
            support for AMDGPU. This adds required support for Vega and

> OF: amba_device_add() failed (-19) for /amba/smc@10100000
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> refcount_t: underflow; use-after-free.

This too has been going on since -rc1, but it's not obvious what caused it.

At a guess, looking around the amba changes, I'm assuming it's

  7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")

Does reverting that commit make it go away?

                    Linus
