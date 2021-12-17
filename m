Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB574783D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhLQEAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:00:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13854 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhLQEAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:00:44 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2b1Kh013696;
        Fri, 17 Dec 2021 04:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lLMTOa6se0nh/zVBZw/VMQhBpdWiZipVfbCVnKc5UiU=;
 b=DOm2uJQsRMpkLqXZSDe4v0b83EfuT4id/jY9NduoXFVVXcd8rds6GBybzBIdRy12T96z
 Qwbe/SxPue6GHQySKDnVFHtMVvHSaulvCUGTTyiqiNUZo09Z58bid0L9jsdWtCux4Jka
 WEgevlQR8JeiBWkRFAeMDBXyGrjaISaQ3Mc/cOeDHH07VwaH+tzscmq/i1OPU75YKdHT
 0MSIJhECggxlh90NePWxuIxSxLjAwUuFU1q4UaOScCCBsYFr456lCsxsQq4wFfdlrUuk
 xXmMJOJTk2eruprM7o8Jnm9MO30tzZWQxx9vAz3EsU1qX0sdgs2HgEDdvdNj821LhTZ2 +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc4pfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:00:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH3xscH028645;
        Fri, 17 Dec 2021 04:00:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3cvneuxuu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 04:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OheWV3tcbyYEET+Bo61Rnkq8tElZOZyCmADRREMR3wxwEqGkhBvSRSmmqeOH1f/nCE9npoNw5gFWv9OkcsxYVscCa+HiYm8RCVbb01tAjCHkPlpTZfMf9PnxuLOBe28HAelH7JoQYAblMG0HsE5nRVsGylGdH+f3gKhuU+Yx+Q3N7XcIYGlIHOQJ/QOpxgmNWntEfuDq4wib9JzF9GA9QyUnr7zRZ0f4Mlz7/xiA3JqkC3Tl3+R9a4oMbXBk3YAx9DL8EwZBqAyH8ILTAMuNB9Ojow6LOkY84uMuDQh5OcJAVaY8wfx+VVtt0NF7uwPVSwC/T9Tv5GzdEjSh/WMUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLMTOa6se0nh/zVBZw/VMQhBpdWiZipVfbCVnKc5UiU=;
 b=bKmOr/9kXhvXgQKxak0mL0XnNa+Hd3sRMSMuuJtrgPrpXzU1wlz1MsI9p95oXZEaTgjyEj0uZT2HLhdF5O3WinbdTDMYr5ZygXkkNdnpYA+f9Mhu5Vc/a7nfRoi1a0zWhCYR4TeK/aMi2ZbVE5Mis9JGR4SBbrF3icF++3itHMhtEGqxQ96c3vJhFUh4h5XU3eNjPnAWDr58kwkqOhDbqPVeaLd+S4pBFk3vIlR+VJHAsaustDw++R9mfXZvnepyFnmg6nhE9zIdHSyBXUVufKmNOrfuRrY+DbfS8M15QlC4MCSvFWEvpSx5Geq92eUnlG+EBOQb62+t2BzLT/SyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLMTOa6se0nh/zVBZw/VMQhBpdWiZipVfbCVnKc5UiU=;
 b=crRd7V4bEshXEcW5QWx+OabEcC1xaYtYVvfWpBuwI+X8fdGNIT/xvdIoMc8KCgK/Etn+syvfhBfxQa33DDcmIVFILsscppEsrE6WjBotp+E6X6eTxUQHtF4WL8698qysVMwDexfuCA/NULb0ZZ06NwOiB0JXKG/0590M35znTOE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5450.namprd10.prod.outlook.com (2603:10b6:510:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 04:00:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f4fb:f2ea:bda5:441e%8]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 04:00:32 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 0/8] hisi_sas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r1abkhil.fsf@ca-mkp.ca.oracle.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 16 Dec 2021 23:00:29 -0500
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 15 Dec 2021 22:37:33 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:806:28::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17edff19-9d2c-4cb0-b9d9-08d9c111c572
X-MS-TrafficTypeDiagnostic: PH0PR10MB5450:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54504C85A3F5F27F2E9A0A9C8E789@PH0PR10MB5450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9kZSMsCf8N66aNAQhkhMlrLSLvrao1+GCA+NYjBUmLZfIOwcUpGSzX/f61Fn44qGivqMZo5AQm808BWInQZU9qrWJvk4UUAG0wDxCpPNkTVpqaHBSc4XO2N2OdJHquzWqb0/RlNjnCwlJmWG6mqVfqKr2f5wZ1FxK3BvSan9NUX4c2i4HBqkwa9IDYkzJFgg2CsRbIYAsrZxcxGvmcD0W7jKxIw+6xPW+zfXwbnIQyov8sgkkKDp8D1fbQWMrgm8xRIVQ6cs/531Vg+RozVv3a7kYk/px3PR6014n68braKdW9l6y5H9PVdghdeauLsXlt+2wBQ+6btfVELUr3C4Lnc19NJKXuGC5Uv1w+vqH2XahG4pIOdLlKa9JA170wtcuIVy/JbWapPgZyt6TUE7giKSukgl0KjGMdx0py2mHnDQmL0XcoTTF4CGK/BHcwMqTiBUuMx3PdffMqTgUeLyhRzBoHxDcVt68NA4Xs9BR7emJWwSU8d4W37KbuVLTUwbMkZXZj/0SX6sVq1FBVjLp/nTj7w5NkeT2cx0uk/G0rfiu5WdvSd5ZomIG+BSCJGOlF0a5soOMNx/pFwQHf9Fx16CQ2VoH4V92/u+EY6s1Rh+KT5vS8NPvAPI9DHpuGTj8UcMa4Oi66RANrP/7C//GF0ksRbT/91Pdzfcn7nku1e6V77zVjgIEqWa76YGSp+9NKuHh2HWTh5v+OfiRKbvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(36916002)(4326008)(83380400001)(38100700002)(54906003)(8676002)(316002)(26005)(8936002)(6666004)(6916009)(508600001)(4744005)(86362001)(186003)(5660300002)(66946007)(66476007)(66556008)(2906002)(52116002)(6512007)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EK0BHID2Lwi2cL8tfr2giZ+rgaXgatM9NlWKXbmSBpNHFOpcfe7tbG6CAbIQ?=
 =?us-ascii?Q?FvblUhoReFvk4BEzILevN8w4fB3WzN/gVSLqdUTVhQaiWvHFu80/m+Kcb0z3?=
 =?us-ascii?Q?G9UADE+D57vvnld0kBT/QF3RJQbfPkA3qK+gVa3yD2W50JnC8uIM1RjYrRxW?=
 =?us-ascii?Q?gwDycmEiLaojLUQ2A3YEkV6gO57yKvKfbqE4daUAs6iUmCzl5JpiN5vPG5q9?=
 =?us-ascii?Q?p45+r93ytON4GsUNVxCHqXjHOuKSmoaBeMzkDYcJVIW2IIG2pxiBgQ4iSWBq?=
 =?us-ascii?Q?G+x7XU9G9d++SHszTVQxJ+vkn6U6cl96u4p01eMi0MDKaLRQZQTUV2xttoC5?=
 =?us-ascii?Q?Cth0lJjuULBcbTutNGLZ7h6yIFl6wWhILzljb8l+nP376dWkjYfca2XZ0oIO?=
 =?us-ascii?Q?hC64KA8kekWIzqDFU+3UrgipkMfzD1mCKeggywRbj98k6lLGEf1Ezmz/GQk0?=
 =?us-ascii?Q?DJEwK9LVNE+lmCPW52QDmAxQ0LBZI4An2uUelGLwB+alzFVlQ77psWnA4KKR?=
 =?us-ascii?Q?SfKaVf1dfZBVS0G6Pp0V6UQwhRXV1YTJfE1NLUZu9HfgPXLo4wwp0PzBUmuw?=
 =?us-ascii?Q?a6ACaReV4WEShqNNerd75Iitqqv7rP69gREx8GWEOzJ8JdZRz38LY9GM0hs5?=
 =?us-ascii?Q?r31LWIH8fmvnvYbV3zRlLQpCmc5Yk2c4MNzI8kdZgdmccdK2Qn6qN1EkkaW4?=
 =?us-ascii?Q?56EtdRUCIS3WBXdBayv+TxMCfSbBnv3OlXTrJe8o6n4F4/qiV1vS8BzO8zVR?=
 =?us-ascii?Q?AYJnHaX229q/B5liAO5tiexyxpKQse1ekHsjrvps1SDk1Z+wC4sqW8U2yUf5?=
 =?us-ascii?Q?uEIunSHlgvJiGo2x3BRLMBR+k2lFcMbjB38KvcmQZSQpCERz45ECD1fOXhk+?=
 =?us-ascii?Q?XcVyYfJtAjdtsTsLs0vNaP8nG5otsHts87OJzDgFbNy9kkz3ndEsS1TnJ5om?=
 =?us-ascii?Q?ldzalLAZiuV9rOvoppTF5hx7fFJyI53JjZJVdmITO1XiWGscnPW2+ZOzmVMj?=
 =?us-ascii?Q?LEsIePf4+9VRtKu5l/iOuf9KRWaBhDaYKVVCZAlhkRYWokkCgVfs7CfiLBAw?=
 =?us-ascii?Q?zAo/zpCrZu4UEwUc93XUR0uIRPn8xX8/EsUMciLJkSxuOUmo0dvTaSIZ6mUb?=
 =?us-ascii?Q?CAl9s4sabR4GnZjraCDJ8KXF5vN3SZqnjCkNmJH4l3ieIuR6gRU9EolWpJxn?=
 =?us-ascii?Q?VJXJYI9doLxitwcPzGODTzOu1tzHO1nCs+w1RqhzBYu4L/ojGlq0K+OhFMbf?=
 =?us-ascii?Q?FYVg61tTj8QPZ9p7LJAu9k8ZkDlPUkoL9w4WiN7WI0jsh4LT10SjOtCWO26f?=
 =?us-ascii?Q?nll9o1nZUmoVMH4jx95t51XSxsOY8y/aiRSF2B4bFW2ocl+sjRfcGJaOvc5z?=
 =?us-ascii?Q?vptyE5p+Czsuxzil7pzVRit2khHi4yPRjPpFV6rkWhmSkS+eUN2972v7tUM5?=
 =?us-ascii?Q?Zr5+zbGn0ibsBcHzyx4aCNZb5qIq8cFEXu0gY26T4I18hqEMw1Iw4Whg4d5Q?=
 =?us-ascii?Q?CY9SXxgoF/Ey38LTeybMFglvYsTMUI+MG76j5f22XrzJ5PQB6c4k2F4+D/h4?=
 =?us-ascii?Q?/ELs8K9q//b9oII8KURpAS4RSfHTxuz2Uhnwir3BJkjDlHZvfDviXL1kyJAP?=
 =?us-ascii?Q?5UfhcKXdUx6Gu6uUmsTxUOrALN27SI9I26qXjq6KNGv0Qpeq87Kuk6XKdrwI?=
 =?us-ascii?Q?tmFM/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17edff19-9d2c-4cb0-b9d9-08d9c111c572
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 04:00:32.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gerk0yVLdk4QRp32hVnQ3xTLmJ1L59SVXQXButseYpZ58lppHgWbpMmWPTOBGMsPAn3o6Rb1C96WyX0RKcP9q8MjtjgSIEpbNuCpM/9DpRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5450
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=760 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170020
X-Proofpoint-ORIG-GUID: wXH-_X1TgupjorYJUrW3DcbHHhXcQuNB
X-Proofpoint-GUID: wXH-_X1TgupjorYJUrW3DcbHHhXcQuNB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This is a small series of misc patches. Please consider for 5.17.
>
> Briefly the series covers:
> - Factoring out the common and internal abort delivery code
> - Fix some races with controller reset (again!)
> - Fix out-of-order interrupt handling on FPGA
>
> I also included a pretty straightforward libsas tidy-up.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
