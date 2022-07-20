Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0957BE08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGTSq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGTSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438745F11D;
        Wed, 20 Jul 2022 11:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3653B821B3;
        Wed, 20 Jul 2022 18:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F46C341C7;
        Wed, 20 Jul 2022 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658342811;
        bh=6JkQqpw0MmTlbMYmqr0ZVhedIMa8/luYWE6ik91JFbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOmDb99rEVneVO589It/Ck5dJ/xZOKEAXZL25BZzDy9Yt0s58r29QNcMLuRwipO8O
         DsTscB4kCggj/R0Zjdb0sO7evdsw/+S/xn3N4crXwuv3FlDR8aZsS3s6DqBf9tpL7O
         AQifSnoyYy17ME+hCCam/oRCmP7RVehNojDyGotY2+3MbcJ0B+6u8jEsOGKco9A2Jf
         xTaie09kp8q5i3+C/uMg5VX8pCPP/3zx0KW2sKVsRO28karhdU1Kj1isNp3Q7d7Mm7
         G+XYUz1CPM2Ewnhud/CBu18EW+nxXbBAp1XBF3KsfhHMKuGlNvKl86u/PgoGgOMIb9
         JOK6qfBN+Xk9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F20340374; Wed, 20 Jul 2022 15:46:49 -0300 (-03)
Date:   Wed, 20 Jul 2022 15:46:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 01/17] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <YthNmcOJOZitcsjD@kernel.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <20220604042820.2270916-2-leo.yan@linaro.org>
 <YthNXweIEdNfcoX1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthNXweIEdNfcoX1@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 20, 2022 at 03:45:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jun 04, 2022 at 12:28:04PM +0800, Leo Yan escreveu:
> > From: Ali Saidi <alisaidi@amazon.com>
> > 
> > Add a flag to the perf mem data struct to signal that a request caused a
> > cache-to-cache transfer of a line from a peer of the requestor and
> > wasn't sourced from a lower cache level.  The line being moved from one
> > peer cache to another has latency and performance implications. On Arm64
> > Neoverse systems the data source can indicate a cache-to-cache transfer
> > but not if the line is dirty or clean, so instead of overloading HITM
> > define a new flag that indicates this type of transfer.
> > 
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> 
> Hey, any knews about this going upstream? PeterZ?

Just took a look and it isn't in tip/master.

- Arnaldo
 
> > ---
> >  include/uapi/linux/perf_event.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..7b88bfd097dc 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -1310,7 +1310,7 @@ union perf_mem_data_src {
> >  #define PERF_MEM_SNOOP_SHIFT	19
> >  
> >  #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
> > -/* 1 free */
> > +#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
> >  #define PERF_MEM_SNOOPX_SHIFT  38
> >  
> >  /* locked instruction */
> > -- 
> > 2.25.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
