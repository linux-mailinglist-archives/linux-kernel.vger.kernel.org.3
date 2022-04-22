Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C550C0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiDVUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDVUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:15:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A8247316;
        Fri, 22 Apr 2022 13:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNNMhMnBEWoYCx8R1LSnbo2+Uc/7/T8NjRcfcHVavWAvNBjckJb6/4oEp9FPsvnpfxwYxnIVOiml4C2el92L+JC+NImZ0c0LoA3InadBfjTa8frqUJTupBKRA451L6WiqxbWRMKYbOpdU8ey1uYHUKfWhxDkp3X+iqTooTUSdxLj96fHzSg/il01tz3xgSR5QJ8c8t8nSG5nCTzQ2NV7QEHsuKZeprA33AbB6OkGRYtdjFfcdUy2G79l2DNoCLjJnMpOL4T9DHlxAe6eHZ4bSFBppMDQHnaQTRf+BEO4je4PVBjaLubtuv/1sqDxyDdnljpHaRP0FC4qGe1HLh9dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdT9vG/0oxpxXJkADbeHjDGPNvYDEGfiHAx+W1zHcec=;
 b=Vy9WvfjBaKftMGQFUWF8UOxEPCmph2kCV32IQWt0k483aGkum5WjlpqKRRrlkZvc/iJ5R+5wyS/3WHBTpIu0CAREM5IC8QEYas4f9jNGNMaA2mRiSboIJPYfu1PQfqwhwqwhGZdY+1jk/SGzUOxyzRU5JYnNaa7I4FyO5ySxIcrazARyVHFCIQmO5paz39kNiNXHwdVAvx2ChycFAVT9iEh8aJyRFmJxbDqnLwmwJPUDQHvwGU34+mcxkQ3VoO+FmqOKSYKrELv4GU3NWF5G6uVakGHejJfmXg13ygHVMOOiiWngiEf3Y/ByxQgO6RkenozX0P3cfyA/ozbT/BM7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdT9vG/0oxpxXJkADbeHjDGPNvYDEGfiHAx+W1zHcec=;
 b=E8j0OlF+IHWpH9LZcZaXT9oV8vQnm4+QScsMfaruhet8oelNMsIV+m4srd9soTNwj1x9g4IjaxUQaSAeAJr9Uql0RWBejBEC5mAfcDyAZRBUC6NOzrb3jLpwrV7qhPE2sjEsglG7SeD6Q0nIU0NCAyWmd34Drl2bTkExOe8rwe0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN8PR12MB3507.namprd12.prod.outlook.com (2603:10b6:408:6e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 19:26:04 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%7]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 19:26:04 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>
Subject: RE: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Topic: [PATCH v4] Documentation: x86: rework IOMMU documentation
Thread-Index: AQHYVnILoAEZrZOhO0iIGelLt1T6q6z8UGDQ
Date:   Fri, 22 Apr 2022 19:26:04 +0000
Message-ID: <BL1PR12MB5144E4460014CA5AF326F313F7F79@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220422175423.44491-1-alexander.deucher@amd.com>
In-Reply-To: <20220422175423.44491-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-22T19:24:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ccf653fa-ed25-4afd-bc9c-656e59726551;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-22T19:26:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 75e0a9e1-e1a1-4bb2-b1e4-7c7226aec1af
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92130bfe-a401-4e0e-356f-08da2495f14f
x-ms-traffictypediagnostic: BN8PR12MB3507:EE_
x-microsoft-antispam-prvs: <BN8PR12MB350792FDD931871CA18E150BF7F79@BN8PR12MB3507.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezYhsFWa27EGznhPoV5j5K9tpNjyvPvh8nvimAuPx2zU0QjY3mHZD4+Ji7h4RG1MTRG/78eWpIwYd7jzjLxVX0bOEOixiOLrQ6AT1ZvsbbLaLsJQ1GEc2EnXKP6FIhbc/al+Et4mlTfD4cOhPpa09uHKQwpH0NwJOVZnF8o6GgyhkmOjKpYJ0lUTsdewdGXJgozLCODl5hdMOQVgu4fvy+0X1LVftIw4stkVy7h5I6QUGTe1EFGhfnh9hMVFH2AgFSxeVkcFQCUCAtvwuEe990995hSzW9bovYCN1Z9LsVVGkKp2Gpo83txu9cEDHkLfADldrQjv6Fofufjkl+cOEPfG4hendOYKvAc6OUc1PMGVLks8TiX7Rqpu+eoDHDLBfXZyI8PuL+h18BG7FIHLXR6noD0gGScLgZMquM72/il4ZI7WLUKh7lUxkFRH3O5rASsd7NBXUgYb0cah0mXvn8QNakithwdgWLbcm6MKaahXxD+FxWQDaw0PGBQujx/3iZ/TVG2m1iztmhgNV7p7cmTU0xObyd+5xKS5zBdmGnxp4Bcgx0N0Hdau32b7BvFpC8CLC1yQxVrQKzDqhaLILpDGc3OznpLfg1jfHp8aPcetk+59KlUCAaCdzg58aoSlsg6ep1FBUdOBWHwv21jxkZfesuSqTuR7tbXgGdc4TnnLU2Mfx9ffuv9TfqdS/3snv7+5g7usO7GaJsFaAZKCScULiReUv11RoIjuyXh/U5mdivzMl0fi5kKlVH9jj1C/fbKBo2c9PbVrhqyKGzu6BksDrAVKPj5vk0DCCvN0qQYz1BuRPm/R/tsiXRz7qtCyoHqYo2L49GyGx3bft8pOSs5hNdCqZwC07nkax2bEdAE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52536014)(8936002)(316002)(122000001)(76116006)(38100700002)(33656002)(53546011)(966005)(7696005)(9686003)(110136005)(30864003)(6506007)(5660300002)(6636002)(64756008)(921005)(508600001)(71200400001)(86362001)(66446008)(66476007)(38070700005)(55016003)(186003)(66556008)(8676002)(66946007)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QFP1d2Urskc8MRsqAB+1MZoNbfZB+pIukabsx0IICi54r4+uojfnhoSOrnGH?=
 =?us-ascii?Q?Eou0R6pYGYjF9hm2JabWpbBJ5QXotGyx9tYi2BRbXbXe+fyGn+pkqiiQ3Lip?=
 =?us-ascii?Q?401y0NxurKbmyL6lAU2f+JgLkN+wQ6+0IK/Ul+Tv8uSTSlo64tnFpbf0JPXJ?=
 =?us-ascii?Q?m/WaiUKsb4Rg76C/YycLJq4tRkjFoMaJRDe0sQs03ys1grcl+1MOVAnXx6Vj?=
 =?us-ascii?Q?WUjLJXM281m+BbRamW/wavfcTDUlRs7Hgcd0/OHsep2SElZpFZzMVa5Bno/v?=
 =?us-ascii?Q?/g4/Nw+I3x9BSF0pouPLwZJNX+kh02SpQRrVd6oTFzctXxfEfMowNi0cH0WV?=
 =?us-ascii?Q?9QTnKgQkY4mVvJhPIhjl4yR5oy6MAISRNXWf/oWp1UEJASTidgp+J6IByyB/?=
 =?us-ascii?Q?BDeYMapB7E5MtbqeUo7OUlwCSxYz4dTivodQuv6WOQBAfuWNwfUD9xn280zw?=
 =?us-ascii?Q?wrS9DO1mxMFvcrpYBDIGjYwWUpAY5b28FsPL6fTrETjcUQ0XXcL91NFir9eg?=
 =?us-ascii?Q?NVevaSQ3poo/AAZOQhlK0IufAT+WOTU42APwMvw8DyyemiUsYiJMMu7tns2P?=
 =?us-ascii?Q?m3gGZ2/ig1+KflTQVYgngtrlx5kmYLXK08vb41vuNsyjVNUNqy9FYFPttWD+?=
 =?us-ascii?Q?XI5IEKqfB8sKZHCWVR+vSL1H/UY8b2jiK0661cFRYfvz0+UL4WOrFZH3npVc?=
 =?us-ascii?Q?sOoft458x335V6fhrCaZ4+ANAFy9E6SWAygP2hJydwxMDDv9BUX6UORWbV3Y?=
 =?us-ascii?Q?Gh+YV7onLzXYGb+lKKCXmP3OHRP7lvDERLGWz/oOf9++KE4em9uofhgx8Grd?=
 =?us-ascii?Q?8IGEwZ0olYNuvLBYelZBscBJcl83tEIEs/EAbwf/e/D6qTeUDL8iCsS7TN6A?=
 =?us-ascii?Q?pcGfOELkW5SjCukwHyZ7S7U8IwAdYuqqsWfxg93IHrpVRneUac2dehwyCDG2?=
 =?us-ascii?Q?XP/JiZ9a+78UwIMjTqRFUdrIflJJ+QNYy0wlRIy5LQ04QgpmAVFxRwcIIU4s?=
 =?us-ascii?Q?qGLafeIRhVele7mn56wK3fliLFHdsFg04SYnlWPPWdZBiuuk1T5QoXo7UBDV?=
 =?us-ascii?Q?LQzurCH/wfTTHZbRSyKIMph0kiQEVI7+ZsxCIQF8c1CmgnH86az+MIMdjeYY?=
 =?us-ascii?Q?marF+0cAUBKJfSXenu6G5sQxrFCa5f34Zpct+eaJhOJ511kXWAP5isomDINv?=
 =?us-ascii?Q?y9bbc2CpBYS5gz6q46ORJtV/Cz6iZ8tDK8T+UXKxlj1JnKVZztta8B6QccYz?=
 =?us-ascii?Q?lq/aDrG/u5X9eJce2IIeY8VS91CIfVxdKsY4wUJzOX5yzvymn9Zaz127DXu6?=
 =?us-ascii?Q?eihpfsY+SFH6fBf59xwgObRLkvyEKosM4GSlBAT/24d0sey8TdLUBxt/VpJn?=
 =?us-ascii?Q?rj1tWqmmNsltM3KoweL+sgLcUHLLFlXLSZSpYZm7UNyNn7VXjsNnt3M+4MBE?=
 =?us-ascii?Q?gMrKZOUGrUy9+XZbEMWGhZmSHaDiJrL2VP1p0HBEes72bDrxpjo1vNBn5oSb?=
 =?us-ascii?Q?zS6w7zycAc6+wXP3PbNthUJIQ2bIAi20jnKQ1WE33+YhNyrHfN6DoOXyQ0Fr?=
 =?us-ascii?Q?cL9ewhtwHl1GbWGKjA20Usqu3oZadbltv8AgyWNSH4eXF9ZW/dyvy4VildEG?=
 =?us-ascii?Q?Www9zP75fDrwRsIP8aANTfzrBDbOGHrsWmGyye183DPjRmqZUetFeQaadyTe?=
 =?us-ascii?Q?5lleTJDAo+qcrU20PSiDqioLTWcpYCXApaQ0QVhcg08AgaGXXtUn9WAizXzt?=
 =?us-ascii?Q?XZR5odB+Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92130bfe-a401-4e0e-356f-08da2495f14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 19:26:04.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ezl1TzI++FMB76ULIi4fVaV5ai+V6d00Ax2Bm3uMpHCWNYAUYN5YrG2Tqov8IhxxNeCl+UTFXUfxD9cyrRmfiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, April 22, 2022 1:54 PM
> To: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> corbet@lwn.net; hpa@zytor.com; x86@kernel.org;
> dave.hansen@linux.intel.com; bp@alien8.de; mingo@redhat.com;
> tglx@linutronix.de; joro@8bytes.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; will@kernel.org; iommu@lists.linux-
> foundation.org; robin.murphy@arm.com; Hegde, Vasant
> <Vasant.Hegde@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v4] Documentation: x86: rework IOMMU documentation
>=20
> Add preliminary documentation for AMD IOMMU and combine with the
> existing Intel IOMMU documentation and clean up and modernize some of the
> existing documentation to align with the current state of the kernel.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>=20
> V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>     a device) and document proper DMA API.  Also correct the fact that
>     the AMD IOMMU is not limited to managing PCI devices.
> v3: Fix spelling and rework text as suggested by Vasant
> v4: Combine Intel and AMD documents into a single document as suggested
>     by Dave Hansen
>=20
>  Documentation/x86/index.rst       |   2 +-
>  Documentation/x86/intel-iommu.rst | 115 ----------------------
>  Documentation/x86/iommu.rst       | 153
> ++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+), 116 deletions(-)  delete mode 100644
> Documentation/x86/intel-iommu.rst  create mode 100644
> Documentation/x86/iommu.rst
>=20
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..6f8409fe0674 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,7 +21,7 @@ x86-specific Documentation
>     tlb
>     mtrr
>     pat
> -   intel-iommu
> +   iommu
>     intel_txt
>     amd-memory-encryption
>     pti
> diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-
> iommu.rst
> deleted file mode 100644
> index 099f13d51d5f..000000000000
> --- a/Documentation/x86/intel-iommu.rst
> +++ /dev/null
> @@ -1,115 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Linux IOMMU Support
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The architecture spec can be obtained from the below location.
> -
> -http://www.intel.com/content/dam/www/public/us/en/documents/product-
> specifications/vt-directed-io-spec.pdf
> -
> -This guide gives a quick cheat sheet for some basic understanding.
> -
> -Some Keywords
> -
> -- DMAR - DMA remapping
> -- DRHD - DMA Remapping Hardware Unit Definition
> -- RMRR - Reserved memory Region Reporting Structure
> -- ZLR  - Zero length reads from PCI devices
> -- IOVA - IO Virtual address.
> -
> -Basic stuff
> ------------
> -
> -ACPI enumerates and lists the different DMA engines in the platform, and=
 -
> device scope relationships between PCI devices and which DMA engine
> controls -them.
> -
> -What is RMRR?
> --------------
> -
> -There are some devices the BIOS controls, for e.g USB devices to perform
> -PS2 emulation. The regions of memory used for these devices are marked -
> reserved in the e820 map. When we turn on DMA translation, DMA to those -
> regions will fail. Hence BIOS uses RMRR to specify these regions along wi=
th -
> devices that need to access these regions. OS is expected to setup -unity
> mappings for these regions for these devices to access these regions.
> -
> -How is IOVA generated?
> -----------------------
> -
> -Well behaved drivers call pci_map_*() calls before sending command to
> device -that needs to perform DMA. Once DMA is completed and mapping is
> no longer -required, device performs a pci_unmap_*() calls to unmap the
> region.
> -
> -The Intel IOMMU driver allocates a virtual address per domain. Each PCIE=
 -
> device has its own domain (hence protection). Devices under p2p bridges -
> share the virtual address with all devices under the p2p bridge due to -
> transaction id aliasing for p2p bridges.
> -
> -IOVA generation is pretty generic. We used the same technique as vmalloc=
() -
> but these are not global address spaces, but separate for each domain.
> -Different DMA engines may support different number of domains.
> -
> -We also allocate guard pages with each mapping, so we can attempt to cat=
ch -
> any overflow that might happen.
> -
> -
> -Graphics Problems?
> -------------------
> -If you encounter issues with graphics devices, you can try adding -optio=
n
> intel_iommu=3Digfx_off to turn off the integrated graphics engine.
> -If this fixes anything, please ensure you file a bug reporting the probl=
em.
> -
> -Some exceptions to IOVA
> ------------------------
> -Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> -The same is true for peer to peer transactions. Hence we reserve the -
> address from PCI MMIO ranges so they are not allocated for IOVA addresses=
.
> -
> -
> -Fault reporting
> ----------------
> -When errors are reported, the DMA engine signals via an interrupt. The f=
ault
> -reason and device that caused it with fault reason is printed on console=
.
> -
> -See below for sample.
> -
> -
> -Boot Message Sample
> --------------------
> -
> -Something like this gets printed indicating presence of DMAR tables -in =
ACPI.
> -
> -ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> 0x000000007f5b5ef0
> -
> -When DMAR is being processed and initialized by ACPI, prints DMAR
> locations -and any RMRR's processed::
> -
> -	ACPI DMAR:Host address width 36
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> -	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> -	ACPI DMAR:RMRR base: 0x00000000000ed000 end:
> 0x00000000000effff
> -	ACPI DMAR:RMRR base: 0x000000007f600000 end:
> 0x000000007fffffff
> -
> -When DMAR is enabled for use, you will notice..
> -
> -PCI-DMA: Using DMAR IOMMU
> --------------------------
> -
> -Fault reporting
> -^^^^^^^^^^^^^^^
> -
> -::
> -
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -
> -TBD
> -----
> -
> -- For compatibility testing, could use unity map domain for all devices,=
 just
> -  provide a 1-1 for all useful memory under a single domain for all devi=
ces.
> -- API for paravirt ops for abstracting functionality for VMM folks.
> diff --git a/Documentation/x86/iommu.rst b/Documentation/x86/iommu.rst
> new file mode 100644 index 000000000000..d51fd8f89382
> --- /dev/null
> +++ b/Documentation/x86/iommu.rst
> @@ -0,0 +1,153 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +x86 IOMMU Support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The architecture specs can be obtained from the below locations.
> +
> +- Intel:
> +http://www.intel.com/content/dam/www/public/us/en/documents/product-
> spe
> +cifications/vt-directed-io-spec.pdf
> +- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
> +
> +This guide gives a quick cheat sheet for some basic understanding.
> +
> +Some Keywords
> +
> +- DMAR - Intel DMA remapping
> +- DRHD - Intel DMA Remapping Hardware Unit Definition
> +- RMRR - Intel Reserved Memory Region Reporting Structure
> +- IVRS - AMD I/O Virtualization Reporting Structure
> +- IVDB - AMD I/O Virtualization Definition Block
> +- IVHD - AMD I/O Virtualization Hardware Definition

One of my coworkers mentioned that it might be cleaner to call these out as=
 ACPI related.  Will resend a new patch with that clarified.

Alex

> +- IOVA - I/O Virtual Address
> +- ZLR  - Zero length reads from PCI devices
> +
> +Basic stuff
> +-----------
> +
> +ACPI enumerates and lists the different IOMMUs on the platform, and
> +device scope relationships between devices and which IOMMU controls
> +them.
> +
> +What is Intel RMRR?
> +^^^^^^^^^^^^^^^^^^^
> +
> +There are some devices the BIOS controls, for e.g USB devices to
> +perform
> +PS2 emulation. The regions of memory used for these devices are marked
> +reserved in the e820 map. When we turn on DMA translation, DMA to those
> +regions will fail. Hence BIOS uses RMRR to specify these regions along
> +with devices that need to access these regions. OS is expected to setup
> +unity mappings for these regions for these devices to access these regio=
ns.
> +
> +What is AMD IVRS?
> +^^^^^^^^^^^^^^^^^
> +
> +The architecture defines an ACPI-compatible data structure called an
> +I/O Virtualization Reporting Structure (IVRS) that is used to convey
> +information related to I/O virtualization to system software.  The IVRS
> +describes the configuration and capabilities of the IOMMUs contained in
> +the platform as well as information about the devices that each IOMMU
> virtualizes.
> +
> +The IVRS provides information about the following:
> +
> +- IOMMUs present in the platform including their capabilities and
> +proper configuration
> +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform
> hardware. These are generally exclusion ranges to be configured by system
> software.
> +
> +How is an IOVA generated?
> +-------------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to
> +device that needs to perform DMA. Once DMA is completed and mapping is
> +no longer required, driver performs dma_unmap_*() calls to unmap the
> region.
> +
> +Intel Specific Notes
> +--------------------
> +
> +Graphics Problems?
> +^^^^^^^^^^^^^^^^^^
> +
> +If you encounter issues with graphics devices, you can try adding
> +option intel_iommu=3Digfx_off to turn off the integrated graphics engine=
.
> +If this fixes anything, please ensure you file a bug reporting the probl=
em.
> +
> +Some exceptions to IOVA
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> +The same is true for peer to peer transactions. Hence we reserve the
> +address from PCI MMIO ranges so they are not allocated for IOVA addresse=
s.
> +
> +AMD Specific Notes
> +------------------
> +
> +Graphics Problems?
> +^^^^^^^^^^^^^^^^^^
> +
> +If you encounter issues with integrated graphics devices, you can try
> +adding option iommu=3Dpt to the kernel command line use a 1:1 mapping fo=
r
> +the IOMMU.  If this fixes anything, please ensure you file a bug reporti=
ng the
> problem.
> +
> +Fault reporting
> +---------------
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.
> +
> +
> +Kernel Log Samples
> +------------------
> +
> +Intel Boot Messages
> +^^^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of DMAR tables in
> +ACPI.
> +
> +::
> +
> +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT
> 0x00000097) @
> +0x000000007f5b5ef0
> +
> +When DMAR is being processed and initialized by ACPI, prints DMAR
> +locations and any RMRR's processed
> +
> +::
> +
> +	ACPI DMAR:Host address width 36
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> +	ACPI DMAR:RMRR base: 0x00000000000ed000 end:
> 0x00000000000effff
> +	ACPI DMAR:RMRR base: 0x000000007f600000 end:
> 0x000000007fffffff
> +
> +When DMAR is enabled for use, you will notice
> +
> +::
> +
> +	PCI-DMA: Using DMAR IOMMU
> +
> +Intel Fault reporting
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +
> +AMD Boot Messages
> +^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of the IOMMU.
> +
> +::
> +
> +	iommu: Default domain type: Translated
> +	iommu: DMA domain TLB invalidation policy: lazy mode
> +
> +AMD Fault reporting
> +^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0007
> address=3D0xffffc02000 flags=3D0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=3D07:00.0
> domain=3D0x0007
> +address=3D0xffffc02000 flags=3D0x0000]
> --
> 2.35.1
