Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49CD5AB7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiIBRq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiIBRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:46:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE7F1B78;
        Fri,  2 Sep 2022 10:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B656B82CD1;
        Fri,  2 Sep 2022 17:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A4C433C1;
        Fri,  2 Sep 2022 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662140810;
        bh=GhWFeoeGibIDNi/9fUOpKvO9bflsC+HCNk2h4a3XhD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAqAvdUIDlS7hOfkH9a9qp98rwd2s52YPlxSqsejLAVNar3O/YpQu62ZBQPUmq86A
         SsG8ludJ8cgHWWemseQe/5lWX/LRy7A1264JBI3wwOb4cpQAWoadj8LP41leFq3zUx
         btfaxSfjmuHFP6soat0S6bCo3G61A7+ExDLfOX4IXyBrhUcK/jtdsk0r3HnMMGmMwd
         UmAkIVZZFzcHTNTVk6xPfNGPNmQNdnAkyKuRewATj0jNLMfPBCICwEpfFusBcBJ7up
         malW5kE1cyfD/8ZfPinLihT+fldOY+sLplLkKUe067FRA89xDlDDPZbquTAgmGv/Ym
         p3AkB6EJ/ZWrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64F9F404A1; Fri,  2 Sep 2022 14:46:47 -0300 (-03)
Date:   Fri, 2 Sep 2022 14:46:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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
Message-ID: <YxJBh3wvAGol+Ekq@kernel.org>
References: <20220824044822.70230-1-anshuman.khandual@arm.com>
 <20220824044822.70230-7-anshuman.khandual@arm.com>
 <Yw59CkHUVbfrHdkh@kernel.org>
 <9b1a8ebd-0562-f104-7439-308282f7fb52@arm.com>
 <YxI99uLvpgAZjm2r@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxI99uLvpgAZjm2r@kernel.org>
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

Em Fri, Sep 02, 2022 at 02:31:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Sep 01, 2022 at 10:37:24AM +0530, Anshuman Khandual escreveu:
> > On 8/31/22 02:41, Arnaldo Carvalho de Melo wrote:
> > > Strange:
> > > 
> > >   75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
> > >         inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> > >     /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
> > >       100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
> > >           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       101 |    __va_arg_pack ());
> > >           |    ~~~~~~~~~~~~~~~~~
> > > 
> > 
> > Indeed. But this new code block here looks exact same like the previous and existing one
> > i.e with branch_new_name() and PERF_BR_NEW_MAX. The complain is that - '%8s' directive
> > argument is NULL. This warning might just be a false positive [1], because of a compiler
> > problem on powerpc64el ? But please do let me know if something needs to be changed here
> > to avoid this warning.
> > 
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
> > 
> 
> So, I tried not returning NULL in the functions that are ultimately
> called, but that didn't help, so I'll try just disabling that specific
> warning for this specific file.

Got it building:

    23.68 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
BUILD_TARBALL_HEAD=b0f700972d9d0c9b8e73f69ccf0e56d74c580d71

With:

From b0f700972d9d0c9b8e73f69ccf0e56d74c580d71 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 2 Sep 2022 14:35:26 -0300
Subject: [PATCH 1/1] perf build: Avoid false positive with
 -Werror=format-overflow= with gcc 10.3.0 on powerpc

When building with gcc 10.3.0 on powerpc this is happening:

   75     8.89 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04)
         inlined from 'branch_type_stat_display' at util/branch.c:152:4:
     /usr/powerpc64le-linux-gnu/include/bits/stdio2.h:100:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
       100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       101 |    __va_arg_pack ());
           |    ~~~~~~~~~~~~~~~~~

Looks related to:

  [10/11/12/13 Regression] false positive: directive argument is null [-Werror=format-overflow=]
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036

So lets disable this just for the util/branch.o file.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/YxI99uLvpgAZjm2r@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8fd6dc8de5210336..20a5524e88a04d44 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -223,6 +223,10 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
+# avoid false positive when building with gcc 10.3.0 on powerpc
+# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90036
+CFLAGS_branch.o += -Wno-format-overflow
+
 $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
-- 
2.37.2

