Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89244622B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhK2VDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27642 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhK2VBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATKaNbD021038;
        Mon, 29 Nov 2021 20:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NohoiToWvV7bRLFDcSOavbKhhUMHdX3UcBwrMAmFP7M=;
 b=WFgTrHuT/oVniD2aWRm4SU4RBuKMU+QsGBhxjxWoQf76Q3ZVn5LmgpzeUKYaSiI9SEVU
 H3C/5zOeirBU4UXtqKKaFoS+NMSqdEF+y1Ydui/mrvgICeF05eaigFYuTHai9THkYiPv
 TMlvbmS5BBJYlnRz1F5KpPE0+nOHBAoLwfhlJGfQPsLdQyvxeFJVA747xtYFUgyfCPIa
 VPjR2id0rRyb9GpmX44Kb3AtqgPrv1rZqQgp3qOP03thUzgBtX7yS1I1FtMfyElPCTh0
 4vUZ9M3uaYK6xYPw104mXScN5PfupKsfyChSYNxmLJpXHk/9ngkGfvlQWl6/EBPgEBDF rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwm42h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:58:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATKpa0R069567;
        Mon, 29 Nov 2021 20:58:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by aserp3030.oracle.com with ESMTP id 3ckaqdf6k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 20:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAyt6+aHE8aKdQDkIFZ69nog9qBnOHpZ7sZJTsfQOa7TvYOPGipPFENTZ490fMbG4saD/A+bgk8ItRu5IIWcIR0xr1BlNwD/zxMxIiMVN4csEEgPJEuBbi7ozBXLiqNM7PPmI6fNyZHpoWR1ibnSb3oIIwOhhQ2vaKiT+qIPVFN/xVjj/kTkji2XKqPN2DuEmd8ENck3+QChDuHrf/eRil9DsOkL7Uwzl9mNiUdOIE/zQ3nNBGKiRbBpgZLdk0c9xnaUfAbSyEuvjw98qT/ZcJhtespDACH37hvi4Bj3TTEHgJHbw8A28IhY3E9HwTCQ0Tvmf6+/orO7owpWTxdmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NohoiToWvV7bRLFDcSOavbKhhUMHdX3UcBwrMAmFP7M=;
 b=Tj6fVVxZnEL5B6F+uEhIv5i8cWKtMTDpKTwCSbKT7ibBuZ9ipFWPyW5OFxxm5uzCM0avCDObI0fpk4wdEwVp2T4bg6imHzTctgxY9akDL0JrCtUIDkFiEFBYOQ5NYgTqC3QQMMtRAJwpd/DQG9lhNk+7P5lV9HtStFB4EM06IyXw75G2+x1eq8dO1ycVgTgq4pSg1oYYOUpTc/dZCZUiOXHbzH10ctRBXyYiNw1e/SeNHFIuVjzxM0xy6BhCwbhyy9jMPtvQsJM9+SfOrhGb0AUKvFcQPOLvlzXrukCO4PTpUCgH3+LPVGZKrw72l0eli8G1tUnCmlRi26hmZbSRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NohoiToWvV7bRLFDcSOavbKhhUMHdX3UcBwrMAmFP7M=;
 b=VXnUSGvCxxVzqC3AfsZ0MItFFTaskxaDeQO4j3bMDnn/7wvDPRbMDmr9xakzHDt51R82e3OmwYizswSfMZd4TMYAqXwCPdaivTenaTkKZQiyqa1JH7+vTbSv26K9Trvov2hgy0DAiEib0KF9SilKsrecafHb+eCxIuGPLRHMZrc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2949.namprd10.prod.outlook.com (2603:10b6:a03:8f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Mon, 29 Nov
 2021 20:58:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Mon, 29 Nov 2021
 20:58:07 +0000
Message-ID: <1e55a9e5-16fb-c863-e223-df02ad1a0449@oracle.com>
Date:   Mon, 29 Nov 2021 12:58:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [BUG] hugetlbfs: Fix issue of preallocation of gigantic pages
 can't work
Content-Language: en-US
To:     Zhenguo Yao <yaozhenguo1@gmail.com>, akpm@linux-foundation.org,
        mlevitsk@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20211129133803.15653-1-yaozhenguo1@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211129133803.15653-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 20:58:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8795258-81b9-48d6-5b53-08d9b37af188
X-MS-TrafficTypeDiagnostic: BYAPR10MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29499B4A4F740BA17F435910E2669@BYAPR10MB2949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPXmuAlhxFlVH02S9VxaII+z6dU0Ds6ElyxpY23pwEBb/bNe3BrdLkRBxlCJn4ya3JsG81tdeOFv/Y2f0m0uARELktMLA9lupkBaCw6cI5P0lphgJMJXvwmZFRSxNGxV/4lLiEdZtNt6KtavOCw3ENPMPE5Lxpb3Z29hSqGU7Y71I3hgf7OA5eaoDl0k8NEvCCXTLtiKgj8icrVn1wP5uE/1qQniKqqJvpsKFCGIVfKLU/JkedNV8RPXcve6CLsSa231gecXyRo4En4tKKVusESlAtN0l89izz4ijTnBhd6zzURXLlGSRCRv3Ugy53nLFpRZnldBX6+vNINCFrYeSKBRTVz1xHtFMDC2kzkX0AqmeCDhocJjgEe2YxlVDDJssU67y5GUv/CDcnPhHUVwy8DWGfk7bquAy1O4iS+FxkSrUNRtYB17XtgyWQnQeGXDQHP8330xKOpMX5sW9ecD0Rqi8igScFXosLR/FYwmT4Z29GVajGd8DDc0/GPyfvDUZr9NJozZ14qUg6uZWeNd7tYEnsQdUH6ArocAvS6BzhObs5mretsXdjOKjRC0NQrXuk33bkjAeOiOcSH4W2D0+vFPBeCRs4qnVH/z34thAEw+87ZmxQuycdWAqFkIoYluuNuqgJ3VWqtJrDBxqHSHkQPDbB6HTZxf6pddq5eQLtmEK1Z2sc+sF6V/qefvi78nNhjxrOVJIMf+f9v8qg4LSA4qvn5sL1KCD/0lE/T0KUWpcwQ90JK4wwCba79JSwPYDKOwPaUlR3fmXyD/mLi0Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(83380400001)(4326008)(38100700002)(86362001)(52116002)(53546011)(38350700002)(36756003)(31686004)(6486002)(5660300002)(66946007)(66476007)(66556008)(186003)(8936002)(26005)(316002)(16576012)(2616005)(44832011)(31696002)(8676002)(508600001)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2J1OVFlTXRZMk8waXdNK1JXRndqYUdRTGdpdmFCaFNNdk9jOGlGcWtHankz?=
 =?utf-8?B?empWNFVRUG0rdHQ0aGY1VWVtRE1xZElRYTNFTmt4VUN0WEJyOXhuZHJ1Y2JJ?=
 =?utf-8?B?dWJJNDlQYXN0cFAvSXZQTXU3eTNpSlp0UFdXcnhzT0tQZGJRZkloeDlHK1ov?=
 =?utf-8?B?M1BUaHJOd1VaUFp5VEhya1pEc25WNEt5RnduNGFjM0NzRHdaa2Y5eEtUMUkx?=
 =?utf-8?B?ZEV3R3ZsV1NqdFovNlNrcWNFUnBoaUFOaDlBendmYUowL3BIQlh6WnVpRi9S?=
 =?utf-8?B?ay9UYzR3dDkxY1MzYkk1aGFkNE9EbnVVYkljck43YUttZlQrME1iVTA4Q29k?=
 =?utf-8?B?THZHQjB6VkhnRFBLS3Z6M1dRall0S2NMUmQxUUVkc1BTcnJkampZcFZKR1JO?=
 =?utf-8?B?NkxlNUxYdjBMczJURlltQVFVUXN4TnJFSUFVVEVBTC9NMFhwTmEvd2FxTTBr?=
 =?utf-8?B?MWJ4M29LSDZ1ckkzekdlUmNENkpjM0UyQXNWNk5lQ0J1UVdEZmk0NkhPTGR0?=
 =?utf-8?B?NnlWMy9pRTNTeFY5cjlxeVVlVDNLOWpPd3drUGt2QXk0MmV0ckc3U2lBZlNW?=
 =?utf-8?B?cGlOQ0ZvM1JYd0VMdnhLbVZxby9iQWRYU0p3VGVUNDVVcGRqaUNMNXM5Tjhp?=
 =?utf-8?B?VnR1T3Iza0dMVGtETjZQZG5kbmh1cnlMQW5KTXNzWUpoRG9vamhzT0tySXF2?=
 =?utf-8?B?bXBxZlE3TzNib3ZZbDc3QUUvMXRQMXk5OGk1cW9WenV0VFlpQStTVEFMVzlz?=
 =?utf-8?B?TC9GaFdxZFdZRUNtLzJEalh0TWtTM0pDVkxWRlR0cTlPZWdDWWREcXpkRlI5?=
 =?utf-8?B?MU5yM1NkWWF5VkNxcDliT051eWpUUjJCLzhKYXpLZ0NlUzdOK3NNWmxGTkxO?=
 =?utf-8?B?eGRLdEdTUEVBNCt2eHFFNTQxZUZLdDVHdkV3UjlUdFQ3R0lxTmprbktrZ2k5?=
 =?utf-8?B?MEQ0WW5WWTlVSStjdWVtL1RucjN2ZjB2OFdkU1NuQzNlQXVoT2QvazJscG9m?=
 =?utf-8?B?eTFibjhXRTBWZ0lCY0YyclVFSDc3L0c2R3BkakZraUJpdjFRN28rS1prTXFk?=
 =?utf-8?B?a0RjTFRTd2dNWno3bTkvenptODFEaHhxWnJvdEpZY0hxSGJPR0FCb3ZWMmtv?=
 =?utf-8?B?N3NsTXVGTmR5bWxxbVl5ZTV4aGc2QllBbVhPL0MrdEFuLy95NjVxdDFTaGQ3?=
 =?utf-8?B?bFBGamxFKzdycFE3R3JBS0RYeXQveFdyeWNPeFd1U3VoL0NSNHcyeDQvU2la?=
 =?utf-8?B?SXVCTnhxLzhhYXBjS1JYcStobmZ4aENvczBWL3F6UFA4eVIzQ0VrK3ZzMFBG?=
 =?utf-8?B?eHl6aVN2UUhSaDJiYklNVEY2ZTc3a254RlNHaXNpcnV5alFYNy9oMnJMVW5V?=
 =?utf-8?B?ZzdPdFJBS2xuT0c0QW5MR2xIYk0xY1pjVzNrV0FBYkE3OElJbVBnNXBSQmFT?=
 =?utf-8?B?Wk81VW9kSG92Z3VKUG1rTnE3R2hpNElubkZNcVBOOURMOHdPTjdIK0o0ejNN?=
 =?utf-8?B?aWxWRUFZYVVpdjRKMUg1T1IrQ2kvNG41M3FwZjlNRDBnN2hBQksvL3ptYSsv?=
 =?utf-8?B?eDhhRVB0NjBjOEtoYjc3S29TK21EbmZqZE5xNEtQQ1EwTEg1TXp4YnJYS2cy?=
 =?utf-8?B?TndZSVl2THZBbGpMTXNrMzJ3TnNMYy85V1o0UzM5Q0lWbTBOU3VDUkNxN3Zq?=
 =?utf-8?B?VVNvM2tjZ09kZDk2OHJ1blFRMlNXYmdwbEtwRTloS2xaa2lQVzdsQ1VPeGNl?=
 =?utf-8?B?Sm1vM3JKMEc0a1VHZDJwWUhZd2k5azJSN3FlUWFYUmVFR2JXUHJyTjR5U2Fw?=
 =?utf-8?B?Q05STUtiY1AyTjJNWUtNSVloM2FqYncyWjRVb3MzZmdQZWVWUWl5YTR4ckRW?=
 =?utf-8?B?WUVFeGZ1SC85SFI1ejJGTC9zUFNwcFp0MW14QXhoRXZGU0NySEVDeXFHWWp0?=
 =?utf-8?B?bjA5SVYyd25FYTNndXJYZGZ1MU9WbHB5Mm54TmpxS3dQdks5VVVEK29mMGhG?=
 =?utf-8?B?ODVZWndwZERhNnR0WUNwRGNUSXNsSmNhdWd3VWx2ZWtWci91UHJtWmVEaDlN?=
 =?utf-8?B?dXhGL2ErejZhRFl0U1Q5OTZtSXd6blhkdW13akNIelVIL1Q3TDFIdlZCVlJa?=
 =?utf-8?B?OEp1aktkYXkvUmxJTXhyMWpzYS93MGw3T1NIMW9hTDJlamk3aTNuek5vMjBB?=
 =?utf-8?Q?1Jxy1KS2BrdvbaCGBzu43Sg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8795258-81b9-48d6-5b53-08d9b37af188
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 20:58:07.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcKJ8Qf2vqor+QMTxa7lwn+IQ3tG8MQRlT67/1q2HZMS1Gl5bSTqtJ+Jj3SRpOAiWhsTZQCH3AttJjcd9LQRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2949
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290097
X-Proofpoint-ORIG-GUID: CSvaCX-KgTfa2EPugDO4oYYBNHjPGyeK
X-Proofpoint-GUID: CSvaCX-KgTfa2EPugDO4oYYBNHjPGyeK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 05:38, Zhenguo Yao wrote:
> Preallocation of gigantic pages can't work bacause of commit:b5389086ad7b
> (hugetlbfs: extend the definition of hugepages parameter to support node
> allocation). When nid is NUMA_NO_NODE(-1), alloc_bootmem_huge_page will
> always return without doing allocation. Fix this by adding more check.
> 
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>

Thank you,


Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 60f9b6a9582e..6d1603387914 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2876,7 +2876,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	struct huge_bootmem_page *m = NULL; /* initialize for clang */
>  	int nr_nodes, node;
>  
> -	if (nid >= nr_online_nodes)
> +	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
>  		return 0;
>  	/* do node specific alloc */
>  	if (nid != NUMA_NO_NODE) {
> 

