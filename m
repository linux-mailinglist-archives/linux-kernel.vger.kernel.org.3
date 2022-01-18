Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E40493100
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350030AbiARWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:47:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5410 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344558AbiARWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:47:39 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEEMs021250;
        Tue, 18 Jan 2022 22:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f+xmmp0yILBW9zO/a9O30NDq7DxiKeeJjO9dCKGUGfQ=;
 b=Abpi6tLSKQsWf/wdzEfBp1M9faGgaEsSjdpdl5cthnc+fnNP68PLd8EKepHqXLzN+C4a
 J2d0K61DCEDr8Lf4I6IfqYCP+luw6sN9Xlb69jPbA+RO0d3QK7+yJ8s883VYC0AZUpjS
 vd2dBnmuH6ek0kEmcVGvD2XTXYONF6xOEE5+3ZUlWFc/QEB/kbMSLTtrVHdOdjeuMZhr
 vuTH3dD+Cn3kw8hVQcJBx/9PhsjQ+RwLo7LpJxEOJFW/R8O1E08lHtl8wMwcjxA2q7GX
 +tBnQNYoCi0AOXoyf+ZlMsqiNnKnTCkRICBomXrdq0AjD5XNcf8fNH1MpTObvJsCbv2M 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q3fjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 22:47:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IMQZuW016645;
        Tue, 18 Jan 2022 22:47:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3dkkcy5t3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 22:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyn67xJbLdbYV1+appdJC9pZ/TcAUTO9z7xLx2A45vTuKsdI2NN05FNsdgfSD5ikfbDdUzaMpbrDJEnznVkBoKkt9ZTLD2ubqTBiOTcAfQG/T1QYYUF+8tRaTOzZa3BupsEp22DliUGTE/aP9+HXbtUDpCTY+rzaDqww7B/j8ZRFgzmRqbekU83ru1/yvwHzBT2zTH4y5qtevUEr7eyaAfA6rUD8eTTV+pBmhKDIXFijocrSxxqtjt8VkRav4EhssgeUFg+oydnUZ9ISsbJgCyZScQBXmgKd69USxjFz1FJHoxcma74/QQLNt8yPvWBm/bsZkQTh4kcr7WC2cphYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+xmmp0yILBW9zO/a9O30NDq7DxiKeeJjO9dCKGUGfQ=;
 b=Myb9wJL5JwWco0tgPwRLMrcwLNQFUkplvWEFYmG2GWyCsrwQQVDFMnyX42fDN2vBhVx+XdXaIrfTx2Qz8Z+EkIF0nMLpEvgSnwdSgJrwxRB2c0i46aIWOR5vYk02sb4ux7Iv68GjN/1udu2lNWFvcoB8kPIfyPrrtdbqsYQCXeBq2x7ye3A01QGkhNr9Q3zPh5fL+7+aE41z9PGxyNsqL91flqwcMkSplrteXT3vGFhbe8RqsHjJ6ahW3UVHOyk1aYOeCqrfl2u+JAhseGb8d/5MiJG9aNYVXC1/KSjLt0/9VQQVgHNG5QDPCZh3Hjz1rrAbfYLohBItXhMORATgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+xmmp0yILBW9zO/a9O30NDq7DxiKeeJjO9dCKGUGfQ=;
 b=WXpMgJSGyw1VtyCIfCrpWwfsYG5LMNQ30VFrZBgsYrNLYi7fQjd3dDte4fMWA/Pu249CI+eAjixkkoKJbWHUrvxcLMgzzZg0+NnX1kZAPrCcqNWvPyQmqjheVS58VjZApNd4AgiZK0QwC/roHtYHsxj9T4sMXbT7J+Bj1u+StRM=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BLAPR10MB5219.namprd10.prod.outlook.com (2603:10b6:208:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:47:18 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 22:47:18 +0000
Message-ID: <6920ea3c-5833-952c-5530-b02560e307aa@oracle.com>
Date:   Tue, 18 Jan 2022 15:47:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, rppt@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <eb696699-0138-33c5-ad47-bfca7f6e9079@intel.com>
 <Yec1OZ0reX2EMXL7@casper.infradead.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yec1OZ0reX2EMXL7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:a03:80::18) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e40a4ba-9cde-4eb5-6f38-08d9dad47b50
X-MS-TrafficTypeDiagnostic: BLAPR10MB5219:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB521961D517E97ED335643A4C86589@BLAPR10MB5219.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPxhjqyz5hvr0UGJ8plHlEBg0KnLmwDfUKP144//5xeJJG2z4gz2rUD05Wxzvn1pbutKKPdyVM23TKF3QGqb0PsiJROBNl9LrnSYPQ3Xiwy3RuoIr38/JRbBBCXF7R2UTv73XsjtavBHS2cpgM0WRy88yK2zVPDPK8uopvMFBCi0js/JqHKhDLBcjcFUlpVhYdlcFST97RvM99txioJt1E+Jzbz0udaHzSXFQ6cK0ssxxUq2OYiW1vWfxG1WA6wQnGI48mh2gq4CCnEIc4987/d3CIlJdoPkHAXKUp+dq8ZmRzUb4IA9rUNCYT92PI/rdqKSBY8D4oEgkzT8MvmbR6zRNIWLsJoWvKFgfKFNGL6WDU4uHuGM/rbpREIna2faRCZ6TzeHs0hVo+TpXUQNnpTX1wtpnoQ8HAB0rlxi1zQdwREt57VPNQQnUaBoUlOUVuPTd9BQtR2fJOZpGhRb9lHCrvu2SEheUnrVtbVSPRDan6uRSzaprviztCAC22gWph3ikA3lw7x8bkuJg/+Sp0MVpeWvyas3BQd1+blv5yWTvU/+9pwTQ56GOh+xGbV8y2ECEb3MiUafy3tYkns14lSkIv5CCY2AKSoxXFGD8s7XzT9JK3b2ge6/gGQY7YUPK15VeXYtEBJqEdw7lmWb0ksS7zVFelKmFYBzPJKmCZKxY+okfmCDhBRwBkFKgS8CqchHSvM12NWT6hunLG7SDadHCGIoRElOJlGUVEEn8onOQZTwIf/RzFIFIHOSpF4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(44832011)(31696002)(8936002)(2906002)(6486002)(2616005)(316002)(8676002)(508600001)(5660300002)(38100700002)(36756003)(6512007)(66946007)(83380400001)(7416002)(66556008)(86362001)(31686004)(110136005)(186003)(66476007)(53546011)(6506007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzNxdmh3OUJLbHpOQlRDWkJHNWRNM0ZMcjhXd2VhU2V0MjAwRDdtVmRCWFpW?=
 =?utf-8?B?bC9aRE9mMDB1Vm9oVDBBNXpKcXlKTFQzbEdPYWd6MW1pVFhDd2Q2cUc1YW41?=
 =?utf-8?B?akNKZk9nS0IydVl4bmpQcmt2bEtMS3pxMW4vMW50QXVEWmEwU1AzMlUwQ0xv?=
 =?utf-8?B?NWdYMW1BWGliVUFKeFUrbVl0aHR6ajgwZ1NnM2NsNWJrSk1SZDlDMnR3UlEx?=
 =?utf-8?B?ZitrbjdRYTM4U3lNVkl1RUs5eWFHTDkzWHA2RVFBRGJQdnp0UjREMHJTUHg4?=
 =?utf-8?B?ZVRYc2F1bDV5NGVZUjFmUlh5TGE0R0xGc1FhdUNGOUJCQUtjVHA2eUFMcXc2?=
 =?utf-8?B?cTJqcXUrcUlWOWNxUnhIaittK2lKVUtrUVdNclVLanpCTkkya040QU9mYnJv?=
 =?utf-8?B?SkkvcC83ODdQOGFIc1dGeGtaQ3l5RHhsKys1bFRaNkQvRGkxb2wrc0ZXQVhl?=
 =?utf-8?B?UUhnRTNJV042bjE2NXVZWHZURWRvWVpLYW1SNVcvUW9Bek01NWdnd3U5MHdi?=
 =?utf-8?B?cncwSkUzcWNFV0pYcHZyNUdvT0tlRTZHaTV1UVg1UHBGeVg3TnQ4Q0IzQVF3?=
 =?utf-8?B?R001SVFYQzQrRDJ0OWRTaVhKYmFLNmMxa0VQS2piaWNhaHRPa3NsT0dxVW85?=
 =?utf-8?B?Q3hSQ3EvazdMdjQ1enpvenQ3Z04rbzlGUytNQTkrOE5MSmZBRWRKQnR4d0JS?=
 =?utf-8?B?ZnFWZU5EdVBoUFZpNngrdGM4a2NWRDI0SWI1LzlaMk1nS3JsclVvUXVoL3Fp?=
 =?utf-8?B?dUpHV2ZpN0ZTWGJUbXg0dVhsYUtBakVYb0xxRjNHRHFPbmF2ZzA1L1BDaStM?=
 =?utf-8?B?b0J3N01IL21aSjRLbnUrdlFOL3ZDanpReTZOekJLRkV4NUtwU3RnQ2JwZ25D?=
 =?utf-8?B?MXo3eEhxQWVqY2dqbGJEYUNlTmxjb3o0Z1JyVkVubEI3Vzg3ZXcwbks0SEJK?=
 =?utf-8?B?bW96Zm1naFFNY2dxV0pLTStIejIxMTlJSjZYNmRINEg3UmtXOWV4Uzd4ci94?=
 =?utf-8?B?K1A5V2djci9kemNBYXptV1YwU2ZvT3FVblZYVk9wejJmOGxybXB6SE1ZNldm?=
 =?utf-8?B?WkVGc0xmWG9SZ0VEcU1RSlBsZ0txTzBjWWZ6ZDcvYVZYdzNYZUQrYUtmbXhD?=
 =?utf-8?B?TEZMUnVrVXNMZERTZ1Q4YVFJVUN1YnE2ZUFLendvTG9OZWNNNjdIK1IyL0dq?=
 =?utf-8?B?TnFEUDlMcW9pK29vbFZRMEV5M3RTL1htSUNEYmU0SkRjN2JPaFNqMkZnMlBE?=
 =?utf-8?B?UllwQllQWFVjM0hpNWZvUC9vUkc0T0d3MG0wSTc1UW8vTVZQamlPdjhnN3RB?=
 =?utf-8?B?S1JoRmZWNXRZVnNqNktERit3NDNGQ3djM2N2c3hXY0xXUmw1R2ZyZTlTNFg2?=
 =?utf-8?B?TUxCWWo5ZExIa3J6MFVqZDYvZExENUxWU010NnJTTUZuMENwemJtbGd3Z1Ns?=
 =?utf-8?B?bU0wQitRektWZk8rWDNsSHRTV3FWTXVISk81M0REYmFOVzU3MldSMHRxVjZK?=
 =?utf-8?B?LzdKZTg0N2xRdFpXQmlMZG42OVhwRDlDNXhjM3p3cjZSYlZhaVVEcHIvSHBO?=
 =?utf-8?B?VUR4bGJYbWc0QVpyQy8ycGNwN2dqdXZhcTdZZmxiYWp2aUhadlpmRW9kemp0?=
 =?utf-8?B?ZmxiM2VQU1NhSkpxZTgxT3lQTnA0OEFaeU9weXlBY2JqUGF4WVpEYlo0V21h?=
 =?utf-8?B?WGI0QTRaNlFuR1JVaW9VMWtuNFNRYUNuODBseW1yVjlhalh0bXV4OWdaUjY1?=
 =?utf-8?B?OWpPTHR5dGxhb3dWMWZQNmdtZFc3eGFSQzBzc2FHYlRCbldzS0RuQWV4TUl6?=
 =?utf-8?B?STlTR0ZXT29VVFUwbDhTQlE2ZXVFMWQzYnZJVVFHdjFLYmV0ZkdsRXpGVlAx?=
 =?utf-8?B?MDhvQ2lRRHhycW9GOUNqQmR3alk0VnYvaHBOU2NSMVhEZC9UZHNXdC94YXRE?=
 =?utf-8?B?bkxSMnVoMDk1bFRxTVZpQzBieHJpcWJJb25wYWJmeno5Mysybkx4dzN4Q2Fr?=
 =?utf-8?B?bjhCS3RWK0g3cWhoZ3lSOEhnR3EzUHFFSm92eXJ3NTUycHZTT3UvZ1RERGQw?=
 =?utf-8?B?dUEyTUw5SGt6S0Y3cGc2N0JacVlXbGNKVEl0ZWhhMmtCaXFhUnZwbVBhMnpP?=
 =?utf-8?B?dXpUMGFYVTV4SFlmTGExcDFaQmowZUZscktzYXZzY1ZySjBxMG1Iekk4ZTI3?=
 =?utf-8?B?REZhbElGNVcvamdZM3pxc29DRGFzM09BUkxZZ0RpQUpNbTBLci91RFdhODNQ?=
 =?utf-8?B?VjlCdW5mSEd1OUVGWW9hRDNDYndRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e40a4ba-9cde-4eb5-6f38-08d9dad47b50
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 22:47:18.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJKY3gE8/14KgSd2DMZJ19eZ0+4HZ9JkHRGZlzxKCgI2Qkbagmo09KNXGOcRveAcxDjFqRq9H25TkoapUNApZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5219
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180127
X-Proofpoint-GUID: x7hAvTtT60Cfa5HbrdAubTNTFVPXQEjO
X-Proofpoint-ORIG-GUID: x7hAvTtT60Cfa5HbrdAubTNTFVPXQEjO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 14:46, Matthew Wilcox wrote:
> On Tue, Jan 18, 2022 at 01:41:40PM -0800, Dave Hansen wrote:
>> On 1/18/22 1:19 PM, Khalid Aziz wrote:
>>> - Starting address must be aligned to pgdir size (512GB on x86_64)
>>
>> How does this work on systems with 5-level paging where a top-level page
>> table entry covers 256TB?  Is the alignment requirement 512GB or 256TB?
>>   How does userspace figure out which alignment requirement it is subject to?
> 
> The original idea was any power of two, naturally aligned, >= PAGE_SIZE,
> but I suspect Khalid has simplified it for this first implementation.
> 

Hi Dave,

Yes, this is mostly to keep code somewhat simpler. Large regions make it easier to manage the separate set of shared 
VMAs. Part of the exploration here is to see what size regions work for other people. This initial prototype is x86 only 
and for now I am using PGDIR_SIZE. I see your point about how would userspace figure out alignment since this should 
across all architectures and PGDIR_SIZE/PMD_SIZE/PUD_SIZE are not the same across architectures. We can choose a fixed 
size and alignment. I would like to keep the region size at 2^20 pages or larger to minimize having to manage large 
number of small shared regions if those regions are not contiguous. Do you have any suggestion?

Thanks for your feedback.

--
Khalid
