Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B797C535F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351306AbiE0LdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiE0LdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:33:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551462114;
        Fri, 27 May 2022 04:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQ3d9AuagI58gmNJtbYvUdMmg49r6jBS/aIJwQeGYky5PNLTj9A/gpTCKHunW1rwGf19/kjI+yKGvTRRyLkCJ1sSiye0OL8vaHB4q1SDPJnBE6E03JyV/lnPHaOH3KsFPnlkNH4W5QE2XxW4NeIIUwff5Fov8dgmrb2eH8EAQjecXaz8l45S5vTJWJqTIwVOkgqTEruskxqLc27IgpOkky9Umgrx4tuJ37LnyQRfq00yQ03hFhZaXi8rB1z+rSbpotr3iS26yR5nlvF4gUs5hZk7qs85+Rgb64h/awLbFzTnKd2/66wKRiDLASQ2JSmWP8yPUhF42pYF2G6hx+lXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FitxCfEsY0kHRY343Jq3J7yryQHTRPobZhvYsKDxf4U=;
 b=fgZcY80/Ykwf/2o1qTJLfk/uYBwBTH0EIgJ6iSTG+UC1T+taFJd8H3glSHp0xJd34v7CtEIed64Tn1EtLBlR/zfxvZ2gNGiIY24YGZf7bKWfrxsYYmrBci2719WOg7tHqa7aXQlgKd+0KZlwMYKMlau+bNARc/OG/Rlu1qZOjesI+NgARD2EBRoto26T0sgYiKjpScOue4yb3SqY1ccnb4sAotrE5j0+iwGYumyoNbNbSkKRUHpzcZsYrplnUysu64AoA07LaGmnWKXmVusnitj8bfz5A4L+CvcP+itK4Fs7nEkfqGaSZi5JM+JGsi4Z08Q0VaPgQfwbSuPfmkSnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FitxCfEsY0kHRY343Jq3J7yryQHTRPobZhvYsKDxf4U=;
 b=YdhNQnhUic167adpFsmdORe53UmGECaCwt4MRXGyhidOAM38UIr3T1ZXYP3sFcyi4os/C6Jix4t9YlnAfvkiMza+N/7ZXpsSZ9HmWZZaBi7mjzIqfuXFWPGEnzUPnQZ6sQF80ULjUDGFHaqS76gjSkUrUN8CQklgJyicXihXMeM=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 11:33:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 11:33:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Topic: [EXT] Re: [PATCH v2] media: imx-jpeg: Leave a blank space before
 the configuration data
Thread-Index: AQHYcbQGiI9X6mRAiUe9cP8s2eccT60ykaiAgAAFGrA=
Date:   Fri, 27 May 2022 11:33:00 +0000
Message-ID: <AM6PR04MB6341CB4019E4F7077D3DCD54E7D89@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220527102444.19683-1-ming.qian@nxp.com>
 <CAOMZO5D-gUdoTx3hLmZE2EeYfun-g2xLx6J4tNTSZd-yKCLgXA@mail.gmail.com>
In-Reply-To: <CAOMZO5D-gUdoTx3hLmZE2EeYfun-g2xLx6J4tNTSZd-yKCLgXA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c10ddf3b-fd69-4339-aa48-08da3fd4a7b7
x-ms-traffictypediagnostic: DU2PR04MB8582:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8582F544DD8468DCC4880B0BE7D89@DU2PR04MB8582.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xh/u87oPfzl2L5k0YeSTG04/wCkoEza5qXQq7YBTV3X56EKKzfa6dDDyJfVfnCgEddyQcbm3JHDn+eKLBfmvM1lz3WCn+8YxnPW18JQYCbmo1bSLVBSPPJB6GGS0Et38SZpTOwgnqZZccwI16fjhvuDS9g8gXS1PVpFDotJ9qd0qZ5BzzdycFfILlieiFEzq1+QoTny3ZajamKoh/LqQJW/MXzuXIsAMrtW9hFcnbIA5g8VoKtBYEkuAL1aXNvG6Dlu+vW2A6hhvreXwgmrWh7r51Yz2P2wKm7MFxfQRGvmIqmdLWdbgpUKP0lSUEcJSgGNuz/o/zYzHQnhgMae0UZMnXlDgIxgNufrabnKJVGHCzG0yIveQKCqSfVNPiobG3dPtCXhe+PTK5fw9GUxsIYPTNj1DovSj9tE6hKVpfuwXGRxESIDje7D33aJrfS0MRMuivfMe7gWI7cpO9paVHipi1DmsHxaBQ6B4ZGNM6cLGo2vNAUlqzGW1k5p8eVNwbBb0J5Jkr2go//EbWNHIBbdybhmrT/F68Wbw0g2R3PAeg2PtbZXKHsqUn1EjMxHzaCut2TESfF7rJMlC6w7i2u4Iyv83zCbZozqIJf17Jlf5VqizEi/TTYK4G/2s8eBUXpHSjcT6e6HtOFWk9kliJ0ruDqgJFN7j5jae9x6tqNf/ZcS01cwluwiuMVGKO7cWz7XG1x7q9XURUZcB3kerDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(53546011)(54906003)(6916009)(2906002)(5660300002)(66446008)(66556008)(66946007)(76116006)(71200400001)(7416002)(4326008)(26005)(86362001)(38070700005)(38100700002)(33656002)(66476007)(8676002)(52536014)(55016003)(44832011)(8936002)(508600001)(9686003)(7696005)(122000001)(6506007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhDQ3dmQ1hyVDdEUitNOXdibzkwZWZ6ZzBaRnVyanFRWWxnZkZqNzhRVDRo?=
 =?utf-8?B?WjFaTnpuanJtL1E3NWhodHVaTUIwS3JlNjJGTnJEWDBXMEdxRFg4OXp4dDQ0?=
 =?utf-8?B?TDlub1VRaXVDUzRrQVFQaXh1RTRFeVlRbllQT3Z6MUF4RDRjWEtvejhsalBR?=
 =?utf-8?B?Sjg0RXVmdkoxZDE3SWErUERYaVkrTFgxSGFtWXNMaHVtd1E0Z3ZVNFpzS2t6?=
 =?utf-8?B?Q2E5QkJ0S2hINlJqcFlNQlI2TjdPVmtRYm05dnFFdmxjQ0dxWFo2ZDZpbER6?=
 =?utf-8?B?d1BwSkMwZFBUeDA1bGw0bTlVZENJUEZ3djd1Y09qZEFZWXdHd2dsdGZjdjZU?=
 =?utf-8?B?SXNBV1VmZkoyZXNiT0ZiU3pVT2oyanhQSDZZZENweFdZeEo5L0h2SUVQdkZ0?=
 =?utf-8?B?d3BZZks5VjViVDhmVjJXdk5nTGpJNThucVBoMFVkQ3ZLVk5BTUEza3kyMkc2?=
 =?utf-8?B?ZWtDQmpiak5ISXFuUEJ5ZExHTk80Nys3aDdTcU45aWhGbjFkWVl4SnpyQTY5?=
 =?utf-8?B?MlJqSFZoanJoR01Va2FsUHRhRklwcWowVjRRdFl2cFpUaWdZbE5VK1B1eWdK?=
 =?utf-8?B?NmZSVDd4Qzh1V0RmWEV6OUowbGtGeTg4ZHdnTlNFNWRJK0hrOWE4WmYyb2pv?=
 =?utf-8?B?aVFxT0FwcC9aWFB3Q0Myc0dTQ0JQT0hzbHZPNHdvZlkvRE9iVlA4NERmb3BB?=
 =?utf-8?B?dEMzSUc3TVN1WlhraXlWU0YrZGg2anl6T0cxWDdhQTduZ3VCeTRXQXpySDNy?=
 =?utf-8?B?UEJNVlp0d0RDYzFGUC80NmdjM1N6R1pGR3JyYUVtRklyS3BBTVFWMU1PRy9v?=
 =?utf-8?B?aTVrd1BFV2MyTjcySk1JSXlMbmZmTFNBODVwZ0Urd1dNYnpLYVIza1dBNHU2?=
 =?utf-8?B?VkZrQWZqUGlrTExXUlVQbFh1VWRTRTlWUjZscStwUW9JazdGQ0w5ZDlnVU5y?=
 =?utf-8?B?NUQ0Y2xleFB4QTZSYXBVQStMNUpheGdrNHhkTmtrN3hJM3VkSklRSmI0SldG?=
 =?utf-8?B?bXoydDZrUzNuRHNvYkdQeWZwbDEwcEJObTBtd3ZmL0lCOHFTSG4vcjNaek1Q?=
 =?utf-8?B?akE1THZHRkh0cmRxU0dyUE1Qa09WSEYyb1A2c0xrcHhSM2owcm1nWG00NDJw?=
 =?utf-8?B?OHpIdm1TUXhCYlFzVHhURTlmL2xqSFdnc0VaTHJvOTlOalhFdExwNTF1MWhV?=
 =?utf-8?B?SnhwcTVLb3VyaXN2Vk9HQ2FxTFg4VGtZWjA5a1Q2RGtGWHM1VmVIOWdUbWRK?=
 =?utf-8?B?eld1eGxxczIrR1VvSmlLTUNSWk1nTW9YVHZSYnozajk3SStkTVl0QmdhRmNQ?=
 =?utf-8?B?Rm13SXlraGxyYitzcFI4SkZJNGRxQUNrYzhTUFYxSGZScEJ2ZjdWeHRteHQ5?=
 =?utf-8?B?ZktxYUliazdiV2dRc0JJRjFJVGsxM1A2d1RDUEhRMzkzQmVDYitGNGc2TXBa?=
 =?utf-8?B?amZVT04vM09PekN2aFdsUjB6Y2JhcDJqMnNab0taVWczOWZ1cWtIdEdrYmJE?=
 =?utf-8?B?U1Qxc0ZZRkNBWEU0Z3RyQVhqVEx0UzljcmI3ZW5XZDhIVlFkbWxDeDJpYld1?=
 =?utf-8?B?R2l5MWpINjdrL0R2ZnQ1elhjdU5VSzl5L3RwcXExVVl4bGlSa0EzdzBKaE9m?=
 =?utf-8?B?VGMyNDdQQTdyQ2x4Q2ZiZTV6NHpSMUhKM2FDNkErRHhqeks0bUZEdGxUSXl5?=
 =?utf-8?B?SFhha1lMTkFIQ09jZnhVbCsxdnZhTlUxejJIZjZ1ZFJpMlFwZTNpQWVnRnc3?=
 =?utf-8?B?dzhGb3cveG1uWEVib29UelFLODg3NWNKWTJWUm1JVHh1SjRXR003emNOOGxt?=
 =?utf-8?B?YzZTL3dyS0xsUkc5UkFWK1g0bDRxc0g5bCtCdFNENFRxQzFoaUtpeWRmRE82?=
 =?utf-8?B?VXRyblZna3NIUGp1RWhCdjk5VC9ZWnlZUndOc2VCWXRXU2MzSDdTOERiVzl6?=
 =?utf-8?B?MFltaW9PVFV3Q1d5ME1JRUExVCt0M2tNY1JxTVpOSjlWenpxcGZCM2NFNUpE?=
 =?utf-8?B?UnRUYU9lWXV5NDJiSnpXY3BvWjVjNC9KY3d1c0FOb1JxR0J1bnBhS0xXdVpo?=
 =?utf-8?B?UmppdVRTc256Y3BrYVFyRTUzNHV6UXIxTTRxenBBVS9EZXg5RFV2Zm5Rc0N4?=
 =?utf-8?B?YTlGL3l2aDVpaHE3MllkTDlYeUtDYXpMZ3psbW9QUWJsdDdWS2VwRXZMczQ5?=
 =?utf-8?B?RHViTzZtdXdObDJHL1p0UUdSMTFETktVRGRQR3ppTVIrS2RLb1NIUGtVTUFD?=
 =?utf-8?B?dmlDY0s1RGowOXUrTlpTb1VPaDB4RFUvLzlJRXdiVmdyM1RnWlJIUktHSnNU?=
 =?utf-8?B?Z1g5OThrRXRrZlBwdFI0L3QvcnlHbExwZWE0Z0pjZENXcEhBNkxLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ddf3b-fd69-4339-aa48-08da3fd4a7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 11:33:00.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I53N3pGCHvs7gTL5YH2oJymAXNNTZtJ7CWCD8JzY+BijqWox6IA4yU3C3DY7kgKQAJX49K3lTOoHoYbcb/XaFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjLl
ubQ15pyIMjfml6UgMTk6MTINCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+DQo+
IENjOiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IE1pcmVsYSBS
YWJ1bGVhIChPU1MpDQo+IDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT47IEhhbnMgVmVya3Vp
bCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPjsNCj4gU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gU2FzY2hh
IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsNCj4gbGludXgtbWVkaWEgPGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LWtlcm5lbA0KPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpP
UEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQNCj4gREVWSUNFIFRSRUUgQklORElOR1MgPGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJ
TVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyXSBtZWRpYTogaW14LWpw
ZWc6IExlYXZlIGEgYmxhbmsgc3BhY2UgYmVmb3JlIHRoZQ0KPiBjb25maWd1cmF0aW9uIGRhdGEN
Cj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gSGkgTWluZywNCj4gDQo+IE9uIEZyaSwg
TWF5IDI3LCAyMDIyIGF0IDc6MjUgQU0gTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGVyZSBpcyBhIGhhcmR3YXJlIGJ1ZyB0aGF0IGl0IHdpbGwgbG9hZCB0
aGUgZmlyc3QgMTI4IGJ5dGVzIG9mDQo+ID4gY29uZmlndXJhdGlvbiBkYXRhIHR3aWNlLCBpdCB3
aWxsIGxlZCB0byBzb21lIGNvbmZpZ3VyZSBlcnJvci4NCj4gPiBzbyBzaGlmdCB0aGUgY29uZmln
dXJhdGlvbiBkYXRhIDEyOCBieXRlcywgYW5kIG1ha2UgdGhlIGZpcnN0IDEyOA0KPiA+IGJ5dGVz
IGFsbCB6ZXJvLCB0aGVuIGhhcmR3YXJlIHdpbGwgbG9hZCB0aGUgMTI4IHplcm8gdHdpY2UsIGFu
ZCBpZ25vcmUNCj4gPiB0aGVtIGFzIGdhcmJhZ2UuDQo+ID4gdGhlbiB0aGUgY29uZmlndXJhdGlv
biBkYXRhIGNhbiBiZSBsb2FkZWQgY29ycmVjdGx5DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
aW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaXJlbGEgUmFi
dWxlYSA8bWlyZWxhLnJhYnVsZWFAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogVG9tbWFzbyBN
ZXJjaWFpIDx0b21tYXNvLm1lcmNpYWlAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+IA0KPiBGaXhl
cyB0YWc/DQoNCkhpIEZhYmlvLA0KICAgIEl0J3MgYSBoYXJkd2FyZSBpc3N1ZSwgc28gSSdtIG5v
dCBzdXJlIGlzIGl0IGEgZHJpdmVyIGlzc3VlIHRoYXQgSSBmaXggaXQuDQogICAgT3IgSSBqdXN0
IGNoZWNrIHdoaWNoIHBhdGNoIGluY2x1ZGVzIHRoZSBjb2RlIEkgY2hhbmdlZCwgYW5kIGFkZCB0
aGUgZml4IHRhZz8NCg0KTWluZw0K
