Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2F58CAE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbiHHO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbiHHO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519CEB1F6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659970653; x=1691506653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGF9ZvLWxny2IyMvhFj9EY7L6o3JSecFMpYExyr+FLo=;
  b=M9JNaku+ldOhTMtXuy7FID4NC47FO06OgtXXl12pKRdgcmE8fahtnreK
   naK43dgNdYlSgicdYDSvuu3mUs2wymjCxrRIngqF3HqUiE6Np+LGK837j
   ROUUYQYHLFC4u2U7o9RYQ2rsv8GwEMNBVInj36p2Nj6Fk8SxluEIKd4+V
   NlmvYiuce1HPRYlDE8tRt5fJNgrC8blwBBCe8+utZDjMUHDJpOkuawYdE
   FhFcqBr4OoqoSk/5g7l8uzHNy2EqOuUnSy1EogklWicthaOF3lDlWOfNB
   zprhs5S+HWIMnWz80sL2DSSA+mRnUK7DjtkiXC1Yir3pKkYU6FgkSkTGA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270996882"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270996882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663980478"
Received: from ziqianlu-desk2.sh.intel.com ([10.238.2.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:30 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever possible
Date:   Mon,  8 Aug 2022 22:56:45 +0800
Message-Id: <20220808145649.2261258-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an early RFC. While all reviews are welcome, reviewing this code
now will be a waste of time for the x86 subsystem maintainers. I would,
however, appreciate a preliminary review from the folks on the to and cc
list. I'm posting it to the list in case anyone else is interested in
seeing this early version.

Dave Hansen: I need your ack before this goes to the maintainers.

Here it goes:

On x86_64, Linux has direct mapping of almost all physical memory. For
performance reasons, this mapping is usually set as large page like 2M
or 1G per hardware's capability with read, write and non-execute
protection.

There are cases where some pages have to change their protection to RO
and eXecutable, like pages that host module code or bpf prog. When these
pages' protection are changed, the corresponding large mapping that
cover these pages will have to be splitted into 4K first and then
individual 4k page's protection changed accordingly, i.e. unaffected
pages keep their original protection as RW and NX while affected pages'
protection changed to RO and X.

There is a problem due to this split: the large mapping will remain
splitted even after the affected pages' protection are changed back to
RW and NX, like when the module is unloaded or bpf progs are freed.
After system runs a long time, there can be more and more large mapping
being splitted, causing more and more dTLB misses and overall system
performance getting hurt[1].

For this reason, people tried some techniques to reduce the harm of
large mapping beling splitted, like bpf_prog_pack[2] which packs
multiple bpf progs into a single page instead of allocating and changing
one page's protection for each bpf prog. This approach made large
mapping split happen much fewer.

This patchset addresses this problem in another way: it merges
splitted mappings back to a large mapping when protections of all entries
of the splitted small mapping page table become same again, e.g. when the
page whose protection was changed to RO+X now has its protection changed
back to RW+NX due to reasons like module unload, bpf prog free, etc. and
all other entries' protection are also RW+NX.

One final note is, with features like bpf_prog_pack etc., there can be
much fewer large mapping split IIUC; also, this patchset can not help
when the page which has its protection changed keeps in use. So my take
on this large mapping split problem is: to get the most value of keeping
large mapping intact, features like bpf_prog_pack is important. This
patchset can help to further reduce large mapping split when in use page
that has special protection set finally gets released.

[1]: http://lkml.kernel.org/r/CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com
[2]: https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/

Aaron Lu (4):
  x86/mm/cpa: restore global bit when page is present
  x86/mm/cpa: merge splitted direct mapping when possible
  x86/mm/cpa: add merge event counter
  x86/mm/cpa: add a test interface to split direct map

 arch/x86/mm/pat/set_memory.c  | 411 +++++++++++++++++++++++++++++++++-
 include/linux/mm_types.h      |   6 +
 include/linux/page-flags.h    |   6 +
 include/linux/vm_event_item.h |   2 +
 mm/vmstat.c                   |   2 +
 5 files changed, 420 insertions(+), 7 deletions(-)

-- 
2.37.1

