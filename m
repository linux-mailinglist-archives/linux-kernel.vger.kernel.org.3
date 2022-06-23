Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6737557CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiFWN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiFWN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:26:07 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE849CA5;
        Thu, 23 Jun 2022 06:26:07 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-317741c86fdso192022367b3.2;
        Thu, 23 Jun 2022 06:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VSbXb30dR2Lsb/63hP9yztOqR+GVnXbxsPEVXZX2P8=;
        b=jVMs100MVogt/YYqOiULAATiSYeusG2/qfrBiT7Dmgv5CHxWdGPLoG9xiaT7DZFYQc
         fQwXG7zS19k5LNgWVyOY3MxF9tErAn07JrqwNkLl7VYQ6XnnBAXJjw4gPx/JGzTFiBn2
         9OYOEQqZ37dQt/dJaAJEhZQN2+m+wIFQQVlQJvVo1zKVsPnnGnPnUQDkeb5mt5D/L6cJ
         tgfOWsw77zGtRt+n2VchR4T4JvTkZPgEvMO3scNdLWdjszj4SKyhnI4qjXvvZheSiF0Z
         R6lzH6wPBZ5tKT+Lj7B1+sTlkzRx2EEWz0zPzGswSTQ9TbN/sONYRkPIs6XpUH1215nw
         i2bg==
X-Gm-Message-State: AJIora/t+Y0NHiL7jij4KBqhfMzPJvfh7hCpaDdgXVnvlJOO/LpGhS4J
        ROLM/uwgdYzFGAtuj5WRMouaOTEJ6zsFtgeFgyw=
X-Google-Smtp-Source: AGRyM1s7TdfF4QH60jlRgW7nEFszCDJjTJ91XlVDuBvNebPGObfQ8O8xILdj9DSY5swk/zGpkmwc3De3uXMZw8GAYvI=
X-Received: by 2002:a81:68d7:0:b0:318:11df:a40d with SMTP id
 d206-20020a8168d7000000b0031811dfa40dmr10924585ywc.196.1655990766614; Thu, 23
 Jun 2022 06:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220623132127.1248462-1-15815827059@163.com>
In-Reply-To: <20220623132127.1248462-1-15815827059@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jun 2022 15:25:55 +0200
Message-ID: <CAJZ5v0jC+B7K0uuE=wLi1hk+WATn5B8sSu6abSO00rYJ4ofRFw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPSS: Fix missing check in register_device_clock
To:     huhai <15815827059@163.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huhai <huhai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 3:21 PM huhai <15815827059@163.com> wrote:
>
> From: huhai <huhai@kylinos.cn>
>
> register_device_clock() misses a check for platform_device_register_simple().
> Add a check to fix it.
>
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  drivers/acpi/acpi_lpss.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index fbe0756259c5..c4d4d21391d7 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -422,6 +422,9 @@ static int register_device_clock(struct acpi_device *adev,
>         if (!lpss_clk_dev)
>                 lpt_register_clock_device();
>
> +       if (IS_ERR(lpss_clk_dev))
> +               return PTR_ERR(lpss_clk_dev);
> +

Why not use IS_ERR_OR_NULL() instead?

>         clk_data = platform_get_drvdata(lpss_clk_dev);
>         if (!clk_data)
>                 return -ENODEV;
> --
> 2.27.0
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
