Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAA48DC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiAMRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiAMRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:05:03 -0500
X-Greylist: delayed 101 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jan 2022 09:05:02 PST
Received: from mxs2.seznam.cz (mxs2.seznam.cz [IPv6:2a02:598:2::125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8EC06161C;
        Thu, 13 Jan 2022 09:05:02 -0800 (PST)
Received: from email.seznam.cz
        by email-smtpc19b.ng.seznam.cz (email-smtpc19b.ng.seznam.cz [10.23.18.23])
        id 2656d399b264a100214bc97d;
        Thu, 13 Jan 2022 18:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1642093500; bh=btXCnBKUj5koh5OuAW6tIKoKtTa1voPx12sh0qgT0Og=;
        h=Received:Date:From:To:Cc:Subject:Message-ID:X-Mailer:In-Reply-To:
         MIME-Version:Content-Type:Content-Transfer-Encoding:X-szn-frgn:
         X-szn-frgc;
        b=GU6ftit2zUb+E3qPl6eg1MZb35en4pXm6oWP2j7+ejrbceP4/Lv3kLwgAJPnqCMIk
         47WuwGOXoeAyNCXUhMDqsZ3X1WmvEGwldanpQIrhSfsYWFIQTdTePaZyhDFIxsflTr
         P+lo8yd+T4MlAs81xDJe7XL3SJAvHi8nLZsO/EzY=
Received: from PC (79.105.116.90 [79.105.116.90])
        by email-relay10.ng.seznam.cz (Seznam SMTPD 1.3.136) with ESMTP;
        Thu, 13 Jan 2022 18:01:04 +0100 (CET)  
Date:   Fri, 14 Jan 2022 02:00:55 +0900
From:   Alexey Avramov <hakavlad0@seznam.cz>
To:     mhocko@suse.com
Cc:     Hi-Angel@yandex.ru, Michael@michaellarabel.com, ak@linux.intel.com,
        akpm@linux-foundation.org, axboe@kernel.dk,
        catalin.marinas@arm.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, hakavlad@inbox.lv, hannes@cmpxchg.org,
        hdanton@sina.com, jsbarnes@google.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        page-reclaim@google.com, riel@surriel.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        willy@infradead.org, x86@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <20220114020055.0cd8697a@PC>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
In-Reply-To: <Yd109jeRllJbjV9o@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-szn-frgn: <092108c3-2aa1-4d4d-a385-941d2bc0ef66>
X-szn-frgc: <0>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But the later one is more complex and a proper
> handling really depends on the particular workload

That is why I advocate the introduction of new tunables.

> There are workloads which prefer a temporary trashing over its working
> set during a peak memory demand rather than an OOM kill

OK, for such cases, the OOM handles can be set to 0.
It can even be the default value.

> On the other side workloads that are
> latency sensitive

I daresay that this is the case with most workloads.
An internet server that falls into thrashing is a dead server.

> no simple solution can be applied to the whole

There are several solutions and they can be taken into the kernel
at the same time, they all work:
- min_ttl_ms + MGLRU
- vm.min_filelist_kbytes-like knobs
- PSI-based solutions.

> For the most steady trashing situations I have
> seen the userspace with mlocked memory and the code can make a forward
> progress and mediate the situation.

I still don't see a problem in making all the kernel-space solutions
in the kernel.
