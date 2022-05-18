Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B952AFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiERBl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiERBlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:41:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1BA3EBA6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652838082; x=1684374082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cGVO0K0CfmqAwoxPaMIv+MgsDVRbV9jjA2fyAPBtOxA=;
  b=D6dKmBAAtLAwNZD4IL1sdYXEOg//YE1P4SNaWXYhb12nGzHCQ4SYEYIC
   DvvrQoS4sLkFt68vEzqDwVSvfWutG4WYAD14BCy2nntQr0liBhbN1op27
   VE3y9dZDSh3GU5scFWZ5iQnb4n7yW2nlHw7oiZ2sbkIdUq+49pxIbVJ3L
   Px55lH54juCsBsURQg6z1rhrbldBl2h/CwDMjT1v2WofNlAAFIQq1HAZf
   +J9SLAX61Q37QdXW/buvNB/oyw5EYr8fJNQod+FUtkvQE8lf8MdyCU2/m
   VuEWnn/yLewPS+jysXI3VR5ZEskhRR55L1HtJ+ie4i+AfjQVom7p/qMJz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="269004794"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="269004794"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 18:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="556060163"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 18:41:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 18:41:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 18:41:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 18:41:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 18:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K25qAV/au2NkuJXYBQwGYiiehVNw3fhqI4N475SBN7qeWKXQoiOO+G7CkRQL40IEaJhWDRU5mPdrNT2Hk1YcSfGpubtbNlRauKBSfce394nbwQpuakIl5JKVGlCppYmV9bKdkFIrAZkBIeojHDstTzz74Z4kQ4P/6sFQmDRAUZIBMe+1AnV5CWSUduyt8zQF787JTVQ2g5gAVJg1O3809Bx/DzWcVcrUM73UKCFsVdayuqmZHUyGuAWazOJztwOrXgarPGq2jG8bFLlezYvhJEnQbtUNU8ldAiMuYj5E00rcYfhZmBHxSVR87yJobjzTsu75Qy+8N+UJIDhPCb/eGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAV/WiVsn4OFsa/Vp8fRSgYi6wm7PJQokMKuaY/gV/A=;
 b=eR+Tfkw1uTR966Wnmky2IjKN8+VQVTy7M//Xg1R1ur6RT44fQ07jIAn0o9ZUN2z7i9mxUcGkLz44yAclqqovPuYsAZXCjdOFuDJ3nG0OSki43K3l0oVsLkwwBNVAd9T0pOtSA9dLRTcB/eMgT6/I965+ovx+cDygUMZs50chGinHi5Eg7herEv9DFxQFktmaPV3Ydxz5fU+4P7AUB+ryNYMGRh03zgMrMsFgeq9s5jJcaPzVCAqcgAcknongP8ctCeQ7d0C6nQC/Jm1GDu9W74Ay5OyQ7NRftBikcZSuscPVsZ1w5AM5W+3T+5GQbLyg1SBjMFFyflELD9TDn9OAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by BN8PR11MB3681.namprd11.prod.outlook.com (2603:10b6:408:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 01:41:19 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::bddb:4bad:2f24:955a]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::bddb:4bad:2f24:955a%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 01:41:18 +0000
From:   "Hao, Xudong" <xudong.hao@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>
Subject: RE: [KVM]  5fc3cfa62b: kernel-selftests.kvm.vmx_pmu_msrs_test.fail
Thread-Topic: [KVM]  5fc3cfa62b: kernel-selftests.kvm.vmx_pmu_msrs_test.fail
Thread-Index: AQHYafBqwzklwF/ZmUyDRfX82lZAwa0j3DZw
Date:   Wed, 18 May 2022 01:41:18 +0000
Message-ID: <DM4PR11MB52781191C81A415B044667B288D19@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20220517131654.GB3820@xsang-OptiPlex-9020>
In-Reply-To: <20220517131654.GB3820@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a55cd4d-5fbd-4424-f3bb-08da386f8131
x-ms-traffictypediagnostic: BN8PR11MB3681:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3681D8DA14743F09159E3F9C88D19@BN8PR11MB3681.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fr21FqJ72pI5SgI6CHC4fGNovcwGMP0EO/+7XPfXJ3R4rw1jH37KMdCt8+lEV1WVANDwBnfnGqd8m34jYWOMfGhvE4RfxgBWb6ef4lUvZoYcr61MN7A/XeS3RGpqCXeK5H4rsP/5I/K2NP2Yil12TALD2XK/nbBdXR5lqWdsR3LBY9WLHEuSnXO4A1LVpfxtAYLIwq0UvQTVc3UgmyDrKPEv4igWQDvm321hSPhzpb76GWToDSmeInE9T0O/zvqpwJ4P2UweU5TyV/CERb+TEP5zVZQmXnwWBpX+jJfsGH05NpAqEHNHhGY8+JixgogTmBo664Vg+oVyStIKomG5gyZpA2X7r2nthDvgs3ArYyIWR2c2X5mGGcItEmkfqhpKzZdaHLIwkYjRny5jK5w0eIC0+VpFlfwb2iD6YqhDganyfJyHfuqOXcwwevol60x17Kh89ez6GIWQvCD9aWbsne6RJ1inY1WlvPULHaw31k7uY4hm6449vGJVzTzbuaDwxfBOQcGpOENgX6o25LLO2pnWrSF1prZPPGWwy6Z5qwM+BIgWDJa7i0z+IZrYdq4fFM1wn4jZxUm/GJlLU76L/QHSkPptBvQuDTMKS/5nIl82FbUyrUuQYLZeWnZVMczi1TkrpPjszKDxMa2lx05TncK6v6GMAA3+jSAC7mf4pFGGDs94k1ZdPXZZyPWG0hqDQCcDsXBxeA9+cuaV/f8ky0IGP6kaBtUNepbpiYzTgFS5NMXX6inmMBHEojOFfoVLZUteJT26cNyZZSZASZ89g8etI5Y5A2k+v1l4aiKJvsmmFlrqOylAguMyWcGGSUcdfTr4Df/Ar9ACgsRyLjTrCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(122000001)(52536014)(26005)(6506007)(7696005)(55016003)(186003)(966005)(107886003)(508600001)(5660300002)(38070700005)(38100700002)(86362001)(66476007)(2906002)(66446008)(4326008)(66556008)(76116006)(66946007)(8676002)(110136005)(54906003)(71200400001)(64756008)(9686003)(316002)(53546011)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XASHu4g338ulrebfJYTf1ofYho0/q5XstrlVW/WDVwwZLtHBboXTVJ4zU2cN?=
 =?us-ascii?Q?cAzQ25uWa9aCSzONluqea7idIcJ5peZRcdXolLQ28FJozDW5BkN45YJ/SxBC?=
 =?us-ascii?Q?FsLBDQQOdH9rysv73iFUTXgexlbVdgdywB2ufQX7j0mKk9zg1o/Hyr/bqaFo?=
 =?us-ascii?Q?Dw1GeSdQLfIvfXdNcWBtOtf7d+BTGhxNrTy4wRw1hz81GDKGXk0qwcSJt7gF?=
 =?us-ascii?Q?XY9X+WQiDzhwlqzOFGGeuMFccb7tJ/AcBoAeFg20rXbPXwM8Z2OabJoJNQM/?=
 =?us-ascii?Q?NxqHaKBMk2oRcsETCZ1VIw5r7/SRAJoXm7SAomPobLCdXSHMlhbnvbwhaE2m?=
 =?us-ascii?Q?+DeqaUR3Of/jtS/sQwyForjq/XLqhaMaXnbUSGvusTlNZRdj1I5jGHCRq1A0?=
 =?us-ascii?Q?sXtx4NrlUgiTLsF/UE84fqnTLGsIjqvHZsAyybjSyY1j633BpujUBh4/rtfO?=
 =?us-ascii?Q?fLZ4u30niV1dKLFdLmcpK49Mfl9/a4xLIe/Q9w7yBurwNnUDY/JCYnTxM4Ms?=
 =?us-ascii?Q?2uZC5QRzw4JG9QxIqeMm0tC8WqO1Kz7kn7ddZ20cwZKPAitv55IB4J1zjE64?=
 =?us-ascii?Q?WNPfbp5SSv9T53yprwPJLaDMbiCgOstXGDhT9d2unpN9383CSqcGnurUCgHo?=
 =?us-ascii?Q?vf+rtwspERhXe5ScqYSx5wysyvpdsyw37oUz/4t/3pTDunggKzSZKl8x8ayh?=
 =?us-ascii?Q?evrBxhxr+95zhN85aTHZrUnh7xEJtlHf+vlQ/3HxER4M7XcuQxjo/UMr74qC?=
 =?us-ascii?Q?rTjzcxlGQeV+ZIgi0QmZ/9i/GaTbyLqLBRHd3fwVpXAx6e3adSfuv258up6J?=
 =?us-ascii?Q?KTqP7Ek69lo5ClMmXruHmpdOiHZEfrlbieK4NW+ipSsp8+bLX+FmoHfg29GC?=
 =?us-ascii?Q?fLmNlFpcwsIAJtK2S3p0yNnFifzEsnIoHJGRCcBNeTU63v3p2QGRrteH1App?=
 =?us-ascii?Q?oMFsT/xt8ZG0SiWEsfc+2oLydZ0FlR7Ap8TGPDeXge2tHYrEGt9pciIgNo0b?=
 =?us-ascii?Q?2sTVBI5iG93HMNeag7hQFAU9m1kNnvyBVTPG8y1CWzMj29nYTGj0JyVTolzz?=
 =?us-ascii?Q?MWvrvkrYcDTDM00rD9gnIEK38+q5fH9P0eCMFJQuxk0429iQVsjlCJAe4Pxu?=
 =?us-ascii?Q?8oYmp9QppkkHtS9UjtgtZBM/FEN2YimLCqLTZ5gwcdmBGW+MOYbDm+F3hCeU?=
 =?us-ascii?Q?joTWQfcpJ8IPpEdiObl781c0oWV4uBM9P3kwFT+H8O7zwDNvmc2lVKwYMlKZ?=
 =?us-ascii?Q?9+RVe38i7xnTWEE5yOPwLKuO7gVKu6Yzo432e8gclypDH3XhYfxIqvYz7+mN?=
 =?us-ascii?Q?v/FWfRghL25EsgxxwLhoGymYnWHMp/ilSRxyzSOvZKCxrSkF7PpDig3g4Kbq?=
 =?us-ascii?Q?PVNHHoMdItV50lKg6HkZuka6X8akn4coR7SsdrphGhi6KMejz4021jjpPyAc?=
 =?us-ascii?Q?rkob9CIbtW9HZ3EmudIzAFO20uyzLZ5HALOlvHrdvkP7UssUzXachb9bYDax?=
 =?us-ascii?Q?sKcOYyT/BMUZYvCvdki1SBl27eztEBD90ZYvazaAzfzUuqMaL+VepRRt36fv?=
 =?us-ascii?Q?O3leyQSUAtM5l9CjYwcfxC3N3JVytSYAFY27A+noTekNOBBJ2iCMeAzXyn/y?=
 =?us-ascii?Q?r3uhKzkyTlDNnWfgIK2DWORxDjjbH2xA2ZASO3aHzJkqDv9yhQ4AiSmK9Ak8?=
 =?us-ascii?Q?bFSxE7axWotmQgH/wo250lyoJ2zftexCcLGzDykZ8i0qCp/Ii3Ohgd2Opcvh?=
 =?us-ascii?Q?wNJGKDQMsg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a55cd4d-5fbd-4424-f3bb-08da386f8131
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 01:41:18.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmLe79ykRT3rNI7MslAiso8V+1G3UOrn7Ny4sjl5QO2VOiBFlo1qx2Yt6SUs+ACXcEEfNiE8fJtjSn9GIC31Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Weijiang who submitted a fix patch.

> -----Original Message-----
> From: Sang, Oliver <oliver.sang@intel.com>
> Sent: Tuesday, May 17, 2022 9:17 PM
> To: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; lkp@lists.01.org; lk=
p
> <lkp@intel.com>; Hao, Xudong <xudong.hao@intel.com>; LKML <linux-
> kernel@vger.kernel.org>
> Subject: [KVM] 5fc3cfa62b: kernel-selftests.kvm.vmx_pmu_msrs_test.fail
>=20
>=20
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-11):
>=20
> commit: 5fc3cfa62b85fb60d2383229791f755f333963ed ("KVM: x86: Drop guest
> CPUID check for host initiated writes to MSR_IA32_PERF_CAPABILITIES")
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.15.y
>=20
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-a6eb654d-1_20220501
> with following parameters:
>=20
> 	group: kvm
> 	ucode: 0xec
>=20
> test-description: The kernel contains a set of "self tests" under the
> tools/testing/selftests/ directory. These are intended to be small unit t=
ests to
> exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>=20
>=20
> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with=
 16G
> memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
>=20
> # selftests: kvm: vmx_pmu_msrs_test
> # =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
> #   x86_64/vmx_pmu_msrs_test.c:117: ret =3D=3D 0
> #   pid=3D10285 tid=3D10285 errno=3D0 - Success
> #      1	0x0000000000402643: main at vmx_pmu_msrs_test.c:117
> #      2	0x00007f8bb619309a: ?? ??:0
> #      3	0x0000000000402759: _start at ??:?
> #   Bad PERF_CAPABILITIES didn't fail.
> not ok 32 selftests: kvm: vmx_pmu_msrs_test # exit=3D254
>=20
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
>=20
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>=20

