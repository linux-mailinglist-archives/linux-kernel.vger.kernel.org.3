Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5983357A1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbiGSOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiGSOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:38:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453461A384;
        Tue, 19 Jul 2022 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658241189; x=1689777189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SxoIVKEbfH9fGBZ/hmtFpF/aqbUE9typlTnggdRzp54=;
  b=jizDk7nUUEynMxnhv6ZwNsfjGg3O6MnnAzAQmw8pLN9+Z+0TPFqIrCfw
   llMXtVil3jhawsOGujx/lvOzb/N7moYYBBZkz1rQCfRKnvyaCXjxu5oIS
   tQdpzmpsvLxuXA/h3wkgRi48/tP6Df/30P3/LX+ohS6hFCGP/TRTqgh6E
   YyUPJaU7qCwIk5xGJ8xr2BiKoCgmFEN1uj8T02tLGFsAf+CVERrDkdbRI
   aoYgPy+2eKZD4kW4qGr5tB8d3+oDpKhtygJ0yUkIp+v5rKXte80E89Rou
   07hUIheG/2zfR5EZOSXkhOWgLi2k6vTdOWlGDcNIW2W73xzWFwN+h1tU0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="350469038"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="350469038"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="924795739"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2022 07:33:08 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 07:33:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 07:33:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 07:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM8jylollMZYKawKVcciBdRjnNQu3RtSovdVBnBaiPNrLpU+GhP5qUo3OorEJfyDr7GenovYsB6ly+Vi1BZd/+chGROJdlD3JijT4zUJJsPBBjEGk0H1kYWWB8ZjgElS6lWH3AQHV7Fbg8UPm8VMSGx4aVPDEdgVQxQowITaQ/qqVp0eMzXZ1kBcw4HToxSJ6rQAs7YTlFMGnzeOClAJZUg+wWtyhri1UeFDN1zTQ5XbS4AWGOb/Do/nmF0FRS1eS0bEjoplLS2MzJypu1NTbT0QReYVbWnSuwUmPtCpHwuYZSFy3pVKtqpX0l02nF4YG9XvCiPOopfmDI5oK+qoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7FaT3MtCmcyOK84wUbjReq1Gp6DVB2T4scuI7b5ePc=;
 b=YZ+RdTP5/GTtKCciIzfjtsGJax3gMAzeXUVRTU+OU6IStpavlNJNIooYrHis9oGCIuJBH1Gmc/i6Jf2FRCmxsWfWbfHyStPGC0OsitjRZmb1wPYbB/qrgpcWr8FjeFxRinafYkS9ShyK7X/ADqG1NudbXEauM1FoYE+cj8C1f1u93TKGkbtQimPlUHTj9EaVG+dnQelyJP00HZk/uzW+Yku5AszioAv24rsUHsJRfuv2CIZ8cU9yAMii7FsF2zSW/+eMdgFiCSemYsQVeLCVNu96Fxt42702lHllm4dKC0W8roqymTdcvnd/X7itvoDQ8DI3TTNw7HQqpvba0mIbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR1101MB2184.namprd11.prod.outlook.com
 (2603:10b6:910:24::20) by BYAPR11MB2967.namprd11.prod.outlook.com
 (2603:10b6:a03:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 14:33:05 +0000
Received: from CY4PR1101MB2184.namprd11.prod.outlook.com
 ([fe80::69fe:fd8e:3436:4572]) by CY4PR1101MB2184.namprd11.prod.outlook.com
 ([fe80::69fe:fd8e:3436:4572%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 14:33:05 +0000
From:   "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] powercap: RAPL: Add Power Limit4 support for Alder
 Lake-N and Raptor Lake-P
Thread-Topic: [PATCH v2] powercap: RAPL: Add Power Limit4 support for Alder
 Lake-N and Raptor Lake-P
Thread-Index: AQHYmGviOrIL5cGlF0SFn38VTAS9XK1/1uqAgAXvnpA=
Date:   Tue, 19 Jul 2022 14:33:04 +0000
Message-ID: <CY4PR1101MB2184DAE94E509EAA213001FCBB8F9@CY4PR1101MB2184.namprd11.prod.outlook.com>
References: <20220715165228.28044-1-sumeet.r.pawnikar@intel.com>
 <YtHEl73BL1BRyl9r@smile.fi.intel.com>
In-Reply-To: <YtHEl73BL1BRyl9r@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 901098c4-88e3-48b1-a006-08da69939785
x-ms-traffictypediagnostic: BYAPR11MB2967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+kCsdGxbfLDWz35cK8zW75RqWGHEtoShTwL6EgchFElMJjMx3ID+zBxbcwmA9W1Lp5i9hb+mYLsZZ8BVmWn51Dpqh5um+hoJULaFa6qd+aWus5EO3PkWqPnqvktCwwn9c24MAJ3Pwl9iwe5OFWHZzv12eZECdt8NV23tm3dGla18VdBXwIBWxrdj2zpq1XIdilmZgFqicwpxCgWMqwGIa1CCCtrfCrHnW/JV/ZGGevvrl3zwwjvlqc6FU5ndyDcFSlbA2n/K9aTKNBd/JF2K1l1xPZSFl5YQ4Ed0iT+uZRaSHgGyECt39fXSzJW/Sz98AY0GFKyE7yCrO+ODVsIbYf8cYv+mZ6kKrSYKxcUpIckvl2DqH5Pp73xyXbeSm0th1r2WD3o8LOgu7St7L0uy0oUNUpQ8A9Ie2becXSMa2BRpoPkdciCR4VxYjQjPHrIeQoWdl0JA7Vsv3zGcnbboF+h+LfPpcL138iQ4v0vEKB/e3fw+PjZGU+KFjVKh2ISox6GeK5HL3/bRv2ARcyN8rMdTBqSHGgJbqZMUKOoY8AO0/SWbHeGiDB/o5z6gnv/InJxA5wk5v2LmqPr2rxrUbX/RoZLh1rlCC65Llru5X6S/UEhYD3Vn+LNHWPwDlN1qu3cL67HA+k4T+62lZ0kEnvicI6GQoVShRcsXmB0F5exroK6nRUpzSLMf7utw5+qC1p2sARkRkW//elBUBMtfZ+Gtht/gHvNxxcpigiGY/NVamVSwAG9+m+Nh8CLD6LuWKv9huZ5aWNPIAU7RA6ODsphWtA0bNVk/zegH8RGdso3JhdOdjco1DlUnTMr8wJd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(366004)(376002)(5660300002)(33656002)(6916009)(86362001)(54906003)(9686003)(83380400001)(55016003)(316002)(8936002)(38070700005)(76116006)(122000001)(6506007)(41300700001)(26005)(53546011)(82960400001)(66476007)(66946007)(2906002)(7696005)(64756008)(38100700002)(8676002)(186003)(478600001)(66556008)(4326008)(52536014)(71200400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M4/31LKdmt+8xUMER8ZIrV+I51hsVxqHTcnbtukFrgbPPgpUU8B/uCiTZCMB?=
 =?us-ascii?Q?J35xeXIRdZLG6ggyW7jTF5gJm+iQUEY0sXWb0wPAiakc8Ecgd9l9nrZYhMcj?=
 =?us-ascii?Q?boIBVOnVTMpOwPUnZ2zdd6ZiVUcpEqZ3qXGwL7dMoaCRY9uDoh+c707lLOVc?=
 =?us-ascii?Q?/yHNCSU/57zcgYxdXrmJ+j0uRnckg5d2xxoiPqxsh0WyQmlfEsauGTTCkgrd?=
 =?us-ascii?Q?ImfUspHt99TP3mzUQc6yqqWBWTfISSnYcsT7LrjWeay2CTK+vxGUvdijgqXA?=
 =?us-ascii?Q?XFJR4Ek8LL30SCxWDlqtNdFQkMpMFvT/M6aFig1r7ZmiWWMaPNsYNvz2OOfs?=
 =?us-ascii?Q?hYTYI7Y9KIJRpADBFpFZBra673zF9RiyFaGOJnmvGz+wn9ZJ8ubzfm5pAi8P?=
 =?us-ascii?Q?j0yRTlUnfJLBkYwCAoom7EyV1QbLL1whvmgPODOrXOvGpqlR95hgjphP7DCV?=
 =?us-ascii?Q?idjBoRTvuwvXn1foHfbY86bo3v0F/VjSQYp9b4je2SM1plf2n3ubbzByNQiv?=
 =?us-ascii?Q?ROP0rkfY0nxX1RQ3JE16MvfqrTDsvioESAMDykiXrNYfve/B5Us++KmUlYXu?=
 =?us-ascii?Q?m8JnBpQRKQQQBKXZXaazkCXDjrpKAXV9j0zF8OEJ0Zm0u0keaGUv1QXB14Ne?=
 =?us-ascii?Q?4hdITCmd7BVzECbUfagM4XJuppeGv/s2HV0Rolbs+505ilM4pDOv1IkTfKgX?=
 =?us-ascii?Q?f+15uHE9vQ6b1x4LVdRvpBex8cRDUiAVHDPUhD0eZ+MNOhvu2z72hKuiGfR9?=
 =?us-ascii?Q?T1UL97M//VFya6k4366BrPP+H4eMfvW7w9/oWDJAIDWvjQ7kN6tMnjv9g7dP?=
 =?us-ascii?Q?SdzGH5uFTGNxWTbw18WHcJNKxViIiGRu22ZwHyJCw/mB0W7Jfw28Sl0Tx7U4?=
 =?us-ascii?Q?QB+/+ZP0kqh0Ov+MBckZTNH6XqgF9fF+jSO0F1HjyolKADqq2YGXRianQRWB?=
 =?us-ascii?Q?ebwtGGrWUaGI91iKLh5SrUzdyx9JrgRKPlr05VYe+gqE6SeuFP6A6EhgagEt?=
 =?us-ascii?Q?9+fxS6LMJBp+njX52b0vRkEQFBtMgFjTT4hyvpWPzQsnRDVUS/ij7SD5lN4N?=
 =?us-ascii?Q?n1MVFOlcGdC1O4/BztKNrpRNU5/RnXWWXTqYAagxVy6OG5r3aaB7XFexzj1I?=
 =?us-ascii?Q?GVfwKfOudP+M5btU6thUktOwl3czJA00574Vk6XYbBp76GK57cHL7lpTppRB?=
 =?us-ascii?Q?/jraawudMWLg1AwOjMtChpve7+/L+HsMT3YtTTth8seaqTrj6C+/T/U2Fj41?=
 =?us-ascii?Q?TTgFDx7/p+Fi84h8kBsjD1s6B6uBIWbxrrOAfbK1uQxdfBMHTnP5tbiiPLqv?=
 =?us-ascii?Q?8GduFIEIPATfVsV4N2todO1YP00gSQjv3NAWTse+aAd34IE9yzI0zNeQfqx5?=
 =?us-ascii?Q?JgHMeEUO7XUUHecB+zlXuf7d0p1tytSphRK50ARa/TRyrtcdUH9IC4uZpBcW?=
 =?us-ascii?Q?CkLFxJQdohu+pSATALE1lWMdXGepokfTiZVPjPuVb89jR66UOTUNuT1iC6ld?=
 =?us-ascii?Q?Mt8hA5+bE5fHa8vZZyqT5ZCC5BgtXrnc3gR+v53/PWlDNhZJubAZuaDgCNEl?=
 =?us-ascii?Q?GiSa6yJhftW69jSERAYuzYrPyV9tQK7MZ2/ZOVt5O9la536Yd6aZuGRPVYJg?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901098c4-88e3-48b1-a006-08da69939785
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:33:04.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6pg68NTDiHhHQ28/2kI3G/FJgt03d4b4C2hEcYzVke3+7UX4I6+pAQkl2N0Goj3Lv/9zBo56hGX2nryfGgvLivQL86QfRlIb4xIwvqFKUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Saturday, July 16, 2022 1:19 AM
> To: Pawnikar, Sumeet R <sumeet.r.pawnikar@intel.com>
> Cc: rafael@kernel.org; srinivas.pandruvada@linux.intel.com; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] powercap: RAPL: Add Power Limit4 support for Alde=
r
> Lake-N and Raptor Lake-P
>=20
> On Fri, Jul 15, 2022 at 10:22:28PM +0530, Sumeet Pawnikar wrote:
> > Add Alder Lake-N and Raptor Lake-P to the list of processor models for
> > which Power Limit4 is supported by the Intel RAPL driver.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> You may not convert people's review into a tag without their consent.
> But taking into account this is trivial patch, it's fine. Just follow the=
 rules next
> time.
>=20
Thanks for your time to review this.=20
Got your point. I'll follow this rule going forward.=20

> Also, where is v1? What are the differences to it?
>=20
Sorry for this confusion. Actually this is the v2 version in the internal r=
eview,
I forgot to remove the v2 prefix when submitting externally.=20
I'll resend this patch removing v2.=20

Thanks,
Sumeet.=20

> > ---
> >  drivers/powercap/intel_rapl_msr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_msr.c
> > b/drivers/powercap/intel_rapl_msr.c
> > index 9d23984d8931..bc6adda58883 100644
> > --- a/drivers/powercap/intel_rapl_msr.c
> > +++ b/drivers/powercap/intel_rapl_msr.c
> > @@ -140,7 +140,9 @@ static const struct x86_cpu_id pl4_support_ids[] =
=3D {
> >  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L,
> X86_FEATURE_ANY },
> >  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE,
> X86_FEATURE_ANY },
> >  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L,
> X86_FEATURE_ANY },
> > +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N,
> X86_FEATURE_ANY },
> >  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE,
> X86_FEATURE_ANY },
> > +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P,
> X86_FEATURE_ANY },
> >  	{}
> >  };
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

