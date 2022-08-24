Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47655A020A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiHXTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiHXTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:22:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337D6C745
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661368930; x=1692904930;
  h=from:to:cc:subject:date:message-id;
  bh=MVptU6GhFZMTidyLjYU8LrlEG2EhWu7IElQGwI91KoI=;
  b=OecIZ/n/DOVq3i3FCpzjj/jkf5JTUUxtuYpIH9TLqH5Gy3BDqkbCcQzG
   r4Pu/zA5fay/UTx+5FsitTtOAaBQqLdZPHlHJTH4nUQq8E1ilcI8H5eLD
   UMFQmgRop8C4gcpeOFZrSOpWp4E8vG9ycXyKndSDQyhNqjHM5QpdIdybP
   qhvo0268/ccwxHp/rHt1pkOHZDUa/A6txlFM2spkO1pV5StrTdC5tbuXt
   yYHwX/xLC/uAgp6/rU9XMz8Y50w6jVLutuurwluNE69Kd68bBkNk1FzVg
   8szn4I1q6pMJ/I7Vb2pzGnKz1eBYdB6HPkH5INK9uJB7zUDLzeWXfeBEE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292801031"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292801031"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="606140552"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 12:22:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 0/3] x86/fpu: Improve the init_fpstate setup code
Date:   Wed, 24 Aug 2022 12:12:20 -0700
Message-Id: <20220824191223.1248-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set of patches fixes the init_fpstate code. So this first version is
sent to the maintainers hoping the fix is reviewable.

Thanks,
Chang

== Background ==

The init_fpstate is an XSAVE image that records init states during the boot
time. It is presumed to cover all the supported and enabled features. The
setup code has been recently optimized to capture legacy states only as all
of the other init states are all zeros.

== Problem with AMX state ==

When AMX is enabled, this buffer is too small to include AMX TILE_DATA
(8KB) as it is statically allocated with about a page. But, the buffer is
formatted to have them all although using the compacted format.

This also leads to a noisy splat with XRSTORS as it expects all the buffer
memory accessible. This is mentioned in Intel SDM Vol.1 13.13 Memory Access
By The XSAVE Feature Set:
    "An execution of an instruction in the XSAVE feature set may access any
     byte of any state component on which that execution operates."

== Other minor issues ==

The existing sanity check could help finding this issue as it checks
whether the allocated init_fpstate is enough for the expected size or not.
But what is currently measured is not matched -- the size without the AMX
state.

Also, these size and features are better to be configured first before
setting up the init image.

== Patchset ==

As AMX requires the compacted format, init_fpstate may exclude dynamic
states. The series also includes other improvments:
* Set up the init_fpstate buffer after its scope is clarified.
* Fix the size that is validated against the static allocation.

Chang S. Bae (3):
  x86/fpu: Configure init_fpstate attributes orderly
  x86/fpu: Fix the init_fpstate size check with the actual size
  x86/fpu: Exclude dynamic states from init_fpstate

 arch/x86/kernel/fpu/init.c   |  8 --------
 arch/x86/kernel/fpu/xstate.c | 33 ++++++++++++++-------------------
 2 files changed, 14 insertions(+), 27 deletions(-)


base-commit: cf90f46223eef9d5f389b4b88ee2fc7914458b06
-- 
2.17.1

