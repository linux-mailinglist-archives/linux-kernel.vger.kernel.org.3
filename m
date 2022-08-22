Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2B59BBCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiHVIjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiHVIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:39:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBFC2983D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:39:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-33365a01f29so273467887b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vytT++BBKVvBIBKerbh2RZUg6dkm4MjxgE2EoTLroDg=;
        b=M39TtV6kr/7uScuJrmyI5mVZGwXatqZ1KOKxIGLS7bfQyauhweSWg6DSbva9396cRI
         XHj2pZ1svzWeiGqYJH/7DKLBe9KpGEOa7Ww5sOKc317CDXQebraW/O69odBhGbVac0iU
         VInjPhFVZ4tQavTcTz3+QyFI0+eeC2sKTVCovdDNfDnI1smAIJC9af0yh+C/8G8zGoDM
         wesxbm1azhWAwoU/wqPG2/01lz+dpvRzJWcNm9CwADiV6fVnAhIxnJCUq2KstkqSrgdY
         t+5bvM4+PfORb5QopN21sP09CCbTBtfr9OaC1MLm48CW+7+i6R8MCCmczGLuCvXYwGSy
         U25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vytT++BBKVvBIBKerbh2RZUg6dkm4MjxgE2EoTLroDg=;
        b=v1O28S028QSL4UrspEIsxLziBcTrj7utZbxfQpVX2TKvOz4xODESMHwSaTMfa5fQe5
         X2ws84jQJjXGVnKGuA5JXLIA2C0c3slTHxh4l/6g0wEJVdUp34UTTiZfUqqo68ngyqnm
         NVVL8BFzZ7eC2JvzZzKSN1UelwVaH396q90mz5a7GIMUfUDDIV9DIAZEPNW6+f9fJUXP
         Eps6XNyBMPfFEA7ENuQnPdaq/vXM9T/AyF5LeD+hy65M01jnyF0AmjR+pzA1qtvU4Ujo
         mw5PYh1pPTUtpOcwrF8bZPlcGNDmaS9DKiY80RCGaimFkpApRPo3lfTkhLmARsELm1e8
         jseg==
X-Gm-Message-State: ACgBeo0VWaBZZDP1fVLWmrdFZzOwbh2779rnkF8crymI6nIp5G2I1AKP
        7l+2ZRxAmOHi8TDxdeBpORqs5UEEGmHuCGcIzgFwZ17W4crNRA==
X-Google-Smtp-Source: AA6agR74s/BI2iC/YWWgKH6zt6NLrogOo6rWq/qAySoZRiKoeBTlX6H99BAtTcsMPFbuuI2PJg5URi+pfhxJ4xT5jKw=
X-Received: by 2002:a05:6902:722:b0:695:629a:c9ac with SMTP id
 l2-20020a056902072200b00695629ac9acmr11951508ybt.54.1661157583329; Mon, 22
 Aug 2022 01:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082846.3558520-1-jens.wiklander@linaro.org>
In-Reply-To: <20220822082846.3558520-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 22 Aug 2022 14:09:32 +0530
Message-ID: <CAFA6WYMytTKk_Z5u=6cd6JWCGp==jA9jDhC+oBboeZODGa+EOQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix compiler warning in tee_shm_register()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 at 13:58, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Include <linux/uaccess.h> to avoid the warning:
>    drivers/tee/tee_shm.c: In function 'tee_shm_register':
> >> drivers/tee/tee_shm.c:242:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
>      242 |         if (!access_ok((void __user *)addr, length))
>          |              ^~~~~~~~~
>    cc1: some warnings being treated as errors
>
> Fixes: 573ae4f13f63 ("tee: add overflow check in register_shm_helper()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 1175f3a46859..27295bda3e0b 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -9,6 +9,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> +#include <linux/uaccess.h>
>  #include <linux/uio.h>
>  #include "tee_private.h"
>
> --
> 2.31.1
>
