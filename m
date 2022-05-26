Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A1534A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiEZGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbiEZGIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:08:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2083.outbound.protection.outlook.com [40.107.114.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD4BA9BC
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZv02CeTA5LM7t4KvYEBpn/t3ePDmc2cbPsDBv+AmeKRoTL0rfkYr7ikRld2qwm5ghXRWN6wKY9glknzp3Dc48X6Tdo0C6bsrwoaHaAAfmRdL5RvDWAyqx/1HE/AOvrPDuxHjgGCsqEYjC4e98BTh3BpyE1lxLExP9jk1a1qhRkOsmHD6ppq+CFJ1w1ggy7lJM/MKPctoQrJFmLgUJm6Sx0KXzF21YmE5dB4P87Af3mTqmGh+vUbAJFOVi0MGff7bl76rjNtzI6H8JLIGi7eF9iwFUWC1uBzt9lsgeD6Y0i8GgeWRXctWgCGTTFBpRFnLSokyti+tzNsMOwHr2o7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNPbArI5sYtJCx8Yx4tEY8VUdcHzrkLpAwXln34HZdo=;
 b=A/v9J8qWQJJLu+YQocDKgUb2HgrMrJhxIhwV7CFkQm2nAwKzmBV/VIzZT7PTXtuzsmT+mt7tIh+0xcLxiZ8S6fdB1BmF5k0p9xaf0j7fs9z2ftz6jxvSBoTDrmadib1HrkBwNMDK5D5LT656lM0HAuxI2I2VWAHSsdANTnL7jp3LrA6QbMnSxYxm5t4n0BdYiPVWae24h9CRAjIhSowo3VmLV1bv7ErcRYVRvu9RI9kdd9QPpRo1q3QHieJ0R9MNrsMf3P1Sm8S00BBOqprM7txZAUpozg+MTkOFGkeHiYzSqh3LwhDnR1ZvGaWqh1sGa79uLyJ0xxSui+NkHJWYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNPbArI5sYtJCx8Yx4tEY8VUdcHzrkLpAwXln34HZdo=;
 b=hqvy6NqKy5TwaKwAu3v2uiXP1wZK5KawamxFf45Gtz7lTs1LhbRsiwfb1PO2cA86s2YiTWU7RotBgKS5hsdtDn5oX77q79QPxspiqgp0xdwTVld/PX7L+TFEvq6vGQ4HOFPaG757QgydTgbCxzt3zG/mi9QKtuUyjSEifqbxecs=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSBPR01MB2888.jpnprd01.prod.outlook.com (2603:1096:604:1f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 26 May
 2022 06:08:01 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 06:08:01 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Topic: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Index: AQHYa38Hnv+yD7ocokSyVBX8dxzd660vCemAgAAjywCAAYk1AA==
Date:   Thu, 26 May 2022 06:08:01 +0000
Message-ID: <20220526060800.GA861236@hori.linux.bs1.fc.nec.co.jp>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220525043233.GA808704@hori.linux.bs1.fc.nec.co.jp>
 <dd9ac56b-c50a-6c6f-339b-50c347f601b4@huawei.com>
In-Reply-To: <dd9ac56b-c50a-6c6f-339b-50c347f601b4@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 097e6e83-4b18-4d1a-5c46-08da3ede16de
x-ms-traffictypediagnostic: OSBPR01MB2888:EE_
x-microsoft-antispam-prvs: <OSBPR01MB28888BCD623FBECC4CDBB0CEE7D99@OSBPR01MB2888.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmQ7yaI+nsbpC7Ip/q7Ixh9wYAeVieGn8qpMLTCwMSQFkae8PlH3yJokn6Ux5c36AM+1KAwwLUtq892/Fg9zEu9wdm9/QIiQ3Ia+XrW9koQOu1JrcrLyCK4y1nOwOQZjMtFlhmSfTSzpVC4JhJAYQfSPBtPCiqAXVah52NBK1WcS6csTL4OM1xikEvymYqf+eCNQwCW5In6nXXd9jtpVXzhnHoZl1pTFxqDYvQ5X3UKyHxTwy4FybJVWoUVmM3iYXO79kWHFUn4v0sZCU9vfpHt7UYuh/AuSfPk0oFC5dsoqq18y512U4OjmQnZaLRvyUZ3Jw3OA2yMz/CrPEk4moj5w8BLcsawUDxUuNc5yD4hV6Uuv8tmcVr7LwqvAqTVT6wH8xPuiBJ2yFDuAVgeatsHvm5oCj1qTVvkCgb1DaibAo10CmFTz8dSEBAHffCu83cBb4W69N4fakFBUW0NmQzwll7Yc7wZcmuogOsOMXvosTM6JFwBPgweeOtfsO7CwedE7Z7z63eID/12yIpSBhvJroboey0dJlumOOr5sGjfCdsayuHMrjqG8JES17fjAPWrOe7f1N+9CJrldRmMOfNeC9GMdDubOWUT+olrNesPrsDtmhY0hQMSNc2b566VSdRleXnoKw0l94efJrgyw1Q8zXUq6rMJMljeyg8/SoSmzd4fSP36lH/4w5CVhW1xumXgmAanwI7c3xfv9yFQ4LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(54906003)(8676002)(6916009)(2906002)(1076003)(316002)(186003)(86362001)(38100700002)(76116006)(66946007)(85182001)(66476007)(66556008)(66446008)(64756008)(6506007)(33656002)(82960400001)(8936002)(5660300002)(7416002)(38070700005)(122000001)(71200400001)(6512007)(9686003)(26005)(53546011)(508600001)(6486002)(55236004)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhEeUh6NXM0Qk1ZUkptNHZCZUVicHBINkZXK3Ura0VDZDlJQmFUeDl1U3Vt?=
 =?utf-8?B?d01jM2ZBVmJKR2VycHV0YkRuTDBKOEcyL0pNZFJlYTl5Uk1Edyt3a3JwZXRU?=
 =?utf-8?B?NmtxalhhQ3cxTGxNdERjWk4xaG5MVnBFOUZ5Q1paV2tNcGh1Z2VxeUZ0RGxH?=
 =?utf-8?B?QTFzVnovQWZ1VFBmUDZzeDBEbzk3VlROSGRjeGZmeU14Z3lod0JZRGFGY0h1?=
 =?utf-8?B?S3lQUmVrZmd6NU00TW9TOG0vQlh6WmdXRmY3VFV5a0RjeEtGY3o4a2pqUXlG?=
 =?utf-8?B?U2NvT1dHaDV4bkhSTnNxZzF6Q3p0Ky8zMVE5Ri83dkxzR3JuZFptU2FOM01V?=
 =?utf-8?B?OGVJZ3FPVjRxYkhvU1VpdnNhbkU3NXhrVnhJVTE3SVAyYTg5ZkszU29UZUFw?=
 =?utf-8?B?a2lSQm1ERndBZ2JMMnNNQ25LYytic3dOemxhcnI4ZnJlUGlpeUUrY3cxZytQ?=
 =?utf-8?B?WndSTDZYRzlkbnBpWlMrR1kreVhKU0ZtaWR5L2JxNHphSDRYRzl1bWVjQmNE?=
 =?utf-8?B?MDBFMDVvMXQzNUpQSk1hY2ZFWXlOOGlPK3o5NVlLY3QyRDgyZmE4VkM4NC9r?=
 =?utf-8?B?RjlpaW16clJBNmJROXp5RVZzNXRvcWVoa0pTMjZBQjQ4OHdWT2wyQTY4aWRJ?=
 =?utf-8?B?MnVOdFpIcld6cmdUZ0hqYnorZ2ZZcG9YT3pscjhJTXhCcDlrVUxVRnFNdHVp?=
 =?utf-8?B?T3M2QkVCZ0l2eC8vNnZMUEI5bWZ0ZjQ4dmVrM3pvOGwzVlcxNmZKWFNsWHp2?=
 =?utf-8?B?KzlacFQ1OWwvN0FLVzN1Y3A5d0FGRUQycUJqajRxa3ZjY2g5TkVDejBCWk9S?=
 =?utf-8?B?cVYwUEYvSjBnTUtDc0FNeXNycGpGbVhVWWZmci9rN1JDamF1NVVvL0RwSnFU?=
 =?utf-8?B?NnBXS0U5dk8wZjdQVkt4dG9mMTh1aXh6NXB3T2hIOWtLSXNJV1pEQXJ1SnpB?=
 =?utf-8?B?RGRkODBYaHB3TjVNSzhIVHQza0o2azlCY2hxQVlxZXRjdHJKdWppUDZTeGhz?=
 =?utf-8?B?b1J6eW4rQmk0dko3bDYvSmloUUpoNW16OE1Fbk1qU2VwNlZOcnV4RUk4TzNt?=
 =?utf-8?B?TkFyODlMNXZqVVVwcFVNNm5taW5zSE9pRnZEMVNqcElNYkxwd1ZZWmttVE0r?=
 =?utf-8?B?SkhxRzNENUpNcDdodGFIeHJEaFBWcmZlOGhWL1R0MjhqekhHbmRsbWFBb0t5?=
 =?utf-8?B?c1p4NllJUEFGY3pQWHJ4QlptNDRmcTRFNmMvbS8vV3I5M1BYY2t5aGNndWtl?=
 =?utf-8?B?NmR2d0ZVeEs0SUM4RE1sUG9qaHJQUDg1d3JkYWxsZGdUQ0c5a2UrNys0VjJJ?=
 =?utf-8?B?RzFpcVhBanhTMWFFa3VCV0VlelhucmExRHRtZjdYZHRhdDN1V0xuQ1RDSDdI?=
 =?utf-8?B?RmNyMndmekNQaFpacUw0ejlZS0lLQlFTd0RqbjNHWlJRdElRczZPK3RCMit3?=
 =?utf-8?B?NitEOFhEY1JVelc1ZHpPaXVTMk9wSTNCSG9OVXhWZ0h5aXVwWVdGQzEyVC8z?=
 =?utf-8?B?VVZ0SlM0YzBPdUIvRU9VUHZVMEtDY2lITWkzNEZMNUdaTE9iOWVKTmNnTUVV?=
 =?utf-8?B?QjBMS0lDQWgwdWduZFMxY0kvU1J3WUlkck0zajZoem9xRTcxWCtEa2FHYTda?=
 =?utf-8?B?bjZmNDRTVjkxQ1A1VEE1Z2hKWElYajJYWXB3dWpBQTMzQ1lmbTNnTEwxNUdh?=
 =?utf-8?B?TkI0RTJNWXpTVjkxbitGbldYVGtVeGsxY2taakRRYWFZc2lyS0lzbEdCWGFY?=
 =?utf-8?B?ZVplRHQ3WlR5UER4aCtTWWlDMDFsWkRJcU1XVGhERzFjV1Y5cGp2aWt4WGJ5?=
 =?utf-8?B?dW85a1BEQ2d5cVN3Tnc2ZGJpSllvYzdDSTFsVjlKNHR6Y25LMEtVcTd2MUZS?=
 =?utf-8?B?MXF3cEJIZlhkTVVyYlAycG9talZrMXVmeURVK0NVU1NYdUxCOGRkOW96a3c5?=
 =?utf-8?B?MkhudVlHTlNzVldPY0RmWGxMTm01dzZ5azNySUFZajFQZ3A1UDBxT3RJcEF6?=
 =?utf-8?B?VlY0T3A3NUgvb1JCemdxWFNKRGFIblVyNzBXZXRmTldsbm5vV0hJS1dwTzlX?=
 =?utf-8?B?YlVKY29JUDg0Mngvb1k3QlNwa3N5WmhSL0N5c0RObEhmNTl6bllTOHkrRnRZ?=
 =?utf-8?B?UWRoNXVHU2IwMlhia3pWNEh0WmlrMEVHcm93SFhMTGFMb3FFWTVud0N6QkpT?=
 =?utf-8?B?Q2xOK3cyNXJoeGlQTjRTbUJJZmZ4RU5aWldtaUJHMm9hUlBrT0wxeXBkTGNT?=
 =?utf-8?B?UEF3NzA3L2xDVHFxL2NSb05ZdGVpQ2FCMnl4NTFNMmUyMlhsdnNWamh0Wkk4?=
 =?utf-8?B?L3hSZ3JKa1pFcmMwS2lWVURMMWZsWE5tWFN3c1Vzc0UrcEhDZHgxVWc1VFM5?=
 =?utf-8?Q?WCVw94q7aIodfRr0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A9A359C0CA1B4BB8EA6D84AD089B6A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097e6e83-4b18-4d1a-5c46-08da3ede16de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 06:08:01.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCOPUNx2PXBbqpNyaS8CIOqGZCfHWgj3BiUsULcSClhX1U03fGwYrjOYoJYKqgYz79tjJh19PJpby5MTRNUGhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMjUsIDIwMjIgYXQgMDI6NDA6NDBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi81LzI1IDEyOjMyLCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gT24gVGh1LCBNYXkgMTksIDIwMjIgYXQgMDg6NTA6MjlQTSArMDgwMCwgTWlh
b2hlIExpbiB3cm90ZToNCj4gPj4gV2hlbiBzd2FwIGluIHNobWVtIGVycm9yIGF0IHN3YXBvZmYg
dGltZSwgdGhlcmUgd291bGQgYmUgYSBpbmZpbml0ZSBsb29wDQo+ID4+IGluIHRoZSB3aGlsZSBs
b29wIGluIHNobWVtX3VudXNlX2lub2RlKCkuIEl0J3MgYmVjYXVzZSBzd2FwaW4gZXJyb3IgaXMN
Cj4gPj4gZGVsaWJlcmF0ZWx5IGlnbm9yZWQgbm93IGFuZCB0aHVzIGluZm8tPnN3YXBwZWQgd2ls
bCBuZXZlciByZWFjaCAwLiBTbw0KPiA+PiB3ZSBjYW4ndCBlc2NhcGUgdGhlIGxvb3AgaW4gc2ht
ZW1fdW51c2UoKS4NCj4gPj4NCj4gPj4gSW4gb3JkZXIgdG8gZml4IHRoZSBpc3N1ZSwgc3dhcGlu
X2Vycm9yIGVudHJ5IGlzIHN0b3JlZCBpbiB0aGUgbWFwcGluZw0KPiA+PiB3aGVuIHN3YXBpbiBl
cnJvciBvY2N1cnMuIFNvIHRoZSBzd2FwY2FjaGUgcGFnZSBjYW4gYmUgZnJlZWQgYW5kIHRoZQ0K
PiA+PiB1c2VyIHdvbid0IGVuZCB1cCB3aXRoIGEgcGVybWFuZW50bHkgbW91bnRlZCBzd2FwIGJl
Y2F1c2UgYSBzZWN0b3IgaXMNCj4gPj4gYmFkLiBJZiB0aGUgcGFnZSBpcyBhY2Nlc3NlZCBsYXRl
ciwgdGhlIHVzZXIgcHJvY2VzcyB3aWxsIGJlIGtpbGxlZA0KPiA+PiBzbyB0aGF0IGNvcnJ1cHRl
ZCBkYXRhIGlzIG5ldmVyIGNvbnN1bWVkLiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgdGhlDQo+ID4+
IHBhZ2UgaXMgbmV2ZXIgYWNjZXNzZWQsIHRoZSB1c2VyIHdvbid0IGV2ZW4gbm90aWNlIGl0Lg0K
PiA+Pg0KPiA+PiBSZXBvcnRlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlA
bmVjLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdl
aS5jb20+DQo+ID4+IC0tLQ0KPiA+IA0KPiA+IC4uLg0KPiA+PiBAQCAtMTY3Miw2ICsxNjc2LDM2
IEBAIHN0YXRpYyBpbnQgc2htZW1fcmVwbGFjZV9wYWdlKHN0cnVjdCBwYWdlICoqcGFnZXAsIGdm
cF90IGdmcCwNCj4gPj4gIAlyZXR1cm4gZXJyb3I7DQo+ID4+ICB9DQo+ID4+ICANCj4gPj4gK3N0
YXRpYyB2b2lkIHNobWVtX3NldF9mb2xpb19zd2FwaW5fZXJyb3Ioc3RydWN0IGlub2RlICppbm9k
ZSwgcGdvZmZfdCBpbmRleCwNCj4gPj4gKwkJCQkJIHN0cnVjdCBmb2xpbyAqZm9saW8sIHN3cF9l
bnRyeV90IHN3YXApDQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBp
bmcgPSBpbm9kZS0+aV9tYXBwaW5nOw0KPiA+PiArCXN0cnVjdCBzaG1lbV9pbm9kZV9pbmZvICpp
bmZvID0gU0hNRU1fSShpbm9kZSk7DQo+ID4+ICsJc3dwX2VudHJ5X3Qgc3dhcGluX2Vycm9yOw0K
PiA+PiArCXZvaWQgKm9sZDsNCj4gPj4gKw0KPiA+PiArCXN3YXBpbl9lcnJvciA9IG1ha2Vfc3dh
cGluX2Vycm9yX2VudHJ5KCZmb2xpby0+cGFnZSk7DQo+ID4+ICsJb2xkID0geGFfY21weGNoZ19p
cnEoJm1hcHBpbmctPmlfcGFnZXMsIGluZGV4LA0KPiA+PiArCQkJICAgICBzd3BfdG9fcmFkaXhf
ZW50cnkoc3dhcCksDQo+ID4+ICsJCQkgICAgIHN3cF90b19yYWRpeF9lbnRyeShzd2FwaW5fZXJy
b3IpLCAwKTsNCj4gPj4gKwlpZiAob2xkICE9IHN3cF90b19yYWRpeF9lbnRyeShzd2FwKSkNCj4g
Pj4gKwkJcmV0dXJuOw0KPiA+PiArDQo+ID4+ICsJZm9saW9fd2FpdF93cml0ZWJhY2soZm9saW8p
Ow0KPiA+PiArCWRlbGV0ZV9mcm9tX3N3YXBfY2FjaGUoJmZvbGlvLT5wYWdlKTsNCj4gPj4gKwlz
cGluX2xvY2tfaXJxKCZpbmZvLT5sb2NrKTsNCj4gPj4gKwkvKg0KPiA+PiArCSAqIERvbid0IHRy
ZWF0IHN3YXBpbiBlcnJvciBmb2xpbyBhcyBhbGxvY2VkLiBPdGhlcndpc2UgaW5vZGUtPmlfYmxv
Y2tzIHdvbid0DQo+ID4+ICsJICogYmUgMCB3aGVuIGlub2RlIGlzIHJlbGVhc2VkIGFuZCB0aHVz
IHRyaWdnZXIgV0FSTl9PTihpbm9kZS0+aV9ibG9ja3MpIGluDQo+ID4+ICsJICogc2htZW1fZXZp
Y3RfaW5vZGUuDQo+ID4+ICsJICovDQo+ID4+ICsJaW5mby0+YWxsb2NlZC0tOw0KPiA+PiArCWlu
Zm8tPnN3YXBwZWQtLTsNCj4gPiANCj4gPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggZm9saW8geWV0
IGFuZCBtaWdodCBtaXNzIHNvbWUgYmFzaWMgdGhpbmcsDQo+ID4gYnV0IGlzIGl0IE9LIHRvIGRl
Y3JlbWVudCBieSBvbmUgaW5zdGVhZCBvZiBmb2xpb19ucl9wYWdlcygpPw0KPiANCj4gaW5mby0+
c3dhcHBlZCBpcyBhbHNvIGRlY3JlbWVudGVkIGJ5IG9uZSBpbiBzaG1lbV9zd2FwaW5fZm9saW8o
KS4gSW4gZmFjdCwgbm8gaHVnZSBwYWdlDQo+IHN3YXBpbiBpcyBzdXBwb3J0ZWQgeWV0ICh0aGlz
IGlzIGFsc28gdHJ1ZSBmb3Igbm9uLXNobWVtIGNhc2UpLiBTbyBJIHRoaW5rIGluZm8tPnN3YXBw
ZWQtLQ0KPiBzaG91bGQgYmUgT0suIE9yIGFtIEkgbWlzcyBzb21ldGhpbmc/DQoNCk9LLCB0aGFu
a3MgZm9yIGNsYXJpZmljYXRpb24uDQoNClJldmlld2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5h
b3lhLmhvcmlndWNoaUBuZWMuY29tPg==
