Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C594D0D39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbiCHBH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCHBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:07:18 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87B30F6C;
        Mon,  7 Mar 2022 17:06:23 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2280otSB002947;
        Tue, 8 Mar 2022 01:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=Vf6llCTTFnBc1RMX8sG6y05Dz+GYq2SIGhea04ggvh4=;
 b=X5Qahmga4vr7LC8p14WwvHhmkXVcuBmrb7cj1+qI0fZsQ8c5SM864XrbDBTFfXcr6cZV
 mHSPGtI1G+xzJWrA5RzDlMxKRfvjBLtrK7Hfa10fijsklRn7PJnQdlrvec8HcrrmwCah
 UOpsJQUCJuume1pJOA3hN2Cj9dGoK4k5/kJR8tiNS7mvBT+wRVoxIhF9X6g8WA90NzX3
 CtmEGlwLztDPGd9Xe/PtF62Mik80HEZTaRBCcp+ewUTQimujwm0CFDDqPyhmtb3xrKBp
 9UV7R/ruaa9cE968HspE/aV4KuofFh9Ndk1mEV+kWLDe/Ejf3i/2s7mf0IGPr8kaGupP cA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3envxw02xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 01:05:49 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id CABD057;
        Tue,  8 Mar 2022 01:05:48 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 608644C;
        Tue,  8 Mar 2022 01:05:46 +0000 (UTC)
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/4] x86/platform/uv: UV Kernel support for UV5
Date:   Mon,  7 Mar 2022 19:05:33 -0600
Message-Id: <20220308010537.70150-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: trtr7n29Trqh3D19BI3Es6d54gT3P38r
X-Proofpoint-ORIG-GUID: trtr7n29Trqh3D19BI3Es6d54gT3P38r
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_12,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxlogscore=390 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080000
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


    Remove obsolete scratch5 NMI handler
	Removes obsolete scratch5 NMI handler only used in UV1 and early UV2
	systems.

    Update NMI setup for UV5
	Update NMI handler to interface with UV5 hardware. This involves
	changing the EVENT_OCCURRED MMR used by the hardware and removes
	the check for the newer NMI function supported by UV BIOS.

    Update TSC sync check for UV5
	Update TSC to not check TSC sync state for uv5+ as it is not
	available.  Therefore it is assumed that TSC will always be in
	sync for multiple chassis and will pass the tests for the kernel
	to accept it as the clocksource.  To disable this check use the
	kernel start options tsc=reliable clocksource=tsc.

    Add gap hole end size
	Show value of gap end in kernel log which equates to number of
	physical address bits used by system.  The structure stores PA
	bits 56:26, for 64MB granularity, up to 64PB max size.


Mike Travis (4):
  x86/platform/uv: Remove Obsolete Scratch5 NMI handler
  x86/platform/uv: Update NMI Handler for UV5
  x86/platform/uv: Update TSC sync state for UV5
  x86/platform/uv: Add gap hole end size

 arch/x86/include/asm/uv/uv_hub.h   |  6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c | 20 +++++++++++++++-----
 arch/x86/platform/uv/uv_nmi.c      | 27 ++++++++++++---------------
 3 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.26.2

