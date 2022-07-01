Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6955E562CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiGAHo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:44:26 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4597D3819F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:44:24 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220701074422epoutp04f12abb312d0eb3b1c7e90cdca81c2b9e~9pNKV5Piu3045330453epoutp04R
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:44:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220701074422epoutp04f12abb312d0eb3b1c7e90cdca81c2b9e~9pNKV5Piu3045330453epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656661462;
        bh=xfYOrQ+4hivqp2gEfSionOxsv4wOOKujiLYahF+aDNA=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=JR8aHrBHXW8nEJfr0zNkor1H+7IANrNFTS9zTsUWcslq/U2kIyY1Cy1ykX5Pg7Wzf
         XqN4ZAleVmgWRHURg67gh0UEkfzy+r3oVglowwyESmUIpRbfh4EjGRF8sdkusgciii
         lxHhbDUuZgWMXfmWw/7rTAK7PLTde1RpQAT4/efg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220701074421epcas2p3efeff3c5c6f4296c36b34c0868ae9627~9pNJq4IIM1390113901epcas2p3G;
        Fri,  1 Jul 2022 07:44:21 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LZ6fF1MmLz4x9Pt; Fri,  1 Jul
        2022 07:44:21 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-e1-62bea5d4dd4b
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.E2.09662.4D5AEB26; Fri,  1 Jul 2022 16:44:20 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 0/2] scsi: ufs: wb: Add sysfs and cleanup
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
Date:   Fri, 01 Jul 2022 16:44:20 +0900
X-CMS-MailID: 20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmhe6VpfuSDPb/UrM4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1eHtK06O3fymax6MY2JovLu+awWXRf38Fmsfz4PyYHbo/LV7w9
        Fu95yeQxYdEBRo/v6zvYPD4+vcXi0bdlFaPH501yHu0HupkCOKKybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf8XLiKreA7S8XXOx9YGxg/
        M3cxcnJICJhIrFn3ibWLkYtDSGAHo8TCpj+MXYwcHLwCghJ/dwiD1AgL2Eis6P0EVi8koCRx
        bs0ssBJhAQOJW73mIGE2AT2Jn0tmsIGMERE4yyyx8OEUJoj5vBIz2p+yQNjSEtuXb2WEsDUk
        fizrhbpBVOLm6rfsMPb7Y/OhakQkWu+dhaoRlHjwczdUXFLi0KGvbCA3SAjkS2w4EAgRrpF4
        u/wAVIm+xLWOjWBreQV8JW7s3QpmswioSkzr3MkKUeMicbSlHexMZgF5ie1v5zCDjGQW0JRY
        v0sfYrqyxJFbLDCPNGz8zY7OZhbgk+g4/BcuvmPeEyaIVjWJRU1GEGEZia+H50OVeEgceX+J
        eQKj4ixEKM9CcsIshBMWMDKvYhRLLSjOTU8tNiowgUdscn7uJkZwctXy2ME4++0HvUOMTByM
        hxglOJiVRHjZ5u1NEuJNSaysSi3Kjy8qzUktPsRoCvT8RGYp0eR8YHrPK4k3NLE0MDEzMzQ3
        MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAlPU2vPdBwatEEW3pXNX5539MfXlj4obj
        X28l8gb4L8xfuE5D6VnJd+abe/ManvyvcTXcWbnCUSzoUJCU7Zb9FpLqnc1T78Y2C/3u3Xin
        Jo+1xTw25sfKyXtLXeUW9cw5z/PRdI+pxPM1igUlknMeJ/+7NK3o6oPPvz9ekGI3sDN5L8x8
        MMN5mYDiHnemqQ77HB4c+114ybDvZ8D7loaqXfs3XZpY8z6sSc3i49Qlbhf9Px1dIr+wJDPU
        SS+Y40/5pvOrDX24VJPfzO/jsS/avM2yZK72XB/xwI/Rtn/Vrfes6juU1rDa4pSmZSfbu5/3
        N4kvYvZY3RfGraqxxPuXRlSXWIv0pqg+9hnxDo4XlViKMxINtZiLihMBLS9xnjcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95
References: <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to clean up UFS's Write Booster code and adds sysfs
which can control the specific feature of it.

V2:
	- modify commit message
	- move & modify err messages
	- remove unnesscessary debug messages
V3:
	- split patch (functional, non-functional)

Jinyoung Choi (2):
  scsi: ufs: wb: renaming & cleanups functions
  scsi: ufs: wb: Add Manual Flush sysfs

 drivers/ufs/core/ufs-sysfs.c | 46 +++++++++++++++++++++++-
 drivers/ufs/core/ufshcd.c    | 69 +++++++++++++++++-------------------
 include/ufs/ufshcd.h         |  7 ++++
 3 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.25.1
