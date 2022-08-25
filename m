Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4276B5A18C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbiHYS06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbiHYS0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:26:55 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F758DFB;
        Thu, 25 Aug 2022 11:26:55 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-32a09b909f6so563788087b3.0;
        Thu, 25 Aug 2022 11:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=r7wf1VgQcXbb9wfHksSmuRqPiTwtCYwRKi+1g4SftOU=;
        b=x4BLn8BkdZtRJ05BlL0taz6+E5x0Cc8MUq2/vObVTnzAxjQQrEiPGqP2fN9sSFudT4
         rInyKR+Etb53PFxDG70ybzpuFZnWPO9Dzt9OCq8IPvVXMa7GaECHzMXk2eI/MPMhQy1a
         8elBW8gNBPTu8Ud0Lw0hbIRrjfgfTSUurxwwWqCQWe8LMPcq878G3olDfj9oPSvAoD5L
         zucCSCD5FKOsIalRFUyv1OftZpIRAI9vEO9SYTLFnYXb+ZQoCCFqTWFOtaPFa0pUybHv
         y7LoRmF5vX15IC4aRRI3hmUWFsCkFM/TXeaG4yKTsdtsvgk7IK93joMbbJvgCVvtrQkZ
         JugQ==
X-Gm-Message-State: ACgBeo2ygJNTrhIb3LAlfXnnuAPanAs6U6+vsimeFPvkBiV3ZbJHdqKg
        ILxt8FOHF7KDmnJdj3BBX2XH9TB+nBYSsxYO2H0yM7dYtnY=
X-Google-Smtp-Source: AA6agR6hx6NbJ3M7caaSE8E42oIFRqV8l9eqO6ZQxBU4y9XV7Pb0FnmgSCwZiGDWFD69sTVESFeDkCfTJOoEXlU1wKM=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr4577792ybm.137.1661452014375; Thu, 25
 Aug 2022 11:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <5607133.DvuYhMxLoT@kreacher> <ecb5a2dd-47b2-e5e1-5254-42bd5d018578@amd.com>
In-Reply-To: <ecb5a2dd-47b2-e5e1-5254-42bd5d018578@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 20:26:43 +0200
Message-ID: <CAJZ5v0in-me017RoR8yRMMXmbBofr6u9o2_WMGh38cpiy3cG3w@mail.gmail.com>
Subject: Re: [PATCH v2] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Aug 25, 2022 at 8:17 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/25/2022 13:01, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> > use low-power S0 idle on the given platform than S3 (provided that
> > the latter is supported) and it doesn't preclude using either of
> > them (which of them will be used depends on the choices made by user
> > space).
> >
> > For this reason, there is no benefit from checking that flag in
> > ahci_update_initial_lpm_policy().
> >
> > First off, it cannot be a bug to do S3 with policy set to either
> > ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
> > used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
> > really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
> > protect the S3-capable systems from failing.
> >
> > Second, suspend-to-idle can be carried out on a system with
> > ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> > policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
> > needed to handle that case correctly, it should be done regardless of
> > the ACPI_FADT_LOW_POWER_S0 value.
> >
> > Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
> > ahci_update_initial_lpm_policy() along with the CONFIG_ACPI #ifdef
> > around it that is not necessary any more.
>
> Looking at the source commit for this behavior:
>
> b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with SLP_S0")
>
> It was trying to set a policy tied to when the system is defaulting to
> suspend to idle.
>
> To try to match the spirit of the original request but not tying it to
> the FADT, how about using pm_suspend_default_s2idle()?

The user can switch to "default S3" later anyway, so this wouldn't
help more than the check being dropped.
