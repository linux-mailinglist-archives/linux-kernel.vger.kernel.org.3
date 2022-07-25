Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A657FED9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGYMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiGYMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE34E082
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 094DB610A1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A6CC385A2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:17:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Pf51o4q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658751430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bK/YvwfROKSRDyXQJn91Dl18uO1oeV6IpFanZCzkJ48=;
        b=Pf51o4q1Uh/iiftNQePhKqqoEJ9ESfx4bX+X5oRmsSYN+R6LLEzw95S2mVEyjHgsJjTDE+
        N9F3aslHjTXCpKxibGBe6bpVLkFHt5owDlSx+jChDey9mZSC7hYc1o4KOPkN83L7MjI+I8
        /ebPnafUEwFMhft6PwjycP/03CFMqiU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a9d6e25 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 25 Jul 2022 12:17:10 +0000 (UTC)
Date:   Mon, 25 Jul 2022 14:15:00 +0200
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
Message-ID: <Yt6JRBToqY5ts6OU@zx2c4.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-3-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725083904.56552-3-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

On Mon, Jul 25, 2022 at 04:38:54PM +0800, Albert Huang wrote:
> +config KEXEC_PURGATORY_SKIP_SIG
> +	bool "skip kexec purgatory signature verification"
> +	depends on ARCH_HAS_KEXEC_PURGATORY
> +	help
> +	  this options makes the kexec purgatory do  not signature verification
> +	  which would get hundreds of milliseconds saved during kexec boot. If we can
> +	  confirm that the data of each segment loaded by kexec will not change we may
> +	  enable this option
> +

Some grammar nits here, but actually, wouldn't it be better to make this
depend on some other signature things instead? Like if the parent kernel
actually did a big signature computation, then maybe the purgatory step
is needed, but if it didn't bother, then maybe you can skip it. This
way, you don't need a compile-time option that might change some aspect
of signature verification people might otherwise be relying on.

Jason
