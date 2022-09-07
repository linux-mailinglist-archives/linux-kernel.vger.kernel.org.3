Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6F5AFF05
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIGIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIGIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:31:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F1CA346F;
        Wed,  7 Sep 2022 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bKV8rZMiMMl7GemBDeOjBwLts2fa7GmujNh4pWx/iH4=; b=DO3PVdlNsrZTfbljOD3O2emLY0
        Y3EyqWYmRaLfywpUt+Wtw3ilhBj17cQ5xFJZE9zlkwx/0E1qeCIwL/rsme5GXqIZ5Vp0uVp+dGC7V
        KgxmvNsY+t9f29MLsks5mFv5Fr1tg2FDX4T+SUto3UXnAQmflOdJM6duEd/0MBaoKkF+Ezkl1CFoF
        Md38klA6/qZK72naq06cz/H1QmlKq1mN0KpKMeX34hHe/8QW7IZBrNYlo8PYrVwKA+XGnGKorLyrx
        crH8CalEIrtoMn3dcOaWmaxqOXqSv6AtEACgnWA8wTiEEzKK3AlgbyMCxZFXHSv6829sxCW+KSKlf
        0iPC5uug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVqSc-00BCIv-Ht; Wed, 07 Sep 2022 08:31:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C164300244;
        Wed,  7 Sep 2022 10:31:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0492E2022E4D8; Wed,  7 Sep 2022 10:30:59 +0200 (CEST)
Date:   Wed, 7 Sep 2022 10:30:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2 4/4] x86/perf: Assert all platform event flags are
 within PERF_EVENT_FLAG_ARCH
Message-ID: <YxhWwxhtFMh1aPMh@hirez.programming.kicks-ass.net>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
 <20220905054239.324029-5-anshuman.khandual@arm.com>
 <Yxed5u9X2PKGAKGf@hirez.programming.kicks-ass.net>
 <763825a2-67a1-6288-1b12-15768eef1d75@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763825a2-67a1-6288-1b12-15768eef1d75@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:57:35AM +0530, Anshuman Khandual wrote:

> > How about something like so?
> 
> Makes sense, will fold this back. Could I also include your "Signed-off-by:"
> for this patch ?
> 

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> > 
> > ---
> > --- a/arch/x86/events/perf_event.h
> > +++ b/arch/x86/events/perf_event.h
> > @@ -64,27 +64,25 @@ static inline bool constraint_match(stru
> >  	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
> >  }
> >  
> > +#define PERF_ARCH(name, val)	\
> > +	PERF_X86_EVENT_##name = val,
> > +
> >  /*
> >   * struct hw_perf_event.flags flags
> >   */
> > -#define PERF_X86_EVENT_PEBS_LDLAT	0x00001 /* ld+ldlat data address sampling */
> > -#define PERF_X86_EVENT_PEBS_ST		0x00002 /* st data address sampling */
> > -#define PERF_X86_EVENT_PEBS_ST_HSW	0x00004 /* haswell style datala, store */
> > -#define PERF_X86_EVENT_PEBS_LD_HSW	0x00008 /* haswell style datala, load */
> > -#define PERF_X86_EVENT_PEBS_NA_HSW	0x00010 /* haswell style datala, unknown */
> > -#define PERF_X86_EVENT_EXCL		0x00020 /* HT exclusivity on counter */
> > -#define PERF_X86_EVENT_DYNAMIC		0x00040 /* dynamic alloc'd constraint */
> > -
> > -#define PERF_X86_EVENT_EXCL_ACCT	0x00100 /* accounted EXCL event */
> > -#define PERF_X86_EVENT_AUTO_RELOAD	0x00200 /* use PEBS auto-reload */
> > -#define PERF_X86_EVENT_LARGE_PEBS	0x00400 /* use large PEBS */
> > -#define PERF_X86_EVENT_PEBS_VIA_PT	0x00800 /* use PT buffer for PEBS */
> > -#define PERF_X86_EVENT_PAIR		0x01000 /* Large Increment per Cycle */
> > -#define PERF_X86_EVENT_LBR_SELECT	0x02000 /* Save/Restore MSR_LBR_SELECT */
> > -#define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
> > -#define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
> > -#define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
> > -#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
> > +enum {
> > +#include "perf_event_flags.h"
> > +};
> > +
> > +#undef PERF_ARCH
> > +
> > +#define PERF_ARCH(name, val)						\
> > +	static_assert((PERF_X86_EVENT_##name & PERF_EVENT_FLAG_ARCH) ==	\
> > +		      PERF_X86_EVENT_##name);
> > +
> > +#include "perf_event_flags.h"
> > +
> > +#undef PERF_ARCH
> >  
> >  static inline bool is_topdown_count(struct perf_event *event)
> >  {
> > --- /dev/null
> > +++ b/arch/x86/events/perf_event_flags.h
> > @@ -0,0 +1,22 @@
> > +
> > +/*
> > + * struct hw_perf_event.flags flags
> > + */
> > +PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
> > +PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
> > +PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
> > +PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
> > +PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
> > +PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
> > +PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
> > +			/*	0x00080	*/
> > +PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
> > +PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
> > +PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
> > +PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
> > +PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
> > +PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
> > +PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
> > +PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
> > +PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
> > +PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
