Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A745511B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiFTHm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiFTHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:42:53 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120084.outbound.protection.outlook.com [40.107.12.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA841C7F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ247DHfRuxK02hoUEhWvnpcMZ8lnA1n5ffpuz5HBCIt3JUxVlPM7pJtchwQlh/yfob2A0h3KNuTevfMZjBJvrzWEkHjzG3C+FwN9DBqBcKq5Qk1KUms9C975JXQ6c5dIh6pVTLt8ziptTZA7KYDnPt12onzJHHsxybX+yaWIyH02P3S2WbpR82z9QqYAIh8ph3je2ke1nwQPffBaJcNzi+rVBZvWw2epMD/jpWvC1nV/Muf9e6aiWmyOOkNMksGTBJnrJID0vDRgLt+6HSXmxb7GBD3dU1czvkgmak2H1UHONokXEIPAkvtD5Zh3ADiro4CkaT3BuvAqYr79JhUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrjxiZGkcnGcV9zwRNNQpmCfEV8X6Cp2/aXt4aX4tpM=;
 b=TTaM1jUz3E31VHG6tpfknSwvHqLBRv0AzYcHBWuzRsHtMGQjbJdKpyrKbmiTpKqQn5UdIbSWoWeNKwubLWH3oQC4ZL0e7Nx+/ouCKQJeizXrBK5XttbNIee37h9mpny37u5gSqFuizBXzEuOE7y9p54jBOTzMrl490A1gbIk+yZf2xZyTOPQw89AEkf/Lq5i9ZAKdxJtMO7gG8gmyg8N1l85SP366WgAxfsPDxkgqMucwT8Zs4N/FhNGhbLdtyuq+zccTPsIf9Qbbks6fPrWC7FntWEFGT+jSAvYA7FLWbJdSYGCv9lOXe6oSe10BIec/hT9sUMlcYOLwlkv13zufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrjxiZGkcnGcV9zwRNNQpmCfEV8X6Cp2/aXt4aX4tpM=;
 b=X8fEiIdFnO1sjM7FkoEmvtMmGIFMD3X16gwmbdeykzXAOvVTkcxaWbnaCpvW2Im6+9RRfGF/nOfo6AS98n0+Sdf9JDlvy8l0ZmG/a3LUczDxXdglvl9cYKJ5/U4/cHmQVqJtM76sBUfW7o26CBLe2xVYiz6fN1cwe5CZGkbqf0hNMES/t+gTliox7C+W3zw+ATfxW8rSKp2dQXx6MgoCj5U5xv3TE1+14TbhtIrEwvFsQx+ABfpvG2UpzbP+IIeCThQ1mV1ESJx4W89aALHZ2dtGDmo7nmYfcsOKyYPuBKHgzPuIP3ok5AN6Tl+h/IzG0mJSnUU98gbaNJ3+2q0SoQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3356.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 07:42:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 07:42:48 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Thread-Topic: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Thread-Index: AQHYgjzk3d7doRxJzUKF7+c6zTT4ua1UCHEAgAPjqwCAAAIVgA==
Date:   Mon, 20 Jun 2022 07:42:48 +0000
Message-ID: <6b80d984-1f81-0d34-1b28-73c64ad15910@csgroup.eu>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
 <20220617201142.yea5ze7od43fat4o@treble>
 <YrAjOHDrkXQPLv+6@hirez.programming.kicks-ass.net>
In-Reply-To: <YrAjOHDrkXQPLv+6@hirez.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99738d1b-46dc-42f8-125e-08da52907938
x-ms-traffictypediagnostic: PR0P264MB3356:EE_
x-microsoft-antispam-prvs: <PR0P264MB33560A4F132674030390B778EDB09@PR0P264MB3356.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZx8+3U0m/8KDnzaQqjtEDpHh+tWjLXJ8WfNo8J2X3QTpYtGGu7ozI8dDb9AsAFsD0SbU4wn1tKUf+2vYXmzjQVRuRbc9+KEKsYa490A7Qf2yzkmsI/91sC7cVKbT0mCSLRHYwoa8L7jJEwShhqBFEWdbKJlLejYL75mVRZl8es1KmH8A5gXXlhId8HvJshBj1njxkBOYS/6srtOsj59E/edRyrRpIgYsorMhnWllgaQ/6whMCtAqaohf/rO4s26JcooCG/jlNR9BgTI8ZbosMMt9l82MeicfuLlOE/1rjSD/I9/x6atg/U82qY2RGTnLTwcYIwvy/rmx2Yz+qDUQ7qvZuksf8skZddPok8iD7KFa5sZqtBChEv4CqdN3T9fmliCCpQgAOKLvjl3qjKM/6KemtNy0To0k1/qf7JbnDDnAGi+m7Mg8BSlcQTLMwScgJFvkadpdMM1wlrHUxtysjYOFVEGUWKAe+1PiilH0O827y2L1w0WSAmwjENf42JC7akbpQhLnY9AWQBOkz0ydhxMqbxOwI6Qw11PQFE2s5kCaCL9i6p5DKeYya4gkeIGESqc63ZZnm+GqhoCkZ5cET2lo+gLdQK6uWDYDQu74iuMcxe77FjWDzKoieus5qC0+U1b8vN0cPTKgc9eNb6IeOfxYz9QnCjqghnis2oCO9uohG0zhlu6SNJBxpYW1nTRv/xXHPJQ2gPitd7mAXQb9vOaj5M3tg7R/T/YK9P33bmE9G82fgdZSWTxfKtsiQ85/cnjnq+2d9IhTaMb9eGW3R5I6iBQhv/Mkqcb8zwqLe8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38070700005)(186003)(31686004)(36756003)(8676002)(4326008)(66556008)(64756008)(66946007)(66476007)(6512007)(26005)(5660300002)(91956017)(66446008)(66574015)(76116006)(6506007)(31696002)(110136005)(2906002)(38100700002)(44832011)(71200400001)(54906003)(122000001)(86362001)(83380400001)(316002)(6486002)(8936002)(498600001)(2616005)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aS9OUitBb0RkVmgySzBrVEhhQS82UmV1Rk9xbmRsTjRwcDVHR0dEMVptT0NK?=
 =?utf-8?B?Uk1GdFJndTlTdjlHU29DL09MdlRieVg5U29yR0dmZWNCZCtFSmVKTnNoczZJ?=
 =?utf-8?B?L1p1SEpadW4wUmNnMGRTSzg5SWgvVWZnc1p1dm9PNTVuUFNGeFB4ajdIeUh5?=
 =?utf-8?B?aUJPTm5NSk9vUkJqTmNWb3dzcGhKZ3ByOTJvdXZkMjVBY01kUVpOUkY5RkRC?=
 =?utf-8?B?VVZFK3RMbXRmTHdITUY2MUk1YUMzZzdwTWFJZkF2QWpVUFRFU1V6RVUxOVNU?=
 =?utf-8?B?SHdBM09vZ28weTV3MDVOdDVyZ05vbkxyUE96SUxBV2kxZHNCK0RlWGhnMDhM?=
 =?utf-8?B?MHRBSzI1WE5Vbk9ibThtSzNHS2ZTbERUWmZNSjJzTWF5Z2dDaXBRckdsWjJx?=
 =?utf-8?B?RCtHeUprMFhzVURHdVVDV1RwY2JhTjZOY0E2MXJTaytzTDlabXdlcUxWSGZq?=
 =?utf-8?B?ZWRnREp1SWFBZWVvb2JmYzFJUDJRRDgyTHBWQUJQd1N0Q1ozREkzeVZHajdD?=
 =?utf-8?B?RUREZ1Boajd1Q3B5K2pzK1daR2RSREZPbHQ5M1VqbnZmblE0UG1GRVM2Y1Ji?=
 =?utf-8?B?alc3bjNVNmI0V0JWOXlBM1RtZmhaVG1QYVBTMW9xVVVuNytWU0tCb1hGSXd5?=
 =?utf-8?B?alZvclZTcDRVOXRUOWczN2JPTGw5Q0ptZG1BNW9EQ3IvZmdFK2lWV3FrMUJy?=
 =?utf-8?B?Q2drTC9MekJZUXdjMjJYLy9qOE1lRlhjd1JzSVZ6U2xDZ0U0WitHRkhkWStt?=
 =?utf-8?B?OUsxMnc2akJkZnExdDJHRGRHb0VLenNpQ0pyQTc1Z0tIR3JWRXJzSnhsUWF2?=
 =?utf-8?B?Q0hxelp5WDlpZ1AreGt6aytPeFFCQXo3ME9PRHgxS1RqOWpxYXQxZ3lFcWNK?=
 =?utf-8?B?bDl5QWcwb1F1OUxUa2hBdVI0c3JYZy9zWHVjYkpQTzB2Mk5zZjBXTVdFWEVj?=
 =?utf-8?B?bmh0Y09jMmk0Q3pvQnFRUnU5SG9TendHTTBRMXpiODV6ano0QWI2R3ExQkZC?=
 =?utf-8?B?Ymhha3lQWlBjMkZRMXhZR1ozdzZkdi9HNE1qL0wzamNYTWRFSjJxbWRSYXBL?=
 =?utf-8?B?REhJeWZ4NkpnMjhhbXg3VkVxNGxhbjZLb2RzclJnYlloWDh4ZkQ0ZTd2cXIw?=
 =?utf-8?B?ZGl5VER2Tjk0N3o2ZUk5SWp1eHFjSkFFNi9KeGdwdUZnRmoweHhFcndZS3RO?=
 =?utf-8?B?Tm9PTVlTejB6MFBUUkN5U3krUHZLN2U5YkJQYVJ5eWhGUW56VXNVZG9kYUdI?=
 =?utf-8?B?YjQ2Skt5UStWb3hIV1JGQXUrMXZXdkkvUlRqcGhXTmIrM2QxN09MVExQMmRv?=
 =?utf-8?B?VnJ6SCthQkQyOHVDZXVteEw5VXdubmxvMnpmbllPMk5qQmtwd0VXTlV3OEpj?=
 =?utf-8?B?QU5EUGdwYWs2bkxCU0lramFSOG5jNU1XSHJCMG5hSFVOaDdGSVpZNWx0U0dq?=
 =?utf-8?B?MkpuRWNWWG9kM1hUU1pEYkpLT2pTVlpTMEN6NXVha3Q1bTQ3YzlpQVoxZTk3?=
 =?utf-8?B?a3BYL0lTay9ncTlXVlliamFIUDUvWThUZFMwN1k5MjNmZTkxb1lDY1diL0Fz?=
 =?utf-8?B?dFovRVprbEhraVM5QkVIUm14RGxaSDA0WmRDdUZRWnM2RDkzRHNJbkVhUFc4?=
 =?utf-8?B?c2pqYzlWVnVGZlg5anN2OTQzQ3lIZ1RZR1c5THFOTGVPZUovci84V2F0RW80?=
 =?utf-8?B?bzBGQ2pmK05jSmtnTWsvZTJZelplcUkwdkpMVU13SnB4dEtoNGIxUjBzMGsz?=
 =?utf-8?B?WUJjUFFkMmFlSy94Z2wwd1k3T2liSUJncXBVNjJOMEZuakIrNmhJVGhzZXVr?=
 =?utf-8?B?VjlZNkhTalhGWGY1ZHg0aUQ4am81cVoxTUQxWlo1Q2NzTDU0eXRRRkZvRXhp?=
 =?utf-8?B?cHBqV1hYZkhaUFRVZGxoUCtlblBGbkkra3VyRysxaDVzT1NTU1V2OXZtMVBk?=
 =?utf-8?B?U0x2MlBtY0wvNVNOOEVSYU5KMGpFR0JNTWVsV1drTVErQ1hvOHo2L3dZTlRE?=
 =?utf-8?B?T1hHMmZqeFgzOFhQdExpa0diYmVlQ21FM2NYeHBicUpIeDErcW41c2xyUC8z?=
 =?utf-8?B?SGgyakpPaUZRa0xwNjlvWjQ1NDJEK0ZRQnlkUnlROEhhNnRHVE5PSWdrUzRi?=
 =?utf-8?B?RkJiRHIyT2YvZzdRSldRNnJaQ0tDYmNRenE4MFh5dW5mdUVOV1Vya1ljOHV2?=
 =?utf-8?B?bHNFaGYram4yNXEwemRTV1hNL3UvOGlLeTZUbmRmckoyNFZuRVJOZytOREwv?=
 =?utf-8?B?d1grQmVmRnpOSlNTRXl4YUF2anNOUVZhbS9YRlNUeWlqeUR6b09YOFpCOGJK?=
 =?utf-8?B?b2p0Tkl1ck1BVW1jOWZXZUM0TTQ3bm5pSFhwR0pBblRRbUNNenJYemFEc2dn?=
 =?utf-8?Q?Nr/WGdDyqGe16kzpM+QDlqqiFd8k6jf0LHRkx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05B1CDCF6BECC74CB632C913FE416BEF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99738d1b-46dc-42f8-125e-08da52907938
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 07:42:48.8207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnfBEMXHL4I+N5pW4GRZJOpMzw6z5kC5Y8mOIdGz6XTKQNz+05LUXM2K1FdNfpPFCaIop/KN8+js1Kt93zJSnpyOEVLS240nEtTG3SOuWBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzA2LzIwMjIgw6AgMDk6MzUsIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQo+
IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0IDAxOjExOjQyUE0gLTA3MDAsIEpvc2ggUG9pbWJvZXVm
IHdyb3RlOg0KPj4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDE6MjQ6NTNQTSArMDIwMCwgUGV0
ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4NCj4+PiBIaSwNCj4+Pg0KPj4+IEkgcmVjZW50bHkgbm90
aWNlZCB0aGF0IF9fbWNvdW50X2xvYyBpcyA2NGJpdCB3aWRlLCBjb250YWluaW5nIGFic29sdXRl
DQo+Pj4gYWRkcmVzc2VzLiBTaW5jZSBfX21jb3VudF9sb2MgaXMgYSBwZXJtYW5lbnQgc2VjdGlv
biAobm90IG9uZSB3ZSBkcm9wDQo+Pj4gYWZ0ZXIgYm9vdCksIHRoaXMgYmxvYXRzIHRoZSBrZXJu
ZWwgbWVtb3J5IHVzYWdlIGZvciBubyByZWFsIHB1cnBvc2UuDQo+Pj4NCj4+PiBUaGUgYmVsb3cg
cGF0Y2ggYWRkcyBfX21jb3VudF9sb2NfMzIgYW5kIG9ianRvb2wgc3VwcG9ydCB0byBnZW5lcmF0
ZSBpdC4NCj4+PiBUaGlzIHNhdmVzLCBvbiBhbiB4ODZfNjQtZGVmY29uZmlnICsgRlRSQUNFLCAy
Mzk3NSo0IH49IDk0SyBvZiBwZXJtYW5lbnQNCj4+PiBzdG9yYWdlLg0KPj4+DQo+Pj4gWFhYIGhv
YmJsZWQgc29ydHRhYmxlIGZvciBub3cNCj4+PiBYWFggY29tcGlsZSB0ZXN0ZWQgb25seQ0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+DQo+Pg0KPj4gTmljZSENCj4+DQo+PiBTb21lIG5pdHM6DQo+Pg0KPj4gLSBObyBu
ZWVkIGZvciByZW5hbWluZyB0aGUgc2VjdGlvbiwgaXQgY2FuIHN0aWxsIGJlIGNhbGxlZA0KPj4g
ICAgJ19fbWNvdW50X2xvYycgcmVnYXJkbGVzcz8NCj4gDQo+IEkgd2FudGVkIHRvIGF2b2lkIG1p
eGluZyB0aGVtIGJ5IGFjY2lkZW50YWwgYnVpbGQgZnVubmllcywgYWxzbywgaXQNCj4gaGF2aW5n
IGEgZGlmZmVyZW50IG5hbWUgbWFrZXMgaXQgZWFzaWVyIHRvIGNoZWNrIHdoYXQncyB3aGF0IHdp
dGggYQ0KPiBzaW1wbGUgcmVhZGVsZi4NCj4gDQo+PiAtIE5vIG5lZWQgZm9yIGEgbmV3IEZUUkFD
RV9NQ09VTlQzMl9VU0VfT0JKVE9PTCBjb25maWcgb3B0aW9uIG9yDQo+PiAgICAnLS1tY291bnQz
MicgY21kbGluZSBvcHRpb24sIGp1c3QgY2hhbmdlIHRoZSBvbGQgb25lcyB0byBiZSBwYzMyPw0K
PiANCj4gUmlnaHQsIHNvIEkgZGlkIHRoYXQgYmVjYXVzZSBvZiB0aGUgcGVuZGluZyAtLW1jb3Vu
dCBwYXRjaGVzIGZvciBQb3dlci4NCj4gSWYgQ2hyaXN0b3BoZSBpcyBvbiBib2FyZCB3aXRoIHRo
YXQsIHN1cmUsIGNhbiBkby4NCg0KWWVzLCBvbiAzMiBiaXRzIHBsYXRmb3JtcyBpdCBtYWtlcyBu
byBkaWZmZXJlbmNlLCBzbyBsZXRzIGNvbnZlcnQgYWxsIA0KcGxhdGZvcm1zIHRvIFBDMzIsIGl0
J3MgYWx3YXlzIGVhc2llciB0byBoYXZlIG9ubHkgb25lIHNvbHV0aW9uIGZvciBhbGwuDQoNCj4g
DQo+PiAtIGNoYW5nZSAiMzIiIHRvICJQQzMyIjogQ0NfVVNJTkdfTUNPVU5UX0xPQ19QQzMyDQo+
IA0KPiBSaWdodC4=
