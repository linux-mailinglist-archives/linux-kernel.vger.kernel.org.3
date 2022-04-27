Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1A510D54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356432AbiD0An2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbiD0AnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:43:25 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CE7513F6E;
        Tue, 26 Apr 2022 17:40:14 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D055A92009D; Wed, 27 Apr 2022 02:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CAA3E92009C;
        Wed, 27 Apr 2022 01:40:12 +0100 (BST)
Date:   Wed, 27 Apr 2022 01:40:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when
 using handle_fpe
In-Reply-To: <20220426083259.526685-1-starzhangzsd@gmail.com>
Message-ID: <alpine.DEB.2.21.2204270130210.9383@angie.orcam.me.uk>
References: <20220426083259.526685-1-starzhangzsd@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022, Stephen Zhang wrote:

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 246c6a6b0261..ef9792261f91 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -90,7 +90,9 @@ extern asmlinkage void handle_cpu(void);
>  extern asmlinkage void handle_ov(void);
>  extern asmlinkage void handle_tr(void);
>  extern asmlinkage void handle_msa_fpe(void);
> +#ifdef CONFIG_MIPS_FP_SUPPORT
>  extern asmlinkage void handle_fpe(void);
> +#endif

 No need to conditionalise declarations ever.

> @@ -2489,8 +2491,10 @@ void __init trap_init(void)
>  	if (board_nmi_handler_setup)
>  		board_nmi_handler_setup();
>  
> +#ifdef CONFIG_MIPS_FP_SUPPORT
>  	if (cpu_has_fpu && !cpu_has_nofpuex)
>  		set_except_vector(EXCCODE_FPE, handle_fpe);
> +#endif

 No need to conditionalise this either, because `cpu_has_fpu' is forced 0 
(in arch/mips/include/asm/cpu-features.h) if !CONFIG_MIPS_FP_SUPPORT.  So 
this code translates to:

 if (0 && !0)
  set_except_vector(15, handle_fpe);

in the preprocessor if CONFIG_MIPS_FP_SUPPORT is unset and is optimised 
away.  Otherwise it should be written as:

	if (IS_ENABLED(CONFIG_MIPS_FP_SUPPORT) && ...

so as not to clutter C code with #ifdef, as per our coding style.

  Maciej
