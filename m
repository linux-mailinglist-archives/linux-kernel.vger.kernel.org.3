Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699AC554ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352939AbiFVNT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiFVNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:19:52 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD82F01F;
        Wed, 22 Jun 2022 06:19:51 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31772f8495fso161616017b3.4;
        Wed, 22 Jun 2022 06:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqOQ1mRCFn6Ej3pl8pj+iDE9h6BQbGKpcTypXijaYr0=;
        b=0tQ8NA9u/3hnZsK81/BvJnnUSvICkO0g/Wp0ibQM1F3Odcv7enRTgwzVAALGz4rYeh
         C8MihQmlQMiN0Yk0d4+e3cVfMupzbyKvlc3K2ct48spQ7WTEdTqYMoOr/A7N8wbOpeet
         D5c2BDN6q1iW1OJuv5PvYbArmcd5wOhrVUcIFew84qZWc9StjxLQxDiG+nTso0HNR1x8
         Zx8Ty8GWq1QiIRaFf/HiXZI7m8jt+6NDSrGxZzChDRfIUUuWboXa1rOuvXiRuzc0jvsL
         6VN7xjrtq23gNOOjWbffMIgg/7zjOoPIO2j12C9QnyE7ZbtiAJZhPXs0Nn2VTRCy3zj9
         5PRA==
X-Gm-Message-State: AJIora8SE7fkp9w1HUvTN7+Lf63bcKnkun4/A+orbxayWH3IrBebTeKw
        BDs/c8rKzRaHmmXdNc6Y++obyTTSFjdEDHd4E8E=
X-Google-Smtp-Source: AGRyM1sn53Rt6HkhjVlMSbjNcbNLgVPQ9GwJB20ZiQABo8pxntYhAsovfB2VWcuhTxwAeGHL8rNEKt8B/xh/xVXVPjM=
X-Received: by 2002:a0d:ed83:0:b0:317:50bb:5463 with SMTP id
 w125-20020a0ded83000000b0031750bb5463mr4185434ywe.149.1655903990990; Wed, 22
 Jun 2022 06:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220622130730.1573747-1-sbinding@opensource.cirrus.com> <20220622130730.1573747-2-sbinding@opensource.cirrus.com>
In-Reply-To: <20220622130730.1573747-2-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 15:19:40 +0200
Message-ID: <CAJZ5v0ij63HVTTWUBwv9WiWhCfKewJR48reUaGN3nvbzoS31tw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: utils: Add api to read _SUB from ACPI
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

On Wed, Jun 22, 2022 at 3:08 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Add a wrapper function to read the _SUB string from ACPI.
>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/acpi/utils.c | 26 ++++++++++++++++++++++++++
>  include/linux/acpi.h |  8 ++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3a9773a09e19..5d1bdb79e372 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -291,6 +291,32 @@ int acpi_get_local_address(acpi_handle handle, u32 *addr)
>  }
>  EXPORT_SYMBOL(acpi_get_local_address);
>
> +int acpi_get_sub(acpi_handle handle, char *sub, size_t size)

I'd call it acpi_get_subsystem_id().

> +{
> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       int ret;
> +
> +       status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
> +       if (!ACPI_SUCCESS(status)) {

Typically, ACPI_FAILURE() is used in checks like this.

> +               acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);

It would be enough to say "_SUB evaluation failed".

> +               return -ENOENT;

Why not use -ENODATA here?

> +       }
> +
> +       obj = buffer.pointer;
> +       if (obj->type == ACPI_TYPE_STRING) {
> +               ret = strscpy(sub, obj->string.pointer, size);

It may be simpler to allocate the memory here so that callers don't
have to worry about it.

Also, this is expected to be a proper device ID, not just a string, so
maybe some validation checks could be made here?

> +       } else {
> +               acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
> +               ret = -EINVAL;
> +       }
> +       acpi_os_free(buffer.pointer);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_sub);
> +
>  acpi_status
>  acpi_evaluate_reference(acpi_handle handle,
>                         acpi_string pathname,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d98..9bf18adf5920 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -21,6 +21,8 @@
>  #endif
>  #include <acpi/acpi.h>
>
> +#define ACPI_MAX_SUB_BUF_SIZE  9
> +
>  #ifdef CONFIG_ACPI
>
>  #include <linux/list.h>
> @@ -762,6 +764,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
>  #endif
>
>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
> +int acpi_get_sub(acpi_handle handle, char *sub, size_t size);
>
>  #else  /* !CONFIG_ACPI */
>
> @@ -1023,6 +1026,11 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>         return -ENODEV;
>  }
>
> +static int acpi_get_sub(acpi_handle handle, char *sub, size_t size)
> +{
> +       return -ENODEV;
> +}
> +
>  static inline int acpi_register_wakeup_handler(int wake_irq,
>         bool (*wakeup)(void *context), void *context)
>  {
> --
