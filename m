Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43748C887
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349911AbiALQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:34:52 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:42909 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349922AbiALQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:34:14 -0500
Received: by mail-qk1-f170.google.com with SMTP id c190so1532401qkg.9;
        Wed, 12 Jan 2022 08:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0N0dPN3O3RZBULsdprAK0TPmoiFmNasZOU3EoQJ8BQo=;
        b=p+mSBlVeeDYomG0z0/5alW2pGuSgGnm0qnbZh0OZMRtvVTq5ZOwQDeQ891qhHTiJnh
         YfM3LkfHfMgXiNLUa/v7hQsRRLrmdgyNsSZsrWbsmgaDcr+LuEWj/PIR06AFZkxptvWa
         BiSNZ99ogigV92Q+9f6OkE9huytWl+E+qcIi5zYqXF+IF0o/VF5xPpbzjgvOtP8hUMgG
         iYQGRYDyukm8v5dgvGf+df3ci43JqyLPt2LQD7hKRAUUp+MEzKRvfvnQtyjo7bkfkMg5
         BA1nWPQX/E3X6UNfLhiPSYWwa7VnTlKW6+XTPJipNbjqxwjLzD7oTCxnVrteliKth3qo
         X2uQ==
X-Gm-Message-State: AOAM533cET0hqCjEms5FrCULBd86VUo2S4HEGLx3VuQnO7Mr9JA2J+at
        wXZzNgbwYwBlbehc61c1PKxskwU8y9uIcz3WWK4pUpj1
X-Google-Smtp-Source: ABdhPJzjopvb12tK07oUFeqfdMnPiZhPPatJI4OEBTP9c5OaTnk5QUzQYpFLSvTxCVZiIabjRFyDFjoqJnHhstBxpO0=
X-Received: by 2002:a37:b702:: with SMTP id h2mr391026qkf.135.1642005253779;
 Wed, 12 Jan 2022 08:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20220112080155.666868-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220112080155.666868-1-chi.minghao@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jan 2022 17:34:02 +0100
Message-ID: <CAJZ5v0iipOm6DX3Fd8iNKF_LC6kJWCy=1LxFsh47z01UYDrRow@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi/apei: remove redundant rc variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 9:02 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Return value from apei_exec_write_register() directly instead
> of taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Well, this doesn't look like an e-mail address of a physical person
which is required for S-o-b tags.

> ---
>  drivers/acpi/apei/apei-base.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index c7fdb12c3310..87145b6b89aa 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -125,12 +125,9 @@ EXPORT_SYMBOL_GPL(apei_exec_write_register);
>  int apei_exec_write_register_value(struct apei_exec_context *ctx,
>                                    struct acpi_whea_header *entry)
>  {
> -       int rc;
> -
>         ctx->value = entry->value;
> -       rc = apei_exec_write_register(ctx, entry);
> +       return apei_exec_write_register(ctx, entry);
>
> -       return rc;
>  }
>  EXPORT_SYMBOL_GPL(apei_exec_write_register_value);
>
> --
> 2.25.1
>
