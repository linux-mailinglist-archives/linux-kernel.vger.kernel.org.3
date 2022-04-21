Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136E3509783
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384804AbiDUG3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDUG32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:29:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63913EB1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79095617A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46B1C385AE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650522398;
        bh=eASUq5L0Nno4NQmQJ4ufntLP3HwDZGjYeatCzopIFSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GS11EPRTbhosmpW/YEtzB5p5qEvI0FScH/Rczym554O+bgWYubZjyV37rp2xp0E9X
         yYQbN8MS1QtNKK8iD0OMaXEGnjLzV875nKh3BOFIg0153ofKMjDN/z/LtuGYVR91Cw
         0VKfg2PJdudxM/eh0hiW6inFLGG8iMdwyKw3HehwzxvC+tSBER3CdkMSkBhTvl1tiy
         FulbafK51FMG+NNKu4Zqj+iPEbA0S5ZHZf7iCw0crc6DuhTCVejDZYaSQ1o5DOqt/H
         6X1Zh5uebqVmHI6Zur48fHcunBxicevuv1neqnfEpQ6DIWZ40XFn7ZCIgOXze1N7tF
         T40UG91xWrmCA==
Received: by mail-vk1-f173.google.com with SMTP id j4so1840659vki.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:26:38 -0700 (PDT)
X-Gm-Message-State: AOAM532Pf41u29y/1rcmldxbK1ip8+Oa8xqAppII9bIWPIaFUDUrQUGZ
        q3KvtMHxQ34P1mCSELNDtSAnS1IQ0vscQPCMMXE=
X-Google-Smtp-Source: ABdhPJyEmGQTQEFgId+gMvpD05ztW7hJbrJQSVqKqTwj1LgijqIgTQNKfp5ziRJ7/nwqVTTW8ZTRCHsm8VZtxW5D8Yk=
X-Received: by 2002:a1f:1b07:0:b0:348:f10f:82b2 with SMTP id
 b7-20020a1f1b07000000b00348f10f82b2mr7251328vkb.8.1650522397713; Wed, 20 Apr
 2022 23:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220420184056.7886-1-palmer@rivosinc.com> <20220420184056.7886-3-palmer@rivosinc.com>
In-Reply-To: <20220420184056.7886-3-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Apr 2022 14:26:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTyhN-Y8bH+o67NyGvpGZJawtPq4FPQ=dBCqUXOjjL=KQ@mail.gmail.com>
Message-ID: <CAJF2gTTyhN-Y8bH+o67NyGvpGZJawtPq4FPQ=dBCqUXOjjL=KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] RISC-V: ignore xipImage
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        jszhang@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
        gatecat@ds0.me, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Apr 21, 2022 at 2:48 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This built file shows up in "git status" without an explicit ignore.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/boot/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
> index 90e66adb7de5..0cea9f7fa9d5 100644
> --- a/arch/riscv/boot/.gitignore
> +++ b/arch/riscv/boot/.gitignore
> @@ -4,3 +4,4 @@ Image.*
>  loader
>  loader.lds
>  loader.bin
> +xipImage
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
