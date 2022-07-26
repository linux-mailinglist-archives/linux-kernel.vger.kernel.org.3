Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D195819A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiGZSXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbiGZSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:23:14 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937A32B96
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fufhIgAGmEPr2y0gVTawBxYZsHer/zgSvMgFNkAzwAo=; b=Ioq29zwDPkae9RKQm0zTORcfp3
        0ZEsHxkp5sJawQ//sCkaOmzL/5+u5dk1o35WMjEIiVqHVuuoglglzRbxHNv/J4L3LCuyQLhey1iR8
        +GA1c+gocBUbrQxuvz4GUL16kLMFX+HnyqVD4+IuumUycVIetU2WlcV1vjV/fJqjIXuFuMLvlDyG1
        unw87/ucyfzu2PZ/qvaxx/4tM4ximU0qD1V8kfpjtawZVArwvHMBOdaP9aQvDFi1uu1bxavQ8z2S4
        L5bmsB30EkLGB+HKJ1+pjwl2eZ+0wvwmYrNrsYbwGjkYPjJLDAuZ0bV9kJYnfaX/FzeOXhcAjrIub
        7xyqEQuA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oGPCZ-007aEh-BE; Tue, 26 Jul 2022 20:22:39 +0200
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
Subject: [PATCH v2 0/4] drm/amd: Add more GFXOFF stats for vangogh
Date:   Tue, 26 Jul 2022 15:21:48 -0300
Message-Id: <20220726182152.123649-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  35 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  22 +++
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |   5 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  92 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 13 files changed, 443 insertions(+), 8 deletions(-)

-- 
2.37.1

