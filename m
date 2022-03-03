Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218BA4CC6E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiCCUON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCCUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35883BF945;
        Thu,  3 Mar 2022 12:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC524B826D7;
        Thu,  3 Mar 2022 20:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E3C340F3;
        Thu,  3 Mar 2022 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338398;
        bh=g7HEXU1edCJeEuz6s3HW4755ffa012L25T8MW/aD5Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niESzphuotFbUU6f1ED2hUOlhkI4P2+lTiecEF1INmxc8xQDrx0zmTMAWAnci4t3i
         PBSx79kgrocHEcXsJFoLemjIFV6/AbkJCd7sgxaQDOQvphDH+Z455Nl5lCGwATFm8E
         1lGYfU9q+YsatInm3A4ihGye8ZVmR3UZCtQHyww9vtOYUY5zYBRKiOZ5t3ju5t9/5B
         dUX/E1xc4+Q2hCvAQGbGyv7/f0F1YCAzwa3C4glYuWrTYwQBcEOfwNfslH6KnuMHxL
         pKo0XXVPkATWjpOyYH3ohKWnHqyU/TJEjSPrLYs9tub/xUGRXun5QsZdRjWLJJuyno
         RWUpMh5Trz8Fw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 2/8] nvme: allow integrity on extended metadata formats
Date:   Thu,  3 Mar 2022 12:13:06 -0800
Message-Id: <20220303201312.3255347-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block integrity subsystem knows how to construct protection
information buffers with metadata beyond the protection information
fields. Remove the driver restriction.

Note, this can only work if the PI field appears first in the metadata,
as the integrity subsystem doesn't calculate guard tags on preceding
metadata.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ace8c61850b1..ace5f30acaf6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1754,12 +1754,9 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
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

