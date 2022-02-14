Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63044B500E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350430AbiBNM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBNM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:27:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2B13E25
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:27:48 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EB9Crs018242;
        Mon, 14 Feb 2022 12:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iJpDCgqyUuSht/RRwCn87C+pT7gDnaBZau4PuHnk9KI=;
 b=wkwGg2Z3mT0yOQlcAoKP0TydmqdB8CXw6S+nFZJS5T75MCDBKQiTmTjyHLgSIsli6jYG
 zW/qRbB5v/CDJUQyS9uNtbb4jy9KTD3Fgs8CfKfMFjvV6bWspBYNgUuLE7gfCHWSlKrE
 1d6MCWUon9/gzVfb1G5a5iC0YyYxC/SS3uOgZ6Ora55vq1OPDXI7IM+9qv6Hi9KtukWy
 2hCPbO5/tH23HM8CejX2oi4rkin+UFhl04yzpzagddf60JpdnFDAVXuvdUU7PSbDZkzK
 hValK5/O30zNQBfoZt4LTrxm8PZTOpHnSss6EBAfi3I534C8QNgrQeNo/k1Mwwa3UQvv gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65euc7vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:27:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ECGPJe071407;
        Mon, 14 Feb 2022 12:27:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3030.oracle.com with ESMTP id 3e62xd15bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCF7B3cxSmK98TjV4ViQH12NI1BslcrJKXhUkewWeJPoXrZBbXmYq0aN2xMGo5Es7giWyhpX4dffYaqVd73QHtcHx2kw49kRcGlGlaytDoKKgavUdbxA7zHen4K9tR61l6Tj3ze26ixtOD3BfriYWX112iFqw+CORL/7yXaD2/tgsPEkTjIyELciQs3/+aZUCNRy1pBS1ny3TiOfx3Cm8XWYDobjrX2H6W32hHw1i9jqi8+usWUPyBaStfwplKncniLKLBW/Wbr72/lM6LD1BXVvCxdPK2Kl+g2zASyg2qYZRXJr4nnQ0Bsn5EZ1vsfXMg5Ula6201acsV7qghCDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJpDCgqyUuSht/RRwCn87C+pT7gDnaBZau4PuHnk9KI=;
 b=ldav6w0K8bugKQ/eWnbiJi2MkslrX0bvL8zapjvaiR0IyXjqk1dDpxIQka5/bGqPSX7Y0rq/EPTVPdPHqXu7nWNcmEvAUMNFDqkcqIc+ryVhDOvylIOuF3D0u4AoCh2tb7Rb6gYVhiPa1BDfYunawjsSqtiVoOttQY8z6z1PPgInna0y/bhvyhW/SJu9swqzpbg22wbF+4f5VtPsTaxJQWPVieraSjH45UaD/BOcniMPmkyIP2vB1ykYq6hGI3+4hR8shmq0RvaWcRixJfXHC/AUx8i6oJHwKkdRwPwWENrl4JXwPlNl06x2wTqXPAhMAQjYJCpRUewk9mGMoclNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJpDCgqyUuSht/RRwCn87C+pT7gDnaBZau4PuHnk9KI=;
 b=0QsQMy+HCwgCTTByqpI0eshjmOT6OSHm7h68qXEzQHQIVvWQbW07X2aMHpyOO6/67THbVwym1s/rHBXU2hwFE52gW0KIp44DWmAGCWzo3S8U22nCbJtCJouZT8jgzYgbfluYtk31yRxl9P523KKLYUU1ergSNIN9zXBOPbna/vI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1726.namprd10.prod.outlook.com (2603:10b6:301:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 12:27:43 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:27:43 +0000
Message-ID: <505064db-4680-056b-6380-1fe04eb1ea00@oracle.com>
Date:   Mon, 14 Feb 2022 23:27:34 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 2/2] kernfs: Replace per-fs global rwsem with per-fs
 hashed rwsem.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-3-imran.f.khan@oracle.com>
 <YgK14ElTBW1BOXxW@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YgK14ElTBW1BOXxW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4de8b0-a990-4b6a-72a8-08d9efb56614
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1726F54204F74EC7B3CC0CF9B0339@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/VhljcPccIbRsCHwNOuWhHXAfe+I445sNXhc9khZQGTvCgFipvW144FKdNeJ5gN8q/k7wa3Dql+oGfUIUGZ1/3B2h/dGme5F3hAdnrQhW/EdKmcIym4mzzgaZH3Oze4LXCbOfH8FPpoyszr8jVxvunkAFqEALTYB/92dyKO2ChEikZ/RGUvjx8WL/dlnTIcmkYy30GK08/MhwlfuRcx/AguEZdRkuHv7piJXL2Rf9suyCkUSWkY9SQduSuS7gXZzOcfQobQ8ClGR46GOeQxkEfwzvQNyySbQsR3QjSUjGpZL6luXm3WZJ77v8vVRfru37uHT+6uFojst5dibmrAIdNm65WGE6CrMsnW1l6igvfnRHERQLdV/ixqNF82NTK87lAKuWjgfv7PETXyBcR7t3brJcrGbDYDgKGxu3eoJh+p4X1o02Cm7VxHsMJaGs5PC3892sZP2YHjNlJ3n973nf2f2PL6AUAnLb2619i3emHO5GGy0E1suA0DFQ+qsZSX+kShzJqsseyHnTfOwC6j9VcZMwFg5ciQ9KXp96o3Av1MtD9MUunEPPgO9VAPSlrEYoHNDn27o4sQWEdHTzuHue2Lhdl84LuWP/h1IIVq16a3as2YYD04KwaC50V2jfJYW7lOooytEkp0Nnklps12NLSFPfpkqJgCiPI5sVhCexhawY5QclLvHghYsStMLMKt11ccVk1bhYnSaaQyCgXZ3DcQZMonvi/rrfspgWwJTiwHW2SzP2DzUip/44cBvHp8UZPQzw9E0wLXmlNiVNdZaE/F8DpcIirQI7ljvBarLp9GZkgIJQRXwcm1fhiqZHvx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(86362001)(66556008)(66476007)(8676002)(2906002)(38100700002)(8936002)(4326008)(5660300002)(186003)(26005)(31696002)(2616005)(6666004)(316002)(53546011)(6506007)(508600001)(6486002)(6512007)(966005)(83380400001)(36756003)(31686004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9LK2ZxOXJNRWFMcFpxbTR4K1I1TEtGSElZNjhiMEtiM1hhMmwrYUpQampB?=
 =?utf-8?B?K050RElsd1VGVGFBdHl1dldORzduN2d5bWJvSUZQSzEyQ0U5WXpXdXI3ckhr?=
 =?utf-8?B?S0NKQlJ0SXJtRTBuTEtNUEd6aWttdldYc016emQ1cWdDcnA3Ykp6SlV0cDND?=
 =?utf-8?B?QkU4eXp0TDJtUGMyMlJObjZvdkpoTmFmaGdoTzg5cDM2UFhVQTZBZ3JRWWNY?=
 =?utf-8?B?OWU4Q0t4NmQwRjNhSlYwK0tDa0RFV1hmb0tuWHV0RmZsUUN3Y3EyLzlsdDlF?=
 =?utf-8?B?QWFDVjA5TnRMbEo1aVo2Z05XOUxhT2o2UzRtYW9jSlc3QW5NT2U4TFp5WmRq?=
 =?utf-8?B?UmlTK3crcE91dHMrOUVLSkk1NVcyazhyT0NIQmVhbENkVVkxRWszMHBmcGhJ?=
 =?utf-8?B?bWdPci82dk1KbXZBaSsvd2g3MS84Tkk2SFpMd1p4SnJrZkR6UlkvREJkeDd6?=
 =?utf-8?B?ZXFtQ2xIR3FrOTVTVmlFVE5jUmRlSzhlT0VsbDV0bmI0L1JFa091djlhaGln?=
 =?utf-8?B?MkdMRFVvaFBQQzg0VmpMbmR0ZEJvbGxTM3R4RDFuN1ZuWHh5U0FNaEIvMXBV?=
 =?utf-8?B?cy8xZGFKSVBXSHJ4S3RJV2NtelRvR3Y4QmlTTlFkVStkRzJBbHhSN2xCaUhk?=
 =?utf-8?B?K0toS3pCbDRDdjk2UHg5K2pWMVNZV1RUeEMwTk1YR0VVWEJqNG9lTGozQ1hT?=
 =?utf-8?B?THJETGd3VkNYb3R5QmpnTFh4ZkEzVU1aaXBod1UyazF6d1VXOExOMzNjRWQz?=
 =?utf-8?B?SkFwMUNiSDYzaGRWVm8zS0pQT3VtcXdCeHFBVHMrSGhBcWlHSUdvdG9hNXp3?=
 =?utf-8?B?bkx0TElhVUYyaXdQdlZKYnVvb1I1eHM3SFJWc2hhV0EvVDUwUjBOS1NTblRL?=
 =?utf-8?B?SUpsenovMmNrRHNLTk03N0FabGVtUEhrOW40b2VVNlhFcjZYWmVFWW9xSzk4?=
 =?utf-8?B?cnJmYmJiWE1KK0JvL01TakR5L3FQYm8xQUxJei9RRTNqcDVlamNubEYrdTJY?=
 =?utf-8?B?SmYwbVVFRUJCNm9mSXdTRHgzdnJELzdqZlNORkVzNERlQ1ZTTjJFTStSQ2Rv?=
 =?utf-8?B?ZThYbmNCZlZZVVV3aDUwSGJRblJXNzRFQkxwVi9vWklmek44dTFuRVZFaFo4?=
 =?utf-8?B?QlV1VEU2TmowVVl3VGVLNTgyODdqS2xPVnZBNFlVU2ZGdUU5Uk8xdms5ZFdk?=
 =?utf-8?B?UkRndVQ4ZzJWdEpFeU9kMVg1Z3d4UXlkeUMrR0VzYStkS3g4MmxlYXNCb2ZE?=
 =?utf-8?B?RldRS0N3NHZBNUxYa29HNHh1SUFLQmdET25RYm1DbHMyejlDNHNpWWFyQkwy?=
 =?utf-8?B?TkIrRXE1QVJMdTZVMWtIQU82VFBTU09lQ0RvRUp5YVQ0WU82emcvUHhmOUdp?=
 =?utf-8?B?NXZPWWM1M0xhSkVjNEY4dnBmbmtzMEcyMFJCZFYyKzJMNUdGdm5Yc2VFbHUv?=
 =?utf-8?B?UVZ0cGZBZkRPcXFJTnRITzloa1NjUytRTmExM0tqeG1kQ3lGMTFHbDI5RFpI?=
 =?utf-8?B?bWNGQi8ySTcwNHo3SUgxZkwva1VLUkhxZ09TZ3ZISklWa0pYUDhsZkhiN2tw?=
 =?utf-8?B?emJjUDhRMDFSMzZZQ1AyQUE0ZmwvcmlGdDFpWlBYcHoxYm9LMWI2R3llbHBT?=
 =?utf-8?B?TVVpM3JMUFc5dmc1VUMvczhRTHFxODBkQ0xibnRySmRLMUtheW5DbEVJSllM?=
 =?utf-8?B?VEFmOFJjZEwrbFkra0lqb05jdXZ3RVdHTEVrOWg5UXZ4TzhjZ3JRUmI4c2dS?=
 =?utf-8?B?YVNaQlYxNDlEUUJtUm9Pa2psKzlwemh2SlozbThWdmdmRDdtd0htaWdYYUpU?=
 =?utf-8?B?MmxjT082M2RYVkdBYXh5Vnk4cURQSXQxU3lhSFBsU0tqZDBzRDlYU09VWm1a?=
 =?utf-8?B?YlNPdWJTS093dEh5WXByZ0VsTy9WZ3RWSSt2d2pWTDcyN3FRVTZzb0hGaWtI?=
 =?utf-8?B?T25VMFZlM3A3aDcvWFYzcWpZczdGOC92RlBCUHQrZndoZzNkRnJZQ3NDK2FV?=
 =?utf-8?B?eUdaQm9PZ1BWWUVwNHpxSFNLaStXMmtMS2VDOCtVQUJldVJ3bnMxZmdJMjlC?=
 =?utf-8?B?Z0FEL2cyamFOK3QrR2V3S3NQUVVHOUpHT2JJZEovSzhJR2dpbmMvVlJNYVNa?=
 =?utf-8?B?ek5vZHRnOU5ZczVwS0l2bkUxNWZUbnBhTXRybjlPcDVmcDZ6ME9FUkFIVkJn?=
 =?utf-8?Q?iFGCsPU49Pbs4H4rMSSTE7E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4de8b0-a990-4b6a-72a8-08d9efb56614
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:27:43.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqI9NeZNn1Nm4fxwp0lHlUSdfcOnDEp/DHI54TzYZaVh7rdgrFex3Tg9+jFouYOMJcfhCg0o3YHiw9dNrMJDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140075
X-Proofpoint-ORIG-GUID: Rtz6USzkWnsRL5p2FCYuI7IgCVZ-cxec
X-Proofpoint-GUID: Rtz6USzkWnsRL5p2FCYuI7IgCVZ-cxec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 9/2/22 5:26 am, Tejun Heo wrote:
> Hello,
> 
> On Sun, Feb 06, 2022 at 12:09:25PM +1100, Imran Khan wrote:
>> Having a single rwsem to synchronize all operations across a kernfs
>> based file system (cgroup, sysfs etc.) does not scale well. Replace
>> it with a hashed rwsem to reduce contention around single per-fs
>> rwsem.
>> Also introduce a perfs rwsem to protect per-fs list of kernfs_super_info.
> 
> Can you split the two conversions into separate patches? Also, I'm not sure
> about the per-fs hashtable as before.
> 

Yes. I have done this in v6 of patchset at [1].

>>  static bool kernfs_active(struct kernfs_node *kn)
>>  {
>> -	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
>> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
>> +
>> +	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem[idx]);
> 
> Please encapsulate this into a function. If possible, it'd be ideal if the
> conversion can be done in steps - e.g. first introduce lock encapsulation
> interface while leaving locking itself alone and then switch the actual
> locking.

Sure. I have divided interface and usage part into separate patches in
v6 of the patch at [1].

> 
>> -static void kernfs_drain(struct kernfs_node *kn)
>> -	__releases(&kernfs_root(kn)->kernfs_rwsem)
[...]
>> +	lockdep_assert_held_write(&root->kernfs_rwsem[a_idx]);
>> +	WARN_ON_ONCE(atomic_read(&kn->active) >= 0);
> 
> Ditto, I'd much prefer to see the lock lookup and accompanying operations to
> be encapsulated somehow.

Done.
> 
>> @@ -1588,37 +1597,65 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>>  		     const char *new_name, const void *new_ns)
>>  {
>>  	struct kernfs_node *old_parent;
>> -	struct kernfs_root *root;
>>  	const char *old_name = NULL;
>> -	int error;
>> +	int error, idx, np_idx, p_idx;
>>  
>>  	/* can't move or rename root */
>>  	if (!kn->parent)
>>  		return -EINVAL;
>>  
>> -	root = kernfs_root(kn);
>> -	down_write(&root->kernfs_rwsem);
>> +	/*
>> +	 * Take lock of node's old (current) parent.
>> +	 * If new parent has a different lock, then take that
>> +	 * lock as well.
>> +	 */
>> +	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
>> +	p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
>> +	np_idx = hash_ptr(new_parent, NR_KERNFS_LOCK_BITS);
>> +
>> +	/*
>> +	 * Take only kn's lock. The subsequent kernfs_put
>> +	 * may free up old_parent so if old_parent has a
>> +	 * different lock, we will explicitly release that.
>> +	 */
>> +	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
>> +
>> +	if (idx != np_idx) /* new parent hashes to different lock */
>> +		down_write_kernfs_rwsem(new_parent, LOCK_SELF, 1);
>> +
>> +	/* old_parent hashes to a different lock */
>> +	if (idx != p_idx && p_idx != np_idx)
>> +		down_write_kernfs_rwsem(kn->parent, LOCK_SELF, 2);
> 
> Can't this lead to ABBA deadlock? When double locking, the locking order
> should always be consistent. If we were doing per-kernfs_node lock, child ->
> parent ordering works but we're hashing locks, so that doesn't work anymore
> - one child-parent combo can lock A then B while the other child-parent
> combo hash the other way around and lock B then A. The only order we can
> define is in terms of the locks themselves - e.g. if the address (or index)
> of lock A < lock B, then we lock A first whether that maps to the child or
> parent.
> 

Indeed. In v6 of this change I am no longer using parent<->child
relations locking order. As suggested new interface uses lock addresses
to determine locking order for nested locking cases.

> Also, please encapsulate double locking in a set of functions. We really
> don't wanna see all the details in the users.
> 

Sure. This has been taken care in v6 of the patch at [1].
>> --- a/fs/kernfs/kernfs-internal.h
>> +++ b/fs/kernfs/kernfs-internal.h
>> @@ -19,6 +19,9 @@
>>  #include <linux/kernfs.h>
>>  #include <linux/fs_context.h>
>>  
>> +#define LOCK_SELF 0
>> +#define LOCK_SELF_AND_PARENT 1
> 
> I get that this is private header but can you please add some identifying
> prefix and make them enums? That makes it way easier for debuggers, bpf and
> tracing.
> 

Understood. These have been replaced with a properly prefixed enum.
>> +/*
>> + * If both node and it's parent need locking,
>> + * lock child first so that kernfs_rename_ns
>> + * does not change the parent, leaving us
>> + * with old parent here.
>> + */
> 
> Please reflow it close to 80 chars and ditto with above. We can't follow
> child -> parent order with hashed locks.

Done as mentioned earlier.

Thanks,
-- Imran

[1]:
https://lore.kernel.org/lkml/20220214120322.2402628-1-imran.f.khan@oracle.com/

