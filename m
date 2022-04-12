Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8A4FCC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiDLCN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiDLCN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:13:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9B412AC7;
        Mon, 11 Apr 2022 19:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gknt+vx3lfR7RT7tnep2rEe1JmcS9hkmuIHWvutQXNT4FX0ofOZGo1dvJSlmESLaMw4sJ6QzT5akxaIBew0L3lP7JPOQXhrYG+H3NLANxO1XHATMBIOAZ/2HOwxuLxjcrz7oCIzW82hgePoRlroie8L/d2OiZdWiNWiNpTcTO1ZDNepNEL5WkT4PX4SbooGLTEXnK7Mts/zM8HiRk61TLiNBh9V9cy32sJ19++d263R3DkFVueXUMdQba3MbttsznX4eELvlkyCl7MU9OFvdoOaBZBAca6A7FtZ42UMHeTEijLyG0U8ONow8sYD95mOr8/lk9OoK0j11L8elw4vZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+I3LdYpa+xaCopSMVUtQRW0V3/heKk+Y5DEeCV6z1w=;
 b=eHNBKChdKXnMqV7PxzMug73qaYGi527T4ubQcU48P6uxbzqpodmwrFOgjqU+20ke3FVfMr58x68wvbHUfI5qNwr0kyC0gzcStAIlcvlLhWUpyCTOJWNnRTlpHxpTSpg2v4DwLxpg3Re157b0uD1+vq5g432VOYCHhYFDzW7Fno5XwXo0MqSj3yg3HMAsN/aGof5/5dIYjY1a0eUIvTkgKBCK2kBjdO1qE16O/IHbGwKhh5ZZ4WuXKgsDd7LS3qDtjQwJHxqaymEEvq4dQ7aLENXlz8GSCTpLmJnwZ12DHFKSIe7VQOOJCihAuvZCTwvuuMsKxfLZxX3eT6FOO1cc1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+I3LdYpa+xaCopSMVUtQRW0V3/heKk+Y5DEeCV6z1w=;
 b=hzne27ueeHq/i34vgW77KHH7hNr5j8ul3cG6iaAvhZU9Z5QvWZXGVsZoCgu3iR5psTz0bpzBPB/6BBWP/oOQN2g5nCP7veI1yt6xL7nNDzcfDVHhviBuc7FW8q0IrRBrvfNiEEiU3vurod1fYeu8AdDvaKA+7aQ5w+tDqNd0xTs=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Tue, 12 Apr
 2022 02:11:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 02:11:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 3/5] media: imx-jpeg: Propagate the output frame size
 to the capture side
Thread-Topic: [PATCH v3 3/5] media: imx-jpeg: Propagate the output frame size
 to the capture side
Thread-Index: AQHYPpAn5g0kglk4n0OAPeil/nyFC6zqt3qAgADvw6A=
Date:   Tue, 12 Apr 2022 02:11:37 +0000
Message-ID: <AM6PR04MB6341C4B1E095965C5DD1CF11E7ED9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1648023273.git.ming.qian@nxp.com>
 <473edd5666b24a659f651ca003add12ac9a0c2d2.1648023273.git.ming.qian@nxp.com>
 <76cc3643-db74-607a-a6b9-c5e0d10081e3@oss.nxp.com>
In-Reply-To: <76cc3643-db74-607a-a6b9-c5e0d10081e3@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a920c85-42dd-4ce8-2dc6-08da1c29c63e
x-ms-traffictypediagnostic: PAXPR04MB9572:EE_
x-microsoft-antispam-prvs: <PAXPR04MB9572316C4A76A538087E4635E7ED9@PAXPR04MB9572.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ztxm43/JMsBNtd/LiBHyTW+m/tfay7ARSh2L/c6PynXkqkfq8010g0d4dDNcVEvsjMWIzHylF7L/7jJqvF9IvlgLxPDY/KBLxgBv4ddjg/LLYtqJo+855jI26wUUN67FChXY0bkbxSs1F084kBZJ0tGhQZaJQ+zSVM7uuuJ9cqGEkMWl1DiHV4lJOaBLl8jt7MrvnLDdaKqmbh9HoLM3/UqTjjjh4v7AHeotfJJwOCdF2t4tfMKMiUgYNgdZq5lZPE6RXonVbYYNdPxtuhp2xU95FrNU1IsJD7+H3DRawIZ8D2oFJ+rAv5zkxak6irFRz3n1754Z0D+mmj1nCqTIixFZb3hLu64yFRNpyDBeqcKi7pkcVv03RgJyUoztMAIJn63SRH83y1AA8gneWxT+pf4jHwJWkg0umvlB22ydPBiQaT2SFl+cbsASXirh1JFDQqhD1qvN4CtvgCvb0Sum8dPErbRW+GDk4OqCZ1Sz/TK5zk9vqGunSVsjMlultapoyG1Cvq0xiEAKFcLANTGnrJ5JRQN3SIVRS8MBZyiM3DnevHs/KSTsvFiGuCKTvlcp9fU2wBRFvWZFrx04Sosu1WysonUMVaVk7LbBn/5YDWZWrElVM9zJbQmAiInSbksiZwRY6i+xrQ3tZ/VCUjMHZWtReHSZyDwo7AtZNff6lsAddjjS0PpV7pLUSkCwxi9vtKl3SQpAt4P1DGOwTQwzqfoZlC/wfnQ6Agq8YiUnlf83Faz6TH7nSd1VsebrIgey
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(83380400001)(71200400001)(110136005)(122000001)(186003)(52536014)(66446008)(2906002)(4326008)(44832011)(33656002)(8676002)(64756008)(66946007)(66476007)(76116006)(66556008)(54906003)(7416002)(508600001)(316002)(38070700005)(38100700002)(55016003)(26005)(86362001)(6506007)(7696005)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRFa3ZwRDNsU1NOVnlMN2d3SFVHRlE4U01oaC9zaFozbTdxbmxoUGtLR1JU?=
 =?utf-8?B?OVVDTjJHZzB1NGZaKzRYbk9KcFp1Z3Zpc0NXOWdnYlN5VERLTTd0aHpRR1Jp?=
 =?utf-8?B?UHpCeE1wNjdrUGo3MUpTVjcvTUdXSlNrUjA1b003bW52ajdueDk1NGQ3dzdh?=
 =?utf-8?B?Mk9WeTFvVnFHcW43d25hZ3FtdWpHdDFPbmQyeUFEZExIREFTQXZhZW15YjY1?=
 =?utf-8?B?MklDZytwNDFYdTBMc3J4QXNxNDFNNGZSUnhHUHJNa0hVZEVaVWhISGNzekZK?=
 =?utf-8?B?U25TN1haelZqYm1GNDAveVpFanUwckhoRW5HTzloT0Q4UnZqdXNteWYyc0x5?=
 =?utf-8?B?c1VaN0o1RElFZUR5WHU0dm5tWEh3bEZ0TmxBSlp3VmhNbEpwak9rQVU2d2Nn?=
 =?utf-8?B?cHUvdk4zdFFWY053ZldTZkkzM25EMzEyOUpUMHFWVGtEZmxLMWtTYk5paHhy?=
 =?utf-8?B?dHNubklVVE9nSlNwTXlYU1FzdmZKQzRmVlJlZ1IrNzFhY1ZHTjl1OVVURnBQ?=
 =?utf-8?B?dWpGa1JKdHkwU2tJQ05RZVNMZnZTb2dMelBxc3gxa1VudzRkRStpSW95K1JC?=
 =?utf-8?B?UzNhVklrZS9ZNjZEMWRPbm9SZHNiUVNnK21KUW1oSnNEMkViOVlpT2NjeHJt?=
 =?utf-8?B?R1I4a29laXRpVGFsRFBCMWtkYkJUcHRRbXRSNyszczRUN0VPQS9UZ2ticVFI?=
 =?utf-8?B?SnVGQ2Q2QlNDQktpYW0wYUdsR1V1Y0FtdXNOakE0aTliK1R2Yk96Q3NrWC9m?=
 =?utf-8?B?MktvR1VnWGRSYkRkellONVhtUWJ2UjdpME5QYmgvcWw2YWJyTWpSb0hZNjg1?=
 =?utf-8?B?NDJFcWJ0S21UR0pEMkRkdDZrZXFKNjdYUEpuS0kwYm9ZNGk0aUJYRENrUzM5?=
 =?utf-8?B?a2VQS3dMUVpuYzZQVlFjVHJGNUlhaUtQN0p3TzlUd25FbUpCYUVtUGRqbzBv?=
 =?utf-8?B?blpxMWFTa1dTOTJ1WUpsRVJDVktwQy9Pa2dNay9xM2pKL1duL2x5V0tlOHRl?=
 =?utf-8?B?aW4rN2tzd2UxaitUWVNFSld4RjFWQXRpdXU4SldvOUpxNzZITVpqTXRwYTk5?=
 =?utf-8?B?TVNlWU9HWS82UCswMkpzbTZHWW9obXQ5aDZSMGt0TnVJVlVHT2M3NWNLdmtK?=
 =?utf-8?B?bkJrbjVwTHZxbWpMODBaWnA2QU9ENEQ5RjlWZFI0THBiQ0xvN24wYStzNTRR?=
 =?utf-8?B?bXVxTzZqMkxCc2dhdCtDNzhOZy9CYnVEc25HeWdxNUJMaDc1UnVoWERYK1I0?=
 =?utf-8?B?Z3pFa3cxamszQk9lVE9IMk5RVWJsdmtYSk45QStjUkR4bzZqZlV0c3o3aTgz?=
 =?utf-8?B?bE8xdEFKeUpoUGZ5WlNKMTIyQmhqMWs4ckdzd0Nxa3RpNnJrUUJnc05HY1Fn?=
 =?utf-8?B?NDR6RnNsVC9kZVdPdGs2QmwzTmF4UUh0Tnp1c29pNkQ1KzFmY0JaSm9CMkw0?=
 =?utf-8?B?a1RBOWYxVWZIdmIvSG5RNUJLTXRUcUFxaEJzK3E1OHlkeFQ2SjhCcWlpMVNs?=
 =?utf-8?B?S1c0NmpvakVWQ2ZMeExGUk1IdURMNG5oR3FBUDR2aFpkZWtlcHAvdHlodHpv?=
 =?utf-8?B?Wm4zTmhwVTFYdXJqWE0yY0V1VnZFalQwaUd0S3lBLzdmTzhHWE12aExiVHll?=
 =?utf-8?B?OVprZTVqNTdaQm9LN3R3d0UrUUVJcUFGMW94UnZGalg2RTVtUFlwQThETUx5?=
 =?utf-8?B?cm9DVS9zd2YvTXhsZHFNaWdJQW1PQ1NBUG9QanF5blpKaHNsYzdHQzZIclZO?=
 =?utf-8?B?OGhYSDFhRW44SFpkM0dsSEhMcFNWdXlFMEtQWVRZSG9uT0RTZCtybXVIbnNW?=
 =?utf-8?B?U21pdk9VYVo1NTJhZDlmMlpUenN2VU8wZUVlb0pFM1FLeVNjbWZGUyt3UFNj?=
 =?utf-8?B?MmlnWHNKUzdaVm1zeHYzR2dtUHlMcm85RGZNQ2pkNmREZkppWUxVSjRKWnVk?=
 =?utf-8?B?RWNtRi9qRXkyVjJFaWZjTndDeWxOWW9aWnN4WHF4RkJlby9CekU0QWwxSVE0?=
 =?utf-8?B?MjNueFRaeTRmTmhUR3ovRnlFaXBwbjZFbm9aQk1ZV0tPTHlsT2x6aXlCUHd6?=
 =?utf-8?B?WVc2TVN0eThvU29INFBnS1YvY0c0VVhyS0tHNzBOYURxRzZkZThIbXFRSEZK?=
 =?utf-8?B?QUx1UXBtYXAvTjUramtMMFRHellUYklVeWx5T1BUZkpTeXJDVFlOS2FkeE5Q?=
 =?utf-8?B?N0NZYytuL0lVcU9GRTg3bmp4ZVZGTEF3aVpweW1xNGo3MnEzQlByTjVYRkZB?=
 =?utf-8?B?V0JVMmMrcmV5UU5vQnhmMDhCM3IxQVppaTJKekhJdG9EeWYrT25jd1YwUnUr?=
 =?utf-8?B?dlNoVUJ2dzVDMlpYNkR4ZENuVTV1dW80NFoxYTdCQ3B6blJZUUJ5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a920c85-42dd-4ce8-2dc6-08da1c29c63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 02:11:37.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIJT3ArtCqPY1Hj10ntIfz8zLzK5GjhORcShiuMLTovuEeVn/HUc36nnu+8OMe/PB3Zgb/E6i0BHZ6tqqMuTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaXJlbGEgUmFidWxlYSAoT1NTKQ0KPiBTZW50OiBNb25kYXksIEFwcmlsIDExLCAy
MDIyIDc6NTAgUE0NCj4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hlaGFi
QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGUNCj4gQ2M6IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubDsga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzVdIG1lZGlhOiBp
bXgtanBlZzogUHJvcGFnYXRlIHRoZSBvdXRwdXQgZnJhbWUgc2l6ZQ0KPiB0byB0aGUgY2FwdHVy
ZSBzaWRlDQo+IA0KPiBIaSBNaW5nLA0KPiANCj4gT24gMjMuMDMuMjAyMiAxMTowNSwgTWluZyBR
aWFuIHdyb3RlOg0KPiA+IFRoZSBHU3RyZWFtZXIgdjRsMnZpZGVvZGVjIG9ubHkgZXZlciBjYWxs
cyBTX0ZNVCBvbiB0aGUgb3V0cHV0IHNpZGUNCj4gPiBhbmQgdGhlbiBleHBlY3RzIEdfRk1UIG9u
IHRoZSBjYXB0dXJlIHNpZGUgdG8gcmV0dXJuIGEgdmFsaWQgZm9ybWF0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IC4uLi9tZWRpYS9wbGF0Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYyAgICB8IDMwDQo+ICsr
KysrKysrKysrKysrKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9ueHAvaW14LWpwZWcvbXhjLWpwZWcuYw0KPiA+IGluZGV4IGE5NTMwNTYzOWRkOS4uNWRmYTZm
ODc4NzFlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbnhwL2lteC1q
cGVnL214Yy1qcGVnLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL254cC9pbXgt
anBlZy9teGMtanBlZy5jDQo+ID4gQEAgLTE4MzEsMTIgKzE4MzEsNDAgQEAgc3RhdGljIGludCBt
eGNfanBlZ19zX2ZtdF92aWRfb3V0KHN0cnVjdCBmaWxlDQo+ICpmaWxlLCB2b2lkICpwcml2LA0K
PiA+ICAgCQkJCSAgc3RydWN0IHY0bDJfZm9ybWF0ICpmKQ0KPiA+ICAgew0KPiA+ICAgCWludCBy
ZXQ7DQo+ID4gKwlzdHJ1Y3QgbXhjX2pwZWdfY3R4ICpjdHggPSBteGNfanBlZ19maF90b19jdHgo
cHJpdik7DQo+ID4gKwlzdHJ1Y3QgdmIyX3F1ZXVlICpkc3RfdnE7DQo+ID4gKwlzdHJ1Y3QgbXhj
X2pwZWdfcV9kYXRhICpxX2RhdGFfY2FwOw0KPiA+ICsJZW51bSB2NGwyX2J1Zl90eXBlIGNhcF90
eXBlID0NCj4gVjRMMl9CVUZfVFlQRV9WSURFT19DQVBUVVJFX01QTEFORTsNCj4gPiArCXN0cnVj
dCB2NGwyX2Zvcm1hdCBmYzsNCj4gPg0KPiA+ICAgCXJldCA9IG14Y19qcGVnX3RyeV9mbXRfdmlk
X291dChmaWxlLCBwcml2LCBmKTsNCj4gPiAgIAlpZiAocmV0KQ0KPiA+ICAgCQlyZXR1cm4gcmV0
Ow0KPiA+DQo+ID4gLQlyZXR1cm4gbXhjX2pwZWdfc19mbXQobXhjX2pwZWdfZmhfdG9fY3R4KHBy
aXYpLCBmKTsNCj4gPiArCXJldCA9IG14Y19qcGVnX3NfZm10KG14Y19qcGVnX2ZoX3RvX2N0eChw
cml2KSwgZik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+
ICsJaWYgKGN0eC0+bXhjX2pwZWctPm1vZGUgIT0gTVhDX0pQRUdfREVDT0RFKQ0KPiA+ICsJCXJl
dHVybiAwOw0KPiA+ICsNCj4gPiArCWRzdF92cSA9IHY0bDJfbTJtX2dldF92cShjdHgtPmZoLm0y
bV9jdHgsIGNhcF90eXBlKTsNCj4gPiArCWlmICghZHN0X3ZxKQ0KPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICsNCj4gPiArCWlmICh2YjJfaXNfYnVzeShkc3RfdnEpKQ0KPiA+ICsJCXJldHVy
biAwOw0KPiA+ICsNCj4gPiArCXFfZGF0YV9jYXAgPSBteGNfanBlZ19nZXRfcV9kYXRhKGN0eCwg
Y2FwX3R5cGUpOw0KPiA+ICsJaWYgKHFfZGF0YV9jYXAtPncgPT0gZi0+Zm10LnBpeF9tcC53aWR0
aCAmJiBxX2RhdGFfY2FwLT5oID09DQo+IGYtPmZtdC5waXhfbXAuaGVpZ2h0KQ0KPiA+ICsJCXJl
dHVybiAwOw0KPiANCj4gSXMgdGhpcyBhbiBvcHRpbWl6YXRpb24sIHRvIGF2b2lkIHByb3BhZ2F0
aW5nIHRoZSBmb3JtYXQgdG8gdGhlIGNhcHR1cmUgcXVldWUsDQo+IGlmIGl0IGlzIGFscmVhZHkg
c2V0PyBJZiBzbywgc2hvdWxkbid0IGZvdXJjYyBhbHNvIGJlIHBhcnQgb2YgdGhlIGNvbXBhcmlz
b24/DQo+IA0KPiBUaGFua3MsDQo+IE1pcmVsYQ0KPiANCg0KSGkgTWlyZWxhLA0KICAgIFllcywg
aWYgdGhlIGNhcHR1cmUgc2l6ZSBpcyBlcXVhbCB0byB0aGUgb3V0cHV0IHNpemUsIHdlIGRvbid0
IG5lZWQgdG8gc2V0IGl0IGFnYWluLiBGb3IgZGVjb2RlciwgdGhlIGZvcm1hdCBvZiBvdXRwdXQg
aXMganBlZywgYW5kIHRoZSBmb3JtYXQgZm9yIGNhcHR1cmUgaXMgdW5jb21wcmVzc2VkIGZvcm1h
dCwgc3VjaCBhcyBudjEyLCBzbyB0aGUgZm91cmNjIGFyZSBhbHdheXMgZGlmZmVyZW50Lg0KDQo+
ID4gKwltZW1zZXQoJmZjLCAwLCBzaXplb2YoZmMpKTsNCj4gPiArCWZjLnR5cGUgPSBjYXBfdHlw
ZTsNCj4gPiArCWZjLmZtdC5waXhfbXAucGl4ZWxmb3JtYXQgPSBxX2RhdGFfY2FwLT5mbXQtPmZv
dXJjYzsNCj4gPiArCWZjLmZtdC5waXhfbXAud2lkdGggPSBmLT5mbXQucGl4X21wLndpZHRoOw0K
PiA+ICsJZmMuZm10LnBpeF9tcC5oZWlnaHQgPSBmLT5mbXQucGl4X21wLmhlaWdodDsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gbXhjX2pwZWdfc19mbXRfdmlkX2NhcChmaWxlLCBwcml2LCAmZmMpOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IG14Y19qcGVnX2dfZm10X3ZpZChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgdm9pZCAqcHJpdiwNCg==
