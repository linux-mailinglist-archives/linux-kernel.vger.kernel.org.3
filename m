Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B351462B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357211AbiD2KFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiD2KFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:05:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E66F7A9B1;
        Fri, 29 Apr 2022 03:01:50 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nkNRW-0002HQ-00; Fri, 29 Apr 2022 12:01:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E124FC01C9; Fri, 29 Apr 2022 11:51:04 +0200 (CEST)
Date:   Fri, 29 Apr 2022 11:51:04 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     liam.howlett@oracle.com, ebiederm@xmission.com, dbueso@suse.de,
        alobakin@pm.me, f.fainelli@gmail.com, paul@crapouillou.net,
        linux@roeck-us.net, anemo@mba.ocn.ne.jp, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is
 overrided
Message-ID: <20220429095104.GA11365@alpha.franken.de>
References: <20220429032621.674865-1-starzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429032621.674865-1-starzhangzsd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:26:21AM +0800, Stephen Zhang wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Undefine and redefine cpu_has_fpu to 0 when it is overridden with
> the "nofpu" option.
> 
> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  Changelog in v1 -> v2:
>  - Choose to redefine cpu_has_fpu to solve the problem.
> 
>  arch/mips/include/asm/cpu-features.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index de8cb2ccb781..38eb469008b6 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -134,6 +134,10 @@
>  # endif
>  #else
>  # define raw_cpu_has_fpu	cpu_has_fpu
> +# ifndef CONFIG_MIPS_FP_SUPPORT
> +#  undef cpu_has_fpu
> +#  define cpu_has_fpu		0
> +# endif
>  #endif
>  #ifndef cpu_has_32fpr
>  #define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
> -- 
> 2.30.2

I prefer just removing the #defines from ip27/ip30 cpu-feasture-overrides.h. 
Or isn't that enough for fixing the problem ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
