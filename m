Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FF4A815D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiBCJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiBCJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:19:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:19:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id j2so6521636ejk.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppSliz/48Zmw4jvP58cJGwmlmvNTKslgB1AxTE1s7Cs=;
        b=yDZxxvlEb0ist7uCOAMfxZ8zBwbMOGcbpOgj8b/4feHNydC1vqbRggQ+sifQHYkIEO
         lZAVeUQgGsmyRelO17d6Q1pgWJW9uyIALX18kY2wqoTnWCNCN8vtG8deY4zdoFHc/q65
         +/HYAzQI5kdg4XB78mvBCug/FU3zZyURFNpvBgmUSaZ6hCwmxCt9toAIfMxN9jlzzUIw
         X85K6xMe9zrxssfxOnM3thO66oBWntNjpt+yfCU2nVcW1yFnpHn9LBilaFrjt8vjMjKH
         MstQWmM2BHdGiAf09M82+GtJH6PSLvgUM20ghjifoZPCTHmiXOLv/3TIaNsXkQjSHZV6
         kozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppSliz/48Zmw4jvP58cJGwmlmvNTKslgB1AxTE1s7Cs=;
        b=V17kCvUoquApK7PbqsZRcWBQ8WF+VBwV1ll0JctKoeR99U5fcZhu42gzWq3gktYF3O
         LBq9+E8ATmsjgKLrMmaUyszzmoXnmYGXTriaq1Do7Fo5YJf7YUPWj6ZSKUnekJLet9VI
         njQyKb11GX5j3XrWVb29NSUUeYqLSwAh38Imq4klne1xlvAi2G3ZFeLzq5iXA/RoQe/L
         21H6HRmy6XMHKolDNVBSyq4p1U0XrHjZiXz8W1jKne3AfRAVkixdoUaOOUP6h3lBR0Rp
         vL0dQzzSwrniVuRCJf9obYeMo/arR90H4Xrqedok8T5npugmTZQjcjYHPG9cQNzftRGE
         HJYA==
X-Gm-Message-State: AOAM531d8OoxZPg8CJDnqFTPcylJl3pXPrNa4yBf5bA1nzhLXP2wukcf
        zYZvLgp5CFogoFQtD+xe5Apw/w==
X-Google-Smtp-Source: ABdhPJwtJzSsiHJACaszbaku1AcK1Cg+QS1icIP4jCgJP3DHPz7c5582+pqlvIx0BT6tz6QsSGngLg==
X-Received: by 2002:a17:907:7e8c:: with SMTP id qb12mr28214053ejc.539.1643879981935;
        Thu, 03 Feb 2022 01:19:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.65])
        by smtp.gmail.com with ESMTPSA id w27sm16805321ejb.90.2022.02.03.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 01:19:41 -0800 (PST)
Date:   Thu, 3 Feb 2022 17:19:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Al.Grant@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Message-ID: <20220203091934.GA2013381@leoy-ThinkPad-X240s>
References: <20220202150104.GB1939745@leoy-ThinkPad-X240s>
 <20220202195115.12924-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202195115.12924-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 07:51:15PM +0000, Ali Saidi wrote:

[...]

> >> >> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> >> >
> >> >This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
> >> >hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
> >> >not obvious how the result is derived because there are some things that don't add up like
> >> >ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.
> >> 
> >> Assuming the above is correct, my reading of the existing code that creates the
> >> c2c output is that when an access is marked as an LLC hit, that doesn't
> >> necessarily mean that the data was present in the LLC. I don't see how it could
> >> given that LLC_HIT + HITM means the line was dirty in another CPUs cache, and so
> >> LLC_HIT + HITM seems to mean that it was a hit in the LLC snoop filter and
> >> required a different core to provide the line. This and the above certainly
> >> deserve a comment as to why the miss is being attributed in this way if it's
> >> otherwise acceptable.
> >
> >As James pointed out, this might introduce confusion.  I am wanderding
> >if we can extract two functions for synthesizing the data source, one is
> >for Neoverse platform and another is for generic purpose (which
> >without data source packets), below code is to demonstrate the basic
> >idea.
> 
> The code below is cleaner, and I'm happy to rework the patches in this way, but
> I think the question still remains about unifying behavior of the tool. If we
> mark something with a data source of ARM_SPE_NV_PEER_CORE as at L1 hit + HITM
> certainly c2c won't show the correct thing today, but i think it also hides the
> intent. The line in question missed the L1, L2, and got to the LLC where we did
> find a record that it was in another cores cache (L1 or L2). Looking at the way
> that c2c works today, it seems like marking this as a hit in the LLC snoop
> filter is the best way to unify behaviors among architectures?

Thanks a lot for pointing out this.  I looked into the code and
compared the memory trace data from x86, I found the HITM tag is always
sticking to LLC from x86's memory events.  This would be the main reason
why current code in perf is only support HITM for LLC.

I don't think it's a good way to always mark LLC snoop, even it's a
snooping operation in L1 or L2 cache on Arm64 platforms; this would
introduce confusion for users when using Arm SPE for profiling.

Alternatively, we can support HITM tag for L1/L2 cache levels in perf,
this can allow us to match memory topology on Arm64 arch, and it should
not introduce any regression on x86 arch.

Could you confirm if below code can fix the issue or not?

From 56e70a9ca974ad062788cfccd2ae9ddafa13d3ae Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@linaro.org>
Date: Thu, 3 Feb 2022 16:53:34 +0800
Subject: [PATCH] perf mem: Support HITM statistics for L1/L2 caches

Current code only support HITM statistics for last level cache (LLC) and
remote node's cache.  This works for x86 architecture since the HITM tag
is associated with LLC but not with L1/L2 cache.

On Arm64 architectures, due to the different memory hierarchy and
topology, the snooping can happen on L1 or L2 cache line, and thus it's
possible that coherency protocol fetches data from peer core or
cluster's L1/L2 cache.  For this reason, HITM tag is not necessarily
bound to LLC anymore.

For a general solution, this patch extends to set HITM tag for L1 and L2
cache, thus this can allow perf c2c tool to work properly for Arm64
architecture.  On the other hand, since x86 architecture doesn't set
HITM tag for L1/L2 cache, thus this patch should not introduce any
functionality change for x86 platforms.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem-events.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ed0ab838bcc5..7a0ab3d26843 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -527,8 +527,18 @@ do {				\
 			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
-			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L1 )) {
+				if (snoop & P(SNOOP, HITM))
+					HITM_INC(lcl_hitm);
+				else
+					stats->ld_l1hit++;
+			}
+			if (lvl & P(LVL, L2 )) {
+				if (snoop & P(SNOOP, HITM))
+					HITM_INC(lcl_hitm);
+				else
+					stats->ld_l2hit++;
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);

> I'll send you a perf.data file OOB.

Very appreciate!  I will look into it and will let you know
if I have any new finding.

Thanks,
Leo
