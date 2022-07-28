Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5F584599
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiG1SXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiG1SXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:23:05 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5476453
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:23:03 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtzXk5GYRzDrtL;
        Thu, 28 Jul 2022 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659032582; bh=UINbQvXcI1FsUTHFriHZVm7J1aYZVSly8vzBah8t+ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTgXja8l8EkLnYiY4mTSFc7sq5jrX1rtY87BtaLZYeNO8SGrBLhtc+57UgzjicO0v
         eIj1Y9W3tqEDDVh7winLELMY8MvjT7RylNRzKNMrqbgIqcmog39sy0Xg9CN40etQKB
         8xCTtBBEYROzrhN1QgrjMvVLept55Y9aWfJfpjLY=
X-Riseup-User-ID: DC7D5CED6CB005C5FDCF5AB464E3A71DB77546D43C03F1E4122D7B0665C25759
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXd258tz5vTb;
        Thu, 28 Jul 2022 18:22:56 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 12/16] drm/amd/display: Remove NumberOfDP2p0Support VBA variable
Date:   Thu, 28 Jul 2022 15:20:44 -0300
Message-Id: <20220728182047.264825-13-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NumberOfDP2p0Support variable from the struct vba_vars_st is
only used on assignments, so its value is not used on code. So,
remove the NumberOfDP2p0Support entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h          | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 6d4907656f9f..3c044549c95f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2186,8 +2186,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	mode_lib->vba.NumberOfOTGSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG <= mode_lib->vba.MaxNumOTG);
 	mode_lib->vba.NumberOfHDMIFRLSupport = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveHDMIFRL <= mode_lib->vba.MaxNumHDMIFRLOutputs);
-	mode_lib->vba.NumberOfDP2p0Support = (v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 <= mode_lib->vba.MaxNumDP2p0Streams
-			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0Outputs <= mode_lib->vba.MaxNumDP2p0Outputs);
 
 	/* Display IO and DSC Support Check */
 	mode_lib->vba.NonsupportedDSCInputBPC = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 31cf144860b9..f973d0ee82f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -754,7 +754,6 @@ struct vba_vars_st {
 	bool DCCProgrammingAssumesScanDirectionUnknownFinal;
 	bool EnoughWritebackUnits;
 	bool ODMCombine2To1SupportCheckOK[DC__VOLTAGE_STATES];
-	bool NumberOfDP2p0Support;
 	unsigned int MaxNumDP2p0Streams;
 	unsigned int MaxNumDP2p0Outputs;
 	enum dm_output_type OutputTypePerState[DC__VOLTAGE_STATES][DC__NUM_DPP__MAX];
-- 
2.37.1

