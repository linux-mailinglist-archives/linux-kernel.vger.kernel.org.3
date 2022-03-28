Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5B4E92CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiC1KzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiC1KzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:55:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9521A817;
        Mon, 28 Mar 2022 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648464819; x=1680000819;
  h=from:to:cc:subject:date:message-id;
  bh=y5Ta5faJZepUriOYafytGSAos/omF5AAyV8E9eFTQcg=;
  b=laqB0FzDKnjXGX0tYPCxgs6rZqsKEeNXPMQnkouOWmaLSMcr8PWrEhM9
   W9i/dvuyw3ENUEEt6WdVwrrvyWb1fiFL4fG/atUpKmfasft+sS/ij4RjM
   nrVAnj1dYngqa9SpKmSC04e3zWKqQogic/krMXHK5cKylOHQpZ5j8tvqR
   9GwbS/VI6qjSgWnHVYF2HPOfJ+8Zn206dmR2zeN3sfKrC6ajGEAE2Lb/U
   3NMPRjZ0klXRJ4DUQJMrrnfMPW1sKxWj85qKsVJ25/0Ol2nqmQF9snXug
   IGfnWk7DMOpA7Mqr2I4O1GN0kqLLBNgIuiVKt8vi7yur7c93QDlM1ZAj7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="257798477"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="257798477"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 03:53:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="563543771"
Received: from unknown (HELO localhost.localdomain) ([10.223.165.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 03:53:36 -0700
From:   tanveer1.alam@intel.com
To:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tanveer1.alam@intel.com, abhijeet.rao@intel.com
Subject: [PATCH] usb: typec: mux: intel_pmc_mux: Add retry logic to a PMC command
Date:   Mon, 28 Mar 2022 16:21:37 +0530
Message-Id: <20220328105137.6223-1-tanveer1.alam@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanveer Alam <tanveer1.alam@intel.com>

There are few scenerio when PMC reports 'busy condition' and command
fail.

If PMC receives a high priority command while servicing a low priority
command then it discards the low priority command and start servicing
the high priority command. The lower priority command fail and driver
returns error. If the same command resend to the PMC then PMC latches
the command and service it accordingly.

Thus adds the retry logic for the PMC command.

Signed-off-by: Tanveer Alam <tanveer1.alam@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 2cdd22130834..da6b381ddf00 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -173,7 +173,7 @@ static int hsl_orientation(struct pmc_usb_port *port)
 	return port->orientation - 1;
 }
 
-static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
+static int pmc_usb_send_command(struct intel_scu_ipc_dev *ipc, u8 *msg, u32 len)
 {
 	u8 response[4];
 	u8 status_res;
@@ -184,7 +184,7 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 	 * Status can be checked from the response message if the
 	 * function intel_scu_ipc_dev_command succeeds.
 	 */
-	ret = intel_scu_ipc_dev_command(port->pmc->ipc, PMC_USBC_CMD, 0, msg,
+	ret = intel_scu_ipc_dev_command(ipc, PMC_USBC_CMD, 0, msg,
 					len, response, sizeof(response));
 
 	if (ret)
@@ -203,6 +203,23 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 	return 0;
 }
 
+static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
+{
+	int retry_count = 3;
+	int ret;
+
+	/*
+	 * If PMC is busy then retry the command once again
+	 */
+	while (retry_count--) {
+		ret = pmc_usb_send_command(port->pmc->ipc, msg, len);
+		if (ret != -EBUSY)
+			break;
+	}
+
+	return ret;
+}
+
 static int
 pmc_usb_mux_dp_hpd(struct pmc_usb_port *port, struct typec_displayport_data *dp)
 {
-- 
2.17.1

