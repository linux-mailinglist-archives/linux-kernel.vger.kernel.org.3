Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB64B50E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353770AbiBNM67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiBNM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:58:56 -0500
X-Greylist: delayed 873 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:58:48 PST
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1115.securemx.jp [210.130.202.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223634BFDA;
        Mon, 14 Feb 2022 04:58:47 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 21ECiGbL023335; Mon, 14 Feb 2022 21:44:16 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 21ECgOE7018633; Mon, 14 Feb 2022 21:42:24 +0900
X-Iguazu-Qid: 2wGqsbWW1lOZcRLAJu
X-Iguazu-QSIG: v=2; s=0; t=1644842543; q=2wGqsbWW1lOZcRLAJu; m=k5V7XzWVQj0SP0R98mV1AosP2jRUJYY7UC11k9IQftQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 21ECgIUs021987
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 21:42:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8xJ+lWPhAb97lsYnAgz9k7ZdOwhnzfz2p8+cjKtOiPo6URXdCFjSdZpfNqI5Czzv6fzmnKLWQX0rOFhJNx96extPQxX43Z1lyR2PxnKUpL4F4Xl4omPmS/CfaXOAMraWsXTeq/KFINudufmsFXJ8FurjtMed2Lg5g0C8vvgK5/yk0+FWjcNVvg5E4UsVFFv2SZzSt5ppJQnnEt9/ZLhl8zw0/oe0eUYUTLWdyPeYJadtNzZTsCgcVv+9/V3/SQ0ho8m/+JqSVnsT3NcHl+B1PV6V200MUevJ2GAXz5RpkB4E9Xadq/tX+w5Hzk9lN6mvoGJsG8Q4wpIqxdGTz4OOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ncVM72lBMCHEb/R5gUeOjq5dsjnGfltu2dRJoPvzo=;
 b=oGH1vM+N+0Oeyqe7EYhahgwVi3wuhKlcGbz7h+ROTQS6ukq63kvwuMhKUHCdmZ9O8aWAoSRmKsFdTIuIWUQhboG0V2CgYjZbtW687xJP1KJ8lRNfWU7KTTeUbdP/wgqLeadmbV4OohnXLED+cpEGJ8YFsFaTddUd7lBJf6PmdQHckLSk9c0o3a2IGipakinwoFpOCrkR9W5fPsvw+Boq0anAD4XxS777yzJJ+oBPHidOlOO1A1KQ9xd7O+D5FiCCJzEQhhAaU/q4qq3FjpiDF7w77oN3P3d/YuXUU/8OL9heyQOuuLLOhjS3Wv3rxGIoMQs9y3UgJpMWugvXGQ1aFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <krzysztof.kozlowski@canonical.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mripard@kernel.org>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>, <heiko@sntech.de>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <p.zabel@pengutronix.de>, <anson.huang@nxp.com>,
        <vijayakannan.ayyathurai@intel.com>, <rtanwar@maxlinear.com>,
        <jeff@labundy.com>, <yash.shah@sifive.com>,
        <sagar.kadam@sifive.com>, <vigneshr@ti.com>,
        <yoshihiro.shimoda.uh@renesas.com>,
        <laurent.pinchart+renesas@ideasonboard.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 09/15] dt-bindings: pwm: toshiba,visconti: include generic
 pwm schema
Thread-Topic: [PATCH 09/15] dt-bindings: pwm: toshiba,visconti: include
 generic pwm schema
Thread-Index: AQHYIXtI+0MD+2w0uUqc+2gBlwMjwKyS/QgQ
Date:   Mon, 14 Feb 2022 12:42:14 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB625242DAA48BB652D839FC8392339@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
 <20220214081605.161394-9-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220214081605.161394-9-krzysztof.kozlowski@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 787aa248-3849-4121-ac0c-08d9efb76d9a
x-ms-traffictypediagnostic: TYAPR01MB3088:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3088E56D37BD27D870A1570E92339@TYAPR01MB3088.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jkc3VXfs4Nn5Z580T8rD4BOxd5I9Uvdei6JnMWANi8AQv09LLUvBWTxMMAI4AmcdbXtX2iqPE3EH5yHD3tq6KN8fr6Lx/+KdBftqOPFQK39eQh2gTKDh54wfKLzUqFtAnygjujCgiJBojharX3Szl/GMe/D0yjXtBdEkIQrmOokyiOSgbKxJ7ZVdobeMWhQDK4k5r5uy9PSlxznO6DZyDg8621lj2t/xeMG6By3M5VoglTbuNVL0VrftxoGEqMmz+vxa7nBI8NNncNchGyNFpLi7GjOVAgdtb91mnNYwyNu4VugGEfatn6BuKr2F7SwuzsZ2IrbdnHwUJBoLQhoPvv2CcRFDS15UhauznbpgbS9hBf4IleY7DhALa/2A3LvH8XBCwXSDCRiXviXkqt0JoFzpf99XW88/PwamvTFw3aNNuz3L73mBEgj5rp753hOYPhB+bxx4Gj4JNPouHn+PXXaP/bkbzV1u8sC4zGkU0FfEw/kp6lwF4dJvtGYTXqknZkgAzChudtnwzYs671jH5LJmlMJdJm8JmRRPFp7zSzY6mmKOiG8X9kvWfqb6P9Cj1jj/KjR7xcSDeFQKX3aTOa2PvGU3AgON1uZYv1gsZWflyngicXX9FY7IAKXh/BxttOuxU3HySYSCe/RZqsDf9MH62eMuepfJdVDtUKgi9Hy6z5YTBivs4yNcNAqyUJ0v2QvtDY9k6hBVntoBIx2ZA85CmkRyUNTOGVIJV3YudfCp2jIgJmj063QJ3mRXrsI8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66446008)(2906002)(38070700005)(66556008)(76116006)(66946007)(6506007)(64756008)(122000001)(508600001)(921005)(186003)(26005)(5660300002)(8676002)(71200400001)(7416002)(7406005)(8936002)(52536014)(38100700002)(83380400001)(7696005)(86362001)(9686003)(33656002)(110136005)(55016003)(53546011)(316002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1JKaDZvdStlRGdhb3FPTEIrRDBENWFQdGhXa1pFZmpGTlRraXVEOFpBdldB?=
 =?utf-8?B?Z05nWlowczRiZEVybm1ueVY4bHMxRGdiektGWW1PRmxNYjdUVkVpQ2hzYzFt?=
 =?utf-8?B?eEtONHRTd3RVTEpWSUxtMERtMnVqb0N3dnpST0EzYXgxQ2RoekZUckErMjhx?=
 =?utf-8?B?Yi9SbE5WbUVvZFJ5d09vc2R6b2R3UDg1OWlzckpmNnFTa3pTMFRPdk9ZQXdB?=
 =?utf-8?B?aDdkaDlNYk00K1dWenNjeWdIMkhacmhFSW9NbS9xU21UNVVQaHRCOVhGMGt2?=
 =?utf-8?B?eHJLd25hajN3Rm9WWHIzUDJpT2NtNFBERklyOWc0Z0tWMDBSQ3U1MHo4YmVx?=
 =?utf-8?B?RnY0UGJZZVFiWkZOUFVjY3R3d2RBL0Y2dkNQc3dqRnBlWEpSWjRpYTc0aGxT?=
 =?utf-8?B?UjRVcmgvS0p0TmdkdStmd05XaXgvNGVQVXdFQXhvaUQxR1psSGlJeU4ycHo3?=
 =?utf-8?B?RWpSbjZqd2FEcm56OEhpTS9CZDk1MzRlWEs1bWYvTEF1M281czZwaGdrSEMw?=
 =?utf-8?B?SDIxWUJad04wai9LZFlLZGFSYXlUcGo4KytIY1Jja2dOUkhFd3RSdktKUTRI?=
 =?utf-8?B?cFhycG9yajFsKzU5ZnVqTGdVRnBOMmpZM29LTDZnWnJxZWZNSjBOeDdwOGdL?=
 =?utf-8?B?d3Zvd3JsNkxHcXptQUEwd0NSK2twNk5Xd1lWY0RlZHlhaGJuUkJPVlMwakgz?=
 =?utf-8?B?SmQ2NHk0YVcrNU5BdkhlSGwycTJ2QldZYXhEam50cjNkUTdFSTNUbjZURjV2?=
 =?utf-8?B?d3pJVkd4YUEvaCtZNlkrZzZidlBnTkFQZDROSWhQQ01TL2RVUVY4aVZGM0hK?=
 =?utf-8?B?cERsQm9CNDF2K0VlNFF5MCtXTlhQTzFaYy9MQkRnYUZuaTRWOHR2bFNiY253?=
 =?utf-8?B?UC8yMFdwYm5BYTRqSmk2RXh0UGUrS21Ld3pyQ21wRHg3Mm9UTjIweldYamdu?=
 =?utf-8?B?T1JGdDlOQjg5aUEvYnY4YUIvbDNVSVU3SGVqYmdTTmVkTXdKS1F5TDB4YVBl?=
 =?utf-8?B?ZTZld29HOU95Qk13VGR3K0d0cVZMVUdmSlV2d2txdXd0T0dBWDlPYThhMUU3?=
 =?utf-8?B?NDQ5VlFnZ0VNNFJSZGFYcTNidUJQbFZ3anFFeU9JQ3U4US9nZ1ZCUTRQZDRK?=
 =?utf-8?B?YWVjbVd4NWs2emdCc3c4ZHUwYUJPNkVabzIvNGpldUg4bTRmZkUzR3NNU29Y?=
 =?utf-8?B?eXdweHJJVmg2UFlNSDVUa1lMY1k4WDZ2dTN4eEhvQ0xHNUdRS0dXSWFUT0w0?=
 =?utf-8?B?TWlzbkd3eHpYaTVETmM2emMyb1d6M08rNnhvbHZjeGF3aUtEWWJ6Qjh3cVpW?=
 =?utf-8?B?eTNFa0lmK0p4VmtYTkErS2YwRmZxY1plYjJFb24xT05lWDhPV2JjOTJJWTNk?=
 =?utf-8?B?VWJRZi81UTk4L21tNmlDRzF5VFgzdFUvY1gzQ0p3WmMyMzdhNXJqeTRHZWZt?=
 =?utf-8?B?UDhUZjNPM0J5bnRmUkpMMnA3SkJwNEhBY3dIVUt0U3FFRHprOS9NREFoZVBM?=
 =?utf-8?B?clBOWlFqbzhVRmFFalJuZEUxZWxST3E0V09ZekZZZFNaZ0w2eXBhWi96dEl4?=
 =?utf-8?B?SGVYK0hGNUFWK3RDMnE1RERIVnUwN0xiNmJ3THJnNGFFNElaQ2N5U2RpWW45?=
 =?utf-8?B?SGRJWWR6Q1JCejRVVVlkN1d4VmJobkNQOHU2TmpwVmFqSExUcGNDM0ZSN2FK?=
 =?utf-8?B?ZVkrVGdxS2hPUHFNYkNXbnd3NW5TcmQvN3BZTUw0cldTTUNJend2Q1JYN1hv?=
 =?utf-8?B?WlY0U1hYK2dGd3dLMWJyaWErV0lWNi91bjE2RVhPYThvV0xBTTQ5SmNxcFRE?=
 =?utf-8?B?UVNqTGRUTHVwaDgzOUladXArLzNwVG1xc080TllZY09tZENBckVXRm85eTlI?=
 =?utf-8?B?RUF1STlqeHRvYnZwdDdRK2MrK0dTall6YjRLWGJiRzZMMDNmc21SeHZZTlVB?=
 =?utf-8?B?T3NYdXFrclVpUUdSSFJKQnFZR0VmU29YUWpLMTdHTHJiS1F1TVVneTVrN1Yz?=
 =?utf-8?B?cklkNEhRRHBnTUZ2Z2lpSEM2T1ZLUUxhcnY5bHd0czYrR0s1ZkFJalhKWmZm?=
 =?utf-8?B?dVM0bXZnT1ZlT2IxcTNoYllzRzFtTkdPdjhVL3pqajJ3K1BCL0R4Qno1WE1S?=
 =?utf-8?B?K2xUWkhmTFlGYk5iL2hxM0NpcGprZG9BOGFyczFoNUM5VUVROEM2OWcxUjJj?=
 =?utf-8?B?a1dYRTdiRXBBQUZkQlpEOTdxc1NQaFhpbEJvajRKU3NWa0t2YWVVbjFGUk9R?=
 =?utf-8?B?N3ZGT0p0RW9zNWFLbFVFNkpBZVBxN2JKMjQ0TjBheDEvN0puN25GRTNYd0tX?=
 =?utf-8?Q?e509+Ogktf7eTqwBsw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787aa248-3849-4121-ac0c-08d9efb76d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 12:42:14.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEowhYL3L+R0Hg9QCz4VF6Th38PmHsk4dfsIXDK3BLQEbbhO3qmyDWPJIFLWAyib/NJi7iXxQ3Y1aWRIJ1bWGrZV/7o2RupeK1bqTPcasHj/6idMpMWPQCAsNyVGYvaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3088
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgMTQsIDIwMjIgNToxNiBQTQ0KPiBUbzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVk
aW5nQGdtYWlsLmNvbT47IFV3ZSBLbGVpbmUtS8O2bmlnDQo+IDx1LmtsZWluZS1rb2VuaWdAcGVu
Z3V0cm9uaXguZGU+OyBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPjsgUm9iDQo+IEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlz
enRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbT47IE1heGltZSBSaXBhcmQNCj4gPG1yaXBhcmRA
a2VybmVsLm9yZz47IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz47IEplcm5laiBTa3JhYmVj
DQo+IDxqZXJuZWouc2tyYWJlY0BnbWFpbC5jb20+OyBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5l
bGxpQGdtYWlsLmNvbT47DQo+IGJjbS1rZXJuZWwtZmVlZGJhY2stbGlzdEBicm9hZGNvbS5jb207
IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT47DQo+IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVu
Z3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBOWFAg
TGludXggVGVhbSA8bGludXgtaW14QG54cC5jb20+OyBIZWlrbw0KPiBTdHVlYm5lciA8aGVpa29A
c250ZWNoLmRlPjsgUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IFBhdWwNCj4g
V2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47IGl3YW1hdHN1IG5vYnVoaXJvKOWy
qeadviDkv6HmtIsg4pah77yzDQo+IO+8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPjsgUGhpbGlwcCBaYWJlbA0KPiA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT47IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsNCj4gVmlqYXlha2FubmFu
IEF5eWF0aHVyYWkgPHZpamF5YWthbm5hbi5heXlhdGh1cmFpQGludGVsLmNvbT47IFJhaHVsIFRh
bndhcg0KPiA8cnRhbndhckBtYXhsaW5lYXIuY29tPjsgSmVmZiBMYUJ1bmR5IDxqZWZmQGxhYnVu
ZHkuY29tPjsgWWFzaCBTaGFoDQo+IDx5YXNoLnNoYWhAc2lmaXZlLmNvbT47IFNhZ2FyIEthZGFt
IDxzYWdhci5rYWRhbUBzaWZpdmUuY29tPjsgVmlnbmVzaA0KPiBSIDx2aWduZXNockB0aS5jb20+
OyBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+
OyBMYXVyZW50IFBpbmNoYXJ0DQo+IDxsYXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRlYXNvbmJv
YXJkLmNvbT47IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LXN1bnhpQGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcmlzY3ZAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMDkvMTVdIGR0LWJpbmRpbmdzOiBwd206IHRv
c2hpYmEsdmlzY29udGk6IGluY2x1ZGUgZ2VuZXJpYw0KPiBwd20gc2NoZW1hDQo+IA0KPiBJbmNs
dWRlIGdlbmVyaWMgcHdtLnlhbWwgc2NoZW1hLCB3aGljaCBlbmZvcmNlcyBQV00gbm9kZSBuYW1p
bmcgYW5kDQo+IGJyaW5ncyBwd20tY2VsbHMgcmVxdWlyZW1lbnQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5j
b20+DQoNClJldmlld2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

