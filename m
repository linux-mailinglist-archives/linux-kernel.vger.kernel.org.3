Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5534DD71E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiCRJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiCRJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:33:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA32E711A;
        Fri, 18 Mar 2022 02:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eItESntnBRy55RA2uoBnbajw1E+B/YDjyre9t01+bX4Ho2hZSKkA02UFV5KCGZBIoOKQkI0O2YiEWylIBBA8p2BNv0qgx1rq+LB+pZpQgWXo5s1dujUriXUFwH92zxEEnYdrEcbOzr/nPBDBXq9SNFM8jSjMulWvyiRAdg8DM2nHo3z+vIzHnLhjsMUAS7y0/NNYQ/QXh14Wm6m+QlYC1hy12icbgzRJjg3h+olr1jOP6N2VUh2GocDhpipaAj1ylzggayXgZe/OvRg7TGY99OXyLyUnsRFLiwTtTnfCKz0kTXmIGeECcoDwq3hDIqSEuAgp9aWN/pWc3KHHw6ZZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItfSCl9YGe9RPUyvygWdcqV48KRVqL8ge2IqHdTJPIY=;
 b=fxREDjURjYXEDYFryYCzTCjXnIXYWqIK/1Ojs+hIo87D0Cc8qNkeA28ofioTaw+LKbTQResMipndRC06spoTnIcRAOjwMgKA7YUkxnShxk/CMRtYXJDYTp8fP2NRYuaur313F4NSokujlgLYeC3GLk4ixqUtDVwtUSnzmpK/ohFS+eYK8NIPygZin9Lmt46LxRk7GeznueYD9Tkn1bmx6JHx6ExbJfBNawzl1DBHioQlUX5lz3E1yYDlv2mwqRWwnz+K8PWLWILy0pcVHOiZoRl8nU4LIMbuH8mWqXvPIf3ibPMrYC5kK/RUDjxThlDfU6DmHFFgwh/smJTporjahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItfSCl9YGe9RPUyvygWdcqV48KRVqL8ge2IqHdTJPIY=;
 b=QX7dvt+CWw9L7I9NqcNUqehM6GNtYrtJFyXrHYXDPeW0X4jzxPTGkNp3tg6kCmMuzBr3DNucSuE3OGgKsZVXRU8bADuQYiQ2Ce30A0YprQEQZcRblQGsRwiDYnjTx3wn1WzI5OGlBTOVl9IvdcOvK4MxRVxx+4ZnHDGVuiYBmWg+mGEgqMJIkrqWBW0qO1oqSnbdgV9zHoqtbchuBtU6vuUtfzwLVAWhq+EJvFE319R3FHRFkgFOU7Kd0HGy60gitZNOojfSJcR8CR1ChK7JoZohR99tk1Y7L3nJ+KZHKcYW8y+dSb13UtKj1+Nm3IVKBUrs6+yvvYO+VY949V08rw==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 KL1PR0601MB4066.apcprd06.prod.outlook.com (2603:1096:820:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 09:32:12 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::ac36:fcaf:45dc:f830%6]) with mapi id 15.20.5061.026; Fri, 18 Mar 2022
 09:32:11 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Topic: [PATCH v1] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Thread-Index: Adg6mrvEVaC9ZcljR92LSXIT/D+xfQACeyEAAAEAhEA=
Date:   Fri, 18 Mar 2022 09:32:11 +0000
Message-ID: <SG2PR06MB23150B3673E58737ABB08D51E6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315A7BAE2F1B384CDADB57FE6139@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <CACPK8XdYHb-PgVVQuTtMBokxu4GTObG7nCohm4dosK9XWzE9ow@mail.gmail.com>
In-Reply-To: <CACPK8XdYHb-PgVVQuTtMBokxu4GTObG7nCohm4dosK9XWzE9ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38ee700f-6098-47ad-7738-08da08c22e48
x-ms-traffictypediagnostic: KL1PR0601MB4066:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB406634DE398481072A966AC0E6139@KL1PR0601MB4066.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cX7vn5pahGuFGFgGpfaZ3GoXeXvNvdiZ4/ZjaP+/WFSryofZSHBo9xPRQVcCbEThVfpQrCwhuoNEBmFMYhWaPssaE/hYcpVIzWlwUeqoyV8k5RmAa+rjbDjNqsIurJ7Gm684OfQXY7psNZ8r/S0ttDtYDzrTR/l4a8LQS9t9JOulE+FTSekbag163YJEpu+xfdr8MKVC2a+zT4YwUfgz2WwpkRMeLAKSW7UbawT6w1u1bZ7SqW+WY0jXIfu9UxKxGRJjWRKW6vKMifHdyYd1wmrrueNXP0vGxCrdf7Y0/lG8NAA1u3yTlliuGQodatYAY47skla/J2DC0sOxn1OqYWrIvSeUf4RzAU0gwtP8xAKL7cwtAx/pjmknyNO5FBBv0Wq+WAQ3RipcwvI2sykmCB/uRVEazORzDV6IR/spoor2XQ3VEj20L5cgOClYObA3Z8M4az9+nWDbuWA91LDm5Kfv0dj3kitYeWmLviJoisJI45Lqi6C31sbZKWVpUDkYW5kGEGDLsSAVdWg1i1LjGbOBPlTfnuENo9UJ4bnGJhbKui7xdb2yr1TzLyzNJLBNBcKFX0aEQiwCW38VgAZRwBdSluws7S4bOweV1JrJaIwv1uWiywzN/76L5D56DDhXeGLNR8BpOAtnhdTOrkL8OFMOYSAi/WR8piXmnsd1cxAqSDO7Q1FLz4jlEbxbqhHYB1kf0dX6tMvHLybqr1ZuRKmf/XXGqJFzLX7anShfjFS5uaAkCL1pBKfW7VrayWbb3rcbgXBSmZRX16wmE5uGQDVf0kgk0cXrAf2P+Cx2mzgZbRedpityuGR74BPYBtpM5cCuRczBHN2acIBnkETWtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(366004)(136003)(346002)(39840400004)(64756008)(66446008)(76116006)(66556008)(66476007)(66946007)(4326008)(122000001)(8676002)(38100700002)(2906002)(83380400001)(6506007)(7696005)(53546011)(508600001)(9686003)(33656002)(55016003)(71200400001)(966005)(186003)(26005)(6916009)(5660300002)(54906003)(316002)(38070700005)(107886003)(86362001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEU5Tmx0eEE0Yjk5M1J3R1ppc3dUNUNYVzFRWlBoUTk3YUFTRjZBekpsODlm?=
 =?utf-8?B?RkI1QkdQU09jUW4vTWh3OTFCTEtjSFlDYlFLQ1FDNUZzcDkzN01CRlJlbVZO?=
 =?utf-8?B?NjE0eEtWSmZCazFiS3c5S1UzbHVDQ2xyVm05MStTTHB2d2F6TlZFYWhNN0FV?=
 =?utf-8?B?Qm9lcVBPWDBpMlMvUEdYbDhhcnBFWVdySy96MW5FSTBsVFdMbzFMR3BlSVlM?=
 =?utf-8?B?V1NzT0Jad0lkVWkrYWUxcVArVzZLbENWYmVMSzcxYXhWSFJmWnVZS0xKL01X?=
 =?utf-8?B?bTdCNCtvM1V6NXJqTSs2MWdhZ3I5bGQvRWYxS1UrT1RWaEJ3T1lCT0Jpd3lu?=
 =?utf-8?B?aWxkcjl4aGhsTmQrN1ZQbTBBRlBPdGlFOE9rczE1Q3dMTjVpWXZFRzN4azdS?=
 =?utf-8?B?YTFwY3RNRkJPYjhPYjdIazFxQ3V5cDZvcHJKMVJVU1E4TWF4N1VYSnoram01?=
 =?utf-8?B?amF5VzJ4eUpRR1lWZHVqQUd1M3BtN0wzVjNaNDB4aUt2c2UyeGdUS0dzUjZa?=
 =?utf-8?B?TWJRTExJZW9rSDloZTMvdFROYXkrcXhKTXdidjcrT0o3Z1BzYisrdzhmYkdG?=
 =?utf-8?B?RnpyLzZDZmRVUnVJVUp4bzE4RXY1K2F1WlFTWXZ6QzZDWHVSUU8zMkxoMElu?=
 =?utf-8?B?eWYrTTV4TW02bUpHOUJTeWJYRmlTc0dLUEFQbytzUVg2MGNSeSsySEhZTHhr?=
 =?utf-8?B?TWxJKzhpTjc5cnV2S2g1eXo4cXh6QTVQdXdFTzVhUStMQWIvWnROSzF5bEtm?=
 =?utf-8?B?Q1FGUXhiR3BMYTZSdDhlQ0I2RDlVWXg0cEFHM1cwN25QRkQrK3RkbWlnMkVV?=
 =?utf-8?B?T0ZoOCtYSWMyS2QxUW5MNHZYRWUraWs5K2NjWlgzTE8rU0lseHM1cmRmdmlJ?=
 =?utf-8?B?UGZJQjdKNEt4WVR5cGxPUmhpRk8xWGZVeXFZenFNSk1wL3pvUThXaFFqOUZ5?=
 =?utf-8?B?bjVKYm16eDNoMllxRm03UnNLVzZwblQ5dWliSG1kY0FGZE9IWUFRN1NNejBi?=
 =?utf-8?B?WmJ0ZklOeWJtWnk4Vkcxak9SOGlWdkp5dHlybVd5SUhwZXFyUU54SzBTS2Ry?=
 =?utf-8?B?YzQ4Ly8vM0tReSszL29LS0lyczN2VU84ZG5XSnd6MDYvb1hCUS9MYk55WTlI?=
 =?utf-8?B?bjdkT0tPaEx5MUdtSVlHVUtNMm1XbFA1NnlvQ25FUGIydkZuaHNyRmxMMGZr?=
 =?utf-8?B?bXh4eHAzT01DcHNLcnFEYStTQm5aUUduUXpRY3R6YTd0TlVQMjJPbWJVMjV3?=
 =?utf-8?B?ckdiK1YzNUR4ZlVJcHVMVkx4RThSeHpsU3dnR2ZLRzFXZzllSmgxL3JXK0Mx?=
 =?utf-8?B?cXhzeTJpcC9PUjA5Q2JadFNvanN5VG5McTBXcEdWcHFKR0NWYnlDUVZzREV6?=
 =?utf-8?B?bE9IbmVNVWczQ05KdFVIVytHbnM3NTkyWEJ0azYxVGtOeTdQUGhxSFl5TjhF?=
 =?utf-8?B?dmpaM282ZzhiREszN3RLV2xFeEtJeklSWEM1WWFSYlNXK0hIOEFqMGFocERZ?=
 =?utf-8?B?MEZVQVNCS1QwRnpHdDRLbUczUmxDd3d5bnNNbHlURFlnR1c0V1gxZ1E3S3hh?=
 =?utf-8?B?cFZPMWdwUEl5SnVXUldBbERiaGptYk81cm41emdCOE5rSWxxMTR0Q2lSQzJn?=
 =?utf-8?B?ZjNOU2xEZEp2czFqak52cUlrNVlEb0ZSYjk0Q3g4Y2ljenBqTXVmOEZJVFIx?=
 =?utf-8?B?SDhqbXJKUTNaWWhmTHNQQlA2MEhGNnpWTE92bENCNk1uUXRFWVZtbGVwdktq?=
 =?utf-8?B?Q1dpdDNXZUF1VGt6V1JoZEJoTTJTeVBjS2ovcXlWMkpxVzBsYmtKU1p3VlF6?=
 =?utf-8?B?VHNKODhMcHYxU3pNcURQSVY2UVFhMENhSWhtS3E5RlhuYUl5RFlKWUs2eWlN?=
 =?utf-8?B?RW5uZGlVZjd0Y1RKZ2VkeEpReHlHWlpMV0gwbE9wSXpmSHkwLzcwbWFSNlEy?=
 =?utf-8?B?S2lqUUdvSzkyRm5oYTZiV0ZkOHJhYXdYb2dTZUxHbDNMdWljVnVqaWc3Ujk0?=
 =?utf-8?B?emRuMnp1TnR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ee700f-6098-47ad-7738-08da08c22e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 09:32:11.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXmytYqzjlVvCtPrugXh3rzIrEPSeV2ZgiR4plj0ybqGcimw7ReDU/89t8OsE7yL6TUP0ngrBiV7IBmzDrBLdMbdP5MzsXCVxwIip7y3Bz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbA0KDQo+ID4gKyZzeXNjb24gew0KPiA+ICsgICAgICAgbWFjMC1jbGstZGVsYXkgPSA8
MHgxMCAweDBhDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAweDEwIDB4MTANCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTAgMHgxMD47DQo+IA0KPiBUaGVzZSBwcm9wZXJ0
aWVzIGFyZW4ndCBzdXBwb3J0ZWQgYnkgdGhlIG1haW5saW5lIGtlcm5lbC4gRG8geW91IGhhdmUg
c29tZQ0KPiBjb2RlIGNvbWluZyBmb3IgdGhhdCBzdXBwb3J0Pw0KTm8sIGNsay1hc3QyNjAwIGRp
ZCBub3Qgc3VwcG9ydCBpdCB5ZXQuDQpMZXQgbWUgcmVtb3ZlIHRoaXMgc2V0dGluZyBmb3Igbm93
IHNpbmNlIEkgY29uZmlybWVkIHRoYXQgdGhlIHBhdGNoIHdvdWxkbid0IGJlIHJlYWR5IHZlcnkg
c29vbi4NCkN1cnJlbnRseSwgdGhlIGRlbGF5IHdpbGwgYmUgc2V0IGF0IHUtYm9vdCBzdGFnZSB3
aXRoIGNvbW1pdCBmb3IgT3BlbkJNQyBodHRwczovL2dpdGh1Yi5jb20vb3BlbmJtYy91LWJvb3Qv
Y29tbWl0L2U0MGE0ZTQ0N2EwZTdmNGQ4YjM4YzMyNTYzNDllMzlmZjM3MDFmMWYNClNvIGl0IHNo
b3VsZCBiZSBzYWZlIGZvciBPcGVuQk1DIGlmIHRoaXMgcGFydCB3YXMgcmVtb3ZlZC4NCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxAam1z
LmlkLmF1Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4LCAyMDIyIDQ6NDYgUE0NCj4gVG86IEhv
d2FyZCBDaGl1IDxob3dhcmRfY2hpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgYW5kcmV3QGFqLmlkLmF1OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hc3BlZWRAbGlzdHMu
b3psYWJzLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVHJveSBMZWUgPHRy
b3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBBUk06IGR0
czogYXNwZWVkOiBhc3QyNjAwLWV2YjogRW5hYmxlIFJYIGRlbGF5IGZvcg0KPiBNQUMwL01BQzEN
Cj4gDQo+IEhpIEhvd2FyZCwNCj4gDQo+IE9uIEZyaSwgMTggTWFyIDIwMjIgYXQgMDg6MDksIEhv
d2FyZCBDaGl1IDxob3dhcmRfY2hpdUBhc3BlZWR0ZWNoLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4g
PiBTaW5jZSBtYWMwLzEgYW5kIG1hYzIvMyBhcmUgcGh5c2ljYWxseSBsb2NhdGVkIG9uIGRpZmZl
cmVudCBkaWUsIHRoZXkNCj4gPiBoYXZlIGRpZmZlcmVudCBwcm9wZXJ0aWVzIGJ5IG5hdHVyZSwg
d2hpY2ggaXMgbWFjMC8xIGhhcyBzbWFsbGVyIGRlbGF5IHN0ZXAuDQo+ID4NCj4gPiBUaGUgcHJv
cGVydHkgJ3BoeS1tb2RlJyBvbiBhc3QyNjAwIG1hYzAgYW5kIG1hYzEgaXMgcmVjb21tZW5kZWQg
dG8gc2V0DQo+IHRvICdyZ21paS1yeGlkJw0KPiA+IHdoaWNoIGVuYWJsZXMgdGhlIFJYIGludGVy
ZmFjZSBkZWxheSBmcm9tIHRoZSBQSFkgY2hpcC4NCj4gPiBSZWZlciBwYWdlIDQ1IG9mIFNESyBV
c2VyIEd1aWRlIHYwOC4wMA0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJN
Qy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOC4wMC9TRA0KPiBLDQo+ID4gX1VzZXJfR3Vp
ZGVfdjA4LjAwLnBkZg0KPiA+DQo+ID4gU2V0IG1hYyBkZWxheSBhY2NvcmRpbmcgdG8gdGhlIG1h
Y3Rlc3QgcmVzdWx0Lg0KPiANCj4gVGhpcyBiaXQgY29uZnVzZWQgbWUuIEhvdyBkb2VzIHRoZSBy
eGlkIHJlbGF0ZSB0byB0aGUgbWFjIGRlbGF5IG51bWJlcnM/DQo+IFdoaWNoIGRldmljZSBhbmQg
Y29kZSBpcyByZXNwb25zaWJsZSBmb3IgdXNpbmcgdGhlbT8NCj4gDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBIb3dhcmQgQ2hpdSA8aG93YXJkX2NoaXVAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMgfCAxOSArKysr
KysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2Fz
cGVlZC1hc3QyNjAwLWV2Yi5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1hc3Qy
NjAwLWV2Yi5kdHMNCj4gPiBpbmRleCBiN2ViNTUyNjQwY2IuLmRiMTZiYTMwN2U5NyAxMDA2NDQN
Cj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+ID4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWFzdDI2MDAtZXZiLmR0cw0KPiA+IEBAIC0x
MDMsNyArMTAzLDcgQEAgZXRocGh5MzogZXRoZXJuZXQtcGh5QDAgew0KPiA+ICAmbWFjMCB7DQo+
ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4NCj4gPiAtICAgICAgIHBoeS1tb2RlID0g
InJnbWlpIjsNCj4gPiArICAgICAgIHBoeS1tb2RlID0gInJnbWlpLXJ4aWQiOw0KPiA+ICAgICAg
ICAgcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+ID4NCj4gPiAgICAgICAgIHBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ID4gQEAgLTExNCw3ICsxMTQsNyBAQCAmbWFjMCB7DQo+ID4gICZt
YWMxIHsNCj4gPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPg0KPiA+IC0gICAgICAgcGh5
LW1vZGUgPSAicmdtaWkiOw0KPiA+ICsgICAgICAgcGh5LW1vZGUgPSAicmdtaWktcnhpZCI7DQo+
ID4gICAgICAgICBwaHktaGFuZGxlID0gPCZldGhwaHkxPjsNCj4gPg0KPiA+ICAgICAgICAgcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiBAQCAtMTQxLDYgKzE0MSwyMSBAQCAmbWFjMyB7
DQo+ID4gICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcmdtaWk0X2RlZmF1bHQ+OyAgfTsN
Cj4gPg0KPiA+ICsmc3lzY29uIHsNCj4gPiArICAgICAgIG1hYzAtY2xrLWRlbGF5ID0gPDB4MTAg
MHgwYQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgMHgxMCAweDEwDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAweDEwIDB4MTA+Ow0KPiANCj4gVGhlc2UgcHJvcGVydGllcyBh
cmVuJ3Qgc3VwcG9ydGVkIGJ5IHRoZSBtYWlubGluZSBrZXJuZWwuIERvIHlvdSBoYXZlIHNvbWUN
Cj4gY29kZSBjb21pbmcgZm9yIHRoYXQgc3VwcG9ydD8NCj4gDQo+ID4gKyAgICAgICBtYWMxLWNs
ay1kZWxheSA9IDwweDEwIDB4MGENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTAg
MHgxMA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgMHgxMCAweDEwPjsNCj4gPiArICAg
ICAgIG1hYzItY2xrLWRlbGF5ID0gPDB4MDggMHgwNA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgMHgwOCAweDA0DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAweDA4IDB4MDQ+
Ow0KPiA+ICsgICAgICAgbWFjMy1jbGstZGVsYXkgPSA8MHgwOCAweDA0DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAweDA4IDB4MDQNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
IDB4MDggMHgwND47DQo+ID4gK307DQo+ID4gKw0KPiA+ICAmZW1tY19jb250cm9sbGVyIHsNCj4g
PiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0K
PiA+DQo=
