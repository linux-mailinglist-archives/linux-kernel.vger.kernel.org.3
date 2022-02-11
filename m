Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406EA4B1C29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiBKCYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:24:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbiBKCYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:24:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1355A1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644546261; x=1676082261;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSIjHhKMiIDWQqKeEZ02YQOA941QnUaGsxVXVdoLOEQ=;
  b=Xqf1iX8uecsds5J+MjVDXSzp/Jis5VfxAP7tjb2KZbdOVVTWFngpHtMM
   tfLqoO7Lh9hSq/6PjmdoMafo1Xqk9T11fancrohQyRReR4XfsOBS6VmXp
   nIDvaSqkBOeAxT1vQLla4Dipnd5ypSF0WBVr1gR7oAhoRule7Pug8XT/P
   hefW3tpRnF1u2WsUk9fmHGIQOt8JENyp6fTGbDp6U2dJeUVkskmrmi1Af
   i3AioPBCEVljbNKRTmtdn7hdBomNKbAT1Rhsr78ckTOLPrri9iAPjkTYy
   PTW7pJtPDZzlgLF41Pnu8cGEnBMjwX+CdIeYoN1p/0RjkYwslrGfmzcoU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336064654"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="336064654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701930485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 18:24:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:24:20 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:24:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 18:24:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 18:24:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abtlAWhJV08tOUlVqiHJx00EU5M3cTuEY08MFY3EQ/FBISRFa2Ua3j6j2vhXUvJIhvWRe1ZfhE9tbKPQeRbfTq6N+bLUZ9PkIE8dAx1rPc7re2Zx4c93sfT5BBaq5GKdFvjpFi0JOBYvcIXECG3W5v2RUVqDfoy82imHDmhJMYD0e6MQ701vjqOXHX7fdzu8SndpaLKCP0+sHTA6Hnx3PSeJ2eu1BZWDEH5/B12YTTVbi/z6OJuzQ5UotWZG24VlrswEYqNVVWRQ1Ztdl9FfywaK84br8tcgChEzys2GvoVde8njysstY3x5N33+ux877S/rxn9Va4qEx0PlmhaukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSIjHhKMiIDWQqKeEZ02YQOA941QnUaGsxVXVdoLOEQ=;
 b=ipunEbEK2L1FENZ+IWuKPI0L/FX5aFAUKYA4gs6EqrQynuxRPquM40jcE1J6F1hxuGC0TBJsiwoTLoYSuLHOCy0O2PzRx9UjuTwpbedE89atCb8H7GfYurwmWD2kI1aNBUK2LZ2gh+DVMkehVcoT2dCyXBovXgQoPHVzq6TDWqzhWI15aBYnOiZnT6Laaf5zf+Aq4xVDvQqG3Aqey+XpEMi7OgCN8XLvX7EuKB3fCcn4cuWqZ2Y2o+yhIJrZ3SZKJ/IcrE9JAf0HsXDWar8s9gHD3Mohbx9tRU/YJummhbG7A8h1fghtTwMN9FFD8kQ1xCh+EanOZbilR7iNRzb89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 11 Feb
 2022 02:24:17 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 02:24:17 +0000
Subject: Re: [RFC PATCH 3/5] firmware_loader: Split fw_sysfs support from
 fallback
To:     Tom Rix <trix@redhat.com>, <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-4-russell.h.weight@intel.com>
 <487b45dc-edd3-4406-7f06-9dc68e330623@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <ca6ad2ef-455e-c6c5-f766-2a64a5caec0f@intel.com>
Date:   Thu, 10 Feb 2022 18:24:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <487b45dc-edd3-4406-7f06-9dc68e330623@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36d4640-1d68-4c75-05c4-08d9ed059a2e
X-MS-TrafficTypeDiagnostic: PH7PR11MB5942:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB594236D9754AB83B878601BFC5309@PH7PR11MB5942.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpurmtucEDVWIOYO7VMoGEjcLLyTV0fJ5UPx94h0ctpAvABlmNZVaEC5Losk/GeNyGINj37O7L6vwWBiJCyTbmbHGt2dvs21p98Mv4EwwBWFTUU3gln2LKXt8Q65xigvCLP+3wYqA6JWu7A1NSp4DRr9bBwGZR4IcJkEwgGI2rKREcKdK9AGR8q/Qsytw4Z5AvW+galcmi878YzJzaa7ZKsP6zQmDlNI0eFItQjyHsUYjdQy1JJ05r/eU5sO24+GLbGH/g0Lx+YrOynPdmdHHBCnvuzeEWQxm/AYpnMUNwpu/effgL7XVU3dLgZYx/QZzC2RNCP5ckzuACSoqCb9WfEi2DuolQxI/Y4FmSlPKoonWyeWflKppcckJ5SslsjEqng3ibDcYtb3Ig/GkM0uWA0ej78jKt/DNezzOB/zPpAF/eahXkBQbNVpMdJsTSBACFWXCJD2OuAFf6yStUFxhlZCOznfhWndl8KwBMFzcnmFhqMsYLsskxODFPZJvMoPdvIqW88JE1aDA2LnZP1M/x8vmIiWbHyFxe6sKehZCJ+0RyoYhgNRdLy5TPh8Nx+e6cezN2YHbSX7PPkbnPH4NtEIAvypFWQKNj/Fj7xiGZF3fqcHaZ/7pFs8VKINN17nF/QeKkMLBWes9yG8A5ggR//wYrOepqYD/T6aS/AdeznvKI1WrY0bwsk0EHWkw1JhPOVsUDNx3GQBbMTG7q0FII9GzoeK0YaZgtw1o4j6Kv0HpKMu1KEZ0WMBWiS+uYU7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(83380400001)(5660300002)(6486002)(36756003)(2616005)(107886003)(38100700002)(316002)(82960400001)(8676002)(6666004)(31696002)(31686004)(66556008)(8936002)(6506007)(66476007)(26005)(53546011)(6512007)(508600001)(186003)(86362001)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmJ3Z3gweGF4cEhCNXUwRzRlOWdReXFiQkxCKzgraEJkWUw2SWJEN0ZoaUVQ?=
 =?utf-8?B?OHYzdlFzdmRjalByc3lRRFBHMjExUGdnS20wZFZKR0loSGQ0RHFwWGx2b0Zy?=
 =?utf-8?B?MW0zUnUzeGp4RzVwVXh1R2Y0Und6dFc1Zno2M1ByYm5PNmMzS3dsQ0FINjZY?=
 =?utf-8?B?SUxXcGZhaE9yV2VRNGlDeEtGcTZ0ZUVrZFFzTGk5NUdDNWxpZTBLN05rUDl5?=
 =?utf-8?B?UHJkTGVpT2Y5RUl1VDdSVzlaM1B1WDQyaVUxWkhwZ1BQRWsxYkM4ekJuY2tx?=
 =?utf-8?B?NTkzMmh3eU1EWGRDbnZ2ZXZpY0JNL21OZHk2bXZUUUtwS0haK3lVeTN4WUwz?=
 =?utf-8?B?RHBoMWI5TVdSTTVTbTZKaVNkSnNEM0VSN0FKVFZ3TVVYU0hCQ1FOODBRbUVE?=
 =?utf-8?B?czUrK3R0RFJuL1Z3MU9wOEwrSXdOTWNkMFpFQTlaTnk3TnhQelY1SHhXeWxt?=
 =?utf-8?B?TkNUKysvaVBkY0hOd2FkcnBsdE5JTGo1SmZ6b1NBRUJ5VkswUnFCMnVMaGcw?=
 =?utf-8?B?YTcrZWxhaXNrV1VrK1FxU2Q5M3p4MjdoeHN5YTlDRndZaEowSGxXSFdIcjZY?=
 =?utf-8?B?REVHRlJwclhPanVSYzU1V0Q3ZG55WG55NloraXU1VzNmdDhhV3drcytnaXBK?=
 =?utf-8?B?UnIrZHBVMHo3eDJiS3NEVk1vZ2lCM0svaDM1VXJOSlllQlFCTkhtekxocUpW?=
 =?utf-8?B?WXR3N0FBSUdQaUpWc2NhVkpJcGMxYml2WklBYlBaSTNhSk02dGZOSlVCNWds?=
 =?utf-8?B?SUkzc21nUnFlMzIrelFzdHM4cFVmU1FhOEEzK0RrM2V1S0tXdHdNd2M0Z2JC?=
 =?utf-8?B?eUlSR3RXZWpMSFZrT1BOVkpTRmpTZUVndnZRWHNINXgydDV1UUFDemZRaHBu?=
 =?utf-8?B?Qi94S0x0Q0pTOS82M0dwQSszS09sazR6ZE9qeFZMN0lzSVJFc3p4N2xTSENx?=
 =?utf-8?B?TXdKSUMxVHlRWFpBUW9BRHNmVVdrTnlCM1orNHQzNVBkWXFQSUlRK2RlQWpT?=
 =?utf-8?B?dTMzcXpTYUZIbDBVT1BpekV4UGxCWEpvYlpWTHlucFh1OHU2RFZaVVIzaUZG?=
 =?utf-8?B?L1h4TGdkV2ExNXlZVVR2Rk1PWWN2b0EraVlGVTZkMlI5SW9zK1RibDBId25P?=
 =?utf-8?B?YzA4bFJJcC9NRkhEN3NkcnJ0V1A4TlBWeEEzZHMyMVpYclg4M0pKU1F2ajk0?=
 =?utf-8?B?aWNwelRsUzJrWVFoWjI3TkxjU283a3lVQm9Dd0Q5ODBQM1hyZG8vM1FzV29H?=
 =?utf-8?B?emNqaDZCZmliWUoyN3Y2RmNPKzB0VCtlWUlmNllZOW0wbUFVTHRXbVFtdXVw?=
 =?utf-8?B?RGxXOGNobTJGL3hrVzI5WWtab01BbHNKY29ZKzBOaVNGeWNGMVpjZnFnTEYv?=
 =?utf-8?B?eC95bDNpbHAzZHFRcVNpK2pTSk4vQ0daeUFWd2p0MkNiOXQ1aXpTaVAyam5h?=
 =?utf-8?B?QnF3VHd1RlVMdTltMVhJbVNsM2wyeVNhclo2aUZSZTE2S0EySTVTUlZlNEpq?=
 =?utf-8?B?bWNPeVYrU05yanIrMjRsYTJ2RnVTV3BOc1JrSnJQUUxyMlpxdnpDVnk2Q0tE?=
 =?utf-8?B?WkJ0bktqYU1sU1VtRDYrdVNtV1hZS2pQeGZtUXhlOHJZTGVNUTQ1bXhLbXIy?=
 =?utf-8?B?S3JYb0ZYVTVuYzhXQlRNSHJNSTFHUkxhUFI5V2xpQk4zZ1Q3cUhlTllwMWp3?=
 =?utf-8?B?cWJDQWdCRGtKd1lzb2hoZzRYeHVZbFArbGljOSt1YkpmWFRiVVM3TlJKNjAv?=
 =?utf-8?B?QlJUK1MwdzJiNkpBMzlmZFMzRmxZZ2E3UVRUUEpEQVcxSStnMEN3ZGM1cTJo?=
 =?utf-8?B?WGhoWGRtbnFNSzJMZUdyTDdKK1d2a1MzQWY2Nm5oaHlPQTdzZVk2NzZqNlVQ?=
 =?utf-8?B?RXFVbmFBNlRoTkVOeExzWVpTbStPdmJJZ1gybm1yeTJheG1DcHJzU1IwL3Vn?=
 =?utf-8?B?UEhrVnFFYU5SdFBJdzRwOGRTbW1HYUdIaU5pU2FydGhDdmhxRWVhMlhOeUhN?=
 =?utf-8?B?YmJhK2RxTkM3OWprZkxvUVRVT2VTMHpudXFxRFJwSWljS0NIUkpyUUwzclFN?=
 =?utf-8?B?NXhDTjVzd0tRRFpFd0xwZGxXMzVzRXRFYVpRUlliWmoycFJOUFFjV0Fvei9l?=
 =?utf-8?B?MHhPUW1mWEh2MDRtMXU2cXRPcXBDdktxQzFHMW5OQWpKZHIxYWFCa25uY3o3?=
 =?utf-8?B?VmxYWGpQNy85Z0RnaEhJLzJtNXkrWmM0d1M3SkRDcC9RWkVCMFRQbTN6ZG0w?=
 =?utf-8?B?ZTlrZnRHQzd4V005dXRlUTVndjZRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f36d4640-1d68-4c75-05c4-08d9ed059a2e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 02:24:16.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQPv0lqak/zS9Fdli1tWttW4/T0IIWhLHrKEqwqxCtdJOUwq76/Fu+ZqGilmXvIa5yBA2ZI2DPUxbQOUMIhKUDPB4CZ+eO/t4O8E5i2/jcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/22 7:43 AM, Tom Rix wrote:
>
> On 2/3/22 1:30 PM, Russ Weight wrote:
>> In preparation for sharing the "loading" and "data" sysfs nodes with the
>> new firmware upload support, split out sysfs functionality from fallback.c
>> and fallback.h into fw_sysfs.c and fw_sysfs.h. This includes the firmware
>> class driver code that is associated with the sysfs files and the
>> fw_fallback_config support for the timeout sysfs node.
>>
>> CONFIG_FW_LOADER_SYSFS is created and is selected by
>> CONFIG_FW_LOADER_USER_HELPER in order to include fw_sysfs.o in
>> firmware_class-objs.
>>
>> This is mostly just a code reorganization. There are a few symbols that
>> change in scope, and these can be identified by looking at the header
>> file changes. A few white-space warnings from checkpatch are also
>> addressed in this patch.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>
> Consider how bisectable and reviewable this patch is.
>
> I think this patch should be first since reorganizing should not depend on anything new.

Hi Tom,

The first two patches are very small and stand on there own. I put them first because they could be taken independent of the rest of the patches.

>
> Other users of fallback will want to know if this change is going to break them, so the reorganization should be as mechanical as possible to make the review as easy as possible and easy to revert if something goes wrong.  Ex/ the whitespace changes made as a separate patch to the old file, not embedded in the new file.  The new Kconfig added later if needed.
>
> Also consider if this move is needed at all, generalizing in the existing file is ok.

I did give this a lot of consideration. I'm open to reorganizing the code if needed. These are some of the things I considered:

The context of a user-initiated firmware upload is quite different from firmware-fallback. I want to reuse the sysfs support for loading and data, but I don't think firmware upload should share the same config options as firmware-fallback, and incorporating the firmware-upload support into the existing fallback.[ch] files seems pretty ugly. I think the split is the right choice.

The split was largely mechanical, except for the following
(1) Kconfig and Makefile changes - without Makefile changes, the resulting patch wouldn't compile. I suppose I could defer the config change, but it is a small and obvious change.
(2) Data and function scopes: the resulting patch would not compile without these changes.
(3) Whitespace changes: the purpose of these changes was to quiet a handful of errors checkpatch. Moving them to a different patch would defeat the original purpose of make the changes at all. Maybe these changes simply aren't needed?

I could defer the Kconfig change and remove or defer the checkpatch-related white-space changes.

Any other opinions on the code reorganization in this patch?

- Russ

>
> Tom
>

