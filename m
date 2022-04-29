Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546F5143AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355410AbiD2IMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiD2IMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:12:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EBBF50C;
        Fri, 29 Apr 2022 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651219728; x=1682755728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k6XnJBhaLGLRXJ95CdLSGdJkqShiGtkM9b3fEumJB/g=;
  b=A2XAAq3LUY/l/x8jLVw7rwWoeFwI5t39QDJd3VD73ooeXU0lmaLdlZMn
   1S+4XEipJm3WeOhlX1yzjpZ6MJy14mvDgAXB31aWK2w7/++xRXhhvFu7z
   RwQ4yefV8za9o4dBVfxZ6LZc16Aon+gUWT8wh/Z9HJ5yTMbmv4aUJuQNY
   yqjCiWs5+144ZgHyyzYQ877HQcybtFTESVpS/956N2B4BkfJP3B6BOdLM
   h072radSuEWJiIBJtcMmbXBzYjLq3nnsrsxG9q9jKeM0M/LzPdz87FOtn
   Eub5qZIIgHgbjsbruZXbKTKBJdNk7figK0IADGhcdXknxiSw3tg+Mlr1m
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="94018680"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 01:08:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 01:08:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 29 Apr 2022 01:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjhzXPCnGUnrjzrS5WTj5ZwlFmLMcWT09eMvzjJtrvc2WNC0DSWG5Gjb4IQvdXAiRtkoCMzdgfMuxFgM4+gH1AWJUkfFi3Rrk/U/4XurHBOgXjmfVj7u3+GaA8mvcwSE9jOrbtYN9/ylt1IlA53O75FVSLs903SO6ih6SFOiu39Vtk0jUWArKsmdBqOxvBR+kszvjPxHHaSPglTUbzjdtaTyGQ+gHygYWTbKg+PBprhYsoo5rn6EmeqtVDgesUWzf2Ak/zBB4UP/N4UHfDZWHFJmLyROXQ8sIAitYNh0SmL+GDbh/3KI7mkFszHcZGcyvsPycz0Vb+Mo575bGz7bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6XnJBhaLGLRXJ95CdLSGdJkqShiGtkM9b3fEumJB/g=;
 b=BBT8/ltKglb73zBKZSESGBch9EsK04ec7GZblBAUrcVHQlkBVo1fEx7ZBC4zSS6gheBnMJJzk7Wwo2icMmnSSgsBeGyXfFJwkceDXTtwBXiRHbtGzFGWfTsbO8/VR9Bb/Jn9ca/M747yj3uGvtCyfbR+FtQucq022KTa7emW/OQanKhE8Vo/QtF9K5pb2QFokBKGXs8zWApmksQZWltJTCUqNgExLD8+a+pcrlxB4ertQHpUinp+LReKS2iz7hcCylLVzfYe67wWSL2LYb33Yd+cDjcugDEPjK0bEabCBMUpxVSIwqa/8GKdSALnRK8PIIUN4lZPC3r6KNpOCUE49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6XnJBhaLGLRXJ95CdLSGdJkqShiGtkM9b3fEumJB/g=;
 b=P3vlsqxZjXFFb2bL1PmfHw/Sfh3w8FHEoVW7kiVBzaAdQcHq7qZ9LJrdLnwWIA6/vLucSLR+rxRKhX2QRQRNSu7Qb7c0FGoQ13dP3oCB+MIWQ2DcMFpKdPnNCJN6haBy6eAG6AqXBU9eeeSUY/ibrDo62ZOGVlYKN4PJ8gpvNrE=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 08:08:45 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::39cb:eae2:1dbc:a5f2%8]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 08:08:45 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v9 06/13] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Thread-Topic: [PATCH v9 06/13] media: atmel: atmel-isc-base: use mutex to lock
 awb workqueue from streaming
Thread-Index: AQHYNGSh7JwrajNUDU+e7C67bQo/Nq0G0GoAgAAHfQA=
Date:   Fri, 29 Apr 2022 08:08:45 +0000
Message-ID: <2510d479-5eef-6ef6-5d32-41f70217eb52@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
 <20220310095202.2701399-7-eugen.hristev@microchip.com>
 <d3858845-ca27-9207-68a9-6d802a7d59fe@xs4all.nl>
In-Reply-To: <d3858845-ca27-9207-68a9-6d802a7d59fe@xs4all.nl>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edc5141a-dcf8-48fc-0fb5-08da29b77b71
x-ms-traffictypediagnostic: CH0PR11MB5283:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5283C799CC648310953F86BBE8FC9@CH0PR11MB5283.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yuMVL43aaU2B0+mPxDn2cb8d5v1QACiX4cXxNiPZ88M2H4BxLSt8c9O/VuZqGO0FGayVcvyfi2aQZq3K2F2XJhW47KVjFKQHH/+YX2FRcofOwVTVxK0AU3TAsedxMvGUZ6j1K5D5i0dab/oQm7VwDSMApUNY+GOcGgZywL/2pqdcqBJ+KDnqiTnI0W5Nu3cblB4WRyBKA9B1HeLCMbAFrJl/+tvc1M3B3OaFjHJPjeeVL/J38yPeN8A4y+WFnAzgrKCXuYUnKnque4H+pCBdEYG+YWwRlxh1SqXIUbjfoqr9EEUSx0Wup/VlBQjrM025lW1qMQkxXAmuIhuKGmXrlp4xYBQUybCqSTv77chJxFszkMF7JE5FeAb0mYbrNyRKvjqfWfSSd1LAivf4uYdl3Bo0RmTioQX6Y/tcrRv94CD4fr02POT9uAOl57IhrYyLXqBS3Ea2dZLzNiyjCo4jrIrn5yohH6JjgS6jDAMFUFAQRIoQ4VxxIYhEwtBrzf8tSqPuEtXH2EmcpsMzyeEK0xD+4gYkqtYz3r/FOnlQJm+XKzxe10lnx4XtWvUF8t+4+ypTIinMmIkHpzswb8zqFgcktSW0ehFpIrs1pzqHvEMSL+dGIflvqXU0UMo1QkDuiXhnM1J1gAtvvbrGUfhTTNJoN0Jd4MASBr9s09fNqnLDVEC2zeT47qehcA3n6v+8lEwdmAuJSZhZyZM7EFZ4g/7T+7hREp4QcrOH8TeMBDUqFT+e1PWc6It9VxIWafDCqWQRr+BP4rs6CUWqmcZwqrakDckc5dakrTcbsgjjCgcUwJwWZztMc8QY9hwV7QqZMVKemUYU+gBl6ZbTvzxJGSKW7zMM8gmAJ5/Z6dYwx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(122000001)(38070700005)(38100700002)(66446008)(4326008)(36756003)(8936002)(5660300002)(8676002)(64756008)(2906002)(31686004)(6506007)(6486002)(110136005)(66476007)(2616005)(6512007)(71200400001)(91956017)(966005)(54906003)(107886003)(66556008)(66946007)(76116006)(53546011)(26005)(86362001)(316002)(508600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emZRQ3F5SlpXRHplR2FTK2JkUXcxbDNYaXdvRytJWUpVdmZUWEZlZE1vdG11?=
 =?utf-8?B?d08rR0dRV3BXUDVpYTkzN2MvZzBBbXVNYklCSWRmc0VOV2FxQXpMZXhuUFBE?=
 =?utf-8?B?VXpvamtZa3FnRWFUY3kxaEdzcXFZU2NGNjZvNlBMbloxSlJaWFZaNER1bEVF?=
 =?utf-8?B?ZFR1NzNvY0pLWGo4dTNnNHJhTiszbFMwSmxJT0NNQzZaSHF0OEd4OEVWU2k0?=
 =?utf-8?B?alZxaW1kejMwN1c0cHJuUDFRM0IxRXhmdjNBWFg5aVdMM2ZQSTdybjlpQlFa?=
 =?utf-8?B?MFMra3QxSmc0enNQcWhHdFNhWVFpajNtZVFjQ1JSenl5OU0raS9ZcDdKR3ZO?=
 =?utf-8?B?VlFTaUJwNkVDdGh4OE43aFhGbmRwR1doOE50RzRTb1UraGxKdG1PRHpyWkFr?=
 =?utf-8?B?RGtYcCtNZnVyd3NxVFJTaGpmWjFlUWY2ZE9SUXkvT0VKTndpMEFrODhuTVcw?=
 =?utf-8?B?T2hGNWljSWJyRjJ1NUVYTVM2Zjd3Y0NKZS9vZXFNWW1jZEk5d1NPN0U1eVg5?=
 =?utf-8?B?L1NPbDZER2ZtZ3NlYU5IT1d5VzdXMXR5ck5DNks3aDRFUnZUdnJXNkVBS2hB?=
 =?utf-8?B?SnVnTEtnOEdDRUlmaG5FN3RBaHNBZDFLVERYYTRiK3oyMVlLVXdGU2xxRmZY?=
 =?utf-8?B?TFEzcWY2bEo3R21wNlNrcllxQkw0UHhzc0podmNtajdGOHR5YjR6emRSRkEv?=
 =?utf-8?B?b0lyQWRjMmtiRVNSaHFUWklxWCtiWFZRaC9IbnRid25pcHlSQnJ4UkJjdGVR?=
 =?utf-8?B?TU5FZHVtSkFFei9Qc3d0TEpLamhwTUpXNjRlWDBROG1qU3Zlby9CUTVnM3JC?=
 =?utf-8?B?YllYNmJUdWpKUGpoSTBESHVYSDFuOERXU3pZZk8waTJhdkMyLzByTklNTVZo?=
 =?utf-8?B?MWwwVHVpZmd4U3lKRjY3RHhKWGxWbkZKMGxMM3FhejZTeTJpdEkwcEdPTHFY?=
 =?utf-8?B?TTVqdVN5Mm9heWI5QTB5aDhTbkNjY09YODFCamJrdXlxZTUxN1BsV0xoVTl5?=
 =?utf-8?B?M3hmd1pzWGI3S1Q5OTRnbGVNZ3d2NG9pUU5DRDNQWGd1dEY2WXlucm1jNEta?=
 =?utf-8?B?c0xBdlhTM0lXdHNLd2lZZHJEUCtnVDRiYWY2UGpLVzRyQm02SXRkYVREOFJV?=
 =?utf-8?B?bGx6U1ZKSnZWK0dxem1sdlhEVmVscmxFOGxLYnp5RFVCWmUwdGF2dlMzUDAz?=
 =?utf-8?B?c1dOZmNDY0NKeWVnMHkwQWJKejY0dStuZzFVRTYxWDcvRmRIVzR6dXNuUnh2?=
 =?utf-8?B?R1hYUy9oZENxcm1id2RnM1hTTmVWc2FjSUsyWVZQUlVsN05kWVA5eHFZTjNn?=
 =?utf-8?B?K1JwMVI2MUEyZEtiK3dVdHp3cnh0ZkpWZEdhSVlTcU9hZjBpSnlDYnoxQ25x?=
 =?utf-8?B?ZFlONnN1TWFQR0hkWG4rcFlXb25lenQ3OUlsSWI4UkRuTjVxei8xSDlnc3Vu?=
 =?utf-8?B?WmVRYWpSMHhkSFczNldvRVZKWmErdzFFU1lOUnlreVVRbHlUbjJ3NDVJOTRM?=
 =?utf-8?B?eVFGVXRPZElJa0tEdHBlYlptaThpellKQUZtUVZtVVZoUGJhU0FBV3Z3cGpp?=
 =?utf-8?B?Zk8rR1N4K2x4dTJLR2w5d3R5NDZGa2JpYVVDUkVuY09ibGMrWFlMbVEvRUJH?=
 =?utf-8?B?dGNwQVJxK1paSXE0S1JKallhRzEwVEYwOWV2TVVHdUg3akRqc0ZvTy9XR0lG?=
 =?utf-8?B?enhyRTE1aUZZblJGaE5JYUpDRnBpM3VnNWxYSFU1VEJ2dzV2Kyt3MFZGQXNL?=
 =?utf-8?B?VHMwdnhsQ2FqZW1POXA3U05nNEpQWUcrVzFWYldRQ21YV1NWcnpuZDY5R0Vr?=
 =?utf-8?B?YThYMEQ4aHhLRjhEaTNFK2RYNFVTMzVMYzFIcjhsM204VnNlYXZQUnJRbDVp?=
 =?utf-8?B?T0R6cmROR1ZBQU15a2YxQThURkpoRzhMN1pPNWJIeDdzaXl3V3N3OG4yOUlG?=
 =?utf-8?B?SFgzY2RsTnpDdXVNb3I0ZWdYTWhINzhOdmhVVWx5N29OeU84enVBc1F6SGxn?=
 =?utf-8?B?cHF4dnRGL3R5dE1wTEpFa29XVmY0NzQ5aDB1L1NhbXlQejFtQTU0dmJrNkJY?=
 =?utf-8?B?b0UvdUhMLzA2R1NrODE3bEErNmtyeTJxNXhhaUpsVlY0N1NjR1JHRDRBRVpJ?=
 =?utf-8?B?b2Iwcm9ZTmJwN0hzRHdGSDNuSlRLK2ZXcUxCMU9xVzRZalNPWXpjRDBCMEtE?=
 =?utf-8?B?Q09PeUtyRTFkelNZN1pNMXhkQ0ZLZTR5VC9iMkdocitGQ3FPcUxPc2w2TVU2?=
 =?utf-8?B?STRjVFN2V3ZvZXN6L3IxNjliSXA4UDlyTlBBTHI5dXlGK0Q3Umc5V0M1YTht?=
 =?utf-8?B?ektMZWtTV29HUmNRQmNkSDFNREFpRDVFaFVvcExNNm9BVkZZQUZaejlCSE0v?=
 =?utf-8?Q?PAi9zIPt4g6MamXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CA74F3F93D2D043A1597A2BC4A47F96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc5141a-dcf8-48fc-0fb5-08da29b77b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 08:08:45.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ful/jAlMKpM6evO98OdNFklhS6+inHrB1kh+9T2Ef7XEbSswQJs7ELkPXJtjWlxsKmMO3mP0iv6H4HTy8Nu93EXmoQ9PL0v5LYRHSOqjuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMiAxMDo0MSBBTSwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPiBIaSBFdWdlbiwNCj4g
DQo+IE9uIDEwLzAzLzIwMjIgMTA6NTEsIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+PiBUaGUgQVdC
IHdvcmtxdWV1ZSBydW5zIGluIGEga2VybmVsIHRocmVhZCBhbmQgbmVlZHMgdG8gYmUgc3luY2hy
b25pemVkDQo+PiB3LnIudC4gdGhlIHN0cmVhbWluZyBzdGF0dXMuDQo+PiBJdCBpcyBwb3NzaWJs
ZSB0aGF0IHN0cmVhbWluZyBpcyBzdG9wcGVkIHdoaWxlIHRoZSBBV0Igd29ya3EgaXMgcnVubmlu
Zy4NCj4+IEluIHRoaXMgY2FzZSBpdCBpcyBsaWtlbHkgdGhhdCB0aGUgY2hlY2sgZm9yIHZiMl9z
dGFydF9zdHJlYW1pbmdfY2FsbGVkIGlzIGRvbmUNCj4+IGF0IG9uZSBwb2ludCBpbiB0aW1lLCBi
dXQgdGhlIEFXQiBjb21wdXRhdGlvbnMgYXJlIGRvbmUgbGF0ZXIsIGluY2x1ZGluZyBhIGNhbGwN
Cj4+IHRvIGlzY191cGRhdGVfcHJvZmlsZSwgd2hpY2ggcmVxdWlyZXMgc3RyZWFtaW5nIHRvIGJl
IHN0YXJ0ZWQuDQo+PiBUaHVzICwgaXNjX3VwZGF0ZV9wcm9maWxlIHdpbGwgZmFpbCBpZiBkdXJp
bmcgdGhpcyBvcGVyYXRpb24gc2VxdWVuY2UgdGhlDQo+PiBzdHJlYW1pbmcgd2FzIHN0b3BwZWQu
DQo+PiBUbyBzb2x2ZSB0aGlzIGlzc3VlLCBhIG11dGV4IGlzIGFkZGVkLCB0aGF0IHdpbGwgc2Vy
aWFsaXplIHRoZSBhd2Igd29yayBhbmQNCj4+IHN0cmVhbWluZyBzdG9wcGluZywgd2l0aCB0aGUg
bWVudGlvbiB0aGF0IGVpdGhlciBzdHJlYW1pbmcgaXMgc3RvcHBlZA0KPj4gY29tcGxldGVseSBp
bmNsdWRpbmcgdGVybWluYXRpb24gb2YgdGhlIGxhc3QgZnJhbWUgaXMgZG9uZSwgYW5kIGFmdGVy
IHRoYXQNCj4+IHRoZSBBV0Igd29yayBjYW4gY2hlY2sgc3RyZWFtIHN0YXR1cyBhbmQgc3RvcDsg
ZWl0aGVyIGZpcnN0IEFXQiB3b3JrIGlzDQo+PiBjb21wbGV0ZWQgYW5kIGFmdGVyIHRoYXQgdGhl
IHN0cmVhbWluZyBjYW4gc3RvcCBjb3JyZWN0bHkuDQo+PiBUaGUgYXdiIHNwaW4gbG9jayBjYW5u
b3QgYmUgdXNlZCBzaW5jZSB0aGlzIHNwaW5sb2NrIGlzIHRha2VuIGluIHRoZSBzYW1lDQo+PiBj
b250ZXh0IGFuZCB1c2luZyBpdCBpbiB0aGUgc3RvcCBzdHJlYW1pbmcgd2lsbCByZXN1bHQgaW4g
YSByZWN1cnNpb24gQlVHLg0KPiANCj4gUGxlYXNlIGtlZXAgdGhlIGxpbmUgbGVuZ3RoIGluIGEg
Y29tbWl0IGxvZyB0byBubyBtb3JlIHRoYW4gNzUuDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+IFJldmlld2Vk
LWJ5OiBKYWNvcG8gTW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0KPj4gLS0tDQo+PiAgIGRyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDI5ICsrKysrKysrKysr
KysrKystLS0NCj4+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuaCAg
ICAgIHwgIDIgKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy1iYXNlLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVs
LWlzYy1iYXNlLmMNCj4gDQo+IDxzbmlwPg0KPiANCj4+IEBAIC0xNTQ4LDYgKzE1NjQsNyBAQCBz
dGF0aWMgaW50IGlzY19zX2F3Yl9jdHJsKHN0cnVjdCB2NGwyX2N0cmwgKmN0cmwpDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAqLw0KPj4gICAgICAgICAgICAgICAgICAgICAgICB2NGwyX2N0
cmxfYWN0aXZhdGUoaXNjLT5kb193Yl9jdHJsLCBmYWxzZSk7DQo+PiAgICAgICAgICAgICAgICB9
DQo+PiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygmaXNjLT5hd2JfbXV0ZXgpOw0KPiANCj4g
SHVoPyBXaGF0IGlzIHRoaXMgdW5sb2NrIGRvaW5nIGhlcmU/IEFtIEkgbWlzc2luZyBzb21ldGhp
bmc/DQoNCkhlbGxvIEhhbnMsDQoNClNvcnJ5LiBJdCBsb29rcyBsaWtlIHRoZSBjb3JyZXNwb25k
aW5nIG11dGV4X2xvY2sgd2FzIGxvc3Qgd2hlbiBJIA0KcmViYXNlZCB0aGUgc2VyaWVzIG92ZXIg
dGhlIHBhdGNoIHRvIHVzZSAnaXNfc3RyZWFtaW5nJyBpbnN0ZWFkIG9mIA0KJ3N0b3AnIHZhcmlh
YmxlLg0KSW4gdmVyc2lvbiAzLCB0aGUgbXV0ZXhfbG9jayB3YXMgdGhlcmUgOg0KDQpodHRwczov
L3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1tZWRpYS9tc2cyMDQwNTkuaHRtbA0KDQpTb21l
aG93IGEgcmFjZSBwcm9ibGVtIGRpZCBub3Qgb2NjdXIgaW4gdGhpcyBzcGVjaWZpYyBjcml0aWNh
bCBhcmVhIGluIA0KbXkgdGVzdHMuDQoNCkkgd2lsbCByZXNlbmQgdGhpcyBwYXRjaCBhcyBhIHYx
MCAsIG9yIHRoZSB3aG9sZSBzZXJpZXMgaWYgeW91IGhhdmUgDQpvdGhlciBjb21tZW50cyBvbiB0
aGUgb3RoZXIgcGF0Y2hlcz8gSG93IHdvdWxkIHlvdSBwcmVmZXIgPw0KDQpUaGFua3MsDQpFdWdl
bg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gICAgICAgICAgSGFucw0KPiANCj4+DQo+PiAgICAg
ICAgICAgICAgICAvKiBpZiB3ZSBoYXZlIGF1dG93aGl0ZWJhbGFuY2Ugb24sIHN0YXJ0IGhpc3Rv
Z3JhbSBwcm9jZWR1cmUgKi8NCj4+ICAgICAgICAgICAgICAgIGlmIChjdHJscy0+YXdiID09IElT
Q19XQl9BVVRPICYmDQo+PiBAQCAtMTc0MCw2ICsxNzU3LDcgQEAgc3RhdGljIHZvaWQgaXNjX2Fz
eW5jX3VuYmluZChzdHJ1Y3QgdjRsMl9hc3luY19ub3RpZmllciAqbm90aWZpZXIsDQo+PiAgIHsN
Cj4+ICAgICAgICBzdHJ1Y3QgaXNjX2RldmljZSAqaXNjID0gY29udGFpbmVyX29mKG5vdGlmaWVy
LT52NGwyX2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBpc2NfZGV2aWNlLCB2NGwyX2Rldik7DQo+PiArICAgICBtdXRleF9kZXN0cm95
KCZpc2MtPmF3Yl9tdXRleCk7DQo+PiAgICAgICAgY2FuY2VsX3dvcmtfc3luYygmaXNjLT5hd2Jf
d29yayk7DQo+PiAgICAgICAgdmlkZW9fdW5yZWdpc3Rlcl9kZXZpY2UoJmlzYy0+dmlkZW9fZGV2
KTsNCj4+ICAgICAgICB2NGwyX2N0cmxfaGFuZGxlcl9mcmVlKCZpc2MtPmN0cmxzLmhhbmRsZXIp
Ow0KPj4gQEAgLTE4NTAsNiArMTg2OCw4IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRl
KHN0cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllcikNCj4+ICAgICAgICBpc2MtPmN1
cnJlbnRfc3ViZGV2ID0gY29udGFpbmVyX29mKG5vdGlmaWVyLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlzY19zdWJkZXZfZW50aXR5LCBub3Rp
Zmllcik7DQo+PiAgICAgICAgbXV0ZXhfaW5pdCgmaXNjLT5sb2NrKTsNCj4+ICsgICAgIG11dGV4
X2luaXQoJmlzYy0+YXdiX211dGV4KTsNCj4+ICsNCj4+ICAgICAgICBpbml0X2NvbXBsZXRpb24o
JmlzYy0+Y29tcCk7DQo+Pg0KPj4gICAgICAgIC8qIEluaXRpYWxpemUgdmlkZW9idWYyIHF1ZXVl
ICovDQo+PiBAQCAtMTkzMCw2ICsxOTUwLDcgQEAgc3RhdGljIGludCBpc2NfYXN5bmNfY29tcGxl
dGUoc3RydWN0IHY0bDJfYXN5bmNfbm90aWZpZXIgKm5vdGlmaWVyKQ0KPj4gICAgICAgIHZpZGVv
X3VucmVnaXN0ZXJfZGV2aWNlKHZkZXYpOw0KPj4NCj4+ICAgaXNjX2FzeW5jX2NvbXBsZXRlX2Vy
cjoNCj4+ICsgICAgIG11dGV4X2Rlc3Ryb3koJmlzYy0+YXdiX211dGV4KTsNCj4+ICAgICAgICBt
dXRleF9kZXN0cm95KCZpc2MtPmxvY2spOw0KPj4gICAgICAgIHJldHVybiByZXQ7DQo+PiAgIH0N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5o
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuaA0KPj4gaW5kZXggOWNj
NjljM2FlMjZkLi5mOThmMjVhNTVlNzMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5oDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2F0bWVsL2F0bWVsLWlzYy5oDQo+PiBAQCAtMjI5LDYgKzIyOSw3IEBAIGVudW0gaXNjX3NjYWxl
cl9wYWRzIHsNCj4+ICAgICoNCj4+ICAgICogQGxvY2s6ICAgICAgICAgICAgbG9jayBmb3Igc2Vy
aWFsaXppbmcgdXNlcnNwYWNlIGZpbGUgb3BlcmF0aW9ucw0KPj4gICAgKiAgICAgICAgICAgICAg
ICAgICB3aXRoIElTQyBvcGVyYXRpb25zDQo+PiArICogQGF3Yl9tdXRleDogICAgICAgICAgICAg
ICBzZXJpYWxpemUgYWNjZXNzIHRvIHN0cmVhbWluZyBzdGF0dXMgZnJvbSBhd2Igd29yayBxdWV1
ZQ0KPj4gICAgKiBAYXdiX2xvY2s6ICAgICAgICAgICAgICAgIGxvY2sgZm9yIHNlcmlhbGl6aW5n
IGF3YiB3b3JrIHF1ZXVlIG9wZXJhdGlvbnMNCj4+ICAgICogICAgICAgICAgICAgICAgICAgd2l0
aCBETUEvYnVmZmVyIG9wZXJhdGlvbnMNCj4+ICAgICoNCj4+IEBAIC0zMDcsNiArMzA4LDcgQEAg
c3RydWN0IGlzY19kZXZpY2Ugew0KPj4gICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCAgICAgIGF3
Yl93b3JrOw0KPj4NCj4+ICAgICAgICBzdHJ1Y3QgbXV0ZXggICAgICAgICAgICBsb2NrOw0KPj4g
KyAgICAgc3RydWN0IG11dGV4ICAgICAgICAgICAgYXdiX211dGV4Ow0KPj4gICAgICAgIHNwaW5s
b2NrX3QgICAgICAgICAgICAgIGF3Yl9sb2NrOw0KPj4NCj4+ICAgICAgICBzdHJ1Y3QgcmVnbWFw
X2ZpZWxkICAgICAqcGlwZWxpbmVbSVNDX1BJUEVfTElORV9OT0RFX05VTV07DQo+IA0KDQo=
