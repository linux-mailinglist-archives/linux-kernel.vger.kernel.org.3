Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83559CD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiHWBEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHWBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:04:23 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797B5723D;
        Mon, 22 Aug 2022 18:04:20 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNponJ022879;
        Mon, 22 Aug 2022 18:04:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=5OA6wQDiLuOs1054EmiLAZoPEIWrI0Zypnio+89fBuk=;
 b=NVp8VztadPJ8yRbD6zqZt8DENgmPiSo173huNtX3e7L5jFN646k9ApB/j1bT8hq8XAdW
 6u3reYDufNo7oVzms/b0CP78JYBS4kWN3MYCnbLtjP0LEcBZUaRB07ckxfkf1UwLpy7T
 OboWkHwu2Kso7PUwCoi3rYE7pqKcyToFit4wROkdk0I2inW+fqHhocs9oPHYGhaYzWou
 acu6CJFAgDf4DX8Cv/G7gZE6hwVFEgheuZDGCzIHUn1M27LpgPZYNPW4sUY0s6qtNiEQ
 PmGsgF/zOHyobcgdiiae/A7NTKwM1YZcjY7jYqn39v6zU7a1vHdfg7v6AvySke2/Urn3 CQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3j2xmkt67r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 18:04:08 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A6C4C00F3;
        Tue, 23 Aug 2022 01:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1661216647; bh=5OA6wQDiLuOs1054EmiLAZoPEIWrI0Zypnio+89fBuk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W0DC6krdZgZpje9L6wW+5jQPO2FK2iBnCXkARislD0a8UDYWlm50Z9LJrfFZyYb8X
         h75mI7ks0LB4sv1GJWcGMBMhAZAU7t52CYicpPGoKBW0TlPPWKyc9LEb5V+TCfLoYG
         aMVPs6wII9tyLWD6gTpCzJ8C2dU5RkPYb4tbBtX8hakSR6ZEzo7jBlrMKGg1HneUHl
         x0j25YmD9lPgU0aouPDgyD+4Q4a6MUgmAogTisW9OBjr8MzkCt6vBzlklfzBTJgsPp
         fudfgEZ9y2nFw1W50dLwSZfm0cqs9HDaNvSkYsbN+6OeNsM9kmQkiqTbHzFWN+bbWM
         F8r9+z3HqJkOg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6C47BA0071;
        Tue, 23 Aug 2022 01:04:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB9B8400C1;
        Tue, 23 Aug 2022 01:04:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FY0BgMOB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmli+ohmSXTOJ+UTaUEqBZo0QEsGFt4DAwiPjpZf2cWTkaEGLz13NEzhUHBEnDtfJhYHgiIPWnFuLa9f8UdmFUxKZRBLq6I2veiKxAfCG8c6G8dbe1CUgxrMpWSW6+KgmhS2ZNnvfgS8CZAo/J8h3y22OiBYaGEA9VF5fLyBLMFmi2FB3UtXspEjRUZnosAvhHkRAmJ4jDCCB7R8Jzzqh4CRXfgwspFiNgvJdaOS9/mPlgvTDA77j70Ypza8DNk8z4+mgdpAc9k+Qa6S3miL/iy9WAsJuGfmCEJRJH2pAhbMtQ4qPBqGDU7bB4aXx59sL2WzOZcSLXxLwB5pZEnFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OA6wQDiLuOs1054EmiLAZoPEIWrI0Zypnio+89fBuk=;
 b=ScIfOIYegq5iMD3mXRcYXllYWrbHC6uGGzts+7gEaBr310+BrgGCVQjXTo3N9fRcYre/NiJAcLpiI/LOP4pTyw/enYInlhBz80cLHcFLMwy1q/MJ0W1BV8qo800kTRCOXtN3Sl+itqdQXLt6PtI3M66rwxajA+cyGL0i+xmkY3UDdNjscQc6zMFz6mOSirpbaw5PIrp+m0j+Uu3zFrKPaoZy2N1imYkWTbA5VhQouXaeK6uh38PQB1Qa89+RVUtznnByA/NtyuTBHInM0HdncF5RTJihPG9fg/vbl9JKBU3Qz4+j3BX3hGfG+KB7918ciB7n563cf0b2ItGm8ltDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OA6wQDiLuOs1054EmiLAZoPEIWrI0Zypnio+89fBuk=;
 b=FY0BgMOBi7kMrgCR9+LEGn8d6+tG9ipMtLy0wYdbYmdRp30e3egWWM/g2AFCSTp3VVGfV4DKRHnknnUi+GlQwsi6rVrYHg3TTQmRHKdTtNx0N164PJmTPtGU89it2xfTLP4H3SHO1gIY7HkXTqdXacBF6w7Qymw98ADYiC2oFyk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR12MB1811.namprd12.prod.outlook.com (2603:10b6:404:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:04:00 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 01:04:00 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v4 7/9] usb: dwc3: Increase DWC3 controller halt timeout
Thread-Topic: [PATCH v4 7/9] usb: dwc3: Increase DWC3 controller halt timeout
Thread-Index: AQHYsrli0QJkm6I7H0uemuJeCdohs627svKA
Date:   Tue, 23 Aug 2022 01:04:00 +0000
Message-ID: <20220823010347.abjxboojiporitl2@synopsys.com>
References: <20220817182359.13550-1-quic_wcheng@quicinc.com>
 <20220817182359.13550-8-quic_wcheng@quicinc.com>
In-Reply-To: <20220817182359.13550-8-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c94df24-b7ec-4e4e-c818-08da84a35d5e
x-ms-traffictypediagnostic: BN6PR12MB1811:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cV+xLpVM9SEYiZCzVgK6Zk9jkoY5BgGBPoRKTEZuG9Jc7ltCyGen8f+FbGMpYir9rTDqRlj6FEk+gVRUmzo5dVVVLIMOrEuuUFv+0Bfzi+rtqlsYxnZVlLglkrMbX7i9xl8WW/yD7l1IgmykWsTbYv2QNPhq538h/Rde+5M0r1OYbUNw5+y2O8fLPQDx8NXIDSW5uWs0G2njo+p31pUtVEBqvbsp91YP4cnq7Nqaruw9JRNZb6YekYhN572wWbPjCDpp6Wxvsnm/PruIPbTtA7x+3nozGtarcQdViishBsYwjGO8ebTwuw24qdjcUEge/XmFY3f7F9Td+e5HoyIYLGvAZqM+KlXb0G2O82/iY/g/jeUgWUT+kfeQRcj02ZJ6l1ot76IPBOrasb3kJ2Xo/zdN/C1wdpvJHzzMaYosvzi9miWR0+lBbtv728C9hx9eicZpT4NArUhCKtno5Qajoa0ppqPW+63056o7msDo+0b4pyRJWXq9ToLaK7uSYI12dkVeMq1jfLxLmZbwqMGIPKMc/4tTdegZaJCmfS7tD0WHjschQ5vK1lCKLzJ4b+h9miVp9vKxgBEmFiR+nC7lScwLzSFiX7qseqPvODw/THzwzkbv1FzaecM64O/qxAKfJg6EMjcAQaSJncIgHborodyT5u169sq8ZH+e89heUqnYpfS+tdQYZdUNYdsJvVz3ossWb5BK4Jm0+nyMtd+vHPPhX7jDMT9Ibe/9dpXpZ8ke8TVPi6xxDJQtlosDUdMqE7a8LCBVb2XeznXJuMCQaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(39860400002)(366004)(8936002)(122000001)(26005)(6512007)(71200400001)(6506007)(83380400001)(5660300002)(36756003)(4326008)(64756008)(76116006)(54906003)(8676002)(66556008)(66946007)(316002)(66476007)(66446008)(6916009)(86362001)(2906002)(38100700002)(1076003)(2616005)(38070700005)(478600001)(41300700001)(6486002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnVhYW9sVmZ6Y0lWa1J4T2l1MkFzaE95OEtReDEreWJQSDBxWk1wTUZIZko3?=
 =?utf-8?B?SGZuQk1uOGZTRUZWNWhQQWEvZk4zdG9MZGZYL3ovSmtaWUdKN0RhZzdudm1u?=
 =?utf-8?B?Ymc3Z3pCd0JsU3MxWVpDN2hVTytMMkdITHZtSzNCc3ZKQ0luaXRncE54NmNI?=
 =?utf-8?B?TDRWQ2UyamVzckVoT1gybkhYYmJob1F1UmkvSGd0OVFXdlZHNHd2T1B4UG5T?=
 =?utf-8?B?cStLQ2F6eGxGNU52K3BoZTIwVGhRZGgrMGZzKzlVZkJTTlZqdnF1bWR5YTR0?=
 =?utf-8?B?NEdXSWVJNjJEQU5uNnVmWUxyeW9KTHlrdTd3THV0UmlidVpNNzlHeUcvdER5?=
 =?utf-8?B?cUs4YnJiZmlIT21qNWRiY0duMk5MaDczMktpTjUxSmhnZDlQcnlEaVRlajFE?=
 =?utf-8?B?bXcyTmdzU1I1OTFkMSs1N1k4VWFLT0Qvb0o3SXRVTHNweWpzNUdXb3JMT203?=
 =?utf-8?B?NFpTdDlBNWlOd3hsWmQrVzdmMFUyY2p6RWNaZFFyZHE2Mm9JeXFqZmRqK3hJ?=
 =?utf-8?B?b3dzWkV2VklpckxmR2NQRGM0d0s4RGFqMkd5SENYeTRvNmtkVkhKdUQ2SmZV?=
 =?utf-8?B?elRzZXBGOU1ET01KZDNVWU1TWU5mSFJvZXhRUkFrY284bVlWQUlvQ2VuTUxG?=
 =?utf-8?B?VVVjaUxzck9qY2p6VFN0OURMNkJlQi85UURJWWRMZFg3dEUrVUppRUpiRHlZ?=
 =?utf-8?B?aFF0N3FhaVlVNlV0WStvTHJHSEcvVE5rWE5CSkJ0VzhpYitmRnI0ckJ6MlFF?=
 =?utf-8?B?NnRObEZiMkhZdlJ0VkNOUVU1V0JMUWhrcXFuRktyU215UnFtRW9pb0tQcEhv?=
 =?utf-8?B?a3BRTHlxdWFOQUdTdlkvcE9UbkF5Q2dkTjAxWkFrRzZZOGM1MVlYZExMdFFK?=
 =?utf-8?B?NEh4UDRycGVYYnduTmlkSjUxODRYSnVHR01IekV0RDg3R0Q5L3VNMEFHK01Y?=
 =?utf-8?B?QjZveG5WbUQyd3QzNm1wN1Q4MDZQMkdES1lmSkkyK3pQa0hMd25pTzNsRnhP?=
 =?utf-8?B?ODQ2a0ZLSTN5bEhNcUM0QzJVZDdqZC81L1J0VnFtNVlOd3A0ZW96bGxzSWZa?=
 =?utf-8?B?N04ybDIycThYK0QzV2QzS0RBMDV3M3phL1owN1FuYjd0c3pWY1U2NGhUejBw?=
 =?utf-8?B?RGkzYVpVSFNOajU2bGJxYlF0QU5GYzRURnE5cjZiZlNiZXZac1Bqd0pnQjhK?=
 =?utf-8?B?T0NuV2JWVXo0blNaS2ZBalhXRlppb1QyWkZtNWdncmZ2dEFkdzIwWnI1YXhq?=
 =?utf-8?B?dDE1SFcwS0UrSG82a0cyYWRLeU52aWxoU3J3b0wybXFyaGNIYXFQWkZZZ3R5?=
 =?utf-8?B?aXBRYjUxVC82L1lBNUpHQWFjWDlNYXEza05BT0ZkVHpqUWkyb3I5WXBYTkxm?=
 =?utf-8?B?K25LYXBYOFI5WXV6NXRiaXZESkx0NW1DazJKdUdUWUk5amt5TC9KUGxDdU9x?=
 =?utf-8?B?UVBJcW9MUWcvd0hkUllPRzQxVlFvWC90RTdUR0N3c29hdkZXMG9RNTdJWUNF?=
 =?utf-8?B?TzVqQ1FCekZWaTJHY1hmZzVBd2ZQQXpvQ3RlaFdKVFVGL0s3QTU3cG5YVlMr?=
 =?utf-8?B?ZTdQOTBYMDNlZFA0TG8za3JXZ3ZiNStCZjdMMGxNelBtU3ZvTXNNYzd0WWto?=
 =?utf-8?B?TExjRElCK0ZOR3JYaDd5SFJmWXVZNDdVUTBlRkZXSlpscHpWc0I3ajVTbHlT?=
 =?utf-8?B?M1d0Um5nY21IbTZKZjMxTnBDblJHT20vMER0Y1c5TE5HTjZzMXdPclJ2bU55?=
 =?utf-8?B?ek1hNVlDMDI0aEFBWm95UldONHJUSGhWWHNaM1JSdlVzbzhRQklrWXgvKzVq?=
 =?utf-8?B?d1BBTkFEdDN2ZGVsWDRFL0NFdHl5bVZiOHc4RXBic0xtbEUrME5veTFvV215?=
 =?utf-8?B?Z0xsTXhxelM4N2RweXViK0o5TWMrNUxaZXQvZVRnbjNpTHVFU2hraFIzMFVx?=
 =?utf-8?B?UFNYbUV3cHQxTldnT2tRRTVuN21uZzVJV2hESEtVTFk4RVZLYXFGenA3ZzRE?=
 =?utf-8?B?WnJydVhiRHBFTVAyMEIwVkFwMU8rbEE1RG14WGNIdStHTU1CRjA0cEdXaDhS?=
 =?utf-8?B?VFhOaW5jdXYxZ3B3SHBic29XOGZzQTlvV1hFTlJkSURuUytubE5EVkVrYW4w?=
 =?utf-8?Q?NwE1wd0TIyEx2j32F7lulXqyL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE050EE869521842959486D7EAC9501E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c94df24-b7ec-4e4e-c818-08da84a35d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:04:00.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNFbtv9+2KSSb36mlGQ1KDeTzpiRS2HPojZld4s93otQ8olo6eGpzS54j88rfejNdWWyLW44Sg4kr/wMLZiaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1811
X-Proofpoint-GUID: CAp91h7ehd8WcQRnyg3cgp71TaP2KsMc
X-Proofpoint-ORIG-GUID: CAp91h7ehd8WcQRnyg3cgp71TaP2KsMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=761 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMTE6MjM6NTdBTSAtMDcwMCwgV2VzbGV5IENoZW5nIHdy
b3RlOg0KPiBTaW5jZSBFUDAgdHJhbnNhY3Rpb25zIG5lZWQgdG8gYmUgY29tcGxldGVkIGJlZm9y
ZSB0aGUgY29udHJvbGxlciBoYWx0DQo+IHNlcXVlbmNlIGlzIGZpbmlzaGVkLCB0aGlzIG1heSB0
YWtlIHNvbWUgdGltZSBkZXBlbmRpbmcgb24gdGhlIGhvc3QgYW5kIHRoZQ0KPiBlbmFibGVkIGZ1
bmN0aW9ucy4gIEluY3JlYXNlIHRoZSBjb250cm9sbGVyIGhhbHQgdGltZW91dCwgc28gdGhhdCB3
ZSBnaXZlDQo+IHRoZSBjb250cm9sbGVyIHN1ZmZpY2llbnQgdGltZSB0byBoYW5kbGUgRVAwIHRy
YW5zZmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdA
cXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDMgKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNTdkODNiM2I0OTY3Li41ZjI1MGRmNzA2NmYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBAQCAtMjQ0NCw3ICsyNDQ0LDcgQEAgc3RhdGljIHZvaWQgX19kd2MzX2dh
ZGdldF9zZXRfc3BlZWQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRn
ZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29uLCBpbnQgc3VzcGVuZCkNCj4g
IHsNCj4gIAl1MzIJCQlyZWc7DQo+IC0JdTMyCQkJdGltZW91dCA9IDUwMDsNCj4gKwl1MzIJCQl0
aW1lb3V0ID0gMjAwMDsNCj4gIA0KPiAgCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRl
dikpDQo+ICAJCXJldHVybiAwOw0KPiBAQCAtMjQ3Nyw2ICsyNDc3LDcgQEAgc3RhdGljIGludCBk
d2MzX2dhZGdldF9ydW5fc3RvcChzdHJ1Y3QgZHdjMyAqZHdjLCBpbnQgaXNfb24sIGludCBzdXNw
ZW5kKQ0KPiAgCWR3YzNfZ2FkZ2V0X2RjdGxfd3JpdGVfc2FmZShkd2MsIHJlZyk7DQo+ICANCj4g
IAlkbyB7DQo+ICsJCXVzbGVlcF9yYW5nZSgxMDAwLCAyMDAwKTsNCj4gIAkJcmVnID0gZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfRFNUUyk7DQo+ICAJCXJlZyAmPSBEV0MzX0RTVFNfREVWQ1RS
TEhMVDsNCj4gIAl9IHdoaWxlICgtLXRpbWVvdXQgJiYgISghaXNfb24gXiAhcmVnKSk7DQoNClJl
dmlld2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5o
