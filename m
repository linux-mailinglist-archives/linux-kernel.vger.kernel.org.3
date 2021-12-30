Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE84481E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbhL3QXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:23:25 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:33625 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3QXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:23:24 -0500
Received: by mail-qv1-f41.google.com with SMTP id kk22so22550025qvb.0;
        Thu, 30 Dec 2021 08:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qeblw1m9b1lBZnq56cGE3LlH8ljA2Kqb7IdC+pWcyJo=;
        b=ay8mOfUG/vh2e3ifneSu+X/ntxD6DEUMwNVKU7ZutA6sKgTyqPjXSbY7ChbVM/5Mun
         rj43lUf/bkV5dVtCC3rMqVWICXrtjoMRNMo2VWPtIAOQzdodVOZFzRlOv+wfENFvUlvS
         k4ruuiyyZAQ63fPsynooikuOdCPKVRs6pLYAEbcpG4XLSCiLeu/arubkmkbquxFhDq6k
         cbSY8ut+QYI9+UItScGkhLjWzCgQ3pgMINQ74TlBIWpLuuHnTdQf6HgeU+T0pBTndZ45
         rQe0UTiGwpT3NScYAFiaVGwWkbUyAAUCB2fBe3vGvc0MN9Ta8dMYUmHyznqJ+Y+85IM7
         OS7Q==
X-Gm-Message-State: AOAM5337TmYn5GtDqj6fGbjFEPEIXdSgZrbj5fmhDAWQlmS2DLMz8NMN
        lkSy5xH1CNK7jH5tAowPai5FT+jedWjA+9TvSuc=
X-Google-Smtp-Source: ABdhPJxCW9LoTGevH6Tb21On6CNI5HU3B20jNAR6zTBdM5kRKtjktxDkmh0EyBzZ4t/fi7OZ3z0LdI+r0wEdGB2yeEg=
X-Received: by 2002:ad4:5c8b:: with SMTP id o11mr27548806qvh.130.1640881403809;
 Thu, 30 Dec 2021 08:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20211222191411.13805-1-manfred@colorfullife.com>
In-Reply-To: <20211222191411.13805-1-manfred@colorfullife.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:23:13 +0100
Message-ID: <CAJZ5v0jJr=-O0UdXKj=nHtDv5oJwKWd_5het80QJZ5PBmzitPw@mail.gmail.com>
Subject: Re: drivers/acpi/processor_thermal.c: avoid cpufreq_get_policy()
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        1vier1@web.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:14 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> cpu_has_cpufreq() stores a 'struct cpufreq_policy' on the stack.
> Unfortunately, with debugging options enabled, the structure can be
> larger than 1024 bytes, which causes a compiler warning/error.
>
> (actually observed: 1184 bytes).
>
> Therefore: Switch to cpufreq_cpu_get().
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>
> ---
>  drivers/acpi/processor_thermal.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index a3d34e3f9f94..74210d63f62c 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -53,10 +53,19 @@ static int phys_package_first_cpu(int cpu)
>
>  static int cpu_has_cpufreq(unsigned int cpu)
>  {
> -       struct cpufreq_policy policy;
> -       if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
> +       struct cpufreq_policy *policy;
> +       int retval;

Why is this needed?

> +
> +       if (!acpi_processor_cpufreq_init)
>                 return 0;
> -       return 1;
> +
> +       retval = 0;
> +       policy = cpufreq_cpu_get(cpu);
> +       if (policy) {
> +               cpufreq_cpu_put(policy);

return 1;

> +               retval = 1;
> +       }
> +       return retval;

return 0;

>  }
>
>  static int cpufreq_get_max_state(unsigned int cpu)
> --
> 2.33.1
>
