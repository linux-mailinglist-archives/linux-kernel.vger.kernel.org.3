Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35524E6D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358234AbiCYElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiCYElu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:41:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D36580B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 21:40:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ONYB28031491;
        Fri, 25 Mar 2022 04:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R4lIv9tjZGqR+6V06dl47DZNjaUwssyhHyznoa/eEH8=;
 b=xU1XHN1qVRUJUMWMph5DOxe+rZVxth3PZDPUNk6vbOOJyPFsuYg/sDVaBciRG2y26mHR
 Wn3wcge/aODCYDgf7WzZvTDffONFj1iuK6y/BoSn4eSItdpR0wpzevOfLFqx2AJrnwOt
 BXJMcFfk9VtVeF8lHWf73OCadk5YkthHkr4PPFB4+nGBgoB15vWkcLcMX6gwK1K049XL
 AqIte2ONAVHieuh5mu96ZwlWRf7Tlple+bbD7jAccP3absAU7oD7OVlVGrzREmdnztkf
 24Se6bXMb21kxFPtsRjrES8Sl1w+YTXgzMt4eI3/sFz+tNsKIJTkeiTytp9/vwjmFttF mg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qtefgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:40:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22P4Y1DB037838;
        Fri, 25 Mar 2022 04:40:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3ew5792b6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzcUDlX1U1KZqRqv99KMbfISUGVq3wtvhkJmwGJuFVxo4z0MIPelXqWel0Dka3PKu5DyQ+x3a03TUGkuFE8yFc/UJH8AWJkN5HrdXbtDTkZ2njUYQMRFqv+1B/u42Zj/N98dBJMo7gfLbyKFhJ3Us2to72Fck2CHoHFpt6SB0Hs0ZprdJARYZBMlRGmxqQ6Xn5PPoEp323k1DWXlxUqR337kGzuJuSCBV8mqTfuqypcO/YsDvlFYdxhOTrgEoHl7Ldez7MDLJCCar2uZofxYHUYtwr9q1+3hW1gaxfS1UJyK9qNzHJ0zXNZp//QjISnnVfnx93Tynu6r9ADKJ8/qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4lIv9tjZGqR+6V06dl47DZNjaUwssyhHyznoa/eEH8=;
 b=mkvcrWP8mLjntnqm6o3RmK9hE/sIFmtUwua7JNjLBs4f6h5aFvgWbj52F3fex2kE0AHAN+7INDZj9ODWYuiuE+z/A2QrriWNXwIzrNNFYaCM7vG3yWUF5wgn7gCbzfmDZJCvoLAi7Cko3SOseeYpLody0f7HGehOQHE6PKcfRSqWjB9q3TgIgiyOIbkr7FYHlPgLL66/aePMCFgvJMQ1DjqkDzO0zN3VpXlbgC9N6ww86lH8vK0DL3iK5S3bSoOAzbpt5DUoTs2x87mcOjAblWW6iQf4ro3RHk7/+Q3yanGdrjKty51zyvxHg1lkzHC/6ke90uenenNh0vP3hqPQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4lIv9tjZGqR+6V06dl47DZNjaUwssyhHyznoa/eEH8=;
 b=OkijhPfL5aQZRbtWHcbnlJZzM+hXMbplpX1GL7ULrAAi4LwCwlcjr6Kv8LU6loDQhMG+UjFXw0muBVW9sLY0ls9LeaxquB0dB3tM3HxFrUQ2BY1q9/yiYN7et/MgU35wCRnlQ8zmvlleph1uQv2KT1IA5J/RYLI6XdAZXR6bY5o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5010.namprd10.prod.outlook.com (2603:10b6:208:30d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 04:40:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 04:40:07 +0000
Message-ID: <1883d31a-639e-8717-39b1-426628cb0d56@oracle.com>
Date:   Thu, 24 Mar 2022 21:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: scalability regressions related to hugetlb_fault() changes
Content-Language: en-US
To:     Ray Fucillo <Ray.Fucillo@intersystems.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <D3204B1E-50A1-4261-8C75-3DF77A302502@intersystems.com>
 <43faf292-245b-5db5-cce9-369d8fb6bd21@infradead.org>
 <e4cfa252-7be8-48b2-9f19-019bcc0038af@oracle.com>
 <8E9438A4-56BF-4DBF-9424-2161A488352B@intersystems.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <8E9438A4-56BF-4DBF-9424-2161A488352B@intersystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:303:83::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34095d78-9575-48c1-8640-08da0e1989c0
X-MS-TrafficTypeDiagnostic: BLAPR10MB5010:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5010EB13BB12170E73FDB45BE21A9@BLAPR10MB5010.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZh8LSYVHR2YcH1XqyWw5UsUPJXUZHJfrycZ4nCvQLhGFEI7KRxiv1LhSXemQj7zwWHfH2uQevlTlk0Iq9vj6x1rrjV4i2XkjpvFVd17Y+vSKnzYxZk4QbZnl6re2BOZMNtuk5THja2dQVAgFt+c6DNKH50ObMl+1jumSlSRFLBiufQLWUMZI6gE8AqFsAdKU/B8Z4b9ZxQzt1HOZqZ7P1T8dytg4j67IppcjJrCci1GJq9Z3xDAs/Xy7zBmYt0ArQCeYkwb6ibyLs4yOubY/zQYeAI0F8TxnFumagwBvo2614qRUv1M3nU8SuZVSec2Pa+E/yiVPz7GrMfMo+2iuGBK4NvXmevDAZ57chr+pGwodCXyL9uS+CZrJgweTuP+/toOFeiyRFqzuvs7slHl9WSAC6dgDmnS5ZB2bVgcOsIk+3DD/RunFnyRMLVJLdnt7s14RZjsoab/JIYN7ZJWDbybm6cHMU43wWySdeRHAiPLLVbg/lNapW/rnAkIsa2ZgHm1yInx3SC0wJadzK5YSVaGd/x/OJ7D5UF4nsk1VB17StDGa71EJI1HgZSdjSzEThh4DKfH161xNLNKwNYyBSAoqE6asNdFiQ6+RmfTcp06iIq0uZx5NFmrLPVpbCS0RJexEOVQvGZRNyTJCf84T/W9bHDzlA8IQ0q9HzfxGEciZoDxJJHASIAR/ldYuVH7EgTdCZetVfVkgaWJf0dn7Wfx9eOSeFMpDeZxZNlaeHZZ6UnczbTI9sQxD9T/S6g074lur+ypYACT8cKXJVovsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2616005)(52116002)(53546011)(54906003)(86362001)(38350700002)(31686004)(38100700002)(6512007)(186003)(66946007)(36756003)(66476007)(66556008)(83380400001)(6506007)(26005)(44832011)(5660300002)(4326008)(508600001)(6486002)(2906002)(8676002)(6916009)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJDaGZaRGprMnhwazMzeHFqUWlLRXRYbTRxcU1SSS91c21KeWNNc2RIS3hR?=
 =?utf-8?B?TGdCYlE2UEF2T3ZzQ0VFRzVzV3NnWDJHRllSTUt2UktVZ2tqS0U1NDVHcnht?=
 =?utf-8?B?VG0vWnlXNitoelZZck9iOFRKNEQ5UitQb1E5cXI3VmZwR0xSeFF2WlZqbDEr?=
 =?utf-8?B?WEN1Ri9jY09DVGg0Mjl0dDg3bW9KMEk2cUZRZ0UzUEQ2U04vSnI0c200R1JE?=
 =?utf-8?B?bHczeVFhay8xcGhrcjVTVnB6YTZqWE0zdjdFRWxTWmx3YjFweldvUVhVRzNS?=
 =?utf-8?B?RXZJMy9lVlBxUkhIZ1crdkI5NGJnRE1ZUUFPWk8yWHZ4NGlRVFVhcUZSS2Rn?=
 =?utf-8?B?R2huK0syZDZ0YlJHS1lQRGxMZk5KbXlHYWRJTGZxVFNMdTRvQ3ZxREZHd0hi?=
 =?utf-8?B?RXA3RlVqMSsrbmpKK1NDM1Npb3phVmxlcXc4NzR4NWJrc1F5QXRaU2dCZFRu?=
 =?utf-8?B?cTVxV09qL0tKZklVd2Q0RmNxOU5wMS9xU2ttcWQvNzgvT0tIV0hoV3VDdXVw?=
 =?utf-8?B?eVFBTDdMRUxpeWVHR2RIUHN2ajFBMEh3bVFBZDEwQVRkc0RMc2pLZDFPYi9C?=
 =?utf-8?B?MHpYL1MrSDI4bVI0TWdtb1R6NjVrc1JGSFlib0VXR0R1ZWsvekJ5VE5tcnFY?=
 =?utf-8?B?VGhIbGNZL1YyYWlrT0lLcHk1aVZNWWY2SUgyTnJJRW9pM3VVZ0NudFloN0g0?=
 =?utf-8?B?TVdVV1pDU0xjMk5FRnJyZ1dpTG9zYjRIcDRZbGNBMmwvdXNFbzlDUnhKaFls?=
 =?utf-8?B?NHB5c2RLTXMxUWdWY2JxT3d4L1NHZzdzWmxBaUlJR2ZmRlZIT2pqeXVXZDQ4?=
 =?utf-8?B?NXR2RDhrTWhYTzA5YmVxL003OEJpWjZXdmdRbE9zQytTMUNGek1BZ090WEdn?=
 =?utf-8?B?WldRdlQ0TGZXeXlTZkRsRHo1N3JsaUVJeWdTcC96M2dGSENWTUZkRUdDa0RM?=
 =?utf-8?B?R0cvSml4TnVBRExEUW8wYXJBSkFzWTRuVTltaWQ4dVAyTE1EZEUrOE9HRUhS?=
 =?utf-8?B?R3p5YTlyc2FZajNMQ2V3UzkrVTVFYktMQmUvTFR5cDlrRjZqUXN6TmtsZjRL?=
 =?utf-8?B?ckFmdzlxUFZSSGJRSitKOVJsRzBKUGpMaDlKSFRkcXZZekNsMDAvKzZCd3Vr?=
 =?utf-8?B?UWZmR2ZnRDNuUU5aUW14VmFsYm5xM1B2RlFlNk52dk1aTHVmVDRwUFRLUUNH?=
 =?utf-8?B?cW5mckZpQ1VCc0hMTEpTajRseTFMMWFGWjVabURQanJsR1k4N09FVU5HaytN?=
 =?utf-8?B?MEN5bU9FVFZOYWdnekZUZlMxOGVvbzNKTGlKRnE4MjhmUitTaTV3U0IyQzFy?=
 =?utf-8?B?dHI4MjVzZnpVcVlpdmt0NjB4OERDWjNNRjFKNEl0V29VYUF1S0ZtaGphWWhP?=
 =?utf-8?B?OXFKaUk3dDc2dnR5SEhSZ1ErZUZpS0czUzRHNHNtaEtxVFlOQWkxWFpISnBR?=
 =?utf-8?B?YmxSUS9KWUUxNUxZQU5HbFIwTEk2UGh3WGNhYmd1WFNjVksrOGE5MjJIdjFL?=
 =?utf-8?B?dmNsOGd0WFdEYWRxYWV3Q05hV0FFcTAzUkR2djN6Q0xKVVlpcmNqdW1KNEUz?=
 =?utf-8?B?NUlHYjNvbjNEdVNwNVJUM1plMkJ6dU8ybVlyTENMdlRieWpCdzFKRXFJdnk3?=
 =?utf-8?B?eG5ySkt3dUtXaTdvajVkYWJrYkdsTldFeHVVVDcwSHIycHZZaVdWRzJLa0Vy?=
 =?utf-8?B?UGlyeFV1V1FuQ250M1hXajRjWDNwQVpPRXUvUnhsRDlzVTZYTyszK01vdGxK?=
 =?utf-8?B?TW5IUWxFMzhodllWUTRKczkyQUlrU1A1STRVWWVjYWcrSFBWMnVZeXJkRjdi?=
 =?utf-8?B?QmhHMHlBbEcrZno0U3RUWm1lU2E4QXovYllLNG9FQ2VocCtNa3J6Z0Y4cldn?=
 =?utf-8?B?VVh5eHBNNE5IMUY0U0Vabi9wYzdydHVKYUdhRTVLcXF6NWlud2pmbFFGTmZZ?=
 =?utf-8?B?aE8vcXF3S004OEtZd25ESVFvMnJyQjZMQllwY1VGVTlqZ0FYK3ZHSGpKSS9z?=
 =?utf-8?B?eUVPSTFqZkErdFcrbE9UVkdMbmw2YlAraWpjcHcxK0dRUnBOc3p2VlNiRjRk?=
 =?utf-8?B?dFdvMW5IUHlzSW84VHlHT2s3Wkg0V1JzbHdQRFpOWVVrcHQyZGlmd3NybW95?=
 =?utf-8?B?WHpIam54VzlBem5nQVlYYTZFb0RMMmRHdmE5ek5GZ3QwdHQ2akRhVzVtZjBL?=
 =?utf-8?B?aURmYW5ScU8rNHY0Z01ub3h5ajJIQ2lBdXkwQWx5dmlwTDk4Vmt1cGF0UVI1?=
 =?utf-8?B?TDNxZ09EUFkwak5PbDI2Q3pwTGNHTVZCcy90UU91cHNkWVBqRkxmTTNyQ3cz?=
 =?utf-8?B?dHFXVVRZaG56Nm5FZ3RVYnFrL3pqajhrTTJKdGdzYll1dEVObzM3S3pEZlpn?=
 =?utf-8?Q?ZgvIl71NVcJigxN8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34095d78-9575-48c1-8640-08da0e1989c0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 04:40:07.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRtogVcpHdrGcLSork/BYlyCnpPPpm79IBI6EO6XLDDcQno/mqk91fcfvRCjdRhLZrloSDSsoN4aEuwAzpO8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5010
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250022
X-Proofpoint-GUID: Jz00IZn-RBALn45jWwAnBuVZvoFvts6n
X-Proofpoint-ORIG-GUID: Jz00IZn-RBALn45jWwAnBuVZvoFvts6n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 17:02, Ray Fucillo wrote:
> 
>> On Mar 24, 2022, at 6:41 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> I also seem to remember thinking about the possibility of
>> avoiding the synchronization if pmd sharing was not possible.  That may be
>> a relatively easy way to speed things up.  Not sure if pmd sharing comes
>> into play in your customer environments, my guess would be yes (shared
>> mappings ranges more than 1GB in size and aligned to 1GB).
> 
> Hi Mike, 
> 
> This is one very large shared memory segment allocated at database startup.  It's common for it to be hundreds of GB.  We allocate it with shmget() passing SHM_HUGETLB (when huge pages have been reserved for us).  Not sure if that answers...

Yes, so there would be shared pmds for that large shared mapping.  I assume
this is x86 or arm64 which are the only architectures which support shared
pmds.

So, the easy change of "don't take semaphore if pmd sharing is not possible"
would not apply.

>> Also, do you have any specifics about the regressions your customers are
>> seeing?  Specifically what paths are holding i_mmap_rwsem in write mode
>> for long periods of time.  I would expect something related to unmap.
>> Truncation can have long hold times especially if there are may shared
>> mapping.  Always worth checking specifics, but more likely this is a general
>> issue.
> 
> We've seen the write lock originate from calling shmat(), shmdt() and process exit.  We've also seen it from a fork() off of one of the processes that are attached to the shared memory segment.  Some evidence suggests that fork is a more costly case.  However, while there are some important places where we'd use fork(), it's more unusual because most process creation will vfork() and execv() a new database process (which then attaches with shmat()).

Thanks.

I will continue to look at this.  A quick check of the fork code shows the
semaphore held in read mode for the duration of the page table copy.
-- 
Mike Kravetz
