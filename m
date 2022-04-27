Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66F5120BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbiD0RPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbiD0RPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:15:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559942A05;
        Wed, 27 Apr 2022 10:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqug9qKEE3vDCtIKJFgcmwKbqEein75KLXXS0E2HMqSwEUjaFvkC+eBhTzOhVdPJzfBz0I6hbmSfaDfDHV3oHchhWumxEh6ed8HTPLqUKjvK58WJSrGggbTCY+K3ZskqcOvuE+w/bKpj0ZijDs3iV8yjelraHjADEq4RG24DgC/vuuBEigji3a6vPQzf8k/iWaezbcpv1Q4uU1/mXXZEeoHg1Bpv+mR119ObrOy8e+z1fVeA5H6lTxcaAd6gYiOmSzomtevDJnw43Mns1oXI7mqZRWyNTrcDwxz+vjFNUewkKrtkHQGBSwqt4af47vzSt3KQKWaptYJBFcoaO6FPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI5JM7MjEtOioW3SUhXEVTZCQGS6Cv9U6Kc76kdNqvE=;
 b=Z7GYwJx7gP94eNK9dVbNKlQpQc4YqObOHISheFy1xzVVVm9SLG1GShP4huIO2T0cx4ThY6+i+D2NOWZfEC6zgI9QSh/RBtQr+PKGaxAuzwyYdBBVXJbLKdoANfjWeI/MUJykxMrcwvOmVKcQp6iE4HUo2Zlq/LWxJlPUoo2Q7BumBdoCmvRJqk42sct3VMNapQxODyAFzhhPqBvDIvq+vVDjBNssQ3a7sDFDykp/H4Fo1G0lXcLN8Fssca6/N1QjWYYKAf3htnZILGbQ7JnLJV42Fl/MA0f0z/TenRaKrs714HZxtiAhFAIowFESOEljMtqaIm8vC0RqIL0+PP9nGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI5JM7MjEtOioW3SUhXEVTZCQGS6Cv9U6Kc76kdNqvE=;
 b=WLr2gwAKUIJQJR7nRqnET8auyd4Enx+G8XPmD1kVB9nR3n/7IwKNDuqmjfEA8gdyYK+jOi2c/5ViZjightjUYXmK7bNxJmyD3dw3lr3SL0jZTBuEja1k7GFdYsIXNqPdwo6LigVN3ge/EWFNL2KzkFFBz2owvdZtuuMveyN/RBs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 17:12:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 17:12:27 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: RE: [PATCH] Documentation: x86: rework IOMMU documentation
Thread-Topic: [PATCH] Documentation: x86: rework IOMMU documentation
Thread-Index: AQHYVoR13kXFsGmb30CyGi5+gP1uJq0CbMUAgAGW2OA=
Date:   Wed, 27 Apr 2022 17:12:27 +0000
Message-ID: <BL1PR12MB5144AF8423DC1FF5D21B94EEF7FA9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
 <20220426094432.2970966f@jacob-builder>
In-Reply-To: <20220426094432.2970966f@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-27T17:00:46Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=11e4dbe2-211d-4255-9e94-7dfdf111de61;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-27T17:12:25Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6d30bc85-dad5-4425-9309-aa83395d4f7f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7beedd0d-5c09-4773-7f2d-08da28711aee
x-ms-traffictypediagnostic: DM6PR12MB3964:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3964507FF92C2CDDF699D02EF7FA9@DM6PR12MB3964.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3PbSbrtLipxR+MyBjQDFczn+BfAd7lrR4XdOzOZdzwD4rW9y+HaWObaTmDhfUwxfxmBBj3wfSyP9pqjfwfS4RLclGTpROQb9PJtADGqHlUwqGHE5vpAayG5gTHzBrYTYE/3k8W2o1gxsvt5QvRTWtf1ZNEkdvyseYKZEmwDfgehwk9gjBUzHYYJoq0Ck2QmMw3R+FRoBVDoEvXIUyN4dgBVrEzYVtQAXDIaYqVYNS0CeokmATx++HIBWFDm4uv36i5cFDcPTpkVCboa9B+tU8vboKt73mFfKLnIMBg93jrNNBTeysOPwl+HCPGp83koB56bhp9hWoh+j6NE6phGrsrW9s4dtsBh5npdW0Wq0wkG/TeezhHjzvgInggu/0OwvOjEWlZsyNRyiMAM6Ad7UMNS53Jb7EYDsZ6tLCTGKF0AGybueMuB2ct5o22wPe4Wo6D5kI+vrgzDnJPbXHkPmvRSTeqzE8COFLgTynWeXsHgZUnr1QSoO1x9t/rBUDWTdxXezE59+bODPoWpPIU+qUGXtLUaBUkf3P67Yio38YnoXUei/xmG18oSNarct70Is6r/L/VTT2NXSIjPKheVno2rmva54s9rVPp08t/PgMAVfkldQxVKSRkf5rUHryAExZPhn17awfsRKyqukO4/NNaJXEDHHd+xuOvBj5WzdiiAVgmd/pzTDX2nToECX3QLLYN2GjvNi1duZ744Pshxci4yLhyAt+jS7u+lQyXXN7FwsOlkXDqoy/zWaHTJIHZyL9OrJn3J2Phc3kWUgcYXCK1gbh8XaztjkNgmuh/KuSRi2gv8dsVMhbqQjbWz4H9zyaHmuxmlnxsMX3XSWA4uSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(52536014)(5660300002)(45080400002)(508600001)(55016003)(966005)(26005)(30864003)(7416002)(7696005)(86362001)(8936002)(83380400001)(6506007)(4326008)(8676002)(54906003)(122000001)(186003)(66946007)(66476007)(33656002)(66556008)(2906002)(66446008)(64756008)(71200400001)(6916009)(9686003)(76116006)(38100700002)(316002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mox1j3/3FGylIqK3IdI48hO2fPyzQ3o69wivZrfLS5qKywcC6PqmreePnc1d?=
 =?us-ascii?Q?/TmSpeFPJg764dmEQPjgARlQOkutgKZm/hB3vgmSYCaVgZj6vXJHwqfoI4LG?=
 =?us-ascii?Q?ugTIpk41bxka03fawsjRJEE8YwZhLBwF06sfOu/ix38gmnvXwd5+nw9bjSmr?=
 =?us-ascii?Q?ChGWefjNggD4MlW3HKHfRsAiT9QjKJUayjCzRd1bUCXNJgimZyfmc7urrWGE?=
 =?us-ascii?Q?EaoCF1JUJ2RGnCgOrQuLhvhUVeCr6tsDNdHDJZsLbrePfbuvQOPFVEQiNnYK?=
 =?us-ascii?Q?cFiZk1HQhN8qVxw/IDIi0/lUNqm0ux5MmtcKF3nc0j2KRhqP6Ud8cR95opJ/?=
 =?us-ascii?Q?D3qI4WFygAeiIeXejQBTW2G+JCEU4ZOdx8S214UhNFO6j3gLxvfD2UcEI5QK?=
 =?us-ascii?Q?NHbkBpIAF7QlQgw8jaJmKJv+qrkESNn9lzUUfEZbO6K3z0xMcPab3jGEjq5j?=
 =?us-ascii?Q?/6/dzuT1NicPeI1ogx76NJ3S0DWxkWbv6MEwsaEUjYoU0Oiqk2ywSZkI4JFt?=
 =?us-ascii?Q?h9kttXobjsYa7nDIpKuJBn+StzHWC341ewV5kRm7sd4/CTYPSbrXkcf3hD9h?=
 =?us-ascii?Q?SVcxk06oJtdmWmXLCmwl05eyaVJS7plxZukGtLJbksQEfBx18llTLonGIIhQ?=
 =?us-ascii?Q?F1jxtMAcaXmOHftVAN27XMIsZfrhp9+k1fqbQYCVIDzu30SRq+3q/aBax7Xt?=
 =?us-ascii?Q?m+6XcBMNExGI4d8XB/H4XQLFIDnB3MRzXgnH0v+kRBwVzp7OxdfxyKkHomNr?=
 =?us-ascii?Q?MBI5KZm1Eo7DjTtasnOxkFYygUxYyz9jhX6oTFylxsFko7PSZNLy4u1fxUZO?=
 =?us-ascii?Q?5/i2X66o6AxguTxkzeUfVAVs2S47zUGGIIPRHM0nlHrYoiBowkPcetIEzDUE?=
 =?us-ascii?Q?I3wvhOKJLQe6bcXKi8UDW5ry+SxlyHkTnnAUhPIT4b4JQUXJJvEs6R/Uafoy?=
 =?us-ascii?Q?sV2ulSLhAFTmDxV2C5ZKR1C59ECHD959OAKNyvUVFHheEGdg+KqMZpUiP/gD?=
 =?us-ascii?Q?PXg+nOvpk8gAKzm4U1vBUQlrw5BnevtpomBvPVzLCgU612WrOJi/smJa4rsY?=
 =?us-ascii?Q?aQ28ul0SRstZfi9r03E39e/ud/ZTLiO3l+GBlVt7nZXwqft1STisKbr4JIhL?=
 =?us-ascii?Q?99booC3WGuCHaSC1vFUrPbRCOE4JGL/pqwYJ/l9UyZqIcYa733rH8BIWz7u4?=
 =?us-ascii?Q?1Gy7sIWBune6YrAbZQM4MuYg9jUcGi5gAvBzvNM7hVtZ4qxehR6og3sMFx5X?=
 =?us-ascii?Q?4dAGqRJJZ7+ZjtSLea23BC8yeOmLqOvSe17tA+7dTkN0HYFHD94bg1CY3viR?=
 =?us-ascii?Q?78zsSE+MAHOytqmZH2Egi3NgMMgqmo3RJqT6zN6dyXCD4FLEuR7yMs1f93Hb?=
 =?us-ascii?Q?NqPfIrilPICxnPv/Myn3mp2hiKm7RDJL+j39t8cZ/g4f+DWkP0OGTn+S0GWw?=
 =?us-ascii?Q?iootcGTDBFcPlu6Ho+Ipz5WSnxZ4yAzSaVmBHIKPIwUaiQe9Ko6vN7gyHS9j?=
 =?us-ascii?Q?mLgqTv5QJ0P5NROkTc2xi+ToZT19RdHiPCRiNSqR8WQjsN5MFJ9n/kEp0awJ?=
 =?us-ascii?Q?vh6KwiXYtjgzVUQPtYbd31Kri/DWrBMsHqjI8EegAh45LVyNlB3qetwL+Xrd?=
 =?us-ascii?Q?Y1UOf2FcvjhaByEjn1pD/BY52MKZ4aVOpSLQ9K7lGmtLOaJ2Pzkf+g2qO8Ue?=
 =?us-ascii?Q?/3xl7/Ho1Cy/+uldMD7F32GmYhjD1BUiEq3na5SKs4gVtKQsgZJWoaAc+BQX?=
 =?us-ascii?Q?TdlEeBskrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beedd0d-5c09-4773-7f2d-08da28711aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 17:12:27.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aRIHCYDV9zwqfw9zMndMRLIDGrEbtWMnnGB+wxPvXGeCI8kRChhgxTOq7nqnD5Dfrz/T98XzNa41cdxzRnnbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Jacob Pan <jacob.jun.pan@intel.com>
> Sent: Tuesday, April 26, 2022 12:45 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> corbet@lwn.net; hpa@zytor.com; x86@kernel.org;
> dave.hansen@linux.intel.com; bp@alien8.de; mingo@redhat.com;
> tglx@linutronix.de; joro@8bytes.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; will@kernel.org; iommu@lists.linux-
> foundation.org; robin.murphy@arm.com; Hegde, Vasant
> <Vasant.Hegde@amd.com>; jacob.jun.pan@intel.com; Lu, Baolu
> <baolu.lu@intel.com>
> Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
>=20
> Hi Alex,
>=20
> Thanks for doing this, really helps to catch up the current state. Please=
 see my
> comments inline.
>=20
> On Fri, 22 Apr 2022 16:06:07 -0400, Alex Deucher
> <alexander.deucher@amd.com> wrote:
>=20
> > Add preliminary documentation for AMD IOMMU and combine with the
> > existing Intel IOMMU documentation and clean up and modernize some of
> > the existing documentation to align with the current state of the
> > kernel.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >
> > V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g=
.,
> >     a device) and document proper DMA API.  Also correct the fact that
> >     the AMD IOMMU is not limited to managing PCI devices.
> > v3: Fix spelling and rework text as suggested by Vasant
> > v4: Combine Intel and AMD documents into a single document as suggested
> >     by Dave Hansen
> > v5: Clarify that keywords are related to ACPI, grammatical fixes
> > v6: Make more stuff common based on feedback from Robin
> >
> >  Documentation/x86/index.rst       |   2 +-
> >  Documentation/x86/intel-iommu.rst | 115 ------------------------
> >  Documentation/x86/iommu.rst       | 143
> ++++++++++++++++++++++++++++++
> >  3 files changed, 144 insertions(+), 116 deletions(-)  delete mode
> > 100644 Documentation/x86/intel-iommu.rst  create mode 100644
> > Documentation/x86/iommu.rst
> >
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index f498f1d36cd3..6f8409fe0674 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -21,7 +21,7 @@ x86-specific Documentation
> >     tlb
> >     mtrr
> >     pat
> > -   intel-iommu
> > +   iommu
> >     intel_txt
> >     amd-memory-encryption
> >     pti
> > diff --git a/Documentation/x86/intel-iommu.rst
> > b/Documentation/x86/intel-iommu.rst deleted file mode 100644 index
> > 099f13d51d5f..000000000000
> > --- a/Documentation/x86/intel-iommu.rst
> > +++ /dev/null
> > @@ -1,115 +0,0 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -Linux IOMMU Support
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -The architecture spec can be obtained from the below location.
> > -
> > -
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> >
> intel.com%2Fcontent%2Fdam%2Fwww%2Fpublic%2Fus%2Fen%2Fdocuments
> %2Fprodu
> > ct-specifications%2Fvt-directed-io-
> spec.pdf&amp;data=3D05%7C01%7Calexand
> >
> er.deucher%40amd.com%7C929847a4b2524432d1a608da27a3c9b0%7C3dd
> 8961fe488
> >
> 4e608e11a82d994e183d%7C0%7C0%7C637865881851295857%7CUnknow
> n%7CTWFpbGZs
> >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> >
> %7C3000%7C%7C%7C&amp;sdata=3DKaPkvBSHWbn1cKBRzyk9H%2BuNDll%2Bq
> 3wPfR3SFVA
> > LwkU%3D&amp;reserved=3D0
> > -
> > -This guide gives a quick cheat sheet for some basic understanding.
> > -
> > -Some Keywords
> > -
> > -- DMAR - DMA remapping
> > -- DRHD - DMA Remapping Hardware Unit Definition
> > -- RMRR - Reserved memory Region Reporting Structure
> > -- ZLR  - Zero length reads from PCI devices
> > -- IOVA - IO Virtual address.
> > -
> I feel this combined document only focus on IOVA and DMA APIs, it is
> considered as legacy DMA after scalable mode is introduced by Intel to
> support DMA with PASID, shared virtual addressing (SVA).
> Perhaps, we can also combine ./Documentation/x86/sva.rst

I think it would make sense to take that up in a separate patch set. =20

>=20
> With scalable mode, it affects boot messages, fault reporting, etc. I am =
not
> saying no to this document, just suggesting. I don't know where AMD is at=
 in
> terms of PASID support but there are lots of things in common between VT-=
d
> and ARM's SMMU in terms of PASID/SVA. Should we broaden the purpose of
> this document even further?

I think that would make sense for a future clean up.  I'd like to land the =
current clean up first.

AMD's IOMMU driver has supported PASID for probably 8-10 years.  When we or=
iginally added it no other vendors were interested in supporting it so we m=
ade it a private API which was used by other AMD drivers that needed it at =
the time.  Suravee can probably comment on the status of our support for th=
e cross vendor API.

Alex

>=20
> > -Basic stuff
> > ------------
> > -
> > -ACPI enumerates and lists the different DMA engines in the platform,
> > and -device scope relationships between PCI devices and which DMA
> > engine controls -them.
> > -
> > -What is RMRR?
> > --------------
> > -
> > -There are some devices the BIOS controls, for e.g USB devices to
> > perform
> > -PS2 emulation. The regions of memory used for these devices are
> > marked -reserved in the e820 map. When we turn on DMA translation,
> DMA
> > to those -regions will fail. Hence BIOS uses RMRR to specify these
> > regions along with -devices that need to access these regions. OS is
> > expected to setup -unity mappings for these regions for these devices
> > to access these regions. - -How is IOVA generated?
> > -----------------------
> > -
> > -Well behaved drivers call pci_map_*() calls before sending command to
> > device -that needs to perform DMA. Once DMA is completed and mapping
> > is no longer -required, device performs a pci_unmap_*() calls to unmap
> > the region. - -The Intel IOMMU driver allocates a virtual address per
> > domain. Each PCIE -device has its own domain (hence protection).
> > Devices under p2p bridges -share the virtual address with all devices
> > under the p2p bridge due to -transaction id aliasing for p2p bridges.
> > -
> > -IOVA generation is pretty generic. We used the same technique as
> > vmalloc() -but these are not global address spaces, but separate for
> > each domain. -Different DMA engines may support different number of
> domains.
> > -
> > -We also allocate guard pages with each mapping, so we can attempt to
> > catch -any overflow that might happen.
> > -
> > -
> > -Graphics Problems?
> > -------------------
> > -If you encounter issues with graphics devices, you can try adding
> > -option intel_iommu=3Digfx_off to turn off the integrated graphics engi=
ne.
> > -If this fixes anything, please ensure you file a bug reporting the
> > problem. - -Some exceptions to IOVA
> > ------------------------
> > -Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff)=
.
> > -The same is true for peer to peer transactions. Hence we reserve the
> > -address from PCI MMIO ranges so they are not allocated for IOVA
> > addresses. -
> > -
> > -Fault reporting
> > ----------------
> > -When errors are reported, the DMA engine signals via an interrupt.
> > The fault -reason and device that caused it with fault reason is
> > printed on console. - -See below for sample.
> > -
> > -
> > -Boot Message Sample
> > --------------------
> > -
> > -Something like this gets printed indicating presence of DMAR tables
> > -in ACPI.
> > -
> > -ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> > 0x000000007f5b5ef0 -
> > -When DMAR is being processed and initialized by ACPI, prints DMAR
> > locations -and any RMRR's processed::
> > -
> > -	ACPI DMAR:Host address width 36
> > -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> > -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> > -	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> > -	ACPI DMAR:RMRR base: 0x00000000000ed000 end:
> 0x00000000000effff
> > -	ACPI DMAR:RMRR base: 0x000000007f600000 end:
> 0x000000007fffffff
> > -
> > -When DMAR is enabled for use, you will notice..
> > -
> > -PCI-DMA: Using DMAR IOMMU
> > --------------------------
> > -
> > -Fault reporting
> > -^^^^^^^^^^^^^^^
> > -
> > -::
> > -
> > -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > -	DMAR:[fault reason 05] PTE Write access is not set
> > -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > -	DMAR:[fault reason 05] PTE Write access is not set
> > -
> > -TBD
> > -----
> > -
> > -- For compatibility testing, could use unity map domain for all
> > devices, just
> > -  provide a 1-1 for all useful memory under a single domain for all
> > devices. -- API for paravirt ops for abstracting functionality for VMM
> > folks. diff --git a/Documentation/x86/iommu.rst
> > b/Documentation/x86/iommu.rst new file mode 100644 index
> > 000000000000..ed87d76a38d5
> > --- /dev/null
> > +++ b/Documentation/x86/iommu.rst
> > @@ -0,0 +1,143 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +x86 IOMMU Support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The architecture specs can be obtained from the below locations.
> > +
> > +- Intel:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.i
> >
> ntel.com%2Fcontent%2Fdam%2Fwww%2Fpublic%2Fus%2Fen%2Fdocuments%
> 2Fproduc
> > t-specifications%2Fvt-directed-io-
> spec.pdf&amp;data=3D05%7C01%7Calexande
> >
> r.deucher%40amd.com%7C929847a4b2524432d1a608da27a3c9b0%7C3dd8
> 961fe4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637865881851295857%7CUnknown
> %7CTWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C3000%7C%7C%7C&amp;sdata=3DKaPkvBSHWbn1cKBRzyk9H%2BuNDll%2Bq3
> wPfR3SFVAL
> > wkU%3D&amp;reserved=3D0
> > +- AMD:
> >
> +https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .amd.com%2Fsystem%2Ffiles%2FTechDocs%2F48882_IOMMU.pdf&amp;data
> =3D05%7C01%7Calexander.deucher%40amd.com%7C929847a4b2524432d1a6
> 08da27a3c9b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7865881851295857%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> amp;sdata=3DQFq8HBY6cm2XaZ50u5LQA3RX3NX%2BwVsMqfJFDH9bFDs%3D&a
> mp;reserved=3D0 + This guide gives a quick cheat sheet for some basic
> understanding.
> > +
> > +Basic stuff
> > +-----------
> > +
> > +ACPI enumerates and lists the different IOMMUs on the platform, and
> > +device scope relationships between devices and which IOMMU controls
> > +them.
> > +
> > +Some ACPI Keywords:
> > +
> > +- DMAR - Intel DMA Remapping table
> > +- DRHD - Intel DMA Remapping Hardware Unit Definition
> > +- RMRR - Intel Reserved Memory Region Reporting Structure
> > +- IVRS - AMD I/O Virtualization Reporting Structure
> > +- IVDB - AMD I/O Virtualization Definition Block
> > +- IVHD - AMD I/O Virtualization Hardware Definition
> > +
> > +What is Intel RMRR?
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +There are some devices the BIOS controls, for e.g USB devices to
> > +perform
> > +PS2 emulation. The regions of memory used for these devices are
> > +marked reserved in the e820 map. When we turn on DMA translation,
> DMA
> > +to those regions will fail. Hence BIOS uses RMRR to specify these
> > +regions along
> > with +devices that need to access these regions. OS is expected to
> > setup
> > +unity mappings for these regions for these devices to access these
> > regions. +
> > +What is AMD IVRS?
> > +^^^^^^^^^^^^^^^^^
> > +
> > +The architecture defines an ACPI-compatible data structure called an
> > +I/O Virtualization Reporting Structure (IVRS) that is used to convey
> > information +related to I/O virtualization to system software.  The
> > IVRS describes the +configuration and capabilities of the IOMMUs
> > contained in the platform as +well as information about the devices
> > that each IOMMU virtualizes. +
> > +The IVRS provides information about the following:
> > +
> > +- IOMMUs present in the platform including their capabilities and
> > +proper
> > configuration +- System I/O topology relevant to each IOMMU
> > +- Peripheral devices that cannot be otherwise enumerated
> > +- Memory regions used by SMI/SMM, platform firmware, and platform
> > hardware. These are generally exclusion ranges to be configured by
> > system software. + +How is an I/O Virtual Address (IOVA) generated?
> > +-----------------------------------------------
> > +
> > +Well behaved drivers call dma_map_*() calls before sending command to
> > device +that needs to perform DMA. Once DMA is completed and mapping
> > is no longer +required, driver performs dma_unmap_*() calls to unmap
> > the region. +
> > +Some exceptions to IOVAs
> > +------------------------
> > +
> > +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff)=
.
> > +The same is true for peer to peer transactions. Hence we reserve the
> > +address from PCI MMIO ranges so they are not allocated for IOVA
> > addresses. +
> > +Graphics Problems?
> > +------------------
> > +
> > +If you encounter issues with integrated graphics devices, you can try
> > +adding the option "iommu.passthrough=3D1", or the equivalent
> > +"iommu=3Dpt", to the kernel command line to use a 1:1 mapping for the
> > +IOMMU in general.  On Intel you can also try "intel_iommu=3Digfx_off"
> > +to turn off translation specifically for the integrated graphics
> > +engine only.  If this fixes anything, please ensure you file a bug rep=
orting
> the problem.
> > +
> > +Fault reporting
> > +---------------
> > +When errors are reported, the IOMMU signals via an interrupt. The
> > +fault reason and device that caused it is printed on the console.
> > +
> > +
> > +Kernel Log Samples
> > +------------------
> > +
> > +Intel Boot Messages
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +Something like this gets printed indicating presence of DMAR tables
> > +in ACPI:
> > +
> > +::
> > +
> > +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT
> 0x00000097) @
> > 0x000000007f5b5ef0 +
> > +When DMAR is being processed and initialized by ACPI, prints DMAR
> > locations +and any RMRR's processed:
> > +
> > +::
> > +
> > +	ACPI DMAR:Host address width 36
> > +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> > +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> > +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> > +	ACPI DMAR:RMRR base: 0x00000000000ed000 end:
> 0x00000000000effff
> > +	ACPI DMAR:RMRR base: 0x000000007f600000 end:
> 0x000000007fffffff
> > +
> > +When DMAR is enabled for use, you will notice:
> > +
> > +::
> > +
> > +	PCI-DMA: Using DMAR IOMMU
> > +
> > +Intel Fault reporting
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > +	DMAR:[fault reason 05] PTE Write access is not set
> > +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> > +	DMAR:[fault reason 05] PTE Write access is not set
> > +
> > +AMD Boot Messages
> > +^^^^^^^^^^^^^^^^^
> > +
> > +Something like this gets printed indicating presence of the IOMMU:
> > +
> > +::
> > +
> > +	AMD-Vi: Found IOMMU cap 0x40
> > +	AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC
> > GA_vAPIC
> > +	AMD-Vi: Interrupt remapping enabled
> > +	AMD-Vi: Virtual APIC enabled
> > +
> > +AMD Fault reporting
> > +^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0007
> > address=3D0xffffc02000 flags=3D0x0000]
> > +	AMD-Vi: Event logged [IO_PAGE_FAULT device=3D07:00.0
> domain=3D0x0007
> > address=3D0xffffc02000 flags=3D0x0000]
>=20
>=20
> Thanks,
>=20
> Jacob
