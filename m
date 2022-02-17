Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C297B4BAB42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiBQUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:48:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbiBQUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:48:03 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2DCB4131A;
        Thu, 17 Feb 2022 12:47:47 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nKngn-0007Qh-00; Thu, 17 Feb 2022 21:47:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1F9C3C2512; Thu, 17 Feb 2022 21:47:16 +0100 (CET)
Date:   Thu, 17 Feb 2022 21:47:16 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove asm/war.h
Message-ID: <20220217204716.GA17899@alpha.franken.de>
References: <20220217134630.42203-1-tsbogend@alpha.franken.de>
 <alpine.DEB.2.21.2202171352060.56785@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202171352060.56785@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 01:58:01PM +0000, Maciej W. Rozycki wrote:
> On Thu, 17 Feb 2022, Thomas Bogendoerfer wrote:
> 
> > diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
> > index 35729c9e6cfa..11392e40d034 100644
> > --- a/arch/mips/kernel/r4k-bugs64.c
> > +++ b/arch/mips/kernel/r4k-bugs64.c
> > @@ -163,7 +163,8 @@ static __always_inline __init void check_mult_sh(void)
> >  	}
> >  
> >  	pr_cont("no.\n");
> > -	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
> > +	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar :
> > +								    nowar);
> 
>  I think it'll read better if formatted like this:
> 
> 	panic(bug64hit,
> 	      !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar : nowar);
> 
> or without the negation even:
> 
> 	panic(bug64hit,
> 	      IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? nowar : r4kwar);
> 
> Likewise throughout.

that looks much nicer, I'll send a v2 with that changed

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
