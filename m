Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAB4E6569
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351006AbiCXOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiCXOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:39:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0089C384
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:37:53 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OCMv5X018237;
        Thu, 24 Mar 2022 14:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wl2fHzmF3exR5+v/K6e3LMOhkjht2e3SbFRsUZZB+W8=;
 b=wlDbf/q0Cgb87D8nLgoGl/Iy2lEza0XT6fFCNaysL3hifi0P3lj+mTbunD5vMaAiGlv0
 VpeFrrqmXyvdrO4B4mFQLawErPMVX/WV9msMYbNuxhtlEFsD6vF+JDD0ANlfY6k/If9G
 pk2mOIB1YeW48qWRPTE7jyG3pxu0UMqJPgGBjSVK7AdCajXpyfC+h3sfK8LkvxWpRG98
 k1fXpO/mNhOaXcp3agiBqQIoixYROOV1A2ZNjKgv1DflVa2QATXfKeaC0IqS9TQxIQXZ
 v4lcO0dqqnlIPwg4RzojONd7nBwgZVJZsFHZaV8he/xjHDQG+7HhmnACyAFCWD8Zum08 iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcvdan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 14:37:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OEVHQQ065801;
        Thu, 24 Mar 2022 14:37:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3020.oracle.com with ESMTP id 3exawjdb15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 14:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxP+GxkNtZNcQTnMa96g2rRbeqWpJDkMSrbuRtfsV4aWZffVrg6fisUdXmYNrVvXkst5GwkyLc7j58eV/xaNF1puzkYuW9zbe4gmQjcV9unyh4ixF3YeQBAagjE3aOTmCyi+FbOZQ5H+FzY8mXRR0o3FmQd9cfyhz9/6unjg6neXd9iTnR5F8aFHTVFD8mBP0rIFx7Zl5GisoTCOfb2UT7dbCcCYrWTg6ZPP58Nixdi8qDMHm5omsRtDdeRnsVvMONCBYtV3da6CqdKOqMyAMAzHrwTDfSlk6fR264eyd6bWI/t46qjopEWatpUMMAIk7zzG2M8nrKy04kY8VumG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl2fHzmF3exR5+v/K6e3LMOhkjht2e3SbFRsUZZB+W8=;
 b=GPwoC7wX3l3cVB+MDwohN2H4rX5IXmc31QNvv+CzlgNe8EN0Jn+Q9a6XkEVQ+O7Cx74R2PGoyWt4U9vJaxqsY9g6eG4TjPaJYPPQfU5ouenBr4sFA5rivTtMQu1k12c/Yzzy2Ql1whfOfX9/t2s+DXKGhue4FWvkpI6zc3ynpcfxw33GwJP5pU/KjgYvvDnqtRlsVSmhPZjsgFCP+Dk8M+49qVLej6Apz94uhu7vQVE1jjYyk2LRqVfTwOWY+t0nQJAwVYHO9n/aQ///6QZVDQePHG4lzdpu3yLKWTiJCQ1sryd+ydSU4+LaJQTXkLojd4D1XEU75T9It9F5+DK+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl2fHzmF3exR5+v/K6e3LMOhkjht2e3SbFRsUZZB+W8=;
 b=tbaw0tNlRR84c4Bq6439GulzoJOTS4eSGZFtfQqhCPZ25BLmD0bET1K5RKg+Czsa5ewGki3SYcqpkvgVyRyYxXa63lcKXZaU0tnS+2OxIZ09KhesCecu49+EwTL2v0Xit0UxDoIUsjArPvVLq+ZCFAPTat4zV5pFpGouSa8NQ/s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3435.namprd10.prod.outlook.com (2603:10b6:5:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Thu, 24 Mar
 2022 14:37:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 14:37:16 +0000
Message-ID: <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
Date:   Thu, 24 Mar 2022 09:37:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
 <20220324143300.GD354864@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220324143300.GD354864@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:806:120::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba0eb88-1900-46a2-6666-08da0da3cada
X-MS-TrafficTypeDiagnostic: DM6PR10MB3435:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3435CEA69E19FBF682761BE297199@DM6PR10MB3435.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFwfVYF1JpK4IxlyafLL71NGhbLzRctbjNKyVhPguXHCgDHB+YN9fXcgF6VoHPFxjFaZfq4Yr7sRrSN2JDrp8Fe83IHba382KgFEGKLwaiPkxbRqcEt1gTWPoRC05suOu/Jn5lnhqfjkL4Om30V2bhGqAZcdc6DKjEfanq8GaZV/15hUSrE7JpA4f8FG1d4jASF/hgZIvCdR7/d5VKj65LjJ17Mi0EBI/3X+0FaUpcEBHrpMnBwAyYY/RbOb4Vll2sD10S2AVe99oS0mEv50WnnM+HV9GGtMFJ9+tW0IzC3/g8II38xFPrCedZ9DbGVTHngBmBqjC1XqlikuzLrtMVhgktWBmedAuRZmXR1V2K0LoukyNiOVKKMB7x+ODTwd/uH7xX+KkC80Ozi5utVKIhRYR2Dux/deGK+D9rSpkQthtifvKuHlA8AVHPOj+Mhbp+ZWexkx3gNJcQN79ReIEwEwPQT1+vkoXAwMdIxPp2lmbDWA4t2AiIUzoELftd1J1czVmbc45oThwn3p0NGbUX7I4APunK0rgyUZp2ibB2vZVt4HnidEBWaiq/V04ux8roDiFffUSz8+OWAz/l1Dy49P2MJeXRiie9PypsdGtN+yQPDB6Xi3+Uz7N1A17iK6vFIIrWY6Use/SckuitI3JurLJQ0GTLo3ntUhevNJ8bHPQQy8toLxUVz+Wg+zKT485nUSMgv0zzcMX760tTlQhhA5nGLzPeMa9JrRqXnrbfcagmjkfZmhWVmZLRSmXt2uXgbiN06JT+Gfn/srqPMMmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(36756003)(83380400001)(8936002)(6666004)(6512007)(66476007)(53546011)(186003)(31686004)(2906002)(4326008)(66556008)(8676002)(66946007)(6506007)(86362001)(107886003)(2616005)(316002)(6486002)(508600001)(6916009)(38100700002)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RlS0dpR2pvNjNNODVGbkVlOUJuK2tRaWV5MnFpeGFPL0x2UnUrVnEyZHhp?=
 =?utf-8?B?VWY1b1oydTNQbExhYUJaSitQSFVxcnV4OC9BRlNzNUJIWHdFb0d2TkpVZ3Yx?=
 =?utf-8?B?RXV2RG5aSXJydjQwTGlnZXY4VjNVK3FqcXJQMHQ2djNESjVKYkw5U2Y0bUds?=
 =?utf-8?B?SmJWK2xZNzFKOGd2VVBWdFg3M0xLUVM5WEJEUVVQbWc3dXlQMEtySkJCbVA0?=
 =?utf-8?B?OGwrb0hxekxKRWc1cTNMaHArUmRESXJDUFZZTVgxajBDUkdXdG9MY1AwWlFa?=
 =?utf-8?B?eDhGV3Z6NFlFUnhlWUpOT1g2cTczc2g5dEJYZllIQXBIcWxNK2l6b3Z2TkFt?=
 =?utf-8?B?WkNoWlRUTHFGanlNTFROK3diNGdyZm9XcjkxYjRocDRrWnhBMUJUUlhvVHhF?=
 =?utf-8?B?RktrdDhzUUF6ZlBiSzlsTnBxRFhRQ0NPMHVDSzBNNGtPSDYzWGR5M2xXTTBq?=
 =?utf-8?B?VllOYnlJOGZQZk1Wb3hJSG53eEdYNHFPNkxWNjFKaXVLcEVLYlM1anh1WFFL?=
 =?utf-8?B?TDF2bURTcm92Ulo2eUh4ZStJVWRoM3JwSStNM296aFdqRnRLclpCVXVzVTFq?=
 =?utf-8?B?L1FFRnUyZkFxOXFWT0JKVnNIT1c0a3ZyaXo2dEJGTTRBbzUzeFUyalZpMGpV?=
 =?utf-8?B?NGo3b0o4a1ZyL0w1UHhCU2tzL1JFWnZIK3M3a0JnQWlOZmVBdmMzbzZ0T1d1?=
 =?utf-8?B?TXRvZUZ3TlhUOWFYNWs5S3hJVi92Q2owMXVNOFZ1SzVTNjU3QmJ3aXl0YzFk?=
 =?utf-8?B?SmRTMC9zNUp0d3pBWmswNGpYSE9RQngwK2ZBNkdId2NMSGo3bnI2algxcTg3?=
 =?utf-8?B?eTV0VWsxZzd6UU9oZGhwNXJ5cVlHMEhlSGZCNFE5enJUc3B4VjQrWGV3d0hT?=
 =?utf-8?B?N3RtRm9jU2JkY3ZHTUxIdWlDQkJUOENlVkJTUmR2OVBUOXlNbmdjMUxiQm9W?=
 =?utf-8?B?SFVYdWFnNFNKNGNnY1lxQzBGUTk5dTBKTFViWENxMjk4TnZaRjFySDdJTjJa?=
 =?utf-8?B?c3NydXRLcWpJYmxjWnFDOExtZ21BcHgxSW9KS2Q3aHVvcGcwZFdnTlQrcWk5?=
 =?utf-8?B?ekhFY3BQZkF5VWQyZ2IvZW1xVStYN205QkFLOGM5Rml1dGE0VlF6eHBqa280?=
 =?utf-8?B?MTQwc1R0RmRlSGpoUFd1VmhyZThpdFdnRTBsU29Zc3BsbTUzYzdtNjczMThL?=
 =?utf-8?B?ZHgwN1JodytCdUhFdkJTN3RFL1kvRkFsNW5WNkR4WjBoZHBkbGZ0Ny9ibHlN?=
 =?utf-8?B?SHJEaXl0U1QyYTROT0dPbEU5Y2k4ZHhBejFqVG5HMFVrZDIzMFBaOHRWQmd5?=
 =?utf-8?B?a2trNzUxbzd5QkpIenorRUcxTzNPZXdqL015bksreXZXeDdJNTZRVXQybUhB?=
 =?utf-8?B?azZaU3o4bk9VMU9NZ1hNaG53UktkQ3N3Vm9KODB6WlVDcUpGcUlxNDNweEd1?=
 =?utf-8?B?SkNTMWFNWE1YU25Fd1p5MVF4a01CMEhXbGZsQ0N0R0lhQjRuWDRhajNLeHBH?=
 =?utf-8?B?eVhOL1F0ck1BSkw3bTZQaEhqZzRGQWhIOTRVMTRHUGtrczFmaDUvSDI4Mm1a?=
 =?utf-8?B?dlFwbU1wRVVkS0Y5Rkd1Mlg3ZW9QWjlFbStsTzBkL1BOYTdsRldva2lhQi9m?=
 =?utf-8?B?OHNRUDBXRTNtYWNxWk5yL2xZNlQyWEpiNVliWUNycG9mYXRvTGJPYzhTWVJ2?=
 =?utf-8?B?UEppRDVTTUhCOUVjYVJaMFkrMzZiTHc4OEM5WUVYSEpaZjRsa3BiS1FLcUJp?=
 =?utf-8?B?VG13M1lUNWxPVmVUckRkUU5HM2p1K2hRNi9Jak03TWF4dENuRVhwZzJkajZT?=
 =?utf-8?B?Ym9RVWZmakV1Zi8vYThQRU81bTJqU0E0YVNOU3oyM2ZDdVJ3a2I4cTRWTEp3?=
 =?utf-8?B?VUZJNGpzQXIyamxpeGE1ZnpXSWtUY1paY0d1TkVlb1Qyay9MYjB1ci9uRGEx?=
 =?utf-8?B?cDdUUjRJaFU3QjdWdEpLU2RiSGVMcDYyeEdoUXFEbVJRQnYyLzVxWTJyeER3?=
 =?utf-8?Q?M48BySDef/QnNAy9/BWONv61oOL86s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0eb88-1900-46a2-6666-08da0da3cada
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:37:16.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sOZ2fLr1C+G+AB/Lfo2A44cRuSsnNUHibHjprA2BnXTv3x4u3P7fOMOFkNruBcnYT1jfyBpoIclFlq4u4wAnU53LdNNtLIxltpmApKMOuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3435
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203240083
X-Proofpoint-GUID: P9-R5y3H6bNB_fnvX1wQFENt1Qz0ErfI
X-Proofpoint-ORIG-GUID: P9-R5y3H6bNB_fnvX1wQFENt1Qz0ErfI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/22 09:33, Baoquan He wrote:
> On 03/24/22 at 08:53am, Eric DeVolder wrote:
>> Baoquan,
>> Thanks, I've offered a minor correction below.
>> eric
>>
>> On 3/24/22 08:49, Baoquan He wrote:
>>> On 03/24/22 at 09:38pm, Baoquan He wrote:
>>>> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>>>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>>>> important house keeping and then dispatches the hot plug/unplug event
>>>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>>>> that handler returns, the lock is released.
>>>>>
>>>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>>>> function that installs handlers for hot plug/unplug events. If CPU
>>>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>>>> register_memory_notifier() is invoked to install a handler for memory
>>>>> changes. These handlers in turn invoke the common generic handler
>>>>> crash_hotplug_handler().
>>>>>
>>>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>>>> of the new CPU list, thus the need to explicitly check and exclude the
>>>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>>>
>>>>> On the memory side, each un/plugged memory block passes through the
>>>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>>>> memory events, one for each 128MiB memblock.
>>>>
>>>> I rewrite the log as below with my understanding. Hope it's simpler to
>>>> help people get what's going on here. Please consider to take if it's
>>>> OK to you or adjust based on this. The code looks good to me.
>>>>
>>> Made some tuning:
>>>
>>> crash: add generic infrastructure for crash hotplug support
>>>
>>> Upon CPU and memory changes, a generic crash_hotplug_handler() is added
>>> to dispatch the hot plug/unplug event to the architecture specific
>>> arch_crash_hotplug_handler(). During the process, kexec_mutex need be
>>> held.
>>>
>>> To support cpu hotplug, one callback pair are registered to capture
>>> KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
>>> cpuhp_setup_state_nocalls().
>> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
>> names I've introduced with this patch?
> 
> Right.
> 
> While checking it, I notice hp_action which you don't use actually.
> Can you reconsider that part of design, the hp_action, the a, b
> parameter passed to handler?

Sure I can remove. I initially put in there as this was generic infrastructure and not sure if it 
would benefit others.
eric

> 
>>
>>>
>>> To support memory hotplug, a notifier crash_memhp_nb is registered to
>>> memory_chain to watch MEM_ONLINE and MEM_OFFLINE events.
>>>
>>> These callbacks and notifier will call crash_hotplug_handler() to handle
>>> captured event when invoked.
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>> ---
>>>>>    include/linux/kexec.h |  16 +++++++
>>>>>    kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 124 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>> index d7b59248441b..b11d75a6b2bc 100644
>>>>> --- a/include/linux/kexec.h
>>>>> +++ b/include/linux/kexec.h
>>>>> @@ -300,6 +300,13 @@ struct kimage {
>>>>>    	/* Information for loading purgatory */
>>>>>    	struct purgatory_info purgatory_info;
>>>>> +
>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +	bool hotplug_event;
>>>>> +	int offlinecpu;
>>>>> +	bool elf_index_valid;
>>>>> +	int elf_index;
>>>>> +#endif
>>>>>    #endif
>>>>>    #ifdef CONFIG_IMA_KEXEC
>>>>> @@ -316,6 +323,15 @@ struct kimage {
>>>>>    	unsigned long elf_load_addr;
>>>>>    };
>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>>> +	unsigned int hp_action, unsigned long a, unsigned long b);
>>>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>> +
>>>>>    /* kexec interface functions */
>>>>>    extern void machine_kexec(struct kimage *image);
>>>>>    extern int machine_kexec_prepare(struct kimage *image);
>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>> index 256cf6db573c..76959d440f71 100644
>>>>> --- a/kernel/crash_core.c
>>>>> +++ b/kernel/crash_core.c
>>>>> @@ -9,12 +9,17 @@
>>>>>    #include <linux/init.h>
>>>>>    #include <linux/utsname.h>
>>>>>    #include <linux/vmalloc.h>
>>>>> +#include <linux/highmem.h>
>>>>> +#include <linux/memory.h>
>>>>> +#include <linux/cpuhotplug.h>
>>>>>    #include <asm/page.h>
>>>>>    #include <asm/sections.h>
>>>>>    #include <crypto/sha1.h>
>>>>> +#include "kexec_internal.h"
>>>>> +
>>>>>    /* vmcoreinfo stuff */
>>>>>    unsigned char *vmcoreinfo_data;
>>>>>    size_t vmcoreinfo_size;
>>>>> @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>>>    }
>>>>>    subsys_initcall(crash_save_vmcoreinfo_init);
>>>>> +
>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>>>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>>>>> +{
>>>>> +	pr_warn("crash hp: %s not implemented", __func__);
>>>>> +}
>>>>> +
>>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>>> +	unsigned long a, unsigned long b)
>>>>> +{
>>>>> +	/* Obtain lock while changing crash information */
>>>>> +	if (!mutex_trylock(&kexec_mutex))
>>>>> +		return;
>>>>> +
>>>>> +	/* Check kdump is loaded */
>>>>> +	if (kexec_crash_image) {
>>>>> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>>>>> +			a, b);
>>>>> +
>>>>> +		/* Needed in order for the segments to be updated */
>>>>> +		arch_kexec_unprotect_crashkres();
>>>>> +
>>>>> +		/* Flag to differentiate between normal load and hotplug */
>>>>> +		kexec_crash_image->hotplug_event = true;
>>>>> +
>>>>> +		/* Now invoke arch-specific update handler */
>>>>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>>>>> +
>>>>> +		/* No longer handling a hotplug event */
>>>>> +		kexec_crash_image->hotplug_event = false;
>>>>> +
>>>>> +		/* Change back to read-only */
>>>>> +		arch_kexec_protect_crashkres();
>>>>> +	}
>>>>> +
>>>>> +	/* Release lock now that update complete */
>>>>> +	mutex_unlock(&kexec_mutex);
>>>>> +}
>>>>> +
>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>> +	unsigned long val, void *v)
>>>>> +{
>>>>> +	struct memory_notify *mhp = v;
>>>>> +	unsigned long start, end;
>>>>> +
>>>>> +	start = mhp->start_pfn << PAGE_SHIFT;
>>>>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>>>>> +
>>>>> +	switch (val) {
>>>>> +	case MEM_ONLINE:
>>>>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>>>>> +			start, end-start);
>>>>> +		break;
>>>>> +
>>>>> +	case MEM_OFFLINE:
>>>>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>>>>> +			start, end-start);
>>>>> +		break;
>>>>> +	}
>>>>> +	return NOTIFY_OK;
>>>>> +}
>>>>> +
>>>>> +static struct notifier_block crash_memhp_nb = {
>>>>> +	.notifier_call = crash_memhp_notifier,
>>>>> +	.priority = 0
>>>>> +};
>>>>> +#endif
>>>>> +
>>>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>>>> +static int crash_cpuhp_online(unsigned int cpu)
>>>>> +{
>>>>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int crash_cpuhp_offline(unsigned int cpu)
>>>>> +{
>>>>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>>>>> +	return 0;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +static int __init crash_hotplug_init(void)
>>>>> +{
>>>>> +	int result = 0;
>>>>> +
>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>> +	register_memory_notifier(&crash_memhp_nb);
>>>>> +#endif
>>>>> +
>>>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>>>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>>>>> +				"crash/cpuhp",
>>>>> +				crash_cpuhp_online, crash_cpuhp_offline);
>>>>> +#endif
>>>>> +
>>>>> +	return result;
>>>>> +}
>>>>> +
>>>>> +subsys_initcall(crash_hotplug_init);
>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>> -- 
>>>>> 2.27.0
>>>>>
>>>>
>>>
>>
> 
