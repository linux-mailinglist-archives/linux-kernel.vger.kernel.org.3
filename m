Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D14BB3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiBRIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:04:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiBRIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:04:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5752B2FFD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A14F761299
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62357C340E9;
        Fri, 18 Feb 2022 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645171424;
        bh=1fBC7GGSjQURm/YJ/N2eyc/koN7mPuNwXAIqCpJshIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=VrXQ4IarbaSq+cKXFQjdKD/3DM8YR2Vo3FUlXSiOJlasS7m8fgxIWGqEBiHvW/ei3
         L7YKgteVEhbctagLZLsppu/DQDOQoxy2qTtZsrCaJ8xtIZW/JCv4Ep2Y82kejdYQRf
         wrQBZIXXm+VGRjmfF/nAKLhgdxxbmCVUfR/oUTVuXH61RaTCiS8gA1i5v3PhhyYglF
         Cdsaf15VqKshWJP4cb/CiJvbOs9WKTPjElL1hevFic9xpdWV5p/6yW7O+AzU25AHSM
         WvcN5bYcVvwasctX6AK9GIVmb/3Eqo1lXwt0d6xJZpC+H+X+gGLaqn5munOzTU2TBw
         L3ICTCx2tkjRA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        linux-damon@amazon.com
Subject: Re: [RFC PATCH V1 0/5] mm/damon: Add NUMA access statistics function support
Date:   Fri, 18 Feb 2022 08:03:40 +0000
Message-Id: <20220218080340.11566-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <503fa0b1-be20-a17e-72f0-14b38c0dc719@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 10:21:27 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> Hi SeongJae:
> 
> On 2/17/22 4:29 PM, SeongJae Park wrote:
> > + David Rientjes, who has shown interest[1] in this topic.
> >
> > [1] https://lore.kernel.org/linux-mm/bcc8d9a0-81d-5f34-5e4-fcc28eb7ce@google.com/
> >
> > ---
> >
> > Hi Xin,
> >
> >
> > Thank you always for great patches!
> >
> > On Wed, 16 Feb 2022 16:30:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
[...]
> > I'd like to comment on the high level design at the moment.  To my
> > understanding, this patchset extends DAMON core and monitoring operations for
> > virtual address spaces (vaddr) and the physical address space (paddr) to
> > monitor NUMA-local/remote accesses via PROT_NONE and page faults mechanism.
> >
> > The underlying mechanism for NUMA-local/remote accesses (PROT_NONE and page
> > fault) looks ok to me.  But, changes to the core and vaddr/paddr operations
> > looks unnecessary, to me.  That's also not for general use cases.
> You are right, adding NUMA access statistics does make the PA & VA codes 
> look confusing。
> >
> > I think it would be simpler to implment more monitoring operations for NUMA
> > monitoring use case (one for NUMA-local accesses accounting and another one for
> > NUMA-remote accesses accounting), alongside vaddr and paddr.  Then, users could
> > configure DAMON to have three monitoring contexts (one with vaddr ops, second
> > one with numa-local ops, and third one with numa-remote ops), run those
> > concurrently, then show the three results and make some decisions like
> > migrations.
> 
> Thanks for your advice, I will implement these in the next version, But 
> from my understanding or maybe
> 
> I didn't get what you were thinking, I think only one monitor context is 
> needed for NUMA Local & Remote,
> 
> Do not need a separate implementation like "numa_local_ops" and 
> "numa_remote_ops", just set "numa_access_ops" is ok.

Sorry for insufficient explanation of my concern.  In short, I'm concerning
about the regions adjustment.

You may do so by storing NUMA-local access count and NUMA-remote access
count in the nr_acceses filed of each region, e.g., saving NUMA-local access
count in upper-half bits of nr_accesses and saving NUMA-remote access count in
the lower-half bits.  However, then DAMON will do the regions adjustment based
on the NUMA-local/remote accesses count mixed value, so the accuracy would be
degraded.  So I think we need to implement each monitoring operations set for
each accesses that we want to monitor.

> 
> >
> > One additional advantage of this approach is that the accuracy for
> > NUMA-local/remote accessed could be better, because the contexts configured to
> > use NUMA-local/remote monitoring ops will do the regions adjustment with
> > NUMA-local/remote accesses (to my understanding, this patchset let regions have
> > NUMA-local/remote accesses counter in addition to the total one, but still use
> > only the total one for the regions adjustment).

My previous comment above might help clarifying my concern.

If I'm missing something, please let me know.


Thanks,
SJ

> >
> > If I'm missing something, please let me know.
> >
> >
> > Thanks,
> > SJ
> >
> >> --
> >> 2.27.0
> 
> -- 
> Best Regards!
> Xin Hao
> 
