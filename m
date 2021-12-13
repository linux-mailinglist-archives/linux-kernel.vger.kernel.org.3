Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB154473227
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhLMQp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhLMQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:45:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC1C061574;
        Mon, 13 Dec 2021 08:45:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22706B80D99;
        Mon, 13 Dec 2021 16:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7604DC34603;
        Mon, 13 Dec 2021 16:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639413923;
        bh=hKfqmXe6u4vNjyIrgd9Gkjmd3Ni7szyFVG5wQnl5oLY=;
        h=From:To:Cc:Subject:Date:From;
        b=lUQpY1CsJ10ZBzipX6FV82UeH4d9wyOBYeC0bkYyTUM9xqtBJN1JYUXJnxl8k1kX1
         C8rJrh9KDhq7LUS1Zha7Ve246SkHxMK/dowATpW/0tjWBzi9EkEOJGpJx90nQysvKz
         6PmehDlAwPusHrmfRRVCdx3QEBzs/sD5WbgRVHqXVYbXCv1lkbHsX2zjcdVxbQCMCC
         9WlKxiPgke4pf0gFNs0Np2yItU09iHMo3zYJTC5SWWJlryIhqNw59fbGnhhMmJnQZp
         VF5+mArLxCJGv/cuKHCvshWdGVoCGWzewagDKM2RQ+dbk0wR2hSCHpmMPcnhYSLvZ8
         PNQMWXTtUyYOA==
From:   broonie@kernel.org
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: linux-next: manual merge of the tip tree with the arm64 tree
Date:   Mon, 13 Dec 2021 16:45:16 +0000
Message-Id: <20211213164517.3393671-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/arm64/kernel/perf_callchain.c

between commit:

  ed876d35a1dc7 ("arm64: Make perf_callchain_kernel() use arch_stack_walk()")

from the arm64 tree and commit:

  1c3430516b073 ("perf: Add wrappers for invoking guest callbacks")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/kernel/perf_callchain.c
index e9b7d99f4e3a0,db04a55cee7e0..0000000000000
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@@ -141,7 -147,9 +141,7 @@@ static bool callchain_trace(void *data
  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
  			   struct pt_regs *regs)
  {
- 	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
 -	struct stackframe frame;
 -
+ 	if (perf_guest_state()) {
  		/* We don't support guest os callchain now */
  		return;
  	}
