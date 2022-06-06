Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69253EA4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiFFJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiFFJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:01:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804A1862B5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654506059; x=1686042059;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YIpkd5IIKg1ixiCTgqY6C0MBrqnJfOwDDlB7m1AdhWk=;
  b=FgqyFfnkeOvHhbAMA2t/tmrcgR+ajT8FWbaDKr5m78epdC1mI4vsKWZy
   3fhB4gGJVzWjh7Ggi2Jc/VtqSIs+rateVIery+9NFMR8deGg0v89RXH/H
   P01h24hXEU5W68DWc8PVRIVEYRHKwJIBucKcEAAj8gnd/26efJwN6AfTa
   QwQrsasexaB15Hs9UBuyLxRDvbAtPDwHAZ74rGXPJEGqEoWRJQl/0syYE
   dkBpMFO68f5in5rAIe7EyiDKg7ullV9+dE918REsqtGPnoC7gr5XyojVp
   wLXoMsU5zmxFRO1ryN53ZZKBcCrzS8S3E0+vx6jh+74JoBE6sQ1GC76Lb
   A==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="98706450"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 02:00:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 02:00:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 6 Jun 2022 02:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ9Ou+52XRqHuOwONv35r3bmart+NaP9y07mAx4uEXA/tSZQzyF5+qWnrHuw9bkbhrytOPXgXFX/MBMK22F7zyovoBa7LeSJLwURUJmsLFFBlRumnEV+5PwLRwWWtAlBM7X7xKuf3tBdpEGvdMlcc6gA8+lrL5PJUr93jiS4HbNCxU9z0QQ/kqlxTRJWBItBh/ddzr0GSf8nljQhCIMpNvJ1taIDBYcG10fwXP/OiDkPxiu7UkZomM4Omwt/Zp4Bf5Ifs1KMAGevKgOHYUhjR/ETEl6vLreOQHSraQC0L2duAqCwCLLGhUYEaIRg9IzYj2NSULyOwa5svDzJUFLtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIpkd5IIKg1ixiCTgqY6C0MBrqnJfOwDDlB7m1AdhWk=;
 b=FjlqLeVLORqWtEWte9nFtjNuil2nmFhxngAimp2m6v0Adenp4cF+4eB4WCCqtfeRepNoxLgoHl4X0aInXE3IYJJdkG8iQI5uUVwozNmR3umgZ03vKUv9qdZ5UlQA7YJPeNfFmI5pVpsy2few8YRpKmlhk1L14n3iHYAD/wuygTh0WhiqmmTNjsSY2ZNHkD687CdrpFhaKwmAfTCIeGXW5ledX9o9UB+MTMLLz1HEfXKDTRSrCtzw6YBEhfQaDNEMiEgMI4bFnWaWYOQCHl+s2/WELM/nPmlwD88/QLOuTbgEVaa8EWKH3dxe2+xB+okhMgHsvRrHZXjK/VtUYoa7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIpkd5IIKg1ixiCTgqY6C0MBrqnJfOwDDlB7m1AdhWk=;
 b=hDOH35VITYiqx5b2aGWuHA5z/H0ltDf85cHML3WYtaLHwtFR9mkIJg27yAmmEn6UWE4BQeXxvUChy3r2hUeUXUQe42k+gIEmqUuCe0w3drtbDYjGyUVviOprubLnK8I37wSp3MvJN+NB2JF1OPfUN3lesbntavk0+zL3140YO/8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MN2PR11MB4287.namprd11.prod.outlook.com (2603:10b6:208:189::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 09:00:52 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99%10]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:00:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linmq006@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Mihai.Sain@microchip.com>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: soc: atmel: Fix refcount leak in
 atmel_soc_device_init
Thread-Topic: [PATCH] drivers: soc: atmel: Fix refcount leak in
 atmel_soc_device_init
Thread-Index: AQHYeYPrugHoQ5HOEU+fRh0sGrrd8g==
Date:   Mon, 6 Jun 2022 09:00:52 +0000
Message-ID: <48c19453-984b-c3ae-b62b-2f0455330084@microchip.com>
References: <20220605084035.27127-1-linmq006@gmail.com>
In-Reply-To: <20220605084035.27127-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d6057ba-9d8c-4180-7e09-08da479b0ef9
x-ms-traffictypediagnostic: MN2PR11MB4287:EE_
x-microsoft-antispam-prvs: <MN2PR11MB42876B47F5BB9EABBD4911F587A29@MN2PR11MB4287.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOyE2nMDg7hpxOliOAwa1L7iqdCu65mjB81mYxwVxLFd8yCu6CZ5bbNPC+HR1Jheq/oRxyuCmA55D8OoEETdgC9XicojLbM5utFL/wio5xIi/prMcF7cWzBMEEQJ/BLIAIs5np9waY0lH1I5rJF2ENbRsimE4z2G/3K2R8Ahllgfs/Im0sSNZ5ofzc+gM4Y+l5PhfF5RSMi9yU7/YPzL1SNEIkABosPyYmwXXrGqYtW1DqC8eHlepGa4JgbN0OACazM1pYuzZteBOZXpL0i26ktGe75dSQG1NYsLuhvpDe3pU1NsVrxXUiLbM8OSBoHnYUrp4YpSMzGplDZld1Xow6uI/rve9tkwF+gnoBNHqacudM10TgV8QSUlpu57XSR0xH9pqS8lnqG7wyJORF2Fav9g/9AsFCGh98v/XY0PKgtKcAGkUJCYY2LYv4LWrdN77QTrUnDuWKVBMT9SRwgEnGKGwumrv4efEBEi0scgUkNcPiTenF/bF1/HFi7o//Vz7+0pnG04Na/JBQG5lGH+a8e9lbY9Wl9yIIPWGoVQU0m++Ea/SQP0xOzoWcFQ9daIDUV1MmJXB1bPiAEQCNnTdxCnj/k16hyjFNkHSTv5GyipjYDhqy4yTjwNnBzEA4c8KL9uUoIDEBBF9n92cXU2LXQGPJROP/DfKiKsjdQgLUZfYYxG0/5wwlXbGVoqBpQL5dwamlFyBGW4dxkdtccmbCendxQLKkPg53dAgyFqph6yjYPj0d3NnWlde4aWk6/GiIxm5RIrdD7lfhdKSnGudA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(83380400001)(186003)(2616005)(6486002)(66946007)(6512007)(26005)(53546011)(6506007)(38070700005)(66556008)(66476007)(110136005)(8936002)(122000001)(38100700002)(86362001)(31696002)(316002)(71200400001)(508600001)(8676002)(91956017)(66446008)(64756008)(5660300002)(76116006)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDRmL2RMY0RsNVFFWEZSN0xwZkN3M2JMZHB3ZXVVTXhFaG1WU1pYZm1kRHNa?=
 =?utf-8?B?bDBuN056TUlkVHo4ai9DRGRkcXJ2b1I5SmZ6T01ZWnB0ZDEwQzFZNnMrTWlG?=
 =?utf-8?B?ekNOUnVyczRHdVVHVlNzUnBmV1ZQVHA2aFl4ZDFxWnpuZnU5cXVvanI5ZE9F?=
 =?utf-8?B?Sm94RGdoM1VlVkExQlNaSFJ4N1hRSUFxUThYZ2huc3o0SkJKQk9hd0RqbjJZ?=
 =?utf-8?B?aGQ1bFdXSEFKWnh5UjVpWUorUktvc1VqazVGc09mREoxMWlRUzVjR1NwbXZY?=
 =?utf-8?B?bHdJbGxzNVd5bUhnaGtWcFJuTll2K2o1TjNpVnF4RUt2YWEyM3VOajdwcnJ5?=
 =?utf-8?B?VFZSNWdFZ2lzSjdMRkVNei9NdGkxalNhTGo4T09yRkQzdzJiTW5hQVBock1W?=
 =?utf-8?B?WDhUa3U0OEFia3Y4TE8zbHBaSitLT0NkYjcrQ3ZiMzNMUldkVHNGbGN4NXZX?=
 =?utf-8?B?STJtZE9rZHU0cHlYczA3VjdpY25MTWF0RVNlaTQ4VXJ1UXRoZWJGZVV1dHpD?=
 =?utf-8?B?bjU4a2RYeUNhZW1YWDR5TGNkZnRCRXQzbGo5NnJNazZpbUhsa1NURC9BbjZV?=
 =?utf-8?B?V0hLZzdHcnYwUUZvZmxtTkhMa2JENE0rQ0tIWTAvcmZwc2lSenJwMzJQbWZO?=
 =?utf-8?B?cnJrcElvT0ZYZU9VVVgwYW1TUEl4T2J4cGFOb2pKbVFpelpRdDlpQUtUOEhR?=
 =?utf-8?B?WW14ZGlhYkNua1g0SWREZDlUS05jV2VCV25NQzJwZmVSWWpUTkRjK3REYjhB?=
 =?utf-8?B?NHVaL1ZqUG4yVTVWZDAzVCt6ekVxcGxIbm9IOXpUeHhPTmhvbzJvZFJvTDYv?=
 =?utf-8?B?dVA2d0RvbmpIL3pVejh1Z092SWMzbzJVN2pwWUNIcFFPM0Y2a2N4cTZTbit4?=
 =?utf-8?B?MGNKMEVPV1ExRmI4c3dOSy9aSjJMWUIyQ1d5UjJha0hscER5YW1ZOWJEbjNu?=
 =?utf-8?B?K3hpS2tCUkxZSnZ4VHBNTVBLU3VjUWN3YTA2cHNxc3NUUENUcC9XempXekE1?=
 =?utf-8?B?MmlJalBkTm16YlBxUVFmWWdpVVN3UEJ1YlgrdldjNU1sR0dXVFRwTnlwY2pB?=
 =?utf-8?B?Unlta0pPQUt6NDVuWmRvYk1WVFRSdlNnQVVRc0F6RzlwdDFmTERhNXhmdDJU?=
 =?utf-8?B?eU1TVVo3RjVwSjlsaHhMdHlwN0hKSWU1ZW5nTy84cWZzbjNqZnlVRTd6WDRj?=
 =?utf-8?B?aFJqNXpybjhEck9IUFRiYXUrMDNSamhQekJrRXV0czNKWjY2V2VFT0h5d1ZH?=
 =?utf-8?B?VG9nLzZSalJRWTFpKzg2M0xhSmVCSUNsS0RFUkl2S2N1NHZUY0hwakhOYXlt?=
 =?utf-8?B?OWNFOWhTalU3clNXTlFJN050TDMwQ1pYREIzbThVRU9KdER2OVhuanB5a3Y0?=
 =?utf-8?B?QU14RHdLUnlYZnc4Y3pFbnYzY1Nnc3BlSU5FRTBET1IzN1dKQWljeC9DQWxx?=
 =?utf-8?B?WXd0SU5sbG5Cc3FMdStEN0VXU3phOEpoZVkwSTQwK0oyd0NralJNQklmN0xS?=
 =?utf-8?B?dXdSRy9oakpPcUlYZE13T0hFdnU2UTZQTVc0WWNuSHFsTGtmT3NjM3ZiQnl2?=
 =?utf-8?B?QzlSekljbFM0RERsM3pLSFYvMVg3dFQ4M0RsV0tzRU5rMVZPdWFDdi81akI2?=
 =?utf-8?B?RVk4ZUhNM1ErakYybXZDbCtqNm9iczNjLy9rUmJJTVdnaEJhc0kveGZkV24x?=
 =?utf-8?B?LzlCMytTT2dlQ1hOZnRmdk1xOWlMOGRZL3pOOTR5Yko5WkFkN0xmZHVrYzY1?=
 =?utf-8?B?V2h2a29yMktOL3crL3ZVczI4Q2p0ZFhCdVN3UmtvYjJXOVBPUE9PNjlNb2hn?=
 =?utf-8?B?WkRJZzRhWVpVQ0VwNGdCUXkydUJIeHhnaFRERjFWOFdEQTdWQ0NORll1NXYw?=
 =?utf-8?B?blc4Z0Q1YnNjbEFRTi95a0ZHT2x1bHJpK29BaVVtbHJxZW9qck5jc0h0T0pN?=
 =?utf-8?B?SEp5VVJqOFhjMFMrUHFpMDZaR1dLZWhsUjd1UUtjS3hKbGpRQ296TkwxY0Nz?=
 =?utf-8?B?cS82S0x1ZG9Ic2JBMEFhMHNmSURUSWNCc3YrUndMWTgyMVNmbVpmTm1jQU9U?=
 =?utf-8?B?VTJXbklCdkJCVGhMOU5EMjdLeEFkb3ZBUHVvcUowckFRUG90R2RXR2hVaW1X?=
 =?utf-8?B?R2pkYURpalkzbGI1ZzFpRS9QbUppVmtaS2dwb1lnL1czcFRBSG03N3BJcGlz?=
 =?utf-8?B?TWs5bGdoeTdRMk5NTU9pQmhPc2xXcnNSWkVOZHk0SVpJZW0zSWc2SjgvOXlt?=
 =?utf-8?B?OVcyN3NnOC9sN1k5c0t5UUVma3R1bkM0NitCRXhBbWkrazNCcER4blNWbmNJ?=
 =?utf-8?B?emJNbi9sZXFJYW1aaHpWb2dnQ2JUbTdBeklJblFiT3pwZ21SMEpGditxK1Ju?=
 =?utf-8?Q?2FapY0lqr7JIiBck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <532EB6CE8F719F4D9EC136FF2A13EFA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6057ba-9d8c-4180-7e09-08da479b0ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 09:00:52.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8KCPtC+vzvMrBCJXK6302lDDddZ9+xS7ktwiLLr1YZ074HUPDd9B7xi6ic/dE2hodLNdXAGAgmTEyXNpuO/ZDpUgMCV8nrSc/2wAEhwSDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4287
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDYuMjAyMiAxMTo0MCwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCkgcmV0dXJu
cyBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNvdW50IGluY3JlbWVudGVkLA0KPiB3ZSBzaG91bGQg
dXNlIG9mX25vZGVfcHV0KCkgb24gaXQgd2hlbiBub3QgbmVlZCBhbnltb3JlLg0KPiBBZGQgbWlz
c2luZyBvZl9ub2RlX3B1dCgpIHRvIGF2b2lkIHJlZmNvdW50IGxlYWsuDQo+IA0KPiBGaXhlczog
OTYwZGRmNzBjYzExICgiZHJpdmVyczogc29jOiBhdG1lbDogQXZvaWQgY2FsbGluZyBhdDkxX3Nv
Y19pbml0IG9uIG5vbiBBVDkxIFNvQ3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvcWlhbiBMaW4g
PGxpbm1xMDA2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NvYy9hdG1lbC9zb2MuYyB8
IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuYyBiL2RyaXZlcnMv
c29jL2F0bWVsL3NvYy5jDQo+IGluZGV4IGIyZDM2NWFlMDI4Mi4uNDZkZmEyNGM1MmZiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9hdG1lbC9zb2MuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9h
dG1lbC9zb2MuYw0KPiBAQCAtMzY5LDEwICszNjksMTMgQEAgc3RhdGljIGludCBfX2luaXQgYXRt
ZWxfc29jX2RldmljZV9pbml0KHZvaWQpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGRldmljZV9u
b2RlICpucCA9IG9mX2ZpbmRfbm9kZV9ieV9wYXRoKCIvIik7DQo+IA0KDQpXaGF0IGFib3V0IGhh
dmluZyBpdCBsaWtlIHRoaXM6DQoJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQoN
CglvZl9pZCA9IG9mX21hdGNoX25vZGUoYXQ5MV9zb2NfYWxsb3dlZF9saXN0LCBucCk7DQoJb2Zf
bm9kZV9wdXQobnApOw0KCWlmICghb2ZfaWQpDQoJCXJldHVybiAwOw0KDQpBbmQgZXZlcnl0aGlu
ZyBlbHNlIHRoZSBzYW1lPw0KDQo+IC0gICAgICAgaWYgKCFvZl9tYXRjaF9ub2RlKGF0OTFfc29j
X2FsbG93ZWRfbGlzdCwgbnApKQ0KPiArICAgICAgIGlmICghb2ZfbWF0Y2hfbm9kZShhdDkxX3Nv
Y19hbGxvd2VkX2xpc3QsIG5wKSkgew0KPiArICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnAp
Ow0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAg
ICBhdDkxX3NvY19pbml0KHNvY3MpOw0KPiArICAgICAgIG9mX25vZGVfcHV0KG5wKTsNCj4gDQo+
ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
