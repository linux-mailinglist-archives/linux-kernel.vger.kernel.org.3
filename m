Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054704C86D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiCAIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCAIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:46:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478DD7D02B;
        Tue,  1 Mar 2022 00:45:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22186SaR010133;
        Tue, 1 Mar 2022 08:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=qZ5WHjBeMkkcCsW7jGv3d1BtxOVWbxTzumx6tbGPb34=;
 b=Q9Fw/hMpA5eYskyv8ZOgTZuxpSia229Rvh+LaCgnmlnYFloZUgTWDLD5hZQOE9qQwH9X
 lcEjPxNxiD35BtkQ6zY5q6Kbpc+KSnDvSV5WLOWpD5/7f8zpMze2K+rQq2fMPdw2wQ7+
 cl3np+oZRu4HyZrL6KQ7xPmI4rbwsJR+zQJrEs8clQ+pVTqxx6bGgSrTsOm7no8pR/LB
 25ca6AG7Z09wWCy/d1N5N3Xs+Uqnd3bo+5PQ86X1gIuItAn+gYhxAiZAuSWx/AX//r4w
 El+jOHyJ9arMH8a4SUSNCEpk7+cArVovSN1pAEj0ne9YrK4KPgGyxiQemK7kSupBWDW+ NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k420gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:45:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2218anDr158365;
        Tue, 1 Mar 2022 08:45:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3efc13xasx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzqO19Q6hNfjXLRXKW+pKRAEPSemitMKmQw7YaZywahBduRS9wPnLjPDHtZYDtBIiDOCb/9QPSGqZUXBfuOeAtj4jMc1FASp2TM9+JZ6vGc6ro++MbDNCn/o0HzS6bdIZ6zqVdyWAe1D23w0IH77XEdNzh4t9thlEwxUyOYuHbrmiXN7IrUPb6Ql5HlHaY94wIC3Ydf9SlyI/lzHlq374sG6zijyx0kbEKIXfgdzfXpHqbAhoRUtoFqr+Y/7VnYdcG4Ty0v2ItOXBjHexED2oa12QS26vb5ZZpMzBSbQdP4INHcWUA60W0tT6IukwbLEHQvEEgj3MD6JUSmfckeVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ5WHjBeMkkcCsW7jGv3d1BtxOVWbxTzumx6tbGPb34=;
 b=mysevGEAIKOnaTt+jy3z24Fh/l1y9Uuo/nCrigijKkpetvFMpdTat41OolMIfQpgD7MZ0HwvoTZMl4wFyxDK0KlieROXBSvc95+wp0ngoofMNnFQtXbyelAHo1KRg+Acu/sEhVMlk9Y2Hi703vyfm4zxUIcMVVBqpGo0jXGTo6+4lm1hqAJ6/OyhM5idTYA5A+nM32R/tDKWswR10SjE/xdvMQ340GOS36NjrSw2WBOElKQCBxPwNjU9S4sOzho3G9RwzTkM1Ck2v765bz57eVzpJftxiU7B/DFyn1JoCN9sWkPxXi95RVdq8WGP0HBxP8Prl/4wCXYxeRuhwk7wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ5WHjBeMkkcCsW7jGv3d1BtxOVWbxTzumx6tbGPb34=;
 b=L1D9zcLkKTOqpAYK0h0WyljNPrHWStoUHQxTABL5iVzvHeckH6ix50XfUyOGQMat8zUBO8r/5ZLziMue27nkEW3EcKzuwjMJUwY+e/Owf/RLNd8FQ8Dw7cx3JA0pFVNmjD6cNtUgC1q/C+Nq1NVXbWi11/Yy4slGBCD/fGHkTJM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4184.namprd10.prod.outlook.com
 (2603:10b6:610:7f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 08:45:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:45:20 +0000
Date:   Tue, 1 Mar 2022 11:45:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: remove unnecessary check in alloc_thread_stack_node()
Message-ID: <20220301084505.GJ2812@kadam>
References: <20220301080706.GB17208@kili>
 <Yh3YskVDQ3FL430i@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh3YskVDQ3FL430i@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0093.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba49315-dede-41d5-52ca-08d9fb5fd17b
X-MS-TrafficTypeDiagnostic: CH2PR10MB4184:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4184152441E414514CA06A578E029@CH2PR10MB4184.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PteIwVWSRb6x93DF/PSHCtvLXbOjdfjTc/ScjCvPHmCohgrxhAE8Vmfb8fLL7B+dCP54UjyEasFqB7N6t2Oc9Vp8ThKqNM1mPyakYt7ymFWzAwnm0SDk3u1h1m7RaM3nIzTKorFhaV0/iOXMPP2ZhvynhUbr9gQYRBILw7T5fQKc5Skr/5BaPutf7z6rh8LnTgI+VhHmy6MVS04up+NCKNkm4PHLE1YKfTsiqAIKvv+K2l6AEeC0uiPrsgEj+OOPfiScX6KcEY7vlZkVdOhcFIZbbCpKsVhMv+/QtKyn8EtQpxXSvJ55wQ8j3Xps4/7dNIiiycJJsvzIo8Zw1ewLNoBPIeubnqZCATY5iOmeGphh4BMI8pMa2qQgGw+0oI/obCL+TomnlMA2aBx+SlnQxAguJKmBNkPfmIGWBInQzAKXtfbSpeSSmArkX7qeoAiuxGiJNvYamvGz5/PAAY/dqVGz6FHPUDlTpwdshHrkTBWNy9UqDJ+HMnAk+SEHTCxPUF1VSdkrkSQD8ycp6l4nidAB0lA1UbZqk+mS7C7l8k31qPkU06rdN3OcAFkNOmtHS7NqSkrrAH8cicw8ks5yLd6hX4b3PbJreH75ntTOVibd/bvcxUaXCYUBJxEb2WCnlejHDtTK8jIFAr3xr8VKC3zt6rJXDLEc9r4uxaIU8DXyE15G7T4aSAuPCDGWYdHZInqa9/OqC0IrD6UsmcNZ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(6486002)(8936002)(53546011)(33656002)(33716001)(508600001)(110136005)(54906003)(6512007)(52116002)(38100700002)(44832011)(1076003)(9686003)(86362001)(7416002)(5660300002)(316002)(4744005)(38350700002)(26005)(186003)(66476007)(8676002)(66556008)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVMgMqzUY3sikrFm1pAvP5KgvAEt8VfeQ0R4W04IgnJB7q2XodJS8Qlvi2cv?=
 =?us-ascii?Q?kiE7ysazJGU6cWi8FCXh41P7YnjEqZNrTIFViFf9LvN1zwxySY8Itn0MMn86?=
 =?us-ascii?Q?93ZeXj9uU+DrHl3yP+kEudTvF/zlzxGgZ+C9Twap5P2DDU/bAYfmGRA1Lq2w?=
 =?us-ascii?Q?ArWIqYLfnkQVF+dGZQUa+RcSAbf4k2RCvd+ikMJwfIA+0qGhX3zgoci7JRcz?=
 =?us-ascii?Q?aa3OIpOb8WRoKVGncih//8PY6wD++S0SCLoOAGxHu1+PqkTWpaO0CVlbusRo?=
 =?us-ascii?Q?sxxJ1zJUUYJkMUjppRf1p1Vuq6wlYzhHgZSgGoPF8BwLIjsW7B/XuuJ07dwE?=
 =?us-ascii?Q?TOtBdYFFXgvt5xXnrm7li2CTSGw+vQcNCEuX2KCf+RIaNmaq6jrytBCeWVaK?=
 =?us-ascii?Q?z85xG+LVw+VdRSLiS0wBUnCDht7Co0U/3ZfTo2yhHJPliWty23oincQVASou?=
 =?us-ascii?Q?15wxeJoKPpQLXqIpsLGHMPr+5P+lMUWOGHXXBMqlPMU9xEa8q4SjgHp76xdX?=
 =?us-ascii?Q?EGIK24zMhYmCJniJwdQwHpQWGM4GD61+c7zcRt3e6z5mGkZIXST3RdTx1dGk?=
 =?us-ascii?Q?KMQyzykPf3IsXqT2mIG8SVIX7KzvqBZlYUnQL/zKzszvh5JJX/zI8IW51FDm?=
 =?us-ascii?Q?YN2mplqz9YRaiDQ2HPKtnFAs0lnZ42fXQKqzvu4G09sPaqrM4mhg1nk1Viqs?=
 =?us-ascii?Q?gDHdF9WFKcdYuQCBNAI+8ZhdBEM0+RbShSG3yZUtPznogV2K8rFxnFDjLyCc?=
 =?us-ascii?Q?0WQQ0Rz+tj4so4bI/76QC++U2zLBhYjEL+B2NSmXpnrMeUqameqtOU2er73w?=
 =?us-ascii?Q?MnC+bSShiU2HCYZbcuTXiCH4b3IlSip5Ge26BPp34WcIrvcqDMGsn3k8DAkv?=
 =?us-ascii?Q?16xgps1i4vizoFmmjcaSmJdQ36qJfpd3/1OJnghVlspn6xbVwpNKrSJXwEt1?=
 =?us-ascii?Q?QJezstDN37um0sHA73EvSkxRjh0hUTzB+KF6LUfrKtjcYLhWbo+kCE9wbpth?=
 =?us-ascii?Q?S7VEdnOxcvfdWStzcwy2Tuq7wAEV8Lct3GMz+ivenMqRdZKBsb+oH5M0RdC2?=
 =?us-ascii?Q?HQ3hof9ABsMPY+t0gfGiXH6Ep7RdsrHMLQ9/4Vez0YiJhLo5+2Fak8tIzOfp?=
 =?us-ascii?Q?LBpuQPpKrn7a7KeJI0XmZYqdnLOYAHSbksumyos7chcAzB3/PNqH4aBADRDa?=
 =?us-ascii?Q?8KG8EyO0vL9abJf5D5NRyUh3BdMSQQq+XLfzdDrTQXbQno1/VOnC0yC0DfhR?=
 =?us-ascii?Q?/j3S7a5Rhce+RHVSHvHJcdS8DYDpAqQrQJJuI1pLD+8urlSvBXVRiLQOpa6n?=
 =?us-ascii?Q?mb1kz4O8elVMaHhMUVKpcQQJ47X71UPfPwRt2IQNNGj5bmVxh0YaGVLjunDP?=
 =?us-ascii?Q?dv5tVmKC0Ndf4b8AlzgM1VhsGqGsITbhMaTwn98o9uAQrXSbGTvjI0PbHMkl?=
 =?us-ascii?Q?twH/Ed5ynEdBHVIQM+bHqLwOFYk3ZlZ8gZWtE05WyT13uJyYj6P0t9lyJeR8?=
 =?us-ascii?Q?rEAS5YXSEYJaOjcaFxaXfLQnHG8fz40yVetgVsiIoyE0KPqvOZQ58ugUr+aq?=
 =?us-ascii?Q?I8BLWDzlcwFlkK6/5jB6CBObh13pQ2FPNCkilfVcEhmY0C3lVVUMtAt4Pphj?=
 =?us-ascii?Q?cDr0FKY+endKldHoKowwAmTlmWIqH0T8b5/Rgc21IuF0xrVHWLoweZ/nsmT8?=
 =?us-ascii?Q?NyJQpg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba49315-dede-41d5-52ca-08d9fb5fd17b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:45:20.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEn+41oLocfKsxvwADieiQBJv6bSsf7vD1lf1DhaFSOs+l79pubNbDhFZ7WBJqSxpu5IfDOFZoLebKNa5NnRfCg1i2cuysPCDXQZZgY6jNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4184
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010041
X-Proofpoint-ORIG-GUID: _u9RstBdiTjcHniIARFfqDe1y-jzJI74
X-Proofpoint-GUID: _u9RstBdiTjcHniIARFfqDe1y-jzJI74
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:26:26AM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-01 11:07:06 [+0300], Dan Carpenter wrote:
> > The "stack" pointer cannot be NULL at this point so there is no
> > need to check.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Which tree is this against? Could you try against -tip, please?

This was against linux-next.  The patch needs to go through Andrew's
tree, not through -tip.

I should have included a fixes tag so Andrew will know which patch to
fold with.

Fixes: dbcd55bd6681 ("kasan, fork: reset pointer tags of vmapped stacks")

regards,
dan carpenter
