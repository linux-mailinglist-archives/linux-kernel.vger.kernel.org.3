Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107444D9EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349716AbiCOPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349698AbiCOPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:44:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757E12AAF;
        Tue, 15 Mar 2022 08:43:44 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22FEHnqx013671;
        Tue, 15 Mar 2022 15:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=fl6uS6zWkfiuQKU7eHmuVsjCUDUD7QTLilOsQRBJDlY=;
 b=SLCqedATfzIyUCK49RAK1YNCbEqN2eCPJ7cZoKPXNyvcXNmCh5FEOeEQoVMCYxt+wlJt
 TR4NPH1JbQZhu7G5S9dfH0ppVT23VeSchNaWG479zs4+2nBtNXNJ7dWz2FaLqhuLiTam
 uZhWp6a7oW8RhQUfDeoUMS5iYKFE6xkHZ2e8NvApWyK5BIYpc4bydkuGHt+r91MBNQav
 xYwbYSsedRnAlW9j2jYW2j27ag9xzNyg/HkZ0DaF/dxJmjh0Y/uwIZd70ftDQgO1VJ2b
 F1J9zkOKvlhye9OvnutuYngmxFB7C9TojIR3iHCKA+iNqRad9Dyab47c8rdTnlydUf4c 7w== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3etvec0v4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 15:43:06 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 3361857;
        Tue, 15 Mar 2022 15:43:05 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id AEA794A;
        Tue, 15 Mar 2022 15:43:04 +0000 (UTC)
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
Subject: [PATCH v2 0/3] x86/platform/uv: UV Kernel support for UV5
Date:   Tue, 15 Mar 2022 10:42:46 -0500
Message-Id: <20220315154249.201067-1-mike.travis@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 61Y_bvkGNELP7RcNJeraSTeddHGXdcc-
X-Proofpoint-ORIG-GUID: 61Y_bvkGNELP7RcNJeraSTeddHGXdcc-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=565 spamscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150101
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
 arch/x86/platform/uv/uv_nmi.c      | 22 ++++++++++++----------
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.26.2

