Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF454D4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiFOW6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351806AbiFOW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:58:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2053.outbound.protection.outlook.com [40.107.113.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08F1EAD9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0yFQFRhvkTS4o9Udy7IXptubJDRqXumiDlC4YPVKKkhqJm+Xr/Gvtu/PmlHSWlx1dlCZRk8FfaFaZcWOVLad0eJDY37AaLNqVrLKwRerc44mqUAX4rgndANYpxwDSqE0otsAen4kc0dOMTzJHRjQ56MoDI0+HpMYt1CbD+Pfma85k3Etyl2jJs82iiozm3WuJgXd6xiAZMeaYAtSNky9+m4q+5FAs7dCJjhwu6X9EDRYP0OK/12ZZz4olDPHKJ0HoXeuS/3HlJc0vTGqs2e4ZZZ2h8xpKlaY05lJ2qRfaLvpF0I6lRbLRUre2ylFg3sQhHBq5rkqnyZacWBC+R6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baaNvhHHQshpeAt9peeBUuGiJL6aizFQb2y/GH/fG9s=;
 b=JQ0X55qlyh1zBX/FKvSvl7ZvBl7urnGj0txJcRj8eVpjJpTXXp+AENfPzClT1mf1pGmwUBkYNdItqX7UojN700HYtR3HK7Ugxk8gqC9+cBKFQQ7M9E8MAtQEQobJnpEMqyYVFoZTRwBo38u6BLIMjiwr9oiu2lL4fgvglDlwkBCCjjrtBOEkRjfdK1OThWrdpP4bJSPLy/5DYMV2EU+K99HB7TGnGv28+Vc21GK5jJPDIMv/aHbuNyeIWzrwGQUVrMepNTwq0ZSm20Mp++mBn+C1Pi/eqcWuxiuwzE4FliCQaWjF3Ak9PwiZrmSEIbNR4gWm9SEtB35DEh0bWglmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baaNvhHHQshpeAt9peeBUuGiJL6aizFQb2y/GH/fG9s=;
 b=Oe1pLmZAKzGM7LIFY9hx7PqutiSgJY0M5TalESat8PFqqwra23owWkCEtJYIP3GskBrXLniNKRpIA6YAfjZVKsJ/Z4znjMUtbA0zQ1vlU9p49p8wvNovs8dxQDy1aXB6FRg8/lCYwQS4+6fQXsXZn00Zl/s3REDfhHJL2i5Ri/4=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB2564.jpnprd01.prod.outlook.com (2603:1096:603:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 22:58:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::b00f:b11:37c6:29d0%4]) with mapi id 15.20.5332.023; Wed, 15 Jun 2022
 22:58:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     zhenwei pi <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Topic: [PATCH v6 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Thread-Index: AQHYgJuBamhWlkQfpkaKBNnobMwn9K1QRakAgACr9YCAACP0AA==
Date:   Wed, 15 Jun 2022 22:58:14 +0000
Message-ID: <20220615225814.GA1685347@hori.linux.bs1.fc.nec.co.jp>
References: <20220615093209.259374-1-pizhenwei@bytedance.com>
 <20220615093209.259374-2-pizhenwei@bytedance.com>
 <20220615103406.GA1669251@hori.linux.bs1.fc.nec.co.jp>
 <20220615134933.66f3ba7f3b169b936b2128de@linux-foundation.org>
In-Reply-To: <20220615134933.66f3ba7f3b169b936b2128de@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aab5b33e-c98b-434d-935c-08da4f2287be
x-ms-traffictypediagnostic: OSAPR01MB2564:EE_
x-microsoft-antispam-prvs: <OSAPR01MB2564FA4C8FC3E49A8C3E5E87E7AD9@OSAPR01MB2564.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtzLgVxA6NrRaGvIRhHjdFdHB7mDT0HJIr3cPv5M5Avtpex1MwEUSNm+yUTKAXmyEDLq63i78/vVG93Rf8sfFVBXvExWgBVjl3ikMF2vxKP+y6ZreZyT7MwZkSbG2l/tgxiabRJDmiGRrKD5/28nTAIO1YpTfz0oJ5OfSlOapOP2IRZxy+4Elt87uq1/9DxMtOCATCmJTsF6VBk91K3iSr14QhmVu0wMRMTgRFHNZEmAP56JPhFJ2gipDDDLmisPImjCaivqvsSt1404BE+qawYItEtbXl0LweYQ9AzagSJmlmbpikeSeeHMvL++bvDQqmJL0TZq0O3ToNOe/s3z+hYsL3SkTrcO7UIvL5GVxxIksQgDTpEeVIHz4+eTzvLuLVoDfWYtPIC+9IV/0zJbKyV96e2hbg5Bk1oG9ya9RjFN3xmA1iw1N/1r549Y3q5IkAbmdeBxl7JfFqTQMlYrOy3Vj9M0btTtjx3wTGDlMI024I706QpwsoAW0WUsC8G0hKkPf8OUPuqDDS+8cZplefmmlt6LN5aB6b1B1ojgnlAIQfG8TRpgNkJJXePjgRW6IHLXDgQRzUd12O2Nbr+caWpndM0JSv6Yw+J5iB/tFl/Ss4K4Z1jglWFesub+jf6y4cqF+QEIljruSUFMGqlZCniRjnDZO7cwfzTt6nTgeeRMP8uW1CeOiou2+AkFh+e1weDCR9GwiKBktJwGEu+v4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(33656002)(85182001)(38070700005)(6486002)(8676002)(8936002)(5660300002)(66946007)(76116006)(66556008)(66476007)(508600001)(2906002)(6916009)(316002)(54906003)(64756008)(66446008)(71200400001)(26005)(55236004)(9686003)(6506007)(1076003)(186003)(82960400001)(38100700002)(83380400001)(122000001)(86362001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cElCL2pMWVlqSUZuZnJDaG9ScTFFK0Z5Z2hORlV5ZGE1Ujl0RXlLZ1dtRVlC?=
 =?utf-8?B?Z2ZZNEFZQUFLdmo0RlVIZ2pRZlg4SUpVaUpUUWZTWTErWkp5Q1k5VEdvL2Y5?=
 =?utf-8?B?WWZhNlFzNnlPdXJHbXhHZWhSUkVtcGRBNXRZZjRUbzM1SnNWZHlINmZ2Tytl?=
 =?utf-8?B?bXkxNUFuMzRLQXdKcXc0TDkrS0U2RCtDTFd2QUErV0tVSitNQ3BSL05oUlZJ?=
 =?utf-8?B?bW9yN2NyZngrWkpjZTBKMHh2dGJEL1U0RVlGR3p1d3dNQlNURjRyUzZZdGRv?=
 =?utf-8?B?aGxVQy81cVZEQytGdlA3dmhKUk1SMWs5UHptczJtakx2cTYwazV3anZkWkl1?=
 =?utf-8?B?OW1ILzFDeTM0M1ptNDhMSEFFbjU4TUhGYnY1OWZ2aW1xZFVRQU1qU21Ydnlh?=
 =?utf-8?B?dG9EOTd5UHZjOE5YT0w1MTJscHNjTkJacDB1NzJTWkh2TmRDczg1MVpMcVB5?=
 =?utf-8?B?MTlDeTdhUU5xM282dVgwUWgrTGsxNzR5NTgrMFIzVjZFc2hyN3plenBaU0RV?=
 =?utf-8?B?MzYrdWJVemw1a3FPZzRVYlFqWGpGVmo5c2N5bGZSUlVLRVpzNlQyeDFEblZh?=
 =?utf-8?B?K0s3S1AzcTRCazZMeFBLNlRFcFM4NFZOdGlqd2ZqSDR2VTJMY0xDS2kvOXYr?=
 =?utf-8?B?NWNvWjFDMVQ0RHc1d3dmWXlsQkhoTXUvcUY4Zk40VmZQSzFSNFhIeHRTb1dX?=
 =?utf-8?B?ZVFOVk8yVEtZSjFlazBoa1B4bVdxdFIyYmtiZE9oSGxZK1cxM3VMd2M1aS9y?=
 =?utf-8?B?c2h0WS9LNHRFekNvY3VOZ2N2a0J4MFc1Nk9rSElWNHZkeHFlV2FtWDhKQThC?=
 =?utf-8?B?V09kTUQ5azVXem1uUnZxL3VyYVU1Y3FVOVA3YXJQeW9USnhWdjM5bzNZZlYw?=
 =?utf-8?B?RFRIQnkxTGZaQW9LemwzZzl1bzkxV3QwQ3c0emR0RngrSTlQc0REaVVuRi8x?=
 =?utf-8?B?QjlMK0d6aTRUVXZMeFU4RGFQQitrbDgzdWRBbVBCZ3Y0U2xCbDlERGJ2MzFL?=
 =?utf-8?B?cXpDOTk2ck9oVURlaG5uNjQ0SlpmaU5SSkdIUFhINFZ6TVNLRUdBd2V0QTJr?=
 =?utf-8?B?Qy9xL1VXL1Z3b3RGbmNVTXErVUwzRFE3YzZtSGE3a3JkM0hJV2M1cVdXcUZl?=
 =?utf-8?B?Vm1YTVBOVlk4UU15bURuYnA3WFVxWkFCOHBwdUdOb1Q2c3NhcUlmVzAxcXRJ?=
 =?utf-8?B?MSs4bmZCVUE3WFA5enBHWTQxV0lUcGtKSWtGanMvNko5SU9rOE9ZNzV4QkRD?=
 =?utf-8?B?MzcyWVlNM0VBdGdXNDRYTzlpVHRLODZNM1hWRVNnaHpDalZBVThLSHJ5Y3lz?=
 =?utf-8?B?SnFqZkFsUzRkd1pSVGVVRUVFOWtZNGc3a2o3QURhbFRjQXlYVDAxSmp1S09w?=
 =?utf-8?B?dm8wbDZIZXI0cEZGQ2JZS2crTXFYWmRCV0RENnVacm56cXFLZ0ZHbldrdERB?=
 =?utf-8?B?UGZ0RkxBeVpHTjFnTkVzbjl3Nnk3OG1sQVhRRnJPWjRZSGRjcFBhVTE0djk4?=
 =?utf-8?B?SkxMU2V4OVdYZGkxeXhSUDRhaVNyVEQ1OGVjWXdJaDVZcEUwRlZIdzZZR1Ez?=
 =?utf-8?B?MjM4ejM4U2hSZEZFbGUzTHV0akJPSEZ4OHJ5Nno3ZWNVSDFWQ3hsV2FRSU1D?=
 =?utf-8?B?Z2hsTEpNdlEzNnF5bEMvMUJtenRIWG13QTdXck9MT0g4am9RdXdvTWRwZkIr?=
 =?utf-8?B?dTBHUG1uV2paZWFSVXc1ZjVxaTc5Q1hOVXRzZ1VFTzJqNFVsTUk5T1c2M2RG?=
 =?utf-8?B?NFptV1R3T2drb2hma3ZiN1lmeE1abEVtTllqaHJYZm5adnhjcGI4N2ZzVWFr?=
 =?utf-8?B?SjlZaVl5QTFSczhXdkhFV2tPektQUGc0VEtlT2Z2TG9BTFRDU2c3QmRuYStT?=
 =?utf-8?B?amxqV2JGaVVqZ3pTdWwrREU2LzBydHFUUDc0UkRlbUZ4aGI3SzlHeFhlemlD?=
 =?utf-8?B?VzhtSkNSMk90U1h6a2R3RGJBK0JrL3RHelgwVUc5emNxYjR2UFF6T29BVksz?=
 =?utf-8?B?RmY1Ti82YmhHdEU0UDNFcndRM2NJaWp0cVF4eUlzTlZabUhLeTVSK3ZTeXly?=
 =?utf-8?B?dDNjZVVaMWpISWpRS296L1NVTWlYbEJJVkhJeEFzVXNTbTk5VTJXdWp6eTRh?=
 =?utf-8?B?OGh5bm82VXZXb29Xc3V3VG9vMWFpUHpIcTloQUdCUnA3T1psdEVYdkE2WWM1?=
 =?utf-8?B?Z1crYkxXVk9YNDVHM21hbE9PU3lBOUs3U2k1VDFaRzVSeFVOZTFtRG9nTS9U?=
 =?utf-8?B?YVJyZWhuNHdjeS9Rb1UvYjlzM2VHMXRIUW5FenFLQk9uMU5TbGlhS0N3bHFr?=
 =?utf-8?B?RE5RTlVFUm44dk9wTGczaWQyYmJ6dFRpOXY3bGdQaDJRcnRsRXVhZXpUTW5X?=
 =?utf-8?Q?3XSILDC3A95c3z4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB4E088E396674ABC77603BECEF4CC3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab5b33e-c98b-434d-935c-08da4f2287be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 22:58:15.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djnfM/UTGFUjh/epHEtBh2p/xjK6RhURw5p+DpebvT046nCBiYG9AOmeKtMQ6RDx4BUL3o0yQHvqYYhSqPAzEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMDE6NDk6MzNQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3
cm90ZToNCj4gT24gV2VkLCAxNSBKdW4gMjAyMiAxMDozNDowNiArMDAwMCBIT1JJR1VDSEkgTkFP
WUEo5aCA5Y+j44CA55u05LmfKSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAwNTozMjowOVBNICswODAwLCB6aGVud2VpIHBp
IHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBm
bikgaXMgZGVzaWduZWQgZm9yIHNvZnQNCj4gPiA+IHBvaXNvbihod3BvaXNvbi1pbmplY3QpIG9u
bHkuIFNpbmNlIDE3ZmFlMTI5NGFkOWQsIHRoZSBLUFRFIGdldHMNCj4gPiA+IGNsZWFyZWQgb24g
YSB4ODYgcGxhdGZvcm0gb25jZSBoYXJkd2FyZSBtZW1vcnkgY29ycnVwdHMuDQo+ID4gPiANCj4g
PiA+IFVucG9pc29uaW5nIGEgaGFyZHdhcmUgY29ycnVwdGVkIHBhZ2UgcHV0cyBwYWdlIGJhY2sg
YnVkZHkgb25seSwNCj4gPiA+IHRoZSBrZXJuZWwgaGFzIGEgY2hhbmNlIHRvIGFjY2VzcyB0aGUg
cGFnZSB3aXRoICpOT1QgUFJFU0VOVCogS1BURS4NCj4gPiA+IFRoaXMgbGVhZHMgQlVHIGR1cmlu
ZyBhY2Nlc3Npbmcgb24gdGhlIGNvcnJ1cHRlZCBLUFRFLg0KPiA+ID4gDQo+ID4gPiBTdWdnZXN0
ZWQgYnkgRGF2aWQmTmFveWEsIGRpc2FibGUgdW5wb2lzb24gbWVjaGFuaXNtIHdoZW4gYSByZWFs
IEhXIGVycm9yDQo+ID4gPiBoYXBwZW5zIHRvIGF2b2lkIEJVRyBsaWtlIHRoaXM6DQo+ID4gPiAN
Cj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4gPiANCj4gPiA+IEZpeGVzOiA4NDdjZTQwMWRmMzkyICgi
SFdQT0lTT046IEFkZCB1bnBvaXNvbmluZyBzdXBwb3J0IikNCj4gPiA+IEZpeGVzOiAxN2ZhZTEy
OTRhZDlkICgieDg2L3ttY2UsbW19OiBVbm1hcCB0aGUgZW50aXJlIHBhZ2UgaWYgdGhlIHdob2xl
IHBhZ2UgaXMgYWZmZWN0ZWQgYW5kIHBvaXNvbmVkIikNCj4gPiA+IENjOiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+ID4gQ2M6IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPiA+ID4gQ2M6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JA
c3VzZS5kZT4NCj4gPiA+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiA+ID4gQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRo
YXQuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogemhlbndlaSBwaSA8cGl6aGVud2VpQGJ5dGVk
YW5jZS5jb20+DQo+ID4gDQo+ID4gVGhhbmsgeW91IHZlcnkgbXVjaC4NCj4gPiANCj4gPiBBY2tl
ZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IEkg
YWRkZWQgY2M6c3RhYmxlIHRvIHRoaXMuICBCdXQgdGhlIGR1YWwgRml4ZXM6IGFyZSBnb2luZyB0
byBjb25mdXNlDQo+IHBlb3BsZSByZWdhcmRpbmcgd2hpY2gga2VybmVsIHZlcnNpb25zIG5lZWQg
dGhlIGZpeC4gIENhbiB3ZSBiZSBtb3JlDQo+IHNwZWNpZmljPw0KDQpPSy4gIFRoaXMgYnVnIHdh
cyB2aXNpYmxlIHNpbmNlIDE3ZmFlMTI5NGFkOWQgKG1lcmdlZCBpbiB2NS44IHRpbWUgcGVyaW9k
KSwNCnNvIG1hcmtpbmcgInY1LjgrIiBvbiAiQ2M6IHN0YWJsZSIgbGluZSB3b3VsZCBiZSBoZWxw
ZnVsLg0KDQotIE5hb3lhIEhvcmlndWNoaQ==
