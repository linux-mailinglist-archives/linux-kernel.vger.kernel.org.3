Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9A52B163
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiEREVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiEREVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:21:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4A31529;
        Tue, 17 May 2022 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652847671; x=1684383671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UxWzub6csSIQjIjTmS0Vgv67VbrycBHJ8EJsVP7fIaw=;
  b=EwbNJTPZ7PLc9TeCefja0L/IEz3ewotXJ0Uh1KBUrda+7LfCI2Sel74V
   mJj2eYYnJfzk6NBASun94S2EylquePI6e3gXszV3qf6KuNDgpTla2NC2a
   +75VaVYoDNJg4lABOhszxzqRUp2pV6HSyP7P7BPYfAp9LaIeucIjG1mXC
   yBg3R8e+KkGv4UqS/+tJRRwPUChd9IoEQC5YfUC9eplUjJJeHTdogEDqp
   8VH0HUjT1qkFYT4XWii1qf7P7tghkmpjs/JbqSbuKgKpzx7vdd90ZFa7T
   nLo0iSZzhpAE5jIcJnen0vr2Adn+zz1gcTBvWsB9+ufUn2hm4pytUzwIU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271164680"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271164680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 21:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="523312132"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2022 21:21:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 21:21:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 21:21:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 21:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+doCLUWzikuPlCMjx/63/Me/bCYOE0VYdH4zsJlAJq98c2iAR52f58RYU0fgPaC1c6+2TK5z/z+6xFz0NGEZYrduk6VqDlgb1MxI1XHALbAm2TzUEcwTNHxpd5D3DgAa/88EAs3Gi/RJvIIaIRZjrkO4YvlozMHr9XNBP9G4QRLvRn3Tm70PWDYtUC+OywEma4zhOE+TfyvRVJV4CukntqzNA8PIC5+vSLi2XSS/+hDjaZ5B3Y6dZPHEF2jCWenlnr8NUNAGStfRWeN+dLOMb/8rRL7QVMLClwIHqhSXQ5dtuxIaMNLCE68moIm93P98ei/VtKTxyfCmLkA/GzCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ncA19XYRvpVyc0WDVrnm2ORURUsX+aFjK1qw4KsXdU=;
 b=UfPn81LfyGXBlcXXlaKJo3bKRU3QWzzqzKw83VRQvzD5bznwNJB0voaSXI21JgRDxKeRUlYV+hWkiosIW/SFa5uvbl76Y+vDf5p72nZxIW9C/p07frJMJim/KxNSJOKjmzU8v5QNSJBQTngbfpGpt4aRkMhb1NsCuz31Tc+SL2iMzJ0PyjgCRIdBI7Ewb1ouvhiclsCW7OMUUDe3o5F+28Qcx6OiSggz9bKC6EkmBiU+oJNLb2bQnNOARTcuzBgPoLCg2b0chSgzOtMVx8XCjwl6RDfTi/bx2xbYIRdOyWnnMYXhBtewJz2Y9PYgMfSMZ5kSfbbaU+uhlUi3pB6N6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN6PR11MB3216.namprd11.prod.outlook.com (2603:10b6:805:c1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 18 May
 2022 04:21:08 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%6]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 04:21:08 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAwgAaO9TA=
Date:   Wed, 18 May 2022 04:21:07 +0000
Message-ID: <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e193c5bb-534f-46ba-0f0f-08da3885d4e6
x-ms-traffictypediagnostic: SN6PR11MB3216:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3216851844FAD796453838F8DAD19@SN6PR11MB3216.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j42bKGDLtjSjD2/S6RZWeTnjFRRXGrvmatgHtYsCSoKZfraD6ESQfo+b07Z7as4Ni5PskgSZhdlE10JbLR1o+17ZNEhnUsO7ODFw85rTDl8xcipfgn26tgh+qIwpAZnJ+c+jo8BDHH0MrLlTkkWMoFlQ0oPKmj8zcBB/HZ8exG5jTu2UQxP3yru0hR33sr9YXk8FLig6Lj+qkotc4WnIWi9tn3Jsvha3pS8Ie8K2sBmtDrnteIhihu/HeS0fQfWOdnhMKjqlXKXwBShpSnAY1Q81AHIzjNMygtcHt2vr0tUkks+uf9onAaXLLqPu10lj4LDDivwz3oPLeO28g6ELEEknmcbX/QLtHiDCWSUDGxykB2qwv6obI25+YKtxi8RVjyIwZ7BFkHCuz260y+ERJri9EkekUg2QO1t8jzRddcMmKWLB6ca8s2vBOXcm1KAVL4ej16NDqn8UPPv2f/WEhpc1FBqWchEQuX0ormdwJMyqqGCkQHPJ199ZB9aTrxZT9wJlhHN1WIHsdxnlPpVi0nea97czdp83ZKzbSdNzA1h2tnl9VOkI5ahAEbUyuFPTC/LyZ0nPjmXs/pKXtOwM77zlYOKjsqkqA+kDnQ8THsRvKRtsXtzmma7lj8LOqH/G6WgJAoYbuSsJwa+5OKmKHywDnKeYJa62WORwKRbQEQipsfxXmsOFFMmfyq1t9EEcJ2+qejuIuvq9NoEIaDR69A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(71200400001)(82960400001)(9686003)(508600001)(110136005)(316002)(33656002)(54906003)(45080400002)(2906002)(76116006)(122000001)(8936002)(7696005)(86362001)(6506007)(55016003)(66476007)(186003)(66556008)(66946007)(66446008)(30864003)(4326008)(64756008)(8676002)(38100700002)(38070700005)(52536014)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EqzgyrI1sxlfSoU08lMMWz8r37naMTXQdvsbdOZHP1FfCNx2nJ+UQxlt5YnR?=
 =?us-ascii?Q?mXLAeGQwvkez+hIwpgU1gFbn7A1o2S6An4mmnDlLLZ/QTblZb/AYgUmKjV6b?=
 =?us-ascii?Q?Kxt10T9+Z/4qkEpim8Uw32S3KPKyWtf3t2phFbDQsy28As7PWJf4uQXOeAK5?=
 =?us-ascii?Q?sRucIfg3KjjY2TkwnWN/+7UrqHES2hLnhb23VYQnL2MtPSRHlXe1r4NefeqX?=
 =?us-ascii?Q?5AzpNwGbsT9J6/7jvi3wkqe7laKO7lPoZduMMMab6p9uwsBK2OjxBDFj1H0/?=
 =?us-ascii?Q?wEASYoTkfM4MK1fPSvRjADdslS4fvCDyV+ishiRcENZsYWXH45W3+CpckylT?=
 =?us-ascii?Q?hfiRMcRWoTWoPg6jXzJCmM4ief6F5VmwbMXT2YYXvesJKPjV85VV/xKMYtpk?=
 =?us-ascii?Q?D/XcbQAV7I7xHnKdAwzgJa7iJv08xj8lqbWnGVyKEDqG5oHTpVQNi3HFVyha?=
 =?us-ascii?Q?TgBrEfTn5FOpxuFurDPIeSboIIsdTnJxsHr8PxWiYCXf5qrrRmTAgoqypEiT?=
 =?us-ascii?Q?UhCKeruIeDWV+9x1kw2l7+aquX3wHxfFrbzvU8WszAPboh+/+k0jnG7ZYTnQ?=
 =?us-ascii?Q?ilmKCesWax7z0AWfZYd6mEeDk2u5JxH2Lij9nqExhytMycNrI6XIvXZQqG5o?=
 =?us-ascii?Q?65SDOrws84i5ZqDx1NmiPJrOfMIhSjoSoM0CvGsmv8FO/7hfMcVzgjtt/m0s?=
 =?us-ascii?Q?rMJQhcFeUazrVUlEZV+JNxTe7fP1nvZbHHTtyWMKvyAdd/SL1J9trjli64Wq?=
 =?us-ascii?Q?zIrAs4Lwlg+SLx5HCaK0K5WLvMMt8Fyjn0XYdnJvRfMUD+/Nr+zbknv1XP63?=
 =?us-ascii?Q?MKu5QguAxzkVxcZlMg+rVz6nx/gmunYpW3fr9r8U+Qn9XV8xd6tQfGDlI0RW?=
 =?us-ascii?Q?YTC2D0wKUsR48t1kF96MoJlvPSy+jfxMl9IV/YmJCkkbC1TeODyCN4I65gdO?=
 =?us-ascii?Q?AJClv7KTs4mUqMPPQivJZMEPmXWyoBT6cIYseS9Fz3kC76rnD9MVZ/hGme2L?=
 =?us-ascii?Q?x+HMhl895OzCkJMMuhXEVHxKs15D380P2jJlZlKgCulk23geGm2IFIXtPpCa?=
 =?us-ascii?Q?CHwn+LYdVRC3rysj5wjrBFKcyJrL1PAswskU0Dbo8G9iyMPVwL7VMgZUKvG7?=
 =?us-ascii?Q?GEECoF1C8tscugf4IeXDV9dC1qphhUFxKjkhb/TdPQBwxia4tNnZLt51fzIX?=
 =?us-ascii?Q?V8IPsOwkQUHwombY6DtBay2cM8UhZLcrf9UqBRburUYgbYaPjMdimDMjir9U?=
 =?us-ascii?Q?SI31MxP39N2EDpXpUgHmQuVcx4wuWqFckmlMF3skvXpxrBgU31hrKh9c8XUz?=
 =?us-ascii?Q?5boaOZN7ZIP2kxaf8I4EhyqE5yNAIYCO1dtvDjTTmbFx+q1MFI7pihwt/kYy?=
 =?us-ascii?Q?jCzugbmpGqLgnX6Qggh7CbTgSL/Mpoq3H23w5sswg7LfVm+hA2eW3vF2ej48?=
 =?us-ascii?Q?uwveAlukKX3FJkudmxobMaNpfSrJT2an4EWrLxVT+VGg9UcCbnwhxVd6Q/N0?=
 =?us-ascii?Q?nx55qkRu3r5dfNDddcQD96RvBCcvf04dvd67gbl0wEwCY/aJ9sDyUlPgOxDz?=
 =?us-ascii?Q?tmGq8c9TqXpQc2kgV4DHRXt3qZW/kGyOBfHU26uV72C4Dy+pAi2qC33Dexbl?=
 =?us-ascii?Q?XDyqsf/glK8S4pSTTa3A6m511OeyarnVj+CqL3puOuquLJ96OTnVORBUbjac?=
 =?us-ascii?Q?hBa4LtDjdicambXye4cwBW1OEXIpWc8wtSmzzv4l2ztVAIXPLVtpifLHOfsB?=
 =?us-ascii?Q?Wji3/BI1ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e193c5bb-534f-46ba-0f0f-08da3885d4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 04:21:07.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9EMT+Ujv6MVPpDYd8+GKLapBn7Q0zZaMqx/vOuLCtz2nB0EoDcGem/KELU1/7/PqTLZovIg0bE+l6tkp7MV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > Currently, the double call_rcu() detected only need call
> > debug_object_activate() to check whether the rcu head object is=20
> > activated, the rcu head object usage state check is not necessary=20
> > and when call rcu_test_debug_objects() the
> > debug_object_active_state() will output same callstack as=20
> > debug_object_activate(). so remove
> > debug_object_active_state() to reduce the output of repeated callstack.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Could you please post the output of the dmesg output of a failed check w=
ith your change?
> >
>=20
> Original output:
>=20
> [    0.818279] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.818301] Modules linked in:
> [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <=
0f> f
> [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4c
> [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbfff=
3bf5c6d
> [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 000000000=
0000001
> [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 000000000=
0000000
> [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlG=
S:0000000000000000
> [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 000000000=
01506e0
> [    0.818330] Call Trace:
> [    0.818331]  <TASK>
> [    0.818333]  debug_object_activate+0x2b8/0x300
> [    0.818336]  ? debug_object_assert_init+0x220/0x220
> [    0.818340]  ? __kasan_check_write+0x14/0x20
> [    0.818343]  call_rcu+0x98/0x1110
> [    0.818347]  ? vprintk+0x4c/0x60
> [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818354]  ? strict_work_handler+0x70/0x70
> [    0.818357]  rcu_torture_init+0x18be/0x199e
> [    0.818361]  ? srcu_init+0x133/0x133
> [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818374]  ? srcu_init+0x133/0x133
> [    0.818377]  do_one_initcall+0xb3/0x300
> [    0.818380]  ? initcall_blacklisted+0x150/0x150
> [    0.818382]  ? parameq+0x70/0x90
> [    0.818385]  ? __kasan_check_read+0x11/0x20
> [    0.818389]  kernel_init_freeable+0x2b2/0x310
> [    0.818392]  ? rest_init+0xf0/0xf0
> [    0.818396]  kernel_init+0x1e/0x140
> [    0.818399]  ret_from_fork+0x22/0x30
> [    0.818402]  </TASK>
> [    0.818403] ---[ end trace 0000000000000000 ]---
> [    0.818405] ------------[ cut here ]------------
> [    0.818405] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.818424] Modules linked in:
> [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <=
0f> f
> [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4a
> [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbfff=
3bf5c6d
> [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 000000000=
0000001
> [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 000000000=
0000000
> [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlG=
S:0000000000000000
> [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 000000000=
01506e0
> [    0.818451] Call Trace:
> [    0.818452]  <TASK>
> [    0.818453]  debug_object_active_state+0x1d6/0x210
> [    0.818456]  ? debug_object_deactivate+0x210/0x210
> [    0.818460]  ? __kasan_check_write+0x14/0x20
> [    0.818464]  call_rcu+0xb7/0x1110
> [    0.818466]  ? vprintk+0x4c/0x60
> [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818472]  ? strict_work_handler+0x70/0x70
> [    0.818476]  rcu_torture_init+0x18be/0x199e
> [    0.818479]  ? srcu_init+0x133/0x133
> [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818492]  ? srcu_init+0x133/0x133
> [    0.818495]  do_one_initcall+0xb3/0x300
> [    0.818497]  ? initcall_blacklisted+0x150/0x150
> [    0.818500]  ? parameq+0x70/0x90
> [    0.818503]  ? __kasan_check_read+0x11/0x20
> [    0.818507]  kernel_init_freeable+0x2b2/0x310
> [    0.818510]  ? rest_init+0xf0/0xf0
> [    0.818513]  kernel_init+0x1e/0x140
> [    0.818515]  ret_from_fork+0x22/0x30
> [    0.818519]  </TASK>
> [    0.818520] ---[ end trace 0000000000000000 ]---
> [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_tor=
ture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
>=20
>=20
> After apply this patch:
>=20
> [    0.647048] ODEBUG: activate active (active state 0) object type: rcu_=
head hint: 0x0
> [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.647073] Modules linked in:
> [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00 <=
0f> 0b 83 05 7b 62f
> [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4c
> [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbfff=
467586d
> [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 000000000=
0000000
> [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 000000000=
0000000
> [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) knlG=
S:0000000000000000
> [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 000000000=
01506e0
> [    0.647104] Call Trace:
> [    0.647104]  <TASK>
> [    0.647106]  debug_object_activate+0x2b8/0x300
> [    0.647110]  ? debug_object_assert_init+0x220/0x220
> [    0.647114]  ? __kasan_check_write+0x14/0x20
> [    0.647118]  call_rcu+0x98/0x1100
> [    0.647121]  ? vprintk+0x4c/0x60
> [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.647129]  ? strict_work_handler+0x50/0x50
> [    0.647133]  rcu_torture_init+0x18be/0x199e
> [    0.647136]  ? srcu_init+0x133/0x133
> [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647151]  ? srcu_init+0x133/0x133
> [    0.647155]  do_one_initcall+0xb3/0x300
> [    0.647157]  ? initcall_blacklisted+0x150/0x150
> [    0.647160]  ? parameq+0x70/0x90
> [    0.647164]  ? __kasan_check_read+0x11/0x20
> [    0.647167]  kernel_init_freeable+0x2b2/0x310
> [    0.647171]  ? rest_init+0xf0/0xf0
> [    0.647174]  kernel_init+0x1e/0x140
> [    0.647177]  ret_from_fork+0x22/0x30
> [    0.647181]  </TASK>
> [    0.647182] ---[ end trace 0000000000000000 ]---
> [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_tor=
ture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory

>Very good, and thank you!
>
>Now suppose that someone passes a pointer to call_rcu(), but then invokes =
kfree() on that same object before the grace period ends.
>Is the offending kfree() flagged?=09
>
>If the CONFIG_DEBUG_OBJECTS_FREE is enabled, the debug_check_no_obj_freed(=
) will check wether the object is activated in kfree() If is activated, als=
o output callstack.
>
>__debug_check_no_obj_freed()
>{........
>	switch (obj->state) {
>	case ODEBUG_STATE_ACTIVE:
>	 	descr =3D obj->descr;
>		state =3D obj->state;
>		_spin_unlock_irqrestore(&db->lock, flags);
>		debug_print_object(obj, "free");
>	}
>.........
>}

Hi Paul

The __debug_check_no_obj_freed() only check obj->state,  don't care obj->as=
tate,=20
the debug_object_active_state() is not necessary.  If CONFIG_DEBUG_OBJECTS_=
FREE is not enabled,
the kfree() will directly release it without check obj state.

Any thoughts?

Thanks,
Zqiang=20

>Thanks,
>Zqiang

>
>							Thanx, Paul

> Thanks,
> Zqiang
>=20
>=20
>=20
> >							Thanx, Paul
> >
> > ---
> >  kernel/rcu/rcu.h | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >=20
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> > 15b96f990774..0604ecd16627 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned=
 long new, unsigned long old)
> >   */
> > =20
> >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > -# define STATE_RCU_HEAD_READY	0
> > -# define STATE_RCU_HEAD_QUEUED	1
> > =20
> >  extern const struct debug_obj_descr rcuhead_debug_descr;
> > =20
> >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > -	int r1;
> > -
> > -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_READY,
> > -				  STATE_RCU_HEAD_QUEUED);
> > -	return r1;
> > +	return debug_object_activate(head, &rcuhead_debug_descr);
> >  }
> > =20
> >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_QUEUED,
> > -				  STATE_RCU_HEAD_READY);
> >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > --
> > 2.25.1
> >=20
