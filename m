Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54985517111
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiEBOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiEBOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:01:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DEC1263D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:58:04 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D64B51EC0373;
        Mon,  2 May 2022 15:57:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651499878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AziFsJ9dHggKgPyDuLgpr4udvJ4pOtHvywmf8k8zxcE=;
        b=luIAZCoeOcvBZAUeO8jCCvSFbJsRv8GEIT97wmcSlEsqidoK1079wSfOfaMw6YnMKIyvVl
        bB3F2ceGM0nqlfaQbaeBi7iYFD6NicAeZExeo5Qnr8c1oZrnKc3E9J0LTw+zmS3TA+x1d1
        IOcA9iM3aWuv39HSnfXmO2RXicMMRNI=
Date:   Mon, 2 May 2022 15:57:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 2/3] x86/fpu: Rename irq_fpu_usable()
Message-ID: <Ym/jZBSTWzoiUYDt@zn.tnic>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.647328777@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220501193102.647328777@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:31:45PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -49,11 +49,12 @@ static DEFINE_PER_CPU(bool, in_kernel_fp
>   */
>  DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  
> -/*
> - * Can we use the FPU in kernel mode with the
> - * whole "kernel_fpu_begin/end()" sequence?
> +/**
> + * kernel_fpu_usable - Check whether kernel FPU usage is possible
> + *
> + * Has to be invoked before calling kernel_fpu_begin().
>   */

Ah, there it is.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
