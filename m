Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6474610CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbhK2JKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbhK2JIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:08:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D662C0619EE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:54:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so35008943wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdbmnS+qzLGOllg3djt0Vc9jKzn0JxQCsXs8x0oCc4I=;
        b=KeccHo9atcNeuiNWN+Ndzepjkl3AIUK+7coGl8mdb/hVrIIbpYYRzvSwUDM5xNo8Sf
         W5k/T/Cn0vY76O7xPQbICDSacxYyjLeEz8lm+yayw4JxjqgBD4emyQ+5EM7zV4QDjHja
         Z7OJxAcFmoAB70ZYONkBFUInI2drj3za9CL17nj6ESCOYcudapuX3wFjhUicFHwFL4Dp
         GKOBGmwZU8MD6IycKnXZz/vkzM9EnizV7NMsMJGDMph+0FQsjEr0Q9zs4Lv07XLXHDKk
         JsFUPjymF2vjiyKCELvrmFH7NGWrAdK/KwxUCbrL/7F++WK7Lqtzk3mlXZK69UKSVEMb
         qiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdbmnS+qzLGOllg3djt0Vc9jKzn0JxQCsXs8x0oCc4I=;
        b=JNXCPdJe0df7D/qn0NyjIAphVw3sKQNBL2ABhkfzqUhd6V3ZLMMI4YDR6AOqyHYUJq
         r+czinnzM89HIrG1rpUPi0Ugo//GEbxrIp9kPP51NyofzHEzAxzujCDy9KMiR/uElSEE
         7ihxoEkdFYI/Ix4IOrQLR9LfySf2r9Hhh2myzB2NS2wPu9/rDEZnls+uWrMYn0tjCa1O
         x3JZTgqeTfTFjdxN57wSpvMfwpY8aiP1mxuSxonxuKXCe9dz+RtVsUZ5QXsKnnlGffm/
         w0yRWNnq3OTJx0FuGKg7c63vpEAXEhFzTtsxWAZNTfsk+3zJcgQiTuVxLNTQmPMb+Hac
         q7Tw==
X-Gm-Message-State: AOAM533WnxT72V9ThrjkDqgYowWQJ/fdFCGER8Giwn7CTnYOu6IHvyWr
        B6OsK3/eCecKJ2y2GdV36ZCWTFlCVl2eq1M01g1z9w==
X-Google-Smtp-Source: ABdhPJxSF0VP/OU+iGTk9mt5FUfOa0tVaHNn4XBMaogEfRyPYlIl3CDUA7CLhGH6suY9UWZUZWe9ydAjsnAWNY2vhjk=
X-Received: by 2002:adf:ed52:: with SMTP id u18mr32072433wro.609.1638176057777;
 Mon, 29 Nov 2021 00:54:17 -0800 (PST)
MIME-Version: 1.0
References: <1637547650-4205-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1637547650-4205-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 29 Nov 2021 09:54:07 +0100
Message-ID: <CAHUa44F=QVxRN1k6-fX1Xw17+gwjBbOedWLKMAD5a6MjsWtBJw@mail.gmail.com>
Subject: Re: [PATCH -next v2] optee: Fix NULL but dereferenced coccicheck error
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 3:20 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./drivers/tee/optee/smc_abi.c:1508:12-15: ERROR: optee is NULL but
> dereferenced.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>
> change in v2:
> --According to Jens's suggestion
> fixed as:
>         if (memremaped_shm)
>                 memunmap(memremaped_shm);
>
>  drivers/tee/optee/smc_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to https://git.linaro.org/people/jens.wiklander/linux-tee.git/
async_notif

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 92759d7..d7c8235 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1505,8 +1505,8 @@ static int optee_probe(struct platform_device *pdev)
>         kfree(optee);
>  err_free_pool:
>         tee_shm_pool_free(pool);
> -       if (optee->smc.memremaped_shm)
> -               memunmap(optee->smc.memremaped_shm);
> +       if (memremaped_shm)
> +               memunmap(memremaped_shm);
>         return rc;
>  }
>
> --
> 1.8.3.1
>
