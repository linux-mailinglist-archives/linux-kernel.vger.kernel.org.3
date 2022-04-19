Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048B506831
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiDSKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245643AbiDSKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:03:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EA815703
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMnrpqAdB2mPkKMHL9PWiWUj5WI7/a6idh6RssCLaZx4KQBZvDJuT6lNF/xRGoeqb3iqcWADp4NCrlKYLuDHKWguxDvJswn76QAaU/1ckpSBznnchz5J705biq4QyYX+JEB+oknI8BzdXDXmiBqvLeO4ByFn9xbTFEoliDEhbmclarcHlB9iXrXxALYzBzL3Pl7ZTpaaqkiTEue+8yItANjjrYLoTHFkTogcMt70z4MQ9gLxti7Cb1/hpPx7X+outQtifkPYTYuR8YtkYtmapeEABXh8vbVVlTX+2wmHOCLxQa9nGnrCo2NRstq5XS/Y53obrR6zFUwSvsH8UnZ8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+gpFb+suJQ8140RU7QtvCO9Q9/QU9QkbNyjS646m8k=;
 b=NtpTcnFMO1OhMTPZAaK2V9DKVqLmtHstKCANtXOZ5umxqQLNkmHxzcZWTpaWZYdm484WBiw0/QbcTtOSfPjb85kEYC+p9ptKatOyd1QtVrGTfGWm4CSLR53cZUwnNN4SWqT9sqkVU3c96IXWjJDZPinL0As0zNFFoatvSnuNGjR1JXopUSuD3J9W6+tOR6gbELL+0SrnIcXA9XA1uIF9bRrzIb2LFqIjW6EGv/RDrM81pnNtGTfNFLn0F8hqDmogqO4cy2RDHnitU4uZS8PVOs37pE7m+cFt+dWLbMTHu1+rKrO3v02u+ExCwSyG77bDTymOcT9zwPAabFPg6GA1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+gpFb+suJQ8140RU7QtvCO9Q9/QU9QkbNyjS646m8k=;
 b=GFV6BzBe70hoUCR6vN43SRuA0CGUDyh+8rc0Zx41/5CO27EhYxdeGm5sPFkNGAjJAA+YKhlbgAyyibOPVzEoTFrwWRoHOiUmBnp7fsU4ovR64vQ6sPSR/6+kXibwaeqGKj+jKSVX5yMsW1TMxc+Ql1NLb1/M47gBzlOtm925Z0E=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (2603:10a6:803:49::27)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 10:00:36 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::d1b0:5a64:86d7:8a42%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 10:00:36 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] extcon: ptn5150: add usb role class support
Thread-Topic: [PATCH] extcon: ptn5150: add usb role class support
Thread-Index: AQHYSZwctDdaLIQeZ06BuvStsTM0tqziq1kAgAAXF/CAFC5VkIAAAhOAgAAAcZCAAAjMgIAAARTAgAAK8QCAAAr3gIAAAWmw
Date:   Tue, 19 Apr 2022 10:00:36 +0000
Message-ID: <VI1PR04MB4333288983F7C857DADB8CE589F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
 <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
 <VI1PR04MB433336414971E5EB6F4BAA8389F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <60955707-aabc-5313-aeb9-d65453538de0@linaro.org>
 <42d019a1-7cb7-d9fb-c974-ce54ccdce5eb@linaro.org>
In-Reply-To: <42d019a1-7cb7-d9fb-c974-ce54ccdce5eb@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38dcb788-404c-493b-e699-08da21eb738c
x-ms-traffictypediagnostic: VI1PR04MB6944:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6944528EF5335BE10C9E5FCF89F29@VI1PR04MB6944.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5h2i0kkVXILqQGUd9oYozfkKJYlYBNiOqbJVR1yD9/8iSW47jsUJFVbmlFcFbtkKPFPWhzM3BVnerNH2GpxzVDbNC9ZGzEcjnGjaqRQhbIjn4nxtk/uZFLWvq+HwoU8O9D+9Ai+k999bTTPzGLX5I3d79Ile5zhYLC8xvM/Ng76xbCFrAmAxC5DAuFSdoMHyRLpIgvZLknnY0Me8ThwLIElzEaoJ+YLNv+XR46FQdGz0GYWMpgcdchJV+3OFQwyxlA6fHKqTPnADt+De8R/jVT2ioDp+nkGmgdtU+3MoutcSSnR/fM+RzwW3RUO94ag6t8K8l1DNILOiQXqNwd84YQ+Cra5QrZr8zl7bdiApE3WUNAMQMgNa/CEl6sp8+aOX3xEpQh4zyuBN0vNUjtwAFgTk60xn+5P5gSbmztPbNlGRCu52UE4Ujjf7UlXK2p6XgsSkCbF3oYfnlNFSv5lXPK4g+e7qtsJXrrMLmebR0xBZU2Ck3af4G1yNmKQ9UM5ZSqLq5qKMxEzwkcBxwPZ2s1JcJy5dksAbyrjuLES7jFaSf1Bf9VMuXMpIba84+MZ0lpqWrc/tAGP7I2CjD3Mu/+NT781WTuKpEcngkCBmvnlVCZYqvEaLTW08eF4vXKlPFvsgiXadZrus5j5fTiXRHtaGSc1nK7mupr31wNZggLomdHYiwYeCGnYbedD5GoZZOfrJYxgKapbtaZW5Jh4iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(53546011)(316002)(66946007)(64756008)(8676002)(66476007)(66556008)(8936002)(5660300002)(52536014)(66446008)(86362001)(33656002)(44832011)(55016003)(2906002)(83380400001)(4326008)(122000001)(38070700005)(38100700002)(7696005)(508600001)(9686003)(6506007)(71200400001)(26005)(6916009)(54906003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGNoYStQQU9xMC9xUjc2ZEVyS2R3L1dHeFE3RXFlMmpKNGxDa3d3NzdneDhz?=
 =?utf-8?B?TnlHSzdXOHQ0ZHZuK1d0bTZaYkdCMDZxQXdyRkJ5U2dCdjVXbHV5RFpFNnM4?=
 =?utf-8?B?Z2FqdTkwQ3RVazFBMVVTdkRaS0MxY2MvbmJZNGhFUzMvWGloT2loY3VubGZE?=
 =?utf-8?B?TWFjalk4dm44djFKTUttemFja1ZtQzNIKzRxUmJLODJzSjBwOE0reVVEaXVs?=
 =?utf-8?B?ZWpDdkwwTVNKTzhiUnpQMVF3MkQxRDVSbU4xVEJUdTJwemhUcGFId0xXaFpE?=
 =?utf-8?B?Z1Y4blk3THBYcFExSzkzQytRcnljTy9uSlBEaGliOFVUUm5RNEZOcGd4WTh4?=
 =?utf-8?B?VXRHODdzWnJwTGwzcUF6K0I4ZEdLVG9IeXk3OWpMTkNsbXkvakxXTlRKQ0hV?=
 =?utf-8?B?Znp5RGg5RENsWFBseElOYTRzYW1JdmhRYjc5ZWVpcTRLZXdISFlNeUJlMnNN?=
 =?utf-8?B?dHB0M2tRb3JWeGdmNTVja2hGSzRNdUtoZ1JodzNBVGJGSUVJeUF6M3Qzb1Ro?=
 =?utf-8?B?MnJOeUhmWm44a2g2VFBoNVNUK3ZiZVRtM0N0ZzYxZk9hY3V6NzlncUgwK2ps?=
 =?utf-8?B?MHNIcE0yV3VUWFdlVHJNNklWN3NKczhmdWVZSmRVQ0FLQ3JqWklHNnhOblhU?=
 =?utf-8?B?aWlna3U0QXVMc2NwZVcvdklXL0xTZUE0NGRoRjduOWN1YTdORnhxQ2dOT2ZT?=
 =?utf-8?B?MTdJaCtmU2JKa3U1Q09wSWx0ZjJGem1zMy9XcmVKL1RNcXBtRXVyN3laUm9a?=
 =?utf-8?B?ZkNvMXBKSlJIbkZLM29YZ0xjZUt1czYyWU1UVzh0djBRS09qaUNTSjZiUWp1?=
 =?utf-8?B?amc4SVRkM0dxWHdSMlh4anQzSnhxSi9ON3V5RE5NR1Z2K3JaL0RtTHl1Q21y?=
 =?utf-8?B?bzVhSVRCSi9MbnBoQ0xoN21zZFlxK0xiR3NRN2JIZ2VuQnlOZDUrREJNQnpp?=
 =?utf-8?B?ZDUzdVhyRnVyTGN0dXlQSnJsWXhiYmV4NXpYQUtvU0pmT21qRExNWmxselNp?=
 =?utf-8?B?Wm9aSkx5Vk90MDl6SWhqODFXMFdFT3MrTnVCc0dSMC9mZkdmSm4xVzUzRnpm?=
 =?utf-8?B?dDh2SW9KMEthYVJpT2tmejJZelVvb09EL3cwenc1WkJxbW9ZbnYyN1dCUldO?=
 =?utf-8?B?YVBKVGYzZHh1VldPSmtwK2tEUksrMEJpbmd4SUIwaXdXNjNkZ29OZ3h1Qzhz?=
 =?utf-8?B?WVZxUTNYaGEzbGxyb2ZqZENrMkZrWkRsRXUxT3BXb05IOFVSMDBndUFuenph?=
 =?utf-8?B?T252RkRJemZJSGorS1FlVWo0Mzc0TEdjT0Z5VXpIZVVZU2JkdmlSTFdpSjRG?=
 =?utf-8?B?WWhwdTlKS25CUml4eXo3c3dBaWF5NUJqTWh6MERmak9BQmhGZkVOclBaMnVi?=
 =?utf-8?B?TE9uc09ZN0ZUWkF3V20xanoxVDRaSnYwOU5zTmxBMkxub200K2FQWlBianpK?=
 =?utf-8?B?WEpFRlViY3FGOTU3NlR2WFBxNDBacW9CSTBxK2JFaWJVQWNoWSt2Sk12djY3?=
 =?utf-8?B?alZUd3d2dElxSlc2NDBaR0xvWGIvaDlPL2JYM2kvNStFakZtcnR5NVhVQ25G?=
 =?utf-8?B?SE5FVHhyMndEU1Y0dUl4Rkx6QkxvOVlFczlCL0dxUG10UjNZT3YvZ3k0enJm?=
 =?utf-8?B?U1dQaGdUQWxkQWpadDB3cEpjdnZQclVuUTB0Nmkvd1NEVXhIUDFBUjRVdlFU?=
 =?utf-8?B?aWlXTnlYaXNYMnpSd3NMMlRRSitjSFBEdU9FQ0NHMUN6UUJMQ0dzQ243MHZT?=
 =?utf-8?B?N3NtWFRucnpyaWZleHlndlgvRXNkNjdJaVZ0dC9JYWRRNFZESkhDZ3BsTTNq?=
 =?utf-8?B?SklCOGdoN3k0WGtwaDRwc0NvSFFHeVpUMHY1Vmc0K0k1eHdMeWhZYzNRZDJS?=
 =?utf-8?B?RzgxbWNNYS91M3U5d1lxdFhDbmJOaXF4d0dIak80eFBnelRjSElZV2NjMmpv?=
 =?utf-8?B?c1g3UWNEZzVpMXNMdmhqbS9vRmhZZGliaTRzOXdBRUpINXpVOTNBS2NDNU9G?=
 =?utf-8?B?R0IvalU3NXpxdnc5Yk05VFZIb1p3SWh1VUhuK1NqeGhqTGZ1SnEwVGF4Sytn?=
 =?utf-8?B?VTJZMDZvOGU0cHJSc2h3UmxuUjhKdWFJckFoQ2VMVENaRDczMVoyandDOWFV?=
 =?utf-8?B?L3VKUWNrak9kaDNkVjFydUN5UldJYmpmbnZyQ1BFNTlEK0tkUS9vblNhQXZo?=
 =?utf-8?B?RUhkdm9HWWROQ0N0VzArRGphYUpMZ2tBVFVJUlJXKzUzRzI3aDdrcDgvOGtn?=
 =?utf-8?B?eHRLdG14STBVSFJtbEh2eTZRRFZWMGduOUxEdHE2Wll4MXVISlhsTkxUREpG?=
 =?utf-8?Q?LuMJfDHutRteS20inZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dcb788-404c-493b-e699-08da21eb738c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:00:36.5054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ak6Vl/Qx4Ittc6LvOcpZke1tbxqUGqFtTFR2o5QEPGpy0KpafZxR5k9C0y/5MM7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBB
cHJpbCAxOSwgMjAyMiA1OjUyIFBNDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBD
YzogbXl1bmdqb28uaGFtQHNhbXN1bmcuY29tOyBjdzAwLmNob2lAc2Ftc3VuZy5jb207DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
WHUgWWFuZw0KPiA8eHUueWFuZ18yQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGV4
dGNvbjogcHRuNTE1MDogYWRkIHVzYiByb2xlIGNsYXNzIHN1cHBvcnQNCj4gDQo+IE9uIDE5LzA0
LzIwMjIgMTE6MTIsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMTkvMDQvMjAy
MiAxMDo1MSwgSnVuIExpIHdyb3RlOg0KPiA+PiBNeSB0ZXN0IGNvbmZpZyBpcyBtYWtpbmcgVVNC
X1JPTEVfU1dJVENIPW0sIGJ1dCBQVE41MTUwPXkNCj4gPj4NCj4gPj4gU28gd2l0aCBiZWxvdyBo
ZWFkZXIgZmlsZToNCj4gPj4NCj4gPj4gI2lmIElTX0VOQUJMRUQoQ09ORklHX1VTQl9ST0xFX1NX
SVRDSCkNCj4gPj4gdm9pZCB1c2Jfcm9sZV9zd2l0Y2hfcHV0KHN0cnVjdCB1c2Jfcm9sZV9zd2l0
Y2ggKnN3KTsgI2Vsc2Ugc3RhdGljDQo+ID4+IGlubGluZSB2b2lkIHVzYl9yb2xlX3N3aXRjaF9w
dXQoc3RydWN0IHVzYl9yb2xlX3N3aXRjaCAqc3cpIHsgfQ0KPiA+PiAjZW5kaWYNCj4gPj4NCj4g
Pj4gV2lsbCBoYXZlIGxpbmsgZXJyb3IuDQo+ID4NCj4gPiBZZXAsIHRydWUuIEkgY2Fubm90IHJl
bWVtYmVyIHRoZSBzb2x1dGlvbiBmb3IgdGhhdC4uLiBXaXRoIHRoZSBzZWxlY3QNCj4gPiB5b3Ug
Y2Fubm90IGRpc2FibGUgVVNCX1JPTEVfU1dJVENILiBXaXRoICJkZXBlbmRzIG9uIFggfHwgZGVw
ZW5kcyBvbg0KPiA+ICFYIiwgb25lIHN0aWxsIGNhbm5vdCBkaXNhYmxlIFVTQl9ST0xFX1NXSVRD
SC4gSG93ZXZlciB0aGlzIGlzIGENCj4gPiBjb21tb24gcHJvYmxlbSBhbmQgSSBhbSBwcmV0dHkg
c3VyZSBwZW9wbGUgd2VyZSB3b3JraW5nIG9uIHRoaXMuIDopDQo+IA0KPiBVc2U6DQo+IGRlcGVu
ZHMgb24gVVNCX1JPTEVfU1dJVENIIHx8ICFVU0JfUk9MRV9TV0lUQ0gnDQo+IA0KPiB0aGlzIHNo
b3VsZCBzb2x2ZSB0aGUgcHJvYmxlbS4NCg0KVGhpcyB3b3JrcywgdGhhbmtzIGZvciB0aGUgcmV2
aWV3IGFuZCBzdWdnZXN0aW9uLCBJIHdpbGwgc2VuZCBvdXQgdjMuDQoNCkxpIEp1bg0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
