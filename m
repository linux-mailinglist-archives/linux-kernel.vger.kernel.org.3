Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7E583EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiG1MaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiG1MaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0A38B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5369161CB5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3E6C4347C;
        Thu, 28 Jul 2022 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659011406;
        bh=SsLKQKAJDVdmsjFvuEvNTnovowDQ9E5EcEd8pA4PGds=;
        h=From:To:Cc:Subject:Date:From;
        b=mloeqN3p2gVVuWZfpt5whWnuCmI19/IGx+lB3YAP9QC2uQ9mKtcWA5MmRci4SBSnN
         A3242ZO939pfOZe9CPGwbXZCHdqcNCuV/SZ1+S+qsuX/jaSRFn6EsOUSfpb+LmQ+qX
         2l5TZNOMRRqcvej1lT+UsIv1SRxCIDExrXx4+Q768jnUGg8aWA3zeCDxS2vagMcKUn
         Xywkd6UGWYKC3d2ACZqwNF5QAGE+jskhS3rzxHFhk/RCOqVqWR0GBXLrOxzM68XUnw
         F9qmxPYJm02Eg34hB/Suee44VQfh9aowrLaeoUPi4AKcE+dW9406ggSPzTA0NG+dRk
         +Nm/Yx0iVAleg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oH2eS-005W6T-95;
        Thu, 28 Jul 2022 14:30:04 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Move TLB invalidation code for its own file and document it
Date:   Thu, 28 Jul 2022 14:30:01 +0200
Message-Id: <cover.1659011328.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Chris Wilson (1):
  drm/i915/gt: Move TLB invalidation to its own file

Mauro Carvalho Chehab (1):
  drm/i915/gt: document TLB cache invalidation functions

 drivers/gpu/drm/i915/Makefile             |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt.c        | 168 +----------------
 drivers/gpu/drm/i915/gt/intel_gt.h        |  12 --
 drivers/gpu/drm/i915/gt/intel_tlb.c       | 208 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_tlb.h       | 112 ++++++++++++
 drivers/gpu/drm/i915/i915_vma.c           |   1 +
 7 files changed, 327 insertions(+), 179 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_tlb.h

-- 
2.36.1


