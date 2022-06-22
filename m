Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF95554B75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355647AbiFVNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356463AbiFVNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:38:40 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764F6579;
        Wed, 22 Jun 2022 06:38:39 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31780ad7535so136828197b3.8;
        Wed, 22 Jun 2022 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWQHo4/Ll0U0MjHnO1yt+1E/OpL+I/MzfVL3cp/Dgl4=;
        b=bZ8egskKF1xMps8RZY/NhbRj+jYJx5az6SEnJkGDk+gBDfNbKROyAiI5fV/u2v6GHK
         SGUa2Rv+jwJ2qTaVeS2dxpfzGmL+TI0mxFqhCLCilo2Wv5aiiTlJ0rtvSHf9OfvKWren
         UyXXEu+hJCxHKBWeI0bv5sDM+A15578MhdXvFEPzbkXiKuYi0MS4MnUneylB2S1wWS/1
         sj3d2LJmINdGvyTA+zKjGEpuEg9NfBBkiu6u/enxFe5jwBemwp++bF5Gd4VVFncqKA1s
         Xd4l8q7i8VdMm4P/WK5XynBxrc71WUJGbtWAgk0P1Xl0UfSlYmqD2Y+UJm95dK+Q6q91
         RLPw==
X-Gm-Message-State: AJIora8yw0HDa58CGmtUKRHKLGBWvsiNLUgunE7sM2KtT9kQrcOiTy74
        p6WKfdkhjExEQwwO52FyDPSywI4/u0flPO+F4uU=
X-Google-Smtp-Source: AGRyM1vk7tKbl15XHzt37qDEAfj9o5qy9tpX7zdLtm/RWDK0PLTgSAq3saIwSXfd1oxViFMM8knkflnaLNY2oHXWeGg=
X-Received: by 2002:a81:68d7:0:b0:318:11df:a40d with SMTP id
 d206-20020a8168d7000000b0031811dfa40dmr4453973ywc.196.1655905118755; Wed, 22
 Jun 2022 06:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <bccae278-e735-4681-cb3a-41359e42032b@zhaoxin.com>
In-Reply-To: <bccae278-e735-4681-cb3a-41359e42032b@zhaoxin.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 15:38:27 +0200
Message-ID: <CAJZ5v0i78UPYpc9epEOndigxAsj3YVXJJTrQDoX0Dw5p-zpgaQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: Add Zhaoxin ACPI Cx FFH MWAIT support
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LindaChai@zhaoxin.com,
        LeoLiu@zhaoxin.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC linux-acpi@vger.kernel.org on ACPI-related changes (added now).

On Wed, Jun 22, 2022 at 5:29 AM Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:
>
> Recent Zhaoxin CPUs support X86_FEATURE_MWAIT that implies the
> MONITOR/MWAIT instructions can be used for ACPI Cx state. The BIOS
> declares Cx state in _CST object to use FFH on Zhaoxin systems. So
> let function ffh_cstate_init() support Zhaoxin too.
>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>   arch/x86/kernel/acpi/cstate.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7945eae..d4185e1 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -213,7 +213,9 @@ static int __init ffh_cstate_init(void)
>
>         if (c->x86_vendor != X86_VENDOR_INTEL &&
>             c->x86_vendor != X86_VENDOR_AMD &&
> -           c->x86_vendor != X86_VENDOR_HYGON)
> +           c->x86_vendor != X86_VENDOR_HYGON &&
> +           c->x86_vendor != X86_VENDOR_CENTAUR &&
> +           c->x86_vendor != X86_VENDOR_ZHAOXIN)

Centaur is not mentioned in the changelog and it should be.

>                 return -1;
>
>         cpu_cstate_entry = alloc_percpu(struct cstate_entry);
> --
