Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1892586E41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiHAQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiHAQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 993F4A1B4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659369939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjwnPcemFdKzS6S36gsMhGgEGUlUL1WuNW85mhTQ5/s=;
        b=JbfJlyAwUZRl9ODP+BjQlUKxmnbxm7OORm5TTNEB/aZrj1q20Wrkxt5lbP0BaSjLBrUT0X
        tqTZrXhx3F2+ZOlmIAoo1Wa83GppQVZmds4oxk22JB4nurL2Ubyx/9z0pUZ9SFxdvoGW5M
        es+8ELtZdrvLiNGi5NFtJcyR0a3C9IE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-XmrRqtr3MD6uq2OG3uJbAw-1; Mon, 01 Aug 2022 12:05:38 -0400
X-MC-Unique: XmrRqtr3MD6uq2OG3uJbAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63CCE101A58E;
        Mon,  1 Aug 2022 16:05:36 +0000 (UTC)
Received: from starship (unknown [10.40.194.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 391A32166B26;
        Mon,  1 Aug 2022 16:05:30 +0000 (UTC)
Message-ID: <4a327f06f6e5da6f3badb5ccf80d22a5c9e18b97.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] x86: cpuid: improve support for broken CPUID
 configurations
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
Date:   Mon, 01 Aug 2022 19:05:29 +0300
In-Reply-To: <fad05f161cc6425d8c36fb6322de2bbaa683dcb3.camel@redhat.com>
References: <20220718141123.136106-1-mlevitsk@redhat.com>
         <fad05f161cc6425d8c36fb6322de2bbaa683dcb3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-28 at 10:30 +0300, Maxim Levitsky wrote:
> On Mon, 2022-07-18 at 17:11 +0300, Maxim Levitsky wrote:
> > This patch series aims to harden the cpuid code against the case when
> > the hypervisor exposes a broken CPUID configuration to the guest,
> > in the form of having a feature disabled but not features that depend on it.
> > 
> > This is the more generic way to fix kernel panic in aes-ni kernel driver,
> > which was triggered by CPUID configuration in which AVX is disabled but
> > not AVX2.
> > 
> > https://lore.kernel.org/all/20211103145231.GA4485@gondor.apana.org.au/T/
> > 
> > This was tested by booting a guest with AVX disabled and not AVX2,
> > and observing that both a warning is now printed in dmesg, and
> > that avx2 is gone from /proc/cpuinfo.
> > 
> > V2:
> > 
> > I hopefully addressed all the (very good) review feedback.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > Maxim Levitsky (5):
> >   perf/x86/intel/lbr: use setup_clear_cpu_cap instead of clear_cpu_cap
> >   x86/cpuid: refactor setup_clear_cpu_cap()/clear_cpu_cap()
> >   x86/cpuid: move filter_cpuid_features to cpuid-deps.c
> >   x86/cpuid: remove 'warn' parameter from filter_cpuid_features
> >   x86/cpuid: check for dependencies violations in CPUID and attempt to
> >     fix them
> > 
> >  arch/x86/events/intel/lbr.c       |  2 +-
> >  arch/x86/include/asm/cpufeature.h |  1 +
> >  arch/x86/kernel/cpu/common.c      | 51 +-------------------
> >  arch/x86/kernel/cpu/cpuid-deps.c  | 80 +++++++++++++++++++++++++++----
> >  4 files changed, 74 insertions(+), 60 deletions(-)
> > 
> > -- 
> > 2.34.3
> > 
> > 
> A very kind ping on these patches.

Another kind ping on these patches.


Best regards,
	Maxim Levitsky
> 
> Best regards,
> 	Maxim Levitsky


