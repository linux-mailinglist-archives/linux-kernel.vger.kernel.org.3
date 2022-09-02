Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6A5AB792
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiIBRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiIBRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:31:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFB86FE7;
        Fri,  2 Sep 2022 10:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E846EB82CE6;
        Fri,  2 Sep 2022 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D077C433C1;
        Fri,  2 Sep 2022 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662139897;
        bh=dvqyiv61NysCsuqfjDoNWZuxtn8xgJaMr/95HoirAwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrFZrTXrLHbd92PS9kEiiSimaWO1wSz9YhwIsyguWz0J42tA1Kp0ICHI9eud/o33S
         6kf61v/pLY5S3wVuulxK6+sLXAqoxSexIJO4zHrRoUHMFnNt6uDCW380iQM9EaK/Kp
         fpCZ64TpWu/Lm8BkW9QX84DIZn5IPtYlTHXQ2f/TepCtQsKFETcu3DQpP7qF5SGQVT
         vdekdRmxgOmdnXZqmy3UwjJ28Q6WQ0qFz0lOtLnf0LCQZiOOxlAt8zap4HP347UXmJ
         OA/2OGQx7sKJ/yktIorRSCeANiuH3m1sEuQwSpevAKiDhqoHR5Grqxc93osypzN8sa
         6qpPIynwD1lgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 959F3404A1; Fri,  2 Sep 2022 14:31:34 -0300 (-03)
Date:   Fri, 2 Sep 2022 14:31:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, mark.rutland@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V7 6/8] perf/tools: Extend branch type classification
Message-ID: <YxI99uLvpgAZjm2r@kernel.org>
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
 <20220824044822.70230-7-anshuman.khandual@arm.com>
 <Yw59CkHUVbfrHdkh@kernel.org>
 <9b1a8ebd-0562-f104-7439-308282f7fb52@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1a8ebd-0562-f104-7439-308282f7fb52@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 01, 2022 at 10:37:24AM +0530, Anshuman Khandual escreveu:
> 
> 
> On 8/31/22 02:41, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 24, 2022 at 10:18:20AM +0530, Anshuman Khandual escreveu:
> >> This updates the perf tool with generic branch type classification with new
> >> ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
> >> field i.e perf_branch_entry.new_type, new generic page fault related branch
> >> types and some arch specific branch types as added earlier in the kernel.
> >>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Cc: Jiri Olsa <jolsa@redhat.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-perf-users@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  tools/include/uapi/linux/perf_event.h | 16 ++++++++-
> >>  tools/perf/builtin-script.c           |  2 +-
> >>  tools/perf/util/branch.c              | 52 ++++++++++++++++++++++++++-
> >>  tools/perf/util/branch.h              |  6 +++-
> >>  tools/perf/util/session.c             |  2 +-
> >>  5 files changed, 73 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> >> index 146c137ff0c1..0f7c7ce29899 100644
> >> --- a/tools/include/uapi/linux/perf_event.h
> >> +++ b/tools/include/uapi/linux/perf_event.h
> >> @@ -255,9 +255,22 @@ enum {
> >>  	PERF_BR_IRQ		= 12,	/* irq */
> >>  	PERF_BR_SERROR		= 13,	/* system error */
> >>  	PERF_BR_NO_TX		= 14,	/* not in transaction */
> >> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
> >>  	PERF_BR_MAX,
> >>  };
> >>  
> >> +enum {
> >> +	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
> >> +	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
> >> +	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
> >> +	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
> >> +	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
> >> +	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
> >> +	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
> >> +	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
> >> +	PERF_BR_NEW_MAX,
> >> +};
> >> +
> >>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
> >>  	(PERF_SAMPLE_BRANCH_USER|\
> >>  	 PERF_SAMPLE_BRANCH_KERNEL|\
> >> @@ -1375,7 +1388,8 @@ struct perf_branch_entry {
> >>  		abort:1,    /* transaction abort */
> >>  		cycles:16,  /* cycle count to last branch */
> >>  		type:4,     /* branch type */
> >> -		reserved:40;
> >> +		new_type:4, /* additional branch type */
> >> +		reserved:36;
> >>  };
> >>  
> >>  union perf_sample_weight {
> >> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >> index 13580a9c50b8..585171479876 100644
> >> --- a/tools/perf/builtin-script.c
> >> +++ b/tools/perf/builtin-script.c
> >> @@ -877,7 +877,7 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
> >>  		       br->flags.in_tx ? 'X' : '-',
> >>  		       br->flags.abort ? 'A' : '-',
> >>  		       br->flags.cycles,
> >> -		       br->flags.type ? branch_type_name(br->flags.type) : "-");
> >> +		       get_branch_type(br));
> >>  }
> >>  
> >>  static int perf_sample__fprintf_brstack(struct perf_sample *sample,
> >> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> >> index abc673347bee..6d962b0a4532 100644
> >> --- a/tools/perf/util/branch.c
> >> +++ b/tools/perf/util/branch.c
> >> @@ -21,7 +21,10 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
> >>  	if (flags->type == PERF_BR_UNKNOWN || from == 0)
> >>  		return;
> >>  
> >> -	st->counts[flags->type]++;
> >> +	if (flags->type == PERF_BR_EXTEND_ABI)
> >> +		st->new_counts[flags->new_type]++;
> >> +	else
> >> +		st->counts[flags->type]++;
> >>  
> >>  	if (flags->type == PERF_BR_COND) {
> >>  		if (to > from)
> >> @@ -36,6 +39,25 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
> >>  		st->cross_4k++;
> >>  }
> >>  
> >> +const char *branch_new_type_name(int new_type)
> >> +{
> >> +	const char *branch_new_names[PERF_BR_NEW_MAX] = {
> >> +		"FAULT_ALGN",
> >> +		"FAULT_DATA",
> >> +		"FAULT_INST",
> >> +		"ARCH_1",
> >> +		"ARCH_2",
> >> +		"ARCH_3",
> >> +		"ARCH_4",
> >> +		"ARCH_5"
> >> +	};
> >> +
> >> +	if (new_type >= 0 && new_type < PERF_BR_NEW_MAX)
> >> +		return branch_new_names[new_type];
> >> +
> >> +	return NULL;
> >> +}
> >> +
> >>  const char *branch_type_name(int type)
> >>  {
> >>  	const char *branch_names[PERF_BR_MAX] = {
> >> @@ -62,6 +84,17 @@ const char *branch_type_name(int type)
> >>  	return NULL;
> >>  }
> >>  
> >> +const char *get_branch_type(struct branch_entry *e)
> >> +{
> >> +	if (e->flags.type == PERF_BR_UNKNOWN)
> >> +		return "";
> >> +
> >> +	if (e->flags.type == PERF_BR_EXTEND_ABI)
> >> +		return branch_new_type_name(e->flags.new_type);
> >> +
> >> +	return branch_type_name(e->flags.type);
> >> +}
> >> +
> >>  void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
> >>  {
> >>  	u64 total = 0;
> >> @@ -108,6 +141,15 @@ void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
> >>  				100.0 *
> >>  				(double)st->counts[i] / (double)total);
> >>  	}
> >> +
> >> +	for (i = 0; i < PERF_BR_NEW_MAX; i++) {
> >> +		if (st->new_counts[i] > 0)
> >> +			fprintf(fp, "\n%8s: %5.1f%%",
> >> +				branch_new_type_name(i),
> >> +				100.0 *
> >> +				(double)st->new_counts[i] / (double)total);
> >> +	}
> >> +
> > Strange:
> > 
> >   75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
> >         inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> >     /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
> >       100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
> >           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       101 |    __va_arg_pack ());
> >           |    ~~~~~~~~~~~~~~~~~
> > 
> 
> Indeed. But this new code block here looks exact same like the previous and existing one
> i.e with branch_new_name() and PERF_BR_NEW_MAX. The complain is that - '%8s' directive
> argument is NULL. This warning might just be a false positive [1], because of a compiler
> problem on powerpc64el ? But please do let me know if something needs to be changed here
> to avoid this warning.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
> 

So, I tried not returning NULL in the functions that are ultimately
called, but that didn't help, so I'll try just disabling that specific
warning for this specific file.

The patch that didn't help is below.

- Arnaldo

commit 07c96060c410db6d10dbbdffb22bb46afebfe2c0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Aug 31 13:26:22 2022 -0300

    perf branch: Don't return NULL on function that is used in a %s printf format
    
    To address this warning:
    
      In file included from /usr/include/stdio.h:866,
                       from /home/sfr/next/next/tools/perf/util/branch.h:9,
                       from util/branch.c:2:
      In function 'fprintf',
          inlined from 'branch_type_stat_display' at util/branch.c:152:4:
      /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
        105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
            |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        106 |                         __va_arg_pack ());
            |                         ~~~~~~~~~~~~~~~~~
      cc1: all warnings being treated as errors
    
    Fixes: 9781e500dcb87eeb ("perf branch: Extend branch type classification")
    Cc: Anshuman Khandual <anshuman.khandual@arm.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index d40776c44b060b7e..f30366999f01e5e7 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -68,7 +68,7 @@ const char *branch_new_type_name(int new_type)
 	if (new_type >= 0 && new_type < PERF_BR_NEW_MAX)
 		return branch_new_names[new_type];
 
-	return NULL;
+	return "<<INVALID>>";
 }
 
 const char *branch_type_name(int type)
@@ -94,7 +94,7 @@ const char *branch_type_name(int type)
 	if (type >= 0 && type < PERF_BR_MAX)
 		return branch_names[type];
 
-	return NULL;
+	return "<<INVALID>>";
 }
 
 const char *get_branch_type(struct branch_entry *e)
