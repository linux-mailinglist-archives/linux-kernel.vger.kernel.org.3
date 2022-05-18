Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA1852BD15
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiEROFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiEROFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:05:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07819CB68
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QYe8TgPSWi5eG10guqlupNGuWjRTxdPb1zxB8kIjdog=; b=E6FxV5oI3JIAvai5YDO1B3iuXf
        jdlF0lYmKxW9TEzTlGfO7weZa17G5O8HZwjEkvT+j5fyh5Klo/0WgjLUeFMd9noiB6krv/ha+ueE5
        F8Dg/KlS1j2tcXMdqa6+OX0OT+vnY/vNxKHeHesMhmMMY8IOF4+DHt0IbKCFbPl4u170BsOgaTuyp
        YBgHxeHNJbsFLXbNSuqAOwuAN1QLNtHJIi3Xd2CIGDoXFDmMy3qX+9NVyXhpmEe1JhvQIRCqH7nHN
        vdvr5EPSJeIsSppZ2/aXLyG7oitnjlmJwWGrMdMiFRaq7r2zJnDGCa/cFE0+ku6PIx1ZCNwwqwm4u
        51VWGxIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrKIS-001YaT-6C; Wed, 18 May 2022 14:05:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0AAE30047E;
        Wed, 18 May 2022 16:05:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 857CA202391E4; Wed, 18 May 2022 16:05:03 +0200 (CEST)
Date:   Wed, 18 May 2022 16:05:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Message-ID: <YoT9D0YGlWwHQMQi@hirez.programming.kicks-ass.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-5-mgorman@techsingularity.net>
 <20220518094112.GE10117@worktop.programming.kicks-ass.net>
 <20220518111539.GP3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518111539.GP3441@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:15:39PM +0100, Mel Gorman wrote:

> I'm not aware of how it can be done in-kernel on a cross architectural
> basis. Reading through the arch manual, it states how many channels are
> in a given processor family and it's available during memory check errors
> (apparently via the EDAC driver). It's sometimes available via PMUs but
> I couldn't find a place where it's generically available for topology.c
> that would work on all x86-64 machines let alone every other architecture.

So provided it is something we want (below) we can always start an arch
interface and fill it out where needed.

> It's not even clear if SMBIOS was parsed in early boot whether

We can always rebuild topology / update variables slightly later in
boot.

> it's a
> good idea. It could result in difference imbalance thresholds for each
> NUMA domain or weird corner cases where assymetric NUMA node populations
> would result in run-to-run variance that are difficult to analyse.

Yeah, maybe. OTOH having a magic value that's guestimated based on
hardware of the day is something that'll go bad any moment as well.

I'm not too worried about run-to-run since people don't typically change
DIMM population over a reboot, but yes, there's always going to be
corner cases. Same with a fixed value though, that's also going to be
wrong.


