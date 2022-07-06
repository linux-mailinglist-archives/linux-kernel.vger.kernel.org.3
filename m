Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B4568208
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiGFIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiGFIqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:46:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA715A1C;
        Wed,  6 Jul 2022 01:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+WwsPK10O+0scb2KzIB22Z3k0WU0xAOM7HA8tNJ0V15E12/7sqV5hyPJCZlMowbKTykZSMuCB486astyvPSA63k+c/jCauX/EAbSSgSuR1sE7QwH4mgoM89rcONVEy3mNKqaQN3y5Nmtc+rPA47jqXNozxVdYLvEuAyiVJcZZMbDaeqgD8PbusWyhICZuyJm3bOq0p9fE3YIBf1xPdVYMHOqKRJ2P0a6rDQfmLh0uo+1OkfAjxUdhVf3RU5Tpdibvw718rbsgoqvtuUpL/5utI/uo59uNZKyufJ54HlmdYKp00wAilqWOhZUAXO+PZYdliBdBvnERqO26IwpNuprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIRgE0K/8MLBSU6j0B6ckKvmwtI0lFUGH1uqPbuY9r0=;
 b=g4caVV8meVICiiqtHIJKAsGzpU36Z5anvLPdmDsPt6wMzFR2ZJiRfRmCY2Ou8JBYrJt8gpZluuwoUHll7sdIJ0QPi0dwKZrF8LwvyRkqSvNQaYYbsu7QheREMbL5hb+A9cdSvvhu/OH3leHLm1c7mdo6gFBXAWewieSvzkwo9b2zWW9grcOdgdI8uSchyJHuEBuGrEdbY4xbxs22hIeC2iv3Kd6QMp3hv1htf72gXigPpmgfTr5Yb3zPflGF/96v7CERIVszcrk2yY30Ck5knMK1MoyIjIAEWTw2ryzgAmKkf1cWPp2i9Gl4XaFQRf7XtHQUT1tgD+UqzgJzlpcFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIRgE0K/8MLBSU6j0B6ckKvmwtI0lFUGH1uqPbuY9r0=;
 b=Dt9p5hKCU2+HkUvlkqGoCmJ8rAYwSvndvvzlHlTbsUxUwcrTBM6LXcrj0rRFAGsy23ABjWrOWJtiFKd3rREht4QBr28cPx6oQRdij7KkGbbgNhWORojD4ELaiP7BtRHQrkMI2fpbGHir3mBgIJZk8mDlKYGzY7MCcdRS/rwVlI4=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 08:46:12 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:46:12 +0000
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
Subject: RE: [EXT] Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG
 flag
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2: add
 V4L2_BUF_FLAG_CODECCONFIG flag
Thread-Index: AQHYipWDeE/RzjQxDUeRnOJpMoOdSa1uZxMAgACkm7CAAKRKcIAAHKYAgAFFRMA=
Date:   Wed, 6 Jul 2022 08:46:12 +0000
Message-ID: <AM6PR04MB6341A3EC4B632B1A918D4069E7809@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220628021909.14620-1-ming.qian@nxp.com>
         <a834a00ba3c4fa8a08290c55d264307fdcf6fabd.camel@ndufresne.ca>
         <AM6PR04MB6341FA1173A9C5645554F882E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
         <AM6PR04MB6341F78F9B7355C5C9188932E7819@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <3754827c8296d3f6712c12a50e36048bbb9f66aa.camel@ndufresne.ca>
In-Reply-To: <3754827c8296d3f6712c12a50e36048bbb9f66aa.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8710c8e5-3cb0-42da-50ff-08da5f2bfaf3
x-ms-traffictypediagnostic: VI1PR04MB7182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQhuEyIwwbvahnKZCNdH7BBtEjchMVDOxWX10hPRiJtZTfT9KVVEMI4yaom5FiJ7Oe7onVtxNVy2khpfdrvY4T8xMEeMs8KTs7jcHwSvcOeDvJL5Kaoyd0lL2BvOXafDAKQnxTkel2yGueMCBNQkW1o0FvcrgvezEzigyamBsS01iJyfVAGqozgsN+iWANf2QKx9otFXIteTzhGp35zX1fokeqYqYlBvdI5bLBLBmOG91W+JRoxC8nWqDuYIp+ZaYhK9kJ+IA138vEgma1CpuR+SDDfEN+zxria8mtWVRyCM2bDhDyz07QwRoGM/aGg0Aj+aPZRQ5zXshAlomAxHg7YxldniK8JO3h8U3EUmGyPVUjiu06Vua0Zh/L9Qg61IB/Zza43JywNizcjPuULufb6yLA+IiZDdTp8MADVJiYKyYXhkb9CGx5uCm2YbstQLVb1gnAzHixfvK0MFozpPyzgbr8/PJnGq2K78/owsWcZ0RMFqyO1sUwQeqzp4LuBOA25UUSUwYbJ5Wiiin2S0Z6EVAxKE3+61oECfLnfXnNsXc+iRk/JB1KpwebtQjXTuNKreugSCHHgNmWwg8xoc5O1jxN5d+hUVp68kvVgCDTjmTspFiZA9Fn6Ncu/WBvyiVnm6MdnMZMZyuLxJN52gNTvRzXZ+Ks4wlyaE+Wg4AGas2t5Z8KA54+7xqJ/Cypw5GmqlBqkDJV70AgeQn/IN2pqm5kxuDoZBDZqFJ1zfVnWCM7NlcK5IPbeX9gusHfP7o6tQhKDWgEL+ybvBRCyPJopLGDcyHJ5M6oLIioR4ppHc4ru1HOqySZLUEVaKSeMz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(44832011)(8936002)(66574015)(71200400001)(5660300002)(186003)(52536014)(86362001)(55016003)(83380400001)(26005)(110136005)(54906003)(316002)(7416002)(2906002)(478600001)(9686003)(41300700001)(66446008)(8676002)(53546011)(76116006)(66556008)(66946007)(66476007)(64756008)(4326008)(38100700002)(122000001)(38070700005)(33656002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmFKd0ZPbHArc1VCVU1jcEs4cmZQbG03bHNUUnVvaVY1cHhIMExvU0dtZWRi?=
 =?utf-8?B?YXFrN0pyRHBGNDBRbVZXSDVUZk1CbFltYk8ycmo0aGlnZ2s2eXBQckt6TWhG?=
 =?utf-8?B?UVlEZDBnM01acUZKdzVpNStRWCtEZHpnYXRwL2Y0bU5ieFZvbTU4N2Exc1kr?=
 =?utf-8?B?RWRRemtJbFN5TWh3cFdpNWxZek9uMVplVzU2K3lFakUrVFN5NXZJdVZ4dGR6?=
 =?utf-8?B?dnpkcC9ndWZvYjVDTmV3d1g2ZlUrQkI1UXY1R3J4UTFRTEFTWmxiSXNJSi9m?=
 =?utf-8?B?a3pxdWlXSWNEVWdNamNsQUFXbHdPRVlDbE9iZjZtd242OXNHZVRaQW1kdUtw?=
 =?utf-8?B?dlMxNDliWGtxdkVYNXRTNWFGUnZyNzBhbW9JREVYMEZwQjd2ZUdxeUNxVVNP?=
 =?utf-8?B?M0ozWVl2cmhiZnVBYUFqWDNBd2dETHBFZjZHTnVzQit6Yy8rT3FQaDZScTdh?=
 =?utf-8?B?NDBpMzlxV29YdmRlelBpQkllU2FjTElabnk2RHI0RHJjb2lrY1MxVkI5RmpH?=
 =?utf-8?B?T1NQM2w3NHNDTE5VbjRRTmROUFBhdjZnR2lzMFVOMW8zK0pTUkkrMG9UdWRH?=
 =?utf-8?B?eFgyQk9KRW9SNTNEZGVFbUFIalFXSzFnaW9ablhZWVdRNHhsOTFDOG02RXV4?=
 =?utf-8?B?b09jUFQwNW10TjN1aEdGK3JrVFQ2U2xwaENBUk1BLzZXeFM0bzgxUW13MlZs?=
 =?utf-8?B?SXgxRHZwN011VTlXd1h3ZDBtRUxic2lrMy9hcFhqeTNOWW5iTzNxQXhnOGF2?=
 =?utf-8?B?NGtVQTlic05nb05IcVphTmRvQkRuL3pUZWl1WEpJN0ZvZ1lMUVJYVHRnSmJX?=
 =?utf-8?B?TkpYVWJ5M3ovZHlTb3RYdFdublZOL2lhR052d0VaV1ZpSmZCRGoyM2tpQXY5?=
 =?utf-8?B?RVRZZW95c3NCTkt1RFZSSHNWRS9KK0ZmamEwK1pGS3F5bzhsWUhwMEJIUVhD?=
 =?utf-8?B?MTkzcHNlTmpIQjBxNXlPbWtLNGlEQVluWUc1ODFTYUFBdlJFdTVXN01SSGNo?=
 =?utf-8?B?TktJbzJBT1dYSHRqNFdNazhLYWo1U1pmUDREN3pJREFwNDA4MWtSdmxRaVhn?=
 =?utf-8?B?R0FyOXNoZjQ0eXJIZzNZblN0Tm0wV2FMc0NWWUNWNUpMNksydnF5c1F1a01w?=
 =?utf-8?B?bHFyd0pOVGZSemxRcDBPZFpKM05VV2Z2cFowNHJZWldpNTJJVGpEb0s4NUUy?=
 =?utf-8?B?Z3hyY1ZxT2t6d0JmVmlBNngwVzVuOTZYRUIrTnB5KzQ3RHN3eHllZnJxc3lU?=
 =?utf-8?B?SlNBN0d6SmFTbkJrNjB1cWxwQUlaOUpiWUtMYkM1aVdGc1NROEUrN2JZUjNZ?=
 =?utf-8?B?UlBUOEFwQlptQk5KYTRoeUV1VmVCVis1cVZnaE1WUEFMUUI1SE9pSjd3c0VO?=
 =?utf-8?B?QnBnZi9HWStiOGdzWllmZ3RQZVAzYTlBZWk4b3FGK3BnRzFSOGNFVXJCd1lM?=
 =?utf-8?B?VWtHREVpa3lTMis5T05tdDRlY2MzU29KOERlaEpKdlVOOUN3WWRXaHNvZFZk?=
 =?utf-8?B?UUtEbDVlc2xFRm9MZHp5SGdiM2YyNUJORlpVUTRyaHBySHdHNndiRCtFNjFi?=
 =?utf-8?B?UWx5T1RrWkVDUkpOSzhlMm9hdDdHVTBCSkVhTkVBNXFSVXZPNzZBUkRNcHk3?=
 =?utf-8?B?L1ZieFM3SmZuY1JYUlFCM1JJbWFtTkJ5bVMzQ1UraVRVb1hJZkY5RFVQeFo1?=
 =?utf-8?B?QUFMMWp5UUxJVVc1Ym5MVUZqMTZrbmJVMVNLUWhFRHNqREpOK3VnZUp2RDRH?=
 =?utf-8?B?bEwxd01yeC9CMnBaZmdZR3NWeWkwVUN4VUxMUnliRnBlMjg3VHlablZrem4v?=
 =?utf-8?B?MmJEOXNOWmZpd0R0cGZ6VFR1V2g1cTA0dUhNREFkNkpKb01HZGp2U1lsWkFo?=
 =?utf-8?B?RXBOZDBBYTZadW1PcllkT0ZpUEUreVdBbVdrTzRqYlVRTElRTXNsd0FJdkFS?=
 =?utf-8?B?VE9XaG5qY1VDQ2J1b1NrVWluWGhxYU1TREEzTFpKRE9SdkU4cDN5NGNTd1RF?=
 =?utf-8?B?ZlMwU3JvdGNpa1lIcXVWM08vV0RaMDJ6UldKbE82djQ2QTBMNy9vdDJlNmg3?=
 =?utf-8?B?WktUSjBvQ0hlZ2wrT21Va3RSUTBaZlZ4UFVoMVovWE15UXhiQWVpejdzQmwr?=
 =?utf-8?Q?8py4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8710c8e5-3cb0-42da-50ff-08da5f2bfaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 08:46:12.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQqdQ7F7GIyDZvsJQsZxWu8+nZwU81F60UJ5QfhHYREGhYd0a851AbzGzB99Oi/54iPWDEWTcYnEsvm457ylyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
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
MjLlubQ35pyINeaXpSAyMToxMw0KPlRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsg
bWNoZWhhYkBrZXJuZWwub3JnOw0KPmh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPkNjOiBzaGF3
bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4
LWlteA0KPjxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsN
Cj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IHZpZGVv
YnVmMjogYWRkDQo+VjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyBmbGFnDQo+DQo+Q2F1dGlvbjog
RVhUIEVtYWlsDQo+DQo+TGUgbWFyZGkgMDUganVpbGxldCAyMDIyIMOgIDExOjM0ICswMDAwLCBN
aW5nIFFpYW4gYSDDqWNyaXQgOg0KPj4gPiA+IEZyb206IE1pbmcgUWlhbg0KPj4gPiA+IFNlbnQ6
IDIwMjLlubQ35pyINeaXpSA5OjUyDQo+PiA+ID4gVG86IE5pY29sYXMgRHVmcmVzbmUgPG5pY29s
YXNAbmR1ZnJlc25lLmNhPjsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPj4gPiA+IGh2ZXJrdWlsLWNp
c2NvQHhzNGFsbC5ubA0KPj4gPiA+IENjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+PiA+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+PiA+ID4gZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsNCj4+ID4gPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4+ID4gPiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSF0gbWVkaWE6IHZpZGVvYnVm
MjogYWRkDQo+PiA+ID4gVjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyBmbGFnDQo+PiA+ID4NCj4+
ID4gPiA+IEZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPj4g
PiA+ID4gU2VudDogMjAyMuW5tDfmnIg05pelIDIzOjUzDQo+PiA+ID4gPiBUbzogTWluZyBRaWFu
IDxtaW5nLnFpYW5AbnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4+ID4gPiA+IGh2ZXJr
dWlsLWNpc2NvQHhzNGFsbC5ubA0KPj4gPiA+ID4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4+ID4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsNCj4+ID4gPiA+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+PiA+ID4gPiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+PiA+ID4gPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+ID4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0hdIG1lZGlhOiB2aWRlb2J1ZjI6IGFkZA0KPj4gPiA+ID4gVjRMMl9CVUZfRkxBR19DT0RF
Q0NPTkZJRyBmbGFnDQo+PiA+ID4gPg0KPj4gPiA+ID4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+PiA+
ID4gPg0KPj4gPiA+ID4gTGUgbWFyZGkgMjgganVpbiAyMDIyIMOgIDEwOjE5ICswODAwLCBNaW5n
IFFpYW4gYSDDqWNyaXQgOg0KPj4gPiA+ID4gPiBCeSBzZXR0aW5nIHRoZSBWNEwyX0JVRl9GTEFH
X0NPREVDQ09ORklHIGZsYWcsIHVzZXItc3BhY2UNCj4+ID4gPiA+ID4gc2hvdWxkIGJlIGFibGUg
dG8gaGludCBkZWNvZGVyIHRoZSB2YjIgb25seSBjb250YWlucyBjb2RlYw0KPj4gPiA+ID4gPiBj
b25maWcgaGVhZGVyLCBidXQgZG9lcyBub3QgY29udGFpbiBhbnkgZnJhbWUgZGF0YS4NCj4+ID4g
PiA+ID4gSXQncyBvbmx5IHVzZWQgZm9yIHBhcnNpbmcgaGVhZGVyLCBhbmQgY2FuJ3QgYmUgZGVj
b2RlZC4NCj4+ID4gPiA+DQo+PiA+ID4gPiBUaGlzIGlzIGNvcGllZCBmcm9tIE9NWCBzcGVjaWZp
Y2F0aW9uLiBJIHRoaW5rIHdlIHdlIGltcG9ydA0KPj4gPiA+ID4gdGhpcywgd2Ugc2hvdWxkIGF0
IGxlYXN0IHJlZmVyIHRvIHRoZSBvcmlnaW5hbC4NCj4+ID4gPiA+DQo+PiA+ID4NCj4+ID4gPiBI
aSBOaWNvbGFzLA0KPj4gPiA+ICAgIERvIHlvdSBtZWFuIE9NWF9CVUZGRVJGTEFHX0NPREVDQ09O
RklHPw0KPj4gPiA+ICAgIEknbSBzb3JyeSB0aGF0IEkgZGlkbid0IG5vdGljZSBpdCBiZWZvcmUu
DQo+PiA+ID4gICAgQ3VycmVudGx5IHdlIG9ubHkgZW5jb3VudGVyIHRoaXMgcmVxdWlyZW1lbnQg
b24gQW5kcm9pZCwgSSdtDQo+PiA+ID4gbm90IHN1cmUgaWYgaXQgaGFzIGEgcmVmZXJlbmNlIHRv
IG9teC4NCj4+ID4gPiAgICBBbmQgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgcG9pbnRpbmcgb3V0
IGl0Lg0KPj4gPiA+DQo+PiA+DQo+PiA+IEFuZHJvaWQgbWVkaWEgc3RhY2sgaGFzIGJlZW4gYmFz
ZWQgb24gT01YIGZvciB0aGUgbGFzdCBkZWNhZGUuIFRoZXkNCj4+ID4gYXJlIHNsb3dseSBtb3Zp
bmcgdG8gQ09ERUMyIHdoaWNoIG1vcmUgb3IgbGVzcyBpcyBhIHNpbWlsYXINCj4+ID4gYWJzdHJh
Y3Rpb24gd2l0aCBzaW1pbGFyIGlkZWFzLiBMZXQncyByZXNlYXJjaCBwcmlvciBhcnQsIHNvIHdl
IGRvbid0IHNjcmV3DQo+Y29tcGF0aWJpbGl0eS4NCj4+ID4NCj4+DQo+PiBJIGdvdCBpdCwgSSds
bCB0cnkgdG8gc3R1ZHkgdGhlIGFuZHJvaWQgY29kZWMyLCBhbmQgZG8geW91IGFncmVlIHRoYXQN
Cj4+IHdlIHNob3VsZCBhZGQgVjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyBmbGFnLCBqdXN0IGxp
a2UNCj4+IE9NWF9CVUZGRVJGTEFHX0NPREVDQ09ORklHPw0KPj4gT3IgaXMgdGhlcmUgYW55IG90
aGVyIHNvbHV0aW9uIHRoYXQgY2FuIGhhbmRsZSB0aGlzIGNhc2U/DQo+DQo+V2UgY2FuIHByb2Jh
Ymx5IGRpc2N1c3MgdGhlIG5hbWUuIENPREVDQ09ORklHIGlzIGEgYml0IHN0cmFuZ2UsIGNvdWxk
IGJlDQo+Q09ERUNfSEVBREVSLCBIRUFERVJfT05MWSwgQ09ORklHX09OTFksIHNvbWV0aGluZyBh
bG9uZyB0aGVzZSBsaW5lcy4NCj5JJ20ganVzdCB3b25kZXJpbmcgd2hhdCBpcyB0aGUgYmVzdCBy
dWxlLCBzaW5jZSBtb3JlIHNwZWNpZmljYXRpb24gaXMgbmVlZGVkDQo+aGVyZS4NCj5DdXJyZW50
IHVzZXJsYW5kIGV4cGVjdCBmdWxsIGZyYW1lcyBpbnRvIGVhY2ggZW5jb2RlZCBidWZmZXIuIElm
IHdlIHN0YXJ0DQo+c3BsaXR0aW5nIHRoZXNlIHVwLCB3ZSdsbCBicmVhayBub24tYW5kcm9pZCB1
c2VybGFuZCAoYW5kIEFuZHJvaWQgdXNlcmxhbmQgZG9lcw0KPm5vdCBzZWVtcyB0byBiZSB2ZXJ5
IHVwc3RyZWFtIHRoaW5nLCBldmVyeSB2ZW5kb3IgZm9ya3MgaXQpLg0KPg0KPkkgYWxzbyB0aGlu
ayB0aGF0IHdoYXQgdGhlIENPREVDQ09ORklHIGNvbnRhaW5zIGFuZCBpdHMgZm9ybWF0IG5lZWQg
dG8gYmUNCj5zdHJpY3RseSBkb2N1bWVudGVkIGZvciBldmVyeSBDT0RFQyB0aGF0IHdvdWxkIGFs
bG93IGl0LiBJbiBILjI2NCBub3RhYmx5LCB0aGUNCj5oZWFkZXJzIGNvdWxkIGJlIHBhY2tlZCBp
biBBbm5leCBCLiBvciBBVkNjIE5BTCBoZWFkZXJzLiBJZiB3ZSBsb29rIGF0DQo+RkZNUEVHLCB3
aGljaCB1c2VzIGNvZGVjX2RhdGEgbmFtZSwgdGhleSBvbmx5IHJlcXVpcmVzIHRoaXMgd2hlbiB0
aGUgaGVhZGVyDQo+YXJlIG5vdCAiaW5saW5lIiwgd2hpY2ggbWVhbnMgb25seSBmb3IgQVZDYy4g
QWxzbywgbWFueSBjb2RlY19kYXRhIGlzIGZvciBvdGhlcg0KPmNvZGVjcyBnZXQgd3JhcHBlZCBp
bnRvIElTT01QNCBvciBNYXRyb3NrYSAod2VibSkgZW52ZWxvcGUuDQo+DQo+T24gdGhlIG90aGVy
IGhhbmQsIEkgZG9uJ3QgcmVtZW1iZXIgaWYgdGhlIDEgZnJhbWUgcGVyIGJ1ZmZlciBpcyBhbiBh
Y3R1YWwgcnVsZQ0KPm9yIHNpbXBseSB3aGF0IGV4aXN0aW5nIHVzZXJsYW5kIGV4cGVjdC4gQWxz
bywgSSdsbCBiZSBmYWlyLCB0aGVyZSBpcyBubyByZWFzb24gdGhpcw0KPm11c3QgY29tZSBmcm9t
IHRoZSBkcml2ZXIuIEFuZHJvaWQgT01YIG9yIENPREVDMiBDT01QT05FTlQgaXMgYSB1c2VybGFu
ZA0KPmNvbXBvbmVudCwgaXQgY291bGQgZG8gYml0c3RyZWFtIHNjYW5uaW5nICh1c2luZyB0cmFk
aXRpb25hbCBib3llci1tb3JlKSB0bw0KPmZpbmQgYW5kIHNwbGl0IGFwcGFydCB0aGUgY29uZmln
IHRvIHNhdGlzZnkgaXRzIGludGVybmFsIEFQSS4gVGhpcyBjYW4gYmUgZG9uZSB3aXRoDQo+bG93
IG92ZXJoZWFkIGFuZCB6ZXJvLWNvcHkuDQo+DQoNCk9LLCBJJ2xsIHRyeSB0byBjaGFuZ2UgdGhl
IG5hbWUsIG1heWJlIENPREVDX0hFQURFUiBpcyBiZXR0ZXIuDQpBbmQgSSB0aGluayB3ZSBhZGQg
dGhlIGZsYWcganVzdCB0byBzdXBwb3J0IG1vcmUgc2NlbmFyaW9zLCBpdCB3b24ndCBicmVhayB0
aGUgZXhpc3RpbmcgdXNlcmxhbmQgZmxvdy4NCg0KSXQncyBub3QgZWFzeSB0byBjaGFuZ2UgdGhl
IGFuZHJvaWQgY29kZWMyLCBhbmQgd2UgaW5kZWVkIHdhbnQgdG8gc3VwcG9ydCBpdC4NCg0KPj4N
Cj4+ID4gPiBNaW5nDQo+PiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gQ3VycmVudCwgaXQn
cyB1c3VhbGx5IHVzZWQgYnkgYW5kcm9pZC4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+ID4gPiA+ID4gLS0tDQo+
PiA+ID4gPiA+ICBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5y
c3QgfCA5ICsrKysrKysrKw0KPj4gPiA+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2
Mi5oICAgICAgICAgICAgICAgICAgIHwgMiArKw0KPj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspDQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4+ID4gPiA+
ID4gYi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2J1ZmZlci5yc3QNCj4+
ID4gPiA+ID4gaW5kZXggNDYzOGVjNjRkYjAwLi5hY2RjNDU1NmY0ZjQgMTAwNjQ0DQo+PiA+ID4g
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvYnVmZmVyLnJz
dA0KPj4gPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRs
L2J1ZmZlci5yc3QNCj4+ID4gPiA+ID4gQEAgLTYwNyw2ICs2MDcsMTUgQEAgQnVmZmVyIEZsYWdz
DQo+PiA+ID4gPiA+ICAgICAgIHRoZSBmb3JtYXQuIEFueSBzdWJzZXF1ZW50IGNhbGwgdG8gdGhl
DQo+PiA+ID4gPiA+ICAgICAgIDpyZWY6YFZJRElPQ19EUUJVRiA8VklESU9DX1FCVUY+YCBpb2N0
bCB3aWxsIG5vdCBibG9jaw0KPmFueW1vcmUsDQo+PiA+ID4gPiA+ICAgICAgIGJ1dCByZXR1cm4g
YW4gYGBFUElQRWBgIGVycm9yIGNvZGUuDQo+PiA+ID4gPiA+ICsgICAgKiAuLiBfYFY0TDItQlVG
LUZMQUctQ09ERUNDT05GSUdgOg0KPj4gPiA+ID4gPiArDQo+PiA+ID4gPiA+ICsgICAgICAtIGBg
VjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJR2BgDQo+PiA+ID4gPiA+ICsgICAgICAtIDB4MDAyMDAw
MDANCj4+ID4gPiA+ID4gKyAgICAgIC0gVGhpcyBmbGFnIG1heSBiZSBzZXQgd2hlbiB0aGUgYnVm
ZmVyIG9ubHkgY29udGFpbnMNCj4+ID4gPiA+ID4gKyBjb2RlYw0KPj4gPiA+ID4gPiBjb25maWcN
Cj4+ID4gPiA+ID4gKyAgICBoZWFkZXIsIGJ1dCBkb2VzIG5vdCBjb250YWluIGFueSBmcmFtZSBk
YXRhLiBVc3VhbGx5IHRoZQ0KPj4gPiA+ID4gPiArIGNvZGVjDQo+PiA+ID4gY29uZmlnDQo+PiA+
ID4gPiA+ICsgICAgaGVhZGVyIGlzIG1lcmdlZCB0byB0aGUgbmV4dCBpZHIgZnJhbWUsIHdpdGgg
dGhlIGZsYWcNCj4+ID4gPiA+ID4gKyAgICBgYFY0TDJfQlVGX0ZMQUdfS0VZRlJBTUVgYCwgYnV0
IHRoZXJlIGlzIHN0aWxsIHNvbWUNCj4+ID4gPiA+ID4gKyBzY2VuZXMgdGhhdA0KPj4gPiA+IHdp
bGwNCj4+ID4gPiA+ID4gKyAgICBzcGxpdCB0aGUgaGVhZGVyIGFuZCBxdWV1ZSBpdCBzZXBhcmF0
ZWx5Lg0KPj4gPiA+ID4NCj4+ID4gPiA+IEkgdGhpbmsgdGhlIGRvY3VtZW50YXRpb24gaXMgY2xl
YXIuIE5vdywgaWYgYSBkcml2ZXIgdXNlcyB0aGlzLA0KPj4gPiA+ID4gd2lsbCBleGlzdGluZyB1
c2VybGFuZCAocGVyaGFwcyBnb29kIHRvIGNoZWNrIEdTdHJlYW1lciwgRkZNUEVHDQo+PiA+ID4g
PiBhbmQgQ2hyb21pdW0gPykgd2lsbCBicmVhayA/DQo+PiA+ID4gPiBTbyB3ZSBuZWVkIGV4aXN0
aW5nIGRyaXZlciB0byBkbyB0aGlzIHdoZW4gZmxhZ2dlZCB0bywgYW5kIGp1c3QNCj4+ID4gPiA+
IGNvcHkvYXBwZW5kIHdoZW4gdGhlIHVzZXJsYW5kIGRpZG4ndCBvcHQtaW4gdGhhdCBmZWF0dXJl
ID8NCj4+ID4gPiA+DQo+PiA+ID4gPiA+ICAgICAgKiAuLiBfYFY0TDItQlVGLUZMQUctUkVRVUVT
VC1GRGA6DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+ICAgICAgICAtIGBgVjRMMl9CVUZfRkxBR19S
RVFVRVNUX0ZEYGAgZGlmZiAtLWdpdA0KPj4gPiA+ID4gPiBhL2luY2x1ZGUvdWFwaS9saW51eC92
aWRlb2RldjIuaA0KPj4gPiA+ID4gPiBiL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCBp
bmRleA0KPj4gPiA+ID4gPiA1MzExYWM0ZmRlMzUuLjg3MDhlZjI1NzcxMA0KPj4gPiA+ID4gPiAx
MDA2NDQNCj4+ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+
PiA+ID4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gPiA+ID4g
PiBAQCAtMTEzMSw2ICsxMTMxLDggQEAgc3RhdGljIGlubGluZSBfX3U2NA0KPj4gPiA+ID4gPiB2
NGwyX3RpbWV2YWxfdG9fbnMoY29uc3QNCj4+ID4gPiA+IHN0cnVjdCB0aW1ldmFsICp0dikNCj4+
ID4gPiA+ID4gICNkZWZpbmUgVjRMMl9CVUZfRkxBR19UU1RBTVBfU1JDX1NPRSAgICAgICAgIDB4
MDAwMTAwMDANCj4+ID4gPiA+ID4gIC8qIG1lbTJtZW0gZW5jb2Rlci9kZWNvZGVyICovDQo+PiA+
ID4gPiA+ICAjZGVmaW5lIFY0TDJfQlVGX0ZMQUdfTEFTVCAgICAgICAgICAgICAgICAgICAweDAw
MTAwMDAwDQo+PiA+ID4gPiA+ICsvKiBCdWZmZXIgb25seSBjb250YWlucyBjb2RlYyBoZWFkZXIg
Ki8NCj4+ID4gPiA+ID4gKyNkZWZpbmUgVjRMMl9CVUZfRkxBR19DT0RFQ0NPTkZJRyAgICAgICAg
ICAgIDB4MDAyMDAwMDANCj4+ID4gPiA+ID4gIC8qIHJlcXVlc3RfZmQgaXMgdmFsaWQgKi8NCj4+
ID4gPiA+ID4gICNkZWZpbmUgVjRMMl9CVUZfRkxBR19SRVFVRVNUX0ZEICAgICAgICAgICAgIDB4
MDA4MDAwMDANCj4+ID4gPiA+ID4NCj4+DQoNCg==
