Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808024DA220
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiCOSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiCOSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:16:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5BE10FCB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:15:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FIEqRN016352;
        Tue, 15 Mar 2022 18:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MKFtujSjHcOX853emxGcQdGSK/MN3zzTgz+vEZ4iNV8=;
 b=yBPCf3gGp4RVMM5pctsMYt5k8cdhIwpa5+Zb+rQZWvmOtcsRrGXQpaxBM2VaDjO6/juA
 aJZWAz3eiG0Avy8AoHmNmMmUizesiPlHp0j6sCRgjaQQAmEQW+W2yojgajzZlxQ81ScZ
 izlYOPu3ihodgsaMiNM+9HASBCLMJ7cLQDvZ8FRjWqiNdmG04rfsmQRR+TaczBQZ6MNU
 JtZHjqSnfCSbXJqcODMQt/SpNP6Ar8jDEZ9SXa6VP9kBwwnr5XnDKxwe2rZGu5+R5dI8
 wPICYIeo3ijDpXQwJGTUHDyLDJU2jG2cB1gsKFqavwmJ2hWCUScp+lAbwSziZ277Y9+W hw== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwkuup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:14:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FICQHW084199;
        Tue, 15 Mar 2022 18:14:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3030.oracle.com with ESMTP id 3et64tqfqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8EAjy5v7qFln8x4ZlMFhm2IpkUU3wOca3nzy6uNK582cjxSydB9WL8VXkBiiRVaWS3E0yI0+6yX2096FOofrA7UQpzRFEMAeATh7iBDbOyGGPHwX+lY4gR6fSENhDmNSR5eTbtXaXACE0OLBhYnDXWna2tYoRb2NaVM32jMHZU18oGucjNbO4BRj1hZtyNSPMN8C/+L612PJgKCSK9ogVHGtxtqTVcsqGnfUA0Nqf8WlZnF8wANWgCA2eSt994Dw/VNXSrMiXQ7sPglKMumW9aH8dGS/bj2Zoyqmf/oJa5Z6DBX7OumHqdWgG7iMkeOtGLjVZkveFjk4tF5Oa5DRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKFtujSjHcOX853emxGcQdGSK/MN3zzTgz+vEZ4iNV8=;
 b=SjZjfD9rg2OX3txK8uor5OvkW5b/yVn6W5C76wHw+6yxv/50W9TLFugYzzGfX+kS/HK2GnQfv1Ss55BeoQ2sMNArP4SRB+wjLI8m6L0mRVvFM50zg0Zk+yLcj2YpAlHlHqfRdiMmB6viGgbwwYGeVUhLtmpFryFmceF3pbrDqPanbVmchakdPtpSIJxsgEoGUg0l1nPCCwetZnwm/OszTq/5tOlRlt8zWvYsQd9Um3EPy62T6LyYP9Y8PPyzvjEfnekwYkJ7DlPsZdMS7WoftxPFdKOPSN6SsSBP4XLlfESNXpwTi9/YhGMzHe6V8fTlQgwK0Tz8BxAUhduqY8Uk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKFtujSjHcOX853emxGcQdGSK/MN3zzTgz+vEZ4iNV8=;
 b=jpuFV004U1sr0dX4t1y6blvW/A+43LMlx3HJvlGoLstQPS8PACQIGRuEvMzwYqwrjl7PZ+WiSIaq3dloTLk07cXlymEgFhHg/R60Ab1vtDJP56WNsZuHlq9H8dWpwlcK+Xa7nAWevAGmUHVjmkxOBjTS2q1stHsCaTPvBwc05Nk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4277.namprd10.prod.outlook.com
 (2603:10b6:610:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Tue, 15 Mar
 2022 18:14:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 18:14:48 +0000
Date:   Tue, 15 Mar 2022 21:14:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <cvn249@gmail.com>
Cc:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        realwakka@gmail.com
Subject: Re: [PATCH] staging: pi433: allow max bit rate of 300kps
Message-ID: <20220315181427.GS3293@kadam>
References: <20220315180820.7393-1-cvn249@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315180820.7393-1-cvn249@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4270ff-d246-4ad3-2b97-08da06afb081
X-MS-TrafficTypeDiagnostic: CH2PR10MB4277:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB42778A45E0B31AF73CF705C38E109@CH2PR10MB4277.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBGqSQny8ArDO3OcwzuYS9BNtG8S3FTwUoXbQtAY1TkYUGuEhY3NFdGu7Kj8GVk9qs6/unkMxMFZ48bh2ZX2qXITRff6z+gibbnZqLQ1BvfpWwSIz5Z+dcYgMh23tSjZdo4/uRj0byMujq/oNpISZsKRSp3Sl4PVZN3ARWXx6n2jNTMf2+3ZN5KFU2plQmMenMSw60uNAFPneyVd4QaBV+AcyROmrjBNOvxCtBe0d5JNI5Vzd0IcYY/kV9sXbacLM5FLX0aOzoj3sS5nB2Qap9++HM0Ya6IVSsupUCxOND7Y1Mu9YGm8q9pOvawfSKcEVPBSqGBH3d3P2JDsBfm9FGiBtmsJvFuAexjX9q3YESWqPfcuINuzVVpDc35aeqzuZRGl11kjh8EsrIC0OQnW1le9Zu6TAxityvWGPqnRXWSBXEKfCksDQmRtV5x7DUWjgVxgS6ejneBYtV/I99sJKpisnohLdNxyVLXW6bu7lkZXjhKDVXndVMEC82DaZJOUX7V4xCYZErhBpW6hBAJBFgwdTfiFYjlWEPAWBhl99kF5JwleIMP7N6XGqxIIjWgWP6YWYz7igbsq4VikcB6dplniG3opo4Tlyjl7I8FQe0tM99hHBetK+FEmjzadyz8ZlFgQgdGfnQErcI2i3axGzSrhxkEwYkzb7bnSsSAdjDFuPkHQxtDVU1PBtPUeAh7yxlQMofyDhiWTPoX+fmSp+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(6916009)(8936002)(6486002)(86362001)(33716001)(33656002)(6512007)(6506007)(6666004)(9686003)(5660300002)(26005)(186003)(1076003)(2906002)(508600001)(52116002)(66556008)(4326008)(66476007)(8676002)(44832011)(66946007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3x9LH4V8qR0y4Fq1ChNLzKVfJUN+ggxcHayNGb5Px1AFirIWQ+0daeIXVzyX?=
 =?us-ascii?Q?o/zNgCFHboDtnwd7rmYx+LJz21E+Bdz9L0PhYK4NZgCoX9vwXb2VXQXJ3Trf?=
 =?us-ascii?Q?HGDMb02nlfWo7RUcG07Uqseh27ZSfHrC855emdF13MmuYRIKd8p8ov3KfXDK?=
 =?us-ascii?Q?QlGDBZ+BXSltaUaJVsQzFz8AYYCy5aiNSgvXoadxtg8iAfEbvbmGenMchLal?=
 =?us-ascii?Q?GIe5Wf8gzBfE9ADta3hIOx8lLsUuYD9N5l4vnDjW6ck/vQ7gzsS6fGFpmfha?=
 =?us-ascii?Q?XGGpZxtgy7KkNbNT9/NEO7rwl53of2roU8QnFjm5UeFIH9CaG6jgha30q9RK?=
 =?us-ascii?Q?eOOob/WK6B0q75vyKH2VxZ9l7uR8UkTAGxCocKIdval1JwMLThXLmo1wfWfq?=
 =?us-ascii?Q?Wcc0ahfgLvp10fjrc46V1mfcalwP7lZiErwDcA+B7X+6pr9wO29FO8guapyZ?=
 =?us-ascii?Q?ARltTwEhlFnTaa9aAyWbwLY6yjV7R0/EgD48zHXnQDyACJohZqG0PZBH06ka?=
 =?us-ascii?Q?qKAhgysogm5Ahuj9jLe1x5W//01pOMibsVh+dpJTUP0Ren4TIg2sloeT50ub?=
 =?us-ascii?Q?AKjN1t6lc3kZYKg2f/FortssZxfIEgvFmIXo/nkHDwHa/lJV8cxoQ1Gc3Sjf?=
 =?us-ascii?Q?Xz02hoX0SxoewYRuGGNPEAbeNk9VKAnj0EZl+ob1f4r4A7/Ur9UZbfQ8W7EX?=
 =?us-ascii?Q?b+YgxpW85wwjl9SG0bTQ49hbxtSbGuc4kzxwM1Q8Xilobc+AeLWmbTVc1k6G?=
 =?us-ascii?Q?ylLC5om1taTsswgYnii7X+KCyM8IDMWK7HLrIWPud3GdUFKKk5/JxFPZVCbl?=
 =?us-ascii?Q?oBJCDzGz520xLEKDvrCHymnI+UGa7UQ77fDDTqhTMGr9ERQQ2+lCtaqHtR6P?=
 =?us-ascii?Q?euNtd0y0bEtO4lZEvwNr/3Zl9uC/fL/vBSpKQSCHr/JGoscH7nm/VRZu9Uwi?=
 =?us-ascii?Q?IuJ+hMkfGdtE2KwA0+T0mcvioiEp31vcN7zSfqslSzEgZewj898Hpku+PTDf?=
 =?us-ascii?Q?5hmF5SxkysN5ljD7CdhR/SpBx+o9qlwwxfj0+ngJqOlNXa0CvOtexQlbLT7W?=
 =?us-ascii?Q?4x5H3nvqlths6bKIDxKkCiRZ2mxo3Uy4PNPlKrzrAaRMYF0F+wahtfeM0puh?=
 =?us-ascii?Q?QMMC3SsNFSXmNIM8hJuoflOMzMt0Ty3sxx5227cL2kPFim+ew3uw0+xpgWA3?=
 =?us-ascii?Q?Juu8vL+7CO2Azc62ywX37BxZHEX635BxKbnV9aLAfbGmxFv68QJfcoQFwLFY?=
 =?us-ascii?Q?q94K1w7LwY1TzladnSiPXpVx8BfCFPBYqoUOFzsmQU3TNSwDprDUN8D5i5r+?=
 =?us-ascii?Q?/UebMZm5/tR5hCmrFW+OMHpY0EvwSyJInoAWExW0avi1rCMjIfeQst0zv4uw?=
 =?us-ascii?Q?zmsywoEWBs3d50Wvc1jRBuqdqxhYh93mR7eu/JiKGgaOhJKFPE7OqO3UGHPQ?=
 =?us-ascii?Q?y74nyEWSp7buzr6pmnYf1J92TPiO9yexHwPELB7LQvYQkKLw/IXWxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4270ff-d246-4ad3-2b97-08da06afb081
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:14:48.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VMePr+1LoxwfvoI0PGjjG+LafNNv7nbqUhpHzvZ9y7n4jU0ZaJOZF+V85Md/KKTgONVFOC9P9edB4qzxgnx4G3zCED10gyo8xCzbSc7lW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150109
X-Proofpoint-GUID: Ups522w3HRmJLvxwfcnCL-T4Ufdy41UX
X-Proofpoint-ORIG-GUID: Ups522w3HRmJLvxwfcnCL-T4Ufdy41UX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:08:20PM +0100, Nam Cao wrote:
> diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
> index 5cf3fd99d521..8530bbe61d70 100644
> --- a/drivers/staging/pi433/TODO
> +++ b/drivers/staging/pi433/TODO
> @@ -1,5 +1,3 @@
>  * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
>    -> Replace this with another interface, hints are welcome!
>  * Some missing data (marked with ###) needs to be added in the documentation
> -* Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
> -    bit rates up to 300kbps per the spec.
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index 25ee0b77a32c..c958dcfa9f96 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -51,7 +51,7 @@ enum option_on_off {
>  #define PI433_TX_CFG_IOCTL_NR	0
>  struct pi433_tx_cfg {
>  	__u32			frequency;
> -	__u16			bit_rate;
> +	__u32			bit_rate;
>  	__u32			dev_frequency;
>  	enum modulation		modulation;
>  	enum mod_shaping	mod_shaping;
> @@ -99,7 +99,7 @@ struct pi433_tx_cfg {
>  #define PI433_RX_CFG_IOCTL_NR	1
>  struct pi433_rx_cfg {
>  	__u32			frequency;
> -	__u16			bit_rate;
> +	__u32			bit_rate;
>  	__u32			dev_frequency;
>  
>  	enum modulation		modulation;

You cannot change this because it is part of the UAPI.

Also this API is rubbish.  Instead you should create sysfs files to
set the bit_rate.

regards,
dan carpenter

