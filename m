Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4702C5A0ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiHYHxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHYHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:53:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA69A00E6;
        Thu, 25 Aug 2022 00:53:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MCwDt5BS1z4xV9;
        Thu, 25 Aug 2022 17:53:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661413983;
        bh=UtVip1icK7gJdBlHq+HFWJBnOoW3QoCQ+h8pU+n3KkA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZLFEHd4Sc+LArWxSHPMZaxUV5Xt5HbCBwxEJoAOkDftQUBd3UvDzQ3SPoUGfIq8+Y
         XOXVABGmUJRXNewPOhBZ4PnZBgAclyRWiDmLWWWIEoOxbTyf0lT9HmzLfn6qDXHVP8
         4cFLNr2mtb3VMBT0+X8XSw8kOQcDbMBET6kwqKOBcIoT5DWSkK5aoD9YgXXoTklXi4
         4vn7aZmWvMmRDrzEWJ1c3IdlA0o+UvHCBus9SLXerZ9zIaIxILLCzH95mjf0d5/kTH
         Nh5wLMJbIfMZsTuGrUc2j6C3xLq/AaC3ujgNFv8DeGoG8jRuDO1B7lmoCz2us+rszT
         QVS80HXLzHXbw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: align syscall table for ppc32
In-Reply-To: <20220820165129.1147589-1-masahiroy@kernel.org>
References: <20220820165129.1147589-1-masahiroy@kernel.org>
Date:   Thu, 25 Aug 2022 17:53:02 +1000
Message-ID: <874jy0lpy9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> Christophe Leroy reported that commit 7b4537199a4a ("kbuild: link
> symbol CRCs at final link,  removing CONFIG_MODULE_REL_CRCS") broke
> mpc85xx_defconfig + CONFIG_RELOCATABLE=y.
>
>     LD      vmlinux
>     SYSMAP  System.map
>     SORTTAB vmlinux
>     CHKREL  vmlinux
>   WARNING: 451 bad relocations
>   c0b312a9 R_PPC_UADDR32     .head.text-0x3ff9ed54
>   c0b312ad R_PPC_UADDR32     .head.text-0x3ffac224
>   c0b312b1 R_PPC_UADDR32     .head.text-0x3ffb09f4
>   c0b312b5 R_PPC_UADDR32     .head.text-0x3fe184dc
>   c0b312b9 R_PPC_UADDR32     .head.text-0x3fe183a8
>       ...
>
> The compiler emits a bunch of R_PPC_UADDR32, which is not supported by
> arch/powerpc/kernel/reloc_32.S.
>
> The reason is there exists an unaligned symbol.
>
>   $ powerpc-linux-gnu-nm -n vmlinux
>     ...
>   c0b31258 d spe_aligninfo
>   c0b31298 d __func__.0
>   c0b312a9 D sys_call_table
>   c0b319b8 d __func__.0
>
> Commit 7b4537199a4a is not the root cause. Even before that, I can
> reproduce the same issue for mpc85xx_defconfig + CONFIG_RELOCATABLE=y
> + CONFIG_MODVERSIONS=n.
>
> It is just that nobody did not notice it because when CONFIG_MODVERSIONS
> is enabled, a __crc_* symbol inserted before sys_call_table was hiding
> the unalignment issue.
>
> I checked the commit history, but I could not understand commit
> 46b45b10f142 ("[POWERPC] Align the sys_call_table").
>
> It said 'Our _GLOBAL macro does a ".align 2" so the alignment is fine
> for 32 bit'. I checked the _GLOBAL in include/asm-powerpc/ppc_asm.h
> at that time. _GLOBAL specifies ".align 2" for ppc64, but no .align
> for ppc32.
>
> Commit c857c43b34ec ("powerpc: Don't use a function descriptor for
> system call table") removed _GLOBAL from the syscall table.
>
> Anyway, adding alignment to the syscall table for ppc32 fixes the issue.
>
> I am not giving Fixes tag because I do not know since when it has been
> broken, but presumably it has been for a long while.

Thanks.

I trimmed the change log a bit just to say ~= it's been broken for ever,
and added a Cc to stable.

cheers
