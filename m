Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE9567CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGFEJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGFEJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:09:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0655E1EC49;
        Tue,  5 Jul 2022 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657080554; x=1688616554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IRp+VNdBzjjUmGZw7m7RApjWHDlIQ2d7t5q1lPYQNI0=;
  b=nRf/Orlku5XKetFluH9dkpBM+paGiI/HtrHP3k/uIv6k5dKAjKQcGN//
   HDkkiD2UsN/HH+XCUJHJrRNsaS61hMLnrs/XYcYmfJ6iDh1eokjOyGv5e
   qicQ6PxvdFROfWRXexMZ82/2hYUTI8aFVWIAdhb7KBhxS7StBkWlsQ0Qv
   IWr4tu8IgNd/VqM+r8VWMrqqn23RwFBc8ueyp8VAPMggdPZZZ2eIfCvIA
   SQk2h9ve6B23bQH1mFMSjVkwKCQ9TOJnws75wuEL85ggMYzS1TIl+dJ1W
   ZqkMLWtqEnUA5AZVGXoFV3rD69jtSn5uSVcxVWwpmu0uqUZv8yEBZNUNF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284753860"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284753860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="543221247"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 21:09:13 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 21:09:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 21:09:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 21:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDATVgcf+yC7yhGyY4Z0IPuVlZqZ5Vip5wSL45Eyl3A4FMsusS/SM6Oo5iXRbC3r5QPl12FloewX6d4ySOGOwcIjZIeTWJov8jayAMgy7IZ2axZWXwEZ/Puv93gi7Re1uUdzykhtw58OO1j0TtIF6rUZAqeoZHCao1GGA33WV8ktkIxKH5q6+Hua7C+wrJeXJwjFAJWi8irsZJAxVthYnZQTkZcutTDkS2PRtb3TTLaIF5L8yJsnU3I1JETjIJOusOx3dFckCdIcFxDPBofPIraeARTun7FF6qGl43pZ/KtUdSBBJsxr2dj5iJe4ebWyhPBuqnVDNXHlEMEOVeYBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et2jRRJSG/3/fcvI179bY8/QyqVONIbgcKCLqItD4LE=;
 b=WLy/MChLOlPAPVo+8f3qxd/qIfOqzU/8uTE4d9jg2ZrzdTIA5mQit76wJJXN5Nipd8sV43vb9aeqWmmF+5mwWNPWVEko6CLUEkKYp/d37lDMkUZXKkdTDsMEMZI2Q3lqKx9Unh3WJFhMtnrm/4b0tyEZd4/7WvhlA7guMaj/5+CySAvuoLYSM/5zJE8Jnu0BkGmL4Kb8htFSNU1fZ9CEbnA+PbQrdcpcq1y1AphUWWYI/1MychblOz5yguWAC+KemmQsxObHS7zUqjrTXTo0VDjvhxjNrlDPaplOOu7u11hPlTbyTjJMaQxV8U/r/fFpaAgKJNIHhpe6SLwZvIVg8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 04:09:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 04:09:11 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Topic: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Thread-Index: AQHYjPSNkw8Leg1ATEaQzvaLUuKjoa1wEumAgACIyGCAACGEAIAAA9hQ
Date:   Wed, 6 Jul 2022 04:09:10 +0000
Message-ID: <PH0PR11MB5880E86FD8C97088EC65B0A1DA809@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
 <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880370195C11E8E943069CBDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220706035040.GG1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220706035040.GG1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: caf28509-0c1e-4c20-751a-08da5f0547bf
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fj6c8xHRF9V+1+ffEky7aK5ijJAHMFnUli2/HNpAzt2uR3OEPsvDaxyRYgZDhhULP5A1e4P4M9eMmOwKu/K/4f1GmQpHwXVZDRhcZ0mztdZ5o9qxwpFqdAW9MM/dfbw29tqore33LdhT2n+yU12WFUTdKTdpWFzQGkZTix3GfBkiL0W5RqQhdoEDX+9mth6YOXM9XvPhgCUoLgsdOExznbMQXDJHS0YpHlmIO+Gt5NflWUenIuxLkmWjYJ+xZ5K9xe+nEgPTKlVloHNc4YBBZyVSxOMDWgDqrTseqapmd7huH355iUIzosphIfoZC+Yo50ZvvI7e/S+b94EMeX3y6HSRKWXo3lvj5z0RfJboN7V7EY9prRnW8fTg+ZyKWdiLf3epMv80QfWNpH3VtKOW9bbwhqROP3FojjCWY0656Wd0C90Uqkbg5aWQdlgwxd/cSHEe2kBNPhOYXpOoMvKYh2upYKV/1eNbrFS19PuxGdYuejzDvEIHdzVGgzfwnxDGL4sMpLnwScGnLJaZwExNo3X85tV4w0JxAknM7zgiDv/6Dn161bT6/vrEfiwbp/UQj107k1+MDbcVv9ZHiBE8qk5JInDa2YnnwkSnNYoMt7JgHF3KoEIvalWlAVyyk7fngTw6uNvmQkeI45WU5vKrM/n+2gQxffCxJpryDFQb7sJOctfG7n2Kdh12k3Ynx3W1S/TSUl4Z5MS5IwVPYcfi1q0J9NLt9CT3khpIs6uWGtSjErbWx1QyOW0Y7cY00T6/qg7obHmYYpVFvTGuJvGrFHt5ZvNxv7fzpvQ+1HBiyeIe/Khx7gWDYpL38a46pqRn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(366004)(39860400002)(6916009)(45080400002)(66946007)(86362001)(52536014)(4326008)(66556008)(64756008)(66476007)(8936002)(8676002)(66446008)(54906003)(76116006)(38100700002)(71200400001)(316002)(7696005)(26005)(9686003)(41300700001)(6506007)(186003)(478600001)(82960400001)(2906002)(83380400001)(33656002)(5660300002)(38070700005)(30864003)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GMTUrjbNSRF5tly8WSmrZm73TETyz9BCdvgl6kBCOLLuUvoThz2VdtRv1JoY?=
 =?us-ascii?Q?lV9VSyx+Nh3qKFhRdx8XC1s0DHdaw3ls8ggWavpnHrKSdf0zI9ZXIzMLFwzn?=
 =?us-ascii?Q?CereoEhfaJyCJMN2sl+qYAOvJk2hm1UhSoW5cZYFFjOdJQEGaSE5lQzOGUCu?=
 =?us-ascii?Q?ucVa71DCrF2pqpRNDRI5qIbF2NAQXeWEthh8Mk/FUG4s5s4XE08P4XSuMC3Y?=
 =?us-ascii?Q?v3TAtWV+Dxt2tPzzHzVSPH3YSEwhK7clzPwiqfe3+YOO27gDL0UVSwaPrtrz?=
 =?us-ascii?Q?Chq04sasDJkxvMcwJ8691GHwaxEhPL236jTVQeX/K8U8QznRYaSCBn8o8uxk?=
 =?us-ascii?Q?p78uIW0SXVasyMEqG46ElJKrbkz5MRWv/IcRYsoDvS3OuuCJNZ7TrN7pRjrw?=
 =?us-ascii?Q?jjDHBbnawuQq19R87xE+qu+jgpkWKZLSX1x+CDopB3xZqrOGAEqUrGEYPce6?=
 =?us-ascii?Q?52FQQS8J3/+bfV9QLIhemwGs6yVJeduoL13DLjC6tpkSFxMPuppUr5dHQq70?=
 =?us-ascii?Q?nZEpvO9yDw2o71Z+e3b48Q32Y8Mm33kuPggcqWaf9+yrfpvzVR6/OWte+4Ri?=
 =?us-ascii?Q?gUC6TW2WR3IwLP73BgcH/AZ4vkgmGAF3u3cCdKHcSM4O9SyZlMSJG1/2e7Rd?=
 =?us-ascii?Q?trJ8PeHVE+CtXzBCU3Hs46LUD/2cNc07cOlDPYDmW+qQYLgBfXREv2hRnZf3?=
 =?us-ascii?Q?+uUEbBS24zSqLsGtpLZtrcdjETR/zZ3ZXlKtW0Sx2GEjNMgoa61TzfB4vViy?=
 =?us-ascii?Q?gE4ZcDH/husZ4rr3lO+QG9dil7jdFYndezXuNrvp6+jJ40F3GHQm8x4jrv0I?=
 =?us-ascii?Q?J6XrOO/xJ+nNXTxrTIFJnKcnNoHMuu/niEnDQ3ImPr9ihGku2FPXQ+H8X58J?=
 =?us-ascii?Q?FNp9ayyordk9Fv6Zth+0kdQorkp2RACUdtsJXNDpZbFYw+WI2recJqg8OW2b?=
 =?us-ascii?Q?WsSujFd/602DgVLGM4eCmKYigXdJCMUOV1+jmi1u4uAzqiQyc52mUfkRslKX?=
 =?us-ascii?Q?c9PU3jGro6RaNxu7cJlRrs9j0ucALj5jBv07uVA75gR4uxdLQ/qKWPyuuSF3?=
 =?us-ascii?Q?FnmYccZMFomPcVHfaKPMzEOO+BGdmJZjLWJeW3nHRk49rCYbf7Z/BBYZL1Uf?=
 =?us-ascii?Q?YXa1FCAsP4xVYvj/me/+iFLbWlobIsgM6hhLCWziFiETik+kfc5ejAI7XAKI?=
 =?us-ascii?Q?6ri3LUiKYet/MoMKQ24QtmueiA8T3ZtSQIyshqNpYkVG4Ii9mmn+KQtf60kO?=
 =?us-ascii?Q?yy/LpJ0atMKogcfp73SA/te/f8ux7u7dCXJvYo+NEdd55uDou46aWwjt5nJ9?=
 =?us-ascii?Q?RnAx+dhlsU34I9C8HmU7ZXTk3tkpOE02eAzigyW+bsBxZ4swXTp0c2CckXOc?=
 =?us-ascii?Q?WRcdWV/P+GvRudap4PAozgCY8JWAmTFExygGoQCKR6KHfkSwj3TYexaGxgUo?=
 =?us-ascii?Q?UVj0Xr6zSrgeJ10mfeh+5s2PjCuCidJCjqAEu6WlbU0l5rUZlCSKy22Kifv4?=
 =?us-ascii?Q?AVQP9pYAbIhSu5fWbJ1azplIk7yo4mGANUhU1/r9dGMzVBeoI/q2wyfCiS6U?=
 =?us-ascii?Q?ZDunLGL1MFKMTeq808VN+adVaisN3hDwOcXWnRGM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf28509-0c1e-4c20-751a-08da5f0547bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 04:09:10.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiHFJ4WWRPebddq1xa7aPu5e70Qwsbuoh1C/F2NiYLEZaPW+4QTcBaWZWpYT47SnRRqBuX2ZlwlRWa2WWDT/yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:00:51AM +0000, Zhang, Qiang1 wrote:
> On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> > Currently, only tree RCU support leak callbacks setting when do
> > duplicate call_rcu(). this commit add leak callbacks setting when
> > fo duplicate call_rcu() for tiny RCU.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> >This does look plausible, thank you!
> >
> >What testing have you done?
> >
> >One important test for Tiny RCU is that the size of the kernel not
> >grow without a very good reason.  In this case, the added code should
> >be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn),
> >but it is good to check.
> >
> >It is of course also good to check that the messages print as expected,
> >which is what rcutorture.object_debug is there to help with.
>=20
> In the condition that the CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn, the function=
 directly returns zero.
>=20
> #else   /* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> static inline int debug_rcu_head_queue(struct rcu_head *head)
> {
>         return 0;
> }
>
>Yes, like I said, the added code -should- be dead code.  But there is
>often a gap between "should" and "is", for example, compilers don't
>always do what we would like them to.  So please use the "size vmlinux"
>command with and without your patch for a kernel built (both times)
>with CONFIG_TINY_RCU=3Dy and CONFIG_DEBUG_OBJECTS_RCU_HEAD=3D=3Dn.
>
>The rest of the test results look good, thank you!

Hi Paul

Original:

text                      data                   bss                   dec =
                    hex       filename
26291319        20160143        15212544        61664006        3aceb06    =
vmlinux

Applay patch:

text                       data                  bss                     de=
c                 hex    filename
26291319        20160431        15212544        61664294        3acec26 vml=
inux

Thanks
Zqiang

>
>							Thanx, Paul
>
> My test results are as follows:
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 1" bootparams=3D"r=
cutorture.object_debug=3D1" -d
>=20
> log:
> root@qemux86-64:/# zcat /proc/config.gz | grep RCU
> # RCU Subsystem
> CONFIG_TINY_RCU=3Dy
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy
>=20
> [    1.015657] rcutorture: WARN: Duplicate call_rcu() test starting.
> [    1.015659] ------------[ cut here ]------------
> [    1.015659] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    1.015680] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc3-yoctode=
v-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? lockdep_hardirqs_on_prepare+0x13/0x210
> [    1.016329]  ? call_rcu+0xde/0x150
> [    1.016329]  ? trace_hardirqs_on+0x54/0x120
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x1687/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_=
leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337be0 EFLAGS: 00010086
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6e
> [    1.016329] RBP: ffff888001337c10 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e8a0 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_activate+0x2b9/0x300
> [    1.016329]  ? debug_object_assert_init+0x220/0x220
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x20/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] ------------[ cut here ]------------
> [    1.016329] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    1.016329] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:502 debug_pri=
nt_object+0xda/0x100
> [    1.016329] Modules linked in:
> [    1.016329] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.=
19.0-rc3-yoctodev-standard+ #214
> [    1.016329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    1.016329] RIP: 0010:debug_print_object+0xda/0x100
> [    1.016329] Code: 60 ec 45 92 e8 a7 7b a0 ff 4d 89 f9 4d 89 e8 44 89 e=
1 48 8b 14 dd 60 ec 45 92 4c 89 f6 48 c7 c7 e0 e1 45 92 e8 f9 d1 b3 00 90 <=
0f> e
> [    1.016329] RSP: 0000:ffff888001337bd0 EFLAGS: 00010082
> [    1.016329] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    1.016329] RDX: 00000000ffffffd8 RSI: 0000000000000004 RDI: ffffed100=
0266f6c
> [    1.016329] RBP: ffff888001337c00 R08: ffffffff90a56ee6 R09: fffffbfff=
25df5c2
> [    1.016329] R10: ffffffff92efae0b R11: fffffbfff25df5c1 R12: 000000000=
0000001
> [    1.016329] R13: ffffffff9227f520 R14: ffffffff9245e640 R15: 000000000=
0000000
> [    1.016329] FS:  0000000000000000(0000) GS:ffffffff92cbb000(0000) knlG=
S:0000000000000000
> [    1.016329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.016329] CR2: ffff888017401000 CR3: 0000000015a3c000 CR4: 000000000=
01506f0
> [    1.016329] Call Trace:
> [    1.016329]  <TASK>
> [    1.016329]  debug_object_active_state+0x1d7/0x210
> [    1.016329]  ? debug_object_deactivate+0x210/0x210
> [    1.016329]  ? _raw_spin_unlock+0x23/0x30
> [    1.016329]  ? find_vmap_area+0x5c/0x90
> [    1.016329]  ? do_raw_spin_unlock+0x85/0xe0
> [    1.016329]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    1.016329]  call_rcu+0x39/0x150
> [    1.016329]  rcu_torture_init+0x16aa/0x1759
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  ? irq_debugfs_copy_devname+0x70/0x70
> [    1.016329]  ? rcu_torture_barrier1cb+0x40/0x40
> [    1.016329]  ? srcu_torture_completed+0x10/0x10
> [    1.016329]  ? irq_pm_init_ops+0x19/0x19
> [    1.016329]  ? mutex_unlock+0x12/0x20
> [    1.016329]  ? srcu_init+0xaa/0xaa
> [    1.016329]  do_one_initcall+0xc1/0x310
> [    1.016329]  ? initcall_blacklisted+0x140/0x140
> [    1.016329]  ? parameq+0x20/0x90
> [    1.016329]  ? __kmalloc+0x238/0x5d0
> [    1.016329]  ? rcu_read_lock_sched_held+0xe/0x50
> [    1.016329]  kernel_init_freeable+0x20a/0x268
> [    1.016329]  ? rest_init+0x160/0x160
> [    1.016329]  kernel_init+0x1e/0x140
> [    1.016329]  ret_from_fork+0x22/0x30
> [    1.016329]  </TASK>
> [    1.016329] irq event stamp: 152
> [    1.016329] hardirqs last  enabled at (151): [<ffffffff91da7a4c>] _raw=
_spin_unlock_irqrestore+0x4c/0x60
> [    1.016329] hardirqs last disabled at (152): [<ffffffff91da7811>] _raw=
_spin_lock_irqsave+0x71/0x90
> [    1.016329] softirqs last  enabled at (0): [<ffffffff908a230c>] copy_p=
rocess+0xc8c/0x31b0
> [    1.016329] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    1.016329] ---[ end trace 0000000000000000 ]---
> [    1.016329] call_rcu(): Double-freed CB (____ptrval____)->rcu_torture_=
leak_cb+0x0/0x10()!!!   slab kmalloc-16 start ffff888003f49240 pointer offs=
et 06
> [    1.101401] rcu-torture: rcu_torture_read_exit: Start of test
>=20
> Thanks
> Zqiang
>=20
>=20
> >
> >							Thanx, Paul
>=20
> > ---
> >  v1->v2:
> >  for do duplicate kvfree_call_rcu(), not set leak callbacks.=20
> >=20
> >  kernel/rcu/tiny.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index f0561ee16b9c..943d431b908f 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -158,6 +158,10 @@ void synchronize_rcu(void)
> >  }
> >  EXPORT_SYMBOL_GPL(synchronize_rcu);
> > =20
> > +static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> > +{
> > +}
> > +
> >  /*
> >   * Post an RCU callback to be invoked after the end of an RCU grace
> >   * period.  But since we have but one CPU, that would be after any
> > @@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > +	static atomic_t doublefrees;
> >  	unsigned long flags;
> > =20
> > -	debug_rcu_head_queue(head);
> > +	if (debug_rcu_head_queue(head)) {
> > +		if (atomic_inc_return(&doublefrees) < 4) {
> > +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head=
->func);
> > +			mem_dump_obj(head);
> > +		}
> > +
> > +		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> > +			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
> > +		return;
> > +	}
> > +
> >  	head->func =3D func;
> >  	head->next =3D NULL;
> > =20
> > --=20
> > 2.25.1
> >=20
