Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E62535B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiE0Ie2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbiE0IeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:34:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780EED8DB;
        Fri, 27 May 2022 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653640463; x=1685176463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aJfHLXVRsr0NKtzaEaHqxmeTIH9nhJPFG6zxcLbPKxA=;
  b=jwRUpAMLp+nIKV3LkauEHk4V8Kd2RxNdttuek4JYZD9xlgBIolXZV0dg
   +omaiWs9GlN04ko0oGSC2bJWRJwqqEY0eTC8BS+ihVf5Y26ewmHnn/fOr
   jGbJG0w5f6EdRWyiuFHQED2Td3pDhNoIkDePJTGZgL2LSmH65+6t3M+Ts
   9sx5NwaY3sBWc3DVt8jr+Pphn2GOhhIwYseJOE2BGRVKMQL48CXNYkGvm
   MXRgzcvCiTS4GYxvMP2bjPtU6BH9z0+bcBgDatiEGg5YVBh1RmPOJ03zc
   Nq6S54S1/i5osDK5QQqt3nhqpocut2UVOJoi+n6naRv7KwLVWAd9lO69A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="299764822"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="299764822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="574441293"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2022 01:34:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 01:34:22 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 01:34:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 27 May 2022 01:34:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 27 May 2022 01:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV9rvDFHc3Sa6Un64Lv1g7ecifmJb/GvgkhXtATezO8voFUUO6qu8SAf7CJMU/IE7tXd6HQx59i/9znGAUPWqHYUymEWI1TsrEuRS6ix2vPpw0hAsAJ5M/ua6Wwz0civX8cLMLc7R2UhmKZKj686LIagj1Nw3NjqbbV5o/g3yDW9fUe55cGSGQaiRCeeRekUKom8vzvOMFY1IelYDPbpcI6ZenTDqswGoclCTSGCh4rL8QkZ0RPUvUfD7REhP8DyHS3Ckk0se7k7X5VvsKE5zSEAV2HsyUMQFhmU5DNkfXfWgJXKj3Kagty+BXRtUbOH4/iMV+VAs/cKmw0VlBeV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoAssQF/fdgzPC+rUItB3nrnkTnHJjmJuDZKw0d/P+s=;
 b=VXShWff1a6Qn+HeYkXPojwtT2z2IBFXnV+28iy6TJDWfnIGdjBDepVDtSYY8tSp3VUfsy9bCkf7mBQf4k9Kcq/hdeRzIppdEkdT9Qu1rhU4xwOhLK9jFj+OmfFPo5zI5zNVrlvjxFb87RtNhgLdMN/pq/pVy8wkPr8HZTEhpAkdKVmljfcXfs8tzaCVikzP6VXu6LaqsxPiqkgKy2ZtR+kAGVx49VnP9KWrNnZezKcXL9wOCW/Qh6gO9Qy3hfkdZMiy2QB16QK4EVVrhlR4H1baBQvLvjl8MfEsghwic8GfNrfyYFKUW//LGkzcm+VAaC/Su8P+/9vMDYJeSDhCo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 08:34:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:34:20 +0000
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
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAwgAaO9TCADEieQIABO1aAgADWSiCAABhfcA==
Date:   Fri, 27 May 2022 08:34:20 +0000
Message-ID: <PH0PR11MB58805066A0F37013C570B7A5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58805D24C88CA447B07C276CDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220526181729.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880ECE6C9DE0AC18E9629E5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880ECE6C9DE0AC18E9629E5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: bce12140-1606-414d-4673-08da3fbbb221
x-ms-traffictypediagnostic: DM4PR11MB5231:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5231AF638BC100261EEBCD1BDAD89@DM4PR11MB5231.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKa9gdpRr6GH7XOi3ldma49LIJd7d9vVKhXp8XjuQXn/b9/6P7Wklf5ddbnY5ea6KtNevOEKT5qyp4nAuAluz5TejLxdWnhR2oD8r6VB0dICdzA/YRpyk2nmpvGeWR1KVfkOKs+O+4z4yydJKzc91xs/5AqtXPYXvStQYktNrRYvxEREHGjjJ+tcaHEQjOJpzDbOYlpTAEiiAE/FgUPT+uImLt5su0P+d0AHyns9G5bHFmFZPRfcTBiHJuY7Lbfsm1obN+gZAXz/8YgVHbt5uHkZUQbK8QGS92Wg51dEm2wuw+ueXA151lcA7bkipOey73fDx0hgMbwmwyOO6BvPmqDFnFTk3eR9s1pC+0WNrI55YwoCLfklFkwE2dTIQKSbsgPx4WTXL4Wd50I3smJssYDKSR0zYT67dQNO2pORpeEPyxd4FWwlQbyZxkGACt2Lml+MKUq3pwi4/Op1AChI1IYKBmXSEH2nC2n+72HGl17rerqsTuQPXJ0pB60+XSFA5YDh2sMoEYxll24HeopzaFHz8Fa5v7Jiu4M9JvxtqwrOmJwYw/aWd/fn0jtDdSwSaFTUZs40RQ77jV5K33eDOXy5CUnJZjYn4KKKYePHsTAq7pwlpk0trShre/7WazkoRMoxkVIVYaXKagfDqyGt5u7ebq5w+49dbpW47wxHx5RpOZoEyzVT9TboSs1rxuN3eAcXG+sXneRddrRB8RCe3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(5660300002)(26005)(2940100002)(9686003)(8936002)(55016003)(54906003)(6506007)(38070700005)(45080400002)(122000001)(52536014)(66946007)(66556008)(66476007)(64756008)(76116006)(66446008)(30864003)(7696005)(82960400001)(33656002)(8676002)(83380400001)(4326008)(71200400001)(86362001)(186003)(316002)(38100700002)(508600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tj9/bv43Yy2ba/UHQIE3kyJxYrlmaMxRUO3Gh/bY/IdsJV0JK3u2r06a6VTF?=
 =?us-ascii?Q?xHnCQy+xRgXkYjMJP1UcUP+ep3ozI8BfhURKOhmKv9Opn88RLMQE4o2KYgLS?=
 =?us-ascii?Q?7zoiVnkd/DiQca0imEng8SAMTdfTDKkslCVMfHi+DDdnHryHPD4RxJr2/sqq?=
 =?us-ascii?Q?IRZjp7NbgKGPnYgtR/FDgyCWfKTyw8pXZ5e2S+pqxZvijdrdfN3cZhgO+1hB?=
 =?us-ascii?Q?fgEKHUv6LRuQK7enzGhYjlDXDwKMWDpLKmL+Ve4IzXblDCKDQ7utTmY75oII?=
 =?us-ascii?Q?TKNXempKHC6vXotR17beY96/LMWw5Mj70Yh5udvX5sKJduX/3lZUut3q6ls2?=
 =?us-ascii?Q?ckvnvIH5KCKZYsisyh0EDSXDefB6cyVJuMCrM3gBY1maCpgirV8Afd0qKtii?=
 =?us-ascii?Q?UysTEcV9GiZ6jhzrFXcfTZbQApmiSS7f3x8OzOzv4RajFlUTKULSdRItDJDJ?=
 =?us-ascii?Q?IWroq3f9GRlCAOVcI6ZDf2ZU9744YLjNFTWhOk9s/2dAGXAeNfM3Bag1r+Jg?=
 =?us-ascii?Q?FxU+etisiSYMb2ZAbPZxNhMrq5JAMLnjAY+ScrDufkY2rDmPaHMLXwUuOUXO?=
 =?us-ascii?Q?E89amhPqFp5bbkdlnTXMhZDuORoCOtozoQaoVZXe9RIUX8B3aF69Oj0Cch7Z?=
 =?us-ascii?Q?5P+EnBwKn+Caerueh4DcG+qeac9MuEQUWxGgie3ZqbpM7/iyk/B7nwPFKJEQ?=
 =?us-ascii?Q?st4s6Js2KOgDHSfc9WjF03le+Gq2FvDniNkRNTn8kY1WL9AQg++DR0YuecCw?=
 =?us-ascii?Q?o0lCJItGo41Kgt/hx97QgvIZsf3Jj6PL7i+JbdFCtWy9fCRUbJXwx31srvOs?=
 =?us-ascii?Q?NPjQAn/1EhEYQHP2AH8gRsqNG/gTHbjNljJsVXIdvAxfZGV7ydmXQ1SwpcBt?=
 =?us-ascii?Q?Y4ALlZpvGwxmdxdPTnwt15PSRGtXDfIWdpzjOu3j0X0/q3V318ki5fuwDcQh?=
 =?us-ascii?Q?+BX9rv1htyCPS8/cR1frjivOFiLaF9QOrtya1ExT5khnswYL3g8RtAH81M3Q?=
 =?us-ascii?Q?T0ovwdj67RmvNGUd30a+CX0xXxymq5SzusB9WeNf3aVC0ZgOrtn7Atgw6Gqi?=
 =?us-ascii?Q?eQnUfaIhBOTRQb+dm2t39tDwvVZubsrq9w+w0bnLN2xPEzcYlf6WCeFXDC/c?=
 =?us-ascii?Q?2YNiivtFlmVPJ8gsG5tRqI3P3vZLLgyPBj8vTR0y3N+w7ljP7+cxzQbCc9LL?=
 =?us-ascii?Q?AbJkqhTGfKl8tQgO1GDSVmLEf8SwTxp83BSy9/lQmrDm3+sZKWdUf2fi3Hlh?=
 =?us-ascii?Q?hNzJgRSJ/ekMpsn3mmWEfgm2Nd+uFzlsL06kl6KLEJG49CWhx1k2gyJpzihs?=
 =?us-ascii?Q?naLaKQTjR6BKFdYxwTdUycGv5kEKqlvr4+Ybsz1GDoPvFVz9qyPzfPfvF9Pr?=
 =?us-ascii?Q?UVMCfDj+n//Wzt5qyWqHR3OjK77RxtWAm9XBbbAz0wdqWuAHiOKZhIMh2eiZ?=
 =?us-ascii?Q?CstNY46RqGJac2VlgXg6s0D1OtbwrO37a4wy9KqG8dhduoADnRzxNQK5dtmj?=
 =?us-ascii?Q?iw14cXXzhWnb8oS4jOFp6BZ8eOwRGxaUeKAs6jln1qjAmLBTQcz5/ilwfpqA?=
 =?us-ascii?Q?ANdZulBui6MIxDKDtan2ntNVhE4itOTLFAt7GbCSVGTZ8EapAT6+GIhiM3b5?=
 =?us-ascii?Q?sAlOKq7KLN+LKhwAEcrtB2t4mOmuaPQ9u6tnjnFzrSBF5mZdsOuFJTPD8hdm?=
 =?us-ascii?Q?mqPSGpJG0daZqbghe9b+0P21WeCeOGjzQFgTnkKyw/PtigzgvZHokT6Z6058?=
 =?us-ascii?Q?edDdo48rlQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce12140-1606-414d-4673-08da3fbbb221
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 08:34:20.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4ehQOVwaLbFBtgpafATXlAAG0CXfbWN3zWLcpePRwHhn6IsHh+kLd+DODxOzX0/VbW7xrYTzRUeY+VG9XArzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, May 25, 2022 at 11:33:46PM +0000, Zhang, Qiang1 wrote:
> On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> > On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > > Currently, the double call_rcu() detected only need call
> > > debug_object_activate() to check whether the rcu head object is=20
> > > activated, the rcu head object usage state check is not necessary=20
> > > and when call rcu_test_debug_objects() the
> > > debug_object_active_state() will output same callstack as=20
> > > debug_object_activate(). so remove
> > > debug_object_active_state() to reduce the output of repeated callstac=
k.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Could you please post the output of the dmesg output of a failed check=
 with your change?
> > >
> >=20
> > Original output:
> >=20
> > [    0.818279] ODEBUG: activate active (active state 1) object type: rc=
u_head hint: 0x0
> > [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.818301] Modules linked in:
> > [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00=
 <0f> f
> > [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4c
> > [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbf=
ff3bf5c6d
> > [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000=
000000001
> > [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 0000000=
000000000
> > [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) kn=
lGS:0000000000000000
> > [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 0000000=
0001506e0
> > [    0.818330] Call Trace:
> > [    0.818331]  <TASK>
> > [    0.818333]  debug_object_activate+0x2b8/0x300
> > [    0.818336]  ? debug_object_assert_init+0x220/0x220
> > [    0.818340]  ? __kasan_check_write+0x14/0x20
> > [    0.818343]  call_rcu+0x98/0x1110
> > [    0.818347]  ? vprintk+0x4c/0x60
> > [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.818354]  ? strict_work_handler+0x70/0x70
> > [    0.818357]  rcu_torture_init+0x18be/0x199e
> > [    0.818361]  ? srcu_init+0x133/0x133
> > [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818374]  ? srcu_init+0x133/0x133
> > [    0.818377]  do_one_initcall+0xb3/0x300
> > [    0.818380]  ? initcall_blacklisted+0x150/0x150
> > [    0.818382]  ? parameq+0x70/0x90
> > [    0.818385]  ? __kasan_check_read+0x11/0x20
> > [    0.818389]  kernel_init_freeable+0x2b2/0x310
> > [    0.818392]  ? rest_init+0xf0/0xf0
> > [    0.818396]  kernel_init+0x1e/0x140
> > [    0.818399]  ret_from_fork+0x22/0x30
> > [    0.818402]  </TASK>
> > [    0.818403] ---[ end trace 0000000000000000 ]---
> > [    0.818405] ------------[ cut here ]------------
> > [    0.818405] ODEBUG: active_state active (active state 1) object type=
: rcu_head hint: 0x0
> > [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.818424] Modules linked in:
> > [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00=
 <0f> f
> > [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> > [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4a
> > [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbf=
ff3bf5c6d
> > [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000=
000000001
> > [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 0000000=
000000000
> > [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) kn=
lGS:0000000000000000
> > [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 0000000=
0001506e0
> > [    0.818451] Call Trace:
> > [    0.818452]  <TASK>
> > [    0.818453]  debug_object_active_state+0x1d6/0x210
> > [    0.818456]  ? debug_object_deactivate+0x210/0x210
> > [    0.818460]  ? __kasan_check_write+0x14/0x20
> > [    0.818464]  call_rcu+0xb7/0x1110
> > [    0.818466]  ? vprintk+0x4c/0x60
> > [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.818472]  ? strict_work_handler+0x70/0x70
> > [    0.818476]  rcu_torture_init+0x18be/0x199e
> > [    0.818479]  ? srcu_init+0x133/0x133
> > [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818492]  ? srcu_init+0x133/0x133
> > [    0.818495]  do_one_initcall+0xb3/0x300
> > [    0.818497]  ? initcall_blacklisted+0x150/0x150
> > [    0.818500]  ? parameq+0x70/0x90
> > [    0.818503]  ? __kasan_check_read+0x11/0x20
> > [    0.818507]  kernel_init_freeable+0x2b2/0x310
> > [    0.818510]  ? rest_init+0xf0/0xf0
> > [    0.818513]  kernel_init+0x1e/0x140
> > [    0.818515]  ret_from_fork+0x22/0x30
> > [    0.818519]  </TASK>
> > [    0.818520] ---[ end trace 0000000000000000 ]---
> > [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_t=
orture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> >=20
> >=20
> > After apply this patch:
> >=20
> > [    0.647048] ODEBUG: activate active (active state 0) object type: rc=
u_head hint: 0x0
> > [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.647073] Modules linked in:
> > [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> > [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00=
 <0f> 0b 83 05 7b 62f
> > [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4c
> > [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbf=
ff467586d
> > [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 0000000=
000000000
> > [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 0000000=
000000000
> > [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) kn=
lGS:0000000000000000
> > [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 0000000=
0001506e0
> > [    0.647104] Call Trace:
> > [    0.647104]  <TASK>
> > [    0.647106]  debug_object_activate+0x2b8/0x300
> > [    0.647110]  ? debug_object_assert_init+0x220/0x220
> > [    0.647114]  ? __kasan_check_write+0x14/0x20
> > [    0.647118]  call_rcu+0x98/0x1100
> > [    0.647121]  ? vprintk+0x4c/0x60
> > [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.647129]  ? strict_work_handler+0x50/0x50
> > [    0.647133]  rcu_torture_init+0x18be/0x199e
> > [    0.647136]  ? srcu_init+0x133/0x133
> > [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.647151]  ? srcu_init+0x133/0x133
> > [    0.647155]  do_one_initcall+0xb3/0x300
> > [    0.647157]  ? initcall_blacklisted+0x150/0x150
> > [    0.647160]  ? parameq+0x70/0x90
> > [    0.647164]  ? __kasan_check_read+0x11/0x20
> > [    0.647167]  kernel_init_freeable+0x2b2/0x310
> > [    0.647171]  ? rest_init+0xf0/0xf0
> > [    0.647174]  kernel_init+0x1e/0x140
> > [    0.647177]  ret_from_fork+0x22/0x30
> > [    0.647181]  </TASK>
> > [    0.647182] ---[ end trace 0000000000000000 ]---
> > [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_t=
orture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
>=20
> >Very good, and thank you!
> >
> >Now suppose that someone passes a pointer to call_rcu(), but then invoke=
s kfree() on that same object before the grace period ends.
> >Is the offending kfree() flagged?=09
> >
> >If the CONFIG_DEBUG_OBJECTS_FREE is enabled, the debug_check_no_obj_free=
d() will check wether the object is activated in kfree() If is activated, a=
lso output callstack.
> >
> >__debug_check_no_obj_freed()
> >{........
> >	switch (obj->state) {
> >	case ODEBUG_STATE_ACTIVE:
> >	 	descr =3D obj->descr;
> >		state =3D obj->state;
> >		_spin_unlock_irqrestore(&db->lock, flags);
> >		debug_print_object(obj, "free");
> >	}
> >.........
> >}
> >
> >Hi Paul
> >
> >The __debug_check_no_obj_freed() only check obj->state,  don't care obj-=
>astate, the debug_object_active_state() is not necessary.  If CONFIG_DEBUG=
_OBJECTS_FREE is not enabled, the kfree() will directly release it without =
check obj state.
> >
> >Any thoughts?
> >
> >Thanks,
> >Zqiang
>=20
> Hi Paul
>=20
> Sorry to bother you again, I think this change is still meaningful, or=20
> there is something I don't konw if I can give you some suggestions, I wil=
l be happy to accept.

>My concern with this patch is that there might be some odd scenario
somewhere in which valuable debugging information is lost.  Unfortunately,
>I haven't had time to fully explore the space of possible sequences of=20
>double-free and use-after-free bugs.
>
>It -might- be OK, but I cannot prove it.  Thoughts?

If CONFIG_DEBUG_OBJECTS_FREE is disabled,  invokes kfree() to release point=
er before the grace period ends,
kfree() will directly to release it, there are not call debug_check_no_obj_=
freed() to check this debug-object corresponding to this pointer, when this=
 pointer is checked before call RCU callback func, the  debug_object_active=
_state() and debug_object_activate() is not trigger warnings. because this =
object state is correct.


However, if CONFIG_DEBUG_OBJECTS_FREE is enabled,  when invokes kfree() to =
release pointer before the grace period ends.
We only check the state of the object(obj->state is set by debug_object_act=
ivate()) corresponding to this pointer, the obj->astate Is not be checked, =
That's is one reason I remove debug_object_active_state(), and I found that=
 few modules use this function.

Now there is another problem,  set CONFIG_DEBUG_OBJECTS_FREE and CONFIG_DEB=
UG_OBJECTS_RCU_HEAD  is enabled I did a simple test like this:

       struct rcu_head *rhp =3D kmalloc(sizeof(*rhp), GFP_KERNEL);
        preempt_disable();
        rcu_read_lock();
        local_irq_disable();
        if (rhp) {
                call_rcu(rhp, rcu_torture_err_cb);
        }
        local_irq_enable();
        rcu_read_unlock();
        preempt_enable();
        kfree(rhp);

the follow warning are triggered,=20

ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
[    1.255220]  debug_check_no_obj_freed+0x248/0x280
[    1.255238]  kfree+0x12d/0x610
[    1.255253]  rcu_torture_init+0x16e1/0x1741
[    1.255305]  do_one_initcall+0xe5/0x440
[    1.255349]  kernel_init_freeable+0x342/0x3a0
[    1.255366]  kernel_init+0x1e/0x140
[    1.255373]  ret_from_fork+0x22/0x30

The code shows that if obj->state is always STATE_ACTIVE, there will be a l=
oop,  until rcu callback is invoked set this obj->state =3D STATE_INACTIVE.=
  after that this loop ends. If we invoke kfree() in preempt_disable/enable=
() critical sections before grace period ends, it may be trigger RCU Stall.=
  So maybe we should add fixup_free functions to rcuhead_debug_descr, In fi=
xup_free function, set obj->state is STATE_INACTIVE and set rcu_callback fu=
nc is rcu_leak_callback() to fix this problem.

static void __debug_check_no_obj_freed(const void *address, unsigned long s=
ize) {
    .. ........................
        for (;chunks > 0; chunks--, paddr +=3D ODEBUG_CHUNK_SIZE) {
                db =3D get_bucket(paddr);

repeat:
                cnt =3D 0;
                raw_spin_lock_irqsave(&db->lock, flags);
                hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
                        cnt++;
                        oaddr =3D (unsigned long) obj->object;
                        if (oaddr < saddr || oaddr >=3D eaddr)
                                continue;

                        switch (obj->state) {
                        case ODEBUG_STATE_ACTIVE:
                                descr =3D obj->descr;
                                state =3D obj->state;
                                raw_spin_unlock_irqrestore(&db->lock, flags=
);
                                debug_print_object(obj, "free");
                                debug_object_fixup(descr->fixup_free,
                                                   (void *) oaddr, state);
                                goto repeat; ..............................=
.
}                             =20


Thanks
Zqiang


>							Thanx, Paul

> Thanks
> Zqiang
>=20
>=20
> >Thanks,
> >Zqiang
>=20
> >
> >							Thanx, Paul
>=20
> > Thanks,
> > Zqiang
> >=20
> >=20
> >=20
> > >							Thanx, Paul
> > >
> > > ---
> > >  kernel/rcu/rcu.h | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >=20
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> > > 15b96f990774..0604ecd16627 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsign=
ed long new, unsigned long old)
> > >   */
> > > =20
> > >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > > -# define STATE_RCU_HEAD_READY	0
> > > -# define STATE_RCU_HEAD_QUEUED	1
> > > =20
> > >  extern const struct debug_obj_descr rcuhead_debug_descr;
> > > =20
> > >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > > -	int r1;
> > > -
> > > -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > -				  STATE_RCU_HEAD_READY,
> > > -				  STATE_RCU_HEAD_QUEUED);
> > > -	return r1;
> > > +	return debug_object_activate(head, &rcuhead_debug_descr);
> > >  }
> > > =20
> > >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > -				  STATE_RCU_HEAD_QUEUED,
> > > -				  STATE_RCU_HEAD_READY);
> > >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> > >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > --
> > > 2.25.1
> > >=20
