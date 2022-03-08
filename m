Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AC4D0D62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiCHBRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiCHBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:17:42 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50042.outbound.protection.outlook.com [40.107.5.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5723631F;
        Mon,  7 Mar 2022 17:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qophv/cIaRgxgBB/F+XAvUQa9gXN1UJFsAeBKq5NE57LTU7SN6uP7vpXUT+WVUx7NwvQze3bpFQPbAQSFjvZK31ARoGIcd0XwxJEAOR1clPzSAZGIaMFpTl2pOd3rdIU80X14Jh+iFL/IwdlZq4OtyZ2Wgh1afD2wACLZ7hQSDx4NOS+LiAfWwV0JcUJcY409RmaUoscsqeajMZ8qfJEYbtHV8f3fou4PNAfR92EiXZigynHB17CPd0rtUmahGjxpfV51HtYZprAqyKPHQcqzGwOI8o5n/6wf36GCy9O9iBisUmoOIHvU2QlDGxh9uPrV2YmmObOxXHtu7Up4rPSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7c/ahAfLZtpPOfc5jRiLvdFmDnQnMik3PzpAGyqE+SM=;
 b=B863MUfssW3OFfGwD8dj02QSSgLQMMZhsbCPhJmLBXO62wV2dV7i+JPDJpwGIHRrB/04BxDvw448t5YCDERijqHTTrbZrxVzcIYgZ//XAZ6i8Z6wurXx3REc2kaU4otQ2wF2lkdtn4IO8viqftow7sqAxe8OsrmSVrMf/A/iZuyqRKgH3/A0kkIyEk9UPvs/eDpSZ3KjjnLTxFeGKa0ZhqftVPlrXhJD6ndLRdF3RL2JKtuJ4h+Snp9YkVTUvUhjgKCp6ExNCWPXCISt10PyUDfeBhQTx4tfTYQbvTQlZ60aKM0iM/HoCObzeWcbx8rkaVLFDhGkJ5dF9NDjtKs2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c/ahAfLZtpPOfc5jRiLvdFmDnQnMik3PzpAGyqE+SM=;
 b=sQ3K1df3kF5LVOJhLmJlpV/ZKqZ0KbWygNUZDiJwwCgk83Ws3hDJGkNr96a/0mp5Rbc9f2a47V4wufkt1fSp96R0qq7k4sE1pEyhh4EpaveypkknB7WOLLZ2v2i3iO+mKidupyBn2GUFsRkyCtjVUuikqzIFzmGMsc7VvUVVV9s=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by AM0PR04MB4609.eurprd04.prod.outlook.com (2603:10a6:208:6b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 01:16:43 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4da8:6419:c67:3ec7]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::4da8:6419:c67:3ec7%2]) with mapi id 15.20.5038.026; Tue, 8 Mar 2022
 01:16:43 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Alifer Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "eran.m@variscite.com" <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        mcontenti <marco.c@variscite.com>
Subject: RE: [PATCH] input: keyboard: snvs_pwrkey: Add key-release-only
Thread-Topic: [PATCH] input: keyboard: snvs_pwrkey: Add key-release-only
Thread-Index: AQHYMi8jzQ/Pq1n1Nk+pJDS5pnj7say0r25w
Date:   Tue, 8 Mar 2022 01:16:43 +0000
Message-ID: <DB9PR04MB84120F45E6F1E283B541FF0A87099@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220307142442.28206-1-alifer.m@variscite.com>
In-Reply-To: <20220307142442.28206-1-alifer.m@variscite.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88fe7373-2317-4a48-f1a2-08da00a14e5f
x-ms-traffictypediagnostic: AM0PR04MB4609:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4609C9F9D19E8AF50F06537487099@AM0PR04MB4609.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyBqZDbV/OAx7lCvpO8pA4/XTgf8B9OTKitTznEnwmwe5hEJs4kNihRmwyBYl7AS6YeFXIgYGhfC9tWHZfWT43ha2Ms76Gor5sFjhwEPYJmorGXZiQ6cYYNVSps/q/18LZ4kNW2sY+FHs2O/QBhmPPrcFSxntQL5c8LBv0BhpHXCe9R6GaSKZsWvS+O8RwRn6ne9kBn23Q999AHegJNv+NEA8XMJhxT7iUfCHiWQ3mmZ9M9Rc2E4LciOYKHGvSQgvOB2CJzPDWAF8kmMSJyYnhuefeEPVFGAjBWs2EcJghZ0tbPM+JefJaMgx/OKzvL4MvNFUSyuhPVWT/t0E6OtwjFFdDSy4NznmZdDgsd5fD3boY2ruD9IIkapziOhGKD8LF1J/pvwli6rbY22TmjPxlclySjx3K/i1BbOHp7mWtQre0xKal7a4KHGDfV/3IpZrrqADw8ovzyd/xDsrxwBniHXNOWrrrFVrXeMGEtk8V8nindVpE+CPrleLaav6sCdUD+pTPcJkdO/5P/NWI95EmK7o3qbfpUuV9AFGwLYCZhv0S4oZe68R2qYxBGQeFuykzjEruM1mFtKvC0iU97cpEKOcXH2wXTGEzG9ThGmdV8QFHSAMuFxwZf7Vbg1MCzX3eTKy3ByIOkK8F72q51TVj7upqBlALeBYhKUxtn3p+MMfrte8eAK1xVl0gLJt47RE/bUFc9lLp90GRsLJtGvqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(86362001)(122000001)(38100700002)(5660300002)(54906003)(110136005)(8936002)(7416002)(8676002)(4326008)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(2906002)(83380400001)(52536014)(6506007)(498600001)(7696005)(9686003)(71200400001)(55016003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFVMSXU5Z3l0aHF5UTdCdDcvRmxYdHVEYlJ2a0t1ZUNNcDZEWGlTVlIxdFh0?=
 =?utf-8?B?ZTRBL00rdzhpQVJFRFF4TUhXUUF4ckxVUU9hdUxTTy9ieFF3UnVGSS83S0Jp?=
 =?utf-8?B?eTNrdlFQbFkxWjczVEtXMFV2OEJ0OGhRRjZ0VDJQbVJ0N3dkNTMyekJsSU5I?=
 =?utf-8?B?OWhYQkliN3k2dmNFTDBmRmpJbTdmaHpaVXViSFNuaElHTHJMK1FYWUNwdWpV?=
 =?utf-8?B?c2R2Ym5ndThzTWxRVk9wdmtTUlJya1g0Tk9welJ5UlJ5UGxzaFBUTG45VVg0?=
 =?utf-8?B?NjBKR25pMmhBanNYK2p6bTBrWGlDNjFXWlJ1SFdaaUhNSFVJM1BRK0VDWFFU?=
 =?utf-8?B?R0JhNmF4UFNsM2MyWjFpWFVPdTM0M01NZGVRMmdQOEpSdXZ3SmxlNGo1VlZs?=
 =?utf-8?B?QnJ1Tzd5Y3VGK3g3NDczSTBGd3g2UC9TYkpWZXcrM2hMQlJlU2FYZWtTd3k1?=
 =?utf-8?B?L3ZGaWtUNnI4QzZUSFpkNU9uYnluV2dXblkxcC85dGsrcWR0bXpnRVRmSFMx?=
 =?utf-8?B?QW5vU0ZvZ3ZFejhuTjZTZHhNenppbFFHT3poaDMxVmJLV2pvZFNaUitFMkl3?=
 =?utf-8?B?cDErdDUzbjZLT1M1am5LSjRrcjZRM1dEOTlzNU1aSFp4d3lrSVVGTzhpemx0?=
 =?utf-8?B?OUJLV0VIS3pUQUxFa3dwUWF6M1U1STBDK2FhRWlFSlB3T0RBQ1A0SFhiRHcv?=
 =?utf-8?B?NVVqZ2xLQnRKTVNoakN0OGFIUTRSeDBQeVQyeUVRWVM5QnVQeDlXdTR1a3BG?=
 =?utf-8?B?QjJxbVNlWThFRCtIOXdoNUlXUTkrK04vdHBVTzJ5dGNvOS94dlNmTzlNdGs0?=
 =?utf-8?B?aU43ZjVJN2ttdVlXQzVUSGhnVUovU2d3MkF0WGJCY2d0KzRZK0Z1bjhJRkZS?=
 =?utf-8?B?NytIZVlNUFEzM0c5cnQrVEQrSllTcVJZN1B1UmVOSG85T2pRalVicVpJVTEz?=
 =?utf-8?B?dVM4M1VQNW02R0x4V1ppMnUwR2txNlkvdWhKclNBUzBuaDFScC95cUVOZ3cr?=
 =?utf-8?B?Vy9oSGtFVlVsa3JGS1NzUGRWQjFjcUw2ZmRkTkdoNzVpbFRZbGZBTUcveXFa?=
 =?utf-8?B?bzhaaHBoSzlvNzV4S1hJYkthdE9vVnpTRDh0TVRSUnJtbWY2c0JPZTJDaXR0?=
 =?utf-8?B?ZytHNWU3UDZSSlllTVhJSEtPeUpTZFhpQXNqUnd4UTFFNEg3cHhIQldBZzFV?=
 =?utf-8?B?UTVZQm9zS09ZK0JVK3JzbklpaVhlYVlTZ3c4Z3hDWnFFSG5saWZrakpaajA2?=
 =?utf-8?B?YnJDb3VKVVdwUmJibWRIdDNoa0kxZk9jQk9hZ2NRT2duZXFXUEV1bWJFMkI2?=
 =?utf-8?B?TE03Vkt5ODVubFp6ZDl0SVNIblFCUHdRSHh1MXlZNGtLZEJySG11UzBvcC91?=
 =?utf-8?B?SmpJVHFiaHhwanEySkJHeExTUlFET24wcnBmTDYwK3ovUmFnZkNYNFR4QXAz?=
 =?utf-8?B?eXJtU1Y3M2JyNmN1NkNkQ0dRemdDZkNXZ0Q1RHdJZXdnQnhZbWV4L1JkU2tJ?=
 =?utf-8?B?WmMrajZXelVVWnlwUUFUeGhWa1Q3R1V4bkdieUNVVUptQ2xlbXNWSEdPc3lz?=
 =?utf-8?B?d2R1VWEwVmFVbXRQZHVEdzJYcGdya04yTjVPbVhqb1o5UkpMcTF6R0hxUnoy?=
 =?utf-8?B?cmVqbVVMZ0xTWjY4QkNvWTF6dWc4K0lQYk5WaFBMSW04U1VLbXV1WVF4M1Bs?=
 =?utf-8?B?Y1dIMG5YeGV5bEpacFBmVGN2RGR4N3VUbXlyRkdhL1U1bHE5QnRQcUFYc2E1?=
 =?utf-8?B?QzR3NWljQUlZVWorSk9pbzVQL2NaNzlIT09kc1JvSy84SVhiTVErNnRUSzds?=
 =?utf-8?B?eHBIK0oyYkxWQk5JVXpsOWlLa1RDSHhpL3Nxb3RLL3lKWSs0YzcvSkZ6ck15?=
 =?utf-8?B?Rlp5TXRONkNwVmJ6LzVNbTR5VEpiNVFLZGtOZUN5bXFDUTlOUjRYOG1hUXpJ?=
 =?utf-8?B?dklFSExFUHowZy90VmNiYUdqVWpjbkFTMlFhTjlITSs3cGc1ZDhSaWVCM0tP?=
 =?utf-8?B?eUtON1grSDFkOHo3a1hkaFdQV1VSNGdRcGJaS0tod0pUWUordWhqSHZIZXFv?=
 =?utf-8?B?cEYvOWtUOS9MUWUwSXF0L3U2ZlpDcXB0YThGbGx3b1VKWGJJc1dKNVpmS0xX?=
 =?utf-8?B?V3hoZE44bDNZSUdTNDR3TUNNdmUvMU0rdWVqbng2KzdaeU5UMG1qTWlyekd4?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe7373-2317-4a48-f1a2-08da00a14e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 01:16:43.0210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhBVTcAH/9iKd/HDWPBP3oi3kUQLrlHsPXzKYHiOZcM3wBrfEEgCwfKzNsKYMEDh+hmgQADr1PP0dKITOfBb7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0hdIGlucHV0OiBrZXlib2FyZDogc252c19wd3JrZXk6IEFkZCBrZXkt
cmVsZWFzZS1vbmx5DQo+IA0KPiBGcm9tOiBFcmFuIE1hdGl0eWFodSA8ZXJhbi5tQHZhcmlzY2l0
ZS5jb20+DQo+IA0KPiBPbiBpbXg2cWRsIHRoZSBpbnRlcnJ1cHQgb25seSB0cmlnZ2VycyBvbiB0
aGUgcmVsZWFzZSBvZiB0aGUga2V5Lg0KPiBOb3JtYWxseSwgdGhlIGRyaXZlciBpcyBsb29raW5n
IGZvciBhIGNoYW5nZSBpbiB0aGUgc3RhdGUgb2YgdGhlIGtleSwgYnV0IHNpbmNlIHRoZQ0KPiBp
bnRlcnJ1cHQgdHJpZ2dlcnMgb24gcmVsZWFzZSB0aGUga2V5IHZhbHVlIGlzIGFsd2F5cyAwLCBz
byB0aGVyZSB3YXMgbm8gZXZlbnQuDQo+IA0KPiBBZGQgImtleS1yZWxlYXNlLW9ubHkiIGJvb2xl
YW4gZHRzIHByb3BlcnR5IHRvIGFkZHJlc3MgdGhpcyBpc3N1ZSwgYW5kIGNyZWF0ZQ0KPiBib3Ro
IGtleSBwcmVzcyBhbmQga2V5IHJlbGVhc2UgZXZlbnRzIHdoZW4gdGhlIGtleSBpcyBhY3R1YWxs
eSByZWxlYXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVyYW4gTWF0aXR5YWh1IDxlcmFuLm1A
dmFyaXNjaXRlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogbWNvbnRlbnRpIDxtYXJjby5jQHZhcmlz
Y2l0ZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsaWZlciBNb3JhZXMgPGFsaWZlci5tQHZhcmlz
Y2l0ZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpICAgICAg
IHwgIDEgKw0KPiAgZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtleS5jIHwgMjEgKysr
KysrKysrKysrKysrKysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2
cWRsLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gaW5kZXggZDI3YmVi
NDdmOWEzLi45ODExZTZiZmQ4ZTUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gQEAg
LTg0NSw2ICs4NDUsNyBAQCBzbnZzX3B3cmtleTogc252cy1wb3dlcmtleSB7DQo+ICAJCQkJCXJl
Z21hcCA9IDwmc252cz47DQo+ICAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA0IElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiAgCQkJCQlsaW51eCxrZXljb2RlID0gPEtFWV9QT1dFUj47DQo+ICsJ
CQkJCWtleS1yZWxlYXNlLW9ubHk7DQo+ICAJCQkJCXdha2V1cC1zb3VyY2U7DQo+ICAJCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQkJfTsNCg0KZHRzIGNoYW5nZXMgc2hvdWxkIGJlIGlu
IGEgc2VwYXJhdGUgcGF0Y2guDQoNCkJSDQpKYWNreSBCYWkNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvc252c19wd3JrZXkuYw0KPiBiL2RyaXZlcnMvaW5wdXQva2V5Ym9h
cmQvc252c19wd3JrZXkuYw0KPiBpbmRleCA2NTI4Njc2MmIwMmEuLmI1NThlNmY4OThmYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zbnZzX3B3cmtleS5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvc252c19wd3JrZXkuYw0KPiBAQCAtNjYsNiArNjYsMjIg
QEAgc3RhdGljIHZvaWQgaW14X2lteF9zbnZzX2NoZWNrX2Zvcl9ldmVudHMoc3RydWN0DQo+IHRp
bWVyX2xpc3QgKnQpDQo+ICAJfQ0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIGlteF9pbXhfc252
c19jaGVja19mb3JfcmVsZWFzZV9ldmVudHMoc3RydWN0IHRpbWVyX2xpc3QgKnQpDQo+ICt7DQo+
ICsJc3RydWN0IHB3cmtleV9kcnZfZGF0YSAqcGRhdGEgPSBmcm9tX3RpbWVyKHBkYXRhLCB0LCBj
aGVja190aW1lcik7DQo+ICsJc3RydWN0IGlucHV0X2RldiAqaW5wdXQgPSBwZGF0YS0+aW5wdXQ7
DQo+ICsJdTMyIHN0YXRlOw0KPiArDQo+ICsJLyogaW50ZXJydXB0IG9ubHkgcmVwb3J0cyByZWxl
YXNlIG9mIGtleSBzbyBkbyBub3Qgd2FpdCBmb3Igc3RhdGUgY2hhbmdlICovDQo+ICsJc3RhdGUg
PSAxOw0KPiArCWlucHV0X2V2ZW50KGlucHV0LCBFVl9LRVksIHBkYXRhLT5rZXljb2RlLCBzdGF0
ZSk7DQo+ICsJaW5wdXRfc3luYyhpbnB1dCk7DQo+ICsNCj4gKwlzdGF0ZSA9IDA7DQo+ICsJaW5w
dXRfZXZlbnQoaW5wdXQsIEVWX0tFWSwgcGRhdGEtPmtleWNvZGUsIHN0YXRlKTsNCj4gKwlpbnB1
dF9zeW5jKGlucHV0KTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlycXJldHVybl90IGlteF9zbnZz
X3B3cmtleV9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKSAgew0KPiAgCXN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBkZXZfaWQ7IEBAIC0xNzcsNyArMTkzLDEwIEBAIHN0YXRp
YyBpbnQNCj4gaW14X3NudnNfcHdya2V5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJLyogY2xlYXIgdGhlIHVuZXhwZWN0ZWQgaW50ZXJydXB0IGJlZm9yZSBkcml2ZXIg
cmVhZHkgKi8NCj4gIAlyZWdtYXBfd3JpdGUocGRhdGEtPnNudnMsIFNOVlNfTFBTUl9SRUcsIFNO
VlNfTFBTUl9TUE8pOw0KPiANCj4gLQl0aW1lcl9zZXR1cCgmcGRhdGEtPmNoZWNrX3RpbWVyLCBp
bXhfaW14X3NudnNfY2hlY2tfZm9yX2V2ZW50cywgMCk7DQo+ICsJaWYgKG9mX3Byb3BlcnR5X3Jl
YWRfYm9vbChucCwgImtleS1yZWxlYXNlLW9ubHkiKSkNCj4gKwkJdGltZXJfc2V0dXAoJnBkYXRh
LT5jaGVja190aW1lciwNCj4gaW14X2lteF9zbnZzX2NoZWNrX2Zvcl9yZWxlYXNlX2V2ZW50cywg
MCk7DQo+ICsJZWxzZQ0KPiArCQl0aW1lcl9zZXR1cCgmcGRhdGEtPmNoZWNrX3RpbWVyLCBpbXhf
aW14X3NudnNfY2hlY2tfZm9yX2V2ZW50cywNCj4gMCk7DQo+IA0KPiAgCWlucHV0ID0gZGV2bV9p
bnB1dF9hbGxvY2F0ZV9kZXZpY2UoJnBkZXYtPmRldik7DQo+ICAJaWYgKCFpbnB1dCkgew0KPiAt
LQ0KPiAyLjI1LjENCg0K
