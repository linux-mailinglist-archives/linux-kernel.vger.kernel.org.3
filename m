Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B973F5970F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiHQOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:19:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FA46DA9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:19:50 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 688441EC058A;
        Wed, 17 Aug 2022 16:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660745984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UgMZtC1v1EoMRLIcmw2I37SWuC2GcwrGDV8t1NasfkQ=;
        b=D/i8J13EAvjHgp+7t+xYE+gOR8ZDeeofp4UdyhSAr460JAS6QDCd3VzJ7DakcW/E4u7LXm
        6zTlaeAiXe3uXXf67goZ6nIXqfN+ivJlf6dIQU6QvplwNopshvrYSVldejEzZl8Y0SmPEb
        183DMlKzKl/tFDbuvRbtve8F2th2uXQ=
Date:   Wed, 17 Aug 2022 16:19:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <Yvz4/ASoX4SiXbhp@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
 <YvyiHGMbp2MtV0Vr@zn.tnic>
 <YvzXsf0mGEcOlZC5@araj-dh-work>
 <Yvzay5jOu5XBJpWa@zn.tnic>
 <YvzfebgOWVKYLClJ@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvzfebgOWVKYLClJ@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:30:49PM +0000, Ashok Raj wrote:
> You will find out when system returns after reboot and hopefully wasn't
> promoted to a cold-boot which will loose MCE banks.

Not good enough!

This should issue a warning in dmesg that a potential MCE while update
is running would cause a lockup. That is if we don't disable MCE around
it.

If we decide to disable MCE, it should say shutdown.

> Meaning deal with the effect of a really rare MCE. Rather than trying to
> avoid it. Taking the MCE is more important than finishing the update,
> and loosing what the error signaled was trying to convey.

Right now I'm inclined to not do anything and warn of a potential rare
situation.

> > > Shutdown, shutdown.. There is only 1 MCE no matter how many CPUs you have.
> > 
> > Because all CPUs are executing the loop? Or how do you decide this?
> 
> Fatal errors signaled with PCC=1 in the MCAx.STATUS is *ALWAYS*

What does that have to do with

"There is only 1 MCE no matter how many CPUs you have."

?

That's bullsh*t. Especially if the machine can do LMCE.

> I'm waiting for the results. :-).  And if you feel we can merge the
> - Patch1 - bug fix 
> - Patch2 - min-rev id
> 
> I do have the comments from Ingo captured, but I'll wait for other comments
> before i resend just those 2 and we can leave the NMI handling to get more
> testing and review before we consider.

No, you need to go read Documentation/process/.

I'm tired of having to explain to you how the kernel development process
works. You send your set, wait for a week, collect feedback and then you
send a new revision.

Not hammer people with patchsets every day.

This is not how that works.

If someone's breathing down your neck lemme know - I'd like to talk to
him/her.

Ok?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
