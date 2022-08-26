Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA505A26EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiHZLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbiHZLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:35:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF1BCCF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:35:48 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A51E61EC0426;
        Fri, 26 Aug 2022 13:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661513742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rygCihiq5JABhm5at71zDCNmLU3ZdhKw80RK9HD855k=;
        b=Zj3SSlNqyYZiBF2SSrKoWJ2bBFB6m0e2WhXbvQJblc6F4/cBoCK3Bc0hcMFnfXl6NgyaNl
        vIAOzZM1G1gYb+cJ73HLkvf9SllznyuTgEaFC5jTp/5V7+aADR6IWYEtK55O4xugOf3IZR
        jqqARj2/rAK/V8j+ZHzshMLrWIKv1Gw=
Date:   Fri, 26 Aug 2022 13:35:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] x86: Add resolve_cmdline() helper
Message-ID: <YwiwCgIoIPnsyanu@zn.tnic>
References: <cover.1653471377.git.baskov@ispras.ru>
 <7eb917aeb1fa9f044f90ec33c8bf33bb6aee62a5.1653471377.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eb917aeb1fa9f044f90ec33c8bf33bb6aee62a5.1653471377.git.baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:10:10PM +0300, Evgeniy Baskov wrote:
> Command line needs to be combined in both compressed and uncompressed
> kernel from built-in and boot command line strings, which requires
> non-trivial logic depending on CONFIG_CMDLINE_BOOL and
> CONFIG_CMDLINE_OVERRIDE.
> 
> Add a helper function to avoid code duplication.
> 
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> 

You have some weird configuration to your git send-email which doesn't
add the "---" to split the patch commit message from the diffstat.

>  create mode 100644 arch/x86/include/asm/shared/setup-cmdline.h
> 
> diff --git a/arch/x86/include/asm/shared/setup-cmdline.h b/arch/x86/include/asm/shared/setup-cmdline.h

Just cmdline.h I'd say.

> new file mode 100644
> index 000000000000..9822e5af4925
> --- /dev/null
> +++ b/arch/x86/include/asm/shared/setup-cmdline.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_X86_SETUP_CMDLINE_H
> +#define _ASM_X86_SETUP_CMDLINE_H
> +
> +#define _SETUP
> +#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
> +#undef _SETUP
> +
> +#include <linux/string.h>
> +
> +#ifdef CONFIG_CMDLINE_BOOL
> +#define COMMAND_LINE_INIT CONFIG_CMDLINE
> +#else
> +#define COMMAND_LINE_INIT ""
> +#endif
> +
> +/*
> + * command_line and boot_command_line are expected to be at most
> + * COMMAND_LINE_SIZE length. command_line needs to be initialized
> + * with COMMAND_LINE_INIT.
> + */
> +


^ Superfluous newline.

> +static inline void resolve_cmdline(char *command_line,
> +				   const char *boot_command_line)

cmdline_prepare() I'd say.

> +{
> +#ifdef CONFIG_CMDLINE_BOOL
> +	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> +		/* Append boot loader cmdline to builtin */
> +		strlcat(command_line, " ", COMMAND_LINE_SIZE);
> +		strlcat(command_line, boot_command_line, COMMAND_LINE_SIZE);
> +	}
> +#else
> +	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);

So that has been switched to strscpy() in the meantime:

8a33d96bd178 ("x86/setup: Use strscpy() to replace deprecated strlcpy()")

Please redo your set ontop of latest tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
