Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F58539ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbiFAH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348104AbiFAH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:56:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E9939B1;
        Wed,  1 Jun 2022 00:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfB65gOgK95mm+qbLLmob3QbRfRNya+2oOjewY7ryUvEpO+vBTTEbaFFY6TNCoSjbiWJWqix8ULfS+IOe44LfM94TKjAT6VH3Ni8ytUY1YQj7+rTMjTie/qkyOzxJRtCu602YHU1FF6/6IdFZgESAHKiK3BXxKh84iYhGvh/qqcSuZ0UWsjLh/izeD/1pJyoW9TjdSrPeev88qxWQjMFmLOo+d093yUL7T7KuvcV0gZpSASCFUpjR2gT7tJs/it3fPJ0AVO8HJnInMbXxrE40BFCTuZ5bq0ISwzas2+sNCIQ3xduD8DjQ2nMbyhxZ/sqRuH0JLEtdMyzhaIuEWTbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkBT92vcjiELXG3FDL/106+gk52lQphumpluunTaLGc=;
 b=kkIQ3NNYVD2BpOvwdE33McD+rznwIaWUERsAOsvPkm1TIkM5My1rxyRJj0n04e3dBc33pioz8LW214izbA+qXZcAS2NOSgAggUIlvZALhWuVHdHrOsrdWIvKNbJjuTq+UGFnIN1XiVOJPtxw1rCTIKwnmasONhV10f0xw2TK2B8MxCN2Yz0JblBsI0rTeW+22P2pu7rD6sbj00XhlLSZc3sDABM8COfV3MZqO9r4H1rdhIWBFtxZnsXPuvjWx86/Mpq2LppNvdJdSxvIxU5laHAw+CbsSIeVdHcELuz9nLCzi8U/2676qLq/WkmmOfZv1Nz1HoAUuT493JylzBpwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkBT92vcjiELXG3FDL/106+gk52lQphumpluunTaLGc=;
 b=E8aoa9H6XC+yY5Jsxguxd3XheeTTrKkGVlu7vgZRQNLKsbexPk4tsYuyAekeFJNaI1vgIxASQKArOvjUFxd7PspJ+XAJjKFY3+YieS7RJ615OyAo6w9VSQCwczMEBwYfhoZU08OXSumaMhxds5kuUbT7Dp9Gn5YAdY8P07F7vVN03K30dfFkT2TTmfAXeIhdLPHyf8ibgbjj0gg4Jw0cmldZjL+QCtCNCbarbvtT2qGwX0oAcAbN51BA80inWOUNX1ZWPpqUJMZp4DTZ2GU8xRqE7WAumVFT3A1peliRsVM4wxhSvEbRVKV5c1ctnnjmyeEqauWE4l5lS3uRdlbC1g==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY0PR06MB5377.apcprd06.prod.outlook.com (2603:1096:400:214::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 07:56:28 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 07:56:28 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: clock: Add AST2600 HACE reset definition
Thread-Topic: [PATCH 2/5] dt-bindings: clock: Add AST2600 HACE reset
 definition
Thread-Index: AQHYdXpflfP5aSpYGU6cNfpVsoLK4q06LDQAgAAC4SA=
Date:   Wed, 1 Jun 2022 07:56:28 +0000
Message-ID: <HK0PR06MB320250A180CB8E6CA0C96DB380DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-3-neal_liu@aspeedtech.com>
 <c2f1621e-21d0-3836-6bb2-c1fb038856c5@linaro.org>
In-Reply-To: <c2f1621e-21d0-3836-6bb2-c1fb038856c5@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35db870c-420d-4524-9650-08da43a43c05
x-ms-traffictypediagnostic: TY0PR06MB5377:EE_
x-microsoft-antispam-prvs: <TY0PR06MB5377FB72EB81B9A8F2A43ADF80DF9@TY0PR06MB5377.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SO+WsZ34GSchoOoEwfeoOprejYjst32mAdl81IoX67zBy3qvtPzEjzsuzL8LnEdEaLlfU3xiYV1BD/Qjm9SroswzFUkk1q3bwRaRnvSdF2Q9C6fjqF9vj+Goo1HGpWG1jwtOPjT71+nUfzrxYPViDeK+tAxh+tTZ2tmZfdhIyyKC2ztuH8YX1dXJ3dCdEn67Z9/ZmvIm7jpHdkvJeuP3V7YDTjdP8wHLyBnLw1M8Rb2E2Yev0RjWuHfIA6HD1m8hT+SOXsXKpXM6Ersl2Qm/hj8z4QCXs/ACqkOrhlpo0mrEqRnhQ1wGAq22HrSKeqCK1JTatKOw/rhhQs0FaZJnvsPyLtuqsvBAyKarTMTOUIrozTrQ9M71R85TlZLnlq1IJNgHa1/LkM6bgEViBGFqXki7Al0MycQxEoQYoC3fYsCItr6lBRPl06QVYSyRzjLEKCt/2EXnuULOm58H0xmSKaJQklGqkBnQXH2+1LVxXPjK/MNjJAWNnX2jsG0HAV2kQiMP8RqyS5GOH7S9WFGYitARK5bnuwFSJF7dvsf/44VRMj3CkN45UWM8muMDA6CCm0lwCMdLck0lwwbH0MhQvb1k6yWdj+sa4IHpJDDJL1tWKj31x09jfsTyNsYqAKZiCb6AC8ksmSCDsQsBDuQvdaYofA/ll0fc9Xvbtf/H5aJf5udmClqZr5r3vFVNnBxs3rocPeFPFFRsFzuCfJIkgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(33656002)(9686003)(26005)(186003)(76116006)(7696005)(38100700002)(66476007)(66946007)(66446008)(64756008)(4326008)(8676002)(66556008)(110136005)(53546011)(316002)(55016003)(38070700005)(2906002)(86362001)(8936002)(5660300002)(52536014)(7416002)(508600001)(558084003)(71200400001)(122000001)(54906003)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RFcVNBYVJ3NFp5ajA0Z1Azbk5IcGNZWUcyWTNlSWVaRFllSENNTmNZdG8v?=
 =?utf-8?B?YnBWU0FWUzZVV0dsRlRLRWNlMHFCSjRwZGdvSlY3K0kvZERIUGpXbS9CQjVF?=
 =?utf-8?B?cVlaeXZnaUt2TExwK0g5WklORTVkbFVwQWdpaytnQW5GZWVSUk5iTDdqYy9i?=
 =?utf-8?B?M0xUUGs4YWFoejBtL0M0SHZBcS9ZbURKNVZtU0dJVDdMMTZ4TEpJdUV1NzVF?=
 =?utf-8?B?dmV6a0kxemlUdEV2STZxSnJKTkcwcDcrczVHbWpwTStlWmorT05VdVVTMkZV?=
 =?utf-8?B?b3BPNGdPU1RsY1JlOEtGWlgyanBBM09SemM4NGRGbE4zZzBCWXFpeXZZNE5G?=
 =?utf-8?B?T1g1SkJ3NHZlRTZJU01DRUI2Nzd5WTU4dE00SUVrRXdJeG10dC82dnUvc21i?=
 =?utf-8?B?MGxmVVl6aWVkMUhIUVpOM2phT0s4K04wektZUjNRSFppbXB2ZUd4RC9GL2NJ?=
 =?utf-8?B?NDVqNkRQOWdvYTZmQWowNVlvTStBT2Z4dmtja2RyUEhld3FOZGNQUnpOd0pV?=
 =?utf-8?B?TzVlOGE5VzFNaXA1YU1FTmNSV1RqL2diOVpUTVJPaHc2Zmk2T2Fnd1F3M0FE?=
 =?utf-8?B?bGVleE10cVN4dThyaXZ6cGI0emxBM0NldzdIcjRoM1AvRGNHbmpCWXh1c1Yv?=
 =?utf-8?B?UW5jUFdoSytkbFFTcytJVmROdGZKRjZjVUJrS0NSNzgxZWVUQjc2TlNnNktu?=
 =?utf-8?B?ZitaTG52MGp3NjkydEtHVmplMHdZUnVrZWI0QzB6L09CYmZvdzUxWS9zU3hY?=
 =?utf-8?B?UG1wMEVMbm45QkE2L1Y5TWxGQ0VTb2x6KzlkTXpLUW44cSt0aStrL21EWnM4?=
 =?utf-8?B?T3VENnc2ckIyLzhTTkdxZTdFa0NSOWwxN0NQR2NScmhUamRqTm16VlVDVFVC?=
 =?utf-8?B?ZzR0M0VpeU5CYWpXaXN1MU1tK0FVeStYeHExZWxCS1IyREhDdWx6LzJnTVp6?=
 =?utf-8?B?aDZPcWx0UFJiZTVPTWp5dUdrUWVEV1l4eGJEQ3NqMTZpalJQZHhkLzFBRnpk?=
 =?utf-8?B?c3liMHk3dlZJbVc3NjJRZldCVjZoM2Q5VVN0SEhrazhSUHMrU1pHbk5YdGxl?=
 =?utf-8?B?WGxNdUtQYkxFNUJhdHJ0bXhldVpVS0JWZWdub3ZTS3BER2I1NnJYdGR2Yk5Q?=
 =?utf-8?B?TFZoanY2UEZwN0JJaDRWQ1ZtMEpKdFFSMjdKajBVWUNvSVQ3WSthUWYvN1gw?=
 =?utf-8?B?TW05MDZPVHh1WkVrZklkRGlNc3ZBUVBXdjRVQ1lhNm9LR0t5ejZHaVBoSXlJ?=
 =?utf-8?B?MlNCZmhKTjc0alBYS0VWTWpmb1djZkkxVnhvOEg3WDczczFmSDlLbmpMbnpv?=
 =?utf-8?B?d1Y3c0x1U1A4KzF1ditVQ3NXWElSTTlaZHZGVHgwb29CWVFZdENNZDNJWTUr?=
 =?utf-8?B?YUhjaDF2VUNQZWRLWkNHK0w5OHQ2NWhZYmhJOEJRNVUyU3RCOTZnbVNGM1hM?=
 =?utf-8?B?MitaTUJZcG5hL2lSaUFCRHB0enNtK281cVhqNXJmVU14LzhKREMwUFlZRFRM?=
 =?utf-8?B?RXpJcy9OTG15QjlrNk5OZlZ0eEd6aUNMYXpTbnNKaEF1SFVrdmhvd2dZV1Nr?=
 =?utf-8?B?cVNnOVdaR0thdkFad2tnYnlUY0N6ajBCSVRCNDFkZlJEdDhVV1MxZVo1d0sw?=
 =?utf-8?B?Y2U2WEw4YU1hMTVwQ20xdjMrYmQyNFhVQ2phdEd0NmFBdCtlZ3E0eTh1TFJR?=
 =?utf-8?B?UmwyUmlaMXZNTFF3YXFMYnpZUDE3bnZuL2lnUjdkZCtJZGdMSGxwekFyNXNu?=
 =?utf-8?B?RnJTeTdIL2tOQk5Ya3F0TmV1dTlMdzROUHQ1SlJPem9EeGpkU2tBYnlQWDha?=
 =?utf-8?B?U3EvTXMvZTVXQm5uRFVSVVY1WGxxN3ZCWTZCcGd0b1MraC9xNThYZ295SzZO?=
 =?utf-8?B?a3VoNTg4Z01jck10R205STNVQ2hseGRpQWU5WVBrNnFNVldaK3JabnN5d24x?=
 =?utf-8?B?K3Y0MjZZYkdaL3lINCtCR3JGd1c5YVNES0pYZFZKazZYYWkzODlNaXl5T3l5?=
 =?utf-8?B?S1ZGVFNrY2pxWDBCczlEZzZ1MVR1YnAxeWNyNnhOMml6Y0kvVnFya21WcTNR?=
 =?utf-8?B?RmRjV052NW9qeGFKZ3FZNXNtUlZ5VFFZUjNUUGpiN2dmWTJHOEVOVW9nZ1U5?=
 =?utf-8?B?QjVNRUNlcHZ2WTY5TUQvVUpSMFN1ODhoa0FndGg5UmZRUHl0RHN4RGkwZ1JV?=
 =?utf-8?B?cFU4bkI5TTJpbzNYQUkxRzBkYms1OEswN2pId213VE90b2YrMWd1QjlacGZw?=
 =?utf-8?B?NjNNSk5yUWlCTUIvRURhTVJOTXpIQmo1Y2dsekR0WlIrbTFWQlVyaWk2UnVw?=
 =?utf-8?B?TEYydVcvaFdQdjVNdHNjU1JJYUozeTdQZlRtSUZWMXN0bW4xNFRxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35db870c-420d-4524-9650-08da43a43c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 07:56:28.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAtqPli6NJ63K7vpav/Zc0WRXgDcESu68q6cfOzTA1R+PZMPtYoc5tFt+My2BGLEHmByoK5t+zF3Vx6GFUfRHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwMS8wNi8yMDIyIDA3OjQyLCBOZWFsIExpdSB3cm90ZToNCj4gPiBBZGQgSEFDRSByZXNl
dCBiaXQgZGVmaW5pdGlvbiBmb3IgYXN0MjYwMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5l
YWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hu
bnkgSHVhbmcgPGpvaG5ueV9odWFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gDQo+IA0KPiBBY2tlZC1i
eTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0K
PiANClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg==
