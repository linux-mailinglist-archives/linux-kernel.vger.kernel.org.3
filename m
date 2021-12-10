Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB04470A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245566AbhLJTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:18:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36494 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245462AbhLJTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:18:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFCE0B829CC;
        Fri, 10 Dec 2021 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7904C341C7;
        Fri, 10 Dec 2021 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163714;
        bh=1NlUhBKnQElZpjb9gRt5/U5B5hvPQ3wTIzrxzhvwqOw=;
        h=From:To:Cc:Subject:Date:From;
        b=oc4gvzVqehY+m4pTLe8NwPhYD9uvmuaNAUM2wTR7OKet5fQQMIC0G/JdgMdIK1WjY
         nNSPYXKXtXTofuQrCK0cGf7MBSGdSUUQhIty9xckmmLWi2ATSXLzinJlSGMG5ia3W/
         GQMiEb29Y5pRMRiGP6C2iFAkhKQ67eBEETT5X9FboYyp7UM7vJRm25IgpR5w8CU44b
         T7qTVA6FgnFIe9migAjNVOoIdlo99MR4R8NeypL3GqGFRujWQ2dm4sGu/SQXotxaBU
         Ho/wMzkcYqQfdk0OZ0t6z+VH4GTQN+WRKOxWxWPxhIRyEddc+4sjWHspPXOVVmjeOR
         npbPpjmWZnzFg==
From:   broonie@kernel.org
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the bitmap tree with the kvm tree
Date:   Fri, 10 Dec 2021 19:15:05 +0000
Message-Id: <20211210191505.1030264-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  arch/s390/kvm/kvm-s390.c

between commit:

  a54d806688fe1 ("KVM: Keep memslots in tree-based structures instead of array-based ones")

from the kvm tree and commit:

  523f4c8e86c3f ("all: replace find_next{,_zero}_bit with find_first{,_zero}_bit where appropriate")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/s390/kvm/kvm-s390.c
index dd099d3527533,59459960ec3a0..0000000000000
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@@ -1988,9 -2016,10 +1988,9 @@@ static unsigned long kvm_s390_next_dirt
  		ofs = 0;
  	}
  	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
 -	while ((slotidx > 0) && (ofs >= ms->npages)) {
 -		slotidx--;
 -		ms = slots->memslots + slotidx;
 +	while (ofs >= ms->npages && (mnode = rb_next(mnode))) {
 +		ms = container_of(mnode, struct kvm_memory_slot, gfn_node[slots->node_idx]);
- 		ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, 0);
+ 		ofs = find_first_bit(kvm_second_dirty_bitmap(ms), ms->npages);
  	}
  	return ms->base_gfn + ofs;
  }
