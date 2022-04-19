Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0A506647
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbiDSHvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiDSHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:51:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF012E6A7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxXktKQX0Ku6ijh4qtvfZUHe2ALWxfqXE2AdHoHXAhMXCNF7ndXO7SdxH5zhb5OOJ5d70kGD6AR04BAz9q0tMcNqv10iQdQ/P0vAGnu8USW34O1tHmdZ+zsnIfI1NG52cY9rzpztxloxzqyK9gTdCKyr6e3gxpb/WI5WA9WmhIqSiPBhZ14xRGCJepwk2kJ/eSVeRyFyByP931wQiRNaJkF6Ad60TM8QUCLe+Ixmd+6EtkCZFkBFWaJcFcXh5p6dTtsXUdslqQpaHnhGVWJPOo8KrssesF6Rf9UVJ5bcvh6W1Ycy1RQmBH4/yUy3lsOLg8hNk64LKFglXo5kItT4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUGxQjkS9iTbVU5sEuRwKyCj3XqG/cwAQ+nnoG3Hrsg=;
 b=I4oUrbVkM2Q1Nk8CbTcCBxjUDvzJG+qTB2ztF2OlmMrxyFsDNye6aT/1aXslNUVaBK75R6zsYVuXYJcbs16qPTk8r21Atcp/BPNyODwET0pq9tyGepu7g2Ozl9zQnvtrHnUTPaD6/qb0aJY0W0vJF8wPz+pGsLa+AgcPoXliIwUnmHRsJNPy5R6ox3zdgpgfprnp/de7CgrKYtccohBK/plj+3VcWtIRFg1BLgKYUoO0ortTRW/Rj/KSiyLF54bydbK2SEM+pxYD+DUMSSl53E/twrhDbZ1df20kAlO7GNUU3Gccqw9fSRqsxG9yhT55gOPdB8tk1oQKpg403sQ1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUGxQjkS9iTbVU5sEuRwKyCj3XqG/cwAQ+nnoG3Hrsg=;
 b=JHgKbxg88mi6HYHxNBp0gi0oWRGzAUP5/0p/cTt/4QCZDZT3FxdqExjZKb9ltR9/8SlWcBkD9Yjvc94sO7W63jFeX/MrSR/RDSFfq5DfOCCFeC/++j6Bszrq9kanvU6p6FhtNXoUzyGI8aqslWsetgLCOKY4D/c5k7XMIxW8yPQ=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:48:51 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:48:51 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqzjuBuAgBMzoSA=
Date:   Tue, 19 Apr 2022 07:48:51 +0000
Message-ID: <VI1PR04MB4333F48595F5DAA9B743190289F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <CGME20220406131913epcas1p485cd66f0f208031dc93579158e95be18@epcas1p4.samsung.com>
        <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <ed177aa8-124b-a949-9e45-86c59b477a76@samsung.com>
In-Reply-To: <ed177aa8-124b-a949-9e45-86c59b477a76@samsung.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c36f7886-ff26-406f-8aac-08da21d90bf2
x-ms-traffictypediagnostic: PA4PR04MB8048:EE_
x-microsoft-antispam-prvs: <PA4PR04MB80489F644AC6F643B6631D7689F29@PA4PR04MB8048.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jmH/FFIi+ejTuc0qo4Od/PUZm116dEkfGj8Wm8aFrT7AaUT6Ng+1QTef37Di9VHfLyrmP/LWHe7142Y76sjZFtnkK8eluBjuyjBOKDaBMqcykmP2JHAUAXbeLsiLafckfO6n6c8hfZviQpsPQ2G304ZxugtZSl3tHSl+iaP0rqQ6WQSBonllQWcdjHz1zl0eonUOgELMjxEWC8vo3rynRrOrnxqOwUFI/XzmrlD419/yXXDSTjf1yai5tUad/p0dpG2gT3daK1vziIv1QWg5A4GE9XHh8pRIjCyrTcfWOpxe0k5Rkj1qcdyhU+wIqPenJIBRk4XSsgTE04/LShIps5XJhdnPu15bYzYuxAcWAfZLuFQMUX5wLseYxT/GGcaYgEbYkvXKFp+JmGJRwASwqkQYd/E06JB4GWzNmIbDlGqdNge4d8xfISjmmPG+afdMItk3HYj+Fo2x8G6UP2auYoxcHej9VHHCWb+GlaHdm0miKwnV1SqK8iHt9vcWvJh1sdnP2gWmgy1jNmmkRqFAH7UdqCsAX65BLYkt8nbKtY3Z06scRjpE3qwrJrUy5R4UxcOMJHyg+HR5klxdWlsTJL9G9/BuQYtjp/l+W3cr+XqK4Zr35QsKHmxox3ll0k8MWuNKoj0DbsDRgrxImozaHqTxSZ8kqypj/pPuJ0Bu0BoCD9VQwtGFpL867HtBGF52/auU+Zhc/0jZauvpLaYHvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(5660300002)(44832011)(71200400001)(508600001)(38100700002)(122000001)(316002)(83380400001)(33656002)(9686003)(38070700005)(110136005)(54906003)(6506007)(2906002)(8936002)(86362001)(53546011)(7696005)(8676002)(4326008)(66556008)(64756008)(76116006)(66946007)(66446008)(66476007)(55016003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckQ4T3NQRjJtVHB6cXB4NmtBVXZxckF1RU1Zb0NncG5NcjdRd21OREs0eU5h?=
 =?utf-8?B?OUptWmEyT2llUXFqdi8rT3FmYUhxTXVCUDVSY2MvaGtUYU84M1lseGw5OTZG?=
 =?utf-8?B?TTF5U3RGT3JpY3F5YTAvN2s4aVN5SnpKdmhzR2paMnFFUi9WN3ByREFkMGNJ?=
 =?utf-8?B?Y3FoZkZocTN0M1VyaHAybm51VVdsZWxUZ3ZOMnBWZnptbGxiK1htSmd0emll?=
 =?utf-8?B?cUE2dXhPVGowMlBIQVh1ZTFYTTNEZWx2OTZtcUtqend5c2ZHOHR6Q3FoWHBT?=
 =?utf-8?B?NkI1Y29UU1ZOa1NmazMvb2xBS08wZHZMUXIwR0lWUC8xSUZZV3JvSEhEZ0Zp?=
 =?utf-8?B?UWM3S0x1OHlsTEpVbkFqdGw4WFhISk4yNWV2RUg4d253TU94SDFYcDNZd2oz?=
 =?utf-8?B?N0FGc2ZKRDFpcnpwSWNnbTNHL21TanlxZEtqS1NRNlgyQVdNejdqeWFwcFNt?=
 =?utf-8?B?ckNEbkNtcm1hZDIwU1Q0dktLaVpjcERsRzZ5U3JvcisxZHBRN1NNZXZvSFg0?=
 =?utf-8?B?ZHdTWnV1eFlQdXJBTVVTZWRlU1hOUFVzUWRvZ0UyR1FmR2Y3MUl3MmlQWkZt?=
 =?utf-8?B?VFVSWFpiQk9xbFllQXZoZGFvdUdQOFhqVXQ3cVRnMDE3TDFJYzNEaEErVW8w?=
 =?utf-8?B?QjFuM2VZOWdKVXhvSm1NZ0pqaThRZVdWRjhGS0VqRU50bmhXa2owUXY2UmJ1?=
 =?utf-8?B?WTRGQzF4TjNNZzkwY3c1b0FaMTRkbTh4eE15YlY2M1IwNkV3WkJ5QUFMR3dp?=
 =?utf-8?B?R0F1UUpvdUk3NWxzeWNwLzZEajFLMmtLTWpoS0NOb0crejk4WW9VVi9jcnRU?=
 =?utf-8?B?UzBmSXA2d0UvUGZYaFRuSFMvbFNNNlVFUHlmQW0rcEJicEJ5ZFRWVGdoemRL?=
 =?utf-8?B?UEw2QUpTb2R5aXdzZks4U3ZkV1Z1NUJBYk1ZdFFRaGFjb2sxVXdKOHBrSkla?=
 =?utf-8?B?L3d4Si9Od2l0TVJOSDdweXZPV01VeW4rMGxvUktHVUhZRGpzMTFiaGZHaFht?=
 =?utf-8?B?ZXNLQVB5NWM5dU9JOUpaamxXRmFxNklqWmJTMkY4enl4eWJoOG1KYXJvMUxX?=
 =?utf-8?B?L25RVEp5M0labE5TSWF1NXM5eWFXZldpbVRhWmowYWozc3c1QnlKSkJGNDV5?=
 =?utf-8?B?WHRGanhaVmhZcHh6ZUFmMzZZR2RUTm0raUV5cXlXNk53WjltdTJxNC9yRW0y?=
 =?utf-8?B?SlNzSUJiQ0gyNzZvWFBpRHA0VXVJOFhnOGFhNm1lVW8zOVd1MGtjVWZMMkdD?=
 =?utf-8?B?c1MrODRKeldFZ0QwRFR6YXdxQlMrMGl1Q0trejZyUm41TVhicmQ1cTBVVXMw?=
 =?utf-8?B?ZW9wOFliT2RKVnpBL3NoZzZaWm9XQ3VyaUV1aHgyK0lEbFA0ZHFzTG1Kckla?=
 =?utf-8?B?b29PZXRoM3JleE9oUHVzTFBjY1RiaWp0cFNpSFg1bnkzMU5oSnhOTk9OSU1K?=
 =?utf-8?B?RjJPL00yY0tJNHI3VFIzVWYvc3ZwTWs3VGJFYmw4MmkwOUVWVmlQZVVIaEpx?=
 =?utf-8?B?NkR2eUt0dG52cXFZcnpSN2FQVHIzb01RcUE0Znh0SFdjL2FDWE5vSzFPK1pa?=
 =?utf-8?B?ck1ETTdOOHU4c1dVZjgzaEZkbG5LaXF0UlFodVpXTE54bHZjbk96TlNUSk1u?=
 =?utf-8?B?cVVmWXY1RjJQTlNad2wxTkI2M0lXekUvZ2Fldlp6ZXJWd3d3d2ZzZ1ZreVN6?=
 =?utf-8?B?cS96ekV2Y3ZUUHg3N3RtWXhJR016aTMzZkJNeDNibTdQSDVVNlVCbHpNRVBs?=
 =?utf-8?B?NU5nODNJTnAyNk5RbnNTbklSeEtJODg0VzNjNFViMSs5ek5FY3N2OElIK245?=
 =?utf-8?B?QXFnYVhZNnR5a1c1VlVLSndqemg0SWd1Rkd1ZTZ1QWpiNDVCSzJKd21uREZy?=
 =?utf-8?B?U0lEL1dMbmxFS3JrMzNXUGk2dW1OV242ckZzaEo0aEVOdUhTWjJYSE04V2hl?=
 =?utf-8?B?L2FsdzB3QTF2MmhCZXB6Q1RRKy81M2dvR2lqRHBta3RjaHJNS1pVanJjNEFz?=
 =?utf-8?B?bldrQmpSWU9kMlgveFdPQkdVa2VxZE1lTWFaK3ZOVmpQTndRV1dOTFhRckxi?=
 =?utf-8?B?OVZVY2hyVndxRGMwbklVNTdXWEt6VEF1ajNyNUpNZlhsUTNXU21HbFYzOXhk?=
 =?utf-8?B?SnhVL0ZVYUt2UXFlSXltU0VUSEgwaEZVbTdEQlA0U1hQbDFuUG5BMDZwNmRw?=
 =?utf-8?B?dUpXaUFEekxtaVJWYU5GMjJBTHRSUXJ5d0JVbWlWVDBWMFBQTkQ1Q2NFUE0x?=
 =?utf-8?B?NXhtem9BcEpHTlFOa1pvOVVrb1FWbGlZKzZwQ2s4bmVFc1BpeGRyOUphbEF6?=
 =?utf-8?Q?1jm9v/IXTOsQAK9W1r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36f7886-ff26-406f-8aac-08da21d90bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:48:51.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfIFUMWTbssqbMNpMJLbvFcI+1ikVcVcD9SrqkbRCtzqlrzynPzqb5L9Itsy4s8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGFud29vIENob2kg
PGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDcsIDIwMjIg
MTA6MTggQU0NCj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+OyBteXVuZ2pvby5oYW1Ac2Ft
c3VuZy5jb207IGtyemtAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBYdSBZYW5nDQo+IDx4dS55YW5nXzJA
bnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZXh0Y29uOiBwdG41MTUwOiBhZGQgdXNi
IHJvbGUgY2xhc3Mgc3VwcG9ydA0KPiANCj4gSGksDQo+IA0KPiBPbiA0LzYvMjIgNjo0MiBQTSwg
TGkgSnVuIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IG9mIHVzYiByb2xlIGNsYXNzIGNvbnN1bWVy
IHRvIGRvIHJvbGUgc3dpdGNoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgSnVuIDxqdW4u
bGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9leHRjb24vS2NvbmZpZyAgICAgICAg
ICB8ICAxICsNCj4gPiAgZHJpdmVycy9leHRjb24vZXh0Y29uLXB0bjUxNTAuYyB8IDM5DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZXh0Y29uL0tj
b25maWcgYi9kcml2ZXJzL2V4dGNvbi9LY29uZmlnIGluZGV4DQo+ID4gMGQ0MmU0OTEwNWRkLi45
ODI4YWRlNzg3YTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9leHRjb24vS2NvbmZpZw0KPiA+
ICsrKyBiL2RyaXZlcnMvZXh0Y29uL0tjb25maWcNCj4gPiBAQCAtMTMyLDYgKzEzMiw3IEBAIGNv
bmZpZyBFWFRDT05fUFRONTE1MA0KPiA+ICAJdHJpc3RhdGUgIk5YUCBQVE41MTUwIENDIExPR0lD
IFVTQiBFWFRDT04gc3VwcG9ydCINCj4gPiAgCWRlcGVuZHMgb24gSTJDICYmIChHUElPTElCIHx8
IENPTVBJTEVfVEVTVCkNCj4gPiAgCXNlbGVjdCBSRUdNQVBfSTJDDQo+ID4gKwlzZWxlY3QgVVNC
X1JPTEVfU1dJVENIDQo+ID4gIAloZWxwDQo+ID4gIAkgIFNheSBZIGhlcmUgdG8gZW5hYmxlIHN1
cHBvcnQgZm9yIFVTQiBwZXJpcGhlcmFsIGFuZCBVU0IgaG9zdA0KPiA+ICAJICBkZXRlY3Rpb24g
YnkgTlhQIFBUTjUxNTAgQ0MgKENvbmZpZ3VyYXRpb24gQ2hhbm5lbCkgbG9naWMgY2hpcC4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9leHRjb24vZXh0Y29uLXB0bjUxNTAuYw0KPiA+IGIvZHJp
dmVycy9leHRjb24vZXh0Y29uLXB0bjUxNTAuYyBpbmRleCA1YjlhM2NmOGRmMjYuLjgyMWIwZjM5
MDMwOA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi1wdG41MTUw
LmMNCj4gPiArKysgYi9kcml2ZXJzL2V4dGNvbi9leHRjb24tcHRuNTE1MC5jDQo+ID4gQEAgLTE3
LDYgKzE3LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L2V4dGNvbi1wcm92aWRlci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25z
dW1lci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvdXNiL3JvbGUuaD4NCj4gPg0KPiA+ICAvKiBQ
VE41MTUwIHJlZ2lzdGVycyAqLw0KPiA+ICAjZGVmaW5lIFBUTjUxNTBfUkVHX0RFVklDRV9JRAkJ
CTB4MDENCj4gPiBAQCAtNTIsNiArNTMsNyBAQCBzdHJ1Y3QgcHRuNTE1MF9pbmZvIHsNCj4gPiAg
CWludCBpcnE7DQo+ID4gIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QgaXJxX3dvcms7DQo+ID4gIAlzdHJ1
Y3QgbXV0ZXggbXV0ZXg7DQo+ID4gKwlzdHJ1Y3QgdXNiX3JvbGVfc3dpdGNoICpyb2xlX3N3Ow0K
PiA+ICB9Ow0KPiA+DQo+ID4gIC8qIExpc3Qgb2YgZGV0ZWN0YWJsZSBjYWJsZXMgKi8NCj4gPiBA
QCAtODUsNiArODcsMTIgQEAgc3RhdGljIHZvaWQgcHRuNTE1MF9jaGVja19zdGF0ZShzdHJ1Y3Qg
cHRuNTE1MF9pbmZvDQo+ICppbmZvKQ0KPiA+ICAJCWV4dGNvbl9zZXRfc3RhdGVfc3luYyhpbmZv
LT5lZGV2LCBFWFRDT05fVVNCX0hPU1QsIGZhbHNlKTsNCj4gPiAgCQlncGlvZF9zZXRfdmFsdWVf
Y2Fuc2xlZXAoaW5mby0+dmJ1c19ncGlvZCwgMCk7DQo+ID4gIAkJZXh0Y29uX3NldF9zdGF0ZV9z
eW5jKGluZm8tPmVkZXYsIEVYVENPTl9VU0IsIHRydWUpOw0KPiA+ICsNCj4gPiArCQlyZXQgPSB1
c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUoaW5mby0+cm9sZV9zdywgVVNCX1JPTEVfREVWSUNFKTsN
Cj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlkZXZfZXJyKGluZm8tPmRldiwgImZhaWxlZCB0byBz
ZXQgZGV2aWNlIHJvbGU6ICVkXG4iLA0KPiA+ICsJCQkJcmV0KTsNCj4gDQo+ID4gKw0KPiA+ICAJ
CWJyZWFrOw0KPiA+ICAJY2FzZSBQVE41MTUwX1VGUF9BVFRBQ0hFRDoNCj4gPiAgCQlleHRjb25f
c2V0X3N0YXRlX3N5bmMoaW5mby0+ZWRldiwgRVhUQ09OX1VTQiwgZmFsc2UpOyBAQCAtOTUsNg0K
PiA+ICsxMDMsMTIgQEAgc3RhdGljIHZvaWQgcHRuNTE1MF9jaGVja19zdGF0ZShzdHJ1Y3QgcHRu
NTE1MF9pbmZvICppbmZvKQ0KPiA+ICAJCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoaW5mby0+
dmJ1c19ncGlvZCwgMSk7DQo+ID4NCj4gPiAgCQlleHRjb25fc2V0X3N0YXRlX3N5bmMoaW5mby0+
ZWRldiwgRVhUQ09OX1VTQl9IT1NULCB0cnVlKTsNCj4gPiArDQo+ID4gKwkJcmV0ID0gdXNiX3Jv
bGVfc3dpdGNoX3NldF9yb2xlKGluZm8tPnJvbGVfc3csIFVTQl9ST0xFX0hPU1QpOw0KPiA+ICsJ
CWlmIChyZXQpDQo+ID4gKwkJCWRldl9lcnIoaW5mby0+ZGV2LCAiZmFpbGVkIHRvIHNldCBob3N0
IHJvbGU6ICVkXG4iLA0KPiA+ICsJCQkJcmV0KTsNCj4gPiArDQo+ID4gIAkJYnJlYWs7DQo+ID4g
IAlkZWZhdWx0Og0KPiA+ICAJCWJyZWFrOw0KPiA+IEBAIC0xMzMsNiArMTQ3LDEzIEBAIHN0YXRp
YyB2b2lkIHB0bjUxNTBfaXJxX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiA+
ICAJCQlleHRjb25fc2V0X3N0YXRlX3N5bmMoaW5mby0+ZWRldiwNCj4gPiAgCQkJCQlFWFRDT05f
VVNCLCBmYWxzZSk7DQo+ID4gIAkJCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChpbmZvLT52YnVz
X2dwaW9kLCAwKTsNCj4gPiArDQo+ID4gKwkJCXJldCA9IHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9s
ZShpbmZvLT5yb2xlX3N3LA0KPiA+ICsJCQkJCQkgICAgICAgVVNCX1JPTEVfTk9ORSk7DQo+ID4g
KwkJCWlmIChyZXQpDQo+ID4gKwkJCQlkZXZfZXJyKGluZm8tPmRldiwNCj4gPiArCQkJCQkiZmFp
bGVkIHRvIHNldCBub25lIHJvbGU6ICVkXG4iLA0KPiA+ICsJCQkJCXJldCk7DQo+ID4gIAkJfQ0K
PiA+ICAJfQ0KPiA+DQo+ID4gQEAgLTE5NCw2ICsyMTUsMTQgQEAgc3RhdGljIGludCBwdG41MTUw
X2luaXRfZGV2X3R5cGUoc3RydWN0IHB0bjUxNTBfaW5mbw0KPiAqaW5mbykNCj4gPiAgCXJldHVy
biAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgcHRuNTE1MF9wdXRfcm9sZV9zdyh2
b2lkICpkYXRhKSB7DQo+ID4gKwlzdHJ1Y3QgcHRuNTE1MF9pbmZvICppbmZvID0gZGF0YTsNCj4g
PiArDQo+ID4gKwljYW5jZWxfd29ya19zeW5jKCZpbmZvLT5pcnFfd29yayk7DQo+ID4gKwl1c2Jf
cm9sZV9zd2l0Y2hfcHV0KGluZm8tPnJvbGVfc3cpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0
aWMgaW50IHB0bjUxNTBfaTJjX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICppMmMpICB7DQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmaTJjLT5kZXY7DQo+ID4gQEAgLTI4NCw2ICszMTMsMTYg
QEAgc3RhdGljIGludCBwdG41MTUwX2kyY19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqaTJjKQ0K
PiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICsJaW5mby0+
cm9sZV9zdyA9IHVzYl9yb2xlX3N3aXRjaF9nZXQoaW5mby0+ZGV2KTsNCj4gPiArCWlmIChJU19F
UlIoaW5mby0+cm9sZV9zdykpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoaW5mby0+cm9sZV9zdyk7
DQo+IA0KPiBJZiB1c2Jfcm9sZV9zd2l0Y2ggaXMgb3B0aW9uYWwsIHlvdSBkb24ndCBuZWVkIHRv
IHJldHVybiBlcnJvciB3aGVuDQo+IHVzYl9yb2xlX3N3aXRjaF9nZXQgcmV0dXJucyBlcnJvci4g
QmVjYXVzZSAndXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlJw0KPiBvbiB0aGlzIHBhdGNoIGRvZXNu
J3QgYnJlYWsgdGhlIHNlcXVlbmNlLiBKdXN0IHByaW50IHRoZSBlcnJvciBsb2cgaWYgZXJyb3IN
Cj4gY2FzZS4NCg0KWWVzLCBpdCdzIG9wdGlvbmFsLCBpZiB0aGUgdXNiIHJvbGUgc3dpdGNoIGlz
IG5vdCBwcm92aWRlZCwgdGhlbg0KdXNiX3JvbGVfc3dpdGNoX2dldCgpIHdpbGwgcmV0dXJuIE5V
TEwsIHRoZW4gdXNiIHJvbGUgc3dpdGNoIHdpbGwNCmRvIG5vdGhpbmc7DQppZiB0aGUgdXNiIHJv
bGUgc3dpdGNoIGlzIHByb3ZpZGVkKGludGVuZGVkIHRvIHVzZSkgYnV0IHRoZXJlIGlzDQpzb21l
dGhpbmcgd3JvbmcgdG8gZ2V0IGl0LCB3ZSBtdXN0IHJldHVybiBlcnJvciB0byBmb3JjZSBhIGZh
aWx1cmUNCmluIHByb2JlKGluY2x1ZGluZyBwcm9iZSBkZWZlcikuDQoNCkxpIEp1bg0KPiANCj4g
PiArDQo+ID4gKwlpZiAoaW5mby0+cm9sZV9zdykgew0KPiA+ICsJCXJldCA9IGRldm1fYWRkX2Fj
dGlvbl9vcl9yZXNldChkZXYsIHB0bjUxNTBfcHV0X3JvbGVfc3csIGluZm8pOw0KPiA+ICsJCWlm
IChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJLyoNCj4g
PiAgCSAqIFVwZGF0ZSBjdXJyZW50IGV4dGNvbiBzdGF0ZSBpZiBmb3IgZXhhbXBsZSBPVEcgY29u
bmVjdGlvbiB3YXMgdGhlcmUNCj4gPiAgCSAqIGJlZm9yZSB0aGUgcHJvYmUNCj4gPg0KPiANCj4g
DQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gQ2hhbndvbyBDaG9pDQo+IFNhbXN1bmcgRWxlY3Ry
b25pY3MNCg==
