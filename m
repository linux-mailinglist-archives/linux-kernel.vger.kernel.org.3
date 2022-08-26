Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A595A2CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344157AbiHZQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbiHZQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:57:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B104BA152;
        Fri, 26 Aug 2022 09:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXuos1Ek8MAER+dFoN6VSTgD8YFUlevLbK1NOeemO5AgHabnjkcZjGo6MBK8rjt/MimidI81CPvDtq44KSdqFH9gE+szjCRcBejr2BhMqkBbUaOFSUdR/u1zLojjgjqvu13SqJXsyEqFpVULDiu3f76dAm9tWI7zLkCyo3H0RbnorRM54g3XQTKEfNdvBv52SOkQnuDRCa2vf4Ta4fWqXy5cnRViRQllehT7xus34nPIg/CmhuOghV49uWtFji9FmeNs5wn5LhnjHNXecA6kFqxzKK6QgWItb1szr6oz61WP7PhQlM04u+HoOLm/5NdbX6TGLZrqXufHXb/Qm+Ytrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOk9ILr5u7EPhTZzrgXaAFvskhr05YV3Ebjy8RZqpvU=;
 b=RmP+NRG8yuziaco4mg7ZYWXVCe3OuJuSdC11wGItgVI+coO/Fax6vrr036mO+m1q6Pn0nNRxeVDJEfOLWbK7P67RQZAG73zViSUilzITzW3Cx5STr7EAumtfcKP61kurwCXrykptR+kpz7wRuMkYmZvHUP8KlomJPB2me607wHVdLfd4f1bCKOmmih/qCasPbYvLHIFsYJbgC5+cc3folsDVHhtroSjLNuLLFFoNMWGEeyANN18IgNPAzvQuG97RSWLm/uaO7fm2uerJRjjVR0nCh1x/X5giehkSUjVCxkEIHuLhwky2ctSm+kuEAqH6mCKdMYYClRMosfHFYngZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOk9ILr5u7EPhTZzrgXaAFvskhr05YV3Ebjy8RZqpvU=;
 b=X2tQX97+Xf8iUJoe2IA1Z4ZHHXn9CYGjwHelXBtVXuRJ1e2kmAHwq2UXpdbEiKuYdZGXZv8vXsbLxMNm5cMyLfE1YT8/DArImycPsWt08xviNUOIZpSYPAGuifgGRuvcSkAzKZAWpbZVsPHWtdyiZ2ugEsWI0OFpKk5gYMRD1r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 16:57:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 16:57:30 +0000
Message-ID: <776c8bcf-8a17-58df-7f7b-e8c2ab422a25@amd.com>
Date:   Fri, 26 Aug 2022 11:57:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 07/10] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
 <c5777707-746e-edab-2ce2-3405ff55be56@intel.com>
 <3a306901-4e3c-f11a-f947-9afaa4431b36@amd.com>
 <7cabdefc-7624-84ab-4914-396e94a3e683@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7cabdefc-7624-84ab-4914-396e94a3e683@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0374.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408e7f9b-ff21-4411-8c24-08da87841004
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVD0jAJUi0SOG7NLrTWlSkSiytvuELEIiPD60cI9AHnzk6cwKZPZ9EZpWSEDihtBKquMst6WNKMS1M6ZPyT5EDoLduf3DHB3Y12QyAAedLzw+cEvVPzZ2TBIFWPdkCMy+CxELym/74UHbciAEm9kDAiVEByL12yYLoviU1I7NMU9D3Jzx5zIB06F1PxrTBmrzroHLA6nds44qYnR0KHbTzCE8AB33urESjYznUmt5Rckfy8xbRqXJaPFVuDNAwWEJRO4y12NyDQ9TsLfM4CTc7xXC/LZMrEzO+UWVTrGXLI6MLGu1fzy4s9kH/Ugo2tg6hyvakCJdGxgKV8wSsx1VfFgtqNKA3GCpaIkClNfsOpgK0dnoK/JGwsrj8ti/Oa4n2xzhIQT+s+jycSgwG3WrHcBqwpN07E2t7iOXvT0Ujmb4+ICCfgFZ/tT6+PWtSY1s/02leFQdKmoQHJ9fvFnQLDMK9HPDIsMPktLY5+Q39BhmNiKXz16FLkd2Pvn/tbrWbIS6MuIKuiC4Wgw1aOwMW97XvEaRL5Y8QJnIC+A1U36qY9cLLVTP+q6sYWn3eo2jxwXht11xQRZ72dU+yHX6K4mA3hWOMIVvB6UqgYp5DTHW238WvT/itbM7KHyHzeRszHsyLpoKUWdw2YFndGYX+lBlx1x8B0lkxJampCaAoaHxv5EsZCZ0IBnTbxLouROZs1soVAg/y9XAOwdap2lYjkA69WKVWv4HbgUB2fcxCEVN3e02rapnkhtARd8EWTKRF4eKuqxjRXxcgrWilKLkcIvydLqeALi7gZtPUYwC5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8676002)(4326008)(66946007)(66556008)(66476007)(41300700001)(38100700002)(6666004)(53546011)(6506007)(478600001)(6486002)(186003)(2616005)(83380400001)(8936002)(26005)(86362001)(6512007)(36756003)(316002)(31696002)(7416002)(31686004)(5660300002)(3450700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEo2K0RybUlaRFk0RlFmRDNCMXgxTUhpanM1S1VTUVVwb3REQ1RyR1E3RXJM?=
 =?utf-8?B?RitJR1dpd05SbjcrTDdhNEFtbjhyVjg5T2UyTVNvb2E5dHU2Zmw2NGdIemZt?=
 =?utf-8?B?V1pTcGdiSEtmZm5TN3ZNakJGVE05aTBNNUcybkVMWGVxaFBvVmloWGxOcHJI?=
 =?utf-8?B?R2FkQXpYVkl3ZXpMN1ozZ2N6bWp2YUFuNWIra3MzVEp2OC9PdDVaWFdzbWJW?=
 =?utf-8?B?YjNZODFxcXRKRzdqN1ZEYmlWS09xMW5VSWp0d3hXczZ1b2dwWmJhVUFJZW5h?=
 =?utf-8?B?WWJGVkROL2dNZ0VpbzFMdnFHZ0JSWFlXbmRKaGlwVFRDTTd2bFR1Q3R1RHQw?=
 =?utf-8?B?aExDRVlOVjBGT0tERlJTU3B0M3MrNUVTb0w0aGo5K0IyTzdoRjdSdXYyNSt0?=
 =?utf-8?B?QVlyTEUvL1dFYXZqOGpxcEJ1UkZrbUxtems1N0lBUEpKemRPMkpJMFIxQ0ZI?=
 =?utf-8?B?NE94YTE5RzgxN1lhQ0Fnd2QrUWFlUUlVNll5MmFFTER3dDI5QTE3OGtYeE1p?=
 =?utf-8?B?aGVNN3owT21XbEJkbmxyZVlYK0tEeWdDT1d6dm1SOFlkMTY2Qm1KYWFMMjlo?=
 =?utf-8?B?SUhScG1QRkdQdjNGYkQ1K1ZhWCsvSnVKakdMVHRka09Va2l1VnhjVHo4ZSt2?=
 =?utf-8?B?VVJmbFRpNFhGT1JiWnE2Z3pyMU5yYUtndEdTSFhLdkJEY0tLN0E1dlpQNzdD?=
 =?utf-8?B?SGwycXdCQjU5ckdQQUZ1d1NBc05aQmlHSVQyZjZCRmIzRmx3aVVicW45QXUr?=
 =?utf-8?B?enhMMVFlajY0ZXg4Wms1L1ZkMCtvZzF6Umc3U3M2N1RhUnNEcmlnNlROaEtp?=
 =?utf-8?B?eC9pZGR6a0dKa1pqNzZ5ZjRGYWEvdHlpSEVMdE04dFpJc0YyYUtGZ3djS0dY?=
 =?utf-8?B?Z2xRZHAwVys3T1ltWDNYZ1NreTFQM2pISW45VitiZHg4YmNiQnFRRVlNdWxu?=
 =?utf-8?B?NVhmbXRILzlyT2VLbFNlRFdraGN0Tjg0S0craldFV29lQVQ2cnlxQllSMHRW?=
 =?utf-8?B?Sks4ZGIya1hvVk1zZTNkME1hN3VaVnl0eGN3eGlIeHk4blhUbSsxWUJrL2Fh?=
 =?utf-8?B?b29XV0tHNWJzM010Ykw3ZW9CWUJyczI5Y1lpK09yRVcxaUdaRmJQRTdDanNG?=
 =?utf-8?B?RCtuWkdVZG9FdlRHcmxxVHJiemZ6QTNYdG1IYlZmZW04Ty92R1M0KzBud0p1?=
 =?utf-8?B?RWJiWHR6U2ZqeUJ3d1V4Zk5BYitSQkY4RUtTRXM1cUQraURQczkxYmVCTVpN?=
 =?utf-8?B?YklXSVQvS0YwSnBtc1Y1TGo0NkpjMXZJM1ludWFSM1dQNXhUL05ScDBlTGtM?=
 =?utf-8?B?WVB1cDdBbzJpWTkwUDZuNlBHTEN0TFkvYU1aV0h0cTUvem4rUzVnd0FuYVQ3?=
 =?utf-8?B?T0VNN0FmYmhGZW5vOGxYalRKMjhoMmk3cXBqaWE4eVhPa3MxVnZueGtDUllu?=
 =?utf-8?B?d3dlMnJiREQ1YTllRCtScDczSzZieHhnU2VvOHkzYndxQ0w2OGxwMlI2c1BU?=
 =?utf-8?B?SGMwR1BpbldpKzJPUy9qVE1vb0psU2FITE5yWitvNU8rb2JCVlRIcDdWOFlC?=
 =?utf-8?B?K2R5T1FRRUl6Vnhra2lCbGM4Vnd4VkEvd3B0Wmw4V0hTSUZSeXRNUVVPcWov?=
 =?utf-8?B?LzBzbHZmT0NqSUN4VUxMZXV4NGRHWWZOVVJQV242dXJ1Z2RWTWUxK0cxbDZK?=
 =?utf-8?B?QUQ5enRLZFV5KzdxVWRySWgzelhjcnNwSEY5SFlxanRDOWlIb3AxbDYwUWY0?=
 =?utf-8?B?RmkwYklPRXllRkF1Nmh2T0tHYXd6RWswNGJUSy9xWVRMVzRha01DSWYrOU5P?=
 =?utf-8?B?Vk9sTGhyNS9jT2c3SmJOM2JqeFpwNEF6aUU4TW83K1ArV1RManUyTlZVMkph?=
 =?utf-8?B?QVYzNkFzZXZiMytOdVZkKzhybGFpTE1IangzSXlnemV0OU5RYU9aQVkwWnBU?=
 =?utf-8?B?MVAyZ1lGZUFac21FcVQ1Ny9iVHB6Q1VGN011QVZrbEZlUDVYYkdRMkNzSTVm?=
 =?utf-8?B?MnlmZDcwSm1HZ2FrMkZiaUJYdjN1SjcyUWlqeWN6allNQ3h1bW5pM0FyOVQw?=
 =?utf-8?B?RktuQ2tEQzNUc3ZZK0FYbjd2NGgrUXlUQlhISTB1cXlyRUU2d09ZbVJlTkJH?=
 =?utf-8?Q?4Yww7wdDcaWKdnBvXZtBHi78e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e7f9b-ff21-4411-8c24-08da87841004
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:57:30.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhbBHPUGUKRquvBs/Ocf4LoHHbiQtXOoFuCBcMiX3CD6yhjQDo5XJKi9p7/O9Cz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/22 11:35, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/26/2022 9:07 AM, Moger, Babu wrote:
>> On 8/24/22 16:15, Reinette Chatre wrote:
>>> On 8/22/2022 6:43 AM, Babu Moger wrote:
> ...
>
>>>>  static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>>>  				struct rdt_domain *d,
>>>>  				struct rdt_resource *r, struct rdtgroup *prgrp)
>>>> @@ -2568,6 +2591,15 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>>>  		if (ret)
>>>>  			goto out_destroy;
>>>>  
>>>> +		/* Create the sysfs event configuration files */
>>>> +		if (r->mon_configurable &&
>>>> +		    (mevt->evtid == QOS_L3_MBM_TOTAL_EVENT_ID ||
>>>> +		     mevt->evtid == QOS_L3_MBM_LOCAL_EVENT_ID)) {
>>>> +			ret = mon_config_addfile(kn, mevt->config, priv.priv);
>>>> +			if (ret)
>>>> +				goto out_destroy;
>>>> +		}
>>>> +
>>> This seems complex to have event features embedded in the code in this way. Could
>>> the events not be configured during system enumeration? For example, instead
>>> of hardcoding the config like above to always set:
>>>
>>>   static struct mon_evt mbm_local_event = {
>>>   	.name		= "mbm_local_bytes",
>>>   	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
>>>  +	.config 	= "mbm_local_config",
>>>
>>>
>>> What if instead this information is dynamically set in rdt_get_mon_l3_config()? To
>>> make things simpler struct mon_evt could get a new member "configurable" and the
>>> events that actually support configuration will have this set only
>>> if system has X86_FEATURE_BMEC (struct rdt_resource->configurable then
>>> becomes unnecessary?). Being configurable thus becomes an event property, not
>>> a resource property. The "config" member introduced here could then be "config_name".
>>>
>>> I think doing so will also make this file creation simpler with a single 
>>> mon_config_addfile() (possibly with more parameters) used to add both files to
>>> avoid the code duplication introduced by mon_config_addfile() above.
>>>
>>> What do you think?
>> Yes. We could do that. Something like this.
>>
>> struct mon_evt {
>>         u32                     evtid;
>>         char                    *name;
>>
>> +      bool                     configurable;
>>
>>          char                    *config;
>>         struct list_head        list;
>> };
>>
>> Set the configurable if  the  system has X86_FEATURE_BMEC feature in
>> rdt_get_mon_l3_config.
> This would work (using bool in struct is something resctrl already do
> in many places). I also think that "config" should rather be named to
> "config_name" to make clear that it is not the actual configuration of
> the event.
Sure.
> Remember to update struct mon_evt's kerneldoc (I just noticed it is
> missing from this series).

Oh,, Will do.

Thanks

Babu


>
>> Create both files  mbm_local_bytes and  mbm_local_config in mon_addfile.
>>
>> Change the mon_addfile to pass mon_evt structure, so it have all
>> information to create both the files.
> Providing the structure to the function would make all the information
> available but I am not sure that doing so would make it easy to eliminate the
> duplicate code needed to create the other file. Giving more parameters
> to mon_addfile() is another option but it should be more clear to
> you as you write this code.
>
>> Then we can remove  rdt_resource->configurable. 
>>
>> Does that make sense?
>>
> Yes.
>
> Reinette
>
-- 
Thanks
Babu Moger

