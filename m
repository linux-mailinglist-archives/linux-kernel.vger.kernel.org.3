Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F44C4AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiBYQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiBYQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:38:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B025BD1C;
        Fri, 25 Feb 2022 08:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A14AB83281;
        Fri, 25 Feb 2022 16:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2B9C340E7;
        Fri, 25 Feb 2022 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645807072;
        bh=dRaPP8U/qTouq/QANC7IxWpVYFkRYB9CeMb80MzSHhk=;
        h=From:To:Cc:Subject:Date:From;
        b=Vf69LTEOSafT8UIUHydSmL5goIF3wOUmpFO31AQYB5oJbw7Rj9odEjyRadWBN6ery
         J2HiB7MOxCc7Bmago6rwxetuKUcBDSX9MqhBdCOCnVpkFTX2vyJsxZ3wnhJTJNhqy5
         mGh+HPKOsbLDLF/8B1AICFiV2CBCjT6VerROgKyK6zYnDtp0yLBuYg7jtkAGvDsFb7
         e4j17/59RU/+XMHpa2tiNV4BhUizfk5OeggdVf+y3dJlYDpKqBvIuEUjB0Rd7U9/hA
         eFO39VhRcyGtqOfRrzIuX85Yj6qU7bAsFyK6u3ouiuDz/50aYfbrSd02VFHTofN4qA
         c6njHZguMFh7A==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Leslie Shi <Yuliang.Shi@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tomohito Esaki <etom@igel.co.jp>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Date:   Fri, 25 Feb 2022 16:37:47 +0000
Message-Id: <20220225163747.888284-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c

between commit:

  e2b993302f40c ("drm/amdgpu: bypass tiling flag check in virtual display case (v2)")

from the drm-fixes tree and commit:

  2af104290da5e ("drm: introduce fb_modifiers_not_supported flag in mode_config")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c4387b38229c2,9e5fc4cdb8ec9..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@@ -1141,7 -1148,7 +1148,7 @@@ int amdgpu_display_framebuffer_init(str
  	if (ret)
  		return ret;
  
- 	if (!dev->mode_config.allow_fb_modifiers && !adev->enable_virtual_display) {
 -	if (dev->mode_config.fb_modifiers_not_supported) {
++	if (dev->mode_config.fb_modifiers_not_supported && !adev->enable_virtual_display) {
  		drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
  			      "GFX9+ requires FB check based on format modifier\n");
  		ret = check_tiling_flags_gfx6(rfb);
