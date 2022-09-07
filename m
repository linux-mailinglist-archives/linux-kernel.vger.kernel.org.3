Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694765AF9FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIGCiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIGCiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:38:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9595AF9;
        Tue,  6 Sep 2022 19:38:16 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286N60Xf029176;
        Tue, 6 Sep 2022 19:38:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ECePbD2fJWepM7h2Dm/bje6gLJSq0e2F+Na65094WFQ=;
 b=jS/CluztLYIUHJ1tNeY7IJB+nGEmiPSb1M0uo/q+Hl5ZzL7IEuKlVL2g6FBNu5NLHiUu
 hG7CtWy9N78QeawvGT1vQ+JEH89VgpFj3iwgDx+CjERnFJsL+Dwh2AyCdBtfjy2+QkrM
 64tmomIsqnr5d+uI0+9vi+K3PZeDEfFqA5TXfzhrEd3ZDaafZurj30Iqn+lg5G4+YDEK
 AE6NRxIJYkcbHd5vZNZ2kgIeJ/4Js3IR7wLr5yl15dcDf5jhLJkWXCPFA73qQDVNly2r
 1+EANgJsIRrskEjJQVVTY4hthdQAKB7hFiBLthsy+sDddL/yFXBv4w/Fu9T5r6PZCSQg Pw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jdxjemwt1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:38:13 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 6 Sep
 2022 19:38:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 6 Sep 2022 19:38:11 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 532113F70E8;
        Tue,  6 Sep 2022 19:38:11 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 3C48688D32E; Tue,  6 Sep 2022 19:38:11 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Subject: [PATCH 0/1] Tracing: Compile error with qla2xxx
Date:   Tue, 6 Sep 2022 19:37:59 -0700
Message-ID: <20220907023800.4095-1-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: pQKOhnM2KODPjLwe-GVtUZjdzJNUrDA-
X-Proofpoint-ORIG-GUID: pQKOhnM2KODPjLwe-GVtUZjdzJNUrDA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, et.al,

Please find a patch to fix compile error coming from qla2xxx driver
when CONFIG_TRACING is disabled. Perhaps not all of the functions
need to be "#define-d" out, but I just did it for completeness.

Hi Martin,

Please apply this patch to the SCSI tree once Steve approves it. Here
is a link to the discussion:
    https://lore.kernel.org/linux-scsi/YxdZ%2F9XOsWilvVSd@debian/T/#m6efb601ed65c907124a03cfd5f3f38f1eb8c5925

Regards,
-Arun

Arun Easi (1):
  tracing: Fix compile error in trace_array calls when TRACING is
    disabled

 include/linux/trace.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.9.5

base-commit: e699bb9765cd447ab477e9e888ddbab347dcf35a
