Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95F588300
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiHBUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiHBUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:12:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF60FD39
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:12:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f192so5087233pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NS3tuj5g45ltjy0NPxQzz9quEN/PCg8b8WCS02pVswg=;
        b=Em8SJoIwFxDUAjRWxZI9tKYzcmsea9EWdDobbLA8ecer+NUancDtHVRen2cmZcIug1
         fhtqoDCaqveVromE7tYrq20GsUI+qcSpVGFjmFuf9ZF2aK7uJMXKwqpIOTVbYag3K/wT
         lxgoTOc6NuGQk4jV1pUkUoZ2+dLNXi5Cxx4w6V2/qqG70StpVM5CtWYC9tXIMWCqjzO4
         U4ERzwH1Y7j5v0p+u9iiW+AMIpfMq4moXkiR2yy99lTxYXkO2ocmXcHOUJ3IP8xRLitg
         kVQmWbtBePlw/NR5IQwFOwyWCpy4HRnR0KySihqmKSkqAEsWgfB0qSI2x80j55BPKpIG
         PW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NS3tuj5g45ltjy0NPxQzz9quEN/PCg8b8WCS02pVswg=;
        b=OhPyAj+5rMrCiQlYpnC4jcGXik7xLrDG8YpabNo76WjH3V1JacdDSZ3rYnwarSaf6D
         VX/NJHB3p56Zz0Yy4m+EYBcNGfXW0Ig3npNN8S5ZwzYAK6s+4GpEeZgAcDOp8SGXMyw4
         2hqEGnoUiJj8Bc1YOJeyGn7loMa85vAW9mAAoW4WW7PSyefoyZ46kiuuCmmZcHJ48lM9
         ZcZbVPDETIylvjJ3MHWaMXKjxBVjnpY+nxd3jurtq+aS8Mp1sFxrQ6W93aWCoQ0c+H85
         6s1bQ9Xdvrrfh3KKdn+ahMAMrU3CGsFc6Gzr1mkLRN/9td9E1X0FWVFq9h24JaEE66BM
         OOxw==
X-Gm-Message-State: AJIora+6HDdGCDdwhOOFD4mtUdKyDdHbYvicuj1NQOh7HE5WwcQPDymi
        3mpDMcmBwbEyXzNPtNF1u7GXhQ==
X-Google-Smtp-Source: AGRyM1vcDUGS589munHLQOjQooPuPYbZkzBOvGtg+XMbecq+nDvZj7bcq4qQC6sQ3vqXWHyMz6KvyA==
X-Received: by 2002:a63:b56:0:b0:41a:495a:2a26 with SMTP id a22-20020a630b56000000b0041a495a2a26mr18600047pgl.411.1659471172691;
        Tue, 02 Aug 2022 13:12:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id bt21-20020a17090af01500b001f1ea1152aasm8864773pjb.57.2022.08.02.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:12:52 -0700 (PDT)
Date:   Tue, 2 Aug 2022 20:12:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: do not shadow apic global definition
Message-ID: <YumFQOeSGnRoqEkM@google.com>
References: <20220729084533.54500-1-mailhol.vincent@wanadoo.fr>
 <YuQdhaUi0ur4l/zb@google.com>
 <CAMZ6RqJUtFDKZj9Wo8EjG3nefwM3RztW00FRwXct-KgFo-HSLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJUtFDKZj9Wo8EjG3nefwM3RztW00FRwXct-KgFo-HSLw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022, Vincent MAILHOL wrote:
> On Sat. 30 Jul. 2022 at 02:48, Sean Christopherson <seanjc@google.com> wrote:
> > On Fri, Jul 29, 2022, Vincent Mailhol wrote:
> > > arch/x86/include/asm/apic.h declares a global variable named `apic'.
> > >
> > > Many function arguments from arch/x86/kvm/lapic.h also uses the same
> > > name and thus shadow the global declaration. For each case of
> > > shadowing, rename the function argument from `apic' to `lapic'.
> > >
> > > This patch silences below -Wshadow warnings:
> >
> > This is just the tip of the iceberg, nearly every KVM x86 .c file has at least one
> > "apic" variable.  arch/x86/kvm/lapic.c alone has nearly 100.  If this were the very
> > last step before a kernel-wide (or even KVM-wide) enabling of -Wshadow then maybe
> > it would be worth doing, but as it stands IMO it's unnecesary churn.
> 
> I would say the opposite: in terms of *volume*, warnings from apic.c
> would be the tip of the iceberg and apic.h is the submerged part.
> 
> When the warning occurs in a header from the include directory, it
> will spam some random files which include such header. This is
> annoying when trying to triage W=2 warnings because you get totally
> unrelated warning (and W=2 has some useful flags such as
> -Wmaybe-uninitialized so there are some insensitive to check it).
> 
> My intent is only to silence the headers. I do not really care about
> the -Wshadow on *.c files because it is local.

But lapic.h is a KVM-internal header, if you only care about reducing the number
of warnings and not actually "fixing" KVM, then why not suppress or filter the
warnings when building KVM?
