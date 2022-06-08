Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2405430CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiFHMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiFHMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:43 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1DC1AB635;
        Wed,  8 Jun 2022 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692580; x=1686228580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x27CnnubEwiDkgkFSluZiZEU6Sh9SnhgeRxl3MbhV54=;
  b=aM9HxWbEK0gtJ+pfI47tOzp+SyTUa16QE3BN960fkrhp7rTRHMKlyWf2
   qMGRiR1/wglfabz77KJJamxRke1YD4Yr97rtULAHQ0l6YaXpC+7uR1kk5
   QIhZ51ow1NoeN3lE+Vydy9yhoIX2tdCqpGR/ObFINMzNrGMADFB7xwNzf
   Te29wkfUV7G22EJh6SeYMf/CWEdXSKJb/sSFxxauQ19gQNeQ8IMn/kkSf
   ORKeLSYSrop9cFDpSkqiDIuDK0LkaU9yZZKMBebmdV7y2jh+vMUFWFfRI
   VDvzmYWhLNDH/ijZMZ7nxYceah0YxueCgWNAl3sTtCRhDH5n6bEFHVMV7
   A==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330540"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692571; x=1686228571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x27CnnubEwiDkgkFSluZiZEU6Sh9SnhgeRxl3MbhV54=;
  b=mDuT/pcliuUQY5K4yRwgZMnnvxQDU2mnsR5Lunn99GEfCP5tJ5+kw09L
   g76ehNh5tap74ytM84M1MZgQMG4ecJFedbbG8VCGDdmgshTPckqEbmuXg
   QnVEitnUF/HgPprnu+xClW6fxGL7FTAaWGr4RNYLXZVbGe4FUEtnNToV3
   kqkYw/UPIlVAQvVDaUSaEK2Q7pw5PSetuGOPivuNX20oGBF25++9BQ9+a
   BGiTtiIbjJzBFbVZg70L1sKHRenx35kVmhU0SDhOAnc8mMj1SnrdcDz3w
   JQ1xq5BrpFggYp4CWJQshAIBFV+jGelqPZAGE3nlrpj1QYsRfSEBDvElh
   A==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330539"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:31 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1223B280056;
        Wed,  8 Jun 2022 14:49:31 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/9] Input: synaptics-rmi4 - fix command completion check for bootloader v7/v8
Date:   Wed,  8 Jun 2022 14:48:02 +0200
Message-Id: <20220608124808.51402-4-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command register is reset to 0 when a command has completed. Check
for this condition instead of the error status, which will not accurately
reflect completion. In particular, the incorrect condition caused every
command error to be reported as a timeout.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_f34.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 3afc94f679ed..b811706fb77b 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -114,13 +114,13 @@ static irqreturn_t rmi_f34_attention(int irq, void *ctx)
 			complete(&f34->v5.cmd_done);
 	} else {
 		ret = rmi_read_block(f34->fn->rmi_dev,
-				     f34->fn->fd.data_base_addr +
-						f34->v7.off.flash_status,
-				     &status, sizeof(status));
-		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
+					f34->fn->fd.data_base_addr +
+						f34->v7.off.flash_cmd,
+					&status, sizeof(status));
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: cmd: %#02x, ret: %d\n",
 			__func__, status, ret);
 
-		if (!ret && !(status & 0x1f))
+		if (!ret && status == CMD_V7_IDLE)
 			complete(&f34->v7.cmd_done);
 	}
 
-- 
2.25.1

