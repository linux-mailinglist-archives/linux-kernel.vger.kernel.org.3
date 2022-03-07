Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB484D00AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiCGOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiCGOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:06:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252295C868;
        Mon,  7 Mar 2022 06:05:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so9237631wma.4;
        Mon, 07 Mar 2022 06:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cPCPfCto9HtHcoYx4KA9jMbfoIz/FloUnMSSYA+d0k4=;
        b=BTE2/1Qef0yz/V0uaAKthJorX2GBLbkZzcxKGR2Nm4au3qlnPQyrgfu1mlgXoaQXXJ
         t+FWXJxNMjy1iKehlIo+ZxIxlHmvTo0CBFhEGJ+mBZY2b0uf7Yzjw4TuR4Y7ZWGloLAx
         kqo2yu7tTvYID8HDIjWa3CQghSghXo74XdMeaKJt22fUxv2L66PkJ7QfQXQskV0vb+el
         3EO3CjnPepNlZXn7wfRukXbwps/Z5cv4IMONsqLWIddmhdlkz4EZR9ErQ/yN66pquo3C
         z7Rafkbyu8kmfTzpIpeVSBWk69OL34Jl4NVgf3IwTxKzUKvQL0JeiEaiK638iSnonExN
         It5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cPCPfCto9HtHcoYx4KA9jMbfoIz/FloUnMSSYA+d0k4=;
        b=LuNFGOQjApxbEhJHxEE9IryCkf/kgEnOEFyi2L1k+VWQkQj0Y0tAFTPH/3o7892aVQ
         QzoaLjsI4symSEJy0BycFKxkgYKBN5XX4xJ8Y2Zf0xS/VWd05SiHNK4/xaiZ3j8ioZLz
         j1LireCUmSqIoB0j1r9tRIhT4odAeG/jc++LqkN7dmuQkfiZBBB2C0Gw1ywapDJwZs3U
         z+DjY13TJzTGdNP4Hkt/zIi/g6zXoqKCXk8EDTI52VeDnsymeJi83cpvWNU1EriAojvT
         w7835DSHU69sOvG/68aF7q+eYQ2mGunfE/vqzIlfdOC9IG4hQMWwPYY8datKebHQQSLI
         V9hA==
X-Gm-Message-State: AOAM532hVfWKcZNz+743Af+TSfTrjF1mYwicpZ04olJ9NlCxO9SSGOzi
        Rs4eB3WM26H1ii18MEYRMX0=
X-Google-Smtp-Source: ABdhPJw/5N67lpL9Hf7fIZQLVJfIywdH1lBuwaVVedppeZ7Dkl2OG1Z7eQ0bXKp6L3JocgQWhHw8qA==
X-Received: by 2002:a7b:c30a:0:b0:389:9e1e:a15f with SMTP id k10-20020a7bc30a000000b003899e1ea15fmr6709974wmj.28.1646661926469;
        Mon, 07 Mar 2022 06:05:26 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm24852516wmp.13.2022.03.07.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:05:26 -0800 (PST)
Date:   Mon, 7 Mar 2022 15:05:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiYRJH+EtVA4hJMX@Red>
References: <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red>
 <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <YiYMeFf+Lsa9y4ss@Red>
 <CAOtvUMccCai9gFrTv6CZB-U56UtCPtmnZUyW5WmUr=+6YiUHZg@mail.gmail.com>
 <YiYPBdRIi4+HYsmW@Red>
 <CAOtvUMewFLaNHu1UmoHhnszBNmLrcVV6nCTd7-th8s9=1+h4bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtvUMewFLaNHu1UmoHhnszBNmLrcVV6nCTd7-th8s9=1+h4bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 07, 2022 at 04:00:44PM +0200, Gilad Ben-Yossef a écrit :
> On Mon, Mar 7, 2022 at 3:56 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Mon, Mar 07, 2022 at 03:53:02PM +0200, Gilad Ben-Yossef a écrit :
> > > On Mon, Mar 7, 2022 at 3:45 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> > > >
> > > > Le Mon, Mar 07, 2022 at 11:14:16AM +0000, Robin Murphy a écrit :
> > > > > On 2022-03-07 10:48, Corentin Labbe wrote:
> > > > > > Le Mon, Mar 07, 2022 at 09:59:29AM +0200, Gilad Ben-Yossef a ďż˝crit :
> > > > > >> On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > > > >>>
> > > > > >>> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> > > > > >>>>
> > > > > >>>> Hello
> > > > > >>>>
> > > > > >>>> I got:
> > > > > >>>> [   17.563793] ------------[ cut here ]------------
> > > > > >>>> [   17.568492] DMA-API: ccree e6601000.crypto: device driver frees DMA memory with different direction [device address=0x0000000078fe5800] [size=8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
> > > > > >>>
> > > > > >>> The direction argument during unmap must match whatever direction
> > > > > >>> you used during the original map call.
> > > > > >>
> > > > > >>
> > > > > >> Yes, of course. I changed one but forgot the other.
> > > > > >>
> > > > > >> Corentin, could you be kind and check that this solves the original
> > > > > >> problem and does not produce new warnings?
> > > > > >>
> > > > > >> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> > > > > >> b/drivers/crypto/ccree/cc_buffer_mgr.c
> > > > > >> index 11e0278c8631..31cfe014922e 100644
> > > > > >> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> > > > > >> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> > > > > >> @@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *dev,
> > > > > >> void *ctx,
> > > > > >>                                req_ctx->mlli_params.mlli_dma_addr);
> > > > > >>          }
> > > > > >>
> > > > > >> -       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
> > > > > >> -       dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> > > > > >> -
> > > > > >>          if (src != dst) {
> > > > > >> -               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIRECTIONAL);
> > > > > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEVICE);
> > > > > >> +               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_DEVICE);
> > > > > >>                  dev_dbg(dev, "Unmapped req->dst=%pK\n", sg_virt(dst));
> > > > > >> +               dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> > > > > >> +       } else {
> > > > > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
> > > > > >> +               dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> > > > > >>          }
> > > > > >>   }
> > > > > >>
> > > > > >> @@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > > > >> *drvdata, void *ctx,
> > > > > >>          u32 dummy = 0;
> > > > > >>          int rc = 0;
> > > > > >>          u32 mapped_nents = 0;
> > > > > >> +       int src_direction = (src != dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
> > > > > >>
> > > > > >>          req_ctx->dma_buf_type = CC_DMA_BUF_DLLI;
> > > > > >>          mlli_params->curr_pool = NULL;
> > > > > >> @@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > > > >> *drvdata, void *ctx,
> > > > > >>          }
> > > > > >>
> > > > > >>          /* Map the src SGL */
> > > > > >> -       rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
> > > > > >> +       rc = cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nents,
> > > > > >>                         LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
> > > > > >>          if (rc)
> > > > > >>                  goto cipher_exit;
> > > > > >> @@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > > > >> *drvdata, void *ctx,
> > > > > >>                  }
> > > > > >>          } else {
> > > > > >>                  /* Map the dst sg */
> > > > > >> -               rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
> > > > > >> +               rc = cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
> > > > > >>                                 &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
> > > > > >>                                 &dummy, &mapped_nents);
> > > > > >>                  if (rc)
> > > > > >>
> > > > > >>
> > > > > >
> > > > > > Hello
> > > > > >
> > > > > > I still get the warning:
> > > > > > [  433.406230] ------------[ cut here ]------------
> > > > > > [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIST, overlapping mappings aren't supported
> > > > > > [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-next/kernel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > > > > > [  433.406434] Modules linked in:
> > > > > > [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6-next-20220303-00130-g30042e47ee47-dirty #54
> > > > > > [  433.406473] Hardware name: Renesas Salvator-X board based on r8a77950 (DT)
> > > > > > [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > [  433.406498] pc : add_dma_entry+0x1d0/0x288
> > > > > > [  433.406510] lr : add_dma_entry+0x1d0/0x288
> > > > > > [  433.406522] sp : ffff800015da3690
> > > > > > [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 0000000000000000
> > > > > > [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: ffff80000b4c7000
> > > > > > [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff80000a9b6000
> > > > > > [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: ffffffffffffffff
> > > > > > [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 000000000000022e
> > > > > > [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: ffff80000b4be010
> > > > > > [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000b4a6028
> > > > > > [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000b4a5fd0
> > > > > > [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 0000000000000027
> > > > > > [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 0000000000000000
> > > > > > [  433.406833] Call trace:
> > > > > > [  433.406841]  add_dma_entry+0x1d0/0x288
> > > > > > [  433.406854]  debug_dma_map_sg+0x150/0x398
> > > > > > [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> > > > > > [  433.406889]  dma_map_sg_attrs+0x10/0x28
> > > > > > [  433.406904]  cc_map_sg+0x80/0x100
> > > > > > [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> > > > > > [  433.406939]  cc_cipher_process+0x210/0xb58
> > > > > > [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> > > > > > [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> > > > > > [  433.406986]  skcipher_recvmsg+0x36c/0x420
> > > > > > [  433.407003]  ____sys_recvmsg+0x90/0x280
> > > > > > [  433.407024]  ___sys_recvmsg+0x88/0xd0
> > > > > > [  433.407038]  __sys_recvmsg+0x6c/0xd0
> > > > > > [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> > > > > > [  433.407061]  invoke_syscall+0x44/0x100
> > > > > > [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> > > > > > [  433.407096]  do_el0_svc+0x24/0x88
> > > > > > [  433.407110]  el0_svc+0x4c/0x100
> > > > > > [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> > > > > > [  433.407145]  el0t_64_sync+0x170/0x174
> > > > > > [  433.407160] irq event stamp: 5624
> > > > > > [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8>] __up_console_sem+0x60/0x98
> > > > > > [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060>] el1_dbg+0x28/0x90
> > > > > > [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8>] lock_sock_nested+0x80/0xa0
> > > > > > [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8>] lock_sock_nested+0x60/0xa0
> > > > > > [  433.407241] ---[ end trace 0000000000000000 ]---
> > > > > > [  433.407381] DMA-API: Mapped at:
> > > > > > [  433.407396]  debug_dma_map_sg+0x16c/0x398
> > > > > > [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> > > > > > [  433.407436]  dma_map_sg_attrs+0x10/0x28
> > > > > > [  433.407455]  cc_map_sg+0x80/0x100
> > > > > > [  433.407475]  cc_map_cipher_request+0x178/0x3c8
> > > > > >
> > > > > >
> > > > > > BUT I start to thing this is a bug in DMA-API debug.
> > > > > >
> > > > > >
> > > > > > My sun8i-ss driver hit the same warning:
> > > > > > [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 add_dma_entry+0x2ec/0x4cc
> > > > > > [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking EEXIST, overlapping mappings aren't supported
> > > > > > [  142.458455] Modules linked in: ccm algif_aead xts cmac
> > > > > > [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.17.0-rc6-next-20220307-00132-g39dad568d20a-dirty #223
> > > > > > [  142.458581] Hardware name: Allwinner A83t board
> > > > > > [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> > > > > > [  142.458627]  show_stack from 0xf0abdd1c
> > > > > > [  142.458646] irq event stamp: 31747
> > > > > > [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up_console_sem+0x50/0x60
> > > > > > [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up_console_sem+0x3c/0x60
> > > > > > [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8i_ss_handle_cipher_request+0x300/0x8b8
> > > > > > [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8i_ss_handle_cipher_request+0x300/0x8b8
> > > > > > [  142.458758] ---[ end trace 0000000000000000 ]---
> > > > > > [  142.458771] DMA-API: Mapped at:
> > > > > >
> > > > > > Yes the mapped at is empty just after.
> > > > > >
> > > > > > And the sequence of DMA operations in my driver is simple, so I cannot see how any overlap could occur.
> > > > >
> > > > > The "overlap" is in the sense of having more than one mapping within the
> > > > > same cacheline:
> > > > >
> > > > > [  142.458120] DMA-API: add_dma_entry start P=ba79f200 N=ba79f
> > > > > D=ba79f200 L=10 DMA_FROM_DEVICE attrs=0
> > > > > [  142.458156] DMA-API: add_dma_entry start P=445dc010 N=445dc
> > > > > D=445dc010 L=10 DMA_TO_DEVICE attrs=0
> > > > > [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=16 bi=0
> > > > > [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=16 bi=0
> > > > > [  142.458234] DMA-API: add_dma_entry start P=ba79f210 N=ba79f
> > > > > D=ba79f210 L=10 DMA_FROM_DEVICE attrs=0
> > > > >
> > > > > This actually illustrates exactly the reason why this is unsupportable.
> > > > > ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
> > > > > ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
> > > > > ba79f200-ba79f23f to be written back over the top of data that the
> > > > > device has already started to write to memory. Hello data corruption.
> > > > >
> > > > > Separate DMA mappings should be from separate memory allocations,
> > > > > respecting ARCH_DMA_MINALIGN.
> > > > >
> > > >
> > > > I just saw something strange, only one SG is involved, and I dont see any DMA_TO_DEVICE for ba79f210.
> > > > I see 2 DMA_FROM_DEVICE (ba79f200 and ba79f210), but only one should be done.
> > > > Why 2 FROM mappings are added with only one sg ?
> > > >
> > >
> > > The thing that does the memory allocation of user calls from libkcapi
> > > tests is the crypto/af_alg.c code ...
> > >
> > > I assume the sglist has two buffers? could it be that somehow they are
> > > not DMA aligned? that would be weird indeed...
> > >
> >
> > The SGlist has only one SG, so only one buffer, it is why I dont understand the double call to add_dma_entry().
> 
> But... a scatter gather list by its nature can hold more than one
> buffer, no? that is the whole purpose of a scatter gather list...?
> 

Each buffer is "in" one struct scatterlist (this is what I call SG, perhaps wrongly).
The debug sun8i-ss 1c15000.crypto: DST 0/1/1 show that we have only one entry (as given by sg_nents_for_len() and dma_map_sg())

Sorry for my misleading SG.
