Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7969472EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhLMOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:21:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40380 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234196AbhLMOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:20:57 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBJEAw006625;
        Mon, 13 Dec 2021 14:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p610fW5z+It9An82JWI1dPiI3SnXF0rm2V730pvMivw=;
 b=BM1A4/RrFR77XcAtvB5Rd0GDqBNe1gT9+INtm/Y5jkg8vljdRXfO1rUvuvN3466h9cMR
 tnVqdzH2CglJRYCInUAFNm+A4RHUPqUN0AjRseYnkBmEphkt/hjGR9Z0Nj2dE+Alv1uO
 dogd22t2YAeElV584AdXvgTZ3teWzhFWQcKV/qfFKFcaG9sU0fhbupyoK8Q5But570zA
 PCO2YrASrAEhAv/c5IJk+JsZWlh9/yArLj9ylwBXCxXxd9DSeGC/vNsB75uhddsVZFFU
 UXcvZ1FsbOKAE0WglsHh83FW6gcG8WZTCg/o/YdvjOrATLuMeg9qZ56XwppuIffrPtdU Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u0c99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:20:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEBVAQ154870;
        Mon, 13 Dec 2021 14:20:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3030.oracle.com with ESMTP id 3cvh3vhuum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKl/a/gQmBLGAhcYl5jomiFQ3oISzJviuT/BkY4PAL3vPO6uRHaAPHmIl95w/oH4nF4F3U2giUwmUVmRS2bH4b3LVH+TNpNI67oer4fUjbkE4yJlwsGzvxMYveGuzZiES+stWtWxIpd8wNLJ8BanNaGwXwG9HUYNKNGsYfaYoYPinKNDVJsiLsowvbXn67YF7pNMGKXAS9ui/iDkPTVHPSB8cSMeqiFeeITW9ItmYSrXXs4N29wYYPS+bnQw/dNJELFUsQRuSlUwf9UhaQTcUVMhP3v/ecmXW4K6bJtJGjoaF9DjFLk2NClTBJAJI69QjTyic44+cJ+87rKE5gF+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p610fW5z+It9An82JWI1dPiI3SnXF0rm2V730pvMivw=;
 b=eQwJVAzNxHXVK6HfukGjvwwP3sMJaTZIxoXpKiSgh0t/IXIL9B+YN+bS7HIepB6BIlMhMeQ6wtPXH00L9EFfbYFg9ElxWJgy6DfQpu6S0C7ahKvJnobphNjFhY3g9V4uBxji202cadas8ekVjitl/STlL86+eMiDtEGDXQubUUl/keRFtshPtGdnNFgBFQd2gXodI6vfKO6l/7SV2JHdg9TD12WjU1gPjfI47FiQd7bdXfSkx/qsNRoyEOcBY+v1y/y64SL9n8L24z8gS1iSXaJOMGFHrtCA8DBhilrSQs3QfWTJxjCAW3YLO5CVEU/22rpM6g1ZLA3KSSAGwETCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p610fW5z+It9An82JWI1dPiI3SnXF0rm2V730pvMivw=;
 b=YLS/sa1DJASCNh6Vxc63blqg9Jc1El6Y6i8i8zvCGbj2+OnAt7PnFj6V5UOfm4sU2bKzJJk34fMw8kxgADJ8tbAUGIzvcf5IPukpqQXMi1YO/of0gn5rxenbq/75XH9gfuGlqTUB9nZnO5VxfofODOdIxtvTOp0aX+HFbLUSpug=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:20:41 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:20:41 +0000
Message-ID: <05c0da33-f225-41a4-4310-9cc9b3348275@oracle.com>
Date:   Mon, 13 Dec 2021 08:20:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 1/5] docs: kernel-parameters: Update to reflect the
 current default size of atomic pool
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org
References: <20211213122712.23805-1-bhe@redhat.com>
 <20211213122712.23805-2-bhe@redhat.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211213122712.23805-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::12) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd3ea1fa-db83-4cb4-fcaf-08d9be43bddd
X-MS-TrafficTypeDiagnostic: MW5PR10MB5691:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5691EAC6888D2B31364CC463C7749@MW5PR10MB5691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbYNYywaK8CAbWRtYOm1AdU2GkaETFMjdfw6IDHDD2/eFsi3CIYHvr7mn5eFnYLFT7LrwK/cs/hwCaksX8dQVV93BKrkm2TBoGy5SUMmRd8box2mdqqMrIMnMvbVjaPLGITQ3Ili5LQe3HGugRkiVG7q1v90AVn9i15dxb5eFy24qAXFCPsx1nmjVqLDTLekTA3naeZovAFEfP5TY0PRDkLMQJJ5yihkengobTzTLLmhC7O3BMZobdbMaLu9nEENhw25IuquBtkdGUGb+6+D544OrCvW3vRqFncAwYmf3bMfD2JS4a1121fmgyCRNX06KAmyFNOL3lmlMFl6A8pyHgB12Ve/uZeTp7YzJC8NLK21/2bP6CnBogqBYNIl0ovR07UisJuH6QjMqLDnOy17h9d1xl7ZOUsoKSQXakZgebIDuLDTaBvEGa2NnV/SpupLtYqqJe75XsrRt9OTPShlTkCsk9965MtT9gzI85x7YGTqrOk7Kd9WWhzL6Y9xuZQP9A/AJRqahHm1OBfcH9EV5YkCdQQP1QVbPGdVB1TwS4D8W5ac399COKv1H/I+PkxumzWlSJcr4NoniHGgqbFpyTPMyfZfWhN5svBEtU/hy4qMxBZ+k0rXT/XCFekhzJgyEwH5xW+uq2mPDyj6LkLZfSP//RYALDvClf4hoXgU5LqQnArspQFlk23PcD0as6nCS72o2fANYZFUrF2OOIN2+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(66476007)(31696002)(66556008)(2616005)(66946007)(6666004)(5660300002)(53546011)(8936002)(26005)(6506007)(31686004)(6486002)(186003)(8676002)(36756003)(38100700002)(6512007)(83380400001)(86362001)(15650500001)(316002)(9686003)(2906002)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykk2eVVFK2haNHdNK3Q0ZUlWTmdWMFdrTEZWWElYWi9qbzIzaFNmejB6eWw1?=
 =?utf-8?B?VWxDcXFoTU1tSGMxem9xZ1ZhSGlMb2c5VENWS3lWK3pWMFVPWU85SjFnUHJ3?=
 =?utf-8?B?RkxaZXZhWjA5ZW9IN0svZWNVdUhBdDhiaUJyaUc1MUZTck5ZNkMvYktEcWgy?=
 =?utf-8?B?L3MyK3hwdWl5Q1pTRVM5eDExdDRIVEozd0RjNEkzUCt6RGpSOStrdkcwOXNB?=
 =?utf-8?B?ZUcyM0R0RmxOYzBBQk5jaVpNb3BMUEV0Z2dGWnJRMHRFVjRVdDZZdllYSlow?=
 =?utf-8?B?RGhLdm5CdEw1R3dmeVV2RFpYYkRiQjVCYlVzMEdwZ3RWZkJKeXJsYUxMS3pW?=
 =?utf-8?B?OW5zWGlhZm5DeE9uOCtOc0E0TitYS2VzK0hncmJ5NmNRTzBnSHRyMjVTNTVC?=
 =?utf-8?B?ZVN2NFFZcHBXTG9vd0dlUjZ0T3RqK0hFNVEvYitPcVRJeFAvcUlyRG5XbHd0?=
 =?utf-8?B?MjVZaU13bk9VS2YxYVByL292dnJtOS9TUDVyWXVsUHlqNitKbklMdENFb2RK?=
 =?utf-8?B?eitOQk1zOEpMUWR5UCtVSWtSVDlIbGF2R294cktlZzhINVZmREpoVkRFNDRk?=
 =?utf-8?B?UkdGT3d4SWVhSkx1a1BFdGk0OHdzMXdKRGxpaVJIQVA3aG41K3JOVDIzeXZz?=
 =?utf-8?B?dktrTnJrM2pzUWRPK0NnWDMrVEpNWTNndThqTDhidkFCbnlzVFlwTEdlYnVa?=
 =?utf-8?B?dEVSbXNVRDA4MUpRelAyK0hjeEtGdjZJbHZvVEZwRGh3K0V6ZHpSdVEzcXIv?=
 =?utf-8?B?eTBSOE5uVURmMDE4VjRIb3E3azdZTXZianBCM280bjVMS0VKVUtvK1ZrTmNQ?=
 =?utf-8?B?ai9WcDRjTjFmL2ZtdytVNm1XTGxWMWZ2WWVmaXhvNGRSTEx3MC93eUhIL1RR?=
 =?utf-8?B?M2pHdW91bnJCWjVPRmJWNmpKT2lkNFQ2MHpoOGtDTmFZbnh6VnZHVmtsY0hD?=
 =?utf-8?B?VVRMbjEyblZmSGVMNXNUUEF0RURDK2d0SEdycHJWNTMxMEk1WURXT1YyMWJQ?=
 =?utf-8?B?U3pMSHlSTGVSSHZ5cWxqVUJOTENCMm1YQTg0eWtPeFJidjhvUXZKUjZZaDVB?=
 =?utf-8?B?dkVZdTZyMnU3cXYzK3h1QjNxS0RYcmRLb1libUtPdzZuMlp3NDJ2SmZnK1h5?=
 =?utf-8?B?Qk1CaFBUSzYyc3B3YndGNEFvS0RrTVZYdmFzVHp5MTR1dVQycFdYUUc1NmZR?=
 =?utf-8?B?a3FkOHp5OU5YWnpRY1BicVFFMWxwVzBMQ0RGRU9ERjlaYWJCOUJXREppZGI5?=
 =?utf-8?B?NXlxWlNpR1dVZEN6ZzZ2Vm04R3B2RnRvbFJOOHNRRWxwS1dwNDlYQWJCbzJQ?=
 =?utf-8?B?QUlvbmNWSUh6RHNIMklFYmpBSURvOUFReklWMi9UbG55UExITzl2Q2JZa2tp?=
 =?utf-8?B?a05PNW8waEEySnhxbGRDZWhidUc5VXJhTTZIaEhmRFFpdDVFQkVndWV6R1Z2?=
 =?utf-8?B?UG9waVNrcHhsYlNQSGpRQXFzSjJsYk01eVRhZENBVGs1YXYwNDdMQVEzT0g5?=
 =?utf-8?B?aTArSHNjTnliZ0l1TVFDdU1TdXZzaHVySjQ4SFJuclFKWTNmcytndkFScU5T?=
 =?utf-8?B?bGVZV2ZhRnZkYnVvVVlweHpoTWdSbHdzMmRteExHbXJoRENwa0dET1BsdTVS?=
 =?utf-8?B?MDRiQ01NMXpFWDNVaURKYW4vNzhaODN0QXRsdmFTZGNFNWJGS3p2RnE0K1h6?=
 =?utf-8?B?K2lLUUhSeHVHdmJ2MjgvSEM2Qmt4cW5qdnZZS21SaTBpMXZzYUxlU2dpV3RY?=
 =?utf-8?B?VzFaaVdhU0tlRno3UFdSOW9UL1dqWEF3akRJVjQzL2RHdndVQXpNSE9pUXVP?=
 =?utf-8?B?YllabmRFeWZ1Ujc1NFlWUGY3cnhSRlE4V28zS1c1RWJyRnpFS3dqTWRVQ2Fy?=
 =?utf-8?B?RXM0UmJwVFEwdXhkVEx6cWo4aytNYjZVTXNsa21vTi9rL1FOcmNUS1RRZE5r?=
 =?utf-8?B?SXhZUTRhSXp3Qzh6LzdjV2tNZmt1UHhpdXJsc0FraFpqYSt0SjhxZS9nTXRH?=
 =?utf-8?B?WFU3VFdoMlFMRklINUltQjJVWml0blBXajNPTVdHS2FDVUs2L3JnalRjZjV6?=
 =?utf-8?B?Z0Q5NXl4OWN6QTBRdExJcDFqNzhuZDlnaHFxUDZlY243Mk9xaS9kVndoQ29l?=
 =?utf-8?B?dVBZV0kxKy9mY2dsTCs1VHd0MHpCYmVFWDFIZzh3bjJSeWJOUXRJQ1FoT2lV?=
 =?utf-8?B?NmdVb3VzVVdRVGdKaGVKRlVWbklKTERhVk54VmMwRGlrejA0Q25RUklQRjBU?=
 =?utf-8?B?UTZQYitOZlFnK0ExeWd3RTlCaWZ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3ea1fa-db83-4cb4-fcaf-08d9be43bddd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:20:40.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4R5nPKpYosTSa/T1ciMXh4j2WCZsQ48eTPuUQ3Vxf4DLnboL5QQtPICgzSSMWXekNRxwRRsG09db24tdZN1Gia9HjVPAb2A4yZmqHFu8I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130091
X-Proofpoint-ORIG-GUID: 9PVRotviwCF39wccsY3-kEByhhv4jGtO
X-Proofpoint-GUID: 9PVRotviwCF39wccsY3-kEByhhv4jGtO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 6:27 AM, Baoquan He wrote:
> Since commit 1d659236fb43("dma-pool: scale the default DMA coherent pool
> size with memory capacity"), the default size of atomic pool has been
> changed to take by scaling with system memory capacity. So update the
> document in kerenl-parameter.txt accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
 >
  Acked-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..ec4d25e854a8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -664,7 +664,9 @@
>   
>   	coherent_pool=nn[KMG]	[ARM,KNL]
>   			Sets the size of memory pool for coherent, atomic dma
> -			allocations, by default set to 256K.
> +			allocations. Otherwise the default size will be scaled
> +			with memory capacity, while clamped between 128K and
> +			1 << (PAGE_SHIFT + MAX_ORDER-1).
>   
>   	com20020=	[HW,NET] ARCnet - COM20020 chipset
>   			Format:

