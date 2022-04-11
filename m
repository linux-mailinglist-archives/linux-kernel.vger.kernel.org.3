Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501DD4FBED9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbiDKOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347458AbiDKOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:18:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E46140F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=83Xr824ZWe/+bYO/7xwxaSh67VlT2bCnejrGqyZ3RhE=; b=ExXjO1y8vLhYwwH/gqilmFGP4+
        whNFaISAjiRPLOaIWuw6lVbEIpc1yvh+i9t0L6cwy7IvEQSyXrsQ11DAJ+jTjLVbMBLVRxkoUzJQz
        dmalJUKxCerzORyj7j9AYYTs61jTztvoXjjhGKAvUhw72XekSZ/0aRqjIAryTS7WVdq+csmQsJfeP
        6eKsiqGxaaW+xYS8NLLYrdsZEW2KSXWco/ZP9BFBqyTmMYWNuFy4GcWobQCNoXIhRBjuUdOcDrVu/
        yJXLWb64YBf5BYVe39meMgy8koTN3R259u+j0Y4vY5dqkFZrHe2essxL1C1XjLHZvrDsPMpse4+yN
        bytyCfqA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndupZ-009L21-7Z; Mon, 11 Apr 2022 14:15:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 34/34] vfio/mdev: Remove mdev drvdata
Date:   Mon, 11 Apr 2022 16:14:03 +0200
Message-Id: <20220411141403.86980-35-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is no longer used, remove it.

All usages were moved over to either use container_of() from a vfio_device
or to use dev_drvdata() directly on the mdev.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mdev.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 1f6f57a3c3168..bb539794f54a8 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -15,7 +15,6 @@ struct mdev_type;
 struct mdev_device {
 	struct device dev;
 	guid_t uuid;
-	void *driver_data;
 	struct list_head next;
 	struct mdev_type *type;
 	bool active;
@@ -66,14 +65,6 @@ struct mdev_driver {
 	struct device_driver driver;
 };
 
-static inline void *mdev_get_drvdata(struct mdev_device *mdev)
-{
-	return mdev->driver_data;
-}
-static inline void mdev_set_drvdata(struct mdev_device *mdev, void *data)
-{
-	mdev->driver_data = data;
-}
 static inline const guid_t *mdev_uuid(struct mdev_device *mdev)
 {
 	return &mdev->uuid;
-- 
2.30.2

