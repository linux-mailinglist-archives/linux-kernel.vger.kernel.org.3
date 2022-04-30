Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C459515EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383041AbiD3PmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382994AbiD3Plh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:41:37 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DBDFA2049;
        Sat, 30 Apr 2022 08:38:09 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2B1B89200BF; Sat, 30 Apr 2022 17:38:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 24B0A9200B3;
        Sat, 30 Apr 2022 16:38:08 +0100 (BST)
Date:   Sat, 30 Apr 2022 16:38:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is
 overrided
In-Reply-To: <CANubcdWykz0j5BaGNhYMW16wX9UbfgsLdEs-ebNWCWP+p1OKWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204301609310.9383@angie.orcam.me.uk>
References: <20220429032621.674865-1-starzhangzsd@gmail.com> <20220429095104.GA11365@alpha.franken.de> <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk> <CANubcdWykz0j5BaGNhYMW16wX9UbfgsLdEs-ebNWCWP+p1OKWw@mail.gmail.com>
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

On Sat, 30 Apr 2022, Stephen Zhang wrote:

> >  Additionally I've thought of adding something like:
> >
> > #if cpu_has_fpu
> > # undef cpu_has_fpu
> > #endif
> >
> > or maybe even:
> >
> > #if cpu_has_fpu
> > # error "Forcing `cpu_has_fpu' to non-zero is not supported"
> > #endif
> >
> > to arch/mips/include/asm/cpu-features.h, but maybe that's an overkill.
> 
> Yeah, but why do you think that's an overkill? There is a great chance
> people will ignore the note of 'cpu_has_fpu', and it did happen. When
> that happens, there should exist a way to point out  or fix that.

 Maybe it's the language, but my intent has been to express my uncertainty 
here rather than asserting that indeed it is an overkill.

 People do make mistakes from time to time, both code writers and 
reviewers do.  It's not clear to me where to draw the line for safety 
checks though.

 Here `cpu_has_fpu' is a bit unusual in that unlike with the other feature 
override macros we don't want it to expand to a non-zero constant.  The 
comment didn't work twice, though I suspect both cpu-feature-overrides.h 
files may have been written before the comment went in (I'm fairly sure 
the IP30 port lived outside the tree for a while).  But I have only added 
the comment in the first place when I tripped over the `nofpu' option not 
working for the machine I needed to run FPU emulator verification with, 
and several platforms were fixed alongside.

 Given these circumstances it probably makes sense to have such a safety 
check after all.

> > I prefer just removing the #defines from ip27/ip30 cpu-feasture-overrides.h.
> > Or isn't that enough for fixing the problem ?
> >
> > Thomas.
> 
> So maybe that's  why I don't think just removing the #defines from
> ip27/ip30 cpu-feasture-overrides.h. is enough for fixing the problem.

 Well, that *is* the fix for the problem at hand, as this macro is not 
supposed to be defined such as to expand to a non-zero constant.

 Adding a safety check would be a separate improvement.  Please feel free 
to submit one.

 We need to keep fixes and improvements as separate changes.  For one 
fixes can be candidates for backporting while improvements are never 
backported; cf. Documentation/process/stable-kernel-rules.rst.

 I hope this clears your concerns.  Let me know if you have further 
questions.

  Maciej
