Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F318534701
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 01:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiEYXeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 19:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEYXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:34:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252AA7E1A;
        Wed, 25 May 2022 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653521636; x=1685057636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uN2OKZvYrBXiL38SXHO+ynj9y4k96qL4/zr1nSWwxM8=;
  b=CwwC6ObtA2gwfNJasJ8kc9JZKQtRRMGGC7/5gG7n+UIurz6NgLtcjlI3
   yYj7bdPHP5+ls6Fh1NDNGEAvr21ii8IFfQfXaEuJgm5McwCXt6Uz96Qvc
   TfqWgqmDOFP3w5dn1py4CwghKDCRjUaPJFop9ii57SXog7cRQuElQyqKr
   uZ0qHcmiWme660Og30oA2USRmKXDBU/eL+u05W2H9c77q9bkLlmCpUDNZ
   to6oMeL4gaHQ/P55QrD5fBQibhKol44mH7y4mNlqZb95qusB85a+n+ujL
   ViPPiwJcgwfEUHLqtl2kNx//irsUgKsuxi4e2XB6HCyQsrpxWZMhani9g
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253835134"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="253835134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 16:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527087164"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 25 May 2022 16:33:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 16:33:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 16:33:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 25 May 2022 16:33:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 25 May 2022 16:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTm+BNli3oUjwKK7G51Sn5I+9Mt4PksQx/N5ja0OciOj6wNEQoymCSSgx2RV1/PcN6AtejhwKQdmz5VUXbYZ1l4aPdI3+RDCvmbfQTPJM4UnxnhhPXWTCgu6YRRG3U1GRuwOPMtZdT+Bw+JCUmxg97dUJJPV0JenpFtRvhcH4/tFw8D92s6H/njmnJx77HWvPT4eB8/ToXTOFrlKWq8nlKPFHfjSszmyYxZ1dr3A9hpJLTGjX/xV0UOlDaN31BzaCfi/o4S8u1UF8qn0nMIaCmWK/93MuRCpakzaRmepTHMfSfdauNclnXnB7vT6J2JUeoKEptGq6KuEGFO9WINwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDhorvRJjavoth94PzzTavV5rRbhjSrNhfIQhS5ckZ4=;
 b=Z9cIBZaQCKdkYCXhHDbKz+JTl2B8EMSKlcB3PDZtoYkQL1WYbD5iAlPm2QGDo1E8vwYiBc6vLwcJvn1g/sz7Fhfb7yis3kYKm0S5sevUTsySETDtW+YCEP8HtSAYqg/H6MWnT/IRdVVa+k89DS8U3h5m44VhAWp2+yUWaLdEVSc7gTgxFTx2rKKz33u3dS0Xh6syGCV0CwMR263V0GqcdC8CULWhSD+ll55vA81yslVafFvPhp6Gq8V8XHSzLKQ/XD4txk/VqMQt/puP/sDJD5/6HptACI5ll7ik+LtfCKeRHNuCuJPjFsuaHUzeBi8XY0D/D2r2cjOUmTG4i8mvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR11MB1474.namprd11.prod.outlook.com (2603:10b6:405:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 23:33:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 23:33:46 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAwgAaO9TCADEieQA==
Date:   Wed, 25 May 2022 23:33:46 +0000
Message-ID: <PH0PR11MB58805D24C88CA447B07C276CDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 98dc761d-ae7c-4c18-9e08-08da3ea70391
x-ms-traffictypediagnostic: BN6PR11MB1474:EE_
x-microsoft-antispam-prvs: <BN6PR11MB14743E0273D103381ED34ACEDAD69@BN6PR11MB1474.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWt+3WM4EGiB5oSXK+CbLDjtdgKw7CSIsdqaDhFoBzWn3r04S0K0uo9BsgNzpwcPas3YDuTLps7ieeBhvsoEscUc0B5JpqZa/EcnTCsjRKhNJy4nx2kNTVrw6/Aut/vX6ZjqVYzVWoejvdRUoY8jprKWS5S5MIS5vyso8QzSeEvjv4bhfEFswbkemYT7eu1Yd4Rss6prY/oIQ3PZ+Xu276glmgc+GifunP4GzCD+Sco9rBmjlHHywOPLKP0ycBy8ChiVvDC48y7S0mAJ7tNBrqPOcc1vl8r5PoOovdshfQhYkyHMIMDLUSdAc3nk5K69FmHCEZ9zLpcd2f6Fw6PU56mNBsLVY9yFs3JHfC/o5VKgwV9N36xHinjbZ67gro54vnOagHrwcV6AN/g4a01UhgM6mV0nxDtRqQ25/87NpNagosez3Xf6nyF66msAFUDjOfX3inWuwI21OeiFjJzQ+ZfKZP/n53FCeBrju0z1C6p4TEPlZZ3LtEselsU0pbW29zVUvOfcUkNFqyg33Nos6xLr0yFj9gwXIG4AoX3NdbOC06QzNibDSz9spPZv60r7EY3P517ieK25SyYkV7lEhjG2FYO5hZBqXIwt3lnu58zJsPgSUZLwUTfX+HYA/NTqDLalXr0F0xph3XL/eXeuapvW8hSHfZPit7rgDX1k7ReyQL9rfhmn5m1/0HWe8Km3AV3F9UfQkGORzDVdog+d3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(8676002)(66946007)(66446008)(76116006)(4326008)(66476007)(64756008)(5660300002)(66556008)(83380400001)(6916009)(71200400001)(54906003)(30864003)(8936002)(45080400002)(316002)(52536014)(508600001)(2906002)(33656002)(186003)(6506007)(7696005)(38070700005)(122000001)(82960400001)(9686003)(86362001)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjCMaqkZaKwhofYAgkdDPfACAPbFtkGEcKRALlgDo9Eghy1zgxnIUghiH2GV?=
 =?us-ascii?Q?ZuP+2QFCVriu35hwLZc5m8vK68ok9beizpynhYuhbl/ex3ajyy0Z2JQw+KGP?=
 =?us-ascii?Q?7+ihGmML6FixX1NHDg4eaHBjU69oXSQQ0ub8CUMrXisDFS1+haHJhovAj1sY?=
 =?us-ascii?Q?5jC3xHwIzDBRBwES8erkEycGyqtyn26yfxJOUm38kC1iL72RSKpZ6+Fn4rks?=
 =?us-ascii?Q?QILj8Eb2KfO5UREe/21GT+k0CFWdp3aAK1K1gXCEQ6radjAnknCMHa34bxjr?=
 =?us-ascii?Q?HTrXilAGyqdJimSJ/1JJyIMFqc8mkghuVp2JCA8111n5xkzqCRFGtG43x8f0?=
 =?us-ascii?Q?8z+OFT0a6LH8yMqYO14SJHNz+vyoz8CnIN72ZxwTUePpo+x4nowbFOldb4BK?=
 =?us-ascii?Q?WwhuPJFg+VTcJ2SEQiV3eDrRFXkYZoq9sU4AVkjXW8LGzCcxTAau3wgn/GBh?=
 =?us-ascii?Q?fIZ8qJME5UNVULXfx9dCv6FAe1B2bgDkkCDb+o8LFuAeeyF+WIg4Js419DAU?=
 =?us-ascii?Q?Cq7/vUxMtT4JtAFqlnfbePO95sdj11yvzwiBckOAW5wL+MqlbWALBmDvlt+d?=
 =?us-ascii?Q?Y/nF/7xRyJOVeqjXYiCZ3P9uZcTnlMg+gzMMR9ZouWnUo1dJlRaS5cngGDoA?=
 =?us-ascii?Q?PPcZoN6MNdDUe4DLoUlXbYZIt5Z/+OXYG3tLWPMAqTaJqvCQNPqP7ufTrSSu?=
 =?us-ascii?Q?F68A+HoP8+vfdx3A70WiVH/n1/jYkRabZYqbgCHd1n57i++hiFaspOlEEYS3?=
 =?us-ascii?Q?UR/eKgOtuyg5OAOCY3AGnEqGvac09QFUMtzMIle1yQFIpHQU2P5PdyfKU/bi?=
 =?us-ascii?Q?HTcwqoR5CFhFCc3G52J2Jw90/voKOt/Pr0wPLrOdTV0DhDRWGf6ZenWLl7OJ?=
 =?us-ascii?Q?rZlikXb9HAHuzJrKLZq7Pz0pGER0qeGXRa8nwRPoSsSZKxTCYT4jH3+t+vSG?=
 =?us-ascii?Q?OW5Tpw8S6gs2hUB3K60ePfyFUwixZAnQg0iBnJWpvx2XHzGRW5J+hZ5VKJ0t?=
 =?us-ascii?Q?vafzd5iB4pu8lt+IasHa1IoDydf3n0InWtwZQyBCr2XTulnhEVF0eUnbUvaJ?=
 =?us-ascii?Q?xQLiDMeMNiPJwiU55tXJIcrlAE8SWvdfj1t+FV7CojQn0mlWcFivnKXl2wOu?=
 =?us-ascii?Q?75A3D3IEIsRA/aQqLuXu3A6v+s9f8j9721SxfzWNvphnNrACQ0QgOYyD2xYK?=
 =?us-ascii?Q?wNemtFMOjbwR1vJ0kTWq9AMvM0x5qFa8g544DV0DSuX8WXMYnvfovk/C9jU/?=
 =?us-ascii?Q?bTPaRULmiOnNt6E95a2hdd5q1bWrEdwew+t7Lbn945VQMdD+KRzVybRPPw27?=
 =?us-ascii?Q?p0fEUjJOYngiCDqOxXhegenZ/X2JLrz/pzadBY7ntX8RiUKYDz5r48Kd2FhQ?=
 =?us-ascii?Q?J2wtPUVFzJ6AQIZUlfXjvnEX9FeKlAHxM/KO+2tdKNPSBC7CxXYONBjsJ0qK?=
 =?us-ascii?Q?+K868IMy/FUfa5gxthDpJJvNk/Epr80NhD0sJvt7mq+F68b0w6NAJkbYJbUW?=
 =?us-ascii?Q?CbiK7PsuyT6SM8TqFX7PuUB0ZhRMdDiKlili/TxDTZUgfSrks4/I6xbYIkyv?=
 =?us-ascii?Q?F4GkFQSA2jS4uLzSutWA1BfrFCfTBbp36DanA437+NFFOz/RsM8NnoFtxYjS?=
 =?us-ascii?Q?ysUh0NgjrCz+cr6/IGdzRVi+Q3iV3SOG+M+DQ/KDvgvk11ZZeMfK+YbEgvh8?=
 =?us-ascii?Q?FbD+SjqEn9gMAHAUZuQBfNq3ygrgv7CSlCXisoR6xDNicWzwr+QuZhgMnDN2?=
 =?us-ascii?Q?nrr0YsPYzg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dc761d-ae7c-4c18-9e08-08da3ea70391
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 23:33:46.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWwBYaoh2KRKR7EaeEw6oXbAABiqnuiAyyZh/65Qi6mjQojKbpkU0Wx5VsyiL6LAlfoI8/wtq8JHdXkqGSkSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
>
>Hi Paul
>
>The __debug_check_no_obj_freed() only check obj->state,  don't care obj->a=
state, the debug_object_active_state() is not necessary.  If CONFIG_DEBUG_O=
BJECTS_FREE is not enabled, the kfree() will directly release it without ch=
eck obj state.
>
>Any thoughts?
>
>Thanks,
>Zqiang=20

Hi Paul=20

Sorry to bother you again, I think this change is still meaningful, or ther=
e is something I don't konw=20
if I can give you some suggestions, I will be happy to accept.

Thanks
Zqiang


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
