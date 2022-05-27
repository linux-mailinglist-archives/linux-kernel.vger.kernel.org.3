Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C74535DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350685AbiE0Jw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiE0Jwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:52:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD129C94;
        Fri, 27 May 2022 02:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBQONzt153aYfxHAd/rGLlc8gt+RzTBEDFTD5feU6SnMUfCA2nGPivzRvSdXfmrYmA4xH+TMwrCz4Yr+B+kAWgk/nCAhpD3TUfj0L3wesNSQ8QlQG9qXnd1DzGY9MBMm/UTjmH4/JMltOMV83FAh9fp0Kgj/VjJMujk2CnW/trvyad+5EvzxHeq5H2UrsxmLlNEF5UCqv23EIl8rDDE6S0BBGBqxM8/O9mWiep9yLwc7YoqfG/7Tfyv8NhCYmCtdJwKFm7j4xXaQDuwwU9TFnk3aDWS84xBMFmM3XAuIYyy5VHNtQ0xNCa37ezBOYWjnPMoeruea7LlPrV+zIAWeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DGcHGjPM0gSznoIhd7PMCSjoN1xR+p8+jRpUi15M4g=;
 b=BVznNUgCuFrXCxaB8KhMxn9wXsx7Bx9VpFFZy2tEgNK7SosIviOBkm2VL+mWB8Hgzm8GdY0Ur5nvxqwqaPG/VdH9ITuGkfl/WK4mz5EZUudCgm4mfZaIjRNgMfHYsim1RXqGYexn/JDwuzFIAHcANWtPiPsaOSuieCI34v287k5HXTMZTaIXKhhQYJjvbI+M2TalX0w6/pVJizF2Q6SLVoZMd+wcigyR5svpSGOb+4cHHutJs4klqE1dzhW2yXqB0sVDP5JnlhcPtd/pPyxV9qYlr/Rfv4qFzcGHKLaSTypCp1dqVEBrPHC/zDBGBsr/cDgcNGSCDgbL8USZCrSVlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DGcHGjPM0gSznoIhd7PMCSjoN1xR+p8+jRpUi15M4g=;
 b=m3aZynz6J2EFzwwrYAiXKuKO/JAOYPbrHz63qDSyP7hZDK+oRY+ywnTPPfZ3Es1x16P2AN79IUPpWE29jyPH/1q8GfEmZb8OjPl1bUVYZSPt43NlRz7fhMh7tuRemG3DW0SyLJ4UZ5WbIwiRTugQUGujkDhPdYfM2nauz0Z2APk=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6716.eurprd04.prod.outlook.com (2603:10a6:10:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 09:52:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 09:52:48 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before the
 configuration data
Thread-Topic: [EXT] Re: [PATCH] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Index: AQHYcZ8+YUShuD0M/kuLAZGNf36Y9q0yd8YAgAAC8FA=
Date:   Fri, 27 May 2022 09:52:48 +0000
Message-ID: <AM6PR04MB634165DE21CEE8B6780CB817E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527075437.16882-1-ming.qian@nxp.com>
 <20220527075437.16882-3-ming.qian@nxp.com>
 <20220527093824.GF11217@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20220527093824.GF11217@tom-ThinkPad-T14s-Gen-2i>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 192aa5cc-a234-4716-b7f1-08da3fc6a85e
x-ms-traffictypediagnostic: DB8PR04MB6716:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6716744E2FF55DE7FCE15093E7D89@DB8PR04MB6716.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVVduKt2gsewiar131Olbl+LLhXmOUr3cf60nJIXLbQtjwQi0izTW1Fq4KEXwfL1C/tVY+lCsUdHakuwj8PQM9nG01pD4C98MGf4jYDGWCf6yVdLx+oqzY71G1FaMFLPPeSigihS1OrqKxwuSK0u/VHg3CXpKsxMe8F8LRAvCexwTs2kx0JGeQJG11otilPqwz9MDc5vEaWr7vsEno0BKaCODwvnWlQZoycyIziZZT8f74SSOXLu1wW25m5ikRDHiIl0/odDa1Uy18tADT8/4c29V/MUSJN/P+IdPyTI4pQOm+D/GNNIUqdZ9t86npyfwQGtnZu7/8jFKgY91lpsKUqewrYVgpz/RVQptB3h2jjaj25u4BPnGyuP7kKMoJNw7CgtTPont9+A/LscILXN2oaZ8shdz5ILIzc6ZabrJphZDuk4DmMVSLuYiDIj8cZ0Yw4jj1mGa2WSrqAY0uTmIGvvgPw/Kie9Pjf0lik0kxe5vRUuwX9a3c1M63rmHlOrOHOSBo8X5+eIx6058lUYE0blg3+71K6vdWxqQJhVs0EgSUKqiSo6L8rq9NLwg0n9+RPLTvK8J8bqOkaDI2NzE85woinzwC1aBNBs6hkpeQjeoaeFARGQf8rU/SKFSOaIwfGOgQGn5hpwgahMdVFS5mdW1fC94lzoSfQrGhm1rZW/BlgUPd9kNBgTLuWob3E6QU2z8GzCATYm2O9/3nKyZdKYq1c8W0bKB8NR0ChSNJe9vwoZ2oayutvu5oeWPEkZBXcjdGp/g6AZKX4+94j00fCc2xJkIN6Z7wL9mCLPN5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(316002)(55016003)(83380400001)(7416002)(9686003)(53546011)(6506007)(26005)(86362001)(186003)(7696005)(122000001)(38100700002)(2906002)(66446008)(66556008)(66946007)(45080400002)(64756008)(66476007)(71200400001)(8676002)(40140700001)(4326008)(6916009)(76116006)(508600001)(33656002)(966005)(54906003)(5660300002)(8936002)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NitaR1crVi9CSWxUMWhReE1EMWV6YVFLaFFqeGROUlljRzVPWWtjcDJkTTJt?=
 =?gb2312?B?QUdoWEZMSlFBeVA1Q3VOKzYrOWZNQ2JtL3NwZkIwam0vN25abDYwRVdzTlAx?=
 =?gb2312?B?RFJjL25mZWZIWjJQSzN3T24xS3N0L2MrZzB2ZjBTRnVpN2ZaSk5YRU04NUlr?=
 =?gb2312?B?bmN4bk5sWEMvbzl1bktBcXFJT2JaajhyUmpyNWRIM2FYWU5yeVAxdXFseThi?=
 =?gb2312?B?dnlVYnlCYUNkVlBYb0lqUmF6YTRxamU2Sk91eG5FamdkT0IzOGZDeGwyT3Fy?=
 =?gb2312?B?ZlBJWlJjLzRVSWY3WHdiSmt4ZlVaVCtzaFY2QXdqMXlob0RkOURHTW0zZzRJ?=
 =?gb2312?B?c0d5MSt0WkZaKy8rMDc0SUtmS3VDYjV0T0xSM3FINlU3ZnBxa3p0bDBYaUxI?=
 =?gb2312?B?ZHRCM2pZNXJ6ZVlwY09jZ285RWZiRmNuUFRWcVRrbWtSZFpFZ3NpNzZkOExn?=
 =?gb2312?B?bXJKOGY2ajBqcERyTk0xejlaMUxXN2I5TzgrT2pSR3FPN1NweGJtZlFvSXZE?=
 =?gb2312?B?VlJOSzZBbmxkdTF4MTAxUnE0eSsxTWNxT2ZidTFUaVRYV1ZLSjNZQ2hmZlA4?=
 =?gb2312?B?QmQ3ZEpaV0IzZmhkR2p2dm1UTnRIZ0k0ei91Y2xUK2ZrSWFveU1RdlFuRzBl?=
 =?gb2312?B?c0k5MlNkK05KSFNxcE92MWZsdW13Z2dyQ2JBYXN3ci9iRjNjRytVRmhlQXVh?=
 =?gb2312?B?OXNjL0JKaVdEQ1RNczgvRlBGZXZaSGJUcUFVM1FGMGJTdDhXaWl5OHBVb3dV?=
 =?gb2312?B?TDYwTjVSbFdTK1NLeGZaVmM2WnkrV2RJWndnUHlzbTI1Q2FscGRMZU5JWDVq?=
 =?gb2312?B?a1J1WXZXWG95RUJUSTc0RzJIaWdhQ3ZjcUx6NkdVcUlXMmVYSEdGWFMwMFhq?=
 =?gb2312?B?YS9yLzZPZFk4TUhsZzIrZU5NNkRKazFLRG5HMWtrTzZoOXlhUTU1aEJCbG5P?=
 =?gb2312?B?Q04wNFZBZmJkVzhiTkNRNzVkazYxLzFMUHpNc2NrRFdZUHhUZVMxUWJtUmM1?=
 =?gb2312?B?dGYwMFlDeloyZStjV1EzZS95R1B6MVJhaDJjQnNoYWJ6cld5akZ5bHpHcUFK?=
 =?gb2312?B?cmV4c2lNaTY1d0FsZkQ3cFhXam94OG5RMWpMQW5FK1UydjY2ZUovcmxTV3BX?=
 =?gb2312?B?TzNGcUo1OEc2UTRIR1NmSHZPN2VucDhFeElVRm1WY0pIcVp1ZUpzUkxicXly?=
 =?gb2312?B?RmxGNlRoTmpCOCtqNXZFck1Rc2lSaHF6SHdDMHRGYkczQjluM0hjR0Q1bG1y?=
 =?gb2312?B?ckxXeXpsdkRCNkxpVmZxL2E1YnhUTG1wY2djQVNDQXJ0SzNaemE3S3o4bmUy?=
 =?gb2312?B?U0N5OGhzQUMvUVA2TStmem1STjUzU1pKRVNnRU5WWkQrd2l6TGowTFh4ODdn?=
 =?gb2312?B?b0RHaDJVdHV3OTM3R0J0bHo1TENPU0REVUJMRTIyaWFHYmxabXN0YnVTTHEv?=
 =?gb2312?B?eGY3M3RDVnEvTzVOa2FxeEdmdFRVZml4d0JVMW93NzA4WVRuRTF2Q0NSeVdo?=
 =?gb2312?B?Z3hTNFpUTUlpMVJLaVZxZUNZdU10bzc3dVFvZFZHdWh2aUZqeHlvTE15Wkds?=
 =?gb2312?B?YTNzSWFheGc2OWQxVFFxMGtOYjlRT1libVRqcWplSStCdDU2WmdJQnBiUEFN?=
 =?gb2312?B?dTZ1S3dsejJZTHhwU2F4RnJiSG4rRjNlSldkYzBVdjVXeExvUlIvQ0xremxV?=
 =?gb2312?B?M1R1N2RvVjZVZHZXY3pNSWJSY01RN3N1bDZ6QWxnVjZ5SVlXVGVzdXJTNy96?=
 =?gb2312?B?TkM5bWVvSjNybEl6blhwYVVSZndBQlp2MUpQQitvd25jUXQ2a1VuVmF5TXIx?=
 =?gb2312?B?eFdJZS9YSU1EbWJuNk5YSWpqK3ZRTGN1OXM0TzdBbTg1Z1c0N0xsd1hCaHIx?=
 =?gb2312?B?RkVzQ2gzYW8rc2NaOGhhSmN4YjkvR3lacXVSeUlpVFNCQnY3TmdFNDRGbUVK?=
 =?gb2312?B?Yk1zYVJyQXR1VnRQNHJzcG1kMHBOZDR1YVdHYVIxczUvU2l1a1k0SXl1bytz?=
 =?gb2312?B?c1lFUFBwa3ZaQS9tajB2d29yeHlsOFBGQ01yWjJ3M3ZvZC9yc0M0YU5NemxQ?=
 =?gb2312?B?VGVSZllHaVhlT0N6RWFVN3hoejczQmQwUS90RzY2WVFhNWZpSlRwMldYYlo2?=
 =?gb2312?B?L3lTVkFEVE8xNUpxZ0svUXVtTzBiRVh6ci9HYzVic2dhdzZCbHg0WmFjbmVC?=
 =?gb2312?B?V09PR2ZBeTdkcHpTY2V5NHRvUkFOV2lzTHZ4cjhXUVlWeTl0RDladFFsOThm?=
 =?gb2312?B?bFBTbGdBUVptRjBUZDd5STZ6dkdFUGhBb0ZjZjNwMTVaUWJhZ09TMVUwSDZ5?=
 =?gb2312?B?S1krM2o4SExycVUxMFRUNGtVSElmbUxyN1JlWlVIZE9YU2FOYWVGQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192aa5cc-a234-4716-b7f1-08da3fc6a85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 09:52:48.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWF28NL/9dI/KAqZuqp4s6ouUDXdh/KjBba/mOYl8xNoOeeF5N79HzS6U6gS+oxRrawaRlZupz+uchzoKwJd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBUb21tYXNvIE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaUBhbWFydWxhc29sdXRpb25z
LmNvbT4NCj4gU2VudDogMjAyMsTqNdTCMjfI1SAxNzozOA0KPiBUbzogTWluZyBRaWFuIDxtaW5n
LnFpYW5AbnhwLmNvbT4NCj4gQ2M6IG1jaGVoYWJAa2VybmVsLm9yZzsgTWlyZWxhIFJhYnVsZWEg
KE9TUykNCj4gPG1pcmVsYS5yYWJ1bGVhQG9zcy5ueHAuY29tPjsgaHZlcmt1aWwtY2lzY29AeHM0
YWxsLm5sOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIXSBtZWRpYTogaW14LWpwZWc6IExlYXZlIGEgYmxhbmsgc3BhY2UgYmVmb3JlIHRo
ZQ0KPiBjb25maWd1cmF0aW9uIGRhdGENCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4g
SGkgTWluZywNCj4gSSB0aGluayBoYXZlIHNvbWUgY29tbWVudHMgb24gdGhlIGNvZGUgZm9yIHRo
aXMgd291bGQgYmUgbmljZSBmb3IgdGhlIGZ1dHVyZQ0KPiANCj4gT24gRnJpLCBNYXkgMjcsIDIw
MjIgYXQgMDM6NTQ6MzVQTSArMDgwMCwgTWluZyBRaWFuIHdyb3RlOg0KPiA+IFRoZXJlIGlzIGEg
aGFyZHdhcmUgYnVnIHRoYXQgaXQgd2lsbCBsb2FkIHRoZSBmaXJzdCAxMjggYnl0ZXMgb2YNCj4g
PiBjb25maWd1cmF0aW9uIGRhdGEgdHdpY2UsIGl0IHdpbGwgbGVkIHRvIHNvbWUgY29uZmlndXJl
IGVycm9yLg0KPiA+IHNvIHNoaWZ0IHRoZSBjb25maWd1cmF0aW9uIGRhdGEgMTI4IGJ5dGVzLCBh
bmQgbWFrZSB0aGUgZmlyc3QgMTI4DQo+ID4gYnl0ZXMgYWxsIHplcm8sIHRoZW4gaGFyZHdhcmUg
d2lsbCBsb2FkIHRoZSAxMjggemVybyB0d2ljZSwNCj4gDQo+IEZyb20gd2hhdCBJJ3ZlIHVuZGVy
c3Rvb2QgeW91IGluaXRpYWxpemUgY2ZnX3N0bSB3aXRoIHplcm9zIHRoZW4geW91IHN0YXJ0IHRv
DQo+IHdyaXRlIHRoZSBjb25maWd1cmF0aW9uIGZyb20gMHg4MCAoMTI4IGJ5dGVzKSwgYXZvaWRp
bmcgdGhlIGh3IGlzc3VlIHJpZ2h0Pw0KPiANCg0KSEkgVG9tbWFzbywNCiAgICBZZXMsIHlvdSdy
ZSByaWdodCwgdGhlcmUgaXMgYSBoYXJkd2FyZSBidWcuDQpJIHdhbnQgdG8gd3JpdGUgdGhlIGNv
bmZpZ3VyYXRpb24gZGF0YSBmcm9tIHRoZSBvZmZzZXQgMHg4MCwNCkFuZCBzZXQgdGhlIGZpcnN0
IDEyOCBieXRlcyB0byB6ZXJvLg0KVGhlbiB0aGUgaGFyZHdhcmUgYnVnIGNhbiBiZSBhdm9pZGVk
Lg0KDQpNaW5nLg0KDQoNCj4gPiBhbmQgaWdub3JlIHRoZW0gYXMgZ2FyYmFnZS4NCj4gPiB0aGVu
IHRoZSBjb25maWd1cmF0aW9uIGRhdGEgY2FuIGJlIGxvYWRlZCBjb3JyZWN0bHkNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IE1pcmVsYSBSYWJ1bGVhIDxtaXJlbGEucmFidWxlYUBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy5jIHwgMyAr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVn
L214Yy1qcGVnLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1qcGVnL214
Yy1qcGVnLmMNCj4gPiBpbmRleCA3MzRlMWI2NWZiYzcuLmFkNDIxM2UwMjBmMyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgtanBlZy9teGMtanBlZy5jDQo+
ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYw0K
PiA+IEBAIC01MTksNiArNTE5LDcgQEAgc3RhdGljIGJvb2wgbXhjX2pwZWdfYWxsb2Nfc2xvdF9k
YXRhKHN0cnVjdA0KPiBteGNfanBlZ19kZXYgKmpwZWcsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBHRlBfQVRPTUlDKTsNCj4gPiAgICAgICBpZiAoIWNmZ19zdG0pDQo+
ID4gICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAgICBtZW1zZXQoY2ZnX3N0bSwgMCwg
TVhDX0pQRUdfTUFYX0NGR19TVFJFQU0pOw0KPiA+ICAgICAgIGpwZWctPnNsb3RfZGF0YVtzbG90
XS5jZmdfc3RyZWFtX3ZhZGRyID0gY2ZnX3N0bTsNCj4gPg0KPiA+ICBza2lwX2FsbG9jOg0KPiA+
IEBAIC03NTUsNyArNzU2LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCBteGNfanBlZ19zZXR1cF9j
Zmdfc3RyZWFtKHZvaWQNCj4gKmNmZ19zdHJlYW1fdmFkZHIsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgZm91cmNjLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IHcsIHUxNiBoKSAgew0KPiA+IC0g
ICAgIHVuc2lnbmVkIGludCBvZmZzZXQgPSAwOw0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBvZmZz
ZXQgPSAweDgwOw0KPiA+ICAgICAgIHU4ICpjZmcgPSAodTggKiljZmdfc3RyZWFtX3ZhZGRyOw0K
PiA+ICAgICAgIHN0cnVjdCBteGNfanBlZ19zb2YgKnNvZjsNCj4gPiAgICAgICBzdHJ1Y3QgbXhj
X2pwZWdfc29zICpzb3M7DQo+ID4gLS0NCj4gPiAyLjM2LjENCj4gPg0KPiANCj4gVGhhbmtzLA0K
PiBUb21tYXNvDQo+IA0KPiAtLQ0KPiBUb21tYXNvIE1lcmNpYWkNCj4gRW1iZWRkZWQgTGludXgg
RW5naW5lZXINCj4gdG9tbWFzby5tZXJjaWFpQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gDQo+IEFtYXJ1bGEgU29sdXRpb25zIFNS
TA0KPiBWaWEgTGUgQ2FuZXZhcmUgMzAsIDMxMTAwIFRyZXZpc28sIFZlbmV0bywgSVQgVC4gKzM5
IDA0MiAyNDMgNTMxMA0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3
LmFtDQo+IGFydWxhc29sdXRpb25zLmNvbSUyRiZhbXA7ZGF0YT0wNSU3QzAxJTdDbWluZy5xaWFu
JTQwbnhwLmNvbSU3QzENCj4gZDE1YzNjYTViYTI0OGFlNTNiYzA4ZGEzZmM0YTc1YiU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNg0KPiAzNSU3QzAlN0MwJTdDNjM3ODkyNDExMDkzNjA2
MDkwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5Sg0KPiBXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlNw0KPiBDMzAwMCU3QyU3
QyU3QyZhbXA7c2RhdGE9MiUyRlpsbWFpZElYbXB1clFCTlc1NnJvUWdhV25ZN0lFbFANCj4gT0p6
aEZhWmxvdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
