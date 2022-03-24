Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B864E6057
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiCXIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiCXIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:30:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098B39699
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:29:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f3so2186527pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJVDDC1/aI1jcfE8sKjVoDZT3m6DF4lZuEhWJoKe5x8=;
        b=fJxRDF5IKhdvpzTw6A6v3h7zyuPn/FgdGBUxxML5DKTW755N8I3ZVqaer38smFKcH0
         OFooySyWDHubZKdVc9mNAcjHeoYxKUKj6FDpGl/rlUD0AOX3j3sVoUpufPmjJieVm6BN
         PE+9wKjY/dk8IPjTjmdk4+1UVqeaD15iqWavCYTvbTPEupgyZFC9Y9glPnp0XhstsK0G
         F9FLYxpES5KOqwhvy5qTuvIMHJYx1vcPFG5DKYHswYv2lmK9nQmxeuC31kgDbtJFJ7dN
         yu+HELd8MRApRhFJ//8eg9amyeIxquPFH7NbX1YQ+Q7blElkHA/zkLtfD0bTGVrBI9xg
         nX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJVDDC1/aI1jcfE8sKjVoDZT3m6DF4lZuEhWJoKe5x8=;
        b=J4x+R9axfxxy1gVj8aiERf7bEcHi0j2RNK/DEZR4KgzT3dLcY+efYBlXoV/xg1p1RJ
         FGJ+kpDLtukriyE4/O1pPUGqEZWCqAyb5Dj/HvNyI1uVTMJbRaBc59U98hDRGtS8BGyV
         LLD3lVtsz+lOEbf9XxX5OwaOhbQQ79cFW8b3IBfVA+bnG4s/trnZZKPugL1/yym35aJ7
         n0uY+yEAV5WSpSkOpSmcrtnHxpT3xojjqXIjAknn3qMi1OoMNBoWW4L/Um47Ack9nFN9
         3mNxALT/xiRr64PRnIRnfFZOIem1EhGx+HRtZzmcKqr7qUqQhJn+FjNA26bOPH6xWjlp
         h8qA==
X-Gm-Message-State: AOAM5335uYtWLdiG+uz1zr7jawPXZWZ9bc6AhCY/nBLg+tN0ktF1voIe
        9jy6vWsur0lBXuQs4wy8FBzAs/X911INrYoA9f6BFQ==
X-Google-Smtp-Source: ABdhPJxTnv7uaOKI9ewe9S1zYl/4CTn+xrZRyF6u3SPpEm7e+MAYuc1RJH22etz6MknOmh3yJBJZGkRyrOsOBfti3rM=
X-Received: by 2002:a63:1649:0:b0:382:2a04:4136 with SMTP id
 9-20020a631649000000b003822a044136mr3096202pgw.568.1648110550371; Thu, 24 Mar
 2022 01:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220316135047.188122-1-dzm91@hust.edu.cn>
In-Reply-To: <20220316135047.188122-1-dzm91@hust.edu.cn>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 24 Mar 2022 09:28:59 +0100
Message-ID: <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
>
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>
> The error handling code of optee_ffa_probe misses the mutex_destroy of
> ffa.mutex when mutext_init succeeds.
>
> Fix this by adding mutex_destory of ffa.mutex at the error handling part
>
> Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")

I believe this should be
Fixes: 4615e5a34b95 ("optee: add FF-A support")
don't you agree?

Thanks,
Jens

> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f744ab15bf2c..30a6119a2b16 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
>         optee_supp_uninit(&optee->supp);
>         mutex_destroy(&optee->call_queue.mutex);
> +       mutex_destroy(&optee->ffa.mutex);
>  err_unreg_supp_teedev:
>         tee_device_unregister(optee->supp_teedev);
>  err_unreg_teedev:
> --
> 2.25.1
>
