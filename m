Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE04A6171
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbiBAQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiBAQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:33:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C217C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:33:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBE5BB82EF0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620EFC340EB;
        Tue,  1 Feb 2022 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643733227;
        bh=Arb/BWLua2YlFsMeKijCGl7aXZyD3XcJWl8aMJ/fCGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwNVGsaezjiDoPndaeYAKZLw+SBLpc15zCQwh5u0NUK9/UhllQpERXi5FdRjcr/fZ
         5DTM5DUPZAxX49dkyt9xlyL0OhLbH/TY1XIRauJfYN8SwjpoOafocGp5AlafmHF8n6
         hmFFlOtRoVenPbnobV8qNQIqcD1/CNb8GzKUhPzuHUFg7UnKCr++AhL4L2aJd0DqZG
         0QqTT9UrN7HHlLzmyGia47qOxZ0QDUse7FvX/rWfVbthFw8p2EOoCh7YbVojrUb6xS
         aXpJtZk4CKy9sAAfGnO7OTE8GsW3I5YffMLpJwYsjdAenuVQ3HSo75vfpIsYWCtNft
         5lLHaFo7LIZoA==
Date:   Tue, 1 Feb 2022 09:33:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kallsyms: ignore all local labels prefixed by '.L'
Message-ID: <Yflg560OtUrCNt7F@dev-arch.archlinux-ax161>
References: <20220201013257.17926-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201013257.17926-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:32:57AM +0800, Changbin Du wrote:
> The llvm compiler can generate lots of local labels ('.LBB', '.Ltmpxxx',
> '.L__unnamed_xx', etc.). These symbols usually are useless for debugging.
> And they might overlap with handwritten symbols.
> 
> Before this change, a dumpstack shows a local symbol for epc:
> [    0.040341][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.040376][    T0] epc : .LBB6_14+0x22/0x6a
> [    0.040452][    T0]  ra : restore_all+0x12/0x6e
> 
> The simple solution is that we can ignore all local labels prefixed by '.L'.
> For handwritten symbols which need to be preserved should drop the '.L'
> prefix.
> 
> After this change, the C defined symbol is shown so we can locate the
> problematical code immediately:
> [    0.035795][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.036332][    T0] epc : trace_hardirqs_on+0x54/0x13c
> [    0.036567][    T0]  ra : restore_all+0x12/0x6e
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Does not seem too unreasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 54ad86d13784..8caabddf817c 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -108,7 +108,7 @@ static bool is_ignored_symbol(const char *name, char type)
>  	/* Symbol names that begin with the following are ignored.*/
>  	static const char * const ignored_prefixes[] = {
>  		"$",			/* local symbols for ARM, MIPS, etc. */
> -		".LASANPC",		/* s390 kasan local symbols */
> +		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
>  		"__crc_",		/* modversions */
>  		"__efistub_",		/* arm64 EFI stub namespace */
>  		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
> -- 
> 2.32.0
> 
> 
