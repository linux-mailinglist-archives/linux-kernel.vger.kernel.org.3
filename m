Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA048E043
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAMW3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:29:52 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:56720 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237543AbiAMW3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:29:51 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DLOiTf013714;
        Thu, 13 Jan 2022 17:29:45 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2054.outbound.protection.outlook.com [104.47.61.54])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dj2j2gsth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 17:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs3EKMOu+fv9IN9G5/baNuMmLxFqDw1Vtv5vv7TI8k7XqvggbTxq8/65v1grthR5L997CvfflRSoE4xuk6pU8lqR3Zce4FPsaaGt69pmcTlyj+/8em5EZhtzsgZfPvhcfO47WRTwZqxXGKiyiwo6uEJzTAisu1BVEAoJgZjN4zSi5SUixU5DupBULiI1PMjBG9hpkADSL0N2tmMMh6GkYuFIfmL4kFoiPd4SFhGNjO0H7IBqBB+WT9hG631m0SwRH8y01RD3stY8J71Zk0iB2tDr+O+qn2KIt5KBccM0QvhxxodFnJ92ejDQcW+TzTul/LY+Qz2DLJbi6O2eBkNbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG4RjOh9IPxcngzifos01wolQfyNoffKSL4Vdbz+whA=;
 b=IEQKxL77KC1Yazqf/UKyfaGbGOZLxPAaqLWDE+euGORYIXjbJEzPU5+GQSYoEsZxitIVxUHwJ+/nmyDh289qPRLko8KIIm9KHKjpzZnnjB8CuwnybO54iMOLSH6X1NMf9++3PtgbHl7jqTJZS+tS3X5wNsu5jyk3YMWiHT1TgtwMat/iSJw+XExR0F2+2Z24SgzQPtp2w2/guZYQ2Le9JjbwxX+K7cuwF8o5ySQkJOx83NU1qp/hbuT0Qkv8fLTFxC4cYLjC/n6zTYKd4ob8NSMpUDZH9kIExX5qN+mZ38yCrcxOrlntsI8+a0XoKQ23sloj15mNI2pYWJSJ0dQelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG4RjOh9IPxcngzifos01wolQfyNoffKSL4Vdbz+whA=;
 b=dh2BUwTdv5P5T1FdK/KfPzuffNO6OuUQdqQwWaFCGFZPXw/yRWkpSJ1gI3DNDKL28/gNV92hD+FJw907k2KPH0zxPhVShQZDgNR+6+VE91p1Ch04+akZMDeZKossYsvEX7ku8mxwqq8TR7DtLH3mPYBN7Ysu3alXuCpwhUrTPSA=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR01MB4593.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 22:29:41 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 22:29:41 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "dev_public@wujek.eu" <dev_public@wujek.eu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: si5341: fix reported clk_rate when output divider is
 2
Thread-Topic: [PATCH] clk: si5341: fix reported clk_rate when output divider
 is 2
Thread-Index: AQHYCMPJU/oLPOr4NU+Vf4USoaiCyKxhiJMA
Date:   Thu, 13 Jan 2022 22:29:41 +0000
Message-ID: <d36fbe1176fd6182bd65c9a995fbf4614a112597.camel@calian.com>
References: <20211203141125.2447520-1-dev_public@wujek.eu>
         <20220113212312.19D85C36AE3@smtp.kernel.org>
In-Reply-To: <20220113212312.19D85C36AE3@smtp.kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9367febf-1543-4e09-b0dd-08d9d6e43105
x-ms-traffictypediagnostic: YQXPR01MB4593:EE_
x-microsoft-antispam-prvs: <YQXPR01MB4593B5C881ECABA5F0A0C106EC539@YQXPR01MB4593.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7UhXpogMwUDe+stvPuXtU1SGFa0yQIp+3OJ+qIpScy1qxRcLH/OrgejtFjPnqXVX9ReEByjRj7QNVJ2aB1PwRkAcDxnEO9l0txNOEZT8tkxj8UUWUegwkgZiMmQsZa/1LBX6rPEraq3OXKEM78hZ9BknoukMhjRvmWjng8D9UFY7rQiJgjIKm4wy1Qw/pxwCfTpCDqPALO89IuxW8Vc28xCxtyYafMcNdDsZ2l+ayqjzqNkS6QOkaGBkogUbIq4QvymMc0oHpk05GdYwSOhhAOLso1RmgTmE1T5w3yfS5L+2UL6EZMwfwoet0e1Q6OVLIogoG12Uuh6f479Wm0bXxuOHGQ8vjaxkTdsXLr3xUANFdlt0qhEB7udrROErm1GeuImuhJzfZJ5/dzQvC3HoqzOsqjthTRzO3cNDdxeR0rGTPCQADPlSwbX/42SO1mtves54vHUtviH4TI+slfJRF9fP4Fk4PWOP9hvmkkiJfwru46U2tLmovpPGZeitYSUVr/RSYtlbs9awV48AJ5hroy6yL6MitC1DVDv3aHoKImUB6yITBDFFss4QZRTvr13conA4QE3a9wu739YZjANXWsCWqliCoRWV4xBh992W1zrZGpYdBMzXQkiaid32jqqEiWF6ben1SXmaZ1R4aHt9wfOvlqD8TmWNEzFzdUNfL8Lxtuz+7f3E3lDkEXFqGggpKMFNgRgWPjpXAteDZMrJS3VeE+kcOX+LPylU+ZHh+Vpuu+8YchHiWd7jViRsYjkHKkRtSnf/ewafJGLS+ypfaS9MHwDcSghDZnc7N075QkdGdj25VwnMbobaNMmdfVQUQzS5LybznGDXf1hxECwb8WAuTP1+OrRwuz82p9/8LI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38100700002)(66476007)(66446008)(86362001)(64756008)(36756003)(8676002)(66556008)(44832011)(6486002)(186003)(2616005)(54906003)(15974865002)(4326008)(38070700005)(110136005)(122000001)(316002)(71200400001)(5660300002)(66946007)(91956017)(76116006)(6506007)(6512007)(83380400001)(2906002)(26005)(508600001)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGNSK1VkMEduUE8rRm5NLzMrMVZmeHp2WHp4TU10a1dySmMzZVVqWXpHdmJh?=
 =?utf-8?B?MWxUMGExUHNxT2hsbnd6ZXAxUUo5U09zYUxmWEhQUW1JNFJkY1E4ck5VYlJ0?=
 =?utf-8?B?R21CTThpUFF6cDRVN2FVV2pIMkpYbUZHaVJZV01XMUwrN2ttOUV3aVJOdk1k?=
 =?utf-8?B?YkJsbGZzNzN4VSs1blNuOGRacStQRjRZbEd6eCt2enFtS216WTBFTFVXOEF5?=
 =?utf-8?B?dStpYUtkc1lnWkYrcUdHZDlNVWRsVkR5bzAwYjV6ZlhxL2gwZVYvRTdYZkFW?=
 =?utf-8?B?QUtaNzhaaUtTajNCaGdzOFdNTjNTV3FSK3l1ZkRLVVdUZmExRFR5YmRaaFFs?=
 =?utf-8?B?K2JFWEs5ZzMwckJHZEk2dzNxN2F1dWs1dGJmM2NCb0gvN3p2ZGJFcm9oY3g1?=
 =?utf-8?B?ekIrTFFRWkRqaGwxWldUcHpGbVM0Vy9DeHNxNGNLd3RnSU5CREc3dEZFVElj?=
 =?utf-8?B?OVdIVkxqWmVIV1NlanBxVmY1MElheE04TEJEWDBDU3M4ZGkwdS9GZ3JrVkNH?=
 =?utf-8?B?YU5taXBWZkFZY0Q1UGQ3OS83STZMWFlJV1V6ODdXL2Y2MUkrMWZBUEs2WTB5?=
 =?utf-8?B?KzFiaWlRdTNjTXJXTFJVWFBYZUlOUkFFaGhSQy9hWkdUcVczTGZxN2ZjdFQr?=
 =?utf-8?B?SUh6YVk4elhKd1NISUZKTWtHV0hpL3c0L2xLVVdIZkM3WHNoT1pWL3NOQ2RK?=
 =?utf-8?B?SkdOTkw2dmhNTHJteExVWGRNQlJrSEt5ZktZRnhVWEZ2TE5qRDZNOHkzVVRB?=
 =?utf-8?B?V3IzSiswbjZqVXFpditjenhIT2ZJd2tPZ3UrcVdFQjFxUzdZQ1NuTFZFYnNq?=
 =?utf-8?B?YWVzampWSHNWTUlSSkJiUXVjQWxpNW0vQVFNQTFqOHg2L2FsemhqU2pTckVt?=
 =?utf-8?B?S05ORkJrdzRKaDQ2WFNsWnNYdVhxRFRTSmpxem8rVlJ2Sk5KTE9rUkQvUHhv?=
 =?utf-8?B?VUpSK2RtV1dEbmswRFVzTlNKWko3blkwNUl4dkZLc1BLcUliQk9oZXN1VXdz?=
 =?utf-8?B?anl0djZXQTd3TW5EUzFiSmZ3Uk54ZUJHZDd0azhZYXlmZDF1OThsSVNRUSsv?=
 =?utf-8?B?YmIyRitQODFRaDVoYS9MaEJQQ29DTWN6M09BTWJrYTlVNHltRnRsRVJsU1hS?=
 =?utf-8?B?M2MvMmlTVFFoYnVYY08xeURxSDBGOWNrTEZpNlhPMlNkZmlOYXdSeTBKSW4z?=
 =?utf-8?B?SWRuSGZCRTZXRFpqbUJIdmtTdXN5ekJ0U09kODZmRzNpQnJYNmxQbmZONk9i?=
 =?utf-8?B?SXZudlZ4OWR2NDZ2YTFteHNkWUd5RjRxaldNRkNlSmpHZE04dnNPOURXNnVv?=
 =?utf-8?B?anJ0a3d1S3pQTlN5MVNyNzZDZzhhR1cvQmw4eFhITjN2NWF1aHpuUjRUTHVS?=
 =?utf-8?B?Y1FEWW15THQwWHhKcDc5bGJjQmNYRFNFT3ZTSFJnR1hmZHlsQmJ3UmkrOHpQ?=
 =?utf-8?B?cnAydWxZSmdjanhmQWxFcHQ2S0xGRlVnaW1qK0dPM3UwdGcxcjNkc1RTMFk0?=
 =?utf-8?B?cjYzcUxQZXh0ZThaWEZkMFlRdnpqVWxqZ01GaDhOQzdIb2JRV0FKdy9DdXoy?=
 =?utf-8?B?Zno1ZGR5THBkKzEzTzNkTG5kZ0NqUTVtSVgxcmUwNzk5blNyVVFFekVkcnRo?=
 =?utf-8?B?cXF1a0hENEdwYTZZNitKelROaElmbEt2Q2ZxYVd6S0hrZFArakt0YTUrYzJk?=
 =?utf-8?B?ZlBuT3ZuZkdURFpXSVR6NHpKeUV0NXduMXBFOEVOeGxGS2VTV0FleDZqSVE5?=
 =?utf-8?B?QUN0dHBHL0FRc0N6R3pRaWU1VGEvTjVIZkNESDZCdUtxaUtySVVicnEya3ds?=
 =?utf-8?B?THYycm1UUE05b3g4THQxUVNtSFVNQld5QTRlZ00zeVl5ZkJ1dkpocFI5bXhF?=
 =?utf-8?B?WTFsdnFjQWtqaUo2QUxEeGZ6SmdZOXdPZ3krMEJSMWhqZEJDdElPM2ordHly?=
 =?utf-8?B?QXByZUZCQjVhZ0w4U0hvYlQzQy85VU1Cb1RzeHZOSDBhU3pwYnovTlVRMTM3?=
 =?utf-8?B?M1pOYkdVd1JvdE80NkorQUFFY1BXWUJHblhXTnFtakwwVG1taDhORjhsNHlD?=
 =?utf-8?B?K25XNjgyNVJETXNZTTYyRzN1dEFCRzJDYnVJd0xNbmtzRDJaQTA4Y055Y1Ay?=
 =?utf-8?B?VVRqNW5xSlh3WmtTbGhpZWVDMFI4dnFJRnE1OGRwM09RaW5POHE5NUVyeW95?=
 =?utf-8?B?WnhLdnF0SDFqc05VVjlCS3UzQ0FNeU14aDhkMnNFUjEzVC9zYWU2bWs3N2Jx?=
 =?utf-8?Q?EjAc4MPAbz/u7MPvfYzksWv4eHrnCDp2w1XOocySQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EC58ACAE4DB44DA5C2DF55E8BF9BB4@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9367febf-1543-4e09-b0dd-08d9d6e43105
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 22:29:41.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JJ+1Ux1k13L0qmoj9JaFvTRFCM4ZAocVbpqDgSMo+LPtFKbLcsFrMHNhKpLiceYWxiawJy1m9AFz59AZ5ip/J669QuXKkKKnjkRNcHgWs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB4593
X-Proofpoint-GUID: XVV5hveQhDpLVxvVMZiDnReOtUhphlkH
X-Proofpoint-ORIG-GUID: XVV5hveQhDpLVxvVMZiDnReOtUhphlkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTEzIGF0IDEzOjIzIC0wODAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
ICtSb2JlcnQNCj4gDQo+IFBsZWFzZSByZXZpZXcNCj4gDQo+IFF1b3RpbmcgQWRhbSBXdWplayAo
MjAyMS0xMi0wMyAwNjoxMjowNykNCj4gPiBTSTUzNDFfT1VUX0NGR19SRElWX0ZPUkNFMiBzaGFs
bCBiZSBjaGVja2VkIGZpcnN0IHRvIGRpc3Rpbmd1aXNoIHdoZXRoZXINCj4gPiBhIGRpdmlkZXIg
Zm9yIGEgZ2l2ZW4gb3V0cHV0IGlzIHNldCB0byAyIChTSTUzNDFfT1VUX0NGR19SRElWX0ZPUkNF
Mg0KPiA+IGlzIHNldCkgb3IgdGhlIG91dHB1dCBpcyBkaXNhYmxlZCAoU0k1MzQxX09VVF9DRkdf
UkRJVl9GT1JDRTIgbm90IHNldCwNCj4gPiBTSTUzNDFfT1VUX1JfUkVHIGlzIHNldCAwKS4NCj4g
PiBCZWZvcmUgdGhlIGNoYW5nZSwgZGl2aWRlciBzZXQgdG8gMiAoU0k1MzQxX09VVF9SX1JFRyBz
ZXQgdG8gMCkgd2FzDQo+ID4gaW50ZXJwcmV0ZWQgYXMgb3V0cHV0IGlzIGRpc2FibGVkLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0gV3VqZWsgPGRldl9wdWJsaWNAd3VqZWsuZXU+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1zaTUzNDEuYyB8IDE2ICsrKysrKysrKy0tLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXNpNTM0MS5jIGIvZHJpdmVy
cy9jbGsvY2xrLXNpNTM0MS5jDQo+ID4gaW5kZXggYjc2NDFhYmU2NzQ3Li4xNWIxYzkwY2FmZTUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLXNpNTM0MS5jDQo+ID4gKysrIGIvZHJp
dmVycy9jbGsvY2xrLXNpNTM0MS5jDQo+ID4gQEAgLTc5OCw2ICs3OTgsMTUgQEAgc3RhdGljIHVu
c2lnbmVkIGxvbmcNCj4gPiBzaTUzNDFfb3V0cHV0X2Nsa19yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xr
X2h3ICpodywNCj4gPiAgICAgICAgIHUzMiByX2RpdmlkZXI7DQo+ID4gICAgICAgICB1OCByWzNd
Ow0KPiA+IA0KPiA+ICsgICAgICAgZXJyID0gcmVnbWFwX3JlYWQob3V0cHV0LT5kYXRhLT5yZWdt
YXAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgU0k1MzQxX09VVF9DT05GSUcob3V0cHV0
KSwgJnZhbCk7DQo+ID4gKyAgICAgICBpZiAoZXJyIDwgMCkNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKyAgICAgICAvKiBJZiBTSTUzNDFfT1VUX0NGR19SRElW
X0ZPUkNFMiBpcyBzZXQsIHJfZGl2aWRlciBpcyAyICovDQo+ID4gKyAgICAgICBpZiAodmFsICYg
U0k1MzQxX09VVF9DRkdfUkRJVl9GT1JDRTIpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBw
YXJlbnRfcmF0ZSAvIDI7DQo+ID4gKw0KPiA+ICAgICAgICAgZXJyID0gcmVnbWFwX2J1bGtfcmVh
ZChvdXRwdXQtPmRhdGEtPnJlZ21hcCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBTSTUz
NDFfT1VUX1JfUkVHKG91dHB1dCksIHIsIDMpOw0KPiA+ICAgICAgICAgaWYgKGVyciA8IDApDQo+
ID4gQEAgLTgxNCwxMyArODIzLDYgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcNCj4gPiBzaTUzNDFf
b3V0cHV0X2Nsa19yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywNCj4gPiAgICAgICAgIHJf
ZGl2aWRlciArPSAxOw0KPiA+ICAgICAgICAgcl9kaXZpZGVyIDw8PSAxOw0KPiA+IA0KPiA+IC0g
ICAgICAgZXJyID0gcmVnbWFwX3JlYWQob3V0cHV0LT5kYXRhLT5yZWdtYXAsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgU0k1MzQxX09VVF9DT05GSUcob3V0cHV0KSwgJnZhbCk7DQo+ID4g
LSAgICAgICBpZiAoZXJyIDwgMCkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4g
PiAtDQo+ID4gLSAgICAgICBpZiAodmFsICYgU0k1MzQxX09VVF9DRkdfUkRJVl9GT1JDRTIpDQo+
ID4gLSAgICAgICAgICAgICAgIHJfZGl2aWRlciA9IDI7DQo+ID4gDQo+ID4gICAgICAgICByZXR1
cm4gcGFyZW50X3JhdGUgLyByX2RpdmlkZXI7DQo+ID4gIH0NCg0KTG9va3MgcmVhc29uYWJsZSB0
byBtZS4gSSBndWVzcyB0aGlzIGJ1ZyBkb2Vzbid0IGFmZmVjdCByZWdpc3RlciBzZXR0aW5ncyB0
aGF0DQp3ZXJlIHByZXZpb3VzbHkgYXBwbGllZCBieSB0aGlzIGRyaXZlciwgYXMgaXQgYWx3YXlz
IHNldHMgdGhlIFJESVYgdG8gMSB3aGVuDQpzZXR0aW5nIHRoZSBGT1JDRTIgZmxhZywgYnV0IGlm
IHRoZSBjaGlwIGhhcyBwb3dlci11cCBOVk0gY29uZmlndXJhdGlvbg0KZ2VuZXJhdGVkIGJ5IENs
b2NrQnVpbGRlciBldGMuIHRoZW4gdGhpcyBwcm9ibGVtIGNvdWxkIHNob3cgdXAuDQoNClJldmll
d2VkLWJ5OiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCg0KLS0g
DQpSb2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERlc2lnbmVyLCBDYWxpYW4gQWR2YW5j
ZWQgVGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
