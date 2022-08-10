Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7558F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiHJX3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHJX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:29:31 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34887D1C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=trpvDn0+SZq7Zkk7eCQdxdRcpW9rsYFD/1VFwj3Zdf4=; b=j340UABcm1SyDMioPS/h0TXS0L
        XQwzgOZL/h6Kn1nUAO1jRoc912cGWUV6fCaLHGAXUNCKaokTkf7Yu2zVc1Z33aIJCdDuGLnfUCaKv
        iOxBGDtLcKMWsY6zE5rVnx3mXzcs+Xr6HwB3muSmZTAwHOnlBI+wix25zcLyOnVJxiE17UENhVoWZ
        K6YHVTVm1fJqYVDz8QV3azK5P83HblyHOuFrKT8xp9JDaN8a9lG7x60HXpD7UMB1bQQUVZVeVS7Di
        jhiQ4bZxqc3v2TI8UiCMVMMRoylqObO8hNx80ldRV98vVyteuBrFXJ0szLmFBXsPWAnHNLLW/6w2Y
        wPAelV0g==;
Received: from [191.17.41.12] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oLv8b-004r9g-6e; Thu, 11 Aug 2022 01:29:21 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 0/4]  drm/amd: Add more GFXOFF stats for vangogh
Date:   Wed, 10 Aug 2022 20:28:54 -0300
Message-Id: <20220810232858.11844-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new logging features for GFXOFF available for vangogh
and documentation for it.

I've created a small userspace program to interact with this new debugfs
interface and it can be found at: 

https://gitlab.freedesktop.org/andrealmeid/gfxoff_tool

Changelog:
 v3:
 - drop IP version check

 v2:
 - Make entrycount uint64_t
 - Add a note in docs about data types and overflow

André Almeida (4):
  drm/amd: Add detailed GFXOFF stats to debugfs
  drm/amd/pm: Implement GFXOFF's entry count and residency for vangogh
  Documentation/gpu: Document GFXOFF's count and residency
  drm/amdgpu: Document gfx_off members of struct amdgpu_gfx

 Documentation/gpu/amdgpu/thermal.rst          |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 168 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  39 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  14 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  45 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  33 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  22 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  77 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 13 files changed, 427 insertions(+), 7 deletions(-)

-- 
2.37.1

