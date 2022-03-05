Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0514CE68D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiCETWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 14:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiCETWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 14:22:08 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B233535DCE;
        Sat,  5 Mar 2022 11:21:17 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7791F92009C; Sat,  5 Mar 2022 20:21:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6990592009B;
        Sat,  5 Mar 2022 19:21:15 +0000 (GMT)
Date:   Sat, 5 Mar 2022 19:21:15 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
In-Reply-To: <YiNlDxF9WppxbkiX@kernel.org>
Message-ID: <alpine.DEB.2.21.2203051837280.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <Yh3tgr+g/6IElq0P@kernel.org> <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn> <Yh4uUoYT+YS5Jxsv@kernel.org> <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk> <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn> <YiNlDxF9WppxbkiX@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022, Mike Rapoport wrote:

> > >  For example I have an x86 system that Linux does not how to interrogate
> > > for RAM beyond 64MiB, so I do use `memmap=128M@0' (for legacy reasons the
> > > x86 platform has a special exception to always exclude area between 640K
> > > and 1M from being used even if not explicitly specified, but we do not
> > > have a need for such legacy such legacy concerns with the MIPS port).  I
> > > consider it an interim measure however until the kernel has been fixed.
> > > 
> > >   Maciej
> > > 
> > 
> > Hi Mike, Thomas and Maciej,
> > 
> > Thank you very much for your feedbacks and discussions.
> > 
> > To be frank, I think mem= and memmap= are used for debugging and testing
> > in most cases, the intention of this patchset is to refactor the related
> > code to make them work well on mips.
> 
> mem= works fine on mips and there is no need to change it.
> 
> If you must supply complex memory layout on the command line, consider
> implementing support for memmap=exact and multiple memmap= parameters on
> the kernel command line, like x86 does.

 There's nothing to implement as the MIPS port has supported arbitrary 
memory maps since Dec 11th, 2000; that's almost 22 years now.  C.f.: 
<https://lore.kernel.org/linux-mips/Pine.GSO.3.96.1000814133957.7256S-100000@delta.ds2.pg.gda.pl/>, 
<https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git/commit/?id=97b7ae4257ef>.

 Sadly commit a09fc446fb6d ("[MIPS] setup.c: use early_param() for early 
command line parsing") removed last pieces of inline documentation; I 
don't know why things like that get approved, but neither I can take 
responsibility.

 Also to say (in said commit):

"There's no point to rewrite some logic to parse command line
to pass initrd parameters or to declare a user memory area.
We could use instead parse_early_param() that does the same
thing."

is IMHO unfair given that the "rewrite" was there in place almost six 
years before `parse_early_param' even started to exist!  Why do people 
assume things have always been like they see them at the time they look?

  Maciej
