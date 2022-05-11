Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B8523072
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbiEKKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiEKKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:12:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309A21935A;
        Wed, 11 May 2022 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263933; x=1683799933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2ZGQHsx6x/fGntuee5Dt0BhAfm+/Hlzd1YGdP2vArk=;
  b=CqpVF3cw1vUDTQpRJLdkMd32AiL/4rYB39vil5RLkML6uDaCVWK4lobg
   kNhuvYJ70ETd0SLspoOs/b2DPGDJzF8YJF6PiElXL1TQT3NW1VXAYGnPA
   CnLYZQoGKusU8d+np3ZL0dw1d3YDZoHi+shVEL0EFHfVUwyYJ5LIp4oxW
   nAlepbiFaHRHbBG9aZ4946+j3V0P65kNFgkwLd77EskgCTXAx9z6eGYxS
   GfEagPi6LPkH6S9Sn2AnKq69XRisbTk20LEPIJuujNv29myKAeQgP7HIR
   mzpFHYJ7u1XI8WnZoMeGPOE+Gq+9n4vbqfmGYkMN2AM1HqNKTIBSrYbOG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250184352"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="250184352"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049671"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/5] serial: jsm: Use B0 instead of 0
Date:   Wed, 11 May 2022 13:11:39 +0300
Message-Id: <20220511101139.5306-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use B0 to check zero baudrate rather than literal 0.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 2 +-
 drivers/tty/serial/jsm/jsm_neo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 046b624e5f71..ca05e84a7c90 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -689,7 +689,7 @@ static void cls_param(struct jsm_channel *ch)
 	/*
 	 * If baud rate is zero, flush queues, and set mval to drop DTR.
 	 */
-	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
+	if ((ch->ch_c_cflag & (CBAUD)) == B0) {
 		ch->ch_r_head = 0;
 		ch->ch_r_tail = 0;
 		ch->ch_e_head = 0;
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0cf586c10688..95bebf2a73d3 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -938,7 +938,7 @@ static void neo_param(struct jsm_channel *ch)
 	/*
 	 * If baud rate is zero, flush queues, and set mval to drop DTR.
 	 */
-	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
+	if ((ch->ch_c_cflag & (CBAUD)) == B0) {
 		ch->ch_r_head = ch->ch_r_tail = 0;
 		ch->ch_e_head = ch->ch_e_tail = 0;
 
-- 
2.30.2

