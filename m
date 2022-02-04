Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6C4A9834
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiBDLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244242AbiBDLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:09:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7EAC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:09:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z20so7972585ljo.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 03:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF8mTd2pmhBF5RAYFm/abAs/390CCKWUzH/vxBmyCuw=;
        b=Qm3ePs5PTzeaH/qa0Q2egUZvLRYCnMkFvv/fKj5QkZzciiSQKCKTUUdPSJ3Pc0tOAS
         MhrifwdqWYRBpDTpFD7uH3aSRFNLf+7xEZRC7qmqNXodXhHqx1qj6Ry5vhAC5R/YvgH9
         6ClC3SSIe+SEpy0pq7TOyXLCwx0GKfgfVxs4oVQ4Fw/ylitoyKqQYqlRvJaS3Nv27uh6
         HULVW8hVbklMr/vDX61Do7cStaUggNNHKbfVDZ7Ky0GCKGgQ9Hgw1Y7W515sCWQpBWLI
         zWNKeibb7vJnCGmEeTBicCkNgOlaby5wioYXZZDiPZnwxewGwH0/EJeN2WQN9utaazgY
         yVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF8mTd2pmhBF5RAYFm/abAs/390CCKWUzH/vxBmyCuw=;
        b=s+wuFtYpQQjxOXrmYDH+cd55t28kiI5mNTALVDgXUwLnlHrhhJuzjfqR1EiKZDjKQY
         iKeW7qAQFAcu2An4PnV/Wjupp2ZEYEIdsS3GZlZiaOO2/Q1XczOBHt6e9ZcoRMUDnTXf
         rBKXOyahFbmKr08fPq5gBJfFvRpzFHmd6C1/snyM1uUBguXSPdamH0SG9bK6ezFb/lHZ
         k1DlIOfb/nk3RxCcXj5zOE+S4J11KjPBfXUqV2l6ofwMROEfLJDsmNKCIDG9tvtPrz9F
         Lu3QZUh0U0k56bPTHoa43eTohMyrbRQ4Ve67gpm4fSZ5LLYz0W6j/IvJs5gQYqZq0jG1
         DGKQ==
X-Gm-Message-State: AOAM530iirIL9IS9haAiVhixQCpCZnebWF0YRY+Jiv0NaqvpPRCfo3F1
        whQAqG7+o4UnY0BGZCjxtTnlBFcRscwAA2nqUn8hbTUyCE6pQlJ7
X-Google-Smtp-Source: ABdhPJwOZnJEtk/elcgbxLe+bNyDlUywLIw/TA+/NB0F5W2moDXZRY/U9dSPSC1OIOze1WlfMu7GBq3TmJ0qM3b09fU=
X-Received: by 2002:a05:651c:4cd:: with SMTP id e13mr1465252lji.511.1643972949543;
 Fri, 04 Feb 2022 03:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20220204093254.2467-1-phil.chang@mediatek.com>
In-Reply-To: <20220204093254.2467-1-phil.chang@mediatek.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 4 Feb 2022 16:38:58 +0530
Message-ID: <CAFA6WYNR_axHaFdbS3sy7pRYFOuTv7KyRe+aP8MywkGdh33NaQ@mail.gmail.com>
Subject: Re: [PATCH] optee: make tee_shm_register vmalloc supported
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     jens.wiklander@linaro.org, matthias.bgg@gmail.com,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 4 Feb 2022 at 15:03, Phil Chang <phil.chang@mediatek.com> wrote:
>
> This patch allowed the tee shm use vmalloc area buffer.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>
> Hi,
>
>  In some low-memory devices, it's hard to aquire large-orders pages,
>  this pathes is allowed user use scatter pages to register shm.

This kind of info should go into the commit description describing why
this change is needed.

>
>  Thanks.
>
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>

Also, I would like this patch to be rebased on top of SHM updates
series [1] from Jens as there has been a lot of refactoring touching
these files.

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/thread/3J2IJX5LG2X4CZBYDLVA4PDVM4APMZSD/

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index b25cc1fac945..937bcc7df8e4 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
>          * Allow kernel address to register with OP-TEE as kernel
>          * pages are configured as normal memory only.
>          */
> -       if (virt_addr_valid(start))
> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
>                 return 0;
>
>         mmap_read_lock(mm);
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 499fccba3d74..31d0c10485ff 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -195,6 +195,20 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>         if (flags & TEE_SHM_USER_MAPPED) {
>                 rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>                                          shm->pages);
> +       } else if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
> +               int i;
> +
> +               for (i = 0; i < num_pages; i++) {
> +                       page = vmalloc_to_page((void *)(start + PAGE_SIZE * i));
> +                       if (!page) {
> +                               ret = ERR_PTR(-ENOMEM);
> +                               goto err;
> +                       }
> +                       get_page(page);
> +                       shm->pages[i] = page;
> +               }
> +               rc = num_pages;
>         } else {
>                 struct kvec *kiov;
>                 int i;
> --
> 2.25.1
