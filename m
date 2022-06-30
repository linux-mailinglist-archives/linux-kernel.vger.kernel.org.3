Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E3561238
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiF3GFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiF3GF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:05:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D3F167D1;
        Wed, 29 Jun 2022 23:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656569127; x=1688105127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aH9kEk2qnDrTtQCfKom61OZ4HEX0rQOrddTbcjy2/A4=;
  b=apz2QQYLDGYwEJ76Ph/iLCLo4qWlYen6poF1TMSSmkHS7krjrqVJxzC/
   8EqGavWZGMcX/gfVFGUrexISfQjPkFe+5CV8t6QMkZQBXKYcAFB7q0gRC
   6E8f6w1G1WLBx8SXof3Cj5t4PDxRs83bIFHBgxcxdgn7aH7kiofSYdXuz
   zAiDo6sgll2F8o9HzKMQIRO+dnXmjHUPyeofyh7q2C0ankADaAvf/dcis
   pcQcqQ6XHOU+QiqQXENjpSghFPYL0CilvcL2Un+2n11Qd2uocbg5fgVX7
   8Uc47lCXaNNYUErkPyro1nnX0XNQ8Lxx/d/TSdwOErFc3qdDuPq99qHgO
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="165764328"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 23:05:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 23:05:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 23:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUXbh/3awEn18nEKelfZsjbvpP3uaCQ5T6SWstZY3vhEY14U4yh4wG0RlJZt/ceRDZ7H1ypxbIUpLivR3dHNQhxHeNfx8QUFjm3K0EBUyhP3pvTw5RgPwHSq9LWXNwtHgYropXmHIAUbMWscT6/yN/3GhzDXVUVN8UGGJe4WJO2yyYYDKXCp7TZ2kXxitjf6VzdrgplED7vvYuIHIV7qWHgix82o3rm/o2XB3ZVI1GfstMcrpqaMRKtiwJ3ntVRn//ZdtnrFPRG4hXG60Ctesspu/hMKRAXpzO840TU0Jzf4Q4NFRVPNxuCQ1fuaLIywtBbUpvxNKRnPAv9gakJxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH9kEk2qnDrTtQCfKom61OZ4HEX0rQOrddTbcjy2/A4=;
 b=HLSlwmsyAC3MZxmBZ+LthPaDtw/PJP5rKKNpAaOSch4wf45ZlPhiNZZipD1cXlrfaaubrEKFrZws1/GyEllcpEHqFiW7QytjDRdDkqk92rAlifsXTesQbrhd/0BwVF+J39ACwvfbIulFYVg5PA9GBt2DsJBIYcdhcRgp0+G6QofYyZ0JAC5gxkRVUntWJMwBQfoamZdmabltUj2i8Bw0LTj6nangmKlYPPnoiQW9EnBLLbfqFp5ed9kalWVyP8kcW32y9JAijJUx0oFx3vsSP5+FgNR8cvGezsfgaLoAwsbEC+jW+ceHCiOt+5vacY1YT3vy6fzhM1hhAXQ8Bsvk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH9kEk2qnDrTtQCfKom61OZ4HEX0rQOrddTbcjy2/A4=;
 b=kolwJ0juWF0jEwR/Y6RynBKWDN7VUWO6itLuMOiOOF8N0weAeJZ9WleMz7w+pwe/ul7J2czcwiv5+wvM4srWHKG0lczbvD/IHsr4f5HQTiQsIrHeUZBILNX6GCWi8fBU3ACTJipbJPv0GqRkLEAhku/g+PKuoi2MrNc+szFpFJI=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 06:05:21 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 06:05:21 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <robh@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <UNGLinuxDriver@microchip.com>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYi7hgu9BbfCeInkGneSj5bi0Tm61m+gyAgAB9RYA=
Date:   Thu, 30 Jun 2022 06:05:21 +0000
Message-ID: <cad8d9fc-35d9-8790-b60e-c4f0d60a7b22@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
In-Reply-To: <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62bb6f89-dc03-443f-0861-08da5a5e8401
x-ms-traffictypediagnostic: SA0PR11MB4527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaOq0mcrr/4S1PUPBmYJSqRgVe/Yp88tz5GVSMXLqQmKgKGMvDvRR4xOVN+mnFPtYHm3LFX7OYE/SiuUGDo5b+DD5tMjJge2qm+Ud9erL1I5K/NSxDpfermYMx0cAqOEqHSqMEoKAli1CTYD0gj9SQ1sZDfznS27UNxiJftVRw0iJGyg4nDn5N1CWhLhVDeXOR8BQLGwo38vAbqtSjplB2Mmh3fXGd2Na80Rnsdw0vVo+7SARLe9btExVG7O7GXEfISFwopCdqP12Ilrjd3IvmL3R2OoxCfTHsfddDcj7ODToGccuwLX3mq+PFwaUQ0N1ZECGvde7GslQW76AJNvQLYJC7vY6nNzVRBO2lBHAGeKBIMxNkqSvSSvbUdieclGoo4TN/052JZiyC81jztPhgNhDJATKbZUeGXfYBJH27i0WDTOtXWnMc3yFJSmSP4I7c5VIPQOqDfsJrGCCzLSUbkKBpVFoqTNUloYZACrJZSDTmf5Gw5iPcG0fTbag4wyklyUqfL1a6KRao2H25hnSUC86iJ6z+8pvz6xxTLw0UGdJH34I5/e/fRr+gL1uCauVKNR+vgEENtkxx6krkSx3nCS6tGvP31IIr+Lj0vPthBGdHpRBO/QrCD+XUIFufLBaO4AeS4ERRcbfNt2YvdSW1ndNsMC6Ok3xwCvOuK3EmncNQDpVwE0bTGB9DzgAchMzizx+0ynAuywKgkdVtuxVkV766SUZ1yNY0yL6rqmvfYbCYdI6qLISB44JHw2LddvyQOj6UgWom4M9YubXalmU9IVZwybBqvwuJFu1T6B1Lj1PWvuvZjQ8KWgld+0zQOSG4gcEDt8QiUGkUXkDW5/FvVPbbZrtg0n7fqCxi8rBgjcMTRWJOmfvq5AMbNh+aeL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(366004)(39860400002)(83380400001)(86362001)(122000001)(36756003)(6486002)(2616005)(53546011)(31686004)(186003)(71200400001)(6916009)(2906002)(4326008)(66476007)(66446008)(66556008)(31696002)(66946007)(8676002)(478600001)(8936002)(91956017)(26005)(38070700005)(41300700001)(316002)(54906003)(76116006)(38100700002)(6512007)(5660300002)(966005)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1JZTnZlSFM5WHhvSnk1VGFoNmlocG9pMHBCVDQyWEVacWhXMzhlVGxlb3ZM?=
 =?utf-8?B?eDdlOTEvMlNnSGg4ZDZwa1o0SjlwRjlDRmRXWkdrS0JLaXZUOWJFbmdhNGly?=
 =?utf-8?B?MUl2RXZqUWVKbEdyaTVkWkl4bXJCR0pTN3htSEZ6S28yak84ODFQZ2g3Y0pl?=
 =?utf-8?B?elNKdmxOVHFIYlhzMzkvNXVYVm0zSm1iV1RWZDEwb3Byb3RvbUluSnhPbXV1?=
 =?utf-8?B?K1ZWUkJVZFNiekxGSjVlVngvSUxWaThrSm95c3BCQVUvaVlnWWFkM3Z6cDJj?=
 =?utf-8?B?cW1Qc1UvUU1CMVJwTTNWR3pUMDdxK29kWWgzV1dEM3pDOGk2UXZ1SjZwZndj?=
 =?utf-8?B?QTVmYUJEYVcvNlZRdWFic29SZmMvSWE4bGw2MVo0R2RJcHRMTXZTN2phclE3?=
 =?utf-8?B?Tmk4VzU3dzJvb081Ti9DY3NRQVY3S1R1dFV5MDBVMHBidGlOanZTWmZIQVpv?=
 =?utf-8?B?SGJkdTJqM1d4dG4wcDJLc3dTcHF6YWhuWkVOS2l3NDBQSVZkMlBjczliZEQr?=
 =?utf-8?B?UkQwTGgxcTFuMWFjM0E1bUQ5U0xHamorZVRUM0lrSkV4bVJxMHVCcDJnUWNV?=
 =?utf-8?B?ZzcxdEVrTmszVk9md3JOWWNTOVlqTFpNbkhpVHpzK3lhN1QvMmd1VSsrazR1?=
 =?utf-8?B?YUUwbTE3K3VPb05rQnF1K3VJZHdSQVhZQlFxa3VuaW54TkMxY2FtTVJNYmNK?=
 =?utf-8?B?NkMrdFJTSVFpOTMvcFh2SytFZ3I4UVR3OVU3cmx4alZVSG03T1h6TEUwS1pv?=
 =?utf-8?B?eUl1QU1rQndrQ0NyY2dYNko2U2g0eVM5MWZOcEJUL1l4S0pqU3FybExkbk5Q?=
 =?utf-8?B?MWlQUDNkaCs1bXBQeHc3ZzFBOStTWWxDVG1Vd0lmbHJyVG9FQ0lrOTN6dGNB?=
 =?utf-8?B?VEhUdS9BSzJRaWt0cU96bHlRNUVVOFBHRTQwM2t3eTlsR3BUYkQxWGtIQWxZ?=
 =?utf-8?B?M1RaTVZPZjM5VmVYUy93TlJocmYrbEljbC8wM05OM3Vxd09vc09RY2tjLy91?=
 =?utf-8?B?a3JGa1c5UlIzbDBJMVl2aHpMU1p2K3pVVWlISHo2djFFUXkwdE15bGc4NjY5?=
 =?utf-8?B?bVk4MW5nNkxCYkNMSWRTWkR1ak5lQnhkSzBQWjBsb29iOWVtNmRjc0lLYXRP?=
 =?utf-8?B?L1BkczBTZ3h2UG9qNUcyNjlPclVKZjhhd1kyODhJcWlibDl1TEtUbnFraEtQ?=
 =?utf-8?B?aU5adjVRZk9mR0R1eUVQL0V5bm5JUnNsZjhSUHAydlJJUm9oNE1Za2NNejNr?=
 =?utf-8?B?QjJyT3JCTFhlYUdnbnp5MVVXak0zRDRFdm1PUGt1dXdpR08wS0p2ZWZlLzE0?=
 =?utf-8?B?TGsrcldJS3JaaVRKc0FBazM2SU5nR053dlJuM1RQYmZpT3FRZGlXdFFDeWRm?=
 =?utf-8?B?T0k5ZjVrNHNYaEdCQXVUc0h6cUN1M2xDWjRCRE1USVRoUWYxQVVKa1E3SDdP?=
 =?utf-8?B?S243NkR2TE8weUJFMnBzbGYyZEhpMWxIRGZOeisxOFEyS0dxancwTTdWOWsy?=
 =?utf-8?B?Si8xcTIwbUtxMnRsbFpGT0VzTWgxRDBYSFBmUnJaSW5IOFJ3YTEzbzNsTUph?=
 =?utf-8?B?WlRMZ0czREhxb0xyMnlORnMvWGZuNVRhWHBSOVFFalhvZDdlMVVGVUthWUNm?=
 =?utf-8?B?Q1JYZEk0Y1BvMDNzRzhxcFo2RzhXbnhDSHZaQ3RuUDA3ZWdJanJ1TEU0SEsy?=
 =?utf-8?B?RGFNa25HNkJrSGlldGxmWVdBSklJNVpSVjd4SEJFQWJnOCtSWkZOM3VuTUg4?=
 =?utf-8?B?MzVIWmJKbG4wQkUyKzYzaGJ2ckZFMitnYlVsS2NyVllzanhVajhmUkVOamJZ?=
 =?utf-8?B?ZmJTKzRlUVNMak9WdEtiK0lYNHRhZ0YrSWk5WC9WWDBERHFyUHZ1cmtyOXFk?=
 =?utf-8?B?OFhRK1ZMaEhDMStLVGxHbytIUUwxZ0tIUjZITnZxUmRMb1hISTdhazU4NGVk?=
 =?utf-8?B?a2pEY0FPaXJJT094UEhYbEJhL0lWS3NuMlo2Z2pRVjlFbDhwTWpMTDRWVDFJ?=
 =?utf-8?B?Q09xNWxLR2NSeW1KcUVpMlB0N2JDeUVVd0dsblFOOHROdE9NWW90bW12Zlc3?=
 =?utf-8?B?M3c4OUNoVE5CMThrYUQ2eDlJenhodUNrWTlGR0V6bHpCWDdzMTAxdkpXNFE5?=
 =?utf-8?Q?IYgQNrImFA8lTq7unePbXxdqU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6080AD4D2AEC8649AC94612ABC87D3A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb6f89-dc03-443f-0861-08da5a5e8401
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 06:05:21.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiKvhydV1NefLH5WN9lezkXPMc3f964ZFKvvvcxccJuk3X1mgOPxs4PjckoarNc8Ki+0z1h+O6eAJYaU1Cj+IpYqxWDRL0ByVmlxOLlgCvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUm9iLA0KDQpPbiAzMC4wNi4yMDIyIDAxOjM2LCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCAyOSBKdW4gMjAyMiAxNTo1ODowNCArMDMwMCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+
PiBDb252ZXJ0IFNQSSBiaW5kaW5nIGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBEZXZpY2Ug
VHJlZSBTY2hlbWENCj4+IGZvcm1hdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9n
YSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zcGkvYXRtZWwsc3BpLnlhbWwgICAgfCA4MiArKysrKysrKysrKysrKysrKysr
DQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGlfYXRtZWwudHh0ICAgICB8IDM2
IC0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKSwgMzYgZGVs
ZXRpb25zKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL2F0bWVsLHNwaS55YW1sDQo+PiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1lbC50eHQNCj4+DQo+
IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0
X2JpbmRpbmdfY2hlY2snDQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3
IGluIHY1LjEzKToNCj4NCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPg0KPiBkdHNjaGVt
YS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL2F0bWVsLHNwaS5leGFtcGxlLmR0YjowOjA6IC9leGFtcGxlLTAvc3BpQGZmZmNjMDAw
L21tY0AwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnbW1j
LXNwaS1zbG90J10NCj4NCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2Nz
KToNCj4NCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvDQo+DQo+IFRo
aXMgY2hlY2sgY2FuIGZhaWwgaWYgdGhlcmUgYXJlIGFueSBkZXBlbmRlbmNpZXMuIFRoZSBiYXNl
IGZvciBhIHBhdGNoDQo+IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4N
Cj4NCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRu
J3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBp
cyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPg0KPiBwaXAzIGlu
c3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+DQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0
Lg0KPg0KSSBkbyBub3QgcmVjZWl2ZSB0aGlzIGVycm9yIHdoZW4gcnVubmluZyB0aGUgc3BlY2lm
aWVkIGNoZWNraW5nIGNvbW1hbmQgDQpvbiBteSBlbmQuIEkgYW0gb24gdGhlIG5leHQgYnJhbmNo
IGFzIHdlbGwgYW5kIEkgaGF2ZSBqdXN0IHVwZGF0ZWQgDQpkdC1zY2hlbWEuIFRoZXJlIGFscmVh
ZHkgc2VlbXMgdG8gYmUgc3VjaCBhIHNjaGVtYSBhdCANCkRvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvbW1jLXNwaS1zbG90LnlhbWwuDQoNCg0KUmVnYXJkcywNCg0KIMKgwqDC
oCBTZXJnaXUNCg0K
