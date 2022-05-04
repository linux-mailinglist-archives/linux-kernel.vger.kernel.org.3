Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2A519B04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiEDJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiEDJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:02:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884C2E5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:59:19 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F4A91EC0505;
        Wed,  4 May 2022 10:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651654754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2ylEsqRwEiHp3+8GOnUS6pksQCRbI2Lf+4Bw9d/1KfI=;
        b=BlTv2tQPkoP4v5rXr8qRxKIrmE98v62HMzVmZ75GiF/tq2hrRJP2sgRs8qZRzoE8yhZKa0
        WSGg/wnWdokIrou9n0cXJ630BqQsa/P8klAK1Yn49iDu+rmE/uZIG/G6rUjEd76u7mnZAO
        LUFqQ55TAx10dbIP+5zXCQb6hBwbAgk=
Date:   Wed, 4 May 2022 10:59:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Parse CONFIG_CMDLINE in compressed kernel
Message-ID: <YnJAYOHBjipBfdm3@zn.tnic>
References: <20220407024014.6916-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407024014.6916-1-baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:40:14AM +0300, Baskov Evgeniy wrote:
> CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE was ignored
> during options lookup in compressed kernel, including
> earlyprintk option, so it was impossible to get earlyprintk
> messages from that stage of boot process via command line
> provided at compile time. Being able to enable earlyprintk
> via compile-time option might be desirable for booting
> on systems with broken UEFI command line arguments via EFISTUB.
> 
> Parse CONFIG_CMDLINE-related options correctly in compressed
> kernel code.
> 
> Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
> 
> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
> index f1add5d85da9..dd8cbbe61dff 100644
> --- a/arch/x86/boot/compressed/cmdline.c
> +++ b/arch/x86/boot/compressed/cmdline.c
> @@ -22,9 +22,49 @@ unsigned long get_cmd_line_ptr(void)
>  }
>  int cmdline_find_option(const char *option, char *buffer, int bufsize)
>  {
> -	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
> +	int len = -1;
> +	unsigned long cmdline_ptr;
> +
> +	/*
> +	 * First try command line string provided by user,
> +	 * then try command line string configured at comple time.
> +	 * Skip first step if CONFIG_CMDLINE_OVERRIDE is enabled
> +	 * and parse only compile time command line.
> +	 */
> +
> +	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
> +		cmdline_ptr = get_cmd_line_ptr();
> +		len = __cmdline_find_option(cmdline_ptr, option,
> +					    buffer, bufsize);
> +	}
> +
> +#ifdef CONFIG_CMDLINE_BOOL
> +	if (len < 0) {
> +		cmdline_ptr = (unsigned long)CONFIG_CMDLINE;
> +		len = __cmdline_find_option(cmdline_ptr, option,
> +					    buffer, bufsize);
> +	}
> +#endif

Do I see it correctly that all this logic boils down to returning the
proper cmdline ptr and so you can do that once in get_cmd_line_ptr()
instead of duplicating the ifdeffery?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
