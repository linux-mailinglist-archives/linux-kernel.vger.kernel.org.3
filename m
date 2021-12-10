Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C9470C82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344319AbhLJV3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhLJV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:29:21 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079AC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:25:46 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 14so11827356ioe.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3xnQkyVQM9gFgRkXS6z7PJuOgEDr5y1E31RCLgb3Z8=;
        b=aceGTxrg11vkKF8tG4YkBLKEXdTqkHeHQKGxGqmjJn3cgEnB44FcIXuE+K0jORKlQv
         XBCdg9mxO6KVpNz/fB3TdnlgrIfMzxcWIqUsvV6eHa7+hewNNUCwZvCBTATnIYjGF8dR
         fAdjDuzlC35HlCXD5Jb/CHyxWIaP1qKKCUlSGuGGgjQI+DE5FVhd1hroH1PkYbJ3s0o2
         Ln5B33IOjeiNBVp1QE7eyNTykT5ZPsJRyCk7fVPe6/jTaMlxI0L96XSA3Xh1lHbyVmMo
         nrDp4ID3uWLEI6/5BkapHNeK1bZq5TpzKg2jVrJbuw+SJnaArfEzLETnFgcUoIlICOGz
         /R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3xnQkyVQM9gFgRkXS6z7PJuOgEDr5y1E31RCLgb3Z8=;
        b=EGM6XDbchWZzB7etbD6SClQhsaHrV+YoZqO5kX00FWmJ3eOeyDfEnV4FkcJ7ZmHw/D
         VDyB9CdwWZq+gRi4mcI50OvTZ03AJps75proEX/pfn86/Vd3n3fwQaIa7bjqsKF7TN04
         lETZSs5qKjtN+T7hUYe015E/vmnlzrihDS+VsaxEzdFa88+lLHOaNi3zHqzcca/7mqeH
         RNaZxaAypV7R/85/eJIoyg4Gn3yMy7afNQEA6qVg0nyc8nVSmLzTpMBOYHzp18qOdNAs
         tGSWXizDvtFduX2/X3woHghlTOpzM6le5KmjSsyPyXu0jMHz8HAeZs61zuqj9CgXF7kv
         To5g==
X-Gm-Message-State: AOAM5301RgeEcjUh/RmYenJrM8wAo53SOlcCUEvzS/a6gsmjLUd0Zrtg
        irTk0T75blszzrLmfOOPHDGXYusV7z03Go+AD9Bskw==
X-Google-Smtp-Source: ABdhPJxq+SKyb3ZFt3b0wHzcslqhiRl4EZSbYHP6Mk7UdxGQfDj769QDCVqG2armZ7Bf+VhqZtSt2qo1kSINOFGQ314=
X-Received: by 2002:a6b:d804:: with SMTP id y4mr9966257iob.184.1639171545688;
 Fri, 10 Dec 2021 13:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com> <20211210210229.2991238-3-eranian@google.com>
 <YbPE3PDQ6Ro9oVEH@zn.tnic>
In-Reply-To: <YbPE3PDQ6Ro9oVEH@zn.tnic>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 10 Dec 2021 13:25:34 -0800
Message-ID: <CABPqkBTCu+PjeXU=Jw4Xsh=x63s-DBVtzJdZmB_pOaoZdabphQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] x86/cpufeatures: add AMD Fam19h Branch Sampling feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 1:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 10, 2021 at 01:02:17PM -0800, Stephane Eranian wrote:
> > This patch adds a cpu feature for AMD Fam19h Branch Sampling feature as bit
> > 31 of EBX on CPUID leaf function 0x80000008.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index d5b5f2ab87a0..e71443f93f04 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -315,6 +315,7 @@
> >  #define X86_FEATURE_AMD_SSBD         (13*32+24) /* "" Speculative Store Bypass Disable */
> >  #define X86_FEATURE_VIRT_SSBD                (13*32+25) /* Virtualized Speculative Store Bypass Disable */
> >  #define X86_FEATURE_AMD_SSB_NO               (13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> > +#define X86_FEATURE_AMD_BRS          (13*32+31) /* Branch Sampling available */
> >
> >  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
> >  #define X86_FEATURE_DTHERM           (14*32+ 0) /* Digital Thermal Sensor */
> > --
>
> It seems you missed my note from the last time:
>
> https://lore.kernel.org/r/YY0OUNqv1w/ihmHX@zn.tnic
>
Yes, I missed that. No worry, I will fix in V5.
Thanks for pointing it out.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
