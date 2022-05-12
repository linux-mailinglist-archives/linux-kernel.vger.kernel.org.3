Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A265250FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355766AbiELPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiELPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:13:36 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0226265B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:13:35 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CEt5it015938;
        Thu, 12 May 2022 15:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=/YEWxrPhlLh6CePIL0BsOiR5cQBtub4EQMXI9f9rhok=;
 b=oxKZOhLkdmrY4ThCsi+EDxVERUmhfI2CRsjj3IIioVVekhJW+KPmjNCYJQHMJLe+TYBA
 n4dBa1W/e+kowts6vfNgq9bP+PDL65xSXrNJrPKcpVJNctG9MQqIfKbT8EQyrCIwlDc2
 nAxaIrAcYgOneh9dshoyIhnrFDTF8LN97pMM9AM4tEYBG/durCW6W1Mr7Zp4ByB5Gwe7
 otnnQx+tDgzmKcAm02lCAwFhiRYMvgYFnNFQLrpsyBuX+4hEjTgI3SDNXMeypnWOB7HU
 LgK2Xi7Kv91RDulVCHgPW1mvuzJcdrkd/u+GzjgN2PzkyxeCuxtFIsV4jKikjTm3CRQJ kA== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g0uj3vtgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 15:13:11 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id B592A56;
        Thu, 12 May 2022 15:13:10 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 2539046;
        Thu, 12 May 2022 15:13:10 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id C675F30090F61; Thu, 12 May 2022 10:13:09 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Date:   Thu, 12 May 2022 10:13:09 -0500
Message-Id: <20220512151309.330068-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220505194658.246121-1-steve.wahl@hpe.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WkWMN80jBTgaSK4d3wDiBtfoldiJGW3s
X-Proofpoint-GUID: WkWMN80jBTgaSK4d3wDiBtfoldiJGW3s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120073
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---

Note that we could not find a reason for connecting
DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
it seemed like the two would continue to match on earlier processors.
There doesn't appear to be kernel code that assumes that the value of
one is related to the other.

v2: Make this value a config option, rather than a fixed constant.  The default
values should match previous configuration except in the MAXSMP case.  Keeping the
value at a power of two was requested by Kevin Tian.

 drivers/iommu/intel/Kconfig | 6 ++++++
 include/linux/dmar.h        | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 247d0f2d5fdf..fdbda77ac21e 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -9,6 +9,12 @@ config DMAR_PERF
 config DMAR_DEBUG
 	bool
 
+config DMAR_UNITS_SUPPORTED
+	int "Number of DMA Remapping Units supported"
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

