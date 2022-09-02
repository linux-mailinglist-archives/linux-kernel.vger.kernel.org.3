Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C575AA6B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiIBECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:02:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC8B56C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 21:02:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2822hkR8025773;
        Fri, 2 Sep 2022 04:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RwLiYzXm6r2X0x4XwkSBRoKpf6qf5vVIv6Dkj9YDXz8=;
 b=ADmkc5QA35z3i+QHOLEdEuRAR6SbmQ+jJBSdp5ewmMZ+NU2lrgSFtRLHLC9Li+68PYG2
 QNJbQ6xG5+xs6Wls/FxF1ARIXcFriscoWO6tnsJyO8xssjRMtjI+sVSnnsM9hl/83yPW
 8vdWXMB93KFxsYDn94LN8acqlkjUxfbUJmFIM+qafFM8joLPYUvS0JxhSTTzB1EkslWL
 rMf50173+/MttVBUOq3lljA8hVuGHDZMM2NhF2p3EKh5oF7AxIkv/MfV+vEjydjW+n2G
 VUZkaoqNektl9nK34PVkcNRKyaH152dS6kKHBk6esf3lYBSJfMB6b1xB1v4Y4e+K+PPx 8g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jarc83emg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 04:01:48 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28241lU6011351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 04:01:47 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 21:01:47 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Alexandru Elisei" <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH] KVM: arm64: Report Protected KVM cap only if KVM is enabled
Date:   Thu, 1 Sep 2022 21:01:22 -0700
Message-ID: <20220902040122.346654-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DfMzIoHNv196IU4pP0vUlh7u1aZbRIJQ
X-Proofpoint-GUID: DfMzIoHNv196IU4pP0vUlh7u1aZbRIJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "kvm-arm.mode=protected" is present on kernel command line, but the
kernel doesn't actually support KVM because it booted from EL1, the
ARM64_KVM_PROTECTED_MODE capability is misleadingly reported as present.
Fix this by adding a check whether we booted from EL2.

Cc: Will Deacon <will@kernel.org>
Cc: David Brazdil <dbrazdil@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8d88433de81d..866667be0651 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1974,7 +1974,7 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 #ifdef CONFIG_KVM
 static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, int __unused)
 {
-	return kvm_get_mode() == KVM_MODE_PROTECTED;
+	return is_hyp_mode_available() && kvm_get_mode() == KVM_MODE_PROTECTED;
 }
 #endif /* CONFIG_KVM */
 

base-commit: 0982c8d859f8f7022b9fd44d421c7ec721bb41f9
-- 
2.25.1

