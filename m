Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4355943F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiFXHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:31:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D869F9B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUOFk9b/9Pi1CdCvUNVXTceplFA6AUnlxbx60+B9dcw=; b=RJTk89S0PROMbL6UJk2GB9VH3Y
        boeJy6Fj/P3iLWMgCWFlNP3yc/NKsj45HMoRB6NW4brd62BOJZ4x83+r70cNzXE8C5z51MD8iOFTe
        Ul5fyyepJRjpetwqojKickySBiGksoqGJlzowtIzK2zR/rBThomoSBT5GQCtRmYuZzTkbMj1oC/kt
        u1Kb9cke5RT3KWTV7TpFnCmmEAQdPdrGlKGltV3CimQXtsUgfl5gJL+mVr0cAwsW3fqhS3OXtz9jH
        4PgH8xTBUqKAgqmgXYl9JOgYKEaUdJomU/8dUP4crr70QUcZdsS23aqMej5/pYesXrwoCwZfT4h8A
        NFe9nn0Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4dlQ-00C6VQ-E8; Fri, 24 Jun 2022 07:30:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6445C3002C1;
        Fri, 24 Jun 2022 09:29:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C88D29B3A655; Fri, 24 Jun 2022 09:29:58 +0200 (CEST)
Date:   Fri, 24 Jun 2022 09:29:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <YrVn9t2kLHB21uG1@hirez.programming.kicks-ass.net>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:06:55PM +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> I'm sorry for the delay. The testing took a while but below are
> the results from testing on our system.
> 
> tl;dr
> 
> o We ran all the tests with with SIS_PROP disabled.
> o tbench reaches close to saturation early with 256 clients.
> o schbench shows improvements for low worker counts.
> o All other benchmark results seem comparable to tip.
>   We don't see any serious regressions with v4.
> 
> > @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> >   */
> >  SCHED_FEAT(SIS_PROP, true)
> 
> SIS_PROP was disabled in our testing as follows:
> 
> --
> -SCHED_FEAT(SIS_PROP, true)
> +SCHED_FEAT(SIS_PROP, false)

So how about I make this change.

> With v4 on the current tip, I don't see any need for
> a special case for systems with smaller LLCs with
> SIS_PROP disabled and SIS_UITL enable. Even SIS Efficiency
> seems to be better with SIS_UTIL for hackbench.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> 

And apply this thing, lets see how it fares..
