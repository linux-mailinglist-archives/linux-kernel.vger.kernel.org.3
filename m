Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56424F1EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381615AbiDDVuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379598AbiDDRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:44:12 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980431DE7;
        Mon,  4 Apr 2022 10:42:15 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234D8Kdg016032;
        Mon, 4 Apr 2022 17:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=PpctgGHHZ4DF//2UP3E/MPy26iNRxSNOmTkDvxyr8t4=;
 b=gmmHpUnlfCL7s3ICxAfhNj4jwf2p5PREI9AczYbRh9sYr1ItW/M8ZteQC6QVUh8iMDho
 28m2YzAyVs3jPDaqiUGnc28sFHFI6ySQ/LYNl1ROqg0szjK4eQXosnumF3oBU6a/LXh2
 MsYXM3LCRgypx8iPjhZbdcARzDQVMUwQCU/xu0vTUqxt6LImtX/yZ2L+LyKOZI66oBvp
 zlXtJWX9cijB9oO6xA0O3nryOP5y4TrBzdJKDEzWFCj/jT8WcjxnirNeOuwIrEdjQ60t
 kR0dQG3GNTNcXXzsrIGWqSt2gRh8KMUhsDVAhPiYHtrD+6O4LntWRkhTmM5cCafFhQ1C PA== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f819q2r08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 17:41:36 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id D53EF5C;
        Mon,  4 Apr 2022 17:41:35 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 34FCD48;
        Mon,  4 Apr 2022 17:41:32 +0000 (UTC)
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
Subject: [PATCH v3 0/3] x86/platform/uv: UV Kernel support for UV5
Date:   Mon,  4 Apr 2022 12:41:08 -0500
Message-Id: <20220404174111.262414-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hr38WTG2GIu1LwBLlVXGqpY74WYOF1aA
X-Proofpoint-ORIG-GUID: hr38WTG2GIu1LwBLlVXGqpY74WYOF1aA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_06,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=603
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send a second time on 04/04/22, sent first time on 03/18/22.

v2: Delete patch to remove SCRATCH 5 NMI support check for
    UV2 and UV3k systems with old NMI support function.

v3: Fix check BIOS NMI support mistake in Patch 1.

    Update NMI setup for UV5
	Update NMI handler to interface with UV5 hardware. This involves
	changing the EVENT_OCCURRED MMR used by the hardware and removes
	the check for which NMI function is supported by UV BIOS.  The
	newer NMI function is assumed supported on UV5 and above.

    Update TSC sync check for UV5
	Update TSC to not check TSC sync state for uv5+ as it is not
	available.  It is assumed that TSC will always be in sync for
	multiple chassis and will pass the tests for the kernel to
	accept it as the clocksource.  To disable this check use the
	kernel start options tsc=reliable clocksource=tsc.

    Log gap hole end size
	Show value of gap end in the kernel log which equates to number
	of physical address bits used by system.  The end address of
	the gap holds PA bits 56:26 which gives the range up to 64PB
	max size with 64MB of granularity.

Mike Travis (3):
  x86/platform/uv: Update NMI Handler for UV5
  x86/platform/uv: Update TSC sync state for UV5
  x86/platform/uv: Log gap hole end size

 arch/x86/kernel/apic/x2apic_uv_x.c | 20 +++++++++++++++-----
 arch/x86/platform/uv/uv_nmi.c      | 21 +++++++++++----------
 2 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.26.2

