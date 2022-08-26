Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F25A2C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbiHZQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiHZQoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E8FE0FCA;
        Fri, 26 Aug 2022 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661532214; x=1693068214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SsdRSharZy4odGMzquDkFKC5QhkP2XmJKJjz8ckRHNE=;
  b=f/c9WsL7Y60/tuXhX+j7hwT2iwkn0kqhKcIjaQpTNjbLy96WFJgdxMhG
   0PR5SSuq1S1egaL4XHMzo0Ym1cGa64NMcF9y4imQScTS5QeDtUXADZJSh
   twhEZzxd+3ROnzr4fZWKwRP3xEHYn0rwtPZ052gHqet2yj+BGzHEj+8mj
   WzR2EiJUgDUKuAdeFHz+gqQ9xgsbNFziJfmd971u3wS44KCxgU23aTw2+
   ZR+heLirQP6YRo1Cwl9IwEjLjvgrXZI7qQl7YjHuXUIIXZ7MxZ94GXSDP
   SmkK+2a91GuC5mL8A9TkxeS7J/FNoisS/MPWYH76yGFsNKlMcDCiSFEa8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="380848600"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="380848600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 09:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="587356162"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2022 09:35:08 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 09:35:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 09:35:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 09:35:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 09:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCG6+w2/QFAAN3Rbhzu/bUttaN71sMwMv5MJ1ZJorMJywTuGpoKj+dK9jaZcPyVuIo937i9XbWFFSCoug9ANlWGXXXUQlKFiz67L4Lq+Dv8GmfpJe0i3NSmnxRoXLUg2b+fAfH4DnTQgj5N9w+UB6F4EhiNr+nZ6pusC6c8EmBrW+S2088OM7t1l8L/veLzKjAwL3iHSjy+YTCUkIVrPVECc7y4XVbkdsMP9E9bHGS+GbnEC5XP5rURKu126RL1Mi8CEmyJ6x/98TAMr73qGGWhtLQ1HxyEfL3ekVzzhqdnX54BhFcmVe4ZRaNgZUs3G2Wci3kWvtTdjnZH/KclMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5uyrTVRq0wIlk7Om6wIUvnLkHWylZoGnfWNtTjRJ5w=;
 b=Kzory2VNxRAK2YIHVxk20x3v/DZnr0IYTvGDwBmqcENOiOXoOa/bGOFO+twmhDSvrpHq1Wadr0dMN1ZM5oJGlmmMFoNBKHBNNVLWsKpGMgMIDAfFVTCklMW6vVGuyMGFLQLYma8bzb6Srm+u76G8y0cHk7u/2TEFQN3gZosvsNZwlko/vEeijn+XDzCUnU8jK01CYhGJV2hlpcFRHA4BGQiCz9PbA2Rbt+UhQiuuykktWTzJ7jzUlwaA5+tdgcCJ/gwNTT/7o+rUhbcigcXVDTTFwXwsz+cjyr4uXJms2pe9caG4BfL3R9OjO/c7SrJwwoxLqNZ811c6qbbauCAGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 26 Aug
 2022 16:35:05 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 16:35:05 +0000
Message-ID: <7cabdefc-7624-84ab-4914-396e94a3e683@intel.com>
Date:   Fri, 26 Aug 2022 09:35:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 07/10] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
 <c5777707-746e-edab-2ce2-3405ff55be56@intel.com>
 <3a306901-4e3c-f11a-f947-9afaa4431b36@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3a306901-4e3c-f11a-f947-9afaa4431b36@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480cb4d0-b16a-4390-7726-08da8780ee37
X-MS-TrafficTypeDiagnostic: BY5PR11MB3975:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6nMdDP8eLDzETVeD1EUMrKKaFDQkqjwJriUxgPeaTWOQyQMc1Qyu3EoOLrJbkLC2HugTG5QqvgySR+X1yOlipJ1UvjY2CCFHy/aNbtgbnlXSX84wwcOZX9i/rGulMzqn/DrlMxfB75JP9N04Zf5dShu5QIXgaxye5U2I2dpyKzGYn3sOnSlweeY2gD3kXfY/jg2gVErGYiW+CfxQHdOZGP1lEdECTRANwPl9YLBoSfvcy1CXnja+8Xsq3VsP9Fw8325t6XRy5a5MsTwi2GId9Old4SOgD5oQl4virUpzwCxO3DqS/DvYFIIFIhTZFsTqIAQOcaj8dxXATeDozA4ElJZjMCKWs/ucNXPtUyd6hBMgFBfmkFKJxTxbS5Sqkyh+sN45YIUQ7SgSiHueN1WGogEUY9SSzPf+QWLvviz1jb5de7Wv1Ow20R0yDhfUQVSngWtxI87SsElvaO70uNE7MZgzUVGkPgjPksq9YW5XVhfLiB217drNZPWYiuKoyYaN+/YPNV5nsmavWd9dCPbB2h3z6ZHhr6ql76DpI+pP8tbSIR9r5AIMpunyAH6l6T4cS2QU3UqnElUF4Zk/9yqMVFqfyu7yx4ucDf25x+XSotJHL1XtK5LvU5dgqZ9C4vzK3EQ7gOogUduSHAGZPt/WtDKmyULSQ86SMjK0gR50WljkxKeR2lEq8CfMaT0/N9wdGEqxZ0LUrinrCqKNz00gMAb/GLlUV/gBdDqyj2fI/x8kqo8+8/Rr9CbcfSIrazVEfazkF2AobaMY2+4V9QH9A01y4tOKAf0QOndAFM7wns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39860400002)(396003)(136003)(8676002)(66476007)(4326008)(316002)(8936002)(66556008)(66946007)(5660300002)(7416002)(2906002)(44832011)(38100700002)(86362001)(6666004)(31696002)(82960400001)(36756003)(478600001)(41300700001)(53546011)(6512007)(6486002)(83380400001)(26005)(31686004)(186003)(2616005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9mVnBtQ1UyVFpqcWNxWTUvd2NodXVOS0I0azdySkIwbjJBS3pGZUNFSU9M?=
 =?utf-8?B?RVRBN0h0ZFBGSllLdXZZcVltS0VSYUJ5U3pwSkVpdGhra29PK3pCK3ZtcjR5?=
 =?utf-8?B?QkRtV2RPd25XRTlsQzF6YU1zSElNSFJ3UjVUWDByZHBMdEpBdHNDdTdPdkFD?=
 =?utf-8?B?OWVrZHJlS0c2ZjZuRnNRanNTYXZ0Vy9GQUVQbWw3WnRicnl0NmJ4eFlPZHIz?=
 =?utf-8?B?Y0xqbDI4eXVoaUErNmxaRE96RzZ6UUNFZVJPUDVWNE4rWUcxNi9uSGtUeUYz?=
 =?utf-8?B?TU5iRGhFYmZLRjdGZ0NsaVBJdnk5dTFEM2RpTXQ0ellsQWZCU1VqazI2bnhC?=
 =?utf-8?B?ejBEUXJoT1UxSVdiMFEzcFp2aDVmUUhDM2ZISDIwM3lRampwWE1FQ0JtcXk5?=
 =?utf-8?B?V280UTRJSm9PMWx4a0hxeUFMaThiaDVEQXl4VjV5emQvbzRnRkdNcG9aeEdQ?=
 =?utf-8?B?UnluK2MvYkZKWWZIQlhRTTgzTzR2MU5oMjJ4bThhZlBqSDJlMTExekpZVEUx?=
 =?utf-8?B?SEdKNEdMY3BGSmQ3STdQTUg5bTV0L3l4M0o1d2kvQUpYWXB0cjUwT3JwOTJo?=
 =?utf-8?B?a2VyYXBVbDVpcE81V2tmVEl5d3l1TUdTc3ZBR2tUMjljejdjODBCUU9lKy84?=
 =?utf-8?B?a2RldUJEQ3ZuMkxiR0h4NHZBUGUzVk5MaHZVcFE1UkZZSFV1eEp4Y24wM2F1?=
 =?utf-8?B?aWtMb1IrdndSQzFmNFF3NDVLY200UHN5OERrNG9Qbm1OcUJlZGhNT2xrYU81?=
 =?utf-8?B?NytXTTlBWmx6N1VVZDNJTzRMUjJoeUF6b0xIS3ZqMlhuOHNXNjY3akNEc0xB?=
 =?utf-8?B?S0JWZXlVV2NJVmM0eFpMaGsrUDhBNkZjYW55TzF6aWl2eFVXSmNNUENUUElL?=
 =?utf-8?B?R3FoUXc1WHhaQk53MWExVFNoaGViSFQrV1E5Tkh1UndxL25zbzREZ3E3VW4w?=
 =?utf-8?B?OFVZQVBjSzl3OHFJUnZVZ3dEckFHNWR6cXFXOTVzSEJSdlU3Z1o0K1owS1J3?=
 =?utf-8?B?V3dxSmdSZEtrRTBzbXRQMUtvMkF5TVhCR1YyWllPaWkvZS9Wbis1Y2lRaEx6?=
 =?utf-8?B?UjBaMFZxZDdnYjA2NHJraStpUWQxd0xoNCtMSkNBczhtRVoyMDFiVVdOMkdR?=
 =?utf-8?B?elhUL2FFZmFHYnNPeGV4dFlRZU1JUmxkYk5yWEhuRXJxekpETDBQMy96aUxV?=
 =?utf-8?B?L1BrbXBFSnA2S0YrNUxuTTJ3SDJ2bTJjUUxWRElTV2JFYnJUVWNtenJUR0Jx?=
 =?utf-8?B?blgwNGd4RXdCMW5OSVpTTVhrN1QzSU1lT2t6aXR1cHVYQjhBT042Qkd1bENt?=
 =?utf-8?B?S1BLNitmZ3V2V3pLSkpFNTRhdWhqTTFpWXZUWjBVRjYzZ1dyV2hOUW42RG53?=
 =?utf-8?B?S2Y2YVJ2clZBRU1EVUcrcmpERE9MNktheWRxYTc4a3E3SkY0ZGNHNys5c1JD?=
 =?utf-8?B?bkh4NktzOGJtRTZ1WjBMbTQvSGhaVFZrRnJXWXZYY0p0L0R5ZjlsYlZUd1c1?=
 =?utf-8?B?V1k4bncrdWRlb0VYWEtRVFdCZGZJVURoSmxWUmdwQmxRbElvSXZWRnpVSURu?=
 =?utf-8?B?TENQYkkwbTRqKzc1MHlGbzRGNEFLTytaSDljZjA2emJuQzNCc2poY0R6M29o?=
 =?utf-8?B?Yk1KOTlhV1E5NW41c0h5azdGUFZJdHQyY0RBYzRlWEVINFRxSXdwdFQxeFY1?=
 =?utf-8?B?SHNoZitCa3BGY0J4NzZNbUs2QUFqdjRxVTZTRU9wOGc1SUljSnF5Nno4NGt4?=
 =?utf-8?B?UENPalZBSlluYUhEV1psZmhKdHMydThValowWThEQ1JyTE1QTVVCNmo2N0hl?=
 =?utf-8?B?eHJJRmYrLzFhMHAvVG9GNnZwVU1lUWZseFI5Z1dKY2U2Vzl4ZHRVZU5yTVlW?=
 =?utf-8?B?dmU1TUltTlRGLzBjV0pKTWJjdS9tSEF0VEp2cFJPSDZVS0FvSzlGakNkRUdC?=
 =?utf-8?B?S3lpdlh2L3dCdTVibC85NFV1YVZzejJSWGZrMStJUEM3dnVyKzVzbEJvb1FE?=
 =?utf-8?B?THRFaHk5N2I4a2ppdVNsckF1eWlZVEhxenpYSWI1VXJNMFF2L0pFdWxObktu?=
 =?utf-8?B?c1IvaWhtbUhER3FUeU1xMmFCN1RneldVUWZvc3oxQ3Fyb2ZUZWF1Y0s2aTBy?=
 =?utf-8?B?WnFEQW96cFdsZlJiUGZNVmFTVkovVGl2UGFWM1o0bm1pUXFXRG85ekp3NDFC?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 480cb4d0-b16a-4390-7726-08da8780ee37
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:35:05.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPwL4Klc5YuoxkXbIOkpsutQEMX0GaiASoCMO0YjX1CUaTIFicjg9/PpD4iF/yYo/xlVX1H1rfyYJ68So+wGQ6cVZJ7PC5YMLMKQ6dVMuB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
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

Hi Babu,

On 8/26/2022 9:07 AM, Moger, Babu wrote:
> On 8/24/22 16:15, Reinette Chatre wrote:
>> On 8/22/2022 6:43 AM, Babu Moger wrote:

...

>>>  static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>>  				struct rdt_domain *d,
>>>  				struct rdt_resource *r, struct rdtgroup *prgrp)
>>> @@ -2568,6 +2591,15 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>>  		if (ret)
>>>  			goto out_destroy;
>>>  
>>> +		/* Create the sysfs event configuration files */
>>> +		if (r->mon_configurable &&
>>> +		    (mevt->evtid == QOS_L3_MBM_TOTAL_EVENT_ID ||
>>> +		     mevt->evtid == QOS_L3_MBM_LOCAL_EVENT_ID)) {
>>> +			ret = mon_config_addfile(kn, mevt->config, priv.priv);
>>> +			if (ret)
>>> +				goto out_destroy;
>>> +		}
>>> +
>> This seems complex to have event features embedded in the code in this way. Could
>> the events not be configured during system enumeration? For example, instead
>> of hardcoding the config like above to always set:
>>
>>   static struct mon_evt mbm_local_event = {
>>   	.name		= "mbm_local_bytes",
>>   	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
>>  +	.config 	= "mbm_local_config",
>>
>>
>> What if instead this information is dynamically set in rdt_get_mon_l3_config()? To
>> make things simpler struct mon_evt could get a new member "configurable" and the
>> events that actually support configuration will have this set only
>> if system has X86_FEATURE_BMEC (struct rdt_resource->configurable then
>> becomes unnecessary?). Being configurable thus becomes an event property, not
>> a resource property. The "config" member introduced here could then be "config_name".
>>
>> I think doing so will also make this file creation simpler with a single 
>> mon_config_addfile() (possibly with more parameters) used to add both files to
>> avoid the code duplication introduced by mon_config_addfile() above.
>>
>> What do you think?
> 
> Yes. We could do that. Something like this.
> 
> struct mon_evt {
>         u32                     evtid;
>         char                    *name;
> 
> +      bool                     configurable;
> 
>          char                    *config;
>         struct list_head        list;
> };
> 
> Set the configurable if  the  system has X86_FEATURE_BMEC feature in
> rdt_get_mon_l3_config.

This would work (using bool in struct is something resctrl already do
in many places). I also think that "config" should rather be named to
"config_name" to make clear that it is not the actual configuration of
the event.
Remember to update struct mon_evt's kerneldoc (I just noticed it is
missing from this series).

> 
> Create both files  mbm_local_bytes and  mbm_local_config in mon_addfile.
> 
> Change the mon_addfile to pass mon_evt structure, so it have all
> information to create both the files.

Providing the structure to the function would make all the information
available but I am not sure that doing so would make it easy to eliminate the
duplicate code needed to create the other file. Giving more parameters
to mon_addfile() is another option but it should be more clear to
you as you write this code.

> 
> Then we can remove  rdt_resource->configurable. 
> 
> Does that make sense?
> 

Yes.

Reinette

