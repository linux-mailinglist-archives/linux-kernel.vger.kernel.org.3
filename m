Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A233351FCCC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiEIMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiEIMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:31:41 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27361194AC;
        Mon,  9 May 2022 05:27:46 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 249CROCX021298;
        Mon, 9 May 2022 21:27:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 249CROCX021298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652099245;
        bh=9ZREDIwDJkJCOxf0Q7gD+6Ncs0UyaKKdGV/vXUHeEUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LXkPlitsldQAhSFiivvju1AEhj66HarIC/nEm/pBS3fUXr42LQOIMlLrIiImeBOZl
         agJ4j8J3xFbB3gWg+msAJ4sjlUcZOZu7yuyIvmCXlgXZKmHvVnIPPWG1YK2tVgQnQ5
         6fEyJzHTODJs3HsylyioEHQjPQcRU0Fg1jEMR+unbw20b3i9NN4y+6HRTWEeXyIwpn
         grTYN0iGmeCvCk144b0DIRABvLe8UQJMdDzXimQpt3KEfAnoRsSE2PsslPdh/JdSJm
         2wVg2HzGaTYtU+nA+zkpegub49phY4udeJnbo8VsCRwsOCdZhMCHrRR+SmKSeNs7tL
         1P190Nha1RGCw==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id bo5so12108481pfb.4;
        Mon, 09 May 2022 05:27:25 -0700 (PDT)
X-Gm-Message-State: AOAM532auYzZHO+yBx9pmSIjgdq5bhn86vd3em9CctSnt/y3DYByjF9R
        Asm3vYX1cL1nkTBsDe8yaV3520OXlaVzHTeyLW8=
X-Google-Smtp-Source: ABdhPJwft+jfg4wCJmRcx83XEPifYs1YNhu4Tpav41+FCLfN3Qx7FEGq2iEWIl802HkeH3iO3hYsMvpAb6HUcC5o0eg=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr16065543pfj.32.1652099244425; Mon, 09
 May 2022 05:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220509211004.2c2073ef@canb.auug.org.au>
In-Reply-To: <20220509211004.2c2073ef@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 May 2022 21:26:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGbe3nz-dHr9oh511dM-wVtj_cqZHsusaK97OM4tEmxw@mail.gmail.com>
Message-ID: <CAK7LNASGbe3nz-dHr9oh511dM-wVtj_cqZHsusaK97OM4tEmxw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the crypto tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 8:10 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the crypto tree, today's linux-next build (powerpc
> pseries_le_defconfig) failed like this:
>
> ccnI8W1t.s: Assembler messages:
> ccnI8W1t.s: Error: .size expression for aes_p8_set_encrypt_key does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_set_encrypt_key does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_set_decrypt_key does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_set_decrypt_key does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_decrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_decrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_cbc_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_cbc_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_ctr32_encrypt_blocks does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_ctr32_encrypt_blocks does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_xts_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_xts_encrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for aes_p8_xts_decrypt does not evaluate to a constant
> ccnI8W1t.s: Error: .size expression for .aes_p8_xts_decrypt does not evaluate to a constant
>
> Caused by commit
>
>   b52455a73db9 ("crypto: vmx - Align the short log with Makefile cleanups")
>
> I have reverted that commit for today.


The fixup exists.

https://lore.kernel.org/lkml/20220507052244.1426765-1-masahiroy@kernel.org/


> --
> Cheers,
> Stephen Rothwell



-- 
Best Regards
Masahiro Yamada
