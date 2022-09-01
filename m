Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8915A8BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIACxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiIACxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:53:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52924161DC1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:53:04 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD01D1EC0688;
        Thu,  1 Sep 2022 04:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662000778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wg2dbZ7MfL90Glri3BhuLOQ5lxp2b+1lT/0glWKVEHs=;
        b=ezljlklvb9pRa/tt4Z+CpLmuHQkLKEAW3ulhYhSnhzsLhBZ1T5QYIYt6s6F3Bfqxwj5Ba+
        GJQDwkBVC0iiih+Q8NutEg5HJQAkAl95PRmhVmBKmjfVurnUztchwC5KqeliJSX+2HT8RP
        CjGaJtcjbjhuzJPWoR79aVZQFh8EzWQ=
Date:   Thu, 1 Sep 2022 04:53:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min
 rev is specified
Message-ID: <YxAefm3F9zMdTjcs@nazgul.tnic>
References: <20220829180436.716672-1-ashok.raj@intel.com>
 <Yw0iDnZ+dB4ULSs/@nazgul.tnic>
 <Yw1AtFrRPWhkJ4r8@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw1AtFrRPWhkJ4r8@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:41:56PM +0000, Ashok Raj wrote:
> But I suppose, you mean what refresh_hw is supposed to mean from the
> existing code?

I've been meaning this for a while now.

> refresh_hw seems to imply when to update  the copy of the microcode from
> the filesystem. Also seems to imply late loading.

After your patch:

$ git grep refresh_fw arch/x86/
arch/x86/kernel/cpu/microcode/core.c:601:static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
arch/x86/kernel/cpu/microcode/core.c:616:       ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, refresh_fw);

$ git grep late_loading
arch/x86/include/asm/microcode.h:36:                                              bool late_loading);
arch/x86/kernel/cpu/microcode/amd.c:894:                                              bool late_loading)
arch/x86/kernel/cpu/microcode/amd.c:903:        if (!late_loading || !bsp)
arch/x86/kernel/cpu/microcode/intel.c:166:static int microcode_sanity_check(void *mc, int print_err, bool late_loading)
...

Now you have both. More mess.

> its used in the following places.
> 
> 1. During reload_store() where this is exclicitly due to echo 1 > reload
> 
> 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
> 
> 	Here passing true makes sense since you are going to do a full
> 	refresh on all CPUs via late loading.

Yes, and here it is perfectly clear that it is late loading.

> 2. microcode_update_cpu() -> microcode_init_cpu()->request_microcode_fw(false)
> 
>    Early loading from resume.

CPU hotplug rather.

> So we would use the microcode cache to load from.

So this happens when the CPU is coming online. I'm not sure why I set it
to "false" back then - whether it is because there's no filesystem yet
or there was another reason. I *think* this was some contrived used case
again.

In any case, this'll need to be experimented with to figure out what
happens when it is set to "true".

> 3. mc_device_add() -> microcode_init_cpu(true)->request_microcode_fw(true)
> 
>    This seems like normal CPU hot-add, I'm not sure if refresh_fw=true is
>    valid. A new CPU should also use from the cache, but not a full reload
>    from filesystem. This could end up with new cpu with an updated ucode
>    and older with something that was loaded earlier.

Just check when mc_device_add() is actually called and then try to
figure out what that actually does instead of speculating.

> Sort of what was fixed in:
>    commit 7189b3c11903667808029ec9766a6e96de5012a5 (tag: x86_microcode_for_v5.13)

That's a tag - not a git commit.

I think you mean

7189b3c11903 ("x86/microcode: Check for offline CPUs before requesting new microcode")

>    intel.c doesn't seem to use this parameter at all today. But judging from
> 
>    amd.c: request_microcode_amd() 
> 
>         /* reload ucode container only on the boot cpu */
>         if (!refresh_fw || !bsp)
>                 return UCODE_OK;
> 
>   Seems like it does the right job, since you would refresh only if
>   refresh_fw=true and its the bsp. Hence it seems immute to the
>   mc_device_add() bug.

I don't see a bug there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
