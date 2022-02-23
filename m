Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7298E4C1B07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 19:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiBWSht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 13:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiBWShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 13:37:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDEB3F8AD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 10:37:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIEGux003931;
        Wed, 23 Feb 2022 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oXNYnhTO6ZZfVOFCxn1xr6xQgrF0aE2uKPhDk7aztsc=;
 b=jwuihuXlkyd7Zr7gDlCYjGRKEJ5f8xQAmtoa2WTdkmjMyIAjja4BH5VONnM2i5pcZkHP
 TZxQkqLyFklX2klfPYaZex3N9qwSp2jgb1EjM3Cu3lk9jjLt2IWABCqmRf21vO+MNvU5
 tUbPN7M+9OsF5URjOe6Id/vV7B9oJb66Ba+4nJLrLjPZugTgiHLML+EzrOungShzXhyS
 Wt2MBA7UGH8URlNgyYodRmmQZGmtpkvlma8Ua2sUnWaSNZl8RfEHUP+rC8ONty6UW9j/
 +wxdKQIUVtDmgvjICOZlV6sKR/UiEk1l2YyyMtesenAPC3/67q4ZfwFnM5d/Chaw+9+d mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7an603-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:37:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIaVS0114433;
        Wed, 23 Feb 2022 18:37:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3020.oracle.com with ESMTP id 3eb482uetm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtmKYmGXXlcbasMPg/eLRRZSjqYYgdwfjvuyGhdBl0uHGJLQsuO9YB1Bz7F5cTUcMknIyrCGjEBc50S4L95LyFtyD2+OyKkZNSBBWk5jCr91ZCgUych/WUcR7zxBYkyg/YGMQeR5eNQH+1M9xJ3ot8Fo+wIkQi0lbBQbqE4yR2aFxZWUtM+FzCq6IFO1Zje/jQYoOglIVatuo0UBSZsK54CV/g/jPwiKgM+Wei75504jeZEVlfhOne4Y+7dXp+/7behHKM8f5HQCT52S5DxXC86UfJJMgCGcOtF71c9nbqMJMGfZJXxBvV9f4Rhyy1aVStDi4orW00U8uJlYjG0SdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXNYnhTO6ZZfVOFCxn1xr6xQgrF0aE2uKPhDk7aztsc=;
 b=fmQ92f7lTpMtJn6JsFSZ+CADaKpEy8mEqLF2HMIboTDaK3KTOAH5PDaL5U29zboJ3OQ8JBghNODLEIFpv7vVagDirwlENglJGA4jKOd2hPJD8MOHfVKiCFk+nI8y2gBIOlqQr3zCpCMEj33aZ9zdfzbs9BRjpxlVgr0JKSRRdNQXQw6A6ldCzhNJW/O62u/dldyPP+p6n4PmcXyMfAOhs2xFH5y9Uz6UmWZ8OuxAl1vfS6DebTMwZ+lYyKJ0FRBMbZrHsGptqU7wx4qkoAzh29Ehug35PuxqhoISt5850D1wSb/jM1EzTbs84Y9buugYYXmXZMYq3jo18Lf49yYO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXNYnhTO6ZZfVOFCxn1xr6xQgrF0aE2uKPhDk7aztsc=;
 b=SWSvGnRYoHjvAWq8Rr+soCgYi8N9lHdrFJlGgMnTCPj2tN35e1KWNqOOyuqSW8mIR1ULG6izBkuJ2gjj8hyjD80NBqrbMPIarq38UeVIWcID9cFVx4cuckLpHaw0TtHYIeM3vTYLQyqRkMaqFqG5/qA9NT1NrDMw3Ys4UJlS7Ws=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 18:36:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%6]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 18:36:58 +0000
Message-ID: <d4f8579f-c6a2-2bd5-2b55-63a05b50b0d2@oracle.com>
Date:   Wed, 23 Feb 2022 10:36:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
 <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
 <YhXxXg45loivQF10@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YhXxXg45loivQF10@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0106.namprd15.prod.outlook.com
 (2603:10b6:101:21::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ff7350-b6c8-464c-83ab-08d9f6fb7928
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5171330FB5B9D7D77F3CAA1EE23C9@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgiGkyCKkZD6DKtfO0xHxLXTLMnTMP21bJihK6HYHr2nbhkmLQeWbdj/WeuimkAzdEQWwy2Ugl2Y+kNS0QwkeJLscfPg5CcZ771MuWI+H4eoS2Bx7lk5DxMSJXtKaLgr2Sb5WTJzsSufnGpYPjvf4moOVDZz7tF50jnSBxEZjygHsCsbnx1O5Uy5gtzxcHl60oRz6QM2RJTnjHXigsmz732HKuMtivEA34zJHBZnq9pbpau1VYRjrmOGk6kXfp/t/p6ams5fhwpAbzwejam8vtsLf8IUZME2PEoYfLGn1xiQAH2yZ1cWkTtZMpwSFD8ItJ3oib+u7Fwlaef8lD9dfgtgDQyxTfF1vKXTGDCUOFmEMXnDJ6YtV00KKv7RJAYPkjPmrMMqp1b34Q2JMEWiYg/pcMuWj8YhyNpcvIt/LAawa5PTrUox/Fwf4XnQ/HJH8HsZhU4JUkeV1kmJol8TBy+x4LIDOEZUhi/Op2YlZGqGAWAKOFzu21ToXMu7fi0px6sqqh+UeOv2y4N6YW0rwoc13kNmbT/3WXHgPBd5OELXFgSEDO5TGyw8KOf3+cHh40//34z6XubaYJUBTK3j3Gv9nfSzdFU7U6egMmy5+OIQ4HMn2HJ75nBnsC87srR9KuZxRc4BfDS8AkPLTYV17vsnxxoQ1/Lq4zxjNoXB1ArI8jHO5FZ9Vfcv4YQb1TyLxmLExm5D9guIq9DNKbo9zLPzDXDMTrH4uKhSQqAD3Fvkl6K5HkL9GDUqB0PTAcZ3Qe47+2UvKHK0pCItHC3oOiHGj2LxEVYT4SyDryk1YN+72vZwX2NN6oiiYIehGxr6KhWJziIgr4FJ3Hpd8RPdzt6ijLU8aYk/C0W6qiw1JtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6916009)(36756003)(86362001)(8936002)(5660300002)(66556008)(6666004)(53546011)(52116002)(31686004)(6506007)(31696002)(2616005)(44832011)(54906003)(66476007)(4326008)(8676002)(508600001)(186003)(83380400001)(966005)(2906002)(6486002)(316002)(26005)(38100700002)(38350700002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJLNUlTdzR3bVRtdDZ2Y08zQmtEZmNTOEhobU9OWDBRSEtjaWhOUmt1Um5O?=
 =?utf-8?B?dUtDek9nUXN6dGRFOU56c3BaQ1QzYVVpemlJbmNMMTJsVmhoYmJSRitkSVRx?=
 =?utf-8?B?b0RUeTZVSFdqQ0g3NkxzYi94WElObUI1RjdORU9JamhNaERITXVMQW0wUzNY?=
 =?utf-8?B?QUtWS0lTS1dDK21vT0htVTAzbWM1MVo0V1pwMjJPckpHcnRFck96NGFpRzVZ?=
 =?utf-8?B?T0pLem5EWTFncEJZLzBJY0RseCtNdGNudmQwYlpOZi9DeWF0ZVhzM0U3K2Zv?=
 =?utf-8?B?MjE0N1k2TG9EVWFZRlpPQXJEVVFVRU5wZnc0UTJhMUxnZU9TZE9oTlRlV3dW?=
 =?utf-8?B?RDZXVFl6am9mVjhlY1lvTlFaTm4wbENhR3BrSXFONlJvN2hoeTg0T0F5M1NO?=
 =?utf-8?B?aDdzWU43TWN4U2U5ZlJ3bWpacE8wblRyb0R0TkRMRFBPMnNTZ0s3UmFzWVdv?=
 =?utf-8?B?TkZYZzYyY3JsOW9qSit6aFpCYXU0WUwxUEdDcVNDWHM2azVKc09zaHBORHhW?=
 =?utf-8?B?U01TdVZ1Z1pQUFlrNnpFZGh6RTJoeWwvSWNUYUdmMUNsenpxVWRSWlFEUDFB?=
 =?utf-8?B?c2VldXQxc2V0M1VoZCtyQjBNejYrMlNyYVplbTZyZU9iR0FyS3pHU1BCTGVw?=
 =?utf-8?B?a0JrN0VjM2lnL2d1VkFCUDdacnhCckZQdXc2blN0U21rQzBkbEI1ZXJYY0ZY?=
 =?utf-8?B?dThPSUtvakNQcVdpNFhNYUVaV3VtU0JOZEJrYUl2Z1AyTHBYc05yUGtaM0tV?=
 =?utf-8?B?Nkt5dHVLWVczT2FPbUloeTB2YitSMHdoTzBDdUZRVDBMQWxsZ0xKaXY2aUND?=
 =?utf-8?B?TEdMMk5OQ1pidm0zNnlYU0VUOVdURXlEVVJraXhmZmxXbXlva1I2eENoNWp1?=
 =?utf-8?B?OWRoVDFaK1p4dHovb3FFbkNqb1h1UE5VVXozZ3hmWkhpK0dMK0lhdTdMclpx?=
 =?utf-8?B?bnpELzFtQ1pRZURDaTh2bzJ4bHU0T0pnYVBSVENPZElBWU5uaG9jQy9wVDlw?=
 =?utf-8?B?NVk3cE1sRllqVG41NzdMOEtEWkNjbFk4cGI1TlB6Y2pKY3BuVmxTVS9LaVJw?=
 =?utf-8?B?RmFQeUxaMXRqL21ITFUwMEFYN0hDbDJmMytnWHRYOTVaZExpTko1dWxNOVlM?=
 =?utf-8?B?N05iTmtiRU1QeCtrOFRxUXJ6RUd1QUIvd3B3WEtyUlpyWldBTlFkTVhWUE1v?=
 =?utf-8?B?RERQZ0QzdkRhdmNTWk1UMGcrQThiWkNuUkNDOTZTUEJudW9iaXdtTEFUSTV4?=
 =?utf-8?B?MDBVTWVOekprcEVOS0RzSVdBWllQUUZRNUV4V092Z213dzlmb3poMVU5VDlq?=
 =?utf-8?B?Sjk4Skc1YXQzYmhHZlVNaWIzVFdTaHBRQ3cxeHpKaVowc3N4bjkrTEpDMWdq?=
 =?utf-8?B?Qnc5ZGRwdVIxblN1VTh1YjVsVEVrK0M1RW83NGlHbnhqNWpXa3FWZXVaK01J?=
 =?utf-8?B?WnRtNk9vQnl4ejkwRXc2TWYwaXYzQk1hdzZuSUxJUmhJSlliaW05WU54QUJr?=
 =?utf-8?B?ZVRzM2N4cjIrS2VLMUNxQ1hBc2tyYkRmRFRxOGVBdXJBSEV1Qm5Eem1heDVm?=
 =?utf-8?B?T242ZTVmNHVqMEFKYmNCZ3drMkhjWHo5Q3ZGNnMxNkV0WUZzN0RvSWJnS3Jw?=
 =?utf-8?B?c1FPRWo4YkEzTDlMVk5JVFlGYjdheHZ2OExzODlCNXJhM3BNVW1UalUvdnFR?=
 =?utf-8?B?MjZseUJmZUtNRWlNNCtNelJVRyt6OWxCRWY3S0lZeXlKTjNQcU5mNGk4d3Ru?=
 =?utf-8?B?SXUzd1FvWUNOMzlyamt2U0FidCs3ZEI4RFA3SU01V1E2SzZxK2ZKMnV5OG9D?=
 =?utf-8?B?WXVmSzhZbGpJakZFWFgvRE5pdm8rellsRm9SN1pzT2QydkxyY1p0MzJmZnNG?=
 =?utf-8?B?NXRJSDdtYlZUbHB2UVlLRGE2TXhVY1RndXlmOW5nSExMMU4xNzU1LzBvekZi?=
 =?utf-8?B?NTBhVGZCaFVQYklBK2o1Uk5yb1oyamNyemJ6czY3d0s4cmtuYWlnVHAzQjFZ?=
 =?utf-8?B?MXg3YXMzNE44bGU0WGhRTzdvNDIvRGZYbVhGQWlXdTlTRlAvVHhwMGh5WWRL?=
 =?utf-8?B?OUJucEhGcFd3RkZSWVFHNnlTckxjWjV3K2RsZnIrNEV0UVltYVlpdlRhOTVM?=
 =?utf-8?B?Tk9wbDUraFRHZDRvQnMyM2lpN2EzVEZmMVBYd2pkRjQ1UWt3RnRNMmxMR3ZF?=
 =?utf-8?Q?WX+EOhz/T3NVif5EXOLTTEw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ff7350-b6c8-464c-83ab-08d9f6fb7928
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 18:36:58.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DecLHUQ/jEL61TEVhyLJ1z6nfDiHNbqcUMsi0G6DGUxVOb/vellTZc9f1IkXiFWC8IA8tPUczuCmeiNy6OtNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=784 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230106
X-Proofpoint-GUID: K_ekLrd7haZIngSvUhjJZGrWvEIDMNYh
X-Proofpoint-ORIG-GUID: K_ekLrd7haZIngSvUhjJZGrWvEIDMNYh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 00:33, Michal Hocko wrote:
> On Tue 22-02-22 13:53:56, Mike Kravetz wrote:
>> On 2/21/22 23:47, Michal Hocko wrote:
>> How about adding this note to the commit message?
>>
>> Note: these routines take a user specified value used as an index ONCE
>> during the boot process.  As a result, they can not be used as a general
>> method of exploitation.  Code changes are being made to eliminate warnings.
> 
> This would help but the question whether the change is worth remains.
> Does this change have any other advantage than silencing the warning?
> 

Silencing the warnings was the primary motivation for the change.  If Dan
has a plan to change smatch so that they are silenced for __init functions,
then it would be better to not make the changes to use array_index_nospec.

While making the changes, I shuffled the code a little and did not immediately
notice that it also 'fixes' an overflow/truncation issue when assigning an
unsigned long to int as addressed in [1].  We should probably make this change
whether or not we use array_index_nospec to silence warnings.

[1] https://lore.kernel.org/linux-mm/20220209134018.8242-1-liuyuntao10@huawei.com/

Thanks for your comments and suggestions!
-- 
Mike Kravetz
