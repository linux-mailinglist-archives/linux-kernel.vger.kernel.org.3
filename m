Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081524D0057
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiCGNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiCGNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:44:13 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283673C493
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:43:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u10so11177658ybd.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JCKv7BiBf9KG6Lbs2x2WUR/OIGhabVnbX0TExKcjkAM=;
        b=gRhar2tLLWw3vujECxYDIPLVv4cP5OMth9dsY81IrziJVDaknPrMFo+BiUFhiXJ7DS
         nWaS4XgP8LTp2gx/tyJR+2S3YX0eVmdK7AozFzzDdgjWt8kCC/DHARuASPKl8yWqdqj0
         EVvhKHnxTyfHPGhZ8l5klawlyZUoD5ZehNQ0EsJRCuLFeYrIa4bMqF2N+7zGpEu6FjmY
         polRoaLpZLFE5t9vTCI3w7sMTd/dZO7L6D9fFMkorMIMUTXhl4gvM3IhuAlnnphN7hyf
         nbAXNJE9C7rhsL58LAKTnwd2rbH9I29vLJrJr+MeibQ7XwmgGRYn+iDc4SEKsIQG37eT
         5JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JCKv7BiBf9KG6Lbs2x2WUR/OIGhabVnbX0TExKcjkAM=;
        b=4wX9EsRzC67DZR97oiaXsvl615FB75b9eZBe7T9OU154QrUwvPUfTcC3GDYulhKnCv
         mOd0f9AlLac3VzUMac8EJnSExAK0sC3uo+SkQCnHXLvz88cRyRuG67/hhtJXgJoZ4sTa
         omBLaIdUG2un25RvnlycoiOpnOFJ7KP5wyUYi5/axL588CwCC/uUxO1GDsld6yODpAfo
         QQ/JMC4GTknhofnu/ifhMuBfH/rBDBJeiebZpI5zgG99JL63gQr2JpMUmYHWYs0wii6a
         6Oc5a8kro96N0KCXLHqeJBSld6pm49UeZkFRLMR8KSmw0ba+4a12FailbhUq8d2hHAZ1
         YRdQ==
X-Gm-Message-State: AOAM531btYX07p2xgj7UwtDeD2VReow+MhxHVEHNICtT7SihogILdaor
        gQVlBe7HTc55E+6kHp06p/rxolQB63jyzGea3VqurA==
X-Google-Smtp-Source: ABdhPJzFyMKnNGi+vCbsh8ASrlugLFK23AGLqc1/O9wGTI5xnE6q4Cl9t28M03oKxU1zc0ZjlqYNyJSxdT4uOPVVyho=
X-Received: by 2002:a25:7804:0:b0:628:ec4c:989b with SMTP id
 t4-20020a257804000000b00628ec4c989bmr7562231ybc.428.1646660598309; Mon, 07
 Mar 2022 05:43:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com> <YiXjCcXXk0f18FDL@Red>
In-Reply-To: <YiXjCcXXk0f18FDL@Red>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 15:43:07 +0200
Message-ID: <CAOtvUMffp3K1q2uXwS4X4dJbFE2_J-nRj8nxBvLewBAVWc8TvQ@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 12:48 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:

>
> Hello
>
> I still get the warning:
> [  433.406230] ------------[ cut here ]------------
> [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIST,=
 overlapping mappings aren't supported
> [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-next/kern=
el/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> [  433.406434] Modules linked in:
> [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6-next-=
20220303-00130-g30042e47ee47-dirty #54
> [  433.406473] Hardware name: Renesas Salvator-X board based on r8a77950 =
(DT)
> [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  433.406498] pc : add_dma_entry+0x1d0/0x288
> [  433.406510] lr : add_dma_entry+0x1d0/0x288
> [  433.406522] sp : ffff800015da3690
> [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 000000000=
0000000
> [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: ffff80000=
b4c7000
> [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff80000=
a9b6000
> [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: fffffffff=
fffffff
> [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 000000000=
000022e
> [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: ffff80000=
b4be010
> [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000=
b4a6028
> [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000=
b4a5fd0
> [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 000000000=
0000027
> [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 000000000=
0000000
> [  433.406833] Call trace:
> [  433.406841]  add_dma_entry+0x1d0/0x288
> [  433.406854]  debug_dma_map_sg+0x150/0x398
> [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> [  433.406889]  dma_map_sg_attrs+0x10/0x28
> [  433.406904]  cc_map_sg+0x80/0x100
> [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> [  433.406939]  cc_cipher_process+0x210/0xb58
> [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> [  433.406986]  skcipher_recvmsg+0x36c/0x420
> [  433.407003]  ____sys_recvmsg+0x90/0x280
> [  433.407024]  ___sys_recvmsg+0x88/0xd0
> [  433.407038]  __sys_recvmsg+0x6c/0xd0
> [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> [  433.407061]  invoke_syscall+0x44/0x100
> [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> [  433.407096]  do_el0_svc+0x24/0x88
> [  433.407110]  el0_svc+0x4c/0x100
> [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> [  433.407145]  el0t_64_sync+0x170/0x174
> [  433.407160] irq event stamp: 5624
> [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8>] __u=
p_console_sem+0x60/0x98
> [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060>] el1=
_dbg+0x28/0x90
> [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8>] loc=
k_sock_nested+0x80/0xa0
> [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8>] loc=
k_sock_nested+0x60/0xa0
> [  433.407241] ---[ end trace 0000000000000000 ]---
> [  433.407381] DMA-API: Mapped at:
> [  433.407396]  debug_dma_map_sg+0x16c/0x398
> [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> [  433.407436]  dma_map_sg_attrs+0x10/0x28
> [  433.407455]  cc_map_sg+0x80/0x100
> [  433.407475]  cc_map_cipher_request+0x178/0x3c8
>
>
> BUT I start to thing this is a bug in DMA-API debug.
>
>
> My sun8i-ss driver hit the same warning:
> [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 add_dma_=
entry+0x2ec/0x4cc
> [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking EEXIS=
T, overlapping mappings aren't supported
> [  142.458455] Modules linked in: ccm algif_aead xts cmac
> [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.17.0-rc=
6-next-20220307-00132-g39dad568d20a-dirty #223
> [  142.458581] Hardware name: Allwinner A83t board
> [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> [  142.458627]  show_stack from 0xf0abdd1c
> [  142.458646] irq event stamp: 31747
> [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up_conso=
le_sem+0x50/0x60
> [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up_conso=
le_sem+0x3c/0x60
> [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8i_ss_h=
andle_cipher_request+0x300/0x8b8
> [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8i_ss_h=
andle_cipher_request+0x300/0x8b8
> [  142.458758] ---[ end trace 0000000000000000 ]---
> [  142.458771] DMA-API: Mapped at:

The more I think about it, the more I suspect that this is a problem
of the input sglists to crypto API calls overlapping in some fashion,
either between src and dst or maybe even across different crypto
operations and HW crypto drivers just mapping those sglists, oblivious
to it.

What are crypto HW drivers to do? scan each input scatterlist for
overlap, not just between src and dst of the same operation but also
across different crypto operations? That is insane...

 I am not sure where to go from here.

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
