Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3057F5AC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGXPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiGXPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:13:54 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43511453
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:13:51 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26OFDbMM008888
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:13:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26OFDbMM008888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658675618;
        bh=oiFMhm7uDjU3kqq1a01hrOtShD22Qh3LrQK0lfMWe9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A3UlfYb+zU4edSjqU3suKNUFKaWpU2OUYSgmaueuooSedaujiCC4SPBnM7AapWgb5
         JEas3SQWl3RHGyMgrTfKVMxtrhnD9X5CGO3Lo41kPNQ8HbZf278t5Gzsio/dtcNTw4
         cAyVRzrj6KOH6Nc5UxWV4wFc0YYKZgYzMDoK1EbBOp8qplS9uIN1wZj2co/NU9qk09
         tChl/cFRHSTjAjeN/z/KqHvGJS20KO8OAtC7qECKsqto3TaFe0HJ0DZEO4IqwnWqwn
         ySnnP/Z7zL+PDto7jSvo3Z41J738Mu0GD27OXpBzMeQPXc2M3mkIiti3NeJO+NbYla
         r5XnWF2oYLSAg==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id l15so8614608wro.11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:13:38 -0700 (PDT)
X-Gm-Message-State: AJIora+ewczaB5u6PyJLWJ8CiAzc9bsPcLu13vdLiZXG1nkmuJm2Z2/D
        HKmBw7YEC1VPy3tedPWFexE9BCeOT94ZdTXIxgg=
X-Google-Smtp-Source: AGRyM1uShHrO4T5UY6OkXCTlB4FwmFpeRAb42CPm68h6kQJyePMiAKxYFTuMHzEAd03vpoTkKvgGqonm79ayIOslvxk=
X-Received: by 2002:a5d:4e08:0:b0:21d:a689:7dd1 with SMTP id
 p8-20020a5d4e08000000b0021da6897dd1mr5254632wrt.477.1658675617101; Sun, 24
 Jul 2022 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220625223438.835408-1-masahiroy@kernel.org>
In-Reply-To: <20220625223438.835408-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Jul 2022 00:12:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyhvn1mU=cAA5zagJMExnfoTEZqi2irVvBKxfooA0JVQ@mail.gmail.com>
Message-ID: <CAK7LNARyhvn1mU=cAA5zagJMExnfoTEZqi2irVvBKxfooA0JVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/purgatory: hard-code obj-y in Makefile
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 7:36 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The purgatory/ directory is entirely guarded in arch/riscv/Kbuild.
> CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.
>
> $(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
> this Makefile for building.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

 Ping?


>  arch/riscv/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index d4df200f7edf..c2d14e2f345d 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -92,4 +92,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>         $(call if_changed,bin2c)
>
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
> +obj-y += kexec-purgatory.o
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
