Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C24BEAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiBUTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:19:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiBUTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:18:52 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6698019C12;
        Mon, 21 Feb 2022 11:18:25 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id j2so36554290ybu.0;
        Mon, 21 Feb 2022 11:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzgUYOPvVSFuM+OD0NIOOfArvnpqyIafZxVpUEmLbzs=;
        b=CHgW3T2N7l5VTMXgthoNHGMThlIh4tdcMBHTLi/KR7Dph2BjFeW3GOB/e08W48YGNl
         Q/z/jdMF8TTUkLaHKB1BoL52lkBQEpN9mj0K51KXP4S7OZmbz6qvOVm7tHhFSJSGrc/d
         54OAikFuqMUtyrTnVtbBZarOrfsLnmCzaHf1zyw3kST8mxrYsZjoKG23avivgzPaVYZU
         FyWU+zLTH2L7hs71bAw0bJTX/BHTkhUHB5Q1NJiwyx0V7SI79NVbECGCPmm1RXgGpRWE
         c5rkCglOU0uiri8GT7hGRJDtU5g1hhcB7E2y4bDLHB8EbjGbMhcDJvX45u8FlBxtSqwt
         Td6A==
X-Gm-Message-State: AOAM533kl9Pwf2MTPVwJIafQ8nBiRRtiumECnd9xhmaRKJVDtsGtmwWw
        MrsvIxMr2WfOnjFuskp76bHVpvQ2CD2hPvmIQ0k=
X-Google-Smtp-Source: ABdhPJxzKeolTMRCSzF1gZvCUSgga9kC27EC4hV9wjKJdhirzXNJgRkVrqDtPDetZQZot9oR8y1pLxP5YAk9oM8NPJ0=
X-Received: by 2002:a25:d90d:0:b0:615:e400:94c1 with SMTP id
 q13-20020a25d90d000000b00615e40094c1mr20140995ybg.81.1645471104673; Mon, 21
 Feb 2022 11:18:24 -0800 (PST)
MIME-Version: 1.0
References: <05530d163bb18634cceaf1f2b0b48409747d18d0.1644838495.git.yang.guang5@zte.com.cn>
In-Reply-To: <05530d163bb18634cceaf1f2b0b48409747d18d0.1644838495.git.yang.guang5@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Feb 2022 20:18:13 +0100
Message-ID: <CAJZ5v0iUVfc-hr_stEbNEv2Ana+g-44Qrtm1b490cLZTDe=YEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: use swap() to make code cleaner
To:     davidcomponentone@gmail.com
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, Feb 15, 2022 at 1:52 AM <davidcomponentone@gmail.com> wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
> index 14b71b41e845..ac6a5397660f 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>                             || ((sort_direction == ACPI_SORT_DESCENDING)
>                                 && (obj_desc1->integer.value <
>                                     obj_desc2->integer.value))) {
> -                               temp_obj = elements[j - 1];
> -                               elements[j - 1] = elements[j];
> -                               elements[j] = temp_obj;
> +                               swap(elements[j - 1], elements[j]);
>                         }
>                 }
>         }
> --

This is an ACPICA change that should be routed through the upstream
project at https://github.com/acpica/acpica, but there is no
counterpart of swap() in the upstream code base.
