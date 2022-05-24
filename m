Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656FC5320E5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiEXCW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiEXCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:22:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382F9969A;
        Mon, 23 May 2022 19:22:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6dJq1p1dz4xYY;
        Tue, 24 May 2022 12:22:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1653358972;
        bh=23gpOQQJ/fv8/qwDF68c85b3c418u/QJJTgIjBTIEYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vz/0zOkh11h32x1S+vJ0dfgu+9jJgWUJNHb0CchW47kngs0PqZLMKT7noGRBVFEwE
         39XRrPncQJjqRDMGqzleHq0xMSJOoyAeGnmsgCeOWcevvawiwHUQL05alQKkjBDNr2
         DB/mKxEjKdt3VtW72OKus9OFCAh+QQr5LPwIYflgraXq1NiXjFZ4CDkql2MlO6JRvj
         hRiWh8rPsSysHWoFNTliHIKLSaeZpQQyAa2uyOJAUJBlY2tJzgh6rRoTXwIKdFnXI1
         IecCU3YpTi4TzIfXCuaGB4wpSGR4qMCnuiZT7O9cFV448cQc4aSLfUe5qPMy/fUyrP
         GpTB+KpFeXJlw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: changed messages in qemu boot
In-Reply-To: <1653069342.3xtfot6wli.naveen@linux.ibm.com>
References: <20220520233602.2738d87c@canb.auug.org.au>
 <1653069342.3xtfot6wli.naveen@linux.ibm.com>
Date:   Tue, 24 May 2022 12:22:45 +1000
Message-ID: <87czg3mzyi.fsf@mpe.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next bboot of the powerpc pseries_le_defconfig build
>> produced these different kernel messages (diff from yesterday's tree):
>> 
>> - ftrace: allocating 33658 entries in 13 pages
>> - ftrace: allocated 13 pages with 3 groups
>> + ftrace-powerpc: Address of ftrace_regs_caller out of range of kernel_toc.
>
> Thanks for the report. I think that is due to:
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/bb6626e884acffe87b58736291df57db3deaa9b9.1652074503.git.christophe.leroy@csgroup.eu/

Yep, I bisected it there.

I should really read my email before bisecting :)

> The below diff fixes it for me:
>
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
> index 46c002a8388804..7418da705d43ac 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -746,7 +746,7 @@ int __init ftrace_dyn_arch_init(void)
>  
>         reladdr = addr - kernel_toc_addr();
>  
> -       if (reladdr >= SZ_2G || reladdr < -SZ_2G) {
> +       if (reladdr >= SZ_2G || reladdr < -_UL(SZ_2G)) {
>                 pr_err("Address of %ps out of range of kernel_toc.\n",
>                                 (void *)addr);
>                 return -1;

I did:

	if (reladdr >= SZ_2G || reladdr < -(long)SZ_2G) {


Which more closely matches what the old code did, and I think is more
obvious? ie. we don't want to negate the unsigned value, we want a
signed value, and then the negative of that.

cheers
