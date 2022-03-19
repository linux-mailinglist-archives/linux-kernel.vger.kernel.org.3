Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE04DEAED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbiCSVVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiCSVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 17:21:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516844550C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 14:20:18 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF9D01EC0373;
        Sat, 19 Mar 2022 22:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647724812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sPwlfcb/KsEa7lAJ/D5+AIV7bo9PMMQXbcG/wOnxx7Y=;
        b=TIFsCKpSYIC/fp7eSjjxtyZpLayYEUdx8Ce9IhJHJoqqJLfd6YjLtGDl2Pw4aU9gvxZGb7
        J3EdhyCokjX1kI/o7t9KgKiEjRRS/iBYIWZx8VDI9TuQhbzRzy9EZIKoc/X8hN6JhpSfb9
        C4rKw62b1UYqtOHAmmFqhNQYxJaHPNs=
Date:   Sat, 19 Mar 2022 22:20:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Beru Shinsetsu <windowz414@gnuweeb.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: Re: [PATCH] boot install: Partially refactor the logic for detecting
 bootloader
Message-ID: <YjZJDP21H+ngnQb4@zn.tnic>
References: <20220316173221.5937-1-windowz414@gnuweeb.org>
 <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de>
 <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
 <221F34C3-C3E0-4401-BEF2-422F11BF8324@alien8.de>
 <9fa42069edf92d0ca7d64e967e1b9c0030d9a6ec.camel@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fa42069edf92d0ca7d64e967e1b9c0030d9a6ec.camel@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:46:48PM +0300, Beru Shinsetsu wrote:
> > Well, I saw this on SLE15-SP4 (brand new) yesterday while I haven't
> > seen it on previous service packs. So this doesn't look like it has
> > been there since 2007. I'll try to debug it when I get a chance.
> 
> Hmm alright. Good luck from now! Hope everything goes flawlessly.

Here it is:

From arch/x86/boot/install.sh:

...
# User may have a custom install script

if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
...

so distros *usually* should supply a custom, distro-specific
installkernel script which does that. The distros which you are seeing
it on simply don't have that script installed and I need to talk to
distro people as to what the rule there is for supplying such a script
now.

Because most distros should supply it though and those new distros
dropping it looks like some new "strategy" or so.

We'll see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
