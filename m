Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3348B05C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbiAKPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:06:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6518 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243717AbiAKPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:06:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BD7BEn007390;
        Tue, 11 Jan 2022 15:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Cd2jDjz9rGivpY1aullaFnXBZmyH2tA8fBAYWbcOkVM=;
 b=bK7ZMDMI3WOZst2b3R+EwdYSE/znDF2reBVnK45C/w6zuNOtHRMx8bLYHWCO0zO3yCzO
 8nwVkeVHeoKpE9dVBe8yHxkPIA4nrd7CkZK04lNwAcehH9Et8clHC7EcI3oTpJIsfdFG
 FKLw4kRmxDMh7WE/K1xaFgudWTWihTzcjxnRbURYzU+jgfTbc4QKQCvrqhaxhhe4jqv8
 qipDG28wU78dcZCLsqiOrJnxFXsbwfAdh7xuQK0DdZp+YNkRjJu11sH0LPVBbT9YkDKh
 bi/EKTTprRmty4smRds7ibS7ezj0mIz/94EBs+s5WmddsO5ZwC1QVcYwATqdwMB56CjN AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbumut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:05:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF1cOf183818;
        Tue, 11 Jan 2022 15:05:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by userp3020.oracle.com with ESMTP id 3df42mvge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqAnOFf6VYv+YoNY7722fQhgkbxjEWy2eXbxMpcKkmS8Ask2LFmug4EhRpwt+wczFkJ8zkKrwPFm8gBd/vwHws6qf18JCRJ7Ht98t7ewcL02x2s5w6ek2ND2LVdvTJ5OIcIQcGj5ePcKN2PKHMaAO76UOcTEIpgFv/5siGEXyE55PIdx6n/GJTqNEFsdPktFX3Dd1uNT+fbv6N7ZkuIRAmo4mMKOf7oCOMugE2JBGTc8ms19C0Pto1v6we+9qn4g32erTVSz8G7pc4vjdA9/BMI3S6PiJlIgOhx4mowczAVhYEdCcfNKR77TnPZk4JbUQ6+yparWjjH//7fuxoEung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd2jDjz9rGivpY1aullaFnXBZmyH2tA8fBAYWbcOkVM=;
 b=Ny6LD6GupzkphbqR+aK8wsASTQBxXo2yykxy8f3zIqLAz6cZpgA/57uoa1q0wxWm+gch13wgVmHyTx/kiuU+FCz5vHSI5bOwE5Sf5KfL0qmAgQ9UWvL9QICNYVqOXupEPYwhF7Cfn0q3neKOPHZm0hG5fj2iLV7COWMYKbdR1VryE4+xmblDEIQeExdeY0uKgOOSRfmltno358XEGEOWXxl2gXBfQKsB07+JwgPrUWR4ei4vaW23iYz2DiQ4kBYGstUxcRVdCBC1rHXpWG1MogVzdzpS0FfqIRXSc2IzfILy8/dMoi2e/BBQPS+//kiRlWC72M6A1cJp5hnEhY59Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd2jDjz9rGivpY1aullaFnXBZmyH2tA8fBAYWbcOkVM=;
 b=wcAHDRn8ik6SSazDXcskMgOgPIXre5BGsRdU5zbSD510s+1lKXHB7wKq5skESUOoGb+dExzov1uLub2Cq4UdGILzYo1Sm1ANhlLUiVdS6ubrcQgT/Wc+9V4bevALvDqP0fTCPxbmDBTWKjQiBsVAaK4B9gFNGqn8rPt1MGQyxDE=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:05:43 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:05:43 +0000
Message-ID: <6dbf6d62-a860-4b69-5ea0-f540d52dbf43@oracle.com>
Date:   Tue, 11 Jan 2022 09:05:28 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 04/13] kdump: reduce unnecessary parameters of
 parse_crashkernel_{high|low}()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-5-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e82b05a-d5fe-466f-a3b9-08d9d513d6d3
X-MS-TrafficTypeDiagnostic: MW4PR10MB5881:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5881991C11DC46BD2B18FF1FC7519@MW4PR10MB5881.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xv9UIquL/59hNn5nKu5rVInPlijrEOZv/WO+dwWNWkwpbhtGxvBUogAn3N1U5t5nr/rG7HulxfxLetVRAeiYlCYX6j0UewcKEIiPRaaQhAXtZTVE9wO8owvZPigjpc72iQWHkeIrz5XHnkoSh1OJqPuynOrXCKgyBegRgFvGS3tx11PiFLoAvTh3q4pXH7ZU/kXmEECxclhCQrqnUNaPycoor1Rn1BXKGTqawyk33C+uxx+tv2SSuDSE16WA1CgQyfKj96CwTNRUxUCFNAXv0m20zEaqxkxRBAqIA4aeOqMUNh8c2BFTmz0BvraYbZUiZaCFJwaAIPaPhetWCNMOHR5z4FmV6g7h+oSxKCAXe2EtLaYWoUs5BlwHLmbHJN9hSxRkbKCvRzqUoHLsdUmSNrKlR03+8sbRQJbdPqKGfZ/dBYP0KbduIj/4ya2RihmiWpaRBwuJAgiPfE66dMQ4DhdbOHvPqlUChdTySfK1uplYm9ouf6sNJ8GEjncchHxaRz5tfyQLHj316Jw5Qv+jMZHMMWjp2SXh+HFVAK0k8aTBodNNK2fzIbtvLckdDz9kARdG5si3BSLJCnnCwkErsJtw2Iywc4Uy2VQqYqpkm5+BkdguUJFZO6P14gQ/GO+NCE1kn/ECwinONZwF9gr3UpqeUJlkYCVLK2UAowc14yfWJ5fQCWip9xoi7uv58LEbulAK5rtyflroxDT4fm1HfrrwNiEiJGJ40jGDj/9YRXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(26005)(6486002)(921005)(2906002)(38100700002)(110136005)(86362001)(5660300002)(54906003)(31686004)(53546011)(4326008)(508600001)(186003)(6506007)(9686003)(6512007)(66476007)(66946007)(36756003)(66556008)(8676002)(31696002)(6666004)(83380400001)(2616005)(316002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThLUlR3MVF4T2wvbnNoTjVNbUpYVmxXM1B5L1VwcTUyZXIrOU9sbjN5NEV5?=
 =?utf-8?B?Y25hdWJDaDdqelpWR1ZMai8yOXpZQ3dSN1MwMGh4SVlzVzdvVlJlWEZOTnNz?=
 =?utf-8?B?MlVhVFlmSHRlQUFIeWs4WEh1SXFVQnN6eDZNaENDU0xhZU5jcXhPV1hwZGZ1?=
 =?utf-8?B?N1BjUmY3d0dBOUdPSU9NK1IxRkNHLzVhVXBZT3ljZjZWQkkzTkNxVVlxTHdq?=
 =?utf-8?B?NnFsdURuN2xrNDF2dXBLN1p2YkJzSHMyeEVZTlN3blBJT0pzazVTUGVZVTFV?=
 =?utf-8?B?UVpOT3d3SEtycXRoVHJKSjhnSXRqdHpaRlVzVDBmdzlHeFFxSzlpb1pXdko1?=
 =?utf-8?B?NENLMmdPTzdSWHg2RXNGSTc5VVRUUEFxSDVXb3ZZLzFzbU50UEVldHdxQWtl?=
 =?utf-8?B?MndBeHhFNGpJdFNsV0xzN1k1dW15K1NSaHdnWHBOQURoMXNlWU8yZDhQQzZK?=
 =?utf-8?B?ZDdSMndTSUVyR0FxNmJERjlMakh6ME5FNzY0bnV4YnVGbGEzamhaT1dBTjFt?=
 =?utf-8?B?YWlZNndMQ3VSRWR6aTNnbjRwRWM5VDF6blhLTXBzM3A4RFJzSHQ5VkNkSnl6?=
 =?utf-8?B?MTlHUDNoTUQ4cFNoSTBFM2F6MnRoQU1QRW9BeUtlTU9UN0w3SjhYU0I0SWFB?=
 =?utf-8?B?K0ZUWFZ2TW85OElwTmx4VVZhYlZ0WGk4T2YyVmM0QXZsNFZ2aWxVbDVmMU1D?=
 =?utf-8?B?VmtVRzZaZjdZdm05NXhQV04yUkRQc0JubHdhYmxMRFdLYVR0Rlg1L3c5V1Br?=
 =?utf-8?B?aXQ5VUhiSW5hdEVMczFJYnRIUTJJT3FkeHBxNGxkdWw4My9sYlRDRGlDN3Mw?=
 =?utf-8?B?WTZjK3RLbWZIM2ZGV3VwRVhteGx5YlBFZUVweERMS2ZrVXBsOEZlNHlyNWFz?=
 =?utf-8?B?QURkRWU1anlWTnYwdW5rWTlRam9TamhEZEFsNFg4T2FzaElvQjU0OFNoSlha?=
 =?utf-8?B?b1RtZDFIaHdSWnRxRjY4T01jMytWS3lHY0EwUVJ5Ny9kOEdlbjZ3YU92amxs?=
 =?utf-8?B?WThkbEp2ZTF5bVR5VmlSU1NHcGhhZCtIZnNiRytIMWI3N1hjTmY2NjJtWVNj?=
 =?utf-8?B?ZXdaWm0wdWJWTU44blk4b0ZHT0tqVmpsaEZqZTh1SmdGT0E5TC8ya1hSNDRh?=
 =?utf-8?B?R1pQcVpHLzVLT0Rza0lJNlMzTDczZmFiaFRTK1pzV2JJbHVQWURPZ1J6MG9Y?=
 =?utf-8?B?NzYydEk0bXUyZUUxT3ptU2U0NWQ0Rkp2dmlmQW5PVzBiN2VHV2lHOHJvZ2w1?=
 =?utf-8?B?UGI2ZUZaWFdqcTlDS0NhMVlFa2RkcFdWWG0vMUtac1JPN0ZpNzM1VnhCYzZU?=
 =?utf-8?B?Q09RTnNOcFNjRFNiRVJzT0FWNlQ1ZEREN2tZVGxpejAzbDM5bXRjNmhqcHdy?=
 =?utf-8?B?NUo4REIwem5wTUtOaTN5L3VnZWNvdG1VSGtRL0RqdDZvQzZHY2pnRWl1cTlv?=
 =?utf-8?B?QVBOL2ZyTVR4cUZkMkpHd240V2dxajRCL1hJVW5vaFo3RHNCenhlMW1FaDUw?=
 =?utf-8?B?YWdZRmw4OXN3VG5LSVJyWmhWbUxSeEEwbjJXYkMxcHkvNDViZGU0enN4b1JG?=
 =?utf-8?B?bXFJdTZBUnhlTXljeVNaczRJK2JNTkVsOUMyMmtSN3hKbGlhdlV6UmFwRHJj?=
 =?utf-8?B?ejFJQjgzdDYrM3FxUVN3Tmd5dWc1TGYyYnNrTzVEN2pqZGszVndKYzVBY1FI?=
 =?utf-8?B?bkJ0cU51aEJKamZ5YjlHSzJCZ2RIbis2dWVZV3JEbEhvT2ZTRnhMb1ZtL1pX?=
 =?utf-8?B?Z3lJSktVaUxMZUEwVmtMWElHY3JpZ08yd0NrYTFwZkJrNlc0V3NCanZEYVJS?=
 =?utf-8?B?b0JOQ2NrY2VVTnA1TVNDWjlXSlZtd1ZLNVlGblBJR3hZUzhYK2JrNGs1ZWgz?=
 =?utf-8?B?a2tZTkR2dlhCU0VJMDRUTldRRlRnUUQ4aExqalBlaktPaElwaWJuM1BJV3Z0?=
 =?utf-8?B?UFFtYjFVbUVtdW52L1k5bGgxZGtrTFR1dFpWdHc3eTZqcG13b3ZneEx1Z0wz?=
 =?utf-8?B?WFluM3pTK3hQRnVZZlhyZDcwc3dGYzNtYjNwcUU4NVk1azVWUEZnc01uRmo3?=
 =?utf-8?B?bFZGZ3dGenNNalZIcXhGVDZSZTUyYVJlTjhZcHNETmxNZ2I5bEswNCt4TUl1?=
 =?utf-8?B?QkVkTm9IYTBmNWVURWREaVMwbFJJdUFXS3Y1Y3phNk1MbnNOOFhFZFBkS1J2?=
 =?utf-8?B?ZjZBdk9HcGNCTlkxNW9nNlRHOHVoY1pHakpQelBXRG40OGFML05pRlFHOGdy?=
 =?utf-8?B?UVMvL25SR3F5R1FUdTllbUhLWTNnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e82b05a-d5fe-466f-a3b9-08d9d513d6d3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:05:43.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdoV1tnJHCl6IObNIwKLag5KPlFBV8j/w49jLYncZMuROBH/vr0GrdtdlPHGDd7fmyyfnlSESZmId4VPWssFaO/7zdKSVogVYtkSDcLL2QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-GUID: tMdnQLF3iBnk-et5fyDWRNho7wI1DCcv
X-Proofpoint-ORIG-GUID: tMdnQLF3iBnk-et5fyDWRNho7wI1DCcv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Delete confusing parameters 'system_ram' and 'crash_base' of
> parse_crashkernel_{high|low}(), they are only needed by the case of
> "crashkernel=X@[offset]".
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   kernel/crash_core.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3b9e01fc450b2a4..b7d024eb464d0ae 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -278,20 +278,20 @@ int __init parse_crashkernel(char *cmdline,
>   }
>   
>   static int __init parse_crashkernel_high(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +					 unsigned long long *crash_size)
>   {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> +	unsigned long long base;
> +
> +	return __parse_crashkernel(cmdline, 0, crash_size, &base,
>   				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
>   }
>   
>   static int __init parse_crashkernel_low(char *cmdline,
> -			     unsigned long long system_ram,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base)
> +					unsigned long long *crash_size)
>   {
> -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> +	unsigned long long base;
> +
> +	return __parse_crashkernel(cmdline, 0, crash_size, &base,
>   				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>   }
>   
> @@ -310,12 +310,11 @@ int __init parse_crashkernel_high_low(char *cmdline,
>   				      unsigned long long *low_size)
>   {
>   	int ret;
> -	unsigned long long base;
>   
>   	BUG_ON(!high_size || !low_size);
>   
>   	/* crashkernel=X,high */
> -	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	ret = parse_crashkernel_high(cmdline, high_size);
>   	if (ret)
>   		return ret;
>   
> @@ -323,7 +322,7 @@ int __init parse_crashkernel_high_low(char *cmdline,
>   		return -EINVAL;
>   
>   	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	ret = parse_crashkernel_low(cmdline, low_size);
>   	if (ret)
>   		*low_size = -1;
>   

