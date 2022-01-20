Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7637494643
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358401AbiATD4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:56:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38164 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbiATD4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:56:32 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JMwpPx032605;
        Thu, 20 Jan 2022 03:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=sRjNKYrHJg1LylS0xuUKRHXgzuikUTKFGWs/OXjvyeg=;
 b=emvTKkhAImajdMDUauiXTlKodE3gASTVqt6DBqVN8x4KrOor0k+JKK8FS+pGbGZ0WmJp
 4uFrBfru5o2o+UwomMhiRsLOT4SCkiAIWcbBKrBaKuYnfhNHtzGfv3kAa7lN0fhqXKTg
 bPPmqkKTna38YXgtHjieSnC/gFcVwj0QyJb1u4l5LVbINlLXfxAGV0yTFH6Qyg6h1lpG
 9L3+kp0sVMm11yS4ME+ZECyUh56Cf6u0cqStkwwOsbNSxjNga0gdAgJTyGXusHEq15wu
 Iy6WnHe+6XujgFxZ/16IdUT5xFfjItWrdjs0SragFpZdtlvatvLq9cvg4uzoeRwLIR8+ Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q74vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 03:56:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20K3odsX170557;
        Thu, 20 Jan 2022 03:56:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3dkkd1kfq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 03:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0WqvPgChFFAhVJ/hqSmDSUPTncH5cgPyDLGYI0XyQKY1Y/Xpr1H1JVObfeytK1wRd0eNDjbosXGoZpcs+Ndw4EFvt2ZsSnLyuRKZV8XMMWZiWHijU5LcM+w3wDbxTkMKuA/vEobrrgQINlHorBDkvXJcvBxRuJxrIDRNSw0c6RxmIR98WjV+ebz/mUgR6S67Ir0XurG2oSNSU0BdVbyW8sE+cnGMAJEu3CrKmy2tTs2q6HCaJNUiXYb1rdDDjKYWAKMFhQcNPn10WFB99vkOW3S2EF2RkYNAdqT0gcfBEEzb8UYR+ApuEQ9QVv6r23jg0lLj9XeGV9SbH7ZoubYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRjNKYrHJg1LylS0xuUKRHXgzuikUTKFGWs/OXjvyeg=;
 b=EKGhNnxuXYtBUHpwWFrkzaUkInY7L8XnVn/xva0wPguZigQkTOhxGSxn+V4/+7T4BYoxDQ8MTBa4//WGXv6i3zFgPrRAvJLnZsJncG9Te741EGkdtNhEcktm6KTvUjF7ufPTQvXt98kpaQMdQoM6KpopOMhfP8kkXWq4Y2EtH/C4zaPbLeicbdGbuZ+F/VSF+IjiPEyIs2UecqBolA4FjT5laQjQjxRd/XYGZ0zZtpO5hUxJN2wNn8u5zFHf6f519rYwvrNHoCyUAtmJ3BG+f5VCz1MbvuH+TwBX4f7OWkglTS8ofWVo8cZIQL42cLlTiPBt0K/P5OfP1FCkjLtwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRjNKYrHJg1LylS0xuUKRHXgzuikUTKFGWs/OXjvyeg=;
 b=J9W26X+LV05NhjfYnszEEB4fUCiQ5zgxY6m5N0umBew0tUVG/T+8sohXcWJnfVA4PVZCKZOsDsViSWNILimkQieP6hUkXz1X7igHXDocLz1w9svqe+yCNXbhwl3GjXN1mwLIyqDk32bbu/LrxRFlBbDkjku/jtqldiSymGMUMoI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3304.namprd10.prod.outlook.com
 (2603:10b6:a03:157::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 03:56:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 03:56:02 +0000
Date:   Thu, 20 Jan 2022 06:55:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lkdtm/bugs: Check for the NULL pointer after calling
 kmalloc
Message-ID: <20220120035542.GC1978@kadam>
References: <20220119122055.1826561-1-jiasheng@iscas.ac.cn>
 <202201191044.69872866B@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201191044.69872866B@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb76bd4b-2d96-4eee-c8ab-08d9dbc8c686
X-MS-TrafficTypeDiagnostic: BYAPR10MB3304:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB33047D0FC07DB36F534A38808E5A9@BYAPR10MB3304.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ne/wF1yCYBn63GKTRlzxv3lbQlBfyal0EbBme2KU+zkkD/N/TZUfAlfO1m9eyVBRRFH8khgVipK4+Y5zz/JEUh0HVRn13NUrgUdORlZpU3vCid1vjKt+oczJqeqQDRGVTPxOi9KD7gJjD5QyTRao/bhhZoB/0wzMH240SoC9tLy+TqqKXwIXd5PIFswg/Or/xbhc4vBs/6S9HI7hmNAqlxQiSci1YXYEaXsBz+JjEQXjf6V68l0fb1+ybxZV7/6vsRyaaV7UjqXCcJO4bUoH8GGh3uWmIHYZCyjdf2/tFomLfDia0M9WWWx7rnFAE68glE6u/op89LDMNm8IdmJfPznugrzoWvtHmFn+o0KZYvTexh9/PynfnRgd0WcXe9MYbE84KW9iOQJZAkzdv2vaw1HwONfuP5wIhuNojBdNxG0R1I7qerGhx6XvtjQgc3G1rgap+1XtknmB+pjw/M4/ZjuURF0He7v3ZVLscA81vSQNrORbv+4eloXtX3718xyzRnpYac6YGAZxXc9e7lPZ9Ox3l8qmF0FHb9xajRfnR+UNSx+umD7B1QA8MO8xoDlDQb9jNzG8tN6B1nUKoIqnkM1QTz2oJ6x6dbzeEz7zkccTgAPoV9Ei/rYNYd7kWTnKYK0mjlSa0+NuGCjBSNVaa5JsyZ8hyZLIrIN8MVbQvsWVZ18cwqZA+8he8RzIio/V+kDSK8u/Qp0QfRW3Isb4dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(5660300002)(86362001)(508600001)(6486002)(6666004)(6512007)(52116002)(6916009)(8936002)(2906002)(9686003)(66946007)(44832011)(186003)(33716001)(8676002)(66556008)(4326008)(26005)(83380400001)(1076003)(316002)(33656002)(66476007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6EEoq1K/PVF5a3OcrXfoFZ0WqHNBjJLOR6BxAw6ihjb2dAI+KvGc/3UQHMB9?=
 =?us-ascii?Q?HgiDJFiRijWEEGPjQodJPUN46AYCGGvUflSgYF7rJ5FpnAjibfcPQgVR+5Q2?=
 =?us-ascii?Q?psy3lASUOQFD/tVzhkcD/DpfmvcOwOEQvhqtHT3jLzGUkp5xy9RmPNvMD1nR?=
 =?us-ascii?Q?Be1OhyKBjX6Y4aR43fLWVHGpOIGVjPCWOXwoSx5qlATXe105/QLKFSqzfJde?=
 =?us-ascii?Q?EMjE0cqlOrAqg6g0n9k1oPxBXVHS/MQDEmZBekRgmULK2Jj+2wnlFVz1ktVC?=
 =?us-ascii?Q?9Tr6D7CiPJwJ3zQbv7imyQYNaJptimPIPvCsafM8ciwTqVlRD5cw1Q6q2RNj?=
 =?us-ascii?Q?TcknTwFDlP1sDPK3IvpQtyCQ4IOyPKR8MtO/ChmsbBJATSo89niYY38PQRj2?=
 =?us-ascii?Q?Wb4O4ZzpZkhpuARaulkHzUyVChKoEZ9XBbnO9VtdiPsiNuLSRS/4u2kyRV20?=
 =?us-ascii?Q?fkch+rwzR4C0xm2Ape4xNrbVxpys3wbDJN70YIp5ZBvCl1weau8WksNd/hbr?=
 =?us-ascii?Q?j0XfpE2RxMIedeCijkKYCeMJ4hX/X8XoT0oQqBrp8Kgf6t7FrNTVs+uYrmFc?=
 =?us-ascii?Q?C9ZJBpMa7jwjROrrZkeMndcjU0qTbjuvtbuZostkAmnr8p7+JteYpQeUsUh9?=
 =?us-ascii?Q?tyU4Of41lZrcb6KJmLT/rDgZLkKiD1gh77Gsae0gDHVPV1Odbhle4bIEAggh?=
 =?us-ascii?Q?LAwvllkOguuw+SJsfQot1BgSEiznntryIePtK2BEgUK0FYPyQtWDPyYe8Ozy?=
 =?us-ascii?Q?xt/rK8mtgVeEhESupHZ8+IccIlzaqc0E4jVTNQpKxEb7394n9vqXaP8H5PKk?=
 =?us-ascii?Q?xrCHbhsk/EF9pblxLqd+ocoZd9OUaU7kW0MNrXPFSldv+5AqMTYoN5W5w5as?=
 =?us-ascii?Q?lYQukRn8r8yMxhVnTBmtD2nl6QO9pJjTrsMAL+56i3JE3Ieano/UHCg7NlB/?=
 =?us-ascii?Q?54q16MsLMS79pInghAWok9kiPW3XrAKHOcWekLLQ0uqU0CEY54DS6CzDO/tW?=
 =?us-ascii?Q?TAiEwZ4aVMwncxlP6z+xEeNHpASEs4dbPLXiA6AmyO+ii9wd9UskPke9usEZ?=
 =?us-ascii?Q?9DUa1Ig0yqw/tx3d7eGCwJVYb8Tds2OqUNViNfgk6DP7tlVYc6Pt0XzCZaHo?=
 =?us-ascii?Q?/Ufv3dusdi0NlzMCOU9pUbHSaxYnCOQhtMTj+DviUJh8LiEJOmyHCjCfnLKL?=
 =?us-ascii?Q?WBnrC/ElvR9edaF4qJpplUnfxxN+Ea+WUVLKq42SjtIM1LlbMUb8Skqy3CZK?=
 =?us-ascii?Q?5/qLDzZ5rf0fiFaCX7V2H2pEvzc6K3+2A2yd3f0/1PK1NveeC3vyKV5G2lu/?=
 =?us-ascii?Q?mFWhhaQgLj9SrD7qJlg7Lt+B4ocfCA31D3Gzg0qPTLoGPjQ8im2yAUc0DEoF?=
 =?us-ascii?Q?FKbJDdnvLpuzeWQV40nPNnf9HLX7rPoZ2m29G2en2g0ItOBQYTMX7mtBGVrQ?=
 =?us-ascii?Q?c7W+HIF69mKZ1aDbOIkN/7fR2S55Od4vKBVgSpt3oUc01e5IONBW97TMH4VL?=
 =?us-ascii?Q?bzuPPpurrNiwgFF1rY0n0RDZ1hZzO8PDoBEy2SnPItAQQ1s/MIn/icFsc3uB?=
 =?us-ascii?Q?rXrVaiSeoxDHer2dUO/iEJJCgLAmuW6RvhAgU1N4Y4owXtOKEUbiY41AYuYi?=
 =?us-ascii?Q?DlYGiWYa5zxirfe4svr1gpD1L9IgP6ofxf3y4bby7HJldhsnqTlBi/Zzoc8g?=
 =?us-ascii?Q?GQeIxOEff9m1fp6GcB+8Tz72BoY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb76bd4b-2d96-4eee-c8ab-08d9dbc8c686
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 03:56:02.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+xcBgrHe7J7X8WRduCZQ9eXrB3g1OaeFVg1+VHU1MX0BNVC3cJzxgAsfy1t7j3zvyalupGaPFiRHh8XrEgVJZhiyKevkstlJxJS1dQYyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3304
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10232 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200019
X-Proofpoint-GUID: b0palV1e2DR61oxTyQsTiu8UB_VWNydm
X-Proofpoint-ORIG-GUID: b0palV1e2DR61oxTyQsTiu8UB_VWNydm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:45:33AM -0800, Kees Cook wrote:
> > diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> > index f4cb94a9aa9c..c35ea54824ac 100644
> > --- a/drivers/misc/lkdtm/bugs.c
> > +++ b/drivers/misc/lkdtm/bugs.c
> > @@ -325,6 +325,11 @@ void lkdtm_ARRAY_BOUNDS(void)
> >  
> >  	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
> >  	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
> > +	if (!not_checked || !checked) {
> > +		kfree(not_checked);
> > +		kfree(checked);
> > +		return;
> > +	}
> 
> This should explicitly yell about the memory failure. See the other
> error cases for examples. I'd expect something like this before the
> return:
> 
> 		pr_err("FAIL: could not allocate required buffers\n");

Adding error messages for kmalloc failures is a checkpatch violation.

Those allocations will never fail.  There is already a warning message
and stack trace built into kmalloc().  It's just a waste of resources to
add the warning message.

regards,
dan carpenter

