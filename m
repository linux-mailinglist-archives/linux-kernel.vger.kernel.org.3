Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA24BF44D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiBVJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBVJC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:02:56 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E085130181;
        Tue, 22 Feb 2022 01:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h87Dma91ycyaW0O8Wqz+uIElGRT5i7o3EpENQoh4hr5dF+gDAQxzAHWtDi4GE6oxn3JybkhqgqyZo1+87U7dBNuOZz2wUad0WC/yxkq1ojOi6LqYLsf90nc31YUz3Hs+pAN4PMprCSd23gFcK+kZ9hZM864uwNkdcy2c9mWiL4WjT+Og4wyBjqBcZhTkmIM9Ci8aZxarOb5FJOrKkdUieIlxydK/DPai655Cjkys7jPZGtqIoenU0TXtMTY6zDWePA6ETiFGY8gnNqrPImWJm8Q0KPs4UTEiWSKSihHpRWphTRki8YRunZYsN9PWHCzcLKr6QbAIOE9l712e89ARog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A+xeBCjDkWxK7inoATp9FCF4fTGoXfmR5pyudbqYdw=;
 b=is5BNQp4oyjr7FIw+p1TY74sjI5lD0tR8ZtbCh1LidEyVcrGXhSuoHUYGKYWWt2gBVp6yNLj52wenrvWBSk9yEoeGbkmMch59s04qyaALInnet3VWq18arCIcfL6zwEAsHY1a51wWzoIBsdSiCmIQVDiyipT7Nq7NGsBD/ieFlblmHZIz7gpTAvtZb3M0lDBLmr+9s4+hcetEdxN9QOf3peY6rSba8qyAqWeBYVmvRAzRoobJGTdGbWkN1mEVmlHl7iiiMPI6DgTrvOmm7/Udsw15eLceYnZu2dkCtXfC2ngA6mCuo6/n261uP3dO/WLkM0mUjKUGNeQI0kQuQfWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A+xeBCjDkWxK7inoATp9FCF4fTGoXfmR5pyudbqYdw=;
 b=JHOBwpfYgxJJJ2CbWXqWMj/0cFbdFoj3Y96ZQiOVnIujqUcj+CA5dGgrmHcCBSZorDPzHRHdfjmODvNKu+c3aTeyMEipW8UhFZUKS82Csk/LmD/b1AskJQ+4VBDVKzeSTCddjTK/fNpKUdQ3J3Sqi/H9V4wRTVebegjdwRSGd7o=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4735.eurprd04.prod.outlook.com (2603:10a6:803:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 09:02:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:02:26 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at
 eos
Thread-Topic: [EXT] Re: [PATCH v3] media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at
 eos
Thread-Index: AQHYJ8gHWDVrUdLAlUyT+VvNr01hGqyfQmUAgAAChlA=
Date:   Tue, 22 Feb 2022 09:02:26 +0000
Message-ID: <AM6PR04MB63415D640666A772234BE1AEE73B9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220222084116.5619-1-ming.qian@nxp.com>
 <de212d97-538f-f25c-5211-8606901cef00@xs4all.nl>
In-Reply-To: <de212d97-538f-f25c-5211-8606901cef00@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c31e5ab5-1d78-4cb0-1efb-08d9f5e20c6b
x-ms-traffictypediagnostic: VI1PR04MB4735:EE_
x-microsoft-antispam-prvs: <VI1PR04MB4735CBCC97BEE96F6A565AB9E73B9@VI1PR04MB4735.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+ifS5MUSE9mHXGZdwpg6KPOqTkk2HWWtkIVTNIP8HYLs1yp+4i7dVUPU+LEBgQhVxRkGIl55oLE1lbNhqWnL4oNt8F2sfbW4PgQGHs5Lo67q+3vMtCiwxzfnZ9E/s3PzqO4fvBcj5WXP9lNkaAYaPMBGdwwBFz0vsRvB3vAUn66Zp+P/7KZ39ewMmFABCzdX37UcGovyCu6lkyGGOpRm3IMq0d0VlE2EpgBSOuwrdLLjKOmWlfzp2YiT1HjT8ALKkU+v8ykZrqOK5zf9jH3+uzPBI3vhnHDB9eJVmWeYrVAMbusd1JdZUoVrqVpZ+tNAvbrwITxYjb0VlmZWgyO+N0LArAYZve6yYZwXi01wM13KJrgOuv7XOSWRQhkTcPakOSC0yY0AF66TciaFzzYXaMMqujjrgUONW8qKYHkj5d7kqhQ6AM9Y/cYl+1RdRR4j6E0floyfOVsZykR6Zb6E33KImZCNUpszefilWlfEBngefmzB1D2ui6KVmx3sgLtneBY3JJim6gcf2Hw7SQI4mM8GBuUZh7FHaJDduuL+n17HNOfPQ+Vx6ouTWROi6fTlvEKVJDUA3lwBAM+9A2jnzPwGp+RLMHDP6PmoiOqkCrJbSwI3XYXs8G4OX/eFyY3St2Or2LaIAuu1gY9XPKeR5rWZntw8Sys17H+Ig17n3t8wECkhm/R7/Q5xHWX8IJV0tUJigb0TMyAruU5DEgMAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(64756008)(66556008)(54906003)(66946007)(76116006)(83380400001)(71200400001)(8676002)(508600001)(4326008)(53546011)(66446008)(66476007)(33656002)(7696005)(6506007)(86362001)(186003)(122000001)(26005)(38070700005)(8936002)(52536014)(44832011)(316002)(2906002)(7416002)(9686003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckI0eVZmblNnUEdkclBkWVE2bzJYQzhlVG9nYmczWkd5MllSWkx5QXVQUG9H?=
 =?utf-8?B?QzEyNXlGNWVsWWtoNzVpdXEvSzJKWE5aL3ZzWGNTNzZEUG9KRGRBaU5pRUMy?=
 =?utf-8?B?enZ6a1BFbk9iK3VCbnMyNktJS1l1Ny9jWEd3Sk5Yb1h6NTF0YkpXT3c0dlFu?=
 =?utf-8?B?b2VRNnFVN0ZwS1UxNEtWVk5tK203cUIvak5idDNSTTVkSHVtZW5IaitvUngy?=
 =?utf-8?B?VnJ3ZEVJQ3pDSVI2RHVIbW9JdVNBblpLZi9LbkduaTEvQTlmQ0R3RGlQeEZY?=
 =?utf-8?B?VjJVNlFyWFdxWUlhRGlDRGt4clNGWEhtazJxZlA3Y1VBNm5TbzdzSTZsZlN0?=
 =?utf-8?B?bWZ4NFNlZUJoa0pKcTYrSkI1ZVpkeklLT0FJTGtBTzhXeERRdlVGTHpDNmR0?=
 =?utf-8?B?Q3oyTXFRSEVQdnlIaDJkNjJuZmJTWlMwRHBLZTlnZExKNmFTOGoyYTZ0cE1R?=
 =?utf-8?B?eC9jS1BGekc2eW9vUExicFMvaTYxVTdXc3VzWThKOTJnUHVmdTY1MUlXdXNI?=
 =?utf-8?B?OGxIUEJUOWpzajR1YTcrZnJIcmd3aWlIOW8vbDhBMDlWRE02eW9KMlJXUFRq?=
 =?utf-8?B?L3ZPOXJ0YXB3Z1d3R2xBVk1kMUIxTFBQMjNUKytpQ3NHTTdjekR4bEUyR3Jl?=
 =?utf-8?B?Ynh6VHBJdm5UL0FVR0llcHdrbFJsdnAyOVJqNzhZbWxQY2g1Z1NGSmszN25p?=
 =?utf-8?B?UFAxYVM3emFtYmF1aHNXMVhRb1dmQTRrU3huMmRzQXFIK0ZZeHI3UGtKK1NN?=
 =?utf-8?B?N2Q4YTRvbkh2L0hwTW0wRjI4aTlCZk5BVlg1Yi9IU3RuZThaNWkxa05obTlM?=
 =?utf-8?B?V0JpQlNQWmhSeFZrMC9ITCsxbi95dEdmUnZmQW9LTTlYQzN6NnJlYVpSRnBi?=
 =?utf-8?B?Umh3OWQvdVE4UDlqazlvcFd1RG9DK1dDa2xXRHNsSWVxZTVwd2o1c09jN0ZI?=
 =?utf-8?B?U2hkeHFkSzBFZ0pxS3RHVDFLRDNJM3czekhhSmlXOE1HYmFwckRxZ1dUZ2Rh?=
 =?utf-8?B?TmlBdFU3cTNVSHE4V2tXTFJNd2NSRy9CT0lyK1hJelVpWG5CcW1hVmxmYVRD?=
 =?utf-8?B?Ukwwb0tOUTdZQlZ6Wlp4UTFhTTBwWFV0QTJjZFFra1J0UU56eGVlZ3dEbzVj?=
 =?utf-8?B?U05hRGdwUHg5QjkwdTNlblJqZmtZOVN6K2w0ZndWUEpmeVdUd2lGMUlqNGxn?=
 =?utf-8?B?Qkp4SmE4VU1jWEJtam5XTGR6ZmFIOWpHNDh4ZDAvOFhpcU5nVnYwa0dRYi9O?=
 =?utf-8?B?QnBMODlTSDNpYzl6dFBBV3E2QlBxc0VuQnkyS1I3K2V1ZG5EZXFGNStZTzdl?=
 =?utf-8?B?UjdBWFhvWWlmS3V0bEhHbzNCUGZRVG9hNE1odnV4STlRSFpyeFFNZ1hVZmU4?=
 =?utf-8?B?d0dkM0FDb2FGUUdkdUxnTzBSTW9MRFR0YkZXcEhjODdPd3BqLy9DS1NxK0FV?=
 =?utf-8?B?ZTZ2RlRmdHdjRXlhaEhRSVhCa3UxeWdscmI1YW5VUlNJaTU0Y25pTFJhcnFK?=
 =?utf-8?B?VWc1aXVkdnFlM0xad0FubDY4Y1hCSklXYjN1Mk96aEJSK29pR3VMSTdXOGRU?=
 =?utf-8?B?d1RvVmNzTXNRUlZ3b3U2aW1DZytHNTNQM3J1Z2ZSWjdtbXd6UFcwVjJrMlBo?=
 =?utf-8?B?Umo0aWMyc2I1UGdDTXN1TE14eHF0cTYrcUt5Yi9GcXZaNVB6Y2VlQ2lVL2Vp?=
 =?utf-8?B?WFV0REZzYjFnZld2bmg0eENvRXJVNVRGUWNoc0NDOERDNG02SkNPRG1BNVM2?=
 =?utf-8?B?dUlFMHFFcHpKTnl5ZXhFcUVzbFl0dHg4a3lkRlNVSUMxazBFdjlTdzZTV2hU?=
 =?utf-8?B?YWpCK1hCUzV6cVE4MjU4RnhmTXE5NGlJalYyYUd6UEFGV1hhVWh0NjlzVTBM?=
 =?utf-8?B?WkNHTW4zNjg5TGd1RFBadWpuWUUwTlNXcnAzaUhNeVh1dERiT3B1Z3cxRVhx?=
 =?utf-8?B?V3h6Q253RVFUVGxZTGlPMXJ0N0xjZjdBVFdNc2JzY3BERGFkVVl5K2VRMjVl?=
 =?utf-8?B?Y0QxcnF0Wm9IMW94R3FRVVJxMGtQSm1GcWQ1cFpEanIyYVVKRHRSSDZKbCtx?=
 =?utf-8?B?SVowMFpEMk8yeWp2TCtJNHhCQ2dJRGl0eWdHQlZuR1loNlFGRFpJK041ck5R?=
 =?utf-8?B?S1piNHNQeTFmRjdGN2VwaFBvQ3FnLzNXVEVpd0ZJZXFVMG02WWRRV1dFOEFr?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31e5ab5-1d78-4cb0-1efb-08d9f5e20c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:02:26.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpEbKMBXizRxNACwayOKyVM68hoiyP+6aeqHdE0y1rpmtq6iAvwVp8U4LvTS+J7dSC7TxoRRXWw7//xz8rag0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZlcmt1aWwgW21haWx0
bzpodmVya3VpbC1jaXNjb0B4czRhbGwubmxdDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDIy
LCAyMDIyIDQ6NDkgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hl
aGFiQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IE1pcmVsYSBSYWJ1bGVhIChPU1MpDQo+IDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNv
bT4NCj4gQ2M6IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1s
aW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1Ympl
Y3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjNdIG1lZGlhOiBpbXgtanBlZzogU2V0IFY0TDJfQlVGX0ZM
QUdfTEFTVCBhdA0KPiBlb3MNCj4gDQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gV2hhdCBj
aGFuZ2VkIGluIHYzPw0KDQpJbiB2MiwgSSBqdXN0IGNsZWFyIHRoZSBzdG9wcGluZyBmbGFnIGlu
IHN0b3Bfc3RyZWFtaW5nIGNhbGxiYWNrLg0KQnV0IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGNsZWFy
ZWQgb25seSB3aGVuIGNhbGxpbmcgc3RyZWFtb2ZmIG9uIG91dHB1dCBxdWV1ZSwNCmFzIHRoZSBz
dHJlYW1vZmYgb2YgY2FwdHVyZSBxdWV1ZSBtYXkgYmUgY2FsbGVkIGluIHNvdXJjZSBjaGFuZ2Uu
IA0KU28gSSBtYWtlIHRoZSBjaGFuZ2U6DQppZiAoVjRMMl9UWVBFX0lTX09VVFBVVChxLT50eXBl
KSkgew0KCWN0eC0+c3RvcHBpbmcgPSAwOw0KCWN0eC0+c3RvcHBlZCA9IDA7DQp9DQoNCj4gDQo+
IFRoZSB2MiBpcyBhbHJlYWR5IHBhcnQgb2YgYSBQUiwgc28gaWYgdGhlIGNoYW5nZXMgYXJlIGp1
c3Qgb2YgdGhlIGNsZWFudXAgdHlwZSwNCj4gdGhlbiBJIHByZWZlciB0byBoYXZlIGEgZGlmZiBv
biB0b3Agb2YgdGhlIHYyLiBPdGhlcndpc2UgSSBuZWVkIHRvIHJlc3BpbiB0aGUgUFIuDQo+IA0K
PiBSZWdhcmRzLA0KPiANCj4gICAgICAgICBIYW5zDQo+IA0KPiBPbiAyLzIyLzIyIDA5OjQxLCBN
aW5nIFFpYW4gd3JvdGU6DQo+ID4gVGhlIFY0TDJfRVZFTlRfRU9TIGV2ZW50IGlzIGEgZGVwcmVj
YXRlZCBiZWhhdmlvciwgdGhlDQo+ID4gVjRMMl9CVUZfRkxBR19MQVNUIGJ1ZmZlciBmbGFnIHNo
b3VsZCBiZSB1c2VkIGluc3RlYWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4g
PG1pbmcucWlhbkBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaXJlbGEgUmFidWxlYSA8bWly
ZWxhLnJhYnVsZWFAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9pbXgtanBlZy9teGMtanBlZy5jIHwgNDENCj4gPiArKysrKysrKysrKysrKysrKysrKy0tICBk
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2lteC1qcGVnL214Yy1qcGVnLmggfA0KPiA+IDEgKw0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9pbXgtanBlZy9teGMtanBl
Zy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2lteC1qcGVnL214Yy1qcGVnLmMNCj4g
PiBpbmRleCBlYzVhMzI2YWZmZDYuLjFkZTA0MDA3NTBhYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2lteC1qcGVnL214Yy1qcGVnLmMNCj4gPiArKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2lteC1qcGVnL214Yy1qcGVnLmMNCj4gPiBAQCAtOTk3LDYgKzk5Nywy
MCBAQCBzdGF0aWMgdm9pZCBteGNfanBlZ19kZXZpY2VfcnVuKHZvaWQgKnByaXYpDQo+ID4gICAg
ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY3R4LT5teGNfanBlZy0+aHdfbG9jaywgZmxhZ3Mp
OyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIG14Y19qcGVnX3NldF9sYXN0X2J1ZmZlcl9kZXF1
ZXVlZChzdHJ1Y3QgbXhjX2pwZWdfY3R4DQo+ID4gKypjdHgpIHsNCj4gPiArICAgICBzdHJ1Y3Qg
dmIyX3F1ZXVlICpxOw0KPiA+ICsNCj4gPiArICAgICBjdHgtPnN0b3BwZWQgPSAxOw0KPiA+ICsg
ICAgIHEgPSB2NGwyX20ybV9nZXRfZHN0X3ZxKGN0eC0+ZmgubTJtX2N0eCk7DQo+ID4gKyAgICAg
aWYgKCFsaXN0X2VtcHR5KCZxLT5kb25lX2xpc3QpKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJu
Ow0KPiA+ICsNCj4gPiArICAgICBxLT5sYXN0X2J1ZmZlcl9kZXF1ZXVlZCA9IHRydWU7DQo+ID4g
KyAgICAgd2FrZV91cCgmcS0+ZG9uZV93cSk7DQo+ID4gKyAgICAgY3R4LT5zdG9wcGVkID0gMDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBteGNfanBlZ19kZWNvZGVyX2NtZChzdHJ1
Y3QgZmlsZSAqZmlsZSwgdm9pZCAqcHJpdiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgdjRsMl9kZWNvZGVyX2NtZCAqY21kKSAgeyBAQA0KPiA+IC0xMDE0LDYgKzEw
MjgsNyBAQCBzdGF0aWMgaW50IG14Y19qcGVnX2RlY29kZXJfY21kKHN0cnVjdCBmaWxlICpmaWxl
LCB2b2lkDQo+ICpwcml2LA0KPiA+ICAgICAgICAgICAgICAgaWYgKHY0bDJfbTJtX251bV9zcmNf
YnVmc19yZWFkeShmaC0+bTJtX2N0eCkgPT0gMCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAvKiBObyBtb3JlIHNyYyBidWZzLCBub3RpZnkgYXBwIEVPUyAqLw0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBub3RpZnlfZW9zKGN0eCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG14
Y19qcGVnX3NldF9sYXN0X2J1ZmZlcl9kZXF1ZXVlZChjdHgpOw0KPiA+ICAgICAgICAgICAgICAg
fSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgLyogd2lsbCBzZW5kIEVPUyBsYXRl
ciovDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGN0eC0+c3RvcHBpbmcgPSAxOyBAQCAtMTA0
MCw2ICsxMDU1LDcgQEANCj4gc3RhdGljDQo+ID4gaW50IG14Y19qcGVnX2VuY29kZXJfY21kKHN0
cnVjdCBmaWxlICpmaWxlLCB2b2lkICpwcml2LA0KPiA+ICAgICAgICAgICAgICAgaWYgKHY0bDJf
bTJtX251bV9zcmNfYnVmc19yZWFkeShmaC0+bTJtX2N0eCkgPT0gMCkgew0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAvKiBObyBtb3JlIHNyYyBidWZzLCBub3RpZnkgYXBwIEVPUyAqLw0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICBub3RpZnlfZW9zKGN0eCk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIG14Y19qcGVnX3NldF9sYXN0X2J1ZmZlcl9kZXF1ZXVlZChjdHgpOw0KPiA+ICAg
ICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgLyogd2lsbCBz
ZW5kIEVPUyBsYXRlciovDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGN0eC0+c3RvcHBpbmcg
PSAxOyBAQCAtMTExNiw2ICsxMTMyLDEwIEBADQo+IHN0YXRpYw0KPiA+IHZvaWQgbXhjX2pwZWdf
c3RvcF9zdHJlYW1pbmcoc3RydWN0IHZiMl9xdWV1ZSAqcSkNCj4gPiAgICAgICAgICAgICAgIHY0
bDJfbTJtX2J1Zl9kb25lKHZidWYsIFZCMl9CVUZfU1RBVEVfRVJST1IpOw0KPiA+ICAgICAgIH0N
Cj4gPiAgICAgICBwbV9ydW50aW1lX3B1dF9zeW5jKCZjdHgtPm14Y19qcGVnLT5wZGV2LT5kZXYp
Ow0KPiA+ICsgICAgIGlmIChWNEwyX1RZUEVfSVNfT1VUUFVUKHEtPnR5cGUpKSB7DQo+ID4gKyAg
ICAgICAgICAgICBjdHgtPnN0b3BwaW5nID0gMDsNCj4gPiArICAgICAgICAgICAgIGN0eC0+c3Rv
cHBlZCA9IDA7DQo+ID4gKyAgICAgfQ0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBteGNf
anBlZ192YWxpZF9jb21wX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwgQEAgLTE0MDcsMTINCj4gPiAr
MTQyNywyOSBAQCBzdGF0aWMgaW50IG14Y19qcGVnX2J1Zl9wcmVwYXJlKHN0cnVjdCB2YjJfYnVm
ZmVyICp2YikNCj4gPiAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2
b2lkIG14Y19qcGVnX2J1Zl9maW5pc2goc3RydWN0IHZiMl9idWZmZXIgKnZiKSB7DQo+ID4gKyAg
ICAgc3RydWN0IHZiMl92NGwyX2J1ZmZlciAqdmJ1ZiA9IHRvX3ZiMl92NGwyX2J1ZmZlcih2Yik7
DQo+ID4gKyAgICAgc3RydWN0IG14Y19qcGVnX2N0eCAqY3R4ID0gdmIyX2dldF9kcnZfcHJpdih2
Yi0+dmIyX3F1ZXVlKTsNCj4gPiArICAgICBzdHJ1Y3QgdmIyX3F1ZXVlICpxID0gdmItPnZiMl9x
dWV1ZTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKFY0TDJfVFlQRV9JU19PVVRQVVQodmItPnR5cGUp
KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgIGlmICghY3R4LT5zdG9wcGVk
KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgIGlmIChsaXN0X2VtcHR5KCZx
LT5kb25lX2xpc3QpKSB7DQo+ID4gKyAgICAgICAgICAgICB2YnVmLT5mbGFncyB8PSBWNEwyX0JV
Rl9GTEFHX0xBU1Q7DQo+ID4gKyAgICAgICAgICAgICBjdHgtPnN0b3BwZWQgPSAwOw0KPiA+ICsg
ICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB2YjJfb3BzIG14
Y19qcGVnX3FvcHMgPSB7DQo+ID4gICAgICAgLnF1ZXVlX3NldHVwICAgICAgICAgICAgPSBteGNf
anBlZ19xdWV1ZV9zZXR1cCwNCj4gPiAgICAgICAud2FpdF9wcmVwYXJlICAgICAgICAgICA9IHZi
Ml9vcHNfd2FpdF9wcmVwYXJlLA0KPiA+ICAgICAgIC53YWl0X2ZpbmlzaCAgICAgICAgICAgID0g
dmIyX29wc193YWl0X2ZpbmlzaCwNCj4gPiAgICAgICAuYnVmX291dF92YWxpZGF0ZSAgICAgICA9
IG14Y19qcGVnX2J1Zl9vdXRfdmFsaWRhdGUsDQo+ID4gICAgICAgLmJ1Zl9wcmVwYXJlICAgICAg
ICAgICAgPSBteGNfanBlZ19idWZfcHJlcGFyZSwNCj4gPiArICAgICAuYnVmX2ZpbmlzaCAgICAg
ICAgICAgICA9IG14Y19qcGVnX2J1Zl9maW5pc2gsDQo+ID4gICAgICAgLnN0YXJ0X3N0cmVhbWlu
ZyAgICAgICAgPSBteGNfanBlZ19zdGFydF9zdHJlYW1pbmcsDQo+ID4gICAgICAgLnN0b3Bfc3Ry
ZWFtaW5nICAgICAgICAgPSBteGNfanBlZ19zdG9wX3N0cmVhbWluZywNCj4gPiAgICAgICAuYnVm
X3F1ZXVlICAgICAgICAgICAgICA9IG14Y19qcGVnX2J1Zl9xdWV1ZSwNCj4gPiBAQCAtMTg0OCwx
NCArMTg4NSwxNCBAQCBzdGF0aWMgaW50IG14Y19qcGVnX2RxYnVmKHN0cnVjdCBmaWxlICpmaWxl
LCB2b2lkDQo+ICpwcml2LA0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAgICBkZXZf
ZGJnKGRldiwgIkRRQlVGIHR5cGU9JWQsIGluZGV4PSVkIiwgYnVmLT50eXBlLCBidWYtPmluZGV4
KTsNCj4gPiAtICAgICBpZiAoY3R4LT5zdG9wcGluZyA9PSAxICAmJiBudW1fc3JjX3JlYWR5ID09
IDApIHsNCj4gPiArICAgICBpZiAoY3R4LT5zdG9wcGluZyA9PSAxICYmIG51bV9zcmNfcmVhZHkg
PT0gMCkgew0KPiA+ICAgICAgICAgICAgICAgLyogTm8gbW9yZSBzcmMgYnVmcywgbm90aWZ5IGFw
cCBFT1MgKi8NCj4gPiAgICAgICAgICAgICAgIG5vdGlmeV9lb3MoY3R4KTsNCj4gPiAgICAgICAg
ICAgICAgIGN0eC0+c3RvcHBpbmcgPSAwOw0KPiA+ICsgICAgICAgICAgICAgbXhjX2pwZWdfc2V0
X2xhc3RfYnVmZmVyX2RlcXVldWVkKGN0eCk7DQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAg
cmV0ID0gdjRsMl9tMm1fZHFidWYoZmlsZSwgZmgtPm0ybV9jdHgsIGJ1Zik7DQo+ID4gLQ0KPiA+
ICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2lteC1qcGVnL214Yy1qcGVnLmgNCj4gPiBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vaW14LWpwZWcvbXhjLWpwZWcuaA0KPiA+IGluZGV4IDlmYjJhNWFhYTk0MS4uZjUz
ZjAwNGJhODUxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vaW14LWpw
ZWcvbXhjLWpwZWcuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vaW14LWpwZWcv
bXhjLWpwZWcuaA0KPiA+IEBAIC05MSw2ICs5MSw3IEBAIHN0cnVjdCBteGNfanBlZ19jdHggew0K
PiA+ICAgICAgIHN0cnVjdCB2NGwyX2ZoICAgICAgICAgICAgICAgICAgZmg7DQo+ID4gICAgICAg
ZW51bSBteGNfanBlZ19lbmNfc3RhdGUgICAgICAgICBlbmNfc3RhdGU7DQo+ID4gICAgICAgdW5z
aWduZWQgaW50ICAgICAgICAgICAgICAgICAgICBzdG9wcGluZzsNCj4gPiArICAgICB1bnNpZ25l
ZCBpbnQgICAgICAgICAgICAgICAgICAgIHN0b3BwZWQ7DQo+ID4gICAgICAgdW5zaWduZWQgaW50
ICAgICAgICAgICAgICAgICAgICBzbG90Ow0KPiA+ICB9Ow0KPiA+DQo=
