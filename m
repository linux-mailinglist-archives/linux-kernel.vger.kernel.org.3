Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6C4E6A73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353209AbiCXV7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCXV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:59:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D9B7C4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:57:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OJQNVQ000397;
        Thu, 24 Mar 2022 21:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kAXksjKsRddXwTmPVTdqxq/sxrlGwL5sjFhDhTQU4mE=;
 b=Qu/iaG6o+pU+9macpv+psgAiHUcnvjBtO9USzAK4s2Q28YUZVYku8XsRLG7eDbjDSScR
 Ii/BnIE57SYjh2VfK0qp+2CeiVtR0qqAkRGHWLOia8jtgboj61SDHfTZyZFdvYIFZb/2
 OBD4RNQjIVXz5h9j1F5TCMVMUh+c06271A5YcnFPy0OXnThdCykpnKSpN2p0MzOZsYXG
 ri5lOyaKfJ7IW2UHuE/IBnBcycuM17WIsTM2kmPL16SFqDp+96ntlYVtwESLB1rFQPmG
 jQJ8xUNYCnZXAnO8c047vQEtj+gtqqNcGzbNbOadPXuRN8gP+kr6o4KdyL5KBk7GnrkL mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72aneru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 21:57:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OLqXYA174158;
        Thu, 24 Mar 2022 21:57:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3020.oracle.com with ESMTP id 3ew701sqr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 21:57:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2e60zPiQkeR/B2UHFcQuq6s0w1A8tSzkRC7LDepgxT5sIWiAg3smJnc8i3ip8nNJlhDsrjcCbUqvORwInQMpPrdvOjKhz1mHa+MdfIY26UESyVS442fUQ+mInTpR7N8C6luAhnrGk65VHFmQ6VmD+5D6/9n0FcvVg24Qua67kA5Yo19ujflOaz3Bt2AabIQH2OTPk1PNH81FjhadYCweQqMjC/cTN1Xi29sMjY9BHNCKw5gABILMqYqVx7kh029JCUzLHoVILz5nGXYTpNGukZTOxPeOo59Iftfi7QQ8qBstLtVkgC5Ot2SdqpCtqEYFPYiTBGT1MRLmyQ5p/fWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAXksjKsRddXwTmPVTdqxq/sxrlGwL5sjFhDhTQU4mE=;
 b=aRqiMjYXvtbascPiJYFSNKvlrUh9RBwhj1bOLASbNuv27RM8d/XPdrn4HMPc8SKaT8Ia1Dzvb8MHEYvd2RHWphnnnI0dPQg1OepHrAtBrVLf7k8Bgi0jSzK5JT4mbAFKWmUbUHT9zRb3ljoUgr3E5w85YQMeeyebjgA0XMKuQMeG5ljRHkgZCA0/jcoDxwtDK24TipEn8/fbLqfSLPyaEIUT47nr+mctOPgZKl7hZ0xfTNmPye3nLjEDa4z7bootsHrUwdHlzkQnrtUT8SOpKMwiVg2/sQXpSPruQHR2tOhckqtLdQQCaXGBP6tqSBa26gjlscJkPd+qZRFNwNsyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAXksjKsRddXwTmPVTdqxq/sxrlGwL5sjFhDhTQU4mE=;
 b=L5c/jvUyiukhkqVK152FuTgRKRBo3nbW6P0G2odA0X/OtJSY/ZzTwKG8NdhFJ5EOVkn7WqgiKbxI5AnXeBExQUKhM91vGuepBODBsEwndy+iXHKYttRZF0hFwVh8Jv03avBuZu528Stf9puuQ3TdMbD1sgbNOJBgQwwxqeW50Ys=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2602.namprd10.prod.outlook.com (2603:10b6:5:af::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 21:57:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 21:57:34 +0000
Message-ID: <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
Date:   Thu, 24 Mar 2022 14:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, akpm@linux-foundation.org,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220324074037.2024608-1-liupeng256@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220324074037.2024608-1-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d25ce6f6-9046-4548-efab-08da0de14d10
X-MS-TrafficTypeDiagnostic: DM6PR10MB2602:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB26021210D9DE0C255DF391BAE2199@DM6PR10MB2602.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuph7NGTi9p3XfuEG9e6t87rSMYok3bthCzSy6mtcnCDWGXrHB7zAqPGRgpTx/6I6P2hZcHSEKNJWHFmApcQgVDIjRhjd8mhPgSyE2DM4SBtheajmiEka7aU8woay9onVe7nYkUaZPzKB2O8oSQiVda06RqwGY1Zo1FGlfZLMyTBhxW3MT7Z3yCi+00HNv77c3yM+Ct6PBa98jMlqyBEhijY0bY9NKeiC+enWj1ehYBw8jfW/Oa7H/eLoLgIs5gS2C6Jr0f6rws9w2qdLBZ9JLgvA8q8w3lMARW4xaxGCOkTWL5PP8wUQDsQIrdeykApeqP6uRuEIZGE0hWBaRzz7XR41czR2cdNaHAFaupelHZ2tTkoLKMU0Tx4ZFmWYB7WAt33OE7XMs77X9QItLcuBnYApgDlI/i8eOKOctNrW90Cwq1sNFTN6XuTtoMz/Ahb4RH8YK7Wuwberv68NlA6MxTqIjWNLPAGeoF4vzyViT0xWnwQyrC0XgeNpsPoD84xjTgIyN1rdciZPUVj3cKt96hepzkSRxxRAHtD4GdrMQYuC1vgLT90KdWc/nP2umRAjDddvVe0NuBw9mdhclsgm3qIUKro48nSHSSuVGo1gobagE4KgrcaW4AoMRgCPkFsjf9onW4oIRPeYuhRKVarN4xl1XhnWS6/QhoazCRv/wc6gUQcmms4UBXtFMpsUHevdAbM+4dDb+DR2ST1zAsTIN49FUfCRFJ3TASLNyynnnCAj+vVut7dRqrqZkAm6D25JykD8AvPb2T/yPbCvt9Tkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2906002)(31696002)(66946007)(66476007)(6666004)(86362001)(6486002)(31686004)(36756003)(6506007)(52116002)(6512007)(316002)(53546011)(8676002)(66556008)(38100700002)(83380400001)(38350700002)(26005)(186003)(2616005)(44832011)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZKUDBjaUNXeFpaRzhiWkZva0R0Und1UnExVU1CemloZmRWMlpsNXJuc21W?=
 =?utf-8?B?am1aZXR1L3U4aUY4SHVXRjY1WnpRUVZ1UHF6d0dBQ0FDK3BmU2ROYlVBNVdi?=
 =?utf-8?B?MUgwQmdHWDV0d1hvSXhyYXJKQ0pOc21ueWhSWDVncmMxVXBsbUZSMW5wVzFM?=
 =?utf-8?B?Ni90R1Y0S3JpSTBSWXN0VTFRT0VUZWU3ek1VNEdhRDFCOWY0SldtVk15ZC9R?=
 =?utf-8?B?SFI0a2Z6bnhkMUFBaEQ1eDlJTkFoa3N2djBZaENzWTBNU0ExNzkxMGI3OGFM?=
 =?utf-8?B?L1lxc01KVFU0dkdjVVZ1NGtKN2tKUEJKalV6WElaWjl2b1Z3QmdXc3NOSTQ0?=
 =?utf-8?B?VnVKRzY0NTl4ZWhERVlVY1JWVEVZZkpHZG4zVE1wczMrYmZnN2IrVmo0UW5C?=
 =?utf-8?B?aVRLcUwyRmdTdWdtaWNLRjdUTE5WMFh2TVZqa0dodHJnOFVEWUl0T202NnV1?=
 =?utf-8?B?UDFWZUIxRTB3Q0pEQ1c3d1pWM0kxaGw0QzgyWktoeVZjVDI2ZTR6amk0V1Fa?=
 =?utf-8?B?TEtUcjV1cUZHTGxpSzlUNlo3dWdQRkZ5d2J6RHNsRkd4U2dUOC9iWExFSzh4?=
 =?utf-8?B?N2ZveGgwamtKc01TR0tRUHN4dW9Hd1hsUy82dTAvRGhmY3g2eFhpSjdudndF?=
 =?utf-8?B?RTVobkVSMFlxbjJ2N1I3WXFFMTJnL09xNU50ZWxOQnZlUmRRSE5OM01yMW9h?=
 =?utf-8?B?ait0Q1Z6dHdFMzhVUFB6VHhYZ3loR2hTQ2xEamkrd2NlR2pQL3U4bEpjOXpD?=
 =?utf-8?B?RDlBbVh1VW50VVVhU01uTlVYRzYxeHdPZFNGZHpCRFkzbjlvV0F6aWkvQWJT?=
 =?utf-8?B?MGc2Uk5iSm1JVGloZy91eTFmYnJuWmY5UWxDMTNlN1dtSXFROXdXaTd1V25X?=
 =?utf-8?B?Q2JjVW54ZUFyQTVpaElLdEJmQ0w3K0FEdTdHT2tXM0VrUVNSVXhqcGdzVWh4?=
 =?utf-8?B?UVlwYmZOUkdra1hZRmVCRU52Ti9lcDhzMlJMeklHMUdDTWpxVmdlOVA4Rkwz?=
 =?utf-8?B?aUlWT2REUzVScXY5Sy9tOFR5a3RxV2kwZGp4OUp3bXNGUm1sNVl5UXhnRjJW?=
 =?utf-8?B?TnlSNEt0bUdNVWNOTDg3TzRVeDNIcFAxUVI1VDZucFROZ1h2V1pUTEQ0Tm9w?=
 =?utf-8?B?enY3TEdlRUJDOXY0Z0JhWW16aFdGWXFvMGozSzlpbjZyU1FuM1Y4OWd0Y2wr?=
 =?utf-8?B?dFRQYnB6VmkwTm5YVWJScGJvN2NOU01xUmNEc3R5L1A4UGYrdGN4ZXF6bFdS?=
 =?utf-8?B?bitXUnczWW5mSDJQV2hCcVpPWnQ0UjljSkZYU2Jkd1dIWWVlSkNQaHQxeXEy?=
 =?utf-8?B?SFoxaDlrNDZua1o5TjM4SkpUenJ2S3Exb1V1RkRpMSszbnpTREUyaktlcGt4?=
 =?utf-8?B?eW9uMkNOODdFQXF2M0FUaERWelFuUlE1R0txQUZoclR3Vk9Eb1piWGpCMmtP?=
 =?utf-8?B?VU9GL2c2U0h2cVBQUmxjelhwa3YxUTY1dW5PeWgxS2lOZ3Q0N24rRi84bkdO?=
 =?utf-8?B?bUNHME5WZ1NYVVpoVURxaFQ1Wk1oZFF3TmpUWTRtNVhZTTRORWNQYWgzNDE5?=
 =?utf-8?B?anNMR0hKbmFHd2ZKY01yRVFTTEtsV2M2ZzJ1Mk5BNndPSFhqd1VFcG1nRnN2?=
 =?utf-8?B?bm1DWjl5NURlMmx2UW94ZnBPZEc2a2dDZW15Vm1yUDU1NWNteHFiTUo1Kzhp?=
 =?utf-8?B?bSthQmxQNjk1UExLZmlETmVSSlNoYzhmT1hVaVg0d1VaQnI1SmMrRG1ta2k2?=
 =?utf-8?B?YWYyUHFlQ0Ezc3VmNXRiVEU1bk1jbm1SRWtLNE96TzNDY1kvYlZLQjh3QmpU?=
 =?utf-8?B?UEFPQkdMaEZMMlBRVXdONHRWTFNCTU1EelplVUNjd2pJYmdZcWhYTU4yQkdN?=
 =?utf-8?B?OS9OQkFnczdmZVcrR3UvMnBCSmFmcy9UMXFqczNSejEwWkZNdWk1a3UyOEJz?=
 =?utf-8?B?TzFMR2xRTHpqVFJDYTVkMmtwU0R4d1hVR2Y2OHE4Z3VvT3Rhc3NIbTZrSnh6?=
 =?utf-8?B?cjVOVlhQV3hBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25ce6f6-9046-4548-efab-08da0de14d10
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 21:57:34.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgG5PN9dZDONKuWyExWSV9XgIH3v4rqe2dToaji3lR9lDpC1gQSuA/WSZbCOvrkh5xt9SDHJU+4G1T97IFU6qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2602
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240115
X-Proofpoint-GUID: HCPcK_dvwSERUOwVVU7ffsqZdOfVGuyP
X-Proofpoint-ORIG-GUID: HCPcK_dvwSERUOwVVU7ffsqZdOfVGuyP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 00:40, Peng Liu wrote:
> Hugepages can be specified to pernode since "hugetlbfs: extend
> the definition of hugepages parameter to support node allocation",
> but the following two problems are observed.
> 
> 1) Confusing behavior is observed when both 1G and 2M hugepage
> is set after "numa=off".
>  cmdline hugepage settings:
>   hugepagesz=1G hugepages=0:3,1:3
>   hugepagesz=2M hugepages=0:1024,1:1024
>  results:
>   HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
>   HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages
> 
> 2) Using invalid option values causes the entire kernel boot option
> string to be reported as Unknown.
>  Unknown kernel command line parameters "hugepages=0:1024,1:1024"

Thank you for debugging and sending the patch!

My first thought was "If someone is specifying 'numa=off' as well as
numa node specific allocations on the same command line, we should just
fail the allocation request".  However, this same situation could exist
without the 'numa=off' option as long as an invalid node is included in
the list.

With your patch, the node specific allocations are parsed (and processed)
until there is an error.  So, in the example above 3 1G pages and 1024 2M
pages are allocated on node 0.  That seems correct.

Now suppose the node specific allocations are specified as:
hugepagesz=1G hugepages=1:3,0:3
hugepagesz=2M hugepages=1:1024,0:1024

Since node 1 is invalid, we experience an error here and do not allocate
any pages on node 0.

I am wondering if we should just error and ignore the entire string if
ANY of the specified nodes are invalid?  Thoughts?

-- 
Mike Kravetz

> 
> To fix "1)", hugetlb_hstate_alloc_pages should be called even when
> hugepages_setup going to invalid. To fix "2)", return 1 so that
> init's environment is not polluted with kernel boot options.
> 
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b34f50156f7e..de8e1d8a2c66 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4189,6 +4189,7 @@ static int __init hugepages_setup(char *s)
>  		}
>  	}
>  
> +out:
>  	/*
>  	 * Global state is always initialized later in hugetlb_init.
>  	 * But we need to allocate gigantic hstates here early to still
> @@ -4203,7 +4204,7 @@ static int __init hugepages_setup(char *s)
>  
>  invalid:
>  	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> -	return 0;
> +	goto out;
>  }
>  __setup("hugepages=", hugepages_setup);
>  

