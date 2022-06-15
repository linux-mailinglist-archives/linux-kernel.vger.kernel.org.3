Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F854C4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbiFOJby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbiFOJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:31:51 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2121.outbound.protection.outlook.com [40.107.215.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251533367;
        Wed, 15 Jun 2022 02:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA8TLptFL7BU3epf3fCgXIW7XvbXn9qlyhg90UsfzhenTW/+bqg9XCz2ERXES29VL873lwzfwo8x1jKNLmbEuy74LiJ7dWOo1WZfaFCaOJFwEHl/uv9+HakJmNf7R2KtUAQq44DCFJVxaaLGC+5rYQ0G1IDgPH0SMzNk9bmP4WWk1DzDdTobvkTTP2c/X/apioyhrpY4uOVtzaCHfk9Z9+UhprFJlz0vQ77vfdVkDH+UzGYuLYGl2U/qei5OYULcp/aISqlBoGMrhY2Ym1BiKOxCbxjajR1CcauBTPnLf7J4kbPHww/6LRCZa1U8RssZerChAlsztm/xvxuzsQd1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmbOpd2zjV+QhHbaNz5Y0/xytOd8rA6/8cLiwDuD/pg=;
 b=UACLGUw9t5lg9YyFwQu75Ge4iFSWofzO4PUd0QCn1oZwb/jZQHdtFOeVXRmYZrduMPuWJ+GRNL6hLYY5oT/BAm7cu4l6QQN7c56nhC7027VEzbvbveSoFmBgNgem5sva77csyCRwtaRSFw2oqniSuDo5ZUzuXK0XrAETDzFOCMfLRUQ5G9hMRnFCrL0i30Lh51IVthFvpeLkX5mfEaQHvi37evJJkK9aUwtgu+OlIDcgsw/Xkjpa/JiDyPVJDK4XVpceEMeh7SG0MXlvsQKICawXHr3KSvPRWXaT9GJp3bb2ne/PsvjdHLcKnB/eW5Onf7TZ73BDIr+V0UQ3rjgyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmbOpd2zjV+QhHbaNz5Y0/xytOd8rA6/8cLiwDuD/pg=;
 b=zEiJI1iXr3qdjkMa6Rh0yswCUnhr7+SEaC4eaIYFIvm03V3kEVk3PTZ10mEejwIJmX9ZBO1eIdKLkY9zAgrgPJh8OaWbwPcfVGawedQXnzn4OXG6Ty9bvK46jntlCwCTng8j+cpcjh/ELkzS9X3TlQkz6wMV6H9WITs8tf1SOm8Z18CQi3DF8aR+L8B8k5FCKi4+jNXrCNooNatEHn+owNEbLF7+zR1Z7WDiqOtzwk8pWQLuCEmbq2+ZD73P17zKN/j2Awv26VQQ66RnLH2L7B5F1+SEuelGc3OEpgXZO4lmaZyXYPC3XBHPBd+BEIwxr0uxG7as2awky1RjJ63mCQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SI2PR06MB5115.apcprd06.prod.outlook.com (2603:1096:4:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Wed, 15 Jun
 2022 09:31:41 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 09:31:41 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] usb: gadget: ast2600: Fix a couple of spelling
 mistakes
Thread-Topic: [PATCH][next] usb: gadget: ast2600: Fix a couple of spelling
 mistakes
Thread-Index: AQHYgIp58fnXEOeJSk2h32htip4ysK1QNCsQ
Date:   Wed, 15 Jun 2022 09:31:41 +0000
Message-ID: <HK0PR06MB3202A6D92D8FD10CFE48F8E680AD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220615073518.192827-1-colin.i.king@gmail.com>
In-Reply-To: <20220615073518.192827-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a89cf79-7268-4656-1d6e-08da4eb1daf5
x-ms-traffictypediagnostic: SI2PR06MB5115:EE_
x-microsoft-antispam-prvs: <SI2PR06MB511550F808AD2A90092AE5AD80AD9@SI2PR06MB5115.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wb6h7TQlIU/X55PCEgJ/LUXDAX+YWVtg74sYb8fbduX9cy0isz1FOkxXSEJMLCqe/VbpHlwC2CUONlwOwu4u0LCdmESA/IUORgD5l85Nk/O5RIltJryPGf2uRGOfC66l6oVL0hwosBwwT+gnDTlPi82B00WLsNBTun/Y491wbntOOrxhwF+YuOBVVN5aMBSefR7zAB4VlSt/Svk7jp170ZRJCXGyghLram9LmbkZ3s1kkruqdNVU3+YZ9kx154/Fj4Eef5sdaD04k6F1zz/h42IBlQ4xziLJn0ldmZ9/72awdps3qQ/5NoX5emJaUcv7S3Q17obNaPbf45gvn1ZnSLJTabSusCZ7bvfqdzyUMeCDAa6E1GNcmhBAmE2wqZlsDv2orLz3edoICPj9lPr25Z7k+MHejYLKMJ0nHuJSggvY4ijl7cYNZhiqvGgeIJqa79e1tfrz0uCXsXPkvYrzOIc6/QOsrKgs+sCXHPQEAXujAUzOyNcm4zY8Z6Ztc34Qy1ISpElhNzdkMUSstq50e113LlsK3B7A8EB5caoLfD7uBGVQqfCiJ+gAVfj8wccrtLjKH6BxUzh2vplMDNsM7DgM+s4Fa3ZMwYIfHsPY01PrVu6U4zU+WhZUr5ffxsHzWl0nJcq7sl0CJ6Q2L68+89eyDgABsuAQRed8aexb1PnHiJ8D9J6ufl/7oU6Y0wIrUww6Dtk/TxjQ0lHNLjIHCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(366004)(396003)(346002)(136003)(66446008)(76116006)(8936002)(66946007)(66476007)(2906002)(64756008)(508600001)(86362001)(5660300002)(8676002)(122000001)(33656002)(52536014)(83380400001)(71200400001)(41300700001)(7696005)(55016003)(66556008)(4326008)(38070700005)(9686003)(54906003)(186003)(110136005)(26005)(6506007)(316002)(38100700002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJQZ0hWWGJRSjhxSTQ5M3h5REpvNU5LNEZkRGlmSWxJTzFrRjUvR3hmcEp6?=
 =?utf-8?B?cVJpZFFmU1QxTTJDWVJJRU1zQzJHVHROTldkRDFsUmVnQ3JxMVR3WVVyWjMx?=
 =?utf-8?B?UlhiY2NVbnpycDFQa3FCOU5WRUJOSnNHNUg3VTdSQ0gvTUdOTVV2U2hENWU4?=
 =?utf-8?B?dXd4Wmdnb3dlK3NKUk5ndS80MDJ3cTk5aVpGRFRwZzNENVBPUFhIVzlWMkxi?=
 =?utf-8?B?b3Y0SlluSjQ2cXdINW9tb05vTWg3bHF3M3BqVUpLRkNSM2VLTU56eldHQ3NH?=
 =?utf-8?B?cUh0OHFvclQzVWF3LzdISHJVU1FwV3pZVzRvZFVEZE9sMmEzcGlCQStKaXNk?=
 =?utf-8?B?T3Y1RUkvSkpiUDJSOTQrUjkvZGgxRkdpZ0JpZFFmQTk4R0hkQmRkaTJjYWMy?=
 =?utf-8?B?YzEwWFNXNkRzSGtsZ0RsbXpmMndiY2tmRlJCYUlueVJUd01rQlR5L3FZY0VE?=
 =?utf-8?B?QU1UcmJNa0gyQTdyWENCSXRZT0o3TE9DOGFvc2FMeUZlaTVWb21MOUdZRHo1?=
 =?utf-8?B?WHNKSzh1K0NMYjgyYWpGcy9ZRHZaYUdidE1yeUEyR2FLV204QTk3dUx6c3E5?=
 =?utf-8?B?dDJNdEN5YTFIdWpWaVRTUnFhZGhIQktlTTc1K1NWenBRVU5xRytZZXhRNzg0?=
 =?utf-8?B?TzE4VCtVZ0UxaEhwejQrVEYyeEJENmJja0JuTkJvWDdrSXQvYS80UCt1UE5k?=
 =?utf-8?B?T2trdm1VREQrZlZucmFPbmdVVHR6cXY0OFJ1OEsrV1pCZ0pJU2NYbHJadSs5?=
 =?utf-8?B?S1NzK05ZSjlNZmJnU1crNGRzbXpQWHFzUG0vV1VMNnlSN3M0c0JVSC95WkJm?=
 =?utf-8?B?Z05LNVhiWmJZZzhiSUpHTFE2ajU4ajBJL29hQ0kzL0dWN2ZrT2l4dlpWcWFs?=
 =?utf-8?B?REhncjFtUjBoNktVeGtRK1ZjOFZ6ZmVuMzFoVFY1d3lFL0YvMGpYaWlvei9J?=
 =?utf-8?B?bC9tZGVUZy92YjJNVXZPd2RteDQzeWMyRzJrYWNxVEExakFZZkRkd0xWR0VM?=
 =?utf-8?B?V2dtcjY4UXh6Y1htbHhqS2ZGeUc0RFhyZnEyd0lhWkVpS05reDdDUUo2Wlkr?=
 =?utf-8?B?eUhxRmFaaktRcFhKcjU4SG10ejlJeXhtZjIvbHFRYnJkblBpZzY5WDUrK2lD?=
 =?utf-8?B?bFFSamM3K0pzNEZyZVZxaWcwOTlMRFI3OTFCcHJZdFd5V29rRlp6bGxDa3Nn?=
 =?utf-8?B?bEtNcXgyeHh2TXJ6OHAyWWhrVWJqMUpjTU4vRFlzWFJzM1NtdUNiUWVVZVJX?=
 =?utf-8?B?anVYNDFvSC9TZGRLZDdKNHdhY1ZydTdmaXNxaEZKY2JQREtVMXpnamxCRGpR?=
 =?utf-8?B?RlV0MHplaHdWeW1hUDZacitIM05vMHR3U1U5aXl1UitHUTVHZEZlQnBETENI?=
 =?utf-8?B?cGRqU3R4VWlTTXUvUVViemhVbkNMVkxyUE9sMGdRbGVyVEs3ak9PYnlSclg4?=
 =?utf-8?B?c3AxRjBScjJiS1FYTDIvV3FVcWF3OU9qQlhBeGxFWG9wc1BxbjIwaE9UVS9W?=
 =?utf-8?B?MjdIelV1Wk5yNDdjUmlPcysxUEw4Njh5TkZlaGFrVVBSM1NaVkVrN2YwcVBn?=
 =?utf-8?B?YUtTSXc0bkZFbFFyUFQwb2Q0M3pMTWlCNXNhNG9xK0Exdmg2Q29KMFN0eEpD?=
 =?utf-8?B?WmJ4Zjc2MDdpYzhtQy8rbG92SGE3MGN4UnZUa3NVdzJOU25jSlI0eTJ5UEZi?=
 =?utf-8?B?Z3hRMG40TkYrd0JlcUFrQWU3NWYxWk5oMjJjZDI5cS9zR3p2UmRyeUxDeTRx?=
 =?utf-8?B?UmY0OXVMdjJjOGFvZzY0dkxEMmtBVm9CdTkwMlEvNHZZZ3dlb2FnSnNqcnd2?=
 =?utf-8?B?ZEtVNkQvWGs3ZzJ2WjE0UmJqdXVpMExJbzF0UW9vT0JLeGl6MUlpUDBQb2oz?=
 =?utf-8?B?dFlPeUw5Y3crRHR1SUxLK1BSMmNVbTJTNmJjbFQwbGJRL0wycGprSGhBV3BI?=
 =?utf-8?B?bXczWkZ2N1dMUXhXWmJ4c1htV003c2VQQ284SzcxU0lVQ05XNDZlV3RxbXVT?=
 =?utf-8?B?LzRjQ3RLQkhNRk1aTG91SFBiU0M5ZmFsMXB4Vjd5ZW9MQ1RZdURKdGpscFVp?=
 =?utf-8?B?a2hUcFNjcmVQUGJvcVM3WlJua0hPeXM2MDNZSnlaSHM1MWcxVHRJd0ZHVTQ4?=
 =?utf-8?B?TGV2Zmp6K2FVRDlNV3JvU1lNVjNGbDhyL3BuQm9uQ0c1dFg1YmZ2VzJNVXdI?=
 =?utf-8?B?aFpXSkh0azI3VzlHTTFTYm1TT0VSSm9xUHMyeHE2eUFkVXlSSHdwMTdtb3di?=
 =?utf-8?B?VC9Gc1pxZ0NJT25vMnh1WnZ4ajk3eFpFbVJZR1FpUm4vUlhKN3Y3TnVjYjhv?=
 =?utf-8?B?WU5qdkZ4ZFdsbVBicERaMklraE5lSzdaQmkxSGNxVjh3QkpSNkVjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a89cf79-7268-4656-1d6e-08da4eb1daf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 09:31:41.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pk60GgiPD/mDmiyH9dof5+8uWjaz4rv9pZSS+5VOWKAKOD1w1Z/vDR0o9NStuxvGUraRtqhxXGqf/qREWLKY7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGVyZSBhcmUgYSBjb3VwbGUgb2Ygc3BlbGxpbmcgbWlzdGFrZXMsIG9uZSBpbiBhIGRldl93
YXJuIG1lc3NhZ2UgYW5kDQo+IGFub3RoZXIgaW4gYSBTRVRVUF9EQkcgbWVzc2FnZS4gRml4IHRo
ZXNlIGFuZCByZW1vdmUgYW4gZXh0cmFuZW91cyB3aGl0ZQ0KPiBzcGFjZSB0b28uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT4NCg0K
QWNrZWQtYnk6IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNvbT4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkX3VkYy5jIHwgNCArKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkX3VkYy5jDQo+IGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9hc3BlZWRfdWRjLmMNCj4gaW5kZXggMWZjMTUyMjhmZjE1Li4wNWNmY2M0ODEy
YjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkX3VkYy5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXNwZWVkX3VkYy5jDQo+IEBAIC05MDQsNyAr
OTA0LDcgQEAgc3RhdGljIHZvaWQgYXN0X3VkY19lcG5faGFuZGxlX2Rlc2Moc3RydWN0DQo+IGFz
dF91ZGNfZGV2ICp1ZGMsIHUxNiBlcF9udW0pDQo+ICAJaW50IGk7DQo+IA0KPiAgCWlmIChsaXN0
X2VtcHR5KCZlcC0+cXVldWUpKSB7DQo+IC0JCWRldl93YXJuKGRldiwgIiVzIHJlcWVzdCBxdWV1
ZSBlbXB0eSAhXG4iLCBlcC0+ZXAubmFtZSk7DQo+ICsJCWRldl93YXJuKGRldiwgIiVzIHJlcXVl
c3QgcXVldWUgZW1wdHkhXG4iLCBlcC0+ZXAubmFtZSk7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+
IA0KPiBAQCAtMTAzNiw3ICsxMDM2LDcgQEAgc3RhdGljIHZvaWQgYXN0X3VkY19lcDBfaGFuZGxl
X3NldHVwKHN0cnVjdA0KPiBhc3RfdWRjX2RldiAqdWRjKQ0KPiANCj4gIAltZW1jcHlfZnJvbWlv
KCZjcnEsIHVkYy0+Y3JlcSwgc2l6ZW9mKGNycSkpOw0KPiANCj4gLQlTRVRVUF9EQkcodWRjLCAi
U0VURVVQIHBhY2tldDogJTAyeC8lMDJ4LyUwNHgvJTA0eC8lMDR4XG4iLA0KPiArCVNFVFVQX0RC
Ryh1ZGMsICJTRVRVUCBwYWNrZXQ6ICUwMngvJTAyeC8lMDR4LyUwNHgvJTA0eFxuIiwNCj4gIAkJ
ICBjcnEuYlJlcXVlc3RUeXBlLCBjcnEuYlJlcXVlc3QsIGxlMTZfdG9fY3B1KGNycS53VmFsdWUp
LA0KPiAgCQkgIGxlMTZfdG9fY3B1KGNycS53SW5kZXgpLCBsZTE2X3RvX2NwdShjcnEud0xlbmd0
aCkpOw0KPiANCj4gLS0NCj4gMi4zNS4zDQoNCg==
