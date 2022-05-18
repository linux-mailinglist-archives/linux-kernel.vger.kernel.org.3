Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BEF52C4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiERUrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiERUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:47:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387E3166091
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B70AB820BD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270FDC385A9;
        Wed, 18 May 2022 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652906826;
        bh=/rxYrjMqwNlL+24I8XRuVFiiERaiBmaRHgjd3WqHu8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9e/AGfg9nDIZpmXwiwrXfey5wMS26IhfiwndlzuAflZx/V2poGYdYQMw6qMLGwMe
         tmL+pdqdr2nIUad1zE/pXjF2HENquMEFkTlPHZ+DkF9ir5T5uUZjvq0SmwsZHxauHU
         N5wtP3IFn/vFyQE2TWylQ1ADXUxyu5cq+zQ+p52I=
Date:   Wed, 18 May 2022 13:47:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-Id: <20220518134705.7ae186d5419b24d689a38ccc@linux-foundation.org>
In-Reply-To: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 23:48:28 +0530 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
> 
> Address this by dropping the weak attribute from these functions:
> - arch_kexec_apply_relocations() is not overridden by any architecture
>   today, so just drop the weak attribute.
> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures.
> 
> ...
>

Sigh.  This patch demonstrates why I like __weak :<

> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>  				       void **addr, unsigned long *sz);
> +
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)

Let's avoid listing the architectures here?  Better to add

	select ARCH_HAVE_ARCH_KEXEC_APPLY_RELOCATIONS_ADD

to arch/<arch>/Kconfig?

Please cc me on any additional work on this.
