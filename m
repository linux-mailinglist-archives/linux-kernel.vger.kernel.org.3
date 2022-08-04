Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5578589898
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiHDHmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiHDHm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:42:29 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C232DAA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:42:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220804074226epoutp02512206b34b3cb8b1e8b8c3b748302ab3~IFHLVmRKo2192321923epoutp02S
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:42:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220804074226epoutp02512206b34b3cb8b1e8b8c3b748302ab3~IFHLVmRKo2192321923epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659598946;
        bh=Rm83Ec5yFCaQndyEYNktaf6vrS+E3EUgRBd9vlEqa4E=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=BcyBYWlizkylV4wi07KVSbhY3UWioAE1U9oDaZYXMptUTm1s6EZ9eIfxJrSxtgqFW
         mNlnnZcuc06/s2x8A8ynQpP+m++s8uL44LkiCJ/FpIaCwWqdVWn+aLPiIEAfnxLZt9
         v4Q4w9E66INNgFG3ZlcZIz/dIwok2tCR5krUn/f4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220804074225epcas2p340956e2923a6957fcdfbb4be56442c03~IFHKqa6eo0759107591epcas2p3M;
        Thu,  4 Aug 2022 07:42:25 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lz10J6MtHz4x9Px; Thu,  4 Aug
        2022 07:42:24 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-55-62eb78607d6f
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.E1.09662.0687BE26; Thu,  4 Aug 2022 16:42:24 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 0/6] scsi: ufs: wb: Add sysfs attribute and cleanup
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
Date:   Thu, 04 Aug 2022 16:42:24 +0900
X-CMS-MailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmhW5Cxeskg5udxhYnn6xhs3gwbxub
        xcufV9ksDj7sZLGY9uEns8XLQ5oWvf1b2SwW3djGZHF51xw2i+7rO9gslh//x2SxdOtNRgce
        j8tXvD0W73nJ5DFh0QFGj5aT+1k8vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCuCMyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8eLxX6aC
        /bwVC/qusjcwHuDqYuTkkBAwkXj6eh57FyMXh5DADkaJY9s/MHUxcnDwCghK/N0hDGIKC7hJ
        zLnOD1IuJKAkcW7NLEaIsIHErV5zkDCbgJ7EzyUz2EBsEYE2Fon1p9khpvNKzGh/ygJhS0ts
        X76VEcLWkPixrJcZwhaVuLn6LTuM/f7YfKgaEYnWe2ehagQlHvzcDRWXlDh06CsbyAkSAvkS
        Gw4EQoRrJN4uPwBVoi9xrWMj2FpeAV+Jrp6XYKexCKhKrJ31lA2ixkVi78EDYDazgLzE9rdz
        mEFGMgtoSqzfpQ8xXVniyC0WmEcaNv5mR2czC/BJdBz+CxffMe8JE0SrmsSiJiOIsIzE18Pz
        oUo8JKb0vGGbwKg4CxHGs5CcMAvhhAWMzKsYxVILinPTU4uNCkzg0Zqcn7uJEZxstTx2MM5+
        +0HvECMTB+MhRgkOZiUR3hWWr5OEeFMSK6tSi/Lji0pzUosPMZoCPT+RWUo0OR+Y7vNK4g1N
        LA1MzMwMzY1MDcyVxHm9UjYkCgmkJ5akZqemFqQWwfQxcXBKNTCpH51y0OQry++NgbIVj9by
        HRSO2vu5zWR16BP9OObtXIy71aqs9l/5NpF9cluP2jHOAL7Jtes/uLwtszy1vNKU2zZ+D3ei
        4a68B88/qd795HCqtv82f0Do6l8rBOZGCItWWrP827p9rsFCHbMJ6+4mvPvHWGD5dEPg0mVH
        VQ+vOLpC5Nne6nZppYwVvKy5zu9cxEtT7JsX7vhmW8jtc2JxwGZtJvtpfWaVC1+zrDtuO0Wr
        o9LmG8+eP0EmGVf18/2F2HZ2nuA6PXHtyxcbpzhELpv89UqB5jKvB4kXndcG35DeyXuj7WdK
        c/yk29yv7MLf8Mn8Wu65/sbLvnd9tu+4G5/JtHMbioV+F72w6ZWOEktxRqKhFnNRcSIAxhoe
        rD8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to clean up UFS's Write Booster code and
adds sysfs attribute which can control the specific feature of it.

V2:
	- modify commit message
	- move & modify err messages
	- remove unnesscessary debug messages
V3:
	- split patch (functional, non-functional)
V4:
	- split patch (The number of patches from 2 to 7)
	- modify dev messages
	- modify commit message
V5:
	- drop (scsi: ufs: wb: Move ufshcd_is_wb_allowed() to callee)
	- fix condition check
	- add document for sysfs attribute
	- move ufshcd_is_wb_buf_flush_allowed() to ufs-priv.h
V6:
	- Change the function name from ufshcd_wb_config() to
	ufshcd_configure_wb()
	- modify document description for wb_buf_flush_en attribute
	- fix some dev_err messages
V7:
	- renaming sysfs attribute name 
	  (wb_buf_flush_en -> enable_wb_buf_flush)
	- update document description
	- change debug message level (info -> dbg)
	  (5.19/scsi-fixes, https://git.kernel.org/mkp/scsi/c/2ae57c995003)

Jinyoung Choi (6):
  scsi: ufs: wb: Change wb_enabled condition test
  scsi: ufs: wb: Change functions name and modify parameter name
  scsi: ufs: wb: Add explicit flush sysfs attribute
  scsi: ufs: wb: Introduce ufshcd_is_wb_buf_flush_allowed() to improve
    readability
  scsi: ufs: wb: Modify messages
  scsi: ufs: wb: Move the comment to the right position

 Documentation/ABI/testing/sysfs-driver-ufs |  9 +++
 drivers/ufs/core/ufs-sysfs.c               | 47 ++++++++++++++-
 drivers/ufs/core/ufshcd-priv.h             |  6 ++
 drivers/ufs/core/ufshcd.c                  | 70 ++++++++++++----------
 include/ufs/ufshcd.h                       |  1 +
 5 files changed, 99 insertions(+), 34 deletions(-)

-- 
2.25.1
