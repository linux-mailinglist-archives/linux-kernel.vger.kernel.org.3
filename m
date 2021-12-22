Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC547CE82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhLVIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhLVIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:55:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:55:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADD261943
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E2C36AE5;
        Wed, 22 Dec 2021 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640163300;
        bh=e5bRXF0QeHEecyEBKt0xWGLG3CQkFtpGm6V1JPRcJAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=kb7Gg1HuTXaDQX01iw84yS5Bbt33Go6aW5J2jmnmRR9yEVffm2bsm5/MVnOYdurGf
         y4gujrc92nF7gV/SXtwE2VcYlwxvrciwpS+ZUzDvLvcp3w3oSU3+rh4rh85zWOswnH
         OXTw0ZdTn3V6XCZ4vh/jap8oziOKRbgQ4rhGe+EMoWKsCO/X+EuRzrHSAY6v7jDSoE
         77ZhDzC+NUSDxnMVcmZVRwyX30oykDyHFxl7hX2Ud0Dq3wWrqKncRHuP/sFI/ZKY6H
         o9TTazh9Sci7jmJDzYXcOgkH5/6EnjtXuu7N0VxSslY89CSUfEEzwa7+gh9CPDON7U
         TbP52rwS98XsA==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add a new scheme to support demotion on tiered memory system
Date:   Wed, 22 Dec 2021 08:54:55 +0000
Message-Id: <20211222085455.15996-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7d3e57ec-8344-bbc9-6a2e-052707aec760@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 22:32:24 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 12/21/2021 9:26 PM, SeongJae Park wrote:
> > Hi Baolin,
> > 
> > On Tue, 21 Dec 2021 17:18:02 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> Hi,
> >>
> >> Now on tiered memory system with different memory types, the reclaim path in
> >> shrink_page_list() already support demoting pages to slow memory node instead
> >> of discarding the pages. However, at that time the fast memory node memory
> >> wartermark is already tense, which will increase the memory allocation latency
> >> during page demotion. So a new method from user space demoting cold pages
> >> proactively will be more helpful.
> >>
> >> We can rely on the DAMON in user space to help to monitor the cold memory on
> >> fast memory node, and demote the cold pages to slow memory node proactively to
> >> keep the fast memory node in a healthy state.
> >>
> >> This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
> >> and works well from my testing. Any comments are welcome. Thanks.
> > 
> > I like the idea, thank you for these patches!  If possible, could you share
> > some details about your tests?
> 
> Sure, sorry for not adding more information about my tests.

No problem!

> 
> My machine contains 64G DRAM + 256G AEP(persistent memory), and you 
> should enable the demotion firstly by:
> echo "true" > /sys/kernel/mm/numa/demotion_enabled
> 
> Then I just write a simple test case like below to mmap some anon 
> memory, and then just read and write half of the mmap buffer to let 
> another half to be cold enough to demote.
> 
> int main()
> {
>          int len = 50 * 1024 * 1024;
>          int scan_len = len / 2;
>          int i, ret, j;
>          unsigned long *p;
> 
>          p = mmap(NULL, len, PROT_READ | PROT_WRITE,
>                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>          if (p == MAP_FAILED) {
>                  printf("failed to get memory\n");
>                  return -1;
>          }
> 
>          for (i = 0; i < len / sizeof(*p); i++)
>                  p[i] = 0x55aa;
> 
>          /* Let another half of buffer to be cold */
>          do {
>                  for (i = 0; i < scan_len / sizeof(*p); i++)
>                          p[i] = 0x55aa;
> 
>                  sleep(2);
> 
>                  for (i = 0; i < scan_len / sizeof(*p); i++)
>                          j +=  p[i] >> 2;
>          } while (1);
> 
>          munmap(p, len);
>          return 0;
> }
> 
> After setting the atts/schemes/target_ids, then start monitoring:
> echo 100000 1000000 1000000 10 1000 > /sys/kernel/debug/damon/attrs
> echo 4096 8192000 0 5 10 2000 5 1000 2097152 5000 0 0 0 0 0 3 2 1 > 
> /sys/kernel/debug/damon/schemes
> 
> After a while, you can check the demote statictics by below command, and 
> you can find the demote scheme is applied by demoting some cold pages to 
> slow memory (AEP) node.
> 
> cat /proc/vmstat | grep "demote"
> pgdemote_direct 6881

Thank you for sharing this great details!

I was just wondering if you have tested and measured the effects of the memory
allocation latency increase during the page demotion, which invoked by
shrink_page_list(), and also if you have measured how much improvement can be
achieved with DAMON-based demotion in the scenario.  Seems that's not the case,
and I personally think that information is not essential for this patch, so I
see no problem here.  But, if you have tested or have a plan to do that, and if
you could, I think sharing the results on this cover letter would make this
even greater.


Thanks,
SJ
