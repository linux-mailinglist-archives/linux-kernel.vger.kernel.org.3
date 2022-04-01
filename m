Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DCB4EF999
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347606AbiDASQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbiDASQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D52178681
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 287C760C6C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B9C340EE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648836855;
        bh=kqU9j86Fp20yiuk8kX7VoDCOGTK2BPuNyNh6eBUBXXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HWRpGX4VIciF/GlnmQv6GJXgQ+OyVRdB2wgg9us7F85HQm/c2I0dS4nRq0y4Vw9QM
         tr9hwIO63BWy3fyu7nlMXBlo1IcVkWB1myDWpWUmoGewxy9PJW2RSzNOu3HwE2/6ZV
         POhh64oogsyLx9uRWiB7tWJ6QGnEzg2zLU+5M0DvHlhJbhVLNFXh1ul9N8HJdXqi+1
         xWQXW68UtibXGdJGKREna7V522YPtYDR4XKJQOAIbC80rc61gOytRUYD/SDVXnKt6l
         p8kKnk48sQvs6rmnHcbgLqi3c3Wfe8PQ3Coy3OChuWrywMtDglBcwDxWhpz/IaVSE1
         7sFHryACB157w==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e6ceb45174so41846567b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:14:15 -0700 (PDT)
X-Gm-Message-State: AOAM532O/ZszlRi/GonNwJunH236l0wbE40aOcmGVIVB3QvCu63sgQ5E
        j+gBfPdVBTpD5gWDaxb8rM5BI+3E/wtS8gyop08=
X-Google-Smtp-Source: ABdhPJxX72PNJDxsBPPdOyCYcv5vbaFnbRnCdQFgmooWJ9gguxs2v2t8FmJaG5mRQzA59s9ZS0nSEuJvmAPfj2gW8xo=
X-Received: by 2002:a0d:d912:0:b0:2e6:4099:b34f with SMTP id
 b18-20020a0dd912000000b002e64099b34fmr11356518ywe.46.1648836854617; Fri, 01
 Apr 2022 11:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220401163909.20343-1-palmer@rivosinc.com>
In-Reply-To: <20220401163909.20343-1-palmer@rivosinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Fri, 1 Apr 2022 21:13:48 +0300
X-Gmail-Original-Message-ID: <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
Message-ID: <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Elide a warning on 32-bit targets
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Ohad Sharabi <osharabi@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 7:41 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This double-cast pattern looks a bit awkward, but it already exists
> elsewhere in the driver.  Without this patch I get
>
> drivers/misc/habanalabs/common/memory.c: In function =E2=80=98alloc_devic=
e_memory=E2=80=99:
> drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointe=
r to integer of different size [-Wpointer-to-int-cast]
>   153 |                                                 (u64) gen_pool_dm=
a_alloc_align(vm->dram_pg_pool,
>       |                                                 ^
>
> which ends up promoted to a build error in my test setup.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
>
> I don't know anything about this driver, I'm just pattern-matching the
> warning away.
> ---
>  drivers/misc/habanalabs/common/memory.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/haban=
alabs/common/memory.c
> index e008d82e4ba3..f1fc79c1fc10 100644
> --- a/drivers/misc/habanalabs/common/memory.c
> +++ b/drivers/misc/habanalabs/common/memory.c
> @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, =
struct hl_mem_in *args,
>                 for (i =3D 0 ; i < num_pgs ; i++) {
>                         if (is_power_of_2(page_size))
>                                 phys_pg_pack->pages[i] =3D
> -                                               (u64) gen_pool_dma_alloc_=
align(vm->dram_pg_pool,
> -                                                                        =
       page_size, NULL,
> -                                                                        =
       page_size);
> +                                               (u64) (uintptr_t) gen_poo=
l_dma_alloc_align(vm->dram_pg_pool,
> +                                                                        =
                  page_size, NULL,
> +                                                                        =
                  page_size);
>                         else
> -                               phys_pg_pack->pages[i] =3D (u64) gen_pool=
_alloc(vm->dram_pg_pool,
> -                                                                        =
       page_size);
> +                               phys_pg_pack->pages[i] =3D (u64) (uintptr=
_t) gen_pool_alloc(vm->dram_pg_pool,
> +                                                                        =
                 page_size);
>                         if (!phys_pg_pack->pages[i]) {
>                                 dev_err(hdev->dev,
>                                         "Failed to allocate device memory=
 (out of memory)\n");
> --
> 2.34.1
>

This patch is:
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Greg,
Could you please apply this directly to your misc tree and send it to
Linus at your next pull request ?
I don't have any other fixes pending for 5.18.

For 5.19 we will do a more elegant solution that Arnd has recommended.

Thanks,
Oded
