Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA015A0251
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiHXTw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiHXTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:52:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F37C1ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:52:52 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B07E71EC0589;
        Wed, 24 Aug 2022 21:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661370766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BtEcTTWjMFEaUqD228VC0UPcOadpBLGiKkdNaczS59k=;
        b=oVoGpaAAioid6YbmUXFy9PXW64G8haJN5bdizKUltPO8qJ+Px14QwwJsfjE6fc9ttncOer
        efzc8E0FaHiF1NjkhGd8LSq0d5QiUGTph/RpT+1dYKfWlyCiwbWTecYDLjowtCWgAoxWcP
        wm1faKB39FcJ8wdGh5UWT9/TBCjfT4I=
Date:   Wed, 24 Aug 2022 21:52:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <YwaBim3Xt3Il3KXm@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
 <Yv9vy/GTh/QInBPM@zn.tnic>
 <YwQae9yhJyjAQ5Xy@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwQae9yhJyjAQ5Xy@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:08:27AM +0000, Ashok Raj wrote:
> Correct, but print_err parameter is 0 when called from scan_microcode() and 1
> when called from generic_load_microcode().

Well, scan_microcode() gets called from save_microcode_in_initrd() which
is fs_initcall and if we had to be really precise, print_err being 0
there is wrong.

Because at fs_initcall time we can very well print error messages. But
that print_err thing is an old relic so will have to get fixed some
other day.

> We do min_rev enforcement only when print_err is set.

That's wrong - you need to do min_rev enforcement only when you're
loading microcode late. I.e., to paste from my previous mail:

"So you'd have to pass down the fact that you're doing late loading from
request_microcode_fw().

Now, I'm staring at that ugly refresh_fw bool arg in that function and
I *think* I did it 10 years ago because it shouldn't try to load from
the fs when it is resuming because there might not be a fs yet... or
something to that effect.

tglx might have a better idea how to check we're in the ->starting
notifier..."

IOW, we're going to have to do something like

->request_microcode_fw(, ... late_loading=true)

and I wanted to reuse that refresh_fw arg instead of adding another
one...

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
