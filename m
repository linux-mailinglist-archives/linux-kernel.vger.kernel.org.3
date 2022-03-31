Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502274ED9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiCaMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiCaMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:40:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC21012;
        Thu, 31 Mar 2022 05:38:28 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A9F81EC04E0;
        Thu, 31 Mar 2022 14:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648730303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qVvXjz2kdMebKf9AM1/GDPf0UZu1N4kVDrHOoUj1qBM=;
        b=PRFvTUMxwiqJihEJnhUgEV2eYFlpxYktmFrjSRGTK/nC4hqoRniVW1jcf6UPlrWnpTJgfS
        0YgjLsiZl24D0xe494AZa1WtC9WSio3hwkCzpQHa19fwd1jA4GjWu6J2tiUNoKU36j6baa
        NQDwVys8nbCF5IHrVSFDpAOqARHiqQw=
Date:   Thu, 31 Mar 2022 14:38:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] [RFC] Documentation/process: Add testing section to tip
 handbook
Message-ID: <YkWgv1yBGtcAbPVj@zn.tnic>
References: <20220314183552.1446911-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314183552.1446911-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:35:52AM -0700, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kernel has a wide variety of debugging options to help catch
> and squash bugs.  However, new debugging is added all the time and
> the existing options can be hard to find.
> 
> Add a list of debugging options which tip maintainers expect to be
> used to test contributions.
> 
> This should make it easier for contributors to test their code and
> find issues before submission.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
> index c74f4a81588b..75f86b0f1cf0 100644
> --- a/Documentation/process/maintainer-tip.rst
> +++ b/Documentation/process/maintainer-tip.rst
> @@ -437,6 +437,30 @@ in a private repository which allows interested people to easily pull the
>  series for testing. The usual way to offer this is a git URL in the cover
>  letter of the patch series.
>  
> +Testing
> +^^^^^^^
> +
> +Code should be tested before submitting to the tip maintainers.  Anything
> +other than minor changes should be built, booted and tested with the
> +following set of comprehensive (and heavyweight) set of kernel debugging
> +options enabled.
> +
> +	CONFIG_X86_DEBUG_FPU=y
> +	CONFIG_LOCK_STAT=y
> +	CONFIG_DEBUG_VM=y
> +	CONFIG_DEBUG_VM_VMACACHE=y
> +	CONFIG_DEBUG_VM_RB=y
> +	CONFIG_DEBUG_SLAB=y
> +	CONFIG_DEBUG_KMEMLEAK=y
> +	CONFIG_DEBUG_PAGEALLOC=y
> +	CONFIG_SLUB_DEBUG_ON=y
> +	CONFIG_KMEMCHECK=y
> +	CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=y
> +	CONFIG_GCOV_KERNEL=y
> +	CONFIG_LOCKDEP=y
> +	CONFIG_PROVE_LOCKING=y
> +	CONFIG_SCHEDSTATS=y
> +	CONFIG_VMLINUX_VALIDATION=y

It would be cool if there were a command I can run so that I can enable
all those. Example:

$ grep CONFIG_VMLINUX_VALIDATION .config
$ ./scripts/config --enable CONFIG_VMLINUX_VALIDATION
$ grep CONFIG_VMLINUX_VALIDATION .config
CONFIG_VMLINUX_VALIDATION=y
$ make oldconfig
#
# configuration written to .config
#
$ grep CONFIG_VMLINUX_VALIDATION .config
$

Needs other options.

Maybe you could create a .config snippet which we can merge
with scripts/kconfig/merge_config.sh... or maybe start from
arch/x86/configs/x86_64_defconfig, add all those and call it

arch/x86/configs/x86_64_testconfig

or so.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
