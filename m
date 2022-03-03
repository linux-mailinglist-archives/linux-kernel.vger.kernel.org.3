Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93534CC161
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiCCPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiCCPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:34:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F67141FF4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:33:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223F4MoG007646;
        Thu, 3 Mar 2022 15:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6MijdMwctfkCVqzA4NGiA7YLNpwow6glPmx4pdoFeU0=;
 b=bVxE8e2Q04n5qvcmHL4+TEoxyFsG/165ipdH7FGOJqICVD/Ram+aGvrS2A9LgfhPt4oO
 04ydI71rdlA1Gt6zZS+H1Uk3pBU+t5SRwogAwaw+VesCwzSgGbPwjlqIMTz3gdLDB43R
 B3Hs45cJyTwyh7mcCcFsfLY9Z+8oyQkgP9tmRvJOp5sIoPpWhH1pyBB2ot3WuHlWjg1k
 0wPamLlHiurNNaAETt91pESVSbEUS3QmHJ9fd2qh/Dezf0HyXmmjaJ4WENsBMPVAsDDv
 ECWlHPNx9uUDhT1KJcb13cFzF2kBnYvy1alA8n+pzFTKQwW0RIGAWJtnR3bhjkTObec0 cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15arwbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 15:33:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223FTOos180823;
        Thu, 3 Mar 2022 15:31:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3efa8jbce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 15:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiehMDHXKYYcAgHM/nDFihwj6O4pWYMgN9dUzjs/0IJnDyRwFWEmK0mr0/OC+rZTWZH6LKbBT3lw7sV7faJ9OY6Qwg+TB5zpW53+lJG4z/GXMBEzCgAt8n4eYj394TRzXG7sGvNzxsmVUzuX5HhNqCvDgYh9Wr7PDOp5GnQxsHTDjAFQhNxp1D+Mql8XiR6iSuEbZ7YbfW/Whf5WFZPFETRH9W/Si5OX8IUNxhUbKmpl8tRhLNjDa+8lfn+QaMjO/r5Pu+L+BnHQuQOBB/D0q02xkf1JdceATNLNRhxa5o11ZEAV/lG2pQ0WgiONWcvhNeENjj4aPfj+Ff425VkRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MijdMwctfkCVqzA4NGiA7YLNpwow6glPmx4pdoFeU0=;
 b=PmLFhMPUMr0fc2N+XU9PNmBi6eFjPNbXpdLISR4TXDjqHAX+RuflItUPjk8mpOCJ6gbz46Pu2A3gMFA916onCeFBGGD5gKcNAr0hivatuiYl6BJVlBd+LVNNr/n0DzX2Uaclxl3wqHm0sgq/NTgQSJElXPiotvquEbwfyRFVw83TBkXo7yWUFhtnJZA4R33d6yyq4OBp6bsXXnEtkMwafCW0r2W6yc9aRQbDhAEMcUlMo/t3HFHw6EDmng9dotJJoeyP6SqCZrNTczpJnrAlwOs7Gw3uI7F8e/Fe/M9NP+6apZxjShfNermHNcYSZFuF26YVd+3lsBSewcLPfQNiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MijdMwctfkCVqzA4NGiA7YLNpwow6glPmx4pdoFeU0=;
 b=itb0K9rby9rTTZWgDfhnbQp72AR3usdo7q09Lz6O+RcfU5TIo6OxjySpXTR/BJ9D8eClMc6O3Bfx/MWOf/MPTUQcPo3BBcl+ScC30Hvc2/TojpAbXKVk6mJrjPl4Q/zu2+f26/viq7VqaMUebwNKgzfmTuJkJbxnff5NAbLxhzM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 15:31:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 15:31:47 +0000
Message-ID: <c2f89d0b-4d85-5cfe-7718-1e70a1cc9e8e@oracle.com>
Date:   Thu, 3 Mar 2022 09:31:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-3-eric.devolder@oracle.com>
 <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
 <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
 <f23efdc0-20c8-ccfd-f54d-69a9b4ee531f@redhat.com>
 <YiCW8gEb3n1CpI6x@MiWiFi-R3L-srv>
 <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
 <YiCvomsNsTrx0dhR@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YiCvomsNsTrx0dhR@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 328cf7f8-4e2a-4323-42be-08d9fd2aeddf
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB4901CD49118E06573B1722F097049@BN0PR10MB4901.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EPN5mrAsYIOmYLtMadqTNJrkeaycejT2kb1jX5/2h1lpeGsnFMHDm65Y1t5rCJ/PdCihMISGmttFDxzOMwev+Q+MzgmGxzWy4vmLPNOxYEZTRHtqPj9ucQ1Xo6GIkSM0JnSKjzftEm6cK+meTCt4v7rHMqCiYzTqdFcjKMTblgX7BuyE/OyR7VqEOI2Gsk0xlPj5RQZRAz+tDMT6odIUsci+L6j9cMpPlBipPCgU2+kzDy2juMtBI3K8ZQmDoHuFpaWLDC+A7NJl+J1KFu6K57W3scI2vaoB1sjkA3mbyt8f54NgGW9370RTJvGk9g+bGbSAvySsiak74e+UEcZ9q8kkstAYzb9bFxMYHnyEPxWqQ1efbS0W09nzO9yaUEuN6bw8sRp6YYYk3J/puzK1NbKjv+mFZjRlVsoir4NRAvtJ0Mokpg4X6kC+4lMNnK2VGR9cm+sX2tE7M1Karcdy0VoIF5B7oWf2MG8FTiE2V+4XTjnjdS8RRRXsPON7LpyZTkniZ2NCLHPF8N6+1t6eQGcLxwy+2JimB96aLxmktEtASkHBaFl/+qxJnwerNXcrYkp4bGMi+ko114ThvWW/qBuaYaiz/dc7X1wkCtQrvUpeH92L9nnoiQHoOhQ11FopsYAeyUvs/YtmUKFiS6YhoVIZbuK5ML7pv/S/YTRJ1HtcotyejUlFc9wYdrGXstiYZmmhx+3aly5rWzNQ0S6zckT+VsTvxfhSly2Iyb8pLBvptvL2hpUJuz1kILFaItL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(186003)(38100700002)(31686004)(508600001)(107886003)(83380400001)(36756003)(110136005)(6512007)(316002)(2906002)(86362001)(6506007)(31696002)(53546011)(66476007)(66556008)(5660300002)(4326008)(2616005)(66946007)(7416002)(8676002)(6666004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhHSzNpWThKRU5scUt3dUIrenMvTURXWkhmdVBkMjhudnB0c20wYkk2NE9o?=
 =?utf-8?B?SU5POXRJU0F1Q2hGcWdhQld6V051bnUzSW4zSmorcVMzcFZSSUlIM2QvTHNF?=
 =?utf-8?B?SC9HZUMraWFvRWVzaVJ2UnFUaWp0RG1qb1J4TXpMVWREUW52VHJxN3E3V0Ru?=
 =?utf-8?B?b1VaMGs3c2xrQ2VhdE9ZbWlSTHRXNkhDK3o1Z2RtU1hGbnM5MzFOK1grUm5G?=
 =?utf-8?B?OWQ4Q0hoaWhzUXQ0c1pPWUlicGVuVVo4dXZCcStFYUxNWUlQWlV6WC9DMmJO?=
 =?utf-8?B?NDJCZXVHWVEzQi9MYitrR2EzSTVoNXd5ZTlrRVdnNkhkSUdyVk0zSzNHQ2Iy?=
 =?utf-8?B?OGV1bk1ZTnZpakxoaDN2U1RCd0ZhRzBzdmphNDBWUFQ3ZEF4OTZzeTVBOFZU?=
 =?utf-8?B?QlF4OG15QWZRcHQwSVR4T3UxSUpTdStMRy90UTlBY3NZZzRVdXR2MGZJbVJG?=
 =?utf-8?B?dTVZcUFnZmlNWjNuSDNFeVJsUEpnVGllc3ZEUmJTYzlzK242cWNadE05V3JC?=
 =?utf-8?B?WmdTRGd3TjdFeG1KM1RNcmxaSCtVbTVGUHhxbHNmZUxCVTBlejQrRWEwQXF6?=
 =?utf-8?B?ZkdZK0poaEpJNU14cXNyRjBQelUyZm5FOFdEek9sRzAzZkVVMnUrRnJsK09z?=
 =?utf-8?B?MXRRZm0yVFIwSHRUc2hCWFRGOHlzUFpYaEpzUVJPbDBDV2dYa2RMYUg2VnE2?=
 =?utf-8?B?M3V5amFYY1ZmRjE3ZjhGQ3N5bTlpekR6R3dVVU4va2FPblZFdDZpNTdyQ3BB?=
 =?utf-8?B?R0ozQWdPM09JcVkyVlpoZUF3ZzZWV2pPdG1MWUd3eGRiWnYxakd1V0pRZURW?=
 =?utf-8?B?RXlJVW5vZ3N4eFNMMXVldlNhMi9WK3dHYU5BMmpYcTJYT2daWXNCMURyb2NH?=
 =?utf-8?B?ZjlsYkNtaWF6YVhWRmhmazA2bjNrQ2dqdk9nV3N4L0RkMjk4SGh2RHlMcjFv?=
 =?utf-8?B?RUxWanJrRDRZOHd1cFAvVk1mUVBnMTdhNmJDcDFlUENOVXBTblQ2dzRIOUMx?=
 =?utf-8?B?VFpicEMrWk1qT2FNblJJd0J4N3FPUWkybHNxcU9ZRGdnTjA1WXFYOUdCUlZw?=
 =?utf-8?B?QjZRVEtVNVhWWEFZaTY5czdaak83OXBKUHo0eXVFd3d4UFRZYTUvN2FxUTNV?=
 =?utf-8?B?V29URTdEZEt2SHdtS3Z6aGpId1pZdURISHNYdGhTcDQvTGRXTDduSUFSbnZy?=
 =?utf-8?B?dS9zWStiWHIycTVZc3R0NEFpb0hEamMxY2gxSXI4VFlyN3l3cFNFaUY3T3RQ?=
 =?utf-8?B?VmRUMVEyeTdhSXpZeXo5VzRBUXNtMnJVckJUMkZseWVJTlpXZGpMdVRqYzVK?=
 =?utf-8?B?ZUlnYm5iekpiM2o5UnN1QUlSVkwxTnlDaFBaN2dTc3ZXb0pCeXlnT3FkeVFH?=
 =?utf-8?B?a3h0aVNCRTVlTHpsRjAzalpwbm1TU3FwRzVoWThnZ2NoT0FqSUJBZGFHT290?=
 =?utf-8?B?QWd2NkJzb3ZqMGFKdkNSd0Q1U3gzWjI5YnlYVFp6VWJyenlKTjBsQUV0d2dr?=
 =?utf-8?B?NW5aeStyRVJhUlpoVXFKL3dXSWZYRWtBclEvM055QXV1ajROMW1odk1Pc2RW?=
 =?utf-8?B?UVQ2b3FoV2hmVklBMXdZSTc3SWYyNlJabEM1eW91UkxHU3FvQ3R0VlVJRlUr?=
 =?utf-8?B?SXdnREtyMkV1VVFJQWtkZUgzQVd1ejYya1dpWEVHWXJJY2ZYQ3o2bHJJNXNt?=
 =?utf-8?B?Z081ME1MWlo3NS9OeFhmNEJNdU5jVFd5Q20va1hRY2F2VG5rd1VjSlNCYUJW?=
 =?utf-8?B?WnNSK1poYjl1SVpSNWdXT3BIdTBVL1AyUm5pU2FrWCtLdlZPVnVVYWp5MndV?=
 =?utf-8?B?SzNPTEF0d1BybFJxQnBTK3VmY0JRVmFZSzBMaDdGaGswYWplMUt6SWlzZk1x?=
 =?utf-8?B?RDV4RWM2MlNGdHJEc0VFdTFRQ1d3dW15VEt4L2U5cUY1eG5DSHhTWWNqN3Fs?=
 =?utf-8?B?K0VNdTFnZjdtVTI1SU0rTXZYOUlaSXlxYmN3blEyMEJnMzY1SUpPOFRnM0R1?=
 =?utf-8?B?VGlrZFpFQzdSNXVzc3E5RCtwbTByek5sYXVScldYUHdiSjhkTGxra2luQ2lz?=
 =?utf-8?B?YitkbUJVc0tlSW03OERNS08wU29lWk1WMUlNQnlOWm9TZXdIMDhkZ1ZNWEd1?=
 =?utf-8?B?eHpob1pta2tkL09xUERBOTYxQ1VhcG0vcjNocDZmVGJhM2lPYTVXZXBVUStG?=
 =?utf-8?B?OXM3bTV3bWVLUjhuTEV4SVlXb2J3eFU1bkVaa25MOVlEblVBVlQzQlhiMEE4?=
 =?utf-8?B?alEvRUZBYXhvelZmeFNxTk94cTQ0MFZZMUdlVWNoZjc2b29TRElFZnpnSFpZ?=
 =?utf-8?Q?Yp79NqmcapnDhZLH2c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328cf7f8-4e2a-4323-42be-08d9fd2aeddf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:31:47.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv8TeMs7kKO4dEt9ifesusobdiQT1jrzHA6mdpCnFjwFued1+5yOLb4chF7QD58j6yWbQkZJN6go8HgzTGnv1B2Ik+CAbkIutHuZW8aezFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030074
X-Proofpoint-ORIG-GUID: Yn_PMj7iJZUSTpoVYNFz4NlAE1T5QO2n
X-Proofpoint-GUID: Yn_PMj7iJZUSTpoVYNFz4NlAE1T5QO2n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 06:08, Baoquan He wrote:
> On 03/03/22 at 12:36pm, David Hildenbrand wrote:
>> On 03.03.22 11:22, Baoquan He wrote:
>>> On 03/02/22 at 10:20am, David Hildenbrand wrote:
>>>> On 01.03.22 21:04, Eric DeVolder wrote:
>>>>>
>>>>>
>>>>> On 2/22/22 21:25, Baoquan He wrote:
>>>>>> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>>>>>>> Support for CPU and memory hotplug for crash is controlled by the
>>>>>>> CRASH_HOTPLUG configuration option, introduced by this patch.
>>>>>>>
>>>>>>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
>>>>>>> also introduced with this patch.
>>>>>>>
>>>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>>>> ---
>>>>>>>    arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>>>>>>    1 file changed, 26 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>>>> index ebe8fc76949a..4e3374edab02 100644
>>>>>>> --- a/arch/x86/Kconfig
>>>>>>> +++ b/arch/x86/Kconfig
>>>>>>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
>>>>>>>    	  (CONFIG_RELOCATABLE=y).
>>>>>>>    	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>>>>>>    
>>>>>>> +config CRASH_HOTPLUG
>>>>>>> +	bool "kernel updates of crash elfcorehdr"
>>>>>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>>>>>>> +	help
>>>>>>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>>>>>>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>>>>>>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>>>>>>> +	  plug/unplug change notifications via udev in order to
>>>>>>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>>>>>>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>>>>>>> +	  memory change notifications still occur (however, userspace is not
>>>>>>> +	  required to monitor for crash dump purposes).
>>>>>>> +
>>>>>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>>>>>>> +	depends on CRASH_HOTPLUG
>>>>>>> +	int
>>>>>>> +	default 131072
>>>>>>> +	help
>>>>>>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>>>>>>> +	  The 128KiB default is sized so that it can accommodate 2048
>>>>>>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>>>>>>> +	  region of memory.
>>>>>>> +	  For example, this size can accommodate hotplugging a machine
>>>>>>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
>>>>>>> +	  with 1024 1GiB memory DIMMs).
>>>>>>
>>>>>> This example of memory could be a little misleading. The memory regions
>>>>>> may not be related to memory DIMMs. System could split them into many
>>>>>> smaller regions during bootup.
>>>>>
>>>>> I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
>>>>> eric
>>>>
>>>> It's still not quite precise. Essentially it's the individual "System
>>>> RAM" entries in /proc/iomem
>>>>
>>>> Boot memory (i.e., a single DIMM) might be represented by multiple
>>>> entries due to rearranged holes (by the BIOS).
>>>>
>>>> While hoplugged DIMMs (under virt!) are usually represented using a
>>>> single range, it can be different on physical machines. Last but not
>>>> least, dax/kmem and virtio-mem behave in a different way.
>>>
>>> Right. How about only mentioning the 'System RAM' entries in /proc/iomem
>>> as below? It's just giving an example, talking about the details of
>>> memory regions from each type may not be necessry here. People
>>> interested can refer to code or document related to get it.
>>>
>>>
>>> + default 131072
>>> + help
>>> +   Specify the maximum size of the elfcorehdr buffer/segment.
>>> +   The 128KiB default is sized so that it can accommodate 2048
>>> +   Elf64_Phdr, where each Phdr represents either a CPU or a
>>> +   region of memory.
>>> +   For example, this size can accommodate hotplugging a machine
>>> +   with up to 1024 CPUs and up to 1024 memory regions which are
>>>      represented by 'System RAM' entries in /proc/iomem.
>>
>> Maybe changing the last paragraph to:
>>
>> "For example, this size can accommodate a machine with up to 1024 CPUs
>> and up to 1024 memory regions, for example, as represented by 'System
>> RAM' entries in /proc/iomem."
> 
> Yeah, this looks good. Can the 2nd 'for example' be removed or replaced
> with 'e.g'? Please ignore it if it's normal to have two 'for example' in
> one sentence, just gentlely ask.
> 
Great, I will make the change to the text as agreed upon here!
eric
