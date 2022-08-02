Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7373E58789A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiHBICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbiHBIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:01:58 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1B335
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:01:52 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802080147epoutp01f2777eb598c75ec8801ca47d18b55599~HeFgkwcs92048420484epoutp01k
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:01:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802080147epoutp01f2777eb598c75ec8801ca47d18b55599~HeFgkwcs92048420484epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427307;
        bh=HGfoqHAh01x+ADFSlz3RVwu54/OZbceLCq0l2/IsZdg=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=L6X2XB2vjHOVl7kFVbcpe281wSNzU6j8l1lmH52X2UnJoQ7xr5ViWLOJ02e3aYH+A
         rD23NoHcTU859XQZQOkqK8cxPA2Bqiz7hBePd4UamPjDvlhEtv4DXVxb7+VNOyamDE
         MtCXeUmVcwkpU/kkvVvtlm43K+fg56hIzJrreZx4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220802080147epcas2p2fb27fbea63c2dfc80594325b58948984~HeFf-QtSt2257222572epcas2p2l;
        Tue,  2 Aug 2022 08:01:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LxnWZ2rNpz4x9QN; Tue,  2 Aug
        2022 08:01:46 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-64-62e8d9ea2685
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.1A.09662.AE9D8E26; Tue,  2 Aug 2022 17:01:46 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 0/6] scsi: ufs: wb: Add sysfs attribute and cleanup
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
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
Date:   Tue, 02 Aug 2022 17:01:46 +0900
X-CMS-MailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmue6rmy+SDLoXC1icfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2la9PZvZbNYdGMbk8XlXXPYLLqv72CzWH78H5PF0q03GR14
        PC5f8fZYvOclk8eERQcYPVpO7mfx+L6+g83j49NbLB59W1YxenzeJOfRfqCbKYAzKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xs2DV5kL
        tnJXTO1Yy9bA+JSji5GTQ0LAROL0oX7WLkYuDiGBHYwS/34sYO5i5ODgFRCU+LtDGKRGWMBN
        YtqKVjYQW0hASeLcmlmMICXCAgYSt3rNQcJsAnoSP5fMYAMZIyLQxiJxrHMrM8R8XokZ7U9Z
        IGxpie3LtzJC2BoSP5b1QtWIStxc/ZYdxn5/bD5UjYhE672zUDWCEg9+7oaKS0ocOvSVDeQG
        CYF8iQ0HAiHCNRJvlx+AKtGXuNaxkQXiE1+JxYsqQMIsAqoS85fOZ4MocZE4ueQLE4jNLCAv
        sf3tHLDHmQU0Jdbv0ocYrixx5BYLzB8NG3+zo7OZBfgkOg7/hYvvmPeECaJVTWJRkxFEWEbi
        6+H5UCUeEttfX2WawKg4CxHIs5CcMAvhhAWMzKsYxVILinPTU4uNCkzg8Zqcn7uJEZxutTx2
        MM5++0HvECMTB+MhRgkOZiUR3jsuz5OEeFMSK6tSi/Lji0pzUosPMZoCPT+RWUo0OR+Y8PNK
        4g1NLA1MzMwMzY1MDcyVxHm9UjYkCgmkJ5akZqemFqQWwfQxcXBKNTB1Zd1If7AgQq09v59l
        9X+91ka3fZpakbPEdGZMvrKSj0OiyfhTimdTlkD7l+dzJ1UzSb2qkJ3eUjL1pLiF7yVzrypn
        ralPlhUt6tmmVvTfb9WEB4td7k3eczXg95wTHrK23ReX/Ni/Z1MF69P3Eo//Nnw2qWZf+3Pi
        gU9bbFZeVzhoKLeswX9n++0X2gFhWg7CsSmrYv4fqTj4KE/AUYbntHnXf6FjBwNXefZMLgl/
        0vexwDxi0zaezlnMc3bY5/vr3lut3bJT5/Za2yM+L57M+rlnZ+o0BwtpTm1J4Z0TjP3+3Hh/
        Z72cYNXmRbfYhOdOnFcyU7+wfrPN9yL2R2VsXYHtMVq2/w7b9nZ7v9yixFKckWioxVxUnAgA
        Nj0o60AEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Jinyoung Choi (6):
  scsi: ufs: wb: Change wb_enabled condition test
  scsi: ufs: wb: Change functions name and modify parameter name
  scsi: ufs: wb: Add explicit flush sysfs attribute
  scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
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
