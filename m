Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52039564014
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGBMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:41:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8110FC0;
        Sat,  2 Jul 2022 05:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkqI3khf+MP+Jt9TVN1lGclDgiEIzbBypabYsZd3VN2HIgOlNRbQKPA7u9YNSYut0QsIUJst+mC+BjfoykLhtooYIGOdTq7/EXr6pyXI+SbNVcAZcN+O9fgSMkmzSvH4eqPwvZmDPCBFq0fNAMLlhyyaQf8eyqIph1X2pJ6Y7MDA1Fo/xrpLd1hlnMAx5tIz4p+BhB6gWKhaQ2kIJNk4DyREStfavva1dg112biCssN5ZIzy8yrJQHFO3SFqVTi4S2/XGT1i7RHeth7QY20zEwk8OkkqRuIx2u7EBclAXQUYsGNgQMqhuxLYeYy67SDhELwbe6fvMx6BAqqp8YJpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqvoReGShOeau/bynGA9o6imkOZFIF0kukGmZX37QKU=;
 b=kMgs3BXW5jyznM778yh5ghLanPRZl8E02TuZ657azsi7HSzx2NPx426pkGugz2wyIeHuglvsTBNBFj/Xd9UuYWG6RN7LDgtXP1/LWTtI3LttLxDGzmE8+PqWz0w/R9Bgp//3k9V9ny3+Uum4tcMnovN2+ostIJOTbPWtjIkHKKZGTRTZVuxt7F0Aqz6mYgcp/rHqFgLpaYaIEvTBS5wCEm+DSIUg/un4zE9sXcCV2UcdL8/T4qOWAtPsmXv1NKecWd4k3ALgMeWznp/try/jo1SumLsNg3bzWTmqaGyYpwipqazYZmzlomXqbVqrzVLVKwWTOJMX8iHaPTuzGGbppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqvoReGShOeau/bynGA9o6imkOZFIF0kukGmZX37QKU=;
 b=QA1zTnCmpL556HEtUx8x3G6Qp5PkL64OexgjI45CN7doc6FuWUm2WulkUMR7sLi5t95i19edeh43JC06YctoL/pudF1neVFQL7okHMNFljRSWId+RiqFhCE6e2a/WQuBYgrWI4+ppXrsd27U02xkFKEJJWwKuOpJDJIFGV8OgpA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7677.eurprd04.prod.outlook.com (2603:10a6:102:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sat, 2 Jul
 2022 12:41:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Sat, 2 Jul 2022
 12:41:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
Subject: RE: [PATCH V2 8/9] interconnect: imx: configure NoC
 mode/prioriry/ext_control
Thread-Topic: [PATCH V2 8/9] interconnect: imx: configure NoC
 mode/prioriry/ext_control
Thread-Index: AQHYgVM8GzNjGbGzV0WOnpDujNOS0a1lLnIAgAXwqFA=
Date:   Sat, 2 Jul 2022 12:41:14 +0000
Message-ID: <DU0PR04MB94173A39251811928E28A5E788BC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-9-peng.fan@oss.nxp.com>
 <ae4b19a2-0315-a748-d048-6eb3ed2cc65a@kernel.org>
In-Reply-To: <ae4b19a2-0315-a748-d048-6eb3ed2cc65a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34424832-3aad-47da-8722-08da5c2826b2
x-ms-traffictypediagnostic: PA4PR04MB7677:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9bIhDSngpot+hfBkgzNhLHLVi3d+71Yqi9H3lOiBCLDI5izjsQup/9kZHw30E7QQs100dC+PZffgNM9+/QlY/PUPr+qby4Yg8GunobmPLfscG83OQDUYj37Eo8Q5KSuVKDy9QcwQ92UHmeBBIEiDSpdP7vWZ8BfB7yhNbnrxmwoW1s5LCNLOz8Agq5enooaDbimMjCQRc6BFnz2OGowxS6ysb0ZBCgIEVhihZS+5rZpPZwGkG9sY0y/RVxSgKG1m1QNMXjj36zB/Z8+S0j2Jv8NipFTNrjKcvaisB0UIL8RXlWgFgjreb7lE2rEZG4P7xTjNlG/eHgTRK/UgLQCagyjXlwUdaCJsaIl9nx/AuZiKpjQeck/fGk/pqN9cnHssvhJ240NS9jbRiq/Ro9Z4vJS0DGvGtYnLKsi6EesT/cHn3GSOttTtrC1hLUSY1cZVHdsJW0TAxFRYETHg9FDed1XvS5Gdv2UMRcV9VcjKRJP89LNCzozI806LetABDcTLQC/Yi4pND3Y7F/4DVJ8haA4ALYLkCj0Ak5wz+FkAaJDUqXwjt6np1UvfhNhaPaS0FpKEJAiMaVEIgP1g4xP2fmXXm1iJwDw1ZfLTC9gyxWShuWxhA8f62NC1sZh7JeYuK1KXn3JjUvhgTh6Ka1AI51CBRIXVjKOnngVVDZlakDaWROoBbJPY/d1bc/ABfX9x1pS1sx2+PUZ/h7qQ+cQiG5ZmBKm9XP4RlVZ9Yhd9VhaxO0Wfk17FUHbrl2qsntPmwuCYOApZS1jOt7ctkxWFPXG2slEmUKgTqQRfv2NhCys+idHUjUAp9S7TrU78C8UZAqJrXsOd/CXjD4vEK3eLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(33656002)(86362001)(921005)(38070700005)(122000001)(38100700002)(8936002)(52536014)(478600001)(2906002)(41300700001)(5660300002)(7416002)(44832011)(316002)(54906003)(110136005)(71200400001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(186003)(55016003)(83380400001)(26005)(53546011)(7696005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0V4NnVUSm1jS004ZVJ5ZkNaNXNrT3k3SnBhWE9RaFRidHlnci9rbkhOTW93?=
 =?utf-8?B?azQvYnZsRGNJeExZeEcxVUt2aFZjNUc1NkZCR3o0RFZEZTd3QUZzU2Y3S3gx?=
 =?utf-8?B?LzNCUmFhTVYwSHZjdHJ3SUsxQzZZKytIUXJnMnJjSzB0WTN2eXZwSkdFcmhU?=
 =?utf-8?B?VDVIM2JKUzg3bnhPMlhNcUxIQTJ4WEdSTERMQld5WmZ2SVhZSndGcTZQNEpP?=
 =?utf-8?B?YU9XNkh1bmhJcVVITnZHNk5mUGRTbzlOYkNhTnlSbTM1OE85KzdFM0F3ZU5w?=
 =?utf-8?B?UWVnRVVRVXpXNUpRS0p3ZmxDNlZYUjczeUUycTFHSyttbWw4N2FiTUVsK2d3?=
 =?utf-8?B?c29IWEFEamxqbDlYZUJlaDVMQkpGVmN1WGFDVTlRM2liMm51WndtMUpNZDlr?=
 =?utf-8?B?YjdlcE9hUmxOM3F0RTJjc3crcDU5bzRwLzNQYS95Qm5tajVpNmJvSG85MU9B?=
 =?utf-8?B?c3VsZm1sQktwUENuWUpWUklmTE1mb3FybHpyVnlFbHZEVEJZZlh1d0szN2dr?=
 =?utf-8?B?dXRSS2ZpUjVxZ0I2SFpzcGdMcFFrUHVlakxjalI3KzI1Y3V5MlRMVnZ0MEda?=
 =?utf-8?B?czRod1ZpZFNhbG1OaE5HL0RNSTMvU2EwRlJpb1YzTWdqSFJuTE1DR08yc0Fw?=
 =?utf-8?B?ZTJkSjhQN3JmYlRqTWp5d0VPbEw1NGRrdkY2T1ZSUytydVFtS3VaM0FkMzlU?=
 =?utf-8?B?aEI5M0pmVGxib2t4UkR0V3Z5MkhId0pieDE4dXBVQmhFZ1lZQ0tFNmQyMWs5?=
 =?utf-8?B?TXFlY1lTeFEzYnF1S3BReWgreldWVjUxbTI4UGVUajhDUkk2d3RuMDRnTE1l?=
 =?utf-8?B?cGhVYmI5TGthSWt0UVM3OC8rcmRWb0VGenZCS00yME4zY2NROExJUDRtdXN1?=
 =?utf-8?B?YktUSktEN1lkMXhFLy9ZWGpDbFdZSm1pUWhGb2Y1ZER4ZTY1akwzaUNtczFz?=
 =?utf-8?B?cjVITkhoc1QyMzlwZ2gwaTRTcXArVjRMOGVqWkp2Q1VRMm81UmFpbndqMjRt?=
 =?utf-8?B?TCt6TEZjYnlqbzhNcG0waUs4YjVWc1IxK1ZGU0p5eUFVbUs5SEdwSjhSWTdJ?=
 =?utf-8?B?SjFOOE8yb3NPbkpqZHRYUDlXRGxnY1Zjd0ZqTkcyUjJuaGRVZEhRZnpyMzZn?=
 =?utf-8?B?bXB6eFE0a2lrMitEa0dyTHgwZjFJTGJlSWZlTk41UytzbG0wRDdPTVRBQ3ho?=
 =?utf-8?B?RDlUdHdYTEM4cXZUMjRleENBZkc2TFZ5L1RGS0g5eDRaTzlRMk1kWE1wT2do?=
 =?utf-8?B?b0NtREJoL0VHQ1FTWkFHUXRFZThHUWVFRTY4Q1p2RnFkYzYzMjRkMWxqT3BW?=
 =?utf-8?B?ejROdmpuNHNOMUJSWCt5UnpHMHdoSnhmQ0lBa2thQStBQU85SjFGeEh6UCtn?=
 =?utf-8?B?WHg4aVo4UExoMmlTdU12TzROQkVYNjc2ZFBmRTlibUd3QlF0SkhkRHRqY1NH?=
 =?utf-8?B?cFRZODRxMEYyQlhPTk4vZUJUMVg2eHcrL2VURFc0UmozM0VhM1BwaDB6RGdw?=
 =?utf-8?B?UVc5OFNrY2dpUkI3N0grdFo5VU1CQmpEdkI0NmFyUFp0N3l0a2YvSnJuU2p0?=
 =?utf-8?B?UnkyakdJYlpFRlhFRDhrS2FEZE5wbStQVGpXWmtzaUcwdGo3WGthSmRUVnJP?=
 =?utf-8?B?dFZERENpOC9TUnMwTUNRdjlJd3M1bEora1NiekpLMXc3U0xRN1NlNVlOSmJY?=
 =?utf-8?B?MVNhUEhEcUk1WGZXcHBsQU9SU3AzYU9wYnluZzRPMEx3RmdUcktyVDQ1TXQ3?=
 =?utf-8?B?Vm90SmtEOXpQWVB3M0V2VVhMa2NKTUlaT2krZ2cxcHYzWDFFdXBUU3VyNTkv?=
 =?utf-8?B?WkxSVWw0RjVsYjVGc1ViWmtTTnJHV0tmQjQ3ckxrT3RucmVqME1hcktDQm9q?=
 =?utf-8?B?TWNRTXp5YXhucFkxWVpqNnRxYnAzSGpUR05nekdJVEV4bzFmc2Q5M2N1SHpX?=
 =?utf-8?B?azQ0dy9QRGdET1NjM09GTndETkttT0kxR1dOSSt6T1NlOHdPYWZuRHNYYzZ4?=
 =?utf-8?B?T1JkTTZtbjZZU2hyTXZMV0Zpc3k4N2w3K3Y3QS9ZMDFyTFZBd0h4d1B2QUU5?=
 =?utf-8?B?Sk5IKzRKNDZQQWZGOUgySFB3VEZZNmtLdEZFMFJ0cW5LRmxPaTdYQTI4UWdh?=
 =?utf-8?Q?+PUs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34424832-3aad-47da-8722-08da5c2826b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2022 12:41:14.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwl+WJlvyqF04zutv6Z6K56KWy2ZkYLN/bY3omdZtPTI8QYJSNMRuNazK33r6o26Tl7LToZXbL9o0Cmo/K6Ghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDgvOV0gaW50ZXJjb25uZWN0OiBpbXg6IGNvbmZpZ3Vy
ZSBOb0MNCj4gbW9kZS9wcmlvcmlyeS9leHRfY29udHJvbA0KPiANCj4gSGkgUGVuZywNCj4gDQo+
IE9uIDE2LjA2LjIyIDEwOjMzLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5n
IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEludHJvZHVjZSBpbXhfaWNjX25vY19z
ZXR0aW5nIHN0cnVjdHVyZSB0byBkZXNjcmliZSBhIG1hc3RlciBwb3J0DQo+ID4gc2V0dGluZyBQ
YXNzIGlteF9pY2Nfbm9jX3NldHRpbmcgYXMgYSBwYXJhbWV0ZXIgZnJvbSBzcGVjaWZpYyBkcml2
ZXINCj4gPiBTZXQgcHJpb3JpdHkgbGV2ZWwsIG1vZGUsIGV4dCBjb250cm9sIGluIGlteF9pY2Nf
bm9kZV9zZXQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5jICAgIHwg
NDMgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gICBkcml2ZXJzL2ludGVyY29u
bmVjdC9pbXgvaW14LmggICAgfCA0NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gICBkcml2ZXJzL2ludGVyY29ubmVjdC9pbXgvaW14OG1tLmMgfCAgMiArLQ0KPiA+ICAg
ZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteDhtbi5jIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMv
aW50ZXJjb25uZWN0L2lteC9pbXg4bXEuYyB8ICAyICstDQo+ID4gICA1IGZpbGVzIGNoYW5nZWQs
IDg0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbnRlcmNvbm5lY3QvaW14L2lteC5jDQo+ID4gYi9kcml2ZXJzL2ludGVyY29ubmVj
dC9pbXgvaW14LmMgaW5kZXggNzg1NTdmZTZkYTJjLi5iZDcyOGNhZjJiODUNCj4gPiAxMDA2NDQN
Cj4gDQo+IFsuLl0NCj4gDQo+ID4gQEAgLTM3LDggKzQwLDI0IEBAIHN0YXRpYyBpbnQgaW14X2lj
Y19ub2RlX3NldChzdHJ1Y3QgaWNjX25vZGUgKm5vZGUpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0
IGRldmljZSAqZGV2ID0gbm9kZS0+cHJvdmlkZXItPmRldjsNCj4gPiAgIAlzdHJ1Y3QgaW14X2lj
Y19ub2RlICpub2RlX2RhdGEgPSBub2RlLT5kYXRhOw0KPiA+ICsJdm9pZCBfX2lvbWVtICpiYXNl
Ow0KPiA+ICsJdTMyIHByaW87DQo+ID4gICAJdTY0IGZyZXE7DQo+ID4NCj4gPiArCWlmIChub2Rl
X2RhdGEtPnNldHRpbmcgJiYgIW5vZGVfZGF0YS0+c2V0dGluZy0+aWdub3JlICYmIG5vZGUtDQo+
ID5wZWFrX2J3KSB7DQo+ID4gKwkJYmFzZSA9IG5vZGVfZGF0YS0+c2V0dGluZy0+cmVnICsgbm9k
ZV9kYXRhLQ0KPiA+aW14X3Byb3ZpZGVyLT5ub2NfYmFzZTsNCj4gPiArCQlpZiAobm9kZV9kYXRh
LT5zZXR0aW5nLT5tb2RlID09IElNWF9OT0NfTU9ERV9GSVhFRCkgew0KPiA+ICsJCQlwcmlvID0g
bm9kZV9kYXRhLT5zZXR0aW5nLT5wcmlvX2xldmVsOw0KPiA+ICsJCQlwcmlvID0gUFJJT1JJVFlf
Q09NUF9NQVJLIHwgKHByaW8gPDwgOCkgfCBwcmlvOw0KPiA+ICsJCQl3cml0ZWwocHJpbywgYmFz
ZSArIElNWF9OT0NfUFJJT19SRUcpOw0KPiA+ICsJCQl3cml0ZWwobm9kZV9kYXRhLT5zZXR0aW5n
LT5tb2RlLCBiYXNlICsNCj4gSU1YX05PQ19NT0RFX1JFRyk7DQo+ID4gKwkJCXdyaXRlbChub2Rl
X2RhdGEtPnNldHRpbmctPmV4dF9jb250cm9sLCBiYXNlICsNCj4gSU1YX05PQ19FWFRfQ1RMX1JF
Ryk7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJZGV2X2luZm8oZGV2LCAibW9kZTogJWQgbm90
IHN1cHBvcnRlZFxuIiwNCj4gbm9kZV9kYXRhLT5zZXR0aW5nLT5tb2RlKTsNCj4gPiArCQkJcmV0
dXJuIC1FTk9UU1VQUDsNCj4gDQo+IE5pdDogSSBiZWxpZXZlIHRoYXQgLUVPUE5PVFNVUFAgaXMg
dGhlIHByZWZlcnJlZCBlcnJvciBjb2RlLg0KDQpGaXggaW4gVjMuDQoNCj4gDQo+ID4gKwkJfQ0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAlpZiAoIW5vZGVfZGF0YS0+cW9zX2RldikNCj4gPiAgIAkJ
cmV0dXJuIDA7DQo+ID4NCj4gDQo+IFsuLl0NCj4gDQo+ID4gQEAgLTIzNyw3ICsyNjMsOCBAQCBz
dGF0aWMgaW50IGdldF9tYXhfbm9kZV9pZChzdHJ1Y3QNCj4gaW14X2ljY19ub2RlX2Rlc2MgKm5v
ZGVzLCBpbnQgbm9kZXNfY291bnQpDQo+ID4gICB9DQo+ID4NCj4gPiAgIGludCBpbXhfaWNjX3Jl
Z2lzdGVyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gLQkJICAgICBzdHJ1Y3Qg
aW14X2ljY19ub2RlX2Rlc2MgKm5vZGVzLCBpbnQgbm9kZXNfY291bnQpDQo+ID4gKwkJICAgICBz
dHJ1Y3QgaW14X2ljY19ub2RlX2Rlc2MgKm5vZGVzLCBpbnQgbm9kZXNfY291bnQsDQo+ID4gKwkJ
ICAgICBzdHJ1Y3QgaW14X2ljY19ub2Nfc2V0dGluZyAqc2V0dGluZ3MpDQo+ID4gICB7DQo+ID4g
ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgIAlzdHJ1Y3QgaWNjX29u
ZWNlbGxfZGF0YSAqZGF0YTsNCj4gPiBAQCAtMjY3LDEzICsyOTQsMTkgQEAgaW50IGlteF9pY2Nf
cmVnaXN0ZXIoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldiwNCj4gPiAgIAlwcm92aWRl
ci0+ZGV2LT5vZl9ub2RlID0gZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+ID4gICAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgaW14X3Byb3ZpZGVyKTsNCj4gPg0KPiA+ICsJaWYgKHNldHRpbmdz
KSB7DQo+ID4gKwkJaW14X3Byb3ZpZGVyLT5ub2NfYmFzZSA9IGRldm1fb2ZfaW9tYXAoZGV2LCBw
cm92aWRlci0NCj4gPmRldi0+b2Zfbm9kZSwgMCwgTlVMTCk7DQo+ID4gKwkJaWYgKCFpbXhfcHJv
dmlkZXItPm5vY19iYXNlKQ0KPiANCj4gZGV2bV9vZl9pb21hcCgpIHJldHVybnMgRVJSX1BUUigp
LiBTbyB3ZSBzaG91bGQgY2hlY2sgaXQgd2l0aCBJU19FUlIoKS4NCg0KT29wcywgZml4IGluIFYz
Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3MsDQo+IEdlb3JnaQ0KPiANCj4gPiAr
CQkJcmV0dXJuIFBUUl9FUlIoaW14X3Byb3ZpZGVyLT5ub2NfYmFzZSk7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICAgCXJldCA9IGljY19wcm92aWRlcl9hZGQocHJvdmlkZXIpOw0KPiA+ICAgCWlmIChy
ZXQpIHsNCj4gPiAgIAkJZGV2X2VycihkZXYsICJlcnJvciBhZGRpbmcgaW50ZXJjb25uZWN0IHBy
b3ZpZGVyOiAlZFxuIiwNCj4gcmV0KTsNCj4gPiAgIAkJcmV0dXJuIHJldDsNCj4gPiAgIAl9DQo+
ID4NCj4gPiAtCXJldCA9IGlteF9pY2NfcmVnaXN0ZXJfbm9kZXMoaW14X3Byb3ZpZGVyLCBub2Rl
cywgbm9kZXNfY291bnQpOw0KPiA+ICsJcmV0ID0gaW14X2ljY19yZWdpc3Rlcl9ub2RlcyhpbXhf
cHJvdmlkZXIsIG5vZGVzLCBub2Rlc19jb3VudCwNCj4gPiArc2V0dGluZ3MpOw0KPiA+ICAgCWlm
IChyZXQpDQo+ID4gICAJCWdvdG8gcHJvdmlkZXJfZGVsOw0KPiA+DQo=
