Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFF4A405A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358289AbiAaKkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:40:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358280AbiAaKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:40:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VATi8i019158;
        Mon, 31 Jan 2022 10:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zdxXsbZJ9cFUbvj+RVgWcg9tEmNDWHTJ0ES5ko21pXI=;
 b=QPmGCsMcANqNa48+cwUpiQsuc+Lkxopy96rT9YRNcMhO2K9wQnrFeRAsiH2JtSKPZ0E3
 qLJ/4My+dlbghcy2rB5mo+otlOKvbfUqpk8ENRxOEpIACvVpBlFmL5QsssFiBN7nwles
 RSqzkfZtGhgH/q2CjMaUQgftkTYXtvxoP2YLLQ2Uu09p+OkCKym7//FdEB3Fip0+lS2o
 u3sQJeLp3SNomkISp7m45ooJgqmWn3QJtn9sdn8usfztaW0nLcMLYkUMf0CGzDeOyqn/
 VEX0O7LXlFO6qM9V4pT/EprPIx9snLZ3G9CcmNgOVD8gPA8HA4fZEaRLf8LBSnPtRC4d tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvwfb3gec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:40:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VAeFrc140878;
        Mon, 31 Jan 2022 10:40:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3dvy1mdrtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2dF6DO3MmiQvy5kLCArnYkbkvNXxBTOoAa8KmGwkynYwbzHo7yZdPu3ntdVNSG2gX7rs37wOT+qaQCj9dIBcJ0ApfebzGtCp27M4VKc0krGK/OvkV/6g0OQlXMMnRdCxfDoqKpbilhGc0oojMlyyA0AnK4m3SmyrzygDFtFLObWS2UswAlM2qZaz6TnVDEsBKIHf7AoV/3fapjQTsvDe6o+iukuqv5Vc+Rg53Rh93HOWv0+2KHQV+69t16NkPKwdQbEj5OheSFN0QioDo75H+OyRopj9VJYP4UNuBUlyvMREmZA3VSTd3nnt7j7xs3QfHgnr3Kl1cru1JI6DlK1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdxXsbZJ9cFUbvj+RVgWcg9tEmNDWHTJ0ES5ko21pXI=;
 b=KQF6dWn3LLWFuJLLylL9NEYU4wxI1kcCJ7aHgHDbyh+46AKpLFWH7xc60CDOpCMVrlOB5GKAQTekEx9kqxIZSlfqzQhmI1B3xMN593y1tlTMCZCnBsKOT9lYzrSXew3HrWfKGsJGmlABX9/VafxILvyblRk/eWqx/WNOxc6wWP2R3DDbSkDXzaXjqI8qqxdxxOh9fxzyRixX+vgRBk1c/DT7SpD7z36petQzfaf7EndY/niWIIvh4Ty4VO/6mAxvqHFhjCKA889ftq55fkUTc1fnUmBRJ4urqu3bNvHOV9zc6cpx8czykvySEdntfCUPMoiYhy7OUxLfTXDVdHxmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdxXsbZJ9cFUbvj+RVgWcg9tEmNDWHTJ0ES5ko21pXI=;
 b=WV3VmUI70bVm22m2dgCyyBdvyPVcHmJOLhnUM2zZkRoNL3vqQn6xsLP9hNWd3rI/QpJ5LmGWbgNs4XmgntN+P+DJL9vG5USFpBAOwCGJts9VjnzhcF6l+uPoZZst2QOglkydhtAG4m0LLeKfCgoIFvsOlXNaTKNf8znbVcUv+U0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1586.namprd10.prod.outlook.com
 (2603:10b6:404:48::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 10:40:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 10:40:40 +0000
Date:   Mon, 31 Jan 2022 13:40:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: remove unnecessary new line escape
 sequence characters
Message-ID: <20220131104020.GI1951@kadam>
References: <YfYtsiKbOXghIN+5@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfYtsiKbOXghIN+5@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38406b73-806c-4a94-8a8a-08d9e4a61ff9
X-MS-TrafficTypeDiagnostic: BN6PR10MB1586:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB15864D4930E9E0DD42CC42648E259@BN6PR10MB1586.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLIZHdHYGfo92XaBgis8VV8/4yby/5K6Sl8U8PZl1ThVUlHwJbN2JxHjR2UBtBhlDKrEtifDpCIfD0hOrtMacUFkxH0blvPF42/w9lU5Zw9IYjFYzGmz7CL0x+EFwSF3mkov0fu8kkevufHz1RDOf2xaXlkjt7FjyOzgjMx7a2b7WZNm7t+2CiXfUyf/1xIfyPyTO0tyGaAIrfMVVh+432bP1lk66fVjPQbQq6ap68R43z1UyQn8XvQ+zUdKO3GDFqAk3f+I7Ql8RkBxwcyaC03Ec9vChXUA0qEuad+vKZMkBSFroiEtwCBsoo4ZitANsdfEOIgqcezXJiEI6w6cEelZ9IiAb7W5IXHh4kTMffAddVCmxpxHuyju1yWqko5LeKTRLI+UHMEc+d580/WywqrEDI/Na4QZyGDvHvo1V3fipxJxB4FBzPvoh2N/WQ9ctatQDlz/Cyj3mOmEhlcMdOo2AIL3aqyEGODw1erF4BRt/SdQPqpC7xaSWqLsoaw4VVKI+Pcr2pKONLQ5ytcFq2J7r/+nt3Dv9SrqcQ8/LfUoyjf1ljGsPNAcdhZAjyVl1YFQ1uzciepQvmKq4EiYNVd8SaeutpLIDzXfSj4PTTq1eSElvcjB234PRWQth9QETQylWey8luv12hiYlHfPl6jzxwfq6fOladnwESg4ZxDLslnYGT62RS3vR2MSUxhzYHbNHZqgGGjD6qZ0UU+2kR4/jWbtK8fimXsDLsfVEfqBNK1Ao9l3ghK+td0VQ8glY20xpw7Y2u31ZqeCbdk/LCSbeUyY0vIynuxnI5SOQ1uOspZfruLvgNz0oADdj9FuV9feGl11eqh4hSSzdyy1Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(5660300002)(6506007)(6512007)(9686003)(1076003)(186003)(26005)(33656002)(83380400001)(2906002)(44832011)(66556008)(86362001)(316002)(38350700002)(66476007)(38100700002)(6486002)(966005)(6916009)(508600001)(6666004)(4326008)(8676002)(8936002)(66946007)(33716001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3j6Uz2Dgu+aNRV8BsXO+WQlleQy056o9/fzaYN2xiom5geI9t7vN1y/Kw45?=
 =?us-ascii?Q?LTTDe+wgQOsIOdoLR5jRGv7bgJltEjVYmfT69ycR3X6UyO1podzrnqSJGyS/?=
 =?us-ascii?Q?0yZpqYH+9CYPfjYP7rFQ6B/hQ0O0kVBWsz2q3z73kmx6s1eFidYaeMY6+YBv?=
 =?us-ascii?Q?zCB0jLIiQE4dUop81NUVFzU2hkCTUARU9hggh9xx33Vh5kRwmofuEmleHDTy?=
 =?us-ascii?Q?yvs3I1X3EZbGWqRNybFqe/T2+xf541D9P/VmNpiXUp2ErY5QEb9wBH7YGcT6?=
 =?us-ascii?Q?i/GwWwi4tsgQQee+pNISa0RTnkSpqQNil5ititoSWTJ8U/uUk06jNrMUpisX?=
 =?us-ascii?Q?rR5VIcF1CFbBu95g6NfINYPDTcINQhZc7SlozG5X4v1EilXIZKc8bOB1raOQ?=
 =?us-ascii?Q?xwcRs+qEnq678ZKSKL0+PaXe+pids+14t+1SIewJveL3cGCe6a+EgLG7SvLi?=
 =?us-ascii?Q?94RhQFTTzPqPOwAFAPVaIMUAq4fGZDs+o4o0dvOT8Pkf9t5unjMDQ4pXimoa?=
 =?us-ascii?Q?QvMWKWXORIKyjp7lIujmBQ7MuZMZYPSMjd6asjKHTlLJ38tylzWbAIT0Ubpl?=
 =?us-ascii?Q?mViMiNkTJfbhbhYmjk4axCDgh/HYGPiF2kDRkyhF8VfFf7WEZkhwzZc5TN0s?=
 =?us-ascii?Q?YO+0DHtZUEDxm6/MZMlBRjnx022jz5ire/fQiU7nyDEUiTlWDGSXX6984zFW?=
 =?us-ascii?Q?75fAQ2U9fdT+vghUa2EW1wfRG1L/t2ctV1+RFm/Fetp5tWfsjUbIio8BQjbh?=
 =?us-ascii?Q?utr1QqrRA8jDkPD4dioCNRS4z1rhLmVLawSUHJJDPqXyrFk57qKQsmHCygx/?=
 =?us-ascii?Q?8NPNCrqMtLSutH08VMOBmjDA4Kue9XW0oTjCxvGMNNWAcm3v9gkAzGHivh4G?=
 =?us-ascii?Q?S/y/Um7phgnfhoPptfKmuRgJyKv+65p1IlU3EzW/uIMYEAzIpviitkJS9Jr+?=
 =?us-ascii?Q?sAX/b1Q2ZMBt2CyyFpiuAD+NAMrIRO2N2zzoHW4lRMBftHgvm2cZfkbTNofD?=
 =?us-ascii?Q?6ZrgCAh50Voyy4XB2AgVmpP3Rlrs373a+P1BoAghbb9wxk6LbJvBiYehv7xw?=
 =?us-ascii?Q?QQLSdOyYPNFaN9bxr6EdX32XE7f25Vor9ajk+RKe2ZF7FFww2FO2vBLPg93H?=
 =?us-ascii?Q?T6oqdDLAh8FWb4e0bpmcU4jKY9BGOZ0cyQMP+50CRqeFQk0Brz8wuoYup1W6?=
 =?us-ascii?Q?49nqUjWyuKqRopvotyJ3DWTdeswrP04gGSea++GTc6J6Mh5sXQw2J10IJjqB?=
 =?us-ascii?Q?kodbfrEoE8ngOz4mxnD9j/Fn3qjdighBa2JiHTZW21+miJ1hlHziBOUJ6V8e?=
 =?us-ascii?Q?77cpL2CEkZaikN2jH2D0e+Wo74X/P9EhCK5SkTrC6stWxxmL+reCc1NgLn70?=
 =?us-ascii?Q?dZerXXxWIK+9ENbMGof3vGgEeaVWHFobX3f70I2VGTybMNMuTOvX3mGx4ktR?=
 =?us-ascii?Q?79wnCynmExAeLrkuIlNqEDtQrj7Wm1tTcdHHA4+aXzYEqsTFSZxeSifqhHnO?=
 =?us-ascii?Q?R6rafVxM3Lpo+5t/EVCdkzT7dKOU9NSbGlKXPx/pQ36IeMMizafZ+ySpdQPF?=
 =?us-ascii?Q?ellcn2QkRlejtqHrdd7KbGv6qLG4gmS9oX/VN7Qymf9CbrVrEkw8z2bPq1IS?=
 =?us-ascii?Q?1k40Zbb41Io1t9Ski0KAmS+5w4CHpyNiMyaA3MyncEDW4ZN87usnZv7K/FKk?=
 =?us-ascii?Q?SnlCsg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38406b73-806c-4a94-8a8a-08d9e4a61ff9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 10:40:40.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8JihbssCcQmTQhP2ClCYttWdzihMjJzvvWj0MxlkzKM9zezok4jJNXRV/iR9vrQHAKvr4lW9mMQh7Td9GnWJnabtacSxs88753DFJwG1E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1586
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310071
X-Proofpoint-ORIG-GUID: IvxG8Cs_ixi_zDW5VBouSQYIMaTTyYSk
X-Proofpoint-GUID: IvxG8Cs_ixi_zDW5VBouSQYIMaTTyYSk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 07:18:26PM +1300, Paulo Miguel Almeida wrote:
> In this driver there were occurences of '\n'-ended strings when using
> dev_dbg function which isn't required which most likely were leftovers
> from a previous printk/pr_<level> implementation.
> 
> This patch removes the extraneous '\n' characters to make it consistent
> with the other dev_dbg instances.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Patch dependencies:
> 
> The following patches must be applied first given that changes are made
> to the same set of files:
> 
> - https://lore.kernel.org/lkml/YfYdVokxsQ+Adl+T@mail.google.com/
> - https://lore.kernel.org/lkml/YfX+llwDWZZMz+NY@mail.google.com/
> ---
>  drivers/staging/pi433/pi433_if.c | 14 +++++++-------
>  drivers/staging/pi433/rf69.c     | 16 ++++++++--------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 02d4ccebf..db1b092e8 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -124,13 +124,13 @@ static irqreturn_t DIO0_irq_handler(int irq, void *dev_id)
>  
>  	if (device->irq_state[DIO0] == DIO_PACKET_SENT) {
>  		device->free_in_fifo = FIFO_SIZE;
> -		dev_dbg(device->dev, "DIO0 irq: Packet sent\n");
> +		dev_dbg(device->dev, "DIO0 irq: Packet sent");

Both the old and new code will do the same thing.  You are correct.
However in terms of style, I believe the preference is to add a newline.

I don't remember the reasoning behind this.  But a lot of these style
rules are just decided by consensus.  If you do a
`git grep -w dev_dbg | grep \;$` then it is 12391 places that add a
new line and 622 which don't.  Adding a newline is the clear winner.

regards,
dan carpenter

