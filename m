Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B44F1EED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381361AbiDDWIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379837AbiDDSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:16:00 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8A3EA8F;
        Mon,  4 Apr 2022 11:14:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id j2so19249419ybu.0;
        Mon, 04 Apr 2022 11:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwHSUD6VUk1+NHBKnrS20gEcYVbH13xq7tQUR/JhwtI=;
        b=uxXwz462nDHL9H4S23fQk4nA3pYOvJipgRNUZsONr35hK4E95Q2rW+3X5POPFTvpS8
         k+p6Kgi2UCdEDTNfH/ULwhTZnDlLPXLy0/DvBgl2XzqeSBJxzT1OmF2s/23QyQ3MC9WJ
         E9iEb1pFeH3vW/DpD5RYzcxZpuybdCl+6/TWs3A5YoJRijl7To+t9DvscqnG+7mP2Fmh
         kVC7myK1V6YJmnb/LpNRTZDT2m66UxnuZIm3Ua9FypIPCXoFhRtWj7L5YsZVRv3jgwpb
         9gIPc1vSq53oyx8uUvObKBvUTSsWHYvVWZ2kcOxHKzwZp6PdKP1DRukX1bdJEK2lIb/a
         GTOg==
X-Gm-Message-State: AOAM530lU7IorsfAxetoDgAlO0ZQ/yIkG9NJS0eKzKYINDhWAmOHPSk2
        c8Ufu8yPjaZoxmc2AoU+ywWtKncbfLzvvVegnZmmiC/5IuM=
X-Google-Smtp-Source: ABdhPJx0SLx3DhI+llrFMerwvLB50TYDoOAuIhNbaiF8shFY+nPZtKAy1GbxINWtrFXBVlb54ABU4pOsrncrwgXXNHU=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr929660ybs.365.1649096042539; Mon, 04
 Apr 2022 11:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220403062322.3168-1-akihiko.odaki@gmail.com>
In-Reply-To: <20220403062322.3168-1-akihiko.odaki@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Apr 2022 20:13:51 +0200
Message-ID: <CAJZ5v0gaRr-r8VFCEGSP1nTX0CwrOi35DXZB5Z8A9tiLufNxPg@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: processor: idle: Only flush cache on
 entering C3"
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Sun, Apr 3, 2022 at 8:25 AM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>
> This reverts commit 87ebbb8c612b1214f227ebb8f25442c6d163e802.
>
> ACPI processor power states can be transitioned in two distinct
> situations: 1. when CPU goes idle and 2. before CPU goes offline
> ("playing dead") to suspend or hibernate. Case 1 is handled by
> acpi_idle_enter or acpi_idle_enter_s2idle. Case 2 is handled by
> acpi_idle_play_dead.
>
> It is necessary to flush CPU caches in case 2 even if it is not
> required to transit ACPI processor power states as CPU will go
> offline soon. However, the reverted commit incorrectly removed CPU
> cache flushing in such a condition.

I think what you mean is that the CPU cache must always be flushed in
acpi_idle_play_dead(), regardless of the target C-state that is going
to be requested, because this is likely to be part of a CPU offline
procedure or preparation for entering a system-wide sleep state and
the stale cache contents may lead to problems going forward, for
example when the CPU is taken back online.

If so, I will put the above information into the patch changelog.

> In fact, it made resuming from
> suspend-to-RAM occasionally fail on Lenovo ThinkPad C13 Yoga.

So this probably means that resume from suspend-to-RAM occasionally
fails on Lenovo ThinkPad C13 Yoga and reverting the commit in question
fixes this problem.  Is that correct?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  drivers/acpi/processor_idle.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f8e9fa82cb9b..05b3985a1984 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -570,8 +570,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>  {
>         struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
>
> -       if (cx->type == ACPI_STATE_C3)
> -               ACPI_FLUSH_CPU_CACHE();
> +       ACPI_FLUSH_CPU_CACHE();
>
>         while (1) {
>
> --
> 2.35.1
>
