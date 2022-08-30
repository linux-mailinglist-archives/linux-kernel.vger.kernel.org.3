Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43B5A70CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiH3W1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiH3W06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:26:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95BE61DA4;
        Tue, 30 Aug 2022 15:25:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ULEBEc010330;
        Tue, 30 Aug 2022 22:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=jbm3UjDcY/kfdEXK+ypRM1eQgzrOIq0LYLt1nrVWse0=;
 b=oq+ZwbsM9oV7IY5h8mj74vJzYYB77WO4LBbbOvH+yqOy9PmFZebOte7Soa/PxHUNzruP
 cqy0KhsjIQFKMIMe/Mbo09sGk6EYOHCGvEdm2c1/dfAlH2lH7y6qwJz7n2EZrchCTpHL
 /oE7g8DHou3wcdjfjUn8ByumTOXZQmcatACSYIiKgnAWkddqAu65cCJXkG1HU719/WzT
 0k23jIvsXPx1ufxL3TZKDlQQEIWEkmCenoVNJWPkd8m8XxFGRiu1EshKQOm3vTrw//Hz
 lytfm9QXgRMOqBsevCVuWACcQv+GYBGpuO0CHR20ULWjVJYKB5dvaCmjJd9MnUgvDjls 3w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j9m2t1heg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27UMPICA020580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 22:25:18 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 30 Aug 2022 15:25:18 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [RESEND PATCH v2 0/5] SCM: Add support for wait-queue aware firmware
Date:   Tue, 30 Aug 2022 15:25:06 -0700
Message-ID: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3_xaYGEY4rEU_vTQgy6AWjqNaKRPwsBx
X-Proofpoint-ORIG-GUID: 3_xaYGEY4rEU_vTQgy6AWjqNaKRPwsBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the QCOM SCM driver to support firmware (FW) versions
that expect the high-level OS (HLOS) to be tolerant of SCM call requests not
being processed right away and, instead, being placed on a wait-queue in FW and
processed accordingly.

The problem this feature is fixing is as follows. In a scenario where there is
a VM in addition to HLOS (and an underlying hypervisor):

1. HLOS makes an SMC call on core 5
2. The hypervisor scheduling interrupt interrupts this SMC call.
3. The hypervisor schedules the VM on core 5.
4. The VM makes an SMC call on core 5.
5. The SMC call is non-interruptibly stuck on FW spinlock on core 5.
6. HLOS cannot reschedule since core 5 is not responding to Reschedule IPIs.
7. Watchdog timer expires waiting for core 5.

This problem is solved by FW returning a new return code SCM_WAITQ_SLEEP to
HLOS right away when it is overwhelmed by the VM's SMC call. HLOS then places
the call on a wait-queue and wakes it up when it receives an interrupt that
signifies "all-clear".

Additionally, this new design also supports scenarios involving only HLOS (and
no other VMs).  Such scenarios make use of a second new return code
SCM_WAITQ_WAKE.

There are three new SMC calls also being defined in this design that, together
with the two new return codes, form the handshake protocol between Linux and
FW.

This design is also backwards-compatible with existing firmware versions that
do not support this feature.

---
v2:
- Changes made to patches 4 and 5 are listed therein.
- Rebased dt-bindings on top of the YAML conversion patch [1].

[1] https://lore.kernel.org/lkml/20220708090431.30437-1-david@ixit.cz/
---

Guru Das Srinagesh (5):
  dt-bindings: firmware: qcom-scm: Add "allow-multi-call" property
  firmware: qcom: scm: Optionally remove SCM call serialization
  dt-bindings: firmware: qcom-scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue helper functions
  firmware: qcom: scm: Add wait-queue handling logic

 .../devicetree/bindings/firmware/qcom,scm.yaml     |  10 ++
 drivers/firmware/qcom_scm-smc.c                    | 140 +++++++++++++++++++--
 drivers/firmware/qcom_scm.c                        | 125 +++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  14 +++
 4 files changed, 279 insertions(+), 10 deletions(-)

-- 
2.7.4

