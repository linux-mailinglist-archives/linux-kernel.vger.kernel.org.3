Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0ED59EB50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiHWSqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiHWSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:46:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C4B2D9F;
        Tue, 23 Aug 2022 10:09:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292491145"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="292491145"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:09:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="670121475"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:09:55 -0700
From:   Rajat Khandelwal <rajat.khandelwal@intel.corp-partner.google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     rajat.khandelwal@intel.com, shawn.c.lee@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Enter safe mode only when pins need to be reconfigured
Date:   Tue, 23 Aug 2022 22:39:49 +0530
Message-Id: <20220823170949.2066916-1-rajat.khandelwal@intel.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Shawn C <shawn.c.lee@intel.com>

There is no point to enter safe mode during DP/TBT configuration
if the DP/TBT was already configured in mux. This is because safe
mode is only applicable when there is a need to reconfigure the
pins in order to avoid damage within/to port partner.

1. if HPD interrupt arrives and DP mode was already configured,
safe mode is entered again which is not desired.
2. in chrome systems, IOM/mux is already configured before OS
comes up. Thus, when driver is probed, it blindly enters safe
mode due to PD negotiations but only after gfx driver lowers
dp_phy_ownership, will the IOM complete safe mode and send
ack to PMC.
Since, that never happens, we see IPC timeout.

Hence, allow safe mode only when pin reconfiguration is not
required, which makes sense.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>

---
 drivers/usb/typec/mux/intel_pmc_mux.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index d238913e996a..4bf84466d1ff 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -432,6 +432,25 @@ static int pmc_usb_connect(struct pmc_usb_port *port, enum usb_role role)
 	return pmc_usb_command(port, msg, sizeof(msg));
 }
 
+static bool
+pmc_usb_mux_allow_to_enter_safe_mode(struct pmc_usb_port *port,
+				      struct typec_mux_state *state)
+{
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, DP) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, DP_MFD)) &&
+	     state->alt &&
+	     state->alt->svid == USB_TYPEC_DP_SID)
+		return false;
+
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB)) &&
+	     state->alt &&
+	     state->alt->svid == USB_TYPEC_TBT_SID)
+		return false;
+
+	return true;
+}
+
 static int
 pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
@@ -442,8 +461,13 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 	if (port->orientation == TYPEC_ORIENTATION_NONE || port->role == USB_ROLE_NONE)
 		return 0;
 
-	if (state->mode == TYPEC_STATE_SAFE)
+	if (state->mode == TYPEC_STATE_SAFE) {
+		if (!pmc_usb_mux_allow_to_enter_safe_mode(port, state))
+			return 0;
+
 		return pmc_usb_mux_safe_state(port);
+	}
+
 	if (state->mode == TYPEC_STATE_USB)
 		return pmc_usb_connect(port, port->role);
 
-- 
2.31.1

