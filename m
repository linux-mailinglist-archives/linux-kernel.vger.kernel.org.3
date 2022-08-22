Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59BF59C5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiHVSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiHVSVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:21:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1646DBA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:21:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 20so10660749plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=E7zU9Fzk9/s8JYdJzxIIZaSlDzKG1TaAOakaBWBMg+w=;
        b=qvCi9A4voRrGsoTjj5ynU//V1tHrgBYKCKmlc0Iz2kCmwFkyDZnlX2Hjo7aLW+FLUD
         ZmHaS9ffoG9ZpFOZFjObLabjNl2F6C8WIQXhMiav/UoWG0D3UW6oRepvBWdDiCtFkftX
         jizt96LLs6acqoItxeO4hvNHLvrgOMiib3dzM4x0NbYubCrm+4Fmyc5YSVAkaQ5g16ym
         SoH+Gv6T4W2KxIC3V6w0ov5Dk22LxkLVG659u8aFpLVSy36PGBPyPaLZ93jlBLhLTxRV
         o1hvAd8G1y/LeGY5t4bbau8pqI9QDfvNsEAl5UZ9gbvLjQzwD+ZWzpreVVNqMHfCYFg0
         GtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=E7zU9Fzk9/s8JYdJzxIIZaSlDzKG1TaAOakaBWBMg+w=;
        b=6cIADgbV7c8yntcQoSouIwuBbktsGUSR4oKIH9exndtygN0VP8wDiakN2jBkNkPgKz
         mR9+A2f3+RrdaNi+6rK/3sC5/Tdi+YYt//fM+EeXkgHdgNLdmyT086au0i4Y4Nq6Fj+t
         B1P9QgPyu8L2owR63thadYqSkaIf0lpBR26bPD4OACwOq55aMkIsIFk+5fa6V7LKD0qS
         PFvOYx44D7ea1RW00euIUuZCCFFV4OcjvSXC0vNbqcXiodoesIz3rkgPTThLXe6sJwvn
         FcW7EOduHZXeWwWqIKBW4h9Oh8rRMD16UttvnXWjv58m8mQjD/pfcexK5YcaOoeMbour
         eXEg==
X-Gm-Message-State: ACgBeo2uh4ThwqDh5JUwBJvkMXlmIAkeimcxOPOhe/lAd7fSA0lDG8Lp
        8RQ5D7G59lnIoL1a/NrC9v9uCQ==
X-Google-Smtp-Source: AA6agR7vb5+ovbrhwIC9w6kPjkD7YVOZqKQ5FF5oNjnlofS9EdadoYakfeT/QbmkLPxz2bM2QFJVKA==
X-Received: by 2002:a17:90b:4a10:b0:1fb:2e77:a33 with SMTP id kk16-20020a17090b4a1000b001fb2e770a33mr6737392pjb.67.1661192488570;
        Mon, 22 Aug 2022 11:21:28 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a744700b001fb23c28e9asm2878749pjk.2.2022.08.22.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:21:28 -0700 (PDT)
Date:   Mon, 22 Aug 2022 18:21:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwPJJKxKI4vfQEVn@google.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
 <c09ba37c-f685-15a3-3042-8cb3a0f91282@linux.intel.com>
 <YwOk991q0iBgcQWC@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwOk991q0iBgcQWC@worktop.programming.kicks-ass.net>
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

On Mon, Aug 22, 2022, Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 05:08:55PM +0200, Andi Kleen wrote:
> > 
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > index 2db93498ff71..232e24324fd7 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -4473,6 +4473,11 @@ static bool init_hybrid_pmu(int cpu)
> > >   	struct x86_hybrid_pmu *pmu = NULL;
> > >   	int i;
> > > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > > +		pr_warn_once("hybrid PMU and virt are incompatible\n");
> > > +		return false;
> > > +	}
> > 
> > It's totally possible to virtualize hybrid correctly, so I don't think this
> > is justified
> 
> With a magic incantation and a sacrificial chicken sure,

Pretty sure this one requires at least a goat.

> but the typical guest will not have it set up right and we'll get the kernel
> doing *splat*.

I 100% agree that typical VMMs will not get this right, but at the same time I
think this is firmly a host _kernel_ bug.

Checking X86_FEATURE_HYPERVISOR in the guest won't handle things like trying to
run a non-hyrbid vCPU model on a hybrid CPU, because IIUC, the "is_hybrid()" is
purely based on FMS, i.e. will be false if someone enumerates a big core vCPU on
a hybrid CPU.

So until KVM gets sane handling, shouldn't this be?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f969410d0c90..0a8accfc3018 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2999,12 +2999,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
        }

        cap->version            = x86_pmu.version;
-       /*
-        * KVM doesn't support the hybrid PMU yet.
-        * Return the common value in global x86_pmu,
-        * which available for all cores.
-        */
-       cap->num_counters_gp    = x86_pmu.num_counters;
+       /* KVM doesn't support the hybrid PMU yet. */
+       cap->num_counters_gp    = is_hybrid() ? 0 : x86_pmu.num_counters;
        cap->num_counters_fixed = x86_pmu.num_counters_fixed;
        cap->bit_width_gp       = x86_pmu.cntval_bits;
        cap->bit_width_fixed    = x86_pmu.cntval_bits;

