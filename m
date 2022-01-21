Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F65495786
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiAUBCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:02:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13048 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbiAUBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:02:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L04GMG016444;
        Fri, 21 Jan 2022 01:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HZjjEopL7LMZvyWoW3TyPmDK/SZ5ppLw/WPOKrvLsq0=;
 b=vT6dFQyxtYQTGQe16jBFZ/ac3gULJ5yqevJo2J8DaKo09T6JWZhsk+xS0ZvnnL13GAHh
 lCieMizLxxa2/UderkGdSo4QqER0LDX2KnkZQKljL9G/9gkt9pFVMNf3j+Og+SGke/iu
 xqjzg8Z0k7/POA/U/0xabRr4TgstpLZgF6YcwH8UKm5cTtJKskwBFdSCqvWMAxSHnVCY
 VzIGZfjloXFyJfvCbkYTdoV1KsVnqKBiviLx7eX5InBOBmAdpZSxd3tnrOmYgudE5Gvj
 p20RAR7wBE4uG3GT3VlB3Ctl8iQQ1EUaaRuUh18G9d+tP60rocE5xKk7Wx1b+9DT2HwO bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhydr2dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 01:02:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L111CL030221;
        Fri, 21 Jan 2022 01:02:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3030.oracle.com with ESMTP id 3dqj059yan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 01:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHIyXUpVl1uwGMwronkJBYdt5P6eUTR2dP3LnUwL+aQ9s/0YcNN/xCqztY92Ub3o8Ef1jn1DHNErkk7JqwsrS31P7iDRUuiNul1SrCv3CV+GBVf9q2S3ShGVm/Xy4I63OSesN50YBEcaL/hI26JEUZqirmIlnpaKcqLvRdjW9FMy6MVJ7Pzhc5ZuJuOBQk4Pl9q2BK4Aay5v6QFBTlZZYVXtzsYNdjSTtdcsxlR2/GpYH4XU1ROJymaUt55p8mayCvZLhlUpsyhAEcqne5jQfSuMPsK2ywIWQxgzhnFbxfxkokq2I7EVh6kTC+iB1q86fj0tlw0cjFoA0xQ7E3wZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZjjEopL7LMZvyWoW3TyPmDK/SZ5ppLw/WPOKrvLsq0=;
 b=PIHUg+1G0pSP1nk8RJw0oJAqhS+X3Uk4zCGGVjC8lzmfKT4boRFlgPq8o2TIqLKiyADR7uCFG6sLo/twL3NkM5mS7kh2YwD3kmNRpeynyqoc6x8Ek3f7uKaBeUKz4VISR71iPEdAQRlTRgsOHF37nNNmL0mxMyRSevyOydbPFG71H/zoARkDqPODaJfXYOi+8yXwQ7WWPMxZaEvaukCyE9F1V9pumRYSVlowrPQu5ucxQO5abukwautVLQQvxz36gPEwLfBzcbnRs7JIdy0IY0nco7c2lWtgHjVpfms0kn0o8D0TaZGy0ZUzFYRAMMVYZGGurd+PYx2IA2W9JiV53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZjjEopL7LMZvyWoW3TyPmDK/SZ5ppLw/WPOKrvLsq0=;
 b=dnsxawGlmh5IhXHM23sQOqoWDnCqftd4Xmq/CCeL4GJ57W+ZGk7GQNbf0fv+xBTSNue+FvWLP5PoeKQDuMRjypoCxdBHjzurKqNuRwm/+7dGAcDER6v3MTzlFYWdwSXcfPRU7amSipIKPBeT6s2UFM519ywRano6He6khJHGag4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BY5PR10MB3955.namprd10.prod.outlook.com (2603:10b6:a03:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 01:02:03 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::d914:c494:66ac:a5b1]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::d914:c494:66ac:a5b1%8]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 01:02:03 +0000
Message-ID: <a34aff19-4530-7f44-c849-4b3eb2aa3d00@oracle.com>
Date:   Thu, 20 Jan 2022 20:01:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] xen/x2apic: enable x2apic mode when supported
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20220120152527.7524-1-roger.pau@citrix.com>
 <20220120152527.7524-2-roger.pau@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220120152527.7524-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c388b255-6a9e-4bcd-542a-08d9dc79a338
X-MS-TrafficTypeDiagnostic: BY5PR10MB3955:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB395505B04D09BB49009B7B438A5B9@BY5PR10MB3955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LReU7A7epo4Mx7lqgU6dv6IY0u+NZlC5SkXdMAWYooHZe3u46LD4PH01Z2NMdI8vfVkxffHdJbW+rUQOFNPczUa24z2fKvzD433fGYIlTanp6PuPTtCL0DJl/pu5WiD+YdOiN8v4xxp9cHZRPffhSZy+kxc5qmPv0dW6SN0rFIi59bqmgQ1yMFsKPR+X3O9/UzrtV5TDCBZi7Crisr1ZH49nxspbQGRetfXQMTe2dg1amDeacgtLQTCqPNDN4nHQHKhjy+X2tWjEIQc4ilxnkFBd5WWYfwfTQI4OpoaJ8pjVHrCLWm/X4QkGHizgF5VW2fRwsBabnpfYS/pX9fNrfAVAdOMZa7V/VqbEmmL5OKwxoIW8hRyB0KVxenDJbHq/FFlqpWxQV+jiB8bd+iDw+EdprN3p+Nxn3XlWrGKXh1nCWoRw6pXhD1XMVFG+xKd2oRE7tqQPKtYeJN1lyIXtIaExWKWHrEI4p/KObstHnTIcEkZwLigKeNpZm+dJGj/Xd8TjcixEXbq2QimmKzKp0f+b7v17rc13GQjx+xu8aT/q7u8OAni2hkGLR3Qt79Qbdi1hS8eOjrIETRZ4+XnJ5niawUFAEjwqVgPaIqJI5lyKs9sZAlR1qhAgHrSlwQ/tyO5ZzXHLJZSUC6HGvMArFl0hEsc1p9BG+tGR4lIzFYj8HZu20ssEBSvcZ/ZvTwQH4fBuLHLiw0OYs342DMJ+0bE9/gu0pqOmyVElHdxhox+O8zElhZu+X8Ix1+gC2so
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(44832011)(54906003)(186003)(6486002)(6666004)(31696002)(2906002)(7416002)(38100700002)(508600001)(6506007)(53546011)(5660300002)(2616005)(66556008)(8676002)(4326008)(316002)(86362001)(66946007)(66476007)(83380400001)(31686004)(26005)(8936002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRoSlJhNWlxNU95a0V3aXJKL3BTNXRORExDRmlBbUN6VlpwMmtMaFMyaUFh?=
 =?utf-8?B?aWVjNGJhS3VsQjFUWjBBQi8yK3NKaGJicnNwZlBzejBLS2NheTJvVTlFc05L?=
 =?utf-8?B?NG0zUXF6SXJuU3FpQVEzS3I3Zi8vN0UvUzIyL1hXNmI1U0NUZGFIU3VRZnF3?=
 =?utf-8?B?MkhSdzlkaTRBbUpKOURFWk4wdnhZV1B6Z0ZxVXB6ZGpxb3BZQXNTNnYxaXdh?=
 =?utf-8?B?bmU4aFJsODFSaGJ5b3ZqWnpHWGtKUk1ZY3lrd2VRNzhaRWhwV0gwYTFUVHc5?=
 =?utf-8?B?c28wNDNYOWFOWkFJTHBUME13cHYySUxKOTh1WTRDTFQzUGZRMWJtQ29XaEFU?=
 =?utf-8?B?cXBlOWFpaE1maGJiNFVKOU5rZW5aV2xIb2FhTE90Zzkwck1KWGdDVGdMQ0xK?=
 =?utf-8?B?ZnYwOXdKS0VjVU52QnFhbTRhSzRFZUs3OVVNS0laNUprL0E1OHJqSG9mbW9P?=
 =?utf-8?B?TlVmVjNGdEVGTUpjcmUyTVFnS3IreHFuT0Y4bm9XMVpXTzJXZjNLRW1US2Zt?=
 =?utf-8?B?TWcxRWovcEhwZmFrK0RhTTNFNmhzeXNETldDeUhFczJmWUczYTJMaHdqOStj?=
 =?utf-8?B?RXZJS3JUVUJUUkxJSUJLY0xkUTlrTWJsZUU0ZThsZDVnVTFjemc1QkRXcUE0?=
 =?utf-8?B?a2hwR3AvSVNMbk04MGlWQnpLYnhkVEljc2ZUanJPRFlHYlA3YWJlaUs3YW9z?=
 =?utf-8?B?UHJVU2ROYnhRSVFSYnlySG5CRkFBNFAyaUpWeXJUTHUxY0w4dE1HeDJObGxa?=
 =?utf-8?B?emNCUVlTTmZyRlcveHI4bGtYbm96WjMrcEJyOUgwYUNhdVZmVFlKRUhxTlJB?=
 =?utf-8?B?SWV5YjZLenp1NXlZeWgxVElzUVFaay9nTjg0TVlmVHN6THI4V2M2MlJWa0dj?=
 =?utf-8?B?dmV5dGtWQUxqc1U1TlNCWnI1OC9zQ3I2bjMwNkozUVBqQi9KMWlGbVgwYU0y?=
 =?utf-8?B?ZnRvSUdIWGdRQm1qUTBaUWgrVkFrRnZQbXRNS2hXUzB6VmRib0Z6NDlaOXpn?=
 =?utf-8?B?dVBGQTJzWDRDUExMWTQxQzc2WlNDRzg2N1FyUEpoTmJTRHNsdTF4dzh3dWcz?=
 =?utf-8?B?K1VUMVI0NHZLWW4wY2FWL2pzVmpXOE83WU5CYUd3VlZvRHJseWhvd2lZYkwz?=
 =?utf-8?B?b2gxd0x3d1QyMm10VjBobkV6b29VSFVMTkRIdDJPV2pRWTkyUll6Wk0rcEFk?=
 =?utf-8?B?OUNwTXVjMHd1NnJhVWVGb1ZUTi9Ndm1GUklnRDFyWlFLdGlyUFIzRVltUHox?=
 =?utf-8?B?Ym40VkdnYUpiNVIrMXh3VDZubjV2SlJKVXhGb3pQV2JhaHh1WW5PaG1EU3hM?=
 =?utf-8?B?T0VoS2prOUhWMGV6RUhORXVXbXBXak14SFVoUjVhZ25GR3JtVjdHVTIyVkl3?=
 =?utf-8?B?cVppWlhFL1hOM1NCTmo2SjgyZW45YmxyMERMaFhLSTRLSER5M29XRGNmeGtT?=
 =?utf-8?B?bDk3aks5NU1OQ2IyK09tNjF0VktvVEpURVRTWkxxZXI2VFZuYmtBUFlIeGU2?=
 =?utf-8?B?TnhUWm40cXMyWjd1WDlBZS92V0lSSUJ2aWdMVnQ1dzAydTA3MXdVTFEzRzFs?=
 =?utf-8?B?a2pGRW1zMTFlL3dWcWxDYThydEc5YkZCbUFZeGlWeldMREtoelBFWU9Fdk9K?=
 =?utf-8?B?MzRDWDFLODJ5NVYvWGY1SkMrSHI1RE40MlZwVWhiWjRuby9uMG8va2RLSHFT?=
 =?utf-8?B?Z1JHM0tXVG1FWCtiOUxUbFJvbXN3UWZPZWFhU0Frb1ZvRDQreHBSVVh2dVJR?=
 =?utf-8?B?WndCSC81WFQ4Mjk3S0NJYTgzZFd3S2ZDRjdiVDgxd2F0c0JSQk55d0pxM08x?=
 =?utf-8?B?SGpIclhhM1BhSXBQUXZQaWF4V3czVlU4UTltaDhiQk1RVHhGdmU3dE9KbzNw?=
 =?utf-8?B?Z0NiMk9WUDBpNllrc3J0a2JXSkdBdWV4OXJhUlZIeWJOOHphVzdkWEI5L2dZ?=
 =?utf-8?B?VHpjdkNLbGU3ZS95a2NvSlJESTI3Q1Uyajk3cHVJc0t6dm1nS2NoQnJMYmxT?=
 =?utf-8?B?cDUwbWduWHlTV282T1VJRTlkenRsZnZlbU1TOEJuczFSSStyWDlQUVloOU1a?=
 =?utf-8?B?UlB0UGEvL29hV1J3VHlQVHRGZnJONzNyVmtuNnNMN1NmZlhFK0RySzNRcTVQ?=
 =?utf-8?B?Tyt2SGVPRVNzM0hyZGV1bzNtMTBEc1B1dmoraFI2NjAzcnhKaEJhL3dWY3dZ?=
 =?utf-8?B?bWEzNnFabmZBYU81N1VjZVZNSUZSbzJDV29KMkYwT3N6a09wU2VaTnhSZlV4?=
 =?utf-8?B?RVZrRm1QeFBCOTBuNWdHVURoN2FRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c388b255-6a9e-4bcd-542a-08d9dc79a338
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 01:02:03.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuIda0lIDMSmVkvJykZpqkz5HHg/S/7LWajs/5QGFXSN/SvLilDTegyQEihWHtlhVT/tlOTbbh02syRzhtNMnQJISzcA6822562bUOfDANo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210005
X-Proofpoint-GUID: WmDM26DaljLu4PaiTRlQoC7Al4i5fFyp
X-Proofpoint-ORIG-GUID: WmDM26DaljLu4PaiTRlQoC7Al4i5fFyp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/22 10:25 AM, Roger Pau Monne wrote:
> There's no point in disabling x2APIC mode when running as a Xen HVM
> guest, just enable it when available.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>   arch/x86/xen/enlighten_hvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> index 42300941ec29..ab8171cbee23 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -9,6 +9,7 @@
>   #include <xen/events.h>
>   #include <xen/interface/memory.h>
>   
> +#include <asm/apic.h>
>   #include <asm/cpu.h>
>   #include <asm/smp.h>
>   #include <asm/io_apic.h>
> @@ -248,7 +249,7 @@ bool __init xen_hvm_need_lapic(void)
>   		return false;
>   	if (!xen_hvm_domain())
>   		return false;
> -	if (xen_feature(XENFEAT_hvm_pirqs) && xen_have_vector_callback)
> +	if (!x2apic_supported())
>   		return false;
>   	return true;
>   }


Then it seems this whole routine can be reduced to just

	return x2apic_supported();

and then dropped altogether and x2apic_supported() moved to xen_x2apic_para_available(). Domain type checks here are not really needed since this can only be called on HVM guests.


-boris
