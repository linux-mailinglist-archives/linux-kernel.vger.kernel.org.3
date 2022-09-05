Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5585ACD6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiIEIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiIEIIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:08:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AB43D5A0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662365290; x=1693901290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AmdYRP8KVrRH+u5qga1MIqlL6UPxSw6DMRfqwuzUsEo=;
  b=XWdH+o0ol+rJAQzffsFJe8cNiOTRM3/yJttnF4uicot3lUf++vMV+MSr
   WeP2pjSkUBsNftFfxESs3VOa63dzaLMF7JTUXIR7iAnitLB5phnX6Oal+
   AHF/bK9tCx14eBiamiFmLD0Q0H/M0ByoSRPgD8UCbF2fbqVlMDL+AEwsg
   HAjP9O62iDhbRYHMYyrfyLR6wyx3aioITqbyXksYDDZOyVIUovFzipP6K
   BhF9IMOhs16Vj4dMEKC7+VOm5sJel92A64vkv4qAhCOwukxJK8O0uMtHN
   4f9lWYvAFsHZCAz6tzbyOAkwKg57o9uzBS5F02hcoQfxj3gcqYc/VQ1wJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="322502370"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="322502370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="717260076"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2022 01:07:57 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 01:07:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 01:07:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 01:07:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 01:07:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD24ykxbsN4ihFfbsj24/AQWOJh3GBIFjFite4txdesqcWOu3pxG66s/av2lqZtyvylnxlcvGCJVTRn2/wGTzSUn8bIlhfIXnqdSQjmpkeuBU9yuiBefuc666kncDJrNxrcV+B5e8pK9CmI7A4N5oynh0dmjnd0qB2/OLd/i/00MhSaOt6CtxydLkEZ9MYLO8pZeFrI8LNrgMpd/bLabD9JM7X4y8tfc0/jblBP3gWM3xncs74htuivGS1ySRDZVBmOPeQW/RdfWQiHm8Dl8VdyaRzHtqoan8+gQ0RT4B/xFE1BMiRaU+3pLBOUOI1JMep6zy1qA6WixbbC0Qd7FAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmdYRP8KVrRH+u5qga1MIqlL6UPxSw6DMRfqwuzUsEo=;
 b=nGlpiZYafZfCd1Gb3/vHYh9gSdOXgLPnrbnh4XfwymGsxcA1WoRdxXXpCv1M0xslSLxXS3u0Lzr2LGlSmKdHGql2fsu2nEZHBJ/ypPyOpyL9dG7ybS/unl8u2muumrV9PiZYVbUoQnL6jYoIXnxF2i2pfyDyjqMYkTmApuT6/VQQdnPCamFfhe1EGuhyLBExCtQzjkZGQjQnzvDRZm59wIQ2APoAuiLHPWLYWn/8wvrjdxUoVdZubMXbTe8RTGTjtMGx7WByV1pHJ4ksLQqZarlBnc8Bt27jY5P2NxrBko+s0T+frQ9Ysnad6Z25mC8OqR7G93u2cL3JmS6trI+Emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by DM6PR11MB2923.namprd11.prod.outlook.com (2603:10b6:5:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 08:07:55 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::b9eb:135b:f1d8:db37]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::b9eb:135b:f1d8:db37%3]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 08:07:54 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
Subject: RE: [PATCH v2] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Topic: [PATCH v2] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Index: AQHYsUZ2xE/DHyX/w0W4oBRjSDBIqK2xSguAgB9NzjA=
Date:   Mon, 5 Sep 2022 08:07:54 +0000
Message-ID: <CY5PR11MB6257F0C029B0C9325A8AC443977F9@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220816075424.1245593-1-sean.hong@quanta.corp-partner.google.com>
 <f6baa98e-af46-7ca8-397a-2e762cd444c6@linux.intel.com>
In-Reply-To: <f6baa98e-af46-7ca8-397a-2e762cd444c6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5fce9bd-7f6d-4f15-1441-08da8f15bcb5
x-ms-traffictypediagnostic: DM6PR11MB2923:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+GIURGYu22rq08KKI1dZsdWp1uBnclKfWbEAS0IAZ/ubyrtA5YzzBSJDU27vRJZ4erLsi2cFZooAmjaOc4zXHit96rMPrAROa4yZ5sIyPAC4YKhInlzocWlPc0bXxrXDV3UPO7Is+ckHfheFOlZSq8ei41C42n0B8MqgSmaXpYBEi2WgTrN6f7TLpety4vicVw4B3LHb1ZZy9Y59gO+3+joMuETopm9a0bzfapch/kgXQEYr/u1rnACYuvTymyIbT1avSi8kJzPjnSH7fxNjD/R4JuxHyGPWOLO28+Rt70y37YR+vVyx/DZa83gcAjNVL7CJPHbSc8wYM+Vw2p08Css6kvTkSMuVltvoQ+mYBozxZINt+7/FGrH1EXEV7Vb0C24o3/DcDs0r5EdOHBcmKsDM6TxBPUMZ2YW4aNdAr83N4SdnblrQdVWB78NFLaizq7pquGMSkHncTrTvr46vb5Vepe3wdtiwzp+GtATp9Q35+zjkd84MXJdhrSuCTXA4zG+v0b/oXjhOTZPx+kKtIfDuPkfSs/tUe/hBiUsaG8aAtmsp2atcCPc5Z9uyu9cmC0AGk7DAtd8nzYLSt8loePCRCHgpmlj7iJAAS5dwqZpvzaWHjXuDqn0JGI+qA8GXP9x4V4VpXrB1/GKpDG51RMKDrwlaodBQlcbdRlWTwrsL7FUjYFYx7CL2NpNHsvloja4hxhlyVt57ZCGTrI9rNvmdGdI0YcLO1Ead00dHpXdQzxXwhmP+Tm1ND671AFu3kX2Acegm1y2+mrEGsVm9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(136003)(396003)(366004)(76116006)(316002)(41300700001)(52536014)(7416002)(55016003)(110136005)(9686003)(53546011)(33656002)(8936002)(54906003)(66556008)(66946007)(86362001)(66446008)(4326008)(64756008)(5660300002)(8676002)(38100700002)(122000001)(83380400001)(66476007)(6506007)(26005)(38070700005)(82960400001)(186003)(478600001)(7696005)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZJVVZKMld1dTZsZFhOWWlBUTJwY1lTdVJqS0FrenBHc3ZLQ0NKL2hFbVNi?=
 =?utf-8?B?RDZab3k1WkJGYVh2L012T1NyV3ZyL3NoMDFma1c3QlNWU1ZBWjFpWWE5SFN0?=
 =?utf-8?B?SHV5T2tlS2lIdzFla3dkalhMaVZrTFNMM0FEcFFNdFlWOGdxWXhSeVZyTjFR?=
 =?utf-8?B?WWJoMDU4WnZOQ3hMYWRSZ0ZhSkRqUzJTcDBKMmgwOFJrZUxpemgvYTdPcm5M?=
 =?utf-8?B?TldOQVVZUnBzSEVrZkNMYTBsV21tUnY4RU8rRmpKODJjdU9uYTdKN3dFNVBP?=
 =?utf-8?B?MXBqQU5ERHp5UTBxWTJqMGRaa2wwRDJsR0MwTFhuVEVJUlRsRGRVMGtIOThQ?=
 =?utf-8?B?WjhRVjdBcUFudjgrQmRXWDFnTm5SSjVvVlBJc2lQOGEvaWZsWG5wakkzREg1?=
 =?utf-8?B?NzJKNE41ZzBMTUw2ZStXMjEvMHBYd3dEaTlZTkxBajMvdUtzQXB3WXNPcENT?=
 =?utf-8?B?KzZBMG5UWEJDajJRTzJMbXhHeTgzdnZKODlwdkE3aExMRk9RZDVtOWdzdm5G?=
 =?utf-8?B?VXVvaDRDNmpINjdIdzBqOEIzOFQwclhrbURqTnc4V3AxY0NuVlp3b2xLeXdE?=
 =?utf-8?B?WHRKWGlDbHIwMml4ZTF1Yml3cDJZVTVOVXFnL1NIamhCb0JvK0p1bXhrMlg2?=
 =?utf-8?B?dy9wdWNNZVpzaEl0UmF1Y3ZoWUszbHk3ZGlYZnBNSmxCSEhkWWR3QjFTWUxI?=
 =?utf-8?B?clJISmVnTTZWdWFQS1VodUxFT3VIQmRDaFVERC9ja3l2RlNJcWs3Z1RhQ0JO?=
 =?utf-8?B?WXZad1haRDNWVDZZMGhGdWtnVkNQNmdmNktNTHpRYnNNU3RuWmk5U01aSkMv?=
 =?utf-8?B?WTBzajErM2VkNXQxQ1NINi9CM1lWRTNkNW5hOENEcFVXRW5oRFNXSVJkMEhP?=
 =?utf-8?B?bmt4Y0w4QmZ3bERzTG80aWZ6WDJqcHBLWjlDMm9nQjVSQnI1a1d2TEgzeGF0?=
 =?utf-8?B?SkhiRE5mYm51SWNCQXNHY040ZW85MVpVK2FJb013WFNtU1BRMk13VWl3b0o5?=
 =?utf-8?B?ZXdoUnlRYWR4dTBLRXR4SzNuQTBZQlZRZzFYV1hLZFlXYXptYkFaYS9Zbi9w?=
 =?utf-8?B?bmQ5ZldrWjREKzBlTHg5WkUwVXE4eEhJRzNiKzNEM2VUcEwvM3VhL1VLVjA5?=
 =?utf-8?B?STR3M000eDBxc2RyM2RuZFlkTE9JVjYyRlYwRDNnMHhrQVdaY1Jsa1MreTNT?=
 =?utf-8?B?ZjdjRFpSK2tuYkpYSENIMkFwWXZnb1RpemtvUkFkRDYvc2VVa0tIcGVPZWRZ?=
 =?utf-8?B?S1lkL084WEpURWFRdFN3b05UbEdSV1VGdkVjdG1IV2NWUFhNT3BlVnVlem9U?=
 =?utf-8?B?YXZmbTkxYU9JRXNYTWtJSlNYY1RhRVBsUGxXSTl4dXhoQ2k3eHJobGNLZko1?=
 =?utf-8?B?WkNhVGllWGxlbytaaGt2ZzhpckZvQVkwQUVRK1gwRXppMU1FWXMrM2phMisr?=
 =?utf-8?B?ekZpK25vZXBlaUhTL1ZNbGdzaU9JNmhhQzF1RjFvTy9qVFpCd0NKV1hSWS9W?=
 =?utf-8?B?aDl4VEVheVpTSmVXZzgxaFdyclVOaFlrNlNNNGZmbis4NDk2eTg4Z0xJZE1x?=
 =?utf-8?B?bkw1d2JubWxIWFMramJ5UnhSbDJGNFo2S25wNW5hY0RlNmtaaFgvbVlDYVBW?=
 =?utf-8?B?VGl4WXdxRm1SWjZWKzZueTl5c2FxdHZPZTk3Q0FmSE5vQXV3NWVrZTRuK212?=
 =?utf-8?B?a0hSU25HeGpWTkd3blh2dE1ma3NLVmtURHJkWVBBSUR4NGhxT0ZSOSszTzNV?=
 =?utf-8?B?bk5zaVNqMzNwN29hWFlQWmtVS09iRWVOVEtaMlNtVTRlNEVZdnBsc1JYYndS?=
 =?utf-8?B?SFVnOERCd1ZFMWVTRjRidU1DYk1CSkY4SVNxSWlXSXhwL2ErLzV0RkV0MlZX?=
 =?utf-8?B?QTdKM2V1aFJ4bDFMOWtLTklPb0lTS3dLNmNaeU10L3ZXblRMS3dRdElsUVJS?=
 =?utf-8?B?bHRIUWl6ZjQ3V05URXJtV3dUVHVEdHRqSDRWT21POG0wR0UvZzdEZTh1Uzl1?=
 =?utf-8?B?dkgvMHZCZGJFNEdvNFJ6OThqZGl4UWo0dlRKRmNUYkIycGNHbStCbzlML2Fu?=
 =?utf-8?B?Y0tWK0E2RFZJVHpFQ1p3YUFJODFjYThUdGlEbHFjVTM1R3NXajd4S3BGSVdz?=
 =?utf-8?Q?nBmKxMnY2ApP6otnUMFinsLXI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fce9bd-7f6d-4f15-1441-08da8f15bcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 08:07:54.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvbipSfi1NUoq9Y0odFy1IUy7dJR98kEZGIaflVcR7Gc+9B/6tiIKQn//NobhxXqJbZrIsF3XSyesiHxlplLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDgvMTYvMjIgMDk6NTQsIFNlYW4gSG9uZyB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIGRyaXZlciBkYXRhIGZvciBydDU2ODIgc3VwcG9ydCBqc2xfcnQ1NjgyX3J0MTAxOS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlYW4gSG9uZyA8c2Vhbi5ob25nQHF1YW50YS5jb3Jw
LXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgc291bmQvc29jL2ludGVsL2JvYXJk
cy9zb2ZfcnQ1NjgyLmMgICAgICAgICAgICAgICB8ICA5ICsrKysrKysrKw0KPiA+ICBzb3VuZC9z
b2MvaW50ZWwvY29tbW9uL3NvYy1hY3BpLWludGVsLWpzbC1tYXRjaC5jIHwgMTIgKysrKysrKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvc29mX3J0NTY4Mi5jDQo+ID4gYi9zb3Vu
ZC9zb2MvaW50ZWwvYm9hcmRzL3NvZl9ydDU2ODIuYw0KPiA+IGluZGV4IDA0NTk2NTMxMi4uM2E4
NDBmM2E5IDEwMDY0NA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9pbnRlbC9ib2FyZHMvc29mX3J0NTY4
Mi5jDQo+ID4gKysrIGIvc291bmQvc29jL2ludGVsL2JvYXJkcy9zb2ZfcnQ1NjgyLmMNCj4gPiBA
QCAtMTEwMCw2ICsxMTAwLDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
X2lkDQo+IGJvYXJkX2lkc1tdID0gew0KPiA+ICAJCQkJCVNPRl9SVDU2ODJfU1NQX0FNUCgxKSB8
DQo+ID4gIAkJCQkJU09GX1JUNTY4Ml9OVU1fSERNSURFVig0KSksDQo+ID4gIAl9LA0KPiA+ICsJ
ew0KPiA+ICsJCS5uYW1lID0gImpzbF9ydDU2ODJfcnQxMDE5IiwNCj4gPiArCQkuZHJpdmVyX2Rh
dGEgPSAoa2VybmVsX3Vsb25nX3QpKFNPRl9SVDU2ODJfTUNMS19FTiB8DQo+ID4gKwkJCQkJU09G
X1JUNTY4Ml9NQ0xLXzI0TUhaIHwNCj4gDQo+IEkgc2VlIGl0J3MgdGhlIHNhbWUgc2V0dGluZyBm
b3IgYWxsIEpTTCBkZXZpY2VzIGJ1dCBJIGFtIGhhdmluZyBkb3VidHMgb24gdGhpcw0KPiBNQ0xL
LiAgSXMgdGhpcyAyNE1IeiB2YWx1ZSBjb3JyZWN0IGZvciBKU0w/IEl0J3MgZGVyaXZlZCBmcm9t
IElDTCBzbyBpbiB0aGVvcnkNCj4gdGhlIE1DTEsgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgMTku
Mk1IeiBpZiB0aGUgcm9vdCBmcmVxdWVuY3kgd2FzIHRoZQ0KPiBvc2NpbGxhdG9yLg0KPiANCj4g
SXMgdGhpcyBpbnRlbnRpb25hbD8NCj4gDQoNCkkndmUgY2hlY2tlZCBzb21lIGludGVybmFsIHdp
a2kgcGFnZSBhbmQgc29mIGdpdCBsb2cuIEl0IHNlZW1zIHRoZSBmaXJzdCBhbXAgZW5hYmxlZA0K
b24gSlNMIGlzIG1heDk4MzczIHJ1bm5pbmcgaW4gVERNIDQgc2xvdCAxMDBmcyBzbyAyNE1IeiBN
Q0xLIHNlZW1zIHRvIGJlIGENCnJlYXNvbmFibGUgY2hvaWNlLiBUaGUgY29tbWlzIGlzIDUzNDAy
MjVhNyAoInRvcG9sb2d5OiBBZGQgSlNMIGRhNzIxOSttYXg5ODM3MyBzdXBwb3J0IikNCg0KKyMg
U1NQIDEgKElEOiAwKQ0KK0RBSV9DT05GSUcoU1NQLCBTUEtfSU5ERVgsIDAsIFNQS19OQU1FLA0K
KyAgICAgICBTU1BfQ09ORklHKERTUF9CLCBTU1BfQ0xPQ0sobWNsaywgMjQwMDAwMDAsIGNvZGVj
X21jbGtfaW4pLA0KKyAgICAgICAgICAgICAgIFNTUF9DTE9DSyhiY2xrLCA0ODAwMDAwLCBjb2Rl
Y19zbGF2ZSksDQorICAgICAgICAgICAgICAgU1NQX0NMT0NLKGZzeW5jLCA0ODAwMCwgY29kZWNf
c2xhdmUpLA0KKyAgICAgICAgICAgICAgIFNTUF9URE0oNCwgMjUsIDMsIDI0MCksDQorICAgICAg
ICAgICAgICAgU1NQX0NPTkZJR19EQVRBKFNTUCwgU1BLX0lOREVYLCAxNikpKQ0KDQpJJ3ZlIGFs
c28gdGVzdGVkIDE5LjJNSHogb24gSlNMIGJvYXJkcyBhbmQgaXQgYWxzbyB3b3Jrcy4gMUsgc2lu
ZXRvbmUgcGxheWJhY2sgc291bmRzIG9rLg0KU2luY2UgSlNMIGJvYXJkcyBhcmUgdXNpbmcgMi4z
MDQgTUh6IGJjbGsgZm9yIG1heDk4MzYwYSBhbmQgMy4wNzIgTUh6IGJjbGsgZm9yIGFsYzEwMTUg
bm93LA0KY2hhbmdpbmcgdG8gMTkuMiBNSHogbWNsayBzZWVtcyBubyBiZW5lZml0Lg0KDQoNClJl
Z2FyZHMsDQpCcmVudA0KDQo+ID4gKwkJCQkJU09GX1JUNTY4Ml9TU1BfQ09ERUMoMCkgfA0KPiA+
ICsJCQkJCVNPRl9TUEVBS0VSX0FNUF9QUkVTRU5UIHwNCj4gPiArDQo+IAlTT0ZfUlQxMDE5X1NQ
RUFLRVJfQU1QX1BSRVNFTlQgfA0KPiA+ICsJCQkJCVNPRl9SVDU2ODJfU1NQX0FNUCgxKSksDQo+
ID4gKwl9LA0KPiA+ICAJeyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGxh
dGZvcm0sIGJvYXJkX2lkcyk7IGRpZmYgLS1naXQNCj4gPiBhL3NvdW5kL3NvYy9pbnRlbC9jb21t
b24vc29jLWFjcGktaW50ZWwtanNsLW1hdGNoLmMNCj4gPiBiL3NvdW5kL3NvYy9pbnRlbC9jb21t
b24vc29jLWFjcGktaW50ZWwtanNsLW1hdGNoLmMNCj4gPiBpbmRleCBiOTVjNGIyY2QuLmUzNzRi
ZjE2MyAxMDA2NDQNCj4gPiAtLS0gYS9zb3VuZC9zb2MvaW50ZWwvY29tbW9uL3NvYy1hY3BpLWlu
dGVsLWpzbC1tYXRjaC5jDQo+ID4gKysrIGIvc291bmQvc29jL2ludGVsL2NvbW1vbi9zb2MtYWNw
aS1pbnRlbC1qc2wtbWF0Y2guYw0KPiA+IEBAIC0yOSw2ICsyOSwxMSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHNuZF9zb2NfYWNwaV9jb2RlY3MgcnQxMDE1cF9zcGsNCj4gPSB7DQo+ID4gIAkuY29k
ZWNzID0geyJSVEwxMDE1In0NCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHNuZF9z
b2NfYWNwaV9jb2RlY3MgcnQxMDE5cF9zcGsgPSB7DQo+ID4gKwkubnVtX2NvZGVjcyA9IDEsDQo+
ID4gKwkuY29kZWNzID0geyJSVEwxMDE5In0NCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc25kX3NvY19hY3BpX2NvZGVjcyBteDk4MzYwYV9zcGsgPSB7DQo+ID4gIAku
bnVtX2NvZGVjcyA9IDEsDQo+ID4gIAkuY29kZWNzID0geyJNWDk4MzYwQSJ9DQo+ID4gQEAgLTc4
LDYgKzgzLDEzIEBAIHN0cnVjdCBzbmRfc29jX2FjcGlfbWFjaA0KPiBzbmRfc29jX2FjcGlfaW50
ZWxfanNsX21hY2hpbmVzW10gPSB7DQo+ID4gIAkJLnF1aXJrX2RhdGEgPSAmbXg5ODM2MGFfc3Br
LA0KPiA+ICAJCS5zb2ZfdHBsZ19maWxlbmFtZSA9ICJzb2YtanNsLXJ0NTY4Mi1teDk4MzYwYS50
cGxnIiwNCj4gPiAgCX0sDQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBfaWRzID0gJnJ0NTY4Ml9ydDU2
ODJzX2hwLA0KPiA+ICsJCS5kcnZfbmFtZSA9ICJqc2xfcnQ1NjgyX3J0MTAxOSIsDQo+ID4gKwkJ
Lm1hY2hpbmVfcXVpcmsgPSBzbmRfc29jX2FjcGlfY29kZWNfbGlzdCwNCj4gPiArCQkucXVpcmtf
ZGF0YSA9ICZydDEwMTlwX3NwaywNCj4gPiArCQkuc29mX3RwbGdfZmlsZW5hbWUgPSAic29mLWpz
bC1ydDU2ODItcnQxMDE5LnRwbGciLA0KPiA+ICsJfSwNCj4gPiAgCXsNCj4gPiAgCQkuaWQgPSAi
MTAxMzQyNDIiLA0KPiA+ICAJCS5kcnZfbmFtZSA9ICJqc2xfY3M0MjQyX214OTgzNjBhIiwNCg==
