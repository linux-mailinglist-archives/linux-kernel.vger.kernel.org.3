Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAA57FBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiGYIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYIux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:50:53 -0400
X-Greylist: delayed 4777 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 01:50:52 PDT
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625076408
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:50:51 -0700 (PDT)
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 26P7VC7H054510
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:31:12 +0800 (GMT-8)
        (envelope-from xi.fengfei@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
        by h3cspam02-ex.h3c.com with ESMTP id 26P7Txkk050140;
        Mon, 25 Jul 2022 15:29:59 +0800 (GMT-8)
        (envelope-from xi.fengfei@h3c.com)
Received: from DAG2EX05-BASE.srv.huawei-3com.com (unknown [10.8.0.68])
        by mail.maildlp.com (Postfix) with ESMTP id 6A45B22FEFE6;
        Mon, 25 Jul 2022 15:34:07 +0800 (CST)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 15:29:59 +0800
From:   Fengfei Xi <xi.fengfei@h3c.com>
To:     <sathya.prakash@broadcom.com>, <sreekanth.reddy@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhou.kete@h3c.com>,
        Fengfei Xi <xi.fengfei@h3c.com>
Subject: [PATCH] scsi: mpt3sas: fix kernel panic in scsih_qcmd after shutdown/unload
Date:   Mon, 25 Jul 2022 15:27:03 +0800
Message-ID: <20220725072703.5562-1-xi.fengfei@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 26P7VC7H054510
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered a kernel crash problem after the user performed a 
shutdown operation. By analyzing the vmcore file, it is confirmed 
that it is scsih_qcmd called memset to access ioc->request resources 
that have been released in shutdown/module unload path.

crash> struct MPT3SAS_ADAPTER 0xffff00ff85806880
struct MPT3SAS_ADAPTER {
  list = {
    next = 0xffff800008eb8038 <mpt3sas_ioc_list>,
    prev = 0xffff800008eb8038 <mpt3sas_ioc_list>
  },
  ...
  name = "mpt3sas_cm0\000\000\000\000\000\000\000\
  ...
  remove_host = 1 '\001',
  ...
  request_sz = 128,
  request = 0x0,
  ...
  sense = 0x0,

The SCSI queuecommand handlers(scsih_qcmd) may be invoked after 
shutdown/unload, depending on other components. So we should add 
checks for 'ioc->remove_host' in scsih_qcmd, so not to access 
pointers/resources potentially freed in the PCI shutdown/module 
unload path.

Just like the following commit:
  9ff549ffb4fb4cc9a4b24d1de9dc3e68287797c4
  scsi: mpt3sas: fix oops in error handlers after shutdown/unload

Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index b519f4b59..d8994eaec 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -5140,7 +5140,8 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 		scsi_print_command(scmd);
 
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
+	    ioc->remove_host) {
 		scmd->result = DID_NO_CONNECT << 16;
 		scsi_done(scmd);
 		return 0;
-- 
2.17.1

