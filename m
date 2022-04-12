Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7714FE3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355620AbiDLOZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiDLOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:25:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940F4D61B;
        Tue, 12 Apr 2022 07:23:12 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23CCgLCv012609;
        Tue, 12 Apr 2022 07:23:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 mime-version; s=facebook; bh=Z777Q8Qk8O2EOLG0b2sWYT3t9JPHgMjhPJBZuhKnIV0=;
 b=nOpng+Fx/hGvf80zIQXM9LeEstv7eDhOX8Lr/iHATY14/EBDcCRDJku2Xc67PHDQLwgD
 ni/kwfGfTrxpQgxejWH6pHILz8RsoOgBfEnuPdIN4txIqQp4iyli3NWIj5aKXXet8eDt
 oQVyiTiO526ns7L9EEvDOHEDuPA5tjgYxX8= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fd9njrm41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 07:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ4xloS7AMES17XY7zWJ5GsE3525HlXq+tS6LoV8+bHbXsaYdylCc3o1sKSieVCD50B138LLbbxRhSV+i3mEWHwqohdNZQRtkvZyf0dX4Z5uyzB3rGcD1pl1HEYDGmDAzRsMoj8eRZjZkgA4Kr5NUIcWkrhiz5kbEMkJAi5ity9loYXu6kbQ+gEkCOc49QBl0+nmtg0w9YfOg+EcL/MfKr7N5gP7GacSlgrtXMCgZrWT3o+0gI4Tcz8TbVezXZEn6RsMPPFdH7GyUgUP4mUTU/FCNQ2pm8rmOt4FZeKczxs0lkHzVmjgNdHaVvXpulvvmFHRhazOmBQIq6ghkV6Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z777Q8Qk8O2EOLG0b2sWYT3t9JPHgMjhPJBZuhKnIV0=;
 b=TpG2JWkYgIzU0q9K3doZglK2JoSIlWYn4Tv2K9jePzyGNy82O9ULwqNsZyGdfF5KU7rbphRv3ep7tcxkVICmYMM+b301qxRZjPVRTnRyW3taOglz5dFtnleAXSMX3Zm3Y/GlKIh1LrMLLy1IggCEkkzG9JtDZFd6oXEnLK/Ql58GlHaeC91A2J0Gl7Pi5W3US/i4j3BpEyRz4EhD4s6CeXbsi7f8VcfBf+cxDbX55JcgZ6T2PBMI6fKyCj+mxd8mJH+zry4nloBtUx1Ae4op1/FlQR1KMXUFnly37TOjgPS3O6RGpeH970FWD05dFVRtAnglYDjg7FkY8kcXbZ1O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB2793.namprd15.prod.outlook.com (2603:10b6:5:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 14:23:06 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::af:a5d5:458b:4f4e%7]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 14:23:06 +0000
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
Subject: [RFC PATCH v2] platform/x86: Add securityfs interface for TXT status
Thread-Topic: [RFC PATCH v2] platform/x86: Add securityfs interface for TXT
 status
Thread-Index: AQHYTnjT5LSRIHBU30ijASgucV0vbw==
Date:   Tue, 12 Apr 2022 14:23:06 +0000
Message-ID: <YlWLRV97ezZINIDx@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com> <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
 <20220222093101.GA23654@amd>
 <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
In-Reply-To: <YiiD3WM76L3jbMyW@noodles-fedora-PC23Y6EG.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 050d29fb-2171-4c14-2a3b-08da1c8ff66c
x-ms-traffictypediagnostic: DM6PR15MB2793:EE_
x-microsoft-antispam-prvs: <DM6PR15MB27932C9B7CC6F0FFC40345D8C1ED9@DM6PR15MB2793.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66rHC2yy3oMYIQzVDzb9VgGQWGfhNl9H37ZguNoJi4Qr5jGP1GvJ5taiLbJyQDiSEBQPA7sCLHlGK96bCkl++mr1tBhFlCBp6LtykqkBrnwayLrI1l616j5ubfKSFGhFI887bVapkIkG1Nd+LoyvxR+bBMLOsW4qm2kt2mHhv7t8lC+uDn6EIVH1VQ38cSeEaIbs+cyQb/ZGnslyEmt+jW1LBa/5xfMYrgkPGc/4BA8aNGVSdhacP0NowhrEAwngZELvingoRIMuylJo8vXjjSP2pWBYtDEAFrVQ3gRgEfEd3X6OcYtlq/VaVK42IjdBckIzTwnVIO9oJIwITQEWNpsg+Qpu/G5OGfK8tXpKwfxGDYbQN3cKNNXgQb0FVZZOLZDi1S1FyqyqpEjeUWsSZrRff7LCEEkuk+R6V8C3mog+c0z/ctHhyuHKbNoh3oap7k07EPcazBKzhClIxdQ1gXqwGnFyQftU3Oi9TdZGKNwKwVttClyFwVU/d45QDo1ZOxsTvU0H+rupawSAQHrmVT1x+aMwcwAnV5raALKAt4/GPzlujGAbLq4Z3XB+O9smXeHvTOspZeogsReDRjkgeRz/gV245h3z2ayu9DWIqLrVqBEgQNoO5Q1ZaXH90q3kMwoYtzty+017wYji67yQEFKfmp1fnc93VCDtdrl4yAGlCYjVKWJ4kTJA0SSaQGorsoxwNe3OshhFqxt3C0oMr7CBifI1wa+MWJ6rm275SL3pbZwni72B4dlUADE26ah8Hsuc6YDlOhE/KaOvBaHRhORRiYo3S5cIVi4RY32R0a8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(91956017)(66946007)(64756008)(9686003)(83380400001)(38070700005)(66446008)(8676002)(76116006)(15650500001)(8936002)(186003)(26005)(71200400001)(30864003)(508600001)(66556008)(6506007)(7416002)(6512007)(6486002)(316002)(86362001)(122000001)(5660300002)(38100700002)(110136005)(2906002)(921005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dl+CxQ2N17jra4VvE141CR1FgcvucMYZ8r9h6Cgk4/J0FOC6cI408zlZffzo?=
 =?us-ascii?Q?Oa9lEqTL5k/Q7BwSnx2SiQF1EYQAxsMxiqypt01afWG7/fF1kd8SenA80qj6?=
 =?us-ascii?Q?oHj2/u9WeiGww/vNr8KlKUGo3ee9Qq2Z9YxGGwUc6UMtjmlW9uzm/BXFklmL?=
 =?us-ascii?Q?6ob6JDti8j9uCfJMYX/GQShaoVvUUCCPs8f0xQ4runGZAkeHWJk2U88M4WSP?=
 =?us-ascii?Q?WMzH93zEi1Do3mPEinofuUMOrxtKdhRADKiXrOBFyhHuaZDdZ41QCRnJzOHe?=
 =?us-ascii?Q?KC6gXrTq/CR7bvQ397N19lkmMO6Bsk1j+eDbH9XT4TqQdYMcZP7L1G4p7oop?=
 =?us-ascii?Q?Yz8GcgD/elumhEOO7gv6VF3a2E7+SvtmL2pS2vGvROKSdPPUQ8HvPoK/dO67?=
 =?us-ascii?Q?BV+31U96E7VPOwpUsskusZI0ptt8rBiFF2u4ZzSL+XE+4uLqlnsdrXKXse2K?=
 =?us-ascii?Q?PuofF1/cnHS3LhqlNjXuY6UH/71Y9Kj6plmmp4sWVhiyy1R2hP6vF+6tPrtX?=
 =?us-ascii?Q?rGu203FX8APb6+rPeBjRIQXzduijEGKTeX09zHTrvAIg2hANdn0y27M2j3zi?=
 =?us-ascii?Q?kocZ3SEwIcp39g5/TWTn4TGSKnxQs8CyRY2dXsFse9BlMwYt9dXRPz1AlYj2?=
 =?us-ascii?Q?TPAyVjcS4awJbX78B/6b2Cuf6Xzb0j0yZcMWoa/yNkBeYk0XF4PqXi402M0Q?=
 =?us-ascii?Q?YeUgC9MHpW7qu2OJpzH+RTi6e70EkHtjmUTkP3dGNFHYRDNfjvvJP+k4Xjvi?=
 =?us-ascii?Q?h7/2rXoeCnB/DJACEzmpzN2pAdTcNmKM6ogXAUnLNpyDzXj1PFpt3mu/uPuG?=
 =?us-ascii?Q?edZ0vVSRLRxR4VBnQHmwIgT4ziR7xIshUWtxLCid8JGJIF83XDAkOxwyLYcE?=
 =?us-ascii?Q?tIJTXeVcyG8ggrbKEWZdSdP03ZRMYx8EXiRXkbO36p0DM2ndXGh2KNkCmRU1?=
 =?us-ascii?Q?MeQ7211TYK6jJf9OSUkHeEiONDeyP+PfH4Tgs53VOD+YibT3MJLMOX5GXLTC?=
 =?us-ascii?Q?+FBglYPiF8YrHmIlBCChemXcY0r/Pl7Td0Xl5pIzfHD3QYmfS/LetQJbGyJh?=
 =?us-ascii?Q?efQh2CluXcE5o0G4FeRXGnsnqYHBMJq+9sWeTyfn+XjLjk+ixX60/N9C5cb9?=
 =?us-ascii?Q?A+S3g0hD3GPp/nwEeJXriINkBJ2FfTt644KAHQjHWGQelLLgSqbAyUXsBN9M?=
 =?us-ascii?Q?fXwsWotgBkHgCI7OrhW7w8y/MGIfdQpP6ILpn0rINT4rnDwcTLJeOL/jyvL2?=
 =?us-ascii?Q?4zX4PD7SRcs9r3ma6ZMUL+Ev1e4I53hnpXJM+JivyENE0p9EdeqcwZc8T5XR?=
 =?us-ascii?Q?rn4/ZIIezjWRwTWxz1FjMbyIRvoPHIrY9I1XwX87kqjID6MJZRL27R7dtW2Z?=
 =?us-ascii?Q?VxyJIy+LxIfmEBycONVON9GQE1//ddm5XE0OtVlhHgkfNtM3ggRxf3VLghtt?=
 =?us-ascii?Q?+HhyeWsz4OvQaX1oEytUAFBgg2PEJTaFRrBBw4cWvv+mCKtNGAGf+zpPHVXW?=
 =?us-ascii?Q?iOU5fDf2l7eRyCfPofTpNmGWeF/qxrbjq834Lm8/vZs2FBvivJD3/o4VEXN9?=
 =?us-ascii?Q?4xGIOkvMEO/p0fg9afgCopp6Sydr5ryPkmk0p2RIS7jog620XBCoylijwxSJ?=
 =?us-ascii?Q?S3fJOP3kFrBJ1YuFKzHj77MIww24jrqXAcILf12MTBlzTMXsokTtwbDPtNja?=
 =?us-ascii?Q?KUbAaj8SfITx2oZ62bvAlbuoXkiQeO3c6IbjS5VTafBxJ4R2iNQ7E3XiuMAi?=
 =?us-ascii?Q?jFmfMj9RKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEF15B57046BA84092F8EA65E8BAD117@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050d29fb-2171-4c14-2a3b-08da1c8ff66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 14:23:06.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAiVeDoOHoUOUiOwG+EawGk9lpnED8pvoBWS4jUF30Ef+ZjdNJDWofCrA1pwpOOX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2793
X-Proofpoint-ORIG-GUID: 4hEX7IdbR3vrNPTR9KJC63Fe-9U2gqJg
X-Proofpoint-GUID: 4hEX7IdbR3vrNPTR9KJC63Fe-9U2gqJg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_05,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module provides read-only access to the Intel TXT (Trusted
Execution Technology) status registers, allowing userspace to determine
the status of measured boot and whether the dynamic root of trust for
measurement (DRTM) has been fully enabled.

Tools such as txt-stat from tboot
<https://sourceforge.net/projects/tboot/> can make use of this driver to
display state and attempt to remediate issues rather than relying on
access to /dev/mem.

See Documentation/x86/intel_txt.rst for more information about Intel
TXT.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
v2:
 - Refer to securityfs instead of sysfs
 - Clarify this is read-only access for remediation
 - Add documentation for the securityfs files presented
---
 .../ABI/testing/securityfs-intel-txt          | 226 ++++++++++++++++++
 arch/x86/include/asm/txt.h                    |  42 ++++
 drivers/platform/x86/intel/Kconfig            |  16 ++
 drivers/platform/x86/intel/Makefile           |   2 +
 drivers/platform/x86/intel/txt_securityfs.c   | 189 +++++++++++++++
 5 files changed, 475 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-intel-txt
 create mode 100644 arch/x86/include/asm/txt.h
 create mode 100644 drivers/platform/x86/intel/txt_securityfs.c

diff --git a/Documentation/ABI/testing/securityfs-intel-txt b/Documentation/ABI/testing/securityfs-intel-txt
new file mode 100644
index 000000000000..2e0df93a168c
--- /dev/null
+++ b/Documentation/ABI/testing/securityfs-intel-txt
@@ -0,0 +1,226 @@
+What:		/sys/security/security/intel-txt/*
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Various files relating to Intel's TXT (Trusted Execution
+		Technology). These provide read-only access to the state of
+		measured boot and whether the dynamic root of trust (DRTM) has
+		been fully enabled.
+
+		These details are intended for use in allowing userspace to
+		remediate issues with the TXT feature. They should not be relied
+		upon for confirming the system is in a secure state.
+
+		Many of the files listed below provide the raw hex values from
+		the device registers. Where possible the bit fields are
+		documented, but bits defined as reserved have been observed to
+		be clear on some platforms and set on others. As the primary
+		purpose of this support is to allow full visibility of state for
+		the purpose of remediation it is more useful to have the raw
+		values than a partially decoded state.
+
+What:		/sys/security/security/intel-txt/enabled
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Indicates if it looks like the BIOS has successfully enabled the
+		TXT functionality. Checks that a heap has correctly been
+		configured for the device. A non-initialised heap is not a
+		guarantee that an errant BIOS has not tried to enable
+		functionality and then clear status, nor does the presence of a
+		configured heap mean the device is fully initialised.
+
+What:		/sys/security/security/intel-txt/didvid
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Contains the vendor, device and revision IDs for the memory
+		controller or chipset.
+
+		b[15:0]
+			Vendor ID: 8086 for Intel
+		b[31:16]
+			Device ID: Specific to the chipset/platform
+		b[47:32]
+			Revision ID: Specific to the chipset/platform
+		b[63:48]
+			Extended ID: Specific to the chipset/platform
+
+What:		/sys/security/security/intel-txt/dpr
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Defines the details of the DMA Protected Range in which the TXT
+		heap and SINIT regions are located.
+
+		Platforms utilising SGX implement this as part of uncore and so
+		this register has no underlying hardware functionality on those
+		platforms.
+
+		b[0]
+			Bits 19:0 are locked down in this register when this bit
+			is set.
+		b[3:1]
+			Reserved.
+		b[11:4]
+			The size of memory, in MB, that will be protected from
+			DMA accesses. 0 indicates no memory is protected.
+		b[19:12]
+			Reserved.
+		b[31:20]
+			Top address + 1 of the DMA protected range.
+
+What:		/sys/security/security/intel-txt/e2sts
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Extended error status details. Contents are preserved across
+		soft resets.
+
+		b[0]
+			Reserved.
+		b[1]
+			SECRET.STS.
+			0 = Chipset acknowledged that no secrets are in memory.
+			1 = Chipset believes that secrets are in memory and will
+			    provide reset protection.
+		b[63:2]
+			Reserved.
+
+What:		/sys/security/security/intel-txt/errorcode
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Shutdown error code details. Preserved over a soft reset,
+		cleared by a hard reset or power cycle.
+
+		b[3:0]
+			Module details.
+			0 = BIOS ACM
+			1 = SINIT
+		b[9:4]
+			Class code
+		b[14:10]
+			Major error code
+		b[15]
+			Software source
+			0 = Authenticated Code Module (ACM)
+			1 = Measure Launch Environment (MLE)
+		b[27:16]
+			Minor error code
+		b[29:28]
+			Reserved.
+		b[30]
+			0 = Error reported by processor
+			1 = Error reported by software
+		b[31]
+			Valid bit
+			0 = Register contents invalid, should be ignored
+			1 = Error details valid
+		b[63:32]
+			Reserved.
+
+What:		/sys/security/security/intel-txt/ests
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Details associated with various error conditions. Contents are
+		preserved across soft resets.
+
+		b[0]
+			TXT_RESET.STS. Set to 1 to indicate an error occurred
+			which may prevent the proper use of TXT. While this bit
+			is set the Safer Mode Extension (SMX) instructions
+			GETSEC[ENTERACCS] and GETSEC[SENTER] will fail.
+
+			This bit is only cleared on a power cycle.
+		b[63:1]
+			Reserved.
+
+What:		/sys/security/security/intel-txt/spad
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		Details from the startup Authenticated Code Module (ACM)
+		conveying the results of its operation. Generally of interest to
+		the BIOS rather than the OS in normal operation it can provide
+		details of where TXT initialisation failed.
+
+		b[29:0]
+			Reserved.
+		b[30]
+			Indicates TXT startup success; successful preparation
+			for the BIOS, SINIT and MLE components.
+		b[46:31]
+			General startup ACM to BIOS boot status communication.
+		b[47]
+			Indicates memory contents were cleared via a power down.
+		b[52:48]
+			Startup ACM to BIOS communication in MP platforms.
+		b[53]
+			Startup ACM indication of run-time enabled status of
+			TXT. Generally driven by FIT type 0xA record.
+		b[58:54]
+			Startup ACM to BIOS communication in MP platforms.
+		b[59]
+			Indicates the BIOS is trusted.
+		b[60]
+			Indicates that TXT has been disabled by a runtime FIT
+			type 0xA record.
+		b[61]
+			Startup ACM to BIOS communication in MP platforms.
+		b[62]
+			Indicates an ACM authentication error from the CPU.
+		b[63]
+			Indicates S-ACM successfully enforced its logic for all
+			provisioned technologies.
+
+What:		/sys/security/security/intel-txt/sts
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		General status details for various TXT features.
+
+		b[0]
+			SENTER.DONE.STS. Set by the chipset when it sees all
+			threads have done a TXT.CYC.SENTER-ACK. When any of the
+			threads does a TXT.CYC.SYSEXIT-ACK then TXT.THREADS.JOIN
+			and TXT.THREAD.EXISTS registers will not be equal and
+			the chipset will clear this bit.
+		b[1]
+			SEXIT.DONE.STS. Set when all bits in the
+			TXT.THREADS.JOIN register are clear. This is thus set
+			after reset (since the bits are all 0) and once all
+			threads have done a TXT.CYC.SYSEXIT-ACK.
+		b[5:2]
+			Reserved.
+		b[6]
+			MEM-CONFIG-LOCK.STS. Set to 1 when the memory
+			configuration is locked. Cleared by
+			TXT.CMD.UNLOCK.MEMCONFIG or a system reset.
+		b[7]
+			PRIVATE-OPEN.STS. Set to 1 when TXT.CMD.OPEN-PRIVATE is
+			performed. Cleared by TXT.CMD.CLOSE-PRIVATE or by a
+			system reset.
+		b[14:8]
+			Reserved.
+		b[15]
+			TXT.LOCALITY1.OPEN.STS. Set when TXT.CMD.OPEN.LOCALITY1
+			is seen by the chipset. Cleared on reset or when
+			TXT.CMD.CLOSE.LOCALITY1 is seen.
+		b[16]
+			TXT.LOCALITY2.OPEN.STS. Set when TXT.CMD.OPEN.LOCALITY2
+			or TXT.CMD.OPEN.PRIVATE is seen by the chipset. Cleared
+			on reset, or when either TXT.CMD.CLOSE.LOCALITY2 or
+			TXT.CMD.CLOSE.PRIVATE is seen, and by the GETSEC[SEXIT]
+			instruction.
+		b[63:17]
+			Reserved.
+
+What:		/sys/security/security/intel-txt/publickey
+Date:		April 2022
+Contact:	Jonathan McDowell <noodles@fb.com>
+Description:
+		256 bit hash of the public key used for the verification of the
+		Authenticated Code Modules. Details are specific to the memory
+		controller or chipset.
diff --git a/arch/x86/include/asm/txt.h b/arch/x86/include/asm/txt.h
new file mode 100644
index 000000000000..a26df62f990c
--- /dev/null
+++ b/arch/x86/include/asm/txt.h
@@ -0,0 +1,42 @@
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
+ *
+ * Registers exist at the same offsets in both spaces, but access control
+ * may differ.
+ *
+ * See Intel's "Measured Launch Environment Developer's Guide" (315168)
+ * for full details.
+ */
+
+#define TXT_CR_STS			0x0000
+#define TXT_CR_ESTS			0x0008
+#define TXT_CR_ERRORCODE		0x0030
+#define TXT_CR_SPAD			0x00A0
+#define TXT_CR_VER_FSBIF		0x0100
+#define TXT_CR_DIDVID			0x0110
+#define TXT_CR_VER_EMIF			0x0200
+#define TXT_CR_SINIT_BASE		0x0270
+#define TXT_CR_SINIT_SIZE		0x0278
+#define TXT_CR_MLE_JOIN			0x0290
+#define TXT_CR_HEAP_BASE		0x0300
+#define TXT_CR_HEAP_SIZE		0x0308
+#define TXT_CR_DPR			0x0330
+#define TXT_CR_SCRATCHPAD		0x0378
+#define TXT_CR_PUBLIC_KEY		0x0400
+#define TXT_CR_E2STS			0x08f0
+
+#endif /* __TXT_H */
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 8e65086bb6c8..40b55e7fbfce 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -159,6 +159,22 @@ config INTEL_TURBO_MAX_3
 	  This driver is only required when the system is not using Hardware
 	  P-States (HWP). In HWP mode, priority can be read from ACPI tables.
 
+config INTEL_TXT_SECURITYFS
+	tristate "Intel TXT securityfs driver"
+	depends on HAVE_INTEL_TXT && SECURITYFS
+	help
+	  This driver exports the TXT (Trusted Execution Technology) public
+	  configuration space to user space via securityfs.
+
+	  These registers provide details about the status of the platform's
+	  measured launch and execution environment, allowing userspace to
+	  perform diagnosis and potential remediation when attestation or
+	  other trust related operations are failing.
+
+	  For kernel implementations which actually provide a trusted
+	  environment see tboot <https://sourceforge.net/projects/tboot/>
+	  and TrenchBoot <https://trenchboot.org/>.
+
 config INTEL_UNCORE_FREQ_CONTROL
 	tristate "Intel Uncore frequency control driver"
 	depends on X86_64
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 35f2066578b2..5d4531d4ada5 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -26,6 +26,8 @@ intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
+intel_txt_securityfs-y			:= txt_securityfs.o
+obj-$(CONFIG_INTEL_TXT_SECURITYFS)	+= intel_txt_securityfs.o
 intel_vsec-y				:= vsec.o
 obj-$(CONFIG_INTEL_VSEC)		+= intel_vsec.o
 
diff --git a/drivers/platform/x86/intel/txt_securityfs.c b/drivers/platform/x86/intel/txt_securityfs.c
new file mode 100644
index 000000000000..2db9aa95acb9
--- /dev/null
+++ b/drivers/platform/x86/intel/txt_securityfs.c
@@ -0,0 +1,189 @@
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
+ * See Documentation/x86/intel_txt.rst for more information about
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
+ *   /sys/security/security/intel-txt/
+ *
+ * Details of the registers can be found in
+ * Documentation/ABI/testing/securityfs-intel-txt
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
+	{ .name = "didvid", .ofs = TXT_CR_DIDVID, .show = txt_reg_show },
+	{ .name = "dpr", .ofs = TXT_CR_DPR, .show = txt_reg_show },
+	{ .name = "e2sts", .ofs = TXT_CR_E2STS, .show = txt_reg_show },
+	{ .name = "errorcode", .ofs = TXT_CR_ERRORCODE, .show = txt_reg_show },
+	{ .name = "ests", .ofs = TXT_CR_ESTS, .show = txt_reg_show },
+	{ .name = "spad", .ofs = TXT_CR_SPAD, .show = txt_reg_show },
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
+static int __init txt_securityfs_init(void)
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
+	txt_dir = securityfs_create_dir("intel-txt", NULL);
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
+static void __exit txt_securityfs_exit(void)
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
+module_init(txt_securityfs_init);
+module_exit(txt_securityfs_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1
