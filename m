Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980C560F74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiF3DRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3DRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:17:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB21186DC;
        Wed, 29 Jun 2022 20:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJl7cEhdxtPO3EgEY8MdHAYXEDVmD/yph0fZ8u5X5GSGuCZ2Pfsq1zPLvBuRU637YP9EtEMIsm0c7pp5PGRoh4Tp923VeuI3jZsAdSTyttUI55YptYs794Sqyl/5vVFNymylYKYZKE1Py5mbjUSbH7ShagfqYk8PMThAKxEi9DEAamcuyr+oRKxv8VkGWM6tRzaQ75E2s9/TIoc8oq+xwyiQcs6DHfaxP/KnRBD/w/0CKPfsRpG5a5+TC9R/p+1Z+HgxdBlKV6y/ttgnJQquWMPM8RyCSCABA0m7kIXFsbvKjmi83kAzhMcuNG2KJp4sN3LaRxO0HGQNBerkKW7feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYRMO5abdd4ZdkdEX7TXwqw1Hs8U2YkJaw2mEa4nyl0=;
 b=RGe+egyFsUQVBsZ97x0FDM4MFRHqlyXdjQKgl8Qn0awGrLZvO8nZVahbq78Cr2qOsXwFyDykAIFXVnRz05R1CYqkrkGb7bhDGXRYks3pRmPEsp/O+F3EW0hw1SiHfFXR3epdW35v05nZc9CCCcoUz+tdN4rrWxzTfhsoJ8KsBt/R/yL8zJf1uBI1fDxf46o+29fTthG4Eck1a4d33tGM5i4vd7lyMQKH+/NtZPh1w7mqkmAawOaXMfufGLwkeBHnWz/Qn6peR8SozGQS43SaD1KA95BaGOTl4TH/0C34unyMyNpORrcqKbhlPtzhG2/Xs1wwLnXzvAADWtwxth46hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYRMO5abdd4ZdkdEX7TXwqw1Hs8U2YkJaw2mEa4nyl0=;
 b=RkvfTpthCK76CGlYtrbidibLKezbyu0BRdMl1A5yQcyjlZ5i04ATvh2lndB+ZDsgFz2OZGzPLghOiZ01PhvGK9FbOlLxSnRdpNT9q6bflwV45tIRp4rvhCBax7+jaBvDOJnGv5ceyPqzCJJQOotGue6ry5Ard4e4W7geWmL2gXPdzIQLemkFRyV5LmgSS51FLgxcu6qXFdh18BMrL3512NU6SgSN4ft213pFfoBXJXDy+AT/xEP8jb6B3LIJfAP1yzhtE3FC8ijlSIEZsBK5Ljs3c+ojsir7gwJ7a0UG+l7uH+iCZiKxu3V+2/JXu7BosM8duxHC9lkHvkm/8jY7Kw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 03:17:05 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 03:17:05 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Thread-Topic: [PATCH v6 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE
 reset definition
Thread-Index: AQHYi5zbaZG1KB8jMkyqmWLIEIl0Mq1mRV0AgAEBVVA=
Date:   Thu, 30 Jun 2022 03:17:05 +0000
Message-ID: <HK0PR06MB3202B894962013238CB93B2880BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-3-neal_liu@aspeedtech.com>
 <c24d0e6d-d9ba-68c5-b1c8-13ad31d39ec8@linux.microsoft.com>
In-Reply-To: <c24d0e6d-d9ba-68c5-b1c8-13ad31d39ec8@linux.microsoft.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae2e420-ae83-4be6-6673-08da5a47027e
x-ms-traffictypediagnostic: SI2PR06MB5315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+BVlOqQPepoN4f9JzjS9WpYl9WLwfKTu3UIEU8otBLbpaGiousphDr4Qg1kzsZlb7IxVbBbHPsaJShtkbc2yBkVCNxJHJm+MxVumw9iAzRa5EeMCFbnBnjpQFNFTxm96riFUIUQORKSHewWvNj/42GGhD8lLiz9ZCot8rcBFLPQKfyC7tWA8ikHzMnJ1/Vcr2X1j2yVKyhpSHdGZx624HbE2PgFv3r0sJ5mkgeGVDWPgk9TGlQH2UT6nDkdJ0by+GchUgIJI3bRJHuJDVJXjIz/bFqkASeAnwcqcFlOKaKbhy+Mg2NS005Hdw8DMX3fRXkvh/0J63zxKnKSnMEJ36BujPQRWMy9eI3m6VzD2jpc3ZlM41zVzzSsQHYZPyVg7OWwZs9fWip9Tg0ia3e68FVjLwco5iwaJUCdN/6LaXFipg+Y4gS9OlaTuLyxvG8kb//EUJKnoUW8jkeErwierwd4qXNgh9CI3PY9m7GzCtKL4dCQV/zWkjSsaG6pE7IjfT7pNewxVhxD4iHLPy3u3+jIVmgwFp02gn72jxbdZweN+o3P5XSxxhf/AOTSS5JgfF7o9EWTHDTiRJQoCdPqGikfntlu1zTNW4ouLS0Q5GmiILzhMWx32IqYnKVVKys1UhZlomqrsgpmvHRiX/9Caw+2wwdFV7ZnYmtx6Un9coxT3NICj+BCykWmixEsvY88bNBZ2gP5/8kAmUnb9xVEcFG+FSJyZvIwKFP/+ARL+xdfjBgZDNO+addG+N1MnDbMXhhrqzRukIAm4Ub1PdVkMGod2GxEbViGLebJFUlTzdC8yL6JIlroTqYFIyus5JrH8KHaV36GWbtHf0dbn++UAQv5s/p8qoq2zbxbV2Y83aiO544xog6DxeC8Vt3dk+pa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(346002)(136003)(39840400004)(66946007)(186003)(7696005)(83380400001)(7416002)(38100700002)(86362001)(52536014)(8676002)(66556008)(2906002)(8936002)(66476007)(316002)(33656002)(64756008)(478600001)(54906003)(966005)(76116006)(38070700005)(53546011)(9686003)(55016003)(110136005)(122000001)(26005)(6636002)(6506007)(4326008)(66446008)(5660300002)(41300700001)(921005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWpoM0kzcWNLdk52cFJ2SHhGcGx5Rm9PcWx6OEthSzhOVEROWm1VYXVTKzZx?=
 =?utf-8?B?RExEWW9ycVloa0R2SWdaRncramFRdGh6enM1Ti85Q09nYzZrNThwOElmanlG?=
 =?utf-8?B?ZllvSDRWR2ppajRtUkR4WVBGVkdna0Vqd3M0cG1uT2VxcmtzNUY3aHkwZmNs?=
 =?utf-8?B?QThlanFwVk11V0xiMUhkM2dnbzFxWkl5MHNneCtCRVY3RFcwZzJEb2RWTE9R?=
 =?utf-8?B?Mm1WUVhuaHU3YzJsQW92eDMwVi9pK2lNVjdVbXdPb1pSSTVjM1BjTjlzVCs0?=
 =?utf-8?B?RU1Uc2ZYTVRHbVliQ0UxTEtRYi9jY28yVWtSUE5GbGdmV05jYzRwVEttcXpO?=
 =?utf-8?B?SmJYNy9JZDMwSTJKTU56VGtsTGtwSWZneGYvOHFETlFNM3dITUo2YjRxZG5v?=
 =?utf-8?B?SkZ2Z1dXc0EvUFdmVCthQ29Rd0h4NWQwUXljc1BEYkN6MzdoUDRaNXVCcTJS?=
 =?utf-8?B?Q3NNVkc3NnlDVXpqUng3cmZER2k3bHR1bVRRakRvVktZai9mbUdNbEo0Z3Bp?=
 =?utf-8?B?aGN2UFJVam9Va0pBMjd2aFVBMkxUNXM5dW5oazF6ZkxQZmpUVUNGZ1VuUlo2?=
 =?utf-8?B?WFFubW1TOGwvdWt1bUNjeURJRVFZR0QwdGQwUUg4UXJJYThkTG5zUVN2U2pn?=
 =?utf-8?B?ODEzOEkwczdXOEhkT3kxQWpzamJuek5JZ0JWZVJlRFIrbm45aTVDWnBlWnox?=
 =?utf-8?B?Njh4MHJsVXQ4QUVyU1Z0VGU4MnJpVXY0VFdHV1crbGJJK0pzUm1pbXovTm1H?=
 =?utf-8?B?Z3UrZ0FoUlEzMkl3T3NVYWVaMkhjdEp0a09XMnN5UHZKVnhTaXJoZnFTVHFG?=
 =?utf-8?B?UXRvbnlhNEpqQ3FTeHY5Tm5veEUrbk1oQVhEKy9hWXEzZzV5UStZamQ0OHJK?=
 =?utf-8?B?OVRPZHhZVHZjSUxhY1dMdGpkTnczZWFlYXYxZ1lJQzN3NWVwUlloMlpTTFNW?=
 =?utf-8?B?SnF3NnNBVWRkTWpkZDViNlVVREdwMzVzUjZLazkxOUtwWHM4ZVQ3cFBtbyt0?=
 =?utf-8?B?RUN2N3FGeVY4Mm04a2RPc1RKdGhqeHNyQ29tWTJRK1BJN2luS20xQno2NFU3?=
 =?utf-8?B?VUxNOHZvTnkrdXdzSzJFTFR0SDZhSDhxRGJ5QjVWaTkvbXBiSkVQbFhiNk8x?=
 =?utf-8?B?RzJlOExHOVBLOENCcmFPT2h5WnVIR3BYZ2dSbS8wSkRRZDg3MzFueTVIcWh4?=
 =?utf-8?B?TDZtUjZnZTg0cy9OZzdQUG5KUUY2VDNmUHByNDAvVzhNYmx4UkVYdEdWbUFn?=
 =?utf-8?B?aHRFVGUrQ2g2UnlubWV2TkFoQy90U014RStGbnNhMTU2MHRmK0psWVNxbHVZ?=
 =?utf-8?B?Z2FycHFHTHFXdVRDWC91WDhEVi81Q3lleVN0cWNBcHYvRWRuYU93VzlHMHNU?=
 =?utf-8?B?aGl4MGZGMWxwSlU1VkxPa0tUbXVqT2dVY2F0TW4xZFFSOURXZXF1TC9VdW1F?=
 =?utf-8?B?eGJKemlmellVd3hvTnkyOUlhYXpUMkk4MkhhYXJoQldHaVJCQzU3aytsd05i?=
 =?utf-8?B?RjNlR0djNEUzamk4NmZCcHlibjN0KzlKQjBudHJPSmFwVXhSZ3ZFMUlmbnMy?=
 =?utf-8?B?bklGR0lrL21FWGp3WkZ5QTV6YmwwbWc1Q0tGSGV3YWVoMVFaZ25UQUNZRjJF?=
 =?utf-8?B?RTZyNDJDMHpzc3NycnNHSXkrOUhsNmFFemNJazBlY203VUFJdU9BbTRhSUVx?=
 =?utf-8?B?VVNJSDNTR1oyMCt5WkNIbzMvNVU1VWozcm9QSmpwSklLazdIV2p0WFc1MXE1?=
 =?utf-8?B?UGhpL1ZvN3ZpTDJjU01IM0Fjdlo3bjdQK2xsck5TWTIyUEdGN1NjM082RDI3?=
 =?utf-8?B?d3AvNEtRZ2NtYzdNMUQ1bjMzRXlVSVpta3VvVlg5dzQ3djY4a2c5b0RvVGo4?=
 =?utf-8?B?VGsvQWRaclRCZDFzZkNHU3lPSnllUzFYa0JQNEZOck1ZS1BZejlCUjR4Sk1Q?=
 =?utf-8?B?N1FYNEJwMGovWnQxTkl5ZTZ2L0dXWUtIRE82dy9jRkwrbTZUSXJwRmJBaGxt?=
 =?utf-8?B?VFNTS3drTWl4ZVE5cnRNZVc1eDFwUlZ5cXh2cmtrRkF1cTYyZ2sxdU1mT1lQ?=
 =?utf-8?B?L0FwZHNUZ20rOUVpY2pRTSt5UTVLV3Jhb2JjNEtCdU9LdkxPcVpkUGdBOTdl?=
 =?utf-8?Q?/7vupj0Wf9M85a8+f9+egYzhm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae2e420-ae83-4be6-6673-08da5a47027e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 03:17:05.7050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skxbtTxFzjLUOtmsGIfD7KPG5IfUzQQP3PYR0yyMAJo1nZeQdZ3LNI3SSOX0efjHmMe1KWAAjAqPa0XzGhH3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEaGFuYW5qYXkgUGhhZGtlIDxk
cGhhZGtlQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyOSwg
MjAyMiA3OjUwIFBNDQo+IFRvOiBOZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5jb20+OyBD
b3JlbnRpbiBMYWJiZQ0KPiA8Y2xhYmJlLm1vbnRqb2llQGdtYWlsLmNvbT47IENocmlzdG9waGUg
SkFJTExFVA0KPiA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+OyBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47DQo+IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFw
YW5hLm9yZy5hdT47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBS
b2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgSm9lbCBTdGFubGV5IDxqb2VsQGpt
cy5pZC5hdT47DQo+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBEaGFuYW5qYXkg
UGhhZGtlDQo+IDxkaHBoYWRrZUBtaWNyb3NvZnQuY29tPjsgSm9obm55IEh1YW5nDQo+IDxqb2hu
bnlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IEJNQy1TVw0KPiA8Qk1DLVNXQGFzcGVl
ZHRlY2guY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtY3J5cHRv
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMi81XSBkdC1iaW5kaW5nczogY2xvY2s6IEFkZCBBU1Qy
NTAwL0FTVDI2MDAgSEFDRQ0KPiByZXNldCBkZWZpbml0aW9uDQo+IA0KPiBPbiA2LzI5LzIwMjIg
Mjo0NCBBTSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gQWRkIEhBQ0UgcmVzZXQgYml0IGRlZmluaXRp
b24gZm9yIEFTVDI1MDAvQVNUMjYwMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lYWwgTGl1
IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2hubnkgSHVh
bmcgPGpvaG5ueV9odWFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmggIHwgMSArDQo+ID4gICBpbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAtY2xvY2suaCB8IDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJp
bmRpbmdzL2Nsb2NrL2FzcGVlZC1jbG9jay5oDQo+ID4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Ns
b2NrL2FzcGVlZC1jbG9jay5oDQo+ID4gaW5kZXggOWZmNGY2ZTQ1NThjLi4wNmQ1NjgzODJjNzcg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hc3BlZWQtY2xvY2su
aA0KPiA+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLWNsb2NrLmgNCj4g
PiBAQCAtNTIsNSArNTIsNiBAQA0KPiA+ICAgI2RlZmluZSBBU1BFRURfUkVTRVRfSTJDCQk3DQo+
ID4gICAjZGVmaW5lIEFTUEVFRF9SRVNFVF9BSEIJCTgNCj4gPiAgICNkZWZpbmUgQVNQRUVEX1JF
U0VUX0NSVDEJCTkNCj4gPiArI2RlZmluZSBBU1BFRURfUkVTRVRfSEFDRQkJMTANCj4gDQo+IE5B
Sy4NCj4gDQo+IEkgcmVwbGllZCB0byBvbGRlciB2NSBvZiB0aGlzIHBhdGNoLCBidXQgdGhpcyB2
NiBhbHNvIGxvb2tzIGluY29ycmVjdCBhcyBwZXIgSFcNCj4gbWFudWFsLg0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIyMDYyOTAzMjAwOC4xNTc5ODk5
LTEtbmVhbF9saXUNCj4gQGFzcGVlZHRlY2guY29tL1QvI20wMDBiZDMzODhiM2U0MTExN2FhMGVl
ZjEwYmY2ZjhhNmEzYTg1Y2NlDQo+IA0KPiBGb3IgYm90aCBBU1QyNDAwIGFuZCBBU1QyNTAwOg0K
PiBTQ1UwNFsxMF0gPSBQRUNJLg0KPiANCj4gSXQgd2lsbCBiZSBiZXN0IHRvIHJlZmFjdG9yL3Nw
bGl0IGFzcGVlZC1jbG9jay5oIGludG8gc2VwYXJhdGUgZmlsZXMuDQoNCkhpLCBiYXNlZCBvbiBA
S3J6eXN6dG9mIG1lbnRpb25lZCwgY2hhbmdlIHRoZXNlIGRlZmluZSBpcyBub3QgYWxsb3dlZCBk
dWUgdG8gYnJlYWtpbmcgQUJJLg0KU28gYW5vdGhlciB3YXkgaXMgdG8gZGVmaW5lIGEgbmV3IHZh
bHVlKGludGVyZmFjZSksIGFuZCB3ZSBjYW4gY2hhbmdlIGRyaXZlcidzIGltcGxlbWVudGF0aW9u
Lg0KSSBrbm93IHRoaXMgaXMgbm90IGludHVpdGl2ZSB0byBoYXJkd2FyZSByZWdpc3RlcidzIHZh
bHVlLCBpdCBhbHNvIGNvbmZ1c2VkIG1lIGF0IHRoZSBmaXJzdCB0aW1lLg0KDQoNCg==
