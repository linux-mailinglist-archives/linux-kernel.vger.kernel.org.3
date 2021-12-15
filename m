Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36DE4758AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhLOMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:18:08 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:38818 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhLOMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:18:05 -0500
Received: by mail-oo1-f53.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5849843ooj.5;
        Wed, 15 Dec 2021 04:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XfuAuI8r8gMaaT/FK+NBfoQJrnloschflDHzdC5Epg=;
        b=r0+74mzaJCfIy3TSukbnGiiQX3R2DkWIHlyyrJXayqgICuR/HKmiH/0ZaBjoF6xGgr
         eVAtq1VX4J3nZPncvwGiVDdECIjx3H7j0NMS9v4JaTF/YxucuGwc69tS+tInw6z8pm8h
         1dYBm5gDJT2n+3epDOy3o2aJS+jVQw9UagpA9B0+psfzCClz5SMRVzz40cEn6PxqvsPu
         XDWgevZ3LBRJXJFjfNKdIBRZwswozyRsS3p2A+LC+XTOSD5LrRtJnbi2FtlPlvJaGmJz
         ZTJZmN7zu7CukiHrJNtsP4as2RBBt7W0N5f8UG75IgYlnqVIKrZ5dcM75oIRczZqFZo+
         5YmQ==
X-Gm-Message-State: AOAM530MIq89cOu3kOeMg5+rbWdyDVL/ULZUcvl6zabHCn8/Rbc96K2p
        Ru96svpB0nZMN/Efbof4t30uuCCqpF8GStOi0+Y=
X-Google-Smtp-Source: ABdhPJwumDoqqi/fTVhsrj0sGJloO+psYXPTBFmlg4pq4svwED4dTqZ4uQlNYP9XVfPRwUiwGOjtmCwUO6v7+eFxY6o=
X-Received: by 2002:a4a:1d82:: with SMTP id 124mr6908688oog.91.1639570684529;
 Wed, 15 Dec 2021 04:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20211214044036.48245-1-ilkka@os.amperecomputing.com> <20211214044036.48245-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20211214044036.48245-2-ilkka@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Dec 2021 13:17:53 +0100
Message-ID: <CAJZ5v0jiLfL0k12y5RZ+9LjLqiBMPqRHrqNQGqQ5Le2yOv7QWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: AGDI: Add AGDI tables to drivers/acpi
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 5:41 AM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
> issue diagnostic dump and reset via an SDEI event or an interrupt. This
> patch adds support to ACPI/AGDI tables.
>
> [0] https://developer.arm.com/documentation/den0093/latest/
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/acpi/tables.c |  2 +-
>  include/acpi/actbl2.h | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 71419eb16e09..5e3169bcb9fb 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -       ACPI_SIG_NHLT };
> +       ACPI_SIG_NHLT, ACPI_SIG_AGDI };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 71ca090fd61b..66ca85b9f5fe 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h

The changes in actbl2.h are ACPICA material and so they need to be
routed through the upstream ACPICA project.

Moreover, you have already submitted a pull request with them to the
upstream: https://github.com/acpica/acpica/pull/737/commits/cf36a6d658ca5aa8c329c2edfc3322c095ffd844

Please wait until this gets integrated and repost the rest of the
patches as incremental changes on top of that.
