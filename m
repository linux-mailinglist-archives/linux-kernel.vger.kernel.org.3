Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A925A036B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiHXVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiHXVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:50:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401E65558
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:50:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 20so16832979plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=RUPC3jPCalHtDBNfvRBs/lbqBPlwSNYiWYp0S4PJ/XU=;
        b=gIHmiktIXmAFUsCwbcPQOlxaKONLU3DwN4gqqDggiCoauGYVwUhDfJClUivkb6m2Iv
         toLhTLkqj3XOWZpAw9II5tGSbwNROBX/IP6Zb6Ri7ytnYYdwXmP1ehzyWzJ5cAb4x+Va
         60vPXyXiLoAWo8bdcrLv3e6mY3NT7sSJAfZDIPbQCewkc5mIx0lb2NXbmQCvdZixU4lm
         cIhaOpV0cL+IQEegjVrvRDZ6m+n2v2J6sqw6PjLykeDZdygsooLa5ljtW3a2TVk3nbEm
         oWyPqnvSBvW39n9klYGMrBuWLr+zi1xW0NW2O3B/ufPQ0uyMBosPRp1bblSqKkb/aA1v
         +szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RUPC3jPCalHtDBNfvRBs/lbqBPlwSNYiWYp0S4PJ/XU=;
        b=jU4OtlVykhJhdKF+1HWK/ZLsg3KjrCJcKomTYM/knRiBvCLqxrebCCLy5a1/AhIvvL
         URhRW4cy3hLy/6PrbFH2GyFCJ5fG94Ehjs+nhAZnRYLYuAFVaCmCmckE7dH0uu7BTcf4
         QpuKt+AGEfTX/q0274h4zr9rfrGkqGzCupg872UFrTYCxp8QiEcG5BLTXRa+nzia0erE
         L6wUqSakpZxaAUf78xK1Oaa6VgEcs6OEzIYlrGAyal/EchAukJ8+rzghDMVy3akFJKvW
         EZy4rnSYw/fh0JOGdtdJ/k4BPTBeeFsG7ElELlqt9hecGc21q+JICZfLkgkwBSuXE/Uk
         CLEw==
X-Gm-Message-State: ACgBeo3E0IgVlF0QYydMiXSjIGlHEZzxuOYVVdkN7KNlVd6WTCj7qc3s
        9ecSAMZfabBb8z3TbbxmB3Am1A==
X-Google-Smtp-Source: AA6agR4Lo5G4GBoW0Csa2WkXlDva4B14EmccEzjTBr/lql7tOsivvXBIhVjphGHfixlQZH/MIcds6A==
X-Received: by 2002:a17:902:a60c:b0:171:407d:16f8 with SMTP id u12-20020a170902a60c00b00171407d16f8mr767658plq.58.1661377847914;
        Wed, 24 Aug 2022 14:50:47 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902f78b00b001709e3c750dsm2366264pln.194.2022.08.24.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:50:47 -0700 (PDT)
Date:   Wed, 24 Aug 2022 21:50:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 04/13] KVM: x86: emulator: update the emulation mode
 after rsm
Message-ID: <YwadM2Y3FCMutSpt@google.com>
References: <20220803155011.43721-1-mlevitsk@redhat.com>
 <20220803155011.43721-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803155011.43721-5-mlevitsk@redhat.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022, Maxim Levitsky wrote:

Please make the changelog standalone, even though it means restating the shortlog
in most cases.  When viewing git commits, the shortlog+changelog are bundled
fairly close together, but when viewing patches in a mail client, e.g. when doing
initial review, the shortlog is in the subject which may be far away or even
completely hidden.

> This ensures that RIP will be correctly written back,
> because the RSM instruction can switch the CPU mode from
> 32 bit (or less) to 64 bit.

Wrap closer to ~75 chars.

> 
> This fixes a guest crash in case the #SMI is received
> while the guest runs a code from an address > 32 bit.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/emulate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index bc70caf403c2b4..5e91b26cc1d8aa 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2666,6 +2666,11 @@ static int em_rsm(struct x86_emulate_ctxt *ctxt)
>  	if (ret != X86EMUL_CONTINUE)
>  		goto emulate_shutdown;
>  
> +

Unnecessary newline.

> +	ret = emulator_recalc_and_set_mode(ctxt);
> +	if (ret != X86EMUL_CONTINUE)
> +		goto emulate_shutdown;
> +
>  	/*
>  	 * Note, the ctxt->ops callbacks are responsible for handling side
>  	 * effects when writing MSRs and CRs, e.g. MMU context resets, CPUID
> -- 
> 2.26.3
> 
