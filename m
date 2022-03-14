Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3244D7B38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiCNHHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiCNHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:06:58 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCA10FE2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:05:46 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220314070541epoutp017020871a53c490cb2bfae3ddadc10fae~cLXRRokk61627516275epoutp01N
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220314070541epoutp017020871a53c490cb2bfae3ddadc10fae~cLXRRokk61627516275epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647241541;
        bh=u0/uygnsY6Fb/wLdxBu6vZllUrVndB9u0ZU8EsbdXi4=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=BavF8c01k3MTTtY7rwQctsYk/bbal59U2ln0omRYDWQWz8YXswjXhiH32iwrjpqHa
         OzFqJH4dC23tzAWe/NIp/IUI5bPtoLO3IyZJmwv8zX3YIhrj9ORkJl/c+HMVdbNWMA
         xhmPxqWBXfbWaYPz4zl132GZtfFYRh0ohZU6Kcr4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220314070540epcas2p1d57e840428ea1bc5808c7d4461cc5c9e~cLXQ0wbgx2402724027epcas2p1x;
        Mon, 14 Mar 2022 07:05:40 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KH6xL0DrGz4x9Pr; Mon, 14 Mar
        2022 07:05:10 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-c2-622ee9211451
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.36.16040.129EE226; Mon, 14 Mar 2022 16:05:05 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] driver/nvme/host: Support duplicated nsid for the private
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
Message-ID: <20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
Date:   Mon, 14 Mar 2022 16:05:05 +0900
X-CMS-MailID: 20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmma7iS70kg6WTjCz+7znGZrFy9VEm
        i0mHrjFaXN41h81i/rKn7BbrXr9nsbj76SWrA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
        PPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5e
        aomVoYGBkSlQYUJ2xosF+9kK9mpUXOhqYmpg/KvQxcjJISFgInF23wLGLkYuDiGBHYwSB/v2
        MncxcnDwCghK/N0hDGIKC3hJLO22ACkXElCU+PusjxHEFhbQlVjzfwoziM0moC1x78xbJpAx
        IgJ9jBJ938+zgjjMAusZJW5dWMYMsYxXYkb7UxYIW1pi+/KtjBC2hsSPZb1QNaISN1e/ZYex
        3x+bD1UjItF67yxUjaDEg5+7oeKSErueXoeK50u0/V7EBrJYQqCDUeL8wyNMEAlziT8vr4MN
        5RXwlbi+5wbYESwCqhLdS1qgBrlIXFkyC6yeWUBeYvvbOeCAYBbQlFi/Sx/ElBBQljhyiwWi
        gk+i4/Bfdpi3dsx7ArVJVeLihB42mBdXzmuAmu4hcXriYlZIIAZKrNz5h3UCo8IsREjPQrJ3
        FsLeBYzMqxjFUguKc9NTi40KjOCRm5yfu4kRnDS13HYwTnn7Qe8QIxMH4yFGCQ5mJRFeq6V6
        SUK8KYmVValF+fFFpTmpxYcYTYE+nsgsJZqcD0zbeSXxhiaWBiZmZobmRqYG5krivF4pGxKF
        BNITS1KzU1MLUotg+pg4OKUamLaYMq4xnH/2fvORxQe4xc8HdfIs+LV/feyT/Cn6OcY+PW6J
        Z+eWmE0QUVrTJHx+UsWRq6yL2fpVRL9eY8vPDD7ffeWTvSPPYs3Vle/e3/PwnWeTOmXfmhO/
        l56c2hg7vff+h6uSnHvKvjqedbe5/k3v5THu51rPIl91avNv41z5s0jyP0NRF8d9p74p6wp8
        5IKcOS0vs/9yiz0xWf1/8+TsRKlPbv4hCXempTC+Medcmrq9bUf5+kmZ5V0znDVfGUqW+trM
        s51hs7jC1uJZ799HLCGC/zsyel7s7WuTrfAwePhOpblxhbZvHsuMDRstu92iJnN8ulyqOVHQ
        t+qausqkWDNH44p85tLAV2f7lViKMxINtZiLihMBViGyGCMEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928
References: <CGME20220314070505epcms2p26dff1d529f4d8c208728e5fa5c5dd928@epcms2p2>
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

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c      | 20 +++++++++++++++++++-
 drivers/nvme/host/multipath.c |  5 +++--
 drivers/nvme/host/nvme.h      |  1 +
 include/linux/nvme.h          |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..f1807b0ca361 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2942,6 +2942,18 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		if (ret)
 			goto out_free;
 
+		/*
+		 * NSID should be unique on the following condition
+		 * 1. Namespace Management support; or
+		 * 2. ANA Reporting support; or
+		 * 3. NVM Set support; or
+		 * 4. Namespace is shared
+		 * Other case, private namespaces are not required to be unique.
+		 */
+		ctrl->unique_nsid = (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
+			(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
+			(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
+
 		/*
 		 * Check for quirks.  Quirk can depend on firmware version,
 		 * so, in principle, the set of quirks present can change
@@ -3816,7 +3828,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl->subsys, nsid);
-	if (!head) {
+	if (!head || !(ctrl->unique_nsid || is_shared || head->shared)) {
+		/*
+		 * If the found ns head is null or both of ns are not shared without
+		 * the unique namespace condition (this means both namespace are
+		 * private namespaces and those can share the same nsid), allocate the
+		 * new head. Private namespace can reuse nsid with the others.
+		 */
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
 		if (ret) {
 			dev_err(ctrl->device,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ff775235534c..7fe91754fe69 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -88,7 +88,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
  */
 bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags)
 {
-	if (!multipath)
+	if (!multipath || !(ns->ctrl->unique_nsid || ns->head->shared))
 		return false;
 	if (!ns->head->disk) {
 		sprintf(disk_name, "nvme%dn%d", ns->ctrl->subsys->instance,
@@ -507,7 +507,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing data could
 	 * change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
+	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath ||
+	    !(ctrl->unique_nsid || head->shared))
 		return 0;
 
 	head->disk = blk_alloc_disk(ctrl->numa_node);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7ccdb119ede..8348c405c6d3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -297,6 +297,7 @@ struct nvme_ctrl {
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
+	bool unique_nsid;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
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

