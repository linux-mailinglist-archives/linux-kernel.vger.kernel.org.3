Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F455C6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiF0NEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF0NEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:04:10 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561EB7F7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:03:12 -0700 (PDT)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R69fXu032430;
        Mon, 27 Jun 2022 06:03:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=Jcnfzgcuk+FV4ZbhBwAahUjfCmLbt/JUREx0UHn6/GU=;
 b=ilmN6dIJfCQIsKgPLS9l/V067lNJpDkgPfCuEAONEc1KUrKsb099T8NDh70y9F7YrdPG
 5Csxx2IJDU4MjTvOiyyZWkAi2XREkXDjST7GCJQbcmsqhVcBB5T33Cmi/5dw+QJYEw34
 LGXrEOtPuCUWKxj28erAUz++GEmOlCuiyxdfhkWIHtglqDc/aVjB62EjHkAjGNMsYWUe
 IA26nRdnZpCMmC70RQxgM7NXrUUAv5CpSSDFHEXTNLjd4AhGCuWiZEmWq4MmWQ6jxQ41
 MwtqfUXqhb3AFEPVzkUde/IQIFmtn4ddOb8SyCBaRwY4GjkgHKowxrDmI3LvFx8SCB6V eQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1eguh32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 06:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG86e3y1hcbS9VHLks58rp7Ii/rfGLSgRANXvjmjE6eOPIVxSh+Eh0YWXP/WvvRDAot8+s0UQx2sbO5Ezy26muy4BgQTZwu84V5en+1xUXMuUuzoTGOukSc/BaXHcJ72ZUbN1ufPx204mdSlscGX55H060fiBcmxA39PT3x0jisD/c5dckzfXXsHLuPOqjPMTxY8g79aHNwy122r5eDGC8JPcVgLoVqMStfGwV+6N13/P3zYMikChP9VPw/iXNw+TWsbeeICrCDDsBc9CGsQomf3+9AoUMmzY69R1nA5f8rPmB7gAVyGhLGtViZcOFrTeyyCzW8vRjtqG2L9pJ2ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcnfzgcuk+FV4ZbhBwAahUjfCmLbt/JUREx0UHn6/GU=;
 b=jgIsjF79AbwEE+SFJlst6fuDmVlpKpmkpqMvQuXkW24PWx/5lgE6r8Zk9gM4I54585EIdCswkJuasjedrUjuDymBtj+v61g1iVdO0LWKJdzBE8o/ScC7rCamv8u4K4zuFzxh3TI36nZtqkRvJgT5jC+Mc3WUl1IlUUeVz6F9mTlc8m/llGl0Z6xTpqFgEpgAAnKsdrZWYJvw3d3O5ISlqsqtbCjuHTcH7k9z9v6rmiqnq26wpd0ByC+4lmp6hz1oX+dnNCcos8fiJSrYXTPvV54E1jdNfuW5vYK1rxO4IWDHCsoRGtuXHSJM3JAmYYAtc174a/21zJ3e4TTHcPNekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CO1PR02MB8492.namprd02.prod.outlook.com (2603:10b6:303:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 13:03:01 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::898c:892a:2385:3df6%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:03:01 +0000
Message-ID: <285ac7f8-20f2-c260-90e2-6271ecddaf73@nutanix.com>
Date:   Mon, 27 Jun 2022 18:31:39 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-11-jthoughton@google.com>
From:   "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <20220624173656.2033256-11-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cba5d351-d35c-48e4-e4b2-08da583d5da0
X-MS-TrafficTypeDiagnostic: CO1PR02MB8492:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVElD+Kk6gsZfQPH8Tod9QwCYj6EeSlQY0U0JBqAlkty0JluVoa+OfnEOfCHN8Dns8coVFNIrBj92J6snR/JSGWYt/Uv9qV8dAZT0xEF9yjMnG043mkinY9yS/J+ZklPCp9XFFR4wPjig1AABEVPnJuNyeWicZsdfMA7Vs6FOw0l9veGVC/Im/myjjJwoe1aZr3IkxXwhBXiE98tnr8MFwvbZx/endv5CWWe48iZRlPJPdsJC+2o1rVYTm+XlhOxjaI5F1s+PTH4s1KkIdYON8TzP3OpHise392QaoMCc9KN95Kz3+AA3AOget9j/svNXablGRqTsMuHKrbOviGmBU/CB/e0NxKpMea74S6dfsDAIkBYNxj3B6MnQ/g9rIeUO/MWzpbI3ZXBGS76AXWlMk9kGOj4rSbKNeyedPqxNgIphPpi0hFliOHuRe+TYSBQPbUjQGj9Vko9gFGkEWtLsITMWE3jt2i6eZ/3mvP6+F1RthEHT0tmkVHlgIXf6f4PVQkRxk3xHDKpd8AAvDY/+xdk79s5DVMNcow6U1OPIFhbf84N+h9MqmmRPZdEoPn/BwfqxsvPCarQm75Ghg+I5tQgIWIT1ARVzwFvZ34z3j71cQs4pXDB1U0roisSELtduin/j9f1uHoT5lvYmRqlR/kmUqOTq0lMojeziYr+JjhYjbf176lSeORZvFbDpmGwTQr5TJQ30LJdDfAG0GXy1FycPvCyLUe74e8BPv62gWUL29+kVIyxwDWcEovoiyFaU+TatTbey2LnBQ7wEdTkt4mS++bobVDVAPOgRkFtDMj8h9V3okNUrUiEgVjMJdPw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7384.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(366004)(39860400002)(7416002)(110136005)(31686004)(8936002)(54906003)(5660300002)(478600001)(6486002)(2616005)(186003)(83380400001)(2906002)(6666004)(6512007)(53546011)(31696002)(26005)(316002)(8676002)(66946007)(4326008)(38100700002)(41300700001)(66476007)(86362001)(6506007)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFk3eHAyQlM4VWQ4SkVkMDNsL3N3Q3ZxblVNa3E3bmZoQm1tQllabHhSMHlk?=
 =?utf-8?B?b21RNDJ5MDUzRzk3d1FLQkpwdjMrZE84MG9CQUJXWjkyU0pnYVpEa0lLUXRL?=
 =?utf-8?B?cWY4TWVIZGdPUDJWV2R0VVM3Y3YyaWlDUW91c1ZMcUpwZU1zK3NIMXZRdHJY?=
 =?utf-8?B?cG5oSTBEMVRvYWRDaUswek5WZU9nYUp1RDJxUTVwYlBJTlFGUGthYStpSzVj?=
 =?utf-8?B?S1lBZFpWZXJUTjAyd1FERThxa2E4UzdmWGsyVzdTNnB6ZEdWQmNkM0QxMHY5?=
 =?utf-8?B?TnlCcnJIdVRlL2pxUkN6YVZBeW14YlFzTHNkK3dCYXJ6UDdVcFdrb0NwS0c1?=
 =?utf-8?B?SUNPR0NRMVI4RTR6RUlKQW0rRmRnV3hHL0IxSE80N0xlQjVzVzd4b3NTY1Jk?=
 =?utf-8?B?VUVUZnhrdWM1bDNRd1Nkdm1KaTAvTEFMaWN0ZkhjUENaU0x2bDZVQ1BoODZ2?=
 =?utf-8?B?MDhmb3VuTGlBZjErNDZNcFVudEtHcTUvSjBHNDlTc3NHVFJMeXpWbVQySDA0?=
 =?utf-8?B?bTQvKzBBTWNRWEN0Yll4SkZwTW5XZ0M0NnM5d0pjWVIzNUcyUmQ2WUxTUVpC?=
 =?utf-8?B?ajFLU2hCWUZWQmdUTUxERkpmaEFSNXR5RlZrbHVvSWdOR2NKTzVzZHJJUDlI?=
 =?utf-8?B?NExoVXZDd3hpa1NBTEZXcTIyNmw4TVh0TWE3emVlVldXdmZwN1kwb000eEw3?=
 =?utf-8?B?SWhZN1FHZCtCMnp2T0hWZWhhVWdrTHJBSVZZQXRVYVJXRmR0WGloNW9sb0I2?=
 =?utf-8?B?YzJPblJBbXorVGlHc3djN0lseXlrM0t5ZllEN1k5bFdoa1RZVjZoSExYYy9h?=
 =?utf-8?B?a1FWTEVTOUxvMFMxVDNuanNmV1A3c1pQUzR0TVBPWlV2cWJuVGJjQTRJT0dX?=
 =?utf-8?B?SDQ1UWZid0hmZjVDSGRrY2c3cjlqQkFmN1E4WGd1U29KaGVBdFdDL002eVBx?=
 =?utf-8?B?TmhlUG1aWlVpY1Y4NVR5Q2g3dmE0ODdTRmlSUUUzaUNoY3VaOFVyQTAvY0lt?=
 =?utf-8?B?QXVVeWptUlBZWWl5VktLZ3RuQVBvZ2ZrZ0h0dmh1Q2hCMVExczlxdUZVWk85?=
 =?utf-8?B?ekRqN2pmOUo3R0wzZG5FNHJKSzFIYWI1RW9ETXJGdlYyQ3lsL3dLTG1KNTJC?=
 =?utf-8?B?cm1kMG9YdEEzVFpQZDZvWkppL25vVTVMSlJwS0xQYUtqWWtobDRMenA5dTVW?=
 =?utf-8?B?dHhoaWI5QVlHL0NHYnFsOGlYVHB4UTRXOE5UVzNzYTAwcFJNNnp1by82YzhH?=
 =?utf-8?B?NG00MlpRL0I4OFZiRGpIaWdtN0VIK2xGTUt4UDQ0akxRbitWTVY5S2w1ZnRi?=
 =?utf-8?B?Vnc2Q3VBeE5Kd0ZxMFdXVnJaelA5VGNUNkVMY21ZNmtBSUQ4eitoM0pSWXBJ?=
 =?utf-8?B?R0lPWVZJN25UQTd0R2d2SHMwZFBSMnNKMFhrelVnNWF0bmtUb2Z0TkVUSDFS?=
 =?utf-8?B?cHM4R1JKa0Nxa205elpNSTNXUWJGRVJrQzV1QkVqY0xYekNTaGdvYk1TWDNF?=
 =?utf-8?B?cVhNSXRXanF6RTBjZHd3WkRFcElNcjhSR2VXWWI2RkEycmFtWit4ZmV6L215?=
 =?utf-8?B?QWdTUmQ3a1hVVnVwUTBwY3lCVlZvTW9VS01CT1BMM1VPZFJuL1VaM3pha3Jo?=
 =?utf-8?B?V3o3QkxMUnEwOVk1dG9sWjN0d0JDdmlNSVJwMGQxUGRLYjV2SXY2ZTlPeDcy?=
 =?utf-8?B?Mk5KZDFyNXBzajE1UnQzZnpFQS81MjlpZGcrVisvZnlka1Y3YVNaTTVnSFB3?=
 =?utf-8?B?K3N0Wmk1SFlTdktMRmY5bVRjQnlmQUN1M0FkZFN0VUxEZDNzbklMbzcxWjVE?=
 =?utf-8?B?MDc2cG84SGZvWWsxWFAwbTMra3lmQkM2NGkwcS9iSHpWOGpscHcwRGJYeEF6?=
 =?utf-8?B?SDFQT1lSUU9iLzRpUk85UE5rK1RXbEErck8wMitDRlU5V0tmaUF3WFk0RlNV?=
 =?utf-8?B?RmFQMXFhbVJBOVZyOENObWJiak0yQlZZVnJjMEpNemZ4eTFEeXo0cFFIalFh?=
 =?utf-8?B?dCtPVjhGdHNWVS9TMFN6bHgvZzNHRUY4L1RZdlhiYlh0WE1TMjVwOEYwYjFC?=
 =?utf-8?B?Nm5GaDI5V2RiSGtjRHZobnJkU244T3R2RnVaMm5BQXBqcjBYSnJJSlRjRFQx?=
 =?utf-8?B?R2oxOVRyWU9WeXVPemJxalYwWkVFV3ZMSllsVXhjeTAwRXZCTThXNnQwaXJo?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba5d351-d35c-48e4-e4b2-08da583d5da0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:03:01.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/bR321JeAu3DpMVBLZVOf1Za/ZbiPQbxViN/iE0a7MGsb2zrhs/dPAizSWoVKO85FBtP2c7r3q95xB9UZsMvIt/wV1w7k447ahYhcIekA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8492
X-Proofpoint-GUID: tZMajvCN9b104sJG-qnFg5CpJ-uxPViq
X-Proofpoint-ORIG-GUID: tZMajvCN9b104sJG-qnFg5CpJ-uxPViq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/22 11:06 pm, James Houghton wrote:
> This is a helper macro to loop through all the usable page sizes for a
> high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
> loop, in descending order, through the page sizes that HugeTLB supports
> for this architecture; it always includes PAGE_SIZE.
reviewed-by:manish.mishra@nutanix.com
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/hugetlb.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8b10b941458d..557b0afdb503 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
>   	/* All shared VMAs have HGM enabled. */
>   	return vma->vm_flags & VM_SHARED;
>   }
> +static unsigned int __shift_for_hstate(struct hstate *h)
> +{
> +	if (h >= &hstates[hugetlb_max_hstate])
> +		return PAGE_SHIFT;
> +	return huge_page_shift(h);
> +}
> +#define for_each_hgm_shift(hstate, tmp_h, shift) \
> +	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
> +			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
> +			       (tmp_h)++)
>   #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>   
>   /*
