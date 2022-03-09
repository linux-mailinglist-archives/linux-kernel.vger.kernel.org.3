Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0894D2A47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiCIID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiCIIDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:03:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EDE2656B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:02:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2294EfSw021312;
        Wed, 9 Mar 2022 08:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=PqWx/RT8JosIXlBZpP28a4bfpbU7IyCt6/Zy3SQaDPE=;
 b=OjgsHnKwnv3EKOXV7DOz0mng/vs6MLuk/3Tbw37plsZ8HcnknKe0Ymf4NmcPWiKAj1Xh
 TisMKM869FR3pD+FZPQsvM+ds4t4X7V5MhAcZ0AERcAsYqmnaBQCo0e01aAdaGc8pFaC
 /c3i//ALaCofcYAwsv9iFMnioZ2L7PSfCbYPDeT3856G8pF2nwBN0FdFAcW2peHVa4yF
 E5RdMZ1hJtyhU6bybEPvDhudmGfFYJMrrcj/pHbM2WCVKSf8TxRTEDlG/Up/O5tIkOA7
 6Nal0997QTPzEX9peg0YEAo+u7JjQ+qRuM1KMWWOPLFZx2n9gIYcJ4sPyDrfAUIZHldM qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsharh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:02:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22982KVY023901;
        Wed, 9 Mar 2022 08:02:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3envvm9x20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 08:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgCwifQ3l8jmdV8MBegH6IOT9IVH6Dwf97qjv3w1tkEC65es62EHv/Uigo6j/N8T5QqmsIZ+/5FUIqnakN8gJ7sNGaL0STpSmOqIG9hYbrl1bBzyX10/5viRZXVIneGd6qhaMAavBeq+t45hH9yLWIVlmhcRNtCsaKvdQIvhdfkHpOwB4z2sLb/Y4k36ffjV28YJE9aYqHSDx0HbjnlXji5kkU2qvfQJGpAMyGSNiBoNWAKgMnVj6cAuFsd5xKdkWZGDyPfq1PnvYvzIslA17uUv+GphYJzfOGF+dsQYE12qWryfleRu1/NDUCXc6INOuSuBYOxvZXkaPjbr8kRLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqWx/RT8JosIXlBZpP28a4bfpbU7IyCt6/Zy3SQaDPE=;
 b=dU++HDdqV/hEH0r4m7EyDT63O5QhHqHKo8Vdd8ZNarGV76jSBY+Vp3u9rsQ8r/hMarRz1rDQ7aUekL79R5QD3PJpRfeU4vhTZ6jOcdVjfvAglclM/9VXchvbtAx3bBMBFXtiaKkPl5jt42+Ezo2Z2HsWI79mfQ6pcVnvOr7SWNvvMz88QRrYYP84Fp0u/ZguQJ5e/4ds3Uy0JLYtbZykXyJQ80HrH9duYySMc9odVkGHMV0w4WNYvslVX+J/clu2I6Rr5N6ztMyYCYhH1cvIYWRB3i8aY0rTfgqtaCINvUtJ5QCm3MX+VJC9OMYJzkU2Wwu69fvl2Sz+LfGJJiipjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqWx/RT8JosIXlBZpP28a4bfpbU7IyCt6/Zy3SQaDPE=;
 b=vvGOqwqGFZq3nas7E6y5Q0I80W2gFVK4jofsUhn5E1o5m65S+TwNnzZv4fDL2iwrxideWG9ze1m3SjbMpTVYm8gYYzj9tqgojzwbcXyex07v+55ijbdKprq/jfORe4rALLlQ1XZ4xdICl4SHMXPfKa2fYRRDYn8vAsRnTEizIos=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 08:02:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 08:02:40 +0000
Date:   Wed, 9 Mar 2022 11:02:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Makwana <makvihas@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: r8188eu: proper error handling in
 rtw_init_drv_sw
Message-ID: <20220309080219.GG3293@kadam>
References: <20220308205510.48431-1-makvihas@gmail.com>
 <20220308205510.48431-3-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205510.48431-3-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402cec38-40e6-4265-277c-08da01a32e5d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46868395F1668341D6DC47928E0A9@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVyVHsoXZpf6AOcvHzudhT9eawJaNXOABAxB82rliovebM7R4EBi2MFNJpI51T5p9fH2cpBPLooOjE67xI42hcllImla9J6EwPQSzIe43/cC/H++ljfKjcnATc6HkGCVarZFA5tRjZU/sqW3R1+sacVVGfWVnPAmTkW/mw1sbLFwFd5o8bQ15qbYaV2ja4YyhybP7lkjrDnA5Ob/it5hJhDKS/kiiCq+cL5prhNhzfczu7YmVcPrQI/tSZ8ZiBlLZwSztaJLwLaoBFl2kJQA2/W5FACCFckzxj4Ej0fG0QSxr/1UGDsKPfNt3ikikgM8j+lP38F3S7dzzYoDi/5en8f89rbsAr9UrIvEcEcpZpNP7SYG9ME2c0lXKFpC6OQQtsKvNhYG9CPTaPmTg4PeN9Z2JhMS6UxoE0Vdk058tsZzhRvP7oxD4FMhlKoGWqykFPBhxzDX/XF1HvTa2o3QoQMcg1+6qGQayAhjuepAkA5dvaa5fjP3c1EXVdRUqsSNOI0hAkHFquOQahHtkEikg9KTvik+5SC+p5LB4dq/DYzoUvf1qaOvc+UwsknussegzLnfuSVgWkjNtqLT+kC4qMIKTFnZDeOuEiBE6tDuWKcj83exKIo3+kvcQi0xcLQt5k8NjmuXpdvp7iOHcVOXMnjrjTFMJjN2dr2DFuylK8e/z3FJKQtEaIqaw/N2SVLcnv2A6SoLv52vmobv/BSWjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(2906002)(9686003)(6512007)(33716001)(86362001)(6666004)(4326008)(8676002)(66556008)(66946007)(66476007)(26005)(186003)(1076003)(8936002)(44832011)(52116002)(6506007)(508600001)(83380400001)(6916009)(33656002)(38350700002)(38100700002)(316002)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYqfNK9g33wuXy930hh1BjmndT1cz9zQDyLBa32hcVRuCJQIKpDnRcRXm9cz?=
 =?us-ascii?Q?x9ERK2oDcs1Vwb1j0LP4qjpzgkYTpfeR9L1pl/h1AggXlsCjH8Fu5YPMA8jV?=
 =?us-ascii?Q?4FRHmW6VqzBZLKO7PyHkNJF5pTK6UA6SJEK5wPVFIG5HDXdZ1GEyiUDiK6Dq?=
 =?us-ascii?Q?XxVJIfWOCY/YAKixKd36ZM+5zTjAp9ZlyYDzRMl1t5MfyG06Jl+vOTWrAlqM?=
 =?us-ascii?Q?eF3Nuk0Eg325mfuuxXgDI6jQE4p8Ox9hddqsf041yButxy0Sn6D0DJ6UOC2h?=
 =?us-ascii?Q?MRuqjc2FHxe0Vtp4MqYuxVxeyIG6duccOarf5YLWdVncv7LpD8gUEVfRr+yv?=
 =?us-ascii?Q?IWpnpXF78OXtiQgxVGVHWjApP3UPjBXLGULjwq+lv8h5l2g4UFxOGC4E5ubv?=
 =?us-ascii?Q?QSVFS1EunfWkwnnF72UheYHyoqmOZlEewkq/2G5L2ifQ+nM+IM4A008xDKUP?=
 =?us-ascii?Q?Y9k6GbEuNfAh/R34MAHTXKbH06vu/QcWJQkwYRXLdrqLgt4X9+RA2N2XaVht?=
 =?us-ascii?Q?86lq1Xs9Q2z9mhFYarYw2N0hv0dKilyfbefJ/3Tb759ieRchZW4AjgBN1MN6?=
 =?us-ascii?Q?Sdp+jFwNxg92RdV8p9NHh7nIRIQfXu38tyE+Hvc0nlHOzqi1RzbFU2EQsaMn?=
 =?us-ascii?Q?v3Ju6yZXpVtX/+WgZdWVmc1fO6yXY0uaMhr0tdseMiCdWJEBEmrki4cnlYXV?=
 =?us-ascii?Q?+2IXzYcmKayzc+ttO0J0mgp+CoLl3F+wZCcy2LQZiQKdni8mfHafJqL6P2J5?=
 =?us-ascii?Q?AbjoOagKPnWTYjO+i9ae/CE062f4BFnORSp31D5rMx0RyJwIapOKFPIUgVh1?=
 =?us-ascii?Q?HrWUn7nHmh2VoLB3aPcmdSjxyIK9u9XMLoUxXDuvIT7A212lXPXf0xGUtP26?=
 =?us-ascii?Q?bmPLhX7+wBICO1kUnh7DQfFUALV1HavE+qnZyEgmv2bw9ImqmBPKo31V/Ci+?=
 =?us-ascii?Q?64qQ267ww/VknehYzJpnrrrZ/nqn0GGrJvR7rbhUjwv3FdlPkqlnm8yIZ+Lw?=
 =?us-ascii?Q?FOsZl7dwtUG7SdcxtcCrRaY8DEPXDZICoEcCHijW3Z19L19nLyVcyR5bS3ug?=
 =?us-ascii?Q?aZsJx5JLfzEOQFTufUfrfYW27MHuNZb2qY9eS6tPxVsYH11JWDwsYpmQdUzE?=
 =?us-ascii?Q?zsESiHpBVIPk39O2MWmtsl0caRXkq6WWwsadT6VUXfFDje3qJSUkYQlNpllT?=
 =?us-ascii?Q?+JMG7tNuaZ0VuxWWVIkXD4nXqLtV3MENxM0xaRKBKnXahD4Dvo8msCfEka9d?=
 =?us-ascii?Q?lurXA2hzGtS+N7yLiU0ShDp3JMFFSPX8yIu4a1By9mr0PxYFk1FGZGshGFCC?=
 =?us-ascii?Q?DmbONLzpALFhj/8hxKjD/4v5mQ+2nSnHA0+zeUrAqMHR6L8SOxFrEAGe6qQz?=
 =?us-ascii?Q?u7LARHa9pFigI2P7axPtgr8C0Hn3TANXzSexI1QbXdQ5TZhDG9UaiB1RuVtt?=
 =?us-ascii?Q?RXKfGMskppF8dgsAUGkbo6SNi/KdfxEgmI9vpNa8G5HliFay4CX/CoQFFcY4?=
 =?us-ascii?Q?C/3aeC3Jox5+edSG1Q/zC1JSkYmYip+AeuIjGEDEetVRigfBfYxwEErKNIYz?=
 =?us-ascii?Q?pI3Z9AHzPsLfodaFQgiAqi+yAf8M8LDf3wG6/8PlgufVYnTAnQW06S1hxVXr?=
 =?us-ascii?Q?2TBsWV4jqbsAK2OIlCjp/VkFNWFq9voU1I+LzWGuqe/mFJrd6cprWxxLgCmj?=
 =?us-ascii?Q?oHoDNQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402cec38-40e6-4265-277c-08da01a32e5d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:02:40.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNU60DxSiaDapfNBlQ8Bl1iS5R+zkIWHM2BaLAootHsG5iA5PV1aISaTBEs9y4WxsgExMKxJQPe16y3swEReTTFpYawW30pv9Gno4zYP2LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090042
X-Proofpoint-GUID: Zaez0iYpRmemajFpuju8cb-9ZxSOcrHA
X-Proofpoint-ORIG-GUID: Zaez0iYpRmemajFpuju8cb-9ZxSOcrHA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 02:25:10AM +0530, Vihas Makwana wrote:
> The code inside rtw_init_drv_sw() calls various init functions to
> populate the padapter structure and checks for their return values
> respectively.
> But if one of the functions in middle fails then it simply returns 
> _FAIL instead of proper logging and calling freeing counterparts
> of previous init functions.
> This leads to various memory leaks and can be found in 
> /sys/kernel/debug/kmemleak if kernel is compiled with DEBUG_KMEMLEAK=y.
> 
> Fix this and keep the success and error separate.
> 

Delete the extra blank line.  Feel free to add a Fixes tag which points
to the driver add commit.

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

> 
> Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> ---
> Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.
> This patch depends on "[PATCH 1/2] staging: r8188eu: call _cancel_timer_ex from
>  _rtw_free_recv_priv"

This is a patchset so that's assumed.  No need to say it.  Also it's not
really true.  Those patches are independent and can be applied in any
order.

regards,
dan carpenter

