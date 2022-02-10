Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778DC4B145A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiBJRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245173AbiBJRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:36:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B8264D;
        Thu, 10 Feb 2022 09:36:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGB0J6013525;
        Thu, 10 Feb 2022 17:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3TJNowhFzsuxVPB1f+Z6NGb1i4oVAZZy32eyhg4wkeI=;
 b=KWdLD69UkGtxzuCCSn5QJz4fOyyZQ6wtgg9H5l1q63HY5LXlpS3jw6mdSg29yl8dlHI1
 65qZBMqEfsTMe99u6tM1Rxy++gzi2rLwjcsY/lsENPZFm4eL/JxJoRgTxtBT5gIYW9i5
 ME7Jgh/dJctGUQcw8dRV/dmEB8fjrrZ9zOcxKS6nBWkoCWsuwCT9GfC6uj8fqozBkXie
 iMg9PRu0/uHp8OdywI+WNADCusYXJgJ2ykNeF9Ofi1409OcxK7w7yymiRRuFz2EFMma1
 CZ+w9tcOI7xs/Ab0KEFWZX3TsNH/g+fzGRdCPg5c8lwBDUGRQuQv0+HbNPtAt8UsYLC+ /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345stq2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 17:36:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AHaDGa185386;
        Thu, 10 Feb 2022 17:36:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3e1ec5fvyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 17:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzMwOrlmWyKbcu8ejjgAccwXfYpCs3EKw1nCi2QfDL8ObPuNxfBHeXT7P1qX88mqwHSm6Trwwji4pk4hT7YO2T6w/2HEUf/zGqt9mXXcTNSJPNT9ghvC5M/vfd7W7yIOrYgWn0Uo1xVe88dhNR1k+OI2NTM9gYhE0Uure31QO+sGoWSb51jfp2wy2YfXWUBMsrzJc/f2Tfq0Um+FOHKcvkLWfQCG/cY+xwSFG9OSogl0TaScdSCsaQh0jjZGXzlwkzJtn1hVKj/2vEyA8ZPd783E94x0HjqzQGDxM0D8tO86qJ6YPPyFIEIC2eV+UdnSaCU+A5RpKs9OdJOzqW2COw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TJNowhFzsuxVPB1f+Z6NGb1i4oVAZZy32eyhg4wkeI=;
 b=GdguRnYkQYLBqcFnReSs6iOj6xDECV0pz58Z7FUtR/b0GT8WZ+WGo0GiGLCwYxG82yLByy0QN+lkvfTsUa2K+4sPoBC04712b+qR9s2RjjDnbpVzomorDQlLcn1ihCRd9+yvlWD0WNL9uq/Oz5q3KDy8IpkSqakzoVgIKOP1zUSOmRHlYvK2t/B5lRclshaYnhSed4DlSP/DXcIAc6qAwrxRy7/M4gd0t2YsE6iLGIQ4NR2jD+bhQqiWo8/vI7SmrUHN7LuCZq/FAGf/tG5hnrp91VdwpJ596Ssd9jRs9SU1f8yEEzG7XNx7fwb81syE0uOHhROLCF17fo8g/yoalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TJNowhFzsuxVPB1f+Z6NGb1i4oVAZZy32eyhg4wkeI=;
 b=DLGCwASOa5BjyRlY+qyJflLLTnF9Ccyfz9ZwbhbdOzTbLuSD1caQgPrwofhQlDHUujl9rzC6xnysecCnqhpb0wCVWaXcpQrgC5f04+b3geFHeM8wx09DKJMH1ETgk70Y35qhPbnR/kGtHB172ZW/cN8CzPckhxNXRL+Nyzn2Dtk=
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by SN6PR10MB2992.namprd10.prod.outlook.com (2603:10b6:805:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 17:36:10 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753%6]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 17:36:10 +0000
Message-ID: <da35c076-52e3-293b-fd36-f4572e369e51@oracle.com>
Date:   Thu, 10 Feb 2022 09:36:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ACPI/IORT: Fix GCC 12 warning
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
References: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com>
From:   Victor Erminpour <victor.erminpour@oracle.com>
In-Reply-To: <CAMj1kXHUOJ-3CXFUJ9ULQuSoRh1=d3PJ15eFUsdGjQtUHozSpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8d4996-d62e-4526-9e30-08d9ecbbd33d
X-MS-TrafficTypeDiagnostic: SN6PR10MB2992:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB299241B389DE32FD38184FEEFD2F9@SN6PR10MB2992.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylhzmoSl99Eewmfqq+Naz6wTNS5nb7v/rvwVV1n/niWUDrKd9h2pl9idMU4na3SiQoeYUsNDGQZH9wuNOnTBuxy/fodTsDyFzBFKmOV+QV05OM7PbGeXq+8+bz2uCG8EZqEtzZit2HptdAMajzZdR2EGrhETQClZKFdClmJVHvoiOUecVwNopBHRsbJvvBCKF9sbVkmTdiTKoJF8o8+30Abs+3T8KlvWLQv5HuTd4Dha/5wK+7DISxxL+4HSpymtD8b9f4l0Ghd++DdcMV1Vs6ekk48VKFjxCtOxq6qKadD68Xmg71QQbWRwNIejb37K0Nhb6r0bgGZDuUJ0IYOCnXdglgGVb+Jvz8U7iA4/Y3g1VkBGaqvwnkRZV+Dole6ID2iuX04u0bnqoiCrEPddzsDMif5gMLL5mDjkgyyPjAofVqSgJBsqX6UvjIA7kbPy8RiZ7ac1Rkj9pS1bwAU1HSQjJRjZk53cHCvqYNVEe77xgcLL1TQw5/vyiuCK/ZW1ekGCWsOlqKZa4FOOe4M2R3veq/XW4DBj/MAyfRrO9XOAAWGxB1eb7XIEeINwbBpjtOeAhYhXA/WvGBkTraaXpMNVpNFxPAFZtn7vcvk1iWQKkgtNmGIRiaKa53ViwB10Hv/U6wWu3wx2AcSafBT0lsufET+baboLD/ibGd4nK+ASBDecI0vo/pmB+qWiYuFbF8wMvihSuojjH4Me+bHGqKql/L8jyKNavvnM6Uq0jWrqqvCMhbGldvTHsTFb3eVid9mOKzmVLjZI2e7IzkT5Tz2ZbtS3ANhxGK/eY/AzQHF4zhEXthKR4JT/7G3jmTlf4Ii96hHXQ+BnearEk7S+x1y9kNp/x5XLhjWj/wmW8rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(7416002)(6512007)(53546011)(6486002)(5660300002)(966005)(6506007)(316002)(31696002)(508600001)(44832011)(6666004)(83380400001)(86362001)(186003)(8676002)(2616005)(66476007)(66556008)(38100700002)(8936002)(31686004)(66946007)(2906002)(6916009)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlTN0NISTQvNDgxdjY0R0hVSTJuc04xM2I1MDF4ck9iQm1RMllwQngvWFRs?=
 =?utf-8?B?WE1hanhDUzFqdzk2RnNmVHFUOUxNS1lqOHZSdjI5eUh3dXplMTBDK0N6VFRq?=
 =?utf-8?B?eVlldjdPUDBRcG01M3BMWnVzOFFjWm9WRFoxZUFYelA2VWN1ZVR1cG50dC92?=
 =?utf-8?B?TlVGREhWRXNaYWdBalFaVllEYzBKSnBndnBhU1ppNU5BZjNFWDVWRDY2emVj?=
 =?utf-8?B?L0Q5RkNTM3RxaVdqR0dMNWk5UUxhRWQwYWMxdXE1WGE1a3RaZ0hDU1JtMktX?=
 =?utf-8?B?TE5qSklSS21BcnRMVjFSNXhoSy9XdktQOTJjd3A0V3ZHbDNldDdOV1BVWlhB?=
 =?utf-8?B?andwaC9vemVlMmhQaHlkTEZJMER3UWtLQnBvNjV1Wm5iVFNCQnZ0RTFFUjNu?=
 =?utf-8?B?VEMzRjFmZ0RWWGtSNlJIc2xYemd2U214RHIvdXA1bU8zTUc3STVmWlF4a29L?=
 =?utf-8?B?OXdwd1hPNGdtdUlvbFJSY2hRMXJJT0VTM2s0a3VNYWVQOU1KZzMzc1FIdUlu?=
 =?utf-8?B?cllWOHA0SCtOSGRPR3RhUFFmcUtHbFVURHpxQWRoTVJqK2t0MGNnaWFVUyt1?=
 =?utf-8?B?WVVFRzBOaUxMenkrYWpXRDEwMk00eHlQS2xLRHdBNG9IOUZWcm94bHV0bWpU?=
 =?utf-8?B?L2JCL1d5MzJ2cXpFQi9zTGRTVTlHN2YwLzVwL0g2K09sSlRFUzZDWkUzdS9k?=
 =?utf-8?B?N0RrQWlhR2pQREtJcnMzL1ZTc0JmQjVDM1lJNkkwU1BDRmp4c0F5TmUzMHdB?=
 =?utf-8?B?b3pYMzc4VkVjbzVySy9LczFicEQ3UFA0b1pEd2xsMXhNRFVvVDV2SG9LODFK?=
 =?utf-8?B?Z0RwOEc1VytJMWs5WkRKaDR3VXFudmtZdW5lbk5nVjRIU2VUaWljd1pHUmVN?=
 =?utf-8?B?ZlVwdGxYWmhLQVcxa2xKTXUvbTRSOHhnT09ZclJDK05FM0pTZGpSSEY2V3dJ?=
 =?utf-8?B?RGUvRGR6UllGcG5pT2JyTWJCeHVqcVRvL3RZTVRMaXBDelJGc3Y5YXFnT3NI?=
 =?utf-8?B?RWdmQys1dDg1UmJXa3VwRFZOWWhyK2dLb3hKODMxZXdFNzV5OHRUWCtKUGt3?=
 =?utf-8?B?K0tWWjBSU2UwbVZjQnRSY0UzZVB4YmtIblhPT1UxU2w3eTdVNFNSR2N1UDVi?=
 =?utf-8?B?ZmRSK0ZKbFlYWkJYMzczWG5WYjNMNTZPTUoweWxSeU42Y0J4dmJobFZIUTV3?=
 =?utf-8?B?OFlGZENzNnduRG9ZM0NEY0FKNStkL29KTUVMWmdSRGxTUys3STR2N21YNW91?=
 =?utf-8?B?cjRHdHF5SkxiZy85RnByNkZhZ25KMk90bElXeHlmeWlKemdlRXNSYitKdnZG?=
 =?utf-8?B?OTN0UzlGY05LenZDdjF6K25OZERsMmpMRm5SaWNjeHQ1NFdCaUlOVEFaeS92?=
 =?utf-8?B?aGtPM2JVWlk5andBdi8vYnZQVjh1ODRvT0twWUZsY1VRYVZNVFE0OGFtU2hQ?=
 =?utf-8?B?b2RzQUp0K0JyM0ZFeTJCaldNUjlta1RpdGVYeXhqenVMWFpkenVkdXdBWVZy?=
 =?utf-8?B?K3E2MWZJQmNaWnFzOTgyc1ZDcGx5eXNYVmtNamR6WkhHenRNam5peXBvK0dU?=
 =?utf-8?B?SVgzV1lXVVQ0VnU3U241L3A5ZEpxdEpTQUFub3dmeURoVVNteXRNS0tnanhB?=
 =?utf-8?B?U2NEWVV5RHJRZG9ENTB0b2VHVEtYd1pBaU04RUE3SVp5WVFReURQWTVob0NE?=
 =?utf-8?B?eGVId2k3dWZhb3Q5ZTVRNTNFVzFvZUk0dE1SVFNBUmpacStackxEbDIvRW9m?=
 =?utf-8?B?R2FUYTBPN1kwWFZpQmtsaHlGYkdpYUdhUHI0eUo1cXlidDU2ZzBWL1pWWkpu?=
 =?utf-8?B?MEpnNXRxQ0xNZmltSUg3TVZiWG9kODJ3WVM3RGkrc2pvSmlzS09BRExhUnd4?=
 =?utf-8?B?MldmNU45VGVEbXFGRUg5WVpjaCtNd3Q0UHU1bkNNMXExTndDOWlOR0FXMUdP?=
 =?utf-8?B?bDlsSmExWHg1VjBSOGd4T3k0Mjh6eGNpZ3M0MGk5WTJDV1ZOVmc1Z0tZZi9W?=
 =?utf-8?B?UkNDRTRnY1Z2R3VtbnI4a0p3cXN2dUROTWtaR1lkZERMZ2orRWlUMGd5MXV3?=
 =?utf-8?B?bENWT3RSUlNtVnVoVGIvZ3BnTWZvQWQ1UzlMb3F5ZG40YXlXVVpYU2FMRFMz?=
 =?utf-8?B?ZTkzZHJUNUtyWlpYcDFQZFd5WWVZK3lDQ3Y4TU5EL0RPbGZEVE9DbThVMXJa?=
 =?utf-8?B?dkNyZnUwQmt3VWRWSGxmWVpPRGp4ck9mc1plTTAwZVlwbEVaRDMza1FUQm1w?=
 =?utf-8?B?c3c0LzduWFpac0Q4MHJRczZQNGgwaVpLQ0RzbXBCVUtjVkIycFlCVVIwSG5q?=
 =?utf-8?Q?s1CAU53Yo7Px7LxihG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8d4996-d62e-4526-9e30-08d9ecbbd33d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 17:36:09.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHUl+jvcQUf5UVTAgSDyP7SANj4KuyG7bkElLkcdEsTCGLZGeSgHc3JNJ0gGrNMxy3H2ifSGX3lREOjpIklGDEuaretVer7Sz/Wz5+yJha4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2992
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100093
X-Proofpoint-GUID: rNNLXxkt0TR9VBeW9MsdhY-ArQvo9yeA
X-Proofpoint-ORIG-GUID: rNNLXxkt0TR9VBeW9MsdhY-ArQvo9yeA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/22 1:11 AM, Ard Biesheuvel wrote:
> On Thu, 10 Feb 2022 at 01:34, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
>> When building with automatic stack variable initialization, GCC 12
>> complains about variables defined outside of switch case statements.
>> Move the variable into the case that uses it, which silences the warning:
>>
>> ./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
>>    1670 |                         struct acpi_iort_named_component *ncomp;
>>         |                                                           ^~~~~
>>
>> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> GCC 12 is not released yet, and this is clearly a compiler bug (a
> declaration is not a statement, and the hidden offending statement
> [the zero-init] is emitted by the compiler itself), so please report
> this to the GCC folks instead.

Hi Ard,

Thanks for the reply.
This fix is similar to the following commits that have been integrated 
upstream:
https://lore.kernel.org/linux-hardening/20211209043456.1377875-1-keescook@chromium.org/
https://lore.kernel.org/linux-hardening/20211209043915.1378393-1-keescook@chromium.org/

You're not obligated to integrate this commit, but you may run into this 
issue once
upstream starts using GCC 12 (or a patched version of GCC 11 in my case) 
with the
CONFIG_INIT_STACK_ALL_ZERO option enabled.

Regards,
--Victor


>
>> ---
>>   drivers/acpi/arm64/iort.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3b23fb775ac4..5c5d2e56d756 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
>>    */
>>   phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>>   {
>> -       phys_addr_t limit = PHYS_ADDR_MAX;
>> +       phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
>>          struct acpi_iort_node *node, *end;
>>          struct acpi_table_iort *iort;
>>          acpi_status status;
>> @@ -1667,17 +1667,15 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
>>                          break;
>>
>>                  switch (node->type) {
>> -                       struct acpi_iort_named_component *ncomp;
>> -                       struct acpi_iort_root_complex *rc;
>> -                       phys_addr_t local_limit;
>> -
>>                  case ACPI_IORT_NODE_NAMED_COMPONENT:
>> +                       struct acpi_iort_named_component *ncomp;
>>                          ncomp = (struct acpi_iort_named_component *)node->node_data;
>>                          local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
>>                          limit = min_not_zero(limit, local_limit);
>>                          break;
>>
>>                  case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
>> +                       struct acpi_iort_root_complex *rc;
>>                          if (node->revision < 1)
>>                                  break;
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!ACWV5N9M2RV99hQ!dguMEUG-y4wN_Scw_dP1umWKxZKxiQA2Fv9sHuQx6Un9QIqSMbkQVxTeIZInR2h7YL-f$
