Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2FC494B01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359642AbiATJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359635AbiATJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642671957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AnozGUjZxfRbxL/uXbhZzAjPZpfXbAj0xuaYn46Ym1Q=;
        b=NJjkkARJZezA/0RNYzYtAyUaELpC13zuVbpPYd71OXyj70UzLoMWexlc36tM7JQoslamGY
        AHYCJ65dGQihq2v+EWjLcM3uqwIoCBcdVlmfJDbqECw1fgs/57OTgiXgigB0/5C3H8cyuq
        AunP6l6IPuhHjPSRScLhZ+h1MXbcyZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Q1acZg4LMjWZJjJMpLE5jw-1; Thu, 20 Jan 2022 04:45:52 -0500
X-MC-Unique: Q1acZg4LMjWZJjJMpLE5jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7497D108087A;
        Thu, 20 Jan 2022 09:45:49 +0000 (UTC)
Received: from localhost (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F2C510013C1;
        Thu, 20 Jan 2022 09:45:42 +0000 (UTC)
Date:   Thu, 20 Jan 2022 17:45:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
Message-ID: <20220120094539.GC18398@MiWiFi-R3L-srv>
References: <20211206160514.2000-1-jszhang@kernel.org>
 <20220116133847.GE2388@MiWiFi-R3L-srv>
 <YebK70Sx4w8zLfj/@xhacker>
 <20220119080859.GB4977@MiWiFi-R3L-srv>
 <CA+zEjCvqYAWaWW9hVbHqYm_GbV-BaiOM4c77WHnxDNh+SRDUuw@mail.gmail.com>
 <20220119093322.GC4977@MiWiFi-R3L-srv>
 <Yef5oz/XiZT/Pxfy@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yef5oz/XiZT/Pxfy@xhacker>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/22 at 07:44pm, Jisheng Zhang wrote:
> On Wed, Jan 19, 2022 at 05:33:22PM +0800, Baoquan He wrote:
> > On 01/19/22 at 09:52am, Alexandre Ghiti wrote:
> > > Hi Baoquan,
> > > 
> > > On Wed, Jan 19, 2022 at 9:11 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 01/18/22 at 10:13pm, Jisheng Zhang wrote:
> > > > > On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> > > > > > Hi Jisheng,
> > > > >
> > > > > Hi Baoquan,
> > > > >
> > > > > >
> > > > > > On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > > > > > > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > > > > > > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > > > > > > and increase compile coverage.
> > > > > >
> > > > > > I go through this patchset, You mention the benefits it brings are
> > > > > > 1) simplity the code;
> > > > > > 2) increase compile coverage;
> > > > > >
> > > > > > For benefit 1), it mainly removes the dummy function in x86, arm and
> > > > > > arm64, right?
> > > > >
> > > > > Another benefit: remove those #ifdef #else #endif usage. Recently, I
> > > > > fixed a bug due to lots of "#ifdefs":
> > > > > http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html
> > > >
> > > > Glad to know the fix. While, sometime the ifdeffery is necessary. I am
> > > > sorry about the one in riscv and you have fixed, it's truly a bug . But,
> > > > the increasing compile coverage at below you tried to make, it may cause
> > > > issue. Please see below my comment.
> > > >
> > > > >
> > > > > >
> > > > > > For benefit 2), increasing compile coverage, could you tell more how it
> > > > > > achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> > > > > > purpose? Please forgive my poor compiling knowledge.
> > > > >
> > > > > Just my humble opinion, let's compare the code::
> > > > >
> > > > > #ifdef CONFIG_KEXEC_CORE
> > > > >
> > > > > code block A;
> > > > >
> > > > > #endif
> > > > >
> > > > > If KEXEC_CORE is disabled, code block A won't be compiled at all, the
> > > > > preprocessor will remove code block A;
> > > > >
> > > > > If we convert the code to:
> > > > >
> > > > > if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> > > > >       code block A;
> > > > > }
> > > > >
> > > > > Even if KEXEC_CORE is disabled, code block A is still compiled.
> > > >
> > > > This is what I am worried about. Before, if CONFIG_KEXEC_CORE is
> > > > unset, those relevant codes are not compiled in. I can't see what
> > > > benefit is brought in if compiled in the unneeded code block. Do I miss
> > > > anything?
> > > >
> > > 
> > > This is explained in Documentation/process/coding-style.rst "21)
> > > Conditional Compilation".
> > 
> > Thanks for the pointer, Alex.
> > 
> > I read that part, while my confusion isn't gone. With the current code,
> > CONFIG_KEXEC_CORE is set,
> >   - reserve_crashkernel_low() and reserve_crashkernel() compiled in.
> 
> Although the code block will be compiled, but the code block will be
> optimized out.
> 
> > CONFIG_KEXEC_CORE is unset,
> >   - reserve_crashkernel_low() and reserve_crashkernel() compiled out. 
> > 
> > After this patch applied, does it have the same effect as the old code?
> 
> I compared the .o, and can confirm they acchieve the same effect.

Checked the .o, it's truly as you said. I didn't know this before,
thank you and Alex, learned this now.

Seems only static function has this effect. I tested your x86 patch,
those two functions are all optimized out. If I remove the static,
the entire reserve_crashkernel_low() exists, while reserve_crashkernel()
will be optimized as a empty function. 

