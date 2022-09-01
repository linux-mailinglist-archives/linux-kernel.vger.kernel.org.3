Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DD5A8A03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiIAAvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiIAAvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:51:13 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A725C8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:49:49 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220901004947epoutp04aa87eddaf5ddb0a832c2db3ffce69592~Qli48MjDM1181911819epoutp04d
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:49:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220901004947epoutp04aa87eddaf5ddb0a832c2db3ffce69592~Qli48MjDM1181911819epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661993387;
        bh=F+DSRmrJxDlQ34jLvI5bieObIeH2rYC6PXiOIfkWjjU=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=AIR9crDXAJg0t0vY3/MfDeNNiActLEPmM9+agiEKgU7AIWrT59gDP+upWk6Aw/Ssy
         v3a6c5WpPVyBGeIRGA+umcYl3KyOqV6vpzBB4CikeLTI0218syvCg0Wj5xXDQc2u0U
         i0DIj+BkF/uLpwZW+RGLmOkInqfGjEiwLw1xEAcE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220901004947epcas2p4298714009c3c8aacc0135baba32c4f3e~Qli4jnZC01107511075epcas2p4Z;
        Thu,  1 Sep 2022 00:49:47 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MJ2W94pSzz4x9Py; Thu,  1 Sep
        2022 00:49:41 +0000 (GMT)
X-AuditID: b6c32a46-aa5ff70000018104-72-631001a56c3d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.1E.33028.5A100136; Thu,  1 Sep 2022 09:49:41 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] drivers/nvme/host: Fix namespace duplication check rule
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
Message-ID: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
Date:   Thu, 01 Sep 2022 09:49:41 +0900
X-CMS-MailID: 20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmhe5SRoFkg3OHVC3+7znGZrFy9VEm
        i0mHrjFaXN41h81i/rKn7BbrXr9nsbj76SWrA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
        PPq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5e
        aomVoYGBkSlQYUJ2RvPuT8wFy8UrTrzqZm1gPC7QxcjJISFgIrFp+mLWLkYuDiGBHYwSG1a1
        ADkcHLwCghJ/dwiD1AgLeEu03t3FDmILCShK/H3WxwgR15VY838KM4jNJqAtce/MWyaQOSIC
        fYwSfd/Pgw1lFljPKHHrwjJmiG28EjPan7JA2NIS25dvZYSwNSR+LOuFqhGVuLn6LTuM/f7Y
        fKgaEYnWe2ehagQlHvzcDRWXlHh68gNUPF+i7fciNpDFEgIdjBLnHx5hgkiYS/x5eR1sKK+A
        r8TWH2/ZQGwWAVWJfV+vsULUuEjsmvcW7DhmAXmJ7W/nMINCgllAU2L9Ln0QU0JAWeLILagK
        PomOw3/ZYd7aMe8J1CZViYsTethgXlw5r4ERotVD4t5ZI0gYBkrMbDrFPIFRYRYipGchWTsL
        Ye0CRuZVjGKpBcW56anFRgVG8MhNzs/dxAhOmlpuOxinvP2gd4iRiYPxEKMEB7OSCO/3czzJ
        QrwpiZVVqUX58UWlOanFhxhNgR6eyCwlmpwPTNt5JfGGJpYGJmZmhuZGpgbmSuK8LtqMyUIC
        6YklqdmpqQWpRTB9TBycUg1MvVr3siUbDrox1m4ra2N2ffK0XN956oo/d3TnbJH7dHqDb+BJ
        l+PxgY73a2NynCdeC51o1bDIvbfofMpZO/7DB6Zuu8v5v2oGE+unxADF050607c8Wj/h7m1n
        3XvKzef7WcI+aE5hur2etYV1vl9uk8Oz4ycmPOTzKZh6o54xYUPb3gDWH9OvlTkuUGk6f8PH
        bEJicKJn2AGFr0ZPfLJLPu3YKM0grVmssWpexr4VSklZbSkfvvxacFVi6o7tv47WPcs7/Paj
        lrPo+/1n857Z6kVcPMrGmnL2x16lqRbfgjfMvWSz5ueKMJ63mR/vl3z4dqXn+dWSyWfmsE5h
        WnNuzX4d8y88ZXeN5sw44GT5N1qJpTgj0VCLuag4EQAQr2NuIwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
sub-system because of the bit size of ID. Current kernel check the
all IDs should have unique value in a sub-system and globally.
However, if an namespace has duplicate IDs (not all) in a sub-system,
current kernel raise "duplicate IDs in subsystem for nsid" error. But
NVMe Specification defines the namespace unique identifier like this:

When creating a namespace, the controller shall indicate a globally
unique value in one or more of the following:
a) the EUI64 field;
b) the NGUID field; or
c) a Namespace Identification Descriptor with the Namespace Identifier
Type field set to 3h
(reference: 7.11 Unique Identifier; NVM Express 1.4c spec)

So, I suggest the modified nvme_subsys_check_duplicate_ids function
checking uniqueness from all IDS to one more IDs.

I missed the initializing of "duplicated" variable, so I reissue the
version2 patch.

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..8c2faa2881a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3902,24 +3902,35 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
        return NULL;
 }

+#define IDS_EQUAL(A, B) (memcmp(&(A), &(B), sizeof(A)) == 0)
+
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
                struct nvme_ns_ids *ids)
 {
        bool has_uuid = !uuid_is_null(&ids->uuid);
        bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
        bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
+       bool duplicated;
        struct nvme_ns_head *h;

        lockdep_assert_held(&subsys->lock);

        list_for_each_entry(h, &subsys->nsheads, entry) {
-               if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-                       return -EINVAL;
-               if (has_nguid &&
-                   memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-                       return -EINVAL;
-               if (has_eui64 &&
-                   memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
+               duplicated = has_uuid || has_nguid || has_eui64;
+
+               if (has_uuid)
+                       duplicated = duplicated &&
+                               uuid_equal(&ids->uuid, &h->ids.uuid);
+
+               if (has_nguid)
+                       duplicated = duplicated &&
+                               IDS_EQUAL(ids->nguid, h->ids.nguid);
+
+               if (has_eui64)
+                       duplicated = duplicated &&
+                               IDS_EQUAL(ids->eui64, h->ids.eui64);
+
+               if (duplicated)
                        return -EINVAL;
        }

--
2.34.1
