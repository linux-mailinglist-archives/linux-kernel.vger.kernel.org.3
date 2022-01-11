Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9848B0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiAKPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:37:01 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45037 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243782AbiAKPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:36:58 -0500
Received: by mail-qk1-f173.google.com with SMTP id q192so3359579qke.11;
        Tue, 11 Jan 2022 07:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKbMPGSxsZYgRIJnEQcbNOJrCU9g0etr89yBb4AmgEU=;
        b=qi6yziUIF+UGmsiMTZHD4ctUDVdooz2vOB/rma36r6ZlQWXlX7hIPQXd4in2YeTaie
         RsTBYOA2A0TelOUQe/T/qI5rR1VS82Cw4poGG0R6XEwIOyWWwarg5w4JfBsCObT5ezb3
         VlS6148q7GuLaEgIadXbtY6bxw5Wk9jMlFxoMwjtF5ZfDCxLBu/jauM5x7OWy//6KhGw
         b4W9bPvP1qj4Ndkg1Q22hfFAP7Geiw4ekYW3xN2tNwKYT7X5fDgYeeF7mCBCqiVQqsaS
         81ukhIeYhM7puiO1O3gp3OBHQqXx34+ZfVzvkRyfIrYpfZ886dDaV2NErrMDvWAyXWqK
         S/pg==
X-Gm-Message-State: AOAM533xKIyBXjDBbmdFBzEzEAGVoaZGV7x5xgRRKtBFk8nKMP47RDMa
        MsdVBHjHXA+kywN18m4A01z8DlRyV4FSTu7Himo=
X-Google-Smtp-Source: ABdhPJwANupgS7MNSWqY2eYVMNKeo+Ocyd4789CrYkao9qs8ATSZZtXuJkxq0CXenMAIhEzvvxhmBVh7prdrhV4szQU=
X-Received: by 2002:a05:620a:1a97:: with SMTP id bl23mr3548929qkb.621.1641915418130;
 Tue, 11 Jan 2022 07:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20220107033516.3611664-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220107033516.3611664-1-jiasheng@iscas.ac.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 16:36:47 +0100
Message-ID: <CAJZ5v0i8JgHk9R2_NsS=5joyhnng9g8eePZox7gsqC9yHpcvLA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APD: Check for null pointer after calling devm_ioremap
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 4:35 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the possible failure of the devres_alloc(), the devm_ioremap() may
> return NULL pointer.
> And then, the 'clk_data->base' will be assigned to clkdev->data->base in
> platform_device_register_data().
> And the PTR_ERR_OR_ZERO() can not detect the 'base'.
> Therefore, it should be better to add the check in order to guarantee
> the success of the setup.
>
> Fixes: 3f4ba94e3615 ("ACPI: APD: Add AMD misc clock handler support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/acpi/acpi_apd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 6e02448d15d9..9db6409ecb47 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -95,6 +95,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
>                                               resource_size(rentry->res));
>                 break;
>         }
> +       if (!clk_data->base)
> +               return -ENOMEM;
>
>         acpi_dev_free_resource_list(&resource_list);
>
> --

Applied as 5.17-rc material with a rewritten changelog, thanks!
