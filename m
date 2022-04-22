Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE350B711
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446860AbiDVMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389189AbiDVMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:15:03 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 05:12:10 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5475676C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650629530; x=1682165530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2rSn6DFS0lcscwXjBnZScziBpGyW8J7ErE4/m2PgXMU=;
  b=pli6MUIukO+3RXdLfbS91eqmS9sORh9XdqwnhEuA9BTAzE7TyuhyDoKl
   Rkm7Zqqu4q6EF7nI0l6eo2J/pcCGrwjA1aY6GqboApTtj6wXjhflgkKhz
   36HfvOsdoxzdnP4+lfcIcNXoFm83ArjycWmOTlck0E1paQNl6pidLYKAE
   ufpYYRi+p6ngZ1SexYaCcLIEz4lCE5MFitIpCGxl1LtwviA7uvaQiFuZR
   O+H1rrGFKUpa/p1M5grM7ZfR8VezKIccFcRo4yjE1NdV5B1Y3LXMDO0KP
   VPDK/ZcZNDjzU3kgRTi3t/OcmxUWdQi39/M34YDvPmSbC3D26zWH+3Yku
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54453535"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="54453535"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:11:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrYDoB6f92FB78649GC+v1S1fXUrOsALMuMuyfFXafk4ppr+n16Fj7H3T4Y6ElFISeLf3HNZpsvDdE1EnYL1ZLqhGN/NMqDNmCh0BR7DuDJ36omWn2f8cYf+XbK3XHlKxF7mQDg+xzK1mBDuiBBuTPAD3S3B2fyJTKmPQnCM+ExQIXr5FEzKKe5OlLFfVzJCU4fyDnsnm72SSykzQuNyk+Btgejwvdigwz8oDr0JBGw+Xz8/b9E/1yQFiRzRXFgqSsxjuxu7hPsRDzwTR+1c5DRxkxDbQC1/B674vReWXD33Xpps8rsTi54FRagJELyknMMylzmuo6EGfbWrMpaPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rSn6DFS0lcscwXjBnZScziBpGyW8J7ErE4/m2PgXMU=;
 b=DJ0uLPXCdaRwQLKypHCxOhIXvmXwkDFqrLCOKuyQMvIZ0cTS2sevf1fReAKdAacdY/9xZ9HLmSe+hN/uQLdbq0S3G9mhm0ub0p993nbUXQKypBXWK2Lo62RBukNG85tHbAdVIDvcB926k5kNN+UGRLmX69HwB1MaZA3RVfO7dEPaVLUZoEO2H4amVBurcQ0Kq9a9xV7PxAkeWmGzzVISBRzm/0rKFv7chWHlGCtI0/BSaJ2I1J4D0j9Bq3nhNHq5r+GF5wyYE/hCcDcbGXSRJaF0iynSE1i8D0NgArFWl0JnzANk/oeig2h8BVwAdLzjg+o7AtDFl00mi6Bqe38Kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rSn6DFS0lcscwXjBnZScziBpGyW8J7ErE4/m2PgXMU=;
 b=DV9Dc8ixl1S87VjoAxdRmrcwcYfxBoPXGL7Jrj2Im9uWemfwhBFGF2Sri1w0EGp3LkmTkv3txl0nXyaFFOcYqzABBFFxzAw98riFEaX6M4f132Kta5TtIVUKapw5fJb5l7SieynOuA4mwCT48A8nn87RHXUImH4a7ubtPGknJ8E=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYCPR01MB9941.jpnprd01.prod.outlook.com (2603:1096:400:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 12:10:57 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:10:57 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v3 1/9] drivers: base: Add hardware prefetch control core
 driver
Thread-Topic: [PATCH v3 1/9] drivers: base: Add hardware prefetch control core
 driver
Thread-Index: AQHYVGMLEHjgMDmteU6Jl0/t5EKiYKz5VdIAgAKC28A=
Date:   Fri, 22 Apr 2022 12:10:57 +0000
Message-ID: <OSBPR01MB20378E97DE0CB45ABB5E677680F79@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-2-tarumizu.kohei@fujitsu.com> <87mtgftov3.ffs@tglx>
In-Reply-To: <87mtgftov3.ffs@tglx>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aac9129-eb96-40b4-68a9-08da24592848
x-ms-traffictypediagnostic: TYCPR01MB9941:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9941E5EFDAC8CA03F2D5D89380F79@TYCPR01MB9941.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crWO71jwM3+oradoTWOBOertKSPzON+zLq8Kj3VGcb79kjpeL0HbRZfV+BxuMBwY0JMghftdzTM+H+kgR1IZob59g2wJm1KrPW863P+WoocMKaqVDVVcQg1WqRjXE2D5l8sulbH8xVP7aXQcPJ1J3p1VGH2388LJ1PRbYQI0lciwWZlhaRbGY6sC99JCwNpanMlm3vic3BzbTNV+3C7JH4AmI75wfxUHNSlyyAJgqeVS7QrC9Tb2vfoEIerZV2WSkChFEglicsrdK5Vl6zgOMHeyef7f8ClD0kJWTbMyCO7hUWV+1i+8cZrHiLJgYD7D8GKGwrGYudmLKA/HNeWOaUao64WfFtJ2wDkxpsRmdrfUCigEkQl450RtavkiHwC5ya5DawbP0k3V4rmk2JWYUrzDoaoed/AYqspk1sd8RGyoM6qf4WHtFJswEdgDbJtF+ST46GnfRyE3uF7k1AkcYUPxY2v+bGjSj4KGZZ8qzdbyJ5bwNvTGU8mTYNMEWvtld/JnnBWScQ2WUb8DtVy2nm7jDvCJiqigq8TIBZNQySV/1RZsFKOFCHczpYND3BqRoCO1OKGBuET45FxwXsKL+UoLB8LWYwznzCb6NVaVR3SMMzMQkQlvapneVCJqmlyx5m3Zt7Tb9YREyUdYN4Vl18y7P/5NKWv5+cc9tE5qXk1G9ENLiYG6rQfJ/Rv5spvJcfQvt2iRUws978Ibrq2JXGkRekljHSZdVEkmc1N6mUw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(316002)(38070700005)(85182001)(921005)(122000001)(54906003)(4326008)(52536014)(9686003)(38100700002)(83380400001)(55016003)(186003)(66556008)(66476007)(66446008)(64756008)(8936002)(26005)(110136005)(7416002)(33656002)(508600001)(76116006)(66946007)(7696005)(6506007)(86362001)(5660300002)(2906002)(71200400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NTFQYUo1T05mN2J2QUhXRkFoUXc4T3Jqb0lDMmxwNk5xU3ByY2s1cnU0?=
 =?iso-2022-jp?B?Rk9GazJSelRVNURQN3o3VmwwUW1pVlc3VlNUNlJzdURiMDgrZ1VNMEdH?=
 =?iso-2022-jp?B?SmtOYnJia1BrWXduMU4wR0ZOeVVDTVZEVnhBM0hOdVpQYTh4ZUlSdDBO?=
 =?iso-2022-jp?B?SVo1STV2bXhLTlZLWWQ4WWtSUzdnS1pwb0FnNVM1ZzUySGlKenJPcFhH?=
 =?iso-2022-jp?B?b0pYTlB3cVFYTTZEamxVNGpPRCt3bmFUdHUrWElrOTNqeWhEcDBYa1pU?=
 =?iso-2022-jp?B?R2sxWGYwSjBnWmVEc0ZlT2JwdVRzN1llN0c4a20vQm9Zak5pOWdLT3BJ?=
 =?iso-2022-jp?B?ZlNpL3BQQlRKWElDZ1VoVUlBSkdzdG5Ua3FlUjZ0MFlidENuRzc2b0NG?=
 =?iso-2022-jp?B?RU94UDVoVG5QNUh2bFZRQWJ6K2Z2ZkdXRDJvdE9CcHhyVDhOcUl3WHdV?=
 =?iso-2022-jp?B?ZjYrWks5bkJqMXEzQ2tWZG5ZaGphOURHbVhCUVhZK05ocmhDU2luV0hP?=
 =?iso-2022-jp?B?ZTVHemp6Sk9yNmQzVTh5VTJZYUNhY0ZJNlFWV0lYb3hvelcrNlNCeEZZ?=
 =?iso-2022-jp?B?SjlxZjcrcUJ5dHF2SnFhSzJnZWR3TG5laU5jcUUrbHQwVndBRmFHdldo?=
 =?iso-2022-jp?B?RlE1UnE5VXIvdnMvaXJqOTU4L1dwcmRPZlExVzRUOGIxMjh2c1MyTWFu?=
 =?iso-2022-jp?B?dVdnQTlqWUlYcThyU1dkUkYwd3ZLbmY2dlVZR1F6WnJrWWJFb0QyR1d1?=
 =?iso-2022-jp?B?OVBnZVFrcE5RN1FramVlZEFpdEhadDN4aCtqaHZqNzZyeTFyaFJWdHRI?=
 =?iso-2022-jp?B?a2lCOWlsT0lpTVhRYlRHVE9pemk5c1FWcUl1UXFQb1htSlVGMWVkKy9F?=
 =?iso-2022-jp?B?MFlsdGJyYVJobTdQdVVkY1h1cEgyc29YN3V4U1FjVm84NytlMWlYRCtp?=
 =?iso-2022-jp?B?WDlPY2N1MU1ySFlGVVhvNTdabXdCbG9xcEF2MjZzV1d3UE9lT2NtYmRE?=
 =?iso-2022-jp?B?V1A0VVBDaXV6Q0hxUmZ4Y3d4eGlJQVVrZ3hMNExBanA0WWxuMXJmYUU1?=
 =?iso-2022-jp?B?VWpLTW5GRGo3NVo5ZWZIeUZsYTA5UEhSNEdaVUZadThLOVdKOXNXbTZv?=
 =?iso-2022-jp?B?d3NkRlk4eGJuMml6d2lLTzNxWisvZGJ5NmFleUJCVnk0cW1hd3A1eThj?=
 =?iso-2022-jp?B?NEFlK3c5WHo2WS9vbVJYbXk1OHdsUlZxRXExelJpMGVTY3habGVPUHc4?=
 =?iso-2022-jp?B?VFY2Rmc0WFkrTFY1UjcrL05CSFh0WXUvOXhaWkVCWEE3RHNHZXcrQnE1?=
 =?iso-2022-jp?B?NTZ2OVNmblR1SUF5U2hzNncxY0dIUnNzbGJ4ZitBdHRCcDgyZXkyUGI0?=
 =?iso-2022-jp?B?VWU2YlRuM0JPR2lCV1JJNUY3VTdoMVVpbENlMHVvS0VkUjhYVHU5VHo2?=
 =?iso-2022-jp?B?dXZ6RWtoald5ajlBR3p5Q2twVFE1ZTNnbnlrZjlidjYvR0dyVkFFNE1p?=
 =?iso-2022-jp?B?VnRZTWc2ZktKei9hT1l3SXFuRDhKVUNVSzQyTXJuVzhZKzJEZzlkK08r?=
 =?iso-2022-jp?B?RUVmUnEzK3JORkdzRnlacnpvMEwwRG9wa2xMSW50TjNDTDFJRk1tdHNz?=
 =?iso-2022-jp?B?Q1RtWDR6SGNKVWlVKzh2aU5EUmNyQXlmMktnUkIyMXR1T2xMeGJ5NzZw?=
 =?iso-2022-jp?B?emYyNys4b01iRWFEc2ZxcGx6ODJ0SndteUk2VzhVNW9ZNERxL1Zwem41?=
 =?iso-2022-jp?B?MkZWQWt4Y0lncG84Q0VZdTJnM2JGRVo5TlhFNmRZWmxDSytscFUwajQz?=
 =?iso-2022-jp?B?TS9OSUpudVlmR21RRE9OY203UU9rb1Uza2VPbmZUUjJRZkx4bS94TmFp?=
 =?iso-2022-jp?B?L3VDZDcrNWwybzNLZ2RYaEM4T1o0dmlxcUdzSFN5U2lkdVZ1ZFRYQTdm?=
 =?iso-2022-jp?B?dlZXdmRsdHNRUVJvcjkxc3VWQkxZaGhHRHN2ZWcwbnhuL1pIYmduVTFQ?=
 =?iso-2022-jp?B?aWdTMWZPUHh4c3RtOEtXcWFEbDIvNDhvY3BGa09BOXZsUmQ1WWtubjNj?=
 =?iso-2022-jp?B?ME0rV21MR3BpY1VjNklNalg4S1o3SjYvV1FxY3NIS2tXVks2bENnQ3FF?=
 =?iso-2022-jp?B?MmhKcW81T2ltbjYrM1greHNncDFhb0IvSVVGcmJTNFozWGVRZnlWbzNa?=
 =?iso-2022-jp?B?RE1kUU90OHN3Vi9sNDd0cmY5ekRxbWc3ZU5RN0lsZXhKNC9vWFpJNzA4?=
 =?iso-2022-jp?B?aTNzSGlDNjA5Y2Jvc3JoQWtmaWZIU2p5N1hYVDRZY3ZmRENib3Z0blUv?=
 =?iso-2022-jp?B?d2FZV2QzUlBmZUlaNVhwc0xVejMyZ0UvMTZqT2RoeFZNVzFMY2pmeHFQ?=
 =?iso-2022-jp?B?c2dpaE5icHI3VlZoOHRlTW1oR2hHeXRLbTE2bEdyS1ZIaVRsTnlpQW5J?=
 =?iso-2022-jp?B?Y1pvVVRNZ3NzTDVoVWM2STFKa1IzenlRbVY2dFVpVkhqdVJnTUxmekpa?=
 =?iso-2022-jp?B?SjB4YnNjSFZkdm8rdVZFUjVFUXZhZUdMSGtJckplTDZhRGNWYjVzc1V3?=
 =?iso-2022-jp?B?ckdzc2ZKcz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aac9129-eb96-40b4-68a9-08da24592848
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 12:10:57.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vGckv4IfoshjV4wALS6Z/a0ymIQVAZJvShAjJo/UrjpUD+LIQZNnSeytEt4GBNMavi2YOgaQ7noo09a6PPv3JGpk/yrCWxYl2kreDKhgr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9941
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment.

> This is A64FX specific.
> This is x86 specific.
> This is A64FX specific.
>=20
> So why is this in generic code and why needs x86 to populate the A64FX bi=
ts and
> make them invisible? Same the other way round.

As you commented, current generic code includes things that are not
needed outside of specific hardware.
=20
> Now imagine a few other [sub]architectures come around and add their spec=
ific
> prefetcher control knobs, strings and whatever. That's going to be unmain=
tainable
> in no time.
>=20
> This is not comparable to the cache attributes where the architectures sh=
are a
> significant amount of subsets. You just demonstrated that X86 and A64FX s=
hare
> not even a single entry.
>=20
> The core code should provide infrastructure to manage the [sub]architectu=
re
> specific control files at different cache levels.
>=20
> Not more not less.

I understand the risks of the current implementation.

I would like to fix the core code to provide infrastructure to manage
the [sub]architecture specific control files at different cache levels
by also referring to the comments I received at patch 7/9.
