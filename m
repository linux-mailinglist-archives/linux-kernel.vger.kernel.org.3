Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B84CFE42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbiCGMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiCGMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:25:14 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978D25CA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:24:19 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2dc0364d2ceso161695727b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tj6WbMsdxlADcgXiMOHHwve+HOHgnfHXu+gQYVdroXE=;
        b=pHA+arVpLeTc3erxecGoIXrFCvy4PoDrWBlqN8JIF7mY2IGoJbMBczR89LA2bS8aMC
         yguRLI+tmcPDIgqqdDUxTOs/kjZFjF5CeNzYIGsqsIQg314nMvzyZOBF02WbUroTpWtV
         GDarJgyW7mr2EOnsWgcBsoa7X44OG1aPm3YigITnEba1sXuXKJfiaVAAkO/G+fs8hWLZ
         gbImZMGZnvXL73zDUG4UevZDohbEcoBL59i64nUpIoPESpteWCFwyi49hKcXFjzlVzcJ
         Bk1TMLuG4GI7/6Zz0I/Y+8IGDZLfq58POLxPMxi5crda+VOekW9RP4bhWlUAyN2YzXng
         kyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tj6WbMsdxlADcgXiMOHHwve+HOHgnfHXu+gQYVdroXE=;
        b=FhxH/pcwuagNyEpRw9z0wk/i/ud59rcNlPE45w3IHcn1FQ/V+a4oOXkUpKnuunq76c
         m7YYe/KTgAYIlKX+4Q7Pcs4ivLqgUlpesuizzf0LasZODti2a4QgDnZiyPWp3FYhigz8
         ylrPUdapVFsE6fohn/gRN0aDBNTOKOePET+LJdLaq9P3nny7hSkfixK4DtdOx2WRsjVj
         eGIo38bT/qkg5gvljaZKURN1IXPfYjqqbSZae1CKykE6kth7Ki5GHY0DvKbVc06OsAMc
         1YhJc16bYx97NSckTqMKOTXKXbmm57VvtZEnhWRy6ENMvZVRSD5LOwqgPxw4Q3fdcwBw
         NaZA==
X-Gm-Message-State: AOAM531UaiM7zxsKhhsvWqmHSB+GJ3U5z732QA/KtySkEMhSX192Amev
        DHGcm5/El4fGme+xttSQwC2knoBdGxbevEM3kz25ng==
X-Google-Smtp-Source: ABdhPJwIUBOImWd12VmEHZQOywK+J1aNy/4vn/CBPX5NYh0qWlcSv8SAgVPPCFqajq3puTrLz/Yhh6dWwpatPuuumFM=
X-Received: by 2002:a0d:d8d6:0:b0:2dc:1054:13a0 with SMTP id
 a205-20020a0dd8d6000000b002dc105413a0mr8131121ywe.54.1646655858855; Mon, 07
 Mar 2022 04:24:18 -0800 (PST)
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
Date:   Mon, 7 Mar 2022 14:24:08 +0200
Message-ID: <CAOtvUMd_mtDjP1WRQ9imjh99bEf3gtJSb3OCr7Q6-Aky2_5-dQ@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

By the way, this comes from a totally different call site than the
previous drbg.

Judging from the fact that we've never seen this error before and that
you start seeing it suddenly from different drivers on different
platforms from different call sites ...

I suspect this is caused by some recent addition or change.

Which tree are you building this from and does it have dma related
commits? may try toi bisect this?

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
