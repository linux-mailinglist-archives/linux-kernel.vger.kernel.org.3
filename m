Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72F49EB71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiA0T6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:58:52 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:34590 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343516AbiA0T6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:58:51 -0500
Received: by mail-yb1-f175.google.com with SMTP id v186so12112855ybg.1;
        Thu, 27 Jan 2022 11:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JU0YS/R/EoprgrYZtkZ8RlkD/FefqeQsRVRgpn1yuvU=;
        b=i7ftKkI84cpQK+r4ETJXUMD8QCkIy++IBrIaaBghlZ/ZazIF2r7zXqjDBI/5+SLtFN
         bJ395QV+AGyJ/4Fr2CzL62h+qZUz4INFD/ZvydI4UA3X1KXxO4wB0mJTiL4QTm/tcsAk
         VmLEcTFxplXccMN2ym9b1YnBRhCvsrtGSCnxS0f9D2byyDL/Tn57QKU8/EM27FTXgb5A
         NIR8xhEEPcDc/jSSbXnfUiUZUkbsgrlQ35ngCnYEMGUaFc6ygw0mh+LUrlu920oEDRdr
         cS4Eh2VDyxjXpL6TKtAIgSv7T2Sd8k9q+1eP8fDVCRT/2eB7rhKlv8nFWaIfPDt3wZTg
         yyjQ==
X-Gm-Message-State: AOAM531S0LwZPcKeIDM0AWdz92ZLzxkr3zs7++F4U15rPOBsWkcjvOPK
        Om+P3gBeFVM0bgQwdSdLbqaTD7S7HXC3QPqTK9o=
X-Google-Smtp-Source: ABdhPJyz77nvWofsixr5tBR8EvQ9OmH8a4W5IGTBg9xpuKoTd8vpYKqyYrvVybZ5UficWnOVaRv+dlsHu84LGDJiqww=
X-Received: by 2002:a25:2ac3:: with SMTP id q186mr7895749ybq.272.1643313530606;
 Thu, 27 Jan 2022 11:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20220124164014.51658-1-zhou1615@umn.edu>
In-Reply-To: <20220124164014.51658-1-zhou1615@umn.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jan 2022 20:58:39 +0100
Message-ID: <CAJZ5v0iVEQVMn4K6007jUaiJ1CNhaCTePhLSBrX=mONswM98-g@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Linuxize: Fix a NULL pointer dereference in acpi_db_convert_to_package()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 5:45 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In acpi_db_convert_to_package(), the variable elements is assigned by
> ACPI_ALLOCATE_ZEROED() and passes its address to
> acpi_db_convert_to_object(). In that function we may have a dereference
> of elements without checks. ACPI_ALLOCATE_ZEROED() would return NULL on
> failure, which may lead to NULL pointer dereference.
>
> Fix this bug by adding a NULL check of elements.
>
> This bug was found by a static analyzer.
>
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>

This is ACPICA material and so it should be submitted as a change
against the upstream code via https://github.com/acpica/acpica

Thanks!

> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
>  drivers/acpi/acpica/dbconvert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
> index 2b84ac093698..8dbab6932049 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
>         elements =
>             ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>                                  sizeof(union acpi_object));
> +       if (!elements)
> +               return (AE_NO_MEMORY);
>
>         this = string;
>         for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> --
> 2.25.1
>
