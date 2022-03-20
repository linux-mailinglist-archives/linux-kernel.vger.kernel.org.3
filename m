Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73FE4E1ADD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbiCTJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiCTJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:32:23 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8102DAB5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:30:59 -0700 (PDT)
Received: from [192.168.1.101] (unknown [88.235.220.59])
        by gnuweeb.org (Postfix) with ESMTPSA id B19977E2BC;
        Sun, 20 Mar 2022 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647768658;
        bh=ygkrm1RT86tyG8j/iRFsG6RBtkprW94+sdWpA72M23g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iRorJ7lpwjGI+5bAXnD11w50y3D0M4kIeiuKV11AUxq5EwUATViGgDdmJy2RYcXLq
         hpDaPpc5u3oIyAOdjcEIR9IJlVKq2m49l24ORVZ4Y9Cc8JCPk3hTNExeJZ2YI16bLw
         L7ixiy8sEFON+dzXkkf1DwSpWJ9UGJsda+0cG2+xoRzK4PJkWYkZv2vrHOyo/ZJsyv
         eHI+3pgFd3OrW9UErrviJRaw3EBlbqJoOmWp48WVZrdWMLsAA30HQ4GHJKMDt6RFg7
         BVvq632iyyrMCi1f8AjzJM/DHUAYyZO93yq4N2bGfumqgCTcHJfvI1/8HzwoKnEZNU
         RFt7kAuHiVpDw==
Message-ID: <e0fb4826470cc052b59c8cba6319df160908af5d.camel@gnuweeb.org>
Subject: Re: [PATCH] boot install: Partially refactor the logic for
 detecting bootloader
From:   Beru Shinsetsu <windowz414@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 20 Mar 2022 12:30:51 +0300
In-Reply-To: <YjZJDP21H+ngnQb4@zn.tnic>
References: <20220316173221.5937-1-windowz414@gnuweeb.org>
         <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
         <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
         <221F34C3-C3E0-4401-BEF2-422F11BF8324@alien8.de>
         <9fa42069edf92d0ca7d64e967e1b9c0030d9a6ec.camel@gnuweeb.org>
         <YjZJDP21H+ngnQb4@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-19 at 22:20 +0100, Borislav Petkov wrote:
> On Thu, Mar 17, 2022 at 04:46:48PM +0300, Beru Shinsetsu wrote:
> > > Well, I saw this on SLE15-SP4 (brand new) yesterday while I haven't
> > > seen it on previous service packs. So this doesn't look like it has
> > > been there since 2007. I'll try to debug it when I get a chance.
> > 
> > Hmm alright. Good luck from now! Hope everything goes flawlessly.
> 
> Here it is:
> 
> From arch/x86/boot/install.sh:
> 
> ...
> # User may have a custom install script
> 
> if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> ...
> 
> so distros *usually* should supply a custom, distro-specific
> installkernel script which does that. The distros which you are seeing
> it on simply don't have that script installed and I need to talk to
> distro people as to what the rule there is for supplying such a script
> now.
> 
> Because most distros should supply it though and those new distros
> dropping it looks like some new "strategy" or so.
> 
> We'll see.

I have seen that, and I had pretty much the same thoughts as well. Arch
isn't quite new either. And as I said, installing from AUR works pretty
fine (package is `linux-mainline`, it also compiles the kernel on
*your* PC locally, then installs it as a PacMan package). Just
compiling manually doesn't. I suppose that's one of the quirks of the
distro being installed manually by the user from the very first stage.
Not even counting Gentoo though, I haven't tried it out as I'm scared
it can explode my laptop as it *compiles the whole system locally*. But
let's see how it goes. Thank you so much by the way!
-- 
Beru Shinsetsu
