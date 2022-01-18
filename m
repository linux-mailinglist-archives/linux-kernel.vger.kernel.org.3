Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344249255D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiARMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiARMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:05:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C40BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:05:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x22so69620943lfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I53vlq5TczLCh/qDkdRQCtzn+r6orw5CjLVZN9/i/Fk=;
        b=yzC/4mAHnosV28AneVuC6T2g1CizSk8ZZ1Q5tErVt2Jynub2M/9tYfdGosNOKrcG01
         vwJaZ787EPZuy/xS7Of/6X7UG4PWmOMc+W9opa/jlGSdwLNjMBgG7I9/TOiEe8Tntvk9
         z9YOmzBFCgHMw+/ZLjE2morB5lPTRPL8S7rJvmXpNWafP5DosyI0/yhtM4eza66JjkoY
         MjW6Zw1JKUCsww4wCnDJjYNOCyUa9oDU2ONJbjoCy4q7shr/SumwiG6jTR6qiRKGnjAV
         g2acwVhIiKgKgZNVXSyyv5CrgqdlLkyhpz/zrMHsgAujbv8L/97b55ZQ5EVz2jwT8HGc
         6Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I53vlq5TczLCh/qDkdRQCtzn+r6orw5CjLVZN9/i/Fk=;
        b=Aw2fLdiyFqVZw+SSRWnWkDh4q+SFXtauQE2in43FK78pYvBvgFvrSK0ShZOn+dtC+2
         kcbYZ81rtXKyX6xTU2ke1z2hcyn8jmmsSpo7fgjeNP6GqK4riQWUiR5aaAEaInfi0e95
         zoF9J3M7LOqw9JnYJjs902RO0ITADKr9JOpw/a+6cLDEiUXwYZB7ITOlvQE7cQzPShjM
         fDPPNao1X39Gwqvtg57F/Mewj2CixIzIaxLCtJcjKudWnRfyy6jaNAgq1ZLSsi6xTh7I
         0vMljK3j2DiJlyg/z7O6pyOE0vYWHGblrajXqtjVeFtv+PKy5DjPYML3+fUwVT3A4eoC
         2Tdg==
X-Gm-Message-State: AOAM53306xCUQzkHaFd9zvAjoK1/ksq+DEXwPQJOlfHKs7ntbtsKb/2h
        z/IEawJE1r+wknTObIT6zCnkwSVGFO13haNF4yyCOD2Wqgt8/sEB
X-Google-Smtp-Source: ABdhPJwlFYXHXFnhZgIpQA33Z4468p+QpZ1jNsGt3fxkjpWaxO0upYtBoneJX2dklUWnvAqcJMRxnJzmVj1C/ONZ31E=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr2147034lfr.253.1642507552369;
 Tue, 18 Jan 2022 04:05:52 -0800 (PST)
MIME-Version: 1.0
References: <a4e48364368cce3c91005a3bd4fdacee086ef00d.1642087405.git.jerome@forissier.org>
In-Reply-To: <a4e48364368cce3c91005a3bd4fdacee086ef00d.1642087405.git.jerome@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Jan 2022 17:35:41 +0530
Message-ID: <CAFA6WYM94k7n3mXA7UpGxL=J5TYJFXSa6KWhqjHPzS63SrNCpg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: do not check memref size on return from
 Secure World
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, 13 Jan 2022 at 20:57, Jerome Forissier <jerome@forissier.org> wrote:
>
> Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
> from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
> refactor driver with internal callbacks"). Remove the unwanted code
> again.
>

Ah, that's unfortunate. The refactoring that OP-TEE driver has gone
through to support multiple ABIs (SMC and FF-A) was huge and I missed
it during review.

> Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  drivers/tee/optee/smc_abi.c | 10 ----------
>  1 file changed, 10 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index cf2e3293567d..09e7ec673bb6 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p, u32 attr,
>         p->u.memref.shm_offs = mp->u.tmem.buf_ptr - pa;
>         p->u.memref.shm = shm;
>
> -       /* Check that the memref is covered by the shm object */
> -       if (p->u.memref.size) {
> -               size_t o = p->u.memref.shm_offs +
> -                          p->u.memref.size - 1;
> -
> -               rc = tee_shm_get_pa(shm, o, NULL);
> -               if (rc)
> -                       return rc;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.32.0
>
