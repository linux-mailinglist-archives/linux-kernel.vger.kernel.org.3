Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FD5AC0CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiICSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiICSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:33:16 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C48558F3;
        Sat,  3 Sep 2022 11:33:12 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id e126so679105ybh.1;
        Sat, 03 Sep 2022 11:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q9iXspB/AOKZB0tpJddHuEq0bJG5RPx5NNXdeYJsIbE=;
        b=q9owDeS+sgWYn/aDiOdT0HAupsJJ5is87fYwisnjsEy5cLncQffGfyIihefq5PRRHN
         FtEhEgAE2EkpSh9TDFbVCdGuWJWJGizcQ88gGfeuCWV+YLv+OcdO4BMxBaoNXKBtqzt7
         GGmlRRP9puYqZi68lRjO+p3u3+MWMBTYvvHoED8M5n88HkQqWwDBbjX3I18ZULiyor/i
         YdXbf6YUv6DMUMCvWPr2YXaG5k/nj1faxoldbskiv1Hpv3ejz27erENi4/TP1g7vY7Ka
         bVoLiB0cY0w/r48BEiAeeKvYHaMKTer6MWoByjJ2jnmT5dlLqSI2vSltBGA++ksV+fZj
         fKKw==
X-Gm-Message-State: ACgBeo1OrE8lPlKbafSMAJC++vYjWc7v4rh34RGkqIo24aXqjYdLur9h
        BsPBMrueY1GRwSZ8beuNzvUkIwCO3P3O3AJy7wgfJfZE
X-Google-Smtp-Source: AA6agR7x5dmEYsR3uUtBzTLtJ47W01LCYmJZHUC/sA2d/N/tS7TLrk+vIkDHwq4i8KPC3z8fguk9RwPeeZD//fA2Bcw=
X-Received: by 2002:a25:d154:0:b0:6a8:cfcc:49e8 with SMTP id
 i81-20020a25d154000000b006a8cfcc49e8mr1888772ybg.482.1662229992141; Sat, 03
 Sep 2022 11:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220825072744.229231-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220825072744.229231-1-ye.xingchen@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:33:01 +0200
Message-ID: <CAJZ5v0jJ1Lzk4ZJ3QWpwQiJot0T2Jx0e8=0iXGYGU7+0gvgPXw@mail.gmail.com>
Subject: Re: [PATCH linux-next] ACPI: EC: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
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

On Thu, Aug 25, 2022 at 9:27 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value acpi_ec_write() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/acpi/ec.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index c95e535035a0..9b42628cf21b 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -917,14 +917,10 @@ EXPORT_SYMBOL(ec_read);
>
>  int ec_write(u8 addr, u8 val)
>  {
> -       int err;
> -
>         if (!first_ec)
>                 return -ENODEV;
>
> -       err = acpi_ec_write(first_ec, addr, val);
> -
> -       return err;
> +       return acpi_ec_write(first_ec, addr, val);
>  }
>  EXPORT_SYMBOL(ec_write);
>
> --

Applied as 6.1 material with some edits in the subject and changelog.

Thanks!
