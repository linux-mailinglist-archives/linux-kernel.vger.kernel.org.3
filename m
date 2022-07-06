Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9D567FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiGFHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiGFHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:22:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A03922520;
        Wed,  6 Jul 2022 00:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hznWShUzh7BJappUxt0Fr9XelSuypqe5M+zugR2UUUD0Vim55QloNxwT3je6THnJd5tCTEZ0oplt8ZNLL0zhlQ1XnnqmxuFRUoTX0rd3enDmM7x0nAbT59amiUquAI/eOwtOQNy52cNXKV5SMWs7vcYon8A4r0BhdhKGSIuJSS0115CEriN92LpIj2OoxVAIPGmeGkDvMEaopQ55hy7j4x5lVxpFiksAXLUQgNZ46/CduC37bI+tByQKMXvCInGD7J/9wenmGtX+Av09cPwnC2o/5SF/JiWgRBQB470yAjzq/Wc02D1erN2ibDk80kW+COcPBnstyAXOXTk6Uhqc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx2dUaL4//wtOey/dzQ268rQKW7sVpnr/0i7jNAEHD4=;
 b=aEFRFKjVHpihtpmTzt5hqQd+rcv5HW0pWQhlNL7NSYvwbnXhMIgcAtzvuN6icYCJQrWU1odP6n6O8RsmKZ9DhN22kQPhTTQgseOC1l0HLlNrLwZpIQypR4nuzqvTIooCrbd1KaW6bHTTUhFrT6C5BtZxtkgFbuxjaDeZYw7k4Y4HUZK8t7pBnoa5TMY9UOOovL1F4N6dP0hIvKe2vF9OZq9NrQtlOCxnroAwCOHaIf54EG10e11eqBtYNtiDbLbHtKgW4jyQFZOOv0CEJTlOyM6OrYFaEFhh9MfNTjH/PAAUYqz+tjTZYB0cwBpFPcODio1nInAZKLl3L2yMdZNrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx2dUaL4//wtOey/dzQ268rQKW7sVpnr/0i7jNAEHD4=;
 b=VYKJf8pEj/QNgjbe74YiJZ+9ZZN43zhGtvJcbIX0z15lPllXxnPXEYE/o1ILsBSsL8+X6CgExYka6eL82qUCs+9cg+ZAXirXshhvCFIoPRqwY0oQ4YecDVGYGFwStMv1VlF857mw4/mJfMSC94bDkoFhzYlsNqCYRIxaNhaSu8k=
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5c::14) by SI2PR01MB3994.apcprd01.prod.exchangelabs.com
 (2603:1096:4:ef::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 07:22:23 +0000
Received: from SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::688b:31d:d1a9:1fae]) by SEYPR01MB4272.apcprd01.prod.exchangelabs.com
 ([fe80::688b:31d:d1a9:1fae%8]) with mapi id 15.20.5395.019; Wed, 6 Jul 2022
 07:22:23 +0000
From:   =?big5?B?SmltbXkgQ2hlbiAos6+lw7lGKQ==?= <jimmy.chen@moxa.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Add an entry for MOXA platform board
Thread-Topic: [PATCH 2/2] Add an entry for MOXA platform board
Thread-Index: AdiRCQhzXENiN+J4RBSxmos7e7A6YA==
Date:   Wed, 6 Jul 2022 07:22:23 +0000
Message-ID: <SEYPR01MB4272F28F81FB51152496D9CBFA809@SEYPR01MB4272.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 442b5f77-823d-4734-c5cd-08da5f2045a1
x-ms-traffictypediagnostic: SI2PR01MB3994:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kSUc/kPxzyusrpqGHzDIE7kC65KmRlXtlm0NYU2mayr74ae9dvN33tzX6AxUy+ZZWCv6kE5AfaZagX2puoPj90A4dLYCv4Um4LmKxOnP919BiXVfwSFIYY+78xwRPMG54TIZMitst9RmrpvIGYmYOnnErsqMjAsh2oP4mW20rcTKLATIcE7WwJFh3e6TeGZcc50Ztiyvl7H6JGKau9vlcq+ghWIcvjTj/5EXLGFxwSkIilJcOEtDTYaS3J4GCgYmBAiNKhNPePB51EltrKO69CNU+VHAG/pE+bnkM9rFgVqqdDU0lN3/T4bfKtL0p+3ABvcvxonSUu8iS2ms3YYAcElTc3/ct2yKh4CQM7ZpPcfY9HNH0APdkkHBFuMvjYPWDE+fED9moiR4DXJH3uQQHi8JGQsLMt0ChuO68TUx0Wmp5rSFwDr005+e2UJPivwXondBN1CZJlpVm9Lg92Dc2t5pClb74LfdQlcXvMK6xEANvgYN9P24UGR7FbJL/jbOzDebxZTY03rn3ySNx1hx/5Gm6HKwsHLPtb4TOSHTvQGbYVBh4CI6kiIBqTglN0Y+JJ3aRb73sBhOf1lKX02TBRJSstHMeiA8wy2/PvO746oLzRdHbfKHKGy7PUwUicRkT58wfCo12jyzEr3rMGatofBY+CGY63aYe3+W61lj0xAQNUw60De3Ht+7HHVwd5JPLg9qVfTUNAeacVRmnrEAAogiPH6MhzhEae+NdIgSxFENw7Ru4plMofr5iTZP7Vn4A+xB5M+48FcIvRGNRqSY6QfgDr1GajyvEiKVuRM4WfFnYiQZjtlxi1c0vk69lznzIlt0j/Codjd0Px/TeMNx1KLNS3H8V4kwzt4pZv3yvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB4272.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39850400004)(346002)(366004)(316002)(66556008)(66946007)(64756008)(66476007)(76116006)(110136005)(478600001)(26005)(41300700001)(8676002)(66446008)(966005)(71200400001)(6506007)(8936002)(55016003)(4744005)(7696005)(2906002)(5660300002)(122000001)(52536014)(33656002)(86362001)(85182001)(38100700002)(38070700005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?LzVDMUxoVE04aE1SQko4UnVubjErck40U25vd29VeE5LZzZITHBoa1ErQkh5WkVR?=
 =?big5?B?Y2NEMGlTMkQ4aFdXWkdNQjd4aDhZdjlvVGVxR1VRdlczdXB2aHBvbjh6SkdFTWVL?=
 =?big5?B?WFhIRlh1TFBLL1FpT3VmemZJanBsUXZsY0EyVnhEMnIrSnhXdnozL0RIWjdCZWwz?=
 =?big5?B?NU5UZ2RKWHZUajVSRDRYeXFFZlFwRHVzS2V3M2NjNko2a0xOL1ArdVNVcE1RRjIx?=
 =?big5?B?QjhreE9wNGg4QkxiYllDa1kyMEpka3pmTVB3T0NaaWcrNkdtWUdrMnkyRWJkT05Q?=
 =?big5?B?TlhjTC9lT2JrRUVQeG8rWWVUd1dsSlBoQmlWV2ZWYmdKR2pRTXpPNEdWeDRFK2RR?=
 =?big5?B?d3VYZWdsNnFOTFFlY294YU5HejFxQnA1L3U4S1Z6MGRkeTBKa3UrMEROS0Q2b09I?=
 =?big5?B?ekllc1doKzY3cUFCdWplTUc2Nk9tNHh0NmtMNUVYRW0vY1RQNWREdWhBcDNob1JS?=
 =?big5?B?bEhvcmxBbHprd054KzRxQ0ovQ1ZER3BhNjRmSmNRTC8yelVzQVhub3BVUFdaeXEw?=
 =?big5?B?RXBuSUl5bjVFYllBT0Q5RkNIQ0xXWmhCVzMwL0ZaM2xaUlUvc3FLbnZRSXdKTUNn?=
 =?big5?B?S1Bad2wwZWJUNjdkZkxibHc3eWZtL3RkRG0yaU9mNEhwOW83QzhlczZEMHZDVDhN?=
 =?big5?B?eXhuRzBxU1RjQ29YMlUvcUtBTHNxY2hnN2N2VS9PLzJ6bGFGbFVzYnNyNzNjaWJU?=
 =?big5?B?Q0xXSEI0K3FhRmhKaDJJajIzS3JVRUp1YXU4Mk4rTi80RGNEejBTTzhYeXdpVEF0?=
 =?big5?B?c2VaVGhUbVNXMTZsblZ1c0RmSDVFWUU3S1p4VWlISFBxUzhodHpuZ3FHa0pPb2g0?=
 =?big5?B?N3MzeDl3c3ZLNXRRN0kxKzJFOWlZSDhSVDdmUmlsR3hhUkovRjVDMkJJYytoL1ln?=
 =?big5?B?MnpScVJ1dGFhOUV6SWFmc2o5RnVtcVhSejgrM3crVHMycHpKUEFPdksrMHRuWFRr?=
 =?big5?B?SjJmeVlnV3h3WlRMcE9YQXUrbmttbzJCam5GVENVeHZQZmFZWXFKN1Q2aTV4b1M4?=
 =?big5?B?TngrSVlybGZuRmJkcjhhTkFhOXZSMElFTStjcVA2WWZKTy9oUDk4RmsvUnJhaHp4?=
 =?big5?B?VlZkMVo3SVJMUmdEUlRoNGpVUlNkSDFZMk9WSXVKSFNGeER4TUhNeVBqQlRQM3BV?=
 =?big5?B?U1VuUEVsQmRFYjlramh4QTVERVc5aVNDd0NaSVdkMFFCRDExLzlPa000ZUkwTHU4?=
 =?big5?B?Zkw2ejlPS3R3VzNSZmRDVDZaaS9sZ244ZUNYQmFhZ01WU1JXNlJsUjRFeUtTbHov?=
 =?big5?B?NHNBcmN5OWpYazFuc2NHeWUwckJHbVU4L3IvSER6d1N3Z0ozK2Z2cXFyRVZCbmVQ?=
 =?big5?B?NE1vQmJ1TVZTU3dJNWROdjJ3eFdaOSt2OFV1UU03OE5GOGJpeHpGNE5VUlphV2Fw?=
 =?big5?B?QTU0TGVqQndHYjVLSzN5VnljQ2JPbkMrUkJHZTFHOW5pbFR2MXJmTnljVncrWjJq?=
 =?big5?B?Q1hURk0yOG5sRGJjUTgyMldmNVRDK3czamptNVZQZzZCWU5lekJucW1vdFNzUXNp?=
 =?big5?B?cXJLdGovMU4rVHlZazhSTXJDRjQ2ZE5GbWRkVVBSWXlsUGJoU0twZU0vSWNDU1c1?=
 =?big5?B?dW9sT0RTSitXVitDTzBVOTA0ZWJBNm5MTlB2aC9GUFRqTWkvRG5nYnc2bEx6azM1?=
 =?big5?B?M0FWc3N4dFAxeE5MdjI3bThQOFhLTEtuRFZaOEFCT0lZbWRibmtvRnZMbTIxajdh?=
 =?big5?B?VlBKWTN5Y2EyRnVDaUcyZTZsU1YxSmJoenA0UmtQVndCZWs4WndSOTBkRTBrMHdU?=
 =?big5?B?Zmx3MHpvSVZFNFRQdzNIZ09PMWUreW5ic013ZllaWkdhd1NEL0N2Tm05SmROZUtG?=
 =?big5?B?ZUZia2ErZVp2L202MWVYUnp1MUxlMDU3Mm5ncVZ0R3ZaNDU4SmZQdE91SWZ5WjlW?=
 =?big5?B?K08rK1JwMEJQbE9Wa0hRakxjN2FnU09oTk9ETGVPODY5NnZzam5nOFdZc2NSTlVF?=
 =?big5?B?cHJ5dEoxUWdWazJhS3JyVnhsT1NOR3VOYWtuRGhYdWVnbFhWcXFyNHV0QllOZE9s?=
 =?big5?Q?xdCfYnpFkhp2RX4p?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4272.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442b5f77-823d-4734-c5cd-08da5f2045a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 07:22:23.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbkK0ct4kygsP8rcis13B2H4uDnbkT1Mrqda2ijE4rFsmQYke1I5tcYYCSx4bBBFVEz6MPD3FrLdQf+jV7lLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB3994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VUMtODIyMCAmIFVDLTgyMTAgaGFyZHdhcmUgY29tcGF0aWJpbGl0eSBtb2RlbA0KDQpTaWduZWQt
b2ZmLWJ5OiBKaW1teSBDaGVuIDxqaW1teS5jaGVuQG1veGEuY29tPg0KLS0tDQogLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21veGEueWFtbCAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbW94YS55YW1sDQoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21veGEueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbW94YS55YW1sDQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi43M2Y0YmY4ODNiMDYNCi0tLSAv
ZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbW94
YS55YW1sDQpAQCAtMCwwICsxLDIxIEBADQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL21veGEueWFtbCMNCiskc2NoZW1hOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTU9YQSBw
bGF0Zm9ybSBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KKw0KK21haW50YWluZXJzOg0KKyAgLSBKaW1t
eSBDaGVuIDxqaW1teS5jaGVuQG1veGEuY29tPg0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRp
YmxlOg0KKyAgICBkZXNjcmlwdGlvbjogVUMtODJYWC1MWCBlbWJlZGRlZCBjb21wdXRlcg0KKyAg
ICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBtb3hhLHVjLTgyMTANCisgICAgICAtIGNvbnN0OiBt
b3hhLHVjLTgyMjANCisNCithZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KKy4uLg0KKw0KLS0g
DQoyLjIwLjENCg0K
