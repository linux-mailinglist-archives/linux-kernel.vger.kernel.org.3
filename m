Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEE49AFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457745AbiAYJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455705AbiAYJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:06:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF71C061190
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:50:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v74so15809342pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 00:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpVbBkGVuYAEOTubZPIVkilPzINucv+qEAj8FIbI7Eo=;
        b=SjqcvJfmWT0LsSwKjLl8/oGty8JaGm5hpMzu76P1PSvKSeC9LqJG+1wXghK/zmBdJX
         qhqwfdMVbkhpp3zA35nVfS4kBFUNsAeaF9OLoms0rPTVihXNZKAGiLblSjNID0iRGLOu
         ytMuyivulEfCH1MZ4wjmwzCAnOxox/TD94/7b6Sftqf3Bn48N9DlXmy3IWLsin5tQSIq
         VtJ7el8ULiGNPnyDl0IKBo6tYoNRIyhv1yw6ijkaoDgrZzI6OD8e+mn7jCGXQGHpa2p5
         XRkWVVakd/2VqTlXPbq1KDIhMSH/iap/cCibF76qi4XJQF8oRpUZFPm4udqyVfmob0tT
         33KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpVbBkGVuYAEOTubZPIVkilPzINucv+qEAj8FIbI7Eo=;
        b=Vf417btgxut62BOJLzVr4V//K40jmYsvbd5fUcvQjeth8T5QAjABgE+ZheW6wH4rMz
         AOZY+ltQL4qWGgA922h7eiCSJIM5DwLipzLmaAdI/XLuyNiS8ilLGWBfU5q8pBmgjngI
         k/YVXdoRytEc13QRbXfSRk5yiblSbk4FFlPeg83OchELbpbTW4qX1LvLRjlvNxfACnrz
         y7H4C4UBdOl8rMcxlW+uFYNCCCkZTxkEQO8q50b2dnvzcpOcQ8p3Q3XcUnNdFqp59cES
         blfYP2cvLG4WkkLEygM5y6H9RB3t4J2LRS6OJgXAijtpXcwXiC5tJ99B2+kqJ6bdUUE6
         0HTA==
X-Gm-Message-State: AOAM533d8J81Tr9X5wDDeXC0HW93IRsmWxIHc2368EkFhh8iLKNqGPhu
        uTgV+gyXyO3rME3x0diG4ovtdHGLPEE7bazZPOSAjw==
X-Google-Smtp-Source: ABdhPJwqX8GsZEMUBsU+KrzF/fAqCLjp+zS06T9nv57NrxBtnCsMNA5eiRqCSmPTIbg7/wLyDlXtIiURagwkkqHNiS8=
X-Received: by 2002:a63:e805:: with SMTP id s5mr14747932pgh.369.1643100647835;
 Tue, 25 Jan 2022 00:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20220123195337.509882-1-ayushranjan@google.com>
 <45a6395e-63f3-12b2-e6d1-52ccf00272e7@redhat.com> <Ye7cNMZku7jlRHa+@google.com>
In-Reply-To: <Ye7cNMZku7jlRHa+@google.com>
From:   Ayush Ranjan <ayushranjan@google.com>
Date:   Tue, 25 Jan 2022 00:50:12 -0800
Message-ID: <CALqkrRWD53MsHUYTDQ9+BiSD27uYUGNtU6pPeD3yiUwtJy2_jA@mail.gmail.com>
Subject: Re: [PATCH] gvisor: add some missing definitions to vmx.h
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        Andrei Vagin <avagin@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Davidson <md@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abandoning this patch in favor of the more complete series of work quoted above.

On Mon, Jan 24, 2022 at 9:04 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jan 24, 2022, Paolo Bonzini wrote:
> > On 1/23/22 20:53, Ayush Ranjan wrote:
> > > From: Michael Davidson <md@google.com>
> > >
> > > gvisor needs definitions for some additional secondary exec controls.
> > >
> > > Tested: builds
> > > Signed-off-by: Ayush Ranjan <ayushranjan@google.com>
> > > Signed-off-by: Michael Davidson <md@google.com>
> >
> > Incorrect order of the Signed-off-by header (author goes first, submitter
> > goes last).
> >
> > > ---
> > >   arch/x86/include/asm/vmx.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > > index c77ad687cdf7..df40dc568eb9 100644
> > > --- a/arch/x86/include/asm/vmx.h
> > > +++ b/arch/x86/include/asm/vmx.h
> > > @@ -67,6 +67,7 @@
> > >   #define SECONDARY_EXEC_ENCLS_EXITING              VMCS_CONTROL_BIT(ENCLS_EXITING)
> > >   #define SECONDARY_EXEC_RDSEED_EXITING             VMCS_CONTROL_BIT(RDSEED_EXITING)
> > >   #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
> > > +#define SECONDARY_EXEC_EPT_VE                      VMCS_CONTROL_BIT(EPT_VIOLATION_VE)
> > >   #define SECONDARY_EXEC_PT_CONCEAL_VMX             VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
> > >   #define SECONDARY_EXEC_XSAVES                     VMCS_CONTROL_BIT(XSAVES)
> > >   #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC        VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
> >
> > I'm not sure why gvisor would care about an internal Linux header. gvisor
> > should only use arch/x86/include/uapi headers.
>
> It's Google-internal kernel crud, this patch should not be merged.  Though with a
> bit of patience, an equivalent patch will come with TDX support.  If we do merge
> something before TDX, I'd strongly prefer to take that "complete" version with a
> rewritten changelog.
>
> [*] https://lore.kernel.org/all/e519d6ae1e75a4bea494bb3940e1272e935ead18.1625186503.git.isaku.yamahata@intel.com
