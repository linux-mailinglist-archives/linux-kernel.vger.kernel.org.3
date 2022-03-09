Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254B4D390C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiCISnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCISni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:43:38 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EB1403D;
        Wed,  9 Mar 2022 10:42:37 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dbd97f9bfcso33212037b3.9;
        Wed, 09 Mar 2022 10:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y61mRCKE3zM9b3wOa8ze9bCmXMfmsVduldNuViZnA4k=;
        b=GE95ESInc2IO8KVquGpLPySZ/+w308ZgkRCbYhr/mdez6s10atGaEEOcXQNqF3yOzs
         7or9LjOeJNNZhBLWPPqqHkRY96Siescs1oPn5ngD0J51AS0agRTYkTYwPapikrj3jumj
         QAw/GTvMHddtmjsXUPcL3Zw1EKf/3ZSv5Zgbyw4wsoaDs/PiJe/ewE30VZl+iyXwImhw
         Lf3ZzrJIpEVszDT8UAzgX28bYH5lgyZygdgfnwUfaEXisJYYHq4+ItkgxDeCs0iamHGn
         EuAHLMWkwiFLka24HjPmofayoBwRbYTgWn6XtkCmgAacUOHy0ymn/zKKoxoIQMda3YQZ
         hrpA==
X-Gm-Message-State: AOAM532aKd7EdlPF04nB4xyuJKmDe5EnFI5tkuJmiXJpZ0QzZaHHSRRV
        ljRivgTtoSkwmCpjnUIGuOikuMdw0K96HUDL090=
X-Google-Smtp-Source: ABdhPJwnEUJOD5z2fMROtMR0asiHyfh52H3fwaFsMnbIiBicsEFlOHLbZIOrDuUxLrBPkwWxCOLEpAfGKZlTIDoDxT0=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr971245ywb.326.1646851356977; Wed, 09
 Mar 2022 10:42:36 -0800 (PST)
MIME-Version: 1.0
References: <43dfaba0646d498fe94c1a8479b812346133f438.1646765290.git.darren@os.amperecomputing.com>
In-Reply-To: <43dfaba0646d498fe94c1a8479b812346133f438.1646765290.git.darren@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 19:42:26 +0100
Message-ID: <CAJZ5v0gMh2ed+ZWOnd-t_uTrZtm=AUfxOAkAKWT7WQK3=gf+7w@mail.gmail.com>
Subject: Re: [PATCH] ACPI/APEI: Limit printable size of BERT table data
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
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

On Tue, Mar 8, 2022 at 7:51 PM Darren Hart
<darren@os.amperecomputing.com> wrote:
>
> Platforms with large BERT table data can trigger soft lockup errors
> while attempting to print the entire BERT table data to the console at
> boot:
>
>   watchdog: BUG: soft lockup - CPU#160 stuck for 23s! [swapper/0:1]
>
> Observed on Ampere Altra systems with a single BERT record of ~250KB.
>
> The original bert driver appears to have assumed relatively small table
> data. Since it is impractical to reassemble large table data from
> interwoven console messages, and the table data is available in
>
>   /sys/firmware/acpi/tables/data/BERT
>
> limit the size for tables printed to the console to 1024 (for no reason
> other than it seemed like a good place to kick off the discussion, would
> appreciate feedback from existing users in terms of what size would
> maintain their current usage model).
>
> Alternatively, we could make printing a CONFIG option, use the
> bert_disable boot arg (or something similar), or use a debug log level.
> However, all those solutions require extra steps or change the existing
> behavior for small table data. Limiting the size preserves existing
> behavior on existing platforms with small table data, and eliminates the
> soft lockups for platforms with large table data, while still making it
> available.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Doug Rady <dcrady@os.amperecomputing.com>
> Signed-off-by: Darren Hart <darren@os.amperecomputing.com>

Not that I have a particularly strong opinion here, but this looks
reasonable to me, so I've queued it up for 5.18.

APEI reviewers, please chime in if you disagree with the above.

> ---
>  drivers/acpi/apei/bert.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index 19e50fcbf4d6..ad8ab3f12cf3 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -29,6 +29,7 @@
>
>  #undef pr_fmt
>  #define pr_fmt(fmt) "BERT: " fmt
> +#define ACPI_BERT_PRINT_MAX_LEN 1024
>
>  static int bert_disable;
>
> @@ -58,8 +59,11 @@ static void __init bert_print_all(struct acpi_bert_region *region,
>                 }
>
>                 pr_info_once("Error records from previous boot:\n");
> -
> -               cper_estatus_print(KERN_INFO HW_ERR, estatus);
> +               if (region_len < ACPI_BERT_PRINT_MAX_LEN)
> +                       cper_estatus_print(KERN_INFO HW_ERR, estatus);
> +               else
> +                       pr_info_once("Max print length exceeded, table data is available at:\n"
> +                                    "/sys/firmware/acpi/tables/data/BERT");
>
>                 /*
>                  * Because the boot error source is "one-time polled" type,
> --
> 2.31.1
>
