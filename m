Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1654D106
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiFOShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:37:14 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8413151F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:37:13 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FHGlT9017477;
        Wed, 15 Jun 2022 18:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=d8XMAARgmnvj7xzWvqVtF6dIUJY16r1BmnSQrSMGTqQ=;
 b=iJW9MxtP5ygLHuflc+Z3XqBWp9H4XpEKXScXERkUYnwYMmAY+HE1XAvb41ITd56pXXA3
 V5na3ku1JfXv574YmKGC/M/7mhiWfpc2DBjUKKKqc0wj+juEBqwjKQf1C0hVZ1OexvMJ
 UhW71beZa99rXAHxzfDfIV7j2AIr6Y2vzrywNmuELHxca+PZzGNRHPkXSYS4zfnYNTnh
 PY42uVWWU2XEY8giMLw8NGpPDDAgjVDnhpXnXulwk8nQWdN93PuIlHdPOE0yRKLKOVIb
 QN6d8R1hnBo8oeAA+JvZq0qP9NKn15D6FeZ8kKIGEbNt1k166dqT+2+ZFlnxgWGelNa1 cQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gqh1ftb8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 18:36:53 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 58A038058C1;
        Wed, 15 Jun 2022 18:36:51 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AAB04803D8C;
        Wed, 15 Jun 2022 18:36:50 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 42142302F481D; Wed, 15 Jun 2022 13:36:50 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Kevin Tian <kevin.tian@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Date:   Wed, 15 Jun 2022 13:36:50 -0500
Message-Id: <20220615183650.32075-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8YzfRBAg7HrDz3A532e43JIerEl_zZPJ
X-Proofpoint-ORIG-GUID: 8YzfRBAg7HrDz3A532e43JIerEl_zZPJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_15,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150069
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support up to 64 sockets with 10 DMAR units each (640), make the
value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
set.

If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
remapping doesn't support X2APIC mode x2apic disabled"; and the system
fails to boot properly.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---

Note that we could not find a reason for connecting
DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
it seemed like the two would continue to match on earlier processors.
There doesn't appear to be kernel code that assumes that the value of
one is related to the other.

v2: Make this value a config option, rather than a fixed constant.  The default
values should match previous configuration except in the MAXSMP case.  Keeping the
value at a power of two was requested by Kevin Tian.

v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.

 drivers/iommu/intel/Kconfig | 7 +++++++
 include/linux/dmar.h        | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 39a06d245f12..07aaebcb581d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -9,6 +9,13 @@ config DMAR_PERF
 config DMAR_DEBUG
 	bool
 
+config DMAR_UNITS_SUPPORTED
+	int "Number of DMA Remapping Units supported"
+	depends on DMAR_TABLE
+	default 1024 if MAXSMP
+	default 128  if X86_64
+	default 64
+
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 45e903d84733..0c03c1845c23 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -18,11 +18,7 @@
 
 struct acpi_dmar_header;
 
-#ifdef	CONFIG_X86
-# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
-#else
-# define	DMAR_UNITS_SUPPORTED	64
-#endif
+#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
 
 /* DMAR Flags */
 #define DMAR_INTR_REMAP		0x1
-- 
2.26.2

