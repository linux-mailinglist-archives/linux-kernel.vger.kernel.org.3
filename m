Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D74A6478
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbiBATBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiBATBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:01:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B57C061714;
        Tue,  1 Feb 2022 11:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCD0EB82F6E;
        Tue,  1 Feb 2022 19:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45A5C340F2;
        Tue,  1 Feb 2022 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643742093;
        bh=VRyH49oabNK9tq5d8ITbMCbDVSNwxXXmYIC92KD8pAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi+UTk5gKsIOw6y/x5rzHWQN/dnuO/rcJ2Xny2s+2Q88W0N8SybiTPxqM2DK7/24v
         oc/3jbMdTQsoMiKdWMxWYVug5ow3HaLAUjFRczq7DhXBMLgmVYgqlGG7GzGug2KnPL
         QMIK3GC9JD7b2hkx+iWsEuDTTJ9VWjJkHm/KlN90BXsGZMzDLbHaTGTXnwICBQFsAp
         3ntQ6T9fgHXAf9+1oLBj6GojrZacR5vN2aX5zv91rESdRcNN7/ch++E5T2Ny111EC6
         yzKSfynwDKOzwRKqAn8Zn/scTeWnqa39hGJMBEGczewg6o3A2HNtN83ohpkyX0pDCm
         JWJht0H1Jfp6Q==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/7] nvme: allow integrity on extended metadata formats
Date:   Tue,  1 Feb 2022 11:01:23 -0800
Message-Id: <20220201190128.3075065-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220201190128.3075065-1-kbusch@kernel.org>
References: <20220201190128.3075065-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block integrity subsystem knows how to construct protection
information buffers with metadata beyond the protection information
fields. Remove the driver restriction.

Note, this can only work if the PI field appears first in the metadata,
as the integrity subsystem doesn't calculate guard tags on preceding
metadata.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..b3eabf6a08b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1726,12 +1726,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
-	/*
-	 * The PI implementation requires the metadata size to be equal to the
-	 * t10 pi tuple size.
-	 */
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (id->dps & NVME_NS_DPS_PI_FIRST ||
+	    ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
-- 
2.25.4

