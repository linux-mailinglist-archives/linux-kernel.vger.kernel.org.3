Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448BE54479A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiFIJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiFIJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:32:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F330C3739EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654767138; x=1686303138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jGMq/aUXvkSurlEbKj5dSxPoKeoRfkz0wxaeeLaXdvc=;
  b=GIK49zL00BckgU6RsUo4EXiSoGaK0S/na3+q69aHsWcBARtwzp9ncXdx
   2T5JPTgscoVizz7Nhcgut08uhVdfpzONzvl4UHHlPCsscNuslBLCG4KyS
   wV92tl2QH8qaJGP7bbDLjBxWyzs3+DhdvVoYt8h5U5UYiyfckJnQR56qn
   Fb0N9pk8aou4Oj35YkDd1uOQc+KbMJ6WC0tWB18bjmDSQoekoFqo+YIk7
   yEcxyQE+F38RiqQ0CBTQnoYV+3hWyvNRjaOd/f7bXH1FBinpCCq1Uwlkk
   FKtSIRP2bQvOH4KojzAP1Rj1plnPmDwZeG+8oza1pEVWu5j1q9CQiFz3D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="257649261"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257649261"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 02:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="555820233"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2022 02:32:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 02:32:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 02:32:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 02:32:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 02:32:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egCh4fmGsl+ekQCFxuqSOofbb8RKyL81zddc0Xovn+05p8/dS7shr4FwxDYWBJKpwO4Hn/y1ArDCKhuYgVN7NrpFKzxKUXNvMEVe63ZRDe0fzAv6e6SNWC4O1kMEYk+qZajsRD44maB01k5GYCj4lIdtrlmKCWjCaD1o2OVpm6OH44VVaQxiNimfkvlA90oLJoEVCGn3zM1vjL/04PcXGnu36iuMzY2zEykDA/Ge11k2hhjBUJgff/7Rz5yHvce5zSNRDJHrQvY4EyOjZNA5z03pYFIeNLwY7LbjCE+j9fE8Dn9ghZs0WkZD9AyqabsdscWglQVmXjFIbOersRt8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGMq/aUXvkSurlEbKj5dSxPoKeoRfkz0wxaeeLaXdvc=;
 b=CffkRosWcLASn5J1kpK1yfFVQblQ2o+J8UkI1791m4JJjHrCJemFUa7orvK/ERkEptLiLTKVvVyCICf98FUeInyWaE6MiVZpz6cm6eLwQ4Dy2Ko8RwEbycJkVCkgbGvrTiRa2W7fdQLzPPlvdKvumJlwW8LTWUc2Nb9MHtQ9yFTYpTampjThkEfBNp3BkACd+mlaFDhezkaAAdKuB9r6GTYM0Kpl6ydeoI3etqy3j39KDt/dtBc6LiipMRSm2GCkgVpDDrolH1oYGaud8eujOc2VXWdPKe2AX1WynL1Yntk0kovMW07yrh5fTnKI4mzjXz6myTFavWFjzoctmzfRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 09:32:02 +0000
Received: from SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be]) by SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be%7]) with mapi id 15.20.5314.020; Thu, 9 Jun 2022
 09:32:02 +0000
From:   "R, Monish Kumar" <monish.kumar.r@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Topic: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Index: AQHYe9vO7iZneeeix02+6Itt57U7B61GyDHw
Date:   Thu, 9 Jun 2022 09:32:02 +0000
Message-ID: <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
In-Reply-To: <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 348a25a9-2f36-450f-52d8-08da49fae8f4
x-ms-traffictypediagnostic: SA2PR11MB4921:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4921186EEED328733D401BCBC3A79@SA2PR11MB4921.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GglL7Db3/UU+MOzYhxZvRS/PJeNZlhVXaj9l0iXLGRmp64Go2oKEggfgXS3GZNGKUF7nSeBz3uVVdO9eOZMLXt0juW67WcnXQAG1Zh1uAxy90fFnwdDyNOQ2bl0jO9jRgMTCOj6HZpDBxMUD8mgPWXUuGy9r+TOrOUbr1WackI9UhOiHa+1IeHlaPRxH7q6+7XmQYg3InYX9idZxPM+eV189SdaV2lmG7S26ySnrFKoqgWKhB6qukLD1G1BeTRJ0hTk0348c5FI66lzYkZXYg/+o+w9ap5YFntMcRY89A4dtdr6Et+Lmebhqv+DfqG6DH0KHHvgND2DPUHQXHvpyVotfgBWe8AbIVtdNU/RR4861f0046At5hguDD61gd01nXMiWzc/E2MNfXdGdsxJxrfTLfxBusTalut+8ryASq8gm3PaIPOwcYomHriwuzR5T7AhevBZLL+2iunyEdnLg3ezmFHHT3pbMoedqZeqMSyLtRa1g7KKXuNdjNSpqw0IDrKLrdyt1RzBD503PXtrOtPDRfoRCKs9SuOJe6dg5tnNwAklf60SXRT7/pMgg7KaixcPOnptg8IUY6tdRXoIKj4Lwx0lPpYwF8OhsVbiqWEWyni9n9pPDuXRYmEhq4xrDAOiefTJnIvMLR8JY/yEKs6F+SF9lRgQ540KQQuKQDs8VuCDfHuTrsOm7wLZqjqCScmuJpN10AC9yV8GWToSC/UANxFodrykCaD+9lhuAtJrXDHuFRz9bxl3DiRGk2pQ5MhUyCwMU01qHFrG4I0DXHbwv5awEkpSz8mh52B2jCJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(316002)(6916009)(5660300002)(33656002)(52536014)(186003)(71200400001)(2906002)(66946007)(66476007)(66556008)(38100700002)(64756008)(76116006)(66446008)(6506007)(8936002)(54906003)(38070700005)(86362001)(508600001)(122000001)(966005)(26005)(9686003)(83380400001)(107886003)(55016003)(7696005)(53546011)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmUxd0hGSkQwcGMrNUVIdUpnWnpjaVUrTnZOSDdxNmtkWDQ0bzN3ak55bFZM?=
 =?utf-8?B?ejV5OFZtSFpUM3hDeDVVK05oem9LVnhuOENQdTRxNUc0OGYzbi82WHF1RUtr?=
 =?utf-8?B?ZzlZTEFtUjVhVW5aVnA2c3lBNHh5bHhLRTN4VWZadFhmMWRNN3VjNUcrWHFp?=
 =?utf-8?B?NytVYmoreDQwTHordlBINm9EYjk5a3JmZ2p3d3ZoY3MxVDFKRHMyVjNuMm5k?=
 =?utf-8?B?c2dHZWx1ZlladTIrdUVuTnljQ2FyWGF6b3NndTJIMU5DYkYwN2sxMTlMVG4z?=
 =?utf-8?B?UHdMaUhBSktPbHM5bFNER3F0cDhpdjRaQjFmWVdpaGJ0TlU0VTdLb3VlQnhm?=
 =?utf-8?B?RVhGUG5lQ2JuT1FaUE1JYVk2dWJzblhldG1xTWRWYlB2VVdkZ0o5SWtRTmp6?=
 =?utf-8?B?czdjMlh0K2JHRFZEZDhaMWhMYUV3ZVR5Z3lOc0Q2SENHQ0JBOWEvSnJvMUxO?=
 =?utf-8?B?MlI3amVYOFIxQ25Kd0xoV0ZhMHVjOHZIRVpnSzRxSDZ2NGFjZkg0QlNlUEVF?=
 =?utf-8?B?Tlg5MVVocWVpQmFLcnViaDdjTEVDY2l3bHpVY1dNVi9NRzNKTG1mWjdReUFR?=
 =?utf-8?B?a1RrdVRyRE5RdU1wZE41TmlnRVc2QUUzckFTRkt1MGs5M3Urc1JPYXF6Rm9w?=
 =?utf-8?B?cW1MeVRQZ3pYM2tPWHF6TkJ6ZEMzeXZNWTR2SXdTOXpzQnJhd2U0eHphL2Rr?=
 =?utf-8?B?cHBmdU1CQ1lyQUJ4eWg3VmhYakxnZXo2dTNHQjBNRXJMWWdFcGg4aW5rcTQr?=
 =?utf-8?B?Sk8xeERheHp1SHFLR09iQVFKL3JGOE5PMVkxUm9lQW45QjdES2JlbDVmWWhI?=
 =?utf-8?B?bFJabVRoQTc3MEMvVGNvbHR6TGYxTEFyR3grVzRUQjBKcC9MbFY5SDV5NVFW?=
 =?utf-8?B?YWVrUFhQTytpV3k3ZE9ZNG5vWDFWRXd6K3FqRFlrbGJXUHFiYXJoZldwT3ZQ?=
 =?utf-8?B?WmlnUnNFbllvK1hvY0Q3MXp2UTduREVuSTJEbENhOUgwQ3QzaTNXQ09XOXd3?=
 =?utf-8?B?aHBwTXZRN3Jrd3RzQXN2VVJxcGQ1SGJYQ2pjWG5VL1RlN1duVnZPem9ybkJS?=
 =?utf-8?B?d014SzEvc0YyWWUzRnkrVmR4NkFmTnYreU56MDljakNXTWxqTlBFOWsyTmRq?=
 =?utf-8?B?SlFHTVFEWGh4bk9BMysrRHhabzM3R3N3TmpRU3BpVitEbkxpNzlrQXVoZit3?=
 =?utf-8?B?RWZrTWtESXRmanNJVWpDL0svaktMcTFlMG5YT00yaWREdzZXU2dwWU9yU095?=
 =?utf-8?B?SHRNY1h2Q1B0bDIzMG9iMXNEcHhPbnh5SnJSN2ZpRDRVMUhQU2VkN1RXaERv?=
 =?utf-8?B?RlhySU1JMlBXQTIyRFZLMjdHUTZSNXpwMzdDbjd1c2FwR0Q3WTZJdmNaR1hL?=
 =?utf-8?B?R3NoMlRpMGdYalFhZHJmbVhvRFZ0RXA4d3hNMi9mcVFYdlN4RTQ5amFmQ3ls?=
 =?utf-8?B?U2pLUktab2QvZWNCc0VWOWxSOWtDVVVqT3d4RER0TXlIQ3JtWGtpdXJLSVRw?=
 =?utf-8?B?MjMrRCs3Q2Nvdm13VUxPZFBMaFZXMGs3cDVNSGNSbi9vQ01TbUtkeWpCcWVF?=
 =?utf-8?B?OG44ZDU5dTBmQ2xRelhhWTJpd0pjaGVpc3dkSmVLdnpjNXVQYUFwWVZOV3Bq?=
 =?utf-8?B?bmFFWGFCN3h0Nld1ZE02RGJYYzJhb0IxVWFUb0pzYmpQcmwyOTE3SXdCdldv?=
 =?utf-8?B?eTVyZFpTRlN6K3diUU9WYzYxVHRXSnk2WCsxUUZPR3U1SEF3SEYwcWQ2cnRG?=
 =?utf-8?B?VW1xY1BLcnMxMkpNNGIra1ZiWUFuMGh5TmN6K0ZWOU5XSUMyaWNieFJwTzU5?=
 =?utf-8?B?b0g2UDV1L3NDdFIyK042aExZdHlkZ0dTdjJ3S2JtK2NndE56S1NPOURFK28w?=
 =?utf-8?B?RlZCaFVvZTR3TXNkSW9XdVlIUFhJMUZ4bXlxOWZjQ2NORUNyTW5VcGVZWkFk?=
 =?utf-8?B?L1ZpY2pVN0xud0kxcGVOdmtDWlhLTlkycU1SRlpiN2d4R3hlRWc0TVJIRWF3?=
 =?utf-8?B?MlZrOGNydmZvcjZ3ZUswVVh4Nmx6Qk41aGJtWWZxdHFTNDJMQlBiS2tROW5l?=
 =?utf-8?B?alI2dGh4ZGo2Mk9JMy9jbVhXazdvdjZvVXBxQ1I3T0dCSVhmTG9LcUdvaEZP?=
 =?utf-8?B?RSs0dXFjTTdBSEFQZmMvS2IvRFJHR3Myb1RRQ2xpd1c0SDlJNGNpQVFvUTRv?=
 =?utf-8?B?a2Z2V0xEaDVlQTdiWDZCVi8rYklrUFFSdUJEMFNYTjdaYTZOQ0dJNy90c2o3?=
 =?utf-8?B?bHN6TFBnZ1hMY1BoR2VFRXN5YlpWQWhEYW80bGgzZ3l3bm1nUmtZWi9LZG9R?=
 =?utf-8?B?MkovSElNaHA1c0pzekN1YWkrZ0ZWbENaS2R1bTNMVGh1dGpMb0JYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348a25a9-2f36-450f-52d8-08da49fae8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 09:32:02.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcwQIx1aGP07EMKiiqPXpSpDu3U23sBOTkB9jRlWE3M0E1I6p0Qs6w4RZnct4Ittl2pHu2DdfKSRnq8ZWllK9RENHgaoVH3tIfnzObNkCH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sDQoNCkkgd291bGQgbGlrZSB0byBwcm92aWRlIGp1c3RpZmljYXRpb24gZm9yIHRo
aXMgU2Ftc3VuZyBYNSBTU0QgZml4IGFkZGVkLg0KV2Ugd2VyZSBmYWNpbmcgU1NEIGVudW1lcmF0
aW9uIGlzc3VlIGFmdGVyIGNvbGQgLyB3YXJtIHJlYm9vdCB3aXRoIGRldmljZSANCmNvbm5lY3Rl
ZCBlbmRzIHVwIHdpdGggcHJvYmUgZmFpbHVyZXMuDQoNCldoZW4gSSBkZWJ1ZyBvbiB0aGlzIGlz
c3VlLCBJIGNvdWxkIGZpbmQgdGhhdCB0aGlzIGRldmljZSB3YXMgbm90IGVudW1lcmF0aW5nIA0K
b25jZSB0aGUgc3lzdGVtIGdvdCBib290ZWQuIE1vcmVvdmVyLCB3ZSB3ZXJlIGZhY2luZyB0aGlz
IGVudW1lcmF0aW9uIGlzc3VlDQpzcGVjaWZpYyB0byB0aGlzIGRldmljZS4gDQoNCkJhc2VkIG9u
IGFuYWx5c2lzLCBkdWUgdG8gZGVlcCBwb3dlciBzdGF0ZSBvZiB0aGUgZGV2aWNlIGZhaWxzIHRv
IGVudW1lcmF0ZS4NClNvLCBhZGRlZCB0aGUgZm9sbG93aW5nIHF1aXJrcyBhcyBhIHdvcmthcm91
bmQgZml4ZSBhbmQgaXQgaGVscHMgdG8gZW51bWVyYXRlIHRoZSBkZXZpY2UgYWZ0ZXIgY29sZC93
YXJtIHJlYm9vdC4gSWYgbmV3IFNhbXN1bmcgWDUgU1NEJ3MgYXJlIHdvcmtpbmcgZmluZSBhcyBl
eHBlY3RlZCwgd2UgY2FuIHJlbW92ZSB0aG9zZSANCmZpeC4gDQoNClJlZ2FyZGluZyB0aGUgUENJ
LUlkJ3MsIEkgaGF2ZSBjb25maXJtZWQgZnJvbSB0aGUgbG9ncyBhbmQgaXQgc2hvd3MgYXMgdmVu
ZG9yIElEIDogMHgxNDRkIA0KZGV2aWNlIElEIDogMHhhODA4LiBJIGFtIG5vdCBzdXJlIGFib3V0
IHdoeSBTYW1zdW5nIDk3MCBFVk8gUGx1cyBoYXZlIHRoZSBzYW1lIFBDSS1JZHMuDQoNCkxvZ3Mg
Zm9yIHJlZmVyZW5jZSA6IA0KQWZ0ZXIgY29ubmVjdGluZyBTYW1zdW5nIFg1IFNTRC4NCg0KbHNw
Y2kNCjA0OjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyOiBTYW1zdW5nIEVsZWN0
cm9uaWNzIENvIEx0ZCBOVk1lIFNTRCBDb250cm9sbGVyIFNNOTgxL1BNOTgxL1BNOTgzDQoNCmRt
ZXNnDQpMaW5lIDE0Nzg6IDw2PlsgIDExMi44Mzg5OThdIHBjaSAwMDAwOjA0OjAwLjA6IFsxNDRk
OmE4MDhdIHR5cGUgMDAgY2xhc3MgMHgwMTA4MDINCkxpbmUgMTQ3OTogPDY+WyAgMTEyLjg0NTc2
NV0gcGNpIDAwMDA6MDQ6MDAuMDogcmVnIDB4MTA6IFttZW0gMHgwMDAwMDAwMC0weDAwMDAzZmZm
IDY0Yml0XQ0KTGluZSAxNDgwOiA8Nj5bICAxMTIuODUzNzE1XSBwY2kgMDAwMDowNDowMC4wOiA4
LjAwMCBHYi9zIGF2YWlsYWJsZSBQQ0llIGJhbmR3aWR0aCwgbGltaXRlZCBieSAyLjUgR1QvcyBQ
Q0llIHg0IGxpbmsgYXQgMDAwMDowMDowNy4wIChjYXBhYmxlIG9mIDMxLjUwNCBHYi9zIHdpdGgg
OC4wIEdUL3MgUENJZSB4NCBsaW5rKQ0KTGluZSAxNDgxOiA8Nj5bICAxMTIuODcwNTM2XSBwY2kg
MDAwMDowNDowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMjINCkxpbmUgMTQ5ODogPDY+WyAg
MTEzLjAxOTY5OF0gcGNpIDAwMDA6MDQ6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHg4MzAw
MDAwMC0weDgzMDAzZmZmIDY0Yml0XQ0KDQpSZWdhcmRzLA0KTW9uaXNoIEt1bWFyIFINCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25A
engyYzQuY29tPiANClNlbnQ6IDA5IEp1bmUgMjAyMiAxNDowNA0KVG86IFIsIE1vbmlzaCBLdW1h
ciA8bW9uaXNoLmt1bWFyLnJAaW50ZWwuY29tPg0KQ2M6IG9wZW4gbGlzdDpOVk0gRVhQUkVTUyBE
UklWRVIgPGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZz47IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+OyBhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbTsgTEtNTCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPjsgS2Vp
dGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgYXhib2VAZmIuY29tOyBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT47IFJhbywgQWJoaWplZXQgPGFiaGlqZWV0LnJhb0BpbnRlbC5jb20+
DQpTdWJqZWN0OiBSZTogMiBzZWNvbmQgbnZtZSBpbml0aWFsaXphdGlvbiBkZWxheSByZWdyZXNz
aW9uIGluIDUuMTggW1dhczogUmU6IFtidWcgcmVwb3J0XW52bWUwOiBBZG1pbiBDbWQoMHg2KSwg
SS9PIEVycm9yIChzY3QgMHgwIC8gc2MgMHgyKSBNT1JFIEROUiBvYnNlcnZlZCBkdXJpbmcgYmxr
dGVzdHNdDQoNCkhleSBhZ2FpbiwNCg0KRmlndXJlZCBpdCBvdXQuIDIuMyBzZWNvbmRzIHRvIGJl
IGV4YWN0Li4uIEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBjYXVzZWQgYnk6DQoNCmJjMzYwYjBiMTYx
MSAoIm52bWUtcGNpOiBhZGQgcXVpcmtzIGZvciBTYW1zdW5nIFg1IFNTRHMiKSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMjAzMTYwNzU0NDkuMTg5MDYtMS1tb25pc2gua3VtYXIuckBp
bnRlbC5jb20vDQoNClRoaXMgY29tbWl0IGRvZXNuJ3QgaGF2ZSBhbnkganVzdGlmaWNhdGlvbiBh
bmQgZ290IGFwcGxpZWQgd2l0aG91dCBtdWNoIGRpc2N1c3Npb24uIFBlcmhhcHMgTW9uaXNoIGNv
dWxkIHN1cHBseSBzb21lIG1vcmUgaW5mbyBhYm91dCB3aHkgdGhpcyBpcyBuZWVkZWQgaGVyZT8g
RlRSLCBJIGhhdmUgbm8gaXNzdWVzIG9uIG15IHN5c3RlbSB3aGVuIHJldmVydGluZyB0aGF0LiBQ
ZXJoYXBzIGl0IHNob3VsZCBiZSByZXZlcnRlZC4gKEkgY2FuIHNlbmQgYSByZXZlcnQgY29tbWl0
IGZvciB0aGF0IGlmIG5lY2Vzc2FyeS4pDQoNCkxvb2tpbmcgZnVydGhlciwgaG93ZXZlciwgdGhl
IFBDSWUgSUQgaXMgc2FpZCB0byBiZSBmb3IgYSAiU2Ftc3VuZyBYNSIsIHdoaWNoIEdvb2dsZSBz
YXlzIGlzIGEgcG9ydGFibGUgdGh1bmRlcmJvbHQgZHJpdmUuIElzIHRoZSBQQ0llIElEIGNvcnJl
Y3Q/IE9uIG15IHN5c3RlbSwgdGhpcyBpcyB0aGUgUENJZSBJRCBvZiBhIFNhbXN1bmcgOTcwIEVW
TyBQbHVzLg0KSXMgaXQgcG9zc2libGUgdGhhdCBNb25pc2ggY29waWVkIGFuZCBwYXN0ZWQgdGhl
IHdyb25nIFBDSWUgSUQ/IE9yIGhhcyBTYW1zdW5nICpyZXVzZWQqIHRoZSBzYW1lIFBDSWUgSUQg
b24gYm90aCBkZXZpY2VzPyBJbiB3aGljaCBjYXNlLCB3ZSdkIG5lZWQgc29tZSBhZGRpdGlvbmFs
IGRhdGEgZm9yIHRoYXQgcXVpcmsgdG8gYXZvaWQgdGhlIGRlbGF5Lg0KDQpBbHNvIG5vdGUgdGhh
dCB0aGlzIChwb3RlbnRpYWxseSBlcnJhbnQpIGNvbW1pdCBoYXMgYmVlbiBiYWNrcG9ydGVkIHRv
IHN0YWJsZS4NCg0KSmFzb24NCg==
