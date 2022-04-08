Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B274F8CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiDHB6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiDHB6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:58:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2054.outbound.protection.outlook.com [40.107.113.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854EA10EC4D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGfILu1coIs8XpRyDkw8u3iB6i46YRGIgzUs6j1h9LdXZg/xmHYSZV6AypghYHjJjU7TPrVlSc7rzFeMLzVspp3PoTtZ4+8KWEa7+DXtOkmvFljmqcF1v/RlX9GwR83E89+a+09mqgm4aTWusctvQFvacblFijg+DwxH4pIK9agE3akpDFnRvOaqHKNheg45scTdv30z+OPj4yVjl0yh0bXQL+DwnN+Xv7H2369nbDnqa5bZXsv+1B2zhYn4cThgYbwh93lmTRBaiNAkYXJhz2jQiUwetEoQ4SVAF0ATNaPBmvH4zvtSb6/gplx+YBKkpkC01NhZhSJNzHA6Etkgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQWGcqNpXx1hjs08jPIJ/DvEa/TArfUbhuMiVUeiED0=;
 b=kSPLMzGgBi7E2HSJv553OgXTgHptuciIFNV3ifwXz4oF+Ny7WW6ru5pn5u0ahL/AWj6j2ikWJvQnGRpD6cez/31wRoV/GC5/D/BsZwe1CCP9gHLJOK93+nlLHZAH5UZu9SON4n0s1XUeaEKAsMzgOsibtETHiCujJl1oFWAJokCuZ7Qr+VTn8lIub1MSSHhpJWkyRjqxIgbNGiIzFhZZrTnR2TZGsLyA5kLEqI470nkBtTC1zaNhmXVO5A2SlugRs3elFCrm5jfIDH5ufm9ymE/4TLawINolU3WMqK9GG7JaFAk4rtH9/Bz4XWork6Ya9P1ajKRKXH+mC78Iklmzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQWGcqNpXx1hjs08jPIJ/DvEa/TArfUbhuMiVUeiED0=;
 b=XSnI6B3w4crILgX9WmMlwsUbimOnm9kkYGmkD69ovbr4esXzITKFN61OClIIxq1xOXwWpI2t97louKcZnWTRUSGiLGibvNTQ3qd8+OyClDX+7wG6vXsybTLskL3Qzw0U92gRkQtUdBTEn8BpnPLAFHD2F8uSHLUtLAjVjgCXZk0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8735.jpnprd01.prod.outlook.com (2603:1096:604:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 01:56:12 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%6]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 01:56:12 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v7] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Topic: [PATCH v7] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Index: AQHYSnNMXhTcbXkCGUqWD5dp3QQR46zkdJ0AgADOHwA=
Date:   Fri, 8 Apr 2022 01:56:12 +0000
Message-ID: <20220408015610.GA3061012@hori.linux.bs1.fc.nec.co.jp>
References: <20220407112929.1344748-1-naoya.horiguchi@linux.dev>
 <4b5ad6c3-99a0-b04f-21ad-8ade46984c76@huawei.com>
In-Reply-To: <4b5ad6c3-99a0-b04f-21ad-8ade46984c76@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d15f2f0-14cc-44ae-4c49-08da1902f55a
x-ms-traffictypediagnostic: OSZPR01MB8735:EE_
x-microsoft-antispam-prvs: <OSZPR01MB873527208E9D6E6CC51792F5E7E99@OSZPR01MB8735.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUdyH96HEYrv6lCPHmWlQeJnsDpuqx7WFoS97ZgciegTmef/vlGZiTtc8wZmckgJNMMgSPdovyw7S6Htk4pKv57TXKBMQ6DETr54Te7TEFNUIAYHTSTkY70lWcP2L2p0OSJOt/RO4tyHWFmeCZeAdOU4P3J2pJfi8H9QevKVZEGyj8yzd6e+kgQ1noOJzO9s/blGh2NUq/kHjGNDk0S7BZ7mko/phDDFiDwK3+xo37FmUduBismnGdK2BHaxkLcUckiiAkOVw9SR2AemuuMsSCcrsYMqnuGS6hBNHysMtMQVsW3WVVWrAld4veBLkZOOAqYAsxL0BhLPZ0gh3rzN/vh7txbi3KZafNB6XJgJYrlluPPMm2xAwMALlGfp4TMdzvkTt8PZpSuimo7+0/vKD9DjoBDHCvZZCpAHCcCCDizuJJjX980i9H+vbarqBxQvU9hAhhbdEPPtwzi3yfqJEfxhKB1vKyKmy3hAZRUqtTFNXBL+nuSZlvKoCCeyONe7QMFf+MfYtr9vtxpAb3Ib7D6CkLte2EE0sIS5dKD7auV77NIMhs67vUu/VX3J87xu9sEFk7VV9kB+C88mtOYABlFBG1jPXeQPFQOTJI9xCHyEYCMp92qowGOIZFpkOR0P55TDsUCWgKArtob1H1Av6kNrnMcIPbuw0kL8WV6Hfm8N1QursqKzyzrCW2GuqmjORhEUxUG9sI1E8FBHqJt5Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(54906003)(76116006)(26005)(86362001)(2906002)(5660300002)(85182001)(66446008)(508600001)(4326008)(64756008)(8676002)(66476007)(33656002)(6486002)(66556008)(71200400001)(66946007)(8936002)(6916009)(9686003)(6512007)(1076003)(83380400001)(6506007)(55236004)(53546011)(122000001)(82960400001)(38100700002)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hPaWwzSEkyR2kvLzFzeW5OamRLUy9JSngyVE1WaDNESW9Hc2txTUVCY2Jm?=
 =?utf-8?B?VDl4cG9IYVB6NWYveTFuNm55TzhJUTlUZWVxbGRtN21qT2ZHb3gyS3h3eURM?=
 =?utf-8?B?S0JUTzhSUWlDZkFVbzJhenUzVFNScUdUMEhHcVVvVDV2RnAya1JUSHV3Mkdp?=
 =?utf-8?B?ZUUvenNJYVNDcExXUGp0MEFVYmx4Yk1tdTZFM1Fqd2luVUI0WnNlenpoQTF3?=
 =?utf-8?B?Z2M4dWpoZWErdVdIcGduQWt6KzJHNXB3K21hUlAxZENqVXdLWXhHQ3k0a0gw?=
 =?utf-8?B?VzRYcWdnR1ZDVXloWUVuRU5kalVrc0ZYUStZeWJJZDdYWXg5eDZwSkwyaEJO?=
 =?utf-8?B?RTM5ak5JcEsySlZVcjlod2Z3V05VV3ZQUGFmQjJzaVFFOS9xZHNwNGxWbGRx?=
 =?utf-8?B?OU94NkVxeDhBLytTQzlIZG1CZnV3ZlYvdUFEUkVWSlg3VWExOWlkU2lhdGR4?=
 =?utf-8?B?RTRZNi9ZUms0SFRDWitVVUIwSW1kNFk2THVoWnlobGJWRysyOVZGMFliaVRF?=
 =?utf-8?B?L3p5LzE2Y2U3T0J0U2R3TlJHRDlWek9WMFVBa01xd3JjUXh4SExKaDYzeWhK?=
 =?utf-8?B?UkRobWRZdlp1UmdUcTNjaGRGQVYyRmRORVlVcC96M2VVeTBhOGl1em03RUFU?=
 =?utf-8?B?eTd6bkJCVXUva0hLbFJMdFRwSkhtN1pvN3QxOXFiOUpYS3FoV0pnNmFqSlNp?=
 =?utf-8?B?TlJlcDlUU2tnNUUraHo2aWFJTWNzZ2tLR0xuZjFCakloNWs1ZXFIcElxY1Vp?=
 =?utf-8?B?UllsUlhjQzNFc1NGSmo2S0VuSlpDZVVsVEl3NXRPVVFXdENOTFBvQVFOelVR?=
 =?utf-8?B?LzZMNzFxVW4veHFsVlNuc0VndnRLQThYNHUrNmdnVHp5bklNYkwvMWlNZzFG?=
 =?utf-8?B?RGNDVlVjY0s5V1JqTWhtM1JRMmx6SmlxVFlxUlludWpQUTBjMm9wVnZGUVdR?=
 =?utf-8?B?enlNQ3Z4UXcrckxwdk9UU0dYR0hvU3RYK2hhVGRYUmt0WE5hSkRsY2IvWHV2?=
 =?utf-8?B?ampzQ0RMUVRpUzhNakJseVlBdE5FdGZzV1JEaHB5WFhnY2tqbDdRc2M3Qitt?=
 =?utf-8?B?Vmw1RjVKTlF5Y2xoZ0g5b1dqRGdFM29RM3h0ZjFJQ0dSSFN2SjFGeFZ4SUhh?=
 =?utf-8?B?QjdJejVMVzRCbHhSV3hiYVdZSnFJVmZGaWRiMWF4eC9waXNlQnRzQUtxVUVV?=
 =?utf-8?B?VlBGNHpqV2o0TGpBbGxDSmZwMEs4cDZ6a3lPYnN1UTVWcG1hU290cjMrWGZK?=
 =?utf-8?B?dkJva0kyODE5ZEtjQWYzbm1NUTAwMHhpS2ZhODY2YTV6dFpNemtTTzJVYWtj?=
 =?utf-8?B?R1JUS3MzMVNYbUZxRWN0bDZFR1RlT0I2WThyY2FscmlGNUZNQS9hQ0tlakh0?=
 =?utf-8?B?SCt5ck1JbTN1SllTek5IN0s1UC9GVEliSzJjWWpQaWx0L3A0d0FtU1NmWTV1?=
 =?utf-8?B?T28xWS9vOWl5enRudjVrTkpIZ0lWZXZOQzFmbGtDOU5DdENFRkpvQUM1dDZh?=
 =?utf-8?B?eW90dmRsS040RVJlRHhHQm00bU9XbzJ5K0E3eUI0SitPK0tUZXVWK3JUdW1a?=
 =?utf-8?B?eEEyZzk4eS9HTDFza0cvcU5UTzRzazBad0syZkhuOS83T21RS3ZLTldlVlV2?=
 =?utf-8?B?ekZKMTR4U3ZLRVV1dGppelBiT1ZhME9RM2xHM1R0QmtueWJBVjhIRkxkTi9P?=
 =?utf-8?B?SjJPUFZlbzBYOFRlQmdpdENsc0ZPODVDUk41SWcrSk5OYkpJMy83M1BMVG50?=
 =?utf-8?B?ckxLKzJ0QnNJTlN2MU8zTEI5UXRIanV6MXd5M2hheHRaNmExcG9odFB5WTFV?=
 =?utf-8?B?MHdiM0pobjhPeXhDb2xtSUV0RW4vVlJRUjZqNzhFaWdjRDlnT2tLc1NZc0V1?=
 =?utf-8?B?ekdQR3M2OUtjZ08zMWtWc1BFdHloWnVpZHVrWlpxdmRwYmpXSmJ5TnYyZGwx?=
 =?utf-8?B?T1A1dzgxYWR5ZDQyV2hVcTZoc3YzS1l2VE1Na21uT2d5SWZ1S0Q1cldvQzFh?=
 =?utf-8?B?SS9BSkZ0Q0VXeXJNc3FDY1lpb2plNitzdHVDQUpGZ2NCT2pxV3h4a0U4eHox?=
 =?utf-8?B?ejFhVG1oVnBRV2tCSFZ0OVllbmF6aGFETnZSV3l0QjV6SUprV0JQY3BXZGNE?=
 =?utf-8?B?amQyVXp3OWMzZFEvR0t1Sm5QVzF2SHVYZndhMVRsWXliWmR6VWx6UkhyRmhv?=
 =?utf-8?B?enFsQkljWUg5RjRvd1kyUE9UQXZ4ZzFsU1BiNHFMdDdhdTRaWkd5U3RmYnJX?=
 =?utf-8?B?aEowSG9XVjNrYVplQ2diOHIrMlRqWkpqUlo2VlRKWEdqRW5jYytmU05ZU3RD?=
 =?utf-8?B?M1RMUGRJaUhBMytvR3piN0dZTGxWWTl5cmdXaFFJTDExMjhNYi9pRlFCV0Nv?=
 =?utf-8?Q?HGLtzprIIuEkDECI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B98203ACCCF57949BD7B6122BDAA2B41@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d15f2f0-14cc-44ae-4c49-08da1902f55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 01:56:12.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+KQPUZ6PPX1RPKlNDHUp1oEwKYGX7r7gJjBk1UbKnKfXHtlP4ql6zFv/V8MsurgtXnXA1WgeaFyZaw5cOgF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMDcsIDIwMjIgYXQgMDk6Mzg6MjZQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi80LzcgMTk6MjksIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCi4uLg0KPiA+
ICtpbnQgX19nZXRfaHVnZV9wYWdlX2Zvcl9od3BvaXNvbih1bnNpZ25lZCBsb25nIHBmbiwgaW50
IGZsYWdzKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBm
bik7DQo+ID4gKwlzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNvbXBvdW5kX2hlYWQocGFnZSk7DQo+ID4g
KwlpbnQgcmV0ID0gMjsJLyogZmFsbGJhY2sgdG8gbm9ybWFsIHBhZ2UgaGFuZGxpbmcgKi8NCj4g
PiArCWJvb2wgY291bnRfaW5jcmVhc2VkID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJaWYgKCFQYWdl
SGVhZEh1Z2UoaGVhZCkpDQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJaWYgKGZsYWdz
ICYgTUZfQ09VTlRfSU5DUkVBU0VEKSB7DQo+ID4gKwkJcmV0ID0gMTsNCj4gPiArCQljb3VudF9p
bmNyZWFzZWQgPSB0cnVlOw0KPiA+ICsJfSBlbHNlIGlmIChIUGFnZUZyZWVkKGhlYWQpIHx8IEhQ
YWdlTWlncmF0YWJsZShoZWFkKSkgew0KPiA+ICsJCXJldCA9IGdldF9wYWdlX3VubGVzc196ZXJv
KGhlYWQpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCWNvdW50X2luY3JlYXNlZCA9IHRydWU7
DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXJldCA9IC1FQlVTWTsNCj4gPiArCQlnb3RvIG91dDsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoaHdwb2lzb25fZmlsdGVyKHBhZ2UpKSB7DQo+ID4g
KwkJcmV0ID0gLUVPUE5PVFNVUFA7DQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKwl9DQo+IA0KPiBO
b3cgaHdwb2lzb25fZmlsdGVyIGlzIGRvbmUgd2l0aG91dCBsb2NrX3BhZ2UgKyB1bmxvY2tfcGFn
ZS4gSXMgdGhpcyBvayBvcg0KPiBsb2NrX3BhZ2UgKyB1bmxvY2tfcGFnZSBwYWlyIGlzIGluZGVl
ZCByZXF1aXJlZD8NCg0KSG1tLCB3ZSBoYWQgYmV0dGVyIGNhbGwgaHdwb2lzb25fZmlsdGVyIGlu
IHBhZ2UgbG9jayBmb3IgaHVnZXBhZ2VzLg0KSSdsbCBtb3ZlIHRoaXMgdG9vLCB0aGFuayB5b3Uu
DQoNCj4gPiArDQo+ID4gKwlpZiAoVGVzdFNldFBhZ2VIV1BvaXNvbihoZWFkKSkgew0KPiA+ICsJ
CXJldCA9IC1FSFdQT0lTT047DQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKwl9DQo+IA0KPiBXaXRo
b3V0IHRoaXMgcGF0Y2gsIHBhZ2UgcmVmY250IGlzIG5vdCBkZWNyZW1lbnRlZCBpZiBNRl9DT1VO
VF9JTkNSRUFTRUQgaXMgc2V0IGluIGZsYWdzDQo+IHdoZW4gUGFnZUhXUG9pc29uIGlzIGFscmVh
ZHkgc2V0LiBTbyBJIHRoaW5rIHRoaXMgcGF0Y2ggYWxzbyBmaXhlcyB0aGF0IGlzc3VlLiBUaGFu
a3MhDQoNCkdvb2QgcG9pbnQsIEkgZXZlbiBkaWRuJ3Qgbm90aWNlIHRoYXQuIEFuZCB0aGUgaXNz
dWUgc3RpbGwgc2VlbXMgdG8gZXhpc3QNCmZvciBub3JtYWwgcGFnZSdzIGNhc2VzLiAgTWF5YmUg
ZW5jb3VudGVyaW5nICJhbHJlYWR5IGh3cG9pc29uZWQiIGNhc2UgZnJvbQ0KbWFkdmlzZV9pbmpl
Y3RfZXJyb3IoKSBpcyByYXJlIGJ1dCBjb3VsZCBoYXBwZW4gd2hlbiB0aGUgZmlyc3QgY2FsbCBm
YWlsZWQNCnRvIGNvbnRhaW4gdGhlIGVycm9yICh3aGljaCBpcyBzdGlsbCBhY2Nlc3NpYmxlIGZy
b20gdGhlIGNhbGxpbmcgcHJvY2VzcykuDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsN
Cj4gPiArb3V0Og0KPiA+ICsJaWYgKGNvdW50X2luY3JlYXNlZCkNCj4gPiArCQlwdXRfcGFnZSho
ZWFkKTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gKyNpZmRlZiBDT05G
SUdfSFVHRVRMQl9QQUdFDQo+ID4gKy8qDQo+ID4gKyAqIFRha2luZyByZWZjb3VudCBvZiBodWdl
dGxiIHBhZ2VzIG5lZWRzIGV4dHJhIGNhcmUgYWJvdXQgcmFjZSBjb25kaXRpb25zDQo+ID4gKyAq
IHdpdGggYmFzaWMgb3BlcmF0aW9ucyBsaWtlIGh1Z2VwYWdlIGFsbG9jYXRpb24vZnJlZS9kZW1v
dGlvbi4NCj4gPiArICogU28gYWxsIG5lY2Vzc2FyeSBwcmVjaGVja3MgZm9yIGh3cG9pc29uIChs
aWtlIHBpbm5pbmcsIHRlc3Rpbmcvc2V0dGluZw0KPiA+ICsgKiBQYWdlSFdQb2lzb24sIGFuZCBo
d3BvaXNvbl9maWx0ZXIpIGFyZSBkb25lIGluIHNpbmdsZSBodWdldGxiX2xvY2sgcmFuZ2UuDQo+
ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IHRyeV9tZW1vcnlfZmFpbHVyZV9odWdldGxiKHVuc2ln
bmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MsIGludCAqaHVnZXRsYikNCj4gPiAgew0KPiA+IC0Jc3Ry
dWN0IHBhZ2UgKnAgPSBwZm5fdG9fcGFnZShwZm4pOw0KPiA+IC0Jc3RydWN0IHBhZ2UgKmhlYWQg
PSBjb21wb3VuZF9oZWFkKHApOw0KPiA+ICAJaW50IHJlczsNCj4gPiArCXN0cnVjdCBwYWdlICpw
ID0gcGZuX3RvX3BhZ2UocGZuKTsNCj4gPiArCXN0cnVjdCBwYWdlICpoZWFkOw0KPiA+ICAJdW5z
aWduZWQgbG9uZyBwYWdlX2ZsYWdzOw0KPiA+ICsJYm9vbCByZXRyeSA9IHRydWU7DQo+ID4gIA0K
PiA+IC0JaWYgKFRlc3RTZXRQYWdlSFdQb2lzb24oaGVhZCkpIHsNCj4gPiAtCQlwcl9lcnIoIk1l
bW9yeSBmYWlsdXJlOiAlI2x4OiBhbHJlYWR5IGhhcmR3YXJlIHBvaXNvbmVkXG4iLA0KPiA+IC0J
CSAgICAgICBwZm4pOw0KPiA+IC0JCXJlcyA9IC1FSFdQT0lTT047DQo+ID4gLQkJaWYgKGZsYWdz
ICYgTUZfQUNUSU9OX1JFUVVJUkVEKQ0KPiA+ICsJKmh1Z2V0bGIgPSAxOw0KPiA+ICtyZXRyeToN
Cj4gPiArCXJlcyA9IGdldF9odWdlX3BhZ2VfZm9yX2h3cG9pc29uKHBmbiwgZmxhZ3MpOw0KPiA+
ICsJaWYgKHJlcyA9PSAyKSB7IC8qIGZhbGxiYWNrIHRvIG5vcm1hbCBwYWdlIGhhbmRsaW5nICov
DQo+ID4gKwkJKmh1Z2V0bGIgPSAwOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfSBlbHNlIGlm
IChyZXMgPT0gLUVPUE5PVFNVUFApIHsNCj4gPiArCQlyZXR1cm4gcmVzOw0KPiA+ICsJfSBlbHNl
IGlmIChyZXMgPT0gLUVIV1BPSVNPTikgew0KPiA+ICsJCXByX2VycigiTWVtb3J5IGZhaWx1cmU6
ICUjbHg6IGFscmVhZHkgaGFyZHdhcmUgcG9pc29uZWRcbiIsIHBmbik7DQo+ID4gKwkJaWYgKGZs
YWdzICYgTUZfQUNUSU9OX1JFUVVJUkVEKSB7DQo+ID4gKwkJCWhlYWQgPSBjb21wb3VuZF9oZWFk
KHApOw0KPiA+ICAJCQlyZXMgPSBraWxsX2FjY2Vzc2luZ19wcm9jZXNzKGN1cnJlbnQsIHBhZ2Vf
dG9fcGZuKGhlYWQpLCBmbGFncyk7DQo+ID4gKwkJfQ0KPiA+ICsJCXJldHVybiByZXM7DQo+ID4g
Kwl9IGVsc2UgaWYgKHJlcyA9PSAtRUJVU1kpIHsNCj4gPiArCQlpZiAocmV0cnkpIHsNCj4gPiAr
CQkJcmV0cnkgPSBmYWxzZTsNCj4gPiArCQkJZ290byByZXRyeTsNCj4gPiArCQl9DQo+ID4gKwkJ
YWN0aW9uX3Jlc3VsdChwZm4sIE1GX01TR19VTktOT1dOLCBNRl9JR05PUkVEKTsNCj4gPiAgCQly
ZXR1cm4gcmVzOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCW51bV9wb2lzb25lZF9wYWdlc19pbmMo
KTsNCj4gPiAgDQo+ID4gLQlpZiAoIShmbGFncyAmIE1GX0NPVU5UX0lOQ1JFQVNFRCkpIHsNCj4g
PiAtCQlyZXMgPSBnZXRfaHdwb2lzb25fcGFnZShwLCBmbGFncyk7DQo+ID4gLQkJaWYgKCFyZXMp
IHsNCj4gPiAtCQkJbG9ja19wYWdlKGhlYWQpOw0KPiA+IC0JCQlpZiAoaHdwb2lzb25fZmlsdGVy
KHApKSB7DQo+ID4gLQkJCQlpZiAoVGVzdENsZWFyUGFnZUhXUG9pc29uKGhlYWQpKQ0KPiA+IC0J
CQkJCW51bV9wb2lzb25lZF9wYWdlc19kZWMoKTsNCj4gPiAtCQkJCXVubG9ja19wYWdlKGhlYWQp
Ow0KPiA+IC0JCQkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+IC0JCQl9DQo+ID4gLQkJCXVubG9j
a19wYWdlKGhlYWQpOw0KPiA+IC0JCQlyZXMgPSBNRl9GQUlMRUQ7DQo+ID4gLQkJCWlmIChfX3Bh
Z2VfaGFuZGxlX3BvaXNvbihwKSkgew0KPiA+IC0JCQkJcGFnZV9yZWZfaW5jKHApOw0KPiA+IC0J
CQkJcmVzID0gTUZfUkVDT1ZFUkVEOw0KPiA+IC0JCQl9DQo+ID4gLQkJCWFjdGlvbl9yZXN1bHQo
cGZuLCBNRl9NU0dfRlJFRV9IVUdFLCByZXMpOw0KPiA+IC0JCQlyZXR1cm4gcmVzID09IE1GX1JF
Q09WRVJFRCA/IDAgOiAtRUJVU1k7DQo+ID4gLQkJfSBlbHNlIGlmIChyZXMgPCAwKSB7DQo+ID4g
LQkJCWFjdGlvbl9yZXN1bHQocGZuLCBNRl9NU0dfVU5LTk9XTiwgTUZfSUdOT1JFRCk7DQo+ID4g
LQkJCXJldHVybiAtRUJVU1k7DQo+ID4gKwkvKg0KPiA+ICsJICogSGFuZGxpbmcgZnJlZSBodWdl
cGFnZS4gIFRoZSBwb3NzaWJsZSByYWNlIHdpdGggaHVnZXBhZ2UgYWxsb2NhdGlvbg0KPiA+ICsJ
ICogb3IgZGVtb3Rpb24gY2FuIGJlIHByZXZlbnRlZCBieSBQYWdlSFdQb2lzb24gZmxhZy4NCj4g
PiArCSAqLw0KPiA+ICsJaWYgKHJlcyA9PSAwKSB7DQo+ID4gKwkJcmVzID0gTUZfRkFJTEVEOw0K
PiA+ICsJCWlmIChfX3BhZ2VfaGFuZGxlX3BvaXNvbihwKSkgew0KPiA+ICsJCQlwYWdlX3JlZl9p
bmMocCk7DQo+ID4gKwkJCXJlcyA9IE1GX1JFQ09WRVJFRDsNCj4gPiAgCQl9DQo+ID4gKwkJYWN0
aW9uX3Jlc3VsdChwZm4sIE1GX01TR19GUkVFX0hVR0UsIHJlcyk7DQo+ID4gKwkJcmV0dXJuIHJl
cyA9PSBNRl9SRUNPVkVSRUQgPyAwIDogLUVCVVNZOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWhl
YWQgPSBjb21wb3VuZF9oZWFkKHApOw0KPiA+ICAJbG9ja19wYWdlKGhlYWQpOw0KPiA+ICANCj4g
PiAgCS8qDQo+IA0KPiBJTUhPLCB0aGUgYmVsb3cgY29kZSBjb3VsZCBiZSByZW1vdmVkIG5vdyBh
cyB3ZSBmZXRjaCB0aGUgcmVmY250IHVuZGVyIHRoZSBodWdldGxiX2xvY2s6DQo+IA0KPiAJLyoN
Cj4gCSAqIFRoZSBwYWdlIGNvdWxkIGhhdmUgY2hhbmdlZCBjb21wb3VuZCBwYWdlcyBkdWUgdG8g
cmFjZSB3aW5kb3cuDQo+IAkgKiBJZiB0aGlzIGhhcHBlbnMganVzdCBiYWlsIG91dC4NCj4gCSAq
Lw0KPiAJaWYgKCFQYWdlSHVnZShwKSB8fCBjb21wb3VuZF9oZWFkKHApICE9IGhlYWQpIHsNCj4g
CQlhY3Rpb25fcmVzdWx0KHBmbiwgTUZfTVNHX0RJRkZFUkVOVF9QQUdFX1NJWkUsIE1GX0lHTk9S
RUQpOw0KPiAJCXJlcyA9IC1FQlVTWTsNCj4gCQlnb3RvIG91dDsNCj4gCX0NCj4gDQo+IEJ1dCB0
aGlzIG1pZ2h0IGJlIGFub3RoZXIgcGF0Y2guDQoNCkknbGwgZG8gdGhpcy4NCg0KVGhhbmsgeW91
IGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9ucywNCg0KLSBOYW95YSBIb3JpZ3VjaGk=
