Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594E533FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiEYO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiEYO6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:58:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5C6C0FE
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:58:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id E979D1F450F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653490685;
        bh=9bRShdzh+eFKzI1iX/FrVehRhjCGpbUYT7uXkboDLFA=;
        h=From:To:Cc:Subject:Date:From;
        b=ff9drY7INcYIJup2RVvMPpszBqC32CT5ohYQyiXUkCP8LNum6WAjATumWLGFHa2sb
         TYwtNWK46RuqmcOypV9L9Yq4zzPDhPG5dIeeS1QEGl5ICTAuaVBPoZXf+zAeHkaCvB
         VA9M4ph/jpmJc0S1lkku7xMWWNi3E6MKm/1U5PLtRPZXcPE4W6WzkiOFnN2BEUrUoi
         l+dfbatSu2qZwLdKpb4vosiG93X/h6nJIglT3TkdXU+KZ5NDwfIYwxzlgN5/udwZcI
         Bk2ekki8HjOFhXDX5HkPvh+NUujpo6qKjANFpmXY8W0U2nqGx6XsauFVdN63o2SAsd
         sgdTg9IKruY8A==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] drm/panfrost: Valhall (JM) support
Date:   Wed, 25 May 2022 10:57:45 -0400
Message-Id: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is version 2 of the series adding support for job manager Valhall
(v9). CSF Valhall is not supported in this series. The core
issues/features are added for Mali-G57 "Natt" as the current target.
Natt is used in MT8192, which needs a few extra patches to follow
(currently blocked on MediaTek integration issues.)

In terms of userspace, Mesa has almost all the required code for GLES3.1
conformance and is just missing a few patches to merge for remaining
features.

v2 addresses minor issues found in v1, but no major changes.

Alyssa Rosenzweig (9):
  dt-bindings: Add compatibles for Mali Valhall GPU
  drm/panfrost: Handle HW_ISSUE_TTRX_2968_TTRX_3162
  drm/panfrost: Constify argument to has_hw_issue
  drm/panfrost: Handle HW_ISSUE_TTRX_3076
  drm/panfrost: Add HW_ISSUE_TTRX_3485 quirk
  drm/panfrost: Add "clean only safe" feature bit
  drm/panfrost: Don't set L2_MMU_CONFIG quirks
  drm/panfrost: Add Mali-G57 "Natt" support
  drm/panfrost: Add arm,mali-valhall-jm compatible

 .../bindings/gpu/arm,mali-bifrost.yaml        | 53 +++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_device.c    |  9 +++-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  1 +
 drivers/gpu/drm/panfrost/panfrost_features.h  | 13 +++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c       | 18 +++----
 drivers/gpu/drm/panfrost/panfrost_issues.h    | 21 +++++++-
 drivers/gpu/drm/panfrost/panfrost_regs.h      |  1 +
 7 files changed, 91 insertions(+), 25 deletions(-)

-- 
2.35.1

