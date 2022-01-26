Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311AE49CDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiAZPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:20:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42332 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236028AbiAZPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:20:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QExkDp010061;
        Wed, 26 Jan 2022 15:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GNrm8E5xtS68R7VxGY6NavQF8t4GV58C6NffYIcQR3o=;
 b=MoFqtaMpsbL+MQnVJHPIMH91Lcm2vQnpcviyGpS2s6Q5G9tjT55GF49OMmCsJ/C2/ert
 ynIIy/qa2oyxI0vaMc27ErffAGt/OemKNMqo58vjL974b4uYo1lLk0AcYF5T6cNbk3vx
 EH4IKGD67ySuBbEttCSmAetc1cpLoVfc9xntMjHC1xjyJ4itwmesmBF2eDNijjGCroSE
 qRDldu2VCJb+4gxDWma00V0OvwW5AKR9ftjI5OBE4FnmIB50OyVtoI73h7QhAtFepals
 YbdqaZ/FwKkbd1qc5rGXmn4cxxTJHvIHYglqlDFCSSwAg1qdWfQHeQp7MSxh3Cqq46Qw zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfp5rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:20:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QFFMO8016222;
        Wed, 26 Jan 2022 15:20:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3dr7yhx7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 15:20:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx3A/R0eIHMbOcUikdjDBUI2NE5lC6q2SZnasWDneMT7upLap4XYiV0OqiZbHC73zgyUsRNTZQIhH5meSHWqaAgw6gsBu9/JMyh/1BwmIMtlAMf+toCoL54+KDevF97FhMVwBGaFah0cleTv3g7uNfsq4gAMVKTBRu2S4E0jgtyRlZx4OdIf/UvjkAWT3ac4WuLNZ7NCmF3s7f6Ax0jHt5SvbnX2I2MbxTOG3lTkRPPprGCEcvgwZGjUyeV19w5B2gExwUwKBoq/AvcCs1SMPHsnz/AWwqZCsdzXVTtjomUBF3JJcwwU5x3/ZJ91EUpSU2Fb+9O091rMJnwhAxe7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNrm8E5xtS68R7VxGY6NavQF8t4GV58C6NffYIcQR3o=;
 b=mu7Z5O0CWZKBHBZOGw+BKAlIykI1sr52vmU2rE7/VTTds7P1/SfpsRGAiy2S9uOhGzhqwbNBFdm9W6RkyEuMT2MlVxaror/NAUnHpAUSJmX7BXAW8G0gdqB9E6YI+bxm3EW93pQ1XNUAfpo8w7ZD+lWDmgLnubfNT9TP6IXf4uhT0zRiqfMeLW6Om9IBR8X3Gehnmy9ZC+zVeTJpCdn5LwZNRJtRS6DR2M8NDhWmiiF69iYDqKDM98MVT3SuJOXGUtm6OJnwylMz2SVk78GVSAxtgRjy/O55WVSJBIkTwihrOq0IANbGD8zRh8Ntzf9J1n7d/MCKj/CgWrIYwk3mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNrm8E5xtS68R7VxGY6NavQF8t4GV58C6NffYIcQR3o=;
 b=cF2Hn3vM1WuYPjpxkjPXU3rexHW+/kLE+dXigMpL+TW6vAk3qCHKaMOER9Lh0bG2DiB1qV/mDgmOyrlT6scWwYBuJSsrE1441DYR92voCvlDPAF74c4a/SKkR6LRxjHEw1SQmIEq3/7TS0eNcrDGHxhrbCFsvZfcwAq8XJaXDU4=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by BY5PR10MB3842.namprd10.prod.outlook.com (2603:10b6:a03:1f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:20:08 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:20:08 +0000
Message-ID: <8e57b05f-8f50-e160-6d24-e1fdac2a9c59@oracle.com>
Date:   Wed, 26 Jan 2022 09:19:51 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v20 5/5] kdump: update Documentation about crashkernel
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
        Chen Zhou <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-6-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220124084708.683-6-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d2b7edd-9e5b-488f-b4a9-08d9e0df567b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3842:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3842DA46C237ADF6A7E615ADC7209@BY5PR10MB3842.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioLCZvPvhc7/xC/YBcqaKG5HkbXuKFrhay6IBtlUfjq3/CXjLUk/mmf8Y3v2ZJgCnAenZ2uGDWe8zDgnfoJ9iLWDi1eHj2NTy+0GQFurFwkSxCsL5GfoOJI8f1Vg3F+lDd5FqgBt2OLHnXr7U6uUwqlBioZEGM9euru3DqYES94bFhXmamwkyMhzWUrd8SBkG3PETIjYG9BPD/vucTEJQZWUivV12NWM5u951IlMJpZl9xrhGchz7f0Z2HF+dYN4uEF4Ko9V3OCQlTM2+PPYNuUHW7gVFITYusAKoWJl8yafgH8PSgXLhGMpJfsXmN8pEI+E5XkZWWZ48u9h8DxtNXkuO2h+PWIJ1rfZ3xpdShuyDhR1+A4heM3RTQLgH5NclLj+UXZYK7vOs/DBgLLFeR5ips303uM4anvxdDIRjyV2c3RQbUkjLOtv74NTcIQkTPXF5re0cK0ljFjg3EIi55PGvorJ3KH8QCf2zCWXbBmf6Cz+fDjgXT4icliG4I06fBf4QH/n54ounT0BnDRU8v4eDVv84h1JXMkfaUDEFw/vDKM9p3oJshS5Quq/1fasZSqp8AcLN1St77hOvIoiY8v+IC19HsE/8Y1m/7OzM66edAnCt+mstP6pJqpGGsb6HXUBYkGpdjA4oVEuFpK/q0oOjqOH/XGB+ap0Ft82hS9n3TuwPruCr5+j6m86KCvz5MkQNi9vUq8K80PjV+JKDgHGcwSU0wtJCzc88lQx0/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(38100700002)(83380400001)(921005)(66946007)(66556008)(66476007)(6506007)(8676002)(54906003)(7416002)(9686003)(316002)(110136005)(86362001)(2906002)(31696002)(31686004)(4326008)(5660300002)(8936002)(15650500001)(508600001)(36756003)(6666004)(6512007)(53546011)(186003)(26005)(6486002)(2616005)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG83TmNyUkREVW1oY1kwMnRFT005RnI0WUZFajNkd1RFMjgwaVFsNkpkTVYw?=
 =?utf-8?B?ZndkM3A4bjBWZFdLSGJBam9KU3lPTGgwU0VwRGRHT3ZsOTVwQ1BOK094T01P?=
 =?utf-8?B?YitaTXh1R01FTTUxeHlxT1FVOGVEVDl1aHN6T2RSazlRU0VPS2dVNDVlbzlp?=
 =?utf-8?B?eWF6U3Y4TDVYbXcvZWxuY09waENSc3F6WDFpRmRXUlZkM0czaVNXMFU1T1Qv?=
 =?utf-8?B?TWFRWHM5ZVFITG5JS1NPNWt6SEFKeUp2c2ZESy9VZzU2RmJBZ25UUUhKWmNU?=
 =?utf-8?B?QWpwZEtqUmplMno4Nno3VWJzcElMTGRZRFJHNEFCeTZNUHlKSWhmZ3J0L0VQ?=
 =?utf-8?B?TTY2bHlSWXBCMHdkVVI4OGFKUlNKaG1CRDlONkpSQUV0UWptSkoxSlkrSmRK?=
 =?utf-8?B?M3M2cnlRQ1E0cnQreU1SeTVLZ1ZtSU5yeklKZkdOYU1JWFZiVjhpRUNySXVK?=
 =?utf-8?B?aUJpNzltWGsrMFZkWGtHSXJZTG43QWFLbFo3YUJGR3ZJT3pVOWw1dFg3ZUFB?=
 =?utf-8?B?VXBiQm40QnVXTHZCeUdLR1pDVnZ6eVJzbFMwa3B5UkRVMHk4ZnAzYUxtL3Rn?=
 =?utf-8?B?ZThHdXFRVHZwc2k2NVhiQWh3MHRLQXpBeXcyWWlmVlVWZEJEU3JwcldWSHFz?=
 =?utf-8?B?ME9UUU1aTFRJMjlMc3RTdHhmK2plb1ZjZjVOdG8zMW1IRDdNV2tNTjZkdk1a?=
 =?utf-8?B?ZTBnTFRNRk83OFR5NWNNNGY2SjZMaTJOMTVrU0hlMndLd3RQcmdSSTdmcU1w?=
 =?utf-8?B?dXJWR2tOVm5PS3hCcmdGaDBnRFhQY3lNZ0RLNXNJZEdUYVZrbjdGRjI3WDNN?=
 =?utf-8?B?d3I0cjJjNGwvTExFTHJVUVl1NFprd0l6OEo3ZXZ1bzNPcmJMeTFYemI4Q1NY?=
 =?utf-8?B?aG1iNDBRUkNRL3JoRXd2UE9ROS91VEt4WjU3MlNsWUZVNllrazJsYitUeG9R?=
 =?utf-8?B?YXJKSU4yZ0g2NlJldnU1YjJpOHh1aFdTTGNUdzJUU3lZYnJkMm95eTFGa1RI?=
 =?utf-8?B?MVFtZjhJZ3dQWGx4NnpsQjVzWEZyeWw3WGhKc0YzaG1XYVdTU0hrMDcyOTFk?=
 =?utf-8?B?L2poeEp0VGZ4eE1IdFVaVVhpM09Jb0VERHpTK2s2dkErSThPbXM4MmtDZlZp?=
 =?utf-8?B?cHZCV2NHbFhYNDZjN2o4VTlFcmErM0dMRGVEaDFRQlRRTkNOZVlCQUt0WGRI?=
 =?utf-8?B?blBYUTUwc0J1aTdqcGNLZDFwTjdVSmJjR3MrQktZRy9TdCsyNDFVaXRKUGd2?=
 =?utf-8?B?S2xpamhJT0hsR080dXZLNE5jQnhtOTVMVTQ2T2VwWTlkNHlBcWtBVFZkMjhl?=
 =?utf-8?B?RUJFWGRJMWl6QytYYVdGUFFETFdoaGttc3Z5R3IvTzl5WjZMWmNYWnMrVDJE?=
 =?utf-8?B?VUNiR1FwR2hkcGd2VW9GeXNmTUtkaGR4ZklUWk51NHRYa1B6YUtuQktSWjd4?=
 =?utf-8?B?ZFhxOS9lbEIwcUNxSXdlTkhMc1JCQ1RlYncvMzJzRjNyOWZCdVNDOXpnS3hn?=
 =?utf-8?B?WjUvc01ibzEwcFFWbjYxOHFIeDd2SUtIdC9sM1l6ZzJONzg2dW5lUlVHUllQ?=
 =?utf-8?B?OStzWUljUk1GSHY5TG50ZE5IanIwTHRVYXI2TGdjaWhNT2ozYXZ6RUdOaTJx?=
 =?utf-8?B?NWNLV3cvR25mMWpaamxPNVR1SnlTRjAzNkRycVFmMnZJNWkrOWE3ZWpOcHo5?=
 =?utf-8?B?SGV3VUdzY2tjcEFMWXdTMkNHeW4wWFYvWHJvZ2MrMmRNcVNoSnJBWkNlWG1M?=
 =?utf-8?B?RTY5bFpPS1hUV0FBb0c5eEJQRFdOeTBZcWYrcW91ZjJhbW1XTE5kaGlDdmVt?=
 =?utf-8?B?N0dRa3JaMERtbUFLU1o0NjVLR1NKak5zTjRTM2ZqNExIdXBZUUhRRDlYbXlC?=
 =?utf-8?B?bDB4ZjgxY0ZVdXB5aVoydW9IQitSWXlCa1czYjNJaTJxeDVGUDhzRnp2SFhv?=
 =?utf-8?B?N0hXZmxLS3pQd2VOVURVZU53T2tHeEpsVjFLNmE4WU9OdjFRRXViT2YvV0NZ?=
 =?utf-8?B?QUp0Z2tCM2wxU09keVVIMDJhUFNtL3ViZXo5OGFjRHRRSU9CZzJvTUE1Mkpl?=
 =?utf-8?B?ZXBOa3BySVM2MDBHUGlvY0hiODBjekh2TnlZNmJoVi9TM0VmdmRxeFBXdjZv?=
 =?utf-8?B?T1lzb0pBNDFEa1pkRkxTcnNUTFhjUlphdkkvalNkVVl2YnlZN3VidWlaZUx1?=
 =?utf-8?B?Nk5sYUN3aDU5MXhWRk9NN0F1UG1ubXhYdERiTGJLSzJtUE9odG1ueEovYmMv?=
 =?utf-8?B?aDV5dWg1UkJrU3VnMDI2VDdxM1RRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2b7edd-9e5b-488f-b4a9-08d9e0df567b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:20:08.4631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/rW+iesbVml5SenDr5EjdXsi0dBcg+fpW+GoEwH//p2Sgv6610LXwhO40QHmyO5ucijvSa9XVa1ydBzzWFyovjQSZCWfpezkAH9npZJgVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3842
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260095
X-Proofpoint-GUID: 9w2f3yvISBDvrDGsbmtwJ5x_azkm9fNQ
X-Proofpoint-ORIG-GUID: 9w2f3yvISBDvrDGsbmtwJ5x_azkm9fNQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 2:47 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> For arm64, the behavior of crashkernel=X has been changed, which
> tries low allocation in DMA zone and fall back to high allocation
> if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> So update the Documentation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
>   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index cb30ca3df27c9b2..d4c287044be0c70 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -361,8 +361,15 @@ Boot into System Kernel
>      kernel will automatically locate the crash kernel image within the
>      first 512MB of RAM if X is not given.
>   
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
> +   fall back to high allocation if it fails.
> +   We can also use "crashkernel=X,high" to select a high region above
> +   DMA zone, which also tries to allocate at least 256M low memory in
> +   DMA zone automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>   
>   Load the Dump-capture Kernel
>   ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f5a27f067db9ed9..65780c2ca830be0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -792,6 +792,9 @@
>   			[KNL, X86-64] Select a region under 4G first, and
>   			fall back to reserve region above 4G when '@offset'
>   			hasn't been specified.
> +			[KNL, ARM64] Try low allocation in DMA zone and fall back
> +			to high allocation if it fails when '@offset' hasn't been
> +			specified.
>   			See Documentation/admin-guide/kdump/kdump.rst for further details.
>   
>   	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -808,6 +811,8 @@
>   			Otherwise memory region will be allocated below 4G, if
>   			available.
>   			It will be ignored if crashkernel=X is specified.
> +			[KNL, ARM64] range in high memory.
> +			Allow kernel to allocate physical memory region from top.
>   	crashkernel=size[KMG],low
>   			[KNL, X86-64] range under 4G. When crashkernel=X,high
>   			is passed, kernel could allocate physical memory region
> @@ -816,13 +821,15 @@
>   			requires at least 64M+32K low memory, also enough extra
>   			low memory is needed to make sure DMA buffers for 32-bit
>   			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>   			This one let user to specify own low range under 4G
>   			for second kernel instead.
>   			0: to disable low allocation.
>   			It will be ignored when crashkernel=X,high is not used
>   			or memory reserved is below 4G.
> -
> +			[KNL, ARM64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
> +			crash dump kernel.
>   	cryptomgr.notests
>   			[KNL] Disable crypto self-tests
>   

