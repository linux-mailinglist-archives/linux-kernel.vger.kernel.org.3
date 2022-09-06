Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1290B5AE12E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiIFHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiIFHgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:36:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B6913DDE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662449769; x=1693985769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GfrWvqJ2Yk4lNCIi6maLCyqMCE7xuPbBeLan3hXpQA8=;
  b=WFxzhbljB7y7ppNuqmvS/aRpZ8ehueEB44sJwKuQlTi6mm17QdySNX92
   rUNYCb704VI3qwotKsqcvTu/rWAunHtJaa8D2lKcHwvP/ehVMxxOCp9In
   SS9XF76wTxANK50VAmfpwfY05XMjCNDAxoyIxYpGVUpoqxj1SurxLKErX
   J7ONSv/wZr0TBr/U/+QMjD8+aXgJZEtY2GCiCbfoZ52COAw+rQ8N3g13x
   8ziyDa69xcWlOV3TEMoMmEaAVNGvsQSrsRc0vg2dGhGzZWL/nqHArQ/kg
   ozDykwsyFNYkMxRc12PNm93dMXpB+ahLYsYJUDEz9slUUvdTt65kuw3FY
   A==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654531200"; 
   d="scan'208";a="322708513"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2022 15:36:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHiipqu3Nyw0MI5ZAtzc9O5WTIH43l20pTBxqiUWJTerZPVBv+Tk85SnuI17edMixkyjv+WOCJBdiE4EvR6utom1RN7xXqoyOYmFDjBZdwvG4UyOZ2lr/8a4dLx1wVumGB7VB2opUr9KLwhO0V0wzu8IG5yEDDSkbTdsm7mMR4ZZgYye2/aO8uuhyFgQIow2xm1kl+I+2pXBlPIPdJtQccvS6YD1PQ657iwvyq0D0VLcPsF7pLYez0LmL1ZVjY/ec0QP7uXam91Ua9OZm+WFPTmseA5f7lXVo7hxERx8NFNLGtE0hox7p8tWzO+ZEQSnvI5nVg60KyVYkQQOLbKv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfrWvqJ2Yk4lNCIi6maLCyqMCE7xuPbBeLan3hXpQA8=;
 b=ZF1e7YUzDQRTk4m5ce8z1I+hXS1D0+eB4IYMbvrG+377WQKwCyYqSHsbTx/xCmK+7YuKYKZk4gGYULpKtBCRNs6Hpqo5WHzwqfu06BU36gbm6AcTGOV6OZqHdS1ftv285dzDUcsbKQpKhmabWaoWvqkM0qDdaP1oJ5nPbGcSF9xnQI/LPE+X1qjTJnVbhYIAF/de35uHcm2/Kepm2+RG3GzN2uLYmaQaEkbqLW66XkFtSrDjaIGQ+zzFVv8Sk/8QVzUn2VUlg7WVH9zMZBy2pMW/9p2RzE9LWYkv4wJiEffHrFTHlkDQa3Z+zKlz8z6DfBV/wQygdfQKKZ13kWts0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfrWvqJ2Yk4lNCIi6maLCyqMCE7xuPbBeLan3hXpQA8=;
 b=h2xPLBNgatJIHZPjhhz0a+XyhtG3oTBN2rZsZv+5OQ59eDBscVQZN8rGhGyAq0WHyMNmYaGsRFbqSx7dOETJP4+lQz3bqPz8TOLzBSstFvnAr2AiIxa9Im6n+CEWWHEu9w6mIwfOL9/Wh9c8wz9xHs8O0mJlMvtXNCpKWUEvA1o=
Received: from BY5PR04MB6520.namprd04.prod.outlook.com (2603:10b6:a03:1c6::18)
 by DM8PR04MB8087.namprd04.prod.outlook.com (2603:10b6:8:2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.12; Tue, 6 Sep 2022 07:36:06 +0000
Received: from BY5PR04MB6520.namprd04.prod.outlook.com
 ([fe80::bc24:4048:67fe:b8b2]) by BY5PR04MB6520.namprd04.prod.outlook.com
 ([fe80::bc24:4048:67fe:b8b2%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 07:36:06 +0000
From:   Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvmet: fix mar and mor off-by-one errors
Thread-Topic: [PATCH] nvmet: fix mar and mor off-by-one errors
Thread-Index: AQHYwSJaAk5sh4abmkS2rpDann1oRK3R1M2AgABRGYA=
Date:   Tue, 6 Sep 2022 07:36:06 +0000
Message-ID: <9A16934B-008A-415B-BBA3-8C646BD46A8B@wdc.com>
References: <20220905122116.2678206-1-Dennis.Maisenbacher@wdc.com>
 <20220906044549.GC32413@lst.de>
In-Reply-To: <20220906044549.GC32413@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.64.22081401
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fab57cff-b7f4-4c89-58f6-08da8fda7580
x-ms-traffictypediagnostic: DM8PR04MB8087:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/3/F+9ffBdDFKJlThK1TwC3GWUQWlGZmoav9t+MZmD6BlcVCs1waVEasOPdXxieSv2/z/nethjyjOZ7BRVgbddcctaTemWxUBhGIYu0MM+7PO4asNprVkninGqjIAPZGKBK9wkVSoeFUb2Tb7KxFD9Tm6XcYI3/t1L05ilU/OeoupBJ4wCj6GctdjjIx42Oew+s0dijK6FsR9S9oeuzQDhq9c1RIKIhZvVNVYezK59MRxQtZlsPrIyOKdfVY27LQEq71Q1Lso+HCVxEa2n9RyX3Zr2jByDaOE1BRTAv+ziZLCS/me+tuXqhy+fR82lTtWf3hi6IN58/VTbAkrApfMnlTWZDR+nDP/w+GSciKLt4CnGu8ttqZfERYjO7/qQM38zukqkyTRC1kYf1YSG4clOngxSIt/k+e11QaqFq9fPAD47le5q6NdNlzH11ou8kGCIIoMj8UDhPE8gvDcULmPkYewiqyDBHsySy3hezqC8la1w72Qb88tZd8QOBRXz4PixaAGE82szDIaW/Xj2YLp92crPQhgDxmFm/YLydDVtFiAEnuo2K8/47BHiCjR50TSYIcNrw9sR2i6QcHfW0/od1+kpGA8PhYnrEZmsZFREPn5l+HWy2Tj1ucevfQ/OWI1QXOFr2fw4WxoEPIGiFRo0I7zYv4sagvLypXCtYNP7fpAvnzSinyrSp9U52BVCowhqIao2PmWF3glAIddpRN3ugVWWSYWt/IXel4uG0wTo/1ZieVbH/wdZhbUzjW/htIGWsBHfTUIfeT5cm5Q4AQl9FQ3vTvBu72EhJWMKG88A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6520.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(54906003)(83380400001)(316002)(76116006)(64756008)(6916009)(6486002)(91956017)(36756003)(66556008)(4326008)(8676002)(66446008)(66476007)(66946007)(478600001)(41300700001)(86362001)(6506007)(186003)(6512007)(2616005)(26005)(2906002)(4744005)(71200400001)(33656002)(44832011)(8936002)(122000001)(38100700002)(5660300002)(82960400001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzV2dDZyOFR5WDl4SVMwZnBzUkN2S2tibmRQVUkxcm1tQUJsUE12bTIzM0Zj?=
 =?utf-8?B?U012dUNjSHorMzJMOXdQNXRxdzdxbFlFR1dwTUJpbkcxcUZPRlNBU0JIRHht?=
 =?utf-8?B?ci9DSzRqbzhKeVNyUkhvREFiMDlxdWZBd1FRZnJXbmF3TXhqTC9ndllXYU1E?=
 =?utf-8?B?NTZBRDI4YXl2cnp3Z3NzRDAvcmNkM1Z1SnFYWUk0WHFzMFkvejJmbUxRMTJG?=
 =?utf-8?B?cVFSSkhXMlIxVnNyKzRHTmgvR2ErUEV4UHNqSjI3NEFNdDVnNlkyVzllUDZE?=
 =?utf-8?B?WEZWS1ZUS0Rrblpsbmk1TjBFRDJsT0RRYlUvRklNOE45Z2hpbWpHbzhsc0xr?=
 =?utf-8?B?TzdjT1JWODYrWHdreVpOdmRwbXAzSTBGYXhUZHZhUGRRZEcvaUhVRmgyb2wz?=
 =?utf-8?B?dUpiaVVmQnh0bno0NzV1QW9RNGgxL01uNlQyZTJKN2VMYXBROEZwaTlSOFNu?=
 =?utf-8?B?R0t3OFNENzZpZmlKWTc3WlRxbVI5L1NSZWlmMjZXYy9KVkdEWnZZaE5BVkN4?=
 =?utf-8?B?SkdEQitPcWlIOXVmZGd5YU9XUXE3cmtsQ3NZcFN6ZUtiWlE1c1IrQjlQdndO?=
 =?utf-8?B?WjB3S1owOW13UlVJV0JSQXNScS8vWVNITHJYbmI1ZitiNURFMEg5aHplN3ZQ?=
 =?utf-8?B?VTZLZWRxZmtrUDU0SThVOXA5VlMyWTI1aUFFTGxZL2xwQXZ4OEJOUEo1WnpH?=
 =?utf-8?B?S01BWVFDMEIwOXNIVUJ6NndZQmMyN05vaXlWa1JsY05yMWNqbno4eU0yRHFG?=
 =?utf-8?B?SlhsTFhIS080ZExMTXIyd2hjZnFYT0psc2tlYllpWERNZWpCQVMwRlhkd1lO?=
 =?utf-8?B?TTcwd0lRRUQrVTlvM3BRd1hGNTErVjhkRlAyOXY2bklhZVdBdG8zSXJudXo5?=
 =?utf-8?B?amxpNlk4VE5EWXU3Y3lTZ0VJS3h3Vi9QeHQ2ZEU0aU56dUgrUFE2Y0RFdVJs?=
 =?utf-8?B?M20rWXhwZ290YjlldWVLNmowYWZIbFBHbjVQYzFYd3lsaG5UbTV0Z2NsYzFB?=
 =?utf-8?B?R0lvVUY3QjAzUFcwanc5NjhmeEZoYWgrOWlMU0ZRWmgrMndyRnhxV2d4YUNr?=
 =?utf-8?B?anlzWUQyMWRSZFIydzduR1RZZUFXWGo3MXFzb3BZS3VuUlVuSWRQS0lWeHU0?=
 =?utf-8?B?a1BjNEhjcGFhTzk0ZzFqSEtXVzRlQVVPNWlIbzN4dENTSS80SzgvWFUxeEJt?=
 =?utf-8?B?MUZEN3M3WnFCSE9MUFJmSzBOMzl2SWQzUUFjRDE2Y2Yva2RBTzQ0RVF0dlly?=
 =?utf-8?B?TmRvaGRpRUxsQ2pvbURLNXBVUy9BWk1tMFRhNzk4TlBUWDZpamFIY0ZxS3dI?=
 =?utf-8?B?QzRlblVBMUI2RUlaU004VDVHOUZwdTlwcG5qNEpYTVc1cW1vdUxpU0ppZndM?=
 =?utf-8?B?TXZpOXY4bEk1RVRzYm5sNnRkOWZleWlxcXNJTXY4Q3plcU02c3lYSkVzNXBN?=
 =?utf-8?B?NWc5ekEwSWFhcU5KdlRxYkZPUTZ1QVQ1Y0NxTjQ1ZGJGV3ZvVExkdlAwTU01?=
 =?utf-8?B?bWVMVzhPTmpWZ09UYzdRVm9YKzlwVW9SQXphSFRkMjgwbVpSQ1B1cnE1VnU4?=
 =?utf-8?B?SUZ1U1lUT0RoOTM4Vyt2cnVYZWhXSGQ2NmUvZGN4Q0Mxa0xhTlpmRXBmdk9q?=
 =?utf-8?B?ZHgxc0MwM2FhZ2F2MGs5UENaR3BHZkNQTi9HZW84UjdYdkYvVllWVFA0VjA2?=
 =?utf-8?B?RHY4TURUQmlrWGFoMG9TWWJpOG11TGFGQlliY0M2ZDFSZkFIUlRncVFIZTlG?=
 =?utf-8?B?R2FXdGlQdTZYMEErSU8yNWsvM2R3ZzN0dGh6bldHZVd5L2F2bEI5ZjJRaDIz?=
 =?utf-8?B?eXFTMlZSaVlyU1NVN3hWY0dNRzg2bjRKTHBxdzF4VFhteTdoNjFyMHBqTGhZ?=
 =?utf-8?B?d0lCa3hyOHlFb3plYTMxVUwvRHpjN1czYjBqdncwVm5OMStGTThIQUlYNXJp?=
 =?utf-8?B?TDljNStCUE54Q3dLcVlhOWpHWWhlNnVmR2Jtd3M1bU1vWXdva2NBUUVtTUND?=
 =?utf-8?B?L3ZkcFhjdFNBZEFwclNsbFZNVVcrOGNnS05UMGVLa3ppTG1tYzd5MDZhU2NL?=
 =?utf-8?B?dUxlOFdBdEliOGFFVDUxanFYUm02STltVjVybHE1cjlJM0s4a2lBL3JkVTBZ?=
 =?utf-8?B?b0d4TXdhdG5FWFgxdWZ5eDBFeHBaeU8zOWZxQ3NJRTJXMHo0WjVPU1hiS003?=
 =?utf-8?Q?0hrNNcSVygWtijyjOEYOKNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97B94F60DE3D6742931E2EB6F852EDC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6520.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab57cff-b7f4-4c89-58f6-08da8fda7580
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 07:36:06.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfWvHrUkvXla+kg7BA20XavdibDDkWZjcBqtLRav0FdeVAXIJj7+XplZhEaPTrNcisy0CJB4oY50apQn7yoEx+Zej0sUbHULlSMsx00ivlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8087
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gQ2FzdCB0aGUgdW5zaWduZWQgaW50IHZhbHVlcyB0aGF0IGFyZSByZXR1cm5lZCBieSBiZGV2
X21heF9vcGVuX3pvbmVzIGFuZA0KPj4gYmRldl9tYXhfYWN0aXZlX3pvbmVzIGludG8gdTMyIHZh
bGVzIHdoaWNoIG5lZWQgdG8gYmUgZGVjcmVtZW50ZWQgYXMgdGhlDQo+PiByZXR1cm5lZCB2YWx1
ZXMgb2YgdGhlIGJsb2NrIGxheWVyIGhlbHBlcnMgYXJlIG5vdCAwJ3MgYmFzZWQuDQo+PiBUaGUg
Y2FzdCB0byB1MzIgaXMgbmVjZXNzYXJ5IGJlY2F1c2UgdGhlIHNpemUgb2YgdW5zaWduZWQgaW50
IGlzDQo+PiBhcmNoaXRlY3R1cmUgZGVwZW5kZW50IGFuZCBhIDAgcmVwb3J0ZWQgYnkgdGhlIGJs
b2NrIGxheWVyIGhlbHBlcnMNCj4+IGluZGljYXRlcyBubyBsaW1pdCwgdGh1cyBpdCBuZWVkcyB0
byBiZSBjb252ZXJ0ZWQgdG8gMHhmZmZmZmZmZiB3aGljaA0KPj4gaGFwcGVucyBieSB1bmRlcmZs
b3dpbmcgdGhlIHUzMi4NCj4NCj51bnNpZ25lZCBpbnQgKGluIExpbnV4LCBub3QgdGhlIEMgc3Rh
bmRhcmQpIGlzIG5vdCBhcmNoaXRlY3R1cmUNCj5kZXBlbmRlbnQgYnV0IGFsd2F5cyBhIDMyLWJp
dCB1bnNpZ25lZCBpbnRlZ2VyIHR5cGUuDQoNClRoYW5rcyBmb3IgY2xhcmlmeWluZyENCg0KPkJ1
dCBJJ2QgbXVjaCByYXRoZXIgc2VlIGFuIGV4cGxpY2l0IGNoZWNrIGZvciAwIGFuZCBjb252ZXJz
aW9uIHRvDQo+MHhmZmZmZmZmZiBhbnl3YXkuICBZZXMsIHVuc2lnbmVkIGludGVnZXIgdW5kZXJm
bG93IGlzIHdlbGwgZGVmaW5lZCwNCj5idXQgaGF2aW5nIHRoZSBleHBsaWNpdCBjaGVjayBleHBs
YWlucyBtdWNoIGJldHRlciB0byB0aGUgcmVhZCB0aGF0IGl0DQo+aXMgaW50ZW50aW9uYWwuDQo+
DQo+Q2FuIHlvdSBhbHNvIGFkZCBhIEZpeGVzIHRhZywgcGxlYXNlPw0KDQpTdXJlLCBtYWtlcyBz
ZW5zZS4gSSB3aWxsIGFkZHJlc3MgeW91ciBjb21tZW50cyBpbiB2Mi4NCg0KRGVubmlzDQoNCg==
