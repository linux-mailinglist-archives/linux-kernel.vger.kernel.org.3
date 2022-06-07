Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB27C53F7B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiFGHzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiFGHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:55:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E2CBD6A;
        Tue,  7 Jun 2022 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654588502; x=1686124502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8ZytWdhWvn9f4cKePQaPrKMljbhomjjjZ2a6/b5nB8=;
  b=CRTq45t3KatoIhvzoqeT7ByP+oiqeLSDkU7IjKvooJz8uNHDUszEh+C9
   jNVK3e8DSVYDkJcfET/uOOh6Ta90ezSfNDwlCIcpOZT+q9fjhvt4+NkoV
   AtWh6+JwRrUxbFk+ptGRiRVMaua45d+K/GSs2aOglgF80GyWol2jCso5A
   WLYg2rOEKExTf3Psfto/Mcsh/Bu+0aYOcaY9fb9OvJxwLT1FuJD7gnRDk
   M01nBRK0lG2edeMupunL00ej+NoBHgAe0GWlLNlbXiXvn72lSMaVAxtR0
   MCeWymmTJzs9PVaxPPCiViIoVA2A1zOgNny1w4Cy9gC28AV4o8mHuBFFJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="162183496"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 00:54:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 00:54:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 00:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga/75nCXSlMO4uBCJCLzjh/VBqPwOp/FCRVpSrseVr/MHb5/ooVwda3E+5jM1umgsNFH+bzEHMS0oZlHyMiMceRf2FfCMg+dMW/NlP+mWh3cCH9gN2K8JQv6uITxGcxpKnhcgQ7A2FjUgWxJu4RIru0T6Xph+muu9aVLoMDhfCmhqvV2Hc0FKNZEvZCGNlm4vuE+m4lxKp5lhhAzlyF+zhMNhb/3XnoT3R/0xDB/tVVpulbuGhAZVVm/5a6HDfejhWKbnrkr98L1h0EYstzQ7GxiQlsvIvMttovWVhj6zwf2+XHvg4jYtdXbmQXaEl98PedWe/eFdJTYcQR7fmVa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8ZytWdhWvn9f4cKePQaPrKMljbhomjjjZ2a6/b5nB8=;
 b=ie1snja2HYId7xKW2KAVddm1VZzRB9GQBdlmouPlOAlmfMyhS5XvpYYTPNtnqWSWlp2ddwxO/Hf+CkRRjBjXjrxBhZO+AZWurbXmdkJoZVn2HcFDEIdLaqaUo4CYrr7zGM9ZVLAPyHnUJ6UTLScOwEFX1wYcXzDxow84t8/mGaaMtyRO/P6I1UyAYbUH6wbtYZ+V3InIBmCBYSDXe9IuhW2M/lBn5m39MwzdRXPSqut//YBFA040T7uqixTiUILCHUOSoO2FHRFFXDBhm1jzNtuA3aTAbSGnChyCzWWWSrTPApaYMv+Erg9zH8vDYimZ+xajVsANqowF89JtS+2cJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8ZytWdhWvn9f4cKePQaPrKMljbhomjjjZ2a6/b5nB8=;
 b=cdCKUMDZ2gh3wJbKW40VfGDd8Ke/876kXax/1OJZxWWOu0NFn4kMfnqQii3P8J0MDHvZhgm1EHYuwItA8S/tHeOroggYnwHOpWMAGWSMXwHdhxBNvlyFhiB6r9UK9Y4tcfruqMOJZNz2A3QrbzNVy9nTuDBjc+hgAk54Hqj0WbE=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by SN6PR11MB3376.namprd11.prod.outlook.com (2603:10b6:805:c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 07:54:54 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::ed35:677f:b973:ac96%8]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 07:54:54 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Thread-Topic: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Thread-Index: AQHYd0QmWAaHYSMcPkGcGHHu1K0zWK1CXQwAgAAGZuCAASf/gIAACd/A
Date:   Tue, 7 Jun 2022 07:54:54 +0000
Message-ID: <CO1PR11MB4865CA9098EA7E1C052823D792A59@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
 <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
 <CO1PR11MB48656331826CDEA9DFB6A11092A29@CO1PR11MB4865.namprd11.prod.outlook.com>
 <ed469c4d-cbf3-2f54-743b-a22c0c120df1@linaro.org>
In-Reply-To: <ed469c4d-cbf3-2f54-743b-a22c0c120df1@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95e6780-43ef-41bd-05e8-08da485b024f
x-ms-traffictypediagnostic: SN6PR11MB3376:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3376463682DE572D0717DC7D92A59@SN6PR11MB3376.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oINOKqUIJpl7IERsTasfWL1FFJPlz0Id4z6x4SfIgKC12Bdl95+Q0QHMoTHaZBhBwf98TGm7mNOOnN6UmwaZ7WYcU2TGzHeTu9ad+oHZMuy7Yc9ifcAL5HRSbzGonk0hfNZhkz3FNuGcfTlecbmVm2sDCmLiDKNs5yd37ReqTQT03/q30g9BI2AL5395IRC3aJXojUx0yw6e4DQgC6m1k64bF2bfMjYt/lj0ZJvhXN+2R/nwLcn5G597iLqOH5LrcX98eo6JCS4GsaskfSprlt4t58aJyxHPre8RGNfVm/Dbfeb/FU/b3DbR/En6ndieZbqN171Pqk+oi7orLiQGANeR12zO48BPgomSXVxx+TMKyWtol8rLFlG7pc8yvGnzGj1smKfg+kVfsUnY6/9qI0Wu+SmesenkvCnkOgKyXWCaRiO9PFYQc3tUEOW2fv7unllWXrz8V1z5XYAA49yV8Hl6VT1jjJSiMAHl55ZFrsQDJ7mBsnsvJcfoGiDiuOKn9mAgnnzC9OU48VbKbFxxs/lOvmRyjCyZZo6GRusfrubQUzh5mgpJpzdr2Q1npF2D/hNoBInHioRl7So70Lz1lw5EYAIqq8b8m45Avtta3GDBpx71cUkRt70yLgTOYVydAzY6QVgFfco4QvQJJX6NncMOywGQialH2k1W6qkUxwzJHGD7v8f3fmZHVdGsuEkjMhyr1THCsK/cnaxO80zsMkBuUUB8dJnvd/DvnYUeE/K4/2G/NV5j0yD0IjtZBqoH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(33656002)(8936002)(55016003)(86362001)(186003)(2906002)(38070700005)(6506007)(38100700002)(4326008)(66446008)(64756008)(66556008)(52536014)(8676002)(66946007)(107886003)(66476007)(76116006)(5660300002)(6916009)(508600001)(54906003)(122000001)(7696005)(71200400001)(26005)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW9zMjFpdkFvUVRQelpWRUpQaVdUOFFKMlArZURkZTRkNlp0S0UySjNtdEgy?=
 =?utf-8?B?NjdZWWlJb1dQb1NwQjdqcGkyWlpGdFp4cTYxVEp4bzhpS1ViRVlIR1FuREtD?=
 =?utf-8?B?eTdHVExBZVNGd20rNXdvT1FBUWRrQ21PbmJ6dklSQW1ETXlkaUJGNTdUZlpx?=
 =?utf-8?B?a091YVJkVDE3d3ZQWmxGU2gwdEp3U3pDbFlqakdWSTlNQjBaZGNVVVE4U0Zp?=
 =?utf-8?B?VGtQeHRZdHNSUWNtczdkSnJiOHZaRUViclM4TEgzSUJTQmZYaHpmQTJiQTZJ?=
 =?utf-8?B?Y2hhYVpDbWhSMVk2T1R4ems4cDZCMkdXYVBTZTRVc3lnWnJVREt2Y1pSM3NT?=
 =?utf-8?B?NG1CZkdpMHpvRVYxeEdmYjRtc25MekpDb0dHbHNDMCsvR0xLYVFmVUltdDdF?=
 =?utf-8?B?YmJCKzhYdEg3ekVTNm1scFlUL29ySzBIU3Y0dlYwQ1BZTVd3emN0Z0V4blI4?=
 =?utf-8?B?czJibUgvWVdZazRGaU5KY3o3NTQ4aStZR1V2RjFjTUtVNEJNTkVzR1k3dDV3?=
 =?utf-8?B?c0lnQWRob3lrZTdHUDM1Qi82MDUrRjJ3eDRrWlUvZk9zMDlXOGNtRTRZRXlu?=
 =?utf-8?B?Ry9Jb3FkaUJ1RXUzaTdhbXBtbzhWbG1GbFRKWVBQOXM0UzdRVE13cWlzN0hO?=
 =?utf-8?B?TTR0dU5qcUI4Z1oydCt1Ky9DYnZIMWd2YnJzeW1VeXp2TDVDOVA1elIraDd3?=
 =?utf-8?B?c09WVDY4bkIxSytlUExpOXluOUVYL0N6N1NFN0ZZMTBYU1RxWDh1VFdMK2pC?=
 =?utf-8?B?emFaWGF6TjlQcytkUG9iNy9RSkdiOUVSUVdTbVVCRlpPS29hT1hLdTc5Q0F1?=
 =?utf-8?B?KzBSVUhJblNrSGtKcFliL0docDlDK3YxS1dFb0RBdjcxdDcxaGozSm5BTzh0?=
 =?utf-8?B?SnAyR3ltbUNiYS9LZnNEbHg0U3NxWDVRRVRETUo0QVVlVEEyQUxBL2VKdjlm?=
 =?utf-8?B?NlFZenk1aGtiNlcxa1RMcTc1NFd0VFErZ2QzSng2V1VPYkEyWEl3bktkRjVM?=
 =?utf-8?B?emdVV2ZIb1lqVnU5U05YSlZOT3lKOEJINHN1bGNtNWNqUFM0RVdrVTdpeUty?=
 =?utf-8?B?K1pWU0RyNW8rREtEQjZFUVFQczNjVXZMWkprS1gybXlxcWw1TTJpYkxCTmpH?=
 =?utf-8?B?azBxcWNralZwU3MvQnREYkl3c1ZJUGZVY05CU3MxVE9pNWs2WUVYQ1cxZytW?=
 =?utf-8?B?MUZCa1NINFBQT1VHZ3B5ZXpYVGQrVFZvRVZYLys2dTZrcGU0UmFSR0hkcXho?=
 =?utf-8?B?MWNXeWhRVXl4eitFbDhSY1pUOTVrblJ4NmIxczJ1RC8wdlFqenJBVFFJU0JG?=
 =?utf-8?B?YmJFS1k5QnB5ejNWR1hpZ0poS1hnZ3c4REtzeFl5bUpaa012NDUxVlFFa05M?=
 =?utf-8?B?WC8yT0dCMlJ1Q2gxMkYyb1lJQUFqelRRUjRpd2FUYU8rMnhubjhTOXJUV3RK?=
 =?utf-8?B?MGVJNm9jbjdkYXR5OHNYcndCSUo1dTNLS1UycmJLSTUvbzJzR204OFlrOEdT?=
 =?utf-8?B?TzdtbUhuRVMyaWxIMnRkR2VySHIwRTZDWU5LZEJGU1BBck51SlNuUGZxRElw?=
 =?utf-8?B?VlpCUTJEaGJZNXFFNVZuMGpqZlFOSHF6N3NFTDA5eDVMQUNOdTBJVHZZeHBL?=
 =?utf-8?B?ejhiUy9KNTBoUDkzY1RHUkZXMnlyTGZwK2JPNVU0Mk50WEhPSXRvWWVDbzVv?=
 =?utf-8?B?R1F1QmdxcEJUSW9xd3M1SFh6REIzTHZDaWdFWnEwdnpZdUY0a0Y0bDVzeTdz?=
 =?utf-8?B?dWhESWlKbm9GQkhUN3dqeDZvVDM1dy9kNlovWlVYeXpwY0plL2dnSlRuSUw4?=
 =?utf-8?B?bDJGOGloZWdmLzU3NExOOUEwWW00QWRpZy9WditZakJsNXhkdVpGaUFRbnBV?=
 =?utf-8?B?U0FsRk9ZbWppV0hSbVpHNThmWFgwcUQ0cGwyWGZkSjEra0lpQ01wRFJFRG9p?=
 =?utf-8?B?R2oyd08xZmlBNFNkR0IyMUIxRjhRZnFsTmgxcUZMYmpYVWVmWUhTR1JqSXhv?=
 =?utf-8?B?RzdmeTAxS0xlR1d6eDU5T0pHd0I0SlBEdm0wZDdtV0xwRi9CdHZhWVVpeTNG?=
 =?utf-8?B?eTduQUFHQ0tCS1dMMzdqSCtDcnYvcndsdGdWWWx4cm1KVmtKWGEzV2xxdmZF?=
 =?utf-8?B?Y0pxSFNJRFRUd2tqWndDVzZYWmlkWWNXLzAwRys5QkM4cnlHaEZZY2VJdjFL?=
 =?utf-8?B?Y1Y2QmZLV0NXYkhhRHg2YWhjNzdMS3pjUTA1NkpVVjlTdjJ0OGgwWVVxUGx1?=
 =?utf-8?B?SEZLcU9sMWtseC8zak9wV25ya2djQXFVZEJUdktxUGFXdkJhZWJZSTJ3OXRX?=
 =?utf-8?B?U3N3eHdHVEExY1N1SUlpWm9VdGVjOWZZK1JtR0JYM2xHeW5oOXJOVnREZFIy?=
 =?utf-8?Q?d77XJbxnYlAl4Kn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95e6780-43ef-41bd-05e8-08da485b024f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 07:54:54.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AUhTF16FkgBRNuKlJN/KDIGkqQ3bz5MO+2D0qj9nPqRSko+VuwmZIQDx9zyK5N2hm/BFxUxYkSbeQf7MbEAZ5jZKgoHK9gcEu9Jcf1up2F9TQmBjVTEM5ml3ngtduke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3376
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gTEFOOTY2eCBTb0MgZmxleGNvbXMgaGFzIHR3byBvcHRpb25hbCBJL08gbGluZXMuIE5h
bWVseSwgQ1MwIGFuZCBDUzENCj4gaW4NCj4gPj4+IGZsZXhjb20gU1BJIG1vZGUuIENUUyBhbmQg
UlRTIGluIGZsZXhjb20gVVNBUlQgbW9kZS4gVGhlc2UgcGlucw0KPiA+Pj4gY2FuIGJlIG1hcHBl
ZCB0byBsYW45NjZ4IEZMRVhDT01fU0hBUkVEWzAtMjBdIHBpbnMgYW5kIHVzYWdlDQo+ID4+IGRl
cGVuZHMgb24NCj4gPj4+IGZ1bmN0aW9ucyBiZWluZyBjb25maWd1cmVkLg0KPiA+Pj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1p
Y3JvY2hpcC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4vYmluZGluZ3MvbWZkL2F0bWVsLGZs
ZXhjb20ueWFtbCAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKystDQo+ID4+PiAgMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1l
bCxmbGV4Y29tLnlhbWwNCj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+Pj4gaW5kZXggMjIxYmQ4NDBiNDllLi42MDUwNDgy
YWQ4ZWYgMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gPj4+IEBAIC0xNiw3ICsx
Niw5IEBAIGRlc2NyaXB0aW9uOg0KPiA+Pj4NCj4gPj4+ICBwcm9wZXJ0aWVzOg0KPiA+Pj4gICAg
Y29tcGF0aWJsZToNCj4gPj4+IC0gICAgY29uc3Q6IGF0bWVsLHNhbWE1ZDItZmxleGNvbQ0KPiA+
Pj4gKyAgICBlbnVtOg0KPiA+Pj4gKyAgICAgIC0gYXRtZWwsc2FtYTVkMi1mbGV4Y29tDQo+ID4+
PiArICAgICAgLSBtaWNyb2NoaXAsbGFuOTY2eC1mbGV4Y29tDQo+ID4+DQo+ID4+IFlvdXIgbmV3
IHYxIGlzIGhlcmUgd29yc2UgdGhhbiBvbGQgdjIsIHdoZXJlIHRoaXMgd2FzIGp1c3Qgc2ltcGxl
DQo+ID4+IGV4dGVuc2lvbiBvZiBleGlzdGluZyBlbnVtLiBXaHkgZGlkIHlvdSBjaGFuZ2UgaXQ/
DQo+ID4+DQo+ID4gSSBpbnRyb2R1Y2VkIG5ldyBjb21wYXRpYmxlIHN0cmluZyBmb3IgbGFuOTY2
eCBhbmQgYWxzbyBJIGhhdmUgbmV3IERUDQo+IHByb3BlcnRpZXMNCj4gPiAibWljcm9jaGlwLGZs
eC1zaHJkLXBpbnMiIGFuZCAibWljcm9jaGlwLGZseC1jcy1uYW1lcyIuDQo+IA0KPiB2MSBhbHNv
IGhhZCB0aGUgbmV3IGNvbXBhdGlibGUsIGhhZG4ndCBpdD8gVGhlIGRpZmZlcmVuY2UgaXMgaW4g
dGhlIGVudW0NCj4gLSBiZWZvcmUgeW91IGRpZCBub3QgbW9kaWZ5IHRoaXMgbGluZS4gTGVzcyBj
b2RlIGluIHRoZSBkaWZmLi4uDQo+IA0KWWVzLCBwcmV2aW91cyBwYXRjaCBzZXJpZXMgYWxzbyBo
YWQgbmV3IGNvbXBhdGlibGUgd2hpY2ggaW50cm9kdWNlZCBuZXcgbXV4IERUIHByb3BlcnRpZXMg
aW4gYXRtZWwtZmxleGNvbS55YW1sIGFuZCBtdXggZHJpdmVyLg0KQXMgcGFydCBvZiByZXZpZXcg
Y29tbWVudHMgZnJvbSBQZXRlciBSb3NpbiBvbiBkcml2ZXIgcGFydCwgTXV4IGltcGxlbWVudGF0
aW9uIGlzIGRyb3BwZWQuIFBsZWFzZSBpZ25vcmUgcHJldmlvdXMgcGF0Y2ggc2VyaWVzLiBOb3cs
IGZsZXhjb20gY2hpcC1zZWxlY3Qgc3VwcG9ydCBpcyBkb25lIGluIGF0bWUtZmxleGNvbS5jIGRy
aXZlci4gU28sIEkgc3RhcnRlZCBuZXcgcGF0Y2ggc2VyaWVzIG5vdyB3aGljaCBpbnRyb2R1Y2Vk
IG5ldyBEVCBwcm9wZXJ0aWVzICJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIgYW5kICJtaWNyb2No
aXAsZmx4LWNzLW5hbWVzIiBhbmQgZHJpdmVyIGNoYW5nZXMgb25seSBpbiBhdG1lbC1mbGV4Y29t
LmMgZHJpdmVyLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
