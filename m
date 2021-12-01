Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128D746451B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhLACzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbhLACzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:55:46 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0CC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:52:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 71so21982572pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CyLZ0HcKYn5cINTo9abzB39mIlHZoj01C7i4Yaug5h0=;
        b=THbyL37rvfXckghPZlSG1AOm0QJnDY49iEa3IgnQVndpSYwCdfa9PFpuPjKbekirht
         f6r1CfsOtuwjrxaTCLTHIqqAVhMf2P0M6Eo9aXq8NJ3y+J5wdX+Hw5rXYSUQQQv8LA3t
         OlIpT1HtmLOrVAUXLhnp80Ybe7jiye+vuYdSpUDdtGBCTnt/+i7YlEwO8CQwA3RpQy84
         0wYN2eC8dy0oEIa6MRSIN/e3Y4aJ+4CGaz7Fg51V0ZV7jaDvYq6cQ7kis4jYf1IN7NR7
         E73wd0XjtgujNQfVc0u1izNyA8HGwz0NLOgd79/mivOpPVrYjnzDjWYSP6dVGge8Evhs
         c6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CyLZ0HcKYn5cINTo9abzB39mIlHZoj01C7i4Yaug5h0=;
        b=I2W2elR3t/Z7CpPTbLNWn6LwDps0JyTSErgMxbUdKAXozy3oxNBOtkgiqC90GMvBdw
         2lQeKMlSHL+RkaJuh7K55nPPPwR1u1QqFm9FSD43IyhZyNonRkXXDCJVXQhGFrsANsP4
         bDWcbicFA2VIM2sYQCTlkb6ZjoT9ChbfVViI+TwTeoo5Ap+zzlC+mtawYvr76QYgKJDP
         vlUbldXeTXnX9KvEq/60AH7Ja+oqiTTWinrqjLPxXQghIkLOvVQd7VEAWfSJmMyoM7h/
         ZXH45WEIdrkc5lWgNO49HAOmHJgFpTZ7gLUFxJr510y3rCN7GrWimYvWG9M4RRIEo+be
         dhwA==
X-Gm-Message-State: AOAM531wryaPelJqK6bq9GcT8Sr0ROIDM5JfCJ0yqVouu64m23qszncQ
        i58jx4rhM0Y4nOz7z9ZH5WfJkQ==
X-Google-Smtp-Source: ABdhPJyOq0509u70/V8v/o1xyWmDvB3d1+CU3yhFTHABEAAYoaXKW8cBcTXYir8Uyy/Gz1GWXhWOcw==
X-Received: by 2002:aa7:88d5:0:b0:49f:e382:3d62 with SMTP id k21-20020aa788d5000000b0049fe3823d62mr3085811pff.76.1638327145686;
        Tue, 30 Nov 2021 18:52:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o7sm16370996pgq.59.2021.11.30.18.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 18:52:25 -0800 (PST)
Date:   Wed, 1 Dec 2021 02:52:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sev: clean up initialization of variables info and v
Message-ID: <YabjZbB8rbMHHX25@google.com>
References: <20211126223658.1150141-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126223658.1150141-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021, Colin Ian King wrote:
> Currently variable info is being assigned twice, the second assignment
> is redundant. Clean up the code by making the assignments at declaration
> time and remove the latter two assignments.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Heh, checkpatch complains about the different email domains as it doesn't know
that googlemail.com and gmail.com are more or less the same.  Doubt it matters
much, but probably worth having your SoB match your local git config.

> ---
>  arch/x86/kernel/sev-shared.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index ce987688bbc0..6083d6f658c8 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -104,10 +104,7 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>  
>  	if (ret == 1) {
>  		u64 info = ghcb->save.sw_exit_info_2;
> -		unsigned long v;
> -
> -		info = ghcb->save.sw_exit_info_2;
> -		v = info & SVM_EVTINJ_VEC_MASK;
> +		unsigned long v = info & SVM_EVTINJ_VEC_MASK;

'v' should really be a u8, and IMO 'v' is a pointlessly short.  Opportunistically
squash this in?

---
 arch/x86/kernel/sev-shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 6083d6f658c8..2feb7359ed3a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -104,13 +104,13 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt

 	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
+		u8 vector = info & SVM_EVTINJ_VEC_MASK;

 		/* Check if exception information from hypervisor is sane. */
 		if ((info & SVM_EVTINJ_VALID) &&
-		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
+		    ((vector == X86_TRAP_GP) || (vector == X86_TRAP_UD)) &&
 		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
-			ctxt->fi.vector = v;
+			ctxt->fi.vector = vector;

 			if (info & SVM_EVTINJ_VALID_ERR)
 				ctxt->fi.error_code = info >> 32;
--


>  		/* Check if exception information from hypervisor is sane. */

s/sane/mostly sane, this code doesn't check that the hypervisor correctly provided
an error.  It doesn't really matter since ctxt->fi.error_code is zeroed, i.e. will
have clean data for #GP, and is ignored by #UD.  And nothing downstream should
be doing anything more than reporting the error code anyways since the value is
fully VMM controlled.  But to be pedantic...

From: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Nov 2021 18:40:30 -0800
Subject: [PATCH] x86/sev: Verify that VMM provides error code on #GP, and not
 on #UD

When handling an "injected" exception after #VMGEXIT, verify that the VMM
did (not) provide an error code as appropriate for the signaled vector.
Treat an error code mismatch as a VMM error instead of synthesizing an
exception.

Fixes: 597cfe48212a ("x86/boot/compressed/64: Setup a GHCB-based VC Exception handler")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/sev-shared.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2feb7359ed3a..139d88a76adc 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -105,11 +105,13 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
 		u8 vector = info & SVM_EVTINJ_VEC_MASK;
+		bool want_error_code = (vector == X86_TRAP_GP);

 		/* Check if exception information from hypervisor is sane. */
 		if ((info & SVM_EVTINJ_VALID) &&
 		    ((vector == X86_TRAP_GP) || (vector == X86_TRAP_UD)) &&
-		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT) &&
+		    (!!(info & SVM_EVTINJ_VALID_ERR) == want_error_code)) {
 			ctxt->fi.vector = vector;

 			if (info & SVM_EVTINJ_VALID_ERR)
--

