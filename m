Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E7509C66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387718AbiDUJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384833AbiDUJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:38:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF711A0C;
        Thu, 21 Apr 2022 02:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXetZm/hgWu1Gor2sk7wNqgNRGePNihwcZQedsX+HgWQ6QwLq2I3OY795yDCAJNtg2Yv3/17Uw+1vuq0306zc9bpg/+B7RatgLJcGu7QtxerprKSYfbkbrEggEcWRQMxohhkkImSzBz9aTGaWMBCCZeyij5EnkKsoqV1zLvK3yf7w00oMkGLL37n6fMmw/5Dk4tyTyM24LcamUg0bEL+pKiXGBhKYf77W3EqQPLRJOOaLrJta/hF3MXAjO/0xfXz1f62sMCIj+NPMJMGatyNME4vZwcosaZpxeRB76AelWtwtlaGjmzxsYmwS1qOds/WosRRAMImLDl8AFVL/mp/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EVF8qmt3HlUkL1JvypzaIPpmNrLwZORKTuDFSJKZLo=;
 b=FdyM0eb+BaCYaKQqnk5nslRa0UaA0g/oHVUgcTB7zCgVvp4KjLkf7n534IcFnvChllCnUoXFUi+EkfaCP6/Q/YPTWg/FcBpIaU8nUjKC5GOshHpm+gKMDbkoDO8Sgr4nR9yZt+y+xjD8cxPo5UO/Ghj7neFkyOBtFe835uWG25NJMV/VWcxCHpfhZfI76L6adpRoZifJYqy6i7989Qjw/DkJ6LZ7CmXTg+bVg8TbbAQX3JlOmbkjLZEHdeulaiXkeeBVTksnXphndYjiVveGuI5IcGmoIAFVPcvfV9lVVGP+43XyhogFt8sE7jsWXCtMHOlBjK5j9CaRkwDDt6vEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EVF8qmt3HlUkL1JvypzaIPpmNrLwZORKTuDFSJKZLo=;
 b=SevcREHG0D3DEI3ytRNeE9iHV3EQ1oNcjfI23Hoj4G38JcGovDQ0kv375l88Z9ZyrdpjMeVMJVNababHMQ6et0QWlm8+J+i0Q9CnoWtxYjloo7rYn91cl2enu1astTaGrD8FLUdVC7vtc6+jf3KNeB5+EnBekpdhs+D0+0rD3TA=
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 09:35:28 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 09:35:28 +0000
From:   Jerry Huang <jerry.huang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Topic: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Thread-Index: AQHYVIiygEZn3a5TtE+wxprjnFe3kqz4tPoAgAFfCfCAAARPAIAAAWVA
Date:   Thu, 21 Apr 2022 09:35:28 +0000
Message-ID: <VE1PR04MB647759CE6388FC6182FA0514FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
 <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
 <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
 <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
In-Reply-To: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 683dc83d-54a3-47eb-8801-08da237a45b1
x-ms-traffictypediagnostic: AM7PR04MB6840:EE_
x-microsoft-antispam-prvs: <AM7PR04MB6840B33F13FF51B5B233168DFEF49@AM7PR04MB6840.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHplcgbap02BxF/dQS8bgTj2kuuFlNEyyXcOmyGBVwidmfoOKiT6xg7WLtxZDtxzbvWKkmv6OgVt/ynC/Ak5stpF+LorwHP809CGybaOLtMdTwnHvqIiGwS9T0f8+osq6croIE59vyqmJ7INKnfydU6enB26uVJ1zk+/OhIUNHPg3o95dWqhNZxcrxYjtbj7UJqcyTgIDGayJ4FJubuyk9gw2zREM2N2KuTOQD2us8g+VvWzTEgN5MLw+HwW0VU2iIkWWBtVK0QZs6CkoDJs7u3MfT7kbsuG3Vnp8NLSyG9VEonkAFYEWnuzLh+yfjJJjxiTbOJ/FuBtzPvtntiUjqfjWKxvmQ/w4ab29ShvUDpZV64jMR80moI7ilJwHZVAqQlJE27+Z6fADkkRvbzjQ7YzhsBaIvhWTRu4IGq8R8SMkqQtGf2N4yH5TUCoGK9eJQkiK1YNPxsXWfMQX8+5cdi/u67xs5sdueI+rjvAUtVuej9FtqJXdtseSKt/QnlliE3PgN8haB5H+rALtRNvGwiD+CjthvN/P3RrIEotJEtJ7K0McX6kEOW3E5mc6Nco426ERNcLPVVof4s03CZvbKRcgghrd2m5dy8RDfWLKqCKzWh6/I3bLukdp/cq3/BdyETVao3xuF5sQ0HInU7LC1i7AUQoKODt9B8X6LwzAula4nvgAVeoBWM59kDCVDupHeTYZEfJBo/h09XMRaNA9s31O3w6BM8sUCkUNjfCFfXSLufXnyJGqtAQssRsv4VP0tUgnzpaJd/Iz5zs9GohP9at9trnO3TilCveusKxgcoUXPA2QnIp+cACcuCYpvsC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(64756008)(508600001)(76116006)(66556008)(52536014)(8676002)(53546011)(66446008)(66476007)(44832011)(8936002)(9686003)(66946007)(86362001)(5660300002)(26005)(186003)(33656002)(7696005)(6506007)(966005)(110136005)(38070700005)(38100700002)(55016003)(316002)(122000001)(71200400001)(45080400002)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bUxSS3ZrSnFWcVFhdUY0amlZV3JGd1JvWWkxVG5OZTBnRWN0TDQ5S0Q3MU41?=
 =?gb2312?B?SVdpWEdKelRKd2FHT3FZQmxxR0I3QWlteVdEdDJhZ0prUHZPU1pZZVVacEVI?=
 =?gb2312?B?eCtnd0xzRHYxU1hvTDk4NCtvdXlDdUo4MWY5WlR2eklnL2w3Q3UxcGlOcmll?=
 =?gb2312?B?MGl2bDQwbUtBcm1OMk9wSnBUR0pLd3E2ME01WWRKM2RCbGFiL2hYS0tSSTlw?=
 =?gb2312?B?dXA2ZU5XOThMeFNXdFV0dWZvcnpqamU2U2NRWlhXOHJ0Ykd2MERFQ2ZkSzRz?=
 =?gb2312?B?V1FZMEs5Q2F2aG5KdFFVUFp5REcvdE9ZMHB4blhVWVowNDZ2ZzFaTGJIMXpk?=
 =?gb2312?B?cW1JK0JESmh3VDFzUVNPRmVvWmwzUjJuUStoWXlNeUJtTFFaa1FiM3hiejRK?=
 =?gb2312?B?VHJ5NCt0MHhJTG1qNnlsMFE2L3M5WTFXdzdXVnF6d3ZabFN2V1gxalZ4anVP?=
 =?gb2312?B?blRZMUlrOWNHYmt6NnJ4U0dyQ3hEWGorUk91M0NXamd3MXJLNndFV1dXUWJL?=
 =?gb2312?B?N0NuVzRvYUwza09nN3ZGS2hxVzVQVGtlMlBkTUR6dktpalRpZDdycms2TWF5?=
 =?gb2312?B?SmRpVUhMWmRuTWRObFBGd1l1YXI3UHBNUmQyZWFtL001aGJ6eHBpYnMyTjZW?=
 =?gb2312?B?VS9mNGJkMTdra0xwa3F2ZVFMM1AxYk8vaHY0OUUrYU13S3hPbGwvNElXREcr?=
 =?gb2312?B?NVFYSExDWStvbFJLV2RMeXNRSWpRelNpdnQ0Vk0vQXM1YXV5VlJSYUhnK2tY?=
 =?gb2312?B?dGJtZmxwRmVWQmNrVWZIbU92Z0hqMHhlS0hBR1VSVmVqN0xrZlJmNmI2L0My?=
 =?gb2312?B?SnN1UzgyU3Q2RVFITVNrdG04UjkralhFalFNazZjT2ZMYUdTaXRLZHd6aGhV?=
 =?gb2312?B?aXlhekVIVXhNWVk0KzRERWhrVmVlWFQra1ZwallhTHpqMGRJVjlOL2YvV3ky?=
 =?gb2312?B?KzQvZS9xaUc2dHl0Qk5iUVdLdHVScFAzalpVKy9SZ2VjMFFNOHZBZk9NcFVq?=
 =?gb2312?B?NGNGVkRCekxyMkM4Ky9Fcnd6VnpQenEzMnRveUYrbmJpTmZrRllIeFNDY2ZC?=
 =?gb2312?B?cFhVQlBoUUJhRVlmSDV4bldJeENhZW1EN3lDY2hxLzlnYzdUeENXdHNIa3NV?=
 =?gb2312?B?VytPVDRqMW1TKzdic2oxVzVMS3MySE9LQUVZRENwVzIrM2Z2T0l4Q0VmTDlB?=
 =?gb2312?B?Zi96QTRtMGVsN3plWGwxQmMyc2xyNFBESThrZHZCQVRXNmlRcUQ3L3dodHVp?=
 =?gb2312?B?ODFacVVKYTVRTFl2a0xVWm5MeHlOQ0F5VStiM3JtWVRCRzBSM09KZWlTb0FC?=
 =?gb2312?B?dGpueUdFdFBSS0x4cmlRa25hVGVEdHlXZ01obEI1Yjc5ZGVsd2lXVWtjQTBi?=
 =?gb2312?B?MHV5WGxGNnNiNzgwQzF2NllnUFQrbGFoWjM0ZnJySFNObmloTWFyU2t0bDJj?=
 =?gb2312?B?NkRLbCtOdzhNRUkyYi9WbnBnMGxYbjVLQXQxR2dSQnEwUENhcCtjNHlDNWx4?=
 =?gb2312?B?UVFCZWR3ZWFsMldkVU55eElNN3daS0VNZnpTcjNXRFcvOCswUXFTekxtNDZh?=
 =?gb2312?B?dVBNRTBYdVBMWEkzbWs5cER2TFBvV0dQRmJtSkZKSkg5NGdZdkM3UU1DN3B1?=
 =?gb2312?B?bWNGTGdOQjUxMmhCUnNjb3JVaEF4c2IvUlhueXNYV1pJRHBOYWxzcGs4K3lL?=
 =?gb2312?B?QkIvTW5DaFhNZ0czZm84ZkxRK1lmbUp4aVdnTHViZlpzQXFBZDM2azBGR1M0?=
 =?gb2312?B?VUVrZGFmbjF2RHlzdm9keWJycG0xMHoxT1NEUVhuWmQ2UjNDU2E0eWlybVQ3?=
 =?gb2312?B?QVhlLzV3WkRpOGp3dnY2WkVzQVFTNU42RjZNZTNTVmpZdC9oY0Y3T2lNRWVW?=
 =?gb2312?B?YTdoNUIrbXVNM0M0a2tTdWl5L0lIOWhMVEozUnYyRWJ6MDNkUklMMCttWTE5?=
 =?gb2312?B?RGVmLy8zRVRkbU5nWGx5UkJEVFRuY3U2UFVtVnFDZzNucTZYRm9MY21YVVUz?=
 =?gb2312?B?YjlIelZRbzJJcUF6Si9pa0g3WjIxZ0RNMFJ3WGdaMzRNWVdEUitkZUtveUxP?=
 =?gb2312?B?SmlXSzJxaFNHZnRxc29qVTV3OEhZSU02dVRBVVFIdFYxWWU1QTFiNjdLVjhq?=
 =?gb2312?B?RTdKMk51bUNvYkRhVmdMeTdjZ1JjSzhlQlE1TkRaOFkxbW9WVmdjMEFsRVQ5?=
 =?gb2312?B?aU5idlozRmV6eGkvK2FCaDB4OFQrMk9Db0JpZG10a2dyeTBEYk1OZ2JyZXI1?=
 =?gb2312?B?Rzk1ZTZQbld6OXJGTDl5NTV0U3UvOUZkbWNuOGpJQnBUODRmWG9SVUo1WGM3?=
 =?gb2312?B?SmVwNEVwdjhqQWhDaUIwOE1kQjhWVFdtVGlxUEZ5a0JJajlYdXljQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683dc83d-54a3-47eb-8801-08da237a45b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 09:35:28.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to2lLNYrAyXHnplA3ShmcLbgYhuZs7Dt6rxlIBooOHZr4XE+q+bp//p7xx8CRMhWR6aiqeazALMk8QqxNzCV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KQmVzdCBSZWdhcmRzDQpKZXJyeSBIdWFuZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPiANClNlbnQ6IDIwMjLE6jTUwjIxyNUgMTc6MTgNClRvOiBKZXJyeSBIdWFuZyA8amVy
cnkuaHVhbmdAbnhwLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtFWFRd
IFJlOiBbUEFUQ0ggMS8yIHY0XSBkdC1iaW5kaW5nczogZHNwaTogYWRkZWQgZm9yIHNlbXRlY2gg
c3gxMzAxDQoNCkNhdXRpb246IEVYVCBFbWFpbA0KDQpPbiAyMS8wNC8yMDIyIDExOjExLCBKZXJy
eSBIdWFuZyB3cm90ZToNCj4gUGxlYXNlIGFsc28gYW5zd2VyIE1pY2hhZWwncyBjb21tZW50cy4N
Cj4NCj4gW0plcnJ5IEh1YW5nXSBJIGRvdWJsZSBjaGVja2VkIHRoZSBNaWtyb0J1cyBkZXZpY2Vz
LCB3ZSB1c2VkIHR3byBNaWtjcm9CdXMgZGV2aWNlczoNCj4gQkxFIFAgY2xpY2s6IA0KPiBodHRw
czovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZ3d3cuDQo+IG1pa3JvZS5jb20lMkZibGUtcC1jbGljayZhbXA7ZGF0YT0wNSU3QzAxJTdD
amVycnkuaHVhbmclNDBueHAuY29tJTdDMGENCj4gMTg2OWUxNDBhNzRiZGZkYWQxMDhkYTIzNzdk
NjM2JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJQ0KPiA3QzAlN0M2Mzc4
NjEyOTQ4NjI3NTM1MTklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMDQo+IENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMw
MDAlN0MlN0MlN0MmYW1wO3NkYXQNCj4gYT0lMkZ3c3dLSlp4dWIzN3Z4aGp1REoxaWlnc3BTUHBi
MVUwa1VRRHhTYXo1WXclM0QmYW1wO3Jlc2VydmVkPTANCj4gQkVFIGNsaWNrOiANCj4gaHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGd3d3Lg0KPiBtaWtyb2UuY29tJTJGYmVlLWNsaWNrJmFtcDtkYXRhPTA1JTdDMDElN0NqZXJy
eS5odWFuZyU0MG54cC5jb20lN0MwYTE4DQo+IDY5ZTE0MGE3NGJkZmRhZDEwOGRhMjM3N2Q2MzYl
N0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MNCj4gMCU3QzYzNzg2MTI5
NDg2Mjc1MzUxOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxD
Sg0KPiBRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3
QyU3QyU3QyZhbXA7c2RhdGE9DQo+IGJFN2twQ3NOQnhvRXVtQ0pEYldpZiUyRlg2WWE5cHglMkJH
eldBcVBUSjkxOFFJJTNEJmFtcDtyZXNlcnZlZD0wDQo+IEJvdGggb2YgdGhlbSBhcmUgU1BJIGlu
dGVyZmFjZSBjb25uZWN0IHRvIGxzMTAyOGFyZGIgdGhyb3VnaCBNaUtjcm9CdXMgaW50ZXJmYWNl
Lg0KPiBTbyB0aGUgbmFtZSAic2VtdGVjaCBzeDEzMDEiIGlzIG5vdCBjb3JyZWN0IGZvciB0aGlz
IG5vZGUuDQoNCkkgYXNrZWQgdG8gcmVtb3ZlIHRoZSB3b3JkcyAiRGV2aWNldHJlZSBiaW5kaW5n
cyIgYW5kIHRoaXMgd2FzIG5vdCBmaW5pc2hlZC4NCg0KTm93IHlvdSBtZW50aW9uIHRoYXQgZW50
aXJlIG5hbWUgb2YgZGV2aWNlIGlzIHdyb25nLi4uIEl0J3MgY29uZnVzaW5nLiBJIGRvbid0IGtu
b3cgd2hhdCBkZXZpY2UgeW91IGFyZSBkZXNjcmliaW5nIGhlcmUuIEkgZXhwZWN0IHlvdSBrbm93
LiA6KQ0KDQpXaGF0IGlzIHRoaXMgYmluZGluZyBhYm91dCBleGFjdGx5Pw0KW0plcnJ5IEh1YW5n
XSANCkkgZG91YmxlIGNoZWNrZWQgdGhlIFNQSSBkZXZpY2UgdXNlZCBvbiBNaWtjcm9CdXMsIHdo
aWNoIGlzIG5vdCBzeDEzMDEuDQpOb3cgd2UgaGF2ZSB0d28gTWlrY3JvQnVzIGNsaWNrIGJvYXJk
cywgQkVFIGNsaWNrIGFuZCBCTEUgUCBjbGljaywgYm90aCBvZiB0aGVtIGhhdmUgdGhlIFNQSSBp
bnRlcmZhY2UgdGhyb3VnaCBNaWtjcm9CdXMuDQpTbyBJIGNhbid0IHVzZSB0aGUgcHJldmlvdXMg
bmFtZSAic2VtdGVjaCwgc3gxMzAxIi4NCg0KPiBIb3cgYWJvdXQgIm1pa3JvZSwgc3BpLWRldiIg
b3IgYW55IHN1Z2dlc3Rpb24gYWJvdXQgaXQ/DQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9m
DQo=
