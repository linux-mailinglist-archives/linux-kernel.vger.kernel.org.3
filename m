Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FC4C8C09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiCAMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiCAMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:54:43 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7356C11;
        Tue,  1 Mar 2022 04:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfZb1RVhJctEwNM2iZCa6fFo4tRoGx3AklgLv4IM3nGZWsE4uH2TTWnhVUk2/ZiSguwKRv3+vV3A2k4MjV6+T+gmjoeiGKpCNwO1sJ3aawCJDYQQRPahzkuLB8gXKcMnH8fA5KnzBKDeNHCwotLofZboFyShnxXgn+YaJFtdZduiGU0GcNNz/gPgw0PSksPl8AA6J2kU6XIIGJzs/UOte3YgacWwoIBU+BkFTaaZq4A97T1m3YfWLR46BcztvpXGCmoFPHgipEfGw4auLmtr4xD0ZwFtjL0p7TCXm4NyGtlFbrRjWyvaSDVey3Z4/gOIETRl5gUyj8M/y8g6PlUfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVP4y9LVAk9s3OZdQQdAnpbcGViT5d5D5l2EZxXqZe4=;
 b=Hmron4lkNrG+szG4Tm9O4707xyJrxCjnHi0pneIdt+sjtzjeoCG2lNGV8uYm/7w3KJDhgxaQTLUIfKVHAgboj1Hbe/H9y3U2m/1dYG81pKBGBcftm3bWgCy1Lr5WEZnCqYZJMuget0n+2Db1xrr45ju8x27mDrBuVUJdyUNuj5tvHeCzdOkELspvKgQYw5wc46CC5NI10d7MHMuDbIBA+RPE2XTAk3RqsGnm/qZVpsChXMW4HUrKZOZ3KFE0/jsouUgXosgxjC8NKY/hqo+xgfZV/ili293GQOxB4ik726ZogxQjDfLeC8G2WfAIVfV9O52ypgGLdJAhALG5HwLA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PR1P264MB4165.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:254::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Tue, 1 Mar 2022 12:53:58 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 12:53:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Topic: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Index: AQHYLLYaFbn8bOSg7kWQHVbhv1kp1KypFp+AgAAJIICAAAN6gIABWi6A
Date:   Tue, 1 Mar 2022 12:53:58 +0000
Message-ID: <fa51ac07-9cba-a8b5-89ed-c51a8a12d452@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
In-Reply-To: <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9051afd-1794-4326-6d33-08d9fb828d4a
x-ms-traffictypediagnostic: PR1P264MB4165:EE_
x-microsoft-antispam-prvs: <PR1P264MB4165F786AFFF89BFD9BD6199ED029@PR1P264MB4165.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BaqKnAn5/SIsagREmoeEDxfE/CsEKk83vEcLqI9ZuZYKbEINdhI/9jqoG0UVWgl/9DRm68heMpyGvHNuvA1gtRDeb6fcGCaxnq/i3mNIgPLMDwSawKH7gCWr4OMwEHuCuXWTTOfcLixWXxj2TzxRw9pvjYZb5gFcsnyPmZsBmRntap/FYVDy8eB4gEAXOOlujOKDFN3RhhT18mE8EUsw2c49pXzB/iTRUdLMzeD/GtDblPf1UcUrHdWCXEk0qk7SGqLSI4Hq0PXcdFWcRfyjRkOsxVoG2r+agasd6eHne2pQ+0BpMmPJAXS6sC7fd/VcIUy62GPI/bkF3jKjVbj5aOy2lt7nH/g36dljksTx/ZM5uo1Me+wct/kGxhCyDBL/L//uLuQHmGbI3JD5COb21rYQQDQQ47k1ZaBo9oUHxQQa5DJdoaa12jyvpBIcIXxH6kaiKBfzZ9lF8hZuUP3W5xmA52t5saf3C88J8Ydg4qWsos4+7HrP3fibAP7LswF+kh4T1d0BDD1Ficl5aQwhBeLPzg3PqfR1ATxauqmwlkTy+2INeig1MM0yqjNH5Um370uhG76d2vAeR0Yu1iJxXBtrK1k09f2ZHsInxsB+pYW15sTR/Al35XeCOAIv8JkMuxxCib7zd+9flOw90V/ethp+fDJAMeayX9n+WdU82h3nhvMWRWDu8VwFsZGb0eVj8CNrd+uD1ki2SSurjqotfTgEYCwwjeMk+4094u62h0poQGR/ve9zC5vysITM5gNS5MlFkTxhi8vL5SrtzX9bXTG92k8MYiG5DDkmqoQzh4/jgVubNwC4mXE2MpepwZEFFZH3B4PjA448ZX4F7t/4H5qiIS+66NZTR8A83LtsvWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(186003)(26005)(122000001)(2616005)(508600001)(38100700002)(44832011)(8936002)(5660300002)(83380400001)(66574015)(966005)(54906003)(6486002)(86362001)(31686004)(6512007)(6506007)(76116006)(91956017)(66476007)(36756003)(316002)(66446008)(64756008)(71200400001)(4326008)(8676002)(66556008)(2906002)(31696002)(66946007)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXE5Z3l3eFA5MCs0azFQR1p2ckh6YmQ1cjM5Sm9RNDdVTDVENmN6a1QxdFIv?=
 =?utf-8?B?ZTNXQkZCZENqUTBwUngzNUVReXN2LzV6MWpOTHR5djgydStXV2NZRk9wR2d1?=
 =?utf-8?B?S0JOemkvVTRhbnJiRG5SWDNOTHk5dHpBd3VUSE9iU09Jb2RUTUNOaE1IVUoy?=
 =?utf-8?B?UFV4Nk1oMW1YbHBjaEQ0b01vUVMyYzc3SjJLSkxDM0F0NEdhUlNDUHpsdENm?=
 =?utf-8?B?cER1enRValBwaE5KeXRvZlVOSzB5am5kVDQrajRWMHVSV3dHSnVoQ0lndXBD?=
 =?utf-8?B?TjFoNVE1ZVhGdFVIZEEwWXlZV0k5clVPQ3lmNGQ3S2ZGQWlEcjRDRWNUZ1NP?=
 =?utf-8?B?WjV1ZVdzTmhMcElzNmlVWVc4N1R2MjN1MkJUbVhINUxwbmdEVVV4WnVqNDBz?=
 =?utf-8?B?dk93cUpZTDZrMlZKK1VXd0ZBc0VpVUw3K01TRkJFL3RRTW9BWUh2bEFVa3lu?=
 =?utf-8?B?bzY4Rmh5Q2ljbnRQM05DS1MwUERWRFo0SEpzakhkNVN6V3k0ekphVFlVSzdr?=
 =?utf-8?B?RDVhUndiUDdnZERmajdYVlJZdmhPc1dvRllEdWFRNlpQTGlaS0srQ1F6ZXdu?=
 =?utf-8?B?YVg2elZtYlFVV0U2Q3VBMk5hYmVpTDVPRlhpUzduL1hVckJBejZvRUZzY0ZC?=
 =?utf-8?B?Qm92dTVyNW9QOEN3VGxEUjFGK0RCZG5SVmlDTTVsdS8ybVlvRUFtc20xT0ZG?=
 =?utf-8?B?RUgxZ3FCb3BOSmt4dGtTUWo4Nkx3aEJrRGJ1VWtEcHdkSDBMTWRaRWNHeDlR?=
 =?utf-8?B?b0pOY1RNRlB1di9yRGlXaU8yRkg3aWRsR3NRQS90bVJ4WVJIQVFyWml0NlEr?=
 =?utf-8?B?cStSSks0OStmUmFsNXFZaHVUTmwrbDVOeG5adXNtMElGaVd4NXo0OXhXdjQz?=
 =?utf-8?B?MzFoY05USDB0WW9CSWgzQWdiVHdoSGxZamRGQ3lVaHl5aHdPcldJQk55VDR1?=
 =?utf-8?B?cERnYzR3ZWkwcWhka0lzOFVEd01IblUycjRRMDkyekN0VFRtdTNSQStucVJT?=
 =?utf-8?B?V05Qa2V6NmROKy9teEJxRmRnUG02MFNoZDJHbmxJRFVzWG9yc0d6UXhBUXhT?=
 =?utf-8?B?L1AyRHNLcVdMam92QUVCS2hwOWVpcENqcU9TZkgrWExmaXdhbzc4RGc0RWZi?=
 =?utf-8?B?SVhZcEdBOFVtdHd0dHJ0Nll3WmxjaU9IU085dDNWM3lOUS9EdVR2WHQxNlhS?=
 =?utf-8?B?SmNIQWpGRTZQTXZEWDYySCtnY0VWVGFJWWtjUThFbnZ3K3pJREMyMEdvQkZo?=
 =?utf-8?B?TjRid3BDa0JJWFdHMnhqZTJlSGd1ZnhXT2V3b2FwZkovbVU4RkFuQ0F2cHJn?=
 =?utf-8?B?amczeG9JaC93TFYvVnlvTEM2Ti9CRjlBL3gyOFdqSnVydU5rbmhiUStQM3hC?=
 =?utf-8?B?akpGT2g3dHlsN1hMeDJoZWk5R0tKaXZFbEpRclJ0REN0M056ZTdKb21YblRj?=
 =?utf-8?B?bTVVSTk0K0VuVEMybEdTQjJsdnV4L0h5WWVQUUw3SXcxTCt0NHloc3pWMDBL?=
 =?utf-8?B?S1pjVy90SmVNN3FqK0FWV3FvTUcrbCt1dWxQbW84aDZPdlpwV2ZKdXRxaTJj?=
 =?utf-8?B?RnB6clhKNHhRNnEzWnBQdDI3NzAxVm1iWDhFYytxQWRsbjdpSlRWR2hVVTRz?=
 =?utf-8?B?ZEtGT1RwS3pPQWhvR1p4dUhZUm1CV0hxbzl0S3MwMHFuSktxRFl2eU9nL3VY?=
 =?utf-8?B?Qk1lT2pPUlU1K2RBVjRtSS9hUnR0cElMT2dQUUZkL1l2YmlkeXdxV0hBd1lF?=
 =?utf-8?B?dkVreTB6RUMwYjlXVUw3cUI1aFNkZE54bUNneG9iaDFKcU5iVTRPMkttMTkx?=
 =?utf-8?B?MFkzaHdOeWFiRFczcUo5WTdNMTZNTHlaeUdELzVxeWo3bVRCYzdXVmNjOFdx?=
 =?utf-8?B?ald6dHFyRGlyd3lqaUNMR0c2dFBzb3RlQXlQMlBSbVNBT2JVakJwbVZPNlVP?=
 =?utf-8?B?VVl6dzNDQjViZkUvRGpOYW9YMm4yZCtKVUVQdy9UNUgvSFdIMUdQWm1mWmY5?=
 =?utf-8?B?V2VQMm5iMXFUTnV6SXYxRW1nbmdQWTVHbmxGQzJyekEvWlF6ZU95enZyVk9J?=
 =?utf-8?B?K29rNzI5b1JLbzk4SUt2dkFXYmlyZFdFVkUySnk2anVJNzQvbXRTR1FNQjdi?=
 =?utf-8?B?SmlPdVVIaDdxWmt6K2VGOVVtbVc1MTFpLzR2VTNtTCtQRkp1cWR3Rm5hNDRG?=
 =?utf-8?B?WHBBY3RrVUxyOFBCWitqbTlEWjcrcU1HMWovTDh2RjdQbWVleE9iZjFCTlhU?=
 =?utf-8?Q?X2JBt2iYTn/S0kI6+BmHJ0mLgAMnFRI9gb1fw3CdxU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <211AF5392B03F34B97FB2C838EB40B0A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9051afd-1794-4326-6d33-08d9fb828d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 12:53:58.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vmbHH5ooBS0pQKfKTfVjcmCnfLq9XEbFHlEsdyq6oha/dceglIkSP3d24aKATdIR6JYikc7eCPxWvqd4epVlr5UFlSbYr2mIUZvLvRFrfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzAyLzIwMjIgw6AgMTc6MTQsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
TW9uLCBGZWIgMjgsIDIwMjIgYXQgMDQ6MDI6MzBQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IExlIDI4LzAyLzIwMjIgw6AgMTY6MjksIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoN
Cj4gDQo+Pj4gVGhlIGJpbmRpbmcgbG9va3MgZ29vZCBub3cgYnV0IHRoaXMgaXMgc3RpbGwgZHJp
dmVyIHNwZWNpZmljIGNvZGUgd2hlbg0KPj4+IGl0IGxvb2tzIGxpa2UgaXQgY291bGQgZWFzaWx5
IGJlIGltcGxlbWVudGVkIGluIHRoZSBjb3JlIC0gbGlrZSBJIHNhaWQNCj4+PiBvbiB0aGUgcHJl
dmlvdXMgdmVyc2lvbiB5b3UnZCBuZWVkIHRvIHVwZGF0ZSBkcml2ZXJzIHRvIGFkdmVydGlzZSBs
ZXNzDQo+Pj4gdGhhbiA4IGJpdHMgYnV0IHRoZXJlJ3MgYmFzaWNhbGx5IG5vdGhpbmcgZHJpdmVy
IHNwZWNpZmljIEkgY2FuIHNlZSBoZXJlDQo+Pj4gc28gYW55IGRyaXZlciB1c2luZyB0cmFuc2Zl
cl9vbmUoKSB3b3VsZCBnZXQgc3VwcG9ydCB0aGF0IHdheS4NCj4gDQo+PiBBcmdoICEgU29ycnkg
eW91ciBjb21tZW50IHRvIHRoZSBwcmV2aW91cyB2ZXJzaW9uIGVuZGVkIHVwIGluIEp1bmsNCj4+
IG1haWxzLiBJIHNlZSBpdCBub3cuDQo+IA0KPiBObyBwcm9ibGVtLg0KPiANCj4+IFdlIGRpc2N1
c3NlZCB0aGF0IGJhY2sgaW4gMjAxNiBpbg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtc3BpLzIwMTYwODI0MTEyNzAxLkdFMjIwNzZAc2lyZW5hLm9yZy51ay8NCj4+IGFuZCBteSB1
bmRlcnN0YW5kaW5nIGF0IHRoYXQgdGltZSB3YXMgdGhhdCBpdCB3YXMgbm90IHNvbWV0aGluZyB0
aGF0DQo+PiBjb3VsZCBiZSBkb25lIGF0IGNvcmUgbGV2ZWwuDQo+IA0KPj4gQnV0IG1heWJlIHRo
aW5ncyBoYXZlIGNoYW5nZWQgc2luY2UgdGhlbiA/DQo+IA0KPiBXaGF0IEkgc2FpZCB0aGVuIHdh
cyAiaXQgd291bGQgbmVlZCBhIG5ldyBjb3JlIGZlYXR1cmUiIHdoaWNoIGlzIHdoYXQNCj4gdGhl
IGJpbmRpbmcgZG9lcywgSSdtIHN1Z2dlc3RpbmcgdGhhdCB5b3UgYWxzbyBkbyB0aGF0IGZvciB0
aGUgaGFuZGxpbmcNCj4gb2YgdGhlIGltcGxlbWVudGF0aW9uIGFzIHdlbGwuDQo+IA0KPiBBY3R1
YWxseSBub3cgSSB0aGluayBhYm91dCBpdCBwZXJoYXBzIHRoaXMgc2hvdWxkbid0IGJlIGEgYmlu
ZGluZyBhdCBhbGwNCj4gYnV0IHJhdGhlciBzb21ldGhpbmcgc3BlY2lmaWVkIGJ5IHRoZSBjbGll
bnQgZHJpdmVyIC0gcHJlc3VtYWJseSBhbnkNCj4gc3lzdGVtIHVzaW5nIGFuIGFmZmVjdGVkIGRl
dmljZSBpcyBnb2luZyB0byBuZWVkIHRoZXNlIGV4dHJhIGNsb2NrDQo+IGN5Y2xlcyBzbyB0aGV5
J2xsIGFsbCBuZWVkIHRvIGFkZCB0aGUgc2FtZSBwcm9wZXJ0eS4NCj4gDQo+PiBCeSB0aGUgd2F5
LCBmc2wtc3BpIGRyaXZlciBkb2Vzbid0IGltcGxlbWVudCB0cmFuc2Zlcl9vbmUoKSBidXQNCj4+
IHRyYW5zZmVyX29uZV9tZXNzYWdlKCkgc28gaXQgdGFrZXMgY2FyZSBvZiB0aGUgY2hpcHNlbGVj
dCBjaGFuZ2VzIGFuZA0KPj4gdGhlcmVmb3JlIHRoZSBmaW5hbCBkdW1teSB0cmFuc2ZlciB3aXRo
IENTIG9mZiBpcyB0byBiZSBkb25lIHRoZXJlIGFzDQo+PiBmYXIgYXMgSSB1bmRlcnN0YW5kLg0K
PiANCj4+IFdvdWxkIGl0IG1lYW4gY2hhbmdpbmcgZnNsLXNwaSBkcml2ZXIgdG8gaW1wbGVtZW50
IHRyYW5zZmVyX29uZSgpIGZpcnN0ID8NCj4gDQo+IFdlbGwsIGlmIGl0IGNhbiBpbXBsZW1lbnQg
dHJhbnNmZXJfb25lKCkgd2l0aG91dCBhbnkgbmVnYXRpdmUNCj4gY29uc2VxdWVuY2VzIHdoaWNo
aA0KDQpTZWVtcyBsaWtlIHlvdXIgc2VudGVuY2UgaXMgdHJ1bmNhdGVkLg0KDQpNeSB1bmRlcnN0
YW5kaW5nIHRvZGF5IGlzIHRoYXQgdGhpcyB0cmFpbGluZyB0cmFuc2ZlciB3aXRoIGNoaXBzZWxl
Y3QgDQpPRkYgaXMgdG8gYmUgYWRkZWQgYXQgdGhlIGVuZCBvZiB0cmFuc2Zlcl9vbmVfbWVzc2Fn
ZSgpLg0KDQpJdCBjYW4gYmUgaW1wbGVtZW50ZWQgaW4gdGhlIGNvcmUgdHJhbnNmZXJfb25lX21l
c3NhZ2UoKSBmb3IgZHJpdmVycyANCmltcGxlbWVudGluZyB0cmFuc2Zlcl9vbmUoKS4gRm9yIHRo
ZSBvdGhlciBkcml2ZXJzIG5vdCBoYXZpbmcgDQp0cmFuc2Zlcl9vbmUoKSBidXQgaGF2aW5nIHRy
YW5zZmVyX29uZV9tZXNzYWdlKCksIGl0IG11c3QgYmUgaW1wbGVtZW50ZWQgDQppbiB0aGUgZHJp
dmVyJ3MgdHJhbnNmZXJfb25lX21lc3NhZ2UoKS4NCg0KQW0gSSByaWdodCA/DQoNCg0KZnNsLXNw
aSBkcml2ZXIgaXMgdGhlIG9uZSBJIG5lZWQgdG8gc3VwcG9ydCB0aGlzIG5ldyBmdW5jdGlvbm5h
bGl0eSBhbmQgDQppdCBoYXMgaXRzIG93biB0cmFuc2Zlcl9vbmVfbWVzc2FnZSgpLg0KDQpXaGF0
IHdvdWxkIHlvdSBleHBlY3QgPw0KDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
