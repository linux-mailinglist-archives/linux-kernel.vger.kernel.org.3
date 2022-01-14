Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBA48EBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiANOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:32:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33096 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64AC1B82604;
        Fri, 14 Jan 2022 14:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB6C36AEB;
        Fri, 14 Jan 2022 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642170759;
        bh=c0/3UrkMbjuUslXbgnUMa3dSP3+Nnia5iZzFb0NTNBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiP7IqOn6qn2bx8lkr/PMrpyoVcpOkYWfbt7xgwW9EImWS60JvI2VTLMzNivT/EXN
         HjOA/Fny0KlbTpUndeJPinDfh0csnrKqI7t8rKFVQ42BQuRjJPxdMwlQHbb0EXgftU
         yzm5ZfgmVZen/41DW9IqNicT1SiF5tjf7VqEEN+ycylmjWsgNM+ky+tOwDZuPtilDN
         b44K2TS3nbx8sB7cgaCXy02Byl7GxADbcohtMV15vns7XoHNvgtfu99pIkAtOUmHkj
         7xdUjNoWKZ5+XRG12ko9vqEgfAX4PRgvRGwmwuZXhrw+f8N5opCwWO9xmWBWI/p2qu
         35QZdgtUoZ99g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3DE7240714; Fri, 14 Jan 2022 11:32:37 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:32:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm: Fix off-by-one directory path.
Message-ID: <YeGJhWmiS04diOvf@kernel.org>
References: <20220114064822.1806019-1-irogers@google.com>
 <42fbdd13-c8a8-404b-a452-1e796c2e5a8b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fbdd13-c8a8-404b-a452-1e796c2e5a8b@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 14, 2022 at 09:26:29AM +0000, German Gomez escreveu:
> Hi Ian,
> 
> I think there's another include in "utils/intel-pt.c" that may need the same treatment.
> 
> On 14/01/2022 06:48, Ian Rogers wrote:
> > Relative path include works in the regular build due to -I paths but may
> > fail in other situations.
> >
> > Fixes: 83869019c74c ("perf arch: Support register names from all archs")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> German
> > ---
> >  tools/perf/util/arm64-frame-pointer-unwind-support.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> > index 4f5ecf51ed38..2242a885fbd7 100644
> > --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> > +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> > @@ -6,7 +6,7 @@
> >  #include "unwind.h"
> >  
> >  #define perf_event_arm_regs perf_event_arm64_regs
> > -#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> > +#include "../../arch/arm64/include/uapi/asm/perf_regs.h"
> >  #undef perf_event_arm_regs
> >  
> >  struct entries {

-- 

- Arnaldo
