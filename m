Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26AD4D0E20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbiCHCvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCHCvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:51:01 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA02936693;
        Mon,  7 Mar 2022 18:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbJs5bK4qQ5Ol0eVCVgDGAGlJh7sc31fPPt3Lz8+p1Ti2TZSWwqPSQ5ZPlt2r5CIS0BCgInoyHYU4TpdLOUyKRGMPqLxLl0pU0C+7Rpb2xiz3Cw9fiu64Y8RCE8kJSU4TAxJ5/oExwWedIYUXGg0urRJgZJu5n8CErFf86zmBwJ8YBTS4LZJc5Yx0JUE88TvZNZZ91hPtH/ZUB10gf6KDBkk6ePaSjaB1EfiXEwKSl/eo896BAEGvEQUlp1XObHI/LzmKE5161kSGkD7OG1LR6PfWpvu7TNup8M1hx7yocdFeGyEz3T/+dfhFEazpw/ROm/ZA77BsdbysQed77Vtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRmuV5DjyW8PjJCJY6T4DEmwlZBT7UTt9c0ZmRm62fs=;
 b=jMhqAStD1GLsO4lxpLDKw14liYjoqzYfihE8cwEMcyQTipsaPujHn3pdKUvqAJWj0eVDUAnqUayUO9i0uJy3X3xtnQ21kuAxesOKl3QkINmkwC7bX2bUJDPbumC1n7ivOOtZm8Dd3gO4jObkpEIlh1Om4GXWaVQ6koatwIzmuvYamYIdI1C+bCFTA6dAXjZkpiZ5SBZGkE2/00IdksOKgjTaHmPawzR4kDS3b2o1SKu27Z1oDuZ4DQTAgOhSf90a4u/K8myjexYIrAPP31vtSmtzj5W2nvDrwRBPPrMUmnzgCMkPmGtLhoDe+ijHeUFu+90YNbjwd48l3D85R6s7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRmuV5DjyW8PjJCJY6T4DEmwlZBT7UTt9c0ZmRm62fs=;
 b=du+Fl5E3tVKKtiTFDLa8ShuApOXylmkbPUlf7Ela+sL9F+GPbFcGFbOy/DT7iB5Hq9GU2p1GfI1Ive3M1L3uKG2FF9ATpNK3ezU/ug9NbDlYmQ4ASciOtTFPMt0gKiQMjYuZkNXWb2E3lR2MLiLdVru+HotB4K78kytjn8HDVkA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6095.eurprd04.prod.outlook.com (2603:10a6:803:f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 02:50:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 02:50:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH V6 4/5] mailbox: imx: support dual interrupts
Thread-Topic: [PATCH V6 4/5] mailbox: imx: support dual interrupts
Thread-Index: AQHYLdyPQfKmy/oJz02N4AXw9bkJway0ZTWAgABsvJA=
Date:   Tue, 8 Mar 2022 02:50:00 +0000
Message-ID: <DU0PR04MB9417F246679378E7AC71BB8E88099@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
 <20220302022522.1789588-5-peng.fan@oss.nxp.com>
 <CABb+yY0-fkRX7W2ju2C4HbrceM0pd-E8pAF53nABpuXZrd3XNg@mail.gmail.com>
In-Reply-To: <CABb+yY0-fkRX7W2ju2C4HbrceM0pd-E8pAF53nABpuXZrd3XNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5c0bfa-f3b1-4bf3-6bbf-08da00ae5707
x-ms-traffictypediagnostic: VI1PR04MB6095:EE_
x-microsoft-antispam-prvs: <VI1PR04MB6095196D980F0DDC9AB8296388099@VI1PR04MB6095.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUJpMoXNVdjhbDmwIttv/SmuLI/AwJiz+dtRfPqNJ/YQeGeGAVmyynVsiK03HRKf2rAqJhVVNxLOVz8gaw4aoE2WVj781ujVVk8Pp2XtQk7Ahu53KW0rUAeDHSulwdlDp1eIkgFVRVybruI+XjgyH8Umtqr7SrUe6ImOuznRby1GiJkrI+nWLF8SN5HGgKzpfOlGFc1GK0KZs+XnXtiknXORR+u+A1mXk41ji8xPS8OHvuIR82T/IxsKiUrl+4WoW1Vzuo4fvTHeZlI8arqDb3onh/b5CilmrTlvZne0qDsoRgeNE47UZKxoNs7OArAsFNc1l4SpUrKSuuoGoRKYvijxT7BXuUgQFbb2dXoumvnwa4rrIGmfZtZj0DScSTSnZ+6LM21KOeWLbp/9zEiygxic4MDXpKt7iC3eJpg1Bxu7haqta1bBfmmig3s7PUk4Ja/Be9rmzw2hBQDxMeIYCxyuQK7QBxwhwm/VFhbV2A7XD0jXynOuOZ3MI25QgyTV9ugFVsXS434a07ob3tFutmMycLP4hh7xjMiutFQlBKfY581LBmq2HzXexNp4MYoCjQh9+w/DnSYffrX2IoODHFCXwvB6XmDxpCootb7k6inWz9Ct7iKFme860+MPwzGRRwr3YSA7LR8MhAfcNiUWmZ3ecsgnORRk7mSr8YdSNwQb1CowH5JfzBTHsquT0IN37mU35t9H7i+c7GT3zzvdGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(66446008)(38070700005)(122000001)(71200400001)(66556008)(6506007)(8936002)(52536014)(54906003)(5660300002)(9686003)(83380400001)(110136005)(498600001)(7416002)(66946007)(15650500001)(64756008)(86362001)(26005)(7696005)(53546011)(55016003)(2906002)(186003)(38100700002)(33656002)(76116006)(4326008)(8676002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDkyVVgxSFJVWUZlSkJKT2szQnRpRVBZWWg1Qis2WERnV0sxdVpMNDhZUkZJ?=
 =?utf-8?B?SGJNeGFONU9nNEJzbGcvVGRzVDZNUk5YOThSTERjazVrNkRJNm9LVXFDdWdt?=
 =?utf-8?B?cDRvUUlKd0w1NTg2eFlCQ2hSZXM0QzA0aGtMY09JbkNoc3JxbG9WV1FiMzlq?=
 =?utf-8?B?TjNTVm00UHVxbTBHK0gyTmNRdXNjQXlTdGdSYmlickYra216ajh1VVduNEc1?=
 =?utf-8?B?ZDNSVEJZY1A1Nkx5cHNGZEducG5YUDJ6MWNEVEF4dDd5RCtBdzlxU3NSbXZE?=
 =?utf-8?B?R1RaYmJvNzFGNDZoQmg0T3g2dFVQb0Qvai9uYlV5aDUwUGtHUFBHT0cvMHB0?=
 =?utf-8?B?Z1dRSmU1VXJid2ROb3NDb0ZVYk5ITnhkc1h0QUh3VzFQaVg5MnB2dDFlcUpU?=
 =?utf-8?B?MmRBQ011R1Flakw4UlNlSEZTS3BWTjIvZDNSK01zaVhkK0hRRnYxVFBaYjht?=
 =?utf-8?B?aTZWZUNtdllVMEJkU3N4MmdUUU15SUJsN1dNdzdiRVRQcXVrNnN1UXlRZE1U?=
 =?utf-8?B?Tk94ejVOdHM2Z1l5eW1EZG9HdUcyMlFGTFJjM0NraTRURG13TG51TTNjMHlJ?=
 =?utf-8?B?S3o5MldnVjMrZlB2MkZKTnRVTGZxS09aKzZaZ1hubE1JcFBEWVRxbWpKZ1RJ?=
 =?utf-8?B?OWVRRElPck9UNHE3UytqQUJHanhRNk11OTNVWFZ2SmkxcDNNakEyS0ZmMXl4?=
 =?utf-8?B?Uno1cWRpZHE4blF6ZFp2dldydjliakVqK3NvbTBadzVyNythampqN0xMZGFp?=
 =?utf-8?B?SXZLTGMzREVZRW9pbHVrQXhFZGRYMlN6VkoxcXVpdGJ4TWJORlR4ODBVeTA3?=
 =?utf-8?B?alBaOG0yS25yY3JuOHVKQ0pYVmdQMkcyMmc2Z2xvSkNGZ2JhdmdINmppOEg0?=
 =?utf-8?B?N0xmOUJob0dEbTlrcks5MCtkcTNzeHBUZmhJR3RvNzRIeFRGT0VGbkU4Mm5I?=
 =?utf-8?B?QUN4amtld3hjNlB6eFBDbzFadVZhVFNlVkw3QmpmK01rSU03OHltdXNFKzJB?=
 =?utf-8?B?TE5VaXhIUFk5SnRDSFJ6TTFYamVmYWpKL2VxYk4wN0FaNFpjcUNud3h0V3ho?=
 =?utf-8?B?Q28xNkxSSGNDWWtkaVJyMFg0clo3R0NlYVEwRkRDd1AvY0Y5VXpQbnhpdzRu?=
 =?utf-8?B?REZmT25WVXVlWXo5Vk1qTktGOEVrV0FNR0JpejF3MTcvcS9IWVFQUzlVTzNJ?=
 =?utf-8?B?Q2JkZHhwZ1hFZlpnT0hEbDFHZ1pocDAvVzlxNnhtT0UwbmdDWTZlL0kyT3NN?=
 =?utf-8?B?b0hSN1ROT3gycFFoU0FvazJQZDNkcXBidlNHQ1BHckhGdDE1d01TeVR4OU0x?=
 =?utf-8?B?cFdBRlg3dkVOTEkzdER6cVhYSndGWnVOY2Z0VnRydVk1eStDWnVOM3ZiMk1W?=
 =?utf-8?B?RU01SkMzcVpjekswVStsVmQ0b3hLOUcvNUdEbHpQZGlVNkRRa3FFZThyYURa?=
 =?utf-8?B?NUJ2dWlRcEp4ZDhEZGZYL3RaeXgwdWpLM1h3T3dlSXdEUVd3bGxYSXI4VlNI?=
 =?utf-8?B?cUZyL1hLR2lBckhubHB0eitkVm1MdEhJaTk2alRxdm5zUlMvUFFmNDZKa1k0?=
 =?utf-8?B?RzNrcEtHY0RqNElkY3Q0bWpnY3NTOVZ1RnllakdpdkZhOEVtQ3ZienRQbk5x?=
 =?utf-8?B?OFIxbzNXb2F6c2M5Y0FYU28rclJPb2pYcThzcWlzUyt6Y3lHcnFYRXYwUDE1?=
 =?utf-8?B?U1BYUVBkVkhnRWxvVEZDYksxbUZ5cmhuNVdLckNveUk2a3NSUXpzNUwrQlpq?=
 =?utf-8?B?MmgzOU8yNC90TmRmVGFqYkZMRklaTlVwUVoyKzhld1k5S3RQaWIya0NoNUl1?=
 =?utf-8?B?UTRqbytiUGczdFVGdWRMcHZHei9OV1RiTlUxZGo5SVo4Vm82RzlQU3BwclBZ?=
 =?utf-8?B?MkJtRVVrVGVJc3M1NXg4QnFZb0VhWVhXNEo1WWpHWWlFeUs3NTUwS0tuTjl6?=
 =?utf-8?B?N252SnRwUkVmMmFPNHJTOGI5dlowNjAydnhFdC9GOG5VMHAyNytlVFNJdTQ4?=
 =?utf-8?B?N2w0VUpJRVc3cS9yTzNoczVNcXpxN0ZkRksvUzRkS2J6SzBrNFoxQXpjMFpm?=
 =?utf-8?B?RmEwckRnUktvUlhZSlNzSnI4Z0F6TW5rcTRKdjRqa3k4SEVldzE3Vkx3T2xR?=
 =?utf-8?B?ZTVhTXN0MFRBckszY293bnVZQWwyRE9lRTJhcEJjWVM3LzlzZTNTcitFbm9a?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5c0bfa-f3b1-4bf3-6bbf-08da00ae5707
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 02:50:00.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEYcjHT3DQ2S25eO4lVPeUXmcqCTvblKF82qJzfhDoTYrTngKVFDbulJHBeQ5k7dAMDnZyUFbPj/IheWwouAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDQvNV0gbWFpbGJveDogaW14OiBzdXBwb3J0IGR1YWwg
aW50ZXJydXB0cw0KPiANCj4gSGksDQo+IA0KPiBPbiBUdWUsIE1hciAxLCAyMDIyIGF0IDg6MjMg
UE0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaS5NWDkzIFM0
MDEgTVUgc3VwcG9ydCB0d28gaW50ZXJydXB0czogdHggZW1wdHkgYW5kIHJ4IGZ1bGwuDQo+ID4N
Cj4gPiAgLSBJbnRyb2R1Y2UgYSBuZXcgZmxhZyBJTVhfTVVfVjJfSVJRIGZvciB0aGUgZHVhbCBp
bnRlcnJ1cHQgY2FzZQ0KPiA+ICAtIFVwZGF0ZSBhdXRob3IgYW5kIENvcHlyaWdodA0KPiA+DQo+
IENvcHlyaWdodCB1cGRhdGUgaXMgZmFpci4NCj4gSG93ZXZlciwgSSBhbSBub3Qgc3VyZSBhZGRp
bmcgYW4gZXh0cmEgaW50ZXJydXB0IHdhcnJhbnRzIGNvLWF1dGhvcnNoaXAsDQo+IG90aGVyd2lz
ZSBwZW9wbGUgc3VibWl0IGZhciBiaWdnZXIgY2hhbmdlcyB0byBkcml2ZXJzLg0KDQpJIGp1c3Qg
dGhvdWdodCBJIGRpZCBsb3RzIG9mIGNoYW5nZXMgdG8gdGhpcyBkcml2ZXIgYW5kIGp1c3QgYWRk
IG15IGF1dGhvcnNoaXANCmhlcmUuIFRoYXQncyBmaW5lLCBJJ2xsIGRyb3AuDQoNCj4gQW5kIHlv
dSBkaWRuJ3QgZXZlbiBDQyB0aGUgb3JpZ2luYWwgYXV0aG9yIE9sZWtzaWogUmVtcGVsLiBBdCBs
ZWFzdCBwbGVhc2UNCj4gc2VlayBoaXMgQUNLLg0KDQpJIGp1c3QgdXNlIHNjcmlwdHMvZ2V0X21h
aW50YWluZXJzIHNjcmlwdCwgd2lsbCBhZGQgT2xla3Npai4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiBiL2RyaXZlcnMvbWFpbGJveC9p
bXgtbWFpbGJveC5jIGluZGV4IDAzNjk5ODQzYTZmZC4uNGJjNTlhNmNhZDIwDQo+ID4gMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2
ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiAuLi4uDQo+ID4NCj4gPiArLyogUGxlYXNlIG5v
dCBjaGFuZ2UgVFggJiBSWCAqLw0KPiA+ICBlbnVtIGlteF9tdV9jaGFuX3R5cGUgew0KPiA+ICAg
ICAgICAgSU1YX01VX1RZUEVfVFgsICAgICAgICAgLyogVHggKi8NCj4gPiAgICAgICAgIElNWF9N
VV9UWVBFX1JYLCAgICAgICAgIC8qIFJ4ICovDQo+ID4NCj4gWW91IHdhbnQgdG8gaGFyZC1jb2Rl
IHRoZSB2YWx1ZXMgdG8gbWFrZSBpdCBjbGVhcmVyDQo+ICAgICAgIElNWF9NVV9UWVBFX1RYID0g
MCwNCj4gICAgICAgSU1YX01VX1RZUEVfUlggPSAxLA0KPiANCj4gDQo+ID4gQEAgLTUzNiw3ICs1
MzksOCBAQCBzdGF0aWMgaW50IGlteF9tdV9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4p
DQo+ID4gew0KPiA+ICAgICAgICAgc3RydWN0IGlteF9tdV9wcml2ICpwcml2ID0gdG9faW14X211
X3ByaXYoY2hhbi0+bWJveCk7DQo+ID4gICAgICAgICBzdHJ1Y3QgaW14X211X2Nvbl9wcml2ICpj
cCA9IGNoYW4tPmNvbl9wcml2Ow0KPiA+IC0gICAgICAgdW5zaWduZWQgbG9uZyBpcnFfZmxhZyA9
IElSUUZfU0hBUkVEOw0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBpcnFfZmxhZyA9IDA7DQo+
ID4gKyAgICAgICBpbnQgaXJxOw0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPg0KPiA+ICAgICAg
ICAgcG1fcnVudGltZV9nZXRfc3luYyhwcml2LT5kZXYpOyBAQCAtNTUxLDExICs1NTUsMTYgQEAN
Cj4gc3RhdGljDQo+ID4gaW50IGlteF9tdV9zdGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4p
DQo+ID4gICAgICAgICBpZiAoIXByaXYtPmRldi0+cG1fZG9tYWluKQ0KPiA+ICAgICAgICAgICAg
ICAgICBpcnFfZmxhZyB8PSBJUlFGX05PX1NVU1BFTkQ7DQo+ID4NCj4gPiAtICAgICAgIHJldCA9
IHJlcXVlc3RfaXJxKHByaXYtPmlycVswXSwgaW14X211X2lzciwgaXJxX2ZsYWcsDQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICBjcC0+aXJxX2Rlc2MsIGNoYW4pOw0KPiA+ICsgICAgICAg
aWYgKHByaXYtPmRjZmctPnR5cGUgJiBJTVhfTVVfVjJfSVJRKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGlycSA9IHByaXYtPmlycVtjcC0+dHlwZV07DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+
ICsgICAgICAgICAgICAgICBpcnEgPSBwcml2LT5pcnFbMF07DQo+ID4NCj4gUGxlYXNlIHVzZSBz
b21lIHZlcmJvc2UgZGVmaW5lIGluc3RlYWQgb2YgdGhlIG1hZ2ljIDAuDQoNCkZpeCBpbiBWNy4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLg0K
