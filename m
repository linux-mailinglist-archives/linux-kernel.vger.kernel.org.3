Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFD5A598F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH3Cwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiH3Cwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:52:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34017B2A5;
        Mon, 29 Aug 2022 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661827960; x=1693363960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hpdom2F8JUseqH/ynR8e83ipceJru7TEARIKt5W9pL8=;
  b=ki0JvDJ8epgRqLkVYhVvg9X07Y9LdUE+XMzShXAfFPtZzFkGsqhUc9K7
   wkk+Y7EMQo819sDhas1QZSxsA7m2dK2qVVSsIxPz7cSmnKlUhjhTw1KIB
   axfweH6Xns7qgKVvZg7IQ0Ei07rvVilEXGghAunEivpzeN10YGqHTunPl
   zSDYP87ESYt7hiEYDrh/cowmchb2uVtUCzwzpKexIc2ALa144Sc6l6W1Q
   mCiV2Yzog6dtZh0SfH1ft/grYAcmzghAhdz18DPonpNS7PyRLQmYfQ+YY
   E8NYeq3KrxyajSYHmRb1gBlBWX5sUXfkjEP/xW4NOo+GnZK/ZnQ6Aueux
   w==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654531200"; 
   d="scan'208";a="314269035"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 10:52:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6QBjQAWGZZ1n9snoNmvdxN8tpdUFnjL/aMP9RNnLAELNt3cB1d2kO1IDoP9qFt5tNTaUNvOiWLwBhOruSD/6qb4rnZmUCRrAfkoFmajuaYNdT2K1d08mD14TxpEEjdwQJW6NDGu4Ze0lsLBo9EmGKTpe7d+jwgFmluS99naSbccdHQIaR2x8+PMvqrku4d06ovTw0gOq3APNpL6d+l8Ug1H8merYhGxJHmX5i8/UW1FdtcBBhfwVLvwpejtk1E6jpWA/z2g0jzwrxTcb3ws8970/ttLxwR1ocCyNSJ1vSnZJ25KWftDQn16zgdQ88lLbh2v73nwnX6hEsPMe4GplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpdom2F8JUseqH/ynR8e83ipceJru7TEARIKt5W9pL8=;
 b=jWief/J+LNzne38lvk9NYu015RcvhnrkhQT8vipEXbMDX6+8IN2l01uoflX9/LXJObey969KuyvWYj/TSIYi+PjBh+QTRBnJdpjX/s1HD11rDqcagcdWAr8pOce8fkixjKxG9ep7mds+UMHa+BR77mz7a1suOqZftPEmfs7lmphP/2EHRwi5PbjPskFMIOaqebEZXfChOVIF4qU7+uyDDR76oVuY7kXL6Mn73Hc63VwmGGlIMX+gHEJPuP/j98oDE3bAR7eyFkgvHZ3akl/hFq0mXcy4LT70LTW2psv5ZGZKr/N+uMwCAKTpJSLeDsdXrAjuanecYSFLgOekPrJAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpdom2F8JUseqH/ynR8e83ipceJru7TEARIKt5W9pL8=;
 b=J+iUQ9k0xB9ZJIA0aMHZhVcQ5/tnnoXhOZj3fHH5A0DnCZwNP4fEmULA0iey2Vv2U60lKgHubCnS4cYX8PSsSAF028zviKu8YpuaGHBqVj1AIYITy7f68lG4AJBW/q4m97uPfkpn3zHsig4ungp+8cn3NIaOjZzlPBk9j4O4ij8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7433.namprd04.prod.outlook.com (2603:10b6:806:e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Tue, 30 Aug 2022 02:52:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:52:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Thread-Topic: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Thread-Index: AQHYvBuPaQNCPIoJM0eY4KBRnLcQhA==
Date:   Tue, 30 Aug 2022 02:52:37 +0000
Message-ID: <20220830025235.vesnxh6xw6j2vvsu@shindev>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
 <20220823121859.163903-14-p.raghav@samsung.com>
In-Reply-To: <20220823121859.163903-14-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94247c3-3e0c-4fd3-4ecc-08da8a32b288
x-ms-traffictypediagnostic: SA0PR04MB7433:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YDXeNlPfh4rS3fnBodeI91BduTPUboQ9/jD2sAZo+Qz2nfgI8qhQlwRdf1tF5/8ZHYUHuzVuFZB+Fdcc9LHGfzYPgeze8euJhbuTK7S8CYWosjdOyO07L2u6yEP2vEWzjHhIb92w1+tWX9bNj4bjqYdXoSgiSptkiLcaoMuiw/0Iux2+IWvw6c97WmoNDAxOr37eCfNrx5Wneck4Ju+NKGZrCr7gCmY3VJGFCkJQoxxfRSzNwcHJT6JOqRNara9cluYGJsCmCN15RIJHlXYcyTlT0+oYv2GL9EefWR5obiCk5zSgXb5xzeQiwKCAe3EWD0ciRpMwXTPFx6a72dqbiZdAlBvQMFTvMd+QIZ0mBg2YjcT3zmL+0EsobaXGRO+H//fb0YGT2KV1h4vwgG4W3YUgQ3uFCTNydHh9UF6nax0xkP4/T91aRjOqPlIsXx5F5kmV4RwIJi+l3vfzBWtXSc87DEukWLiO3DZHFAJrUZ3gNgzzy0lv+EVyqdfvC2nnGwSUV7NdLmjPj3IjaTYZkRYi0kamVt81jknQL9oy1+e4lyUUjOY5qU/V09tBHYZEl2H8B1/w0Rs0DuhujludV1bScOsoo9que5rwZoAZobvqxS3qfij/HjeXXc9Z9r0kj6d2C5gWBN93PyVRWkccew7tyc6bpo5sI8HePpih/6mIlZwpdwwgtHdZW8dPT0Aav7S2hx1Xw6htfubVjW4wOnpOKOg2c3gTxXxPc+YuuaG9ugjZ9jqVCFpOV4ULUxU4x3SaQbtZCbE9jEXEkcy7CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(91956017)(1076003)(54906003)(6916009)(8676002)(66476007)(86362001)(66556008)(6486002)(76116006)(4326008)(66946007)(66446008)(64756008)(71200400001)(5660300002)(82960400001)(7416002)(41300700001)(38070700005)(478600001)(316002)(8936002)(33716001)(44832011)(4744005)(38100700002)(6506007)(122000001)(2906002)(83380400001)(9686003)(26005)(6512007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZXluAVRXn7EC5yVgpTN82pTohwVK/t5x3Tnyxtfb/mZt3/7jtOKyUEJQwI?=
 =?iso-8859-1?Q?ziAbikPxNdycOwM3EjEEujewjX1ZH0jk1Lv2/LlGDyVg6OTt5sFWv3B3S4?=
 =?iso-8859-1?Q?7Mmookj5fhJrvngN84RzmChCV5kgQ6sZ8OCnlE0+mWbNSMMpCnqwDvRwT6?=
 =?iso-8859-1?Q?VDRlucrAcCDAkhsI21k0o/Q0CYuG8vslmh7lD4AyVLbTXtVZVM08gBfoDi?=
 =?iso-8859-1?Q?kSdtxfDWFeQmkVqjgPsX/NYaRBXv38ZhTHayMeR3n+8AWlP2vXyd2zLfss?=
 =?iso-8859-1?Q?nWh+JOa8VDHQX/Ga2wpT/bg+x85ymiHCLIhQDCTRNFrqTwVNM4s3AOD6UI?=
 =?iso-8859-1?Q?c5qfCFRTXuf6/BCsa3Z4g9NC5esxqiQZXGS9lRJ8VDGDEzeAplIhuPGUi+?=
 =?iso-8859-1?Q?LBFVb1mQrHbpQjR9uVkRQSXhxTU9DAHBXiP3p65miK4IIzKK12GfkyWI17?=
 =?iso-8859-1?Q?Iq3KVkngsiooWS3h6v+FNKcNoNqQ7qQYoTDFT8N5FeLkwNnYJ/X+8KabqN?=
 =?iso-8859-1?Q?RJwfzlcbJSqMxEEFfYRmdTa5DwnpcVxyMwe0pY2WyKOy4dixed8ciAM+tP?=
 =?iso-8859-1?Q?XL7432FLYc99st6jMKGrm3YT2KHIoZpJPZ3uCOB1M81RzuaGU4PukXunLp?=
 =?iso-8859-1?Q?78+/GX5C99ROTmYAXEu1/IFjgYJQ/rfZ3MjrVRCjktG3GlC0fDnaM6YNn7?=
 =?iso-8859-1?Q?OexiZDRm4OFvjx+vvKVKH25ec3tzgD4GSDaC85m+3mGvXG65JTIyrw+ICQ?=
 =?iso-8859-1?Q?m1OnZBaUVha93a5dnX0rhb+UgNM6cjqidZFEBkdqtjS8me0JmWQ5xfxqg7?=
 =?iso-8859-1?Q?PhK1GK11HmI2igAKiEnH83ctRIveW/6rRy7YhCeE0V9nuz5f3LfS+RHDJr?=
 =?iso-8859-1?Q?iwLuNXK7A5SoJP3ZhzoaEkok51pUPsUfp6Pfi/yUDO9tFlR5Vo/B0qheA5?=
 =?iso-8859-1?Q?5VwgRlIa4ZthyAoQy4IkTpwkiAE94dwi+CdJcqkhWipebrwbQU8hW0TNiG?=
 =?iso-8859-1?Q?Qj+nlKTsEqcjDBtVwCdU/WOrJ3P36wQXpAKNbt1E6wqkdxjqUsTDA4bk31?=
 =?iso-8859-1?Q?kbzo6vUHOhFoVBssOoMYMAmhkxXRU2UyF0vV4zvQVN7noSu3X2A3YTdXZR?=
 =?iso-8859-1?Q?zVglGHWSvn7LYgY/dLQxVSeZVn9W6zsDnqRm6yBL6ZxZy5hgKUBZMChEs1?=
 =?iso-8859-1?Q?0nglIj/jGdYqNhg1dxlEwIlZDbXYQq+t1qMxwWDwCPVbaQLyX2U1exqSpU?=
 =?iso-8859-1?Q?SVv0yila+4ptmRmrAb/X+jF7oQ+h/A+A5xGH+5jDi0agBNW+jSgzJYyJq/?=
 =?iso-8859-1?Q?NPscSmnfjm17PK7eDuXxZY1AiOvvcPDAgdJreEy03AvPZTAkXnRDTetPW0?=
 =?iso-8859-1?Q?5E3XiXajCxqxoaqPHD4+pLCQRnjDonf9QXEqf7awDbRs8Sn12dRVx+DJ58?=
 =?iso-8859-1?Q?MMSDMOexWGxC28F4LsKH6Kh4o+DZ2Xbvn9r4Yg5eQ4oDtj9C+OAMzxNC+u?=
 =?iso-8859-1?Q?xhJdOJR8AWKXxcVRq2i4lnFJmztG0v4y1Folw5lWgF9yV8sGwJZGkt7voQ?=
 =?iso-8859-1?Q?WuF+1ABOKBSQ8o4JCoX544BUBqB0DnP9hAUAEw/cra6OEeN508rawXqi+E?=
 =?iso-8859-1?Q?ve878bo1cOJ08swFTNBMiJngPFXJqD9XovbEvrmpziewOY/xkcCLgdZbdP?=
 =?iso-8859-1?Q?6lZSROV/O2/5L7AxjC8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <42404C1EAA114F4B887B69257D54658C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94247c3-3e0c-4fd3-4ecc-08da8a32b288
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 02:52:37.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X43BsAi1OoeVoyjiSFPgW0ARbXpI5BBOZABehKWWBJYqO6VLYChDj+OUd7tsUcn1687lRzwLXVaq7CqrCJzjjNnaCQ3ebZ7OLxApHXsFOX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7433
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2022 / 14:18, Pankaj Raghav wrote:
> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
>=20
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device t=
o
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes by using this target.

FYI, with this patch series, I created the new dm target and ran blktests z=
bd
group for it. And I observed zbd/007 test case failure (other test cases
passed). The test checks sector mapping of zoned dm-linear, dm-flakey and d=
m-
crypt. Some changes in the test case look required to handle the new target=
.

--=20
Shin'ichiro Kawasaki=
