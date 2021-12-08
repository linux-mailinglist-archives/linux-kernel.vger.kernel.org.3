Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2B46D55F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhLHOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:16:34 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43711 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhLHOQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:16:32 -0500
Received: by mail-ot1-f50.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so2815761otu.10;
        Wed, 08 Dec 2021 06:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kot1Vo3tW7X4q0oWAztyb7sc2d5t0hVeg+NoGlVrew8=;
        b=Xegniiuy9RhQMiRQFFeiIgXwYehAEWP3W0WWDF7XZvNwJSwdmNKrCYZN2Li7A8bUG6
         Jr7bkBHDWjGnD32jHsyxP9Za4pt01hsWo3dlwwil0RStMnu+Wk944DzBZBzu9DEp8i6l
         5Fxvwo5kE8uVLRbYcrR0puqUEisoENZf9VOX2lN6zGefdtCt1xMflDydXbNNllAF4HCo
         mCoC0zhmhJeAWXq5nmTblaXflfqlmK5VcIk6EJ1vDI7/MbNQe7o9TwFTugMTfXXntE+b
         NEAhDmq/8nM99VyxweKyZSQJjsnnkzMDKvZUZn8TuseeNM2YZmSplNLEFc83ULjipzII
         oyrA==
X-Gm-Message-State: AOAM531SgEQMxt9nUQuZAjqGHyHa59PmfTatTdn5EswjxmP/eyTPh4o9
        S+wq+ilyJKu0/UVXqLcm4A9SmwxpLbU3YwKhmCUPn+dX
X-Google-Smtp-Source: ABdhPJysPaLI98z7r5Jf+ITKMnCviwdGPrRqU1FNn7oQtauRkJLz5idaoWdf/ZmXXa2cs4/90nI/5pTEZ+rC2dd+W+w=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr41268530otf.198.1638972780217;
 Wed, 08 Dec 2021 06:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20211123132330.1008671-1-yu.c.chen@intel.com>
In-Reply-To: <20211123132330.1008671-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Dec 2021 15:12:49 +0100
Message-ID: <CAJZ5v0h6Hka8P9Ba9cYrWSwzfWtH=-prLXjOKBe+1-vEU6rH0A@mail.gmail.com>
Subject: Re: [PATCH] tools/power/acpi: Fix the compile error when output
 directory is specified
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:24 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Compiling the tool when output directory parameter is specified would
> trigger the following error:
>
> make O=/data/test/tmp/ -C tools/power/acpi/
>
> make: Entering directory '/data/src/kernel/linux/tools/power/acpi'
>   DESCEND tools/acpidbg
> make[1]: Entering directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
>   MKDIR    include
>   CP       include
>   CC       tools/acpidbg/acpidbg.o
> Assembler messages:
> Fatal error: can't create /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o: No such file or directory
> make[1]: *** [../../Makefile.rules:24: /data/test/tmp/tools/power/acpi/tools/acpidbg/acpidbg.o] Error 1
> make[1]: Leaving directory '/data/src/kernel/linux/tools/power/acpi/tools/acpidbg'
> make: *** [Makefile:18: acpidbg] Error 2
> make: Leaving directory '/data/src/kernel/linux/tools/power/acpi'
>
> This is because the output directory has not been created yet. Fix this issue by
> creating the output directory before compiling.
>
> Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/acpi/Makefile.config | 1 +
>  tools/power/acpi/Makefile.rules  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
> index 331f6d30f472..cd7106876a5f 100644
> --- a/tools/power/acpi/Makefile.config
> +++ b/tools/power/acpi/Makefile.config
> @@ -69,6 +69,7 @@ KERNEL_INCLUDE := $(OUTPUT)include
>  ACPICA_INCLUDE := $(srctree)/../../../drivers/acpi/acpica
>  CFLAGS += -D_LINUX -I$(KERNEL_INCLUDE) -I$(ACPICA_INCLUDE)
>  CFLAGS += $(WARNINGS)
> +MKDIR = mkdir
>
>  ifeq ($(strip $(V)),false)
>         QUIET=@
> diff --git a/tools/power/acpi/Makefile.rules b/tools/power/acpi/Makefile.rules
> index 2a6c170b57cd..1d7616f5d0ae 100644
> --- a/tools/power/acpi/Makefile.rules
> +++ b/tools/power/acpi/Makefile.rules
> @@ -21,6 +21,7 @@ $(KERNEL_INCLUDE):
>
>  $(objdir)%.o: %.c $(KERNEL_INCLUDE)
>         $(ECHO) "  CC      " $(subst $(OUTPUT),,$@)
> +       $(QUIET) $(MKDIR) -p $(objdir) 2>/dev/null
>         $(QUIET) $(CC) -c $(CFLAGS) -o $@ $<
>
>  all: $(OUTPUT)$(TOOL)
> --

Applied (with some edits in the subject and changelog) as 5.16-rc material.

Thanks!
