Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D155A73F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiHaCgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiHaCf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:35:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B79C511;
        Tue, 30 Aug 2022 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661913357; x=1693449357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3wanf09tVKxeV5DAaMAAIZQ/+wVHUh3GTHruoz+PY2w=;
  b=YvHSlDnVlp5tOvetJmiSTzD+QVblL0DSf7fL4nvqbBlHtTlbN1wvKqeS
   AWUOcYcswfDXxm4erhLaMWL8GPnOgK6fbgGnx7S2L2ktV5jVmGJVWeLNi
   B9ezBQ21qJgaV/uJG8YFdX1yDGjiJO5IlQRznkhkWpyMrsxk9Wch7NaQ4
   SwpKmzEIKNFx5TqsVt3d8pCO+4uKise4BRy8VEZLv/LiJH9RSNWNb/bUo
   Wp7vSi5R6L8F1i1xLMjyAM4b41/hpSgAT0Dvj+pKhuCbzdQoc49UqGCCw
   3HuKy/5ujQEwMBFhkYSyU2Sn72UfUpHd9m4ygoqObGGtOUD6J4LulUvCK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275104300"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275104300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 19:35:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641666577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 19:35:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 19:35:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 19:35:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 19:35:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 19:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyU5yV9iTIvJzMO5XvRIptJOgsAW1gG8akSjTQCUm/6BP4PtXXKRUP3lYaIa71C0m0aecViHHDzomoQO9g6OydlUvkjNc1wg5z4tY4IhLvTfoCApbVv7GLM/z24h/OVa/MKJGq33p0GukTfuDFDTxmclqmE4TpA2VkOZU9JD6IMRddmdb/0w5qGUyVtsJcKms7KIkv9qmqSjhBf0L8AW8pjHj2GnsyDgwiSaQ38BST6RnOy0rv1SqdcSWXyOpRWbO2L2Zik5rm8F6948lxp+e56lNeslABd/WO9azdYu5ft4wEKMm2gAJwhlQn5UtIY5HVvGvOEAQXRB4NFL+WEZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wanf09tVKxeV5DAaMAAIZQ/+wVHUh3GTHruoz+PY2w=;
 b=QAsVfjxJuBb8O/QuqZWYebjASfg1+RsE27o2wFGjQShQc7yR8eZ9sjxKbze6uGqGfa/BfLigOJpjJqfJSUwxzwJ+uRhJNDtByQugcPvY+ITa3Ux5i5vF6hfrjjOKF/+euJs0yejj5BKFt8Ik/y3OxmVlIGy6eYKZ5txtgUe3wwp0XegMBjNOTA2W8dhzU4BqvMh5ZgDoaVXZ7KxArSx3Be2fHzuWzIAysk8swMlKSPDQ48p5+gzP/N0vW5JZyT9L6ZNie4TNy4b80ALWTXK/heeqFzCEbI4NS2WftVL40uaJkpXIiuUZwenhGZ7/V+rOB6wtIu7Y021W8slCBFgt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN6PR11MB1572.namprd11.prod.outlook.com (2603:10b6:405:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 02:35:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 02:35:53 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4A
Date:   Wed, 31 Aug 2022 02:35:53 +0000
Message-ID: <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
References: <20220830031206.13449-1-jarkko@kernel.org>
         <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
         <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
         <Yw7EX5GCrEaLzpHV@kernel.org>
In-Reply-To: <Yw7EX5GCrEaLzpHV@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f766ccc-f739-4e59-16b3-08da8af986aa
x-ms-traffictypediagnostic: BN6PR11MB1572:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+28ks2h+IkmqyYNvwsPhWTWxvO1z2wRouXgck4QoD8mRWuEGCx5A7H5xvmHAKuUIwDtp/sRj5R5g63B72NqMtdCDWcUpyDZ45vzNTxJlD+iZoUprpUExI6MrtZcbkOAqOuIraMJzlR1ead5XakWwgmmR7GbY18zRFJqMvbB2UXwEXOMaBqtOb1+valDC8lpNL/5FHjjXT3l+w8m8OXwPOVFDZuf51OFaNndWLcGCq7/EZwV21y0L5nvaVZw7HetN7ttsPL1XnAYqTabNtZB8q7tS6NmWPht3hWrFRENG+HKGefRSxTNUuCz1ZMaTo1QG+0HQBZlv24G5Sbj2Etg7IincMwjd9T5IbPSnAvszKus/l+LdWkEUm0GUpopxAwlPvdgUlzUy8tTAayFOZgkQS6C2KRBOs04K07hbt99zNOr5IVH7xZ3Z9+EL9HWUODB+wK9c/xB1Eu4BuCLLoLCmkRQVTDk7p7ITktVNxGEiwxtqkJHx5zRgrLfm6fzJJGjb2om7Vexs7lFfY0K8e1a05581HH0+zy2p5BAiyhKJdIxliVHmrlIqkSnwNcZ45LOIu4wXx3dtdEV908M5ToilrEEawhO0Z16sjo09ktZ9TsfF5WxkAX78moIxCX8uVYYbTVHhDJdf8FiVUPC76MVXgSb6wzptfZM21kD0EC9tu/MSODyB0z2YS0Zal/TtUUXNcokf923VIVvz9lQwoJT5bAPUY7yokDiClqqB76CPXqnZeYxe1K+koJxvIL2aO/srdAxSemuo1OGMzxLrj4rdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(64756008)(6486002)(2906002)(7416002)(8936002)(71200400001)(2616005)(66556008)(6512007)(5660300002)(66446008)(53546011)(26005)(83380400001)(186003)(478600001)(41300700001)(66946007)(4326008)(66476007)(8676002)(76116006)(38100700002)(91956017)(6916009)(54906003)(316002)(6506007)(36756003)(122000001)(86362001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUYrVUxONmRiYXpGN2tDc2lUR1VXWmNJK0dwWVc5SUpCdXJNT24ycTVXcExU?=
 =?utf-8?B?bEsvRWxpL2lVUlBXbDFPa3JVdFpZV2lIQWZ6Ulo1em9TcEhnOG56dWNYbXBC?=
 =?utf-8?B?d1NFaHU5ZXdRTVNaQTRlR29xZklrSnZEb2Jqd3Y3czR5N2NaQ0xNYTZFenF0?=
 =?utf-8?B?RU1PTVZ1Q2gyTWlBNVJzd0hGZDBKZzJKSmRXYUVsRTJnbGNoRFFRNGNxb1Qw?=
 =?utf-8?B?WWVBSjhHaEZEaCtYSEpGTnR0bnV1aUpuSEhTb2lsQmZ0dnRGTTBlWlFNVVZx?=
 =?utf-8?B?VFg2UVRwUHoyRnFpUkR3cStHY21ybjhwOUZCcnJwZ0ZiV2JIcU84dUNaQ1Zz?=
 =?utf-8?B?cXpiMzlqcVFoRHd3Mmw4RTYwVmcwbHV1RE5NNnltNExnVUdxQmxQOERCeEU0?=
 =?utf-8?B?cm5IRTBVQ1hzcHk1UzlPSk0vbE9xWENSVU5SS041T2ZzMkdWdE9RTXJWUWtV?=
 =?utf-8?B?eEQrZlorQmxhMG9MNkxtQnlrWjUzb1B6aElnWXpPQm8zdjlxNFdJdUVBU0lm?=
 =?utf-8?B?aTRKM0Z3RE9idG5ZQlhSQXpKZVc2SmQxMzhCRFkrd0ZSbVZFUzVJQWYvTTI3?=
 =?utf-8?B?WWtDNU1KeXJYcUxGUmJOb2tQSWFuKzQwTzZmNVBFbHpmSHpYSXJlSmxNNERt?=
 =?utf-8?B?U0l0K2pDck9ZR0g4eUNuNkRRemdOTVB2akxmajkyZ2ZCRTN6akFRMFluZnc3?=
 =?utf-8?B?SmZRNE1KNndVSDZxMWJDT20xK0tidTNSNnYwMi9ZUWdaN012UEQ2U1ZhblBs?=
 =?utf-8?B?MElONVBHWlFlR1JQakVVNFlVakwxV3NGVitDQm5kN1JNWkNmUHFpWG5oMVBR?=
 =?utf-8?B?NXhYTkh4RThBWkI1TXpVUXlhVzdMOFFsWm1Fd201S3dIS1ZpTDBoa1ZNMjEz?=
 =?utf-8?B?QzNmWmJ3d0FleFBVY2pFZ3NvRmEwNmtiMEhrR1ROOFk1cE1QTlJMKzZoMTFu?=
 =?utf-8?B?cGJMY1B0VjN2MWxQT3NOeXJsKy9Xc2xlKytPYTF2UnhRd3ZrWDlsVE1XNXZy?=
 =?utf-8?B?Y2E2M3NIajdRTWJqM0Y5eG9ZeU16a01nTWdUejJMY1Rka3h4ODhxZTBWS29M?=
 =?utf-8?B?TW9ZT1A3OFRxZTJweW9xU2RXampSajVBcUJHSnlIVmQwZk9xcUZaaU9zMWVG?=
 =?utf-8?B?VVp1QVg3bytsUldJUWhIUnROa0x2Mm9HTXVpOFd2Yk1sbnZxVXZGOWwwRzJU?=
 =?utf-8?B?Q2loVHFiWTJVTW5iMktjM25QMnFxM3NjN3JKM2VvSFdydHNXMTdhWU81QmMx?=
 =?utf-8?B?N05pbVNVOENSdjhaeDZUQkRuWU1paDlDTzRFZ3RMaUIzUy9QQkRiVXhySEY0?=
 =?utf-8?B?cXhncXBGdTJBdzFDWkhUOFFWVmlCeFlsMU9scCs0RDh5dytjcGNIaXdwRnlE?=
 =?utf-8?B?MVpyY2NxaHhPMEVHS3MzdlR0WE5uS204RFl2T0Rzc1BQR0p4TEt2aUlzUWcz?=
 =?utf-8?B?RUxRVDNwbGRYcDVHdlEzNlIzalBoZXRJWENQSG1sSFB2ZndLQmtxaGVWR3Rv?=
 =?utf-8?B?UnFsYTFiQnRNUDNUYXpzS3MyMFI2TFBkMzdOZllFdFJ5Z1pEdHNxeVFHVkFW?=
 =?utf-8?B?bzlvaWRSbUltbXZkVDUzNnRwdDFZalZqYWdGRFNOQU5Cbmt6bjVLeUtwWDZ4?=
 =?utf-8?B?SGxENUgraUFROE15L2p6dkY2MnEzNzNBdGJCeEU0MGZQMCtKTUxtWVNlbzFV?=
 =?utf-8?B?Q1dpcXcrM3ZWUzBwK2pXbzgvQmtrYnpucUtUWjQ1SWQwSnN6Y0pPaVJGTkRr?=
 =?utf-8?B?NlBYNWsreVlYQmMzWTFTdkJ6cGViZzBEaDQ1SFhLLzlwY05rOWgvcjlHUG9T?=
 =?utf-8?B?SXc5U0JNRWI3TXR0U083ZERUVkwxRWZYVGFqL0kyaGl6OEs3RExod3FsQWli?=
 =?utf-8?B?bWN6cExEMnloNGF4YytaQjhzV1JMTGJaVEhDSDdDazhHSktRNU9BRXRxNVhw?=
 =?utf-8?B?MVhjK09DQUZhdG9uWjRuVkd2SVdrdWpPRkFvWW5oeHZOeFhCMHVBLzJIWVpM?=
 =?utf-8?B?MzRlaWdBOUxhRGlmV1VYQytmWlpRZG91UThvZWFRSi9xWGZaM0tVVXRqMlh4?=
 =?utf-8?B?OGhscldUVGdjZ25IOU1McWhNVzVoVkxlaGR5RndWTGUrSGJMdVQrUldpSG9F?=
 =?utf-8?B?dE0wdVYvODRCWDhTMzdGNHFzR2U3ZXYzd0M0VVI2aXlydENneW5HaWthYWhu?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E66DB658926A13458BFFF12ED50CB663@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f766ccc-f739-4e59-16b3-08da8af986aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 02:35:53.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfL+w2/gI5m6FUBIqCqc3heZaWfbeSXGSa8ycVlpAEtInRcpXjXUpRflApxkU/6Wgil4L7ef/h6UGDMwDkdlCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDA1OjE1ICswMzAwLCBqYXJra29Aa2VybmVsLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDE6Mjc6NThBTSArMDAwMCwgSHVhbmcsIEth
aSB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMDgtMzAgYXQgMTU6NTQgLTA3MDAsIFJlaW5ldHRl
IENoYXRyZSB3cm90ZToNCj4gPiA+IEhpIEphcmtrbywNCj4gPiA+IA0KPiA+ID4gT24gOC8yOS8y
MDIyIDg6MTIgUE0sIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gPiA+ID4gSW4gc2d4X2luaXQo
KSwgaWYgbWlzY19yZWdpc3RlcigpIGZvciB0aGUgcHJvdmlzaW9uIGRldmljZSBmYWlscywgYW5k
DQo+ID4gPiA+IG5laXRoZXIgc2d4X2Rydl9pbml0KCkgbm9yIHNneF92ZXBjX2luaXQoKSBzdWNj
ZWVkcywgdGhlbiBrc2d4ZCB3aWxsIGJlDQo+ID4gPiA+IHByZW1hdHVyZWx5IHN0b3BwZWQuDQo+
ID4gPiANCj4gPiA+IEkgZG8gbm90IHRoaW5rIG1pc2NfcmVnaXN0ZXIoKSBpcyByZXF1aXJlZCB0
byBmYWlsIGZvciB0aGUgc2NlbmFyaW8gdG8NCj4gPiA+IGJlIHRyaWdnZXJlZCAocmF0aGVyIHVz
ZSAib3IiIHRoYW4gImFuZCI/KS4gUGVyaGFwcyBqdXN0DQo+ID4gPiAiSW4gc2d4X2luaXQoKSwg
aWYgYSBmYWlsdXJlIGlzIGVuY291bnRlcmVkIGFmdGVyIGtzZ3hkIGlzIHN0YXJ0ZWQNCj4gPiA+
ICh2aWEgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSkgLi4uIi4NCj4gPiANCj4gPiBJTUhPICJh
IGZhaWx1cmUiIG1pZ2h0IGJlIHRvbyB2YWd1ZS4gIEZvciBpbnN0YW5jZSwgZmFpbHVyZSB0byBz
Z3hfZHJ2X2luaXQoKQ0KPiA+IHdvbid0IGltbWVkaWF0ZWx5IHJlc3VsdCBpbiBrc2d4ZCB0byBz
dG9wIHByZW1hdHVyYWxseS4gIEFzIGxvbmcgYXMgS1ZNIFNHWCBjYW4NCj4gPiBiZSBpbml0aWFs
aXplZCBzdWNjZXNzZnVsbHksIHNneF9pbml0KCkgc3RpbGwgcmV0dXJucyAwLg0KPiA+IA0KPiA+
IEJ0dyBJIHdhcyB0aGlua2luZyB3aGV0aGVyIHdlIHNob3VsZCBtb3ZlIHNneF9wYWdlX3JlY2xh
aW1lcl9pbml0KCkgdG8gdGhlIGVuZA0KPiA+IG9mIHNneF9pbml0KCksIGFmdGVyIHdlIG1ha2Ug
c3VyZSBhdCBsZWFzdCBvbmUgb2YgdGhlIGRyaXZlciBhbmQgdGhlIEtWTSBTR1ggaXMNCj4gPiBp
bml0aWFsaXplZCBzdWNjZXNzZnVsbHkuICBUaGVuIHRoZSBjb2RlIGNoYW5nZSBpbiB0aGlzIHBh
dGNoIHdvbid0IGJlIG5lY2Vzc2FyeQ0KPiA+IGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkuICBB
RkFJQ1QgdGhlcmUncyBubyBnb29kIHJlYXNvbiB0byBzdGFydCB0aGUga3NneGQgYXQNCj4gPiBl
YXJseSBzdGFnZSBiZWZvcmUgd2UgYXJlIHN1cmUgZWl0aGVyIHRoZSBkcml2ZXIgb3IgS1ZNIFNH
WCB3aWxsIHdvcmsuDQo+IA0KPiBJIHdvdWxkIGZvY3VzIGZpeGluZyB0aGUgZXhpc3RpbmcgZmxv
dyByYXRoZXIgdGhhbiByZWludmVudGluZyB0aGUgZmxvdy4NCj4gDQo+IEl0IGNhbiBiZSBtYWRl
IHRvIHdvcmssIGFuZCB0aGVyZWZvcmUgaXQgaXMgSU1ITyBjb3JyZWN0IGFjdGlvbiB0byB0YWtl
Lg0KDQpGcm9tIGFub3RoZXIgcGVyc3BlY3RpdmUsIHRoZSAqZXhpc3RpbmcgZmxvdyogaXMgdGhl
IHJlYXNvbiB3aGljaCBjYXVzZXMgdGhpcw0KYnVnLiAgQSByZWFsIGZpeCBpcyB0byBmaXggdGhl
IGZsb3cgaXRzZWxmLg0KDQo+IA0KPiA+IEJ0dyBjdXJyZW50bHkgRVBDIHBhZ2VzIGFzc2lnbmVk
IHRvIEtWTSBndWVzdCBjYW5ub3QgYmUgcmVjbGFpbWVkLCBzbw0KPiA+IHRoZW9yZXRpY2FsbHkg
a3NneGQgY2FuIGJlIG1vdmVkIHRvIHNneF9kcnZfaW5pdCgpLCBidXQgd2hvIGtub3dzIHNvbWVk
YXkgd2UNCj4gPiB3aWxsIGRlY2lkZSB0byBtYWtlIEtWTSBndWVzdCBFUEMgcGFnZXMgdG8gYmUg
YWJsZSB0byBiZSByZWNsYWltZWQuIDopDQo+IA0KPiBJJ20gb3BlbiB0byBjaGFuZ2VzIGJ1dCBp
dCBpcyBpbiBteSBvcGluaW9uIG91dCBvZiBjb250ZXh0IGZvciB0aGlzLg0KPiANCj4gDQoNClll
YWguICBJIHdhcyBleHByZXNzaW5nIHRoZSByZWFzb24gSSBzdWdnZXN0ZWQgdG8gbW92ZSBzZ3hf
cGFnZV9yZWNsYWltZXJfaW5pdCgpDQp0byB0aGUgZW5kIG9mIHNneF9pbml0KCksIGJ1dCBub3Qg
dG8gc2d4X2Rydl9pbml0KCkuDQoNCkJ1dCBtb3ZpbmcgdG8gc2d4X2Rydl9pbml0KCkgYWxzbyBt
YWtlcyBzZW5zZSB0byBtZSBnaXZlbiBLVk0gZ3Vlc3QgRVBDIHBhZ2VzDQphcmUgbm90IHJlY2xh
aW1hYmxlIG5vdy4gIEZvciBub3cgdGhlcmUncyBubyByZWFzb24gdG8gcnVuIGtzZ3hkKCkgaWYg
b25seQ0KdmlydHVhbCBFUEMgZHJpdmVyIGlzIGVuYWJsZWQuICBXZSBjYW4gbW92ZSBzZ3hfcGFn
ZV9yZWNsYWltZXJfaW5pdCgpIG91dCBvZg0Kc2d4X2Rydl9pbml0KCkgd2hlbiB3ZSBhZGQgS1ZN
IGd1ZXN0IEVQQyBwYWdlIHJlY2xhaW1pbmcgc3VwcG9ydCAoaWYgaXQgaGFwcGVucw0KaW4gdGhl
IGZ1dHVyZSkuDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
