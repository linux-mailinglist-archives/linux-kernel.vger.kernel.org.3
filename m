Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1054DFF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376807AbiFPLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376442AbiFPLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849D5DE46;
        Thu, 16 Jun 2022 04:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F2CAB82360;
        Thu, 16 Jun 2022 11:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ACCC34114;
        Thu, 16 Jun 2022 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655378715;
        bh=iIk2YS5z65pjvpfKrUKwRuHJctWgL1FjnG556xx/xV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ceqGBWqVUrt6dyOkV2RGVN1XXwmlKVQ4sllwi+WyxWWVVQrAqpZygZBxXykX1FgEp
         K1wEVpFQHojUm0ufK7sjR3+x6BasaudcVJ6P9GCayrYVDoXLubotPG7kmuheZjQc1k
         cjid70BIz96LbbYL4dkeijs4bquJuVz7yZ19d9grrB+4WagEjr2xpiwTK5aamv4prw
         J7xEoyn8lJqdbQGCJAvfVHDFSsmUAehPBSm0h8E9Pxd/mr37jVmEAA5DUKAPmVweGy
         az2jFmPfO+Cj0JvGhU/9LPwnmcFuG2qoVv126pgUNfdSzR7xCV1ykrNq81PsX4n1si
         hTmdXSqwlUbjA==
Received: by mail-ot1-f54.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so816256otg.3;
        Thu, 16 Jun 2022 04:25:15 -0700 (PDT)
X-Gm-Message-State: AJIora+HNLWsZLLlTda+6E1yFV412SprlGhz1+81WZoszaGIOcoZ3h2A
        iEETB8jUsMYcgMKdgBdy2DHHgZmLPQk1WkPG2Ww=
X-Google-Smtp-Source: AGRyM1sq6WhQFq4kYMdW/m0PJWq0sNgWE09mDloXs/0UqdIfemWCq+RA5+Bc450OKx4Yj2EjPEeqDY5pIUAi1ElWO/4=
X-Received: by 2002:a9d:37a3:0:b0:60c:5427:1f56 with SMTP id
 x32-20020a9d37a3000000b0060c54271f56mr1824706otb.71.1655378714352; Thu, 16
 Jun 2022 04:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220615154142.1574619-1-ardb@kernel.org> <20220615154142.1574619-4-ardb@kernel.org>
In-Reply-To: <20220615154142.1574619-4-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jun 2022 13:25:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfVi8sYXR0z42v72XfTBaQ9jaDAzuLuK=TBKHUqKkEPA@mail.gmail.com>
Message-ID: <CAMj1kXFfVi8sYXR0z42v72XfTBaQ9jaDAzuLuK=TBKHUqKkEPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] jump_label: make initial NOP patching the special case
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 17:41, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Instead of defaulting to patching NOP opcodes at init time, and leaving
> it to the architectures to override this if this is not needed, switch
> to a model where doing nothing is the default. This is the common case
> by far, as only MIPS requires NOP patching at init time. On all other
> architectures, the correct encodings are emitted by the compiler and so
> no initial patching is needed.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/staging/static-keys.rst |  3 ---
>  arch/arc/kernel/jump_label.c          | 13 -------------
>  arch/arm/kernel/jump_label.c          |  6 ------
>  arch/arm64/kernel/jump_label.c        | 11 -----------
>  arch/mips/include/asm/jump_label.h    |  2 ++
>  arch/parisc/kernel/jump_label.c       | 11 -----------
>  arch/riscv/kernel/jump_label.c        | 12 ------------
>  arch/s390/kernel/jump_label.c         |  5 -----
>  arch/x86/kernel/jump_label.c          | 13 -------------
>  kernel/jump_label.c                   | 14 +++++---------
>  10 files changed, 7 insertions(+), 83 deletions(-)
>

This needs the following hunk as well, as spotted by the bot:

--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -220,8 +220,6 @@ extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
                                      enum jump_label_type type);
-extern void arch_jump_label_transform_static(struct jump_entry *entry,
-                                            enum jump_label_type type);
 extern bool arch_jump_label_transform_queue(struct jump_entry *entry,
                                            enum jump_label_type type);
 extern void arch_jump_label_transform_apply(void);

Let me know if I need to resend for this.
