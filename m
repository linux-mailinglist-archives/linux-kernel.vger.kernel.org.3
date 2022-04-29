Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2E514EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378131AbiD2PPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378115AbiD2PO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:14:58 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B163ED4477;
        Fri, 29 Apr 2022 08:11:39 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C540B92009C; Fri, 29 Apr 2022 17:11:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BEEC492009B;
        Fri, 29 Apr 2022 16:11:38 +0100 (BST)
Date:   Fri, 29 Apr 2022 16:11:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Stephen Zhang <starzhangzsd@gmail.com>, liam.howlett@oracle.com,
        ebiederm@xmission.com, alobakin@pm.me, f.fainelli@gmail.com,
        paul@crapouillou.net, linux@roeck-us.net, anemo@mba.ocn.ne.jp,
        zhangshida@kylinos.cn, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is
 overrided
In-Reply-To: <20220429095104.GA11365@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk>
References: <20220429032621.674865-1-starzhangzsd@gmail.com> <20220429095104.GA11365@alpha.franken.de>
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

On Fri, 29 Apr 2022, Thomas Bogendoerfer wrote:

> > diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> > index de8cb2ccb781..38eb469008b6 100644
> > --- a/arch/mips/include/asm/cpu-features.h
> > +++ b/arch/mips/include/asm/cpu-features.h
> > @@ -134,6 +134,10 @@
> >  # endif
> >  #else
> >  # define raw_cpu_has_fpu	cpu_has_fpu
> > +# ifndef CONFIG_MIPS_FP_SUPPORT
> > +#  undef cpu_has_fpu
> > +#  define cpu_has_fpu		0
> > +# endif
> >  #endif
> >  #ifndef cpu_has_32fpr
> >  #define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
> > -- 
> > 2.30.2
> 
> I prefer just removing the #defines from ip27/ip30 cpu-feasture-overrides.h. 
> Or isn't that enough for fixing the problem ?

 That's what I've meant, and I have now posted fixes, successfully 
build-tested.

 Additionally I've thought of adding something like:

#if cpu_has_fpu
# undef cpu_has_fpu
#endif

or maybe even:

#if cpu_has_fpu
# error "Forcing `cpu_has_fpu' to non-zero is not supported"
#endif

to arch/mips/include/asm/cpu-features.h, but maybe that's an overkill.

  Maciej
