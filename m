Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92D53E9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiFFOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbiFFOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:42:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A71A384
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654526559; x=1686062559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VzrlOVXFHNGxewHeQ9+phMApukJnGGy7+AOe2fFMn6M=;
  b=H16dDoDv5GWISp3fo7QFUt2b1Gv7w18F/YRWja+j8RFzZzIDrXl8eqbo
   gTWCSmXv8vp4F66vpsSsQ/ql6HXCGVQgbBdcVebtZlwOtORKw/h9HU57P
   cJpHUn4t86HTRvi57aeFydmtwdJ3stEke4/+YzAnhRnvFGxOzsdK5aaW0
   M2i6/0VG3TT81negjh90rk1+S/cZ1U1UIe3N71olXh1SRQASgEuF0D4kh
   mowmEa2DFgKRBSkXhbRDYj1f3jjGMjkk9Ygyr9JE6Dq/OLO2o5EJ1z//E
   8IG96piqjECjSJMZ8kZMa2ZItnLuaz0MYkNjnYdCwqxfPsvyMt4t4DlkT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="256497758"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="256497758"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 07:42:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906574474"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 07:42:37 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/3] mei: me: set internal pg flag to off on hardware reset
Date:   Mon,  6 Jun 2022 17:42:23 +0300
Message-Id: <20220606144225.282375-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Link reset flow is always performed in the runtime resumed state.
The internal PG state may be left as ON after the suspend
and will not be updated upon the resume if the D0i3 is not supported.

Ensure that the internal PG state is set to the right value on the flow
entrance in case the firmware does not support D0i3.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 9870bf717979..befa491e3344 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1154,6 +1154,8 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
 			ret = mei_me_d0i3_exit_sync(dev);
 			if (ret)
 				return ret;
+		} else {
+			hw->pg_state = MEI_PG_OFF;
 		}
 	}
 
-- 
2.35.3

