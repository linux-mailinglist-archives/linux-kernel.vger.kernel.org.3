Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0A597B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbiHRCBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242592AbiHRCBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:01:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B05A1D7F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660788063; x=1692324063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZaVt2csn1yFdcpjXAlnXCpIx/VP1COxtgMyVrkoYM0U=;
  b=R1/BmOxXoUgbCPzt8D8uJpU2QrxfHJp5PucSlp6XG3UL30DYDERmJ4H4
   V6Wj1OQ09IkcvFSfTqL3yNQsgsZ2pIeO57jzTR47f9IA0/vEOewmDGXM4
   YQ9ayf0H0SYaE1LIJq+iSVvqqHB0UGHa6jjD6kNIvSplqA0QsnoO9G6jh
   duydnvb6L7CDbVkvtfJm3fSZDUSg/kHo36ybK8AmxUidiFenGf7Het11T
   nPT7NKdazIsMYBuSaZy/hNZdV/82TMM6l5nGJ0NsyqHJFCl+8iV+cMsEV
   rQlrIwY5BYEfu545y6y0KR9yMPPUJboKq6usZN9taY9iZZLSNTum+RDku
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="290211794"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="290211794"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="675875750"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 19:00:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 19:00:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 19:00:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 19:00:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 19:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keQ4QgOxRoEFhYP8wcZaEk5il+5oqZuiUHvgc1OQojjSBwTnsZ2Pd8s+2lJD6EMqvOToifvob0Gd8U4pkkAMXMZmaDLGqVv3RBGoCXEZ/TJ+b3Ub6Vm3wlix9AFYe1euCLqeznBDAY+VvI3625MPPbGM7OS9l3rNv5ak/9YY1ZWoRqWbt3NLgz6ftdqS5luXbVHz1iUdFQZNViw/ZQWivlX2GLB5ISRDSCklDjdJz6wPQ5IyFjZkbwx6R862qU8jg/uoCCEwACk/ad5TBvKnxLN8KEG4IegApSOokv9L+pEveAEgJeWmJXvEYSPV8xDMWMLDiWhtRLAMo8KHckxmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AFwl6Tdw7lCOQEeBIBUL2ttLPJdObo/6MKBRhbNoOU=;
 b=aUCmb5A3XOcAajMJq/YBegYSobB514onGLZE2jKSANJSdYI/u4Scl1oWV72ObVxz1HgHm/rfUiSy572TQD+RWvyRJZGOrDkkv4AG9UPXmZHcd6mAc6dgjJSZwr9Cs4JlVLspxi60xNyekxBrw5zlxMl/CBm5tmLnnAgzXPBhccwFtfqxixG5cvGx6lKBb4aChgtkfdfmLrBJv7OQNvCbK2komKBvuDN2QpY+GrkWFzQwWFAUIfoSpd4PEH4yJMELWmz0ucjMMI10v0fWsmDMqBb02lflSYFw2uDofoB9g/H9112DxnImk8MH9zDFwsIgUVZqwZZLkq5t240X+3nfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 02:00:55 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 02:00:55 +0000
Message-ID: <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
Date:   Thu, 18 Aug 2022 10:00:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 048c13e2-86a1-44f4-9404-08da80bd7c64
X-MS-TrafficTypeDiagnostic: MW5PR11MB5761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g75LIN7pW2D6u035r7jnh4uKb1aY/0AhVZyJytat8jF787K5w8AsTPMZkxBm7Qkisqoh6KLmACzdrKYIcF3yen3UB2+oIT5j65HBYNH9n5Rw6GoVkYzHUPB8BTN8dCtlYGL0oTprCZ5bU8bxCRTbiM3FebcOAVTVa5DKJfR/KJGtDv1CCHAYYKiCvjgkxFSfGUW00EvBhtgvRIGQSHnSulrKa/Q8T1Ev9lut7XSh70gmSoZTBmwee9p3PSWjNvfB8Oaiikg1XAglOsZoSv2EH/obLkzM9hFoy0KcrR6ToBj9jTrbWWhb374is+BUHgzQicE/HLnMcD1Z9+LoFMGrJV7HaAwrBLUbRZyxy8GCr+XDoPG4qPPkrNE16Ec8xj4LydMqFbXL7kjcDXlCnbwvUl0QcdN4G+XVTcvo18HCGc1JIGqTXD53OKsx00D4HUGs+C15MRFg8iqVB8zO2Us45pQ/BgJL8eDoVNS7ahiTLRnatIb0EqIMCszNEO0DnDAx946t/D4Nr9/lmyWLu4NV+SA0Q4dqCHUQ62wQSYmom6xNtWUqsLC06IdNcz4yNcdtZ0sRAc2wrlVINl0XshcFjYYSHWUBs+lxOlmXNCEiQ7P5SIFzF4+80GsEgDrc4f5vKQJpaZH0KRj86IL/XxKxDeKef/CqCNXiagbWCzX63njwoJhvu+cDBF0QAoVFZU9j0SSQHPwYM0jOy7mmIsWQdbF/in0PYwI2iKz47ERM2kJLL0wwQ+tKXy3uB9lOVJTWZhZ97JEZu2RlY8/VSratU0JcoFenwt0fXSfzCPVDc9LBxING3UTWmeQiIfjdWcONZoa4nhBJaDmwHrSoUspX9/FfBKl4BcCqFor0AZkq0bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(6486002)(6666004)(6512007)(83380400001)(53546011)(6506007)(5660300002)(186003)(41300700001)(26005)(316002)(2906002)(2616005)(478600001)(4326008)(31686004)(66946007)(86362001)(66556008)(110136005)(8676002)(66476007)(38100700002)(31696002)(36756003)(8936002)(82960400001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDdWbnFscHNNaStoYU9JRi9VbERSazdFbzgvL0FDTnNBUUxCb0ovWVdiT2M3?=
 =?utf-8?B?Ky9kTDNhcFFZZkN0THc5akJCRHBsRENVU1B6QUpPRGdLUEtSaTNDSGdFTk9G?=
 =?utf-8?B?T3ZxSHRKdVJYMGYxWHo1c1ptWFBvcFlmU3pNVHNrSHRTdDNPeHRQMmRDTHQ1?=
 =?utf-8?B?cnBhRHJxU29WQWk4NFdmZk52ZDdkc0pkMFdHRWc2ZjIzZVZ1TVF3dGFRQUpa?=
 =?utf-8?B?YWV6eGVVZkJhS0lPLzJGOFJucmorc2MzV0pLa0laeUpZZW9LbzRKQ1l0MHZT?=
 =?utf-8?B?ckRleWUvZWVrTnBXVDUyeVZ6YkxzNUQvVVNmZGdmZ1dhdUFOd0hjUlJ1V0Jn?=
 =?utf-8?B?NnZ5TGcwRkxaTHQrd20vSUpiM0duM1kxeDY3VzNKek1BNHYwbHV4dTYwOCtL?=
 =?utf-8?B?M0MxZ0ZjM080Ui9zWXZZN1R2ZUIrU3JoUk82eGlkNFlSVFc5SlMxWWpaN0pP?=
 =?utf-8?B?aWc1eEpuOU9VOURONTBNY3pnNDlsanpNekZRSzVlQmV5UnltbU5OSm5DRjU4?=
 =?utf-8?B?Rk84ZTVXcHpQVm1rT0dwSG50YUtITlZoK3hncWtoYi9ScStwWHFNR0poVFFz?=
 =?utf-8?B?VjlWMTdvM21EaTA2OVlHcXVTY0VjbGNrRkV6K3hiU2hReXBXMFc5bUl2WGZQ?=
 =?utf-8?B?WEpRZGpKbmEyOGN0dUJOdkZOVlhCdVFVcW5XVlRmNThpMVBSYUl5ZEpEUFR3?=
 =?utf-8?B?N1puaTlybmJ4dGpkUFVISTFjTnFLaGNueHgrVTJBSkdLWG13L3BONk16MHpk?=
 =?utf-8?B?MGlJUHlnWWRndktpWUxvOFUram5OWDlGakNhT2F6Mi9pMXVSeFZPWUJzRHRD?=
 =?utf-8?B?cWdMVTl6MkhkV04vVmR4Tm9hOFZGUiticzQ2ckFpZ0tTM01PNUtESm1PMlUr?=
 =?utf-8?B?Q01Cem53c3RjTjJpcmJhNFdNUSthalhhbjVpdkRGOVBFV01TTGY5azRXM0pV?=
 =?utf-8?B?V3N6dWVkbEtQRVhOZ0tMYkUreGlzZ0V5dVR3azdKUnhQOHUyOXdhTThDMWNZ?=
 =?utf-8?B?TDNKb0kzMkdkU3pGdGY4dmZUQllLZ2podXV6WWZJYThzZ25xOHd5Tm5PSEtN?=
 =?utf-8?B?SzhGMy83eVNmNStNNmtpTzhmNzZjdFMyM2ZVc2Q3NWlrZFlWS3dEbmV6eGFF?=
 =?utf-8?B?bG1raUJ0cVYwNnpjbVJpMkI3cUgzRzdMdksrZGVTSUpxckhoQWpzRTdtU1ht?=
 =?utf-8?B?Z0c2L24rcG1wbTBYTVZWMVQ0M1pENjRSRmk5bTJaUVIxenV4WnBmNjZpbUFx?=
 =?utf-8?B?blJXN0hMdnNVb080MTA4L2hPRDBsWllVRUtEeER6L0h5YmdxMkdPR0hNNXlJ?=
 =?utf-8?B?RVZZWERzbzdwMVF2VE56V05aRExpWEtNZDRwRGU5OWZEa0gvSEVXemozeWhS?=
 =?utf-8?B?Sjc3S0ZqVjNEem1BcU5sZVVtay90SE5rQnBiMGNnUm5XdUJvaU1XWnZWNlgy?=
 =?utf-8?B?UW1DcEVydTdyM0tpZHpvbnhSVksyaUNnVlc1U0tETnJJcWZQZWpNN2RybU4y?=
 =?utf-8?B?UHVjYWR2SElFUk1aTXh5ODE2L1c2emNJVjhZdnREakEvblJPdFdsQzFMeHdQ?=
 =?utf-8?B?NXZFSjR5aXQ5TTdtSEtqYlNERHZFOVJZZVdHTk4wTGgxNXZMaUNmc1hvTjdt?=
 =?utf-8?B?OW9zazNxa1pEZWlsYVVhdWdxM1hSNmgrd0RZYmx6bU9YaUo4NFkyVkRuMGt4?=
 =?utf-8?B?TmVmZ2E0ejNEMFJRTXF2czJuNWVqQ05wNlhqQTNOeFpCMVFuZ1JzVXNJZ2hs?=
 =?utf-8?B?aGp1bWdqZ2kwSlZaNjAvNzdEL3BRSGlPRHM1S2Fsb3ZSVkNvRzJnYVVyNEor?=
 =?utf-8?B?ZUxNcU9KeDhHVUVoQzJpQ25KK2hlVStBZWQ4djJCQXVzRkJPcXd6R2xmSHVL?=
 =?utf-8?B?dXdLRFg3aFZ1Z0dUenF1dW5pRmVXc3pZMzkrZU5vb21HR1drc01rUzNBOFJl?=
 =?utf-8?B?MDNaeStheVZjcE1GTnRxQ2pTQlNGUzFnNTdwdy9qNzNPMXpIRGczL1graXhk?=
 =?utf-8?B?aCtua0FsVlJ6enN2UURnYmVNSVJYVkdxUWd5R2VFWGIrN2FocFU4dzlBUndF?=
 =?utf-8?B?UEZtbVI1ckdyd3FtdUs1RWcyNHhHUnRtL1NxTkZIdlBiRFF1M0lhZmhHR05H?=
 =?utf-8?Q?ESA/MpiOCkjAGsWDJvTyAc9JX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 048c13e2-86a1-44f4-9404-08da80bd7c64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 02:00:55.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiPHxSVuPC9oeS+fD+fQPKcqyawA7CH0vO67Viz9o3ZtC40NlGJYKs3y1r2BS4f33QxjIEPlMoAzleqg0K7PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>> 	/*
>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>> 	 * preceding stores to the page contents become visible before
>>>> 	 * the set_pte_at() write.
>>>> 	 */
>>>> 	__SetPageUptodate(page);
>>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>>> can tell us more details.
>>>
>>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>>> to make sure the order between the page’s contents and subsequent memory
>>> accesses using the corresponding virtual address, do you agree with this?
>> This is my understanding also. Thanks.
> That's also my understanding. Thanks both.
I have an unclear thing (not related with this patch directly): Who is response
for the read barrier in the read side in this case?

For SetPageUptodate, there are paring write/read memory barrier.


Regards
Yin, Fengwei

