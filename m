Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948FE5650C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGDJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiGDJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867510E2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6FC613EA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D62AC341CE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926993;
        bh=/5JaPw4EUM5yVyAM4e0BWPzMra4rZmzapl5XeNJAS88=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aXLaGpkf+CXygbJstCby7cW82DNpvNZntZlRoR7B6Lt37q1nESmML8vmNx0EZ7pCt
         ajlcx+LCC4r8p2z/nfXIP/ZayR5qEDw8GWm/OZRj5wZxY7PW2s8HsQVGqMI0Rv3KVI
         VRe/m9Q8D6r0WDLgGVUdoyIc6EkfDZQwg4qZeLSepF/FHD1DtpV6ScsVkTojVayELH
         RMpGlujpLMzIUl8zrgxM38dtGLoeElnuIEoy537F3bWuTlYHvX2sbJNW8lso9sIdRc
         t/CwI5yNnSuDCmpFnjO+x2P2QHSRIbZQtND5Zzj6liVCc2F8wAu4Le9BoQRYEY+4mC
         9pVOvJL7GSC4g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] habanalabs: allow detection of unsupported f/w packets
Date:   Mon,  4 Jul 2022 12:29:35 +0300
Message-Id: <20220704092941.2237683-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we send a packet to the f/w, and that packet is unsupported, we
want to be able to identify this situation and possibly ignore this.

Therefore, if the f/w returned an error, we need to propagate it
to the callers in the result value, if those callers were interested
in it.

In addition, no point of printing the error code here because each
caller prints its own error with a specific message.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 04ca4aaee446..fd8dd332a59a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -327,11 +327,15 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 	rc = (tmp & CPUCP_PKT_CTL_RC_MASK) >> CPUCP_PKT_CTL_RC_SHIFT;
 	if (rc) {
-		dev_err(hdev->dev, "F/W ERROR %d for CPU packet %d\n",
-			rc,
-			(tmp & CPUCP_PKT_CTL_OPCODE_MASK)
-						>> CPUCP_PKT_CTL_OPCODE_SHIFT);
+		dev_dbg(hdev->dev, "F/W ERROR %d for CPU packet %d\n",
+			rc, (tmp & CPUCP_PKT_CTL_OPCODE_MASK) >> CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+		/* propagate the return code from the f/w to the callers who want to check it */
+		if (result)
+			*result = rc;
+
 		rc = -EIO;
+
 	} else if (result) {
 		*result = le64_to_cpu(pkt->result);
 	}
-- 
2.25.1

