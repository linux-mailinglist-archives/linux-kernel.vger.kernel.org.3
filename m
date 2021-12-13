Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE94730B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhLMPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:38:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44444 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhLMPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:38:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FCA61151;
        Mon, 13 Dec 2021 15:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D29CC34602;
        Mon, 13 Dec 2021 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639409904;
        bh=eag2UJN8uLxpr82gnTwtWUePcV9ReC6aZJXhUT3jRh8=;
        h=From:To:Cc:Subject:Date:From;
        b=j0ro/ekfzYwTjuG2mlgInDcXWOwpgoNICvZ/Whyay6F7DMq2bvHyX2vNkXZ+NH7uJ
         D7rCmxc/02wPjol2Wk0QqyAc4WymR9H6rmvTIoR1xa1x+1TsAowl9EUvmLDb/4p4KJ
         c3Ysk0eRmDo8r6qOf0EX/dyzXGzgfhPIRu40mrZholqeGiGGvXHWK7rlUHKXEphYeV
         H0vexX/9v+7OLKcLPCexMdJqgKNaXV9evjpKQYC0mwQfJi9P2b6wEz39J+ftD3M/YR
         B6N/OC+OEbLfJbdVCxvAlv65iCszyd7h2uF2lRhRj/ppGVlq74znA43iyQRLd0zl8/
         NU91BdimjfHLw==
From:   broonie@kernel.org
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the etnaviv tree
Date:   Mon, 13 Dec 2021 15:38:20 +0000
Message-Id: <20211213153820.1588197-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the amdgpu tree, today's linux-next build (x86
allmodconfig) failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_set':
/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3248:20: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
 3248 |  adev->dm.dc->debug.set_mst_en_for_sst = val;
      |                    ^
/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_get':
/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3257:27: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
 3257 |  *val = adev->dm.dc->debug.set_mst_en_for_sst;
      |                           ^

Caused by commit

  99e574ca64d3b6 ("drm/amd/display: Add Debugfs Entry to Force in SST Sequence")

interacting with some of the other DRM trees.  Sadly this wasn't a new
version of the tree so it didn't flag up for several merges I've just
patched this out for now:

commit 0456e621ece3c28802799f3ed1f71a63af81960c
Author: Mark Brown <broonie@kernel.org>
Date:   Mon Dec 13 15:26:46 2021 +0000

    amdgpu: Patch out set_mst_en_for_sst
    
    This breaks the build in -next due to issues with another tree:
    
    /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_set':
    /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3248:20: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
     3248 |  adev->dm.dc->debug.set_mst_en_for_sst = val;
          |                    ^
    /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c: In function 'dp_force_sst_get':
    /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:3257:27: error: 'struct dc_debug_options' has no member named 'set_mst_en_for_sst'
     3257 |  *val = adev->dm.dc->debug.set_mst_en_for_sst;
          |
    
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 68c379ed12383..df3c615ed7943 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3237,30 +3237,6 @@ static int disable_hpd_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 			 disable_hpd_set, "%llu\n");
 
-/*
- * Force sst sequence in mst capable receiver.
- * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
- */
-static int dp_force_sst_set(void *data, u64 val)
-{
-	struct amdgpu_device *adev = data;
-
-	adev->dm.dc->debug.set_mst_en_for_sst = val;
-
-	return 0;
-}
-
-static int dp_force_sst_get(void *data, u64 *val)
-{
-	struct amdgpu_device *adev = data;
-
-	*val = adev->dm.dc->debug.set_mst_en_for_sst;
-
-	return 0;
-}
-DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
-			 dp_force_sst_set, "%llu\n");
-
 /*
  * Sets the DC visual confirm debug option from the given string.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
@@ -3346,8 +3346,6 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
-	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
-				&dp_set_mst_en_for_sst_ops);
 
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
