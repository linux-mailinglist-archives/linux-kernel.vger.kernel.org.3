Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62F5A890E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiHaWhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHaWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:37:01 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070266A59;
        Wed, 31 Aug 2022 15:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWlvAjkK/oMfndsq7cYDOhjFghluIh8LOCNcqZovFYn/ISiMUHFqTbKq5pv2HS6EKLWgWBktEOt/dGC0OvPSmOAV721akqU4cpCk6heX4r34x/vL/wMP3j+AC8jWl9ep4fUBnRVktkBtYZlxSWmoOscgfBOmPePwnZwbeMZ0a/9EujNlJrSmMyXV0hoJ7R8Y28+CJaFLvIyN4ITBtjmgMS9AyuP2gh0Du7gOFU4o01RGNhsgFog+Rxysej0WrCp56C8G/ELVH9gad9jYLsmoKHL0KA15LDdO7mKMgFz4raX410MmOTjd0iF0J5lrwzyjBD14E1iJHaCL4NoWIjQ7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwVAKIzDmzD/CdmgLivFl7dZW1TJzh9PlD7LFnl6kt0=;
 b=MVl7VENwLO6v/8N2uFSx9P3SuKH8GhyEa7hLMfF4Hx0Yz+epYupftz66wp9C+iuFzy7iA4rZSBtWYiKhBICBtctzMt3oc8+MjD+Gso2q3ps7/ta0zUiyKBXMGCv85lyf9DjKU1y4xtF7vGxQNZmlUc++qNH28Qq10kE3fc6rxavuoTzrzSOdv8cfsNaF56H8s5bVjXHJJVUNrvSWbegDQda2P8mrx7L32zDuGbR8Lhw6Qol2JhWMpNjdxMj2Mk1KyMkciO2cSB+8iXCdpAMc8gAasb5AmCtbp9zbknz1XLWr0WXx+nvIb0QmOEWheFuOgzE19aNyI1cDaLRWzBJczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwVAKIzDmzD/CdmgLivFl7dZW1TJzh9PlD7LFnl6kt0=;
 b=NkzmXNFe0IG/qrNCyCVaGsLyTeUarNcHJ6wClBA+U1H2EAUUIVOiM/apYo61Ub+Ta+iUOGrtZEKpaCfKlwlNE1ho0Q2j2vZMKcKuOJEFAycQL5li3I0OdtYC/Mxa3K1PCJgkD3+xyt7dmaeRCfN0eCTBKOZUKd4t16CAl119Vls=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 22:36:54 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 22:36:53 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 02/17] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Thread-Topic: [PATCH v6 02/17] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC
Thread-Index: AQHYtM80+j6TcWUBgUKVRT5z6Z5nWa27cuSAgA430gA=
Date:   Wed, 31 Aug 2022 22:36:53 +0000
Message-ID: <57b2ed86-2e0e-5501-154e-18a395e27071@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-3-brad@pensando.io>
 <20220822212927.GA882083-robh@kernel.org>
In-Reply-To: <20220822212927.GA882083-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d487c3af-d723-44d2-ad8a-08da8ba14dbb
x-ms-traffictypediagnostic: DM6PR12MB4957:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LR4Jqv68KHfu+nl47YVr05tBeb5jdx/qlQWIio7kNcutOeZbkTnhhHY4b1fHMQjQPDgfDq91cOKXbdox3HBPA3ZDgZHg0tbpUWqbpv9T87lBGW97+w3IXddoLmSwWvmUsTF5xy3flxlpKnsLHLR34EB+7qVG7KTH7eIkDwy4S9fVkZl00JmRirPcfvY4m4UJtxnXC/eCvLj0BCUYgvC6tbP8gkAFS7BD51jgN488sGYyi/eO6cc8LvKIn9qhoC/MgqP5OzZs/r1tAxA+tlHAntXpckypoC3rL2G8DcvzoVW0zj+b2x9upuTV75aU/9IYHI5Vbktmf/aYQR4oXNaQcnYTxFS0yME62/9nVCoBwc8Mz5F5hbU8cxw+zRE/SOY6PF/ZRhM5g6fAp7v6YuzYilUwPzejC/shUBGXhq6VEOFHhQi+MiiYfj7wYkdbWKbd9s9j2Lf13CMWGgrdT8njoxZnSx6zi2OzvCX305ZdDDyh14piZ0pmcYGfETSC3oPMUqXCFfFz+ljhDPkWx0+7YcVgdG4pq4Q9RLSBl7LnyLpvYeeeFpeli36kfCL+FxyyaH48U6jxFvpe4c5vaH0Zy8Zo+q8wOMV4sS+nx0KBk1ZyWlo40jAf7uZDcu0DRzliRKy5QeB7DJGOcU70CXynbXv9cnqI1aktt2RQvzu2sfNEni7azVly4qr7O8x7qhbLm/sfzp0nlcOziFbJNBvupjEuvbxnh70thSwJT+Uu1lmgm7wbw4bNEuTG86/f+qTwsqm8cpf85wbvAzcE9FgYuNj4wmUbUYY7z2J0V9zuf7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(8936002)(5660300002)(478600001)(38100700002)(7416002)(6486002)(71200400001)(110136005)(54906003)(31686004)(6506007)(53546011)(316002)(41300700001)(6512007)(66446008)(2616005)(86362001)(64756008)(26005)(83380400001)(2906002)(66946007)(76116006)(66556008)(91956017)(66476007)(122000001)(36756003)(31696002)(186003)(8676002)(4326008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVdTdVJTSm12ZzRmZkVaSm1kMU92ZzJpVDRmSUt3RnB3Wk84N1p5VmhWMHEz?=
 =?utf-8?B?YlJYLzBIKzVaRnJnTHRvZE9ldzZ6bmhHY3A1QkE1Qk9hU3JBcGtKQUVXNVlE?=
 =?utf-8?B?Z3F3aWdxMVdTTGJwNER4dzhFUVEvS2FGSWh4TDlLNkNpSUFVTkNUOHYrMTN2?=
 =?utf-8?B?WloyRllZbWdybzM5VDBHTjFHOHdlREVhMG5oL0NKcnpwSk9UU3E4YnFoNjVh?=
 =?utf-8?B?RzQ0d1JXU0IwWU5OYXBXdlZwblptM0t4ZU43Q1ZxdWpQWjhkOXJvZFJ5LzN2?=
 =?utf-8?B?NmdySmIyd3J4Y2dmY0JoYW00bXMvSytLV3pzNkM3SVEzKytTTVlRdXpxNzBk?=
 =?utf-8?B?TjdBNnBkQXlFTkdkWUVlcDIwYVNpd3JTdnhhS2FMT1JvTzAwRmg1cDJYTW80?=
 =?utf-8?B?c1hGa28wZmR5SDRRdFgvSSszb2FGWjNJN0RRMXkvbVZpTGcxSGEwd29YTnQz?=
 =?utf-8?B?S01FUDE4M3JUenFtTmRxT0hYTlVCZC9mWHNNenNoaEJhNTc1c0RhNUtYamo2?=
 =?utf-8?B?dHpsWHVuVWpXWUQzR3ZpWmJ5VllIZmJrQTI4YWpLajJibktWTExJVVFHMzJN?=
 =?utf-8?B?L1NKUkUrNHVTOGt6UnA4VDRrRk9razdYUnBaUnkxRE5ZaWJNMzZYMC9kQzZp?=
 =?utf-8?B?amlacFZIQUl0bm52bDBKOHhra2JiaExrN1pwYVRuMVgxeXhDOFJibXhSR0N1?=
 =?utf-8?B?bkpseE0yNFd4REdpTEpXbFBJSkc1aTdxd0haL3BhYm0zWU11TWNVKzVKKzdr?=
 =?utf-8?B?QXhsT3ViMkhFczZZb2UwQkNzZmxIM3NhRmNFcitqREh1ZjBzWEwzN1RMbS9v?=
 =?utf-8?B?RG85cGJ0MWhqU3lvTVYvNTUvRTI2aUpZTTVEMnU5YXFWaVljVGRiQVJOenN5?=
 =?utf-8?B?WWFaakRYMHRxaHYzckQ4cFF0a1ViNFlNSDRGSW9teER3M0p5b24wSytRejJV?=
 =?utf-8?B?WXRWZnZhM0IzMFQ0a2E5bi9LeEEyaWg0ZGhDRkVkbklPSWRoNHFqOUpTUmJx?=
 =?utf-8?B?OVF3NmNUWXlwZHFBQ1pRNDFXQk1wMVVpN09jNEFVSFI0cTM5aVI1L3VZTFFD?=
 =?utf-8?B?TllQeTQ2Y1NCR3lQWEVTTEphemJ3dzl2NDFNK3JGZXNROWhWNlZyVHVrY01D?=
 =?utf-8?B?SCt6ejJwVnF0dy92YTB1dkJFSTVDRHFIUm55bkVaUWNhLzhNcEFVVGNhSUdX?=
 =?utf-8?B?Ri80ZEZTZ0Q1dEVvSFpWblNYOHBHS205T1RmVk1rNGNVbXdqa2R3Vm1weS9E?=
 =?utf-8?B?Yy9OSTdmNGdtY1IxajVSMlk1RXJiZWsrVjgwcFpsMHNvZ25KNkZ0TkR2dUFH?=
 =?utf-8?B?a1ZOeDZPSXFaYk53Q3RFTk9KMjltMUk3NzZyY3dSNzczWE5LS3BPTXYwNzlP?=
 =?utf-8?B?ek03NTBRT0JuNUxjbjllOTJvS1JGZkw0Z1AxS040cWlzRGF2ZVhRUS9CK0x6?=
 =?utf-8?B?NnY1T2xIQk5NZG9Uc3dYQUlxSWtvOTczNGRXckhGSG5RRXYveDcwaSsxc0hx?=
 =?utf-8?B?UDMyQWRVNUU3d2VLNlRBZloxY1NzT3BEVERDQjZ4RStDUEJMS2R4T29zWmky?=
 =?utf-8?B?ZmZ0MTd5eGFQVzI3bmdMTUNVdXVoT2VSNGhLcWNnWDVsSkg0ZjlZQ3BCMzY3?=
 =?utf-8?B?MytkMG44WTlkRU5uUVI4OE9sWCtwN3dIQkdaRE5zWitjWkdaYVpZM3BiaGx4?=
 =?utf-8?B?bFNoaThhVFJra2lFaGZWdlJpTG4wbDZmelM2cFE5VTBHMVROZlJONUJwYUlI?=
 =?utf-8?B?clJOSmtyNDZmU2lUTmZ0MUFJVHJiQ2FSUDF2MENUK01YQTBKczAySGo2Vmdv?=
 =?utf-8?B?VndEenpSUklRS3cvSWlDZlVxeDZrSm16bE9OTGpWWkpjMjhucjcxd2pPWHVs?=
 =?utf-8?B?VlFZQytVSkZQYnR1Nm15TlpLRWt5cEtOMW5oZmdzUllTYmtuRTJoQWlHYzBR?=
 =?utf-8?B?K0Z6TU5oR2diUk5tTFVuTHF3TXNXQUxTeTJDUW1vZVJoamczUFQyNFpDbUN1?=
 =?utf-8?B?VkQyTWc3a1R1RWQyNW5lNG1XazZYNmZjRXlZUnJxTlljYlIvWGJNSWpJcmpY?=
 =?utf-8?B?WGZZblBuK25aRGNpcmROSWFKTlg5WkhVS1RDbmVMbS9yR2VEYm16V2NYZ1A5?=
 =?utf-8?Q?55WY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05C566D8AF46884199014165061FCB49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d487c3af-d723-44d2-ad8a-08da8ba14dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 22:36:53.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDpJXFRxT0XaSeKr+FLlx/jeofRg+cGUqeYqGyCAQjJbMS0fVPgLBnMIwPfPZhgr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMiAyOjI5IFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gU2F0LCBBdWcgMjAs
IDIwMjIgYXQgMTI6NTc6MzVQTSAtMDcwMCwgQnJhZCBMYXJzb24gd3JvdGU6DQo+PiBGcm9tOiBC
cmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4NCj4+IEFNRCBQZW5zYW5kbyBFbGJhIEFS
TSA2NC1iaXQgU29DIGlzIGludGVncmF0ZWQgd2l0aCB0aGlzIElQIGFuZA0KPj4gZXhwbGljaXRs
eSBjb250cm9scyBieXRlLWxhbmUgZW5hYmxlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmFk
IExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9jZG5zLHNkaGNpLnlhbWwgICAgICAgICB8IDEzICsrKysrKysrKysrKy0NCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9jZG5z
LHNkaGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2NkbnMs
c2RoY2kueWFtbA0KPj4gaW5kZXggNDIwN2ZlZDYyZGZlLi45NjRiNjEwZWVlZjIgMTAwNjQ0DQo+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2NkbnMsc2RoY2ku
eWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9jZG5z
LHNkaGNpLnlhbWwNCj4+IEBAIC0xNywxMiArMTcsMTQgQEAgcHJvcGVydGllczoNCj4+ICAgICBj
b21wYXRpYmxlOg0KPj4gICAgICAgaXRlbXM6DQo+PiAgICAgICAgIC0gZW51bToNCj4+ICsgICAg
ICAgICAgLSBhbWQscGVuc2FuZG8tZWxiYS1zZDRoYw0KPj4gICAgICAgICAgICAgLSBtaWNyb2No
aXAsbXBmcy1zZDRoYw0KPj4gICAgICAgICAgICAgLSBzb2Npb25leHQsdW5pcGhpZXItc2Q0aGMN
Cj4+ICAgICAgICAgLSBjb25zdDogY2RucyxzZDRoYw0KPj4NCj4+ICAgICByZWc6DQo+PiAtICAg
IG1heEl0ZW1zOiAxDQo+PiArICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgIG1heEl0ZW1zOiAyDQo+
Pg0KPj4gICAgIGludGVycnVwdHM6DQo+PiAgICAgICBtYXhJdGVtczogMQ0KPj4gQEAgLTExOCw2
ICsxMjAsMTUgQEAgcmVxdWlyZWQ6DQo+PiAgICAgLSBpbnRlcnJ1cHRzDQo+PiAgICAgLSBjbG9j
a3MNCj4+DQo+PiAraWY6DQo+PiArICBwcm9wZXJ0aWVzOg0KPj4gKyAgICBjb21wYXRpYmxlOg0K
Pj4gKyAgICAgIGNvbnN0OiBhbWQscGVuc2FuZG8tZWxiYS1zZDRoYw0KPj4gK3RoZW46DQo+PiAr
ICBwcm9wZXJ0aWVzOg0KPj4gKyAgICByZWc6DQo+PiArICAgICAgbWluSXRlbXM6IDINCj4gZWxz
ZToNCj4gICAgcHJvcGVydGllczoNCj4gICAgICByZWc6DQo+ICAgICAgICBtYXhJdGVtczogMQ0K
DQpBZGRlZCB0aGlzIGNoYW5nZS4NCg0KUmVnYXJkcywNCkJyYWQNCg0KDQo=
