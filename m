Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE046F3CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLITVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:21:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46624 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLITVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:21:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 114F1B82614;
        Thu,  9 Dec 2021 19:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08CEC341C6;
        Thu,  9 Dec 2021 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639077463;
        bh=l8aT2KFL66nTXjJzC+nFcTYlOzHn82GOsxi5oeVWqXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckgeEJQIO8DMz1SvfiIwuXablyJcWbuWPrlZfMFBsL7PHVeL+tKZC5OQhmYbvMoJS
         2MAnUpmjSgIZJcwQV7maFNq67++Jv+PeWQwGJIF1shOh+jMQlXfBqS0RfkNxl/nwoK
         /c8U2jJ2E0RSEDn8zbypb1bbuvC7IgET/dqeGLCtqHleCQyL74ptX/ovL+OOjnTk4/
         svFVOKla7gMg4bdxhHiv99W8HfKviDpsOth4+qsZr053ksruRrkNgTyDNgxyXgPdJZ
         EkdzOR0TkZJMvKrLIxJp6wXHQA8AW1FeTsQanJKzzvfC1ekiX/92ddtHef/Y+xW/oz
         ouBiUv7YQ5AcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77CF3405D8; Thu,  9 Dec 2021 16:17:41 -0300 (-03)
Date:   Thu, 9 Dec 2021 16:17:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 0/4] perf: Add new macros for mem_hops field
Message-ID: <YbJWVYZg1el9PR1I@kernel.org>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206091749.87585-1-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 06, 2021 at 02:47:45PM +0530, Kajol Jain escreveu:
> Patchset adds new macros for mem_hops field which can be
> used to represent remote-node, socket and board level details.
> 
> Currently the code had macro for HOPS_0, which corresponds
> to data coming from another core but same node.
> Add new macros for HOPS_1 to HOPS_3 to represent
> remote-node, socket and board level data.
> 
> For ex: Encodings for mem_hops fields with L2 cache:

I checked and this hasn't hit mainstream, is it already merged on a tree
where this is slated to be submitted in the next window? If so please
let me know which one so that I can merge it on perf/core.

- Arnaldo
 
> L2                      - local L2
> L2 | REMOTE | HOPS_0    - remote core, same node L2
> L2 | REMOTE | HOPS_1    - remote node, same socket L2
> L2 | REMOTE | HOPS_2    - remote socket, same board L2
> L2 | REMOTE | HOPS_3    - remote board L2
> 
> Patch 1 & 2 adds tool and kernel side changes to add new macros for
> mem_hops field
> 
> Patch 3 add data source encodings for power10 and older platforms
> to represent data based on newer composite  PERF_MEM_LVLNUM* fields
> 
> Patch 4 add data source encodings with proper sub_index used to
> represent memory/cache level data for power10 platform.
> 
> Kajol Jain (4):
>   perf: Add new macros for mem_hops field
>   tools/perf: Add new macros for mem_hops field
>   powerpc/perf: Add encodings to represent data based on newer composite
>     PERF_MEM_LVLNUM* fields
>   powerpc/perf: Add data source encodings for power10 platform
> 
>  arch/powerpc/perf/isa207-common.c     | 60 ++++++++++++++++++++-------
>  include/uapi/linux/perf_event.h       |  5 ++-
>  tools/include/uapi/linux/perf_event.h |  5 ++-
>  tools/perf/util/mem-events.c          | 29 ++++++++-----
>  4 files changed, 71 insertions(+), 28 deletions(-)
> 
> -- 
> 2.27.0

-- 

- Arnaldo
