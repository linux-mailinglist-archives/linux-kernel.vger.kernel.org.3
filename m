Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F454F6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381613AbiFQLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiFQLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:44:52 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120087.outbound.protection.outlook.com [40.107.12.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB76B0A8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr1WzLjyZqw5Qf+kRpQ9dtbxRQVwbAYxV7TSqb7+/wu2jgkxg6M6e0nQHfh/rbPssUj4Uf+YmR3cIFhJo9PalR61dzn7MI4W5r6vEwuYH8j5ba4qPY28YL3vRTHHlBz/3XTU24APLkbf9jdFZabIMz9RM/0/mj3X6aPmf+d7yfOL9AimD38gVWutLm9FBGhM9076ONI21SvnXIQr6i1pf+o7+UufYiq3bxxN6Faok2ICvtP4gwBTkVRsuY9AnxAUAxD6MDd7aE+DR8kh3M3TUT9+b6GSX0PjSHAYHZ2mfcz8tgo2uLO1o1G8JFTNQ0bkvvyGhWQ8uS9773Kz9XU3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33WvQ0ehKsrPnVPOHgPqRegWBwd8D9XWG+ABx7RHQRw=;
 b=fLVi8ha3l5r/dOHZm7fJ+VNQ92Q4YPVgBX4hooKkBBWoKxSyqV6hLCbyqcx7YJ4HLKG47zlTNFuSkhXJBnVyk3dYJQBDES28eI37r82PtoZHNfk+1vA0bmx9ZLjG6oUc47WQUbmbKV3E201XXH/wQLomKN1S6h7rnfjC61gboZU1BcZVFgVCrLYgDRg2JRyz2Izgsoiwgeh5lAM0V1Z5dSiXd55spu+29JNXZxkDAk2PDNzHpaT5UhY9WNfnlBtp2y2JpLmfE6Ul94/vzoXDkLMrIjdr4blUoeG2GWjmQaYfm4CDZwYGtvkpmD7PUVrpNBYlBoKq9UAHDPg3AhkEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33WvQ0ehKsrPnVPOHgPqRegWBwd8D9XWG+ABx7RHQRw=;
 b=kUZZ92mf4G3WPW4mnQ+yp+gEvDrqq3P5JaDkro+lh3b4TdL+daSgkmuEDUsy7iXOpFbaYtStfwy6sxB8sWAKSMuanUE/lWAWlClKlBpBJTi4nol/wCflv8+CAQFHDSvwE4HUvcS9eKIFdwIOQJIqUYuEOLLO77oNnc190QdMmgDSKeaPqz05whB+zKMq6teQW/8jlF9yabVKo4EUMwSSV4jRJwmQVFPKz5eO1CCatq9+gHLdNmc5HGcWZ6y0GPHNJwPSGCmF312Hb4qVnB6Vw5/NQv3TTeI788IuIzmt7XtC/EAVej2Sz4oRmCduYi1RGjuL7kmFW52rykojU/eGEA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3273.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 11:44:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 11:44:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Thread-Topic: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Thread-Index: AQHYgjzk3d7doRxJzUKF7+c6zTT4ua1TetEA
Date:   Fri, 17 Jun 2022 11:44:49 +0000
Message-ID: <5c759021-99ce-7633-699d-49b3229df339@csgroup.eu>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
In-Reply-To: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74b0c6bd-9cd9-4157-5cfb-08da5056c8c8
x-ms-traffictypediagnostic: PR0P264MB3273:EE_
x-microsoft-antispam-prvs: <PR0P264MB3273932E6601699B8BDA86E6EDAF9@PR0P264MB3273.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJvWHJ/zo45g8+ZzaIGe8u+C8fvla7jtJjE/Sqt4LrRLSs1z/D5wNtboTAlilQ6U/mOMBxvIfoDl9Y+QAy19Z90vN7L6wu67Wpc254eqLx99Jz1daI8plvI6xl3oF5CZrMN9NrM//L+h/y3Ml9byZI5Gb6FqI5YjRl2atn1cMeUB1/88VlNEd1iaks8rR9gkUMX/d9t7I+dDvNlv7SSNvKL7b1ZXZsiovRLgTwuVhZikkDtStfQLLjjbH1xWvWmgF6WdJrU3k6gispmLi8Rt80wAehkzMhBmfspCQvzeAL7Od19DFe7jZzBrNFKdvO29uGdebZ+3m1Dnotj709vuiaxOwR8ye2UrB5KNC3mXTc++eafZ4CG4Qwm5ZRBL9D1L7k02Xry0JHlq8/6f/VUImSIwqlda3+A6WNxSRllWwHD2gdV6lZytoEhZl51ecKWUCXdBgH4qI8hCISGrWQaJbQhb3bGyAgawy5xAIZ2O+cX5tjaGGousxe0YG076kZ12kS1HsX6ABpdDxteKqXmXcvryjoxB20MfjdCO8nZ/+T8zbAU2ktokvBj2/pyoObEN+tNYUaSGUHCYYyFZQ6c/ZP1jnhLogtZkzRsy/J1QKgifIkUYQrz+0YPuKFNqvlYnO7UsvrMYtzdZrgujUNQHSe9j26CoVZl/kzlHKn1C1XIFldfuUfHG1Vf4YFGHCLNx1OIx1gZA1wsKXF/XHBQJBsRTc5MrR0BZFMQlVYzRU1X0MZYY3b40wIU6GY8f45KJNd1wYmNMOi8cQv6w2xQVtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(54906003)(5660300002)(8936002)(6506007)(26005)(31686004)(6512007)(6486002)(36756003)(66446008)(2906002)(122000001)(83380400001)(316002)(110136005)(86362001)(76116006)(4744005)(71200400001)(2616005)(91956017)(4326008)(66556008)(31696002)(44832011)(66476007)(186003)(66946007)(64756008)(8676002)(38070700005)(498600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emIyNHdBL3Fvc2t2cTl5UkxoaDdYN2w4WWNSNm8xL0R5L3RkcEFTN0dFWmlu?=
 =?utf-8?B?dGFuTVlLS2RZOEdSYnpHYnBIVmlTenltMWRGTENXd05DMW5jV3JYUHdUdkdL?=
 =?utf-8?B?TjRGRjVOWWRycFRLRXFuQmt3eUhwQzZJenc2ZUhoM05uQytsMHN2Wm5CUEJB?=
 =?utf-8?B?NHhrc2lweWNJbFh0czF1TFNzTzZXdGxQRHUweENHbDVOY3dCZVR4UHU3MEwr?=
 =?utf-8?B?aTdtdUFGd0lyNFVPclYzYlB0eENoQ1B0QmN3VXRGaXdFM0c1VlhlMmQ2aEZT?=
 =?utf-8?B?TlhLS2RUTTZZRGUvb2U4a2lVWmtqOXhsRjRVOWUyQWZzZG1nb3QwSUNOejNF?=
 =?utf-8?B?aXBGQ1pXZHhYa3hXd3RXYU5nS3Q0TjVYV0dadk0yeVZxUEM3cldBejY1RnhR?=
 =?utf-8?B?dGdjaTBPUnl5ZUhoK3ByUU9wRlJmYWRwOVg5TklOM0liV1BnMytUcFdRU2Zz?=
 =?utf-8?B?OG9UQ214cXF0Y3JTMjNJVS9JeXpkb011Y2xXd1pRWVlBTm5ib2lkVUFQSmdw?=
 =?utf-8?B?WWJmaG1sc0ptQ0E4WXlFSjRrVWxHbDhMSU4xSVFpM0lIdGF6YUdGSlZBTjNY?=
 =?utf-8?B?Y1Y0NTJkMk9SMHFWNlI1eEhySS8wcDdWdXZjN0NFWS8yTjdJMzVRYzZmRmY0?=
 =?utf-8?B?cEgzaGtGUG9qQlpSSUVNSGgrSVR2Tyt1Z0VvODMvZ25heEN5bjhHbzdhTlRp?=
 =?utf-8?B?ZzJQcW90OUgvZWhCcVlxSEsyQ3RLeUowQ3lHVU5qSWxicUh6L1h3cTBlSTNV?=
 =?utf-8?B?QThZWHNDWVNnOUZTSWtlNzNCUDdsdXZqdDhSRExnZnBFOTVta3J4NW9aaXo0?=
 =?utf-8?B?ei9qRkRUWmM0UnhPaHdYdFdoWTVvT1JDL05HdXZ3REVjK2dYcHNhUGVnT3pW?=
 =?utf-8?B?Y3diVVNZYU0zL2s5Tm45UHpWd2VaZXVLc0JVNXRvVnV4N2NRaWhYa2tEY01s?=
 =?utf-8?B?anUvUFhFUjh4OU5COGpYOVhoZm5yVndoSlhwdFRTOGE0SVdzaFlqTm14U0E4?=
 =?utf-8?B?aUZzN3ZIRHpzNVQwYkJZWTMybFR6cVhRTnB2eFB2Y3RJbHlLWFN1VFJNaTJu?=
 =?utf-8?B?Y3JwWDE5bHFUK0NsRTFQT29lZUN3Q3MxdmQ3c3pXYmdvRHpPSzVnYmx0UDl4?=
 =?utf-8?B?RmszVldWVThEWWptWXNsL1F5TmlKQ1ZrKzF0SnFmc3ZWQmtVZWZrNlZ3bzBB?=
 =?utf-8?B?ckxvajhCUjZGZEh3UDBORWE4QldRR2h4Y3dYTWpScFhNdENTdFdrVEdxQnlo?=
 =?utf-8?B?RjF5M2FDSFQ1Mi93ZzJIdm9zR3JDclRGRmg0UDhiZUNkY3FQVlpwQXpsclI4?=
 =?utf-8?B?bDNIVzRrNUcwK3FkZFl5MFQ0Wk81QXlhUE95M2NnQytIZVVVbnpFS3NNQXN4?=
 =?utf-8?B?YkpuVGo0cFFUdGgzVG1tNFBvaVpSb25JeFhQTUY3OXhmb210WWtHdFdnTU9q?=
 =?utf-8?B?SmpwSzM4NEJCbXRyRmN6dk5ITGEwcXUrM1NaMENUUnBDUW8wdDZRSW00MzRy?=
 =?utf-8?B?dGg0WStTS1A3RmRnTXhCQzRoRHVLMVhWV25Fb3RpYWNYT1VkWDM4TnBIOHAr?=
 =?utf-8?B?ZHd4NjRGZDFjamhXUjZmbGpNYVg0eW8vdmRQQmJjL0srZytmRjRuRXcvdnFt?=
 =?utf-8?B?RWo4VWo3TjNEUzBmUkhBYVpYNVdLaXM0ckplM3hQaGlCaEVoRjlyL1phU2Zt?=
 =?utf-8?B?TTZQcEVrMnJwei9GN0lTdzFOQW0wTzJEOSt0NVc3R283dFFFNkhQSlE5VzF6?=
 =?utf-8?B?bEgzTUhIdkd3cDZtN2l0b3AzNTFPM3JEQmYxNjdWV2tuSmltY2ViNWN1UjNO?=
 =?utf-8?B?NG5wbGFHQ3dOSytvTzNJVm16Vi9WZExkWkJJS1JBRFJPcE0wTjdJZmV5WXBh?=
 =?utf-8?B?MzVPbWZ5ejg5aVFDVXVjUjFYWFY5TlBuVzNiWTlwdWoyb2lKaGdCQmNaVEJu?=
 =?utf-8?B?b25Bd0pnb095emFjWlhlYVhxaXZLcjltTnA3VW0yaEpPbzlZbXIxL0hPck5Y?=
 =?utf-8?B?cHVQSmVCZGNMczF5RkpXRFhQYlg2S0ZOUGxwbnJpbHB5RHdLMGxpNlg5Mjds?=
 =?utf-8?B?dW5uSXBNUjRFUFg0MUY1RkcwNmpTc2k3cVlncWRYb0hNUEZ6c1lLQ1o3KzJt?=
 =?utf-8?B?dE01VmFYdTUvRVBmK1B3ak51THlSSVQ5OUUwdkF0cVlaTGwzcEJqYWtyTnV2?=
 =?utf-8?B?QjB1RkdhbFZhWElaTTV2bnZVc1hmaFI0bzFrT1F5b1ltQmpWT0xzaDRScDFU?=
 =?utf-8?B?WlhFN2ZNUEUya3dPa1prTS83cjlzMGRaTnBnWU9oNHd6OUFCZVpWS0hRSGVn?=
 =?utf-8?B?RlpOMmhXNUl3Yjk1TjVITzBwZG5uZ0c4WHV2V00rUVVQQ2Q1eVlGMlpscU5x?=
 =?utf-8?Q?14MFE/DtvsiAvp2JlxI3ExdxhvPZ1A/cbenAJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C007EF0F26D5343AAB39CC51F91F33B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b0c6bd-9cd9-4157-5cfb-08da5056c8c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 11:44:49.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjvhlM/Tncou9WVqbqQvJPyCZKBxAzR1Mj7P9n+r6JwFYGGtcHXeKhdq2VfWByQsIUzAveGGEUBaZBhAFHWsPVX4DWAb0YZlT+p1qJ4yptA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3273
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzA2LzIwMjIgw6AgMTM6MjQsIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQo+
IA0KPiBIaSwNCj4gDQo+IEkgcmVjZW50bHkgbm90aWNlZCB0aGF0IF9fbWNvdW50X2xvYyBpcyA2
NGJpdCB3aWRlLCBjb250YWluaW5nIGFic29sdXRlDQo+IGFkZHJlc3Nlcy4gU2luY2UgX19tY291
bnRfbG9jIGlzIGEgcGVybWFuZW50IHNlY3Rpb24gKG5vdCBvbmUgd2UgZHJvcA0KPiBhZnRlciBi
b290KSwgdGhpcyBibG9hdHMgdGhlIGtlcm5lbCBtZW1vcnkgdXNhZ2UgZm9yIG5vIHJlYWwgcHVy
cG9zZS4NCg0KSSBndWVzcyB5b3UgbWVhbiBpdCBpcyA2NGJpdCB3aWRlIG9uIDY0IGJpdHMgYXJj
aGl0ZWN0dXJlcyA/IEJlY2F1c2UgaXQgDQpzZWVtcyB0byBiZSBkZWZpbmVkIGFzICdsb25nJyBz
byB3aWxsIGJlIDMyYml0IG9uIDMyIGJpdHMgYXJjaGl0ZWN0dXJlcyA/DQoNCkNocmlzdG9waGU=
