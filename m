Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B75AF45C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIFTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiIFTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:22:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D864AA9262;
        Tue,  6 Sep 2022 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3GsMXUauB5utuEXv1jDmKoUBdqmBEdZQ5N5O8GX8KS8=; b=lobpDkUTBm1BgXceQdblKqADOJ
        R3CgWOaoofntBmHZnnPPUdL7z6rPA8k7tPrZsd81Y+GRNrncrNGRrPwu8ae/qcDWlgS38a7H8irke
        3eZAphqb8aoprdffabGDRGHCBfr6EcmWC9oe4SYAffOL9pZXFMYgwJVA+gwfDvKYDgEf7+TUM0bzR
        TyDsmpEwf1gnmia1mNIY4XKS7EB62smcgf6DSTokDh1bEa97CUc1bcWyE7wxdyp42IE1nEKdCwSVW
        v64hda0sbzRR/VWRuZwa/YIXoNxxg45Dm+cxjo/GhErqZKYyTz0L/tStNbxI+56gNnVMf9owY7B0N
        mmD8jzug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVe9K-00Ah4Z-Pu; Tue, 06 Sep 2022 19:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C76BC300244;
        Tue,  6 Sep 2022 21:22:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2EC92B576966; Tue,  6 Sep 2022 21:22:14 +0200 (CEST)
Date:   Tue, 6 Sep 2022 21:22:14 +0200
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
Message-ID: <Yxed5u9X2PKGAKGf@hirez.programming.kicks-ass.net>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
 <20220905054239.324029-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905054239.324029-5-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 11:12:39AM +0530, Anshuman Khandual wrote:

>  arch/x86/events/perf_event.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index ba3d24a6a4ec..12136a33e9b7 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -86,6 +86,26 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
>  #define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
>  #define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
>  
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LDLAT) == PERF_X86_EVENT_PEBS_LDLAT);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST) == PERF_X86_EVENT_PEBS_ST);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_ST_HSW) == PERF_X86_EVENT_PEBS_ST_HSW);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LD_HSW) == PERF_X86_EVENT_PEBS_LD_HSW);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_NA_HSW) == PERF_X86_EVENT_PEBS_NA_HSW);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL) == PERF_X86_EVENT_EXCL);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_DYNAMIC) == PERF_X86_EVENT_DYNAMIC);
> +
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_EXCL_ACCT) == PERF_X86_EVENT_EXCL_ACCT);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AUTO_RELOAD) == PERF_X86_EVENT_AUTO_RELOAD);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LARGE_PEBS) == PERF_X86_EVENT_LARGE_PEBS);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_VIA_PT) == PERF_X86_EVENT_PEBS_VIA_PT);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PAIR) == PERF_X86_EVENT_PAIR);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_LBR_SELECT) == PERF_X86_EVENT_LBR_SELECT);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_TOPDOWN) == PERF_X86_EVENT_TOPDOWN);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_STLAT) == PERF_X86_EVENT_PEBS_STLAT);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AMD_BRS) == PERF_X86_EVENT_AMD_BRS);
> +static_assert((PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LAT_HYBRID)
> +				   == PERF_X86_EVENT_PEBS_LAT_HYBRID);


That's not half tedious...

How about something like so?

---
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -64,27 +64,25 @@ static inline bool constraint_match(stru
 	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
 }
 
+#define PERF_ARCH(name, val)	\
+	PERF_X86_EVENT_##name = val,
+
 /*
  * struct hw_perf_event.flags flags
  */
-#define PERF_X86_EVENT_PEBS_LDLAT	0x00001 /* ld+ldlat data address sampling */
-#define PERF_X86_EVENT_PEBS_ST		0x00002 /* st data address sampling */
-#define PERF_X86_EVENT_PEBS_ST_HSW	0x00004 /* haswell style datala, store */
-#define PERF_X86_EVENT_PEBS_LD_HSW	0x00008 /* haswell style datala, load */
-#define PERF_X86_EVENT_PEBS_NA_HSW	0x00010 /* haswell style datala, unknown */
-#define PERF_X86_EVENT_EXCL		0x00020 /* HT exclusivity on counter */
-#define PERF_X86_EVENT_DYNAMIC		0x00040 /* dynamic alloc'd constraint */
-
-#define PERF_X86_EVENT_EXCL_ACCT	0x00100 /* accounted EXCL event */
-#define PERF_X86_EVENT_AUTO_RELOAD	0x00200 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_LARGE_PEBS	0x00400 /* use large PEBS */
-#define PERF_X86_EVENT_PEBS_VIA_PT	0x00800 /* use PT buffer for PEBS */
-#define PERF_X86_EVENT_PAIR		0x01000 /* Large Increment per Cycle */
-#define PERF_X86_EVENT_LBR_SELECT	0x02000 /* Save/Restore MSR_LBR_SELECT */
-#define PERF_X86_EVENT_TOPDOWN		0x04000 /* Count Topdown slots/metrics events */
-#define PERF_X86_EVENT_PEBS_STLAT	0x08000 /* st+stlat data address sampling */
-#define PERF_X86_EVENT_AMD_BRS		0x10000 /* AMD Branch Sampling */
-#define PERF_X86_EVENT_PEBS_LAT_HYBRID	0x20000 /* ld and st lat for hybrid */
+enum {
+#include "perf_event_flags.h"
+};
+
+#undef PERF_ARCH
+
+#define PERF_ARCH(name, val)						\
+	static_assert((PERF_X86_EVENT_##name & PERF_EVENT_FLAG_ARCH) ==	\
+		      PERF_X86_EVENT_##name);
+
+#include "perf_event_flags.h"
+
+#undef PERF_ARCH
 
 static inline bool is_topdown_count(struct perf_event *event)
 {
--- /dev/null
+++ b/arch/x86/events/perf_event_flags.h
@@ -0,0 +1,22 @@
+
+/*
+ * struct hw_perf_event.flags flags
+ */
+PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
+PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
+PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
+PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
+PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
+PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
+PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
+			/*	0x00080	*/
+PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
+PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
+PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
+PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
+PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
+PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
+PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
+PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
+PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
+PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
