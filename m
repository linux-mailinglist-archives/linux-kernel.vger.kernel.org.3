Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14394513991
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiD1QWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiD1QWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:22:32 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63F29C93
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651162757; x=1682698757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0aBCiflcBypZDeWPvvxI6gb6KauRymjuytqGky4Ut0=;
  b=uoA9whTqwzee98UQycNmhDnTAbVllLwyAJ15apSGMeY76ngr8Wo9kVGl
   ssPtzSACVoJmdmq4R6sfonVJpWUigXpibQbY0zEjN+UdXmqfoeThHE0W8
   B5Jotjyjo1T33tMNdT66Ddo03rSb1kdz91KPRBCFmK5ET8OUirEupJOs3
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2022 09:19:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:19:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 09:19:15 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 09:19:14 -0700
Date:   Thu, 28 Apr 2022 12:19:11 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-ID: <20220428161911.GB182@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com>
 <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:39:06AM -0400, Zi Yan wrote:
> How about the one attached? I can apply it to next-20220428. Let me know
> if you are using a different branch. Thanks.

The original endless loop is gone, but running some syscall fuzzer
afterwards for a while would trigger the warning here. I have yet to
figure out if this is related to this series.

        /*
         * There are several places where we assume that the order value is sane
         * so bail out early if the request is out of bound.
         */
        if (unlikely(order >= MAX_ORDER)) {
                WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
                return NULL;
        }

 WARNING: CPU: 26 PID: 172874 at mm/page_alloc.c:5368 __alloc_pages
 CPU: 26 PID: 172874 Comm: trinity-main Not tainted 5.18.0-rc4-next-20220428-dirty #67
 pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 tpidr_el2 : ffff28cf80a61000
 pc : __alloc_pages
 lr : alloc_pages
 sp : ffff8000597b70f0
 x29: ffff8000597b70f0 x28: ffff0801e68d34c0 x27: 0000000000000000
 x26: 1ffff0000b2f6ea2 x25: ffff8000597b7510 x24: 0000000000000dc0
 x23: ffff28cf80a61000 x22: 000000000000000e x21: 1ffff0000b2f6e28
 x20: 0000000000040dc0 x19: ffffdf670d4a6fe0 x18: ffffdf66fa017d1c
 x17: ffffdf66f42f8348 x16: 1fffe1003cd1a7b3 x15: 000000000000001a
 x14: 1fffe1003cd1a7a6 x13: 0000000000000004 x12: ffff70000b2f6e05
 x11: 1ffff0000b2f6e04 x10: 00000000f204f1f1 x9 : 000000000000f204
 x8 : dfff800000000000 x7 : 00000000f3000000 x6 : 00000000f3f3f3f3
 x5 : ffff70000b2f6e28 x4 : ffff0801e68d34c0 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
 Call trace:
  __alloc_pages
  alloc_pages
  kmalloc_order
  kmalloc_order_trace
  __kmalloc
  __regset_get
  regset_get_alloc
  fill_thread_core_info
  fill_note_info
  elf_core_dump
  do_coredump
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 irq event stamp: 3614
 hardirqs last  enabled at (3613):  _raw_spin_unlock_irqrestore
 hardirqs last disabled at (3614):  el1_dbg
 softirqs last  enabled at (2988):  fpsimd_preserve_current_state
 softirqs last disabled at (2986):  fpsimd_preserve_current_state
