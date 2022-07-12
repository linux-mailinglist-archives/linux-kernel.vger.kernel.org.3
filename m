Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31488571A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiGLMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiGLMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:46:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F18B0FA6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:46:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCica7016881;
        Tue, 12 Jul 2022 12:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dCYZ6oZv3oAaDnQdJDGZWm3Bna5te/b8gdwDmZiCOis=;
 b=Ky/JM6Bv4QXuSZbDCp9YsXAMNmhhzPOOBD26w6k3012N4E5vQcnkykRw/RyoAfZYhVbg
 eVoCJLzkz18G6iVE0oFIkKj4NJDfWhFXBn3SnauZAIEZoizdlbik5ptY/fgWAsYv/3SN
 S3Tp4T+O6rs6fCE2EOfT3M0/M2HWB2xx0brtTUFgUkN1wWIVfHOEjVydDwyYIFuNR760
 eYto8BZbeU0BdCnV0mnrSjXyI0gfShzoJMoFtWtayojO2cUGTjCLjU3sJHDZo50lqU5u
 Tg7yWXEha/V/XcuHQ3q4Y6Y+XIqZUVVjGpDHDYiLIeoquhvaQq+yXCBRPfdKK9V/Hui2 1w== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h997u00ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 12:46:13 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CCLhp2028372;
        Tue, 12 Jul 2022 12:46:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3h71a8u4bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 12:46:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CCir5X24052120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:44:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA229A4040;
        Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739F3A4053;
        Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 12:44:53 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nvme-pci: fix hang during error recovery when the PCI device is isolated
Date:   Tue, 12 Jul 2022 14:44:53 +0200
Message-Id: <20220712124453.2227362-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712124453.2227362-1-schnelle@linux.ibm.com>
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zZ-Xx_TiTN8lrVlPKMNjzoJc2qKZJUxO
X-Proofpoint-ORIG-GUID: zZ-Xx_TiTN8lrVlPKMNjzoJc2qKZJUxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 and powerpc PCI devices are isolated when an error is detected
and driver->err_handler->error_detected is called with an inaccessible
PCI device and PCI channel state set to pci_channel_io_frozen
(see Step 1 in Documentation/PCI/pci-error-recovery.rst).

In the case of NVMe devices nvme_error_detected() then calls
nvme_dev_disable(dev, false) and requests a reset. After a successful
reset the device is accessible again and nvme_slot_reset() resets the
controller and queues nvme_reset_work() which then recovers the
controller.

Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
queues if pci_device_is_present() returns false. This is the case for an
isolated PCI device. In principle this makes sense as there are no
accessible hardware queues to run. The problem though is that for
a previously live reset controller with online queues nvme_reset_work()
calls nvme_wait_freeze() which, without the freeze having been
initiated, then hangs forever. Fix this by starting the freeze in
nvme_slot_reset() which is the earliest point where we know the device
should be accessible again.

Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 193b44755662..7c0c61b74c30 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3399,6 +3399,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
 	nvme_reset_ctrl(&dev->ctrl);
+	nvme_start_freeze(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.34.1

