Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91E5673B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiGEQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiGEQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:00:45 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775A1839A;
        Tue,  5 Jul 2022 09:00:44 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j7so16252932ybj.10;
        Tue, 05 Jul 2022 09:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PWyJkGbY1QecBgTJVZxXj+1AZU7IHfNHTa4FKb8zOI=;
        b=QYuM7m+Q97t6nZQNV6/ggJc+DuE1yR0185yj5iVWh5OLgYpfHrCgYzxhAs80mx3HUz
         6F7i16k/Hx3ugzQEHBIwe7xc5gntSjxP6bCW+VAudGjQgcC9OaJe7G4QOnBFUBr6H3B9
         jQlTYGiF/VVnOXaWAmfuvtEB43zeD4jsVfIWvKmOjkKXfWZ727iDHxIsB8bSc0npJiwl
         AzlOF/ZWUya8qyWkDxYoh81AIkXi9D8gt8BRBH8iMvDTbx4HIU6MqT/RNcCKNm3/eJXn
         OKsz4U1vTY0/etIGKd5ZwD1HG1t5JHUPPEWtwPJfzoMV2yCyNlfufsyEo3YbMnrk6riw
         Ra1A==
X-Gm-Message-State: AJIora8ATw5CICSCcNKuFyPrvpey5uA/PoqJbv4qg6kSLTOiace6NPNA
        DYHuQCQuesovZx9reWm3FHSwnLzs02/9BXMricmALHRT
X-Google-Smtp-Source: AGRyM1tcBwZLh8rRYpqHw497xW826C2jzB0Zuqve2AKbtsgc3kdwC5WdPPJja5gSs9nyc6dKnOr9oErdWKb927wiSpg=
X-Received: by 2002:a25:9847:0:b0:669:b4c6:d081 with SMTP id
 k7-20020a259847000000b00669b4c6d081mr37036694ybo.633.1657036843024; Tue, 05
 Jul 2022 09:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com> <20220630150135.1799535-2-sbinding@opensource.cirrus.com>
In-Reply-To: <20220630150135.1799535-2-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 18:00:32 +0200
Message-ID: <CAJZ5v0i-UQYVimV0wPygV3Qe_ASEAPA66Taeardg_LdxT7rGkg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: utils: Add api to read _SUB from ACPI
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
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

On Thu, Jun 30, 2022 at 5:01 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Add a wrapper function to read the _SUB string from ACPI.
>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/acpi/utils.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |  6 ++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3a9773a09e19..394954f4b6ef 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -291,6 +291,44 @@ int acpi_get_local_address(acpi_handle handle, u32 *addr)
>  }
>  EXPORT_SYMBOL(acpi_get_local_address);
>
> +#define ACPI_MAX_SUB_BUF_SIZE  9
> +
> +const char *acpi_get_subsystem_id(acpi_handle handle)
> +{
> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       const char *sub;
> +
> +       status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);
> +               return ERR_PTR(-ENODATA);
> +       }
> +
> +       obj = buffer.pointer;
> +       if (obj->type == ACPI_TYPE_STRING) {
> +               if (strlen(obj->string.pointer) < ACPI_MAX_SUB_BUF_SIZE &&
> +                   strlen(obj->string.pointer) > 0) {
> +                       sub = kstrdup(obj->string.pointer, GFP_KERNEL);
> +                       if (!sub)
> +                               sub = ERR_PTR(-ENOMEM);

The error codes below are somewhat questionable.

> +               } else {
> +                       acpi_handle_err(handle, "ACPI _SUB Length %zu is Invalid\n",
> +                                       strlen(obj->string.pointer));
> +                       sub = ERR_PTR(-EINVAL);

This is as good as failure, so why not use -ENODATA here?

> +               }
> +       } else {
> +               acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
> +               sub = ERR_PTR(-EINVAL);

Likewise.

> +       }
> +
> +       acpi_os_free(buffer.pointer);
> +
> +       return sub;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_subsystem_id);
> +
>  acpi_status
>  acpi_evaluate_reference(acpi_handle handle,
>                         acpi_string pathname,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7b96a8bff6d2..7651198ad6f5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -762,6 +762,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
>  #endif
>
>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
> +const char *acpi_get_subsystem_id(acpi_handle handle);
>
>  #else  /* !CONFIG_ACPI */
>
> @@ -1023,6 +1024,11 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>         return -ENODEV;
>  }
>
> +static inline const char *acpi_get_subsystem_id(acpi_handle handle)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline int acpi_register_wakeup_handler(int wake_irq,
>         bool (*wakeup)(void *context), void *context)
>  {
> --
> 2.25.1
>
