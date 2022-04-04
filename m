Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7C4F1DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387024AbiDDVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380133AbiDDS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:59:05 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F09C2C102;
        Mon,  4 Apr 2022 11:57:08 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2eb3db5b172so64775667b3.6;
        Mon, 04 Apr 2022 11:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myPVoCqtsI8E3yDzZq2k0LtGHfhc8/v0BCP25SPN5jA=;
        b=XW0pudLE5S2mdxsLuQTQkMiyisnc41yFjaiOin5vouIvDeAkmE+sxM/qIm+NkNzWxX
         5ItOOhahtGXd4AqNewIZBMd75ZAdkIQBBy9OjUVkgoBecIv0tAJ4+svu9G8eKyE/FwPR
         KWDRe1grbORoPDGxDje7Bnw7ZrrI1yAgzvqRFFesTzUMisKnWCEf7G146QtTCo9PVwfq
         lg1h4uJ5WSFlotdXUQL6uDl/SpAMPvyO1jEdhglJcQ7xDo7pyP8LF8GdgoPDWxJ1KtUK
         EabcANBEkblQnUSsnHWOdiEfTIUcVA1N1wN5lgECe9L8fwuL5XHFMiFIjxnUbAnDO1LC
         zCAQ==
X-Gm-Message-State: AOAM532/rsRWx7nxoUuWlFmVZcLQTM27o40Mh0p/2tT0SI6O4O+wq1EW
        7qrV4m3elf1NqqRJQfqWHwNmeUfuiI8nffLxi7w+vQvlOWU=
X-Google-Smtp-Source: ABdhPJxLubOyIWPyzSiezqjgyNhGaeZMpXGj7I20PJkJS25VOxo/KAE7xiWFmyDpQxZxhz+RUsNJ1xt77HyGjplGRW0=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr1309564ywb.326.1649098627877; Mon, 04
 Apr 2022 11:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220403062322.3168-1-akihiko.odaki@gmail.com>
 <CAJZ5v0gaRr-r8VFCEGSP1nTX0CwrOi35DXZB5Z8A9tiLufNxPg@mail.gmail.com> <4d6307d0-cd67-dfb2-6d6d-2f37bf4a271b@gmail.com>
In-Reply-To: <4d6307d0-cd67-dfb2-6d6d-2f37bf4a271b@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Apr 2022 20:56:56 +0200
Message-ID: <CAJZ5v0gu4VsC7P6276p=S3ZyOg-BWP_dG6rzou2GDYA4TTMsSw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: processor: idle: Only flush cache on
 entering C3"
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Mon, Apr 4, 2022 at 8:25 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>
> On 2022/04/05 3:13, Rafael J. Wysocki wrote:
> > On Sun, Apr 3, 2022 at 8:25 AM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
> >>
> >> This reverts commit 87ebbb8c612b1214f227ebb8f25442c6d163e802.
> >>
> >> ACPI processor power states can be transitioned in two distinct
> >> situations: 1. when CPU goes idle and 2. before CPU goes offline
> >> ("playing dead") to suspend or hibernate. Case 1 is handled by
> >> acpi_idle_enter or acpi_idle_enter_s2idle. Case 2 is handled by
> >> acpi_idle_play_dead.
> >>
> >> It is necessary to flush CPU caches in case 2 even if it is not
> >> required to transit ACPI processor power states as CPU will go
> >> offline soon. However, the reverted commit incorrectly removed CPU
> >> cache flushing in such a condition.
> >
> > I think what you mean is that the CPU cache must always be flushed in
> > acpi_idle_play_dead(), regardless of the target C-state that is going
> > to be requested, because this is likely to be part of a CPU offline
> > procedure or preparation for entering a system-wide sleep state and
> > the stale cache contents may lead to problems going forward, for
> > example when the CPU is taken back online.
> >
> > If so, I will put the above information into the patch changelog.
>
> I guess it is causing problems because the dirty caches will not get
> written back and the RAM becomes stale if they are not flushed. From my
> understanding, the CPU should have an empty cache and read back contents
> from RAM when it is taken back online.

OK, please see if the changelog I've added to the patch is looking good:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=dfbba2518aac4204203b0697a894d3b2f80134d3
