Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8F4F8E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiDHFKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiDHFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:10:01 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2040.outbound.protection.outlook.com [40.107.113.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC035C8BFE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML/5YQIRs4ewmvXW6uFYBqh0H9EyfojNq2yAcuX6+GPYGycEos5Mg8/xITn35+xGRsRL1Qb2gtGPvH0hWsWXHwa590E2446qwjMgNTt4qnEEXETHSA4dWkYZP2hP+/PeOFjBYMEghM2snyV4JGtN7pSeRElKMLzVxDAIHGvRwzkaVn9dwS9LmaYTwKneQD0QSlxe5SpJ5gLJNYQCB2xlVP4Kb8sE90Eq4r210cgogKF06R/d2LiDlV7cZXCVnCQ3dX/VAccKSg6qiDkZr7a6EsJAVLX3NMGN0vil9lbaDCQ6rfomeEJSGIfv/ED1ob42C7TjgdftvAJbmVurCbj8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnlPhW4bE17ZgZSEFcNxl5Et5OTWM+f46JmMNDiXZ9c=;
 b=dN7TrIK/vk6HaYF+W1XG1Y3DGImIwAIZy56f48KIsCUJTHa4OvKGVcf1H4/J2VBHvnx+iBr+vwHES3Zbt7qPTSsmSVJnPTQnXbZsdlCye2DtK5McADhRcuLes6Q2bpPMnDu8iuTx7gM3La+U4vk35Lk9ahsMyn2vTnaVJ/SPdQNB5iLKcy/uweN0MRVVmlTncPb0T39ZaFDG414mhqZoF4o22DAsyafDWLdynArT5cv9xP4h+x+/+UdgzHpLzeIY58lv+kCvp8ffEOYIIRQrb7ShXd4eyukeHdL6DeMFQS7EDyaD9TDXk1vwtGk1N4mLoKBmQ4w+1UAou4gNMPmwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnlPhW4bE17ZgZSEFcNxl5Et5OTWM+f46JmMNDiXZ9c=;
 b=gfaOAihoBx1DMijfAcLvLxBGaeA3MBQGsm2J1eMB2plF+VcfR9HU4SsmVHAPpVgAiFZUQ1ZMkkOeh45XQK2+aXKKxhgpidjSkFL9Wpj0QLaimfpERLIf+fP+N9dnDLXIA7Zp/j7ldxr7LHSLwFxmI5xKJI0fvSPUxqfzxcls7nY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB4134.jpnprd01.prod.outlook.com (2603:1096:604:4c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 05:07:54 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9149:6fc9:1b62:1232%6]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 05:07:54 +0000
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
Thread-Index: AQHYSnNMXhTcbXkCGUqWD5dp3QQR46zkdJ0AgADOHwCAABqFgIAAGwyA
Date:   Fri, 8 Apr 2022 05:07:54 +0000
Message-ID: <20220408050753.GA3069452@hori.linux.bs1.fc.nec.co.jp>
References: <20220407112929.1344748-1-naoya.horiguchi@linux.dev>
 <4b5ad6c3-99a0-b04f-21ad-8ade46984c76@huawei.com>
 <20220408015610.GA3061012@hori.linux.bs1.fc.nec.co.jp>
 <e928b6a2-2bb4-82dc-1508-5b293ecb7539@huawei.com>
In-Reply-To: <e928b6a2-2bb4-82dc-1508-5b293ecb7539@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 929cb2f7-ea03-499f-17c8-08da191dbd19
x-ms-traffictypediagnostic: OSBPR01MB4134:EE_
x-microsoft-antispam-prvs: <OSBPR01MB413416D2490CEE867C1A1DCFE7E99@OSBPR01MB4134.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKIY0sGC/5CNaofbKfg7pIOzYB6KX14V5+6QJ6rmSuhDCyRtr3qpyDyqMhocpSZkSeLIV8nBFb4yOhpokZbRFXpokHkCCRGjvh0bU4dCyDCQuPzivIy/fAkMiUEl0BrQdjUkDX6YLImrqooj46bk3BB57LJhS7yooM7xrO3xSKiDY0ZJk86sjiTEgcIdd16P76e4A4Heq+cPjsDc+t8ySBLAAEp8klJkWakul7IauG7AL9NRTjQhqBrWVBYTDsJdMMiQpvwfqRU2cjBVFTPZ6c2JxEQqnjyLL/2WsSSEDs0UhiJr8kN6ymMYmTsTZSSUFDirWfKoGqkQMSNizJbtaeJL2QZ3tJNzGyQ9CInpKvWWMffMyj+VG5/T9UNREkmZqInsPiGV2NBW3x72saPC/eZ3F8rXp/eq330go9TSsbMQFnW0OxFuTUeW4C3lcP/4K2tS9poqGwOGhkcfqVt0FQwY5R7ERLUU0rxTe9iRRQMIGRsDf5eOxuyj2bxmisy9wbGeEULJvEJm3bOq80HoNC2mGRN2Wp3m9EzeMIT8iCu5+1Oj7twDmxX4U/rsVeqifLXiuO+5Lxxhl2IQv/cYdtqWIh21wXQtGxxk09CARQhdFYKTD4+/4Il8BqAZW0QzFL/lrapYgyZXlNnn07+H8mZX8If0P+H3d5f27iHgpi9aOIEpiseetnbMq4Bco5uXGkJDxeaS5HU2OgymeEVMpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38070700005)(8936002)(66476007)(82960400001)(9686003)(83380400001)(6916009)(54906003)(38100700002)(76116006)(4744005)(508600001)(8676002)(71200400001)(122000001)(86362001)(66556008)(66446008)(64756008)(66946007)(4326008)(55236004)(6486002)(186003)(2906002)(316002)(6506007)(5660300002)(26005)(1076003)(6512007)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzNBM0hsakhxOTE1QnhycXpIUnlodHVUTVkxSmZCM2Vxd2N2cHBkRVJWendV?=
 =?utf-8?B?VXI3NUliRFIvVnB2eTV3T0loQUhqMVp5MjdPaU9XZHd6bURvMWJ6eUlsUEFn?=
 =?utf-8?B?UFdrOURjMEdXSng5VWZEY2tCZHkzVm5rQ2dLdnJLOFB1c3BkRFlWWVZtQk0w?=
 =?utf-8?B?TDZyWjJ1bmtzMktOcXEyd0IvWWg0Q1E3Z3pUeXpENkhZYzBmZWphRWtkenl6?=
 =?utf-8?B?OTRZRGJTaWNhQ2oyRG9JWUIydEcrT2lrbStEd01SM1BDN1BVVWxONkFpWm5C?=
 =?utf-8?B?M3Qzc0owalFlTGhJU2ZGaFk2UmFFZVpjWXBTQjV0Q251TExKRG9aUm1HYW9l?=
 =?utf-8?B?ZjNGYlhSV0Z3aHg3eDlmTmJtWWt6SjFtdUwrNEFqMVVxT0V4LzEzc09DRy8x?=
 =?utf-8?B?TThCNnl2bUY3MzA2SjZ4WFB5bjBIMFI3MW5aeXJxNklPUm44RTB3ejNLMXpu?=
 =?utf-8?B?U3BRNDdEbkFzcytvWnhoUU5lM3RkUFBUU3NzejA3ZHl3MXE1L0FkVEYrak1L?=
 =?utf-8?B?UVdvU3M5cTRzNmdSS2NmZW92WHNJVG5WZ2lZM0l6N0VCZkova25ZOU1zYWpu?=
 =?utf-8?B?VFRZMXBHUlV1cUtDd0RWSjN6cStDVk5rWjJQTEdSWW15RjlNWEhOMTQ2Q2Zm?=
 =?utf-8?B?dTNUK2pJRmdNUnlWbVFBTkFhNndCeHljUU90eTA2WmU0SjNxMGRhUHpkK0dD?=
 =?utf-8?B?dTZqUDhPL0MzS3dqSnQvRGVKd2UzWWJLa0YrcjJqaWdMZmRCWmtuZS9KbHhL?=
 =?utf-8?B?WVBhQlZUZHJZSVliejgzUW9UT2x4Y2pYVmZSb1U2S3RqRzZGZ2lRbDN5M1pB?=
 =?utf-8?B?dkhERGZnaVRURVBTMnZxVm4yUGZoUUR6dlpKV0xsdmRtaFJSc2dxeGhPSVA1?=
 =?utf-8?B?OWM4bCt6bkRkamFTcVJYTUU3amhya1NHL1dma24xSzJUUjU0WkY1d3NPSWlN?=
 =?utf-8?B?TndkdktnRVN1S2JCKzJZQTVjcDdJNlBrTkJMd1RTdjIzS3FReDlHWUk5Mngw?=
 =?utf-8?B?bHAwQThpT002MFlPbjQvdUdKdm1nRUxUWlprU1NTd1ZDTzNRcjhTKzhLSWxG?=
 =?utf-8?B?V1F4NUxYYnIyWXVNcjNnMnQxS3ZPMFVIRmZqMEJGYzF3RXRjTWd6eWtKdlE2?=
 =?utf-8?B?WE4zSVM5dzE0dTVSVFB2ZGdibUN3VmNicTdGazNHZXZIMnoxb2VxZGRoSWdO?=
 =?utf-8?B?dkNXbHhUcVZ0cXpORmt3V3JsNktLL2JNVHQvUDhQOWJiYkVmb2hjM2V4OXBG?=
 =?utf-8?B?RTFxdHRhNndhcmRxc3FUTkxVUzh1ZW85aGNYYm0zVUdZM0dFSXcxWUJwQVZC?=
 =?utf-8?B?cDlxdGF1REhHcEh2MXVDbmZqNmoxeHNUbjNyRGE5cmRpVFJ0aHFiKzNmQThm?=
 =?utf-8?B?SGtaMFRJVUZZUlRmUUlBUDlPS0hTZVVtVUw5RVYremxJd3JhY245bFArdzFD?=
 =?utf-8?B?TTZlR3UvS1p0R1QxbVFmUnVBOXFnMWI4MUVhc3Fha25xNzAwbnJiMHc3SkRu?=
 =?utf-8?B?bWVnUkN1RGQxVzBJZ2RKa0orVy9QMXI5UUQ0SHJsTWJVaWdGelcwdUp6VUtC?=
 =?utf-8?B?Z2EyaXo5ZE1qRnFaaUxYSVpMdWZFdXZPQWxwUnM1Ynd5aFRrNkR0d1hmZ05I?=
 =?utf-8?B?WFZhaG9rS2ZTdzFnNnp0eDNKM3k1bFEyTFpDWTlqUGIxSElwSStMMEtsbTRX?=
 =?utf-8?B?NGJhR1BWT2lGNGNtWFVLMTdWRmwzeHpMTWFzNEhHOHlicGY5aFhqS213Q2JR?=
 =?utf-8?B?MDFWTWVmeHRaeDU0dWx0QTdkU2dPcGgxaTFKRWNYWm9kbU5FOTBXTjFqanNh?=
 =?utf-8?B?SFhvZFRJclA0NHBkMHBhbFdTL0J6cFM3ZS9PSWM3OGpqbk94UTRWdUdRczVp?=
 =?utf-8?B?cDVOa0kwdW9nNHQxczRFVXhlYmlzaGJHa0ROZEhpU3NLU3REU00wMVRaeCsv?=
 =?utf-8?B?YjRYU0h4ZmM1WEx0RWd5ZEJia1dxMzV0VHlCbFZHZ0c0R3E3UCtEeGNMMnF4?=
 =?utf-8?B?YU1IS1FvVHE2b2RsTnJmUkRNKzMzNFVPYVkzK2dUSHRPRTFsWkVaZXFnbERX?=
 =?utf-8?B?SkRMeUZmSTc2Y0l0TFV4eERkbDJRaFN3TUhjZTF0ZWVyK1Vyd3kxV200bDBs?=
 =?utf-8?B?WTJxNlllZUJ0bWJ2SjJ4Vks3SUtMMUpJaUE2Z0hKaHFiTTc5OXNucUozdUtD?=
 =?utf-8?B?aXFIU1R3ODZ5cTI5UU1aT1lZbkVZdGFsRXFVdUx4aGthdVYvdFhod1F0ekEy?=
 =?utf-8?B?b0g5MWlwTExEYXNBVVNoRCtVd3I5MWtCTTlGSlpzWW9jV0lBditwcFZOQ21G?=
 =?utf-8?B?QjZJV1hXaTN1S2xOdW9pay9NMVgrR0lPaVlkWVVRL3RYNDA0UkUxQ2ZFbXpU?=
 =?utf-8?Q?P517GLVI3Pf+U8YI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134C2A01AAD3BD429BD69B88BCC8BE3C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929cb2f7-ea03-499f-17c8-08da191dbd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 05:07:54.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWyj9lewWSKXEM2IJIulpAcqYieKBfevf/IqfWI1fGL+GHIhRyZVeo0XfzJEkoAqicVv/T18rlMHAbpsfbZVmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+IFdpdGhvdXQgdGhpcyBwYXRjaCwgcGFnZSByZWZjbnQgaXMgbm90IGRlY3JlbWVudGVk
IGlmIE1GX0NPVU5UX0lOQ1JFQVNFRCBpcyBzZXQgaW4gZmxhZ3MNCj4gPj4gd2hlbiBQYWdlSFdQ
b2lzb24gaXMgYWxyZWFkeSBzZXQuIFNvIEkgdGhpbmsgdGhpcyBwYXRjaCBhbHNvIGZpeGVzIHRo
YXQgaXNzdWUuIFRoYW5rcyENCj4gPiANCj4gPiBHb29kIHBvaW50LCBJIGV2ZW4gZGlkbid0IG5v
dGljZSB0aGF0LiBBbmQgdGhlIGlzc3VlIHN0aWxsIHNlZW1zIHRvIGV4aXN0DQo+ID4gZm9yIG5v
cm1hbCBwYWdlJ3MgY2FzZXMuICBNYXliZSBlbmNvdW50ZXJpbmcgImFscmVhZHkgaHdwb2lzb25l
ZCIgY2FzZSBmcm9tDQo+ID4gbWFkdmlzZV9pbmplY3RfZXJyb3IoKSBpcyByYXJlIGJ1dCBjb3Vs
ZCBoYXBwZW4gd2hlbiB0aGUgZmlyc3QgY2FsbCBmYWlsZWQNCj4gPiB0byBjb250YWluIHRoZSBl
cnJvciAod2hpY2ggaXMgc3RpbGwgYWNjZXNzaWJsZSBmcm9tIHRoZSBjYWxsaW5nIHByb2Nlc3Mp
Lg0KPiANCj4gT2gsIEkgbWlzc2VkIG5vcm1hbCBwYWdlJ3MgaXNzdWUuIDopIFdpbGwgeW91IGZp
eCB0aGlzIGlzc3VlIGtpbmRseSBvciBhbSBJIHN1cHBvc2VkDQo+IHRvIGZpeCBpdD8NCg0KSSds
bCB0cnkgaXQgdG9vLCA7KQ0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGkNCg0K
