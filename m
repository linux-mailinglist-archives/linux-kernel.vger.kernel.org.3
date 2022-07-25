Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F457FEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiGYMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiGYMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:02:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3416586;
        Mon, 25 Jul 2022 05:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D29F9B80E78;
        Mon, 25 Jul 2022 12:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE3C341C6;
        Mon, 25 Jul 2022 12:02:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kmNdDbqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658750530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPvyHjMLA4A9n1tAA4Jqif7EHSTbfVf0ytv4zVQMZbw=;
        b=kmNdDbqBKJxYqauSDh1rz4znS2xhBeIz0oPEysy02qDxKObWVO5vZ65qozv6zyiHldHrog
        45t4+DpAbXG7dH4D6QPnLSDJu2kqTtJvgH3Ub4Z9csu/8tdoLdMmnCQLo9qGigzZqoLHto
        MOyUZst7DdmYxSlppN8375YQDlqhFlI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ffac6d22 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Jul 2022 12:02:10 +0000 (UTC)
Date:   Mon, 25 Jul 2022 14:02:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/4] kexec: reuse crash kernel reserved memory for normal
 kexec
Message-ID: <Yt6GPsWcG9iWHBUg@zx2c4.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-2-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725083904.56552-2-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

On Mon, Jul 25, 2022 at 04:38:53PM +0800, Albert Huang wrote:
> The kexec userspace tool also needs to add parameter options(-r) that
> support the use of reserved memory (see another patch for kexec)
>
> [...]
>
> -	if (kexec_on_panic) {
> +	if (kexec_on_panic && kexec_on_reserved) {

Two small questions related to this:

- Why does kexec-tools need an option, or more specifically, why does
  userspace need to communicate about this at all? Can't the kernel just
  automatically use the available reserved memory in the case that's not
  already being used by the panic handler kernel? I'm curious about
  whether there are caveats that would make this occasionally
  undesirable, hence suggesting an option.

- I don't totally understand how this works, so I might be a bit off
  here, but is there any chance that this could be made to co-exist with
  kexec_on_panic? Can a larger region just be reserved, specifically for
  this, rather than piggy backing on the panic handler region?

> +static struct page *kimage_alloc_reserverd_control_pages(struct kimage *image,
> +	case KEXEC_TYPE_RESERVED_MEM:
> +		pages = kimage_alloc_reserverd_control_pages(image, order);

Nit:
  reserverd -> reserved

Jason
