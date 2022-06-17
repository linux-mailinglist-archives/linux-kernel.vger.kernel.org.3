Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85D54EF52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379390AbiFQCaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiFQCaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:30:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A464D35;
        Thu, 16 Jun 2022 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655432998; x=1686968998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iOTntLsq/YwPdElNvcdYlNs8WESHyvxa34mW+m8Me3M=;
  b=mKS5Miue6OqJTDTtmKZr85VL7v/3tZ+ZPF1UFGxiDSTYUJ8SccSPvbjJ
   IVzy098lkr3TfxhgRMvgE8yttb0y1zhnYWFw/njd2GSW5vaWmrOyvNaWM
   8Rfv0JEDbTEXBnOfeSuXOx5M/vEZw/9CptY5dSjMbUBRR8XgzhyBWCUsN
   +LU5r6y2TGnIeT4EviH1zQewqyGPUN7supUMK7Vvplr1JQJxwjRfm32B2
   ql+jlp48rYNYqbFh7M8h3Kw/zIw33XVMDGCCsETm6t9hYXTPYhGQP1BD6
   01esVhda8zAtOBuBw9V2sA74pGUAL4Po2C0do84WoXX3tz4+Y55vGRipy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279458715"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279458715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 19:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="560169607"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2022 19:29:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 19:29:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 19:29:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 19:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmmfirTdbbPIFQK5lxihI+FrsNu7je2r+yuMz6qh9zQfsLEm4dLt4N3a3JUJ2M58mCAGD4qLBcE93Ctg++RRiwlXEkZUkIQ0XrxA0sCvSJjs3tQXCLLJuX6TRgkRPW7z0Xjet7oj2Dr2b5aJgCS8Rrld3UMN6pjpbC9VcKRAG6qmvWp6vAKNZJEt+tNFgVdFugD5DcVJsL6tVAmLqXq0xJqVa6A/PVYwsTCC87spUbyGeDFWqvpcWeMjI+5QaUHRddbWfLXpAGMdXUE420yb0QAWfP5KUagFNS0ZIsmYG4BVcJsBXHAcCqCbl6areyhRXVMLLhzI1Ue9MOCEIFUb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSAYG840ZDcGrpRlKHfYPAQbTIKIsHpHnfvrLMMndCc=;
 b=Xew1WBTqgb3QgAAr76yeErpBBEEdZMY0MG8rZgvZbxN2ej1aHB+Pq1DOZMIE8NXVDjdD3UFAMtgh/CUKkyQnqrCAVXiigsZMT3WxbqN7mgnqhueIlC7ky3nNL8DV2elJ7F5FBKVOEM6pygaz11/qutwmdDdclCllw7y5nUhyF00KbPl87NLrcw7wHWtm3hHc7CLn+yPHwjuDRjPtduWQ9tVg6WlJLJ2B7ziC4eqpTlpGjk/UGzzi4XBe9d8GkEXhwn9F5QtlgE72hGX2hax3YC5n8n3BdgxdpcwKwC6CVPQRa5/zMgVBDcaShdUbD8b8QnlZi9RMGy2cTjlr/7NRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 02:29:54 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%5]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 02:29:54 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAwgAaO9TCADEieQIABO1aAgADWSiCAABhfcIAgY7WAgAAzoBA=
Date:   Fri, 17 Jun 2022 02:29:54 +0000
Message-ID: <PH0PR11MB5880C6A31DF2ABCE5B43B574DAAF9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58805D24C88CA447B07C276CDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220526181729.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880ECE6C9DE0AC18E9629E5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58805066A0F37013C570B7A5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220616230851.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220616230851.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eac0ecb-cb71-47d0-6dfc-08da500943c7
x-ms-traffictypediagnostic: DM6PR11MB4643:EE_
x-microsoft-antispam-prvs: <DM6PR11MB464345EADF36FA7B54F4CF69DAAF9@DM6PR11MB4643.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Rf+rolYxhuDgf1I+kzAWNSRfpUxW6h3dUlPdY4x0L4ysL2AkWoXogTE2mmfYh3ry45817hyMEj08sjiuKZKVb7ehfpMixLk2WcT1yUb3SiMvEcHvMSJuFMiyEXAuKA1mMFsnyFUvHwyKuvcqFeQwoX3ozZv6tio7O+Rb59uY65ZnQTXv7DCzCoSIBczrvBjsFIwksuT2Jmsr0ud9qS/EchpRWHDFnrY5g1BwvNu9fR8/bw0Ki92+bJF8ymBGgBrU4Mg/A67/wlh8JLJLA9lsu33UtS5YRoocIXFa784M8bpSRz/BJkMD2WVxHslZgLnm8GdNj37vUBUGKP1w1KzmKnNsJv7Of96QW5aRQ9lpm/EjwabSkrGG90O2w3l+pREqiyxuo8tWSETM8bLShiU2yZDE+taikkGBMSv8lOQoYiTAYJylHojjbZ1cGq0MRhIepHA9bKwpG/qaq6B3eDppPH33iLi79Ifc8EjowV072t2NJd6wghjWEiqqmLH3T9+HBjk303pdepaA9Qgp05SRaWDQNv1OXNSRGA8HXpyR6L4BF4PQU3PDD9sdMbFUMhhbdJLX7hMsStJ8sGrMWQHEs69Ktvr/D3d3HQRKU6IexGk2/CML4AV2JAnrZJ5NODlGRgmi6xHj4TZ4f0GLvChg1snpZCYEK81i+5j5lh0ZYVJLYkJLQdyiHLClmJLtb+feUeHMqysblSHBIGe8uVsJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(26005)(8936002)(33656002)(508600001)(7696005)(2906002)(6916009)(54906003)(6506007)(4326008)(52536014)(8676002)(66946007)(76116006)(66446008)(83380400001)(66476007)(64756008)(66556008)(30864003)(45080400002)(55016003)(38100700002)(5660300002)(86362001)(38070700005)(71200400001)(9686003)(82960400001)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cOIn1ZgUEUOF7Uge8KCifVlNAJLeRc2BbLLoJL3NKMUkm5epeIi5VdhNjeEy?=
 =?us-ascii?Q?zE3qZ1rC7YovNg0YOckizBcH7mV+7uhlukIpexyUaVu10mrhA4AxcrrWAOJk?=
 =?us-ascii?Q?tOXe3BPQoJ/bDZ1GlEKvx3TmCuZEsrT2HioI1XmQqSDQT2S4zlSaTXSJatHe?=
 =?us-ascii?Q?0jeNa+UH2w2PCPW/+fIKKBHPRGNOZuqfzq2MOGSooCkL8i5iRYVrq2s061qR?=
 =?us-ascii?Q?Bz1hDsGRMYP6DIKK3YWAK2JAV2MN2Z1/TFShjfmYfwnIzyOBWNaG86dbZF7f?=
 =?us-ascii?Q?8KsOp24SpHQr0KCpZtdkM109/RB1PHlPhkJ5l3HBtcHs4rDTAv3cHqi/QaCE?=
 =?us-ascii?Q?EzuMB03+dCRvzBwXRfzQE74tbjZJY3R9sOs4n0MclQzzR7Hhqbq58x0G1jlT?=
 =?us-ascii?Q?rKi+uS501pX0WgVcx2z5Y0ApRFFWT5lZD9NP/gUckLffQtHmvU9QAg+ooXrj?=
 =?us-ascii?Q?wbbDuc8ssXfwHyjeoUmYCg494iB8htE+rSV0pjSYWKL1BtBdTcK9GVnEN2PZ?=
 =?us-ascii?Q?C2QObGDiKELaxirTNd1oc0Hj/2E3h+FG0W5mzF0klaSBtK+ey+aajLfNjlu4?=
 =?us-ascii?Q?9YyVSQTRS8iI1ImVumsvX/jvxjw3F0GjeH1N8PlWrMQsIUNhutwpdH2vRLJn?=
 =?us-ascii?Q?RhvmtKmt4AbxcL+502Gnx25RNGQIujdTdfg/PhEV7kE5CGxpQ68nJbuJM6Ma?=
 =?us-ascii?Q?YUB0ZCREaYQqXggz6BQuMl3zbi/ee9janre+UIwA1KFLdTuEE5nJdVWTs6Zj?=
 =?us-ascii?Q?S3FSrd37yKNGM1zBA5BqZiP6bhM8ImI8wrZgP76fGgipAZ/Kin6YvjeukS3n?=
 =?us-ascii?Q?8P8gJbhD0qqmgUtyPSSGTVOJ7qvAjcKN3FGcBL94Q8SNijeZjCWMQpBkfC4a?=
 =?us-ascii?Q?+gg5MfuJ8xSaVcmY4C/k77AdV9h2lukFEeEyXUyd5h7tLxHyr/WCs6aELH7Q?=
 =?us-ascii?Q?FacTV3A9PCoo4w8pkPeMdn9LjBJ0b631hA7HfJNxggGxYP8O3txrNE1/MlXT?=
 =?us-ascii?Q?qOAoRAZVTqeft2IRo8Q1ZPtGGfhIz9Z/TR5Oec3ZJ8SFTMzzyclVz5LmOgF6?=
 =?us-ascii?Q?KYimkVZuCqNnUoPj1qogddRi6BNVy16f5wGx0HujhLorhuRMWV/R0kli00yH?=
 =?us-ascii?Q?nKm4zMrvwz9bpsZy4vtnbYg2pE6F09E+DAAJSamO87rMLxIpwHFPCnDMJhKs?=
 =?us-ascii?Q?Ve6NdTFqry5L87SxVKwRNRYuVsDiZNXsh2CSWzDihWbnsYkCt9MEKGrqPIJE?=
 =?us-ascii?Q?FddSnuSxQfie/ayFrQsJIh9gaov8Q0LGda2pPeodzGE/IoFLkFAUR9w+zlst?=
 =?us-ascii?Q?e5OpS2doBNJEnl8Ln8gz2G9v6a4iamTNjR65UF8XLu3wDA/1WakwWL0V+l5d?=
 =?us-ascii?Q?0C82+RXn2WgYrMA5IcAhGppVdpkv4qbXsjj2O29lmrYNocoUCshZsTLakFsB?=
 =?us-ascii?Q?iirdwKRCVZAaQinvPUW67vTA9u4dB11yWIyLVjTg3Gd4Tjf4RCfPTAW7wCTb?=
 =?us-ascii?Q?AroeBzhqseXHqlWeo1f2ltQuhZZsuqk2ReE8wREW+eYc5RRk9LU8vTasw8Wp?=
 =?us-ascii?Q?PyhRo50k/uoHnacU+lsyMB2ozy/LVcwwhokRE9M6TLp5vd41dnXNGa/Fx5Q9?=
 =?us-ascii?Q?RlM1rxKjcjLHVNHg1/bXqsE5eyZlm4Abawg2vEbuTGPbZzKB5z9OgtGrob1o?=
 =?us-ascii?Q?6bqenK4mMRIL6binr7DhKDPIkDesLBM7zn/lWPdpMIBHry1Kxj3WvJQPyXsI?=
 =?us-ascii?Q?mkDlg/UspQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac0ecb-cb71-47d0-6dfc-08da500943c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 02:29:54.7792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukppjsyb1wlL85xQSlIN2+oztV02ShqVRvFv2Q+68HF/x4jljSb8PTDaOLwFfukrDugAWeIXyVTSdxf6JUTP9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 08:34:20AM +0000, Zhang, Qiang1 wrote:
>=20
>=20
> On Wed, May 25, 2022 at 11:33:46PM +0000, Zhang, Qiang1 wrote:
> > On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> > > On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > > > Currently, the double call_rcu() detected only need call
> > > > debug_object_activate() to check whether the rcu head object is=20
> > > > activated, the rcu head object usage state check is not=20
> > > > necessary and when call rcu_test_debug_objects() the
> > > > debug_object_active_state() will output same callstack as=20
> > > > debug_object_activate(). so remove
> > > > debug_object_active_state() to reduce the output of repeated callst=
ack.
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > >Could you please post the output of the dmesg output of a failed che=
ck with your change?
> > > >
> > >=20
> > > Original output:
> > >=20
> > > [    0.818279] ODEBUG: activate active (active state 1) object type: =
rcu_head hint: 0x0
> > > [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug=
_print_object+0xd8/0xf0
> > > [    0.818301] Modules linked in:
> > > [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W     =
    5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > > [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> > > [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 =
44 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 =
00 <0f> f
> > > [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > > [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000=
00000000000
> > > [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffe=
d1020067f4c
> > > [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffff=
bfff3bf5c6d
> > > [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 00000=
00000000001
> > > [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 00000=
00000000000
> > > [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) =
knlGS:0000000000000000
> > > [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000=
000001506e0
> > > [    0.818330] Call Trace:
> > > [    0.818331]  <TASK>
> > > [    0.818333]  debug_object_activate+0x2b8/0x300
> > > [    0.818336]  ? debug_object_assert_init+0x220/0x220
> > > [    0.818340]  ? __kasan_check_write+0x14/0x20
> > > [    0.818343]  call_rcu+0x98/0x1110
> > > [    0.818347]  ? vprintk+0x4c/0x60
> > > [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > > [    0.818354]  ? strict_work_handler+0x70/0x70
> > > [    0.818357]  rcu_torture_init+0x18be/0x199e
> > > [    0.818361]  ? srcu_init+0x133/0x133
> > > [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > > [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.818374]  ? srcu_init+0x133/0x133
> > > [    0.818377]  do_one_initcall+0xb3/0x300
> > > [    0.818380]  ? initcall_blacklisted+0x150/0x150
> > > [    0.818382]  ? parameq+0x70/0x90
> > > [    0.818385]  ? __kasan_check_read+0x11/0x20
> > > [    0.818389]  kernel_init_freeable+0x2b2/0x310
> > > [    0.818392]  ? rest_init+0xf0/0xf0
> > > [    0.818396]  kernel_init+0x1e/0x140
> > > [    0.818399]  ret_from_fork+0x22/0x30
> > > [    0.818402]  </TASK>
> > > [    0.818403] ---[ end trace 0000000000000000 ]---
> > > [    0.818405] ------------[ cut here ]------------
> > > [    0.818405] ODEBUG: active_state active (active state 1) object ty=
pe: rcu_head hint: 0x0
> > > [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug=
_print_object+0xd8/0xf0
> > > [    0.818424] Modules linked in:
> > > [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W     =
    5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > > [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> > > [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 =
44 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 =
00 <0f> f
> > > [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> > > [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000=
00000000000
> > > [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffe=
d1020067f4a
> > > [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffff=
bfff3bf5c6d
> > > [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 00000=
00000000001
> > > [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 00000=
00000000000
> > > [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) =
knlGS:0000000000000000
> > > [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000=
000001506e0
> > > [    0.818451] Call Trace:
> > > [    0.818452]  <TASK>
> > > [    0.818453]  debug_object_active_state+0x1d6/0x210
> > > [    0.818456]  ? debug_object_deactivate+0x210/0x210
> > > [    0.818460]  ? __kasan_check_write+0x14/0x20
> > > [    0.818464]  call_rcu+0xb7/0x1110
> > > [    0.818466]  ? vprintk+0x4c/0x60
> > > [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > > [    0.818472]  ? strict_work_handler+0x70/0x70
> > > [    0.818476]  rcu_torture_init+0x18be/0x199e
> > > [    0.818479]  ? srcu_init+0x133/0x133
> > > [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > > [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.818492]  ? srcu_init+0x133/0x133
> > > [    0.818495]  do_one_initcall+0xb3/0x300
> > > [    0.818497]  ? initcall_blacklisted+0x150/0x150
> > > [    0.818500]  ? parameq+0x70/0x90
> > > [    0.818503]  ? __kasan_check_read+0x11/0x20
> > > [    0.818507]  kernel_init_freeable+0x2b2/0x310
> > > [    0.818510]  ? rest_init+0xf0/0xf0
> > > [    0.818513]  kernel_init+0x1e/0x140
> > > [    0.818515]  ret_from_fork+0x22/0x30
> > > [    0.818519]  </TASK>
> > > [    0.818520] ---[ end trace 0000000000000000 ]---
> > > [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu=
_torture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> > >=20
> > >=20
> > > After apply this patch:
> > >=20
> > > [    0.647048] ODEBUG: activate active (active state 0) object type: =
rcu_head hint: 0x0
> > > [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug=
_print_object+0xd8/0xf0
> > > [    0.647073] Modules linked in:
> > > [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W     =
    5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> > > [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> > > [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 =
44 89 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 =
00 <0f> 0b 83 05 7b 62f
> > > [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > > [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000=
00000000000
> > > [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffe=
d1020067f4c
> > > [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffff=
bfff467586d
> > > [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 00000=
00000000000
> > > [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 00000=
00000000000
> > > [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) =
knlGS:0000000000000000
> > > [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 00000=
000001506e0
> > > [    0.647104] Call Trace:
> > > [    0.647104]  <TASK>
> > > [    0.647106]  debug_object_activate+0x2b8/0x300
> > > [    0.647110]  ? debug_object_assert_init+0x220/0x220
> > > [    0.647114]  ? __kasan_check_write+0x14/0x20
> > > [    0.647118]  call_rcu+0x98/0x1100
> > > [    0.647121]  ? vprintk+0x4c/0x60
> > > [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > > [    0.647129]  ? strict_work_handler+0x50/0x50
> > > [    0.647133]  rcu_torture_init+0x18be/0x199e
> > > [    0.647136]  ? srcu_init+0x133/0x133
> > > [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > > [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> > > [    0.647151]  ? srcu_init+0x133/0x133
> > > [    0.647155]  do_one_initcall+0xb3/0x300
> > > [    0.647157]  ? initcall_blacklisted+0x150/0x150
> > > [    0.647160]  ? parameq+0x70/0x90
> > > [    0.647164]  ? __kasan_check_read+0x11/0x20
> > > [    0.647167]  kernel_init_freeable+0x2b2/0x310
> > > [    0.647171]  ? rest_init+0xf0/0xf0
> > > [    0.647174]  kernel_init+0x1e/0x140
> > > [    0.647177]  ret_from_fork+0x22/0x30
> > > [    0.647181]  </TASK>
> > > [    0.647182] ---[ end trace 0000000000000000 ]---
> > > [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu=
_torture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> >=20
> > >Very good, and thank you!
> > >
> > >Now suppose that someone passes a pointer to call_rcu(), but then invo=
kes kfree() on that same object before the grace period ends.
> > >Is the offending kfree() flagged?=09
> > >
> > >If the CONFIG_DEBUG_OBJECTS_FREE is enabled, the debug_check_no_obj_fr=
eed() will check wether the object is activated in kfree() If is activated,=
 also output callstack.
> > >
> > >__debug_check_no_obj_freed()
> > >{........
> > >	switch (obj->state) {
> > >	case ODEBUG_STATE_ACTIVE:
> > >	 	descr =3D obj->descr;
> > >		state =3D obj->state;
> > >		_spin_unlock_irqrestore(&db->lock, flags);
> > >		debug_print_object(obj, "free");
> > >	}
> > >.........
> > >}
> > >
> > >Hi Paul
> > >
> > >The __debug_check_no_obj_freed() only check obj->state,  don't care ob=
j->astate, the debug_object_active_state() is not necessary.  If CONFIG_DEB=
UG_OBJECTS_FREE is not enabled, the kfree() will directly release it withou=
t check obj state.
> > >
> > >Any thoughts?
> > >
> > >Thanks,
> > >Zqiang
> >=20
> > Hi Paul
> >=20
> > Sorry to bother you again, I think this change is still meaningful,=20
> > or there is something I don't konw if I can give you some suggestions, =
I will be happy to accept.
>=20
> >My concern with this patch is that there might be some odd scenario
> somewhere in which valuable debugging information is lost. =20
> Unfortunately,
> >I haven't had time to fully explore the space of possible sequences=20
> >of double-free and use-after-free bugs.
> >
> >It -might- be OK, but I cannot prove it.  Thoughts?
>=20
> If CONFIG_DEBUG_OBJECTS_FREE is disabled,  invokes kfree() to release=20
> pointer before the grace period ends,
> kfree() will directly to release it, there are not call debug_check_no_ob=
j_freed() to check this debug-object corresponding to this pointer, when th=
is pointer is checked before call RCU callback func, the  debug_object_acti=
ve_state() and debug_object_activate() is not trigger warnings. because thi=
s object state is correct.
>=20
>=20
> However, if CONFIG_DEBUG_OBJECTS_FREE is enabled,  when invokes kfree() t=
o release pointer before the grace period ends.
> We only check the state of the object(obj->state is set by debug_object_a=
ctivate()) corresponding to this pointer, the obj->astate Is not be checked=
, That's is one reason I remove debug_object_active_state(), and I found th=
at few modules use this function.
>=20
> Now there is another problem,  set CONFIG_DEBUG_OBJECTS_FREE and CONFIG_D=
EBUG_OBJECTS_RCU_HEAD  is enabled I did a simple test like this:
>=20
>        struct rcu_head *rhp =3D kmalloc(sizeof(*rhp), GFP_KERNEL);
>         preempt_disable();
>         rcu_read_lock();
>         local_irq_disable();
>         if (rhp) {
>                 call_rcu(rhp, rcu_torture_err_cb);
>         }
>         local_irq_enable();
>         rcu_read_unlock();
>         preempt_enable();
>         kfree(rhp);
>=20
> the follow warning are triggered,
>=20
> ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
> [    1.255220]  debug_check_no_obj_freed+0x248/0x280
> [    1.255238]  kfree+0x12d/0x610
> [    1.255253]  rcu_torture_init+0x16e1/0x1741
> [    1.255305]  do_one_initcall+0xe5/0x440
> [    1.255349]  kernel_init_freeable+0x342/0x3a0
> [    1.255366]  kernel_init+0x1e/0x140
> [    1.255373]  ret_from_fork+0x22/0x30
>=20
> The code shows that if obj->state is always STATE_ACTIVE, there will be a=
 loop,  until rcu callback is invoked set this obj->state =3D STATE_INACTIV=
E.  after that this loop ends. If we invoke kfree() in preempt_disable/enab=
le() critical sections before grace period ends, it may be trigger RCU Stal=
l.  So maybe we should add fixup_free functions to rcuhead_debug_descr, In =
fixup_free function, set obj->state is STATE_INACTIVE and set rcu_callback =
func is rcu_leak_callback() to fix this problem.
>=20
> static void __debug_check_no_obj_freed(const void *address, unsigned long=
 size) {
>     .. ........................
>         for (;chunks > 0; chunks--, paddr +=3D ODEBUG_CHUNK_SIZE) {
>                 db =3D get_bucket(paddr);
>=20
> repeat:
>                 cnt =3D 0;
>                 raw_spin_lock_irqsave(&db->lock, flags);
>                 hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
>                         cnt++;
>                         oaddr =3D (unsigned long) obj->object;
>                         if (oaddr < saddr || oaddr >=3D eaddr)
>                                 continue;
>=20
>                         switch (obj->state) {
>                         case ODEBUG_STATE_ACTIVE:
>                                 descr =3D obj->descr;
>                                 state =3D obj->state;
>                                 raw_spin_unlock_irqrestore(&db->lock, fla=
gs);
>                                 debug_print_object(obj, "free");
>                                 debug_object_fixup(descr->fixup_free,
>                                                    (void *) oaddr, state)=
;
>                                 goto repeat; ............................=
...
> }                             =20
>
>One thing to keep in mind is that if the kernel reports a major bug such a=
s double free or use after free, there are limits to how much work should b=
e put into keeping the kernel limping along after that.  So reporting the f=
irst failure is very important, but reporting second and subsequent failure=
s is only "nice to have".

Thanks, I hadn't thought about this before, now ,I agree with this view poi=
nt.

>
>At this point, my thought is to leave the code as it is.

Agree

Thanks
Zqiang

>
>Or am I missing some additional breakage with the current setup?
>
>
>							Thanx, Paul

> Thanks
> Zqiang
>=20
>=20
> >							Thanx, Paul
>=20
> > Thanks
> > Zqiang
> >=20
> >=20
> > >Thanks,
> > >Zqiang
> >=20
> > >
> > >							Thanx, Paul
> >=20
> > > Thanks,
> > > Zqiang
> > >=20
> > >=20
> > >=20
> > > >							Thanx, Paul
> > > >
> > > > ---
> > > >  kernel/rcu/rcu.h | 13 +------------
> > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> > > > 15b96f990774..0604ecd16627 100644
> > > > --- a/kernel/rcu/rcu.h
> > > > +++ b/kernel/rcu/rcu.h
> > > > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsi=
gned long new, unsigned long old)
> > > >   */
> > > > =20
> > > >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > > > -# define STATE_RCU_HEAD_READY	0
> > > > -# define STATE_RCU_HEAD_QUEUED	1
> > > > =20
> > > >  extern const struct debug_obj_descr rcuhead_debug_descr;
> > > > =20
> > > >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > > > -	int r1;
> > > > -
> > > > -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> > > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > > -				  STATE_RCU_HEAD_READY,
> > > > -				  STATE_RCU_HEAD_QUEUED);
> > > > -	return r1;
> > > > +	return debug_object_activate(head, &rcuhead_debug_descr);
> > > >  }
> > > > =20
> > > >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  =
{
> > > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > > -				  STATE_RCU_HEAD_QUEUED,
> > > > -				  STATE_RCU_HEAD_READY);
> > > >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> > > >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > > --
> > > > 2.25.1
> > > >=20
