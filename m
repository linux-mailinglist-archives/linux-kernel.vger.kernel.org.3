Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2345607FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiF2R5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiF2R5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:57:01 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0241330561;
        Wed, 29 Jun 2022 10:57:00 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3137316bb69so155521347b3.10;
        Wed, 29 Jun 2022 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH2Yp0O/98KyfDQYebyfrOTqhKJqAyqJfrsNaCmqdGc=;
        b=7b3ZlqG6LY2d0waZKsXp66Bwq1U9A07QRgrMdEfxgb0dCcTNBIc+IDnPQ1l/A/3PEx
         LvLTvIcjJPFiLkoh04P+5dtwfX8ZwvN72AxRfk9MH29ChWL5x8WQStvh/FzpwlzMoOQ6
         QrMW7UWDWHCbFdLhyef9ENddkrogCMVZOc6GJ2OLzXykSi1sjsBHlCCM47RBsIwIJ+7a
         TAesgFzfdK8N5Q93k9C/cMMPbIifEtcI9EpILRdNmBCvWfwsJpo+NjPvGZJ1/LGIfNP4
         hIMECUK6EnQKdprxal5NI+lFAHpXVW47AYGe/2sUlRzpGQC1JuuOa0+YGNiPOB7EUmQR
         0aqg==
X-Gm-Message-State: AJIora93djCT0KWejQ54DVtX+9ry7fX2I8G+i+p4rsnX5EnSBlnfw5qU
        BDJgs9DfZE+G3ApiCvEnsz9yXvxz8ln4aTacp0c=
X-Google-Smtp-Source: AGRyM1ti5TBf5g1kWbCdir04ld9vdzUoLq18CT9Z9Qyw37ZvnKqPyfJzSGrwXyCc5ziK0uZMrO3OjD6BGFhSV499nSI=
X-Received: by 2002:a0d:d811:0:b0:31b:ddc4:c0ac with SMTP id
 a17-20020a0dd811000000b0031bddc4c0acmr5350460ywe.149.1656525419226; Wed, 29
 Jun 2022 10:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <YqpX9npa/wR7mafR@agluck-desk3.sc.intel.com> <20220622170906.33759-1-tony.luck@intel.com>
In-Reply-To: <20220622170906.33759-1-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:56:48 +0200
Message-ID: <CAJZ5v0jBN7-fkP_WB4CDg5UALn+GeY5i8gxM3FwrpKdM-m93rg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/APEI: Better fix to avoid spamming the console with
 old error logs
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Doug Rady <dcrady@os.amperecomputing.com>
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

On Wed, Jun 22, 2022 at 7:09 PM Tony Luck <tony.luck@intel.com> wrote:
>
> The fix in commit 3f8dec116210 ("ACPI/APEI: Limit printable size of BERT
> table data") does not work as intended on systems where the BIOS has a
> fixed size block of memory for the BERT table, relying on s/w to quit
> when it finds a record with estatus->block_status == 0. On these systems
> all errors are suppressed because the check:
>
>         if (region_len < ACPI_BERT_PRINT_MAX_LEN)
>
> always fails.
>
> New scheme skips individual CPER records that are too large, and also
> limits the total number of records that will be printed to 5.
>
> Fixes: 3f8dec116210 ("ACPI/APEI: Limit printable size of BERT table data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> Now in PATCH format with a real commit comment. This version fixes
> the issues seen by Intel's validation team.
>
>  drivers/acpi/apei/bert.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index 598fd19b65fa..45973aa6e06d 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -29,16 +29,26 @@
>
>  #undef pr_fmt
>  #define pr_fmt(fmt) "BERT: " fmt
> +
> +#define ACPI_BERT_PRINT_MAX_RECORDS 5
>  #define ACPI_BERT_PRINT_MAX_LEN 1024
>
>  static int bert_disable;
>
> +/*
> + * Print "all" the error records in the BERT table, but avoid huge spam to
> + * the console if the BIOS included oversize records, or too many records.
> + * Skipping some records here does not lose anything because the full
> + * data is available to user tools in:
> + *     /sys/firmware/acpi/tables/data/BERT
> + */
>  static void __init bert_print_all(struct acpi_bert_region *region,
>                                   unsigned int region_len)
>  {
>         struct acpi_hest_generic_status *estatus =
>                 (struct acpi_hest_generic_status *)region;
>         int remain = region_len;
> +       int printed = 0, skipped = 0;
>         u32 estatus_len;
>
>         while (remain >= sizeof(struct acpi_bert_region)) {
> @@ -46,24 +56,26 @@ static void __init bert_print_all(struct acpi_bert_region *region,
>                 if (remain < estatus_len) {
>                         pr_err(FW_BUG "Truncated status block (length: %u).\n",
>                                estatus_len);
> -                       return;
> +                       break;
>                 }
>
>                 /* No more error records. */
>                 if (!estatus->block_status)
> -                       return;
> +                       break;
>
>                 if (cper_estatus_check(estatus)) {
>                         pr_err(FW_BUG "Invalid error record.\n");
> -                       return;
> +                       break;
>                 }
>
> -               pr_info_once("Error records from previous boot:\n");
> -               if (region_len < ACPI_BERT_PRINT_MAX_LEN)
> +               if (estatus_len < ACPI_BERT_PRINT_MAX_LEN &&
> +                   printed < ACPI_BERT_PRINT_MAX_RECORDS) {
> +                       pr_info_once("Error records from previous boot:\n");
>                         cper_estatus_print(KERN_INFO HW_ERR, estatus);
> -               else
> -                       pr_info_once("Max print length exceeded, table data is available at:\n"
> -                                    "/sys/firmware/acpi/tables/data/BERT");
> +                       printed++;
> +               } else {
> +                       skipped++;
> +               }
>
>                 /*
>                  * Because the boot error source is "one-time polled" type,
> @@ -75,6 +87,9 @@ static void __init bert_print_all(struct acpi_bert_region *region,
>                 estatus = (void *)estatus + estatus_len;
>                 remain -= estatus_len;
>         }
> +
> +       if (skipped)
> +               pr_info(HW_ERR "Skipped %d error records\n", skipped);
>  }
>
>  static int __init setup_bert_disable(char *str)
> --

Applied as 5.20 material, thanks!
