Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDED535764
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiE0BrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiE0BrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:47:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E252FFD8;
        Thu, 26 May 2022 18:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF1CXPoac9t+UZh/6B8ohZrQgP2aBl1l3hk+oQ1Z00qiEHvaWwb8ENrvcg35VeZQnf5YL76SdvmRsKMc4yHEt0b5pSrfj5Tw5+4ccR6P93Xo84HKzlYGalM12zaoOegXLukeDSiJHyihpr95e65UsjrGm1XXyWmtOagDnH85mPNH/YRFYKxxF7c4Rb312IsGRIBRefIoQdpMWXv76gS2KoOsg2hRF5+WFb3a7SR+klQ+YZfZbqrTgMKm3iCODthGsj3uSxVWAtVntACPFS2UtNtM4+S/jtK6VcF1TLk7p9PyIvJk1vfpTLjdv7d30tDi9KSz4WHHwQ/jHx+8+lWI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1EBFiVNGuoX4izHnrDasYo9vP0xzmsemcxaLdy17ds=;
 b=GVUoMIUkUSHd5ITpaXRjDQQ5H9Vs5qM5aQboUwM1S61Vmu8MbgjrB9Irv/OOkxvttFestaOfOU4L/fItrXqk6JNfeyf78sKJbTLqBDGxWnVSYYdPnA91Gdi89KJzZkXutNGxG1p0j4ORjNeHj+Mp8xzoCbz3RtGUW0yeA/m6y9wE7Xafw08wBbvRYVsMVbtaXYFZhHjY/gBNjP9Bf5ooth7FO/CWMw3UrO3UMfGRxXWfJ3VdOBqbLWfiMvigHZbdqiSzHJvoej6qRptjbFPs+oJMyDl0438WZXbn/TBoIbNaJc9kIeruOCHmmZeXfTHz1sq0Byu/xxPmplwg0tmSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1EBFiVNGuoX4izHnrDasYo9vP0xzmsemcxaLdy17ds=;
 b=Fa01O15EcUb/gE+miDXXmvHf7Bw94qKvrr0bNYI4eaxxSqwhHE5jcVgpXWNP/e+myRbcEZM6mFeWWwVtuUuZeZvkB+gCrfeeyjhSviO0jWMojugpGgipiLCt3Re65QJOtoFDi1soITBBjJkuaYA6xLeA8JCWK6iDi5qM4DAWzpM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 01:47:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 01:47:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Topic: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Thread-Index: AQHYbphE4hPgB8NWEUiwdYEo5yj0ra0tzvwAgAAFlVCAABKegIAACHAAgAMluwCAAN/LUA==
Date:   Fri, 27 May 2022 01:47:12 +0000
Message-ID: <DU0PR04MB9417CD64522CF6D1B395D66588D89@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
 <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
 <DU0PR04MB9417F22B607C95BDAB84C01488D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <f42f4b45-f8cb-8855-8814-5dfaaf446d4a@linaro.org>
 <DU0PR04MB941718AEF4D3DF64F3E551B888D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5bcbf7d3-daa8-6f00-6743-3d0328a82980@linaro.org>
In-Reply-To: <5bcbf7d3-daa8-6f00-6743-3d0328a82980@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a76ed2b3-d4b5-494a-4957-08da3f82d199
x-ms-traffictypediagnostic: AS8PR04MB8069:EE_
x-microsoft-antispam-prvs: <AS8PR04MB80691DC77AB77E9DF49F67E588D89@AS8PR04MB8069.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0k6GW+W/1DlEuxU81raX4ykGiX03ZCo1ByUrtguuQr0eXVEJOVYHgo0JwmiZQjlcMjfRbibSo2xNu8JTy+d+EFSsYQwa9RJD69OhXZG54A3DWqVY0pON6ooUQlGtdjJrqwkxTNzjmdmTdm70jfpzRY6ZdIqQ05LKK2yWdBgGD0rGGe/zqAXpO/ntmmaOvJibVJpbeFjiY5FEv9fQ48NzV+rrhAYr3XbeFCcFTO3B4NyRYQ017w6pGGSBhRMqF5dD82YDX2Ktgtw1jujrMFzstSAMpT8O5/1GXA0pA07dh38f3/2+LEtNBzLOndsRZ4KrvPV7QmNUrZfOcIHKJfn1QczqG/2X9flBFkAmtl5hmoVKpqy3Pr31rmyJZ2boVOke9YMGf3i5R7WAOQpXZ7AMNTriOKAkx0HiI2TC0/eRQD+aN7tw4yuGMZ0UdQ1wbv5fLOUsjfiHt14qZM0nqh4Bbx49l8KlhRhq6k5fmaqBKChxu/HXQKK7T+ddrZxzaiS7zKFb+dM7bXGW0L6wLVW7rJmnDPHB2xEKbpFmY6P6qJCCrpbUQLMcN/T3x8ahwaaFVJUA1zs8frJPeYWKytzeccAxMU6k0Ba42mevnkWeoRjqSIx6JzJIYVQajD4wJfP4zbRkPYBzbpuEqFkO25hV7P4pXm5fnKrvj4PTiWRbB7vGF8FiTM6hQ1d1LBjew2ijZSxrX8YcgF0qrZ58WpwCtc6VvreMLTQrbQ2XThUvxoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(26005)(9686003)(7416002)(8676002)(508600001)(5660300002)(8936002)(44832011)(7696005)(52536014)(33656002)(2906002)(122000001)(55016003)(83380400001)(86362001)(186003)(38100700002)(66946007)(110136005)(64756008)(66556008)(66476007)(66446008)(38070700005)(316002)(76116006)(54906003)(4326008)(71200400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZ2VUJzbFdrRkZTS2h4ZGZhajFsRWdvMC9XSnF2aUpZaTR2b1kwV0FacTJy?=
 =?utf-8?B?aEY1ZC9vY2ZTWU8wUXZUSWhLc05EdlFvclBGZnBQNThIY253RThKUk15aE1q?=
 =?utf-8?B?eTZsTzhVbCs2NGdjVGFlUnNOaW9uRm9keGd0WU12aUZkMExKTFg5U1JuR1Az?=
 =?utf-8?B?WjVFc044dUE5ZzNndTRzVTkycVZBR3ViTExZcEdlekE3T29GU2daS1lkdk9Z?=
 =?utf-8?B?bEROZE9wU3MvSld0UjlGUHhlNi9weVQxU05kR2ZsTnpsQks4cCtnYk1wRWhv?=
 =?utf-8?B?NWNnL2pWSEl2TzM2bU9vSndkSlk0MFhITkw2aVhsdzRNeVhPYmFOMXdBdFNP?=
 =?utf-8?B?U1dpT3RQTyt5ME5MdGUxaXArK3IzdTloNHE2WXM2VnhtMkJScTIxUC9jMU02?=
 =?utf-8?B?RWs0RlJaNlRiWUZIMTdWcStyQzI3OUFRbUVQOURVMXh1WU54QTJUK3F4cXhO?=
 =?utf-8?B?QkplaDlnaXF4d3R5UUpFTUE4MmVBR3l0a0tBQzIydWo2MVU3cFFoK3BiUjUx?=
 =?utf-8?B?enBZd2dBUWdUNS9zbDhZTEQ1RE1ZVm9GYjVqeC9HLzAxbVpBL3Y3VERZUzN5?=
 =?utf-8?B?TTdXNk4vb2ZsYjhTN1pRRTZZS2UrbjBWRk5BSXFRTWN5Q2Jib0R5NFNKV1NQ?=
 =?utf-8?B?bm5QTTBjYzJZbjVZZEdDOUxZMzNRNi9UWnNLNGh4SXhwODhwdEFjdUdETm5U?=
 =?utf-8?B?MGhXWG9Wb3RZMTNwQlhyNTN2Y2dpS05iQ0NzZ1VQYVZjQ3pkcFVCN3VUVDAw?=
 =?utf-8?B?a1JEcllFWXE0UGZvOWRyOW1oN2lvK1M5YTVvcC9QMEtVUjd1M0l5OHJnUVpO?=
 =?utf-8?B?Vkk2Tm5jclhhRksreWQ5NVFwdFhSbFk1TTRzZnd4R3dORHh2MEx5NkFHMWli?=
 =?utf-8?B?ajNTMzJDWVJmNHhseXFieHJsemdYNllkMFVXbWRMN3ZjSTlsbm92VC9qU2hm?=
 =?utf-8?B?aDRQT2MycXd1NXFqa0Q5Um40cXh3ZFIyVXBtWTNZYlM0ak9WRU0yODFKc3Jp?=
 =?utf-8?B?aEZtTkdETytUVTNlb3J2VGNUVlBzZkJ3ZkVkS2U5OWFSQmRHQ2RTNlRuN053?=
 =?utf-8?B?c0Rtby8rTmFFeUlyV2RzcDRDeFBBdDJ2ZGljcU1lZHdYU0x2Z1lxR2NYR3V6?=
 =?utf-8?B?M1M5OVlNMlE1cm5mWEZNWWo3RnRYUmd0Qk82Lzk5Z1pyaktNc0hSbjlqVHpS?=
 =?utf-8?B?Z25UeVlEZUEyZDkzV3p2eVBCMFliOUhxWk1FbFBDanlFblNLN1lPa24vYVVZ?=
 =?utf-8?B?VEdINVcrTXdkMUlQZVlITFE4NXc0N2RtdUVKYVV3S0VsL2NCa09qenVKbXYz?=
 =?utf-8?B?RE55QnRYZENTYjM0KzRpSTNMaTc1SlFTM3Bvdi9nKzJxcDl4Y01zaVVzYlUx?=
 =?utf-8?B?QlFCZWovQXVOM090SnJ5THZ0Mi9RZlpwMDJ4d2M2TVY5dit3ZXZIQ0FTNVV4?=
 =?utf-8?B?dmhNREpYSVVJU2ZacmRWSkVKYlQ4WWdyVXAxMXhqcnRGZFd4aXBUR1VQYVl1?=
 =?utf-8?B?QXFZWHVqQm1Cem1tSjNFRERmTlVhZTZVeFE2bWc5cFZEUnI0UFNoeFZUaWZl?=
 =?utf-8?B?bDNPWi9QM1BDSkFJSkVrenZKSVlKcmQxd1ZmcnVrOGt1cTEzNDBUYXQ1c0ht?=
 =?utf-8?B?akNjMzJsVTZtb0k4T2haa0VJT2VwTk81UDc2WFgvd3RBTTBLenhQeXNncE0x?=
 =?utf-8?B?MDRwbFFpUWNqamIxODJUQXYwMjhtVzBKbXlZb2ExKzc2Ny8yemVWSTQwYjlV?=
 =?utf-8?B?aXZYSkJrV0JRWHNyN0Z4Nkh6ZVE1cktPVkVvQ0ZvZmJqeVdrU2lEMmp2bTN1?=
 =?utf-8?B?TFdRMTJma2pLTHJLRjV5MWNhS2FSbGl6alhMbGVUOGpNTnd5cUNXZWlhalli?=
 =?utf-8?B?VC8rOWhsTUVHUk5HNWViR3RVRTZvTVFNcnhMeW5IWHpNSmptTVNyREdmRUNr?=
 =?utf-8?B?L05aMFFFd2JCeGQwVWxYc28wY1RkVENMRGZCcWFrVEdJZ0kzNGZiZWNobW1u?=
 =?utf-8?B?enZ2U2dXVjdubDJFWmRXbC9nZUZDNjhOOHlwU2hFdU5nM0swNlE4dHUwcXE0?=
 =?utf-8?B?ODZxbml2U3UySFFxMlA0aTBiN2dCMkpjUmRlZUk3NWFKU0d4LzFFb3pudXpx?=
 =?utf-8?B?Tm1xOEJ5ckFzM2t5ekhxRjg4aTN2Q2QzL2R0Y1ZIU1JCdGUvRmh5Y1V4UHRx?=
 =?utf-8?B?ZnRyWU9zaUJrRUJmdXd5R3UyeUdIUWVkd0MyZTBnRGNlc2pValFJQUE1UVhu?=
 =?utf-8?B?L2lFMUlTa2I3U3pvbk1vVTczKzZIMWdlcC9GTEc0YjRzMU5MRitTcDdRUS82?=
 =?utf-8?B?eXA2R08vMnpJZmZWVXdKTDgzbVc2TmRDTWd4SVo0N3JLWlZqMjBoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76ed2b3-d4b5-494a-4957-08da3f82d199
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 01:47:12.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+fOdjftiA/UTMHH6SWbpzLXn1g70S7Z62i5or4ozZ9N6nAFNMHViciHQTAt+Hntwt34m05MLgEvaHxsJazAJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDIy5bm0Neac
iDI25pelIDIwOjA4DQo+IFRvOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFBlbmcgRmFu
IChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT47DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBzYm95ZEBrZXJuZWwub3JnOw0KPiBtdHVy
cXVldHRlQGJheWxpYnJlLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRy
b25peC5kZQ0KPiBDYzogQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvN10g
ZHQtYmluZGluZ3M6IHNvYzogYWRkIGJpbmRpbmdzIGZvciBpLk1YOTMgU1JDDQo+IA0KPiBPbiAy
NC8wNS8yMDIyIDE0OjA3LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzddIGR0LWJpbmRpbmdzOiBzb2M6IGFkZCBiaW5kaW5ncyBmb3IgaS5NWDkzDQo+ID4+IFNS
Qw0KPiA+Pg0KPiA+PiBPbiAyNC8wNS8yMDIyIDEyOjM3LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvN10gZHQtYmluZGluZ3M6IHNvYzogYWRkIGJpbmRpbmdz
IGZvciBpLk1YOTMNCj4gPj4+PiBTUkMNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIzLzA1LzIwMjIgMTM6
MzAsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPj4+Pj4NCj4gPj4+Pj4gQWRkIGJpbmRpbmdzIGZvciBpLk1YOTMgU3lz
dGVtIFJlc2V0IENvbnRyb2xsZXIoU1JDKS4gU1JDIHN1cHBvcnRzDQo+ID4+Pj4+IHJlc2V0cyBh
bmQgcG93ZXIgZ2F0aW5nIGZvciBtaXhlcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1i
eTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgLi4u
L2JpbmRpbmdzL3NvYy9pbXgvZnNsLGlteDkzLXNyYy55YW1sICAgICAgIHwgODgNCj4gPj4+PiAr
KysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL2lt
eDkzLXBvd2VyLmggICAgICAgfCAxMSArKysNCj4gPj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgOTkg
aW5zZXJ0aW9ucygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4+Pj4+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2ZzbCxpbXg5My1zcmMueWFtbA0KPiA+Pj4+DQo+
ID4+Pj4gRmlsZSBzaG91bGQgYmUgaW4gcmVzcGVjdGl2ZSBzdWJzeXN0ZW0sIHNvIHByb2JhYmx5
IHBvd2VyL3Jlc2V0Pw0KPiA+Pj4NCj4gPj4+IG9rLCB3aWxsIHB1dCB1bmRlciBwb3dlci4NCj4g
Pj4+DQo+ID4+Pj4NCj4gPj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRp
bmdzL3Bvd2VyL2lteDkzLXBvd2VyLmgNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdA0KPiA+
Pj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2ZzbCxpbXg5
My1zcmMueWFtbA0KPiA+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvaW14L2ZzbCxpbXg5My1zcmMueWFtbA0KPiA+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ0NWMxNDU4YjljMQ0KPiA+Pj4+PiAtLS0gL2Rl
di9udWxsDQo+ID4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvaW14L2ZzbCxpbXg5My1zcmMueWFtbA0KPiA+Pj4+PiBAQCAtMCwwICsxLDg4IEBADQo+ID4+
Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkgJVlBTUwNCj4gPj4+Pj4gKzEuMg0KPiA+Pj4+PiArLS0tDQo+ID4+Pj4+ICskaWQ6DQo+
ID4+Pj4+ICs+ID4gK3RpdGxlOiBOWFAgaS5NWDkgU3lzdGVtIFJlc2V0IENvbnRyb2xsZXINCj4g
Pj4+Pj4gKw0KPiA+Pj4+PiArbWFpbnRhaW5lcnM6DQo+ID4+Pj4+ICsgIC0gUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4+
Pj4+ICsgIFRoZSBTeXN0ZW0gUmVzZXQgQ29udHJvbGxlciAoU1JDKSBpcyByZXNwb25zaWJsZSBm
b3IgdGhlDQo+ID4+Pj4+ICtnZW5lcmF0aW9uIG9mDQo+ID4+Pj4+ICsgIGFsbCB0aGUgc3lzdGVt
IHJlc2V0IHNpZ25hbHMgYW5kIGJvb3QgYXJndW1lbnQgbGF0Y2hpbmcuDQo+ID4+Pj4+ICsNCj4g
Pj4+Pj4gKyAgSXRzIG1haW4gZnVuY3Rpb25zIGFyZSBhcyBmb2xsb3dzLA0KPiA+Pj4+PiArICAt
IERlYWxzIHdpdGggYWxsIGdsb2JhbCBzeXN0ZW0gcmVzZXQgc291cmNlcyBmcm9tIG90aGVyIG1v
ZHVsZXMsDQo+ID4+Pj4+ICsgICAgYW5kIGdlbmVyYXRlcyBnbG9iYWwgc3lzdGVtIHJlc2V0Lg0K
PiA+Pj4+PiArICAtIFJlc3BvbnNpYmxlIGZvciBwb3dlciBnYXRpbmcgb2YgTUlYcyAoU2xpY2Vz
KSBhbmQgdGhlaXIgbWVtb3J5DQo+ID4+Pj4+ICsgICAgbG93IHBvd2VyIGNvbnRyb2wuDQo+ID4+
Pj4+ICsNCj4gPj4+Pj4gK3Byb3BlcnRpZXM6DQo+ID4+Pj4+ICsgIGNvbXBhdGlibGU6DQo+ID4+
Pj4+ICsgICAgaXRlbXM6DQo+ID4+Pj4+ICsgICAgICAtIGNvbnN0OiBmc2wsaW14OTMtc3JjDQo+
ID4+Pj4+ICsgICAgICAtIGNvbnN0OiBzeXNjb24NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICByZWc6
DQo+ID4+Pj4+ICsgICAgbWF4SXRlbXM6IDENCj4gPj4+Pj4gKw0KPiA+Pj4+PiArICBzbGljZToN
Cj4gPj4+Pg0KPiA+Pj4+IFdoeSBkbyB5b3UgbmVlZCB0aGlzIHN1Ym5vZGUsIGluc3RlYWQgb2Yg
bGlzdGluZyBkb21haW5zIGhlcmU/DQo+ID4+Pg0KPiA+Pj4gSSBmb2xsb3cNCj4gPj4+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9mc2wsaW14LWdwY3YyLnlhbWwNCj4g
Pj4+DQo+ID4+PiBUaGVyZSBhcmUgc2V2ZXJhbCBzbGljZXMgaW4gU1JDLCBqdXN0IGxpa2UgdGhl
cmUgYXJlIG1hbnkgcGdjcyBpbiBncGN2Mi4NCj4gPj4NCj4gPj4gV2FpdCwgYnV0IHlvdSBoYXZl
IG9ubHkgb25lIHNsaWNlIGFuZCB5b3UgZG8gbm8gYWxsb3cgbW9yZSBvZiB0aGVtLg0KPiA+DQo+
ID4gU2xpY2UgaXMganVzdCBhIGdyb3VwIG5vZGUgdGhhdCBjb3VsZCBpbmNsdWRlIG1hbnkgY2hp
bGQgbm9kZXMsIHN1Y2gNCj4gPiBhcyBzbGljZSB7DQo+ID4gICBtZWRpYW1peCB7DQo+ID4gICB9
Ow0KPiA+ICAgbWxtaXggew0KPiA+ICAgfTsNCj4gPiB9DQo+ID4NCj4gPiBUaGUgc2FtZQ0KPiA+
PiBhcyBmb3IgZ3BjdjIgLSB0aGVyZSBpcyBvbmx5IG9uZSBwZ2MuIFdoYXQncyB0aGUgcG9pbnQg
b2YgdGhhdCBub2RlPw0KPiA+DQo+ID4gVGhlcmUgYXJlIG1hbnkgcGdjcywgcGdjIGlzIGp1c3Qg
YSBncm91cCBub2RlIHRoZXJlLCBTZWUNCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAuZHRzaS4NCj4gDQo+IFNvIHRoaXMgZG9lcyBub3QgZXhwbGFpbiBteSBxdWVzdGlv
biBhdCBhbGwuIFdoeSBkbyB5b3UgbmVlZCAic2xpY2UiIChvcg0KPiBwZ2MpIG5vZGU/IFlvdSBo
YXZlIG9ubHkgb25lIHNsaWNlIGluIHRoaXMgZGV2aWNlLCBzbyB0aGlzIGlzIHNvbWUgaW5kaXJl
Y3QgbGF5ZXINCj4gd2l0aG91dCBtZWFuaW5nLi4uDQoNClRoZXJlIGlzIG5vdCBvbmx5IG9uZSBz
bGljZSwgdGhlcmUgYXJlIG1hbnkgc2xpY2VzLiBJIHVzZSBhIHNsaWNlIG5vZGUgdG8gZ3JvdXAN
CmFsbCB0aGUgc2xpY2VzLCBhcyBiZWxvdzoNCnNyYzogc3lzdGVtLWNvbnRyb2xsZXJAeHh4IHsN
CiAgeHh4eHgNCiAgc2xpY2Ugew0KICAgICBtZWRpYTogc2xpY2VAMCB7DQogICAgIH0NCiAgICAg
bWw6IHNsaWNlQDEgew0KICAgICB9DQogICAgIGRkcjogc2xpY2VAMiB7DQogICAgIH0NCiAgfQ0K
ICB4eHh4eA0KfQ0KDQpXaXRoIGEgc2xpY2Ugbm9kZSB0aGVyZSwgaXQgd2lsbCBiZSBhbHNvIGJl
IGVhc3kgZm9yIHNwZWNpZmljIGRyaXZlciB0byBrbm93DQpzcGVjaWZpYyBub2RlLg0KDQpUaGFu
a3MsDQpQZW5nLg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
