Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F2A592755
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiHOBDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:03:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64721DFC2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660525396; x=1692061396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vaBvhh+z6gw6XPR6wKJFSfjnJrV84fKu5mn0BPFulLg=;
  b=lt20i5T5PKlmCZ4Md2mLVxckMi5zPLpwmWL9MoVXjr7f9IFUi6m7VX2U
   kLWrqv65DiREx2GJaCoYCwTu8ShXfFXWzr8N1FIQlGdpT6Cy2P900yF8p
   munT6h+pReJSJveAa8j9fGogWwwkGIeZDHN9sws988qQtZo8Bc4k2Ht05
   Y7JHoFCK9dMdq/mi0Dud51dFtzcBuMJyoXfKCYFZqmu5VDpFRYeYUIUDg
   7xtcBOOOivGFfkQtFPPiSd0QhD6leiqtO2+NeYlMeGeycU0l65UCyjYQw
   r6KlG7wjvJFEP3JfnC2oHy2+HA7ku6KrBq1XKXcTpCkAcg9rdxvxZrBHI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="353607974"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="353607974"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 18:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674678278"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 18:03:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:03:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 18:03:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 18:03:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 18:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYZbabZyD1iJnu1ux5sPA3fAPMmNSwVbqDl3KROa/AP2rzDjg5xTgZUn25UsGjZSB4p6MCogSY2zHpAdUFOFTuOdezj90nGkW6qFbWQP4R0t6axFObTVfxdbB32tHE7MaDnkUq2rZwhcti7D0YuufWxJV4iv6k6Ox4jtEZYjGmVp8w/ZyShdi3W5rV6PB5LKeG1qHhBY/vfk5uI+tLTsGi8XLtsdr8abmLrt/X2OMAzrD7OMjiIjXaKIGfFq//5HpI/TnsEEsJ+VvzNo+XLm+UMSiziz4AqaFB/2Re9PmQxOgOT0Qk9I0HXhjSPXyuw10U0eaIjkPWSBzUovEGR0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaBvhh+z6gw6XPR6wKJFSfjnJrV84fKu5mn0BPFulLg=;
 b=QG+xAw7Q5k+V4vn9ZjnYgihQwFoU4Moy/P9JlR0vRD4eLtICJiTpwkMMktBXfHreOOXgZQnWs7BDOUNAWWmxbgXAUYDYy3riQPYXrLgFpEtvX8LiwXSf0bZ+WzQku80N2UCckAinGVHv+WUS29zlBldQOwxbT6Q5bZF24/dYfnvSJRsa1AkMOyktnYizbCFG9U6iHG9ujg6r8Jrdo+3wWM5o3Nj7BSYX2vJEK0DOUSt2tguRFj8bo7B8IDUUcgundyltXQViFQeXo0zPj1bKxNjjkbRUH2tjwDfCg4KpZiiQLVVm1nyzNNS6e69mV4kyVwAZUKQsZPH6uDJ4FSE36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:03:13 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:03:13 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v2 3/3] mm: handling Non-LRU pages returned by follow_page
Thread-Topic: [PATCH v2 3/3] mm: handling Non-LRU pages returned by
 follow_page
Thread-Index: AQHYr+bsUXqK17YUW0SN0h8WjtP9Qa2ul5AAgACOC9A=
Date:   Mon, 15 Aug 2022 01:03:13 +0000
Message-ID: <BYAPR11MB34950F770632BCE03BCAD752F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220814140534.363348-1-haiyue.wang@intel.com>
 <20220814140534.363348-4-haiyue.wang@intel.com>
 <aff9df5d-81be-ee98-5b12-c70cbede8a31@redhat.com>
In-Reply-To: <aff9df5d-81be-ee98-5b12-c70cbede8a31@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45605b18-509b-4b8c-7a52-08da7e59edb6
x-ms-traffictypediagnostic: MN2PR11MB4533:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+LAdITPjl3YT3i60rdEtdDqZ04PMKJWAHtbIsUWGvhVTpV3X+0V8/QVluf2jcTMkpSaD1mdWTaWag9xmBCEb4eLVrL8z7UzuadOimDsq2UPI0VCY6yQab8tQnpMeDQL/fXM7g1Ez3Zbbd4tPZNhAMNClgo8namCULJWWBUUQl35KQX33DVfeddETHNMF4EQ6SioalLUQQ6VuUrJjcoeDhHRIaeMGy8ysvanOUhy7mGDskpk2JZp+GvWXHhIdN5w2y0j/ZT0EIRUOuXb/X5Qed+Oiujt07jR/HSWpiU/zOmXhf1NomfGiaMIvVAXE065M3qWIzKpnU5X5kTyAdGYbOZ3CuA1uNjICKssPZFstWuxNb+RNAUeT54dpOFkytRfDuOmPPab5e0xlY5OVxifwgkp5o5b2E895O9N/nWmdvZxTArY7FIpaCGmx5i+aj25t5udUP6RtQ3l+lCUrgxHi9Un0lpldKDzO/fkWDwf80kAJSM/bw4g24kOWL6UVwpvbOn2h5D45wXJe3hROmKMfY97OYnaVcyWmXonVi531T97a6YV+gxWWA3WgtQG/XnKuqxlDJL2lTEP4EOPtvqRP8l9Zn5LgVa131V/IZGhSTxWGcOTxVPFJwpLMFdGcoQHF0tZgh5ITnxm2wyhGnQCOx4hCRJdhb1vp1hhxIKDodOpJTWNWIfHXVNldqErBXZQJK7XL29Mj/cZGo+AgMGWk8g1t8F0Bx+geMxIzwZpDvnK0ghMy8Nl4xfFIjwSl8VzbFHCuD7DhZIxpZpk7DjyKdeAjPTvqTRfDWcYO1Djsu4AfYqbJH6r2n6N+4rcOU32
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(366004)(376002)(8676002)(122000001)(71200400001)(38070700005)(41300700001)(316002)(33656002)(82960400001)(9686003)(2906002)(66446008)(7696005)(26005)(53546011)(66476007)(66946007)(66556008)(76116006)(4326008)(38100700002)(186003)(5660300002)(64756008)(478600001)(8936002)(83380400001)(110136005)(54906003)(86362001)(55016003)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NncxSUpyM2FTQzF3d2tuRlZXb2tHakFRMHNkeE1DYzUvMGxsQnZBbGVzNmpv?=
 =?utf-8?B?bW9saTlBOE5sU3NGTUxSVitDN0NTS3lBY0xDekFmLzR0ZGQxYUtHQmlsQVR0?=
 =?utf-8?B?YzAraDZZR0V3eTNYSmZVL3MvTlZKWWhrV0ZjSFhYbTA2YVV4cWNQbHk0U3li?=
 =?utf-8?B?MEowZm9RR2Y4TSt3TjEwdE15YzVqS1FhZTJZQlAraERRVU1NVXFuZHNpaXZV?=
 =?utf-8?B?ZTJ0M0VNeFVEQU5PaGVCZHZ1Sk1aOG9RRnZVODVDMWxVY29GVGRraEh0MVM4?=
 =?utf-8?B?QTNhR2U0SkdtQzh2VFZ6V2I4MVdFMDcxMDBXanB0Ym5ieHFkQ0FXWFBMa044?=
 =?utf-8?B?TThTaTFxcU54NUxFQXZoTXdYd2NLK1RrY0oyZ0JFZjdLcGRpZVMzVFgyOVA0?=
 =?utf-8?B?U2RMN1FqTi9QMFpJRkYyNUNZeTFWWjNzdnBLMHR3T0ZUNXB3VTJSU2NVaUdC?=
 =?utf-8?B?NC94bm90bTVWaXFKV2ZTS1JMcTQ4SDF0S1V0b0Z1Zm13N3U1RWRVUTVjeS9Q?=
 =?utf-8?B?OGNmSUtrVk5RRE9iUnYyM3NvRUEzTVNuTmY0Um83SjhKMms2ek5GWmNsQkIz?=
 =?utf-8?B?RTFJc3p3d3pFTTBEalFZV0pjZitsbWNaODVleFkyNGl4ME9PMGN2VFpid2NT?=
 =?utf-8?B?ek82NHhKOUpqWWZuZk9Uc0dkVytiRWRWT2V1U0hUT2hSZEl6VzRUOEkwSkZw?=
 =?utf-8?B?TWRlcVFKeGVOUEtpeEQ2cXUrRUplc3BzRk1pQklmT1dHaEtYL0dveXRTZ0Nz?=
 =?utf-8?B?UGdaMXB5T3FpUWhTYzdnSXlOV1pIMks4dU9oSW0xd25VTkxPQzdkKzRWcmJC?=
 =?utf-8?B?SlF5UEVZNVBsd1ZxT0MyOTlyYWVjS3dqamRGOEJnRWVGQWd4blZoTEVFZzZL?=
 =?utf-8?B?TFlPSENmZVBYdjFMN0xZd1UvZXhLZ0xLSmQ4K2FRNXptZHk1TGpmYjluTHFM?=
 =?utf-8?B?dlVRaXBHQVVNRVhuaTNGeXdWRzV4dTVVakEvUVdLa2NYUHV4cjRDejZWL2pE?=
 =?utf-8?B?b0I3QkpsUGNhc2NmZnN4QU5tWE5OK2lsZEdOZjdwdnQ4aUNMK2NCZFpYSC9m?=
 =?utf-8?B?dzBLZExxRldmUVl2V2l6Zk5QNkp5RWwrdTRSbTJ1R1V0cVZmeXZ4VytQU296?=
 =?utf-8?B?Rm5UTjlsbGxNanBWUExLT2tGeE5xTXErcDkyNmd1YTFPKzlDdGFpTkppWDRT?=
 =?utf-8?B?cUk1TjR4Y044UXdDU3hHSEFJM0p0ZWMwVGhSeEVIUTMyQzRNSEQwUTRSdHp5?=
 =?utf-8?B?Sm9KVzFvT3Vjakl0dkM1djMxbE1KZThBeUM1eVZDMmtldTUrekRhOG9PN01a?=
 =?utf-8?B?aFRvNlhXbWJONWJRd09TU2QvQU1oY3BQRjZrRUhzV0IvOVdNUHI2dWJkdFFN?=
 =?utf-8?B?K01uV3NKYU9MdFJIdWo4UFp3U20wU0hSRmdlQlhab1hCeXBQa1NPMlJjcGN4?=
 =?utf-8?B?emkyTmZ2akFMWGhBSHVJRS84QnBYRHpQS3d5eEwwV0p0aDBmNzRRaDFjQmNa?=
 =?utf-8?B?dzZIVzl5RGZ6M09kMlZrdEU4czFpUGI3VEQ2Ujk0VXlFbStSNXdRYXJCcVNn?=
 =?utf-8?B?TVlpTlZ3T0FYaWZDd0pPT1RsU3hTT2R2UHRlSGowOUVrYml5TnBEdEROT2RL?=
 =?utf-8?B?TEx6dXBVczJDZ1RYdWZkUEpUT05jbGxqVFRCR0wwdFhveWp2cFZmTFN0UUN4?=
 =?utf-8?B?UlpGc3pkVEhBZmJ6N1dTS2F2RHhuV1R5UXUxOWJVUWxUMkRtcGpNNXJCazJN?=
 =?utf-8?B?U0NnUnVTOWF6ZHBaR3JBYk5mYzRjUnk3ZUpYNTRXbFI3SUJxWjRJL0t4bmpk?=
 =?utf-8?B?b2tsT0Q0QW9OeHlyc3dGT0Erb3hNR0hYUk5sMTJwTzFKZlNrY0srVXpva3Zw?=
 =?utf-8?B?VTJUMndVNFZFMUFINmtPbnJ5c0VPSUdjZVV0b1FQK2t4MUdzaXJLendtcUkx?=
 =?utf-8?B?WXI0L0xlWVdrR0pJVVhPTXJaL1crTG45RVVvVlJOTmVBdEtGM3dmWTRwM1dF?=
 =?utf-8?B?RTkwaXdCeUhyaTY3c2h5N1c4bkovL2dBVk5EZGh0M1VGZ3NuWFBpdm1GUUIw?=
 =?utf-8?B?Q1J0UEdaOU14c1JHQ0Q0M21rMkFDTExpQ1pmQUU4TkdzeWo4QTE0UFRoODB5?=
 =?utf-8?Q?H7aTfhWDGkRZzSeIpD+vqh++D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45605b18-509b-4b8c-7a52-08da7e59edb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 01:03:13.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkDQPOGiQFzDvOXIhijQsbYQLozNKBXa0Qv5NxSFoxLUws5ZN0UACssMByLWNK+OCwXovQilTQbbh97iVB2gxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8
ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTUsIDIwMjIgMDA6MzQN
Cj4gVG86IFdhbmcsIEhhaXl1ZSA8aGFpeXVlLndhbmdAaW50ZWwuY29tPjsgbGludXgtbW1Aa3Zh
Y2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBha3BtQGxpbnV4LWZv
dW5kYXRpb24ub3JnOyBsaW5taWFvaGVAaHVhd2VpLmNvbTsgSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsNCj4gc29uZ211Y2h1bkBieXRlZGFuY2UuY29tOyBuYW95YS5ob3JpZ3Vj
aGlAbGludXguZGV2OyBhbGV4LnNpZXJyYUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMy8zXSBtbTogaGFuZGxpbmcgTm9uLUxSVSBwYWdlcyByZXR1cm5lZCBieSBmb2xsb3dfcGFn
ZQ0KPiANCj4gT24gMTQuMDguMjIgMTY6MDUsIEhhaXl1ZSBXYW5nIHdyb3RlOg0KPiA+IEFkZCB0
aGUgbWlzc2VkIHB1dF9wYWdlIGhhbmRsaW5nIGZvciBoYW5kbGluZyBOb24tTFJVIHBhZ2VzIHJl
dHVybmVkIGJ5DQo+ID4gZm9sbG93X3BhZ2Ugd2l0aCBGT0xMX0dFVCBmbGFnIHNldC4NCj4gPg0K
PiA+IFRoaXMgaXMgdGhlIHNlY29uZCBwYXRjaCBmb3IgZml4aW5nIHRoZSBjb21taXQNCj4gPiAz
MjE4Zjg3MTJkNmIgKCJtbTogaGFuZGxpbmcgTm9uLUxSVSBwYWdlcyByZXR1cm5lZCBieSB2bV9u
b3JtYWxfcGFnZXMiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpeXVlIFdhbmcgPGhhaXl1
ZS53YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbW0vaHVnZV9tZW1vcnkuYyB8ICAyICst
DQo+ID4gIG1tL2tzbS5jICAgICAgICAgfCAxMCArKysrKysrKysrDQo+ID4gIG1tL21pZ3JhdGUu
YyAgICAgfCAgNiArKysrKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL2tzbS5jIGIvbW0va3Nt
LmMNCj4gPiBpbmRleCBmZTNlMGEzOWY3M2EuLjEzNjBiYjUyYWRhNiAxMDA2NDQNCj4gPiAtLS0g
YS9tbS9rc20uYw0KPiA+ICsrKyBiL21tL2tzbS5jDQo+ID4gQEAgLTQ3Nyw2ICs0NzcsMTAgQEAg
c3RhdGljIGludCBicmVha19rc20oc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVk
IGxvbmcgYWRkcikNCj4gPiAgCQkJCUZPTExfR0VUIHwgRk9MTF9NSUdSQVRJT04gfCBGT0xMX1JF
TU9URSk7DQo+ID4gIAkJaWYgKElTX0VSUl9PUl9OVUxMKHBhZ2UpKQ0KPiA+ICAJCQlicmVhazsN
Cj4gPiArCQlpZiAoaXNfem9uZV9kZXZpY2VfcGFnZShwYWdlKSkgew0KPiA+ICsJCQlwdXRfcGFn
ZShwYWdlKTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiANCj4gSSB0aGluayB3ZSBjYW4g
ZHJvcCB0aGlzIGNoZWNrIGNvbXBsZXRlbHkuIFdoaWxlIHdvcmtpbmcgb24gcGF0Y2hlcyB0aGF0
DQo+IHRvdWNoIHRoaXMgY29kZSBJIHJlYWxpemVkIHRoYXQgdGhpcyBjaGVjayBpcyBjb21wbGV0
ZWx5IHVzZWxlc3MuIGRldmljZQ0KPiBwYWdlcyBhcmUgbmV2ZXIgUGFnZUtzbSBwYWdlcyBhbmQg
dGhlcmUgaXMgbm8gbmVlZCB0byBzcGVjaWFsLWNhc2UgaGVyZS4NCj4gDQo+IElmIGEgem9uZSBk
ZXZpY2UgcGFnZSBjb3VsZCBiZSBQYWdlS3NtLCB0aGVuIHdlIHdvdWxkbid0IGhhbmRsZSBpdCBo
ZXJlDQo+IGNvcnJlY3RseSBhbmQgbm90IGJyZWFrIGtzbS4NCj4gDQo+IFNvIGp1c3QgZHJvcCBp
dC4NCj4gDQoNCkZpeGVkIGluIHYzLg0KDQo+IA0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiANCj4g
RGF2aWQgLyBkaGlsZGVuYg0KDQo=
