Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432A35B106D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIGXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIGXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:33:26 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561EC3F62;
        Wed,  7 Sep 2022 16:33:25 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Dd22m021501;
        Wed, 7 Sep 2022 16:33:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=Hc31V8ZuqZz5YhbVQYoEhOrae4ibNDQKAwszi1N7H8o=;
 b=ISylTUr4Q1Rfq8w3VfpntidlymmubYeHOUjnrJtUS3J+8BHHCUswZA6FeBkwkV/w/T52
 ABafw7aGOjSE+f9lQ2wUvkP8YUsYAyHVI5YwlE2TzNnQ99EqBcEttO9nI5/c4434kChX
 tUeLhff66OdX8cPapwRsa8eVU2KogMa6anOLFaecBCPPqd/gjLjzqSRrivf9ItMDRNBO
 iL2ARPqTtDJ18ngahCEbfM8g8HzO69673AoEUHpVRK47La0ykPJvUu86xJeTh7kC3wzb
 wqGrZ4flIi/OKhfkPD8rs/0VpPjtQjM6YSYh50i+DcnPQFAR9mwp5bkklFA2Q7BAclAF Mw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6eq0tgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 16:33:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 7 Sep
 2022 16:33:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Sep 2022 16:33:19 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id E74A03F7126;
        Wed,  7 Sep 2022 16:33:19 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id BEB1E228060; Wed,  7 Sep 2022 16:33:19 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Subject: [PATCH v3 0/1] Tracing: Compile error with qla2xxx
Date:   Wed, 7 Sep 2022 16:33:07 -0700
Message-ID: <20220907233308.4153-1-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GJQTJkYrv6t67i2Yu92tfQHhIQOq_I0q
X-Proofpoint-GUID: GJQTJkYrv6t67i2Yu92tfQHhIQOq_I0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
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
when CONFIG_TRACING is disabled.

Hi Martin,

Please apply this patch to the SCSI tree once Steve approves it. Here
is a link to the discussion:
    https://lore.kernel.org/linux-scsi/YxdZ%2F9XOsWilvVSd@debian/T/#m6efb601ed65c907124a03cfd5f3f38f1eb8c5925

Changes from V2:
    * Incorporated Bart's review comments (use of git clang-format)

Changes from V1:
    * Incorporated Steve's review comments (change to inline etc.)

Regards,
-Arun

Arun Easi (1):
  tracing: Fix compile error in trace_array calls when TRACING is
    disabled

 include/linux/trace.h | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

-- 
2.9.5

base-commit: efca52749564601de2045eb71dbe756b7bade4e8
