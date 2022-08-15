Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3C59517A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiHPE6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiHPE4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:56:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A280B56
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:52:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Nh4To0e9HTLjwNh4TowhXt; Mon, 15 Aug 2022 22:52:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 22:52:26 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     michael.christie@oracle.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH v2] scsi: target: Save a few cycles in transport_lookup_[cmd|tmr]_lun()
Date:   Mon, 15 Aug 2022 22:52:24 +0200
Message-Id: <03705222390bfa3b48ad7658f693fc0fc030b3ae.1660596679.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use percpu_ref_tryget_live_rcu() instead of percpu_ref_tryget_live() to
save a few cycles when it is known that the rcu lock is already
taken/released.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Change in v2:
  * sync with -next

v1:
  * https://lore.kernel.org/all/e4a21bc607c39935cb98d4825cd63ba349820550.1635974637.git.christophe.jaillet@wanadoo.fr/
---
 drivers/target/target_core_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index b7f16ee8aa0e..76c6613a1da7 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -77,7 +77,7 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd)
 
 		se_lun = deve->se_lun;
 
-		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
+		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
 			se_lun = NULL;
 			goto out_unlock;
 		}
@@ -154,7 +154,7 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	if (deve) {
 		se_lun = deve->se_lun;
 
-		if (!percpu_ref_tryget_live(&se_lun->lun_ref)) {
+		if (!percpu_ref_tryget_live_rcu(&se_lun->lun_ref)) {
 			se_lun = NULL;
 			goto out_unlock;
 		}
-- 
2.34.1

