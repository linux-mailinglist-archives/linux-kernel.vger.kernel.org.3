Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C94E611E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349215AbiCXJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiCXJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92811C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:33:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qx21so7869649ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zFKrt6to1eZyq9gMngL7L6t1LrZeAjIbbXsxuEEFtQ=;
        b=UGplhL4bkgbtu4kUdigKsfDB9kLRsc1aKOw3FvV9qID5fExTEXd6AphhxYsbIRify1
         XuhAgX1C3j1Dpfz/ZF8p/4ksUUVdTNSVZkK9HrxcYHpPaPdc0s6NnmK8QRpVR8czieA1
         iCvH1coPkyudiVu1Oqw5ILjBJ17u302LvDo9mM4XQtQvdquZFysuD1CusT+RtrUSbmeH
         nFbgQ8JOm0vzocHgTqJ3P/foVWf2XepyS1dZw4ltLjyllKmHv8d5X6PzhNCC0gjUS2lJ
         GIwlFspTRxrpO969nWaffCtzU6OW7sW7V6XwPDijzk+5O7WmECfSNSmL09bHz5EU2VDW
         Q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zFKrt6to1eZyq9gMngL7L6t1LrZeAjIbbXsxuEEFtQ=;
        b=mHquoNTp1xpnTJtV1TMQc8Ve4+jHSMWIopBQ4flpNJDV63Ibzcxk04aEVigom2G/Sb
         4UCpePSJO3bMYcSRqJATkMJnL50JxfhZX2qtP900PlG+zbt4lM9w8VP9LluPJtlg0F+S
         kY0wt7bINdGZOutir1H+kjPVdC6mZcM3g/MFDJbemaMLzUBr/EsGf2yhUIFa6uz5d7if
         EgOUcXommfi/dbp1dIrAk2OuI+ojhNEOfJdhFy9IHW0Srhl3B1dd+rFjaMcOw4bbHvbo
         v6Xfhv6isU45JHtLBXf8x9Ggn7Pu4BEGUsHdYVP+uphwONWRfpVrcKdZZ52C3um7zzUW
         /Cgg==
X-Gm-Message-State: AOAM532ZBlybDin5nMZrIgVGIeIt2Nnsf2lKS4myAvhyf17AWFe7Cp3u
        DKiKBu15QiMGgyY4TeTVBv0uv3+aH/fRrWG7nZ/QCnL/ROitug==
X-Google-Smtp-Source: ABdhPJzGx+u34QBKZdpeldetkusEGyTi0+zdW4/YQw5XkK2Zici1ke0LOiie41LVugO86Xb2WmqusGX3kKure1lx97Q=
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id
 t1-20020a1709061be100b006ceb0a8017dmr4694422ejg.413.1648114418259; Thu, 24
 Mar 2022 02:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220316135047.188122-1-dzm91@hust.edu.cn> <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>
In-Reply-To: <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 24 Mar 2022 17:33:12 +0800
Message-ID: <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> >
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > ffa.mutex when mutext_init succeeds.
> >
> > Fix this by adding mutex_destory of ffa.mutex at the error handling part
> >
> > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
>
> I believe this should be
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> don't you agree?

Hi Jen,

This commit 4615e5a34b95 is more suitable since mutex_init is introduced here.

Why did I label the commit aceeafefff73?

Because this commit tried to fix the issue, but only added one
mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.

>
> Thanks,
> Jens
>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index f744ab15bf2c..30a6119a2b16 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
> >         optee_supp_uninit(&optee->supp);
> >         mutex_destroy(&optee->call_queue.mutex);
> > +       mutex_destroy(&optee->ffa.mutex);
> >  err_unreg_supp_teedev:
> >         tee_device_unregister(optee->supp_teedev);
> >  err_unreg_teedev:
> > --
> > 2.25.1
> >
