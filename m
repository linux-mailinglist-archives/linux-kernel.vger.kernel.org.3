Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0E530736
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiEWBlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351982AbiEWBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:41:06 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B2DE95;
        Sun, 22 May 2022 18:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqZJ2QuFjQiZkO1oc0370LaKmjgMrlKsb3S4h/qwhrzA6AtX1KQEXHB4tAuVeDvIQEWh0MWGtznOggMCaZXYN1FwOHdDFUI7u0n1fvg/FoPOnKp4mFDI/Z2sLwEqdTrG/M2jSk4yVAW3vOHZObSQtL0BPRrXUTgVvd8dcmBVq3IG/sbHebB1HGUtxprEyZaia0Uq44lIZQJxbcDIDdECdJE/zqfNM1F/Oi486C0r7md3XZMQYebxZnYE8GfU7J/feGq3UAQ+XpngIxceI1KiC1R19Ys/aL5qgo6L/C0s9fCrK75W+/8VBqWyT31C8/SbCzp0CJ3vd9ijy4oOamVD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsEKP9YqqSRc/7RLHtNsjF8HJZtA4tV48F3sAeI1ibg=;
 b=Q+2Hy1rZ5PvsbOVCPJniajSOxJeKbamldWO7wPEW9vWFF32XDCphQ7U1G+5gpvNsvQaCsd91bCVhJ8ptDkkI8tpyUMlV7SwantiyldfW7dxxziYngcnwdysi6GFEcLwyTwrwcGiWE1iVdO+n6+u1DjNFkbYYkNnrn5Af2fYeXWLLbaEVAW0zJckopQ4TTHlMmQa/FVqGeqIQWH3kCQhA/Gj2G7nAQMXwWA8uiuRBQMZCJrz3lzekkzRC9iwuyXeopQYKr6VNwzVTH7gp6DOrPNs4aKC00k0oLRrClF3R5JIAqRCWd6z9kunMOWiSpzyPRgrtAOhaqdZ8G+/TsKrrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsEKP9YqqSRc/7RLHtNsjF8HJZtA4tV48F3sAeI1ibg=;
 b=f2klOsFnx4wh+zqsKLz6sBUaAQBVMbYyihkSWQGV+C4NUKC3tXeovm6wYr1II4kWG92MXA/yUMKkWcmJOyUvQsG87EiAQGEpyt1mlvN+04ktQRkHFk/v9U9sHEsKri++s8RUy95q5IMfyKDlvheMWLCvEY5R8MswVIoBejh1KO0=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4166.eurprd04.prod.outlook.com (2603:10a6:209:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 01:41:01 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 01:41:01 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: amphion: return error if format is
 unsupported by vpu
Thread-Topic: [EXT] Re: [PATCH] media: amphion: return error if format is
 unsupported by vpu
Thread-Index: AQHYa1IjNpIg22tPvUuo55ULLbP5Xq0mgWIAgAB2L0CAARtBAIADorNg
Date:   Mon, 23 May 2022 01:41:01 +0000
Message-ID: <AM6PR04MB6341756721E13E6F15F6A826E7D49@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220519072844.31792-1-ming.qian@nxp.com>
         <e03669333c20c07d40d0b1ce05eb771f5dbd4139.camel@ndufresne.ca>
         <DB8PR04MB634682E34667F804608E3018E7D39@DB8PR04MB6346.eurprd04.prod.outlook.com>
 <6187a0514757dd50734175ceebcc0061d8eb6c5b.camel@ndufresne.ca>
In-Reply-To: <6187a0514757dd50734175ceebcc0061d8eb6c5b.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff78ef1d-716b-4feb-2279-08da3c5d4b40
x-ms-traffictypediagnostic: AM6PR04MB4166:EE_
x-microsoft-antispam-prvs: <AM6PR04MB4166229AF1F7FB5B9B372B26E7D49@AM6PR04MB4166.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55+3v6AGHJFzCq4wbb1RaHxp951QHIT/8heKZHFhlBpdNJIg1yDOB5SnxqZuSnm2Bx9smrSNe9UqfY+vXOC816oGsP2PF3/ZUarSo+neenyCQ36FG9jYlsX8A3HtZxnSNfj/i2O7KPLP1c5PQQ0drfR/N4PLI2eQukCQ+tExsK60LTNPF5bP8dZl2+I0/f2m9OolEHUGo+ZzvK2qLTgsrOQoPT3SPYWb1EzvlE8/vYJoxEFMPsOlEw8Xp+cev9rGL9qMfNcO4ShZIciQG0JJgcST6pKut234EUBIl0u0xSbtNc2TN0afSrcyG6XUDjPxgjdCzReW2Qd8h/wGDfTZbXCkJ1YlAK/kqAivEU3ToBCVYpCY03QFVSxRz77retZ8l9GxZXeKJw/EOEUodiEwR5JkTqtAqW8X9o4FBgsE7xdFkkXO2XsQceG3MdVk4fOVVGbBwYRvO+gfj9XJxg8az5fdJtLhEdmbQqJqOmXoFD7LUPeVac/f2qUsH0WdpBD0pMtShGx/8TDc7oBYI73GNO7XKw60vGwQTBv7NBMrHvZiqu2MSBVg5E+oLvnZ5SH43FVJwW2D++qkLxC+0ZUQR7CabsvzmPI6q3diDcY4aFpjnqvik27K82CqscSLqKmp4cyXxVIP+XkdCQl1B1AqJdiW9WIK3mqIcB9+NJs3BGXDLpM44li8QXyTkhJfNhVVf71vHqONFofiAA384EUOMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(2906002)(4326008)(8676002)(33656002)(86362001)(186003)(316002)(54906003)(76116006)(122000001)(5660300002)(83380400001)(66946007)(53546011)(52536014)(44832011)(38070700005)(38100700002)(508600001)(55016003)(71200400001)(66476007)(66556008)(6506007)(64756008)(66446008)(9686003)(8936002)(7696005)(26005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3JydERJM3BtRU5LdHpCKzRFNTdtZFZ2Vm0rQmxaaDBiQ0tUZ0hTM0R6aHRl?=
 =?utf-8?B?RHUwS0d4cytKa2ZEOVNQc0JNUGtPcXZVajJxeW02dEhSeTUvOEdOaVRKRE81?=
 =?utf-8?B?RDhVU29vU0pLZDFGWlhHb2gwWG1IakhpQnVvZis4Nmp0OHNETzlCTGxTN0NX?=
 =?utf-8?B?bk1VRVhDaTQvQTdjSHhsSHdvY21RZCswa29FQ0RmbXBhOWZSSzkybWlKdkdz?=
 =?utf-8?B?enJobHQ0cXBINVZKYmtGRGtlWlBPN3Q1dkVnMXpGckloWjdUUkg2YnJvWVlQ?=
 =?utf-8?B?ckFzejFyS1lPeHd0QnptSzBmb0tQWERObnVZUG04aTV1VFVQZURUZ0oxcXo1?=
 =?utf-8?B?WHVSa0hWT2Y3SEFLUGV4ajRxN2RUYW9UN1NjRk1YQmVrck95YXRxd3BmSHRy?=
 =?utf-8?B?Nkh4TXk1MmJSaExPd1ljUXBtcnF3NkNGeVhLcmpYM1JTcXhUbDNjakxTUXli?=
 =?utf-8?B?NXlMOG1qaEF3QzdWY3VRRXVhZ21GTzczYXRYMDY4RlA0RElwdWtlOC9MVnhW?=
 =?utf-8?B?YjNqOGZ6alkwTXV6aksxWVRLRlFUZ2xMbktFU0MxWml2L2J4VW05U2Zndkoy?=
 =?utf-8?B?bEg1U0x6N3NOM2gwdXcrUVBQaEx6TzBYczdvSlRvRkE5WUdUTHBVWU9KQWVU?=
 =?utf-8?B?NERPQkFiY2RyTTVwcWx0VEp3U1k2OGZtZ0ZlWS9zc2l1VzAweEQ5QU5FU3FW?=
 =?utf-8?B?dmRYenFPdkJ4L3g5MWxyOFZGTy9yVEhHcGpTRk9pRG1PcHIwWWZUakIrYlhD?=
 =?utf-8?B?SEVNS2VjMFVxWHJRRHpJd2J4VkZBNVNiVkFpNnIzOWxsRWk4bG00UGlHUkN5?=
 =?utf-8?B?ZFNyaktGR3g5NERVSFZhTENmaFVKS0VkOExySlNkVTBCV3paV01rendVWHJ2?=
 =?utf-8?B?ZnlKUXZnOG5jZFFwQ2NmWUNMcGl2SjBXYmlXbnp3Tnc3dFhreklwZ2dFMlRx?=
 =?utf-8?B?SHRFTi9icTQ1MlpRVUs2RFZwOVRIU0dFekplZTY5dzhIand6OEhHblQ3cTkz?=
 =?utf-8?B?N0ljbU8zanVZL2JpcDZuNVpzMGNFaFgxRlFZT21NR0NOUVc4dm1PbWR6dHB4?=
 =?utf-8?B?N3NvaVh2U0VvZlRsQ3dlckxuMjl4WmZzVkVjVXdzQkcwY0VibXZsVTEybDQ1?=
 =?utf-8?B?OGRvYmQrZnNnKzczNmtsMWdHeHZTOUlFbG9uRC9sZThvSXVJVm5KY25xOEh0?=
 =?utf-8?B?eHlhQUtrWGtzUFdTZms0WlpBaEQxTUl0bWJOenNDbUpqWGlrdWNYRGh0WGtS?=
 =?utf-8?B?NFFqa3hFWjA0blJDV0toUElhTlFIWW8xdzZIMmVJOGZEMDFJWkNvMVNOTDFk?=
 =?utf-8?B?akZYSjNDMmplYmhDbXp0NDgwclQ3c213cjRXbXQzcm12bkRNQkdLSlllUEF2?=
 =?utf-8?B?S2JoS3JHL0Q2OC9nZ0RrL1d2eXNIK3Z4YndrSXhqVUpuQWN1dGpLYzNEUmlT?=
 =?utf-8?B?UDI4cFJmOTk1dThrSGxSdmFtVWtUdGkra3VRSG5KMm0yU0VTWnltV1RKU09Y?=
 =?utf-8?B?RDZ6aGVTYWpXTUFzUFFWcnY3cDRNYnRzK0kzcUZzZzlkTFI1aGZrNFQ3R2Fq?=
 =?utf-8?B?YmFzRC9hNGcwa0N6QkFiV0pFL0o2WUgyWmUwUWdWcG9rRkVUYkI5N2lPNCs1?=
 =?utf-8?B?RFZzN21CTkw4NDIwU1FvbW4rVDE0MkNUcHdxZGRaYXFtZ0JLTVFRcnEzZ040?=
 =?utf-8?B?amg3U2Q4U0N6NVVMeVFNS1cwZ21veEJYUHg3TlkrWnBidlZBVkp4YTlHODJu?=
 =?utf-8?B?T3N1TjZ5dlVuS25hRktCdEI2RFF3SjRJVzJSbXoyUWF2eFViQ3NCS05Ocnpu?=
 =?utf-8?B?bEFhajREZTMzQnpjdjFXK3NwMGN4RHczeDkwa2F2VjJhWWtSRzlmbERKQmUr?=
 =?utf-8?B?cFVhOWpmS3JzWGRvNHh6Q01BTTVVOGIwYTVQM3l5OFdvRVc1TGUyMEtnYWpj?=
 =?utf-8?B?Z1k0ZmtEYzJCQ1IvSXFUMFNlUURTSjYrMTY5KzZ5Unc0WkxHY0tGN2svZVRD?=
 =?utf-8?B?M1p6NzJmSVFwYVhlWWkwR0c0R05KSnR1WVd0aEpDRVk2eVk3V2gvSCtERGta?=
 =?utf-8?B?VW92cmQrMENxOFp5Y3NYVkZnbkZmTmYxdG9WTEM0WTNzNjRVcktqeHA0TXYv?=
 =?utf-8?B?Vm50TzE2RVZkMTdiQy9iTGJ1QldYOWZnY0JOVmY5dDBFNURMTzlQTkI0WlhF?=
 =?utf-8?B?VzF2MzNhZFMvNmxMUG56ZzIvRWwxeHRBMldMVDhPQjdUT1ltTnVoN0wzazRn?=
 =?utf-8?B?S2x5VVVTWVhyWkhxY1htRWRrU0NCUjJ1ejkxdndhL293WU9mMXBUL24wUEFU?=
 =?utf-8?Q?lLrSpTtCiv342/RXRf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78ef1d-716b-4feb-2279-08da3c5d4b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 01:41:01.8153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s86aiqaQjk7xW3xBYd9EejXZXlG+8r4xafBUhyx8OVa//5AA9LML01JFtLoiW2X5wOwyjju13s4pT2BNu1Hzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIFttYWlsdG86bmljb2xhc0BuZHVmcmVzbmUuY2FdDQo+
IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMjEsIDIwMjIgMjowOSBBTQ0KPiBUbzogTWluZyBRaWFuIDxt
aW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gaHZlcmt1aWwtY2lzY29A
eHM0YWxsLm5sDQo+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsgbGludXgt
bWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRd
IFJlOiBbUEFUQ0hdIG1lZGlhOiBhbXBoaW9uOiByZXR1cm4gZXJyb3IgaWYgZm9ybWF0IGlzDQo+
IHVuc3VwcG9ydGVkIGJ5IHZwdQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBMZSB2
ZW5kcmVkaSAyMCBtYWkgMjAyMiDDoCAwMToyNSArMDAwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoN
Cj4gPiA+IEZyb206IE5pY29sYXMgRHVmcmVzbmUgW21haWx0bzpuaWNvbGFzQG5kdWZyZXNuZS5j
YV0NCj4gPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDIwLCAyMDIyIDI6MTMgQU0NCj4gPiA+IFRvOiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPiA+ID4g
aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sDQo+ID4gPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsg
cm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA+ID4g
PGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+ID4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtZWRpYTogYW1waGlv
bjogcmV0dXJuIGVycm9yIGlmIGZvcm1hdCBpcw0KPiA+ID4gdW5zdXBwb3J0ZWQgYnkgdnB1DQo+
ID4gPg0KPiA+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+ID4gPg0KPiA+ID4gSGkgTWluZyBRaWFu
LA0KPiA+ID4NCj4gPiA+IExlIGpldWRpIDE5IG1haSAyMDIyIMOgIDE1OjI4ICswODAwLCBNaW5n
IFFpYW4gYSDDqWNyaXQgOg0KPiA+ID4gPiByZXR1cm4gZXJyb3IgaWYgZm9ybWF0IGlzIHVuc3Vw
cG9ydGVkIGJ5IHZwdSwgb3RoZXJ3aXNlIHRoZSB2cHUNCj4gPiA+ID4gd2lsbCBiZSBzdGFsbGVk
IGF0IGRlY29kaW5nDQo+ID4gPg0KPiA+ID4gSSBoYXZlIGEgcmVhc29uYWJsZSBkb3VidCBhYm91
dCB0aGlzIHBhdGNoLiBJIGRvbid0IHRoaW5rIHN1Y2ggYQ0KPiA+ID4gY2FzZSBzaG91bGQgYmUg
cmVhY2hhYmxlIGJ5IHVzZXJzLiBOb3JtYWxseSwgY2FsbHMgdG8gU19GTVQgc2hvdWxkDQo+ID4g
PiBlbnN1cmUgdGhlIGRyaXZlciBmb3JtYXQgc3RhdGUgaXMgdmFsaWQgb24gYm90aCBlbmRzIGJ1
dCBtb2RpZnlpbmcNCj4gPiA+IHRoZSByZWxldmFudCBzdHJ1Y3R1cmVzLiBBcyBhbiBleGFtcGxl
LCBmb3IgZGVjb2RlcnMsIHNldHRpbmcgdGhlDQo+ID4gPiBDT0RFQyAoT1VUUFVUIHF1ZXVlKSBm
b3JtYXQsIG1heSBjaGFuZ2UgdGhlIHJhdyBmb3JtYXQgKENBUFRVUkUNCj4gPiA+IHF1ZXVlKSBp
bXBsaWNpdGx5IHRvIHByZXZlbnQgdGhpcyBzaXR1YXRpb24uDQo+ID4gPiBBcmUgd2UgY2VydGFp
biB0aGlzIGNoYW5nZSBpc24ndCBwYXBlcmluZyBhcm91bmQgc29tZSBtaXNzaW5nIGZvcm1hdA0K
PiA+ID4gcHJvcGFnYXRpb24gPw0KPiA+ID4NCj4gPiA+IHJlZ2FyZHMsDQo+ID4gPiBOaWNvbGFz
DQo+ID4gPg0KPiA+DQo+ID4gSGkgTmljb2xhcywNCj4gPiAgICAgWW91J3JlIHJpZ2h0LCBpdCdz
IG5vdCByZWFjaGFibGUgY3VycmVudGx5Lg0KPiA+ICAgICBBbmQgdGhlcmUgYXJlIHNvbWUgZm9y
bWF0cyBzdXBwb3J0ZWQgYnkgVlBVLCBidXQgSSBkaWRuJ3QgYWRkDQo+ID4gc3VwcG9ydCBpbiBk
cml2ZXIsIGFzIHRoZXkgYXJlIG5vdCBkZWZpbmVkIGluIGtlcm5lbCB5ZXQuDQo+ID4gU28gaWYg
c29tZW9uZSB3YW50cyB0byBlbmFibGUgdGhlbSBpbiBmdXR1cmUsIGFuZCBpZiBoZSBvbmx5IGFk
ZHMgYQ0KPiA+IGZvcm1hdCBpbnRvIHZkZWNfZm9ybWF0c1tdIHdpdGhvdXQgbW9kaWZ5aW5nIHRo
ZSB2cHVfbWFsb25lIHBhcnQgLA0KPiA+IHRoZW4gaGUgY2FuIGVudW1fZm10IGFuZCBzZXRfZm10
IHN1Y2Nlc3NmdWxseSwgYnV0IG1lZXQgdnB1IGhhbmcNCj4gPiB3aXRob3V0IGFueSBlcnJvciBt
ZXNzYWdlLg0KPiA+ICAgICAgIEkgdGhpbmsgZHJpdmVyIHNob3VsZCByZXBvcnQgYW4gZXJyb3Ig
aW4gY2FzZSBvZiB0aGUgbmV3IGZvcm1hdA0KPiA+IGlzIG5vdCBpbXBsZW1lbnRlZCBmdWxseS4N
Cj4gDQo+IEZhaXIgcG9pbnQsIGJ1dCBpdCBzaG91bGQgYmUgYnVnX29uIG9yIGF0IGxlYXN0IGFu
IGVycm9yIHRyYWNlLg0KPiANCj4gcmVnYXJkcywNCj4gTmljb2xhcw0KPiANCg0KSSdsbCBhZGQg
c29tZSBlcnJvciB0cmFjZSBpbiB2Mg0KDQo+ID4NCj4gPiBNaW5nDQo+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9u
ZS5jIHwgMiArKw0KPiA+ID4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV92
NGwyLmMgICB8IDQgKystLQ0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4gPiA+IGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPiA+ID4gPiBpbmRleCBmMjljMjIz
ZWVmY2UuLjA5MzBiNmJhOGM0MiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+ID4gPiA+IEBAIC02MTAsNiArNjEwLDgg
QEAgc3RhdGljIGludCB2cHVfbWFsb25lX3NldF9wYXJhbXMoc3RydWN0DQo+ID4gPiB2cHVfc2hh
cmVkX2FkZHIgKnNoYXJlZCwNCj4gPiA+ID4gICAgICAgZW51bSB2cHVfbWFsb25lX2Zvcm1hdCBt
YWxvbmVfZm9ybWF0Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICBtYWxvbmVfZm9ybWF0ID0NCj4g
PiA+IHZwdV9tYWxvbmVfZm9ybWF0X3JlbWFwKHBhcmFtcy0+Y29kZWNfZm9ybWF0KTsNCj4gPiA+
ID4gKyAgICAgaWYgKG1hbG9uZV9mb3JtYXQgPT0gTUFMT05FX0ZNVF9OVUxMKQ0KPiA+ID4gPiAr
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiAgICAgICBpZmFjZS0+dWRhdGFf
YnVmZmVyW2luc3RhbmNlXS5iYXNlID0gcGFyYW1zLT51ZGF0YS5iYXNlOw0KPiA+ID4gPiAgICAg
ICBpZmFjZS0+dWRhdGFfYnVmZmVyW2luc3RhbmNlXS5zbG90X3NpemUgPQ0KPiA+ID4gPiBwYXJh
bXMtPnVkYXRhLnNpemU7DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Y0bDIuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vYW1waGlvbi92cHVfdjRsMi5jDQo+ID4gPiA+IGluZGV4IDQ0NmYwN2QwOWQwYi4u
ODliODhlMDYzZTQ1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X3Y0bDIuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X3Y0bDIuYw0KPiA+ID4gPiBAQCAtNTAwLDEwICs1MDAsMTAgQEAgc3RhdGlj
IGludCB2cHVfdmIyX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3QNCj4gPiA+IHZiMl9xdWV1ZSAqcSwg
dW5zaWduZWQgaW50IGNvdW50KQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgZm10LT5zaXplaW1h
Z2VbMV0sIGZtdC0+Ynl0ZXNwZXJsaW5lWzFdLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgZm10
LT5zaXplaW1hZ2VbMl0sIGZtdC0+Ynl0ZXNwZXJsaW5lWzJdLA0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgcS0+bnVtX2J1ZmZlcnMpOw0KPiA+ID4gPiAtICAgICBjYWxsX3ZvaWRfdm9wKGluc3Qs
IHN0YXJ0LCBxLT50eXBlKTsNCj4gPiA+ID4gKyAgICAgcmV0ID0gY2FsbF92b3AoaW5zdCwgc3Rh
cnQsIHEtPnR5cGUpOw0KPiA+ID4gPiAgICAgICB2YjJfY2xlYXJfbGFzdF9idWZmZXJfZGVxdWV1
ZWQocSk7DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAgIHJldHVybiAwOw0KPiA+ID4gPiArICAgICBy
ZXR1cm4gcmV0Ow0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIHZvaWQgdnB1
X3ZiMl9zdG9wX3N0cmVhbWluZyhzdHJ1Y3QgdmIyX3F1ZXVlICpxKQ0KPiA+DQoNCg==
