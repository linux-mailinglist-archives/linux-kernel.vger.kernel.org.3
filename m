Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0699A47939F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhLQSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:13:13 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35711 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhLQSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:13:05 -0500
Received: by mail-ot1-f47.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso3918309otr.2;
        Fri, 17 Dec 2021 10:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvGmzx8fKaWmjWYpwpwNNKr5wJo10Iuv+DGCUGYROQ0=;
        b=zRokOvPocKm4MUfzTr24PA+anxuxXg6iwrOIE2o1CKz4pV6mR2MD7szSi51r9et5e/
         hpXaqod8RNlWAcCDQmJbanYV36oGsJXVrzxDF85MjRA8lyaJqTtOHXreo5YPSG2+mRgJ
         5L9aIyP1G2iiMpdNsjxr9rQ64EmwZSkz8zc+vRDxFvs8Mhq4jssm5OCirmmZ8dfg2Q2Y
         gA1kMPAqWWlpsJStXlOICyaYw+io5y0Opwb6RCDQGtDizfsLBSm+miediwzyGFkKCWhJ
         aMA74kAP75wBiuuIA256b4yWKsyXqHem2SzwTyXLl2PL6A0rHrEu5JaPEQm+OcdEc6xN
         uxgQ==
X-Gm-Message-State: AOAM5314ngYbb6B8ypOUIEd9sdNIfeKuxmH+yqqgMv9a1J8hf1x0tbD2
        HZ5nZg+rC5uS2oqQMThn9U2VVnHdbMA3cLOIQsY=
X-Google-Smtp-Source: ABdhPJxQ3aduTTtUVlakLgKo1GUFMoOUuhtMu1X8I9LCwDaAE1XtfCaqIAv/oeYMPFxzsSdHKRvKZva2PM2GstlLfwA=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr3147128otu.254.1639764785388;
 Fri, 17 Dec 2021 10:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20211216095826.297912-1-vkuznets@redhat.com>
In-Reply-To: <20211216095826.297912-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 19:12:54 +0100
Message-ID: <CAJZ5v0gUW_KZFNFvhyaj-ekBMbo2f-U=SN2RhRcJeJVFk1zf+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NUMA: Process hotpluggable memblocks when !CONFIG_MEMORY_HOTPLUG
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:58 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Some systems (e.g. Hyper-V guests) have all their memory marked as
> hotpluggable in SRAT. acpi_numa_memory_affinity_init(), however,
> ignores all such regions when !CONFIG_MEMORY_HOTPLUG and this is
> unfortunate as memory affinity (NUMA) information gets lost.
>
> 'Hot Pluggable' flag in SRAT only means that "system hardware supports
> hot-add and hot-remove of this memory region", it doesn't prevent
> memory from being cold-plugged there.
>
> Ignore 'Hot Pluggable' bit instead of skipping the whole memory
> affinity information when !CONFIG_MEMORY_HOTPLUG.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Makes sense to me, so applied as 5.17 material, but CC Dan and
Jonathan in case this can be problematic for some mm-related reason.

> ---
>  drivers/acpi/numa/srat.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index b8795fc49097..6c884f3e8332 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -254,9 +254,8 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>         }
>         if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
>                 goto out_err;
> -       hotpluggable = ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
> -       if (hotpluggable && !IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -               goto out_err;
> +       hotpluggable = IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
> +               (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE);
>
>         start = ma->base_address;
>         end = start + ma->length;
> --
> 2.33.1
>
