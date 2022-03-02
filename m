Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C254CA631
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiCBNma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiCBNm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:42:28 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90088.outbound.protection.outlook.com [40.107.9.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12631913;
        Wed,  2 Mar 2022 05:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duKji0A7ycCUf+FhCv9R3GqRaESU/T27QWRG8Hbf+puBXG1kActh2Js2cDAwuKJJCuYCw3uHBBYjMe24cym2kTJD/BR0KKEcPGZJhvXi6VwOha8J4CBWuDUmnRJsgoBvfWqGou+PljLmsK5cDuerukcVVTq0o5KHHhv4ZJfHBMwL8zjHGBFhLrFNIvWoQsoKgPr4MKkF2HpDKSWYmClDcWP94QXq396TQFMFepJvuSJ9IPrqOyUMresHaoPo0Y56pyf2lblkRPBv/opyUC7aLUzvsUFnQqz3r4lQJUQvYD1lSQCuC+z/tTCkcOuwjioIwntYkmH0slIXfDrN8sZXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwVTKVfJ3R7iGO7013w78D/D91/AbjUyQqaoRV3XZLs=;
 b=Tlam1oPVdzZgCGKZFohxGXuUHofXWm/QNCcWejjAbt8CdE/aoDtQBh66Adr0oSyPIlJxiQSHEVSP8iWzlDU+UMiKb0GVcgD4VgWH/5up6psOJZke1zzsUBibWSJKrrA1mGObUEX7RMEGlnAfsCl39y7B3lxa+fXvgwx4cFskNpMlkb5rBalKYeNqQVVT12n97PI6/2tszGpoVX1WoIFAfYaBFPnUWgkXnWC8jFLbQr30ai2eEgtVTF7B2hMYiF2y3CGp5x0al7zu6qAsVJuegTh3na7CGpwx0m8Ilb5iTN3zg40LJMgPR97IK8SaAoUX1GFn6h4rY37EH+J4BYYDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Wed, 2 Mar
 2022 13:41:43 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 13:41:43 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v9 07/14] module: Move extra signature support out of core
 code
Thread-Topic: [PATCH v9 07/14] module: Move extra signature support out of
 core code
Thread-Index: AQHYLP0GFLJD3Dg8pkOmoPnkw1nPZqyrv2OAgABa0QCAAAJSAA==
Date:   Wed, 2 Mar 2022 13:41:43 +0000
Message-ID: <aae67a8e-6f0a-a535-7053-67a6dd601d30@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-8-atomlin@redhat.com>
 <c03fa2bb-1b0e-62c7-53fe-33e44d20b564@csgroup.eu>
 <20220302133324.dbf5vx45foxa32bu@ava.usersys.com>
In-Reply-To: <20220302133324.dbf5vx45foxa32bu@ava.usersys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e490b96-3c8d-47d1-b835-08d9fc526351
x-ms-traffictypediagnostic: MR1P264MB2113:EE_
x-microsoft-antispam-prvs: <MR1P264MB2113C5D9319A5217A2486C09ED039@MR1P264MB2113.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usOx9KeyaWz9BoWno3a18BBpb4AzjtYpr4jEpSiC3qDRwXjDsfkDP4g723UYPlNhUnWmSoFsgt7bL4w7vo6tGT7hqmshpNQqo4sy3EyKnLqGJ7erFHAEWDkeSNud83mapq163BCi+R4QIs39RBEmp0D1vq7XJqtHRa/stu9NeHWgxIvX0/UcTIXK5fIElknFxY9PGBMpCo4WYroYYzoReqlLBZMCBxGHBjsrNFm9yQva+cNpKZogRgoF8yQKLCPKES877qcWPreKczaliuVbEwHkfcL85KWbzQqB4dNSh81A0KEprJs9lS0wtkdWR5NEDHT0zVjQwd8Y2t1TWdceppmtSPI7N5dScATcqPnAM9wPQ/2q/f41NO5iWwGJsJdq9RCq88zBSeH/eur26zijA0gufssLCOCwdR2RVPKc2K+oP0Qk6YXfLDTM+/I3wQt7D5aeqtLz3aXM2XVLDrv31cEzlOxlT6j1aMIKsiIEjqiqgQJKJKcY0T5vsVPYOAgWZTD3U9Sj7c7I8fQoatsyZY+v3P607Ps2ycl/yF8Mw/o3DNNAvZ5i630bhp1AG9mkLbxB0hLoY7DdooaIVqJG/UF5+i0E7+GwFou8FIOPA7oqIe612x3H2kAg1HE9J4S+TgY5xz6X1DR/A91GuYvj0TasDGLWNZ2n6xZobKrnsJ+moFt52fC8+okNCiTU464HUyRdRkRrsIV36HtXFaeWb0zk5+icULVLCP6OjJlyK2PQ/6DTw3dH3DhlFGkkPmuWBdrJBWuhKoQKvjey1mvgaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(2906002)(6512007)(122000001)(186003)(83380400001)(2616005)(26005)(54906003)(6916009)(316002)(8936002)(71200400001)(4326008)(8676002)(31686004)(6486002)(64756008)(66446008)(66476007)(66556008)(5660300002)(508600001)(36756003)(91956017)(66946007)(76116006)(44832011)(31696002)(7416002)(86362001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVI0YlBmdWtaaFIyeE50b2xqaDg0SkJkaDJvYXJtTXoyYmxncTNNN09RTlNv?=
 =?utf-8?B?K09HQjZ4Uy80Smp5ZTNZZ0RJci9JQkRkbXB2Vm1oNXczMXo0SWd5QWNHMXBR?=
 =?utf-8?B?a1kvdkd0NXhzWVhMQlJVNjdYcUpoZXU2cFBOcWhTbHREM0llT2c0dC9DSzJ5?=
 =?utf-8?B?SnZIU3ZKSTNheHBtUFJTbTZ4QnhSQTN3SmxSRUxHaXJLeGFqbk5FcVBSSldG?=
 =?utf-8?B?VmsrU25INytGKytCK0FkQnlZUHJCMklXTmExWXFrUWxrRDlJTlpMNDIwN010?=
 =?utf-8?B?R2FXUEhmSmVKR2RnQzJkQ1hINWozd0tHTW9zUzBWSndna1ZNdStINEF2dEg4?=
 =?utf-8?B?UEZCU3JpUFBDRHdSTWtpd1p4OXhwY0IxNFRnc0tTRjNIeVZmdXFhK094ejF6?=
 =?utf-8?B?UXh5RHFrVGl4Ny8wUENXWGRoRnJlbUZTb25HTk5pSkpyNUtmRVl4ZHdOVGd3?=
 =?utf-8?B?TEdrM2tzaUx4dEVZZ05YM00xcEJnaUpWVVc1Y2pCRUpLOE80cElDemx4ditm?=
 =?utf-8?B?ODViTmp4L0ZseXpTdlJWZGxKNHhLTjVab0RBREEyclI1U3gwZmV1US9UYkJu?=
 =?utf-8?B?NVpkZHRieWFHTk40TnNvQi9rTklwUzRac1c5eFpDYm5zenFkZjE2SnhMRWcy?=
 =?utf-8?B?UVNuTWRqNlZubkZXMVU1NHNHdG8wSElIQ0VlTi9OMVhzYnA4dk1mYk1TNFhw?=
 =?utf-8?B?UVMyMU1WNG1DZDE1OS9tekdHejZIU3R5eXZPOXBpUlFJdHhFcnI1RWxYUzcz?=
 =?utf-8?B?RFIrY1VQWkF6VjVOMGxVTEZaaWRUcDFrZzVGcGt2c3JPUCtTL0J6ajh5SGJE?=
 =?utf-8?B?bVRkd0hnem9VcUk5QzJtd1RrZzRmTmQ2dWtvdjlrWE04WFQ4aktkQUNLUDRw?=
 =?utf-8?B?Q25xeW1lTjM1eUQxQmxYdCtLM0p2ZE1UOFdrM0dOTWZSMm1aT0pWeHorWVRW?=
 =?utf-8?B?cS9WdkV5dk9vckl0eDNzQlh4MGZ4enRoTkhJNFN1dTZwYkhWVisvL0NSWjN0?=
 =?utf-8?B?YmQ4dXgvUnRmQm95ZlB0T0FlalZ1dmtQU0NmSzRXVE5yblpiR3VTWW1sZGFa?=
 =?utf-8?B?THJqR2NpTTYyblZWQlhsMFc4NzJSYm5ab242N1UxZDZLK1c1eGR6V014Uitn?=
 =?utf-8?B?QUlZWlhmSFpDM0gwcWV5bjBLWEw3eDM5RmgxR2FxRitqRWNVa0pFZU05TGZn?=
 =?utf-8?B?Mm55b3htV3lLOEhiZ3Q3Z0NVTDJJbkhzb1JaaTlUREM1dEpCbCtqUHJ6UFR1?=
 =?utf-8?B?M1drNVNKZ21jN1B4N0FtQzdrTFFOL1dYcEFvdWhBRFMzQ1ZwNUZSUmpub0RZ?=
 =?utf-8?B?S3BqWG54MlZXTTRzVnJjSHVkeXM4SGdPdXBoczkrRUxaZExDaXJJMm1lczlj?=
 =?utf-8?B?aVp1OFZ4TVBNVTA0eXgxRWlWVytoaS82aElRSzNoc0M3RGZidHZPdjVBcEQv?=
 =?utf-8?B?L0huWkh0RTQyOEt6M2MwbGlQVndlTXp0MUdkWStxeWhOV1k3ckFTN0JTSkJC?=
 =?utf-8?B?SVFCU1NCcW94dTlSLzlzeVFFSCtUbnNyWi9uaU5oYU1GdWZLQWc1Nm9XSWZa?=
 =?utf-8?B?c3hzUmF6L0dyWFY5bkdaOFNGWnNuYWxjL2ZmS0M1bTRBRUdjOUwwdngrRGFJ?=
 =?utf-8?B?TXYvV3lwN1FUNWNqeEVvbFZrdzJ2RU5aVEhteTA0ZWtIeGRaNjk3d1I2STZW?=
 =?utf-8?B?eW90dW00a2NtaW9mdnBwSER2VXBiQ2hCRE1Cdnd6SHZPRXRPUDNyam1kbkVH?=
 =?utf-8?B?dWUyZmkvdEJrbnNIbURGdGhvb3BiN1ZUMWpsdkEwbDdmM1NiekhQY1NIUlNx?=
 =?utf-8?B?ZnVyTG9XcUZKV3dIQU5uZ1lDL1h5SEVWVGdXUUN5T3JJYzhzR2tMM3FiTzhm?=
 =?utf-8?B?YlVqSnNBL3ZkOWwvR0RrYW5MWG5tVWhSWjJYY3ZuMlRCQjRJdDZFMExpU1dH?=
 =?utf-8?B?bDh3RXlzNUg2ZFBnSnl0dXJlL2hYc0VCalFHc0RIa3Q3Y1QxemM2RGROMm1j?=
 =?utf-8?B?TWFydDNMNUlqL2JyN29Bb0FrUVA4Y25Pd1JOVUwrT1dBMDRxR1cxUkxub3Zw?=
 =?utf-8?B?aFd4U0ZBMFQxNjk4Yml6Z0FLd3RxcXdUTjE4V01KOW5CR3QydmlwRFEvYThI?=
 =?utf-8?B?VXV6bk1Nd0ZWTjN3R1R6SUlQd0RJSXBIcmlCcFh1K0ZvTWVLc3cwUTJoUHdu?=
 =?utf-8?B?YVMxS0hiTDZRSGt5djVGTUtGZTJUNkR5K3lmRE5vQUpVNnVHU2JIYjVVMnNW?=
 =?utf-8?Q?t0BDeJ7qOTTMxlMk9mXl8xsq5q9/jxumY3KDEuSvz8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6903CAC515FDC040875D9335D449D275@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e490b96-3c8d-47d1-b835-08d9fc526351
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 13:41:43.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m40PoZhLWe38jvLHkyrNJyGSHsou3xWV2iQw/w6g1bsiPGfdLZgOc/oDozSxjllVZcnzR8nkSWioIKZT36AYU/62iAagpR3A1i2DVmfT2eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2113
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzAzLzIwMjIgw6AgMTQ6MzMsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBXZWQgMjAyMi0wMy0wMiAwODowOCArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
PiArYm9vbCBpc19tb2R1bGVfc2lnX2VuZm9yY2VkKHZvaWQpDQo+Pj4gK3sNCj4+PiArCXJldHVy
biBzaWdfZW5mb3JjZTsNCj4+PiArfQ0KPj4+ICtFWFBPUlRfU1lNQk9MKGlzX21vZHVsZV9zaWdf
ZW5mb3JjZWQpOw0KPj4NCj4+IEFzIHJlcG9ydGVkIGJ5IHRoZSB0ZXN0IHJvYm90LCB0aGF0J3Mg
bm90IGVub3VnaC4NCj4gDQo+IEhpIENocmlzdG9waGUsDQo+IA0KPiBUaGFua3MgZm9yIHRlc3Rp
bmcgdGhpcy4NCj4gDQo+PiBXaGVuIGl0IHdhcyBpbiBtYWluLmMsIGlzX21vZHVsZV9zaWdfZW5m
b3JjZWQoKSB3YXMgYnVpbGQgYXMgc29vbiBhcw0KPj4gQ09ORklHX01PRFVMRVMgd2FzIHNldC4N
Cj4+IE5vdyBpdCBpcyBvbmx5IGJ1aWx0IHdoZW4gQ09ORklHX01PRFVMRV9TSUcgaXMgc2VsZWN0
ZWQsDQo+IA0KPiBBZ3JlZWQuDQo+IA0KPj4gc28geW91IGhhdmUgdG8gbW9kaWZ5IGluY2x1ZGUv
bGludXgvbW9kdWxlcy5oIGFuZCBoYXZlIHRoZSBzdHViDQo+PiBpc19tb2R1bGVfc2lnX2VuZm9y
Y2VkKCkgd2hlbiBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2VsZWN0ZWQgYW5kIG5vdA0KPj4g
b25seSB3aGVuIENPTkZJR19NT0RVTEVTIGlzIG5vdCBzZWxlY3RlZC4NCj4gDQo+IFN1cmU6IHdo
ZW4gS2NvbmZpZyBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2VsZWN0ZWQuDQo+IA0KPiBMdWlz
LA0KPiANCj4gSSBjYW4gc2VlIHRoYXQgdGhlIGxhdGVzdCBzZXJpZXMgaXMgaW4gbWNncm9mL21v
ZHVsZXMtdGVzdGluZy4NCj4gU2hvdWxkIEkgYWRkcmVzcyB0aGUgYWJvdmUgYXMgYSBzZXBhcmF0
ZSBwYXRjaCB3aXRoICJGaXhlczoiIG9yDQo+IHByb3ZpZGUgYSB3aG9sZSBuZXcgc2VyaWVzLCB3
aXRoIHRoZSBmaXggd2l0aGluIHRoZSBzYW1lIHBhdGNoPw0KPiBJbiBteSBvcGluaW9uLCBhbm90
aGVyIGl0ZXJhdGlvbiB3b3VsZCBiZSBjbGVhbmVyLg0KPiANCj4gDQoNCk9uIHRoZSBwb3dlcnBj
IGxpc3QsIHVzdWFsbHkgZm9yIHRoaXMga2luZCBvZiBzdHVmZiwgaWYgdGhlIGZpeHVwIA0KZG9l
c24ndCBpbXBhY3QgdGhlIG90aGVyIGNvbW1pdHMgb2YgdGhlIHNlcmllcywgd2UgcHJvdmlkZSBh
biANCmluY3JlbWVudGFsIGZpeHVwIGFuZCBNaWNoYWVsIHNxdWFzaGVzIGl0IGluIHRoZSBmYXVs
dHkgY29tbWl0IHdoaWxlIA0KcmViYXNpbmcuDQoNClRoYXQgd2F5IHlvdSBnZXQgdGhlIGFkdmFu
dGFnZSBvZiBhIG5ldyBpdGVyYXRpb24gd2l0aG91dCB0aGUgZGlzYWR2YW50YWdlcy4NCg0KVXAg
dG8gTHVpcyB0byB0ZWxsIHdoYXQgaGUgcHJlZmVycy4NCg0KQ2hyaXN0b3BoZQ==
