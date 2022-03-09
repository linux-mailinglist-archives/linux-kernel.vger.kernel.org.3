Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E44D2D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiCIKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiCIKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:41:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF87E1B;
        Wed,  9 Mar 2022 02:40:10 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2297glUV006440;
        Wed, 9 Mar 2022 02:40:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 mime-version; s=facebook; bh=SVkXT7Fs5n1wa+6aLKmHoGuP4C/EQZ0vDxV3vcSr7SQ=;
 b=dtn0WvfgaLePHTgIyN6uya5x+tZfSoRRjYErs3xlhfN56sMr2Dr1xcPnK6EQf9JbnCQZ
 4GXpYv5ldD+vJSHGxGTHOPjtW9D5/GkyWIylYSRc0rAwQBlWkmxLqVNqGPqTQa0a57DY
 If56OISGYWis+43MDr0Te7T1eUunrvBtR7Q= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ep2wh0vnh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 02:40:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLxRYB6EMEj7WotCVnKRLOBGEbMJBrhkwwXzxIBreQCjIspZDgy5QVqx6mRWNNcaPkhUdl70OWDQGBDCqQfULAEhktqZjlGyDx69q0VsUjHauwkevQm4bCgMPTyDqbVUb/BgSI058QLS4uF3TJd6otY8a9dT6xNXkx0C5RgFljhR6ZmGItuz6jG6pHe6LlYHI4o2aqBrQz1teKgHiGKj7kYX6rYcWv4b06FX7ocbhaDcbQjWCvEP3qw8zudQjI0CP1lot5FHyrSBcoV2dNxrAcqOBvReq6/kIIFjU6tOQ4JMs17GMD0FzMbTzNGX5k2Y8XgGc9hfe7b8j8qS2UWDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVkXT7Fs5n1wa+6aLKmHoGuP4C/EQZ0vDxV3vcSr7SQ=;
 b=C0bZD+e7tprBXv8zFZKHX0JSJkPBXz+fVkg2dFuddcVRYSUq8/g7kFCwtzr3xinh1J5Xxe368AjLvRbdTnsYWJ9ox+NnBm7tSj1AZkcEjyWuCR6d1SyrINqK6DrdYWL8PjtSW5oHaBhwmL4m4xVraQLR3W5z737AtTajMR2KjufzxDf+TT6dDDB/My/xwJHHS8M9HymE3pPudp8IQOGP7F9R+JxevfktriHdwe/4K+fqRehknPN4Sn8qQ4Fk+yAofogcdslNMcoKLr7vkSN6zJwDQgh9cKka/IANZr+HZKxEgx+M/POP2+WLqmSU+HSb3gILyVJsO5J5mhxHqFDLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MW4PR15MB4761.namprd15.prod.outlook.com (2603:10b6:303:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:40:04 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:40:04 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Dmitrii Okunev <xaionaro@fb.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Xiaoyan Zhang <xiaoyan.zhang@intel.com>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT status
Thread-Topic: [RFC PATCH] platform/x86: Add sysfs interface for Intel TXT
 status
Thread-Index: AQHYM6IJ2oHmymlKRU22/keFD+BGbg==
Date:   Wed, 9 Mar 2022 10:40:03 +0000
Message-ID: <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com> <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
In-Reply-To: <20220222093101.GA23654@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ed1ebd-8ba4-4a4a-2cd9-08da01b92bb7
x-ms-traffictypediagnostic: MW4PR15MB4761:EE_
x-microsoft-antispam-prvs: <MW4PR15MB476136604FF41B2F3BA92FAEC10A9@MW4PR15MB4761.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwTqH25+N3Wh7imxCp/69oODNXYLpjCFBHJ0b4uoiwHd/f+9YksRMK2BbYtLeGCMw1EuYG1jV+MGtOKSSrcsRBEbW6BzTtQjX3FvZWw0/c0Ex08kACzWW6tUDB/hWw5lIGt9fS3gN72YiFjrxb1evQjHn4PcYpizk8PD/xK638Ns7O0T5Eu8tGQdrjXN8dnX3qJHgq2lYe1YBHsB101tocuALbbtX5WKW/b2grwT471cqogaZGhsVAV5xMzAkxT2cD8dqtkWzcL1XB7smhJtuRiOkKM0KLRWQe4eaLXg067X1Aovgk69bSLRwEL+PQWzvpIEDdN8nbid87UP9VzfgXEI6PJ1nttFMMkUzRlkWFnHtOa5VP4pxY1/y8LbTPB67Od0D5J6UgFQcTa+9VU5ITYtg8QAsMJAEO4YrnxjTEikaTnyC4Kx/5wWWHkdtBc6a97T9rMFFxB7sNbAGNPjvjykEJEBU3bOL2S0Hmtv/QZfR+7gtXK4rINJbYe2tgpuizWo9Gxv0b6fq+bmWvzLrwjYxSzerSMoWKzYFlT6SVkSm9AzjRuuNrYgRmLdLSYgwpVnp8dCh5Tx+rZB9a7jB7Rext8q/44TFurTDS0Zb82Ly4Rma8XTtuJ4prMNbHwjseUMYtI+p+UKFTgPcEIdvn3/YztkSZF31lJ/tl7VN30/OtD7z6CHZ95kfatnjid2zquVfw6Y4mxe7XhO7QvD+PbsgFDs4yFAg8EzCBGBIEg1yg5CWimVm1flGX7ju7N9IGgn5MyuEMr/FC7tssXAZhKGbFauzl5YGtfaZ4HjoghL86gIq6+hHG8it/lElwJp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(38100700002)(122000001)(6506007)(26005)(186003)(2906002)(6486002)(508600001)(86362001)(66476007)(8936002)(7416002)(64756008)(38070700005)(66446008)(66946007)(91956017)(76116006)(66556008)(71200400001)(5660300002)(316002)(110136005)(9686003)(921005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pxdsmwdc+bR7qNQSsVWTYQkMJ7E6k40UKQ+e0V17Eoh5JjROr41QIMkSrkuV?=
 =?us-ascii?Q?GRZHqi3jA0p9BMNYp4Vy7MxV7QHaY4Xd4/fT49bZNjfww3vYQRHTR3oCcI2K?=
 =?us-ascii?Q?fzRPwka81Bb96LksddW/58eJg6EusXC2lGgNhJiEOT4ShpuZvog1z9CwG499?=
 =?us-ascii?Q?erQ75vs/wvMjfGoKdWLo/Unskpa8IFSG9eU9uNX3Z9iDznlA0OQZjWCoMjKx?=
 =?us-ascii?Q?PpRuvQmMgm4hxaXLkDeZLfK0De25dXe3t3/ufd5g8Ac4I+dLiTaNgrUoQgrr?=
 =?us-ascii?Q?98PUpTAT/20NMvJVjQj1R1XN5wfowo1vLZt067/x8PVAmcFA4IwzTCOtxRYZ?=
 =?us-ascii?Q?edeS1ursfXoYiCIRKCQKQDostox6cMRgNHZWuMvRSyW1PXtPrK0t3Rb2KVo9?=
 =?us-ascii?Q?X5trPZjLXpITfnaXv+DVTAs24tFkPD/F/qnlUN8aqbK8omcOPdaQKflSdC1g?=
 =?us-ascii?Q?CbkTWKVH5x9+CWs/rtYndEwmXe6wf+ZD7VTLser6RtuDkELu433BDGySVlPm?=
 =?us-ascii?Q?4IMZJaTiUvfvPi7mHbSbzhB98yzAqMs4PcDX/Kb6/lJ6xHFtQ3rHjTJGBmgo?=
 =?us-ascii?Q?GQ88xmLOCnJCBRv0p66e0L4SygCsSb40hALdkFQa5PH5sEqrkfLzbLsK/X+u?=
 =?us-ascii?Q?UmU3VJB/cnrbhUDYDl9RwVtK6+SQrXCwKOUCwLOZQ3EsRYof/oarxPwX1wvr?=
 =?us-ascii?Q?60D0EJZ2IqhDm1Uf9AUU0pQrMT5kUMYFMdsQGrTGlGNvTgLrlV/Kkm07IQz/?=
 =?us-ascii?Q?uzC8HUc0aadPt6+JjYKPTN7QS6FHakxJXkjvCBGNF1W9EjhMbF0AsuaQaGFo?=
 =?us-ascii?Q?+uiQA+eqdFHZRfpJEICWAWJ6bb5lESGlU3kypxgM9Rfb3p+LcowRq21P7qcr?=
 =?us-ascii?Q?NxzjpAdnV5bLCfQXLNfoju/LnuNupCjIKfvDN22MyVVqSj9/RepNGKdoipb6?=
 =?us-ascii?Q?KI98dSRQCU6q7JMJWxzQG36VdL1PpsaRY6EGRiLiTR39+lnklpgjbdOrhxQu?=
 =?us-ascii?Q?RjCz11wrwCJC7PB0Z/H21HXkLxs2GQ8l6dpGbfFB9SE9tYUCQVutWXqZuACS?=
 =?us-ascii?Q?SXigRCF0LfNQbMvby/ZBKC+WvbhDlE1m0ULwKSIvoYxLkvUqpcqNSseDPsBL?=
 =?us-ascii?Q?0zn5Qwwk2DwJESXhptlupzq0xe6yDYdA1h2hRto9GZcyUOJru9jT1Vs8O+ja?=
 =?us-ascii?Q?8AdCgC0fywTmn1qy3I/EEzlq1SqN9y/cZHa6MdHHutjXsMpj6jjOiPbsDLz6?=
 =?us-ascii?Q?wJQPYAXZWjFqlbTZURAePSQ5cobldluU/Zgn33nUCeBkupJn9s8ya9dlxZfi?=
 =?us-ascii?Q?3rlB7whB60vCdfYhwSqOT3PuaSC9RUQel1zwoEwLRY7oHIzCpLeZ/C22ovCD?=
 =?us-ascii?Q?vvw+4rT61zt8UxoBjkJTMJJ3sN9bQ3dIHzVsHOpgXm1fEswJrhhmlRDBtOwo?=
 =?us-ascii?Q?hMMZ2rHGUzHwXMLrJ9yrrZWIuYM2pWWtDHuJlKj/NKKYIM8cWhQ6CeECtg7g?=
 =?us-ascii?Q?ipazQY0dmxk8bwSkCM5BSdP9yya4OIEx23Ml4mHxB85/ce7NdBVFdvlki16v?=
 =?us-ascii?Q?7kqndma14kqnNK3z+XHqcUUP9u6nyvHmwls2JWwQ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1242C4E0B07A8746A0D0486F4A273A38@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ed1ebd-8ba4-4a4a-2cd9-08da01b92bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 10:40:03.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMjmy452vxIZpgYtGJ+n6QViP0NOs+L2OtqRaFOViB2LLcP5SID4BXAOaM52y/R9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4761
X-Proofpoint-GUID: hhVE6tQHiMIml5_BasnMG9PYA6gyBimi
X-Proofpoint-ORIG-GUID: hhVE6tQHiMIml5_BasnMG9PYA6gyBimi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is an RFC to see if the approach is generally acceptable; unlike
the previous driver this exposes the information purely as read-only
status information, so userspace can make an informed decision about the
system state without having to poke about in /dev/mem. There are still a
few extra registers I'm trying to dig up information for before a proper
submission.)

This module provides read-only access to the Intel TXT (Trusted
Execution Technology) status registers, allowing userspace to determine
the status of measured boot and whether the dynamic root of trust for
measurement (DRTM) has been fully enabled.

Tools such as txt-stat from tboot
<https://sourceforge.net/projects/tboot/> can make use of this driver to
display state rather than relying on access to /dev/mem.

See Documentation/x86/intel_txt.rst for more information about Intel
TXT.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 arch/x86/include/asm/txt.h             |  34 +++++
 drivers/platform/x86/intel/Kconfig     |  14 ++
 drivers/platform/x86/intel/Makefile    |   2 +
 drivers/platform/x86/intel/txt_sysfs.c | 185 +++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 arch/x86/include/asm/txt.h
 create mode 100644 drivers/platform/x86/intel/txt_sysfs.c

diff --git a/arch/x86/include/asm/txt.h b/arch/x86/include/asm/txt.h
new file mode 100644
index 000000000000..9c90d894c1af
--- /dev/null
+++ b/arch/x86/include/asm/txt.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * txt.h: Intel TXT (Trusted Execution Technology) related definitions
+ */
+
+#ifndef __TXT_H
+#define __TXT_H
+
+#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
+#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
+
+#define TXT_NR_CONFIG_PAGES	((TXT_PUB_CONFIG_REGS_BASE - \
+				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
+
+/*
+ * TXT configuration registers (offsets from TXT_{PUB,PRIV}_CONFIG_REGS_BASE)
+ */
+
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_ACMSTS			0x00A0
+#define TXT_CR_VER_FSBIF		0x0100
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_QPIIF		0x0200
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_DPR			0x0330
+#define TXT_CR_PUBLIC_KEY		0x0400
+#define TXT_CR_E2STS			0x08f0
+
+#endif /* __TXT_H */
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 8e65086bb6c8..ae8d032b4499 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -159,6 +159,20 @@ config INTEL_TURBO_MAX_3
 	  This driver is only required when the system is not using Hardware
 	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
 
+config INTEL_TXT_SYSFS
+	tristate "Intel TXT sysfs driver"
+	depends on HAVE_INTEL_TXT && SECURITYFS
+	help
+	  This driver exports the TXT (Trusted Execution Technology) public
+	  configuration space to user space via sysfs.
+
+	  These registers provide details about the status of the platform's
+	  measured launch and execution environment, allowing userspace to
+	  make trust based decisions. See tboot
+	  <https://sourceforge.net/projects/tboot/> and TrenchBoot
+	  <https://trenchboot.org/> for projects which implement the
+	  appropriate boot flow to fully enable these features.
+
 config INTEL_UNCORE_FREQ_CONTROL
 	tristate "Intel Uncore frequency control driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 35f2066578b2..ac73ac61090a 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -26,6 +26,8 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
+intel_txt_sysfs-y			:= txt_sysfs.o
+obj-$(CONFIG_INTEL_TXT_SYSFS)		+= intel_txt_sysfs.o
 intel_vsec-y				:= vsec.o
 obj-$(CONFIG_INTEL_VSEC)		+= intel_vsec.o
 
diff --git a/drivers/platform/x86/intel/txt_sysfs.c b/drivers/platform/x86/intel/txt_sysfs.c
new file mode 100644
index 000000000000..a8e51abc6854
--- /dev/null
+++ b/drivers/platform/x86/intel/txt_sysfs.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This module can be used to access below resources
+ *   - TXT config space
+ *   - SMX parameter
+ *
+ * Intel TXT (Trusted Execution Technology) will provide higher
+ * assurance of system configuration and initial state as well as
+ * data reset protection. It also helps solve real end user concerns
+ * about having confidence that their hardware is running the VMM
+ * or kernel that it was configured with, especially since they may
+ * be responsible for providing such assurances to VMs and services
+ * running on it.
+ *
+ * See Documentation/intel_txt.txt for more information about
+ * Intel TXT.
+ *
+ * Intel TXT configuration registers are a subset of chipset registers.
+ * These chipset registers that interact with SMX are accessed from two
+ * regions of memory, which represent the public and private configuration
+ * spaces, by system software using memory read/write protocols.
+ *
+ * Safer Mode Extensions (SMX) provide a processor's programming
+ * interface in an Intel TXT platform for system software to establish
+ * a measured environment within the platform to support trust decisions
+ * by end users.
+ *
+ * Data can be found below
+ *   /sys/devices/platform/intel_txt/...
+ */
+
+#include <linux/byteorder/little_endian.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/security.h>
+#include <linux/seq_file.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/txt.h>
+
+#define DEV_NAME "intel_txt"
+static struct platform_device *txt_pdev;
+
+static int txt_enabled_show(struct seq_file *m, void *v);
+static int txt_key_show(struct seq_file *m, void *v);
+static int txt_reg_show(struct seq_file *m, void *v);
+
+/* securityfs related data */
+static struct dentry *txt_dir;
+static void *txt_pub_regs;
+static struct txt_securityfs_file {
+	char *name;
+	u32 ofs;
+	int (*show)(struct seq_file *m, void *v);
+	struct dentry *dentry;
+} txt_securityfs_files[] = {
+	/* Raw registers */
+	{ .name = "acmsts", .ofs = TXT_CR_ACMSTS, .show = txt_reg_show },
+	{ .name = "didvid", .ofs = TXT_CR_DIDVID, .show = txt_reg_show },
+	{ .name = "dpr", .ofs = TXT_CR_DPR, .show = txt_reg_show },
+	{ .name = "errorcode", .ofs = TXT_CR_ERRORCODE, .show = txt_reg_show },
+	{ .name = "ests", .ofs = TXT_CR_ESTS, .show = txt_reg_show },
+	{ .name = "sts", .ofs = TXT_CR_STS, .show = txt_reg_show },
+
+	{ .name = "enabled", .show = txt_enabled_show },
+	{ .name = "publickey", .show = txt_key_show },
+};
+
+/* Shows if TXT has been enabled */
+static int txt_enabled_show(struct seq_file *m, void *v)
+{
+	/* If the BIOS has enabled TXT then the heap base will be set */
+	seq_printf(m, "%d\n", *(u64 *)(txt_pub_regs + TXT_CR_HEAP_BASE) != 0);
+
+	return 0;
+}
+
+/* Shows the 256 bit hash of the public key */
+static int txt_key_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%016llx%016llx%016llx%016llx\n",
+		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY)),
+		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 8)),
+		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 16)),
+		cpu_to_be64(*(u64 *)(txt_pub_regs + TXT_CR_PUBLIC_KEY + 24)));
+
+	return 0;
+}
+
+/* Show a generic 64 bit register */
+static int txt_reg_show(struct seq_file *m, void *v)
+{
+	struct txt_securityfs_file *ctx = m->private;
+
+	seq_printf(m, "%016llx\n", *(u64 *)(txt_pub_regs + ctx->ofs));
+
+	return 0;
+}
+
+static int txt_pub_reg_open(struct inode *inode, struct file *filp)
+{
+	struct txt_securityfs_file *ctx = file_inode(filp)->i_private;
+
+	return single_open(filp, ctx->show, ctx);
+}
+
+static const struct file_operations txt_pub_reg_fops = {
+	.open		= txt_pub_reg_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct x86_cpu_id smx_cpu_id[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_SMX, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, smx_cpu_id);
+
+static int __init txt_sysfs_init(void)
+{
+	int i;
+	int err;
+
+	if (!x86_match_cpu(smx_cpu_id))
+		return -ENODEV;
+
+	txt_pdev = platform_device_register_simple(DEV_NAME, -1, NULL, 0);
+	if (IS_ERR(txt_pdev))
+		return PTR_ERR(txt_pdev);
+
+	txt_pub_regs = devm_ioremap(&txt_pdev->dev, TXT_PUB_CONFIG_REGS_BASE,
+		TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt_pub_regs)
+		goto out;
+
+	txt_dir = securityfs_create_dir("txt", NULL);
+	if (IS_ERR(txt_dir)) {
+		err = PTR_ERR(txt_dir);
+		txt_dir = NULL;
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(txt_securityfs_files); i++) {
+		txt_securityfs_files[i].dentry = securityfs_create_file(
+				txt_securityfs_files[i].name, 0444, txt_dir,
+				&txt_securityfs_files[i],
+				&txt_pub_reg_fops);
+		if (IS_ERR(txt_securityfs_files[i].dentry)) {
+			err = PTR_ERR(txt_securityfs_files[i].dentry);
+			txt_securityfs_files[i].dentry = NULL;
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	for (i = 0; i < ARRAY_SIZE(txt_securityfs_files); i++) {
+		if (txt_securityfs_files[i].dentry != NULL)
+			securityfs_remove(txt_securityfs_files[i].dentry);
+	}
+	if (txt_dir)
+		securityfs_remove(txt_dir);
+	platform_device_unregister(txt_pdev);
+	return err;
+}
+
+static void __exit txt_sysfs_exit(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(txt_securityfs_files); i++) {
+		if (txt_securityfs_files[i].dentry != NULL)
+			securityfs_remove(txt_securityfs_files[i].dentry);
+	}
+	securityfs_remove(txt_dir);
+	platform_device_unregister(txt_pdev);
+}
+
+module_init(txt_sysfs_init);
+module_exit(txt_sysfs_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1
