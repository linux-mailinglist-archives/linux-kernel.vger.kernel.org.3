Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D095057E34A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiGVOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:54:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF295C19;
        Fri, 22 Jul 2022 07:54:26 -0700 (PDT)
Received: from zn.tnic (p200300ea97297665329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7665:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D72031EC04E4;
        Fri, 22 Jul 2022 16:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658501660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mCR4LQOlJZ0Afghe45GGJBA2iWSsio2lR2y8ckrkB7s=;
        b=cqNhHILaFs4aUzopyZ7JeqcY13E4ZhnfRpMeWD0Cl6aUh2kDSkxaQkrkt3Vvxc/VuvmZp9
        tdE1Mzb6vnzert1LktwimuOkVwifuyr9KxM8AOtVLRYS42uEMzXiHZXVwNOq6eiym+ns4j
        AQDXrfUvrKllqOi3Pkhp/7omjh6BbO4=
Date:   Fri, 22 Jul 2022 16:54:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/configs: update configs in x86_debug.config
Message-ID: <Ytq6GO0JJcqT2gOw@zn.tnic>
References: <20220722121815.27535-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722121815.27535-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:18:15PM +0200, Lukas Bulwahn wrote:
> Commit 4675ff05de2d ("kmemcheck: rip it out") removes kmemcheck and its
> corresponding build config KMEMCHECK.
> 
> Commit 0f620cefd775 ("objtool: Rename "VMLINUX_VALIDATION" ->
> "NOINSTR_VALIDATION"") renamed the debug config option.
> 
> Adjust x86_debug.config to those changes in debug configs.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  kernel/configs/x86_debug.config | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
> index dcd86f32f4ed..6fac5b405334 100644
> --- a/kernel/configs/x86_debug.config
> +++ b/kernel/configs/x86_debug.config
> @@ -7,12 +7,11 @@ CONFIG_DEBUG_SLAB=y
>  CONFIG_DEBUG_KMEMLEAK=y
>  CONFIG_DEBUG_PAGEALLOC=y
>  CONFIG_SLUB_DEBUG_ON=y
> -CONFIG_KMEMCHECK=y

While at it, you might also whack the last mention of KMEMCHECK:

$ git grep KMEMCHECK
kernel/configs/x86_debug.config:10:CONFIG_KMEMCHECK=y
tools/testing/selftests/wireguard/qemu/debug.config:21:CONFIG_HAVE_ARCH_KMEMCHECK=y

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
