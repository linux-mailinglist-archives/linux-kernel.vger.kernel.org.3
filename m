Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BD5AB168
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiIBN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiIBN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:29:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FEB116E2C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A660FB82AC7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2882C433C1;
        Fri,  2 Sep 2022 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662123683;
        bh=2Bz/efN2/mg1731d5K4pjKr79RYPaHO217/mHswxl4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=K/WL4KZPAlSuht5rqlHSv5eY4DFfjY9gDUj2mqBn+KnYx0byowdhu2Z25fx2k1FIA
         a6njcrtpRvGUnLQvKBi1UYfAdwHkiegRVUWv3hvrplGcuMR0Zwd+CWhyD86w94wKIn
         N22QsLhhAWrCcwkNn6uKjfUf859qv1iWPTxzvoCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng^Ci@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deuc her <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Thelford Williams <tdwilliamsiv@gmail.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Yongzhi Liu <lyz_cs@pku.edu.cn>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix memory leak when using debugfs_lookup()
Date:   Fri,  2 Sep 2022 15:01:05 +0200
Message-Id: <20220902130105.139138-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=gregkh@linuxfoundation.org; h=from:subject; bh=2Bz/efN2/mg1731d5K4pjKr79RYPaHO217/mHswxl4Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmC/yZsOu+8L1Mx8IXV1LtsrzJY/ZoOyKvVmH27M98zdcG9 uSo/OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi0fIMC9Zfmp9y7XLhBFaZa0Kzdc U3nHD0UmSY7/s/eFtrCMv55BPFc1lj7uS9ETn4EQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  Fix this up by properly
calling dput().

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: hersen wu <hersenxs.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thelford Williams <tdwilliamsiv@gmail.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0e48824f55e3..ee242d9d8b06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3288,6 +3288,7 @@ void crtc_debugfs_init(struct drm_crtc *crtc)
 				   &crc_win_y_end_fops);
 	debugfs_create_file_unsafe("crc_win_update", 0644, dir, crtc,
 				   &crc_win_update_fops);
+	dput(dir);
 #endif
 	debugfs_create_file("amdgpu_current_bpc", 0644, crtc->debugfs_entry,
 			    crtc, &amdgpu_current_bpc_fops);
-- 
2.37.3

