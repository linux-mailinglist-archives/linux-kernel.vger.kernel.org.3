Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403CB580E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiGZIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiGZIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:06:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C56EDF22
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658822777; x=1690358777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HGlsa2yQeAcmhp5nDeXtqkCQItYyuqxtpfPsy509ITc=;
  b=CG24Nqud8luedHHaH0hLdDhx24y6H6myXCY5so2ndp2b+h3vUjEYb43x
   Wfdqj3ZDNZHcCPtaLi66N0eRaA76Q96BMfXE4dV6xWxbRhHIRIlT1GgAb
   qD2trA2wequqU4x1Wr/n0VDcb1SYSK36fk6izfUq05yyaeLY7Magf8H7T
   nSdvpSuiuxdYB3U9jkjfSL2pbXhz5sWb+heGBjm/8SCGUZ7Y/y0UB2qce
   wddJt0KDxaMWuf5WYgEUPMs8F7mf2VdpEDJFBsGPpfJBgUcYdXyBtIe0R
   oMaTq3umfyoeCe5CeF16M+1J+rhpw/nLBZWKBSg7xTmKz9Vkjto7YfdnC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="166395279"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 01:06:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 01:06:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 01:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQpiXN27PXvrLWJCaPdg8lOxsxhWY8oNkPh79X9vSWj5pwwp9N8pX2QRk75kymGrynz91U9sBo05ha8RidE3QGjsCJR5yt3I4tGtWVB4iy+zhtdJctbPS/+smOqJmbXhmiiJ7SEG9cSjhSslnYmjjfvM5XVyaRZRDBigfVKohnSbWSV1TXs8WeIzhVdz/5LGgKHUnOcieOb2v6C5Z/Rsc96xvoZUcP9Ni/AeOw5tNrEq3VT62XpHDoLLdMONgAA1M47q8n+Gjt+RjL/iTXSZylWAab0wG63BNRfPfZRROZVjTLP8PKqmXiKEuycjxKOr6zKZlvOTcGP/WswZWnJySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGlsa2yQeAcmhp5nDeXtqkCQItYyuqxtpfPsy509ITc=;
 b=fM/hb9ayrIFiR+5yd+98lGQdtXDCVXKyByiLW33okA3LyoB201T8udFe54OxDi09ZgY7DJhxHUMhixTHnKlJd/ki6SWoKlG7Dxkk+mHHz3ZQ3s7w3tQQr2RquNlN55DV4TRNRdxPm0Yjzks1AkBIPjVm4YruNAPomx6NPaKDd68hB0uV2D6uQbnflSs1dNGc+yTEhJ+bzSSleKRZR3B+E+SFPb4eR1X+7LCmOlPgrqgFGbZKncT3F6WIdfqdbOGSbmRd2GHrfr4cbYO1Btzn3GAWqcstoE507D9+YR2wQExrMrkm5sDvqBAQL7BbJwv8lnDNDiXU0CMUDJgwlrb0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGlsa2yQeAcmhp5nDeXtqkCQItYyuqxtpfPsy509ITc=;
 b=HKhokSjO2lgJf9I3LKVUP7hZPxNPuHj4U61tif2mhG0KIfwBTIS6mHbZ1OHZ1SynWsAfkevXuEyWCg8z4pG5x+6Y4rs4AGqWQ0KeCk/jOkZ/AY9OnGg49awjbZz473FuoekC1jj1Ik6ni1yDOwVfujq4No7rINHbNOCJemExmsg=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 MWHPR11MB1551.namprd11.prod.outlook.com (2603:10b6:301:d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.21; Tue, 26 Jul 2022 08:06:05 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Tue, 26 Jul 2022
 08:06:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <Takahiro.Kuwano@infineon.com>, <tkuw584924@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 0/6] mtd: spi-nor: generic flash driver
Thread-Topic: [PATCH 0/6] mtd: spi-nor: generic flash driver
Thread-Index: AQHYoMaNVGoFuICE5kiLshJW1ov3CQ==
Date:   Tue, 26 Jul 2022 08:06:05 +0000
Message-ID: <b3d5ecf7-39e4-d6f1-93a8-9efc8e352c9d@microchip.com>
References: <20220513133520.3945820-1-michael@walle.cc>
In-Reply-To: <20220513133520.3945820-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 017de404-8074-4290-f8f6-08da6eddb06e
x-ms-traffictypediagnostic: MWHPR11MB1551:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaVHBTn/YoVrDGq8ZNj6ERgn+KaSL/2mx0RDsbx59CfnVe316Q+/pF/sGjXD5dQGtSpRgWB17ctMvWWsQdX6oCjPKOHBz4BX2GFzL1og+5Fuco7QeTWTsDFLaZe95ePcHeGvwX7sxjQUofSHFL/4jZSQfB5yjBgGKSm3XawlMnslUbx5q4wGcceMHcq/yMT1HvJcSq9A/y45LM53XLq8aEWLujMJziJdYaSFDPDUgLCU04GG8rJA1bQC8ha7/a5x6moourgIuXIgDEkxCFcq3p+UJjah5jcObLa/noVyGfsEmo+ALcRkeitc8c+p93EDRTEDFdmMA59gfxivvzcyR0G9nUnnUHGNVyNVuB52Y4rRbjj1yyVYkOqQwIdKdnK65KShViWBSyg++iyCFzX9hYqDlPOqbNh2YwgNixOW6izZ6PUigWtLBkO6c580Ae8UA9EzaEZNjOTTK+6Lq561K1jEk58KZA9PAn3XVdWPn0W64ak3kzllrrEqUitCblTiEstI5XGu1OWZUMK2kjuue0YBU1/IWMv1NxnUgxZMp7VtMBySyhoPds03hnjYFH1auw+AsyAbPPAOckKR5MUbGekYi+Nd3ZSMc/Ny1rbodpWfzONyU0j/gJVjiRE9RDQGzXXvBbpQ6SAh8dICCbUUcG+CyYcI166iaFJWXO78qWn/j4X6i4BZzfyD0ZVSJTy+EEPSimTSO4obZSatsPaP42VkR0ttYvBV9K3ijC5WxYLSwkpS0cKK8EzlZwE9Qi6RCiBM4ULrPBFKasxRlfqi46Owl//bb/KROi5VeSefjfN3s9mpkkWbmXTO/reRtoEXsp0ybb0Kf4T7b/tiBxmlQrbEA4nuD+DbSy6a9gB1x3x0Vg0XynMs7N2mGg8BJwA7VTTj9VAIOytRZlh+R7Z7uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(8676002)(66446008)(122000001)(110136005)(66556008)(4326008)(54906003)(66946007)(64756008)(66476007)(53546011)(6486002)(478600001)(2906002)(26005)(76116006)(316002)(2616005)(91956017)(6512007)(6506007)(38070700005)(8936002)(5660300002)(86362001)(41300700001)(36756003)(186003)(31696002)(71200400001)(38100700002)(31686004)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlhPWHNqcTB3LzdTbFk1d2lSYlpRZmVFTkUwd0laWHZpWUxWZzg3d01nVlF6?=
 =?utf-8?B?YU5HLzR0eTFNcURDaE16VFFNdkNGYUh1cENuSE1kaUd5WU8ra0EyUlhPKzhx?=
 =?utf-8?B?ekVxd2NjUGU0dE5HNFlsVmc5ZENGTnNuYVBmb0pXdVhjdTNkR1lwNkFvRWxX?=
 =?utf-8?B?ZUhVZ3liTmtXTTZsMUxkVU81UTNrU2J3RGpqQS9VUnM3NEhtem9WUktjWGQy?=
 =?utf-8?B?b21FbDgzQVhZK1RsR0xNL1BhTjVnejVoRkNUT1VSdDJYR2xRVVl5dUhrUmpK?=
 =?utf-8?B?KzBzVklraDJyR2l1Q3Z5VTR4c1U1c1RObDVrUHpTY0daM0hwbmoxZDlqaUtG?=
 =?utf-8?B?STh1clcrQWdzcklQZ0lHZTl3NXU3cXZ5eTRob2s5OTVISmdjejdNcmdrSzY1?=
 =?utf-8?B?WXI4Y2wxcWxDWEJTOUtoelFZQUNvU1lkdE5hWVMrb0ZYZDVNTDFjcDFQbVhW?=
 =?utf-8?B?a2FXVDNuVUpyTzI5NXl6SWJibkdtVUdXdTdvek5lSU1SMUlCRmlPNWxLMWlx?=
 =?utf-8?B?bE5qUTlDT1paU1VhZWFvOGxReEExei8za1d4Rms5U0FoQWtlUXVqb0FEVzFj?=
 =?utf-8?B?RlFxeWxpWC9yeDBUTWZ3a05vaWY5ckFrRmlSQldPVjh4bjg3L2M1QlFENlNT?=
 =?utf-8?B?MjlWRWxGdW9nL3JwY2xRMGQ5M01qcDVVS2xRR3VpZThTMVZianRmUVlJL1R5?=
 =?utf-8?B?dkVPTmJweUFOT2x1Z3Q5VkZ6c2ovMG1yR0tBK0cwRUoxTkNBVURqZWY1OGxh?=
 =?utf-8?B?MW9rejdubEQzMEJ3L0xnSEp2bFh1RTcvdTJFeXhmaHhWTjJjMjBXMFFuWVVO?=
 =?utf-8?B?djB4dmhmZXhOazNvVUJQWGcyaGkza29FQkdlalR0UTNpckRGV1JKT2NILzVV?=
 =?utf-8?B?cGdodTNOeWJORTl3VnRBNWwxc1VnVytwK0U3ZkFVQW9kM3JCMTQ5V08yTTY0?=
 =?utf-8?B?YU9rcXBRZzdhV3l0Y3ZuYmlITTRPOXdvT3BIOW1KdU5ZOHhyMDVZVGROWTd1?=
 =?utf-8?B?QXBOaG95Wm5zeE1IR3BpeDNQVU9SWmh5RjMwbVJzWDBzRnZ3RnlqWU51ME9W?=
 =?utf-8?B?RHhzUzVDLyt2TFVhNVF0QzJ5RzUvNkdPQ0c3cXVhZVI0ZmxHREY5UzJJNlM5?=
 =?utf-8?B?MFhJcnUvRitUM0Y5THZHRExHNUd2czExTTFJYjU5bmNiK2h5TVlVVGNtcy9Q?=
 =?utf-8?B?S3BIRlJKeFQ2ZjhnSkVzM2N5VTI0enZEck9ZRjBUZFVuK2lTa21QcCtlcnRo?=
 =?utf-8?B?SFBBYVBialpGbnNQTzBRMThvQURGRmdKeDkwbGNyeVRJNC9NWW5jeTFOM3Z0?=
 =?utf-8?B?M3kxZGhCektMZ21rZE9rNHhXaWVtUGlKZTJLeWFsTHVWVG5adEZzSUxaelpu?=
 =?utf-8?B?cnRGMTk3QisrdDZlNXdROG1iYWFqR2g1enpoRFQ2Z2ZPckJQTUJkY1BEWERa?=
 =?utf-8?B?bDNjVFduYUd1cVg5V1lqVEx4bGJ6ZVhVK0N2cXFVK0JjKzZMQk5FdDhUMVBs?=
 =?utf-8?B?SWdhWHJTejBEYWlsU0tKeFk5SkZUalQ4MjdkWHFzbTJSZlNsdWxtMGxreTdQ?=
 =?utf-8?B?SU41dGhFT09KdFdmOWg0UnF6ZEN6Y05KUDNkY1QvQVVnQ2VMSkVzOWl5aGZU?=
 =?utf-8?B?Q3UyeE5GZGd2QVZvRkhCTnRHeE5vMDBLNkNqUzR2N0xwRy94Z29rUWIzdGNS?=
 =?utf-8?B?aEFtb21JOTBlTjVzNlVoM29GbHhheXJtTUM5Q0gzTzdtSlRRQ3JRVDNjL3Q4?=
 =?utf-8?B?OUJEMjd6a2IzTy9uZ05oM05FbTRjejlFN0x6VzA5TWxvcHo5TjVpbGd3Zm5E?=
 =?utf-8?B?aXdWQ1NhZVc2YUlXZWg3SEQ1MDJMUCtqMXpEUEU5V3l4TnB3ZVJXbC8vOUhU?=
 =?utf-8?B?YllzTVRLRkQzUDM4SjQwYmhQcXVTOEVDN0xIMnFpeS9xbmI5ZjN4VS9jZFNz?=
 =?utf-8?B?NmNHdWt0dEJZZDdLNjBkYlBGN3RnRHdsMkxsNDBONlBFT2JFRXBSTGc3cnVp?=
 =?utf-8?B?em55YUVMdjJ6ajBNbDR4a3NNd3M4Mkx4ODM0QkJTSzJ0VmZ0ZUlPYjA4UlhN?=
 =?utf-8?B?ZGxBMTBxVWl6WmVMaFRGSUN0VzdUamI3Z1ZqZGROS0hNNWpRSURTZWwwelpv?=
 =?utf-8?B?VWRIcjlqeXg4dE1WUmZkeEZYY010VDVuRDJWSmZSaW1Xa0RKZk5pWVpIRnl4?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <417A972630933B4FAE19F4D31CF7389E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017de404-8074-4290-f8f6-08da6eddb06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 08:06:05.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZyXHFNl73w9VSLxG3QT++oqCKErMI6LSccijhTWOg74b+6TxpGmcVUYR5kQW5cjvAxbeRKgXfbZGXZNKKGp3sDL0VWg6IiLgL3f1MZyEOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1551
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRha2FoaXJvLA0KDQpXb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGlzIHBhdGNoIHNldD8N
Cg0KVGhhbmtzLA0KdGENCg0KT24gNS8xMy8yMiAxNjozNSwgTWljaGFlbCBXYWxsZSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgYSBnZW5lcmlj
IGZsYXNoIGRyaXZlciwgd2hpY2ggaXMgdXNlZCB3aGVuIHdlIGRvbid0IGZpbmQgYSBtYXRjaGlu
Zw0KPiBmbGFzaCBpbiBvdXIgZGF0YWJhc2UuIEFsbCB0aGUgYmFzaWMgZmVhdHVyZXMgb2YgYSBm
bGFzaCBjYW4gYmUgZGlzY292ZXJlZA0KPiBieSBTRkRQIGFuZCBtb3N0IChpZiBub3QgYWxsKSBu
ZXdlciBmbGFzaGVzIHN1cHBvcnQgaXQuDQo+IA0KPiBNaWNoYWVsIFdhbGxlICg2KToNCj4gICBt
dGQ6IHNwaS1ub3I6IGhpZGUgamVkZWNfaWQgc3lzZnMgYXR0cmlidXRlIGlmIG5vdCBwcmVzZW50
DQo+ICAgbXRkOiBzcGktbm9yOiBzeXNmczogaGlkZSBtYW51ZmFjdHVyZXIgaWYgaXQgaXMgbm90
IHNldA0KPiAgIG10ZDogc3BpLW5vcjogcmVtZW1iZXIgZnVsbCBKRURFQyBmbGFzaCBJRA0KPiAg
IG10ZDogc3BpLW5vcjogbW92ZSBmdW5jdGlvbiBkZWNsYXJhdGlvbiBvdXQgb2Ygc2ZkcC5oDQo+
ICAgbXRkOiBzcGktbm9yOiBhZGQgZ2VuZXJpYyBmbGFzaCBkcml2ZXINCj4gICBtdGQ6IHNwaS1u
b3I6IHN5c2ZzOiBwcmludCBKRURFQyBJRCBmb3IgZ2VuZXJpYyBmbGFzaCBkcml2ZXINCj4gDQo+
ICAuLi4vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLXNwaS1kZXZpY2VzLXNwaS1ub3IgfCAgNiArKysr
Kw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgICAgICAgICAgICAgICAgICAgIHwgMTgg
KysrKysrKysrKysrKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggICAgICAgICAgICAg
ICAgICAgIHwgIDMgKysrDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2RlYnVnZnMuYyAgICAgICAg
ICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgICAgICAgICAg
ICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9zZmRwLmggICAgICAgICAgICAgICAgICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1u
b3Ivc3lzZnMuYyAgICAgICAgICAgICAgICAgICB8IDIwICsrKysrKysrKysrKystDQo+ICBpbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmggICAgICAgICAgICAgICAgICAgfCAgMyArKysNCj4gIDgg
ZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IC0t
DQo+IDIuMzAuMg0KPiANCg0KDQotLSANCkNoZWVycywNCnRhDQo=
