Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB58050BAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448637AbiDVO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449081AbiDVO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:59:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F95D186;
        Fri, 22 Apr 2022 07:56:30 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7b815ac06so11962137b3.3;
        Fri, 22 Apr 2022 07:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnk4bSj33w5ONisLnwinOIO7YU3rJXD/3b8GbGFERCE=;
        b=E12yFrBdzYPrVMbJJjpCVlXi60AXLTav8pCp/kxWPPXCEzDTBtGphnD3DdcVhOWYTx
         8NjdeeO+OVOnBGzm3P7x7qZIcYy/xFTWLXVJ8RWqXpZavJuv7X5DGCmHKXvWyarYB0We
         xYQQOOv+LCxQBCs7CjHlSAUYYXZ2h5WkD78Nkoo8ZgK7rgdYIXBFOThfagCga2BsM96D
         qhU3Sh+HT3i4+nIl9Z+nZ2gmtRahl3nSxg1aePctZPePNSydZYSm8UElVqO3Dd4P432u
         q63WAKoxyzg9Frr9Zg5FeFIOf2JGchDVuOn1Z4O8L9rScwBc32KJta46uDBbiJaWN9Ku
         Qeew==
X-Gm-Message-State: AOAM533+dzmX/hxNIimUC0ojGHNAxYqZ9eXWAlmCT3TOmg72WBEUO2fi
        kH+pxkGX5Ktv2BU9FcpbnmwJkQh+Uxw8XRWG+1U=
X-Google-Smtp-Source: ABdhPJy9tUCk3u0oHHIxt4bXYYvuVAO1Op8RV37m9A9G2JbZP+QlSKRnH/d505sobWKnaOhGdpxMcgvKT2yynCLRBOg=
X-Received: by 2002:a81:1096:0:b0:2ec:4a46:7e5a with SMTP id
 144-20020a811096000000b002ec4a467e5amr5412135ywq.196.1650639389433; Fri, 22
 Apr 2022 07:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220421164254.859162-1-trix@redhat.com>
In-Reply-To: <20220421164254.859162-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:56:18 +0200
Message-ID: <CAJZ5v0jJUOXs=RDJLnDSp40i7FdaLGfb=GN-wVifd0UJ-gtEMA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bgrt: use static for BGRT_SHOW kobj_attribute defines
To:     Tom Rix <trix@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 6:43 PM Tom Rix <trix@redhat.com> wrote:
>
> Smatch reports this repesentative issue
> bgrt.c:26:1: warning: symbol 'bgrt_attr_version' was not declared. Should it be static?
> Similar for *status,type,xoffset,yoffset
>
> These variables are defined with the BGRT_SHOW macro.
> For the definition of bgrt_attr_##_name,
> the storage-class specifier should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/acpi/bgrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
> index 02d208732f9a..e4fb9e225ddf 100644
> --- a/drivers/acpi/bgrt.c
> +++ b/drivers/acpi/bgrt.c
> @@ -21,7 +21,7 @@ static struct kobject *bgrt_kobj;
>         {                                                                       \
>                 return sysfs_emit(buf, "%d\n", bgrt_tab._member);               \
>         }                                                                       \
> -       struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
> +       static struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
>
>  BGRT_SHOW(version, version);
>  BGRT_SHOW(status, status);
> --

Applied as 5.19 material, thanks!
