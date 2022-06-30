Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7A5623D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiF3UGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiF3UGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:06:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319444757
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:06:29 -0700 (PDT)
Received: from dimapc.. (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97EEF660196E;
        Thu, 30 Jun 2022 21:06:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656619588;
        bh=xsvNmDMcGVOkoQTugF/axTWFHna4KKvMOUF9W1Ml/Ts=;
        h=From:To:Cc:Subject:Date:From;
        b=he14SaaKl2bzQgvd1kFoJEyysf31ZtW+VEza3/RtUAROyqjVLuzgHz4E/Ht1kmMRU
         I6Ypda7X+uAYmUuwmdnG+8aDEO0lzhMNiNmaXdulb0AyrQ+iLSlL6b5PWl2p6u6mnH
         e54mCVnjgwmn2I4lgavXrBkeIgOw4ckqDs/F+8tb9CCwvfX5oJZCuNCygdekOz7IW8
         XMDdYkRl/c+Aujg+GKjIZ7F+LRDIjS7Xd8J3Xlc2aCoDYCjCubDpGNAagYCoMg5Jan
         +mssW5cc9NW1vaLhhACKIWFHcySbG++8cWhXpmf67j425rwIptqL/vElc46C60nK03
         6zErqHhqeytpg==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
Subject: [PATCH v7 0/2] Panfrost driver fixes
Date:   Thu, 30 Jun 2022 23:05:59 +0300
Message-Id: <20220630200601.1884120-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two minor bugs in the Panfrost driver.

Changelog:

v7: - Factored out Panfrost fixes from [1] since I'll be working on
      the dma-buf locking in a separate patchset now.

[1] https://lore.kernel.org/all/20220526235040.678984-1-dmitry.osipenko@collabora.com/

Dmitry Osipenko (2):
  drm/panfrost: Put mapping instead of shmem obj on
    panfrost_mmu_map_fault_addr() error
  drm/panfrost: Fix shrinker list corruption by madvise IOCTL

 drivers/gpu/drm/panfrost/panfrost_drv.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.36.1

