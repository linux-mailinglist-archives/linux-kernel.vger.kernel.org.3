Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19113525D93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378286AbiEMIaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378248AbiEMI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:29:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C225F2A8044;
        Fri, 13 May 2022 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430577; x=1683966577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOoN2Fve4JKCSLdO4MGCcXzCd2YW2wiUYn98empvuVE=;
  b=f+zoycT4/P4tlE5zJl3sYMqvGtIZVYr43YH2wPtgZYGG8V+81IKOBGJO
   uvG4ucmUHzGFu5dBO6iBFV37zivmDp8PNerrTZvn3ifav9j2o+iYiwlvC
   HeoFcRk0krJezWEJ2jtOsRymiU2XM1BkrjCnMOlYFz40emCb4OmhI5n+W
   tfpJG4s6lRCo9F5uvd1q1H6k1YnnPPJzYMctavohgXKaQSBgL44vN14l7
   bH4oVHC85e3ixEakcy4DVUXf3pz2mt1S6xu4SLIbkn8hnuXo78t0v38Y6
   t6POpXS/buEvy4HZN0AMIeUruIKVHxL7z0u2x2DhgcGlWh8h9cmZNpP+J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385208"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385208"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107510"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:35 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/5] serial: jsm: Use B0 instead of 0
Date:   Fri, 13 May 2022 11:29:06 +0300
Message-Id: <20220513082906.11096-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
References: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use B0 to check zero baudrate rather than literal 0.

While at it, remove extra parenthesis around CBAUD.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 2 +-
 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 046b624e5f71..3fd57ac3ad81 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -689,7 +689,7 @@ static void cls_param(struct jsm_channel *ch)
 	/*
 	 * If baud rate is zero, flush queues, and set mval to drop DTR.
 	 */
-	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
+	if ((ch->ch_c_cflag & CBAUD) == B0) {
 		ch->ch_r_head = 0;
 		ch->ch_r_tail = 0;
 		ch->ch_e_head = 0;
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0cf586c10688..0c78f66276cd 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -938,7 +938,7 @@ static void neo_param(struct jsm_channel *ch)
 	/*
 	 * If baud rate is zero, flush queues, and set mval to drop DTR.
 	 */
-	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
+	if ((ch->ch_c_cflag & CBAUD) == B0) {
 		ch->ch_r_head = ch->ch_r_tail = 0;
 		ch->ch_e_head = ch->ch_e_tail = 0;
 
-- 
2.30.2

