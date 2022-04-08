Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7424F9453
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiDHLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiDHLmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:42:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC914ACB4;
        Fri,  8 Apr 2022 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649418011; x=1680954011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J669eTEJykHaSlZWi18qnlrVnDnZT6sCHVan60Wt7sM=;
  b=EDFL5sC76ASB7r+z4bibU3cHWsx+3t26BRvNVS92c/aNKQsH8hjJyiTc
   1oseI/v6tsetOD9m7oyrOg8Nb1NA8S7FIFaAPW0iuNKVJHdfohRNqJrY5
   CpYWhJQqUgB5AEAD1wsLRlFY5TJrVw1uYSu4wxd6U1VuI0wu0CcDCrTYE
   dnShoKglpfvgHfn7d3/IvZLknDzWbD0lDbbh29OLfustGDV6FhNS3J2L3
   HMu5gMKORs28zw+/G9Ipx+U5jn0ZaWvcdVGEgJ1KoYViMxynP4DLxB9Qj
   dETxm8tOvE5HbX2FsDChsCnMucU4DfDuYNqn41vokIBxhmaoAhitzzaLQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261749129"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261749129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="571462664"
Received: from aecajiao-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/3] tty: Add functions for handling flow control chars
Date:   Fri,  8 Apr 2022 14:39:52 +0300
Message-Id: <20220408113954.9749-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move receive path flow control character handling to own function
and a helper.

This seems cleanest approach especially once skipping due to lookahead
is added. Its downside is the duplicated START_CHAR and STOP_CHAR
checks.

No functional changes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..90b3e06cbeb1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1220,21 +1220,33 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
+static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+{
+	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
+}
+
+/* Returns true if c is consumed as flow-control character */
+static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+{
+	if (!n_tty_is_char_flow_ctrl(tty, c))
+		return false;
+
+	if (c == START_CHAR(tty)) {
+		start_tty(tty);
+		process_echoes(tty);
+	} else if (c == STOP_CHAR(tty)) {
+		stop_tty(tty);
+	}
+
+	return true;
+}
+
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IXON(tty)) {
-		if (c == START_CHAR(tty)) {
-			start_tty(tty);
-			process_echoes(tty);
-			return;
-		}
-		if (c == STOP_CHAR(tty)) {
-			stop_tty(tty);
-			return;
-		}
-	}
+	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
+		return;
 
 	if (L_ISIG(tty)) {
 		if (c == INTR_CHAR(tty)) {
-- 
2.30.2

