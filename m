Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5FE566925
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiGEL2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGEL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:28:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEA916584;
        Tue,  5 Jul 2022 04:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ean4aaqUrkKkbCV2Lr544IQB6wO+30c/Kj8sOj0U6Mqyuz+8d656D5/K6Me1jM/Estt3gS0afUhPOa3HQPjuXIGNe4Q/cpMYkU4+ErQds1IjZfKtSNQVMiJLsGQh1D/Nbeuo49rUAIDHFm/tSE1EnmzBHCFgDijjR/nriKvoXgLceWrzGI3C8ZcioY3uBwx+OoRao3Be5/jisAHPvEOiFEPjldhZe5ZzE1+taHhLqgKYCQXciSjOZm6SClCFsPxq6HZNwlbwGUq20orgiKYFE1HOvxD+DEhm7VEpUA+0PYbsH0PxCxpUxAgJZdhE1ztcyXFYRDDLiHbB9H/R+NXhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaW52W/I7iKqAxMcEnXwkh02X8b2tnQ0k+XOQjdp0WE=;
 b=jNv7Sie8gGd8jdPRJgzq2kLN5C5VwdgIOeCJMhwvw7sDfVOih+KHjQ0sdpfJZT7PU6FM4WNsU+mWvByukr7hTiz3DON9/MC5K9q1Ra3sSo0hxA4+AT98rY+ivr5p7+JszeQlBQa7igvbOwt9cstnHxxCq1jjBcuw8jvZdvmwDe0stQ/0P5nEr5TfNVL2qZVsn6BIvaXkS/GSZo+IF7bKmCs9rEjqrq7k/oRUpey4L6JxEr8UHlgDdd0GNBVCwyFUwoW0mF7M4x92cyNUhW9AXBbpXn6EFTyaGgW0VIDoUVKZey8SDs4k4ZSSfDeC6tNWk8dnLtXz9lic75B3k0DhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaW52W/I7iKqAxMcEnXwkh02X8b2tnQ0k+XOQjdp0WE=;
 b=aS2r9w3ndURShGcChZdVSW+GKRVtssWxyGTIw2EG3N8VYMmq84aaVrTYl8HpYXxgAJ4o9tvHKlIaeWJ90K55UjHrBrXPQfSH+DwgRRARIaA7f6LmU4wQhgN8SrmZHkCIhwEAlJ5fDeJznZuv7k5LFXLypHXUZK10JzzI8asLOQo=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6222.eurprd04.prod.outlook.com (2603:10a6:803:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 11:27:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 11:27:55 +0000
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
Subject: RE: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Topic: [EXT] Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
Thread-Index: AQHYiq7J1t29u6ewlE+hUMTTkjT24K1uamyAgACj+3CAAJ5+sA==
Date:   Tue, 5 Jul 2022 11:27:55 +0000
Message-ID: <AM6PR04MB634136824EC98EE804FAD0CEE7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
 <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
 <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e3974f0-e8c1-497c-c8f7-08da5e796805
x-ms-traffictypediagnostic: VI1PR04MB6222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6zB3oKO86exQtzYQSveRI++6GmcKyIR2TkEAArifZPdYVyz0IVk+SrhyjhAo6eJN8FROnDJjgU2MWdolDB8gQzP2tIvqjxXAXWj2VnUG2vDDhfSlUaJmFGDSUC0QmI7/SxAJWp1IzcCriVjczAOd/dhYXAaKVRcP6w1svX+yOkrSxjsIiGZj3OCKe/JNfCoQnfOifsDW7d1YSZ1X+ojxA/n/ZQdmvbtvKRmmFwSMZWgsT8zpeXVfdcDf4/Gqfw4DDaJiCI7/HE2F+c9j2d7zYAOWQw5n/MzFLmuKQTUOs5dOFtME72e0Xweu4yVPaSSG0zCsMJP1Pc2U4q8TMD0rOj0P/ywwb/EeVe6vAyeYBtgMIhfsON2CpYTMrazEm9LlbUMDBLzzVMMULf8zoCPnz3KxaVK+ZeU+68dJmma97Yva8UZMR7ezyGjJeC2YuHX689ENrccyv/UQpFAsAmQikrgpbK7/71wTUxxUk3wIdgLRKTqMozIUMufMAR+VKwYH/c1RNl7h3b4/09OHjfOwctKCj4jNekULRSDv/HugevbkXdsBE9rQ2QmUYAxVn34F+BOIatXojcJJ7tSsN4t4kz9TdrezJ8Dd4ATpCs0kZDsMEwZUSa85IPjj0BYNEanP/YsZNQwAwn9uw8mwU9VrJNWtsi5RKM8E+IDTtr7FcBA1KXLyyrg7sF2cEfRH07Dubx7zN2dtSMzhU+L6ZxGP8mf9Q7YIOybaFWOlpSsRbJoqhzUpyhxZtGyteqUtw4XrXNphHgnXshLS+Niu7x2ZCueXhpFn9HUTTx4mGELrNTKkw9lBk1lE7xYDjHd3B3ckNM2iseqGzN6WJLwl0tfi6F05UX4QVGnXDooc9MTwvpyK/6ZDHWn+ypk4g8Ae3zu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(2940100002)(186003)(9686003)(2906002)(26005)(53546011)(83380400001)(55016003)(41300700001)(38100700002)(7696005)(6506007)(54906003)(38070700005)(110136005)(122000001)(44832011)(8936002)(478600001)(5660300002)(52536014)(7416002)(71200400001)(66556008)(66946007)(76116006)(8676002)(64756008)(66476007)(4326008)(66446008)(66574015)(33656002)(316002)(86362001)(32563001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0hiMDhDOXdFNU9ZWm5uMkNqMFRYV2toMFNHMTF0MllPelNoK0NzVWorQVBF?=
 =?utf-8?B?RkZTcFYrRnlEaS9NZkdBakFCbjdvSGdqNGxUKzlyK3VkT2k1THNmeUNYM1dI?=
 =?utf-8?B?YVErNUJOMVdjVzRCWFRmWnJRY3F4L3BBTDVnL0xxanRlVkhtaXVCd2hjb0xD?=
 =?utf-8?B?ZG1HYURWV1RMcUc4ZGVqUlVyVEVzRXcwY2dyeXEybGlmK05NeFlSekI4Znpu?=
 =?utf-8?B?WHA1dVJYRis0eDJQVVZSbi9TWGNOTW5mMGFkSkI0ajcvbmRvMHdXTklLeVl4?=
 =?utf-8?B?L051Z2NhMHlSUjhQamN5aVFlaitOZ1pKVnNlcS9qc3hGWWpBazlGRTRYYjBW?=
 =?utf-8?B?ZkZrZGFiVmpDcDdXdk42UC9LcVR5S21HaFl5Y1JaWVN6MVQ1L3c3U2xuSUtB?=
 =?utf-8?B?S0dZc1M3eFdrdXV1M1A0alhacFgrTWk2U2R5MEtxSVpoZGU3eUhRZ2Q5aTk4?=
 =?utf-8?B?TG9yaU5zdUl4NWNpcFpmeWN2dUxPYU12c1Y3TmVFdkdnSEVXZlRSTHRBbmlj?=
 =?utf-8?B?NXJ6OTVyTzZmTjY2MFZyZjlmQmVPQ0hWWFF4ZzkxM2lzdHREUEd6S3F6M1JW?=
 =?utf-8?B?dVlDN1lQb1hUNmFTUjladEVoWnZ0STdKRjIzc2EvM2dzVWZKaFRTYkZML1VS?=
 =?utf-8?B?TnVVKzIwRFJocllIQVBoODhVbnhlNTI0VmtjZ2lwVFluZWxaREIyTUpkZjRH?=
 =?utf-8?B?a29DcG5KaWppaGVaampWZ2RSK1JEOFUwdWpsQmkwcFAvQlZxYnlUS3EwalRk?=
 =?utf-8?B?TDlDc1loT2V4OEF4bDdYRUhNNEZ2UGNEdXNHZzZtL1ZuTlhIaU1DelhXT0tQ?=
 =?utf-8?B?bUthdStlN1VZaE5tcWRYYVJWYWpWc2dQaGE3WGEzTFVsUXE3WGw4Z1hxWUo5?=
 =?utf-8?B?REJKYzc3cnJ2ZjJtQVBLUkMybEUzY1VIanhqZndWL3hhK2p6ZGFTN0dHRWJM?=
 =?utf-8?B?QkpaYlRzb0d0TjJONXZSbXNWTnFFQmhLa3BkSnpFTzlBNUJRUUpTUHJEQmpZ?=
 =?utf-8?B?ZXdqUVZhU1FwWlN0WEVja3I2bkJxWEtiTGNnb1RNaHVvOTdNamF6TnBUQmhm?=
 =?utf-8?B?allmME5WTzU4R1dVN3J0czFjSmFsZ0U0SHFuUXJ2d2ZwMmNHVGtmRHRHYzBm?=
 =?utf-8?B?MjRFMzM5WHV6RkxTRnBtZ1NzTUxoMGIydkl3K0l2aG9UTHFObUNIUlQ2Z2k5?=
 =?utf-8?B?bVQwN3IyY0k3WlByUzZ6QitSR2FwKzlQenZUV1dKbVlEMFdwRnRxN095QVRG?=
 =?utf-8?B?OTBVTEdLcHZkc1czUHViOTdSdEV1SFN4TzcrRUJTR3I4cDc0cHVWQXBPRit1?=
 =?utf-8?B?SHpVZ0x5Q3ZQUnp3ZkI3WTNqSGtlWXh0RE5jaDlJdHFCUjdieUsyRm9pckx5?=
 =?utf-8?B?Rk8rU01nNnZza3NuOWFWamsxQS9zUmV0SXlnRWFTcG9RK05DVkJnaHg1MjRB?=
 =?utf-8?B?WjNXS0ZZTUdlTktWbytQVHdvYXQyZVZqNm5oZGxiNHR5QXhqcE91ams3UElj?=
 =?utf-8?B?OHczUFV6SHFaYXRlL0d0a0pyRytMbU1sL1dwUzNRUEx4bGFhNmtKdFBwcEQ4?=
 =?utf-8?B?QmNxUW5lQ3RwWlF3eEpLczd5T1dJbnllRUxLaG9yT2Z6ZFFFODVMeTV5RG51?=
 =?utf-8?B?NVBmdDNNME10cklIY1RHa2UyYVNOQno5bnJaVytHWVVzRUdYOUpjME9ka29V?=
 =?utf-8?B?OWlDZ3BKZW13Q0RDbVlCdUw3NS9ZMlh6MjJEbXpta0lOZVlSQUZYd1JIYmJh?=
 =?utf-8?B?VDhkbG1BNnJvcHNBM05rajBSeVdtRGdSV1h1a29ZbWovOThFR1UrdDcxMHJG?=
 =?utf-8?B?bE51N0w5cVlkYk1URDkwVURGZGwvRUEvYnNvYXdxYm9yYjU2S3ZjN25ReGpp?=
 =?utf-8?B?aHEwdXIwOGEwNHRpbkdYSWFkRk9EMEgxc1lpVXFXTGZFTnI5cENlNGp3OUtD?=
 =?utf-8?B?dm1aVXRNVytJcHowaktFbCtERFNlMzRMVTZPbm90OFNNdWhsUk55cXpuNmw3?=
 =?utf-8?B?aWE4WDEwbDAyR0o2c0V0ZG83VEpmS2pJS3lnUktFYmo3NXBzOXAzdGcrVWhl?=
 =?utf-8?B?S1h4VWVVenBzWFFtaXk0amd5QTVERFVsV09wMk1rR2ViYWNsV2xWN1NENHhS?=
 =?utf-8?Q?3ll0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3974f0-e8c1-497c-c8f7-08da5e796805
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:27:55.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbFP9EsPwrLkxY9mtHyGCLDAMQF+RgVi2FEFHmZINpkCD/2lqpmEhUMLjWdlUyZcu42jyGxdRSc/XVNtryBLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj5Gcm9tOiBNaW5nIFFpYW4NCj4+U2VudDogMjAyMuW5tDfmnIg15pelIDEwOjAwDQo+PlRvOiBO
aWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzQG5kdWZyZXNuZS5jYT47IG1jaGVoYWJAa2VybmVsLm9y
ZzsNCj4+aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sDQo+PkNjOiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+Pmtlcm5lbEBw
ZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4+PGxpbnV4
LWlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOw0KPj5saW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4+U3ViamVjdDogUkU6IFtFWFRdIFJlOiBbUEFUQ0hdIG1lZGlhOiBhbXBoaW9uOiBvbmx5IGlu
c2VydCB0aGUgZmlyc3Qgc2VxdWVuY2UNCj4+c3RhcnRjb2RlIGZvciB2YzFsIGZvcm1hdA0KPj4N
Cj4+PiBGcm9tOiBOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzQG5kdWZyZXNuZS5jYT4NCj4+PiBT
ZW50OiAyMDIy5bm0N+aciDXml6UgMDowNg0KPj4+IFRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBu
eHAuY29tPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPj4+IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5u
bA0KPj4+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+Pj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBn
bWFpbC5jb207IGRsLWxpbnV4LWlteA0KPj4+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1l
ZGlhQHZnZXIua2VybmVsLm9yZzsNCj4+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+PiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIXSBtZWRpYTogYW1waGlvbjogb25seSBpbnNlcnQgdGhlIGZpcnN0DQo+Pj4gc2Vx
dWVuY2Ugc3RhcnRjb2RlIGZvciB2YzFsIGZvcm1hdA0KPj4+DQo+Pj4gQ2F1dGlvbjogRVhUIEVt
YWlsDQo+Pj4NCj4+PiBIaSBNaW5nLA0KPj4+DQo+Pj4gTGUgbWFyZGkgMjgganVpbiAyMDIyIMOg
IDEzOjIwICswODAwLCBNaW5nIFFpYW4gYSDDqWNyaXQgOg0KPj4+ID4gRm9yIHNvbWUgZm9ybWF0
cywgdGhlIGFtcGhpb24gdnB1IHJlcXVpcmVzIHN0YXJ0Y29kZSBiZWZvcmUgc2VxdWVuY2UNCj4+
PiA+IGFuZCBmcmFtZSwgc3VjaCBhcyB2YzEsIHZwOC4NCj4+Pg0KPj4+IEknbSBub3Qgc3VyZSB3
aHkgVlA4IGlzIGJlaW5nIG1lbnRpb25lZCBoZXJlLiBUaGVyZSBpcyBubyBzcGVjaWZpZWQNCj4+
PiBzYXJ0Y29kZSBmb3IgVlA4LCBhbmQgbm8gc3BsaXQgb2YgaGVhZGVycyBlaXRoZXIuDQo+Pj4N
Cj4+DQo+PkhpIE5pY29sYXMsDQo+PiAgICBUaGlzIHBhdGNoIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGggdnA4LCBhbmQgaW5kZWVkIHRoZXJlIGlzIG5vIHNwZWNpZmllZA0KPj5zdGFydGNvZGUgZm9y
IFZQOC4NCj4+QnV0IGFtcGhpb24gdnB1IHJlcXVpcmVzIGRyaXZlciB0byBoZWxwIGluc2VydCBz
b21lIGN1c3RvbSBzdGFydGNvZGUgZm9yIHZwOA0KPj5hbmQgdmMxLg0KPj5JdCdzIGN1c3RvbSBi
ZWhhdmlvci4NCj4+DQo+IEluc3RlYWQgb2YgZXhwb3NpbmcgdGhlIGN1c3RvbSBmb3JtYXQsIHlv
dSBzaG91bGQgdXNlIGRhdGFfb2Zmc2V0IGxpa2UgVkVOVVMgZHJpdmVyIGRvLiAgVGhleSB2cDgv
OSBjb2RlYyBpbiBWRU5VUyBoYXZlIHRoZSBmcmFtZSBwcmVmaXhlZCB3aXRoIGFuIElWRiBoZWFk
ZXIsIHRoZSBkYXRhX29mZnNldCBsZXQgdGhlIHVzZXJsYW5kIHNraXAgaXQuDQoNCkhpIE5pY29s
YXMsDQogICAgVGhlcmUgaXMgYSBzdHJlYW0gYnVmZmVyLCBhbmQgZHJpdmVyIHdpbGwgY29weSB0
aGUgY29kZWQgZnJhbWUgZGF0YSB0byB0aGUgc3RyZWFtIGJ1ZmZlciwgZHJpdmVyIGNhbiBkZWNp
ZGUgdG8gaW5zZXJ0IGN1c3RvbSBzdGFydGNvZGUgb3Igbm90LCB1c2VybGFuZCB3b24ndCBrbm93
IGFib3V0IGl0LCBzbyBJIGRvbid0IHRoaW5rIGl0J3MgbmVjZXNzYXJ5IHRvIHVzZSBkYXRhX29m
ZnNldCB0byBsZXQgdXNlcmxhbmQgc2tpcCBzb21ldGhpbmcuDQogICAgQ3VycmVudGx5ICwgZHJp
dmVyIHdpbGwgaW5zZXJ0IHN0YXJ0Y29kZSBmb3IgZm9ybWF0IHZwOCBhbmQgdmMxLiBUaGlzIGlz
IHRyYW5zcGFyZW50IHRvIHRoZSB1c2VyLg0KDQpNaW5nDQoNCj4+ICAgIEknbSBzb3JyeSB0aGF0
IG15IGRlc2NyaXB0aW9uIGluY2x1ZGUgc29tZSBjb25mdXNpb24NCj4+DQo+Pk1pbmcNCj4+DQo+
Pj4gPg0KPj4+ID4gQnV0IGZvciBWNEwyX1BJWF9GTVRfVkMxX0FOTkVYX0wsIG9ubHkgdGhlIGZp
cnN0IHNlcXVlbmNlIHN0YXJ0Y29kZQ0KPj4+ID4gaXMgbmVlZGVkLCB0aGUgZXh0cmEgc3RhcnRj
b2RlIHdpbGwgY2F1c2UgZGVjb2RpbmcgZXJyb3IuDQo+Pj4gPiBTbyBhZnRlciBzZWVrLCB3ZSBk
b24ndCBuZWVkIHRvIGluc2VydCB0aGUgc2VxdWVuY2Ugc3RhcnRjb2RlLg0KPj4+ID4NCj4+PiA+
IEluIG90aGVyIHdvcmRzLCBmb3IgVjRMMl9QSVhfRk1UX1ZDMV9BTk5FWF9MLCB0aGUgdnB1IGRv
ZXNuJ3QNCj4+PiA+IHN1cHBvcnQgZHluYW1pYyByZXNvbHV0aW9uIGNoYW5nZS4NCj4+PiA+DQo+
Pj4gPiBGaXhlczogMTQ1ZTkzNjM4MGVkYiAoIm1lZGlhOiBhbXBoaW9uOiBpbXBsZW1lbnQgbWFs
b25lIGRlY29kZXIgcnBjDQo+Pj4gPiBpbnRlcmZhY2UiKQ0KPj4+ID4gU2lnbmVkLW9mZi1ieTog
TWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+PiA+IC0tLQ0KPj4+ID4gIGRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMgICAgICAgfCAxICsNCj4+PiA+ICBkcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmggICAgICAgIHwgMSArDQo+Pj4gPiAgZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYyB8IDIgKysNCj4+PiA+ICBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5oICAgIHwgNyArKysrKystDQo+Pj4g
PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4g
Pg0KPj4+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVj
LmMNCj4+PiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZkZWMuYw0KPj4+ID4g
aW5kZXggMDlkNGYyNzk3MGVjLi41MTIxOGE0MWE1YWMgMTAwNjQ0DQo+Pj4gPiAtLS0gYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+Pj4gPiArKysgYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+Pj4gPiBAQCAtNzMxLDYgKzczMSw3IEBAIHN0
YXRpYyB2b2lkIHZkZWNfc3RvcF9kb25lKHN0cnVjdCB2cHVfaW5zdCAqaW5zdCkNCj4+PiA+ICAg
ICAgIHZkZWMtPmVvc19yZWNlaXZlZCA9IDA7DQo+Pj4gPiAgICAgICB2ZGVjLT5pc19zb3VyY2Vf
Y2hhbmdlZCA9IGZhbHNlOw0KPj4+ID4gICAgICAgdmRlYy0+c291cmNlX2NoYW5nZSA9IDA7DQo+
Pj4gPiArICAgICBpbnN0LT50b3RhbF9pbnB1dF9jb3VudCA9IDA7DQo+Pj4gPiAgICAgICB2cHVf
aW5zdF91bmxvY2soaW5zdCk7DQo+Pj4gPiAgfQ0KPj4+ID4NCj4+PiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1LmgNCj4+PiA+IGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+Pj4gPiBpbmRleCBlNTZiOTZhN2U1ZDMuLmY5MTRk
ZTZlZDgxZSAxMDA2NDQNCj4+PiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlv
bi92cHUuaA0KPj4+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5o
DQo+Pj4gPiBAQCAtMjU4LDYgKzI1OCw3IEBAIHN0cnVjdCB2cHVfaW5zdCB7DQo+Pj4gPiAgICAg
ICBzdHJ1Y3QgdnB1X2Zvcm1hdCBjYXBfZm9ybWF0Ow0KPj4+ID4gICAgICAgdTMyIG1pbl9idWZm
ZXJfY2FwOw0KPj4+ID4gICAgICAgdTMyIG1pbl9idWZmZXJfb3V0Ow0KPj4+ID4gKyAgICAgdTMy
IHRvdGFsX2lucHV0X2NvdW50Ow0KPj4+ID4NCj4+PiA+ICAgICAgIHN0cnVjdCB2NGwyX3JlY3Qg
Y3JvcDsNCj4+PiA+ICAgICAgIHUzMiBjb2xvcnNwYWNlOw0KPj4+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMNCj4+PiA+IGIvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9tYWxvbmUuYw0KPj4+ID4gaW5kZXggYzYyYjQ5
ZTg1MDYwLi5mNGE0ODhiZjk4ODAgMTAwNjQ0DQo+Pj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+Pj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+Pj4gPiBAQCAtMTMxNCw2ICsxMzE0LDggQEAg
c3RhdGljIGludA0KPj4+IHZwdV9tYWxvbmVfaW5zZXJ0X3Njb2RlX3ZjMV9sX3NlcShzdHJ1Y3Qg
bWFsb25lX3Njb2RlX3QgKnNjb2RlKQ0KPj4+ID4gICAgICAgaW50IHNpemUgPSAwOw0KPj4+ID4g
ICAgICAgdTggcmN2X3NlcWhkcltNQUxPTkVfVkMxX1JDVl9TRVFfSEVBREVSX0xFTl07DQo+Pj4g
Pg0KPj4+ID4gKyAgICAgaWYgKHNjb2RlLT5pbnN0LT50b3RhbF9pbnB1dF9jb3VudCkNCj4+PiA+
ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pj4gPiAgICAgICBzY29kZS0+bmVlZF9kYXRhID0g
MDsNCj4+PiA+DQo+Pj4gPiAgICAgICByZXQgPSB2cHVfbWFsb25lX2luc2VydF9zY29kZV9zZXEo
c2NvZGUsDQo+Pj4gPiBNQUxPTkVfQ09ERUNfSURfVkMxX1NJTVBMRSwgc2l6ZW9mKHJjdl9zZXFo
ZHIpKTsgZGlmZiAtLWdpdA0KPj4+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24v
dnB1X3JwYy5oDQo+Pj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBj
LmgNCj4+PiA+IGluZGV4IDI1MTE5ZTVlODA3ZS4uN2ViNmYwMWU2YWI1IDEwMDY0NA0KPj4+ID4g
LS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuaA0KPj4+ID4gKysr
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdV9ycGMuaA0KPj4+ID4gQEAgLTMx
MiwxMSArMzEyLDE2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZwdV9pZmFjZV9pbnB1dF9mcmFtZShz
dHJ1Y3QNCj4+PiB2cHVfaW5zdCAqaW5zdCwNCj4+PiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHZiMl9idWZmZXIgKnZiKSAgew0KPj4+ID4gICAgICAgc3Ry
dWN0IHZwdV9pZmFjZV9vcHMgKm9wcyA9IHZwdV9jb3JlX2dldF9pZmFjZShpbnN0LT5jb3JlKTsN
Cj4+PiA+ICsgICAgIGludCByZXQ7DQo+Pj4gPg0KPj4+ID4gICAgICAgaWYgKCFvcHMgfHwgIW9w
cy0+aW5wdXRfZnJhbWUpDQo+Pj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+
ID4NCj4+PiA+IC0gICAgIHJldHVybiBvcHMtPmlucHV0X2ZyYW1lKGluc3QtPmNvcmUtPmlmYWNl
LCBpbnN0LCB2Yik7DQo+Pj4gPiArICAgICByZXQgPSBvcHMtPmlucHV0X2ZyYW1lKGluc3QtPmNv
cmUtPmlmYWNlLCBpbnN0LCB2Yik7DQo+Pj4gPiArICAgICBpZiAocmV0IDwgMCkNCj4+PiA+ICsg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiA+ICsgICAgIGluc3QtPnRvdGFsX2lucHV0X2Nv
dW50Kys7DQo+Pj4gPiArICAgICByZXR1cm4gcmV0Ow0KPj4+ID4gIH0NCj4+PiA+DQo+Pj4gPiAg
c3RhdGljIGlubGluZSBpbnQgdnB1X2lmYWNlX2NvbmZpZ19tZW1vcnlfcmVzb3VyY2Uoc3RydWN0
IHZwdV9pbnN0DQo+Pj4gPiAqaW5zdCwNCg0K
