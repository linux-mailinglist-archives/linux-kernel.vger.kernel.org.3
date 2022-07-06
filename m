Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4F56897F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiGFNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiGFNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:31:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E0240B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJrL14H17CaNQ1LE8Fwc5h+kvb++ywTr3VQ4AE3atjjt6gN08SjIQ4ZZts23VIURVCARm1h32hEC57BGWvIaG6fKJrq65w6Y5ORoRxYlz89qtaC/1kSLJSLVCXlgQX2IIqSCxQ/7JNqJ12v0gtOg+izvia5aWOMxAzm1SKzeG1jjRIwR5Mxx2eQ8nDhPhpJ4nUldsuWB0q0uyxxb3Ic27/cMc2PgngrnYPsV/q9xkCsq4IUGQPbOjKn1qwBow1sy6er84IkXF52l+I2R2hRO5cuPz3v3zyMsQvwycpH+8+7wSzqcyxmRQIkvCK0B0cg5i22Yc3e1UaJZS4i/qgLQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZHzaw6r5k3m6BUzHJg28uAQQ6yLzh5yCedpMsbtg9k=;
 b=GBECJQ4ffSltvYX7T7reEkKikb8MyV88h0q/eOQZAy482JLC6tJWcfvydUHF9ZRh8/GTnJE0HIx03syvTW3qukEp4trbPCzjVohJGO58oLhnhTEEhSyAAV5bRjv8sDKc08zlXfGqJioGaDMfJxCtYUqsJblhkDFTDaU/uVRJn56i8ggb05mZK7sQ+Gp+dVgfv05CVWv8B5Wq81S0ZqqT1rLbcsSABKGpaxEgQMZfR+NOXAm0Oop6/9M2QvKJpMtH20tKoioJNsiK1dzp455/U3viBA0sFvS6oWFclQfwyFA6+NcvC5mvbjwugS58boGllXP8OXBmEO8j+utqcvm0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZHzaw6r5k3m6BUzHJg28uAQQ6yLzh5yCedpMsbtg9k=;
 b=ko8QWXLsxIw+KJsKeIYS491WKWihsYZUZoEXH/Kbq4D/NB+W8y0L3Jp0ouPNhhvGM1P1fpffp2vI6ZPQziEqyu+lRqASnXrZed963BIakh/eW+gyx8HGjrPG/IVv3IRsM2loNdlukZ1HetXIp+Zp4AlnkmNycXcWK91BmpbCgDg=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by TY2PR01MB3625.jpnprd01.prod.outlook.com (2603:1096:404:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 13:31:10 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5417.015; Wed, 6 Jul 2022
 13:31:09 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: RE: [PATCH v4 1/2] mfd: da9062: enable being a
 system-power-controller
Thread-Topic: [PATCH v4 1/2] mfd: da9062: enable being a
 system-power-controller
Thread-Index: AQHYkTRTfAD+qtu6MEaJzI+8n2rDya1xVk9w
Date:   Wed, 6 Jul 2022 13:31:09 +0000
Message-ID: <OSAPR01MB5060C440ED0A20A219B4445EB0809@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <c6e19670802355222a228061f37aadace2764933.1657104160.git.helmut.grohne@intenta.de>
In-Reply-To: <c6e19670802355222a228061f37aadace2764933.1657104160.git.helmut.grohne@intenta.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4d09333-b01b-4e47-8cdf-08da5f53c9c0
x-ms-traffictypediagnostic: TY2PR01MB3625:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78PS1NexJkZruEjNjzQvJ8PMiiONSPFikawaUwdKJK/Oe1PlSSDEBtFhHopAtxIog03xdQRHEgU9rUgoaXJTvYI8riaigAeimSennr6oQlqmZn+g+WuAX4C1GYPdJRllziuZh9aF68LuefWhx6goa6zt/LtHXgHZBziAEwrnUKbW9vAGsUFIsBWQX4pLKXk3o/zKjNnmmfWSTkFZSYdvg4wbwmY6H7WYm4pctKyZZ0M/0x9d3lIDLx9p+9zf0QxI52KI+zMdYG0jwX2dO0OiFliTRCZTZQbCegEGvjJ9RInaFSwwXXJzSTjYA73uMUmmQe/ke4T8bmZ8umIBeiyf+XRzqwnNnG86Gm57Q1uFljxLz9tJ+AaRPNqUiSH6eqMNIHYAjB1ePBbKqgNq6SEObHmjGVvylW+yvTkMDEwfTYg+2LdYrwLlKyxpNXMqDBUXUj30a0O4R+GdrcFe3+z8lHtzUk6MEQC3K+6dInO1ilM3Yy00pTZAWq6FBZ2ANnIIRkyWmd5UBYRDoblKSHA4FNv9jZcQv0Ihwn6O8tHwtfbrop9navBsl7xq8GxFHhN6sKBKMppLzwgnyn9ml7lnmbeSSdpLj2GkmdQVwSpvKK8YmCguPfFslBnFAWfi4ef5oMZCC33XpN3Tb8V4jLECS4jApMqBQr2GRQQf9lqReflXb9KaeWitlKPRUYKAr14UKuRGCThxIx6AFmAlQDap9ZflPOXbYsexMVD+DE9zJ79AarzPdTRiDBbbNvuSx5ztvc4q2lpTIsv5XQ3QDxhncRrmE/7FuVa/Ue0eNg6FRxp2thdQjhlYRIk2mDODswnL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(2906002)(478600001)(26005)(9686003)(38100700002)(33656002)(186003)(122000001)(66556008)(8936002)(54906003)(4744005)(8676002)(5660300002)(110136005)(71200400001)(86362001)(316002)(55016003)(53546011)(7696005)(6506007)(41300700001)(38070700005)(52536014)(66446008)(66476007)(64756008)(66946007)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTB1UUZxSjFlNnBkVEFtMTVaWGwzMVhER1FQQzF1Q2Fma0VBZzFpN0FYL1Fw?=
 =?utf-8?B?U3VxWlB5TjE0b2pYSTliTzNYOVJtdXRRQ1ZaTmIveVNvNnZRUHBKdnRxcjRP?=
 =?utf-8?B?SjJUNVpYOWEyZCtMZ2JETVBPSlVGYVRvaVlVbW9NRW5DdjJoYVNEZUlidDdH?=
 =?utf-8?B?ZDRkWVVSTDhSNmN4ZktSUDFaUW04N2lzSU1nZ04vYkkwa0V3Z0tZckZKYkV5?=
 =?utf-8?B?YWNTdU14N0tDVnNKOCtaamwzci9Db2tneVVMZlBZam5EWmh1MnBHMlJuOGI3?=
 =?utf-8?B?MEswNGZxbzR3akdWVjF0OHdwZVRxb0g4WU53OXl6RG5VK1RQVUN0WXhzNVd4?=
 =?utf-8?B?OVpQRHI1aXUwUmpHMzVmME9FREdoR0M1b0ZYVFRoZnRaMmVwTUlVM25KVXhV?=
 =?utf-8?B?RGMrdVBWUzJqa3FCNlpzUmIyWlNDNTM1MTVkeTFaWUxjNER2RDhMM1JKVHM2?=
 =?utf-8?B?bnRWU0FMMWtiWG9oWXh1a0wxR3A2dGdZazIrZVJZSTVvV2JoWmJEWGlhc25v?=
 =?utf-8?B?Sm1wMDNSbFdKMmNrRzJrdTlRS1ZyUWpqYkN4VHB1TzJheTNDKzJJc0hRd1lO?=
 =?utf-8?B?QlNxOXVzNEE5S0ZKUTdVdXh4ZjVJYXNqN3BUWFdlUEJ0VE4vd2lUM211VjJy?=
 =?utf-8?B?RHZCczJGQ2ZBU25VbEFpQ3Z2cTJhVlFQMjQ3elZ1S0ZWTkVPZFRYb0RDRW5W?=
 =?utf-8?B?NDdsYTRYL1cvNkhHRWNhaFR3QzdNVUQwTFdGbnViTjZLOEg0UEFkZ0ZxWnRy?=
 =?utf-8?B?MWtyektXbkVpeWJaa3duOFE4eXNjaWFXc3BGWVNlTVYyTE0wbUhUUk1sMWZx?=
 =?utf-8?B?c0w0aXV1R2tOcElFM0NiTnNtUk9UYmlsWUNlMzJPLzFFbnVTVFBCQm16ckwx?=
 =?utf-8?B?NHZOcWJCeE4wTWpxVzlBaHZETnZONjF5YS9hU29kT3F1YVJjMzFwdlkrU01v?=
 =?utf-8?B?QTlSZzRpNk9LcDgrSTA1Y0xVRGhJMmx6YUpVTW52QWtGWU1qekNjaFBuYXpr?=
 =?utf-8?B?KzNmYU5la05heGE0TGZmUTdtT1BoRytGb1diRG90VVY0M2w0d1NQUVpCNXFk?=
 =?utf-8?B?TDlsMVNtZlVqNDlGYk9ZODlvVTJOSUtDeXFsYzVOaGNkcUp6UUlhbENDU29G?=
 =?utf-8?B?WXUyYklUamM4MHJXVXpkVlRpUEYwRzUvYVJydTJGQ0tEQkRQTENqV3NVZEdQ?=
 =?utf-8?B?TlZwVDF2OGRDMlRJV056eUhJMDBsTUJnRU96Vll4TnhyQTlWTGs1UFZDdTFF?=
 =?utf-8?B?Q0dSalZGVzYza0tteENRbVcveGV6T2NrVXVhdFVMU0FVNjBsaE54ZXlZU3Bk?=
 =?utf-8?B?QTlic080UGZkQzNpZ0tSQTZGYnptb3R6d0ROMHpCK0JHOUFsc3Exb29qMnI2?=
 =?utf-8?B?S1FBcmNkSlpFL1I5YjgxVmlxNzBYdXhJZ0Ryb2RXUjEwRmdSZVdPMlY2cVBL?=
 =?utf-8?B?WkUzNUdYZkdCancySUpLN3VhdlZWNy9NQjFhVWRxZVQ3Q21pYUxJWG1wWkNU?=
 =?utf-8?B?YVgzVXAwR3BkU2VTWHJuQ3Ria01ablZVQ3pBL2FGdDFQRkUzTUVseEdTVVVJ?=
 =?utf-8?B?cnJrdkx2cGJnamJYVThVQy9ETW1wRHl3ZFNTTWE5Y3czc01HZ3BJeXFBZHhE?=
 =?utf-8?B?TUJEQnR3NUNvNlM5dDYyK3d6cHIzYTU3Qk1kNThYYnZ3WklvOUEwYUlPWUkz?=
 =?utf-8?B?ZkFWcmJEMlZuYTI1SGZ2WnBvWnpySG5Dbmc0SVFFK0ZWUllIOEo2UzRXS3lo?=
 =?utf-8?B?dmlxT2hqczI1dTZwZCs3MU5rS0Q5eHFuTzAwYnRqUnpxNjcyN0UwekFiRkdq?=
 =?utf-8?B?VGtDUDZCc2E0Rzk1ZFdBMFhTZ2FDTTBSZkI4TWFwdHp3anVnaEkxTjlxQU9M?=
 =?utf-8?B?QXhsYWpNTmRFY0pjd2lVTUZxYytkcWkrMzZialBGVG8rbFoyM0lPUjU5eXk1?=
 =?utf-8?B?VkNXakNOZzRtRmR5RW40M2VVY3pFNjBMV0xYSjNGRHcvWWlYMkNhSHRpbU5l?=
 =?utf-8?B?RmVRcHlrMndzRVNCV3FPNlBFK2cvdUJ6b0FWRzYwS2RvNTVrTkU0dmdMVnhj?=
 =?utf-8?B?b29WTXdtUnF5U29EY21qVEpjcGNWclZFVXc3blpYQnhPZXpxbFkrWXRGdDcv?=
 =?utf-8?B?RTdBRlhKUGcvdUZ4SWUrcTZIc2ZBUkZtaDRiM0wrSU80R0NleWNLUTBCOHB3?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d09333-b01b-4e47-8cdf-08da5f53c9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 13:31:09.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJpZLy+7AyqSzeDtbEEhCMRnoy/2mlZA0ubYGmNdT3QmuYqGIfnSy2gIfV5u1HL2NePQO6f0pjE0+cIbS9eLcDXiFdORLf61wMnIMpnKsrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3625
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgSnVseSAyMDIyIDEzOjMwLCBIZWxtdXQgR3JvaG5lIHdyb3RlOg0KDQo+IFRoZSBEQTkw
NjIgY2FuIGJlIHRoZSBkZXZpY2UgdXNlZCB0byBwb3dlciB0aGUgQ1BVLiBJbiB0aGF0IGNhc2Us
IGl0IGNhbg0KPiBiZSB1c2VkIHRvIHBvd2VyIG9mZiB0aGUgc3lzdGVtLiBJbiB0aGUgQ09OVFJP
TF9BIHJlZ2lzdGVyLCB0aGUgTV8qX0VODQo+IGJpdHMgbXVzdCBiZSB6ZXJvIGZvciB0aGUgY29y
cmVzcG9uZGluZyAqX0VOIGJpdHMgdG8gaGF2ZSBhbiBlZmZlY3QuIFdlDQo+IHplcm8gdGhlbSBh
bGwgdG8gdHVybiBvZmYgdGhlIHN5c3RlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlbG11dCBH
cm9obmUgPGhlbG11dC5ncm9obmVAaW50ZW50YS5kZT4NCg0KUmV2aWV3ZWQtYnk6IEFkYW0gVGhv
bXNvbiA8RExHLUFkYW0uVGhvbXNvbi5PcGVuc291cmNlQGRtLnJlbmVzYXMuY29tPg0K
