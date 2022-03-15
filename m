Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE44DA22E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351028AbiCOSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351003AbiCOSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:16:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693612A99;
        Tue, 15 Mar 2022 11:15:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FIEPga024088;
        Tue, 15 Mar 2022 18:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RwrRK0boNdAfxJtmpO6Yl7aDzuT7ST1PJ1JkbLFY3X0=;
 b=uKnMv59FKjA6sG4x7UzKWNEsY/iB2CrL47oi7pPxbUO60Uqz+j8niNgM81AIkHuYOB+P
 k+ZUQjl+mGwetpacVPuqb8mc8lopsi3jujqwx5rUeOcg1NtCk9Fy5Sg/UXSQok8G2u4f
 fs0TZV7w7Ba/nI1A5KaexZ5sU3Zh7I9KcUKIvVvdKEbX5uoWOvLYWBtbHfIo2umlHHsz
 A+Xxa/3UBSNdQC69b0ZWZJzzB+wncKo0+8fcD7Y+dwdZ3SWyT1JQdnnnxXFxiJCmNITj
 gD0LRNBCpkurYAXQ+4sXheo2usyZyBz50yMtmUZVCF3QiLlDS2ChBdn8TNf0KYIMVSNH 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rbw46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:15:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FIC05f113246;
        Tue, 15 Mar 2022 18:15:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3et64k5v17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPe7PbiG0+2RpXx8Xv8GaHWhDHc0HMFIEuRDnTuZnxITTZQ2u2z9p4Boz/JZVtFuIlvZKutGdLgniqZwZembtAkAtsmFPMhAy7ZHqISntMyu8xceYsC4SGyn4xU6KQpTnNn3hay6eu04J9UJx52Vcy075gzWgvd0YJQWrPjrBrmEyQxhGNXITnq+NMvLlWitMGXerFP690BWG0nE0Ixc8tcp3kdwSzIOzDqSgeGSF3nXR+NsvICGz2XSdyrbeiZ+QAoM7RBiJxlxVmW/lcXghALBP9/egAR7/lbPMiClGeWP0lYfEO+p4jfvpa47rqLDu30AgfXaNOc+me2egwSMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwrRK0boNdAfxJtmpO6Yl7aDzuT7ST1PJ1JkbLFY3X0=;
 b=BUDMJBeEL/jfR3382dsJnNMKSiO30j2DE+uQb+fxVKz+jPCj6LazGYtiXvkO3tmk630KRz5dZOU7u1eMBmqo0jJatJSrv5piiIN+YOm14cA52ghjNzOcua1NMEGdvta0paAYF77AC7fow9NkI8prajUo0lOWX+MVpeXaC2oYveCeD1dNfBOsC0ZQkOR2Zm6y8scWWTZT5g88srMa/wm5tVlZv4pVjX83UCKA20k8z1LAmdYXLNMMxChcdy3Vomwps9wynTeGYbTWbiCSEknJIqXPyjanWvIBjiCEX1VL9ENBcdNst/Imt2tgL+glaAggD5Sx3ccJrZQDvPAsSRrTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwrRK0boNdAfxJtmpO6Yl7aDzuT7ST1PJ1JkbLFY3X0=;
 b=YnO9JkEga0t4OB5SDfJ7MzzVbv0ef5kv3PzAvib28UO4ctKrX4T3pW3/t9cknYyadJzs0fBD91L+wvxiPEgKulYyHQcQYoBmq3jrflUKSq63az4zCGEUhoForCEYJ0wVj/MZmxehytsTkBUf2Xw3D6WV7kOueqWvZtd+AB/5nOw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4155.namprd10.prod.outlook.com (2603:10b6:5:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 18:15:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 18:15:06 +0000
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: 3w-sas: Correct log level of several messages
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d8vay0y.fsf@ca-mkp.ca.oracle.com>
References: <20220315060459.133090-1-pmenzel@molgen.mpg.de>
Date:   Tue, 15 Mar 2022 14:15:04 -0400
In-Reply-To: <20220315060459.133090-1-pmenzel@molgen.mpg.de> (Paul Menzel's
        message of "Tue, 15 Mar 2022 07:05:00 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:805:f2::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f229f05e-9a6b-4ab2-1631-08da06afbb7b
X-MS-TrafficTypeDiagnostic: DM6PR10MB4155:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4155E76CDCC19CC06123059D8E109@DM6PR10MB4155.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQVFjGYm0Lc5MpEQfKUuRPLv/GnaqUWcf/KU0RwUoYV5iN/alXz3qdcneIitvsdvDGs47sUfNFUPVS9h1+4tf/5zdX/xo7APEfdIwgaZFpnW8f2D+HOL639F1Wf9pREX9dfl1NvS7ArqZ/yn5+GzxxKEsELcqr7Z2jWdZsSlPCzVMYxLFu7E3AlOLfLrwoypaSwXmXdVRsT6mTTxnewsQKq2JN+YHmt93VCCZPDXnNRWwqYPDM//xfQJ/XBYbwzdnZEcnRayZ6Zhf7A22CKqgvlFPfDH6B1AvuczhbTaXOMJIVMpnxo5y9ApnnLoACgivQPCpp9EZbfhOXxw3kHDbhN/nGPRVC2qH+Z86Vi8aURM8q+Jwqa+hvE5ub3LtZ7P+qLMcVgKKjciMOLy+rMurlP5h8+U+GdW/EXhdEK0WZzFs4UmLMpGMrZI9YtLkYi4XAZZPKAeS5xa7qpLHe17NPqx7zZT6cu4hlvLKfcpminJ7a5V6n5MUHAq+dAzHsZhn/28H+4l9m+Lb2mDSG1F+y5ZekCsTgCCcT0udY2nGudQBWF0LNIIIfNLMBNYeIaReppcXnlwLTo7yUWJaeFi2BQjXczftnR7xa1HmzlnkjlnIHpba+iLzPoJdZz5u/MSvJRO3kIzV346TawsfwKGx/smpQperb66U8L//DwonMNpjFoCMRQUQ6vxIPqM1IYgYnSsVyIRSV7renur3MUoHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38350700002)(8936002)(38100700002)(6486002)(36916002)(6506007)(52116002)(508600001)(5660300002)(26005)(6512007)(8676002)(66556008)(66476007)(316002)(2906002)(54906003)(66946007)(6916009)(4326008)(558084003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yu+48Lv1JLZzp28Sd7YI+3gA1hTEQK6SIzlD3DFQATWgNe/u76LgXg9UN11d?=
 =?us-ascii?Q?1T9QaOHI6bYjUgaNSiNeMlvE9PZQzHRBx382zN2sQf4fjdD/4oIS/ajgwiFM?=
 =?us-ascii?Q?dc/AkuK31ZfD6I62ppWyJW/0e+EwkOM91e9TuVF4MYbFJyfPwpxYyNXxLKVQ?=
 =?us-ascii?Q?QAas0MAB7T3Q6WCRu44I9eDrQLw6togDl4FtLLs66EOf0vkt7lWAIJoMJvoK?=
 =?us-ascii?Q?sr6LEDEPHmqSHdtvdx+93y0oZHwt1/aXCRbnrL51jd+3+Abll1JKGvNSpW2w?=
 =?us-ascii?Q?5Lh2j8+vuBxcqb5UKHoYkv8kBxtKR6PfoM71OaXs+6sbf1Y29Myley5zMrkz?=
 =?us-ascii?Q?aGfsFoCmmB3Az6kEy/Rtsd8EgR2+mxjn0eDXafpRQo7hSnEFIe/DxsAhLJsN?=
 =?us-ascii?Q?SuuDsEQ9nUovrSaIApahjfkUkgj1CDgH9vwEjoR0Y4G/CWzbCO+hg/N2fnYz?=
 =?us-ascii?Q?8hWwdbYXyIPcVvdQxDm/ZbcRDqqkTWKoNceJlgFcp1ZyOJsYw6VU7wrzObM0?=
 =?us-ascii?Q?9E44rYHpnW7H7ntja0LGjBxNc7HsB/KPrycBrij+WqM+io0e8Gf5oexeVBWr?=
 =?us-ascii?Q?bvpld/Xh64bGaI1oYVyCw78H6l2w/HDojVrB8VFCV7jn1cWuCosw3B/6aDWf?=
 =?us-ascii?Q?klDkI7E3tkLHyJDLZQnesxKOO8IY9Zf32HGJWK7BWzEmaDfVX5mZyb+zllrH?=
 =?us-ascii?Q?hpzGRqi61YzZiaf5S1xoqvnX/0BZq7hpvYsfjJVsGGpBZ3U7ZxvT0Bet48G/?=
 =?us-ascii?Q?Qq05sMTlobW9IC62GC4jNrIwCLYfc5KMMuFuhCzXsnnw0wOIrVre6PnO52Dt?=
 =?us-ascii?Q?4XemoLgt/2ptism95qwA5KEyLoIJHiM2VT2YQbtbhSaJvCBuqkrxgLnFyxHi?=
 =?us-ascii?Q?F1Qjf7EiKfJEGN8tKIU2LjFhv+PHF4Lrd4G/+fwZIT2pk8GLjzZQgmgDOEh+?=
 =?us-ascii?Q?PzPqZ7Jn8TXJMap2Zp/aA6eEA4Xlc0YojxSylcZyYnI/U5excd/Y3Huza6yS?=
 =?us-ascii?Q?1XMsbWFTnuwRHf7Gn57YIpSXeuFNTmpG2bQht/WFOLFqTG+5MIP5C8g6G5bc?=
 =?us-ascii?Q?5O8+MQcwVSSUM4mn7+xm1tsn/1SRAi8WXnNr9kxEaMd5wxQpuAJI2TdBYpta?=
 =?us-ascii?Q?CaSW7hpVqVm04lEe+5xxPgstGMDizBUfMJ66gsblTWzUebQ78D0fzT2/hdtK?=
 =?us-ascii?Q?NB0YbQMFQ1jqEXKVuXZQoVP7nYwP8SuQ6v9a3N0iM9gMYOsO6j99Nigisg8C?=
 =?us-ascii?Q?9sAy1sTpfN2sFTSxw+eT1+NgEazWNGHINXSKAp1bhYJC9+TPURH4qV4Cc9qZ?=
 =?us-ascii?Q?RZbrTi900HuzcHKxEOLOyKOo0oUxSy52sui2UfJ/XMUoMESKkR08q6sg+waL?=
 =?us-ascii?Q?15fvRDbS874DWyKZGHM797q8cRwujH06n2EDxZB7OQ5Uq10siG8ihIjjJXWc?=
 =?us-ascii?Q?kVkTEr0NBd+F9yvIJp94kfu4urLDuGWP2NP+WYdrveLLquy6IZ1PRQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f229f05e-9a6b-4ab2-1631-08da06afbb7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:15:06.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NznCZja3OTf1ZUa0u9nfLZaq8DK3MA58Vt9+ey64zBV7QxAJU2zvIqKLXPwsc0QB+7ikUQyitX/hA9vZ2iMDgWKeQfKDJADs/GVhF6dt3DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=824 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150109
X-Proofpoint-GUID: LjaLlAg53OPTYdnDYI-lskmw-eKw_kYz
X-Proofpoint-ORIG-GUID: LjaLlAg53OPTYdnDYI-lskmw-eKw_kYz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul!

> -		printk(KERN_WARNING "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",
> +		printk(KERN_INFO "3w-sas:%s AEN: %s (0x%02X:0x%04X): %s:%s.\n",

Maybe it would be worth considering a switch to dev_info()/pr_info() and
friends while you're at it?

-- 
Martin K. Petersen	Oracle Linux Engineering
