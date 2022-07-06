Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7C567CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiGFEJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGFEJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:09:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A941EEF5;
        Tue,  5 Jul 2022 21:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaGOWmBWZ4NV3124K3E62as1PVgICTd2kNFT3Vlo11FtBvVcfP9u4XZLwuU3ljh0WLqyMQ3L2A5Pwf6X3j1mV+XfppNcDcaDjD4boFmhFzVEAzQ8dbloVI9M2rXgSR4mj2Z9AHNTfRtBFlY0RJts/PS+htYEAiAb76mCs6p8R5scIBQuVTnCEFfLATPL/GsV4U/ZgvdEo/8nNY80UC9wuxqowHBXqM3hKk9IQm/jWcTwURMBQ//v89QhPoRhyfaqs3CG5+pZPdeoTpyIArBzKjKLnZjN0Im9c8MnoeGs1a+5IIWQ46/k5ysE27XBvDdswhWxGd1YmSUGnXMH8T0C7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+w2YOuQhSVLs5laLvvfccMOYkycN8gQF1NqNQMRS/Y=;
 b=WnkhX/vypKa5LILhfolHofKbAOcmnjpQ6eXPobVrojqHXk/QqzEWrWVw71tSWoaO79Osq6+wL1O46Kt+i3+qHyQZiOYXwlhrN43vUxK7kIWyj7IAK4JXEWm7lqnl7VX36r9k/ajAaSzqvMSQCcGH0UZW4ef9NRqq1d0C6n9vJcJA7zRvjgw0sbheAPBIVL6PsXBSAOPvCm34koHGFkYcajZ7olw2pkBOaUuQUp3PVbo1QTB9LUZcNFbUWmKffrmgPnPjazI2vfDxQK/Fbg4BFTTINjNBDBjT2soY20ya2yyOqdHC0Whriy7c/vJp0qFTqQzd9VwV9OST0RfmgM2yXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+w2YOuQhSVLs5laLvvfccMOYkycN8gQF1NqNQMRS/Y=;
 b=csCNsN48tOAYijpI1vAHr4ejwB59rQUyI2SmH5O7T0m8idx7dETUon1/vdkLw3jYLeJ5M0ScQbKhwCv2QoloUD4zMsQ2bxipR5D3YZxzIfVWsbsPX+0JsXJskbbKcJRtnepqVPoBfvXgTrE+Uj4U6lYnqLqa5OOs34Y7W55ILyA=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB9342.eurprd04.prod.outlook.com (2603:10a6:102:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 04:09:36 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 04:09:36 +0000
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
Thread-Index: AQHYiq7J1t29u6ewlE+hUMTTkjT24K1uamyAgACj+3CAAJ5+sIAAG8eAgAD9qIA=
Date:   Wed, 6 Jul 2022 04:09:35 +0000
Message-ID: <AM6PR04MB63416B4BA53E80123037AC8EE7809@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
         <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
         <AM6PR04MB6341F4EB028CAE9B61C85157E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB634136824EC98EE804FAD0CEE7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <42ba6a9516f4359b757d2f94b16c1bb23cc41cb2.camel@ndufresne.ca>
In-Reply-To: <42ba6a9516f4359b757d2f94b16c1bb23cc41cb2.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e4f7092-0275-46bb-9cbd-08da5f0556c1
x-ms-traffictypediagnostic: PA4PR04MB9342:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DLprLqEMztl7Dlllubjymx01fBwTOgWQxSMzYVWFePyXVbjE6cwNupGhDButaPt6MOmnk7xMnb2pt5Fud5LFVIJOgHrULSSUO0cQRO82ZNXr9TIw2q5aqDe/XwKPBuHAC7rcbqipg+3Gxd7LEInnQtiMmIko/Qwhi1oaU9vibIw5QZA73UcfHP0cIIYUDbOyYbPjyESS5ZyGc4MmWeO8kLlHoqW2mGo2IpbtdL1ff1JKk0U1Z3OFkbg1eK+G/hx8fdlutWX4z/wlCFec9JUdlKncPbiHt+YnZF1eA3xR9p0pzxYSfnygTj2BQ9cXjYd59QMYFNRZ5T5cPjqEA1RiSEEU94b0ax5fcOAkM8d+PPoqnIIRVva+W2qEqqLAoDp4zWMx1JQye21kme6Hkx9uUbEAfNFTyJOP8/nxD1+o2YxzaTmtwtqg1kekinQlpfgrZZua5DGggKfiId9Hzx045R6CGA3DqxmvcL291UjfxoRHIrVG8BHzIIq6Ym9yUmm5mDPzEbuSUtBoqB5ptG5cNnVyVyrrMHqcRVeX9NfIaTU9fwP3a7EwNVtaCVALijrN7zqdFUfbbA4yOH79zN/uj0jFQItDbr9U9XzlwYYOvMigExGgvn1GLCLyDAEcAmFManG4eLE0IHdB9Oh5VW1dlqWw8c2mDE0OOsAtkJZIu6M1o642++ECv85+QAd3DHmWX1oafKEuBao/DB1pAcY5QovBBwv7E5aGOMknfYsc+Djq4VKIakqVGh4/9oh6fpyJ+e+XyjO2gqkE25TTz0KSInbWDYVgtoqhxvxvAD23mOeVDmEZ+0DpWshyiHTcFhmjngDEOMRvmOZzu3wDB8fgw3wEngqUSCWUNeBLc14ajff+zApGH0UWVSY/jLq9BSX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(83380400001)(66476007)(186003)(66574015)(64756008)(9686003)(71200400001)(33656002)(76116006)(66946007)(66556008)(66446008)(8676002)(4326008)(478600001)(52536014)(86362001)(7416002)(44832011)(5660300002)(8936002)(26005)(38070700005)(122000001)(38100700002)(2906002)(41300700001)(55016003)(53546011)(7696005)(6506007)(110136005)(54906003)(316002)(32563001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTJzYkFKYjFraTFGdkxKTWxDSUozdHVGQlRiVXVuSjluV3RJR1poTUtGNGsr?=
 =?utf-8?B?T09UelN3ekcwNXpicENkM1VQOFNLQm5CRTdnWVBaQVVnajBzalpqZmltWjB6?=
 =?utf-8?B?M0dGMG43MUhqMEx3STBTR0wwVkpCdDgxU2xHQzUreFZQcURuMDdGd0ZQekYv?=
 =?utf-8?B?eFFlUnhMTWhWRWxTOFY1YTFkeEVEYlJOT2FMOUQ2bU9wMU04UDNoRHFoSFJs?=
 =?utf-8?B?VXdHN2ZxK0w1aWxzNDJCejlVNzhZVUx3cGdLcmh0SVA5QzhFWDA4V1UwcTJW?=
 =?utf-8?B?emV2WDFRaTlXN1VscnVNelk3OU5PVDVlUEVnQy9Ic2s2bTM1Yzd1YmJ6U1FT?=
 =?utf-8?B?Y0dhQkRTZkJoZC9Kdk5zbEM1bHhLVUtVOFIrS2w2WkFnajdxWmtmeHdobEVa?=
 =?utf-8?B?cE43VGZFTkl5dGVpZktKQjRjL2VDSTFYdTBFd2JnSU5oajVQMTdMRGVpUnB6?=
 =?utf-8?B?UWNKaTdWeTR4eEpNZGxISTZ4QlFHcWVQNnFzd2cvTy80MlpBb0JrMEQwVFZ3?=
 =?utf-8?B?SjJ5aldYekl5YnVYT1RzVzg1Sm03NXl2c0Fka0lPTzBDUEMzNzh6aXBHaEto?=
 =?utf-8?B?eWl5YnpKNWh2OU5lSVZPZ3IrS2pzU3JXRTBPZXkzWlB3dmhLY0VzV0dZMHZ0?=
 =?utf-8?B?UHZPTGRnc3BVS3ZpSkpDWGRBRjhLa0RSSTBqYjJCdFdYR0RqY1RmbEUxWVVB?=
 =?utf-8?B?QlgvY3NreHEyUFozT0Y4bFJhczByalpXNHNUVkJsZk9MYWhYWldzR2JDdmk5?=
 =?utf-8?B?VTRpRDlQZnVrMi9oT1p1amZrTWhiZ2dNeDBOQ1dJaFIrMDRMRU9LOGFBOUZJ?=
 =?utf-8?B?THFEYXNhZmplZ2doSjNqeGk1VTdlZW4wMWNkRzY4dFVORWNrM1JsL0lLTS94?=
 =?utf-8?B?alJnWlFFcDYrdXhxTnZQMXNteVRHMUxSRGtIc1BrSWo4SExSTFBxeGsxOWtL?=
 =?utf-8?B?K3VuUitCUmRISEVZYmF6Z3grS3JBbXp4bDJxNFpkK1JtWnFNZ2g0VzJXYkRx?=
 =?utf-8?B?b1ZqWllncENOc0dTSk9uVk9lakFLcHZieWZWYWRSNmRRd1hOcWIzNVBlcHJi?=
 =?utf-8?B?YTl0NzFscEJ5UFNtZnV4SjdvRXdaa0p4THJwVlcyMnZMRDdaK1lScVRlQ0Fw?=
 =?utf-8?B?aDkzSjY4UThLeVNGSkI0dnQ3emhkWEE0bmJid2dlMW9Kc21UYkxRKzROdDF5?=
 =?utf-8?B?YU1Ra3Y5cmhOYWVYSmp6RU1IUzdrL0dPRzBnWXdEUTlXdFE2djQwT2I0UkdV?=
 =?utf-8?B?WHRzMXVmQWltLyswbGUxYUpPZlhydjM2R05nWUs4V05qSVFCSHFRc1dWS255?=
 =?utf-8?B?ZmRhSUxvdlF3WmFsUjNQUElwNXRLM28rWHNMTzc3clFNMytCMnpnRUY3Rldy?=
 =?utf-8?B?SVg5WWk3OGNpOEg2ZXRORTVpOTVoVXFkTDBRUGRhUDE0R3VCTWtaNmtzandl?=
 =?utf-8?B?Q0tPRVV4eTVVbzB3eklFL0tIbk1QRUhqTTNhQldhTHZWUGY5QUI5WUFZc2xF?=
 =?utf-8?B?NC9NYkgvdXRiK1YrYTh1ZXI4cTF4OW9jSXd1SlNaOTdYNnJ0eU5IK0FWTlVp?=
 =?utf-8?B?Yk1vOXJDNXBSbjkyTUxqNGorSXBhVUVUQlNHWWpzNlVGZUE5a2VOREJUWE5F?=
 =?utf-8?B?QmVGaktYdisxNFNIYi9QN0tJY3Q1UTBubnp3VEp3WWlCQlRUb016dnlTVEll?=
 =?utf-8?B?UW5Ddk5oZjhuUmJBN1VMcG42VEE2cERwTXF3Qi9DS0tCNTJmM1FNaVdFWXQ0?=
 =?utf-8?B?RlhPS0V2Vnc5TlFLSXBZaDdQMnhvVURCUjdtbXN0TlVsNEV5YTNpcTVrQ292?=
 =?utf-8?B?dUdDK0hOVEpPbGJaUGRHOEhVbXprYlNxZjRnaTB6YnBibVdma3NnZ3dpZDFJ?=
 =?utf-8?B?OXBOU0xGcm9SMGxGVk5JL3FVaHJPN2FuWm9UZVdUSW1DRXVaSGtkVktHVSti?=
 =?utf-8?B?ZFFDT3diWE9uZDFMSTcvL0RYd29RUVY4NHJsL0NvQW5yNVViQmdEUFlzN0Ev?=
 =?utf-8?B?RW5GV2xHOVE4MGtjODhLY3Z6ZEhvM2llRGh1bndHNnJEZnNTSW1yVUdoQ20w?=
 =?utf-8?B?UEpXZnlQVkhMOGtTZjFsNFljdkRJMXMrWldZUWIzWFdqTWYxc2FsR0JaZ0E1?=
 =?utf-8?Q?TbfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4f7092-0275-46bb-9cbd-08da5f0556c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 04:09:36.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FfMrpvXzjH/rwx4MpdysgT2JvY1xTrQEGpsoJvKqLGhjfg6NcVwlWadiDCN4vGhV7kPNTisB20R0JwwzE4xFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPlNlbnQ6IDIw
MjLlubQ35pyINeaXpSAyMDo1OQ0KPlRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsg
bWNoZWhhYkBrZXJuZWwub3JnOw0KPmh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPkNjOiBzaGF3
bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4
LWlteA0KPjxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsN
Cj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IGFtcGhp
b246IG9ubHkgaW5zZXJ0IHRoZSBmaXJzdCBzZXF1ZW5jZQ0KPnN0YXJ0Y29kZSBmb3IgdmMxbCBm
b3JtYXQNCj4NCj5DYXV0aW9uOiBFWFQgRW1haWwNCj4NCj5MZSBtYXJkaSAwNSBqdWlsbGV0IDIw
MjIgw6AgMTE6MjcgKzAwMDAsIE1pbmcgUWlhbiBhIMOpY3JpdCA6DQo+PiA+ID4gRnJvbTogTWlu
ZyBRaWFuDQo+PiA+ID4gU2VudDogMjAyMuW5tDfmnIg15pelIDEwOjAwDQo+PiA+ID4gVG86IE5p
Y29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPjsgbWNoZWhhYkBrZXJuZWwub3Jn
Ow0KPj4gPiA+IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPj4gPiA+IENjOiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+PiA+ID4gcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+PiA+ID4g
ZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZzsNCj4+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+ID4gPiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQ
QVRDSF0gbWVkaWE6IGFtcGhpb246IG9ubHkgaW5zZXJ0IHRoZQ0KPj4gPiA+IGZpcnN0IHNlcXVl
bmNlIHN0YXJ0Y29kZSBmb3IgdmMxbCBmb3JtYXQNCj4+ID4gPg0KPj4gPiA+ID4gRnJvbTogTmlj
b2xhcyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVzbmUuY2E+DQo+PiA+ID4gPiBTZW50OiAyMDIy
5bm0N+aciDXml6UgMDowNg0KPj4gPiA+ID4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5j
b20+OyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+PiA+ID4gPiBodmVya3VpbC1jaXNjb0B4czRhbGwu
bmwNCj4+ID4gPiA+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7
DQo+PiA+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
DQo+PiA+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+Ow0KPj4gPiA+ID4gbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPj4gPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+PiA+ID4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBtZWRpYTogYW1w
aGlvbjogb25seSBpbnNlcnQgdGhlIGZpcnN0DQo+PiA+ID4gPiBzZXF1ZW5jZSBzdGFydGNvZGUg
Zm9yIHZjMWwgZm9ybWF0DQo+PiA+ID4gPg0KPj4gPiA+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+
PiA+ID4gPg0KPj4gPiA+ID4gSGkgTWluZywNCj4+ID4gPiA+DQo+PiA+ID4gPiBMZSBtYXJkaSAy
OCBqdWluIDIwMjIgw6AgMTM6MjAgKzA4MDAsIE1pbmcgUWlhbiBhIMOpY3JpdCA6DQo+PiA+ID4g
PiA+IEZvciBzb21lIGZvcm1hdHMsIHRoZSBhbXBoaW9uIHZwdSByZXF1aXJlcyBzdGFydGNvZGUg
YmVmb3JlDQo+PiA+ID4gPiA+IHNlcXVlbmNlIGFuZCBmcmFtZSwgc3VjaCBhcyB2YzEsIHZwOC4N
Cj4+ID4gPiA+DQo+PiA+ID4gPiBJJ20gbm90IHN1cmUgd2h5IFZQOCBpcyBiZWluZyBtZW50aW9u
ZWQgaGVyZS4gVGhlcmUgaXMgbm8NCj4+ID4gPiA+IHNwZWNpZmllZCBzYXJ0Y29kZSBmb3IgVlA4
LCBhbmQgbm8gc3BsaXQgb2YgaGVhZGVycyBlaXRoZXIuDQo+PiA+ID4gPg0KPj4gPiA+DQo+PiA+
ID4gSGkgTmljb2xhcywNCj4+ID4gPiAgICBUaGlzIHBhdGNoIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGggdnA4LCBhbmQgaW5kZWVkIHRoZXJlIGlzIG5vDQo+PiA+ID4gc3BlY2lmaWVkIHN0YXJ0Y29k
ZSBmb3IgVlA4Lg0KPj4gPiA+IEJ1dCBhbXBoaW9uIHZwdSByZXF1aXJlcyBkcml2ZXIgdG8gaGVs
cCBpbnNlcnQgc29tZSBjdXN0b20NCj4+ID4gPiBzdGFydGNvZGUgZm9yDQo+PiA+ID4gdnA4DQo+
PiA+ID4gYW5kIHZjMS4NCj4+ID4gPiBJdCdzIGN1c3RvbSBiZWhhdmlvci4NCj4+ID4gPg0KPj4g
PiBJbnN0ZWFkIG9mIGV4cG9zaW5nIHRoZSBjdXN0b20gZm9ybWF0LCB5b3Ugc2hvdWxkIHVzZSBk
YXRhX29mZnNldA0KPj4gPiBsaWtlIFZFTlVTIGRyaXZlciBkby4gIFRoZXkgdnA4LzkgY29kZWMg
aW4gVkVOVVMgaGF2ZSB0aGUgZnJhbWUNCj4+ID4gcHJlZml4ZWQgd2l0aCBhbiBJVkYgaGVhZGVy
LCB0aGUgZGF0YV9vZmZzZXQgbGV0IHRoZSB1c2VybGFuZCBza2lwIGl0Lg0KPj4NCj4+IEhpIE5p
Y29sYXMsDQo+PiAgICAgVGhlcmUgaXMgYSBzdHJlYW0gYnVmZmVyLCBhbmQgZHJpdmVyIHdpbGwg
Y29weSB0aGUgY29kZWQgZnJhbWUNCj4+IGRhdGEgdG8gdGhlIHN0cmVhbSBidWZmZXIsIGRyaXZl
ciBjYW4gZGVjaWRlIHRvIGluc2VydCBjdXN0b20NCj4+IHN0YXJ0Y29kZSBvciBub3QsIHVzZXJs
YW5kIHdvbid0IGtub3cgYWJvdXQgaXQsIHNvIEkgZG9uJ3QgdGhpbmsgaXQncw0KPj4gbmVjZXNz
YXJ5IHRvIHVzZSBkYXRhX29mZnNldCB0byBsZXQgdXNlcmxhbmQgc2tpcCBzb21ldGhpbmcuDQo+
PiAgICAgQ3VycmVudGx5ICwgZHJpdmVyIHdpbGwgaW5zZXJ0IHN0YXJ0Y29kZSBmb3IgZm9ybWF0
IHZwOCBhbmQgdmMxLg0KPj4gVGhpcyBpcyB0cmFuc3BhcmVudCB0byB0aGUgdXNlci4NCj4NCj5D
YW4ndCB5b3Ugc2F2ZSB0aGUgc2xvdyBjb3B5IGJ5IHVzaW5nIGRhdGFfb2Zmc2V0IHRoZW4gPyBJ
IHRoaW5rIG1vc3Qgb2YgdGhlDQo+Y29uZnVzaW9uIGNvbWVzIGZyb20gdGhpcyBjb21taXQgbWVz
c2FnZSwgc29tZW9uZSBlbHNlIHRoZW4geW91IHNob3VsZCBiZQ0KPmFibGUgdG8gdW5kZXJzdGFu
ZCB3aGF0IGl0IG1lYW5zLg0KDQpJJ2xsIG1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCBy
ZW1vdmUgdGhlIHVucmVsYXRlZCB2cDggZGVzY3JpcHRpb24uDQpBbmQgdW5mb3J0dW5hdGVseSB0
aGUgYW1waGlvbiB2cHUgb25seSBzdXBwb3J0IHRoZSByaW5nIGJ1ZmZlciBtb2RlLCBzbyBjb3B5
aW5nIGlzIGluZXZpdGFibGUuDQoNCj4NCj5yZWdhcmRzLA0KPk5pY29sYXMNCj4NCj4+DQo+PiBN
aW5nDQo+Pg0KPj4gPiA+ICAgIEknbSBzb3JyeSB0aGF0IG15IGRlc2NyaXB0aW9uIGluY2x1ZGUg
c29tZSBjb25mdXNpb24NCj4+ID4gPg0KPj4gPiA+IE1pbmcNCj4+ID4gPg0KPj4gPiA+ID4gPg0K
Pj4gPiA+ID4gPiBCdXQgZm9yIFY0TDJfUElYX0ZNVF9WQzFfQU5ORVhfTCwgb25seSB0aGUgZmly
c3Qgc2VxdWVuY2UNCj4+ID4gPiA+ID4gc3RhcnRjb2RlIGlzIG5lZWRlZCwgdGhlIGV4dHJhIHN0
YXJ0Y29kZSB3aWxsIGNhdXNlIGRlY29kaW5nIGVycm9yLg0KPj4gPiA+ID4gPiBTbyBhZnRlciBz
ZWVrLCB3ZSBkb24ndCBuZWVkIHRvIGluc2VydCB0aGUgc2VxdWVuY2Ugc3RhcnRjb2RlLg0KPj4g
PiA+ID4gPg0KPj4gPiA+ID4gPiBJbiBvdGhlciB3b3JkcywgZm9yIFY0TDJfUElYX0ZNVF9WQzFf
QU5ORVhfTCwgdGhlIHZwdSBkb2Vzbid0DQo+PiA+ID4gPiA+IHN1cHBvcnQgZHluYW1pYyByZXNv
bHV0aW9uIGNoYW5nZS4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gRml4ZXM6IDE0NWU5MzYzODBl
ZGIgKCJtZWRpYTogYW1waGlvbjogaW1wbGVtZW50IG1hbG9uZQ0KPj4gPiA+ID4gPiBkZWNvZGVy
IHJwYw0KPj4gPiA+ID4gPiBpbnRlcmZhY2UiKQ0KPj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPj4gPiA+ID4gPiAtLS0NCj4+ID4gPiA+ID4g
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMgICAgICAgfCAxICsNCj4+ID4g
PiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHUuaCAgICAgICAgfCAxICsN
Cj4+ID4gPiA+ID4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMg
fCAyICsrDQo+PiA+ID4gPiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3Jw
Yy5oICAgIHwgNyArKysrKystDQo+PiA+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMNCj4+ID4gPiA+ID4gYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+PiA+ID4gPiA+IGluZGV4IDA5
ZDRmMjc5NzBlYy4uNTEyMThhNDFhNWFjIDEwMDY0NA0KPj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdmRlYy5jDQo+PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vYW1waGlvbi92ZGVjLmMNCj4+ID4gPiA+ID4gQEAgLTczMSw2ICs3MzEs
NyBAQCBzdGF0aWMgdm9pZCB2ZGVjX3N0b3BfZG9uZShzdHJ1Y3QgdnB1X2luc3QNCj4qaW5zdCkN
Cj4+ID4gPiA+ID4gICAgICAgdmRlYy0+ZW9zX3JlY2VpdmVkID0gMDsNCj4+ID4gPiA+ID4gICAg
ICAgdmRlYy0+aXNfc291cmNlX2NoYW5nZWQgPSBmYWxzZTsNCj4+ID4gPiA+ID4gICAgICAgdmRl
Yy0+c291cmNlX2NoYW5nZSA9IDA7DQo+PiA+ID4gPiA+ICsgICAgIGluc3QtPnRvdGFsX2lucHV0
X2NvdW50ID0gMDsNCj4+ID4gPiA+ID4gICAgICAgdnB1X2luc3RfdW5sb2NrKGluc3QpOw0KPj4g
PiA+ID4gPiAgfQ0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+PiA+ID4gPiA+IGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9hbXBoaW9uL3ZwdS5oDQo+PiA+ID4gPiA+IGluZGV4IGU1NmI5NmE3ZTVkMy4uZjkx
NGRlNmVkODFlIDEwMDY0NA0KPj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1LmgNCj4+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
bXBoaW9uL3ZwdS5oDQo+PiA+ID4gPiA+IEBAIC0yNTgsNiArMjU4LDcgQEAgc3RydWN0IHZwdV9p
bnN0IHsNCj4+ID4gPiA+ID4gICAgICAgc3RydWN0IHZwdV9mb3JtYXQgY2FwX2Zvcm1hdDsNCj4+
ID4gPiA+ID4gICAgICAgdTMyIG1pbl9idWZmZXJfY2FwOw0KPj4gPiA+ID4gPiAgICAgICB1MzIg
bWluX2J1ZmZlcl9vdXQ7DQo+PiA+ID4gPiA+ICsgICAgIHUzMiB0b3RhbF9pbnB1dF9jb3VudDsN
Cj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gICAgICAgc3RydWN0IHY0bDJfcmVjdCBjcm9wOw0KPj4g
PiA+ID4gPiAgICAgICB1MzIgY29sb3JzcGFjZTsNCj4+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMNCj4+ID4gPiA+ID4gYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+PiA+ID4gPiA+IGlu
ZGV4IGM2MmI0OWU4NTA2MC4uZjRhNDg4YmY5ODgwIDEwMDY0NA0KPj4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X21hbG9uZS5jDQo+PiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfbWFsb25lLmMNCj4+ID4gPiA+
ID4gQEAgLTEzMTQsNiArMTMxNCw4IEBAIHN0YXRpYyBpbnQNCj4+ID4gPiA+IHZwdV9tYWxvbmVf
aW5zZXJ0X3Njb2RlX3ZjMV9sX3NlcShzdHJ1Y3QgbWFsb25lX3Njb2RlX3QgKnNjb2RlKQ0KPj4g
PiA+ID4gPiAgICAgICBpbnQgc2l6ZSA9IDA7DQo+PiA+ID4gPiA+ICAgICAgIHU4IHJjdl9zZXFo
ZHJbTUFMT05FX1ZDMV9SQ1ZfU0VRX0hFQURFUl9MRU5dOw0KPj4gPiA+ID4gPg0KPj4gPiA+ID4g
PiArICAgICBpZiAoc2NvZGUtPmluc3QtPnRvdGFsX2lucHV0X2NvdW50KQ0KPj4gPiA+ID4gPiAr
ICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gPiA+ID4gPiAgICAgICBzY29kZS0+bmVlZF9kYXRh
ID0gMDsNCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gICAgICAgcmV0ID0gdnB1X21hbG9uZV9pbnNl
cnRfc2NvZGVfc2VxKHNjb2RlLA0KPj4gPiA+ID4gPiBNQUxPTkVfQ09ERUNfSURfVkMxX1NJTVBM
RSwgc2l6ZW9mKHJjdl9zZXFoZHIpKTsgZGlmZiAtLWdpdA0KPj4gPiA+ID4gPiBhL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4+ID4gPiA+ID4gYi9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5oDQo+PiA+ID4gPiA+IGluZGV4IDI1MTE5ZTVl
ODA3ZS4uN2ViNmYwMWU2YWI1IDEwMDY0NA0KPj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2FtcGhpb24vdnB1X3JwYy5oDQo+PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYW1waGlvbi92cHVfcnBjLmgNCj4+ID4gPiA+ID4gQEAgLTMxMiwxMSArMzEy
LDE2IEBAIHN0YXRpYyBpbmxpbmUgaW50DQo+PiA+ID4gPiA+IHZwdV9pZmFjZV9pbnB1dF9mcmFt
ZShzdHJ1Y3QNCj4+ID4gPiA+IHZwdV9pbnN0ICppbnN0LA0KPj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2YjJfYnVmZmVyICp2YikgIHsNCj4+
ID4gPiA+ID4gICAgICAgc3RydWN0IHZwdV9pZmFjZV9vcHMgKm9wcyA9DQo+PiA+ID4gPiA+IHZw
dV9jb3JlX2dldF9pZmFjZShpbnN0LT5jb3JlKTsNCj4+ID4gPiA+ID4gKyAgICAgaW50IHJldDsN
Cj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gICAgICAgaWYgKCFvcHMgfHwgIW9wcy0+aW5wdXRfZnJh
bWUpDQo+PiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiA+ID4gPiA+
DQo+PiA+ID4gPiA+IC0gICAgIHJldHVybiBvcHMtPmlucHV0X2ZyYW1lKGluc3QtPmNvcmUtPmlm
YWNlLCBpbnN0LCB2Yik7DQo+PiA+ID4gPiA+ICsgICAgIHJldCA9IG9wcy0+aW5wdXRfZnJhbWUo
aW5zdC0+Y29yZS0+aWZhY2UsIGluc3QsIHZiKTsNCj4+ID4gPiA+ID4gKyAgICAgaWYgKHJldCA8
IDApDQo+PiA+ID4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ID4gPiA+ID4gKyAg
ICAgaW5zdC0+dG90YWxfaW5wdXRfY291bnQrKzsNCj4+ID4gPiA+ID4gKyAgICAgcmV0dXJuIHJl
dDsNCj4+ID4gPiA+ID4gIH0NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gIHN0YXRpYyBpbmxpbmUg
aW50IHZwdV9pZmFjZV9jb25maWdfbWVtb3J5X3Jlc291cmNlKHN0cnVjdA0KPj4gPiA+ID4gPiB2
cHVfaW5zdCAqaW5zdCwNCj4+DQoNCg==
