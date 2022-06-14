Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6754AD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiFNJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355494AbiFNJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:38:52 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2104.outbound.protection.outlook.com [40.107.135.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A683D495;
        Tue, 14 Jun 2022 02:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1PSLfsEfqR/kx15ZzafJoYQ4oirx9Vhe3exVWhG5IBc7SmCB+GaiHBtMxQYijXp8dWGSbcwG8SH8LzKAXRs/09+MArGu9O3gUUhrvLn2LLI2o4jKRN4km3/UhhNqL4pKtka5WisXhcKJk8zfy/1E0C/Qtp88qT6VjYXE8iBW6k1r7fKqnAQGSVLX3DMAIzvs6oGZqZG+uRujUKu0zpx42etq3DkGAKJBhN+bnIRD/lek0UbZKyuFMM3T0RkvqF4JuPm85h5nEefysLcs9EZ2LEcJLFSvU2FyJ+CruJ6viM3tTwxMyUA/4ANMxBwk1bFPBxdViKJknx6BDStT0jmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWm6ssMKEY7t//y1mUcwX0QxYl57ww7JGwvMSScih84=;
 b=N+478AyAc2wAhpFloHXSZHge7V1Oj2rpgwSCOJzqkaq3Mb5kDWojw5CoYHPEhyiy9fKz0OPAm6hKOY1xWZP+55nxsOZf20tRpvcYvk4edVff2KeGFWBdj7smtXjprh7EYOv5GPwSf+dt1FXj+SHCEyXtW0eOwDKZWPb/PBYYDsBYiVWLz2jbmPI+TWQvkG3XRfwf9qQ12wxk/P99ZUCD+LeR2+i76F/fsxjAsFmCUyzXzZjs5/VvvRduPVB/9lFMWNOgw6Ncm8XTIG+cn/AR/FixuOE+EoX9rYWWwwUEesnHr3VsztopmVXpnwfH76ftquhd3zH2tjevmZMQMmz25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWm6ssMKEY7t//y1mUcwX0QxYl57ww7JGwvMSScih84=;
 b=buda6rh24hHGxJce2yk1CHLQHWRosUhuZ/EyM/oFeiujOpfjou83Av/G8H38EiYTKYib6U+ah2Hoz1Hg5pjBgWLCvCGctfEeHcVInNHLgf/EhCprrVImHgDRC9oaoOgN5CszHzsNviLQvWoD5elnrYOrEAbhVgxwecuOqF+Bq6E=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE0P281MB0194.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.11; Tue, 14 Jun
 2022 09:38:47 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84db:ff67:63a4:bd38]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::84db:ff67:63a4:bd38%6]) with mapi id 15.20.5353.013; Tue, 14 Jun 2022
 09:38:47 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
Thread-Topic: regulator: BD71837 PMIC resume during noirq phase?
Thread-Index: AQHYf84FTXTME6yl/0+UAaeR8Ky7hq1OpXoA
Date:   Tue, 14 Jun 2022 09:38:47 +0000
Message-ID: <bf361642-2315-c654-613d-d732e51a4e6e@fi.rohmeurope.com>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
In-Reply-To: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5d6b3f-01bb-4bdf-f2ce-08da4de9ae21
x-ms-traffictypediagnostic: BE0P281MB0194:EE_
x-microsoft-antispam-prvs: <BE0P281MB019486342A9E8502AE72937AADAA9@BE0P281MB0194.DEUP281.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MgzxY3dz84pNQsaSY3JO8E3Z16V5B7fA5LZaqDeo1ZEaC4suPZCHQxoEHsZ5KlkPFGj/aLrMAYQKtG3xRocZcB0/Sw4hbEHXlTa5Bfel2f+6OgE4iDFJoEB5xRetMEEdgMp8cjb6QXo12/oPb+iPUXTgWdCe9aGjeh1CruVVXTWxDV+4K/t0rZxASzVUejnwmaFhHqPBbJ09nVuqJVxLa7WTVFgfZ0eNFqwnZAIta7GrmuT6WI7suOGWkbRWg1s1vAhNa089BC8iLE8mcfXYTRJ8fiwX0qfP1e66f//hlWbY4F/QWXxSeigE/SnDyTmOZHwT1zj28ch02KrFLdpJKBubBLDcM8u2e+7a4paux0FBk39tr+/lhnTq6JDAk7qIIEwlKAVO/qt8m0cd+0d/Fr/R3RiDDtq9DFi2pZHbC9wc8Ai3Knb6UAvoIvvWemkMJE6un4sNQVyj62pIUB3Xd1Bnew8xSQn7AjTkzmSB3QbLZjBVWwL3Zm1iZofOzr6NYSvkHYlL560q0sTLZ5WhnCnKMjdVBWfkiOs+BOXKmYZy4/fos/0uQgLU07+2toHkrU/mkqY5ulNtdN+n2Q4ly7y4yqDE1cy2j4bl0npvEnpdhxP6sto6azjbtEuUUVvp+qIj+ODkmWlmrkdAg7OBYt+l39IKzmgCpVclKJpXA77h6XB3tII60T9+N5b9RQR83S7IFMyVkveabjyT/fyjc5SO6huOdPcVBIo027hp7UiXV9N8D1DW8c+UDfIVA5RjH1GDtApuURghKoscPDLLhqcUjSDqHwVMp01MwmlCpzHuxtHGhrGndt76fUnHn3JeFbPluY5LyFg/WFgJLMtKsJt/9XCj2IWigQZ+1cUl+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6512007)(508600001)(86362001)(31696002)(38070700005)(316002)(6486002)(966005)(71200400001)(5660300002)(8936002)(6506007)(2906002)(54906003)(2616005)(8676002)(4326008)(66946007)(122000001)(76116006)(31686004)(64756008)(110136005)(53546011)(66556008)(91956017)(66446008)(66476007)(186003)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5Ua2JKN3U2YXZ2d1VvS0ZDQ1o4UERjcVltZWlXNXVReFNIcm1SbU1FdUx4?=
 =?utf-8?B?VlNMMDlOMVZFTlM0Z09uak1QalR5bElGYWVVdlJSY2J3WXFGeCtkU1dmOWpN?=
 =?utf-8?B?YVN6VWJ1WVBEbnc2cWVkdVhlMmxKMXBzRlk3SzA1TzJKcmxuaUtYU2RwRmJw?=
 =?utf-8?B?bURxaC81d3lmWnNnVUwvaWdYWGVqUzRha2VJNVRIdUNPS0xPVTVCelBMNERu?=
 =?utf-8?B?SklzMnc2eEZET1B1Qm1kajVrRGN3SmFQNm5JcStWTWdCR0xzc1hRRDZYQ0tv?=
 =?utf-8?B?MlprSjdrL0NEQmFLYjJFOGdtQ0pEZUQvTG1aVTFLb1JWUFNNY200MUprdTJ1?=
 =?utf-8?B?ZWFxOThucnNtWlBNQnppSEV3Ky9wQStKZTlheGNXS05sMDdVL2x2NWd0Z0Ni?=
 =?utf-8?B?ckNjK0VBTGFSRVA0OVVidE9MZVRkaEt3MDgzMEFjU1ZZT2NKOFExbHlCM3Ju?=
 =?utf-8?B?SEgxcGtSWDgxa2YvSjA1VzU5YTZCeG9JVzBsMVVYRUpNeGc1UkZOZS9BbHJ0?=
 =?utf-8?B?dVhTK2pWTWpXclUvSWRpSmd4WXIzNWlvNFM3a3M3QytuOHFScE1CbUdhdzRL?=
 =?utf-8?B?TG1JZDRIM1BydVhlZFhMUDhZekcxWUlCOG5MTHZhR3NRZVZZd2xPTVhJRU4w?=
 =?utf-8?B?TnNqMGFscW5zb2N3elFoY3FCdHU3Vk4wZ09kRlY4VS8wRVpkY0tYRVZxdjJk?=
 =?utf-8?B?VUdRaGxKams2R24zaVVkSkZhM3VNMWVFekxLY3BEVUVKdTNYWm9aamVVajlS?=
 =?utf-8?B?Y2x2M0w3Vy85TnZ6emNYUzlVT0JKdmtKZTBnYmNDOUNqNi9HNkVlZ0tJbDFH?=
 =?utf-8?B?R1JzREJDUDRZZzA5cGpHV1ZwbmN5TzlURHRJZHdueWN6MG9jUCsyUFdNemNh?=
 =?utf-8?B?MHBsV21xdyt6b2l3WlU0clZ3UXRiZmN6aGFjS01iUW5ZVG1BdWVBM1lmUC9C?=
 =?utf-8?B?Q0JGVSs0K0pSZmdDK0JjaS81aWkxakZ3TTk4ZzhNek9Gc3ZnK1BZSmRNbjg4?=
 =?utf-8?B?bXlmMEtFVkp3UnMxcWdRYlplS2VMLzhWdUhheVY3Y1pONmdicmhGeGRrekF6?=
 =?utf-8?B?UFRNdGZsTG8yTUtJYllPd252Y09nS3JsclhhL1FUelc4UWlGS0QzaHRFQTY0?=
 =?utf-8?B?bzFQR1h1UGRTYWpqZGE5QUJORzhMdS9BYVh3b08zNWMzZDYydlZ6enI5VHFa?=
 =?utf-8?B?TllJYzBtZXdTRk0yRFB5UHEyMU5Qa2NIWFF3VzhjTnI1VGp0QTRYcEp5ejF0?=
 =?utf-8?B?V2x2b2l6NmNjMWtmVWVpWmxYZzlENkxmYW04cmo4dzMvczdRYko2WFVrcXlp?=
 =?utf-8?B?ZzdFeFV4VFlFVVBIeXlhUXo0YTZNV25wSG92UXh6STV1MGluNTRpVDVRNVIy?=
 =?utf-8?B?SU9kaDNXSXhnL2x0WkR0amQwa1FYaERmbllDVmh1b0ZsWldublNRUUZSVnFN?=
 =?utf-8?B?WTBjRmVlayt3bXpNWjhzemk1ak90QXgrZkl6U2RNM093WnMvdGh0L1g0SE9h?=
 =?utf-8?B?WDl6b1NKSElNajd4cmlPUVZTTXROd2M5WU8rOWJTMkFzditmY3VDWi9Xa055?=
 =?utf-8?B?RFJlSDdFOG5nQjFpQTM3cXpwYUUxQnIwdFkyMGN3K0N3Z0tRZHlNK0tsbFlY?=
 =?utf-8?B?WUpsZ2cyWnI4TkYvMmlFZEhIQXpiZDdIbS9ndmRxaVBqNzNHaFJWN2JQNWNC?=
 =?utf-8?B?WWsxVzdEa2xwVUpNZDY5blZIcWJLa3o2QjNIek1KMC9qdEZoemsxRjF0UEF4?=
 =?utf-8?B?RzZvREdaMmJBZmdCOHNqOHdUMkZvZkhNZ3dUcGNyN2IrMkdIcW84NXpRak96?=
 =?utf-8?B?NXEvOStiZk9kbDVKcVJqeUtkWjBjalppUW5RS2JHdGFvdUxNNUFRSUR1eVhT?=
 =?utf-8?B?QkhXZFNRL051QzVsbUgzUXRGWHdyS2lxelZUN2o4MTg1cExoZk45d0NsNlVm?=
 =?utf-8?B?M1oyR3JwL0hwd2xnYnpQeU9rcWNRR00rQlpOV1pTSUNiTDFOejlpKy9neTk1?=
 =?utf-8?B?VmFLN2Iybk9nNkVnaDFLdUwvRCtXMWw5cmNJMkhocW5TNis3TnNFV0RHdk9T?=
 =?utf-8?B?MWIvV2pPeFpLdTJsMEY3QlNWWlVwZUFhaHhzVjR5bzJqdjNzdHVQVVpOTDlu?=
 =?utf-8?B?OUYwNTVwemg2S0xiYXZuYUE3Qlo2RmdUL05uNDZOdmFTeUhqV0puTy8wMTE4?=
 =?utf-8?B?cGJMcU5ZKzM3SDBZS2ZKTWxxS0xoYmVlVEF1ZVJ4RFBKZGNaTk1HTnR3RVNE?=
 =?utf-8?B?VTUvdkQ0aWR4ZUJjQmVqUWtxRDZGaVU0aXRKS0tYK1kwOEw2S0NaNmFhQ0tV?=
 =?utf-8?B?aExEekYvbXNlR2xtN2VnS0hSS3pwS2NqR0w4ajgxaXdpdVVZMVpuVmVYZURr?=
 =?utf-8?Q?YwObBBX5JSWfajbotMCXKW78yQtCak1ppJdrw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B86F5A3C74D0D47BD8145A99D686124@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5d6b3f-01bb-4bdf-f2ce-08da4de9ae21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 09:38:47.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgvPwGTyXqIByffjlWddMdY1SPjbridjoHmDOXccH3oDr0UdPI/R26emFVCJ58xwu3TrnDvruJMvVXLZ/l9HFl9/IMGDrWVxgIMv2DZrTJtMKypeyBfM7lIwRCxCU1tU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0194
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlIEhvIE1hcnRpbiwNCg0KT24gNi8xNC8yMiAxMjowNiwgTWFydGluIEtlcHBsaW5nZXIg
d3JvdGU6DQo+IGhpIE1hdHRpLA0KPiANCj4gSSBoZWFyZCB5b3UndmUgYmVlbiBoZWxwZnVsIGlu
IHRoZSBwYXN0IC0gdGhhbmsgZm9yIHRoYXQhDQoNCkkgdHJ5IHRvIGRvIHdoYXQgSSBjYW4gLSBJ
dCBtYXkgbm90IGJlIG11Y2ggdGhvdWdoIDovDQoNCj4gSGVyZSdzIGENCj4gcXVlc3Rpb24gSSdt
IGN1cnJlbnRseSBzdHVjayBhdDogSW4gc2hvcnQsIGlteDhtcSBjYW4ndCB5ZXQgcmVzdW1lIGZy
b20NCj4gc3VzcGVuZCB3aGVuIHVzaW5nIHRoZSBiZDcxODM5IHBtaWMgdmlhIGkyYy4gVGhlIG9y
aWdpbmFsIHJlcG9ydCBoZXJlLA0KPiBqdXN0IGZvciB0aGUgYmFja2dyb3VuZDoNCj4gDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvMmQ1ZDNiYmVjNDQzNzQyNTA2
ZTM5NDg4ZGJmYmY3MjRiYjRjYTkzZi5jYW1lbEBwdXJpLnNtL1QvI3UNCg0KT2guIEkndmUgbWlz
c2VkIHRoaXMgb25lLiAoSSdtIG5vdCBpbiBDQyAtIGFuZCBubyBrZXl3b3JkcyBsaWtlIGJkNzE4
MzcgDQpmb3VuZCA9PiBtYWlsIGZpbHRlcnMgZXZhZGVkKQ0KDQo+IA0KPiBCdXQgaGVyZSdzIHdo
YXQgSSAqdGhpbmsqIGlzIGdvaW5nIG9uOiBXaGVuIHRoZSAoYnVjazMpIHJlZ3VsYXRvciBmcm9t
DQo+IGJkNzE4MzkgaXMgdGhlIHBvd2VyLXN1cHBseSBmb3IgYSBwb3dlciBkb21haW4gKGdwdSks
IHRoZSBwb3dlciBkb21haW4NCj4gZHJpdmVyIGNhbid0IHJlc3VtZSBiZWNhdXNlIGJ1Y2szIGNh
bid0IGJlIGVuYWJsZWQgd2hlbiB0aGUgcG1pYyBpc24ndA0KPiBydW5uaW5nIHlldC4NCg0KTXkg
Z3Vlc3MgaXMgdGhhdCB0aGUgYnVjayBlbmFibGUgaXMgdHJpZWQgd2hpbGUgdGhlIEkyQyBpcyBu
b3QgeWV0IA0KZnVuY3Rpb25hbC4gVGhlIEJVQ0szIChhbmQgQUZBSVIgYWxsIG9mIHRoZSByZWd1
bGF0b3JzIG9uIEJENzE4MzcpIGFyZSANCmNvbnRyb2xsZWQgdmlhIEkyQy4gVGhlcmUgYXJlIG5v
IEdQSU8gY29udHJvbGxlZCByZWd1bGF0b3JzIG9uIEJENzE4MzcoKikNCg0KKCopV2VsbCwgeW91
IGNhbiBjb250cm9sIFBNSUMgc3RhdGUgd2l0aCBHUElPIC0gd2hpY2ggY2FuIGJlIHVzZWQgdG8g
DQp0b2dnbGUgYWxsIFBNSUMgcmVndWxhdG9ycyB0byBwcmVkZWZpbmVkIE9OL09GRi9WT0xUQUdF
IHN0YXRlcy4gKG5hbWVseSANCnRvIFNVU1BFTkQsIElETEUsIFJVTiAtIGRvbid0IHJlbWVtYmVy
IGFsbCB0aGUgZGlydHkgZGV0YWlscyB0aG91Z2gpLg0KDQo+IEknbSBzdGlsbCBhIGJpdCB1bmNl
cnRhaW4sIGJ1dCBoZXJlJ3MgdGhlIGxvZ3Mgd2hlbiBzaW1wbHkNCj4gcHJpbnRpbmcgaW4gdGhl
IHJlc3BlY3RpdmUgc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2tzOg0KPiANCj4gWyAgNDUyLjE5OTYw
MF0gYmQ3MTh4eC1wbWljIGJkNzE4MzctcG1pYy4yLmF1dG86IGJkNzE4eHhfcmVzdW1lX25vaXJx
DQo+IFsgIDQ1Mi4zMDE0NTBdIGlteC1wZ2MgaW14LXBnYy1kb21haW4uNTogZmFpbGVkIHRvIGVu
YWJsZSByZWd1bGF0b3I6IC0NCj4gRVRJTUVET1VUDQo+IFsgIDQ1Mi4zMjA1OTNdIGlteC1pMmMg
MzBhMjAwMDAuaTJjOiBpMmNfaW14X3Jlc3VtZQ0KPiBbICA0NTIuMzIyMTUyXSBiZDcxOHh4LXBt
aWMgYmQ3MTgzNy1wbWljLjIuYXV0bzogYmQ3MTh4eF9yZXN1bWUNCj4gWyAgNDUyLjMyMzg1M10g
aW14LWkyYyAzMGEzMDAwMC5pMmM6IGkyY19pbXhfcmVzdW1lDQo+IFsgIDQ1Mi4zMjQ3NzhdIGlt
eC1pMmMgMzBhNDAwMDAuaTJjOiBpMmNfaW14X3Jlc3VtZQ0KPiBbICA0NTIuMzI1MDE3XSBpbXgt
aTJjIDMwYTUwMDAwLmkyYzogaTJjX2lteF9yZXN1bWUNCj4gDQo+IGFuZCByZWd1bGF0b3JfZW5h
YmxlKCkgaW4gaW14LXBnYyBpcyBjYWxsZWQgZnJvbSBnZW5wZF9yZXN1bWVfbm9pcnEoKS4NCj4g
DQo+IEF0IHRoaXMgcG9pbnQsIGRvZXMgYW55IHdvcmthcm91bmQgb3IgZml4IGNvbWUgdG8geW91
ciBtaW5kIEkgY291bGQNCj4gdGVzdD8gSSBndWVzcyBpMmMgbmVlZHMgdG8gYmUgcmVzdW1lZCB0
b28uLi4NCg0KSSB0aGluayBzbyB0b28uDQoNCkJlc3QgUmVnYXJkcw0KCS0tIE1hdHRpDQotLSAN
ClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0dGkgVmFp
dHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFu
ZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+IHRo
aXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+DQo=
