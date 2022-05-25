Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A016B533FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiEYO71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbiEYO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:58:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23AAF1ED
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:58:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 6D1E11F450F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653490702;
        bh=iIq4Z4OE65fY1MUJxJmt36vci/mo0TrqzqbRmhmVVVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALVw3IlJ0zZ35sYa98XF05tNlJeyYalTzDhzbUAQ+yPCPe5EpdyligBS3ytbL5P2X
         ESgtBI6h821tZqo54pybiiWG7A6cFyHdgLOWrd9UmcT4ZDkv5KVg0qJ58FEXWKJVr2
         m2lXcGK++3Z5qX1eJ8WG6MMVDk6/Xm9UB+dyw7u4/zsrjlE3X2c7VqfGON92hnXtTs
         r0YYA62UPBZuDI3wrHNbQ5FUzkEtlily8FMHfNgKG4FrNyEIkykhig7v0EkcmALZNh
         bx3R8osuxeZYDkcBSReCZLDPWM+hDCTiHYkhfPSTl+QoAyjZh6x3DfWDd3MwYEhC1s
         XeHBXPsth+t6w==
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
Subject: [PATCH v2 6/9] drm/panfrost: Add "clean only safe" feature bit
Date:   Wed, 25 May 2022 10:57:51 -0400
Message-Id: <20220525145754.25866-7-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
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

Add the HW_FEATURE_CLEAN_ONLY_SAFE bit based on kbase. When I actually
tried to port the logic from kbase, trivial jobs raised Data Invalid
Faults, so this may depend on other coherency details. It's still useful
to have the bit to record the feature bit when adding new models.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
index 36fadcf9634e..1a8bdebc86a3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_features.h
+++ b/drivers/gpu/drm/panfrost/panfrost_features.h
@@ -21,6 +21,7 @@ enum panfrost_hw_feature {
 	HW_FEATURE_TLS_HASHING,
 	HW_FEATURE_THREAD_GROUP_SPLIT,
 	HW_FEATURE_IDVS_GROUP_SIZE,
+	HW_FEATURE_CLEAN_ONLY_SAFE,
 	HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG,
 };
 
-- 
2.35.1

