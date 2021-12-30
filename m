Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14A2481E21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhL3QcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:32:01 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46734 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241210AbhL3QcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:32:00 -0500
Received: by mail-qk1-f176.google.com with SMTP id 202so19371581qkg.13;
        Thu, 30 Dec 2021 08:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMR3MPLmeBapB7tPMkt4p+dub4AFSu/Ecw/CYlkb3Qg=;
        b=4SktJ7eJ//akFihWoES9GihNDcsgoA1gFgiq5aoTtyEUSBFSPsZX9L4P5HqLxXSmQ4
         5HCB3X4giCSGyNZIVIy4ScKfSsLg8K8DgbTWH4595i5T5dhXOl0LTv4dF+Jl0gJLOKPK
         sUGLxRT6OLJqODTI2XFxnUCNCdxjrbW+L7KivUSxjwp2epoxH2WTEmwu1Jrn3ZdoDoaZ
         n2LIO+eNPE4P2e8gyeSvKbn9hOl6o0knX61rH0I/Uq89Gi75deNjDSDd3OD0GAGAbO4V
         lHl89an1ESg+5IRfq3XczsB/L5DkE8lCpTZvT0iiDiOgnihKqjOKnK1vycc6bJYx6Zj7
         HAcg==
X-Gm-Message-State: AOAM531i0Iw7i4laRQu39sLGEFuFwlX3CGbxCD4AJy8bJ7tgdrNeMDLV
        d6WdkqLYtnY+nbPTYgXlYmWsLzroft8pkB7o6nY=
X-Google-Smtp-Source: ABdhPJzsKgoPVIRt1f1dGhol687DGA5SJ3uvWtKWwXyUEjSvbZ9NpgoMTPiBslL5ME5a+nsfvibwS/JBDv0D7eRoe9M=
X-Received: by 2002:a05:620a:4721:: with SMTP id bs33mr22857201qkb.8.1640881920167;
 Thu, 30 Dec 2021 08:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20211229174058.11350-1-shenzijun@kylinos.cn>
In-Reply-To: <20211229174058.11350-1-shenzijun@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:31:49 +0100
Message-ID: <CAJZ5v0jef5a=3w6bsh6CwEYixTwVgTaT6BBwYym3Sut6KToJsg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: DEBUGGER: Add return value check to acpi_db_walk_for_fields()
To:     shenzijun <shenzijun@kylinos.cn>
Cc:     Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jinzi120021@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 10:41 AM shenzijun <shenzijun@kylinos.cn> wrote:
>
> From: Zijun Shen <shenzijun@kylinos.cn>
>
> The function acpi_db_walk_for_fields frees buffer.pointer by the
> first ACPI_FREE. And then uses the second ACPI_FREE to free
> buffer.pointer which may assigns again in acpi_evaluate_object.
> It's necessary to make sure that buffer.pointer get a block of
> memory in acpi_evaluate_object and acpi_evaluate_object return 0.
>
> Signed-off-by: Zijun Shen <shenzijun@kylinos.cn>
> ---
>  drivers/acpi/acpica/dbnames.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index 3615e1a6efd8..7a2d980cb2b8 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,7 +550,10 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>
>         buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               return (AE_OK);
> +       }
>
>         /*
>          * Since this is a field unit, surround the output in braces
> --


This is ACPICA material, so please submit it to the upstream ACPICA
project via https://github.com/acpica/acpica/

Thanks!
