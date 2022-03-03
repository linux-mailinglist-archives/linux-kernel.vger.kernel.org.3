Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11284CBA97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiCCJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:46:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE6178691;
        Thu,  3 Mar 2022 01:45:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2238WA1j007646;
        Thu, 3 Mar 2022 09:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hBuNVQt+sVM4c8pxgkt9idw7wAD4i+iri8F6x9PVMV0=;
 b=BTx4eop+mfHScW6SpLs59Lg0vJ4viArjSEkvpwj1TP3F/gxyQP+RtUloiliJmGIyYQDN
 cOcDqMPgMw3UXEG9cWEpknjafKr/sZBzkt401K0C/gtGXhobyw68mHu5XScolBiUb+xL
 957RMANxNwjlDfnqE8qpMXUMMjTeOffUtbVEjQcOc0oWiYCLPDsxSLvhnvzIsn8iBw7D
 aDxRgErZSOpPb1y9pVIR3fHqYpgIAKbEurO7cqnS6Lt85WDHpvcxoOIgVnP/kUDBiwcn
 6/mq/TolteShQ2ocbpFQhc++Fvf8WcxL3z+Mq+e8UkBq+EthR71v9YLlDK3nS/T2wlgO JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15ar2vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:45:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2239euX3006734;
        Thu, 3 Mar 2022 09:45:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3efc188gk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 09:45:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc0ePxR/8AR+eMHRKUq6QVU9bqr1XSRv/BMmvCSec2FridGcYVLk0WkL+b84n9Iue45QnsvqmuBh+jf2br3w50BwgH/N/CnWPs/NVIWPuIF9LfyhzuG/cwWnrZKH0/qAGDDr6tDXwfPwEfSbLbJ4w+vmrrpzlqltm+CiC94TVaMSSf0yIIhhSm4RhwL4V7YW/LznucZrq5R7rVgXp6MdFVHR+Yi52sHuy+IJq8PeFYwJCbk5vDBAuy27JJzSlE1wHazWWp3vlOy30vIngCfcZi3zc/8GhLahy7YlFySLXekUkGaYh704OLL7FoMEAKtme7qajgp/emWbhNkuljZa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBuNVQt+sVM4c8pxgkt9idw7wAD4i+iri8F6x9PVMV0=;
 b=Vx2uRGWep+g80XzDhKLUKxDRy1GC7WA/0YfKa5b2FsnSdNvjAlMjXiy1qqWhYQdVJHRh0BkIBe94d3f9ZWiGMc1cJ3VvbR3EnlUdDtg4+Dhn0jeND+VfPbe2ZYwtQdVbr8pVuSflfE7KbTO7134+eRakz6rczScox5viFtLkzGdvRi7oare70c/RBG/cVqIc5wNJsV1o5Ui59ZdQHE6JHEzNp4yO8CD2buUQQW1O9qOpy2CSX6GgCA/3pZLTAAWdkvptSyaA+g/Grt77SpFFRh2OI9yJyXzmDdTP/28nETk6gvBaW6cXL3MlJUdL0FUqHG5Jpxb80eivi+2oQDYOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBuNVQt+sVM4c8pxgkt9idw7wAD4i+iri8F6x9PVMV0=;
 b=rOg2R9KNib5Eb2Y0rTu7WumjG/WDbdwZIzI+hgS68g+ZCENQBLuLbFs0D+oBEkV/sTQvbcqGq8/Wk4nicCc3ZGbOFGGl6BILvzO5aeq4CxCNhcVzsRjYw4+pLQPCiaEfN7XwZsxPAkNAm2FJ7X5t4Mf8pYjLvVU892ejc4wDTuU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 09:45:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 09:45:21 +0000
Date:   Thu, 3 Mar 2022 12:45:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <20220303094509.GA9912@kili>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d13393d-1bff-4da3-8acd-08d9fcfa8845
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB548133DE960324AB8D8801948E049@PH0PR10MB5481.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ni2Y2wQqvWZHl+iK40VZZmkpQc7QxwXeuINMADuZZ0cbv8e2mH5DZKx8OsKHVeCkyZGEgHkHT1tPckbWpqdLYG15IiLi46me2OXO1y7xJxCz0H1biO3OvjWQKG+WBgWj471d1i2u55qXl4ym3A2bRBXesC0oCjH9r/HmaF80iX9Dy2KoQatJkkuXRWgNlK6I+3F5SiIj9kdY1XfdnpmFRw1zMDu6T4lQR1NXE2oncOvDE5yD/NOfePjXr1COzP/Hq1yvwzv8kp1NQmF3a8gdxx5espc9MhO/yxQWS9asItvhFTYWBkqKFsZafHzkVWo7Vmco1I6c5ICCM2vxtcoBcAeatvbpaUfRdgLe4S54T3gUKf8LRGvaXI+/gmmk6YVpP2DfrheI53EMMJFgfSn4dSkPqdXrBaupwASFpOKD+sO7zhyk80zLlW4+CoX5LZBq0fvRhdxWtPlgMhaBMqeRpbM1uRj1IBZHntAwuczKRRLKYpL/JDAfPRzogvOn4SFDXiyOvevg3hqs0nQ/q05Db0ovA9/QfcjBpNxfJDKDsR0FLj4iejWSsWwUEJT2q2JsdDpHBwO8DWIwJ6SEiM2h6g+nY7K5lWl7biKoK84HFGxGIu+ZBaoaM+BXZ2rVqYRGyS/FyraUJcEAQiXrajJdzcGYgW4tvloVihcFQHrpg9PEsXoyFDz6LUNrUVusEE5tbhPeDZl7sDB8MPUlRkSuKYrMmLtn7/Fn9zkvCJBuuxoi9BF7OC6N6v3LniOU4OjuJvEWuTaQrN4iGtjWLsR7GEEcqji/4IpQSpwAjPhy4gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6916009)(54906003)(316002)(6506007)(6666004)(966005)(6486002)(33656002)(6512007)(9686003)(508600001)(1076003)(33716001)(44832011)(52116002)(8936002)(5660300002)(2906002)(26005)(66476007)(66556008)(66946007)(186003)(38100700002)(38350700002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ds9W5U1w5L2yFcI67bnTOtYXsl91puB2bD8e+PAvmYL0pjHBBBo5E5ywqYq?=
 =?us-ascii?Q?CW0oB7NL8RSPwcvWVTGd0/Dgsz7kn20qK2olpfcp58xGgQS8Wxed/elXcB5Y?=
 =?us-ascii?Q?mYQuoCZ/iJf9KN6SYOgLg+bmJvXim5lzioi5ipyyPUViLEjlHRYpNnkKeFdq?=
 =?us-ascii?Q?YTmL/7Sjk8PZo2H3CyW7wPqaBr1I+YP9meTMgLxLds36r98TY/lohNSdNR0P?=
 =?us-ascii?Q?SXY3xMpgFQ4uyGYWEfC05fmlmNbNgiLgiyjFfvNVkxBcd6rtp50JfkiBjGK5?=
 =?us-ascii?Q?ArRW8VXmAM7qEUMEWnJxej8FPahH/DcqtAXLElnC9yga99R1JT6jwGuRDY21?=
 =?us-ascii?Q?qaMzOWwZuqgHWuZnFaFyL6pMFjd5pvUfZ4RINYtA0bY688+ETGEogDYrgX6C?=
 =?us-ascii?Q?dFI6cVRr8YBvdyHnBp8avqT46ogKJTdt4mdlkVUdyKpgsMYtvzteKFD7A+h0?=
 =?us-ascii?Q?GYZXb2QIRVDEbSgLybyoXl3H9jYAUZnXgDMf75jbq4tUW+i0Q/UiIGasXWZY?=
 =?us-ascii?Q?QZTs0YCfN4sNXCHXMSR8uNld2sBcI6HtXWZxmjeVKACQ6fbghey9JhjdEbb0?=
 =?us-ascii?Q?AzuFFez8tgru2LN8PAbe2dYUHpOlnzOordfsCOf7PbIMI2VnGy9CSRDEXBrt?=
 =?us-ascii?Q?tJPTgYELKpUuJdqMClTUzp7BgO8TxlLAMNWgXjHGT5NCsZ2J60A/A713+B6D?=
 =?us-ascii?Q?IijnRwA7NfZqL2TIXiu/uP5BrYcjDFaInQ5r8TiVJkcxzNUw8fQQ7aLB9rxg?=
 =?us-ascii?Q?250QHSq3o0vdnGfuKrJto6sRoscWM3uY/Qd3Mp4tzLgg7NnVlqJwLBflTRXX?=
 =?us-ascii?Q?Jihm+Wm7NdXmRI2UwlGKuDmwh1BffDa3juwkcjz5pIKaEwhsRMjXB/zpUFNY?=
 =?us-ascii?Q?hfkW2DYHhEyciBSbIW5/swTVBTTVEN3EvkQfTPSXo6JdXrGB7h9D9R6zyVBK?=
 =?us-ascii?Q?78zvc+EOWsQwygL3IUpV796SF01M2QmXyarQ+Q/WR2Qi5Y1miCxHe4uKIrAo?=
 =?us-ascii?Q?02zHfwgVtbWzA//noG4Z8WUt3VpH73DtzP7xQ5IRcNsSWuV01eAZWVmEDZ5F?=
 =?us-ascii?Q?E233tzL9x6sxLje4zUYFcsNmFAAeOK7WhgygxyG8y8mOl+bJhk9cmJEtCL/5?=
 =?us-ascii?Q?LMEvfv78AT76OTUY3tAmx5G1qoYqk2zSG2Ch+KevHz1656NlgcUDN5Zi+as0?=
 =?us-ascii?Q?qqhnY5eSbg5/myp3a+mhwwIVA2ZzBn1XI/5Pp6+i19ffHKKAwjtsb/KVLFEe?=
 =?us-ascii?Q?NIP33ADKDu2rBySEIpTd3R1hzOt01TxN8Eh9AfQDV0boZij0km5xErbEyPr/?=
 =?us-ascii?Q?5pugn6EsRHZGJS8iCtOsW99SCiROckd5v+csjE9px4rcjvoG8Ps7rCAepemG?=
 =?us-ascii?Q?gfiiby1m3PrLAbW1Hd9rsfGulmIagjdc0TPw1ooXWl87O2QQrhUbO8dRKGL8?=
 =?us-ascii?Q?mArakn5ymoYRhk/C/6f/23xIk8fTkroOPQPjvF5hc2sj4XO6Ub5bbj67q+K9?=
 =?us-ascii?Q?uXhUJD/8A5Q4D+RT17/7vZmQMD8agse+pyCqpBjJ22UBD8QtsDmTCP5+kHRu?=
 =?us-ascii?Q?kMJd//BWM0SbH8u4oBOsAv4wt3KhjAmp9emA2icF2p9DkbN4++oIABSxXEN0?=
 =?us-ascii?Q?g9eh4AgtnCR053ElRglqyGeNKE/HhgXMfy6jeRm8uGFc+27tCvyMLi2vH1Xw?=
 =?us-ascii?Q?smLX3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13393d-1bff-4da3-8acd-08d9fcfa8845
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 09:45:21.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yl6Mu0BxdciEUjPyWv9hCELp0z0OJSi6/KwYoA3wCamc7XEcBxD0iET7w9skBt8wR88gjqdYuJItff+nc8Lz1qbh7vkNFIVAG2VJlovW3To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5481
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030045
X-Proofpoint-ORIG-GUID: nZc3iUIBQPVykgAHhRsruZj1tUkOKfkS
X-Proofpoint-GUID: nZc3iUIBQPVykgAHhRsruZj1tUkOKfkS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:53:34PM +0200, Andy Shevchenko wrote:
> It's unclear from "Submitting Patches" documentation that Reported-by
> is not supposed to be used against new features. (It's more clear
> in the section 5.4 "Patch formatting and changelogs" of the "A guide
> to the Kernel Development Process", where it suggests that change
> should fix something existing in the kernel. Clarify the Reported-by
> usage in the "Submitting Patches".
> 
> Reported-by: Florian Eckert <fe@dev.tdt.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

I've always lobbied for a Fixes-from for bug fixes that get folded into
the original patch but I also kind of agree with Dan Williams that
Reported-by tags are fine for new code.

https://lore.kernel.org/all/CAPcyv4gbgDMGBQ3t4q1EckELbMG5JXi10YuzLsMjFns67od=sw@mail.gmail.com/

Everyone can figure it out from the context that kbuild bot didn't
really tell anyone to write a new driver.  It's just the reported-by
count that's used to justify funding a team of devs.

regards,
dan carpenter

