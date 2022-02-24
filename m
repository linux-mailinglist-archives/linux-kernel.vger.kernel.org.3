Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448A4C2423
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiBXGiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBXGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:38:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E1171ECA;
        Wed, 23 Feb 2022 22:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645684664; x=1677220664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YzPeNkJogoD1nZY6sfoIRHPA/mOLH5eN1O3XBXT6Uwk=;
  b=X4bMT3zysyFe2f0izo8cb5vILvXQ5w51mL2rqRewq+sApkKMuOOSdkW3
   fVzHzbpecB4tY+lYTX8GLuBPolhBq7B9ZnynIHVbGIESOYuuSY+jOJlig
   KLvoD4FkNB7zm/PZ8HyskM6Iw+UgBTEEnHT8aWCwFHqPdQab+1N72j0Zp
   xYEbhzEHe/Yvkj+/lDvIzmCslZb4prsJSmYzWbL74acdBgHIBPUynqCMz
   hintcsx7pnIq8jxB0rdCvPBJwHCJZDyN2JI7C4/4FMJmzSt2hCHs9mAf6
   oOrZQBKt625z8aZdUn7GfYv5qF9/tEyEPYJ78eWDICuhteJKsF+SFf+vn
   w==;
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="154214022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2022 23:37:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 23 Feb 2022 23:37:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 23 Feb 2022 23:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ2RZCRV0qW9JEUBo0nMZ99R81kPJQZshMoZRvJRBCOHlMFbu1T8iizxt3aX/vJnORAIwq9m8YN5Epe2i/D9yIvCdeMNGfbSMTtJQD+TFkun8q6THUteb5AU9VYj9DNqnmIyeQoVRVuHkTMnH1MgCbduH5rP+B47MKMg70aZP9edmvK8w2C535AUsktO/upXYi+2gu2bHGAmiOxG+a2To4D2b5sN2NDGTtK2ALKrTGYpQ34dZ5mgINLs4TqeSQSQeTFOq9JtdYjpFDYvzVbccK4w28TMq83wEgWA/9FKoVNc7vvB3uf/VSk91sHAaMZBjLuNXhxYd03oltYfjtb3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzPeNkJogoD1nZY6sfoIRHPA/mOLH5eN1O3XBXT6Uwk=;
 b=JBnk0vSFzGuSdnZUv0IbbGWwaYnq1Frp3cF8nywJFQLQWzmO54NzYLo+hKpS3Cf4nkqiHuaq90LzIvEEVTD6x2kpbzX2XbM7tHQusImPOHJmCgfYfkoHqnSglzvMgKX4mKcnGvJaWB6HpZY/zNvY6pJ8xLP/h4/66J30qhGiZYeJS/Piao5EpdyeAQj1dw89VSdWT8hwUsCO6PLKag0kHUlFLeJj2GNLtqjkTB74kz70uKUYka1FcRKs/X/UAOJv8WFoaNNsQh9x0o2SgZoJ4/uPrSn0Dd4Tyj0q3uC575LMDU2DK7GNtF1QB9bXq49IYyUmteEznmr/IZEW/kJ0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzPeNkJogoD1nZY6sfoIRHPA/mOLH5eN1O3XBXT6Uwk=;
 b=Fyo5ofo4korgJ1vaKpDFykCi/ISJ7iL/7/6pX/TGoUHqZNqqntaJkFB8t29cLrqk161eJk/hDKJjZd9YWxGvK7m/v5cwySeAtewwVYRT+SWfpL0iL6xLnXtwUMWpfksBSm9JqaHWXewvA+q5Tvzf3xjIo6SFmguEqi1PSiHccFY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CH0PR11MB5331.namprd11.prod.outlook.com (2603:10b6:610:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Thu, 24 Feb
 2022 06:37:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 06:37:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/D6yiQgoA
Date:   Thu, 24 Feb 2022 06:37:21 +0000
Message-ID: <779069a1-7389-ab70-9f03-81090d0600ba@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
 <20220223183849.xcwciv2ybnkdnauk@ti.com>
 <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
In-Reply-To: <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14af72ce-5adc-4cb6-0d36-08d9f7601c47
x-ms-traffictypediagnostic: CH0PR11MB5331:EE_
x-microsoft-antispam-prvs: <CH0PR11MB533139AAA73A212D6FAB69F1F03D9@CH0PR11MB5331.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzUVZb+q7qUa//vnrCnqumkdKFRP1AnErB8ER7FmMcVCWP0OmWTnU08nyjJ39xEt3SBvzRXCGhf6nWW2UMtxe6o+oW0gCiTv45RVWyCcfD8N5v4g20yFI/A2MAgeMpuURT2bEGjxtdQU6Tm1szoEidqZDLmt7Im2hikyn4dC/ImTYMcbq87vCwaAAiq7ZJ9cRRNZvASmGOmT9oOFfaek/siKfOY8+u2TodmZUZymNevTF4EhQ9qQp69iTJGfo+v6ESaMi0crb7uerGCTtTVMYlDM8HapixKkKwzfILbSRz6pg8GqvW79XNyv8enXdVjku0yPcYCvUPbczYpRDYbwY1pAQFB9zHXq6Ks1Hv/lElOXCC5D3DWeNVDoEBT47xs9+HAlwUOFa+H5uRDniVihzRWvMLWakItTkyRgWNz4jAdo5SQHSDOrMvYpr91+XN8FF7oI68q/xCzpxW9dpffAogNMQIpNbQz+8vb7+f/nfr9rgYYi4ALNMTgzhnBHR4TDyv6QPfrsaUt4mPjdgRB3FqKAj2Spc9D/eTtnBkJXizPu3CZyGu2hPHloK3Jkpvs8ZzoQ4R7JLq0j9Y8yUyADFp3gFubbBpq7tFqtbJ9tLyOhNagSzjZuh9kYJofJy2jbEFxz3buAvzenMyTjxJwmyDVI2NjLdmVkrtt91J/L9B3VFTNOmXklfz7Ay0GpUpW16JXcCM4dnfp5OL/Py7brOrZpqEojlF7nFL/7axKLX7fx3djInxbWrMjpPqB9tOJVh7F409cnqX1k9P9QidDbZ8Ob3wbcXbqllldelYdM4G5EcLV/s9ubez/lKfQwKWjIqw8RbxN5ouGX/HKArmHix2vkjadHQgtX/iYL5oUk5Zs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(83380400001)(36756003)(6486002)(6916009)(86362001)(76116006)(66946007)(31696002)(966005)(508600001)(122000001)(66556008)(66476007)(91956017)(66446008)(64756008)(8676002)(4326008)(53546011)(26005)(38070700005)(6506007)(38100700002)(316002)(7416002)(2906002)(8936002)(54906003)(2616005)(71200400001)(186003)(6512007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnRxdE9NdEcvanV1Q1NKSERqV3FjbzdyNXd2aEtFMkxlWU9KUjNaQkhXMVJI?=
 =?utf-8?B?dmJMV2xOOXVoVFBaYXF6VTdTQ1ZTWWQ2eG05UHBncE9aeTlVeTduNnl0VVdU?=
 =?utf-8?B?MXp5NkJjZnJnQWtCRTdBQWZOeTFGSTBhcGxSWVFycGo1K2hmUDZydFQyN2Qz?=
 =?utf-8?B?MHQxNlAvTU1vTFRBVkk0U2ZocTlxTENuM2RwNERpMXpIZEU2aWpyTmlFZ25K?=
 =?utf-8?B?K3BwcUVKTFFBcFNHUEdoODR6V0grNHJlbTBSYmJMWEo2d3B2ZStRSHpUMFBQ?=
 =?utf-8?B?TkhWZlFtcHljYjVzczNqd09VNzMxQTBGQXViSllDWm1kem8zNkllbkd1aytp?=
 =?utf-8?B?Nlg3dWFpTk1ZUzNJaDExTVVqSnlGOEVqWmd0c0RCeE1OM05WQ0wxRTVvcHJ4?=
 =?utf-8?B?UXIxd0ZCcDE5aEdQU1Q4QjRJcGYwQ2pjVndiOWEydFc0YkxtQ3N6dHZsQlVY?=
 =?utf-8?B?UklDcUUySFE4SFVmbHhiUTBZLzRTUW5uTFdhWHpZTTlObndxSXA1d1RKeXNs?=
 =?utf-8?B?eWF3bGVmVVVpWTZ2c3l6UERJcE9neEs1TjUvVzZHOHZHZlVlRkNUcTQ5a2VO?=
 =?utf-8?B?ZUFwL3hEaGpEYnNRL3VOWmFBa0RYNXJuZXJIVFRuaEd3ZmRlU2JzRHBLakJY?=
 =?utf-8?B?N3Y2YU56NGt3NE5KckYwSWVwVUN6cm1GbG1WMUtkRFpJUXFUQlJtSU01b3U1?=
 =?utf-8?B?WkRuR0RJSlJXMysrQjBaTWoxWm50WUwxa2VlSVpyN3NuUkNaQnplN28raEFN?=
 =?utf-8?B?L1kwelVFOWM5cEF3WHgrY2hoSklta0JoeXMwNkErZy9IdzRJdXVqTktHSnBB?=
 =?utf-8?B?WFd4NnVxdDlSZm1NMzF1aHJ5YlVQY1RxRnRDZmFYanhTNHFxaGpVU2RtMnhO?=
 =?utf-8?B?M3NFZ3dtY1J5NWlrZDNBKzJoR1ZpSjVLWHVSMlhUOHl1WDhVTlI3K1ZCcWZn?=
 =?utf-8?B?WDN4b24wODRxQzBDR0wxMmNNd1BmbUFRM29mZ3dnUWJFc0dSZ3FMYkRkRmg4?=
 =?utf-8?B?ZXhrM2lnR2JtNGlpWjNmWWlIY1NaMnpDR3A3N3VEYktJRGlRY1VSQmt0T2xT?=
 =?utf-8?B?WWdCSG8vcEtuSG9admpaRUZDVWt0MGtHME5ZaU9HTkg3RkpVeHYzM0ZGOGMy?=
 =?utf-8?B?aVZYdkdEdXhuNGtFbUNKRmh5cGtHUmZrTjlpSDM5NWdHMGxLbW9BQ051YkRP?=
 =?utf-8?B?cGswbzdaOGp4N0l0K2lKVUU0dUNuUzRiSHR6SEJMdUYxZmNMa05BbnFOWFAv?=
 =?utf-8?B?SzNLWGN3T3Ixb2hNWis3WUdEZkM5cnlCdW1sMmFtbGFKRkk5UEhYTzRTQ29M?=
 =?utf-8?B?VzZOcjdRZDhoYkhtUXc2MzhyU2xXS1U0anFkN25PMWwyTEZoZnNzdFREYWlh?=
 =?utf-8?B?clUwOUhGc3pFVXBIdHlhYWZMdlozQ2hDSDhUYXNESjBMa2ljZnhYWVkzNnRu?=
 =?utf-8?B?ekRoRlE5OFRKTE1pTkZ0VU1xV3d5dmF3NjNsM2JtL1RCaUtFWHpYRTN6eitJ?=
 =?utf-8?B?TkR2Skl6Vnd0SW1wZmJGdy9sWWJMVkJqc2JiV1k2N3NJaDBjWWVkYUhENW5a?=
 =?utf-8?B?TEZINWJBMEZtS3Ywb0RmTzJ1UUJjMXk1RXo4eUEremlRTnVvd1FyQUs1VjF4?=
 =?utf-8?B?VE5yY0QzaUZ3dGMyZkZsTUY4SmxsRHB6QVVFWWpZT243ZDc5eTZxcThMUnZ3?=
 =?utf-8?B?ZmFmWHkzZTJHK1orQUZGVWpjZXNsUlJqNHNnYTBsbEFSeGJJYmd2aEJwUlNs?=
 =?utf-8?B?WFp0YW5Db0d6dHo1MGd3S1R3Ykhmd2ZKRlJNRFY5aUxwNFJmUUxmbEFvZFJJ?=
 =?utf-8?B?ODZJVHlNck5oMWMzRTd5SG1XNWRLNHUrQnpWeENMYkc1L2xCYWMxSE15KzV3?=
 =?utf-8?B?UGg0NDhkOE9mcHpjTGNuODBjNUJsZkFlK09SRTB0UmRIQ3lBZnN5UUNLdmRC?=
 =?utf-8?B?b0V5MHhtVnJZNW91dXE5SHNHUzdkdElEUnNtVld2cVlQZFNndThEejNjNDY2?=
 =?utf-8?B?SnBkQUhtRzROOHhBR2wzdmRBd2o5QXhkQWc0aFBuS3FBQ3A1a0dxclNOZFQ2?=
 =?utf-8?B?R0pycFgwTEUxWWF6M2huQWNwMUUyR3grQlptRGhGWlljcGhRZlpXMDhZVktS?=
 =?utf-8?B?cnR3OStvUDdWZ2NXWUVBK1ByaWt5OVRMejlzWm0ySVhtVVdpUStscEFaRFky?=
 =?utf-8?B?c3g3QlFwYitrbG9KejB6N09tUWZ3M2xmVXV6OVBCOTl0N2JaOHlKeWhPSVB1?=
 =?utf-8?B?NU91NEdYQ2xmdEcrMVRtTVpYeW13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <509C0B81FFA97E46A08B69703F58765C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14af72ce-5adc-4cb6-0d36-08d9f7601c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 06:37:21.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIGELz5wSv1wtCbgUKrkFHVO2L3r5ZHyOdAcRiOGDmZy+y33Totdiu1uw5tU+Qnp6fJIWh0twcnBReAfj5pnvNKyTHuX6xvdcOK1JlBwJPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5331
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNC8yMiAwODowOCwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIvMjMvMjIgMjA6Mzgs
IFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pg0KPj4gSGkgVHVkb3IsDQo+Pg0KPj4gT24gMjIvMDIvMjIgMDI6NDNQTSwgVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDIvMjIvMjIgMTY6MjcsIE1pY2hh
ZWwgV2FsbGUgd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
Pj4+Pg0KPj4+PiBBbSAyMDIyLTAyLTIyIDE1OjIzLCBzY2hyaWViIFR1ZG9yLkFtYmFydXNAbWlj
cm9jaGlwLmNvbToNCj4+Pj4+IE9uIDIvMjIvMjIgMTY6MTMsIE1pY2hhZWwgV2FsbGUgd3JvdGU6
DQo+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+Pj4+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pj4+
Pg0KPj4+Pj4+IEFtIDIwMjItMDItMjIgMTQ6NTQsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tOg0KPj4+Pj4+PiBPbiAyLzIxLzIyIDA5OjQ0LCBNaWNoYWVsIFdhbGxlIHdyb3Rl
Og0KPj4+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+Pj4+IGtub3cNCj4+Pj4+Pj4+IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBBbSAyMDIyLTAyLTE4IDE1OjU4LCBzY2hyaWVi
IFR1ZG9yIEFtYmFydXM6DQo+Pj4+Pj4+Pj4gRm9ydHVuYXRlbHkgdGhlcmUgYXJlIGNvbnRyb2xs
ZXJzDQo+Pj4+Pj4+Pj4gdGhhdCBjYW4gc3dhcCBiYWNrIHRoZSBieXRlcyBhdCBydW50aW1lLCBm
aXhpbmcgdGhlIGVuZGlhbm5lc3Nlcy4NCj4+Pj4+Pj4+PiBQcm92aWRlDQo+Pj4+Pj4+Pj4gYSB3
YXkgZm9yIHRoZSB1cHBlciBsYXllcnMgdG8gc3BlY2lmeSB0aGUgYnl0ZSBvcmRlciBpbiBEVFIg
bW9kZS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBBcmUgdGhlcmUgYW55IHBhdGNoZXMgZm9yIHRoZSBh
dG1lbC1xdWFkc3BpIHlldD8gV2hhdCBoYXBwZW5zIGlmDQo+Pj4+Pj4+DQo+Pj4+Pj4+IG5vdCBw
dWJsaWMsIGJ1dCB3aWxsIHB1Ymxpc2ggdGhlbSB0aGVzZSBkYXlzLg0KPj4+Pj4+Pg0KPj4+Pj4+
Pj4gdGhlIGNvbnRyb2xsZXIgZG9lc24ndCBzdXBwb3J0IGl0PyBXaWxsIHRoZXJlIGJlIGEgc29m
dHdhcmUNCj4+Pj4+Pj4+IGZhbGxiYWNrPw0KPj4+Pj4+Pg0KPj4+Pj4+PiBubyBuZWVkIGZvciBh
IGZhbGxiYWNrLCB0aGUgY29udHJvbGxlciBjYW4gaWdub3JlDQo+Pj4+Pj4+IG9wLT5kYXRhLmR0
cl9ic3dhcDE2DQo+Pj4+Pj4+IGlmDQo+Pj4+Pj4+IGl0IGNhbid0IHN3YXAgYnl0ZXMuDQo+Pj4+
Pj4NCj4+Pj4+PiBJIGRvbid0IHVuZGVyc3RhbmQuIElmIHRoZSBjb250cm9sbGVyIGRvZXNuJ3Qg
c3dhcCB0aGUgMTZiaXQgdmFsdWVzLA0KPj4+Pj4+IHlvdSB3aWxsIHJlYWQgdGhlIHdyb25nIGNv
bnRlbnQsIG5vPw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSW4gbGludXggbm8sIGJlY2F1c2UgbWFj
cm9uaXggc3dhcHMgYnl0ZXMgb24gYSAyIGJ5dGUgYm91bmRhcnkgYm90aCBvbg0KPj4+Pj4gcmVh
ZHMgYW5kIG9uIHBhZ2UgcHJvZ3JhbS4gVGhlIHByb2JsZW0gaXMgd2hlbiB5b3UgbWl4IDhELThE
LThEIG1vZGUNCj4+Pj4+IGFuZA0KPj4+Pj4gMS0xLTEgbW9kZSBhbG9uZyB0aGUgYm9vdCBzdGFn
ZXMuIExldCdzIGFzc3VtZSB5b3Ugd3JpdGUgYWxsIGJvb3QNCj4+Pj4+IGJpbmFyaWVzDQo+Pj4+
PiBpbiAxLTEtMSBtb2RlLiBXaGVuIHJlYWNoaW5nIHUtYm9vdCBpZiB5b3UgZW5hYmxlIDhELThE
LThEIG1vZGUsIHdoZW4NCj4+Pj4+IHUtYm9vdA0KPj4+Pj4gd2lsbCB0cnkgdG8gZ2V0IHRoZSBr
ZXJuZWwgaXQgd2lsbCBmYWlsLCBhcyB0aGUgZmxhc2ggc3dhcHMgdGhlIGJ5dGVzDQo+Pj4+PiBj
b21wYXJlZA0KPj4+Pj4gdG8gd2hhdCB3YXMgd3JpdHRlbiB3aXRoIDEtMS0xIG1vZGUuIFlvdSB3
cml0ZSBEMCBEMSBEMiBEMyBpbiAxLTEtMQ0KPj4+Pj4gbW9kZSBhbmQNCj4+Pj4+IHdoZW4gcmVh
Y2hpbmcgdS1ib290IHlvdSB3aWxsIHJlYWQgRDEgRDAgRDMgRDIgYW5kIGl0IHdpbGwgbWVzcyB0
aGUNCj4+Pj4+IGtlcm5lbCBpbWFnZS4NCj4+Pj4NCj4+Pj4gQnV0IHlvdSBoYXZlIHRvIGNvbnNp
ZGVyIGFsc28gM3JkIHBhcnRpZXMsIGxpa2UgYW4gZXh0ZXJuYWwgcHJvZ3JhbW1lcg0KPj4+PiBv
cg0KPj4+DQo+Pj4gV2h5PyBJZiB5b3UgdXNlIHRoZSBzYW1lIG1vZGUgd2hlbiByZWFkaW5nIGFu
ZCB3cml0aW5nLCBldmVyeXRoaW5nIGlzIGZpbmUuDQo+Pj4gSSdtIG5vdCBzdXJlIHdoYXQncyB5
b3VyIHN1Z2dlc3Rpb24gaGVyZS4NCj4+DQo+PiBTbyBvdXIgc3RhbmNlIGhlcmUgaXMgdGhhdCB3
ZSBkb24ndCBjYXJlIGFib3V0IGV4dGVybmFsIHByb2dyYW1zPz4NCj4+IElmIHRoYXQgaXMgdGhl
IGNhc2UgdGhlbiB3aHkgYm90aGVyIHdpdGggYWxsIHRoaXMgYW55d2F5PyBTaW5jZSB0aGUgc3dh
cA0KPj4gaGFwcGVucyBhdCBib3RoIHBhZ2UgcHJvZ3JhbSBhbmQgcmVhZCwgd2hhdCB5b3Ugd3Jp
dGUgaXMgd2hhdCB5b3UgcmVhZA0KPj4gYmFjay4gV2hvIGNhcmVzIHRoZSBvcmRlciBzdG9yZWQg
aW4gdGhlIGFjdHVhbCBmbGFzaCBtZW1vcnkgYXMgbG9uZyBhcw0KPj4gdGhlIGRhdGEgcmVhZCBp
cyBjb3JyZWN0Pw0KPj4NCj4+IElmIHdlIGRvIGNhcmUgYWJvdXQgZXh0ZXJuYWwgcHJvZ3JhbXMs
IHRoZW4gd2hhdCB3b3VsZCBoYXBwZW4gaWYgdGhlDQo+PiBleHRlcm5hbCBwcm9ncmFtIHdyaXRl
cyBkYXRhIGluIDhELThELThEIG1vZGUgX3dpdGhvdXRfIHN3YXBwaW5nIHRoZQ0KPj4gYnl0ZXM/
IFRoaXMgd291bGQgYWxzbyBjYXVzZSBkYXRhIGNvcnJ1cHRpb24uIFlvdSBjYW4ndCBjb250cm9s
IHdoYXQNCj4+IHRoZXkgbW9kZSB0aGV5IHVzZSwgYW5kIHlvdSBjYW4ndCBkZXRlY3QgaXQgbGF0
ZXIgZWl0aGVyLg0KPj4NCj4+IEkgdGhpbmsgdGhlcmUgaXMgbm8gd2lubmluZyBoZXJlLiBZb3Ug
anVzdCBoYXZlIHRvIHNheSB0aGF0IGV4dGVybmFsDQo+PiBwcm9ncmFtcyBzaG91bGQgd3JpdGUg
aW4gOEQtOEQtOEQgbW9kZSBvciBpdCB3b24ndCBib290Lg0KPj4NCj4gDQo+IEhvdyBhYm91dCBz
d2FwcGluZyB0aGUgYnl0ZXMganVzdCBhdCB1c2VyIHJlcXVlc3Q/IE1heWJlIHdpdGggYSBLY29u
ZmlnDQo+IG9wdGlvbi4NCg0KTWljaGFlbCBoYXMgc3VnZ2VzdGVkIG9uICNpcmMgdG8gYWx3YXlz
IHN3YXAgdGhlIGJ5dGVzOiBpZiB0aGUgU1BJIGNvbnRyb2xsZXINCmNhbid0IGRvIGl0LCB0byBk
byBpdCBpbiBzb2Z0d2FyZSBhdCBTUEkgTk9SIGxldmVsLiBJIGRvbid0IGtub3cgd2hhdCB0byBz
YXkNCmFib3V0IHRoaXMsIGJlY2F1c2UgSkVERUMyMTYganVzdCBpbmZvcm1zIHRoZSByZWFkZXIg
SSBndWVzczoNCiJCeXRlIG9yZGVyIG9mIDE2LWJpdCB3b3JkcyBpcyBzd2FwcGVkIHdoZW4gcmVh
ZCBpbiA4RC04RC04RCBtb2RlIGNvbXBhcmVkIHRvDQoxLTEtMSBtb2RlLiIsIHRoaXMgZG9lc24n
dCBsb29rIGxpa2UgYSBoYXJkIHJlcXVlc3QuIFRoZSBkb3duc2lkZSB0byBkb2luZw0KdGhlIHN3
YXBwaW5nIGluIHNvZnR3YXJlIGlzIHBlcmZvcm1hbmNlIHBlbmFsdHkgd2hpY2ggd2lsbCBtYWtl
IG1hY3Jvbml4DQp1c2VycyBoYXZlIHNlY29uZCB0aG91Z2h0cy4gSSBkb24ndCBoYXZlIGEgc3Ry
b25nIG9waW5pb24sIGJ1dCBJIGxlYW4gdG93YXJkcw0KZG9pbmcgdGhlIHN3YXAganVzdCBhdCB1
c2VyIHJlcXVlc3QsIHJlZ2FyZGxlc3MgaWYgSSBkbyBpdCB2aWEgdGhlIFNQSSBjb250cm9sbGVy
DQpvciBpbiBzb2Z0d2FyZS4NCg0KSSB3b3VsZCBsb3ZlIHRvIGhlYXIgTWFjcm9uaXgncyBvcGlu
aW9uLg0KDQpDaGVlcnMsDQp0YQ0KDQo+IA0KPj4+DQo+Pj4+IGFub3RoZXIgT1MuIFNvLCB0aGVy
ZSBoYXMgdG8gYmUgKm9uZSBjb3JyZWN0KiB3YXkgb2Ygd3JpdGluZy9yZWFkaW5nDQo+Pj4+IHRo
ZXNlDQo+Pj4+IGJ5dGVzLg0KPj4+Pg0KPj4+DQo+Pj4NCj4+DQo+PiAtLQ0KPj4gUmVnYXJkcywN
Cj4+IFByYXR5dXNoIFlhZGF2DQo+PiBUZXhhcyBJbnN0cnVtZW50cyBJbmMuDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGlu
dXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0KDQo=
