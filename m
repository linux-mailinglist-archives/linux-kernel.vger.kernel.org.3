Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950854BDDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377283AbiBUOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:05:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiBUOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:05:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C241AF05;
        Mon, 21 Feb 2022 06:05:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f17so2404378wrh.7;
        Mon, 21 Feb 2022 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XUxcEn3H/QIKWoe8zGetU+JshLykgc6V1hwBTKo452I=;
        b=qN8k8HohDbYPnd6+WZ+RVI5vHilVflRaOiDVw7kiFguwZnPxHFvD2AMGHrmAHjUAIm
         kVxgfCyVLFG6AgSbisa1SXmgErJazigkX/SyrPnKVgGY7dHIFSLV9rcTRoDvjjjc4+mi
         tUY0YvmGmcKbf9sIJnTW4T1t7T2tZACcynaStjABxjxJg1QMCGGI280C/HLapDpEkQgZ
         KqGiUTR092HoB3dLw8DCBqWBfJDFfAu9oIw+YjVP+TaiKYGvC6O+OvsxbwmTryvDisIh
         Z7iqKZA3wbQ7M7bCBZhd+jCYRhGcj7h9MYKvVYPn6aSx5+qhPR7EX7Gb67R3W5EA5qq3
         2wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XUxcEn3H/QIKWoe8zGetU+JshLykgc6V1hwBTKo452I=;
        b=TZirTMoIzesdVP62z2JzAyQ7ik5Q8OSP0eHoWiBug38pPaqlMmtwqXmVx4fiG0f0sY
         aKJowCGSNhB45dByWKDpqIXR+tJoTs3Lz8C2P4hz3A4LrZivJ4dvBMP1gI4uDEqsFgcQ
         yhABpEyWDOgBSakH3vbje6sDfjzMSuJdgzZRYMYHLH9m6hHOsuyjucKSdxgYr3ybxK6E
         gYDrfAqmRdNVvhPd3gWDH6wiB2xocW4gAclInLj7lLY6NMslsJR0WRaSSM6iB0gqeRsr
         cLNwCvyU/DQUvcDhniRd7RvcLorYbg0KAxa4LkmuXNwKFGWkVl6KtZi3NwUF5/ubUdJc
         MamQ==
X-Gm-Message-State: AOAM531u1M1Ll09Z3wE08PnA+Z3wXPgdXv6wP8JkyNRqpCN/RBP3A3X4
        dgHQpTT+CHvH6aGoKaHVbm8=
X-Google-Smtp-Source: ABdhPJwS8j1SUpFwH2bwHg6tnObRt0u3r2lqqVsckqw6MctCQIfac24TY6Z3KtJoIe7rf9JH2zQqzg==
X-Received: by 2002:a5d:5904:0:b0:1e3:3238:889 with SMTP id v4-20020a5d5904000000b001e332380889mr15373392wrd.289.1645452309951;
        Mon, 21 Feb 2022 06:05:09 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j12sm758968wrs.1.2022.02.21.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:05:09 -0800 (PST)
Date:   Mon, 21 Feb 2022 15:05:05 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YhOcEQEjIKBrbMIZ@Red>
References: <YgOQBNIdf0UnSH+M@Red>
 <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Feb 21, 2022 at 12:08:12PM +0200, Gilad Ben-Yossef a écrit :
> Hi,
> 
> On Sun, Feb 20, 2022 at 9:26 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> ...
> >
> > Hello
> >
> > While testing your patch for this problem, I saw another warning (unrelated with your patch):
> 
> Dear Corentin, you are a treasure trove of bug reports. I love it.
> Thank you! :-)
> 
> > [   34.061953] ------------[ cut here ]------------
> > [   34.066656] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIST, overlapping mappings aren't supported
> > [   34.076555] WARNING: CPU: 3 PID: 475 at /home/clabbe/linux-next/kernel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > [   34.086748] Modules linked in:
> > [   34.089809] CPU: 3 PID: 475 Comm: cryptomgr_test Tainted: G        W         5.17.0-rc3-next-20220210-00115-g1ca9f29d9780-dirty #25
> > [   34.101635] Hardware name: Renesas Salvator-X board based on r8a77950 (DT)
> > [   34.108508] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   34.115471] pc : add_dma_entry+0x1d0/0x288
> > [   34.119569] lr : add_dma_entry+0x1d0/0x288
> > [   34.123664] sp : ffff80000e3236f0
> > [   34.126976] x29: ffff80000e3236f0 x28: 0000000000000000 x27: 0000000000000000
> > [   34.134122] x26: 0000000000000000 x25: ffff80000b3c76c0 x24: ffff80000b3c7000
> > [   34.141267] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff80000a8c1000
> > [   34.148410] x20: ffff0004c0b93f80 x19: ffff80000b320000 x18: ffffffffffffffff
> > [   34.155554] x17: 6c7265766f202c54 x16: 534958454520676e x15: 00000000000001fa
> > [   34.162697] x14: ffff80000e3233f0 x13: 00000000ffffffea x12: ffff80000b3bdda0
> > [   34.169840] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000b3a5db8
> > [   34.176984] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000b3a5d60
> > [   34.184126] x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 00000000ffffefff
> > [   34.191269] x2 : ffff80000b34db38 x1 : 371dfc0f85526100 x0 : 0000000000000000
> > [   34.198411] Call trace:
> > [   34.200856]  add_dma_entry+0x1d0/0x288
> > [   34.204604]  debug_dma_map_sg+0x150/0x398
> > [   34.208615]  __dma_map_sg_attrs+0x9c/0x108
> > [   34.212717]  dma_map_sg_attrs+0x10/0x28
> > [   34.216554]  cc_map_sg+0x80/0x100
> > [   34.219875]  cc_map_cipher_request+0x170/0x3c8
> > [   34.224319]  cc_cipher_process+0x210/0xb58
> > [   34.228415]  cc_cipher_encrypt+0x2c/0x38
> > [   34.232338]  crypto_skcipher_encrypt+0x44/0x78
> > [   34.236786]  drbg_kcapi_sym_ctr+0xdc/0x1f8
> > [   34.240887]  drbg_ctr_generate+0x5c/0x98
> > [   34.244812]  drbg_kcapi_random+0xb4/0x260
> > [   34.248823]  alg_test_stdrng+0xf8/0x2b0
> > [   34.252661]  alg_test.part.29+0xb4/0x398
> > [   34.256583]  alg_test+0x48/0x78
> > [   34.259724]  cryptomgr_test+0x48/0x50
> > [   34.263386]  kthread+0x11c/0x128
> > [   34.266619]  ret_from_fork+0x10/0x20
> > [   34.270198] irq event stamp: 318
> > [   34.273424] hardirqs last  enabled at (317): [<ffff8000081300e0>] __up_console_sem+0x60/0x98
> > [   34.281869] hardirqs last disabled at (318): [<ffff800009bfbb18>] el1_dbg+0x28/0x90
> > [   34.289531] softirqs last  enabled at (314): [<ffff800008010550>] __do_softirq+0x4a8/0x5ec
> > [   34.297796] softirqs last disabled at (305): [<ffff8000080ab644>] irq_exit_rcu+0x18c/0x1b0
> > [   34.306061] ---[ end trace 0000000000000000 ]---
> >
> 
> So, this is an interesting one.
> What I *think* is happening is that the drbg implementation is
> actually doing something naughty: it is passing the same exact memory
> buffer, both as source and destination to an encryption operation to
> the crypto skcipher API, BUT via two different scatter gather lists.
> 
> I'm not sure but I believe this is not a legitimate use of the API,
> but before we even go into this, let's see if this little fix helps at
> all and this is indeed the root cause.
> 
> Can you test this small change for me, please?
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 177983b6ae38..13824fd27627 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1851,7 +1851,7 @@ static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
>                 /* Use scratchpad for in-place operation */
>                 inlen = scratchpad_use;
>                 memset(drbg->outscratchpad, 0, scratchpad_use);
> -               sg_set_buf(sg_in, drbg->outscratchpad, scratchpad_use);
> +               sg_in = sg_out;
>         }
> 
>         while (outlen) {
> 

No more stacktrace !
