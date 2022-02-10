Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443E4B093D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiBJJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiBJJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:12:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AEE1109;
        Thu, 10 Feb 2022 01:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F3DCB82440;
        Thu, 10 Feb 2022 09:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3331DC340F0;
        Thu, 10 Feb 2022 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644484319;
        bh=JedsB1JwXMEe8yGaX/BRWqTZv9TyfpT/Y68puVJHs/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VF3q86MjV6MKq4r9qsD1rtfzgmwOhffpMjSWJ+EQuSRNZKZn96yOdYHRi8qOGKVZo
         WQdV5jkduwNFX+iPKGunGKIuHmw2vT/JAvwJBzTepl5t311clPn0vv4tBnQ44Qakeo
         OqW+tJ+kWuUBzZsKwJp2no1l/ZeKL5z2Fyn8ifO8fkPH7YlHUWc95sTSgkGo8lGIRn
         3UhrvlgBLj2+HE948UWlskfcH8EQk7bFuljZZp+20NsMvY5WtxA5lRht+Agkc7onWR
         D+/W/+uaIuKRv2k2Hh6eBMaGIO2c+3qi+AlZHTWGKu+PmJXMjLTtuKORRzjp+ozAJV
         WDwYpQ/SZZV1w==
Received: by mail-wr1-f54.google.com with SMTP id e3so8409210wra.0;
        Thu, 10 Feb 2022 01:11:59 -0800 (PST)
X-Gm-Message-State: AOAM530jkiuz241WhbeujITD+MYGPOyeThP0IzHFesKwxAOj27dzhZxL
        loeDNpE0c5Ki2Ld6o+BY0N+dzm1G8+lCCAky5JU=
X-Google-Smtp-Source: ABdhPJyCE9WauEk8svEa5nQ4zRYMLQZlXKjxclYSXVI9ENtdYdFhWHJ6K5eHC4aW0EOR7LXwJnDCKn9OyF3EktyQeN4=
X-Received: by 2002:a05:6000:1b88:: with SMTP id r8mr5675117wru.447.1644484317472;
 Thu, 10 Feb 2022 01:11:57 -0800 (PST)
MIME-Version: 1.0
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
In-Reply-To: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Feb 2022 10:11:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com>
Message-ID: <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com>
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
To:     Victor Erminpour <victor.erminpour@oracle.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 01:34, Victor Erminpour
<victor.erminpour@oracle.com> wrote:
>
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
>
> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
>   1670 |                         struct acpi_iort_named_component *ncomp;
>        |                                                           ^~~~~
>
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>

GCC 12 is not released yet, and this is clearly a compiler bug (a
declaration is not a statement, and the hidden offending statement
[the zero-init] is emitted by the compiler itself), so please report
this to the GCC folks instead.


> ---
>  drivers/acpi/arm64/iort.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3b23fb775ac4..5c5d2e56d756 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
>   */
>  phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>  {
> -       phys_addr_t limit = PHYS_ADDR_MAX;
> +       phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
>         struct acpi_iort_node *node, *end;
>         struct acpi_table_iort *iort;
>         acpi_status status;
> @@ -1667,17 +1667,15 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>                         break;
>
>                 switch (node->type) {
> -                       struct acpi_iort_named_component *ncomp;
> -                       struct acpi_iort_root_complex *rc;
> -                       phys_addr_t local_limit;
> -
>                 case ACPI_IORT_NODE_NAMED_COMPONENT:
> +                       struct acpi_iort_named_component *ncomp;
>                         ncomp = (struct acpi_iort_named_component *)node->node_data;
>                         local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
>                         limit = min_not_zero(limit, local_limit);
>                         break;
>
>                 case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
> +                       struct acpi_iort_root_complex *rc;
>                         if (node->revision < 1)
>                                 break;
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
