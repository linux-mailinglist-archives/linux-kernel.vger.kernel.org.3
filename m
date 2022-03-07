Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50F4D005B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbiCGNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiCGNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:46:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35B8BF4C;
        Mon,  7 Mar 2022 05:45:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t11so23382592wrm.5;
        Mon, 07 Mar 2022 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRWYQj6ygSui15Ezjgo123BR8/QmAv/FWR5OuEvV+NI=;
        b=n1IQEZX17CMKDWNM426OeL5UtCpuckOQnDSb2LW7JtAZ60GJ7ZaWUwoghdLIyBrcFU
         eB9ZbKtjhDrqtElqD5nKWEwi5TSQKsSP0erByxRQ1Yf+oacCqmy89FW9GWmrANrXzgl4
         aqsHl1M+AkFrY3U5NO1k6onrvu1BlRgG7fWclvIjoxNyA99SBztI3AZtZL1UEqBjQtCE
         hjL7kfGh4uVAo5SB0srU6lgZGtWgjH3s0ki07g/6MSVWu87DZ1n8J8xdDUpwzjEWz3uu
         F6EwiuejvSg0J9WOuw6n++lIHh/LmlQQ7roSXaNRCUnSmHCKGk4D34TKVO57Sl8DwQxP
         rb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRWYQj6ygSui15Ezjgo123BR8/QmAv/FWR5OuEvV+NI=;
        b=MJbPXS736RvmzjuYdxmbl90t4kq0g8YXRMjdWROVIhmX+Fpvi422/YYqlfLX2Dg/1S
         4hDlnQVLjMSHTNTnWoH9K2l3o3dqBkVhSS1NhaaJqfy3GPLHUB7WZ6Jd98DO1rjUkZCU
         VmX49hI2wfjcoFzNKFC6ZxVgR2/clNI93jE0qYeJ7zPgWlhgfcNdoccQ1CpYv10MwXy3
         uiRAvGXs8IMSUvvAV3MduTTs/ujE9CQDAWztFVmyssyAjkg1enK9MJ92Mv9DzqMCsuGA
         nLpLtL+OArMkTyMSTO/vb/hHtvWo/TJG3ZjNqRaMH+n0PmxKXoLejKpWlf5C9IAyADCI
         BARw==
X-Gm-Message-State: AOAM530VU5HrTRisTvTLPXu8q6SWmOgfqe+ZLdcDRbz6ZOI5sbssM1/9
        harimKJ0cecmFTlaIwuExSQ=
X-Google-Smtp-Source: ABdhPJw0aimp3vMEoxOLNxX2rIy0M69Q13B+uOp5tuZ+iRFppzRxxqwYwRsPutM3Iy5qPl6eVUK3Hg==
X-Received: by 2002:a05:6000:168e:b0:1f1:faf1:23b7 with SMTP id y14-20020a056000168e00b001f1faf123b7mr2561745wrd.150.1646660732772;
        Mon, 07 Mar 2022 05:45:32 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm11419676wro.71.2022.03.07.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:45:32 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:45:28 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>, hch@lst.de,
        m.szyprowski@samsung.com, Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiYMeFf+Lsa9y4ss@Red>
References: <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red>
 <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 07, 2022 at 11:14:16AM +0000, Robin Murphy a écrit :
> On 2022-03-07 10:48, Corentin Labbe wrote:
> > Le Mon, Mar 07, 2022 at 09:59:29AM +0200, Gilad Ben-Yossef a ï¿½crit :
> >> On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >>>
> >>> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> >>>>
> >>>> Hello
> >>>>
> >>>> I got:
> >>>> [   17.563793] ------------[ cut here ]------------
> >>>> [   17.568492] DMA-API: ccree e6601000.crypto: device driver frees DMA memory with different direction [device address=0x0000000078fe5800] [size=8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
> >>>
> >>> The direction argument during unmap must match whatever direction
> >>> you used during the original map call.
> >>
> >>
> >> Yes, of course. I changed one but forgot the other.
> >>
> >> Corentin, could you be kind and check that this solves the original
> >> problem and does not produce new warnings?
> >>
> >> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> >> b/drivers/crypto/ccree/cc_buffer_mgr.c
> >> index 11e0278c8631..31cfe014922e 100644
> >> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> >> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> >> @@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *dev,
> >> void *ctx,
> >>                                req_ctx->mlli_params.mlli_dma_addr);
> >>          }
> >>
> >> -       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
> >> -       dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> >> -
> >>          if (src != dst) {
> >> -               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIRECTIONAL);
> >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEVICE);
> >> +               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_DEVICE);
> >>                  dev_dbg(dev, "Unmapped req->dst=%pK\n", sg_virt(dst));
> >> +               dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> >> +       } else {
> >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
> >> +               dev_dbg(dev, "Unmapped req->src=%pK\n", sg_virt(src));
> >>          }
> >>   }
> >>
> >> @@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>          u32 dummy = 0;
> >>          int rc = 0;
> >>          u32 mapped_nents = 0;
> >> +       int src_direction = (src != dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
> >>
> >>          req_ctx->dma_buf_type = CC_DMA_BUF_DLLI;
> >>          mlli_params->curr_pool = NULL;
> >> @@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>          }
> >>
> >>          /* Map the src SGL */
> >> -       rc = cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_nents,
> >> +       rc = cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nents,
> >>                         LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
> >>          if (rc)
> >>                  goto cipher_exit;
> >> @@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>                  }
> >>          } else {
> >>                  /* Map the dst sg */
> >> -               rc = cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
> >> +               rc = cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
> >>                                 &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENTRIES,
> >>                                 &dummy, &mapped_nents);
> >>                  if (rc)
> >>
> >>
> > 
> > Hello
> > 
> > I still get the warning:
> > [  433.406230] ------------[ cut here ]------------
> > [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIST, overlapping mappings aren't supported
> > [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-next/kernel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > [  433.406434] Modules linked in:
> > [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6-next-20220303-00130-g30042e47ee47-dirty #54
> > [  433.406473] Hardware name: Renesas Salvator-X board based on r8a77950 (DT)
> > [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  433.406498] pc : add_dma_entry+0x1d0/0x288
> > [  433.406510] lr : add_dma_entry+0x1d0/0x288
> > [  433.406522] sp : ffff800015da3690
> > [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 0000000000000000
> > [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: ffff80000b4c7000
> > [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff80000a9b6000
> > [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: ffffffffffffffff
> > [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 000000000000022e
> > [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: ffff80000b4be010
> > [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff80000b4a6028
> > [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff80000b4a5fd0
> > [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 0000000000000027
> > [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 0000000000000000
> > [  433.406833] Call trace:
> > [  433.406841]  add_dma_entry+0x1d0/0x288
> > [  433.406854]  debug_dma_map_sg+0x150/0x398
> > [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> > [  433.406889]  dma_map_sg_attrs+0x10/0x28
> > [  433.406904]  cc_map_sg+0x80/0x100
> > [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> > [  433.406939]  cc_cipher_process+0x210/0xb58
> > [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> > [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> > [  433.406986]  skcipher_recvmsg+0x36c/0x420
> > [  433.407003]  ____sys_recvmsg+0x90/0x280
> > [  433.407024]  ___sys_recvmsg+0x88/0xd0
> > [  433.407038]  __sys_recvmsg+0x6c/0xd0
> > [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> > [  433.407061]  invoke_syscall+0x44/0x100
> > [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> > [  433.407096]  do_el0_svc+0x24/0x88
> > [  433.407110]  el0_svc+0x4c/0x100
> > [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> > [  433.407145]  el0t_64_sync+0x170/0x174
> > [  433.407160] irq event stamp: 5624
> > [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8>] __up_console_sem+0x60/0x98
> > [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060>] el1_dbg+0x28/0x90
> > [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8>] lock_sock_nested+0x80/0xa0
> > [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8>] lock_sock_nested+0x60/0xa0
> > [  433.407241] ---[ end trace 0000000000000000 ]---
> > [  433.407381] DMA-API: Mapped at:
> > [  433.407396]  debug_dma_map_sg+0x16c/0x398
> > [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> > [  433.407436]  dma_map_sg_attrs+0x10/0x28
> > [  433.407455]  cc_map_sg+0x80/0x100
> > [  433.407475]  cc_map_cipher_request+0x178/0x3c8
> > 
> > 
> > BUT I start to thing this is a bug in DMA-API debug.
> > 
> > 
> > My sun8i-ss driver hit the same warning:
> > [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 add_dma_entry+0x2ec/0x4cc
> > [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking EEXIST, overlapping mappings aren't supported
> > [  142.458455] Modules linked in: ccm algif_aead xts cmac
> > [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.17.0-rc6-next-20220307-00132-g39dad568d20a-dirty #223
> > [  142.458581] Hardware name: Allwinner A83t board
> > [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> > [  142.458627]  show_stack from 0xf0abdd1c
> > [  142.458646] irq event stamp: 31747
> > [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up_console_sem+0x50/0x60
> > [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up_console_sem+0x3c/0x60
> > [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8i_ss_handle_cipher_request+0x300/0x8b8
> > [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8i_ss_handle_cipher_request+0x300/0x8b8
> > [  142.458758] ---[ end trace 0000000000000000 ]---
> > [  142.458771] DMA-API: Mapped at:
> > 
> > Yes the mapped at is empty just after.
> > 
> > And the sequence of DMA operations in my driver is simple, so I cannot see how any overlap could occur.
> 
> The "overlap" is in the sense of having more than one mapping within the 
> same cacheline:
> 
> [  142.458120] DMA-API: add_dma_entry start P=ba79f200 N=ba79f 
> D=ba79f200 L=10 DMA_FROM_DEVICE attrs=0
> [  142.458156] DMA-API: add_dma_entry start P=445dc010 N=445dc 
> D=445dc010 L=10 DMA_TO_DEVICE attrs=0
> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=16 bi=0
> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=16 bi=0
> [  142.458234] DMA-API: add_dma_entry start P=ba79f210 N=ba79f 
> D=ba79f210 L=10 DMA_FROM_DEVICE attrs=0
> 
> This actually illustrates exactly the reason why this is unsupportable. 
> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping 
> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range 
> ba79f200-ba79f23f to be written back over the top of data that the 
> device has already started to write to memory. Hello data corruption.
> 
> Separate DMA mappings should be from separate memory allocations, 
> respecting ARCH_DMA_MINALIGN.
> 

I just saw something strange, only one SG is involved, and I dont see any DMA_TO_DEVICE for ba79f210.
I see 2 DMA_FROM_DEVICE (ba79f200 and ba79f210), but only one should be done.
Why 2 FROM mappings are added with only one sg ?

