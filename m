Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A74EA569
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiC2CsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiC2CsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:48:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FFB1A637F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:46:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T0SpRG000992;
        Tue, 29 Mar 2022 02:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LhTw3PskH0pSsDyJdSyJHsgBBH0zO4dKJJCoq0r6ev8=;
 b=J0z+usl2pYU9mi7mt4kW8JMC5qQmDc8JXG+coJYt44oX/9wgwTl7y0O9ZNsaNtJnDGUk
 F7974TtoG0rjgIPIbzvAarV6rMaYUbdH3EjWVOG8ixjIRi6W+GH6Lj0U8J7gLfqtjXhK
 Mbb4NLA5e03Qts4dU2ZSWRzv3eWfj5+GNtkyBBWsotsYkAolAMreRqdgZPb4/s5fm/p1
 0s9mER/ZreLNzMEtDi/FTVliLBYZEXUHnVLNvVWpi0G56LCAarVrigE98222w1SzcnNi
 htXgDKBL/p3lAKxijeHVYl8P5OEWYeCtpeCDy7qSb5BmOFNJXSqxqkJTNBaZGCfn765R sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cn5g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 02:46:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T2kHKU014502;
        Tue, 29 Mar 2022 02:46:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3f1v9fenwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 02:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiVjvCbW0+XXXlOMg02Wbc8mtEbPnUaxkJC37GtK4xJynfuxwYhbuz92eoOtumNiYAhe0/jOoRbmpoUnToIqTv9PVNcyqaX08hgVXAmv9FOAtLNEnJLoly7IZq6RakkgoK30GqFxJDTOP2OGmd6VZK2uB8B3iP5MPNPZ1fXRXcYyRWk40lHO/RPvmmTmF79FxV6ukTJWtsjqPLPG9pB/RHLESVhhwIda8njXR1yvtgUh8sPY28syTpI1stXtQI5rEz3DSqAQER+gNvyvRAeMobumD99fgdddyeekPqzkF7NWk53UzRrkgzXCDUJ9d4OzpJMTZMpwAeLdEObazcZ6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhTw3PskH0pSsDyJdSyJHsgBBH0zO4dKJJCoq0r6ev8=;
 b=UGa4ScNIZG1DXkpw6XLYJByTosCjPubtymNznkH/JHakcdn9ZTWFQjwrxcpgU1OIQaj2RrQhWD95tUXfVlfwpbOOvJMNo+7dSWmeGHqDHfZp8NbxG8iV3PsGy5kvGeWijCOTFAVri/IVK0wzBeyFyODj86AGlQi8UWHnmtjOrLg8gnvBPX7jr1AcFMPlFKERfBi80qvvcnJBTooNh0ZT1ZT7ErqYJDaRK93/V3ZDOhrQjdUw4WSOtKWbYrc0zPNdiDLCZpF3YaCBUPQoTQwMQTctLFP21gmNmakObSNHC8mTZWG8lvjfwTNV3TUAGlMB1ie12L+jOCmzxrnmzXZn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhTw3PskH0pSsDyJdSyJHsgBBH0zO4dKJJCoq0r6ev8=;
 b=nyAUyNr3lvprhtyBRHxS7zduM2Hc4aPsCk2SYxPWqhHT0oVkF/kTsnBLLt6e70KOAQAH0pRRz7mK3itUORq88p0Z37ZQqyFqpIlh7jmDqb3tiH89ijQJm/YSSRd16UI2JEOpDjIvJCchunsXEkq0QvaW2OWOIx0wMIKsli3nS/0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4746.namprd10.prod.outlook.com (2603:10b6:806:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 02:46:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 02:46:15 +0000
Message-ID: <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
Date:   Mon, 28 Mar 2022 19:46:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     "liupeng (DM)" <liupeng256@huawei.com>, akpm@linux-foundation.org,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220324074037.2024608-1-liupeng256@huawei.com>
 <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
 <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dae6ff2-a158-457d-cac2-08da112e4b17
X-MS-TrafficTypeDiagnostic: SA2PR10MB4746:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB47468CFEAF1F0AA171EB9C79E21E9@SA2PR10MB4746.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xva8IQN09jxsWnSMnonMx94R0Ib0AbnsfnnG1Yt5fFeHZOJmZwJSEDVUjh9brpwLKmIJu4/VLSy6niIf7iNDYSnx54VwO0NEnhp+BCw+/+qE/y+bUKWW6H/U/cQBC76Z3BNTyzFtKV/m2e0px+2dOHPbKzJ3jsAFgM8u2OMw/CDwImjJYVJvXym16cPJV0KCPmKiPlXQsp9J4co1tTZtnWnIBCsEeHv3b4wa3r8QI/9BRFRSLGEEPkybYjvrh/3DUR7+yMGk/ANsj+U93jQzZ8gbpXDy/VaMoAl888o0fPVtmhBdk362Q0LhQwAbGUDwugbeObcnNX4cXuh7DYN83tS5B7O0JPKF7NCtf0TNSB1bltZAmItg3IvuaHAhyCJdxYc8lTJaJqjDPHIuzXOS4i8wjrJ0G/yL4J8eBGXkbUXBRKcN18Kvgbdj349/eqfwJPgWNcuV/3qV4YP6/a3dVAX/AKtY+7lt+ldAnDRnFmFEHY5SeULEb96d7NG318zkubHOPmlYSN6rUJhwRhCDJmCG39HhU+7iQVPYrHWyXuxw5J1izBOId2N01GNrHAXQv8UqgIruV1I2XEoF9kq6fVG2nJ5LV0eS07vFhYHtXJWdcyxtN/Dy/+KMEoumiz7eSLR41P+UoEQxBNlE7EC4LnF2x7RNztmvVVMnu8/5K0DUJw/k2q5xrLQ90zxNM7dvT6eYmmJh9LGaWS6HFk4apcpr6soXIoPYP/T5+alxOtfLHfjCghDcUTOiJ0GIVdLyF1dzjFjsaKMKnUqkIvYSSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(86362001)(6512007)(2616005)(53546011)(316002)(508600001)(66946007)(6506007)(8676002)(83380400001)(8936002)(44832011)(38350700002)(5660300002)(31696002)(26005)(38100700002)(31686004)(186003)(36756003)(2906002)(66476007)(66556008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlY3UmZjQXdFL0hZeFJPTUtGeUdLUGY5ZUNINWdSQXFNaU9DTVFlcy9PU3N6?=
 =?utf-8?B?OVJYS29pamdyWnZQYVo3UHdINHcwaTM0cE5yY0hxcjdtaGdlVDZHMWhUWVFw?=
 =?utf-8?B?dXFnMjVwbUV1YjA1RzVkM1UrQWNFM0U3Y1pVcWdlMlVyMVUrYmVUZ29UTm1G?=
 =?utf-8?B?MmdWaDFHYXFkSXZzc1hnaEx0aXNnNzV1TytaeTNjZDJIMDF5cjdKMHFZMnBJ?=
 =?utf-8?B?UDB1emdXOVV4MnBLUUFWREROeGh2NnVUdFBlU1p3d2FkbmptUGgweElzTzZy?=
 =?utf-8?B?ZjlNZ2dlcVNOeUtPZEV0STdwcEt0YkZXWlRMeWp1M2RmVElXZ0hLL0FnZlVP?=
 =?utf-8?B?UXVFb2ZZdG9CR3Z5V1dSYldZR1VsdEVoOWY2cmxpWGRyZjJrN2luTjZJamhV?=
 =?utf-8?B?S3MzWDlEQytJeTIwc2xPOFVQRlY4a1YwZnROUS84WDdBUUd4dWx3TWNCQ2h6?=
 =?utf-8?B?T08vU0RqdkhsaUErMy83OU5LQVVoKzg0MHozU0tRSnY3NldLTnBoeS9qbGE3?=
 =?utf-8?B?d3IyT01HOWJObFBRY1FsNGZIblV6Rzd2bmRvV1VzaXBIU2thNlkyWWhRR1NG?=
 =?utf-8?B?K3gzU0haZmhvcUN5UngrUjNwbzUrWmVNRzRPanl6bUZ0bGUya28zTURXblBm?=
 =?utf-8?B?elcrQVAzSDY3MGc3enB2ZEtkck9TTi9pZTYwRUZldFR1Wk15ZnNuVS9tUzBN?=
 =?utf-8?B?eTFCRmI1ZWZOSFNZWG5qUU5leEsxZHNITmpYd2QxMTB4dFQ2OG1iTzFRWWZ1?=
 =?utf-8?B?NEQwaGloVjlLY1k5MnFyclVoRUY0dlV0OE03SjcvVFdKaHMzbWEvWmo0OUNm?=
 =?utf-8?B?NHgrUGpiZktPMzcxbnRDOWpWV2FNVmVabUExZk9RTm1EQUdZRVpyOUpHMjVF?=
 =?utf-8?B?Z29aYUxnbjk1cGhTUUtEV3ZOaWcvalRQekJpSGFSVUcyUDB0WGUzU2N3RWpN?=
 =?utf-8?B?SWJtTGg2cUt1TWl2eFlnTU5PeU9ieS9jYlV3T1QxQkFpREwvdzZselRLZWRQ?=
 =?utf-8?B?SlNkZEVJbDNGZGZxK3phaXUwbFAxN1Z3dHFTL0ZwNDR5MlBFUXJMSktQWVFJ?=
 =?utf-8?B?ZUU4a2hRVHRsZkdYUTYrdEN0V21aMzE2aXdhVS93M29YdkRORG96SmtrVGlN?=
 =?utf-8?B?QnU5VGd5cEhKWFg4U1NCUFE0akdZZXB0ZEFYNlorZUMvNjBjNzVsdFkraVFr?=
 =?utf-8?B?VjRZRlpCWkEyYUxpdEdFKzUxUVBKWDUzSnNqblhiOWNwZ1Z1QU1EVGZnb3pt?=
 =?utf-8?B?Q1ZCQ3dRdnpiR0JNcUlMZkI2WFRnS2c0b1NZeXdqcUp5RE1KN1R0RVlkcW9H?=
 =?utf-8?B?SWovYnc4NFZOQUhONFozSmtvTnhXbmFxRDZsR2h0Y1RIMTlTdkNpbGdMWnE2?=
 =?utf-8?B?a2JSTytxQXdEd1FpTEp6ZHc0L3dWYlhxRkpIbUZ0bk9ucHdvT1FRRXdPbFhH?=
 =?utf-8?B?UWIzQzJKWS9CbWFScDc2bjFkWHhPbFZuODBFUlk2UGtxNjNVWWNnczJ2YUNz?=
 =?utf-8?B?cksrQzhsVXhrOXpabWxrMXg0T2t6Q21XdXdhTjg3ckFHdHFWUlQwdFQ2dEVB?=
 =?utf-8?B?WjVudEl5a2tXcUlvSHlpbStuUDZvQmFTS3dvMk54QlllRDhtSTFxcVg4NlVV?=
 =?utf-8?B?MDVvRFBRK092VHhqUjQ0OGNRaVVzeEphTGMvVkxJaXhCZjVLWkRQMmlucDky?=
 =?utf-8?B?VmJaaThHWi9OVjRacEprRmlmdjhCd2d5OXRGUTdrM2x0QVZES1JzcndZd3Ir?=
 =?utf-8?B?VGNTTFJjTEYxdGNZcXdFaXlGbHNYSHJNTGMzYUVreWl0S1dpR2g3Q3c3Qk93?=
 =?utf-8?B?NXRsMzN6MzBDZVBUTlNXVmU0NkZHMnNRZUtKS2tBaWdWQk92Z0ZjSDN4RGR5?=
 =?utf-8?B?TVhGU0d1QUV5WllMUHVDZTR4ZTl3aHdydDF5V0l3MUFJWUNGRkRYMTVScUVT?=
 =?utf-8?B?by92dm93bWQ4MG1sQjdMVUlvanA0RGdoWGkwU2ozQnRiTitsVFRKREdSd05h?=
 =?utf-8?B?anhKdlkwc1BSUk9qcm15dDlScHIyelJ1S3pMU0hjVUN0ZWxTTno2dStoam1Y?=
 =?utf-8?B?YW9uSUlNMkV1dlV1LzZFSm40SnpOMlR5WWNJeGROeGlWUzBpQTZrOG9wVThU?=
 =?utf-8?B?NXg3R1RaTU1pUVF0V1hLUEl3SmNXdVkrei90NUszQjNmV1hqKzJ2alRETXha?=
 =?utf-8?B?ZEthMlU1YkQxZzJBaHY5VnBZN1NXUzljTW9aYzBmT1ZGL0hWQjVhVS9CQjhB?=
 =?utf-8?B?K0NLTy93R24waTlzajdhQTYxVkNtWGtXUGRpNmJrWUUwUGFVVDUyRDNVVUJO?=
 =?utf-8?B?dGtiQktVR1NhNnR2Ym9LU0cvRzRjZTBzRUpOcVZqUDhuSlBoZVl3SWZ5SGRI?=
 =?utf-8?Q?rJv7qggT1buoz3Z4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dae6ff2-a158-457d-cac2-08da112e4b17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 02:46:15.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlstxqN5MABqzZpbX7R2w1e8VWjTJa32YZcIUJIKE21dXBiphIhbdYMAd2ck6IZqs8kTj/6tnqg1chhHhLkRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4746
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290015
X-Proofpoint-GUID: jHz1DeIFbK7j7ZpDlmouG8Yo8v4JdpWy
X-Proofpoint-ORIG-GUID: jHz1DeIFbK7j7ZpDlmouG8Yo8v4JdpWy
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 20:15, liupeng (DM) wrote:
> 
> On 2022/3/25 5:57, Mike Kravetz wrote:
>> On 3/24/22 00:40, Peng Liu wrote:
>>> Hugepages can be specified to pernode since "hugetlbfs: extend
>>> the definition of hugepages parameter to support node allocation",
>>> but the following two problems are observed.
>>>
>>> 1) Confusing behavior is observed when both 1G and 2M hugepage
>>> is set after "numa=off".
>>>   cmdline hugepage settings:
>>>    hugepagesz=1G hugepages=0:3,1:3
>>>    hugepagesz=2M hugepages=0:1024,1:1024
>>>   results:
>>>    HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
>>>    HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages
>>>
>>> 2) Using invalid option values causes the entire kernel boot option
>>> string to be reported as Unknown.
>>>   Unknown kernel command line parameters "hugepages=0:1024,1:1024"
>> Thank you for debugging and sending the patch!
>>
>> My first thought was "If someone is specifying 'numa=off' as well as
>> numa node specific allocations on the same command line, we should just
>> fail the allocation request".  However, this same situation could exist
>> without the 'numa=off' option as long as an invalid node is included in
>> the list.
> We will "specifying 'numa=off' as well as numa node specific allocations"
> for some debugging and test cases. If the original command line can be
> partly effective, this will be convenient. Yet, we also test "an invalid
> node is included in the list", the behavior is the same with "numa=off".
> 
>> With your patch, the node specific allocations are parsed (and processed)
>> until there is an error.  So, in the example above 3 1G pages and 1024 2M
>> pages are allocated on node 0.  That seems correct.
>>
>> Now suppose the node specific allocations are specified as:
>> hugepagesz=1G hugepages=1:3,0:3
>> hugepagesz=2M hugepages=1:1024,0:1024
> For this case, with/without this patch, huge page will be not allocated
> on any node.
>> Since node 1 is invalid, we experience an error here and do not allocate
>> any pages on node 0.
>>
>> I am wondering if we should just error and ignore the entire string if
>> ANY of the specified nodes are invalid?  Thoughts?
> 
> Thank you for your response.
> 
> This patch only to be consistent between 2M/1G behavior, and repair "return 0"
> as 1d02b444b8d1 ("tracing: Fix return value of __setup handlers").
> With this patch, a node could allocate huge pages until there is an error, and it
> will print the invalid parameter from the first parse error. So, I think this
> is acceptable.

Yes, I agree that the change is needed and the current behavior is
unacceptable.

One remaining question is the change from returning '0' to '1' in the case
of error.  I do understand this is to prevent the invalid parameter string
from being passed to init.  It may not be correct/right, but in every other
case where an invalid parameter in encountered in hugetlb command line
processing we return "0".  Should we perhaps change all these other places
to be consistent?  I honestly do not know what is the appropriate behavior
in these situations.
-- 
Mike Kravetz
