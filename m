Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD549F3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbiA1HEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:04:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38380 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbiA1HEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:04:20 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S1xgX8004436;
        Fri, 28 Jan 2022 07:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=N5JSYENfR0M4K9oCuclm1eOGkM7bKaBhT3OxwjV7P9Y=;
 b=XCx58kRWxUibH0/ohy0ep5UuGvZ9OEyqesRa2fb/0alcaQCy16UtColizlTPMi9NdliO
 Pbseyr3zpWzg5MCKnOFJj5q0RQD66+27Uxi+A4IZdyRLdZKn+2rkeW+pt6XHJ2pHXVjd
 wAE/OQnA8DFxORulO74hiKK7Fx5/o/KYCsHovnwGkXFmqxz8QKfxqOuAA8DOQvB/LP2g
 QuTtdDhLs5lKC/JMaJtqC03wFqET8qFvNyl8epDEXoWpmlFPfU2kOTUTXxFJilX0LrL7
 jgxGOwSY4gU0M3WKCWcfmutMBB4mnDA+aLePFwEevnijNhPdLbqnF/tNeSK681SY8lh9 vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp1xsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:03:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S71QtA109583;
        Fri, 28 Jan 2022 07:03:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dr7yn7xj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6To5X+tqExbFoMK9cJgwqNez/7G+Y5Hh3BKY9Lo/4vI6V/d92mPO8vhQ8BTTca5BM7WoW1eiXQ0Faj2I71d+6aCiJbNUucKODAbmKA1UheRvR9lXyDCoZ1iE6ddYR0gorh0TPuSCTdtL2dJ103fRSpxHcC9YpKmrb6tGUhVDx7I3EshESC7QPwGRmDYdtLZv+PTULHTkLmpOLIcjIZ/36+yoNXbH+UfeCmp6bDlFNCRl30baRqyJ3MvFKwAGds8HXKqf0U7dlSIRMkdUhaKxPwQFT1/ZfeniaRzy8Yarxx7GXsiXk8ekF5TWcVbrwOBbs7ZTfUngNKjUT7R8SlvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5JSYENfR0M4K9oCuclm1eOGkM7bKaBhT3OxwjV7P9Y=;
 b=GLXK/hUR3YB8si+qjiWpcuaFKJKKbOc0YYUnkauOjQSa6S/24YcMXZHmmfd59cNzJADJFbheEH5P9Sr0WGTUXbPiLYK7tckqltCxXilOG3IWtOMJ60HOzAlJv5ZOEr3dG8jF4fJJG3o+YmYlobxixOkXqT+r1L8Dw28cjHxN/SyUwYu/Oc8cSpHaooDTqvET/i0HFN/MGktSkzOqy7IcNbyjrKw9gWXL1kjWMk3HhXOr6vvi7AEhkjKNlEvD0KIPLV6y5YI23FJ4jEam/N3V7C+wbkCZ8YYIVLy/mTSX8bbRRsop7m90a4TaWY6drJaLi4+f93aTkE74SU/AZatcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5JSYENfR0M4K9oCuclm1eOGkM7bKaBhT3OxwjV7P9Y=;
 b=P8Vvrgw0RGzid00d9otR9KQz1xgVxDU1QFOc+NfocpnI1rOcpVYm8zusSWBqt02oEABBA6/ILXUAeia44xEmWOxccp4YrOQFAtKVVvCSFQ2Vpk3zR7fih/FUrW2NFpdpeuy75NYyjKid6IeiOvI7ZrsDnFl9PGTEXycWyISkU2k=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH0PR10MB4955.namprd10.prod.outlook.com
 (2603:10b6:610:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 07:03:56 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 07:03:56 +0000
Date:   Fri, 28 Jan 2022 10:03:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     cgel.zte@gmail.com, nsaenz@kernel.org, rdunlap@infradead.org,
        unixbhaskar@gmail.com, dave.stevenson@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] vchiq-mmal: Remove redundant 'flush_workqueue()' calls
Message-ID: <20220128070330.GD1951@kadam>
References: <20220127014432.1185206-1-chi.minghao@zte.com.cn>
 <fdbe3eaf-c737-0714-6b54-8a7cdbe38a0c@i2se.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdbe3eaf-c737-0714-6b54-8a7cdbe38a0c@i2se.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::32)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab24f7ce-1401-435a-0248-08d9e22c5973
X-MS-TrafficTypeDiagnostic: CH0PR10MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB49558E6A8E810740C4BBC98F8E229@CH0PR10MB4955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ktSE4OiAJ1qCQqGSIDTAS63YEHfGiatkA2/2D9FzLM2qpOs0V5rMw4FObWd9iKWUlkiB/xuh2giM4PlAeKpE2ObZyKtRP7YUrtB6GxUYNUiywlENvsCOaqNQt0l+9ei7oRa55R62vFatQ+GceKJ47DXKm/9F0VMVK2/ZdvUJL2a9z/nSMtJJUkm44oYHGbRneUkr/sE3a0bDJbUsrmyvqi70XN06tjG5VnhiTOtrbrqH1YmYe2NeknDrJLg2ol7EcBMq39hmaFq84PMWZ1AO2joK+cO75sr9seRqo80ux/M0uZcmTDdZDjUJz+y6iQofVxUze6GJ5gS0aXk6f34b+5GeR0CLjq1dqHRtZTNVKgJkXhBmGMATVmOPPXFO50wFJbN3xAONE0iLHMV+ikazRWu+QWju5H4TvFfQq5ryn7wPZDD3ztJZ/HIihln/CN811HAxu9eFKu/x5/gO075yUGPDS6k7VGchTDVJk0dao9pQmmPEEvEiPKr0kzCMZg1IHXZliLpfEqgbFFopDi64HX68qnfacqg8lEiv0fb9EyztsX+dGGMij7WrP8LBo+p9vorvX0CNEjsxJZfJPRt5jlftKc4hFG1N5WSETAGq7WnH5ZmfcT5GL96SDsSkRtdHRVzsbVNN6bbuW7JaR1HhjqXKhoafgLS9vN45Us3K/+4pKdg+v6OclFCOayd+lr+qYG6+Ez6+s41d8fL4XRWQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(38100700002)(6506007)(38350700002)(44832011)(5660300002)(52116002)(7416002)(4744005)(33716001)(26005)(508600001)(2906002)(6666004)(186003)(6486002)(33656002)(316002)(86362001)(8936002)(4326008)(8676002)(54906003)(6916009)(9686003)(6512007)(66556008)(66476007)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yEpe57fmyDg4+En46hbZG+nOkayH9hCvwS4vmMiw2yvKtNvap+3UKHBrT9Od?=
 =?us-ascii?Q?zEiF85SWdJ9D0pVr/AUvm35U7dHgT6PoibE2T3ABomaGybRE1JN1WLy3zF5s?=
 =?us-ascii?Q?ZsEFEOC9xJa1wfF4rbkuYyJenZiiW8TX+4TN9Al2/Ctwg3aANqKyGwQxJaEf?=
 =?us-ascii?Q?QWI8f0uR0mPN8ZDOpRGeeRQDoxSsGMWzlsSjI4i0evEo0graNOLVbC7xwPWE?=
 =?us-ascii?Q?3T6AF3BjV15lsJ40DGCVZGJdxPeKEN3jF0Qe+zbIOiB4dyGwq714pUPmwy7K?=
 =?us-ascii?Q?876M18v00QvawoIiOt8odPN837vW0V/cWYeJSUVDXNBtdU87zdXc0A7ApkGD?=
 =?us-ascii?Q?qsbCY11ThbfM7y1V/K2sRk41oVrZVUckV5OL22IE64pA1KEJFuhf9A4NfnbX?=
 =?us-ascii?Q?AgFO5dkFLDpJOfS5Ul0kpqL/gPzeMG2VO73pVfXo8gpY5VX10HJ/c7sgCYWB?=
 =?us-ascii?Q?4pU9IlFIYwtrRkI8z62FeZUKN96e04DxzS2bo30O7Imu/+XmqP+C9Tw71bml?=
 =?us-ascii?Q?4TTHaPumitmL2+OeyYe6XNZd+h9GLXf43qIZ1C4UBJmFGYUydTLDd7pSOhdt?=
 =?us-ascii?Q?koSYUZxGZh/Jezh0sZZgc+OLjnNcOqQTO0Ks1ELbEtwdTHGrSwi0LgsLzHuI?=
 =?us-ascii?Q?O0NvUnSqFgudXEwlCEY7hTzK9s6yDLVyisTGXo50tjwZbQGtT7X+nvP3QjnF?=
 =?us-ascii?Q?NfUaQh6FQ7KYl4FKc7JlTwFf44jpp3ePHjalQOe2yi7yULizgUOypIXUVcCp?=
 =?us-ascii?Q?Ne++TRfZklk30/Gd0wsLvjPRD/KhIk17QIidKxim7Pq49nHiV7UJcia1zNTQ?=
 =?us-ascii?Q?Y71i+XDdGLAVyf4Gl0RcEBGlwu2kC3s0sd0nKJ3JnMoAxBiuF04zILzuy6fi?=
 =?us-ascii?Q?5JWxLJ3Al3zq/t4Xp/vq+MwJkVgx4JkhmeKltCGyfDhtvJfp7VMAtzIq4zMK?=
 =?us-ascii?Q?r6YlYdToTPGo8gYi7/y8Fy2bA7oZ23GZR3PFTimuvdiltJWHxFfl/YJsVNiX?=
 =?us-ascii?Q?rCne6YCjzQeskmZHfe9R6A65kYLQw3+6BitXeOghdQfuwpjuNdvXYCXDxIdw?=
 =?us-ascii?Q?68BF8/e6+jgadzaRT+7Vk03/UHa0u7dbIkz4QTbRNTJeSgC+T2DEWHTb4PvM?=
 =?us-ascii?Q?9lpMYOYAqBYJ1Fp09k+6Fa5bClgZvw6OQPoByvHq6OrAd58yVEcs64lsb83k?=
 =?us-ascii?Q?tha9ojAmmcADiu9jceR3xV9kP9rqa/1hbXUy76g86JOAjmhrcoFTR26C/7a7?=
 =?us-ascii?Q?XzrWGpmTBjn9EH/ogIrtoLyuxgHOxlSaIhGNaCuYfrsA1mPZbwBAExFyFt5c?=
 =?us-ascii?Q?XDJtnl4tiyk78Zc6+QN1Sb86VrCZCrre66rf2WuFWVPLvnH1Y3pT9aYj563h?=
 =?us-ascii?Q?cDx7cex2BD1RdnF8n2irLuZor5XqnMi3eJAVPwbRc4BEPnHZzOZw5OId+4uE?=
 =?us-ascii?Q?go/U0qbF3YkKO9Re1qtdrKAy79MSrdBumAl8YZmISlzhoVTvZ24zQKB3+5lL?=
 =?us-ascii?Q?V/1xSGu7ea3Bmn72/KF/zd1eXseFGk3cmkKb18D+Qul+vIn5+HQEAXBx5TtJ?=
 =?us-ascii?Q?dFbb6QkX0h9eeFA7RmhWOzc73cIx6xG5qLmSpErNXy2XaLL/Ncsf4jaQkVwq?=
 =?us-ascii?Q?L4N/knfwJXj++jLNs7UBh1LovG+r8U3RTISavifkPfIaVSTgHv+GzjmGldvs?=
 =?us-ascii?Q?nXGTtKB2ld3bMZOAijzDunGgaJE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab24f7ce-1401-435a-0248-08d9e22c5973
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:03:56.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kV2vVET+PsEayTEMF0pjwXg9q9N7rWkxeSS1h5hbW4uF3y2mHmvdyfkZmbj/utn4bH1OShD5GzHRP5/5JX7UgTu3z1P9NNYCfCCOvBSTGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280043
X-Proofpoint-GUID: UCkeruIaNKza7dF7FcBuaz67qsf6jsTq
X-Proofpoint-ORIG-GUID: UCkeruIaNKza7dF7FcBuaz67qsf6jsTq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:35:09PM +0100, Stefan Wahren wrote:
> Hi,
> 
> Am 27.01.22 um 02:44 schrieb cgel.zte@gmail.com:
> > From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> >
> > 'destroy_workqueue()' already drains the queue before destroying it,
> > so there is no need to flush it explicitly.
> >
> > Remove the redundant 'flush_workqueue()' calls.
> are you sure that drain_workqueue() is the same as flush_workqueue()?

drain_workqueue() calls flush_workqueue() repeatedly.

regards,
dan carpenter

