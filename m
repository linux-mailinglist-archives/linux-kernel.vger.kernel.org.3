Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0495B037A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIGL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:56:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDD7FE4B;
        Wed,  7 Sep 2022 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662551778; x=1694087778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4C4vOH4AS9wNEL/9JtetICouMH3J9a1nV18A4BnQ+sw=;
  b=JtAGlBRqyAM5hesEW7257AlkXiqpHq4NzLmSj6S7wfypAYtSeEZXtG6m
   jFbrnU6cdenyajH49bxnOXz2g1LsLoL80qXFFrlyIoTLPRiazQN0v6unK
   RZVqbDuuBBDIEzS3gPlWGGKsJdWvZqN4VoCZdQmRQmfsanmSk3oOdM1pK
   Mm7fFKlh75QUgCcmAldEo5NbpRpJ1GI3h13qVAr04Ki0A0kzJoK4PqKR6
   9v/vhn+LpxkaAnw37iBfIjatIRctEw8eXDAaspaU94qvU2Jq/ELPglubn
   WW6PftLrdBjsQWmOL/Uns6J0DX56ry9hpYBzIDLU5iM9cs1qn08QToEHp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296851220"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296851220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="756742666"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 04:56:14 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, grzegorz.alibozek@gmail.com,
        bastian@rieck.me, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: [RFC PATCH 1/2] usb: typec: ucsi: Check the connection on resume
Date:   Wed,  7 Sep 2022 14:56:25 +0300
Message-Id: <20220907115626.21976-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue where the partner device is not unregistered
properly after resume if it's unplugged during suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=210425
Fixes: a94ecde41f7e ("usb: typec: ucsi: ccg: enable runtime pm support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 42 ++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7f2624f427241..33e1cee9dc184 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -183,16 +183,6 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 }
 EXPORT_SYMBOL_GPL(ucsi_send_command);
 
-int ucsi_resume(struct ucsi *ucsi)
-{
-	u64 command;
-
-	/* Restore UCSI notification enable mask after system resume */
-	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
-
-	return ucsi_send_command(ucsi, command, NULL, 0);
-}
-EXPORT_SYMBOL_GPL(ucsi_resume);
 /* -------------------------------------------------------------------------- */
 
 struct ucsi_work {
@@ -746,6 +736,7 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 
 static int ucsi_check_connection(struct ucsi_connector *con)
 {
+	u8 prev_flags = con->status.flags;
 	u64 command;
 	int ret;
 
@@ -756,10 +747,13 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 		return ret;
 	}
 
+	if (con->status.flags == prev_flags)
+		return 0;
+
 	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
-		if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
-		    UCSI_CONSTAT_PWR_OPMODE_PD)
-			ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_register_partner(con);
+		ucsi_pwr_opmode_change(con);
+		ucsi_partner_change(con);
 	} else {
 		ucsi_partner_change(con);
 		ucsi_port_psy_changed(con);
@@ -1280,6 +1274,28 @@ static int ucsi_init(struct ucsi *ucsi)
 	return ret;
 }
 
+int ucsi_resume(struct ucsi *ucsi)
+{
+	struct ucsi_connector *con;
+	u64 command;
+	int ret;
+
+	/* Restore UCSI notification enable mask after system resume */
+	command = UCSI_SET_NOTIFICATION_ENABLE | ucsi->ntfy;
+	ret = ucsi_send_command(ucsi, command, NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	for (con = ucsi->connector; con->port; con++) {
+		mutex_lock(&con->lock);
+		ucsi_check_connection(con);
+		mutex_unlock(&con->lock);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ucsi_resume);
+
 static void ucsi_init_work(struct work_struct *work)
 {
 	struct ucsi *ucsi = container_of(work, struct ucsi, work.work);
-- 
2.35.1

