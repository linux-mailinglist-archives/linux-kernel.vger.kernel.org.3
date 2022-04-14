Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD7501F48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbiDNXoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiDNXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:44:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFAB2479
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649979722; x=1681515722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9imTj+NnhVlR1XaERtBpLNxZXhz9ZjCOCTbL/uvPxQ=;
  b=USV2hLZTHwDEXXX8bRmkqiUIKLQdv3/2FRhe8uz1PWF3PLfYwtq3qW40
   1v/3hlC/Eel3YeAWQxArG0SOVkK1Fyg+BOzJLrFnO1385rCRV/BabczKW
   4g6IoOm/a0YhA6/XRimlXRoCYKaVXqLGLHWU3RW7kUnYZEATd0jyx94/r
   xp6kKO5HhXte5WZCfDyHrnpcqskxfoq1i1miPjT7z+C+51BiCk8P1vC/0
   QoohJ1HXvcQLEgRIMketGCNwFIIM1nQzQX4Q6AAi4Pd89SEsQ9N8S3kBR
   +Kh7a6EZWlVwK4zdmHYBsux85zzExB13Ke1uwjJ6ovSLBi5Vi3bIAuxeT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="325959811"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="325959811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 16:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="612520215"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2022 16:42:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 16:42:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 16:42:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 16:42:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 16:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWOtgEgp+E9CfsKr+7AUChM9gde6wwjqRPHE0bl6oVG8Xxn7zql+C9Ms0oW4Tal/OC2nAH8pB4rTteeeuHeMsrZFum915u3vO+vEjwJ/u+Sa+BIjuu1Uw7Cb5ZbcmkU1itwHcUvAWQAJrB4u6lPe2btet1YwRNfPfK51UX5C7CmIUm+1E8o17CCjXC82DbRrMsryAYA4zr1STbD+msrnCcYNTD2hWjSj/X8oInMUZhEZu3ME5ZBbPkLca9dezl5YsSDJ+CyD5wZCDA6XCJxbg1AREvec1qiXtNZramyoRpscxjO+G78ZkVFyzh6fIFL9lfeOUING60pu3XyzFnbknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9imTj+NnhVlR1XaERtBpLNxZXhz9ZjCOCTbL/uvPxQ=;
 b=ga9LHeM6XF9e5QLkoJaj9Xlh85zz1W5rGtaN8s9gtpJGHyYwvpBhq2YfpkObJelsKOS4c7u6erdml9F+fatOFdc/gJHM6/WhBc+DTDmkR6zkB5CQfMWHp3csecMJIMEInFGVPzIkq/ZxQOillHRZ4bFohfdM3NvBmCibeYriRR8fM0Id4N7U3Oninln+BlTZmJ7Lnau2LwADJ5spD1PyWWCKL5AWkcr8bNU4XyzvpFyq9hjnk3fgf0bChr92r+jB8H8u+NKU1po3GlqMUk4fmuzbart5kuhgg6k1ONNODW26fH/Mn+ZaMOoce74ae8XLcDIqyI/GdjgS8N5HLuLwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 23:41:58 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b105:318:79c9:1606]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b105:318:79c9:1606%9]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 23:41:58 +0000
Message-ID: <03e8a254-51ff-9eb9-78a5-10ac76c3b3da@intel.com>
Date:   Thu, 14 Apr 2022 16:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH v1 2/8] firmware_loader: Check fw_state_is_done in
 loading_store
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-3-russell.h.weight@intel.com>
 <0dc2d770-176f-9c58-e875-cb65ff38509c@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <0dc2d770-176f-9c58-e875-cb65ff38509c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642b651d-4447-4178-30f4-08da1e705d86
X-MS-TrafficTypeDiagnostic: DM4PR11MB5439:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB54394935B24A1B0E2B8FB071C5EF9@DM4PR11MB5439.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1vHmvuyx436cpuAKeU9I/4m1ImQAfKASjSI+kKutQb3JSjuhai7TEdtT3OCOHZFbIEg4DHEuEBX+8nTqtzE4Ja4A0gz49Ss8TN1R6/BF89WI/FVyO3KOudiDRRH3n8krXk6scey2G/vSIasvWCoEZSnnfRippqSDpyxhteppFtDrzFqaeDIXHhOqEIjEK1+9fLojRO7IDg5p52mf9IFGSrUNjGTINQ0vXnSnO9JZPv4q7rvVIo0PQ/HRQcW7RJD74/vjHNU1zPdlHVNU4RLV3OxO/q2+EDN3dXzU6mRbZyX/jex7yajnBEyR5/U9gO8ctBf5sjI3Zv8DG3S0e558wNEXe3x+/XSnS39SQ7iONqFotuaseTO8SjkpVFluI7YxiDAD5IrtilPhIbsXfzm8sqvvK74dJtcBJqpKFeJmqmYeX8coYdUF19oxYN6HZx+ZAml68Fljdia6dVC3Hv1MOCsgqmoMMVlqSBJF0ghw4yBk0NTLKcTw15d2EJlawJueGbr7tHyPPbUB7efgVQ64+HjCikYurLY79zVTuh7bKXnfsC2TIVXQlQY/VkVlo0RNzlzeMgKmftLfjAjsMNl75UJSId9M+qHBVdJnCY4fHvHqVB7sH6ZEIohYXGETrj8lMKRXvzUX8iyUT7FBUR6wylAscUBUDlLEFjLwJZeniGljhxBjct3fVgmNZCDFzK+VhFfy6rzePbyy9emn/l1EMZYuZ35KhSys9lQz2gMLl0dYZZfrCnbNsyKt8rEKBaz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(8936002)(107886003)(8676002)(2616005)(4326008)(5660300002)(26005)(186003)(2906002)(36756003)(31686004)(508600001)(6486002)(86362001)(66946007)(83380400001)(66476007)(66556008)(6512007)(82960400001)(6506007)(53546011)(6666004)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzB1cnJZTjVmREpZRTFwWUFRU25jQ2ZXeGVSUTJuclpxWUQ1MWtqekRyZWdF?=
 =?utf-8?B?M0NBMUJGajhTZ1l2VEhESGt0RDlLS3lSeVFLUEdxdGRLcTFVVXJ3N1lJK3p2?=
 =?utf-8?B?b3pRQm84NG4zdjRlOGNDUHlvWm00eGZNRGtVMTlWUjhwMzV3UGdubHlDT2FD?=
 =?utf-8?B?VHNqbmtDQUJQMmJBczdrV1FmZXlTWWVQdG9pZ1ExZElpWW5FbXZkdllBZ3Fv?=
 =?utf-8?B?UDVRQWl5NU5VcVdiQXlHbTdQQ1R0by80ZnFSQzBOaW1MSFVQUUZmT3RNalVs?=
 =?utf-8?B?eE0wbzVaYXJyYnZUYWpPeVp4TS9LUEEvUzhrd1BJU1lWVzBPdVVvaE1xZEU1?=
 =?utf-8?B?dzJ0ejNIRG5pM3Zzay9zaE5pV0V3OTh1a25mb0hUU2hhUllhQSt1M2dJWmNU?=
 =?utf-8?B?RWtYSHdYYjg0RXRzSUtoRGhEd055RkozaGkwQkY5UkNNUTZLUkVKWXZHL1k2?=
 =?utf-8?B?R1JUWWZ1eWQ1MWhjZE9BdWdVOERnYk5iZ0U5TE9STlZ3ejZFQUROREJvTksr?=
 =?utf-8?B?emNRSEM3TmJsTkJkblYwalo1bVdBUzhWb3lkZ0dYUG12cmFhYzM1Y1FRSFAz?=
 =?utf-8?B?OUVkUmtpOVR3L05BQzIvN252eGxCaWNNVGFIdGRyTnBJclNaSDJMNzlUS2gy?=
 =?utf-8?B?cmgwQ0VsMldtMGhZUjl6N0ZQZEhqL2RlZmNOMXR0dWdqbTlOb2l5WTFKZ2lG?=
 =?utf-8?B?cWFzQVcyYmRUbmd6eWZTSks2SGlaYS81UFliVzZUTUloNm8rWk9QK0hPSmFD?=
 =?utf-8?B?dTZQRXpUUmZVZENMY29VMm83NWk2b3VxQnZBa0ptKzRkMjRZWlR2WWRWK2du?=
 =?utf-8?B?QXdmM2ozeUYzU2h1Ui83R1NmRWo3Ty9aalFDaFpJaytyMFNvRndyeWxXWWtP?=
 =?utf-8?B?SEd1Y3NybUtoOXFSaG12SW9qT2J0N2lHT210ZXlVS214L0d5TnVaUVZzUkRN?=
 =?utf-8?B?RTJUNksxcU5RME1RN3lGN3hOTk1hellxWEI0RkdPVElRZFF2UEVpYU5uQURC?=
 =?utf-8?B?cVU2NEVKUkhLZmRYVmNUMHdRNWw2NTdWSzkyckV4SE9iNG9qSjMwV3R6OFZt?=
 =?utf-8?B?aWNYeUVCSi9sTUxNQmRlUjZKS0VGS1Zob2VGYjVSTTc4cVVNdXRPUEh4UDk1?=
 =?utf-8?B?djBRZllCR1pReUlZcUNFSFFyK0ZrbDN5dGtIbnp5dFB6ZDdLQ1pzMnRiZmxr?=
 =?utf-8?B?RkdobDVUTlhtVU9FL1gvd3VHYVNTQm9pQ2NUdDFUaHcvTVd2RHhUNU5JZFZu?=
 =?utf-8?B?eFg5MlVTUXVJbitYZUZvem9ndC9mYis5aHpDa3NOMnVQMnk1Q1RlVjNOd1JV?=
 =?utf-8?B?SE5uTVBtdmNUMlV3U3BmWERZdTBVTjVWMHQ2Y0tqZS9xMVdKeUdXNkJ5c01v?=
 =?utf-8?B?a1RxMVhLUGR1WmhQa1N2UDU1a0J1OUE5eGR6U2daWTJHSVFCTm5nTUlKaDFL?=
 =?utf-8?B?cWU1dHhCV01VcS9UalNrUW5mZ1JBQm5FL24vMFgzdTNsZEFaRjRaRnpHN1h2?=
 =?utf-8?B?YTB2RlErdFJEcFVzQUpuSGpWK0VwREN5aEVPaE5PYmRRb3lwekJRejNIc0RW?=
 =?utf-8?B?bUxSckVLSXgwaWZFSXFNcG5vZ2pQMS9pOStqZ0xnQjR2VUJHR05CaUVNVGhP?=
 =?utf-8?B?bERoK0NmMzVHYnE2cmlpRmk3akJaYTgrL21jZHA5MGtXWC92RWJkSGQrOGs2?=
 =?utf-8?B?VCt2VHZiTEU4clBZejR1Q1p3aWx1ZSthSDJPcC9tYnA0OUtMNXFiNmtQdWtP?=
 =?utf-8?B?c2xGSmp6YUhvWDVXMGQvMFNZejczTFhzcHBGUEYzOFBCaDgrZG81QnFNTW45?=
 =?utf-8?B?Y1kwUFV2aERZQ1FLWDl1VWwvZzhiMGRwZDRBUzhXVEd2clFpSCszdTlTTkky?=
 =?utf-8?B?NER6NnNLU0hLalQvVDRlcEtzbjFXTVpmbWErL2dLRXVkYWcxMU01T3dRejFJ?=
 =?utf-8?B?ZlluNm1LYUNUU1BqbzdDMksrYThqV1RCZUYvcU43RVVWbTRGZzVFTWg2ZEln?=
 =?utf-8?B?RElqekgvaDhwRS94aHFKNjBjWGdCQVdPMmJDTGU4VElUUXYvenVCbnUwakF0?=
 =?utf-8?B?TWVVMk8rcytzclV3bXhKYk9ENS9yNUJ6RUYzejZ4ZVBqZXQ5TlJ4QXQyZ0Mv?=
 =?utf-8?B?VXNTZnRDOTc3UVFrdVh5dUJiZGtlSWlDUk4vSExFcUQ1ZkRHZlVualJMZHhQ?=
 =?utf-8?B?c1dFZDlHdWNrRkxQY0JiN0hQaGVHOUJCcFBPQWQ5NWJVV21aVnFISkxQMUtE?=
 =?utf-8?B?VmY1VTVzeGx0emorNWR2QmErT2VYN1VqVy8ybC9oMmRJbWM3c2gzbCtyVzhj?=
 =?utf-8?B?WjZZYWpRK0RvaFRoQ3NTZWV1RlNUYk01bW1mS08xZVg4aGVzRHBLS2RJbXNW?=
 =?utf-8?Q?aEPS5Z1VBPS5sIkg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b651d-4447-4178-30f4-08da1e705d86
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:41:58.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTv0rIBRS7Thgp5irCw7ADaMCs8m0Z4kVVDloZ5sUIdLHzscBgObphMi5lx1o0G5aqHquynAtgB3OAdnjgsz7F5PbqFW5Hfny20xvm2usxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/22 07:47, Tom Rix wrote:
>
> On 3/23/22 4:33 PM, Russ Weight wrote:
>> Add the fw_state_is_done() function and exit early from
>> firmware_loading_store() if the state is already "done". This is being done
>> in preparation for supporting persistent sysfs nodes to allow userspace to
>> upload firmware to a device, potentially reusing the sysfs loading and data
>> files multiple times.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v1:
>>    - No change from RFC patch
>> ---
>>   drivers/base/firmware_loader/fallback.c | 2 +-
>>   drivers/base/firmware_loader/firmware.h | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index 4afb0e9312c0..d82e055a4297 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -250,7 +250,7 @@ static ssize_t firmware_loading_store(struct device *dev,
>>         mutex_lock(&fw_lock);
>>       fw_priv = fw_sysfs->fw_priv;
>> -    if (fw_state_is_aborted(fw_priv))
>> +    if (fw_state_is_aborted(fw_priv) || fw_state_is_done(fw_priv))
>>           goto out;
>>         switch (loading) {
>> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
>> index 2889f446ad41..58768d16f8df 100644
>> --- a/drivers/base/firmware_loader/firmware.h
>> +++ b/drivers/base/firmware_loader/firmware.h
>> @@ -149,6 +149,11 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
>>       __fw_state_set(fw_priv, FW_STATUS_DONE);
>>   }
>>   +static inline bool fw_state_is_done(struct fw_priv *fw_priv)
>> +{
>> +    return __fw_state_check(fw_priv, FW_STATUS_DONE);
>
> This looks like the fw_sysfs_done() in fallback.c
>
> IMO this one and similar wrappers should move to firmware.h and use the *_is_* naming.

Thanks for catching that Tom. Yes, the new fw_state_is_done() function is exactly
the same as fw_sysfs_done(). I'll follow your suggestion and move fw_sysfs_done()
and fw_sysfs_loading() to firmware.h as fw_state_is_done() and fw_state_is_loading().

- Russ
>
> Tom
>
>> +}
>> +
>>   int assign_fw(struct firmware *fw, struct device *device);
>>     #ifdef CONFIG_FW_LOADER
>

