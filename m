Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069B5522F34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiEKJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiEKJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:19:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EAF994FA;
        Wed, 11 May 2022 02:19:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c12so1761267edv.10;
        Wed, 11 May 2022 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FWrA/1HzsR1Fw7JiPrCjDIP8RO6iLoamwA8NVbBFUo=;
        b=Kh6KdaD3Nhovfjm7JjbOXwHoQ0DWkIiuyZ9Ryxi3zqwlh2155hYLOYHNjSdCulB6rM
         mLwubuJGzueqRvehPlqLSJcbWilLD5nDJe8cM7MMpV2tqtzmwnkYq0KPDa4XB87BLU+b
         Ih35NwEYpri6s3gzhIaxoicAlqeGe6xluEnB1NTg3aPmGVRasxlqrBEjhKjGAqQ6A7my
         0miUYrGrITe+fH7qExkXsYgN5X4zoGPFlfRulnBSa60vPo7DHkMKPrH45I5aJbtl3Icy
         WZrKo2mpbBU/GIErsrDThWA8VzpYsN1t6z1+atKnyYGvz2Lsn+nfY9ZlVxrVYJeq0cP0
         WahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FWrA/1HzsR1Fw7JiPrCjDIP8RO6iLoamwA8NVbBFUo=;
        b=r6whHcXXYnhV1sgC9yvQmhSrcS8OITm6QDK4Mm0P7SvdDjI9KDewP5pH+D7VdXU3Qb
         na437s03B03nB2I9YqMWL/kjUZliZJUMNnh9gz36aXp3udvohEYWGo6YvbBL+UUak5Ta
         1OOlVp2lghDh1IK77fnhjR+NlPHCmm2ZGa4jl8xF/fXBLIT+kQRLyusyVftVR4RyHbVi
         kBaNaHiYgJq4nVJqRNvziCnZFtslaJEMnDKys4FSiePT3AtUgbh43qE2p8PDZurTgYHD
         gmWhBKJLxIHn5lmrWXxbNVi1KsRZnRQt3Rv0LTiVCTHNGgaZ/0OJchoRsJU77c0+a8vd
         NnoA==
X-Gm-Message-State: AOAM531z4TFpcrNVtCB7skboD82itEy1Sqhi+s033BsmGPFt2y1udcxi
        +nBg34DwzZL1vHIg+TcrZ2+OH1kH7iMCThX1UeI=
X-Google-Smtp-Source: ABdhPJyAjMMACQ/bMvn1oWN7KSjTqhuM5w1KxcOEaFqspEIDacs06uc3fJkNWxX1AYsfrzNZC7aM8vxNcKf/ufHeAbg=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr27783655edr.296.1652260792848; Wed, 11
 May 2022 02:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfzbWAS6phV3eB7ehe50NrXitkuS54sYjdVK-OqqYVieA@mail.gmail.com>
 <20220511021638.1488650-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220511021638.1488650-1-chi.minghao@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 11:19:16 +0200
Message-ID: <CAHp75Ve3ur6_jpd_wOP29CEJF8VvyG+e_Wn7dfa8N=vRHedoKQ@mail.gmail.com>
Subject: Re: [PATCH V2] toshiba_acpi: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     Minghao Chi <chi.minghao@zte.com.cn>,
        Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:16 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
> v1->v2:
>         remove Reported-by: Zeal Robot <zealci@zte.com.cn>
>
>  drivers/platform/x86/toshiba_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/toshiba_acpi.c
> b/drivers/platform/x86/toshiba_acpi.c
> index f113dec98e21..0fc9e8b8827b 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -2353,7 +2353,7 @@ static struct attribute *toshiba_attributes[] = {
>  static umode_t toshiba_sysfs_is_visible(struct kobject *kobj,
>                                         struct attribute *attr, int idx)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct toshiba_acpi_dev *drv = dev_get_drvdata(dev);
>         bool exists = true;
>
> --
> 2.25.1
>
>


-- 
With Best Regards,
Andy Shevchenko
