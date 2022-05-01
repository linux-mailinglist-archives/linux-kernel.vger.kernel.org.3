Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563D551644A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbiEAMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiEAMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:01:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421983A5C2;
        Sun,  1 May 2022 04:57:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Krl8S2W6kz4xXh;
        Sun,  1 May 2022 21:57:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651406250;
        bh=KLrQiQd2hh/CdsUpLpsJ9wNQAuRET+XGyyixHfrk344=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rfnAWHaonFRnz6CX4sVxw3eZHjjOz4D9N7EJqBE1ipI7gaFq+MUEydrsMMkNN1XV3
         aSEu6GrtTP7fWb/wAdUbvPPqmF/Rz2J822VD/S253BRxJhKZ1XVsebbSA1zb7wE+S2
         OyKD6NReOSJoK/gmlrYpe8wMbvtLHHfzP/l++wJw7op30vjeDgZOS3wgbCsTt/+tFo
         SOb4M9LlHKENd+ypDOthi3jm1q92QnsgQ6kbrn3/slh7+IBtUoWOmTgj1uO40abV8t
         Gso3VDnoPCz7g2IkVuRgEO51oqRPkePXa/ZSKZ9dun4rFMc5uTCSXqLJ96/4shy1T6
         0YsikNdHwIWow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kbuild: drop $(objtree)/ prefix support for clean-files
In-Reply-To: <20220430110409.256858-1-masahiroy@kernel.org>
References: <20220430110409.256858-1-masahiroy@kernel.org>
Date:   Sun, 01 May 2022 21:57:24 +1000
Message-ID: <871qxda2jf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> I think this hack is a bad idea. arch/powerpc/boot/Makefile is the
> only user. Let's stop doing this.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/boot/Makefile | 4 ++--

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

>  scripts/Makefile.clean     | 8 +-------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 4b4827c475c6..008bf0bff186 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -453,8 +453,8 @@ clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
>  clean-kernel-base := vmlinux.strip vmlinux.bin
>  clean-kernel := $(addsuffix .gz,$(clean-kernel-base))
>  clean-kernel += $(addsuffix .xz,$(clean-kernel-base))
> -# If not absolute clean-files are relative to $(obj).
> -clean-files += $(addprefix $(objtree)/, $(clean-kernel))
> +# clean-files are relative to $(obj).
> +clean-files += $(addprefix ../../../, $(clean-kernel))
>  
>  WRAPPER_OBJDIR := /usr/lib/kernel-wrapper
>  WRAPPER_DTSDIR := /usr/lib/kernel-wrapper/dts
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 74cb1c5c3658..878cec648959 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -36,13 +36,7 @@ __clean-files	:= \
>  
>  __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
>  
> -# clean-files is given relative to the current directory, unless it
> -# starts with $(objtree)/ (which means "./", so do not add "./" unless
> -# you want to delete a file from the toplevel object directory).
> -
> -__clean-files   := $(wildcard                                               \
> -		   $(addprefix $(obj)/, $(filter-out $(objtree)/%, $(__clean-files))) \
> -		   $(filter $(objtree)/%, $(__clean-files)))
> +__clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
>  
>  # ==========================================================================
>  
> -- 
> 2.32.0
