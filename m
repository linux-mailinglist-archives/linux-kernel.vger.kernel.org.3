Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6465602AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiF2O2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF2O2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:28:06 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44EABEB;
        Wed, 29 Jun 2022 07:28:05 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31772f8495fso149708077b3.4;
        Wed, 29 Jun 2022 07:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHR5ymbsi5Z999J/dNB6LVJ9e+8/Ici1kU2JlqnQpKY=;
        b=8C1ofLx6XDbqlYzlNHkRvE8nKs8/RB04OrLtfDlpnxG4alW9gcVuoXeB8OBbQSNu6i
         ulJUeRkiaQ7lGULxKzU+bQ0VXvaZ78Lh5XqPB1IWNWpDb4clitjsjxCIzMs6/vWmAJUZ
         p+2LJuqDyDCcq2R0M/iBmKTJ9G7c8ftiq/a3ADW+XelhafqlLX8Ch8pPJ8Fv4snCfISq
         cWfoiXDiuzmm+DgBkCTBTCurwrUqrVuqutXZz+vekAoX5PNOCEndJPh3X5yw0YfebepE
         zR+oDkAbI6bX1qWwjgnwU7jgbyLYlLbKB5YTW0Y34CBZcCsR9uDGmvf7UO2WXbz7fWrQ
         hQUA==
X-Gm-Message-State: AJIora/llUJ08rZpsF62SOLPIKnd6GtnUsyRgNxj674znGj4iHlY01YF
        CndXT6qUhVzQZKTxCP6fx9DiMnOPq0r8iHFbzpUYRLaXi/A=
X-Google-Smtp-Source: AGRyM1t7OXAfuIqFWwKLk+lBTxMSyeGPHn3W96IbunZGgW4UmzkbDNhR8beTXQHeD4d5aKYs1HBGZD8huUCIIT8oda8=
X-Received: by 2002:a81:57d7:0:b0:317:b111:34d5 with SMTP id
 l206-20020a8157d7000000b00317b11134d5mr4228905ywb.7.1656512884315; Wed, 29
 Jun 2022 07:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220522214302.39024-1-james.liu@hpe.com>
In-Reply-To: <20220522214302.39024-1-james.liu@hpe.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 16:27:53 +0200
Message-ID: <CAJZ5v0i7CiuXXHOyMqwzS5CUqKPN6rcLC9yxpv20goeAinbKUg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: OSL: Fix the memory mapping of an ACPI GAS that
 addresses a data structure
To:     James Liu <james.liu@hpe.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, david.chang@hpe.com, clayc@hpe.com
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

On Sun, May 22, 2022 at 11:44 PM <james.liu@hpe.com> wrote:
>
> From: James Liu <james.liu@hpe.com>
>
>     Modify acpi_os_map_generic_address() & acpi_os_unmap_generic_address()
>     to correctly handle cases that a GAS table (i.e., Table 5.1, ACPI 6.4)
>     is used to address a data structure; in the case, the GAS has the field
>     of "Register Bit Width" equal to 0.
>
>     For example, "Injection Instruction Entry" (Table 18.25, ACPI 6.4) has
>     a RegisterRegion field that is a GAS that points to a data structure
>     SET_ERROR_TYPE_WITH_ADDRESS (Table 18.30), which is required when using
>     EINJ (Error Injection module).
>
>     This fix preserves a fairly sufficient memory space (i.e. page size) to

The hard-coded PAGE_SIZE allocation size is kind of a concern, because
the spec doesn't seem to limit the size of the structure pointed to by
the GAS to a page.

Also it is not clear from the spec that the RegisterRegion field in
Table 18.25 points to a structure.  On the contrary, Section 18.6.2
says that it points to a register.

In any case, I don't think it is OK to use
acpi_os_map_generic_address() to map an address from a GAS pointing to
a data structure.  acpi_os_map_memory() appears to be the right
interface to map such memory regions.

>     store the data structure to prevent EINJ module from loading failure if
>     platform firmware can correctly support Injection Instruction Entry in
>     an EINJ table.
>
> Signed-off-by: James Liu <james.liu@hpe.com>
> ---
>  drivers/acpi/osl.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 45c5c0e45..99f987c8c 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -452,14 +452,20 @@ EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
>
>  void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
>  {
> -       u64 addr;
> +       u64 addr = 0;
>
>         if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 return NULL;
>
> +       /* Handle a case that GAS is used to address an ACPI data structure */
> +       if (!gas->bit_width) {
> +               pr_info("An ACPI data structure at 0x%llx is mapped\n", addr);
> +               return  acpi_os_map_iomem(addr, PAGE_SIZE);
> +       }
> +
>         /* Handle possible alignment issues */
>         memcpy(&addr, &gas->address, sizeof(addr));
> -       if (!addr || !gas->bit_width)
> +       if (!addr)
>                 return NULL;
>
>         return acpi_os_map_iomem(addr, gas->bit_width / 8);
> @@ -468,15 +474,28 @@ EXPORT_SYMBOL(acpi_os_map_generic_address);
>
>  void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  {
> -       u64 addr;
> +       u64 addr = 0;
>         struct acpi_ioremap *map;
>
>         if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 return;
>
> +       /* Handle a case that GAS is used to address an ACPI data structure */
> +       if (!gas->bit_width) {
> +               pr_info("An ACPI data structure at 0x%llx is unmapped\n", addr);
> +               mutex_lock(&acpi_ioremap_lock);
> +               map = acpi_map_lookup(addr, PAGE_SIZE);
> +               if (!map) {
> +                       mutex_unlock(&acpi_ioremap_lock);
> +                       return;
> +               }
> +               acpi_os_drop_map_ref(map);
> +               mutex_unlock(&acpi_ioremap_lock);
> +       }
> +
>         /* Handle possible alignment issues */
>         memcpy(&addr, &gas->address, sizeof(addr));
> -       if (!addr || !gas->bit_width)
> +       if (!addr)
>                 return;
>
>         mutex_lock(&acpi_ioremap_lock);
> --
> 2.25.1
>
