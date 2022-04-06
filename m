Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EC4F6C33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiDFVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDFVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:10:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4904B1C4;
        Wed,  6 Apr 2022 12:52:29 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 236HP4Xx022099;
        Wed, 6 Apr 2022 19:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=TeLjmDe8KaYmNQLUDpQGazX6OlQUYNJzNKjtmOt/48Q=;
 b=L87jj346LoirwCN8Q4JcSxtZUlqynfdKOFFPovBVCJjoDqPLTMfNjXlJJ9aMmq37q7ko
 8MM55w5u/WKaDD86WSa/zdf8bFQCJS2GNsvjlO2khUSOn8YiBiXNwcRvUooYyefgawFu
 ERwSE/Z5r7bjDB7inlo0jZf1aMQFl2llmBo0DUbPJ3y5k7wQF6IgHPid1tOubL6/ZyyR
 Jd9pMdFAFY98NFpJz1qo4gS+rsuYyIHoHnz7yAwkej3zWBIxuu7cbyeSoSrYcSRsL1+N
 q663yrJXGC1FkBiWr21emNJu76bDp7XZdqCFd/6zkZD73x1Pwo8eKK8aKEAfgmld/BL5 Sw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3f9cuc2n41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 19:51:51 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id AB4A659;
        Wed,  6 Apr 2022 19:51:50 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 4C0BE4B;
        Wed,  6 Apr 2022 19:51:50 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C6EC8302F46FE; Wed,  6 Apr 2022 14:51:49 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 0/3] x86/platform/uv: UV Kernel support for UV5
Date:   Wed,  6 Apr 2022 14:51:46 -0500
Message-Id: <20220406195149.228164-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
X-Proofpoint-GUID: evaS46WmeaNDVqCkJvZLXnImLr8xIcrW
X-Proofpoint-ORIG-GUID: evaS46WmeaNDVqCkJvZLXnImLr8xIcrW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_11,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=772
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Delete patch to remove SCRATCH 5 NMI support check for
    UV2 and UV3k systems with old NMI support function.

v3: Fix check BIOS NMI support mistake in Patch 1.

v4: Clarify commit messages and comments in all 3 patches.
    We hope this addresses the issues raised by Thomas Gleixner in
	https://lore.kernel.org/r/87zgl02w6v.ffs@tglx

    Update NMI Handler for UV5
	Update NMI handler for UV5 hardware. A platform register
	changed, and UV5 only uses one of the two NMI methods used on
	previous hardware.

    Update TSC sync state for UV5

	The UV5 platform synchronizes the TSCs among all chassis, and
	will not proceed to OS boot without achieving synchronization.
	Previous UV platforms provided a register indicating
	successful synchronization.  This is no longer available on
	UV5.  On this platform TSC_ADJUST should not be reset by the
	kernel.

    Log gap hole end size
	Show value of gap end in the kernel log which equates to
	number of physical address bits used by system.

Mike Travis (3):
  x86/platform/uv: Update NMI Handler for UV5
  x86/platform/uv: Update TSC sync state for UV5
  x86/platform/uv: Log gap hole end size

 arch/x86/kernel/apic/x2apic_uv_x.c | 16 +++++++++++++---
 arch/x86/platform/uv/uv_nmi.c      | 20 ++++++++++----------
 2 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.26.2

