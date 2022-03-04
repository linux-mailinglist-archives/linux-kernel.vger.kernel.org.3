Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80B4CCFF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiCDIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiCDIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:30:16 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1FE4474E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG9gW9nOMNCWM38mDWyspdo1L+cZLvNfhEMnjzRkBRKWXPKv79/ECz8XTBuD+x/a9T08xsev2NCLZda7j7XCNKuZrgxnz6W1LFqm9EtPwa3zPyFhbsI5USR6uwqPsn3PXVzrrgYuS0BOVPpFWNafiUxMgot71y5OHti7Ivwvi9F3p+/G8Fgi9JMBVX/ynnyvsx6NM4nGBP1eCfg+X2+d1U586+m9zgxEWFhSU8WoeCvnbq2tuoHmIjszxs7EhgQwhjHANmWkXlKDv/EkYc/DNO4qoxBWq0xpe48gb9lmhAHlEaMKAIUsUCSelrstNGp7dQCtPgsP0jP3eOB1g7+PNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeIp91Ggqwreogg8I78Kr1nXTYg5a+61S91MtlAbzGQ=;
 b=E24qTBjqvyucTDFsPRTxQ7M1w8IyGm928f1h4CkdZiMDUSo+iAaVqVd9Barrz/2eu6EipP2AM/aQE/Z/4phCo/Ki3O2MzjK+Om1CkrfJNit6UyrQDAUHEfMgjyyJ5by9V8gT+eFqGR1U9/mQE2v2zUvT1Aox9TZTRqvzK268dlVVKwuZguGdSwi7Q+JfB03yrpl7TtHj5itlqaUvHynoepqutqsHm3Yw+yzVjcIsP95j89P/6fvqdjg5eo2IWMvDsULbX1j9TaBIJWt1TJhZ1mUkn+cqTCioVlcbccl4Lpw0G/ECybQXHROCtoAwHg26Akk70x0bDQNSgLwT1v+P0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeIp91Ggqwreogg8I78Kr1nXTYg5a+61S91MtlAbzGQ=;
 b=Y68SjhOinx+ekOS3jXm0THrE402BLHgdj8q2A3i1kSSJF7ByGU5oJSax+85Q+0yKo24G0TW8kaeK2z/mshPd65h1DtydcsGHSL6PicXaPlCcpeBde5qMF4UdP3rAbAT5YJfFKMjB2e8jCCr7rMoyuUICuv22+wjM9idZTf9QclM=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by HE1PR0401MB2523.eurprd04.prod.outlook.com (2603:10a6:3:83::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 08:29:23 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::2558:6415:f9a3:48fa]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::2558:6415:f9a3:48fa%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 08:29:23 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [EXT] [PATCH -next] drm/fsl-dcu: Remove unnecessary print
 function dev_err()
Thread-Topic: [EXT] [PATCH -next] drm/fsl-dcu: Remove unnecessary print
 function dev_err()
Thread-Index: AQHYLqaflcAkQynvCUmYWVe4uEkb6ayu5fgw
Date:   Fri, 4 Mar 2022 08:29:23 +0000
Message-ID: <AM9PR04MB89078D8090D1FAD28BCB48F5F4059@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20220303023010.61403-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220303023010.61403-1-yang.lee@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d76230e7-4ae9-418e-e755-08d9fdb91690
x-ms-traffictypediagnostic: HE1PR0401MB2523:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB252304637C8674EE607985B7F4059@HE1PR0401MB2523.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JJupPy0/PU5WWgyhqQH3VsLHeZBORMfPskuONR0kznDKFMoShQ9OFRO28YZRJANHcbARbq9Xavet3gXgfxPs3YTZp7BUy878NYmblyJtFWpBQzfwwHD9Lknamn6/QaotdBnDFGElMr6/JCvZnAT+SWPnfUVBYOx7Nu7rvoIOogaed3kRgxFgIsAd10H3cc3SuYXmHtFdxB2bKDB8Qrd264iEt+XvUDaFW48uC0pQFg0da3B1eNC6/osrXIhQIPDkgAUVPbq1Ya/IEocp5BB70E4F58B/wLB8RX1FZyswXePZx+VOJTrZ9sWl5nDurUIyA7/gA/hIr13YueoEUgIHTtpd3XrKuEinP5xkBGhX9wBp+XQFEo/J76/cbgtWDaa9YzOzXPN3tBOzVCUQAucAHei+oRzj/WqBuL4hQ5CKePjFklV/jzJiMMVvT51M2HPL/hJHD5fmYVCoehALTBZd3bT13JSWTMckl0F1GNPvQjI3liIrf/0yD+HRCA3BvFX7SY0AfJaJRyVy2wp6wRqv/gsk1H4pjL5OLLwMzG1JAKrGCpHAVoTEqQaGSg2Ey2F5pq/ToRvON6B1SSeq0YYL/lLkwsi9+TaYVOgvTiwcW8GlRQdjUVEI2OkuFLNGJn3XO6NcuDjCSi5asuUszSWVZadDCjJVaOpPUzz3HFzgpNrKlTYXDfXAxKu8vl2WMO9TousaBZXOp1NbHs7GyqQag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(2906002)(122000001)(6506007)(86362001)(33656002)(6916009)(54906003)(26005)(186003)(38100700002)(44832011)(316002)(55016003)(5660300002)(8936002)(52536014)(4326008)(53546011)(8676002)(66476007)(66946007)(7696005)(66556008)(66446008)(64756008)(76116006)(9686003)(38070700005)(83380400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Sk44SnpyMHZKT0MyZGE2TTd5dGpOd2ZHQlNMUTRDUkNJV251c090TkNhRDhW?=
 =?gb2312?B?N25EUVVKRnRscXk4N2t1UDkyTkN3N2w2SmlqTmNFOFV5ZEt6VjJkSVJNUUM3?=
 =?gb2312?B?NmZjeFoyc1JudWk1OTZxaHZOb2p0WlRyeG1aT0tZWk1UZXltYVdCSm5wUmdn?=
 =?gb2312?B?Q0QwelFwU09tSmZCazlwbTdiRnRaRWVVVk43ZGFCbndVc3NqQWZoUEtSQ0k0?=
 =?gb2312?B?RTZBclhkclhiT3RqOFlNM21lZEkwQ3FBUTJUUlp4V1NJK1orZWxmbXZyd1JK?=
 =?gb2312?B?eUR0V1pUUVlDN29paHlLSTdDS2xPcVkwbk9Cc000UWswTXVhSjJ6NDVETE9o?=
 =?gb2312?B?MHZ0UGJkZFVtWkFNWWVlVDVjbi9iaFY4em5ZZ2pWQnVxVElQUmpGLzhOVHBs?=
 =?gb2312?B?WmptVXFTVkd2L0h6c3AxWjFIWjg4dk16UmFDZkFDbzc5MEduWU8rT3VTWCtN?=
 =?gb2312?B?ODFWNWNBaHduWS9ZN1pXM241SDljNWN1eTdXV1lEYWsrOUNyM1JRR3pHZzVC?=
 =?gb2312?B?SmxoV2ZYYkZydm1ISytNaVE3d242N0RaTktJVWM2Rk5vUXVpMnpUNGZxNmNq?=
 =?gb2312?B?VnYrN0hnSnZ4eWxBL29kYnBESE9mSTNDYTZXNjBpNEE2WllHZXAzTGpBWnda?=
 =?gb2312?B?cDllMEU1NFRTMEFhU3pINWcrSlN3d0JZREdZbmdYUGxGWEU1Y1hIKzdqQ0ZJ?=
 =?gb2312?B?Ri8rcXNvUGxtQ25uOC9vRTBLczA2ZWcrWkZESFJMWTZEUmtnVDl5SEhOSGE3?=
 =?gb2312?B?OUpjNzFPNG1TeXdmNS84ckgzLzdBK0RHY2xEWGpaZUFFNkcxeFl3VFBycUs5?=
 =?gb2312?B?cjZjbzNpOUNqRnFmaXpCMDBjRXp5U3FWKzRvZnc3NVdJak05VEtFNFY0N2tB?=
 =?gb2312?B?ZjZ2b0lNdzc0MVdodWlrSXJwY3N3SEIrdXRuTWFkZktFWmNlaTBKeXNvS3BF?=
 =?gb2312?B?N0doQTVOclJjWUZOcTFRRk5Id3pJUWpsSnQrSXEvaldydHBRZW1DUjFabE9L?=
 =?gb2312?B?aHFvWEw4aUJuQW9RcElqSG1mZDRvZVhudFRkb084WTFRamIyT2trZ245czdZ?=
 =?gb2312?B?VzlZY1FUL21ZNGlUekpaVDJjSWNPWXlwL3NzL1hacXI2Ky9lamdybzJ0cnJt?=
 =?gb2312?B?dU12VyswMFplaThuaXBQT0cvejRJM1poR3VMdEFnRWxWRGhZR0tkSitlZXo1?=
 =?gb2312?B?Ry9CUmJ1Wk5USTB0enVOYktzTGR3bWhIRUxtbmVzOEowa3kxa2d1UFZDQm5l?=
 =?gb2312?B?SUhlNTF2YmpWVUVDa0Z1NmhYdk5Dd3JOTVJVd0EwakllcVZId2V6bnFjVmtn?=
 =?gb2312?B?WEZScEtOZmJkb1BDYm9yMVpmQ3BPSkIxS2MvOUVPY1pFRXhSUlR0a3ZjS3Nl?=
 =?gb2312?B?Z2pRNnZZa25KY1lDdVUrTGxzTlVwTFV2dmI3WWtMNUVjVlRYOGVDTFVkS3FH?=
 =?gb2312?B?S0VNSHllY0hIUkpHTEphSzF3WWxTQktPd1BLNnIvRklqekdTa0xJUXNqbnU4?=
 =?gb2312?B?Vm5tMTNPSGNXNmlEWXNrYm1FOE1RR2dxN0tnQWtWV25xSC9jd2ZXUDhKelNu?=
 =?gb2312?B?UFZPL1Q3RjlITWdyRzVzVjlUVkxkNlRVZEc5NzVPc0xLbDd0K2QyK0crS29J?=
 =?gb2312?B?VzlZQ1pHd3VlZkQ2OVZXSFplK0pyZ0c5dzUzUW5KTzZReDRIWXNHTFFFSXg1?=
 =?gb2312?B?MFhuSHIzeEI4NlRVUE81M2hhQ2dYdW5rR2ZKZy82VGRMYnVMSXMwOGs5U1Fa?=
 =?gb2312?B?eWkyc3VUbjJ5dFRsdzdYa1BFREF1SFBxclZ0blUrWUp3MmVCT2RiTmNNRXlR?=
 =?gb2312?B?SVMzVHZGT0NpVnNKTnJScnErS0ZwSVIwUHNyTGl5c3dPcUVGWWVndXVkSXBY?=
 =?gb2312?B?WVZsbWNnM3o4a2NwNGNVckphNjlQVlJwZXRLMjRHUnMwbytOK080Q3llc3pZ?=
 =?gb2312?B?OTBQZzhHaWtiR04vemJpL3lQam81eUtOT05aQk8wQnNPbHVxQnBibDUyYmxI?=
 =?gb2312?B?dHJrSnJBNjRQNmFQeDNXZjRFdmp6TElZOE11YmZ4TW9NcHlYTk52ak1tVjlv?=
 =?gb2312?B?UzBPSkZDM0V1UjZBczRsV0dkM21iUm1kUURPcno2K0JLNkJNS3BlNTY1dy8z?=
 =?gb2312?B?WVYxcFd5MlozaHBBLzBtZnFxN01COWN6ckxVM1ZxWnBINkhwR3Rsd0hmaFlC?=
 =?gb2312?B?VFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76230e7-4ae9-418e-e755-08d9fdb91690
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 08:29:23.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8I1uYUK4VhAO3aOpdE7juhvobQiWpwg95ORiLZjHHS3jwpJXsb5hK9lOyRBhxOho7908cI/vErtC1y5N2Pt3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IEFsaXNvbiBXYW5nIDxhbGlzb24ud2FuZ0BueHAuY29tPg0KDQoNCkJlc3QgUmVn
YXJkcywNCkFsaXNvbiBXYW5nDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFlhbmcgTGkgPHlhbmcubGVlQGxpbnV4LmFsaWJhYmEuY29tPiANClNlbnQ6IDIwMjLE6jPUwjPI
1SAxMDozMA0KVG86IEFsaXNvbiBXYW5nIDxhbGlzb24ud2FuZ0BueHAuY29tPg0KQ2M6IHN0ZWZh
bkBhZ25lci5jaDsgYWlybGllZEBsaW51eC5pZTsgZGFuaWVsQGZmd2xsLmNoOyBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBZYW5n
IExpIDx5YW5nLmxlZUBsaW51eC5hbGliYWJhLmNvbT47IEFiYWNpIFJvYm90IDxhYmFjaUBsaW51
eC5hbGliYWJhLmNvbT4NClN1YmplY3Q6IFtFWFRdIFtQQVRDSCAtbmV4dF0gZHJtL2ZzbC1kY3U6
IFJlbW92ZSB1bm5lY2Vzc2FyeSBwcmludCBmdW5jdGlvbiBkZXZfZXJyKCkNCg0KQ2F1dGlvbjog
RVhUIEVtYWlsDQoNClRoZSBwcmludCBmdW5jdGlvbiBkZXZfZXJyKCkgaXMgcmVkdW5kYW50IGJl
Y2F1c2UgcGxhdGZvcm1fZ2V0X2lycSgpIGFscmVhZHkgcHJpbnRzIGFuIGVycm9yLg0KDQpFbGlt
aW5hdGUgdGhlIGZvbGxvdyBjb2NjaWNoZWNrIHdhcm5pbmc6DQouL2RyaXZlcnMvZ3B1L2RybS9m
c2wtZGN1L2ZzbF9kY3VfZHJtX2Rydi5jOjI3NzoyLTk6IGxpbmUgMjc3IGlzIHJlZHVuZGFudCBi
ZWNhdXNlIHBsYXRmb3JtX2dldF9pcnEoKSBhbHJlYWR5IHByaW50cyBhbiBlcnJvcg0KDQpSZXBv
cnRlZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPg0KU2lnbmVkLW9m
Zi1ieTogWWFuZyBMaSA8eWFuZy5sZWVAbGludXguYWxpYmFiYS5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vZnNsLWRjdS9mc2xfZGN1X2RybV9kcnYuYyB8IDQgKy0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9mc2wtZGN1L2ZzbF9kY3VfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2Zz
bC1kY3UvZnNsX2RjdV9kcm1fZHJ2LmMNCmluZGV4IDdhNTAzYmYwOGQwZi4uMjA4OTVlYTc5NzM5
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ZzbC1kY3UvZnNsX2RjdV9kcm1fZHJ2LmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9mc2wtZGN1L2ZzbF9kY3VfZHJtX2Rydi5jDQpAQCAtMjcz
LDEwICsyNzMsOCBAQCBzdGF0aWMgaW50IGZzbF9kY3VfZHJtX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQogICAgICAgIH0NCg0KICAgICAgICBmc2xfZGV2LT5pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KLSAgICAgICBpZiAoZnNsX2Rldi0+aXJxIDwgMCkgew0K
LSAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBpcnFcbiIpOw0KKyAg
ICAgICBpZiAoZnNsX2Rldi0+aXJxIDwgMCkNCiAgICAgICAgICAgICAgICByZXR1cm4gZnNsX2Rl
di0+aXJxOw0KLSAgICAgICB9DQoNCiAgICAgICAgZnNsX2Rldi0+cmVnbWFwID0gZGV2bV9yZWdt
YXBfaW5pdF9tbWlvKGRldiwgYmFzZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICZmc2xfZGN1
X3JlZ21hcF9jb25maWcpOw0KLS1bQWxpc29uIFdhbmddIHINCjIuMjAuMS43LmcxNTMxNDRjDQoN
Cg==
