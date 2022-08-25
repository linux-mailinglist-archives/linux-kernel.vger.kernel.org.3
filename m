Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F865A18D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiHYSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHYSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:36:40 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1668D3D7;
        Thu, 25 Aug 2022 11:36:40 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3378303138bso524005777b3.9;
        Thu, 25 Aug 2022 11:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FCakrSp9UGKvybYoXqF895/oq5ySorkOlezhX9EwPEg=;
        b=rzoikXIHKbLuFtnzwVb1eoKB8qaO45XYq3DOzSJCmEtsk/yU410bicBchD0vkA44Tj
         LTveHuWhipsNtzKcGSIEZFE0Ge+Ehgcmaf5t5SgU6FduM9oomR7ntKLowaS2xJmF9LFm
         ekr7CFQ+kH3JSfKNhQ988kaxW3wARB9bPQH9LkU7OOvHLWz7cg72ExSlJ0NUaoRyfdlY
         wRKdLQ2uzWn3W7pC/7IEdfhyi84W1FUPeGSr250SUnF3uEV+i8YEVoPa2bL3ob15XASe
         om/3oZTk3xcFelBAYeCpsm1+0thy/AFBGzF8EcU5ZCj8QSX4Nleux31LDmjdPbrok/FC
         NbdQ==
X-Gm-Message-State: ACgBeo3KYgBHQ9dZtBBGrOryyxvB1wDfzL7uvic+G82ZYrlLEoq0hXfG
        saLgRg9Uc7sdc4wfLt0iOfgnUW43k01VIOVptsGJGiWNtYY=
X-Google-Smtp-Source: AA6agR7qrjzZCfEQJFCIMTW3ZXCgJ3VMJsEZa4Oh+bMf1Pj5eSvg4ptSzw9hdH66yc2rat7GUhFsSpCCFg5g96uPoNw=
X-Received: by 2002:a25:8d84:0:b0:695:836a:fcaf with SMTP id
 o4-20020a258d84000000b00695836afcafmr4391624ybl.633.1661452599139; Thu, 25
 Aug 2022 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <5607133.DvuYhMxLoT@kreacher> <ecb5a2dd-47b2-e5e1-5254-42bd5d018578@amd.com>
 <CAJZ5v0in-me017RoR8yRMMXmbBofr6u9o2_WMGh38cpiy3cG3w@mail.gmail.com> <54e439c8-7390-be01-66b2-5692af571d1b@amd.com>
In-Reply-To: <54e439c8-7390-be01-66b2-5692af571d1b@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 20:36:28 +0200
Message-ID: <CAJZ5v0g0ZmkbKCxTg3DZZ-BJTuazH3zrfUsJmCun6GAhJywqrw@mail.gmail.com>
Subject: Re: [PATCH v2] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 8:29 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/25/2022 13:26, Rafael J. Wysocki wrote:
> > On Thu, Aug 25, 2022 at 8:17 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 8/25/2022 13:01, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> >>> use low-power S0 idle on the given platform than S3 (provided that
> >>> the latter is supported) and it doesn't preclude using either of
> >>> them (which of them will be used depends on the choices made by user
> >>> space).
> >>>
> >>> For this reason, there is no benefit from checking that flag in
> >>> ahci_update_initial_lpm_policy().
> >>>
> >>> First off, it cannot be a bug to do S3 with policy set to either
> >>> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
> >>> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
> >>> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
> >>> protect the S3-capable systems from failing.
> >>>
> >>> Second, suspend-to-idle can be carried out on a system with
> >>> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> >>> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
> >>> needed to handle that case correctly, it should be done regardless of
> >>> the ACPI_FADT_LOW_POWER_S0 value.
> >>>
> >>> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
> >>> ahci_update_initial_lpm_policy() along with the CONFIG_ACPI #ifdef
> >>> around it that is not necessary any more.
> >>
> >> Looking at the source commit for this behavior:
> >>
> >> b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with SLP_S0")
> >>
> >> It was trying to set a policy tied to when the system is defaulting to
> >> suspend to idle.
> >>
> >> To try to match the spirit of the original request but not tying it to
> >> the FADT, how about using pm_suspend_default_s2idle()?
> >
> > The user can switch to "default S3" later anyway, so this wouldn't
> > help more than the check being dropped.
>
> Right, they could also change LPM policy to different policy later too
> if they want.

Exactly.

> This is just for setting up default policy.  I think if you matched to
> only when pm_suspend_default_s2idle() it would be the least likelihood
> to change this default policy on unsuspecting people upgrading.

The only case where it matters is systems doing S3 by default that
would end up enabling DEVSLP.  Would that confuse the BIOSes on them?
Maybe, but I think that S3 with DEVSLP enabled is generally expected
to work.

Anyway, I'm not religious about this, so I'll send a v3.
