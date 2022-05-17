Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACE52A85C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbiEQQms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351106AbiEQQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:42:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EC403D7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82EB9B8181B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A2DC385B8;
        Tue, 17 May 2022 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652805761;
        bh=1IrxNJ1bp3kbA2oD6OHuufL2ZTrxl/ACrlKCvG7jTxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQeQSS+V1lj64xDAGzkxKJCHnkihMRbBKk2KbalQc+XmCt4HPchv4lCVWrSfzd2Od
         5K9XN4lutNDsC40vvqk8mXq0gt+/ob0xmC3xmHOjP5iI7Kh/J2VY2WTe5UVmzEk3uH
         YDKCHwuDl7AEKV/0qhQOD4dXaCjUxV7iIGJlNg1kxu7e/RDsyVbHof/Vr2HYcw2FXG
         Vdmt22FdW9mQG5UDeUIpwIXE5D3u+PeV5Dt6Aie3aCTujOhLapO+j8pGhnxZKoPV4Q
         Izz8BTiWQmqm8/WksnkH830yWMBwQZe8w3ylhaGQ85eS+VAL26Dlw2J0L8CNHZCqtg
         EsTsYVHVsDQfg==
Date:   Wed, 18 May 2022 00:33:52 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 2/4] riscv: introduce unified static key mechanism for
 CPU features
Message-ID: <YoPOcHvhWEqeEwzo@xhacker>
References: <20220508160749.984-1-jszhang@kernel.org>
 <20220508160749.984-3-jszhang@kernel.org>
 <CAK9=C2Xinc6Y9ue+3ZOvKOOgru7wvJNcEPLvO4aZGuQqETXi2w@mail.gmail.com>
 <YnkoKxaPbrTnZPQv@xhacker>
 <CAOnJCU+XR5mtqKBQLMj3JgsTPgvAQdO_jj2FWqcu7f9MezNCKA@mail.gmail.com>
 <YoCollqhS93NJZjL@xhacker>
 <CAAhSdy3_av5H-V_d5ynwgfeZYsCnCSd5pFSEKCzDSDBbD+pGLA@mail.gmail.com>
 <YoKIv2ATRdQfYbBf@xhacker>
 <CAK9=C2VJ-+bu20+QOfKrq6cEBE93Yi21U=zU9AKOSQi1GGHWiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK9=C2VJ-+bu20+QOfKrq6cEBE93Yi21U=zU9AKOSQi1GGHWiA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:31:50AM +0530, Anup Patel wrote:
> On Mon, May 16, 2022 at 11:02 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
...
> > Currently, RISCV_ISA_EXT_MAX equals to 64 while the base ID is 26.
> > In those 26 base IDs, only F/D and V need static key, it means
> > we waste at least 24 static keys.
> 
> If you want to save space of unused static keys then there are other
> ways.
> 
> For example, you can create a small static key array which has
> many-to-one relation with the ISA extension numbers. For ISA extension

"any problem in computer science can be solved with another layer of
indirection" ;)
I see your points, thanks very much! But I think the array should
be a static inline function to make use of compiler optimization to
avoid the array references for performance. And the static key check
maybe used in modules, I want to export less vars.
I'm cooking the patches, will send out for review soon.

> which are always ON or always OFF, we can use fixed FALSE and
> TRUE keys. Something like below.
> 
> enum riscv_isa_ext_key {
>     RISCV_ISA_EXT_KEY_FALSE = 0,
>     RISCV_ISA_EXT_KEY_TRUE,
>     RISCV_ISA_EXT_KEY_FLOAD, /* For 'F' and 'D' */
>     RISCV_ISA_EXT_KEY_VECTOR, /* For all vector extensions */
>     RISCV_ISA_EXT_KEY_SVINVAL,
>     RISCV_ISA_EXT_KEY_SSCOFPMT,
>     RISCV_ISA_EXT_KEY_MAX,
> };
> 
> extern unsigned char __riscv_isa_ext_id2key[RISCV_ISA_EXT_ID_MAX];
> extern struct static_key_false __riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_MAX];
> 
> static __always_inline bool __riscv_isa_extension_keycheck(unsigned int ext)
> {
>     if (RISCV_ISA_EXT_ID_MAX <= ext)
>         return false;
>     return static_branch_unlikely(&__riscv_isa_ext_keys[__riscv_isa_ext_id2key[ext]]);
> }
> #define riscv_isa_extension_keycheck(ext)    \
>     __riscv_isa_extension_keycheck(RISCV_ISA_EXT_##ext)
> 

