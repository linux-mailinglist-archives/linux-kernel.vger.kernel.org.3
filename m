Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB7358209C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiG0G7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiG0G7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:59:18 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E027175
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:59:07 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220727065905epoutp0375b0a8d825352d92458e4e93571b41f4~FnXDYugAi1467114671epoutp03B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:59:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220727065905epoutp0375b0a8d825352d92458e4e93571b41f4~FnXDYugAi1467114671epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905145;
        bh=lNNfLiLq987R9+I+SlWzlrwsx34BfKrbsSzg18k1BO4=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=D8IIiIIBBQB75u8AF4W+Jiz36v3io1J77S12mn7PU8cvZsROrGPF4Ya13psG9PGGj
         fVjfH0DFWtzNH1pKD98RITKQYB5dNyY8jQ830HNG4ayuJk90U3qYZuJN8SDb1Bjhf9
         Bc5uQN5si0JSebfrf7TEpLAbn9rM9/JogbQ6hjKQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220727065905epcas2p46087a372261c557b2b8689796a468825~FnXC2lDm81032510325epcas2p4O;
        Wed, 27 Jul 2022 06:59:05 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lt4Q04KhJz4x9Pv; Wed, 27 Jul
        2022 06:59:04 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-b6-62e0e2389809
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.57.09666.832E0E26; Wed, 27 Jul 2022 15:59:04 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 0/7] scsi: ufs: wb: Add sysfs attribute and cleanup
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
Message-ID: <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
Date:   Wed, 27 Jul 2022 15:59:04 +0900
X-CMS-MailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmqa7FowdJBk3nFSxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtevu3slksurGNyeLyrjlsFt3Xd7BZLD/+j8mB2+PyFW+P
        xXteMnlMWHSA0eP7+g42j49Pb7F49G1ZxejxeZOcR/uBbqYAjqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
        qQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RmfrtkVTOCouL6qgaWBcRdb
        FyMHh4SAiUT3AtEuRi4OIYEdjBI7pj5kBonzCghK/N0hDGIKC7hJHH1u0sXICVSiJHFuzSxG
        iLCBxK1ec5Awm4CexM8lM9hApogInGWWWPhwChNIQkKAV2JG+1MWCFtaYvvyrYwQtobEj2W9
        zBC2qMTN1W/ZYez3x+ZD1YhItN47C1UjKPHg526ouKTEoUNfoa7Pl9hwIBAiXCPxdvkBqBJ9
        iWsdG8HW8gr4Sizp/cUKYrMIqEp0rfwKtcpF4sv8N2A1zALyEtvfzgF7nFlAU2L9Ln2I6coS
        R26xwDzSsPE3OzqbWYBPouPwX7j4jnlPmCBa1SQWNRlBhGUkvh6eD1XiIdF2qINpAqPiLEQg
        z0JywiyEExYwMq9iFEstKM5NTy02KjCEx2pyfu4mRnBa1XLdwTj57Qe9Q4xMHIyHGCU4mJVE
        eBOi7ycJ8aYkVlalFuXHF5XmpBYfYjQFen4is5Rocj4wseeVxBuaWBqYmJkZmhuZGpgrifN6
        pWxIFBJITyxJzU5NLUgtgulj4uCUamBS9L+2Z3ecYefWjVEr3G9vKZmYMnd6d/P2li317SFN
        T4zCX1yLD7U+0HfWcf3+mJdmq9jOczEDk8qpOX/jkhsmb2ie18aukBrLvN+6KenWG+PAO1k3
        FC/s3NB29f63OCWXnx3fjwT9/LQm9bmHBId6hImh4y7FOXfudJtvyfzo1p0TH7Zy7t8Ns58+
        O7pA6lJfW3COYp/J+orlrR8mNnikyp9bdU6rIUUvN3f+f2VXc6kNrSvUl4V6cUiyRxRKvVuV
        qrHlf4teUt8iwf/Fy5SrzrxZHeMqVPTqZ9ueP7b/t9mWMC1nED7XOm1NkFdbg4XIp7R/CVzB
        TPM8rK61J02rTRQIfZ4upHzWv/J4mxJLcUaioRZzUXEiAHfwaP80BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
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

Jinyoung Choi (7):
  scsi: ufs: wb: Move ufshcd_is_wb_allowed() to callee function
  scsi: ufs: wb: Change wb_enabled condition test
  scsi: ufs: wb: Change functions name and modify parameter name
  scsi: ufs: wb: Add explicit flush sysfs attribute
  scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
  scsi: ufs: wb: Modify messages
  scsi: ufs: wb: Move the comment to the right position

 drivers/ufs/core/ufs-sysfs.c | 46 +++++++++++++++++++++++-
 drivers/ufs/core/ufshcd.c    | 69 +++++++++++++++++++-----------------
 include/ufs/ufshcd.h         |  7 ++++
 3 files changed, 89 insertions(+), 33 deletions(-)

-- 
2.25.1
