Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB553D943
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbiFEC1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiFEC0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:26:55 -0400
X-Greylist: delayed 2278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Jun 2022 19:26:53 PDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A96BBC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 19:26:52 -0700 (PDT)
Received: from [2601:449:8480:af0::de51]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1nxfJ4-00D9V8-IG; Sat, 04 Jun 2022 20:43:54 -0500
Message-ID: <198e1080c142048ce6c8705a569fe0a0461e3682.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Diana Craciun <diana.craciun@nxp.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Jason Yan <yanaijie@huawei.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Sat, 04 Jun 2022 20:43:53 -0500
In-Reply-To: <20220604085050.4078927-1-masahiroy@kernel.org>
References: <20220604085050.4078927-1-masahiroy@kernel.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::de51
X-SA-Exim-Rcpt-To: masahiroy@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@csgroup.eu, diana.craciun@nxp.com, frank.rowand@sony.com, yanaijie@huawei.com, robh@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] powerpc: get rid of #include <generated/compile.h>
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-04 at 17:50 +0900, Masahiro Yamada wrote:
> You cannot include <generated/compile.h> here because it is generated
> in init/Makefile but there is no guarantee that it happens before
> arch/powerpc/mm/nohash/kaslr_booke.c is compiled for parallel builds.
> 
> The places where you can reliably include <generated/compile.h> are:
> 
>   - init/          (because init/Makefile can specify the dependency)
>   - arch/*/boot/   (because it is compiled after vmlinux)
> 
> Commit f231e4333312 ("hexagon: get rid of #include <generated/compile.h>")
> fixed the last breakage at that time, but powerpc re-added this.
> 
> <genearated/compile.h> was unneeded because 'build_str' is almost the
> same as 'linux_banner' defined in init/version.c
> 
> Let's copy the solution from MIPS.
> (get_random_boot() in arch/mips/kernel/relocate.c)
> 
> Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image
> offset")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> If this gets into the mainline before -rc2 or -rc3,
> I will base my kbuild work on top of this.
> 
> 
>  arch/powerpc/mm/nohash/kaslr_booke.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


