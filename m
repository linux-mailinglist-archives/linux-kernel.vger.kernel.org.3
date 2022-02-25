Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F704C470D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbiBYODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiBYODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:03:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0265198D0A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645797794; x=1677333794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B34EZUXnFYqm41OF0+N7NChbcaUh4YkL1vucE1SGYlQ=;
  b=1//1gXXgz0g9yDAp+BTlittwqwcEHgHso9s40erkUk9IjVrcEs3+MMtQ
   KBGvIdqZeCCPifi7I2empiUpHkFFe/BHMkPUo3xkTG1ofHrCCLjEQ3odU
   wA26Ol7soja//0ykUpYtdSvW/Wm/21D3NJzsmoTiQCm3tCLWYinaX1raD
   hEQqAvIXJcOMcZkqBtY8q8kdbCJSFbZ9VMMIM2PXPgd2Nb/VCU6zsOrzH
   YhIOdEfVbRrNFLJXPuvo9mdCtUWJoQmi0jaKO7hi6KBcMnGLH/9N/ehPo
   80laAiCzHOM4PkcOeFULKzcFzQxr8yY0dmZFOrY3l9D012dZfPeyLVnuv
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163650514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 07:03:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 07:03:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 25 Feb 2022 07:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbyZmBxGToNzjS/7DWbxwpCoG9lBM5rA5mctFOIa2DnqiuOYP9YRlEMa2KAQVdtJO5nlP5YQjHkF1tmZrv2GzkGvegSauB4sCOnfNCZjAd+z4OWGEDhsUoYSm/Dms/H8Rit94yaixaM1J64UmO7BAB96ZGoHVUofQKkUWoolnR6RcEtIiKRsbkf+6Lxg0YzfcoxOVjfXaiyDyZp/C9ZKzKGMp2HsBYW3BYxeFNffI81v4Qjrb61fCCZUIpp6Eg8uLqjnuGTCSMcK/q4o8DhpbqodSIFwOs71Qdz/XBZI1UE3j6geegygsl0HtlcdDb7FTBFFjEUZ272qGkbk7VTBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B34EZUXnFYqm41OF0+N7NChbcaUh4YkL1vucE1SGYlQ=;
 b=GsW6j4vfCxdJ/4v38L6yoWOE8BoKi7KF48kHVqRrQ/Co0/uvs1UgGXVwLIPJ0W7RlSYqBwwSiAP2qtk/fGKldtbHnzgr/ODClqPP3HX2cAMHTC6Hbeab0LoTA78miYxpVjVEaGp0zB9XbbYE/eavtkFBXGm/gIsDWVuuTLjh+E9SEgUILTzXtFlhbtdj3S8blh3qkyqeH4X3oW/YIorVdQfdHFiLJNVVaLewsvxvWCrsMf3yzgCvnfLXUAPZ5+FRt1YdjBu2ACN1JIMlbs8gtgWzleb1tUqI7IM1HJBn3SCW1EFtQ3MFiCTodjlfu+udCNflRFAll4BvoX5Yr+7+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B34EZUXnFYqm41OF0+N7NChbcaUh4YkL1vucE1SGYlQ=;
 b=db/8wp/y9Yv9R3MWfiT7w9Cn5VcWK47fQA2KGVDx81mbQIqRu7wqSvOuVr3CePWO1PpCGHUyQL6dYZjfVXfX52jyyRUa/1v5YTmyzkqesC2BiDfr0LVkleobiEQB/PQfVPMmY5I5XrYWrQRx9hT7BAKRyEm1jT+JA3Y6tyyIV78=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1298.namprd11.prod.outlook.com (2603:10b6:404:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 14:03:08 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:03:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Index: AQHYKlBqRJ8KViEGekaFpWEnk7/QxA==
Date:   Fri, 25 Feb 2022 14:03:08 +0000
Message-ID: <3bd0bfad-7f04-a972-0f65-21dea2173dd7@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-27-michael@walle.cc>
In-Reply-To: <20220223134358.1914798-27-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9716044f-d964-42f6-4640-08d9f8678d65
x-ms-traffictypediagnostic: BN6PR11MB1298:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1298AA677D80BE00C55A6E10F03E9@BN6PR11MB1298.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t85WyNxO0W4zkafPzdzdRxFQJbZLng5CpbKsSVDquZQrLimfaIF94mZVsQr+p8P0PFh2fhpJK87Wqdv0qLt1T1jdlydEJ+1sJbVgdwdY40OSvoy4e4cl53v+GS5wWV9kVlaDzpoqggbVArTinHwV2GKV0HhXRjMrQv12jWhN1/tnglqa4L0GVmELZpjBMXtyXKtRZsyvMVddR+jAN1446AmamQ58puC0oOGoZkY+hGGqhK+S7Qdi0etwVEAAle0z+mV1TioIjMO7tH0RvJvzR5OncFPPJOgXqMd0Rk7gqeOomo6ESSHwJmwypBtKc2878pVHOV3pEpwaNkkhBa7bCTwrKNH5O6MhBnpuGA4mZJbfrNnkJPLvNvevzfL3b91bwQ7ebwlE7iz1fyU1haUthRz1W0NDORIyufMQWhZ095cxCX/uBDXgTaLmefvMa1qx5pwheJubquDto5OP2X+4d7pSrzj56Shl1Kl2KDaiMQ2q6KQgeLxHrkG9Rqw+gTd9mxLBotrf/CiN907eztUi7kDK/J34NP8bqKCtMVR1rfWQIp35WG1Xq/wOhD0c75TGb503bqxo/nNjIO7ylhZWCdwCkJB2LUvVEkAw2RQhV2A4w+eP48dYJ3X13AbE7Myu6H4nLwaiBXbY63lchEEx3hzWZXPtELzRIFWf+1J89zgkX7GYAjt7ljuDou/8AL5jD7GdDc//x4Q27B7DUQfk129rF79EQzFBpH8B+Mh1E72F1W+bNvnTt5f+1yoVXYkfoJ+YjFlnyGPrqvMzcpj/kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(26005)(110136005)(2616005)(71200400001)(54906003)(66446008)(186003)(2906002)(66476007)(31696002)(86362001)(38070700005)(316002)(76116006)(66556008)(66946007)(64756008)(8676002)(6506007)(122000001)(91956017)(83380400001)(8936002)(38100700002)(4744005)(5660300002)(36756003)(31686004)(508600001)(53546011)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3F0SUtpU1g2bmtTbVphUnpmbTZnK0loaCtZamhOcEZ2OWdTVnVyaWc1UGg0?=
 =?utf-8?B?ek1IYUZkMGVYZS9VcHY4SVZJemJzNWdqdytSSGhtSXVMQmcyVGNES1hkMitT?=
 =?utf-8?B?MFhYREZlaVEyK2pLY3NSVVJDS0ZsanhQL3Q0eVZHUUFEczRWNUZMVmRLZEtQ?=
 =?utf-8?B?dk44TWJNaFJNWE9MWXpsbitJS3JsTGszTExNQTNxSmZiYjF5RW1aQkNib3JW?=
 =?utf-8?B?RDd1Y3RZdXJ4cUlmMlJVcE13b0dBcWU3V3R0L3J5a3NXZG5kN0UreWFZTGVB?=
 =?utf-8?B?SnhaSDl2eXE3N0xGZElsTXpGTU5WZ3Q4dnFmL0pMNHlaMEdNbkE2RXo1QTky?=
 =?utf-8?B?TnN1SXNhWlBNZlREQkF1b0ZaQ003WlBVVktYbGdOYnVlZlNIV1FqVnRqZ1Zq?=
 =?utf-8?B?RDJYOGNqS1BObFdHS2NRSnlMcWJ2c0ZLeGF0c3JhclJNR2hnVmJzT3crWHhS?=
 =?utf-8?B?NDJEOVpNNTJDZVVPYTA4dDBySlgzTndUWFF6Rmx1dFk1MWN5dFBQck83c1Jh?=
 =?utf-8?B?MkxVVmVwcEJ5QWNUZkJuRWR2QXJuNDdXVXJzK2RlNXJzUGlBVU9aNCszQU9v?=
 =?utf-8?B?VnNwN1hrK2M5aFA0YUlmNkVmejUzMXJqbDhxdjZWb3hTVThSdVo2UVhSaW4x?=
 =?utf-8?B?cjBiZDUvTHJpZTEyZGpBY3UzaWVuSHNxa0dlcU5ycmhGVWFoUklSNGxKajBy?=
 =?utf-8?B?bGVpeHlYSEd5NXIra3VGSys2dzFFUGJUblJLUGZUeXVVUXFWNDFHd3JrRElz?=
 =?utf-8?B?b25VbnFLbW1pS3o1ZkhLQW0vRjR6Q0NGN21sZkdtZ0FoQy9rUm1PVUdaRldT?=
 =?utf-8?B?NTBwNE9IRlYwMTI0THdwQjVFbTBOK2JtMzgwc2FUMmhSZXkrQndONml5Y1Q4?=
 =?utf-8?B?QmxaTzB0SmhBNm9rMGZIcXY1aXVhbWtpTUVGSkZUSjNxZmNRUU5VNmJ1T3ND?=
 =?utf-8?B?TWhmLzdENmgxeGoxOG4xeEl4R0orSGtxR3d2UXkzWjBqU3g3YzZOM29DUjRr?=
 =?utf-8?B?MGsvOWRGU2plMTZSa3doeFhNNDF2b1p1OUpZVGVCeGtsdFROOEhTYUpCOXdp?=
 =?utf-8?B?Z2hHdW9yWDlkeXFQWW9vUjdEelk4MGYrQ2gzWEg4RHJYdnNEWEVZR09uTis5?=
 =?utf-8?B?U0hOMnBBRFFzMTI0VUNBMXlFVjd5cTlMeVpJZVFaUnJETnBuVUxPb3ZBUUsy?=
 =?utf-8?B?bVlNYWlUbzdaMzFmVWZtejBmbVF2V0J5K08zUXFBcTlRMjYraHBQVFllWXIv?=
 =?utf-8?B?Tkt4YW0rVVhqS1J1VWJXeHlzdnM1d0VTQmdwQmZITWdlVnA2Ty9mdUpOanha?=
 =?utf-8?B?VG1RYlhYRzVSMGZXSlVRejhwaXgydDNtc3hKZXNrUDBKeGNGK3Z2amg2ZmRs?=
 =?utf-8?B?eDZwMEtEVG1PV0pJT0VDdytLN1hvV3lPZENqUHJRRDlZTmp3b29TQVpzWnhq?=
 =?utf-8?B?S0JndlowNk8rdHczbEhYbVR0OTF4NHgyQThMS3JaWjdoRjVreFZYaklsc0dR?=
 =?utf-8?B?bEtYaFBYQ1E0S3loRUxFRGw4dUVRSERhUUNjRnhpZ2s5LzJTRzFUNkVOY2VV?=
 =?utf-8?B?d2RuTkcrSWJvY05nVnNyS1lnREs5L2hHN0xzQU1iQlArWTFlNFNOa0xYSnVG?=
 =?utf-8?B?cDFVYWhUTUk5ZFUxb0hNVzVPOEFLODN5VjBQY2NDTlNtRVNpdGdaZU13dWtM?=
 =?utf-8?B?OUZ1aUhheGNxYWFzUm10UU56Q0ZtY1lxV0U2SXplYnlRNEtmcE9GTVI5N1BC?=
 =?utf-8?B?L1g2TVFXVjBESWw2TDNqNFEwcFVVY08rQVJNcVZFM2JqeVBtbDVhTDFXY1ZR?=
 =?utf-8?B?Szg0LzJ1bkk4QVAwUVRSM3hFUFRnYnlpMGVmU0FKanZleEdRNThwcVFzb05O?=
 =?utf-8?B?YVppV2Q3ZVd0ZFZYSmZXSzEwV1p2Lzk0M3ZuUHF1aWFzYnhRMmdROTJ1dWJ3?=
 =?utf-8?B?MEduc3c0Z0JpRFlEMy9RZU9lTFduRHVrSXZ0VHdJZjdjTEk1VnZqd3hVT05w?=
 =?utf-8?B?S3dZR29BQ2hFNXhTQUp4SXE5aVlESDA3ekp6TVpaM1U4VitMS093Zy9TclV1?=
 =?utf-8?B?R3R5KzdyZGVLMzBZWWhraHNOVXl4Nm9iYm1xZ053eE9qRVFXcVg2ZVdsT1gx?=
 =?utf-8?B?SlA2MjBqUDhCQ0k1MVpveEwrNVdQNzdqaWQ0MVZDYWNONm5GNzd2VGkxeU54?=
 =?utf-8?B?TVNUL0MzMFQ5OEF1T0wwMVhpZ0hMREtVQkZuS1hiNUthWENLWjJiejM5akN6?=
 =?utf-8?B?TmwvMTVaNTk4Q3NUcFpVNlhKTWp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF46775ED6C706489CC865AFD4977684@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716044f-d964-42f6-4640-08d9f8678d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:03:08.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+udRpdNGjnTlyupbXR0v0G4D2m6seHqO4IhN4QmOXqZGOi8asKdKnQRjxIRDheva32Lti0wq4O/DHjyg/Vfw9sIfMjF2nbOgPd96xPfZBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8yMiAxNTo0MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEcm9wIHRoZSBnZW5lcmljIHNwaV9ub3IgcHJlZml4
IGZvciBhbGwgdGhlIG1pY3Jvbi1zdCBmdW5jdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiBUZXN0ZWQtYnk6IFByYXR5dXNoIFlh
ZGF2IDxwLnlhZGF2QHRpLmNvbT4gIyBvbiBtdDM1eHU1MTJhYmEsIHMyOGhzNTEydA0KPiAtLS0N
Cj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMgfCAxOCArKysrKysrKystLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYyBiL2RyaXZl
cnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4gaW5kZXggMWE3MjI3NTk0YmYwLi44YTIwNDc1
Y2U3N2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KDQp5b3UgZm9yZ290IHRvIHJl
bmFtZSB0aGUgbWFjcm9zLCBhcyB5b3UgZGlkIGZvciB4aWxpbnguDQo=
