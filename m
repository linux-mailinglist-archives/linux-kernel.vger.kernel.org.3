Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED81859C6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiHVSj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiHVSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:38:54 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120040.outbound.protection.outlook.com [40.107.12.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57198A1B1;
        Mon, 22 Aug 2022 11:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSupePDNd2HjZs97MxADFkEcQKQnytImO4nN6ww47ja4mSGwwXcCNrm8pR6MboP0wPnwEmvJI/W/I4wGAS+QogwghYyyagkMrQBnUTPj4FGVrOXJ7SPZai163VY1stTzCvpiNiFlVJ/Nmy5YD57jHdSa3hVFSsEF+Nl7DxPTCFX4EfZ+Q1mhEMDvPVnyZ7F2W+wuuGDPCDVizWRVR03tsEzKT0tZGRwb/UMkCJXzxm+lZj8JiP+dRPRRR2qA0RcYmmhEKwLcrsC8yT2ZyVU+V6/K2LGPd1alvYT/I5Y1zEQNrblKusyBaW9DNl5f4pofXC8ESUjP5nJCo9aOFx9amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xIfI3euVfUP/rLtUDneZ/vz9b+72z1BJFoZElHGXRc=;
 b=R1xAtTawW6wovW+zWoW8g2+kyVOMFcBCT2oeE5/pEFOVz0no26680IooGichlc7/YIDB5rXLfNonU+wWZL/M3xk1FocDQWkVRIF9DdBYMRt4fJNIkjXYlZBoSBJ1tgkIGHrZK3vTwfog3EK62+jyLnOf8XBvZDS4Y8LNOjQ+alaBFUQNg9dFS59U/G1GaQfnTPFte4I4sglrl0RnSom7dsaD5BY+fMNdl1UrRxyD9IPhFZh2hlPJhpL9WOnVL9ZdA9VPhFMo2/pgL8dXzQbfAJlgB9uX84kjk9BmdwxY/1jM1UXwMWXZfjcGEbMXm7rDJCG9Zhwp0pgxQDgo1rUjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xIfI3euVfUP/rLtUDneZ/vz9b+72z1BJFoZElHGXRc=;
 b=ezY6Z5XjuoIEWCddAFNgzawNHaGPoodGqwUWt1UOuPL8gR+KX7puZnblr2HOSwIu5AMJQgCC7sEii3ZmnYewXlNxHofLGnYOS+06JgeE07Fv+HeiEi0E6CpA1dEjhuO1PpyPJDgd3V64pYV7+PvL59tbtInqlj6YbgtLMEHHAGqW4p/oWNg4qfitbp+EE7zoXKBoyFWsL4od7K8gg23+XXV6QnHkdK3B1Njn2RCy8f33ddMLnNMKKaxodUddNbwdqW9AMKQbUEQffx8JQJEIY8l3BKYWltu8gIdvNQcvbBfodMmjNR792yUH9RzR8OifVK7RSh4xq0GPsZHemlB4Mg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2353.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 18:38:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 18:38:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Topic: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Thread-Index: AQHYLLYaFbn8bOSg7kWQHVbhv1kp1KypFp+AgAAJIICAAAN6gIEM5foAgAYyz4CAABdGgA==
Date:   Mon, 22 Aug 2022 18:38:22 +0000
Message-ID: <c4950a61-ba9a-5897-1f04-bb2c56979d7d@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
 <f9046e68-ff22-2652-48dc-d277b4af75dd@csgroup.eu>
 <YwO5l/KpXoKJVawq@sirena.org.uk>
In-Reply-To: <YwO5l/KpXoKJVawq@sirena.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a1e8a6-d634-4489-5988-08da846d7dc9
x-ms-traffictypediagnostic: MR1P264MB2353:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7vhiKBk046p2dZ5bQlqVs2ieNUlyRxph1rW/9c6B0nUD08bmyh7zB/BSjYgbE31s4N94NjKu77OgvfGvCsndNrvBXMEzj6xxuYDg8bF85v8N83V5oWPYUD3C+6vijRmH8TUVPDyp8ZnBI96VsgCXiGKmpEGtYDAo+mra5wnZ6E9Ea6v4SGR7HU0DY5/JzGmYCPTOQnr1a4/m86ZRPLo9j4TaSwPs37p3oFg9MxQ/OZNkdqgb+eulyc3NZ+BNjJXYEXDsT2mUvoDADRhrfhNI0qhmjJOuApo1GNMLyVzz+XjmbzZzg9NnOh6x9bBhIAuLs1RKSWVlYxFIQfuKBQda0BgjRWLeldE8NblqvdTgQ9ahZ4kP8oZueQzfoeTKJ43Ad31VUd78F8nu55u4YLUM1H6Ic/8nMkCcY0zIsHnEdOEEVOPVVtafeJ63MVFFJdcTWprqCONB7yAPAqD7CQY+tqkOL2K5Cua6NKI0iT+JIRh+RJ1rA0Hak7WDAuUz0wtyxyind/f8ueIwoXoaP5v0R1Bafww71Avo1OsIF68iG9c50YfxJcrUGAGa9o+unk9G+67dSyKr/FbgtrX0m3JgvM6bnPm8G8ALXm1WENsRBAvl7Opjl6YLDb2Gdd3o3tSp30DzWas0d09OG358UxhttV132jXUvjVUQFQ4y7O4p25TtynNDHrPA8SOmeTdlSm8C7I16OJTXfC2wNQY2jtWXZww1/XQdMO5H3cweh8dnh66ixzGrn5k5bQEVC2TJqEe3lQAvvA3jGVXH61zdj7LOFEtsxZokoEZkxb5bZA3SoQmtFupyWni3COINt218MJUmxPEAYKH7s0A0Nx63cr6/mlU3x7DO2ZHdpoPHl5IuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(38070700005)(122000001)(6506007)(6916009)(54906003)(83380400001)(36756003)(2906002)(31686004)(38100700002)(8676002)(91956017)(71200400001)(316002)(44832011)(41300700001)(8936002)(5660300002)(26005)(186003)(66556008)(4326008)(64756008)(2616005)(66946007)(66476007)(966005)(478600001)(76116006)(6486002)(66446008)(31696002)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGQ1cDNNaXJiTzE1NnpOZ1pFSUxsYXF5bVl2Wk13Y25xNmlic1VLeWN0TE1O?=
 =?utf-8?B?cHRXakp5TGliNmNTejBReWJvWUtRVll0QjZCNkdxZlZuZzFvejQ0MTE5UjJL?=
 =?utf-8?B?UnBiM1UvOTZmWU5odmFVQ3J4ZmZCb0FqWVVvbklIZVVxUGhMUXlZSFRTN0Mw?=
 =?utf-8?B?Zlg3cm5NRkVIMkNLNS9RbitrKzJFNWpuaEY4endWYVd1ZGJiNnZrSmtHVWho?=
 =?utf-8?B?RXVSNVVsbUsybmlBMUhRUnBLRk9McXVxeEZmcitjcUtoeGNSZkN5Nm1sM1Zy?=
 =?utf-8?B?K0JQRi91c3hIaDVIMEsyQzAyM0Z3SmFwOXdCS25JbjAzOVhxdFN5Zys3YWRW?=
 =?utf-8?B?RForbFJ4TXRJOTBmS2Z3YWdBUFJKQXl4NEZoeGlMaURzL0hwSmcrMkdaQmN4?=
 =?utf-8?B?UVRBUk5QWDNDOXVSWEFDcStmYzVVT29GQUFUSGthYmE4dTRnbFhDdDZyTmIx?=
 =?utf-8?B?MU1UMGJPcXlERzE5ZTA5L0lWY2owTmZTaHcrN1ZBc0NpS0VWOW1GdzhUYWhn?=
 =?utf-8?B?T212eFUvTXZoektQZlZ0Z3NqaWU5UFJCYkhQSnE4YUJOQjB0b0cyekNnb2xu?=
 =?utf-8?B?SHI1MEtiRk55S1hielMxNmVFR2tyejRIV01YQUR1MXcvSU8xVzU5ZzgrV3RW?=
 =?utf-8?B?UHI2dWM0bGQ4bmFvVFRxcitTRFZPTmhOakVldkw5alAvaXNVaFllTDI1V1B1?=
 =?utf-8?B?WjRUNkZhMjVjY3c1MUpUMWJmWWEweDFiaFE5LzFZVDEyVDdzWkYzOVAwZzNM?=
 =?utf-8?B?bWFrQW53RHVtczA5aGRmSU1lS3NnbXh1L2xJL1ZJRHRWSG1EajJ0a0ZvejZ4?=
 =?utf-8?B?cWRCcXhFRnRrRUE3cUhvazlkc1hnbzlSaGpCL2dnNnNJRm5oR1piaEZwcWMx?=
 =?utf-8?B?K2Q2SXF0V0Y1c0lkVHQ1Y2k1NnZRN1NEeTRjcFJ0U0VoMUVMZ1lCS0pKQmZC?=
 =?utf-8?B?eTFSMGJGVnRsaVFKOHBlalZ6cFA1R1ZoaXV6V0J4WS9xUnhKbC9MNDNhcGNo?=
 =?utf-8?B?K3kvdDNqZjVFS1Fmci9OaGdhYWRNMC9TVVhnQVROSjk5WnY1MFhLSHpEWTlC?=
 =?utf-8?B?ZlF1dzdKM1N1eThzR09qWFNvdHJodHBSVkIybWZEZlFEQWY4dk1sZHJYdnl5?=
 =?utf-8?B?Z3lXQ2VrbjlLeUtWbkZqdlZndDJtS2xvNFRyKzZpVzkwemw5NHRCV01RV09Y?=
 =?utf-8?B?K3dIcmx1eHNka0M4ZW1ONkxKRm1pMUZmQkdqRzdLdzlVZUwrTmxiaVVuMTBZ?=
 =?utf-8?B?c1B5MnlwaWhtbHFsSjFTVTJZaUVHcEkzSktIOUdSWWhIWGovbWdTSzBMV1VX?=
 =?utf-8?B?WVdlbTBqcWE0TGs3RFo2MjRuWUlvSzlmSmxlbWxKcHhnL1VGSlZVRjd0dnRk?=
 =?utf-8?B?WENjMnEzRU1TMUZ0bWNrL2VESXJKOUdRN1JvR094SENOV0x0alpnWTJqcTZw?=
 =?utf-8?B?QjdFRWZGU3I4ZmhLOWwxRkZuRzNML2RlTVFTSkh6SzBqMlpJanFMcW54cWhV?=
 =?utf-8?B?Q29pMmlybjQyMXRLQ0VGY2JFZHcwNysyeGhDQTR2eUs4UmluN3I0NzZ5ZzhQ?=
 =?utf-8?B?RHF6RVJCSHVhV29qSnFWYXljRngxSG5jTDRQcXd0cTV1M0pJQ2U4THM3SkZC?=
 =?utf-8?B?VGFMVWlBK044YWRZSCt1eEZ1eXg5UFptTWd5UnFHa2tBdG41QysySmNsN0Ra?=
 =?utf-8?B?amJuOWtaMkxvVFdWRjNSb0ppamEzYk1ENWsyWXVWNmViMkhRcVlVVy9hTmpv?=
 =?utf-8?B?USt6NWVXcFJkbmFGSTM0aWhLalNLaVNzTHZqZjZEL1dtckt6TFhYOVdNSDcv?=
 =?utf-8?B?RytZcG1hNVhMdXhkR1Nmd1ZlbVNxSlVsM01mM0w4Ry9OazFnN3dJeG1wMnBH?=
 =?utf-8?B?Q1BxbXh4WERMSUk5UkN4RVgvcUo2ZCtZTFRNVmhFU3B5cjNEeDk5ZmhJNENk?=
 =?utf-8?B?aDBRMm9WSDZsbElrWVhjQUJlOFovVDRiV3Y5SS9aTm9HK0c5eHVBdm9BZWo5?=
 =?utf-8?B?UWhkeHU1RDVuMGVPaDBOWDI0SWFoYmtTWno4ajQrTnhSM2pMeUtQRlI5VjNY?=
 =?utf-8?B?N3g5QU12Mks0OTNucVJmQ3Q2MVJmUVFWNUF3QmlqV3B1eGZlZmpxV3IrYTdH?=
 =?utf-8?B?OW5XMW1Ga2JkVFkxMk1hUVhPMzYzNTRFWllqQi9jZFlNRDY0a0oyMWhicmJU?=
 =?utf-8?Q?jvJtpLCIU9rp0h4Ylowg7UI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B10AADB2B98F3B4C8FD687CE98E98B94@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a1e8a6-d634-4489-5988-08da846d7dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 18:38:22.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00YybVKbh/oVyYsFSvFNvtWNQ/SqolMRhdaSbbD3CMsudmW4jGk/KEf0738HNDhIwplFz5yaTPBXef3PXVETnHzdPfp5GgHo/QJmKuehcHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzA4LzIwMjIgw6AgMTk6MTUsIE1hcmsgQnJvd24gYSDDqWNyaXTCoDoNCj4gT24g
VGh1LCBBdWcgMTgsIDIwMjIgYXQgMDY6MzU6MzlQTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4gDQo+PiBZZXMgaW5kZWVkLiBUaGVyZWZvcmUgaW4gdjMgSSB0b29rIGEgZGlmZmVy
ZW50IGFwcHJvYWNoIDogYSBmbGFnIC5jc19vZmYNCj4+IHRlbGxzIHRvIHNwaV90cmFuc2Zlcl9v
bmVfbWVzc2FnZSgpIHRoYXQgYSBnaXZlbiB0cmFuc2ZlciBoYXMgdG8gYmUNCj4+IHBlcmZvcm1l
ZCB3aXRoIGNoaXBzZWxlY3QgT0ZGLCB0aGVyZWZvcmUgdGhlIGNvbnN1bWVyIGhhcyBmdWxsIGNv
bnRyb2wNCj4+IG9mIGhvdyBhbmQgd2hlbiB0byBhZGQgdGhvc2UgYWRkaXRpb25hbCBmYWtlIGNs
b2NrIGN5Y2xlcyBkdXJpbmcgYQ0KPj4gdHJhbnNmZXIsIGFuZCBjYW4gZXZlbnR1YWxseSBhZGQg
b25lIGF0IGFueXBsYWNlIGR1cmluZyB0aGUgdHJhbnNmZXIuDQo+IA0KPj4gSGVyZSBhbiBleGVt
cGxlIG9mIHdoYXQgd2lsbCBkbyB0aGUgY29uc3VtZXIuDQo+IA0KPiBIcm0sIHdlIHNob3VsZCBh
bHJlYWR5IGJlIGFibGUgdG8gc3ludGhlc2l6ZSB0aGF0IHdpdGggY3NfY2hhbmdlIHRob3VnaA0K
PiB0aGVyZSdzIHVzYWJpbGl0eSBjaGFsbGVuZ2VzIHRoZXJlIGFuZCBBRkFJQ1QgaXQgZG9lc24n
dCB3b3JrIGZvciB0aGUNCj4gZmlyc3QgdHJhbnNmZXIgd2hpY2ggeW91ciBwcm9wb3NhbCB3b3Vs
ZCBzbyB0aGVyZSdzIGEgZnVuY3Rpb25hbCBiZW5lZml0DQo+IGV2ZW4gaWYgeW91IGRvbid0IG5l
ZWQgaXQgZm9yIHlvdXIgZGV2aWNlIHJpZ2h0IG5vdy4gIEl0IHdvdWxkIGJlIGdvb2QNCj4gaWYg
eW91IGNvdWxkIGhhdmUgYSBsb29rIGF0IHVzaW5nIGNzX2NoYW5nZSBmb3IgeW91ciB1c2UgY2Fz
ZS4gIFNvcnJ5LCBJDQo+IGRvbid0IHRoaW5rIEknZCBmdWxseSByZWFsaXNlZCB3aGF0IHlvdSB3
ZXJlIGxvb2tpbmcgdG8gYWNjb21wbGlzaCBoZXJlDQo+IHVudGlsIEkgc2F3IHlvdXIgcHJvcG9z
YWwuDQoNCkkgdGhpbmsgd2UgYWxyZWFkeSBhZGRyZXNzZWQgdGhpcyBwb3NzaWJpbGl0eSBiYWNr
IGluIDIwMTYsIHNlZSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNwaS8yMDE2MDgy
NDExMTIwNi5HRDIyMDc2QHNpcmVuYS5vcmcudWsvDQoNClRoZSBjb25jbHVzaW9uIHdhcyB0aGF0
IGl0IHdhcyBub3QgcG9zc2libGUgdG8gYWNjb21wbGlzaCBpdCB3aXRoIGNzX2NoYW5nZS4NCg0K
T3IgZGlkIHdlIG1pc3Mgc29tZXRoaW5nIGF0IHRoYXQgdGltZSA/DQoNCk15IHVuZGVyc3RhbmRp
bmcgaXMgdGhhdCBpZiB5b3Ugc2V0IGNzX2NoYW5nZSBmb3IgYW55IHRyYW5zZmVyIG9mIGEgDQpt
ZXNzYWdlIGV4Y2VwdCB0aGUgbGFzdCwgdGhlbiBDUyBnb2VzIE9GRiB0aGVuIE9OIGFnYWluIGJl
dHdlZW4gdGhlIHNhaWQgDQp0cmFuc2ZlciBhbmQgdGhlIGZvbGxvd2luZyBvbmUuIElmIHlvdSBz
ZXQgY3NfY2hhbmdlIGZvciB0aGUgbGFzdCANCnRyYW5zZmVyIG9mIGEgbWVzc2FnZSwgdGhlbiBD
UyBzdGF5cyBPTiB1bnRpbCBuZXh0IG1lc3NhZ2UgaW5zdGVhZCBvZiANCmdvaW5nIE9GRiBhcyB1
c3VhbC4NCg0KTXkgbmVlZCBpcyB0byB0cmFuc2ZlciBhIGZha2UgYnl0ZSB3aXRoIENTIG9mZiBh
dCB0aGUgZW5kIG9mIGEgbWVzc2FnZS4gDQpJIHN0aWxsIGNhbid0IHNlZSBob3cgY3NfY2hhbmdl
IGNhbiBhY2hpZXZlIHRoYXQuDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
