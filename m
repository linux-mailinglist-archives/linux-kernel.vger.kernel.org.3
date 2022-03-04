Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836E4CD525
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiCDNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiCDNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:31:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE661A8063;
        Fri,  4 Mar 2022 05:30:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so5097699wmb.3;
        Fri, 04 Mar 2022 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CiuC7L8X27pHR00uqbdsBUeOVA3npM9RU1hYhchJXuI=;
        b=ZOD82xKyU4QgIyIBxbHdiVMS49jv0GKIUfBBXDA0Cb6bV67juBJNOl0tv14VBHHU74
         biZJdvrlw+Gl79lZXVuZ9X1UmceBe3COIYsySGWn9+qU0zeDOB1HB/Gen5i09z3B5NFe
         uklp2P+3NDZ2YmXOKPUNfi8pUW+wYGPulCDKfyMPj0OFNoHnz6tTedDgaHojo3ynWEFU
         d5NV3tqrNfclN6Xgb+/aa9BydNGI+8cy0gF9JTzdqJnXD5UgRegOh2P8jHdMRPs2eKRS
         d56M1dm20gD4NiC68ssGciKOS7950E6Btsey9zLpU/M3lTkuYdEBsRhkWErvhZ4ll36P
         VEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CiuC7L8X27pHR00uqbdsBUeOVA3npM9RU1hYhchJXuI=;
        b=cpqG+kKD/jttpElltKSOgPapQKmInF8+x0ET2PXIsRCa23ywrMAbwkMaPJyRc9ty5F
         pPu+vezmDiRp0ul9f1L4qNGOo+AZfWXCMYrlNNpVrcfLiYTCrczBvz8SdtJi1XoPPz+A
         uwkXnCHSDh67eCg6lJM1DWtnl3YnzxdJz3v9iErXyVxDqf4yT9R1ryNc/rPcdyifx5gi
         piDKQIIKJKpvWY4e4vsaWjqURyElqCDTsdLSBSR9QyYDnA7Qsg68IKtaQc2NiIALSuua
         xXPqNPifrpQPWwWzQUF22ILNt5Xc3TrDoyIIiUrk7prggogk58gKyeST0DKkO6EYjXNX
         4qYg==
X-Gm-Message-State: AOAM532orO+5P3R/NZSzjinNI26wJ092fu2XcjvLWB3ZvVRIk0AF5e7+
        ZxgHirSC5a6xXsIcErgqtQo=
X-Google-Smtp-Source: ABdhPJxZ7n9YO4XAWpjgGRGLB0q9K0ndYYS5IDJkRYxJkPwmqFhznmwOAM5+mtAOAonWp5TgTxUojg==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr7841675wma.108.1646400611548;
        Fri, 04 Mar 2022 05:30:11 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m2-20020adff382000000b001f022ef0375sm4395915wro.102.2022.03.04.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:30:11 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:30:06 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiIUXtxd44ut5uzV@Red>
References: <YgOQBNIdf0UnSH+M@Red>
 <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Feb 28, 2022 at 11:11:43AM +0200, Gilad Ben-Yossef a écrit :
> Hi,
> 
> On Tue, Feb 22, 2022 at 9:39 AM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> >
> > On Mon, Feb 21, 2022 at 4:05 PM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > >
> > > Le Mon, Feb 21, 2022 at 12:08:12PM +0200, Gilad Ben-Yossef a écrit :
> > > > Hi,
> > > >
> > > > On Sun, Feb 20, 2022 at 9:26 PM Corentin Labbe
> > > > <clabbe.montjoie@gmail.com> wrote:
> > > > >
> > > > ...
> > > > >
> > > > > Hello
> > > > >
> > > > > While testing your patch for this problem, I saw another warning (unrelated with your patch):
> > > >
> > > > Dear Corentin, you are a treasure trove of bug reports. I love it.
> > > > Thank you! :-)
> > > >
> > > > > [   34.061953] ------------[ cut here ]------------
> > ...
> > > >
> > > > So, this is an interesting one.
> > > > What I *think* is happening is that the drbg implementation is
> > > > actually doing something naughty: it is passing the same exact memory
> > > > buffer, both as source and destination to an encryption operation to
> > > > the crypto skcipher API, BUT via two different scatter gather lists.
> > > >
> > > > I'm not sure but I believe this is not a legitimate use of the API,
> > > > but before we even go into this, let's see if this little fix helps at
> > > > all and this is indeed the root cause.
> > > >
> > > > Can you test this small change for me, please?
> > > >
> > > > diff --git a/crypto/drbg.c b/crypto/drbg.c
> > > > index 177983b6ae38..13824fd27627 100644
> > > > --- a/crypto/drbg.c
> > > > +++ b/crypto/drbg.c
> > > > @@ -1851,7 +1851,7 @@ static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
> > > >                 /* Use scratchpad for in-place operation */
> > > >                 inlen = scratchpad_use;
> > > >                 memset(drbg->outscratchpad, 0, scratchpad_use);
> > > > -               sg_set_buf(sg_in, drbg->outscratchpad, scratchpad_use);
> > > > +               sg_in = sg_out;
> > > >         }
> > > >
> > > >         while (outlen) {
> > > >
> > >
> > > No more stacktrace !
> >
> > Thank you. I will send a patch later today.
> 
> > --
> > Gilad Ben-Yossef
> > Chief Coffee Drinker
> >
> > values of β will give rise to dom!
> 
> OK, it seems my direction of fixing the caller site has not been taken
> kindly by the power that be.
> Let's try something else.
> 
> Can you please drop the previous patch and test this one instead?
> 
> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> b/drivers/crypto/ccree/cc_buffer_mgr.c
> index 11e0278c8631..398843040566 100644
> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> @@ -377,6 +377,7 @@ int cc_map_cipher_request(struct cc_drvdata
> *drvdata, void *ctx,
>         u32 dummy = 0;
>         int rc = 0;
>         u32 mapped_nents = 0;
> +       int src_direction = (src != dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
> 
>         req_ctx->dma_buf_type = CC_DMA_BUF_DLLI;
>         mlli_params->curr_pool = NULL;
> @@ -399,7 +400,7 @@ int cc_map_cipher_request(struct cc_drvdata
> *drvdata, void *ctx,
>         }
> 
>         /* Map the src SGL */
> -       rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
> +       rc = cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nents,
>                        LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
>         if (rc)
>                 goto cipher_exit;
> @@ -416,7 +417,7 @@ int cc_map_cipher_request(struct cc_drvdata
> *drvdata, void *ctx,
>                 }
>         } else {
>                 /* Map the dst sg */
> -               rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
> +               rc = cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
>                                &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
>                                &dummy, &mapped_nents);
>                 if (rc)
> 
> 
> Thanks!
> Gilad
> 

Hello

I got:
[   17.563793] ------------[ cut here ]------------
[   17.568492] DMA-API: ccree e6601000.crypto: device driver frees DMA memory with different direction [device address=0x0000000078fe5800] [size=8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
[   17.587371] WARNING: CPU: 0 PID: 0 at /home/clabbe/linux-next/kernel/dma/debug.c:1018 check_unmap+0x138/0x868
[   17.597304] Modules linked in:
[   17.600364] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc6-next-20220303-00130-g30042e47ee47-dirty #52
[   17.610191] Hardware name: Renesas Salvator-X board based on r8a77950 (DT)
[   17.617063] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   17.624026] pc : check_unmap+0x138/0x868
[   17.627948] lr : check_unmap+0x138/0x868
[   17.631870] sp : ffff80000b4037a0
[   17.635183] x29: ffff80000b4037a0 x28: ffff0004c8789840 x27: 0000000000000000
[   17.642329] x26: ffff80000a9b6000 x25: ffff80000c4ea030 x24: 0000000000000000
[   17.649473] x23: ffff80000b420000 x22: ffff80000b4c7000 x21: ffff80000c4c2000
[   17.656617] x20: ffff80000b403880 x19: ffff0004c0ad2880 x18: ffffffffffffffff
[   17.663760] x17: 63697665645b206e x16: 6f69746365726964 x15: 00000000000001b5
[   17.670904] x14: ffff80000b403490 x13: 00000000ffffffea x12: ffff80000b4be010
[   17.678048] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000b4a6028
[   17.685191] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000b4a5fd0
[   17.692334] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 00000000ffffefff
[   17.699477] x2 : ffff80000b44dda8 x1 : beaec6c6f6c7ed00 x0 : 0000000000000000
[   17.706621] Call trace:
[   17.709065]  check_unmap+0x138/0x868
[   17.712641]  debug_dma_unmap_sg+0xfc/0x1c8
[   17.716740]  dma_unmap_sg_attrs+0x4c/0xa8
[   17.720755]  cc_unmap_cipher_request+0x50/0xb0
[   17.725206]  cc_cipher_complete+0x44/0x80
[   17.729217]  comp_handler+0x178/0x3a8
[   17.732881]  tasklet_action_common.isra.15+0x148/0x160
[   17.738025]  tasklet_action+0x28/0x38
[   17.741686]  __do_softirq+0x13c/0x5ec
[   17.745350]  irq_exit_rcu+0x18c/0x1b0
[   17.749012]  el1_interrupt+0x44/0x78
[   17.752594]  el1h_64_irq_handler+0x18/0x28
[   17.756692]  el1h_64_irq+0x64/0x68
[   17.760093]  cpuidle_enter_state+0x104/0x528
[   17.764367]  cpuidle_enter+0x3c/0x58
[   17.767944]  call_cpuidle+0x20/0x50
[   17.771437]  do_idle+0x23c/0x298
[   17.774666]  cpu_startup_entry+0x24/0x80
[   17.778591]  rest_init+0x184/0x288
[   17.781995]  arch_call_rest_init+0x10/0x1c
[   17.786097]  start_kernel+0x6dc/0x718
[   17.789759]  __primary_switched+0xc0/0xc8
[   17.793769] irq event stamp: 2082825
[   17.797342] hardirqs last  enabled at (2082824): [<ffff800009caa0e4>] _raw_spin_unlock_irqrestore+0x8c/0x90
[   17.807087] hardirqs last disabled at (2082825): [<ffff800009caa6a0>] _raw_spin_lock_irqsave+0xb8/0xc8
[   17.816394] softirqs last  enabled at (2082814): [<ffff800008010550>] __do_softirq+0x4a8/0x5ec
[   17.825006] softirqs last disabled at (2082819): [<ffff8000080abb6c>] irq_exit_rcu+0x18c/0x1b0
[   17.833616] ---[ end trace 0000000000000000 ]---
[   17.838232] DMA-API: Mapped at:
[   17.841371]  debug_dma_map_sg+0x16c/0x398
[   17.845382]  __dma_map_sg_attrs+0x9c/0x108
[   17.849480]  dma_map_sg_attrs+0x10/0x28

I got also the overlapping message on one of my driver now, but it is hard to debug, I dont see how it can happen.
