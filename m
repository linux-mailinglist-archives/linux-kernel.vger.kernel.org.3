Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8C5B13E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIHFPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIHFPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:15:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2081.outbound.protection.outlook.com [40.107.114.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79149F8CB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 22:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+vVn5Ak0juXj0Aog5A7e+JMri8MzYs5gsnRH71w1JON/FFzMAwj2JnLGLJxburD9RR1H/g1FPUNbVEEPfcK3I+7AUmJc3r3WfKvSDjOSDNqAncKOmhV5HJy2gcUsFbA4zCNFeOJXQ1VQC3pP0/Vge+2MCPgn2S257CiIfTuENWUzf0UoWD/9e5p58jDmbhTeGBrgyJMJ0wzrB9TtAb2FlAxKqEqAy3FNFmfmaDkpWxaUE9/ADPNUfyyLybZjHfM18jq3COWtwo7hfApCyPpAX3rBsKFzpQSiXaVaBz+RcQfgSlG9Zb2StqgMsWA1L50d1pVrv9cMvy2iVIQaPTHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifzvs/JurLvtJLjvFfe9iM9A+nBWRcyCjHPbLI/bn2o=;
 b=ciSVzkCBmAgs550iVeq+Yv2EzAc2Eqz3kq/OR8TNybBG4yoedQ+G/CWPdtKjIldARGlQg/fhs3LNqvVN1cNZmOb7T7BM7bFl3/0A1dVkhs7UkLxXrdHbpPCkzRpsF4baIHyPwAY9T+SG98hfM0/qRuCF4PKFj01n3EMola+2YKokXft4w3EOnxH9aCkRmlZ4CkIZGw14d4UR8F5Q7sWcGGyAeYy0tEzbCixVa5WkPCSJpaPTfxlaUIzZuDVqL2ULpzEvq1BeP/lpnomduMXDugnDFJzYY3f9tH8GMfofd8tdERhRYAU9M3VpWDDmogh7k/27ZU7zKkstsc2Brg49Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifzvs/JurLvtJLjvFfe9iM9A+nBWRcyCjHPbLI/bn2o=;
 b=Ie28R8NteytfWezwVtpgAN3kLtgfOsQcbo/QKnpMhIngYJFDQxugMsCY0QLWLtSX9FiuGuv1hikomJ8lsUoBwf+oO1rsPc0C/3nUJZ0PU1mJyjI2DwW1YiSjYAj3GuiVVsZ3+zvW4FxQwgc6ObBqX5mOAj9qkHH6V+zTI3Z0AYY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB10409.jpnprd01.prod.outlook.com (2603:1096:400:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 05:15:08 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Thu, 8 Sep 2022
 05:15:08 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
CC:     "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/hwpoison: add __init/__exit annotations to
 module init/exit funcs
Thread-Topic: [PATCH -next] mm/hwpoison: add __init/__exit annotations to
 module init/exit funcs
Thread-Index: AQHYwdSCXVDrSpUsCESQKtksFYnAdq3VAEMA
Date:   Thu, 8 Sep 2022 05:15:08 +0000
Message-ID: <20220908051508.GB1496675@hori.linux.bs1.fc.nec.co.jp>
References: <20220906093530.243262-1-xiujianfeng@huawei.com>
In-Reply-To: <20220906093530.243262-1-xiujianfeng@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43440d1c-6a50-4619-4e5e-08da91591903
x-ms-traffictypediagnostic: TYWPR01MB10409:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5S6Ziqtc0FMyfdkxR1fqirGUjgomybNCgoyv83rhJMJR8/u9w/EtjSl3/G/05ndTxbHC2WV2ehM4uvKAYpgw6Z9FbPpX27Fe7rRvXmOLCbnTCVrPO+MbvSJsycP+pgAxgg0OB5PZyynt0JP9l7VC7I92F5qvK8LOHibig+6jquXmOrQa3I/GLoH2oYXB2AmJrOBuSalakjJGX7jnb2KoMrDfyYvkEjexOeoZ1rB3R6GzZdB51Dics4TvcFLNU1ktvYj2MObLz3wpl9ykpFSxw809YBnvJVlF82wjFyQpUMVLILyfBcu8aWZPIhStI2ISQza9HSigBe5h5ACg0LIQKPrqnULc/y9jQMFhtNT8fJSUF/l8hD4+P1PUyOSmBvJJJEWTG+xIXEXjyhyaXBewEGA9hiMneLYqeISW+Y4Wmf+dhg0EIQk7mJdAB35Co9YovjAnj8920sTFaDqXhhPXJdXQO5/5hZ7oZf9Cof9kEoB8T9Z3bj3OQgC1mFYrYS/fQqIyzB8MiIXW+HCTuryikgPYTN7PrVpDtyc/ydGTCGKoaRVEajFTRh+Hjpc5ELSDZGuPfzSXg1Z4X9LGd39QcwMWybacbNPyxRuxZp5gCKvqIop6cs+m8pIHW/057ef6IMdHuqMFRgdbuoY53MBGqFsJddZCnzaIz9kLt8V856KtGALSCEFWtbskVJjP2/MQSkXGvy9YUNbnm/1JxZ/ipYrRsaMUrOtSbpyYoDUXVVH9thOCJXYXSrq4S1NFoupBgSdgqm0pc4m4LyRIOzfTng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(33656002)(316002)(2906002)(66556008)(1076003)(186003)(5660300002)(66946007)(8936002)(85182001)(8676002)(76116006)(4326008)(66446008)(64756008)(66476007)(54906003)(6916009)(41300700001)(71200400001)(55236004)(82960400001)(86362001)(6506007)(6512007)(558084003)(9686003)(38100700002)(478600001)(26005)(38070700005)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlpYWWNqRndDbXpJeXFjRFdIeWpIRkVjVXk4UVl3MkViVnUvb3RSVmQ5QTZz?=
 =?utf-8?B?UVlDK2hySzhQaWU4bytacGFROWVUR1BrS2pBTFcwWHkxdmM4SzArWnVkNG1G?=
 =?utf-8?B?Q1MvbjVnMGNsVFR1RlJnTkMyUG54YjN5MEVnUkQ5Yi9VRTl5MXVIWkZ4cHR4?=
 =?utf-8?B?ZnhzZzIvZkNLLytjNkdMUUlCcFVmT2x4TEo0cFFPN3hVRm1EcnBXRUFjOWpp?=
 =?utf-8?B?a3pDTmRJczVYQ05xSmRibEpuQnBINDJhN0hSRzk5OUhWaFZNNGp3MVFvcGVR?=
 =?utf-8?B?bTJPb2tKNmNOeVVrMFV1UWRRUDRBdUt6L1J3cU1kUWs5Rnh1WHNnOWY3WE5W?=
 =?utf-8?B?SloySDBteStWMHUxZkpXOE1FOWJQZ1QxcjlzdnpQMzU0dVN0WHhiWkhrOGhr?=
 =?utf-8?B?ZDQyVzkvbWVkSGRkL28reEcrcHlaM09pM3ZMWklzQ1MrK0NXbVUwcHdoeTl1?=
 =?utf-8?B?Q2xiUTduejVhN01sQ2lqL21jY2R4LzJiU20vdGZDMDlqejN0bFVnMzlENzVw?=
 =?utf-8?B?b3FTUXRRSXhZWDFlTXZ4QWlpZ1BzVnJNSGNtS2V3clJXNTVpV1MvNzVXVDNu?=
 =?utf-8?B?bmVDakFnL1FZUlM4N2I1TnlBb3UzUU1ycmVIQ005RURWR055ZTFNaVA2QXEr?=
 =?utf-8?B?NElubzhYdnJqVFF0REgyS1MxSC9RejUrMmxmL2dpT1R4T1NjeG8rMVlQZjdQ?=
 =?utf-8?B?bnNSMWY1b1RTNFVsN3kyazVoMTNoSTFzWjZHWjhzK2ZDcFZ3K050YzZkWlp0?=
 =?utf-8?B?VXMvMTNwZi9uUHZ3dEFET3V2N0JRYlY3R0FPV2xpS3NWbG9UcDQrbnIrdTA3?=
 =?utf-8?B?cW01Qi84eDZLN25YZEcveDRRUTRqbFFPYWpQRDdINDZITnR1Wit0enVQMmRT?=
 =?utf-8?B?WnpDdnlMQU9YOHd2Lytqak14RS95UWZMMVlaTXpVQUJxcE14RXFGRnBvNERB?=
 =?utf-8?B?czduMmg2Y2I2eng3WnRYZ1dqejloeDZyYUR3WDhicmRVRUVrTEdnZDRsNS82?=
 =?utf-8?B?TVN5dWtTL0Qzb0JxemxKbE5qYlZtaTFyaVpneEdORFFFc0hFMGJ0aTZmbWRZ?=
 =?utf-8?B?blZYSG9Jek9vT29Xa2FzaHdkdlJmTFB3UHlocUU5VXNuNnB6cUF5ekZCS1FY?=
 =?utf-8?B?NDFyL2VuY1p3MnllSFF3ajFHdnlPVkUwQzVad0YvcjBiY1BLV0JqUGlQLzlY?=
 =?utf-8?B?VWdaajhGaE9jcEdrYkxDcUhYMUxPcTk4VzlaQ05ORkRZTjBZU0Q5dEx0ampD?=
 =?utf-8?B?TTZJTStGRXVnamVRai9BVkdJekR6NEVkUll2SisrOTVNbWw4SDhyYWhaMzFr?=
 =?utf-8?B?T3ZueVVkMHpRRDJjYVhlODRSVXFaQkNHVUxlUm5obXRkSytGQURMMzFzV1Q4?=
 =?utf-8?B?ZTFNV0hGdXllc3gwWmV5cXRKbnNvR0RhTk1HMW01ZnRTWXQyTTNmbmNBZXZR?=
 =?utf-8?B?Z0JtMnhrdE9tdVhRQ3o4bTNsOU42djhGMFBtdTc0MEMvRTJJbmZOZ2Vac2xC?=
 =?utf-8?B?MWtXTFl4YS9Ia3dLUFB4a3k0N05mS0x0eFNCZWRzd3J2cXVwaFZOd1h5Nk16?=
 =?utf-8?B?UUxVQU94RU9CUVVFQ0kwaEt6TWt0ZTV2MGlxU0lBSlJyaWdnLytEUWFiVHk4?=
 =?utf-8?B?WXRsM0tYMGRhcUJ0azF1OU1JNkl1S0NaMmxqNkhEeTZWeFVRc0laajRhWnhK?=
 =?utf-8?B?RDdyeHprWkFRT3JkVit2ZmN2ZDBTWktwenJqOEtsR0dyRU1uNG0za1F6SVk4?=
 =?utf-8?B?blNjM2IrWXRzVUFwWklHMkIvMHZTNWJtTXJkZTFLUWZ2dWt3cWF6bXRKNHha?=
 =?utf-8?B?bGFLeUtoOVdQb0g5c3pEUVhsN1ZMRENPZVBCU2xLYmtvalh5WnhJQjB0dHZr?=
 =?utf-8?B?ZXFSMGJKMytrYStPUW9kelJ2MFFCc04xa3k5bXdLcm00SXdEQktkTXRKNU5h?=
 =?utf-8?B?R1ZyNzgrUWlBZnd3V1J5TmEzSm5ORTFYenIyYjlOa041VkRFN0hIREJyMmQ5?=
 =?utf-8?B?dXVWaWdmK28xbFEvVmdESnlwZ1ZVTnZjTGJ3aW9BcmExd05KRFhRM0laUHhz?=
 =?utf-8?B?VmQ1aGNFOHJWSlRoYlJma3JxYkd4YUVsSnQyQ0ltWXBQZGZPVkZDK2dmMHdm?=
 =?utf-8?B?ZElPZGhCUWZNV0E5N3Zva2szUTdINUpqaGJ1M1FCU3pSNjd0SUhXRE9HTGtv?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93836BE5FB6D144DB146087E374B3368@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43440d1c-6a50-4619-4e5e-08da91591903
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 05:15:08.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO0fs02mpQcL0quMtF49hJOXVCUJ9POZQ+p0ZrsLNjpCgmSaNeIgNwnvO2rZ9l+53BbaQr2nhYrqNMP7npeyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMDYsIDIwMjIgYXQgMDU6MzU6MzBQTSArMDgwMCwgWGl1IEppYW5mZW5nIHdy
b3RlOg0KPiBBZGQgbWlzc2luZyBfX2luaXQvX19leGl0IGFubm90YXRpb25zIHRvIG1vZHVsZSBp
bml0L2V4aXQgZnVuY3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaXUgSmlhbmZlbmcgPHhpdWpp
YW5mZW5nQGh1YXdlaS5jb20+DQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tPg0KDQpUaGFuayB5b3UuDQotIE5hb3lhIEhvcmlndWNoaQ==
