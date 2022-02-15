Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874614B75C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiBORL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:11:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbiBORLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:11:24 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE311ADD9;
        Tue, 15 Feb 2022 09:11:14 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 124so29963389ybn.11;
        Tue, 15 Feb 2022 09:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDMnKMXVJa929NolhryiFxFArnbuzBfDe+LVL1CiDA4=;
        b=qkq+usKeOxl48IvR8xKHyJmiW0/RIiDOO/zUa4Ak23YjGWAKmeH2ErhM6HjZEzjTpM
         C8i2uauPazpx5r199SudX14FNNM7ftF5Xubkrt1CPKk9tDEP2o5UK5LM9+7FEApHEgVV
         v1hBxNZ7She1Q9DxSgcw5JtDiPCQCmPGaO0jbmCrzXrgc9kSWNhaiwkTq7gx9N01BXSn
         4UjaKsIB0MXzIRb6ieaD15MDI/zAhDvYGfjxfmoDWLwbd8R7iII0pahAaPDxo3F+HqBH
         aIbCK0trrq4Ce6qP03O+Yue/yITGEfCSDYx5uBZdeIK4M6/RICuWCLaRHcoeDcIPiEX0
         CRBQ==
X-Gm-Message-State: AOAM532hS7E4uAUytwekSnRDSr4Elr6shdYQtTpBudnVIPl8I62kUFun
        WpUHpLjgskw8+iZ2I00IoF2GVpX1BEwVlmKRZiM=
X-Google-Smtp-Source: ABdhPJwo53vGAohhtNHRmPcc5fLjmAhyMnRIp42CHlVQKf826ePo/bhOG0f9z4hWzUvi1WbJmxqPpIugfXk26cW3QjU=
X-Received: by 2002:a25:3410:: with SMTP id b16mr4716036yba.78.1644945073814;
 Tue, 15 Feb 2022 09:11:13 -0800 (PST)
MIME-Version: 1.0
References: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de> <CAPcyv4jSP4PTehMdkcpZfpDcz1HZ0ekjx+WztOiqpwGFU-1iBg@mail.gmail.com>
In-Reply-To: <CAPcyv4jSP4PTehMdkcpZfpDcz1HZ0ekjx+WztOiqpwGFU-1iBg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 18:11:02 +0100
Message-ID: <CAJZ5v0hv2P9_g0QAsY_guvYA_vSE-q4jz2902Df7r9KS=iRfMg@mail.gmail.com>
Subject: Re: New warning: ACPI: CEDT not present
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
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

On Tue, Feb 15, 2022 at 5:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Feb 14, 2022 at 11:52 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > #regzbot introduced: 2d03e46a4bad20191d07b83ec1242d5f002577be
> >
> > Dear Dan,
> >
> >
> > On the Dell Latitude E7250, Linux 5.17-rc3 logs the warning below
> > (`dmesg --level=warn`):
> >
> >      ACPI: CEDT not present
> >
> > I think commit 2d03e46a4bad (ACPI: Add a context argument for table
> > parsing handlers), part of Linux since 5.17-rc1, is the reason.
> >
> > If I understand it correctly, CEDT is not to be expected on older
> > devices, so the warning is not justified. Can something be done about it?
>
> Rafael,
>
> I'm inclined to just delete the warning altogether, but special casing
> is also an option. Any preference?

Change it into pr_debug()?

> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 0741a4933f62..fb2e4a216154 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -399,7 +399,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>                 instance = acpi_apic_instance;
>
>         acpi_get_table(id, instance, &table_header);
> -       if (!table_header) {
> +       if (!table_header && strcmp(id, ACPI_SIG_CEDT) != 0) {
>                 pr_warn("%4.4s not present\n", id);
>                 return -ENODEV;
>         }
