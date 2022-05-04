Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E413D51AF3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378112AbiEDUgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378082AbiEDUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:36:37 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8EA04FC6B;
        Wed,  4 May 2022 13:33:00 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nmLg3-0003MI-01; Wed, 04 May 2022 22:32:51 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 61086C01D0; Wed,  4 May 2022 22:28:22 +0200 (CEST)
Date:   Wed, 4 May 2022 22:28:22 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     macro@orcam.me.uk, liam.howlett@oracle.com, geert@linux-m68k.org,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: adding a safety check for cpu_has_fpu
Message-ID: <20220504202822.GB23391@alpha.franken.de>
References: <20220502032002.840029-1-starzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502032002.840029-1-starzhangzsd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:20:02AM +0800, Stephen Zhang wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> There is a chance 'cpu_has_fpu' would still be overridden when the
> CONFIG_MIPS_FP_SUPPORT configuration option has been disabled. So
> add a safety check for 'cpu_has_fpu'.
> 
> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  Changelog in v1 -> v2:
>  - Choose to redefine cpu_has_fpu to solve the problem silently.
> 
>  Changelog in v2 -> v3:
>  - Choose to point out the error instead.
> 
>  Changelog in v3 -> v4:
>  - Make the check work for 'nofpu' option.
> 
>  arch/mips/include/asm/cpu-features.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index de8cb2ccb781..c0983130a44c 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -133,6 +133,9 @@
>  #  define raw_cpu_has_fpu	0
>  # endif
>  #else
> +# if cpu_has_fpu
> +#  error "Forcing `cpu_has_fpu' to non-zero is not supported"
> +# endif
>  # define raw_cpu_has_fpu	cpu_has_fpu
>  #endif
>  #ifndef cpu_has_32fpr
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
