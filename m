Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739B48EFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiANSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:09:31 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:38857 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiANSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:09:30 -0500
Received: by mail-qt1-f174.google.com with SMTP id bb9so6035407qtb.5;
        Fri, 14 Jan 2022 10:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWFRqt1snG0vKk4A5HswSbVNh90av8m781UEgmU/+DA=;
        b=11KrcIlSxri4kn5ralE0W0fEdSHvTSkjo9NcwZ8ksO0/f6VyVgxGz2JHds4PdYX3Kb
         5wzjpLm5D4NL/qaB7YQuYUNe4aOi7u8OcIlNKtw4Z1o7oArc+OIYIc/V9v5qD8vzLE77
         LU9tCQK/KGrzavyT2YaxBSpAa/LLTQkhC1MA11dXVi5njdRij2sw91QIlYdVnwHbXWYu
         BC5Me686GO5XGYY4hLrVIgso7M78zumoZDOG5fl40UZEBM+WOBCAarTHEnmchiYqHod+
         kf9Uvx96wEtQce5eRNhLw9w2+M8xiW+c0W+rrpV3dXkspsJDsbOwx7hSKynu0VSbb/A5
         v9HQ==
X-Gm-Message-State: AOAM532Rg5uKhvTqLcudKNvkKoQY9Gyyj56knbcX0H9E4CwzxmXd3e7a
        gceg3HFK6UX8vZPH0K4tUAe07XOPcSjPwhpjnAw=
X-Google-Smtp-Source: ABdhPJxTXfPOTcCz0073xhS4n7Az6/FPfBKGiajhOEWK/wDX6tVYGQV2jg6sy6ywX29PPSDXNZb5nySCtjg9+CHTlOY=
X-Received: by 2002:a05:622a:1881:: with SMTP id v1mr8653852qtc.327.1642183769801;
 Fri, 14 Jan 2022 10:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20220114101546.1368163-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220114101546.1368163-1-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jan 2022 19:09:18 +0100
Message-ID: <CAJZ5v0j5LVV_gV_K45YqFPqtBcS423VP0x_Uos7MtKBeqWkg5A@mail.gmail.com>
Subject: Re: [PATCH] ACPI/ACPICA: Check for NULL pointer after calling alloc
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:16 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the possible failure of the allocation, object_info could be NULL
> pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> If fails, we should return 'AE_NON_MEMORY' and the caller
> acpi_db_command_dispatch() will deal with the return status of
> acpi_db_display_objects().
> Also, the comment of the acpi_db_display_objects() is wrong.
> So we need to correct it too.
>
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

This is ACPICA material, so it needs to be submitted to the upstream
ACPICA project via https://github.com/acpica/acpica, thanks!

> ---
>  drivers/acpi/acpica/dbnames.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index 3615e1a6efd8..d8e5852fadb1 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -632,7 +632,7 @@ acpi_db_walk_for_specific_objects(acpi_handle obj_handle,
>   * PARAMETERS:  obj_type_arg        - Type of object to display
>   *              display_count_arg   - Max depth to display
>   *
> - * RETURN:      None
> + * RETURN:      Status
>   *
>   * DESCRIPTION: Display objects in the namespace of the requested type
>   *
> @@ -651,6 +651,8 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
>         if (!obj_type_arg) {
>                 object_info =
>                     ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
> +               if (!object_info)
> +                       return (AE_NO_MEMORY);
>
>                 /* Walk the namespace from the root */
>
> --
> 2.25.1
>
