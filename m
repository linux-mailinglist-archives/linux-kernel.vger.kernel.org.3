Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5C4DA14D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiCORci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbiCORcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:32:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99D58E47
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:31:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFQhmG021546;
        Tue, 15 Mar 2022 17:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9kgqkY39qORWndbkP1yPDeQw58fxWzGkhq7n6MZkVkA=;
 b=Cvw2osWTyxykaPR/bIM2yT7/Dj8j9Hsyga+XmkEjug1capefzRdNmDkJmqiY9qUFKlgt
 VrZuZWZxkf6Bk5lN+Lp+utzqmkTiwx9JKHml3eLUCUk+2/VkWmTOWH1a34CKJUJhM0yZ
 ogIaVBWavpoovvTMcGZFMwEGtB2CowN8znAk541WeBgAH9jjAVMR3zRQXuJwK3lgIYXG
 1L9c5VOOiKMvzS/97oKuB0fAYLgV10j+6HKoYM8WdCIzMyOSfM5aG2aiFZg0ZXIw4CyQ
 ov2afVJELJ90EVKoUsd81D73I9CMtGQkTXWy1Ze/wmy+hnOzeXV3qw8NCyCWwP0VKv3O zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6kx7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:31:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FHA1ca142023;
        Tue, 15 Mar 2022 17:31:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3et64k4vf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbYPqEsibB1F8u47eXBS4ye2koJL0KiVhyucWkwMqTL5TjLvHOw2JFIonGyJfUbGHoinwk9QpWblwMR1dhccUSLGLiNGaUnRW6DbZQn9T7GhYvsCX+YVkxICzYby4fytdzsuwxBvg9A6tsIH5dNV2aGwbmpjdxXBAGb4dijTZorR/qvVwLW35EVmlqEUBuXq5TtCbUgZQJGKPonizE73iZ16TWL9tx+GrfkAfboYLzwkAGmtz/Z2leAL+AK464OKEsprLaI/KIOecSgU1ZrKJiYLIn1ZkiP94KLcjToc0eHMk1dJF1RWnQrLc7S/Pe3qJnuIxNDmdahUyzoyQFAUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kgqkY39qORWndbkP1yPDeQw58fxWzGkhq7n6MZkVkA=;
 b=gptcEM3nbsz4yhaLQbgfyvExLy6eBHWGp8r/czK/Pm+J2iLfNS1vwuEgrMP/yKqGq07FF8ApO9PP2MNfItWWV5pIfOG9tS2nYjZLafKqJsCdZaDwq6oxgLsuikTBSre+t9wDNbd9Ds5NEGRscrY6OaRxtJXjIe/jr9FQRjm6YpFMSh0xp3gWKCKHabeQocmE3Z09l1keVE8GCM8lN7iVy+brY5QybE4mgDuX+o1fcHc+lg6hBg0pThx35I7vD4gOP6RTYHxorzRE7XwL+h4NOkN38xmLc/vZNGPvReI5auj2GmJNQ426a1oJ0n8Vjy64Wg9D3x4f9ou70ajNUeZYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kgqkY39qORWndbkP1yPDeQw58fxWzGkhq7n6MZkVkA=;
 b=fnmkA0hBuFbSp42rXw8K1AK/kpV7UyeRlBwYUeFu3gJMZq9lq4rrabq32YNrVMP+7FIuY7jfMKqAYJW2kRaM9Za+FAOcrpn6CHH/Y/FZQiQ+ZqvG6wjqQ6QxDH5l7nulz+qlRBOW4O6Rk0ECxwvSKNx+DmNVsDbcp4pP25q5HG0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3384.namprd10.prod.outlook.com
 (2603:10b6:a03:14e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 17:30:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 17:30:59 +0000
Date:   Tue, 15 Mar 2022 20:30:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mmal-vchiq: clear redundant item named
 bulk_scratch
Message-ID: <20220315173037.GC1841@kadam>
References: <tencent_F721901366AB5C720E008AF7F02DA5D3FF07@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F721901366AB5C720E008AF7F02DA5D3FF07@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed798b5-c25c-4a7b-fc69-08da06a9920a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3384:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3384B37F32DE14020BDCA8B98E109@BYAPR10MB3384.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +daG2pfT4HSr/ei55XuKTH4V303R6fpIYPRGtOikpOHLjkIvPQ2FioYGLSDfDwv0VQFCg+hiMNvc3D3BEYa4IGV42z0K+XhieoVp9Vyfs/V3k3eNDs2CaLlj2y0iMEc3NOAo6E38W8GqHOX9hZdr+YMra6cyJCbQZBTd3Q00LMpl/jA6eKDc2KPAa/T7eC5f3cefUREaDHwdldphJxmCmpIdVpygAWBJ9zjJChu11NSx13HM9OjulXcCH9UxhxDIB9ak9vYGGCFTj2BYpl+KupJT75ZruQBqOmNR5/g979OkHGuNpKdPn37JuGbJ/4o3hz2qhfyaUt8hQCd6fwkhoQ1U2pW7SMoajjn8/v+v/xw4TYA2QbMsHDKwbDOUTdQqTEtXSgcnQHJQ9WkowtFXjZl26agZEijRbAfA0rusPvjYjAp2pE8e4JPErjlLJfKwiIQd9ugHUr7XFR5+CuL9fGHMgSYNcdqXHXfj4IOj7WEbzM+kEShLgzlQFJqzJMmeZfOm0Dyml4ehFZ7H3J5apPKnMo2S6OKpgY3nm96FVMjb45Ht4YK4UyxeY+CapP1ATaMmHb/6ZkWi5UYS35xNjc7HOpDGy2LCMqLqdcoGtig/V1Yl0aAORnXQLwAUgydOq/RynpIDpzoppPe5v7zcsWDTcKp8nvlwRpKjYkGNYG0rV+uHqoJRG4SzkEqkoEj6rFGUNc683bh+Fype4Cn41FiRw+WxOwpU+AZu93KoBc1zD+vW3StZgvkjMQV3OvdP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(6666004)(66946007)(66476007)(66556008)(8936002)(4326008)(1076003)(316002)(33656002)(86362001)(8676002)(9686003)(38350700002)(6512007)(38100700002)(33716001)(6486002)(2906002)(6916009)(508600001)(52116002)(6506007)(186003)(26005)(4744005)(44832011)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HtiVPw6gW483rHEJidhFxoW8tQyTuO9k43XyfdcMXrHJ08/3NsyCdi4XbZeu?=
 =?us-ascii?Q?5q2efa64S2p/qk3OVZNS7WukslmLRF7piZ3n4BFlVRjBNA01rSJxze5m75/E?=
 =?us-ascii?Q?mUg8MFVSd47BbJTGJoiVkjRiFIE0TWgCBj9r4+9/NnqlOJvUUMUKL4M3QTPt?=
 =?us-ascii?Q?aIbY/7iLo7pjLxwDlIuw2R3iuBzH02B/eDX+HS1BQr16wMaOzrn0FiqhimLx?=
 =?us-ascii?Q?xxwmQPwCZCh0sUK0Qp+lJgV0cZZ5O5E7V7To1KzOR0lj4pm8V4RdXQHZkd0D?=
 =?us-ascii?Q?uZNZXvHcXAcUId4akNGdzoJJLIUeuBmy60l79H6Kh2X9x6yfy9MSsxKA1Oui?=
 =?us-ascii?Q?EpRTO3EuT6NGxfJozQHRn2rT2oRxzHwbkNGK49GdbfZHUbfUnjSCjWutwuHX?=
 =?us-ascii?Q?ZLZNRpehxzsCUrQCFw3vR5HhuNK6WU7Ve6H16oB1DSLwywZdGq+1WjIsysfd?=
 =?us-ascii?Q?TE0nGC1yTPUz87BrGQQL0MmHbb3dAg1vni8HKyMuGjIYWAvKPE+I7Lo4YnKH?=
 =?us-ascii?Q?R2P248PasPyqwhF7SjTEhqRxm1JJ5KE+aws7CqbBQyOyFYENQwFFi+j6Nud/?=
 =?us-ascii?Q?2c2AEi8/WlBCzOXevVe3OqNrOPLO1Xg+YaAfn+NNI6rOFkAyTB5os0lzNQUN?=
 =?us-ascii?Q?Id9XkAZl+p/rE/gU2v2fVycMMu/DgTIHyFEwwEKwsk9YgHtx8ed4xZNF45Ld?=
 =?us-ascii?Q?UhMek3/ytVuO4DhyIH7M3hWXWMo4zCWf6TNm3VNe5dZXygwRF5McDdrByvun?=
 =?us-ascii?Q?azr+jHeT/+jJvRtHjqb5PHTMn8TevP+IRGFp795sJjpv+G/0UAH2ctk7LVY7?=
 =?us-ascii?Q?TfXwa2XEiAGoM1fsxvJEk5lDZbA5On4HaVrHRVxitGHWvCq7s5AeP0vEomp1?=
 =?us-ascii?Q?K4+rUfUMRUMG8W1PFS/xm2LU0XKh4G2En9blz1LDJdLtAwpM1wUFG1fuAV/L?=
 =?us-ascii?Q?9ATvZH4bH7i2wuDLBsl38JSowMtexeaQ6/Bl/tgNbdITNvVCeEEFGkLqF1/g?=
 =?us-ascii?Q?vGCyhwMhOvtSTGrPnmaBuVet6t8CxNEzgu4GmxvlVmS454RGUY3lVfC2hoE2?=
 =?us-ascii?Q?ZvudjJx2Fjnq1DjBgkPaGLuvprDIvGzSAAr528PKd2KcL4hBDwmjsFqFl5Pn?=
 =?us-ascii?Q?l+8VrAEnHGJRR1WRHk+1Fz1C2NcgD4SlPXBNa3nEOzGpVGTKozj5rWEur789?=
 =?us-ascii?Q?rP5JaH+mAGEoRtDQcVDfNMXsLHeGGXXY8xZqa37ksZcnZgIdB85FjgH7218K?=
 =?us-ascii?Q?7+ZaAI/bTthncBEQZEpNfZLqxD6hLv18ch5WTq76oksz1fXE61u1aQWWoZ1Z?=
 =?us-ascii?Q?BWK1z1o/MDbQuSGwtPwZx9l3h5uBVC09zcHZaU2HKttH/4xUW2Osm5xFRQSR?=
 =?us-ascii?Q?tl1taQprmafZzFXeQ/ysxSEuOIzPT4T0sl1nFT97ZNkuzTv0pcfOWqhlL4xg?=
 =?us-ascii?Q?5XqzMtFgkeTny+gNmRsael5T6PLB9a12FMlcOChrcbdAQv8WUFPDGg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed798b5-c25c-4a7b-fc69-08da06a9920a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:30:59.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZXwsQ/431ZQmqymXYVxHMSLbZEjeI3qvVrDOSQBMEhcepW21EXD5LlLV5nioIKVxr7zCpXySIbKANrMDlJ11pMVIa1u4ioAQSNyUId77Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3384
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150105
X-Proofpoint-GUID: SlAMNMx7PXYi1MG9T2IkvSJG3nNRGP2N
X-Proofpoint-ORIG-GUID: SlAMNMx7PXYi1MG9T2IkvSJG3nNRGP2N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:24:12AM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> bulk_scratch is not used anywhere and the original allocation of it
> does not have proper check.
> Deleting it directly seems to be a good choice.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

