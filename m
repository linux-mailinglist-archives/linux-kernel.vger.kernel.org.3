Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8853E9C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiFFMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiFFMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:10:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8ED245A8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaXjs3zDDA90WSrHC+mrWB+u4Jyd1uCT1+PUOAmZPxy/YzojYxA1Sjl6Bo3jSnLrgJZDF+0X4LeZObqxhxr9OR2/4D1PSaIJaLckUBtdQRFtrNWxufzfsOy5dBlX15m2LSbDAAnHrcH+3HWzHmmd71s4uc7Fw4Dxx+XR5R3R5R17udFzL0QqYbwlFb/Jh92eRzFvxZ0/JBnkQkOMvIGOZsUlThxTz9CknQ7Ac+Y452hg2g0abtlRMeM8T/T1DTGApoYzfNzju01T4tklu1/E5gsE4Vp5u0MxC6WeqnsRt145sMME6LxssB1OyKKLVe8nep90ZYY0kSdfTyYPXyWC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVQO3rtktdKzWbKTUZnVmP93MIwQ2gdQCMb14CNFrL8=;
 b=hHFyZtKp4CdVUdn0LFC0v0El7kWco3T4qUtem2qGIggyIre/xsWh6b/A/92L2MK6fG2+pzRKQZR9l5Og3x5H2RtoKvdFjxbxlNVjxXN0zWI/SgY1H4Frxw1hmSZz68/f7sZwKY5ZWGHRU8IT03O0KkIUzJarfZR0ixc9chLPMJjIRFGYxb1MFWtE5iu5cRKT0/DzIyehm9vuL1imdhdQNWTJVB9hk7v3wyrx7PHELFZyVXSUOkG3ZNtl0PcYHPw4Gzlbi2Ne49kBmEVCmX2JBBzUOWDDmvsz0l0nqpcnsmaZFMcK5fcJnkuZoP4mv+HjrNaBxS461uRAmKMkKJREYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVQO3rtktdKzWbKTUZnVmP93MIwQ2gdQCMb14CNFrL8=;
 b=3nvO4giOnX3kJpugf8twc2eaIm4fjTkGRDukNDhoUf46UMBydF4IisG8JXMI+vFOEfvLVWLkgLvyVQQe4MhxguFXWxUnwXRbHz1ZJFlewntvIImA+kqOp0De3O8zPUJR4XNholehplRAX5ImohgzJrzVyL5bd7TmQnvWtiKPqQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MWHPR12MB1934.namprd12.prod.outlook.com (2603:10b6:300:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 12:10:15 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd%5]) with mapi id 15.20.5314.015; Mon, 6 Jun 2022
 12:10:15 +0000
Message-ID: <eaf22a62-73c7-d96b-fcd8-4437eb3d8559@amd.com>
Date:   Mon, 6 Jun 2022 17:39:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
 <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
 <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
 <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
 <a844c8c9-e1e1-2ccb-d58c-a5a608afabc0@linux.ibm.com>
 <87fski80sx.fsf@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <87fski80sx.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb47771-ebd4-412a-ebba-08da47b583a9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1934:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1934E759D556B82D11007A6FB0A29@MWHPR12MB1934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZETCl4g/N7tmyarj1WLcYAg8EwEw8cVji5q+w66y2orgg8za4R9Ylxx/v5f3v4z7BXeIGPAXMtsKxL8XHWWl8vc77Ma2buZS70ynZd9b7GGwaW8bFAO8H+rB/HalBAM3PGEldBNZOteId6K7LTgEpT5catRwdn9eK0Cpa1wIghm4oar2WOzuxmCp773SrM00rOeV/my6v1Ndj3ZGyXVvQZqbTu4WVpBVe0Y30cZNECsNrwYaZBw/ZfKQugipnqitHccDuQd5ORjM8uQXdMx1S+4KgTYRtsZTlkJlphyfYOxD3uJcN2I2FebpCkJFmRBtM1owu8wrobKdwa5ezCI5IXFbaygdKE3bC3FC/DIAXZE6MoCDLCxvNyDgjpWqJrqoLZNO3JOO0hiwkOotGqzwbl+ZtiBh2YCBsUfFmqTbIkbyiE/jJ2fsLydWFaL43khTp+3zavxR4vDFe94KfSecFt8LHwmKMbEKOY47PqRuwQo7MszZ5ETQhmgZEPcxx/jJCAdBrbcPJzLGg+ctqcvl3kr+bnxbE7MgSCUKm91xNhF6LENzFDTsGfE2wHRZ5tBqhNH50pQJphV0MmS2eduEcOAZSoSP77pwNytszXOCn/+cMDT+JxX2+cd+f9bgCa9yh2/cfj3Gtp76rPoyxYmTpMneoSkDde/W7xh+Zb0KDUPXeQv6RplMQVwfJUgww87+cHnDs8QFcPfau7BG3KEbaJYVHouA9ds8dy5T9GpPq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6666004)(66946007)(36756003)(31686004)(53546011)(8936002)(66556008)(4326008)(8676002)(83380400001)(26005)(508600001)(54906003)(38100700002)(6512007)(316002)(6486002)(7416002)(31696002)(186003)(2906002)(6506007)(2616005)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWdTV2I0RWxKSVM4azBoY0lTZmIyUTV4ak1wVFVTYm5KekUwZm1MeHYydVBo?=
 =?utf-8?B?cVBpUWJVTUZzcFdkVVM0U0dIL05tdnFneC9Sb1ZreFlJYWdCa3lmUDQ4ZHY5?=
 =?utf-8?B?d2RJNm1wT1NJMEJDMURiek5GY2NYTGRSVndhUTZnTWRHQkp2NEg3blg2THZv?=
 =?utf-8?B?V1UrcXB4cDd5S0Vpd2R0TWp3a0kzc3poSEZka1lhT2ZFRVo4ZzkrWFdnQm9Y?=
 =?utf-8?B?ZFNmMHg2MkRFNXlvcnpOZFovWU9LQ0lMdExlZEdJUFo1NnVITFlYWnBYSnht?=
 =?utf-8?B?L2Z4bktITE1vOXpOWFZrbEcxUDdGUEd2K29qajBhNjZFRzNpTDM3MlBrSXFJ?=
 =?utf-8?B?eUErOE0rcTNGOGhWOTJMcDBSVzRvSnJ2UFg5TU4rVlNyZVpkTE01TmdCZ1FE?=
 =?utf-8?B?VHMycnZ0eHFJSE9tTllGV2FMdnVBSFNzRzFGN0hScHFOMklFaTcrRjJneHE4?=
 =?utf-8?B?eVpLdzB4NDNnK1VMN3RhYk5LdFh3WEZ5ZGhlbFFZOWlLUkxnOTNPVFB2YW5E?=
 =?utf-8?B?UlFEMXJtRVBYMGYzWTkyV1M1M2YwUm1rSzdKL0JRVy9BeXI1dWQ2WUZsbFhH?=
 =?utf-8?B?S2ZvSTM4MzU5eTZMamtMdE9wMFhLMVdyQ2dJam9YMG9HZjBhcjNWWXlDSmQz?=
 =?utf-8?B?aVppaU9MUmQzZGN6SHVkL29zOTl5bVBVS1lhWFZoNE50ZnVmZ3FVRnk5R2Vm?=
 =?utf-8?B?QndVdlVhYTloVUpxdU9DanhFZUxBZWJXelR2Y2d3cFM2UDhwQ0kxbm5oSWNw?=
 =?utf-8?B?eTdGczh3cVJNRzJuckhyQTdWUmFjeUdTSnkxZWhwdG1HZmJvUVIwcjAzLzFE?=
 =?utf-8?B?RURnTmNsVk5BY3JRT3BxM2kveXFUNVNLeTZDOXoxclpYRXd5RDMxZmVEeFBK?=
 =?utf-8?B?SG56dm9WakExMDJEaXBjWWdVcVFBTDMzZENIVUxUa25iQzFMc3lQZ1Y2U0tG?=
 =?utf-8?B?dU85czlFZGhETVRyTXNvRDRiUXY5amxFZC9IUTQvWnRMZ0RwMHk3YW00aytp?=
 =?utf-8?B?QlUxSEdXZ3RUd0k5VHhCT0diQzZ1QmhyY0taMzMvYmNlbWJ4ekxnbUk1QjFN?=
 =?utf-8?B?K0g5ZldJRXd3S0lGY1pmdGlmSldvWkRVQmV1cit4amdSTXljZjlNcW9kMGkw?=
 =?utf-8?B?a1NERWhjcXBjOTF2LzFkSERhNmNzTENyM2xpUmdTUFNTVU5wOFA3M1RNa2NW?=
 =?utf-8?B?RVJEVEE5Vk9na3U4V0QwL2lMdXYya1c3cTRIZFIxOGJLNE1GcnpaeXZTcmRj?=
 =?utf-8?B?RDZ1S1hiYk45dVdlQ0ltbVpBZXdCTzFiOU0yKzZ3UUUyRzR2aHB3UjQ2S3pP?=
 =?utf-8?B?WTI3QVpmOHdCZW9EL1doRnpPeTk1UFd1MDBzbEZsVXcvOUliVmNTdDNBaHN0?=
 =?utf-8?B?Wk1DNGFlR0IwbGY1T0J6MjhFdHhPaVNObnMwK1V2aFN1OU82cFZ1aHd3VTNN?=
 =?utf-8?B?d1hQeVlBams1NElHMEtVMnNDbTdOM3NiVk5xbEU1ODJ5dXZLZGFGbFZEUHl2?=
 =?utf-8?B?ZnozQWJWQklYTFBuY0Y4NXQwSmRyK3dhT25zSmxGUlNCZWFxY1BUMm00MWxV?=
 =?utf-8?B?aVJNRkN5dHJoamNIUXdTclBvM0s2cVRGUWt5ckoxMnczblc0bmlpYzFGbFhh?=
 =?utf-8?B?M3hyQmZScmJlcUdYVkJVU1FRUjZ0M2VkUkFxUitveGtlSVc5bytTbEMvUU55?=
 =?utf-8?B?RkZ6dWpKRE5zM2Q4NVN3ZjRnK1ozVnNDcXFSNzN5SGFQRVllVlFqQzhOS25O?=
 =?utf-8?B?VFdDcjdWN3dnTWdSbFRLTEczRXEraCs5SFNIWE9yZ3BRTHZISTFPUUJScFBY?=
 =?utf-8?B?OHBCOHVRanlvUDBmWTdKN1lOKzdTRktKQ25iSlc1VjVnN05rRk9LU3VyZ0hV?=
 =?utf-8?B?Q2xEWWlyT0lFa0Y0aG9oR0NCak0wbEJkZEdBOFhVcHBPbzNiREpoZVhVTVNQ?=
 =?utf-8?B?VU0zcStWUE1jbHNoaTVuZ3NkR3lkSTkxTWtKbkMvZ2pGTmRUMlZGYzExcXlj?=
 =?utf-8?B?L0laZlNlZmhkR1M2NkRVNE9KTzE4Q3M1MG5uYWptWEduaHo0ZVJOa3VQeE1G?=
 =?utf-8?B?d2kxY2pqUCtRRFkrYzZKNWh1SC95aVVlVkUvRHlBWThpL3oyS2dPdXYzV2FB?=
 =?utf-8?B?bGZoWTBpSFF2dWFsSS9oL0ViZ2FveGY0T0VOUGFsZWFQLzFxOWRJbE9DZ25T?=
 =?utf-8?B?OVUrK0FZL2c4VEx3Y3ZOSG5TVHZ2MTJub0VldndFVmdJVlp1eXRFUG1wcllr?=
 =?utf-8?B?aVE0YmpmVjhKbmVoTnM5QXNFMkxvTDlkVklxQi8wN0hXRUZGd2JqWnJpdEVY?=
 =?utf-8?B?OTM2NS9vZEJRM25YR1BvVTZWUWRjUlJNWGJvc2xHOStENmY5aGRjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb47771-ebd4-412a-ebba-08da47b583a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:10:15.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCWaJDdoUePOUcktbuxfyNdFdex56ReyhO/cVIJxE9Xkc9EAnoWerpcjb8ZomGTiS5CUhWOck1mpS6AuD24npg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1934
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2022 5:24 PM, Aneesh Kumar K.V wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>
> Can you try this change?
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7a11c387fbbc..905609260dda 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -94,6 +94,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		goto err_reg_mgid;
>  	data->mgid = rc;
>  
> +	/*
> +	 * This get called before the node is brought online. That
> +	 * is because depending on the value of mhp_default_online_type
> +	 * the kernel will online the memory along with hotplug
> +	 * operation. Add the new memory tier before we try to bring
> +	 * memory blocks online. Otherwise new node will get added to
> +	 * the default memory tier via hotplug callbacks.
> +	 */
> +#ifdef CONFIG_TIERED_MEMORY
> +	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
> +#endif
>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct resource *res;
>  		struct range range;
> @@ -148,9 +159,6 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  
>  	dev_set_drvdata(dev, data);
>  
> -#ifdef CONFIG_TIERED_MEMORY
> -	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
> -#endif
>  	return 0;
>  
>  err_request_mem:

Yes, this fixes the issue for me. Thanks.

Regards,
Bharata.
