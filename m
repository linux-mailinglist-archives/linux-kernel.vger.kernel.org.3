Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960F449576C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378433AbiAUAfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:35:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378427AbiAUAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:35:53 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L048Zw019544;
        Fri, 21 Jan 2022 00:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qg6IlCrAN2YmC/kleCSTE3gOiRzbIXRBd/h7M7SWyfI=;
 b=hXT9owchF7qUt5eQIuFMfUxqfW8k9CFX8lZqycI/5oiP08bO4P6rwElm31jIXAOt8uU6
 F9mxhgX3dGc+0uG4gdzmUfuCsCJcDHvOcM95oA4EJb2UK+9NaRh6ed58Mvq1ZHIjsOa2
 Fp2MEgW+roXqq6tBGCIAltXVU0RwbEMbyitvmQSuf4oSQ+RdrVbp7yG2MlLwbsNEjNRO
 i4vfK+jT8y50iGWJhplZz3uUIi+T5D8eDczIglaXXNQfy2tq/pvpOjQ6O6qp8K0JDxCF
 TvJRjH4JEwMUsyFwN1t9aeDSDcBXoqzgIPOnP0mmhIhNkV/xgX3dGsiVVmhD1GSYVW4h WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyb81hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 00:35:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L0Ue8E001356;
        Fri, 21 Jan 2022 00:35:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3dqj0v1xyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 00:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlDDi0WicNwNYlhQgIB5e9axp6uw3w8YrcJE0utO3g1ODKzthIbVfFw9x9Sob+1rKoZHFXiptZJxcQxCfRRe9tPhyM37oFqGtkObA6DtWySbHMemsAyN2zScuag3vHg0KOwZ6ket7RpcGuEnwdv3srp7mSfzFDmbSA8YBN3P5obCdAwuvklTSa+JzH7ThE2yqvthiQwJ++kPOL+lYTpvjscObvos6hbiCuCgTo0ALbz9EmgnnEuKdPaeUJl1dw1EgHkJmCr6O5WLWxRunTJH9y/Cik/zu4ji5Zakr/XIqGqb+E0ekQW+aTP3nPT4aw/UsjceykRoCG0q1n8cunU7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg6IlCrAN2YmC/kleCSTE3gOiRzbIXRBd/h7M7SWyfI=;
 b=KvGerFigfJwV2wbXc8rkZ5zBxFT2SW7sSydEbuF/JKsOBYZaq5PniTssHaf3nr34M+4oshVeXXFLyKeGun/z30QmBggYTg+Y7YCcJE3QmkDuQ+jrHvuv+/M0eb66aIdb+gyIW/qKYJaA4k2b0ip+StLhE2erewxTHCpFOX8m4rhR5a0HCer5WKrkbp0v3LcAXDJ8+y9FuBI8N4ogQwfXLK6qnZlwd9Iq3E/9nhKVVRJgFScOAUhAurcvo+KIE1j9hMi/BpbElVW/bSuNnHXAgDHLKDFY/Y4R9ySdwuu55RN09OwG6pvw9Z9iEHnSG9SDdkVRsLt1x941l8/FFO9Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg6IlCrAN2YmC/kleCSTE3gOiRzbIXRBd/h7M7SWyfI=;
 b=wnCxQT3lKTb2mwcX9bQd8ddOKD8HEypaA8JyxJVsYm2DFZdPQ47VrMIB+xsy8Sq1h2cLiMG0ktCzYcNtcp8bddYmh73wEpUjY+OGTdxPJUT7P3JmvJ6CnzOq4aSzpW8GRkjoaHw9SCIKgVksFmKzT2hmr8FqFB4q38p3uo48rKQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 00:35:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%5]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 00:35:27 +0000
Message-ID: <a74a4203-d93b-48a7-339e-86061cc5bbd6@oracle.com>
Date:   Thu, 20 Jan 2022 16:35:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/3] mm/hwpoison: remove MF_MSG_BUDDY_2ND and
 MF_MSG_POISONED_HUGE
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211115084006.3728254-1-naoya.horiguchi@linux.dev>
 <20211115084006.3728254-3-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211115084006.3728254-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cad1d22-cc8c-4df0-f479-08d9dc75eb34
X-MS-TrafficTypeDiagnostic: DM6PR10MB2908:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2908CCEBB6C2FCDADEE359FFE25B9@DM6PR10MB2908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuT2eHHwUVFMG6/7xbR4P2qThD9BpKmCJjs7+KA/8bVIWmD7+xAxaP6n39Iax3S7/WzYV8z+mfKERH0KZjb77ZtF298HJ3dua6WPlatJtddE1IelrhXz7fjbETKcAdwxq0ft14d/knmh/mNxUb2CgKCMErMyIK8Et+7PNslu9OqAYospAvw//ypMfrZGlL5L+ij+PrTs9wryENJFSs/RkcRnZmGL+aNy3GIG4nmmHEmCTJfY34sA4jaaPY4bmfhqfhwIl7C8mX2XZ0ag2qt3EEjKNvcp1u1KlJU8DUq0h/JoXqMSLoMzgn41HQd4yAoc+T+oUqnH245Q98UX8/8dCu4pmCEopsOlklcadxLbsORlbDoCGAVQxFIAAn9mYw9ZkgC3WIIFpWBLHkRIgntvhUQOL7yRFBgn/J4q4D3nTsTLu78NEgrwvLq3T9MYl0dhbjbKwD9ukwtVHjzsQ+ScldEKUc3FL+eiizAi+5pMWwJxbXrtRHew34ou4khWzOCLxD8nqTRzoKyJzizrDTZuu+Cv3irGIbPl4Se5bzakFLOLlWhjm43BfhLhcayjs4PT2RpY3MRdo4CMVzia5Bn1lFSvr7FjTl86YrZk04khdPLvAgpVTewOdfkPKtyWoLcWoPp5x7N/MdEVdgF30ryavWARByfzRuNRyHvDFJm2+cs6XTBNAMMTiQcV6OsKtBXv/TOVhb9JZgdrigwHuDejIbjGXUBp3GMFcz4PmaIGwygo7nSL/hIG1B2Q4buHDt3j72RtQI37w5Ql3SUOsvnQZHZahPIhOlppWjdgKgC5pC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(66476007)(2616005)(86362001)(4744005)(36756003)(31686004)(66556008)(6512007)(31696002)(5660300002)(508600001)(4326008)(38350700002)(38100700002)(6486002)(316002)(186003)(83380400001)(8936002)(7416002)(54906003)(53546011)(2906002)(6506007)(8676002)(26005)(6666004)(66946007)(52116002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZ1OVB5c1dVNmZETFMwdEZPTHZ6TUl0RmRUYlpFQzZxeS8zNkE2Y3d5Uzly?=
 =?utf-8?B?SjUyTWJWMkhRSmxGc214UExBMzNISjczdEpMa1VJZkNxYVhkU05CQ2QyYzcz?=
 =?utf-8?B?c1VBeWZhMzU3ZG42bDR6RzRxSnM0RUtUVjdVWjY2dFExdEdnbDdoRU9uMS9C?=
 =?utf-8?B?YlZyY0RQajR0YzVTaFlTM3FkSHJiV1ZiTjNXbXF3VVF1MnFPSzJOai8zY0FW?=
 =?utf-8?B?emM5aFdlcDVtVTJuQXYvY2sxclFYWXBORTFnQVNsY3J5WTdVVDBUZmdWWC9Z?=
 =?utf-8?B?UFZvVU9nQzkySDQ5NmIwVGtBRXlYSnNjYW5FRnF1NGhnMUtGNEZjbHpCQk5n?=
 =?utf-8?B?UUh5TEdIdi9BWTBYalJFemVtWkVpZi9zV1BHUkcxelZJdjFvSHM4UVJpZWlB?=
 =?utf-8?B?bnJmNmx6UFBTNytxdUZOekxQWkJUTTB0ZjQ3eHVUd1ZOSTg4M00xWSs5MTJS?=
 =?utf-8?B?UjBqYlo5eHRpV2ZtUGhqMnZEcFhuN0NHZitCa0VPRnJqdC9ZSHdET29zd2Vj?=
 =?utf-8?B?Y0hUbXVaSEo2d3RpTmNnYW52TndVemtxcnEyMVZnYlZEL2JoTERPOEpDWW1Z?=
 =?utf-8?B?dk5GK0FPeDRIdUdRYnZ2RThXdHN6RkpVSnM4dkxxY3lXMWYvUDZTWjFoWW5O?=
 =?utf-8?B?U3RMVklsWFpaUEJ1Y1FNTXFSc1lMcXlCMStzUVNkaXN4WkkyTFgxWHV2Tk8r?=
 =?utf-8?B?VmhQQUU5QmM0RGgvN2ZGQmZjZ1IrelV4NG1ualBiMFBUZ1RlSDIwWTJVU1ZG?=
 =?utf-8?B?RTdhclBEWVdnTHdITHljQW9ZRkF1ZGo0R2twY2JXZ015VmtlWEJFQWp0VkY2?=
 =?utf-8?B?cnVTakdLdHIxbWxLLzRMQ2ZQdnZzZHVNSDJyNURhWloyOWNrMTgwRnM0RG9w?=
 =?utf-8?B?N0xkOGFXSFFOQTJRdU9TK0hhOWZZbzg4eW1QcVU5WTR5OFJnRmg2dHJObXdo?=
 =?utf-8?B?RDN3L0ExNDJhYWtjRVUrbS9kNnI5NFBVUXZpNlJVRkVZVDdVOUdFWC9vSVdp?=
 =?utf-8?B?M1VWcmFHZEdmZXFtajZBKzRJd0lBSHFGRlUrazMrVUluUWYzL3gwN2p4TUVP?=
 =?utf-8?B?c1ZjWkVMdjBORnpxN1drandUSG4yZEliNXZjTHZ1U244OXBnbU9lTUYrQ2pv?=
 =?utf-8?B?VG9CRWd2emlNb09EejF5WGFXeVp6VHNnRjdPVGVKa3NUelEvb296dlZNSnMv?=
 =?utf-8?B?MXVMNVVUdDZHQUVaaHJicEh4YXkrWmpGd25UdjZSSCttMEVsWU5hT3ROb3ll?=
 =?utf-8?B?YmYyWFFKSXFoVlJQOFYvWHI0MWhIczlKNWx6OGtYUmkvejdrcjhhK3p6cCtu?=
 =?utf-8?B?b25WcE1SdEFvb0tBNktDdFQ2Z2xyWk9IckxSQzFJSjFIUzFwQmwvNzBvZE90?=
 =?utf-8?B?cEI4THNRaFRKNU13WFpMVzRzazcvc2lPN0ZGcFlDWEhPL1dSNWZpbmxZOWdP?=
 =?utf-8?B?Q0wwRkRENUo0M0g1M09wRnlPeERXcjVxZnJYTTFnM25yVGtabGNkTjZOL1FH?=
 =?utf-8?B?eU1YbmVTUUU1M2JIaHU0Nk9jcFJBUW5ZdENVOUd3N1NZZ2JLUFV0Z2ZoNmFs?=
 =?utf-8?B?N3VWUG15RThiSW9rVXlMeGZOSEM2Rnh3d1N6cXcrY055Y2x5ZFN2UFU4NEI2?=
 =?utf-8?B?ZzZ6cWJhUFFjdTZsOTE3TytPYW04alRBcVVCVFdiOFJRbXhKSGNaTVFJcUVt?=
 =?utf-8?B?bHRSZmRGWlpJWTMwaVdGR21BU2dzR3JzVFNrYnRVN1Y0SmV2YmhlRTVpMnNX?=
 =?utf-8?B?aS9jRG9CUTBLY29JNmIzS2JyTnYwc1crUERmVTlRaE0vbWlyU2lMZzhmcS92?=
 =?utf-8?B?cnNFSVVIMy8zbzRuMHNWUG91anpqbTlCaWxueDdNdk9lYlJ5YWF0MlN6TWx2?=
 =?utf-8?B?eWFRQ0R4V21Bekt6eUE1ZzZqcmdKUGV4SWk5S2EzTEFZWXJ2b0lGQ3B4VEVZ?=
 =?utf-8?B?eGUxdmFNQjhjNmdwcGtBMHMycnRuUG03NWlhdk1hNmoraWZLOEd1QW84c25i?=
 =?utf-8?B?R295TzN1d3hQTXBOQWwydkIzUXltUEdIVDNaYXl2Z1IvWUgxYXNpZmxjT0Vv?=
 =?utf-8?B?NnMwaytGMWNBalMvTnd2NDBwdVdlMytPSUY4VlZhcXN1OHo4T0dTVWlHU1dr?=
 =?utf-8?B?SERXbTBVcS8xaTlHMmxwcm16U2oxRXN2b3RDVjUzeUNmRFNQNkI2ODRKN0cx?=
 =?utf-8?Q?INsljZnOU2NOng9QwTU0F9M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad1d22-cc8c-4df0-f479-08d9dc75eb34
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 00:35:26.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjDO5ktlvhu4V/Mgl5c8eHuDcl1/H7r/lo/YZwZgorifGr5U+rpuQNXmd3a6O+/s4F+xvc18wfxuCH3hyB+8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210001
X-Proofpoint-ORIG-GUID: 7M5fE2M_i_0xZNwrJYyDBBYXUrj7yaes
X-Proofpoint-GUID: 7M5fE2M_i_0xZNwrJYyDBBYXUrj7yaes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 00:40, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> These action_page_types are no longer used, so remove them.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Acked-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/mm.h      | 2 --
>  include/ras/ras_event.h | 2 --
>  mm/memory-failure.c     | 2 --
>  3 files changed, 6 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
