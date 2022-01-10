Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA93489FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiAJTFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:05:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40262 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242273AbiAJTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:05:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AIwu78018262;
        Mon, 10 Jan 2022 19:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FeLEXjcoSfGjBLT/zVMTX5ZaZ+6PuLKEpeuZJt23z5k=;
 b=n8aQraWy4H/lBd9srkWgOzR/SfalMu+Zc6Bv58DTP8Rpwxj5GLnKKI4yz1A22u5fncJy
 zI63tAiZNE7q26hVicQSZopcyVIcovxt54zRmPPrZLIfDN3LvqGzvqPL5aZE+oIT95r0
 G3OX/+LKs1OxU8jNxCc/OScLqCdj+ZiE9DgpHe1GCYnm3eWALIhG5AUVl3jxemgUzw/I
 tK6qyYtltYeA9aq6ObPfS+PfOYypz68E7rU2d/Wk5yBuKX79GFuEMd9SY42OC+hho2/m
 pc1APBpo3snroqh1uggvvLeysQL6wFRNXL3ACyDcKXI3PjNQjmfcBD1c0h48lq7GP5vX BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbsdqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:05:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJ0Q9B139090;
        Mon, 10 Jan 2022 19:05:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3df0ncygd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:05:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlHWqQIHwoP7QkPlgadfYIyQdPmNlnLI/jcZAQMJya2rsxZGqANOoqHAWsTkMGw0BxXoSTVFi1hecbvW99tHDruW7PTbbfXCFbMExRIRU1JKEIgfQhWgYpW+70ZdATmebJq+pe53abPNQTc2THISS3h/csUviJqIeyvzlRAH/byY9J10NAw/TV8j20frZbD+930sEvbFwPZ4SvfqJvr6dhEr05R6aYM+09M8Uu2QkxKrbWlc6daFHr46XrUr2EX7GCKBluQIRIrYYZJK+jZ5AwEikfjJb4yL/afeD+tj+GUADMwInJiaORqEvujO4GWAmHWiHvQWx/N4GUHZT3tHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeLEXjcoSfGjBLT/zVMTX5ZaZ+6PuLKEpeuZJt23z5k=;
 b=kwcouRnMVvBE99c14zZMiSr45lSCY0Kfjc/S8vTL/f9eHmTr/EHjJC0nta7tiXiy1XsNU978Vtyfwd5HjzHFw+keJcDWLerFes1041dAvP7tiCZXff8zX/36OtvraM5vP26l/qEOZ47GdGS0kC8aHdOneXtMd1MU+JruYFlmiVC/DYfRJmsdbMckgspnsEyCRbsYsOBJwsG2eOt9xva8rptXhjXrkai84YUP0cYkoquA+J8MWU3hwBrHOKysJWtysFuArV4rpy83oujVqC7xrjRNlglAmBxaFibPpLWJsDDgkjcJsLNVuCcS/YbzyuQrXqXn+EVmaSSJROxaZ7cT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeLEXjcoSfGjBLT/zVMTX5ZaZ+6PuLKEpeuZJt23z5k=;
 b=T/hRjJ8Se50zxod/c4MXp44T9Tj2bc2w2ceGPyf8bA+KwKPbmS06LxlHughCD6Ci3nKUAlrWPvYvy0pKNehBo8bjNvR+SRofOj7vIESDY3TtgzSy4fLlPlt1yw0C2RJkM47/xpCJfR967XI+G33uBlyh3UKo9IgvSP0xkhhYe6o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2455.namprd10.prod.outlook.com (2603:10b6:a02:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:05:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8502:19a4:8a7f:ea73%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:05:21 +0000
Message-ID: <c19eefb9-76ef-5e03-50e2-8a90c20a4c19@oracle.com>
Date:   Mon, 10 Jan 2022 11:05:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [External] : Re: [PATCH v2 06/28] gup: Fix some contiguous memmap
 assumptions
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-7-willy@infradead.org>
 <YdvuhjweiC1SjVF4@infradead.org> <Ydw2iQR8fT+qGkz6@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <Ydw2iQR8fT+qGkz6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:301:4b::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab2acdbb-22b3-443b-9d8e-08d9d46c2660
X-MS-TrafficTypeDiagnostic: BYAPR10MB2455:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24552CF36F67F871E81125E3E2509@BYAPR10MB2455.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqo44oB/DbcZLl1igZ8uJprj0rbs+ZuySr+sqXfVpW9Trg937S1NIUl+eeUxAUYkraR3Wdj8IA21Ih75e7yvp5Yyk4ECOqgrO6Mt3MwusBL7ikp/eVCUWwbp17rQIiiFg73mzLiDvii+wvP77wJ1U3d+JdC4QbrLQ9WQ8V7fXFFTqpM430FPyu3/YySoFkr/aZDj9wV8pKg/lDjR9Kg2SCEB8YtyVh6v6F+iXqzo+GDWYCnlfrnVTQghlrpRuXUnf39KEGzs64hyBKjeFB3njSUnEsjLKvoQnopr6nIkNl8lTZwHSyZ/n+lDkCYFuYMOkJggJW3yL0pUIskYHYHM5nZgsOVJtQSrJwhl/lMyd2TPFatt0insrNSy1odYGsGmVeldmaeUloIFidFc95iT4Xwxi/ACQ+3ch4/+t9vSWWHU3vyx0Dd4m2aHD87QVUQn+KvSiKrMWuRsjhf0n07izldsh2jqO0GGSLlb6nqmEjRE2u7Y4mx6AUGuBOfXAtd7NTjHJYgUxc5I7cI2zX5kF1m9PFoDtAhxLqwnIUNhECMzXGQE0l1LKLLPYKZ6YFWrCORBMkiaZsvpJUidxMC+oP/JB2mmGWyKh7/cI16rox8oiWxNvl93CSZh6Rz/MEOw/0dTzHGvlybal2Y7b4JRqrvUlwb5M4aCM9gW3HGsZjN9MYJ0b1VKe7CR5uORm09V6s/Rox3GbpaXIhZgCySxBRgpSGjTfDvyp7HU3O9lZWrqLwU6Om5Iqka9YZQqC5KuS/H5BW2MgVaB62h85kEQ0wrvp3Lbx93YufEBhDdIkar/7p95DDcJpeYQvt+VX4ALLFMIjkflPdsQQHyIOx8TJSvU+EBFMSlCI+jPBxLwkNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(52116002)(8676002)(2616005)(54906003)(966005)(110136005)(6666004)(31686004)(83380400001)(6486002)(66946007)(86362001)(66476007)(66556008)(44832011)(26005)(5660300002)(4326008)(186003)(2906002)(53546011)(6506007)(36756003)(6512007)(31696002)(38350700002)(508600001)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVqeVNMV0pNQTgrOWZYdUpsc1paZXY1ekNBV3FsaGY4WFdyZm82Sk9adldS?=
 =?utf-8?B?MmxPbUJoN1lHWU1KQUNyYnVRYzBSRWxLbCtjRWpBWERKc3h4K0lWd1dsa3dO?=
 =?utf-8?B?b1p3cEJXeCtiL3JQTmdjT3ZWaWpNUS9TNlBlaW5GdnBpaE9QQWdPL0JaZlJS?=
 =?utf-8?B?VVU3amVac1NpMlVUSjNiWkxkN1ZnQXQzMXpsMXo5cHNGWHV1NVlSR3QyTjZW?=
 =?utf-8?B?Zm51T3hweEQzaWRtL1JGYjhCMGlXSnpselJzZVNMUDVuVUxRVytDUTg3dmZv?=
 =?utf-8?B?dlVFQUMyT2RPYVFlTm00MDdZWjNPS0g3TFZZRTkzZ2puaDBoTUVwS3FCTm9S?=
 =?utf-8?B?dmRpTDB1OFBhRmpiMm5hanVRU1dud0FrR0xBbEdOQjMrR3N6M0VsWUZQSEU4?=
 =?utf-8?B?TVl1dUJ3VmNwVU9Bc1d3WUFaS2ZQUXZHYXEyblhYRWxxeUVXZm5hMkg4RExW?=
 =?utf-8?B?VkZ3YlZETitSVlI1cE5KQW5FZDI4cGxka2tZVTg5eW9GRmpBZnhsMmVRVzB0?=
 =?utf-8?B?eGJXRDBmNUxEMlo5bzdMVkZsYkhnV3ExUjBISFRsdjZGN2hKL2FxQUR4cU9V?=
 =?utf-8?B?eFczMkdtOG5Jc3kxcVJua0NOWjJ2Vm1rUjNmMU1Na2hiajV3WG5WenU4Qnc2?=
 =?utf-8?B?bnkxODJQSDcvT0l1NkNtL0VqMzdRbVVwUUdZQkoybWdnRGxpbVdxTzhsUjhh?=
 =?utf-8?B?U2E1dUF0RUxyMGY2WkIwaEFtY0xIa2N1YWlDbTNwQlc4cnkzbm80Z3krNTB4?=
 =?utf-8?B?TVJlSDF6Y25OaVlJbXl3MktYU3I2UC9wN25wcnlEOUhoQWc0MmNXUnA2YTh3?=
 =?utf-8?B?QjdILzdLTzVIVExid2krQVBFUUVSNGpCRVZQcWhYazFOMi9lTTN5cW9tVS83?=
 =?utf-8?B?aUZMVGJFS0ZGQVlCMlVIMTBVVC9DK1dIT2RsbHl1bTVNY3VXYmNRTy9SUndZ?=
 =?utf-8?B?dkU0QzdRTW9vNFUyWlJQTllHU0NxV0Z6SVI4amp6VTNjdEx1MzJFSW9XRmww?=
 =?utf-8?B?dkpEaFF2cFN5Z3puNHFXMjdoWG5OWG56bjNNVGdOK21YaldJQU51UVV0Mmhm?=
 =?utf-8?B?WUJuZ1p6SjRuSlRJNlZFOVhHaGlMWUZIeWtXTnRia2FrZ0FBWkpNSzhCdkVT?=
 =?utf-8?B?ZGFsU1lqS01sS0I4OGRSdGRjamh0TERxcU5rM205aGlwd2tZL0x5ODlxZitT?=
 =?utf-8?B?c3VWcGI0bjFsVU95c3dzSnUvb1JMb0hud0psUkVXU0E2aXJLRFMxajkxeTN3?=
 =?utf-8?B?azYwZ3Jjd1VyYUZKcGtRWnFmS21FMzJ6UnlVamZDUjRxYkdLL291UmdDRnZM?=
 =?utf-8?B?cVdBWS9zZFpGMDM0R05vUC9mc1Nta0ZQd1hITTJXWnJ1QTV2M2lTMG94Ny9O?=
 =?utf-8?B?UFd4NlJzQmlmYzc1YSs5ZmJtc2tCNDRhNWI2bWlqSFB6QXRDczRQRGZnWVEy?=
 =?utf-8?B?dXRTYkxBOWlTN3BVV0tydXVoY2pPSmhPdVFNaEtCN3J5TGJBdXZzeWtGZm05?=
 =?utf-8?B?b2RuTlowS0pMUEl4WEJxYStaVS9sOEN1ejVRb0FTd3RaSCtJRGtJcVIxT1px?=
 =?utf-8?B?MUxKczcvQXNiN0xkQmV5ck54emdHMUM3SFhoZmZkcjd5WFZObVQ4RkM5dXlk?=
 =?utf-8?B?dHlCTGh5NHZ2RzFOTEZhN2dzdWdYMWNlQm1rbmJncnRLNEF2bDJDQmsvd2J6?=
 =?utf-8?B?QXUwQ2NQMXZ6NTVubVhNR3NHOVZ5K3hoL1B0K2hmcThxNWhrNUo3WkNHdDV0?=
 =?utf-8?B?VGJjM3JCVEFXUFh5SXBxZDJLVDZvSG1rUTIyOWxZb1VXaWNXNHdYbVNBM1Fl?=
 =?utf-8?B?OFNPZXBjQzNRQXpSZlZFZndyWU16d3VkZDdoRHdSS3J5aE5Yd2xaTGtjWWhy?=
 =?utf-8?B?QnllUVgxak8yajRtdjZMVVorekNVN0VuYTlwOC82VDR4UDROY3ZtVjZKdkpL?=
 =?utf-8?B?SHNuaThEWFJJZjYrbGpCRlQwa0s2aHUxUzMwaFQyNnhIeW8xcDZmQnpzUlRr?=
 =?utf-8?B?SFJEU3YzbGtwVkM0UDhMbkxnTXBLK00rL043K05aczFhMDZXUDJ3L2hheFl1?=
 =?utf-8?B?TVJqWGRmekhYUEJNU1VqdkZUVVoyM3NjMGhjOFN4U1N6eEw1WUU4OXhLMDNz?=
 =?utf-8?B?Y2ZJbDlqMURvb2l4VWJKTWM2NkFHZmVhS054RndGc2IrTElMelpwZmRKYWxs?=
 =?utf-8?Q?9z1nCO6QNjnRVP7XGkkPvQ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2acdbb-22b3-443b-9d8e-08d9d46c2660
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:05:21.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOdnzGmx6VM1+8fx0SoY4xOCUYh615qVWKhffOjyqQlcTqIBuaN0pcr3BHZ0bm7uwpG9vAKe3UdZfJ+gL+/31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2455
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100130
X-Proofpoint-GUID: 3upw_r42Qqd_FAcJJWkvQvop7s_cjjfU
X-Proofpoint-ORIG-GUID: 3upw_r42Qqd_FAcJJWkvQvop7s_cjjfU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 05:37, Matthew Wilcox wrote:
> On Mon, Jan 10, 2022 at 12:29:58AM -0800, Christoph Hellwig wrote:
>> On Mon, Jan 10, 2022 at 04:23:44AM +0000, Matthew Wilcox (Oracle) wrote:
>>> Several functions in gup.c assume that a compound page has virtually
>>> contiguous page structs.  This isn't true for SPARSEMEM configs unless
>>> SPARSEMEM_VMEMMAP is also set.  Fix them by using nth_page() instead of
>>> plain pointer arithmetic.
>>
>> So is this an actualy bug that need a Fixes tag, or do all architectures
>> that support THP and sparsemem use SPARSEMEM_VMEMMAP?
> 
> As far as I can tell (and I am by no means an expert in this area),
> this problem only affects pages of order MAX_ORDER or higher.  That is,
> somebody using regular 2MB hugepages on x86 won't see a problem, whether
> they're using VMEMMAP or not.  It only starts to become a problem for
> 1GB hugepages.
> 
> Since THPs are (currently) only allocated from the page allocator, it's
> never a problem for THPs, only hugetlbfs.  Correcting the places which
> can't see a 1GB page is just defense against copy-and-paste programming.
> 
> So I'll defer to Mike -- does this ever affect real systems and thus
> warrant a backport?  I know this doesn't affect UEK because we enable
> SPARSEMEM_VMEMMAP.

I guess it all depends on your definition of 'real' systems.  I am unaware
of any distros that disable SPARSEMEM_VMEMMAP, but I do not know or have
access to them all.

In arch specific Kconfig files, SPARSEMEM_VMEMMAP is enabled by default
(if sparsemem is enabled).  However, it is 'possible' to configure a kernel
with SPARSEMEM and without SPARSEMEM_VMEMMAP.

This issue came up almost a year ago in this thread:
https://lore.kernel.org/linux-mm/20210217184926.33567-1-mike.kravetz@oracle.com/

In practice, I do not recall ever seeing this outside of debug environments
specifically trying to hit the issue.
-- 
Mike Kravetz
