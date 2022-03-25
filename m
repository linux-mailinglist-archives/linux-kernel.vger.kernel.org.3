Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98C4E6BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357283AbiCYB2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiCYB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:28:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50055.outbound.protection.outlook.com [40.107.5.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116B63B3;
        Thu, 24 Mar 2022 18:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBuCnK9BnhLsyenS+QZnt6gdylsuNjKtFY82AmWuTN3yllNzwFwEvKaD4LtjyreRkhFT78fOcEjm0IwRlvdhYYoNah00T/dPqVV21/74fUSt1BMnxbGgsf1K65jFTJ48GINE6D+B0DO/+B06972J0h7SXKQrh3VHNHceCNscwqHT1ByosH08SpcWMMkrpV3Dwsd7y/fXX+BR6YUmEHzfTXcV4M9uegvg/vh4hs1eJtgOkv9l5gqgrqg8d2iBi9XZSnNfWyKHudakcvHj0Vt462bQnysPB4DXT1m6VUnptOifJbdu95yydcy8OxEL9xOz3fxW+OfK+V4YkBE1OIkLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYinDMIv1/9dNvKAhX1dqZ65kXqGdeO+NePc9aQq3g4=;
 b=JTb4nQSd1RAmtPYbLE6tSaL8RbaSgbeQW/3L5iF+zjRiGGfBSyuaR5Utu9+qM3tmF8iVfRUmYF5WWptOiZEBTwWM7BQYpHns5s6GD12XCNAn4ko7sSGwqEgvzjLUK9RgJeNJgLORdIxhAjmz7w5h2rUlqQAqNNHv544TN4gXFVO51Ktm5EipfvlTnKFbSZoSZAavBDFo05EY1JeRJLLhOSpB+S4xZnrg5MPKLswZ4sNic5+hM7hsu8oP0fze+bAPXSW/SUBXvdTWM8lhIH0Bti6c+YMJ79lI3bV1ZWDjT60VIIH/DaGarofQZYp5g+QtegRNVNiaHXjmh/WQwHv/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYinDMIv1/9dNvKAhX1dqZ65kXqGdeO+NePc9aQq3g4=;
 b=p5iE08iRv6EzfyoZurDj6/mPzXimvV2Zl/POw85w+3GX7CQcbQuX0NgqCJo5WgeTu7bmPWxs1Uf9vEi3IiR8w0tyNKieYhP2JX/wg5tD9ZfhAPJQABZBQAqhgvN7IMg9cb/Uc8C50DOZF6QPLZcarjw/DQGW/Bs/C/tjVI2naiE=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB5821.eurprd04.prod.outlook.com (2603:10a6:803:e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 01:27:05 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 01:27:05 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using
 both of_alias_get_id and ida_simple_get
Thread-Index: AQHYPRZKKS2PkrWc90O+BIkrSaMZEqzPU+kQ
Date:   Fri, 25 Mar 2022 01:27:05 +0000
Message-ID: <AS8PR04MB84041B39303666AA30E90DD7921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220321112211.8895-1-sherry.sun@nxp.com>
In-Reply-To: <20220321112211.8895-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 608f97b2-cba2-480d-578a-08da0dfe928d
x-ms-traffictypediagnostic: VI1PR04MB5821:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5821B1EE371D86A4FBDDCCB6921A9@VI1PR04MB5821.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPv1dUTVEKTxt84geDEid8Z3NLyyTYTLj+P8lvf04qnKu64NmqAUUBq+WTaDFxnAlvJOTAyvRPy3rdEu4mNXFKfa78wWBqAJ14h78WbQmM+oNLZcUlr2FCSKegrqdTDxTJAUMPzdFvuK8IFmsKhY5uN70NFOQrWRIx+6Y7XT0Y4UrAsy+/O+S65Y6fIUAgEupZtBEIirtMApyxy0d4CMNrHd2IDZi15rZcH4LpmoQQB00QqqyFUixQtrmcfwCnNCJHePQGk9fm07Go6YleM1cXp9iTXdiwB1TBRU2vo/ORQEemPoYn7L5a18WkPxjUh1w1ZDueybTg74FgbtHbkVkZFU7jQ9V98wLoMVRRXbnKReUQ6aXz3GRqPdR9ALjBOSHUFFNZdu2qCO7fvtxPcL67kKfgY99Uo1HRzLcYvcA1VLaoWj8tcZUM6K+3dSWLPo44W+wrxNjhjFCjTjZM8cVt3QOsMATOE4kbKnLi1llJ8nRe5rB6HQj8xJw5oj6gfH7sV4seLEY+NL8luR5UEF6gsUusUCAlV5xzRsR8s8dLiWv5mfcF82Z+NLBzRnYwxlsayh44jqfahh0gtsFGYVQzENMVgw10MnP9oWhGmUlDQ4rtjV2kSw/aGKouH70uAi3l8FOoAEXz/h7u8lX0nbrAkijh8TW1dv+BHNHMAP8WEv3nFISuz0bXfVXrSHsiTkvoyJsc0NHylVyKg2h107gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(55016003)(186003)(26005)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(71200400001)(4326008)(110136005)(316002)(54906003)(8676002)(122000001)(6636002)(9686003)(2906002)(53546011)(508600001)(38070700005)(83380400001)(52536014)(8936002)(33656002)(5660300002)(6506007)(44832011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0tRcTFxajByNVczaUl5OHhXWFlqRVJwYzNqQlgxbVJlTW5NZTRvU0N5L1lB?=
 =?gb2312?B?d2puaEFYSGxrRmw2dEtjTmhiN1dkQW9HU3cwYW5Rc2FpR2doOTJzWGZJZU1B?=
 =?gb2312?B?R213THdXNG1CQmZjK0pJcjI0RmJlV0hJOFp1N2pFY1p5bWhhekRveko2V3I2?=
 =?gb2312?B?ejd6RDVXTHlpOTc4S21uVm4ybXk1OXZwR1ltUTd3dEZidzhKN1c5MnROWm9D?=
 =?gb2312?B?S2k2TGdYMG16MXFYTWIzWFFQK0FZeXBIUDJob2NmWmp1b0VmM1J0a0F2c01z?=
 =?gb2312?B?cjNoTVdXcHgwYzF4azJwcmdWdUw3R05uN1JFQk9IengyWUN4K3AxaTFrcm9w?=
 =?gb2312?B?Mmp4S1hrNlIrYi9qdHZ0QTl0cFI0THl2cloxWVdBUVhCck1zK3hja3VpVm4y?=
 =?gb2312?B?cXQrNW5vNWtHdU85SHRFRFg0d0loY0tQVjRVWFIzb3hyQ3NvZWt5Ykw4VDN1?=
 =?gb2312?B?ZmhZTlNxcWZ1ZTJIQWtHdjhibGxUSUJ5aHZLQUd4c0Q0dDVDcnBQbmdFU0lh?=
 =?gb2312?B?djlmeFl3eFpoUGxaU2h4UjNRRWZXdjd5K3A4QmtZWkk3UlY5SDVoUFlyTnF1?=
 =?gb2312?B?b2U1VXNnLy9aOC96YUZPR2xKR1NTNmRaNkM2YzZtT1d5c0grMlQybzJjaGpR?=
 =?gb2312?B?VTN6bzhhc0I2NUNQQVZvWE1qM2cvdENQVWE3aHExWExBenVWMGNBZVdXVUNK?=
 =?gb2312?B?czBsTlV5VE5Wdkw4aWFWeHliU2V2UGp1a2R1SnRsbm90M0pmQU4vWk4zTmhN?=
 =?gb2312?B?cUNqKzhVNUExT2xvOFp6VENFL3loaVQ0LzdYcEVyUkwxWTFkMzcvVzBUZnNo?=
 =?gb2312?B?TFAwSVlIWlBPZXBUR1B0RWszc1A5RnF4UXNENXdDSzZGOEVvS3cvcUhuUUpU?=
 =?gb2312?B?Z3NsaEpIOEpheVVwa2ExZ00yN3ZnOFF5TDVIcTBIWnVsdUFyQnFsSlRWQmRv?=
 =?gb2312?B?SDNZYWtXVlY4Wm5NbWNJZ09OTlBUN0pIcFlTK3B4ajVuUWNtTDNJWEphZmVQ?=
 =?gb2312?B?c1FheUswdGwzV2lrR2swdXBSQkpZSGFaSmJrTFJFTHhNVzhvWEJ3V0dJSmlF?=
 =?gb2312?B?cXpEWkNaZUNSTTlPODBxeUpZMEpYOG8vdzF6NzlNczZXR3RCZXUwbWlkRFUy?=
 =?gb2312?B?TGR1cUEwb1REbjdSMFN2K0tJUmxxVFhhbEhheVdYbXl3b2g1VWdhNGhnQzk0?=
 =?gb2312?B?NDlXUGJuTzVxbFIvblVEVEY4VHZvVmJSV2QzdUZITVpQeVE0N3k2OEl0Zkts?=
 =?gb2312?B?ZDBrTVlnK3IrY0dtWURUWVYrL3dGOXllaWprMUtQUUhPVm94WDAwSkFkczMv?=
 =?gb2312?B?WCtJMmY5OUVaYnlCQkRndnpxUjlPbEVsRDRTUzhzOG9BNFg2bUloRjN5bDNJ?=
 =?gb2312?B?YXpHZ0ovTEtDQnhUWnJiSmdtTGhKWTNCOVIwaVBnOVZBbWJrU2g1TDQ0NEpq?=
 =?gb2312?B?eDVKbWFvTXl5SDl3bENjYVN1NVU1UHlINDQrSHdSZWRFdEMxN1BPb0lYeHRV?=
 =?gb2312?B?SFExTFkwRnB3UC9PdXlsa081M2JScWsxNjJBd1ZWODZoZHVYME02STk1RWRn?=
 =?gb2312?B?M0VEZzkvcWhaVm1YZ2FVeUo5dms4TUhpN0RqNmhYakhVMTF6L3pIMVA2Q2Fq?=
 =?gb2312?B?RlRiRnJlcnlySVFnbDNXaGc2aGgrakQxNUdvYTM2bUZlUlpxREM5U21BVWE3?=
 =?gb2312?B?clhWYW5LL3V0TmdRb0tZbVlkaEFuNmdPZ3lvUTlabk9iWE9sWk03ZUpJMi8x?=
 =?gb2312?B?OXdwbExmR011Vk1zSWpad3BOTkFWOEtSK2FBNE9LMnFMYmF4Zy93U2tUMVB5?=
 =?gb2312?B?TEpTN0xwOFFOSkMxOEpyZWR0Zi9IZFNXZzF3YTNOQThYdVNjaTMxL3pIL0pU?=
 =?gb2312?B?aFdBODE0aWpaRDFyUS9aenlYSDAzSGE5dE91cTZmLzhFZ1RhdlVKNEhuWDBa?=
 =?gb2312?B?YkZ0aGJ2TWVLOTdTTm50U0ZRVFVNc1hzMHoyeHJvd3FRZzRIdlZmMDRUNXN5?=
 =?gb2312?B?aVpZUytUOVdUNDRLQ3lrREZhVnl1ajlwb1BOUzZZbmt3eVhRYTE2NlFudVpn?=
 =?gb2312?B?U25hM0p1bXZtVEtrK04yaXBJbnVEeWt4VXVmY08wZmVsMm5BUmtXYU9qWkx1?=
 =?gb2312?B?clRDYkVoUE1QQmZMVzRKZVU3eExNR1NnUEpqY3B6ZWl3R3U4YlRhUzdQZWdI?=
 =?gb2312?B?ZjZqR0xJbk52UGNOWHRHL1dBWkRTd2VKOHhCNGI5bHhrRFVzeE5uby9mdXZQ?=
 =?gb2312?B?OFlSYm5hTGlJajBEbGE0b0RlWUFKSXBkYmJ1R2c0NlorRUYrcWdNSUdYTWN0?=
 =?gb2312?Q?bsZUHKoHLpgDI4Nn8q?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f97b2-cba2-480d-578a-08da0dfe928d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 01:27:05.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jc3uYqIXZfv8cVrwj4HS5RSC9C21rm7OI4R2PbCQOHRUUKezu1+i8l5+E8fzXNEmMZxB0Mbh+zqUU1hFHJ23HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
aGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jPUwjIxyNUgMTk6MjUNCj4gVG86IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOyBqaXJpc2xhYnlAa2VybmVsLm9yZzsgVmFiaGF2IFNoYXJtYQ0KPiA8
dmFiaGF2LnNoYXJtYUBueHAuY29tPg0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDog
Zml4IHBvdGVudGlhbCBidWcgd2hlbiB1c2luZyBib3RoDQo+IG9mX2FsaWFzX2dldF9pZCBhbmQg
aWRhX3NpbXBsZV9nZXQNCj4gDQo+IE5vdyBmc2xfbHB1YXJ0IGRyaXZlciB1c2UgYm90aCBvZl9h
bGlhc19nZXRfaWQoKSBhbmQgaWRhX3NpbXBsZV9nZXQoKQ0KPiBpbiAucHJvYmUoKSwgd2hpY2gg
aGFzIHRoZSBwb3RlbnRpYWwgYnVnLiBGb3IgZXhhbXBsZSwgd2hlbiByZW1vdmUgdGhlDQo+IGxw
dWFydDcgYWxpYXMgaW4gZHRzLCBvZl9hbGlhc19nZXRfaWQoKSB3aWxsIHJldHVybiBlcnJvciwg
dGhlbiBjYWxsDQo+IGlkYV9zaW1wbGVfZ2V0KCkgdG8gYWxsb2NhdGUgdGhlIGlkIDAgZm9yIGxw
dWFydDcsIHRoaXMgbWF5IGNvbmZpbGN0IHdpdGggdGhlDQo+IGxwdWFydDQgd2hpY2ggaGFzIGFs
aWFzIDAuDQo+IA0KPiAgICAgYWxpYXNlcyB7DQo+IAkuLi4NCj4gICAgICAgICBzZXJpYWwwID0g
JmxwdWFydDQ7DQo+ICAgICAgICAgc2VyaWFsMSA9ICZscHVhcnQ1Ow0KPiAgICAgICAgIHNlcmlh
bDIgPSAmbHB1YXJ0NjsNCj4gICAgICAgICBzZXJpYWwzID0gJmxwdWFydDc7DQo+ICAgICB9DQo+
IA0KPiBTbyByZW1vdmUgdGhlIGlkYV9zaW1wbGVfZ2V0KCkgaW4gLnByb2JlKCksIHJldHVybiBh
biBlcnJvciBkaXJlY3RseSB3aGVuDQo+IGNhbGxpbmcgb2ZfYWxpYXNfZ2V0X2lkKCkgZmFpbHMs
IHdoaWNoIGlzIGNvbnNpc3RlbnQgd2l0aCBvdGhlciB1YXJ0IGRyaXZlcnMNCj4gYmVoYXZpb3Iu
DQo+IA0KPiBGaXhlczogM2JjMzIwNmUxYzBmICgic2VyaWFsOiBmc2xfbHB1YXJ0OiBSZW1vdmUg
dGhlIGFsaWFzIG5vZGUgZGVwZW5kZW5jZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4g
PHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jIHwgMjQgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVh
cnQuYw0KPiBpbmRleCA0NTJhMDE1ODI1YmEuLjQwNDY1ZDIzZDdhZCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jDQo+IEBAIC0yMzksOCArMjM5LDYgQEANCj4gIC8qIElNWCBscHVhcnQg
aGFzIGZvdXIgZXh0cmEgdW51c2VkIHJlZ3MgbG9jYXRlZCBhdCB0aGUgYmVnaW5uaW5nICovDQo+
ICAjZGVmaW5lIElNWF9SRUdfT0ZGCTB4MTANCj4gDQo+IC1zdGF0aWMgREVGSU5FX0lEQShmc2xf
bHB1YXJ0X2lkYSk7DQo+IC0NCj4gIGVudW0gbHB1YXJ0X3R5cGUgew0KPiAgCVZGNjEwX0xQVUFS
VCwNCj4gIAlMUzEwMjFBX0xQVUFSVCwNCj4gQEAgLTI3Niw3ICsyNzQsNiBAQCBzdHJ1Y3QgbHB1
YXJ0X3BvcnQgew0KPiAgCWludAkJCXJ4X2RtYV9ybmdfYnVmX2xlbjsNCj4gIAl1bnNpZ25lZCBp
bnQJCWRtYV90eF9uZW50czsNCj4gIAl3YWl0X3F1ZXVlX2hlYWRfdAlkbWFfd2FpdDsNCj4gLQli
b29sCQkJaWRfYWxsb2NhdGVkOw0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgbHB1YXJ0X3NvY19kYXRh
IHsNCj4gQEAgLTI3MTYsMjMgKzI3MTMsMTggQEAgc3RhdGljIGludCBscHVhcnRfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gDQo+ICAJcmV0ID0gb2ZfYWxpYXNfZ2V0
X2lkKG5wLCAic2VyaWFsIik7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gLQkJcmV0ID0gaWRhX3Np
bXBsZV9nZXQoJmZzbF9scHVhcnRfaWRhLCAwLCBVQVJUX05SLA0KPiBHRlBfS0VSTkVMKTsNCj4g
LQkJaWYgKHJldCA8IDApIHsNCj4gLQkJCWRldl9lcnIoJnBkZXYtPmRldiwgInBvcnQgbGluZSBp
cyBmdWxsLCBhZGQgZGV2aWNlDQo+IGZhaWxlZFxuIik7DQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAt
CQl9DQo+IC0JCXNwb3J0LT5pZF9hbGxvY2F0ZWQgPSB0cnVlOw0KPiArCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gZ2V0IGFsaWFzIGlkLCBlcnJubyAlZFxuIiwgcmV0KTsNCj4gKwkJ
cmV0dXJuIHJldDsNCj4gIAl9DQo+ICAJaWYgKHJldCA+PSBBUlJBWV9TSVpFKGxwdWFydF9wb3J0
cykpIHsNCj4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAic2VyaWFsJWQgb3V0IG9mIHJhbmdlXG4i
LCByZXQpOw0KPiAtCQlyZXQgPSAtRUlOVkFMOw0KPiAtCQlnb3RvIGZhaWxlZF9vdXRfb2ZfcmFu
Z2U7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0NCj4gIAlzcG9ydC0+cG9ydC5saW5lID0g
cmV0Ow0KPiANCj4gIAlyZXQgPSBscHVhcnRfZW5hYmxlX2Nsa3Moc3BvcnQpOw0KPiAgCWlmIChy
ZXQpDQo+IC0JCWdvdG8gZmFpbGVkX2Nsb2NrX2VuYWJsZTsNCj4gKwkJcmV0dXJuIHJldDsNCj4g
IAlzcG9ydC0+cG9ydC51YXJ0Y2xrID0gbHB1YXJ0X2dldF9iYXVkX2Nsa19yYXRlKHNwb3J0KTsN
Cj4gDQo+ICAJbHB1YXJ0X3BvcnRzW3Nwb3J0LT5wb3J0LmxpbmVdID0gc3BvcnQ7IEBAIC0yNzgx
LDEwICsyNzczLDYgQEANCj4gc3RhdGljIGludCBscHVhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIGZhaWxlZF9hdHRhY2hfcG9ydDoNCj4gIGZhaWxlZF9pcnFfcmVx
dWVzdDoNCj4gIAlscHVhcnRfZGlzYWJsZV9jbGtzKHNwb3J0KTsNCj4gLWZhaWxlZF9jbG9ja19l
bmFibGU6DQo+IC1mYWlsZWRfb3V0X29mX3JhbmdlOg0KPiAtCWlmIChzcG9ydC0+aWRfYWxsb2Nh
dGVkKQ0KPiAtCQlpZGFfc2ltcGxlX3JlbW92ZSgmZnNsX2xwdWFydF9pZGEsIHNwb3J0LT5wb3J0
LmxpbmUpOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiBAQCAtMjc5NCw5ICsyNzgyLDYg
QEAgc3RhdGljIGludCBscHVhcnRfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBk
ZXYpDQo+IA0KPiAgCXVhcnRfcmVtb3ZlX29uZV9wb3J0KCZscHVhcnRfcmVnLCAmc3BvcnQtPnBv
cnQpOw0KPiANCj4gLQlpZiAoc3BvcnQtPmlkX2FsbG9jYXRlZCkNCj4gLQkJaWRhX3NpbXBsZV9y
ZW1vdmUoJmZzbF9scHVhcnRfaWRhLCBzcG9ydC0+cG9ydC5saW5lKTsNCj4gLQ0KPiAgCWxwdWFy
dF9kaXNhYmxlX2Nsa3Moc3BvcnQpOw0KPiANCj4gIAlpZiAoc3BvcnQtPmRtYV90eF9jaGFuKQ0K
PiBAQCAtMjkyNiw3ICsyOTExLDYgQEAgc3RhdGljIGludCBfX2luaXQgbHB1YXJ0X3NlcmlhbF9p
bml0KHZvaWQpDQo+IA0KPiAgc3RhdGljIHZvaWQgX19leGl0IGxwdWFydF9zZXJpYWxfZXhpdCh2
b2lkKSAgew0KPiAtCWlkYV9kZXN0cm95KCZmc2xfbHB1YXJ0X2lkYSk7DQo+ICAJcGxhdGZvcm1f
ZHJpdmVyX3VucmVnaXN0ZXIoJmxwdWFydF9kcml2ZXIpOw0KPiAgCXVhcnRfdW5yZWdpc3Rlcl9k
cml2ZXIoJmxwdWFydF9yZWcpOw0KPiAgfQ0KPiAtLQ0KPiAyLjE3LjENCg0K
