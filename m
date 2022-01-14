Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB81748EDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiANQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:14:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:15627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243197AbiANQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642176854; x=1673712854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VH1UViepgxqtzwOLLg8b2DbUEf0YL5k1MqaNstvOLsY=;
  b=KgmpuwaeicSBX4A26j5rbWSnVohBfXSGXzw2U++nAdsNDk2P0G4MLxio
   BrwXL9QPPGiLxS/EvlN29qUUhQcHatW6U8d80OrQ01zrZwda+OGkKoO1w
   iDmDecvJwusHl7lVPH2gx0l5YT+FsvzLTd3mQSEN5uFN8LNLPGsKhb4Yw
   xHfLXwVlw7w7YRPSLEBo7fZtoAzbldflVENEPoGDq1jiWobIi8jDpVlS+
   zHli/zcAJwMGnHyLJhMz2LljhtH4lsNIdAYoW4Yp4xc15ZwihZOk8bSOj
   P21SBqIJDWWi4i7QUaIYpoojG+N1taV3rTm/qjbzWERByRqPWp3P6ljTG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231622787"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="231622787"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 08:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="475822159"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 08:14:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 08:14:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 08:14:12 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 08:14:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdnTuG7ILeDWpyHiHH1S+MiyxBeEo78oShHpxvyZ7yK+QcYxzjWAc/alsjlsK9uGdjtwdx1nY7KEp1i2T1D6IQ+V1cips1i3hO2NjIfxoeBaiSGkUPVxjG6AA24YoaMKmk++PdXr3q2PVIGg6gqF5T7uDaoQYKGl9OO4dRMBy6rP3EsMKIcywYTW/WJR+F1u1gKzQ8itHeHQh4NulNCxe5cUOMOQPpgYk5wz+NnYICW0fJkTQQgw48q0a8nSwRitw9QC3iWu2Phrpxfsf+nSEa0vKSll4P3q7fQPcqZAgDk6W0SY9Cd5yuMOF7b7mHquAq73Y2G5LVltMYoQfWaRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7Z3N0WYfM3ZuHG+yp3uyrC+yIWCGRNuqjQrLY/qGV4=;
 b=na31HO3Ql2QfhHUUsIO8nfz7CtLOpWch7ksIu1GJrXqlYZK3xiB9Vkhpb2B32qJxzO5drc15wKCiLwq0W1dse0pUGN2BxqpE8duPXe0TIBXb+8XkydWOhgsGPQV1RYhE6mBUB9kLxw+etljmKgFe6EBYzrI0PBcIBHJlmmR/LAVUvlltESreIWT+iY4A/lSzsSkRQKHuPvQIlhh5oi1FPxA+IHSA7PlaytKtWj5NWd+rZusc7IzROSJ00hYa4F4ZivnPFR1uOHNhyJh/Cqy6R9UjIqRX0/xH6TJhdeqT4mwtUOcM4YhQ+oil4v3OzRGiJbKfxebEW5l9sM6zzmdUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 16:14:10 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 16:14:09 +0000
Message-ID: <da4fe940-45e1-7934-9ee7-1b54db40f7e9@intel.com>
Date:   Fri, 14 Jan 2022 17:14:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH 2/5] ALSA: hda: cs35l41: Add calls to newly added test key
 function
Content-Language: en-US
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-2-tanureal@opensource.cirrus.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220113170728.1953559-2-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::33) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9034993b-1c01-4976-65bd-08d9d778e588
X-MS-TrafficTypeDiagnostic: PH0PR11MB4789:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB47892333904990704B5CC186E3549@PH0PR11MB4789.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nHqTkOwQ7We5MJ3knk2TAM80E3YedbwHO/8/3ydlyTV6ZvL7q56iG0Q1Z4FFmiARe1Mv2C8aU4WdxnDZon8Mxc3hnhKkgxyls9z78S1mqcBnQoCCzWCh1v5wv0LEaXY+PF5uzG3AJJ1HPC1wiwDHJLVkcqhP/QAX+5H7ENxyg7o4+SreBRSjssoE8PVdsPHhC8fAwpcm5HEXMGUiIcikOuxpaa15s1z0nmlsYU7/zX17dmYtNvh9sW4mCFwN0z2YWvceVKk07SuT7+OoJEg0octnMYMEhNbYovWN0WBsdhhh2yS448h+InUmnrZrOjhb84jnPWUKel0qWinPkBgriXJw5wGzIl8DHk4IcI3ZXrjO46dvhq+uzpoT+rgUDnQFtdVoh7j9Kct7brt5V+tm32t6GFMDprBiLIq4eNCWJcAKQqrAgeewt8tUR//lvNy+nHDkhuMafmUL6Hiy5tNIgBypk/+nSlcWBtU7JzcUhLoyOzikbUz2BgX4vIp45yXDt1+ZJep3z1KbEIJwRsWR3NYWNpTP6Thdw45OmWRv7Rhstvf3aXbiyyaMTq3QL3ia2uG2/dS8LuDhwZHOGXwTu11StptYX9lvCWC0l7XvmBbPI7k5JiuaQtz52scZFaWooQCVGKqNIxDPTSVSjjpkTizn4tsfbQYUC7RjXXGdxyNd75Y98iJdJr+9vo4VW8Xh/Jo7M0cSE2m5XS1IsIaVkoClluKnBaaaq9wi/SU55I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(8936002)(2616005)(31686004)(44832011)(82960400001)(86362001)(8676002)(6486002)(5660300002)(4326008)(36756003)(31696002)(2906002)(7416002)(6506007)(186003)(53546011)(66946007)(66476007)(38100700002)(110136005)(316002)(508600001)(6666004)(26005)(83380400001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZER3pibXA4UG9POGlYcXdyODZLVG8vUFRKYU5VZkx2L1Y3Q3U2elN3aWkr?=
 =?utf-8?B?NDdob1NienJiaThFSnJ6ZkZDRGR4TjNvQ2c4TVV4ZkwybVpGWGNnelBic1pq?=
 =?utf-8?B?bGJadmVvY0hucU9uOTB1ck1jeGt0Yy9kcFl3WFhTWG1Ba3hFUVFGelZwYnlu?=
 =?utf-8?B?SGF4UFd3U2d1SGdSakYzM3loMXZENXlmd3hsNmEvdEpFbkU5VEVNaGl5UkNp?=
 =?utf-8?B?UHB4UmtRVVYzZGxrblVBTEZyMzNoVlU5NFNFSGJHZnBzRjU2SkdRa2hjNE5C?=
 =?utf-8?B?UGVubXg1c3JKZHpKV0hBelg0MnVvYXVHcEtJVXZ3WWp2M2VaYk0yRzEvZVVq?=
 =?utf-8?B?NmFwL210SVBLWWlYcnJsZ0kzMTRiY1BIWVZZblZkU3l0bUFoSCs1N1k4Y2l0?=
 =?utf-8?B?OE1sTzlRSUZ4RE1waUNEMEdVY2c3S2cxNEdJdTdkZ3ZFRzNIL21CcXE1cFcw?=
 =?utf-8?B?UzRZRnNJYWYrTFMwUVJhSmR4V2R0SlJQcE1SSVRPenl6c2NJcTZmS2hGZ0c3?=
 =?utf-8?B?THBJNzdqb3pIdVhFUVhNNFVZMDc1ZzEyY2MwT1YyNVpJbGxOUFBGcmRyVGJF?=
 =?utf-8?B?VTlTV0ZCVGtPOVkvSnQ1eUZwczRDL3AwYTl1MmlGV0R3ODcrMVRXMmN6cmJX?=
 =?utf-8?B?THN2WDBZc0pERk5DZmwvOFg0QlVDR0hyWVhMYkxya3lqcGp1ZEtTT2FnL0c0?=
 =?utf-8?B?aUUvbW9PdDBXbTYxMnhTMzZlaFVoZFU3MFFPK20vdm52L2NYU3B2TXh0amhD?=
 =?utf-8?B?Z1I4dHVwbFo4VTVxOTNQam92KzZFNENIMHVQa05DSHNyUFE4dGl4emxNV0ha?=
 =?utf-8?B?K1pHMjBjTm9SaDlVWjQxR24rTXdqbzFtdlVtNE0xbTQ0Qkc3cnpidUExWVZk?=
 =?utf-8?B?VHpXUU13ZFd6S25BWVhWblBldS9BbWNRdk1IVmtaL1hZbklZVXR2YmNQVmJm?=
 =?utf-8?B?Nzl4ZDhyUkZHSElBL21paXJrZHpVUXZORnF1MmNFT0tVNDd5K2hUblJuMTJu?=
 =?utf-8?B?OU11SEE5c1IwOWJGSm93d0JadVdya3RmYWNqY0phMWxKYlVPaFIzS3VEd2xr?=
 =?utf-8?B?YzZLS0VNWFdTd2RDMEUxQ2d0bXR0eXJ1dXNYa3pSMmZvMU9qekgrUDV4SnNo?=
 =?utf-8?B?U3FGb2RJcDA5ZlJqYzUyUkJRdUlxYm95TjZ3V0k2cTZwaHVGTDZpU0N5VmFv?=
 =?utf-8?B?LzQwbnVNaG9tVlNBY0x4OE9paXJVTlp5RWlnb2M3b1lBc2czVGczdTNWUGtR?=
 =?utf-8?B?Qm5jc01hOFVnd1lYaVliSVlxWDBGajh5eDJVajVyaHFRRDdwZW1TVjBJajB1?=
 =?utf-8?B?MjJ3bDNuVUtlcmRVcGN6VGt5MHQzc3BNeXYvTGtyQm1vTWxhVU5hQUlzQXVx?=
 =?utf-8?B?RjhjWG4xQUpoU3Bick1BZnA2anZyYWlJeTQ5c2gyU2NoNmdGRFh3a21mS0Vr?=
 =?utf-8?B?V0VvYVhLMGNzVklwU3VIRlNSbC95ZXFTZ2tzL2Q4Vys0N1MrdWVSUkRqdWl6?=
 =?utf-8?B?bnZ3QVIzTjEyUmJ4dk94emZHVkgzeFlUalRrRlBGQTVzUFMvMkY4UFJUWENE?=
 =?utf-8?B?eWlTcVBSOCtYSHhaZkhYeVdoejZOTkpHNUVrTWtEYVdOMU85aXBra3lTLzdJ?=
 =?utf-8?B?TGNmOTBkT29nTzJPcitqajlaT0Nua3FZeTJOWFZpVmF0T29SczQxNWdWMHF5?=
 =?utf-8?B?WGRiVGxmaVNlU3lONHgwYWFPcEN4UEFaRUJnNGhaeVhKTjJKTGtrVk00d1dh?=
 =?utf-8?B?Rjgrc0RxWnhNUnpKMlhkLzlNVXdMdDVtRUdVSjFHbDZXYzdRM2JFUVFMSHJR?=
 =?utf-8?B?ZzhoUlNXMy9NUGl5MlFLSStTWlA1MEtOVFlMZTFsOWNkZ2hqWUVYRXRXdDBv?=
 =?utf-8?B?eXBUeXFILzcvVURtcURrSkIwMEtwbWM4TytUZHExM3Uxdm42TWhFbFYxRHBS?=
 =?utf-8?B?SFY0ME42TW1jeUNiay96VzBOZ3JUeXZLc0xoKzErN0FMbEltY2NzeS9sd0p0?=
 =?utf-8?B?ZWJuR2IzL3hZbnNKWTFGVFZmYlZWaDhzY0ZlOTJTVi9abVJVczR6WVJzb29B?=
 =?utf-8?B?Y0wzZnB3Z29nbHY1MTI2Q2ZYS20yYkpMeWI5bm1JQXRycGFqS2VsY1d3Q3FG?=
 =?utf-8?B?N0lWSzZiZ1V0dHlhSFFzTU5XbEtLZ2VEK3NYa2J6d0ViNTJWNTkyNndCcHBG?=
 =?utf-8?B?S0ZSRW8rdGE4ZUFzQmlGTHJ6bXFTZWxnc2ZOZGRpZ3U2Nk5HOTdWSGFaQXdL?=
 =?utf-8?B?OWxPaGRRMFFDUlpNS0x4WTY1TUNnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9034993b-1c01-4976-65bd-08d9d778e588
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 16:14:09.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMijQ88tYxlWs2irlM8Nm9Xbk+G+7zTZUUiBfUiMI3X1k3azL9IjWMyYeXvrG9DfdxBkzdL1lZBSCSEHfyPNNn2vtBxmxIm8Tt/4irQTKDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-13 6:07 PM, Lucas Tanure wrote:
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> The test key now needs to be manually held when calling
> cs35l41_register_errata_patch, after patch:
> 
> 'commit f517ba4924ad ("ASoC: cs35l41: Add support for
> hibernate memory retention mode")'
> 
> Add the missing function calls to this driver.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>

Judging by the commit's message, this patch is a fix for a previously 
added commit so appropriate 'Fixes' tag could prove helpful here.

>   sound/pci/hda/cs35l41_hda.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index c47c5f0b4e59..509a380f9be7 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -463,6 +463,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>   		goto err;
>   	}
>   
> +	ret = cs35l41_test_key_unlock(cs35l41->dev, cs35l41->regmap);
> +	if (ret)
> +		goto err;
> +
>   	ret = cs35l41_register_errata_patch(cs35l41->dev, cs35l41->regmap, reg_revid);
>   	if (ret)
>   		goto err;
> @@ -473,6 +477,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
>   		goto err;
>   	}
>   
> +	ret = cs35l41_test_key_lock(cs35l41->dev, cs35l41->regmap);
> +	if (ret)
> +		goto err;
> +
>   	ret = cs35l41_hda_apply_properties(cs35l41, acpi_hw_cfg);
>   	if (ret)
>   		goto err;
> 
