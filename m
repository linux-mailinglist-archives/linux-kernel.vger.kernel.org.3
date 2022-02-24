Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7F4C2E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiBXOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBXOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:34:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA717C42F;
        Thu, 24 Feb 2022 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645713232; x=1677249232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WZtgLt1LHVDBKogRnFY2YyXHZbaqr0rlHHXvDwhZ+KM=;
  b=sN2Mft5UH1kmRl0sRQM7XOo/wD0znaVWJ+PqxmB+XtgUCqJcEu/KO6ZZ
   5jbUtth8muU8blVpZoYSYCwIUwkuDMeXyQ6I1rFKZR/acgzRnw8BY0yuk
   +nEUyIgyCejNtPtNj5kV1vXd1sdliK3nqwBS/LMx4sWvDW8QiuverT9K+
   TNfYgPHVERQ5DMvavuJwNeT6piHGNj3Y/mvRfCgyC1bMj0x3cJoYkO/85
   gQoPepUkMlbhzCLmYDDGGdF/2VSWA+MSazaVstvntGlUSX5AlBkSwUJac
   wf72DPdrq5nucUsrMuprZCvkWXfRHwtHVprklJc4vBFNsoNAQJ4mYI/Cd
   g==;
X-IronPort-AV: E=Sophos;i="5.90,134,1643698800"; 
   d="scan'208";a="154761745"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 07:33:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 07:33:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 07:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYetKFzsSz5z24KmJyAsu32E921IdGmpfmW/Qy6BfET7duOQNJ1EK9OUapWHvZj6Xd2qWVNP1We0biPHeKP7P6fgBAWF2xu7GeKazibI3zTc8Y1Qr99Fj6MJcSshEjsTqXjpSsRlHpUAxRVuIFrgjQhA4WAIqqx5Ommgo78hWtqPFdyjFfGE5zFmY5lQh+D3Y6zD4sVQR1VKFIYpGqmYy0bqSCEkMJsuaQJslUr1wGzVmwKqC4qD9ZPUQgBLU47lBXAHXcE4URt0icP3P3Ki6mF4WrJ8IuVwsjR2fYf9mEFWIyd/IXEqblYG1YSDqDKYISYaYgnNUbM5o1CoqJ8pdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZtgLt1LHVDBKogRnFY2YyXHZbaqr0rlHHXvDwhZ+KM=;
 b=EdbxiZmI4xLaXwqwkfANBzfTcfNqBSvYjZ2WiKNpF8XwGhG+UFLFZzoBtdbppB6i3VvV/V3KXMOdvymxw0QtiqTewTqIruW/h/8TQrRnj+ipaDLi4q7kmp3qW88mCRcvWpkw3kgoA+DAkSW1qBpTaRG3D6e2r/uHBj9yEjrfukt5Eox/ObNA0tzC+Njc5eSwHsZzP1cmixZmXGT89LYe5i8Ny9olv1FHZoy6vBz0rNwkfLzCpAtQGg9Gu6Gxtio9GPnRx+G7gusnFIdcRuo37PiDWZmhFt14XCshDBp+2SpZ8CY74EFThXQMdGsxMyr1Kk0yjY6rDwziN7cBrWHDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZtgLt1LHVDBKogRnFY2YyXHZbaqr0rlHHXvDwhZ+KM=;
 b=k4bHL5MLrV1rsEwzHrEtis5dVEul5F5c6SpJy2g03+gMtlktKWwflZKRoj6hVy+s9PSzALZVSZleqSZ29oN2lgyG9bxLCsG84gFjkJaHhWKW5cHaexDVRtGvXvPEbkceva1eo1TJ5JAonl6bI05AcZ/TYv4dkeIK36FPVAfZoWI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CH0PR11MB5492.namprd11.prod.outlook.com (2603:10b6:610:d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 14:33:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.025; Thu, 24 Feb 2022
 14:33:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <broonie@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/Dw==
Date:   Thu, 24 Feb 2022 14:33:49 +0000
Message-ID: <a7c9919a-b2b1-df80-51a3-e62e1a7a77be@microchip.com>
References: <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
 <20220223183849.xcwciv2ybnkdnauk@ti.com>
 <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
 <779069a1-7389-ab70-9f03-81090d0600ba@microchip.com>
 <a85e2d1862cfff477e97c39509b2b74d@walle.cc>
 <20220224132440.pi55jefug7ntzgjq@ti.com>
 <fee24baf231332168457d5d21e272665@walle.cc>
In-Reply-To: <fee24baf231332168457d5d21e272665@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b4b52a-2c6c-41f0-7740-08d9f7a2ac42
x-ms-traffictypediagnostic: CH0PR11MB5492:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5492F62EF4160F59EF3298F8F03D9@CH0PR11MB5492.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62/j3k5z+sX0hGx4DvWed/GuoFNg52IInvYbtIeVyg30dwZDSgtXm7EgF77AWXc0Vf1kSK8zTB/WGD1xASjQp5Smruiw8HQaiLmSTpPu2RGupqq3mVxB6ZGIUqxWmtlcPLJ/y5GmqBF5bjhWqDC8nLXpHhqLZKVY+J5uuJNuTRJsXEdaVbqL15CF2SEgXTku1mhiRVVor+U3JUuVQqv/8UR4lmszeueG9nWPDx9DBj/bWnj+DvP0Wm5yHQInESqYMVULhW6C8b0aB52eE2rA/s6oqu99lX5+DZL4AfK/+V0Tk2H/w2yxlOlSlGYoHcslHSUZBmU6hbgh9ftvbURXz6e0dkiIoNCBbOmRSOnHxy9OYw9BmMj5Y1v7yC0Qb/7s9tHH5J9rPpy1Z+sUr0SpgKULsmgIrBOTfxsVfzvWssYwRceekmEc0+1L8+PdnhHtWsoP93SVs4OXlw2lYCd0FS4/GS1adIIklOf/2bLN0IIWTv2rlkg3u7F66TAVsqXOGMDOW4jajXxRfLoSeONMaLNzl68WyPO3GyAwA60yeKc8nUsQ7zffBQvaC6dgJ+QQOdcV3LfW0/oB8GdTIWd8afHLBM3+cxvdMij/Qhd2kfXSrI2xdSW7taBqBKmvrmp3QjgR1mfBWCqOQ68TKGrc/U1Y4vbzLLuCZbPJoYzrnJ4WxCqI9qYdblBAvk3nbKthcy2CniaQrFVgL4RzS94EZoXBYxJnswuPJefM8NdIZYRH0uKoGlJbr6JiP8dZKsFI471PfqDisxuQFKzd9o+x8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66446008)(76116006)(66946007)(8676002)(4326008)(66476007)(91956017)(54906003)(64756008)(5660300002)(6486002)(38070700005)(2906002)(110136005)(508600001)(86362001)(31696002)(7416002)(316002)(122000001)(38100700002)(83380400001)(26005)(186003)(2616005)(31686004)(36756003)(71200400001)(6506007)(8936002)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVl1ODlRdG1DMlFDRWh1L2t5Y2oxTmJTT2lCQkhla3llbzU1Wk4wemF6ZURG?=
 =?utf-8?B?eFFzY09HRG1rMGlwTVlyV0w3Kzl0c1hGV0MvaGJzVFFWelkvdjFQYmZxTlEz?=
 =?utf-8?B?eWdHcnhEL2wzZVBVN09OUHVkeG9WUENmcnpERzFqN0xwRE9IdzltMTIwM1F0?=
 =?utf-8?B?cFY2VnpnbW5MZU1MdlIyQjdXYzdJTWdSWExvbGQrcVRrR1drM09aYTdZR3FH?=
 =?utf-8?B?dXBwUVNaVnJMaG8vT3dKYzBBM3VBVXJ6Rk4yTHBlQU5PWk1oRlZvOVFDTE5a?=
 =?utf-8?B?Rll6WHRSTHRYaUpoVVZPU3FSbTh5b3Z5alAyejdKMmxKcEJobEhCbk9FNHBv?=
 =?utf-8?B?WGdyVXZWVE1lQ0VaWnZRRmhMRXExWTJVcW9UZHNyQTduTFZyRGZtZmZGQlBJ?=
 =?utf-8?B?TThzcXp2NDk2TjdPVStnSThuQ25YRnZnZ3RiME9JTlhVcDAvVEloYUpRVUxV?=
 =?utf-8?B?Tlh4T3psSWRMS00yaUFKNko4a1AxbW96VWtzTUMwQy91MjV6Rk5LOEZWQzJS?=
 =?utf-8?B?c1YzVnFSUCtKbHFDdkNrclBRTDlyc2JNMDV5UkpHblZGUUtrYmVMcDdWcWNm?=
 =?utf-8?B?VE1aR3c0NC9vaWZGZmV4Tk5jT3Z3c2VDRU1SNy9vcklnREY1bkduRHY0ZjVy?=
 =?utf-8?B?eU0zTlphbzBtcGZLY1RWSU0wNS9SRTE4Ui9Jd2VkMGRTcjhPYlI0aElSbUpL?=
 =?utf-8?B?VXZPcllUWDd1alJIY2QyN1lIWS9CWjhST2JWSHYzL2NJM3BZb1lpS1pOUVV1?=
 =?utf-8?B?MHdGMHNaeWpoTktZYjNlbTQ4MnRjaGN5a0hrU3oyZGhHcUZmS1ZTVm1Lbjd0?=
 =?utf-8?B?eEhISktvWWlxV1FRSmwrUzJ4ak9FWDE5V1ZwUjFJWEdya0orUWpVbVFrTjhw?=
 =?utf-8?B?L0tlOE1oN3g1WmJ6WFFQbmNkc2ptbGZjK0haTVNFK2dmajNKZzY3YmVhSjdm?=
 =?utf-8?B?VTY1UDlocGZKajZlWjhRajRjQUo3YnFaMkJOYlllLzJPc1p2aS9wNHU5MmlS?=
 =?utf-8?B?T095ejFGaUJHbU1LVVdSVlJiRUZDUUw3OGd6UGVObGV5dnlESU4yWGFEU0xu?=
 =?utf-8?B?ZzJaZXVCbjdaOTdLOXloVldHMHZvTk1KZDNCZnluY2hRTFpvdGdhMS9UOWVv?=
 =?utf-8?B?MzFiWlNscFljWHJEWGNiWlVuQXRsSiswV2U5WUpzcjNGSWNMTy9WL1Jyc3pH?=
 =?utf-8?B?Vy9XWG1GYWV6ZklTYnhmOFZLQ2dkOUVqaWhlTXpHSU5pY2l5RDU5TWxOWUIv?=
 =?utf-8?B?aWhKREZmb2RRTFk5dnV2eW1CZExyTytHNzFYN2kzT20wWjBBTHpPbVBZVHI5?=
 =?utf-8?B?dUZmbU1hT1RyZ1A3MW9iVDMvMlNMRStRMGlTWm0rVm9YNlMyNWNkak1hNnE5?=
 =?utf-8?B?cUoxbFMxdkl3UVFEdEtScHJoeE91cE4zZGhOTU0wT2N3eVRsUnhoOExpZzlL?=
 =?utf-8?B?YjV6bTl1RGlhZTFxS3Y1LzJlQmNaWnNNYXBPeEk4bGtCOWFKZUpERXFhcnZR?=
 =?utf-8?B?UkZRYlFuMkdtS0RYTURNOGY2bjJDUS9YNm1KdW9IYlNvdWljWVVWNGYxcnRE?=
 =?utf-8?B?YlZ2K05xaGhNMzZ6Ym9OdVdkYnJjYkg5Q1dHVVo2Z0lhVUQxQm14N1o0ZjNS?=
 =?utf-8?B?L0t5VjR2UkhGemM3MTVFbWxmMXlFaTRZYkNicTA3UFNEaEl4SnpTZENRK2I3?=
 =?utf-8?B?STc2QVdOR0Nxd3hxVFI4MlBXOGh5Y29oYS95WlgweWlQRm02YVl1RVVSVFFF?=
 =?utf-8?B?NHlEWkkyVzBIV0hJRk13MWVnbUYyR1NjRDJjdjhSMXQ1Kys3blAyUmJKWER6?=
 =?utf-8?B?cHExSXUxanIvNCtRa2ozTktYMTZXeHlQdEV6NjRmM1Z2d0dqNk1GQW1uWXkr?=
 =?utf-8?B?YmFIOUphd2FDOVdvZkgvbEpqWjIwaExlRlk0bk5aRlg5aGxWRncrZS93MXNl?=
 =?utf-8?B?ZkdlZHlaMUtjOU5GbTM0UlhkZDBJWFpkUm5ZSkRQczZFS0pPeUxmZWFialUv?=
 =?utf-8?B?c1U3TDVJeDB2MlU2a3lkcVNVbWNZZ2FGLzZCa0x6TDNGUndUYUNQUEFmWTBS?=
 =?utf-8?B?c0NpaWVVWjU0YmR4dTRIT3ZMd1JqMVNoMEZrUVBERkREOEpSczU3aHNtbSsz?=
 =?utf-8?B?dWNWLzl4NTF2d2hSeTMwZFM0KzJUT1YxbjhJeHdOcngrQlFTeUhQVUU5U2dJ?=
 =?utf-8?B?L3NlYU13MzBnOThiZlluT1FiS2xYcWdaZjNiNWhnR0p4M1BaTzNPY21YUnVu?=
 =?utf-8?B?WHluejB5Q29uZlFYbC8vOUNNS093PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DB97F38610A6549B4CB984010836ACA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b4b52a-2c6c-41f0-7740-08d9f7a2ac42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 14:33:49.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoWwZ/vuw9lSTCkrChhTVe5DgNLwnjCdiihe9ltr4Kulaj4XYJf7L2ysxiOANvfKYasBUY4rLHewLESnHVeoGrudXjiGaR7Oiq7iim6Nmzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5492
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNC8yMiAxNjowMiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTI0IDE0OjI0LCBzY2hyaWViIFBy
YXR5dXNoIFlhZGF2Og0KPj4gT24gMjQvMDIvMjIgMTA6MzdBTSwgTWljaGFlbCBXYWxsZSB3cm90
ZToNCj4+PiBBbSAyMDIyLTAyLTI0IDA3OjM3LCBzY2hyaWViIFR1ZG9yLkFtYmFydXNAbWljcm9j
aGlwLmNvbToNCj4+PiA+IE9uIDIvMjQvMjIgMDg6MDgsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+PiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+PiA+ID4ga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4gPiA+DQo+Pj4gPiA+IE9uIDIvMjMvMjIgMjA6MzgsIFByYXR5dXNoIFlhZGF2
IHdyb3RlOg0KPj4+ID4gPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MNCj4+PiA+ID4gPiB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4gPiA+ID4NCj4+PiA+ID4gPiBIaSBUdWRvciwNCj4+PiA+ID4gPg0KPj4+ID4g
PiA+IE9uIDIyLzAyLzIyIDAyOjQzUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90
ZToNCj4+PiA+ID4gPiA+IE9uIDIvMjIvMjIgMTY6MjcsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+
Pj4gPiA+ID4gPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cw0KPj4+ID4gPiA+ID4gPiB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPj4+ID4gPiA+ID4gPg0KPj4+ID4gPiA+ID4gPiBBbSAyMDIyLTAyLTIyIDE1OjIzLCBz
Y2hyaWViIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+PiA+ID4gPiA+ID4gPiBPbiAy
LzIyLzIyIDE2OjEzLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+ID4gPiA+ID4gPiA+ID4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuDQo+Pj4gPiA+ID4gPiA+ID4g
PiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiA+ID4gPiA+ID4gPiA+IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+PiA+ID4gPiA+ID4gPiA+DQo+Pj4gPiA+ID4gPiA+ID4gPiBBbSAyMDIy
LTAyLTIyIDE0OjU0LCBzY2hyaWViIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+PiA+
ID4gPiA+ID4gPiA+ID4gT24gMi8yMS8yMiAwOTo0NCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+
PiA+ID4gPiA+ID4gPiA+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
DQo+Pj4gPiA+ID4gPiA+ID4gPiA+ID4gb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4g
PiA+ID4gPiA+ID4gPiA+ID4ga25vdw0KPj4+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+PiA+ID4gPiA+ID4gPiA+ID4gPg0KPj4+ID4gPiA+ID4gPiA+ID4gPiA+IEFt
IDIwMjItMDItMTggMTU6NTgsIHNjaHJpZWIgVHVkb3IgQW1iYXJ1czoNCj4+PiA+ID4gPiA+ID4g
PiA+ID4gPiA+IEZvcnR1bmF0ZWx5IHRoZXJlIGFyZSBjb250cm9sbGVycw0KPj4+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gdGhhdCBjYW4gc3dhcCBiYWNrIHRoZSBieXRlcyBhdA0KPj4+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gcnVudGltZSwgZml4aW5nIHRoZSBlbmRpYW5uZXNzZXMuDQo+Pj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBQcm92aWRlDQo+Pj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhIHdheSBmb3Ig
dGhlIHVwcGVyIGxheWVycyB0bw0KPj4+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3BlY2lmeSB0aGUg
Ynl0ZSBvcmRlciBpbiBEVFIgbW9kZS4NCj4+PiA+ID4gPiA+ID4gPiA+ID4gPg0KPj4+ID4gPiA+
ID4gPiA+ID4gPiA+IEFyZSB0aGVyZSBhbnkgcGF0Y2hlcyBmb3IgdGhlDQo+Pj4gPiA+ID4gPiA+
ID4gPiA+ID4gYXRtZWwtcXVhZHNwaSB5ZXQ/IFdoYXQgaGFwcGVucyBpZg0KPj4+ID4gPiA+ID4g
PiA+ID4gPg0KPj4+ID4gPiA+ID4gPiA+ID4gPiBub3QgcHVibGljLCBidXQgd2lsbCBwdWJsaXNo
IHRoZW0gdGhlc2UgZGF5cy4NCj4+PiA+ID4gPiA+ID4gPiA+ID4NCj4+PiA+ID4gPiA+ID4gPiA+
ID4gPiB0aGUgY29udHJvbGxlciBkb2Vzbid0IHN1cHBvcnQgaXQ/IFdpbGwgdGhlcmUgYmUgYSBz
b2Z0d2FyZQ0KPj4+ID4gPiA+ID4gPiA+ID4gPiA+IGZhbGxiYWNrPw0KPj4+ID4gPiA+ID4gPiA+
ID4gPg0KPj4+ID4gPiA+ID4gPiA+ID4gPiBubyBuZWVkIGZvciBhIGZhbGxiYWNrLCB0aGUgY29u
dHJvbGxlciBjYW4gaWdub3JlDQo+Pj4gPiA+ID4gPiA+ID4gPiA+IG9wLT5kYXRhLmR0cl9ic3dh
cDE2DQo+Pj4gPiA+ID4gPiA+ID4gPiA+IGlmDQo+Pj4gPiA+ID4gPiA+ID4gPiA+IGl0IGNhbid0
IHN3YXAgYnl0ZXMuDQo+Pj4gPiA+ID4gPiA+ID4gPg0KPj4+ID4gPiA+ID4gPiA+ID4gSSBkb24n
dCB1bmRlcnN0YW5kLiBJZiB0aGUgY29udHJvbGxlciBkb2Vzbid0DQo+Pj4gPiA+ID4gPiA+ID4g
PiBzd2FwIHRoZSAxNmJpdCB2YWx1ZXMsDQo+Pj4gPiA+ID4gPiA+ID4gPiB5b3Ugd2lsbCByZWFk
IHRoZSB3cm9uZyBjb250ZW50LCBubz8NCj4+PiA+ID4gPiA+ID4gPiA+DQo+Pj4gPiA+ID4gPiA+
ID4NCj4+PiA+ID4gPiA+ID4gPiBJbiBsaW51eCBubywgYmVjYXVzZSBtYWNyb25peCBzd2FwcyBi
eXRlcyBvbiBhIDINCj4+PiA+ID4gPiA+ID4gPiBieXRlIGJvdW5kYXJ5IGJvdGggb24NCj4+PiA+
ID4gPiA+ID4gPiByZWFkcyBhbmQgb24gcGFnZSBwcm9ncmFtLiBUaGUgcHJvYmxlbSBpcyB3aGVu
IHlvdQ0KPj4+ID4gPiA+ID4gPiA+IG1peCA4RC04RC04RCBtb2RlDQo+Pj4gPiA+ID4gPiA+ID4g
YW5kDQo+Pj4gPiA+ID4gPiA+ID4gMS0xLTEgbW9kZSBhbG9uZyB0aGUgYm9vdCBzdGFnZXMuIExl
dCdzIGFzc3VtZSB5b3Ugd3JpdGUgYWxsIGJvb3QNCj4+PiA+ID4gPiA+ID4gPiBiaW5hcmllcw0K
Pj4+ID4gPiA+ID4gPiA+IGluIDEtMS0xIG1vZGUuIFdoZW4gcmVhY2hpbmcgdS1ib290IGlmIHlv
dSBlbmFibGUNCj4+PiA+ID4gPiA+ID4gPiA4RC04RC04RCBtb2RlLCB3aGVuDQo+Pj4gPiA+ID4g
PiA+ID4gdS1ib290DQo+Pj4gPiA+ID4gPiA+ID4gd2lsbCB0cnkgdG8gZ2V0IHRoZSBrZXJuZWwg
aXQgd2lsbCBmYWlsLCBhcyB0aGUNCj4+PiA+ID4gPiA+ID4gPiBmbGFzaCBzd2FwcyB0aGUgYnl0
ZXMNCj4+PiA+ID4gPiA+ID4gPiBjb21wYXJlZA0KPj4+ID4gPiA+ID4gPiA+IHRvIHdoYXQgd2Fz
IHdyaXR0ZW4gd2l0aCAxLTEtMSBtb2RlLiBZb3Ugd3JpdGUgRDAgRDENCj4+PiA+ID4gPiA+ID4g
PiBEMiBEMyBpbiAxLTEtMQ0KPj4+ID4gPiA+ID4gPiA+IG1vZGUgYW5kDQo+Pj4gPiA+ID4gPiA+
ID4gd2hlbiByZWFjaGluZyB1LWJvb3QgeW91IHdpbGwgcmVhZCBEMSBEMCBEMyBEMiBhbmQNCj4+
PiA+ID4gPiA+ID4gPiBpdCB3aWxsIG1lc3MgdGhlDQo+Pj4gPiA+ID4gPiA+ID4ga2VybmVsIGlt
YWdlLg0KPj4+ID4gPiA+ID4gPg0KPj4+ID4gPiA+ID4gPiBCdXQgeW91IGhhdmUgdG8gY29uc2lk
ZXIgYWxzbyAzcmQgcGFydGllcywgbGlrZSBhbg0KPj4+ID4gPiA+ID4gPiBleHRlcm5hbCBwcm9n
cmFtbWVyDQo+Pj4gPiA+ID4gPiA+IG9yDQo+Pj4gPiA+ID4gPg0KPj4+ID4gPiA+ID4gV2h5PyBJ
ZiB5b3UgdXNlIHRoZSBzYW1lIG1vZGUgd2hlbiByZWFkaW5nIGFuZCB3cml0aW5nLA0KPj4+ID4g
PiA+ID4gZXZlcnl0aGluZyBpcyBmaW5lLg0KPj4+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQn
cyB5b3VyIHN1Z2dlc3Rpb24gaGVyZS4NCj4+PiA+ID4gPg0KPj4+ID4gPiA+IFNvIG91ciBzdGFu
Y2UgaGVyZSBpcyB0aGF0IHdlIGRvbid0IGNhcmUgYWJvdXQgZXh0ZXJuYWwgcHJvZ3JhbXM/Pg0K
Pj4+ID4gPiA+IElmIHRoYXQgaXMgdGhlIGNhc2UgdGhlbiB3aHkgYm90aGVyIHdpdGggYWxsIHRo
aXMgYW55d2F5PyBTaW5jZQ0KPj4+ID4gPiA+IHRoZSBzd2FwDQo+Pj4gPiA+ID4gaGFwcGVucyBh
dCBib3RoIHBhZ2UgcHJvZ3JhbSBhbmQgcmVhZCwgd2hhdCB5b3Ugd3JpdGUgaXMgd2hhdA0KPj4+
ID4gPiA+IHlvdSByZWFkDQo+Pj4gPiA+ID4gYmFjay4gV2hvIGNhcmVzIHRoZSBvcmRlciBzdG9y
ZWQgaW4gdGhlIGFjdHVhbCBmbGFzaCBtZW1vcnkgYXMNCj4+PiA+ID4gPiBsb25nIGFzDQo+Pj4g
PiA+ID4gdGhlIGRhdGEgcmVhZCBpcyBjb3JyZWN0Pw0KPj4+ID4gPiA+DQo+Pj4gPiA+ID4gSWYg
d2UgZG8gY2FyZSBhYm91dCBleHRlcm5hbCBwcm9ncmFtcywgdGhlbiB3aGF0IHdvdWxkIGhhcHBl
biBpZiB0aGUNCj4+PiA+ID4gPiBleHRlcm5hbCBwcm9ncmFtIHdyaXRlcyBkYXRhIGluIDhELThE
LThEIG1vZGUgX3dpdGhvdXRfIHN3YXBwaW5nIHRoZQ0KPj4+ID4gPiA+IGJ5dGVzPyBUaGlzIHdv
dWxkIGFsc28gY2F1c2UgZGF0YSBjb3JydXB0aW9uLiBZb3UgY2FuJ3QgY29udHJvbCB3aGF0DQo+
Pj4gPiA+ID4gdGhleSBtb2RlIHRoZXkgdXNlLCBhbmQgeW91IGNhbid0IGRldGVjdCBpdCBsYXRl
ciBlaXRoZXIuDQo+Pj4gPiA+ID4NCj4+PiA+ID4gPiBJIHRoaW5rIHRoZXJlIGlzIG5vIHdpbm5p
bmcgaGVyZS4gWW91IGp1c3QgaGF2ZSB0byBzYXkgdGhhdCBleHRlcm5hbA0KPj4+ID4gPiA+IHBy
b2dyYW1zIHNob3VsZCB3cml0ZSBpbiA4RC04RC04RCBtb2RlIG9yIGl0IHdvbid0IGJvb3QuDQo+
Pj4NCj4+PiBJTUhPIGl0IHNob3VsZCBqdXN0IHdvcmsgdGhhdCB5b3UgY2FuIHVzZSAxUy0xUy0x
UyBtb2RlIGFuZCA4RC04RC04RA0KPj4+IG9uIHRoZQ0KPj4+IHNhbWUgZmxhc2guIEFmdGVyIGFs
bCwgdGhhdCBpcyBUdWRvcidzIHVzZSBjYXNlLiBUaGUgUk9NIGFjY2VzcyB0aGUNCj4+PiBmbGFz
aA0KPj4+IGluIHNpbmdsZSBiaXQgbW9kZSBhbmQgbGludXggaW4gOEQtOEQtOEQgbW9kZS4gTWF5
YmUgdS1ib290IHdpbGwgdXNlDQo+Pj4gcXVhZA0KPj4NCj4+IEJ1dCB5b3UgZG9uJ3Qga25vdyB0
aGF0IFJPTSB3aWxsIGFsd2F5cyBhY2Nlc3MgdGhlIGZsYXNoIGluIHNpbmdsZSBiaXQNCj4+IG1v
ZGUuIEZvciBleGFtcGxlLCBST00gb24gc29tZSBUSSBTb0MgY2FuIHJlYWQgU0ZEUCBhbmQgdXNl
IDhELThELThEDQo+PiBtb2RlIGZvciByZWFkaW5nIGltYWdlcyBmcm9tIGZsYXNoLiBJZiB5b3Ug
d2FudCB0byBmbGFzaCBkYXRhIGZyb20NCj4+IExpbnV4LCBhbmQgaXQgYnl0ZSBzd2FwcywgUk9N
IHdvbid0IGJlIGFibGUgdG8gcmVhZCB0aGUgaW1hZ2VzDQo+PiBwcm9wZXJseS4NCj4gDQo+IFRo
ZW4gSSdkIGFyZ3VlIHlvdXIgUk9NIGNvZGUgaXMgYnJva2VuIGJlY2F1c2UgaXQgZG9lc24ndCBy
ZXNwZWN0DQo+IHRoZSBTRkRQIGJpdCB3aGljaCB0ZWxscyB5b3UgdGhlIGRhdGEgaXMgc3dhcHBl
ZC4gSSdtIG5vdCBpbXBseWluZw0KPiB3ZSBzaG91bGQgaWdub3JlIHRoYXQgY2FzZS4NCj4gDQo+
PiBUaGlzIGNhbiBvbmx5IHdvcmsgd2hlbiBldmVyeXRoaW5nIHRoYXQgcmVhZHMvd3JpdGVzIGlu
IDhEIG1vZGUgZG9lcw0KPj4gYnl0ZSBzd2FwcGluZy4gT3RoZXJ3aXNlIGl0IHdpbGwgbGVhZCB0
byBhIG1lc3Mgd2hlcmUgZGF0YSBpcyByZWFkDQo+PiBjb3JyZWN0bHkgYnkgc29tZSBzb2Z0d2Fy
ZSBidXQgbm90IGJ5IHNvbWUgb3RoZXIgc29mdHdhcmUuIEkgZG9uJ3Qga25vdw0KPj4gaG93IHBy
YWN0aWNhbCBpdCBpcyB0byBtYWtlIHRoaXMgYXNzdW1wdGlvbi4NCj4gDQo+IFdoYXQgYXNzdW1w
dGlvbiwgdGhhdCBldmVyeW9uZSByZWFkcyBpdCB0aGUgc2FtZSB3YXkgYW5kIHN3YXAgdGhlIGJ5
dGVzDQo+IGlmIG5lY2Vzc2FyeT8NCj4gDQo+Pj4gbW9kZSBpbiBiZXR3ZWVuLiBBbGwgb2YgdGhl
c2UgYWNjZXNzZXMgc2hvdWxkIHJldHVybiB0aGUgc2FtZSBmbGFzaA0KPj4+IGNvbnRlbnQuDQo+
Pj4NCj4+PiA+ID4gSG93IGFib3V0IHN3YXBwaW5nIHRoZSBieXRlcyBqdXN0IGF0IHVzZXIgcmVx
dWVzdD8gTWF5YmUgd2l0aCBhDQo+Pj4gPiA+IEtjb25maWcNCj4+PiA+ID4gb3B0aW9uLg0KPj4+
ID4NCj4+PiA+IE1pY2hhZWwgaGFzIHN1Z2dlc3RlZCBvbiAjaXJjIHRvIGFsd2F5cyBzd2FwIHRo
ZSBieXRlczogaWYgdGhlIFNQSQ0KPj4+ID4gY29udHJvbGxlcg0KPj4+ID4gY2FuJ3QgZG8gaXQs
IHRvIGRvIGl0IGluIHNvZnR3YXJlIGF0IFNQSSBOT1IgbGV2ZWwuIEkgZG9uJ3Qga25vdyB3aGF0
IHRvDQo+Pj4gPiBzYXkNCj4+PiA+IGFib3V0IHRoaXMsIGJlY2F1c2UgSkVERUMyMTYganVzdCBp
bmZvcm1zIHRoZSByZWFkZXIgSSBndWVzczoNCj4+PiA+ICJCeXRlIG9yZGVyIG9mIDE2LWJpdCB3
b3JkcyBpcyBzd2FwcGVkIHdoZW4gcmVhZCBpbiA4RC04RC04RCBtb2RlDQo+Pj4gPiBjb21wYXJl
ZCB0bw0KPj4+ID4gMS0xLTEgbW9kZS4iLCB0aGlzIGRvZXNuJ3QgbG9vayBsaWtlIGEgaGFyZCBy
ZXF1ZXN0LiBUaGUgZG93bnNpZGUgdG8NCj4+PiA+IGRvaW5nDQo+Pj4gPiB0aGUgc3dhcHBpbmcg
aW4gc29mdHdhcmUgaXMgcGVyZm9ybWFuY2UgcGVuYWx0eSB3aGljaCB3aWxsIG1ha2UgbWFjcm9u
aXgNCj4+PiA+IHVzZXJzIGhhdmUgc2Vjb25kIHRob3VnaHRzLiBJIGRvbid0IGhhdmUgYSBzdHJv
bmcgb3BpbmlvbiwgYnV0IEkgbGVhbg0KPj4+ID4gdG93YXJkcw0KPj4+ID4gZG9pbmcgdGhlIHN3
YXAganVzdCBhdCB1c2VyIHJlcXVlc3QsIHJlZ2FyZGxlc3MgaWYgSSBkbyBpdCB2aWEgdGhlIFNQ
SQ0KPj4+ID4gY29udHJvbGxlcg0KPj4+ID4gb3IgaW4gc29mdHdhcmUuDQo+Pj4NCj4+PiBKdXN0
IGhhdmluZyBhbmQgb3B0LWluIHdpbGwgYmUgYSBtZXNzIGluIHRoZSBmdXR1cmUgd2l0aCBmbGFz
aGVzDQo+Pj4gY29udGFpbmluZw0KPj4+IGJ5dGUgc3dhcHBlZCBjb250ZW50IGFuZCB3ZSBjYW4n
dCBldmVuIGZpeCBpdCBhbmQgd2Ugd2lsbCBoYXZlIHRvIGxpdmUNCj4+PiB3aXRoDQo+Pj4gdGhh
dCBmb3JldmVyLiBJTUhPIHJpZ2h0IG5vdyBpcyB0aGUgYmVzdCB0aW1lIHRvIGNpcmN1bXZlbnQg
dGhhdA0KPj4+IHNjZW5hcmlvLg0KPj4+IEkgZG9uJ3QgaGF2ZSBhbnl0aGluZyBhZ2FpbnN0IG1h
a2UgaXQgdXNlciBjb25maWd1cmFibGUsIGJ1dCBpdCBzaG91bGQNCj4+PiBiZQ0KPj4+IGFuIG9w
dC1vdXQuDQo+Pj4NCj4+PiBJIGhhdmVuJ3QgbG9va2VkIGF0IGFueSBjb250cm9sbGVycyB3aG8g
Y2FuIGRvIDhELThELThEIGFjY2Vzc2VzLA0KPj4+IG1heWJlIG1vc3QNCj4+PiBvZiB0aGVtIGNh
biBkbyB0aGUgc3dhcHBpbmcgb24gdGhlaXIgb3duPyBTbyBpZiB5b3UgZG9uJ3Qgd2FudCB0bw0K
Pj4+IHN1cHBvcnQgYQ0KPj4NCj4+IEkgY2hlY2tlZCB0aGUgZGF0YXNoZWV0IG9mIHRoZSBDYWRl
bmNlIFF1YWRzcGkgKHNwaS1jYWRlbmNlLXF1YWRzcGkuYykNCj4+IGNvbnRyb2xsZXIuIEkgZG9u
J3Qgc2VlIGFueSBzdWNoIG9wdGlvbi4NCj4gDQo+IEkndmUgYWxzbyBjaGVja2VkIHRoZSBmbGV4
c3BpLCBkb2Vzbid0IGhhdmUgc3VjaCBhbiBvcHRpb24gZWl0aGVyLg0KPiANCj4+PiBzb2Z0d2Fy
ZSBmYWxsYmFjaywgdGhlbiB3ZSBzaG91bGQganVzdCBzYXkgdGhpcyBtb2RlIGlzbid0IHN1cHBv
cnRlZA0KPj4+IGlmDQo+Pj4gdGhlIGNvbnRyb2xsZXIgY2FuJ3QgZG8gdGhlIGJ5dGUgc3dhcHBp
bmcgYW5kIHdlIGZhbGwgYmFjayB0byBhIHNsb3dlcg0KPj4+IG1vZGUuDQo+Pg0KPj4gRnJvbSBh
bGwgSSB1bmRlcnN0YW5kIG9mIHRoaXMsIGl0IGxvb2tzIHRvIG1lIHRoYXQgdGhpcyBjYW4ndCBy
ZWFsbHkgYmUNCj4+IHNvbHZlZCBjb21wbGV0ZWx5LiBJZiB5b3Ugd2FudCB0byBhbGxvdyBjb21w
YXRpYmlsaXR5IHdpdGggMVMtMVMtMVMNCj4+IG1vZGUNCj4+IHRoZW4geW91IGxvc2UgY29tcGF0
aWJpbGl0eSB3aXRoIDhELThELThEIHNvZnR3YXJlIHRoYXQgZG9lc24ndCBkbyB0aGlzDQo+PiBz
d2FwLiBTbyB0aGUgcXVlc3Rpb24gcmVhbGx5IGlzIHdoaWNoIG9uZSB3ZSBjb25zaWRlciAibW9y
ZSBpbXBvcnRhbnQiLg0KPj4gSW4gbXkgZXllcyB0aGUgY2hvaWNlIGlzIGFyYml0cmFyeS4NCj4g
DQo+IFdlIG5lZWQgYSByZWZlcmVuY2UuIEFuZCBJTUhPIHRoaXMgcmVmZXJlbmNlIGlzIHRoYXQg
aWYgdGhlIFNGRFANCj4gdGVsbHMgdXMgdGhlIGJ5dGVzIGFyZSBzd2FwcGVkLCB3ZSBuZWVkIHRv
IHN3YXAgZW0gaW4gOEQtOEQtOEQsDQo+IGFueSBzb2Z0d2FyZSB3aGljaCBkZXZpYXRlcyBmcm9t
IHRoYXQgaXMgYnJva2VuOyB3aGljaCBkb2Vzbid0DQo+IG1lYW4gd2Ugc2hvdWxkIG5vdCB0cnkg
dG8gYmUgY29tcGF0aWJsZSB3aXRoIGl0LiBCdXQgd2UgLSBhcyBpbiB0aGUNCj4gU1BJLU5PUiBz
dWJzeXN0ZW0gLSBzaG91bGQgbm90IGJlIGJyb2tlbiB0b28gYW5kIG1heWJlIHdlIGFyZQ0KPiBn
ZXR0aW5nIHRvIGJlIHRoZSByZWZlcmVuY2UuLg0KPiANCj4gSXMgdGhlcmUgYW55IHNvZndhcmUg
eWV0IHdoZXJlIHdlIGNhbiBsb3NlIGNvbXBhdGliaWxpdHkgd2l0aD8gVGhpcw0KPiBwYXRjaCBz
ZXJpZXMgd2lsbCBicmVhayBpdCBhbnl3YXkgaWYgeW91IGFyZSB1c2luZyB0aGlzIGNvbWJpbmF0
aW9uDQo+IG9mIGF0bWVsIHFzcGkgY29udHJvbGxlciBhbmQgbWFjcm9uaXggZmxhc2guIFNvIGFw
cGFyZW50bHkgd2UgZG9uJ3QNCj4gY2FyZSBhYm91dCB0aGF0LiBZZXMgdGhlcmUgbWlnaHQgYmUg
c29tZSBmYWxsb3V0IG5vdywgYnV0IGlmIHdlIGp1c3QNCg0KSSBrbm93IGFuIGV4YW1wbGUgb2Yg
Um9tQ29kZSBzdXBwb3J0aW5nIDEtMS0xIGFuZCB0aGUgb3RoZXIgYm9vdCBzdGFnZXMNCmhhbmRs
aW5nIHRoZSBmbGFzaCBpbiBlaXRoZXIgMS0xLTEgb3IgOEQtOEQtOEQuIFRoZSBwcm9ibGVtIGlz
IHJlYWwNCmFuZCBJIGRvIGNhcmUuDQoNCj4gaWdub3JlIHRoZSBwcm9ibGVtIG5vdywgdGhlIGZh
bGxvdXQgbGF0ZXIgbWlnaHQgYmUgZXZlbiBiaWdnZXIuDQo+IA0KPiBJbWFnaW5lLCBzb21lb25l
IHdpdGggYW4gU1BJIGNvbnRyb2xsZXIgd2l0aG91dCBzd2FwcGluZyBjb21lcw0KPiBhbG9uZyBh
bmQgd2FudCB0byB1c2UgdGhhdCBtYWNyb25peCBmbGFzaCB3aXRoIGEgYm9vdCByb20gZG9pbmcN
Cj4gc2luZ2xlIGJpdCBhY2Nlc3Nlcy4gSXQgZG9lc24ndCB3b3JrLCBkb2VzIGl0PyBTbywgd2hh
dCB3ZSBhcmUNCg0KSXQgd29uJ3Qgd29yaywgc3VyZS4NCg0KPiBkb2luZyB0aGVuPw0KDQpUaGF0
J3Mgd2hhdCB3ZSdyZSB0cnlpbmcgdG8gYWRkcmVzcy4NCg0KPiANCj4+IEJ1dCBJIGFtIG5vdCBj
b252aW5jZWQgdGhhdCBhZGRpbmcgYSBLY29uZmlnIG9wdGlvbiBpcyB0aGUgcmlnaHQgdGhpbmcN
Cj4+IHRvIGRvLiBJIHRoaW5rIHRoYXQgd291bGQgY2F1c2UgdG9vIG11Y2ggY29uZnVzaW9uLiBJ
dCBpcyBlbnRpcmVseQ0KPj4gcG9zc2libGUgdGhhdCB5b3VyIGRhdGEgZ2V0cyBjb3JydXB0ZWQg
Z29pbmcgZnJvbSBvbmUga2VybmVsIHZlcnNpb24gdG8NCj4+IGFub3RoZXIgZGVwZW5kaW5nIG9u
IGhvdyBpdCB3YXMgY29tcGlsZWQuIFVzIFNQSSBOT1IgZGV2ZWxvcGVycyBrbm93DQo+PiB0aGlz
IHRpbnkgZGV0YWlsIGJ1dCBvdGhlciBwZW9wbGUgd29uJ3QsIGFuZCBpdCB3b3VsZCBiZSBoYXJk
IHRvDQo+PiBleHBsYWluDQo+PiB0aGlzIHRvIHRoZW0uDQo+IA0KPiBJIGRvbid0IHRoaW5rIGEg
S2NvbmZpZyBpcyB0aGUgd2F5IHRvIGdvIGhlcmUgbmVpdGhlci4gV2hhdCBpZiB5b3UNCj4gaGF2
ZSB0d28gZmxhc2hlcyBhbmQgeW91IHdhbnQgb25lIHdpdGggYW5kIG9uZSB3aXRob3V0Pw0KPiAN
Cg0KSXMgdGhpcyB1c2UgY2FzZSByZWFsPw0KVGhlIGZpcnN0IHRoaW5nIHRvIGFuc3dlciBpcyB3
aGV0aGVyIHdlIHdhbnQgdG8gaW50cm9kdWNlIGEgY29uZmlndXJhdGlvbg0Kb3B0aW9uIHRoYXQg
YWxsb3dzIHVzZXJzIHRvIGNob29zZSB3aGV0aGVyIHRvIHN3YXAgdGhlIGJ5dGVzIG9yIG5vdC4N
CklmIHdlIHdhbnQgdG8gbWFrZSBpdCBjb25maWd1cmFibGUsIHdlIGNhbid0IHVzZSBkdCBwcm9w
ZXJ0aWVzIGFzIHRob3NlDQpzaG91bGQgZGVzY3JpYmUgdGhlIGh3IGFuZCBub3QgY29uZmlndXJl
IGl0LiBXaGF0IG90aGVyIG9wdGlvbnMgZG8gd2UgaGF2ZT8NCg==
