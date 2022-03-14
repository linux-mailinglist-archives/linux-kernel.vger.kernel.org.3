Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91F54D805B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiCNLHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiCNLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:07:08 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853A47ADA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:05:55 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220314110549epoutp031f23f77aeb0f6ed7ba2b604eea7a3fc2~cOo8H2B1U0403204032epoutp03U
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:05:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220314110549epoutp031f23f77aeb0f6ed7ba2b604eea7a3fc2~cOo8H2B1U0403204032epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647255949;
        bh=+sURExfT6I73ywJq8FqiGsFUXCKNcPfnjGGoN0nd/6U=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Nz/iRhuimqP2X1GyhqaX7buAGq4AISpWh3n1mTrpK1HGeAL/fcI4VbvTlRGkzhetT
         4rgPDL6TjX63SWs5b5bWTc1/wCrha2LHNivLgML5KeeLQIBIBdAc1SeJBsplEbltDx
         HQLaEsWfP8gbjEUzHsmp4AVcfXh2dT4lbJgrxd7o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220314110548epcas2p22385e16505bfa9fb788cab6895eebd1b~cOo6kQnsY1976619766epcas2p2E;
        Mon, 14 Mar 2022 11:05:48 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KHDGx64NBz4x9Q3; Mon, 14 Mar
        2022 11:05:45 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-66-622f2189de09
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.FF.25540.9812F226; Mon, 14 Mar 2022 20:05:45 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Reply-To: sungup.moon@samsung.com
Sender: Sungup Moon <sungup.moon@samsung.com>
From:   Sungup Moon <sungup.moon@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sungup Moon <sungup.moon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
Date:   Mon, 14 Mar 2022 20:05:45 +0900
X-CMS-MailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmqW6non6Swb0tuhb/9xxjs1i5+iiT
        xaRD1xgtLu+aw2Yxf9lTdot1r9+zWNz99JLVgd1jYvM7do/z9zayeGxa1cnmsXlJvcfumw1s
        Hn1bVjF6fN4kF8AelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE74/GrpewF/zUr/s96wdzAeEKpi5GTQ0LAROLMxN+MXYxcHEICOxgl7tze
        w9bFyMHBKyAo8XeHMEiNsECQxKPt35hAbCEBRYm/z/oYIeK6Emv+T2EGsdkEtCXunXnLBDJH
        RKCPUaLv+3lWEIdZYD2jxK0Ly5ghtvFKzGh/ygJhS0tsX76VEcLWkPixrBeqRlTi5uq37DD2
        +2PzoWpEJFrvnYWqEZR48HM3VFxSYtfT61DxfIm234vYQBZLCHQwSpx/eIQJImEu8efldbCh
        vAK+EvOezAVrYBFQlXj7oBWqxkViXdM5MJtZQF5i+9s5zKCQYBbQlFi/Sx/ElBBQljhyiwWi
        gk+i4/Bfdpi3dsx7AjVFVeLihB42mBdXzmtghGj1kFjzIhgShoES305NZ5nAqDALEdKzkKyd
        hbB2ASPzKkax1ILi3PTUYqMCY3jkJufnbmIEJ00t9x2MM95+0DvEyMTBeIhRgoNZSYTXaqle
        khBvSmJlVWpRfnxRaU5q8SFGU6CHJzJLiSbnA9N2Xkm8oYmlgYmZmaG5kamBuZI4r1fKhkQh
        gfTEktTs1NSC1CKYPiYOTqkGpl3B8cdzrRbFixXWGn1fkTU3nO3VN9+G7TEz/mZtE2RxuvPW
        tGfNvX27RZR+MstGadwJ3V/3Jnvqj4fSWxhfldRyq2oev/b62Kp3POvVzy2KvPDE/rDLggDh
        j9OidnSrzN7c7zJbRZtlS5K+fNtyGcfU5nsuzhWKyxZe8zycrRlRu5o/SC9j7VL7sjlf5Q+8
        PSHO/+fZjJoGx1m88XclMs0Zi08u32C3+eSLedMMohb32//8vNqq7/cPod+PHt1ZUvVv9hVG
        Pl7vtjUGSz/oLnvN+Waa2V0GuRhe+QAJ33fbi6cmTNR2Pfnt+fTthxbFB6a+Wvbgf4jh57UB
        T/9NmFp7x5vvmhCH57Kg2krehTVKLMUZiYZazEXFiQC53lvGIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314110545epcms2p4a227eac7c4652445050e70ee2350635d
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the multi-controller, managed by a special admin command, has private
namespace with same nsid, current linux driver raise "Duplicate unshared
namespace" error. But, NVMe Specification defines the NSID usage like this:

If Namespace Management, ANA Reporting, or NVM Sets are supported, the
NSIDs shall be unique within the NVM subsystem. If the Namespace
Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
a) for shared namespace shall be unique; and
b) for private namespace are not required to be unique.
(reference: 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec)

So, if a multi-controller, which is not managed by Namespace Management
function, creates some private namespaces without ANA and NVM Sets, the
duplicated NSID should be allowed because that is not a NVMe specification
violation.

But, current nvme driver checks only namespace is shared or not, so I
propose following patch:
1. nvme_ctrl has unique_nsid field to identify that controller should
   assign unique nsid.
2. nvme_init_ns_head function creates new nvme_ns_head instance not only
   head is null but controller's unique_nsid is false (no flagged
   attribute) and namespace is not shared.
3. for creating bdev device file, nvme_mpath_set_disk_name will return
   false when unique_nsid is false and namespace is not shared.
4. also, nvme_mpath_alloc_disk alto return 0 with same manner.

This patch has been modified the unique_nsid mechanism from flag based
to the checking function.
- v1: flag based initial patch
- v2: change from unique_nsid flag to nvme_check_unique_nsid

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c      |  9 ++++++++-
 drivers/nvme/host/multipath.c |  5 +++--
 drivers/nvme/host/nvme.h      | 16 ++++++++++++++++
 include/linux/nvme.h          |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..5eedef9a781c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3816,7 +3816,14 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl->subsys, nsid);
-	if (!head) {
+	if (!head || !(nvme_check_unique_nsid(ctrl, head) || is_shared)) {
+		/*
+		 * If the found ns head is null or both of ns are not shared
+		 * without the unique namespace condition (this means both
+		 * namespace are private namespaces and those can share the
+		 * same nsid), allocate the new head. Private namespace can
+		 * reuse nsid with the others.
+		 */
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
 		if (ret) {
 			dev_err(ctrl->device,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ff775235534c..4671dc1b32da 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -88,7 +88,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
  */
 bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags)
 {
-	if (!multipath)
+	if (!multipath || !nvme_check_unique_nsid(ns->ctrl, ns->head))
 		return false;
 	if (!ns->head->disk) {
 		sprintf(disk_name, "nvme%dn%d", ns->ctrl->subsys->instance,
@@ -507,7 +507,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing data could
 	 * change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
+	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath ||
+	    !nvme_check_unique_nsid(ctrl, head))
 		return 0;
 
 	head->disk = blk_alloc_disk(ctrl->numa_node);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7ccdb119ede..50091ed3713b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -719,6 +719,22 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live);
 }
+static inline bool nvme_check_unique_nsid(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head)
+{
+	/*
+	 * NSID should be unique on the following condition
+	 * 1. Namespace Management support; or
+	 * 2. ANA Reporing support; or
+	 * 3. NVM Set support; or
+	 * 4. Namespace is shared
+	 * Other case, private namespace are not required to be unique.
+	 */
+	return (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
+		(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
+		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS) ||
+		(head->shared);
+}
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4f44f83817a9..f626a445d1a8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -346,6 +346,7 @@ enum {
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
-- 
2.25.1

