Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BB4E6AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355481AbiCXWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiCXWnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:43:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01EADD6B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:42:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OJHHE0031416;
        Thu, 24 Mar 2022 22:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JopOeTFHkoM+jtlVu21Qwbm4LTlOGsh+v5FQ9sGjqAE=;
 b=iCpcnN5x0XGuzRZSS2KBLY+h4tQZhiNS86CFYuE5nGkuAq36ng2mHDhFDC2QlQzu7EUI
 ktWNqbwbDr8wcGZcSX+DLfa/YNZLvQcqebiCYlwVBRTZBHF6zTCXqSFbcPxCNgGfatWN
 H72XB1IP7ykNu2EtN5/niNMrqb3yOZ8a3lEo5yanuTAbTXgwkk7j7pH85y41VqKg2y+q
 EntQK6oIPYEgYJ7IxNCLm9SVG31lRzZdCXoR8jKyr7zRc+isV7CuLC+HSV66zaLtoMYW
 hYxiDaNpBggWLMHUhh52poZhrnsGr73g+XUUb5AbZUUkV9OF12lq3UfUXjQXX3HVy7b0 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qte45a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 22:42:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OMaAD4075317;
        Thu, 24 Mar 2022 22:41:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3ew49red5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 22:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtLstkQbupsSe3nJdusArpMXZG+Yx7B9ZE9IjXOsV9ACfLQ8cs2pRZBOy2+ThHGsJ1uGyXMuKnsHed8HHvn7QcXX2nzH49ZSGSN6aQZ24BiMSwIN91S58rweM/5Cr5SACsCjtrOvyLvVuqspDafuXxvA9jgm0KmkkWbi/IUZXj9YpnMo2LK0i66CrxhnxVefWgzJXrak6m27JQvqDW9SH9guofbCvLEoECno13tN/QfPFwo0CUADKxB7VXWEqIOuJFFYgUkbXFTzEpCUHSdOsPSQY4pY/FXfcp47SzK1bQNA4wpo0mw7s04+SztJ8D8TPD1uwqbQgGyOm37zWoVQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JopOeTFHkoM+jtlVu21Qwbm4LTlOGsh+v5FQ9sGjqAE=;
 b=UG5D8EHnqr4MY71yU61U0f7K2rHot9EWeagmqnD9Cqby0azBckcMttJ2GbgjKPuXopB1JZF19L6laol0btv4jgbuB6C5zdaXV+P3CqH2YMRDFc9nRJneH8RgSW2OiW9CxVGry1i2xznGzxaIixHNdlG1wilbFC4+hOxtMkyY61Gb6Gbp34++tvnFVl6qMBDZ5RuuFjmq0DdIOJcGiNLW1+blaAxUxgXC2yV1w4Ym7W9rzhQN5/yt0F3RGleIYApFn0Fkn/puZ3iZkUUe7N8cUr+4g9F6qfT1vuK1JF44yl77keXi4YYp35E3atxK9Tvp67rQ+eZVvt7jPWGefzax0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JopOeTFHkoM+jtlVu21Qwbm4LTlOGsh+v5FQ9sGjqAE=;
 b=QCGbi50MfrYxS7AF+TGmvpKDOvdPyQ6Juh+TJW5yeR23c8rWQa2sguOkL76IOVEes1Xvo/RHGjFOBnp+CYYfBkttmt0KTgSjMl4mH9Qgn788USunplrBl3o+ScsowsFbHNYt8n+bTf1TIH/i8L6fwQra8MqFLD9N4p+29Tg6A/c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3034.namprd10.prod.outlook.com (2603:10b6:5:6e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21; Thu, 24 Mar
 2022 22:41:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 22:41:57 +0000
Message-ID: <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
Date:   Thu, 24 Mar 2022 15:41:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: scalability regressions related to hugetlb_fault() changes
Content-Language: en-US
To:     Ray Fucillo <Ray.Fucillo@intersystems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
 <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cca37bc-6091-4322-3d1b-08da0de7804d
X-MS-TrafficTypeDiagnostic: DM6PR10MB3034:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB30341B0D33B3A53BE38C3D27E2199@DM6PR10MB3034.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7fF2LhAlJHP04QZSrXFjYxv6KBkxutSKDJ2bbqYFxQ5dv2Z47ov8QBhxfh4RJG/sGQ5XL5WZilf6AHunkiP4CUBPxFXAtj+mnB8OdlMHSgqU5cLTj36isFZd7U7oedhIkjxU5mXRvu1EuVMUI+xcThxUow0qa1nYsjTH2OoSj/fOCSxYwNq1Nk3zytFC3ozv2gav1fe438VqDJGbbuurigBVA81q0UC5eeVMwUFXeWLtVObGql6vorplmO6ND0VSjXHNDlWUKGRoAKIpQGxEs7dIiBZm04d27GmF5oiZEjONSrz6Yr+6Ye/fi4sGrcVWMRsZXmF1oqi32aTiyQ8EAtfyvoyeS027iBhRCmEQRYN8b6kQ3EJvfvLSRMdr8UQMJiYYZiOIyFQF2uYMZsH4clR4y1ydGx1km0/nf57A8QPc8LUHqh1FRVqjE+DfiaR/Ga6eTC63koR4pcVFEs/UMTSODJxipE7k6wwwoFQ3f2POY2agtuerKCuQWe1s3HGvkp7OrAsr9cp0f5UaI2PgQ33A21BuvSFq9uz8xEmm2kSPKIoCcOPzyFZflDfYEua2pJ2yR8XIme2meUCll2d/K9pmJQDWuuayroMr3GOMT8KmmdkAGvh/r4e+mp6elaguYhIX/xJC4eWvW+kcuQKFYUZBCS7pEFCa54z4DLT+sk1wrTdg6tibGTcFYWkPdjYTfeooY3o3918F2OfJAIWgu3Nd94wdqfEmWXzSlnDKpmwoUnD+VShaXkmh58k8BDllSAudOIrPOhg/59MLMhlrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(66946007)(6486002)(83380400001)(38100700002)(31696002)(8936002)(38350700002)(6512007)(316002)(52116002)(53546011)(66476007)(508600001)(66556008)(2906002)(186003)(2616005)(26005)(8676002)(44832011)(86362001)(36756003)(6506007)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9aeTRPSXRnQjBPdFpIL2w0alFYZXJINjhrSTVlMVdGVVk1dVNOcDBoQVU5?=
 =?utf-8?B?eTBvQkFPRk91bFYwVUh5WmpIbTkzeWlhc0JsL0UzZUNDSUlhWWJSVXcwWmJC?=
 =?utf-8?B?YkZZNVFXOFZ5dGFNdWhyZjhDakdaSlF0aytmbyt6TUEwc3crbHlvdDlwbldX?=
 =?utf-8?B?Y1NKc0RCRlR4c3REclFjUVJ6V1VoQmt3NURZMkQ1aGh0a0Z3MC92Sy8yQldG?=
 =?utf-8?B?bGpVdVdYb1ZhRlByQ3RablpUNlI1WmtsTkVFYlMwNTJqY0RXN1NPcCtLNkll?=
 =?utf-8?B?ZHcxbGJWOEVKMzVZYzR1TjVDU2lrOHVzaHVOTzFrQzc5Y0RRbFJMTHFhUzVB?=
 =?utf-8?B?ckRlc0dBdXZwNURVSjhTODI0MjZ5ZlNLdHhBa0Z0dG15SlAvSEJES2REZkhF?=
 =?utf-8?B?cDViWWFQanREZ0FFb3U3cGYwMlFzcXB1M2NkemN6bFRCaEZuN2FMM3h6dzZq?=
 =?utf-8?B?am9NRG9OT0JBY3JLK1hPQVUxWmVxbTNOSVhzY1l2enhza3BpRE5CV25VTHJ1?=
 =?utf-8?B?NkJ4YUowNnNzOFNML0VveGx5V3VTQjhnaTR3VXdkSlZHN1U0aVpEYnhGLy9z?=
 =?utf-8?B?MnhaNkZPM3N2b0txZzZ1VmcyUHJ5RUtBaEs2NkVOYzlxTnJPU0NJb0dtcWkz?=
 =?utf-8?B?YmV0Y0k5VEpuVHBQd2xaUWxzWGxaMGwzL2lZcm5jS0VoWGxnR0Rkc29SNjBv?=
 =?utf-8?B?R0RQaTdSR2Rwalp0UkF1ckdQKzlLb0FDVFg2UzZZZXVLbFd2cEI0NEF1RVlK?=
 =?utf-8?B?azJsYzNPSmhtM0Z4cFpHc3JVMWJXWGdDMXF4ZlJrcEVKQkpVTHc5Mk9tekQ3?=
 =?utf-8?B?SnQreVJZNmx6a1dPdXRMRGtMTSsrc2hnbWdjZUJ2MGFpdWl5aWNoRWxRT1po?=
 =?utf-8?B?QlNWd294cjRIcUZKS0JyOFBRZEppOTByRXRZZzEyTDFyQ3drSk9VR01zNXY4?=
 =?utf-8?B?YTJjc0VoTUtEaUZWaTRpYWp6T1Y3b05kWEJmMmloNUhaWWhpbzlTbm1sd1Z5?=
 =?utf-8?B?MXZDUDljVUFTVHZzd28wQTBtbFdsU1B2SnczRGFrZlVEeERDanlmMW9BRllJ?=
 =?utf-8?B?ZVpIRytKTFV6M2tlRzkzZkorMEI4TnNBYnA0cU16NHJVN2Vyd2g1QnBkK3lQ?=
 =?utf-8?B?TDJ0dGlMbmlRZlhzNTNLdnNYMkltRUF5TkNySlJKc1Z5YW9HYlNSKzJsZUNk?=
 =?utf-8?B?bmhDWllibWhHa3RoVEJFWk5wcUVUeXR4bVpUK1BMOHNqR0tCMWwyMC9raW9Q?=
 =?utf-8?B?MC9kbTNDZFlsUFhid3BhRkJIM1lYaDFYWEtZSXZ3RWJhb3pzMDlzMi9CMHRY?=
 =?utf-8?B?V2RGY216S1VyOW5tRU9zZGxGZml2N041bFJUMjhTVW8rRnZxd0pDd1ZvbGpn?=
 =?utf-8?B?VWdXQkFoQ0Z1Y1Z5anQ2Q0VmZWhTUTFMTm9UUW1udmhyQzZ1TkgrR05paEdT?=
 =?utf-8?B?dUkrVCtkT3lQeUk4RW4vZjNxRGg0MjFwZzZrRlBqOTkzRVRkRk9zTks3RkJX?=
 =?utf-8?B?N0tFNWpHZTZtMUpKdVZHYklJRWl5SnZDa1Mxd1o5Mmk5ZEJBUy9QNTJNc0FG?=
 =?utf-8?B?SzZmMmtOd0NsSjY1TGdOTUN2V2FVbnBnb2FlQTF4djk3cnFkQXBUa0xvMEhh?=
 =?utf-8?B?M0tLS3MwVUlqQWNJVXpTOTFKYSswUnIwMjVYY2hIZzQyT0hSV2lJS2FEbDAv?=
 =?utf-8?B?ZDM2MGRBWkhRcC9jbWxiR0pZcDZPS1pKMzZzSnpnc2dyOVpJR2dxbG1UR3N4?=
 =?utf-8?B?TkllUTBwVXZmV0p2aXhGT21nekdXK2VOSUNrMFptcXpYU1pXMHFCZUdEVXRv?=
 =?utf-8?B?dmNtSzFJNXREVG1OLzVrL0V1dC9xNWVvK1BNNmFlV1dva2VVZjNWVlZ3cStK?=
 =?utf-8?B?cmZBN2J3eVc1WXNOeW9HZHNHVmpSMTZxWGFNNGRBWnN4RlhLQ2JMNHYxc1BT?=
 =?utf-8?B?NVZQUGdIVzFQTXFwSkVPL1VSNEovTVFHR1pLa2x5NHBQRVg4US9VNU5FRHVW?=
 =?utf-8?B?NmExZHdRQlF3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cca37bc-6091-4322-3d1b-08da0de7804d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 22:41:56.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOMJBpS8n3XdJIAUOMX/FuCPjlLVB5CZvIu0zSI/jKySt4b4I7MoBasQPbA/3kHnAFSZMLUOi/Ob2yYZmv22Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3034
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240119
X-Proofpoint-GUID: MBscG2dYS9wBUmAfsPrcDFvKSb4E4jpo
X-Proofpoint-ORIG-GUID: MBscG2dYS9wBUmAfsPrcDFvKSb4E4jpo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 14:55, Randy Dunlap wrote:
> [add linux-mm mailing list]
> 
> On 3/24/22 13:12, Ray Fucillo wrote:
>> In moving to newer versions of the kernel, our customers have experienced dramatic new scalability problems in our database application, InterSystems IRIS.  Our research has narrowed this down to new processes that attach to the database's shared memory segment taking very long delays (in some cases ~100ms!) acquiring the i_mmap_lock_read() in hugetlb_fault() as they fault in the huge page for the first time.  The addition of this lock in hugetlb_fault() matches the versions where we see this problem.  It's not just slowing the new process that incurs the delay, but backing up other processes if the page fault occurs inside a critical section within the database application.
>>
>> Is there something that can be improved here?  
>>
>> The read locks in hugetlb_fault() contend with write locks that seem to be taken in very common application code paths: shmat(), process exit, fork() (not vfork()), shmdt(), presumably others.  So hugetlb_fault() contending to read turns out to be common.  When the system is loaded, there will be many new processes faulting in pages that may blocks the write lock, which in turn blocks more readers in fault behind it, and so on...  I don't think there's any support for shared page tables in hugetlb to avoid the faults altogether.
>>
>> Switching to 1GB huge pages instead of 2MB is a good mitigation in reducing the frequency of fault, but not a complete solution.
>>
>> Thanks for considering.
>>
>> Ray

Hi Ray,

Acquiring i_mmap_rwsem in hugetlb_fault was added in the v5.7 kernel with
commit c0d0381ade79 "hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization".  Ironically, this was added due to correctness (possible
data corruption) issues with huge pmd sharing (shared page tables for hugetlb
at the pmd level).  It is used to synchronize the fault path which sets up
the sharing with the unmap (or other) path which tears down the sharing.

As mentioned in the commit message, it is 'possible' to approach this issue
in different ways such as catch races, cleanup, backout and retry.  Adding
the synchronization seemed to be the most direct and less error prone
approach.  I also seem to remember thinking about the possibility of
avoiding the synchronization if pmd sharing was not possible.  That may be
a relatively easy way to speed things up.  Not sure if pmd sharing comes
into play in your customer environments, my guess would be yes (shared
mappings ranges more than 1GB in size and aligned to 1GB).

It has been a couple years since c0d0381ade79, I will take some time to
look into alternatives and/or improvements.

Also, do you have any specifics about the regressions your customers are
seeing?  Specifically what paths are holding i_mmap_rwsem in write mode
for long periods of time.  I would expect something related to unmap.
Truncation can have long hold times especially if there are may shared
mapping.  Always worth checking specifics, but more likely this is a general
issue.
-- 
Mike Kravetz
