Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F6524FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355131AbiELOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiELOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:14:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09024EA02
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:14:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so4981927plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FuS/ZgfSwC6kSt4qIvn3GFGZYvOzE0L2SWUhv9P3AZU=;
        b=M6M2RBJZBMGhUpzDnpJTlBCP/1NlQvrn3MAPUOVbiVmQVneFnd/IdoEzdV/Ts0RSxj
         /sMNT61JH0UKaA+qe6ctPJ4SYeNyiaohtE0dGIfHbZ9Cg5ca2eqNUmbZz7HXQ+yOYXac
         s3svq/Bs1P5B72M2f+ereQ2ezZKD/GmQtJCF5om56RdwpuDLSnPKo0YAQjctT2jvY3hu
         6/1kyIzYSjUwU4AIX/to3PUXR7y2dyZxl9aSXjevImr/TLxfywO4feB34OtacCtXi4BG
         3Tdimw90q5VqakA8Qk6STfelnaPYaADMlbY01UPuNf+ctPNFMAyviYjtp/cqIpQLwVN/
         uW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FuS/ZgfSwC6kSt4qIvn3GFGZYvOzE0L2SWUhv9P3AZU=;
        b=HbeKIaME1w59P2vPKN4JJgtkJL1s2jTJ+ttHiLlyWKvpykgrH6Mkk5BH2u+B5Aop0o
         pH/3Zqe88pE/YHngYMniEpH/bOq978s2r+Ha+PbMxnwkMot70MoPxwVrLigP3Go8Qkke
         oCH6xBcDYLqBBMEreujoXKQu3pVFhwnC4tEY5Iy4z+vV780fz7Nfwam7x2a94j+3lqVQ
         nGxlXsX+ZcS1y/AWE5TKLyQfaKSjw0lW9dJOBGzCjGd/0MAjJKQAGi47ttWZUQeUoY25
         hrdl9hDChLAxkCzHrHfooCvOwgHbOYVlRWEO6SV6ZUj4krdeADMn3pzQ6/yUmSIBNEp2
         UcCQ==
X-Gm-Message-State: AOAM532LHKG731P+yZGgS7ITai4Zee8ceWqCpPp/n2mhckDXPIKG9q7L
        bU2fLCLVThL6T6Dh+5UCf/Lq5w==
X-Google-Smtp-Source: ABdhPJx4JPQbkZ31MyCPnBd/otdiCyBaejNm1PnUMk6ARMDfKx0wO0sZ6mVRrkYprBHt+7b3ScWpmQ==
X-Received: by 2002:a17:902:e149:b0:15e:bafb:8760 with SMTP id d9-20020a170902e14900b0015ebafb8760mr30657461pla.155.1652364865185;
        Thu, 12 May 2022 07:14:25 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902a9c900b0015f186be48asm3980280plr.36.2022.05.12.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:14:24 -0700 (PDT)
Date:   Thu, 12 May 2022 14:14:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler to
 avoid double list_add
Message-ID: <Yn0WPBGGI4VcbM4S@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-2-seanjc@google.com>
 <87wnervxb7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnervxb7.ffs@tglx>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022, Thomas Gleixner wrote:
> Sean,
> 
> On Wed, May 11 2022 at 23:43, Sean Christopherson wrote:
> > @@ -840,6 +858,20 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> >  	unsigned long msecs;
> >  	local_irq_disable();
> >  
> > +	/*
> > +	 * Invoking multiple callbacks is not currently supported, registering
> > +	 * the NMI handler twice will cause a list_add() double add BUG().
> > +	 * The exception is the "nop" handler in the emergency reboot path,
> > +	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
> > +	 * handler has already run, i.e. has already prepared other CPUs, the
> > +	 * reboot path doesn't have any work of its to do, it just needs to
> > +	 * ensure all CPUs have prepared for reboot.
> 
> This is confusing at best. The double list add is just one part of the
> problem, which would be trivial enough to fix.
> 
> The real point is that after the first shoot down all other CPUs are
> stuck in crash_nmi_callback() and won't respond to the second NMI.

Well that's embarrasingly obvious in hindsight.

> 
> So trying to run this twice is completely pointless and guaranteed to
> run into the timeout.
> 
> > +	 */
> > +	if (shootdown_callback) {
> > +		WARN_ON_ONCE(callback != nmi_shootdown_nop);
> > +		return;
> 
> Instead of playing games with the callback pointer, I prefer to make
> this all explicit. Delta patch below.

Much better.  If you're planning on doing fixup, can you also include a comment
tweak about why the callback is left set?  If not, I'll do it in v2.  A bit
overkill, but it's another thing that for me was obvious only once I realized "why".

Thanks!

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 4e3a839ae146..808d3e75fb2d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -896,7 +896,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
                msecs--;
        }
 
-       /* Leave the nmi callback set */
+       /*
+        * Leave the nmi callback set, shootdown is a one-time thing.  Clearing
+        * the callback could result in a NULL pointer dereference if a CPU
+        * (finally) responds after the timeout expires.
+        */
 }
 
 static inline void nmi_shootdown_cpus_on_restart(void)
