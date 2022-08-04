Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C7A589880
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiHDHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiHDHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:37:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20A5FAED;
        Thu,  4 Aug 2022 00:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B947B824A8;
        Thu,  4 Aug 2022 07:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BCDC433D6;
        Thu,  4 Aug 2022 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659598649;
        bh=WCCCi7+K04HSk34cpQtOannRRuatd2BnFuBrKl96JQY=;
        h=From:To:Cc:Subject:Date:From;
        b=iXEh8yK5mnllftkRpyNpPnBhdIyexLOhqftRLlEu/JYtYLlQ9oXjqiBFbB/bAQfZZ
         kmQjCEoNtgTu+dhzCVc703jzve/2M8cRaK5XqCp29U7dE6UvAkQNAmTzVQDsB2yCfQ
         zSCeXWbfTQWVwUL2RNDbHqUcPcwcAQDuFumSbisxy37/At0lpMv3S44RnUO1hTlhkE
         ZiHCcc1VNRr6/ND7llMF1nub3mDzfoqsjMKpM8gHwBlJktsvtlKxK/EcR0KT6pxJyC
         6e6DLggeDRkgkpWRQQBq6AnlcoN+cYyui4IRe9fe31jzo/XHoTX5xFum2LrmG9Jnfm
         6TS/PGXgw7jGw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oJVQ6-0017HL-L8;
        Thu, 04 Aug 2022 09:37:26 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Move TLB invalidation code for its own  file and document it
Date:   Thu,  4 Aug 2022 09:37:21 +0200
Message-Id: <cover.1659598090.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more things to be added to TLB invalidation. Before doing that,
move the code to its own file, and add the relevant documentation.

Patch 1 fixes vma_invalidate_tlb() logic to make it update the right var;

Patch 2 only moves the code and do some function renames. No functional
change;

Patch 3 adds documentation for the TLB invalidation algorithm and functions.

---

v3: 
  - Added a fix for an issue from the last TLB patch series;
  - included a better description about the changes on patch 2;
  - did some minor fixes at kernel-doc markups;

v2: only patch 2 (kernel-doc) was modified:

  - The kernel-doc markups for TLB were added to i915.rst doc;
  - Some minor fixes at the texts;
  - Use a table instead of a literal block while explaining how the algorithm works.
    That should make easier to understand the logic, both in text form and after
    its conversion to HTML/PDF;
  - Remove mention for GuC, as this depends on a series that will be sent later.



Chris Wilson (1):
  drm/i915/gt: Move TLB invalidation to its own file

Mauro Carvalho Chehab (2):
  drm/i915: pass a pointer for tlb seqno at vma_invalidate_tlb()
  drm/i915/gt: document TLB cache invalidation functions

 Documentation/gpu/i915.rst                |   7 +
 drivers/gpu/drm/i915/Makefile             |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt.c        | 168 +----------------
 drivers/gpu/drm/i915/gt/intel_gt.h        |  12 --
 drivers/gpu/drm/i915/gt/intel_ppgtt.c     |   2 +-
 drivers/gpu/drm/i915/gt/intel_tlb.c       | 208 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h       | 128 +++++++++++++
 drivers/gpu/drm/i915/i915_vma.c           |   7 +-
 drivers/gpu/drm/i915/i915_vma.h           |   2 +-
 10 files changed, 355 insertions(+), 184 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.h

-- 
2.37.1


