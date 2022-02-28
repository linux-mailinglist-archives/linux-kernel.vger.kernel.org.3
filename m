Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF174C6129
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiB1CfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiB1CfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:35:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D08532CF;
        Sun, 27 Feb 2022 18:34:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMWjDp008194;
        Mon, 28 Feb 2022 02:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=sHK14AhjhC8fuxTsgnPspoy+kmE7NZkNwIvjuEwyOw311VrDJqUsRQ83jmZHVVTX24BG
 D6HtwBSSfUqp7sb3QdBHDa4t8cDB+LwjS+Khcoa0WX9B5tIzeNsCXejGJyXho8rfWbbE
 h2MFHroSN1bw0GmKe8o5nFrQF9cvMrRpnWVfxXqs0BMzBw8EKvzMp9575XR/KUynhzdK
 dV5uTgaYuSkzVEhiI9WMUwnz4wr9eDLuVuMqs2tmdieT7PYTnCZdgDhb3nP5+wKuwwRT
 5YvDjA3zCmhplx6go3Gcfv07FWItGrGpz7qom8WbM3ycmW+5Jbg2cg1JgCubjVAybPK1 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02jxwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:34:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2VEd6087057;
        Mon, 28 Feb 2022 02:34:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3efdnj9qy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifiR1AECeSJaTrU/1uRgz4BIIXxdF5IdFQUFuGZhpeFe4OUPVnQrKVVtKFy8na0rGiUfNDNJRj7ZEUYctHEyrbPIw1tYD9IvLgxFBBgrXQrIv5wifWzxnKLM1HL/fvw22VCx5e2IIU2UEVszGXyGbflLv7Pjv98KJl7wLl5Ii0e3PiiYWuQ7lYZUH3c7HwfuN8WDOtosN8KOtRk5trbI7GgI5C5pVHpGvsOJS2CSniiN1xu6p4SZ+4gD98MLnRmM47oqWnk1qBWARSp4cM8hHuEqFK9Iqkfgo8JmNYrXdXOT7hEdbZusFeo8QcJPv8QtemV2SBG++XQehxKE9ksmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=L95bec5QFe/ouZ8tThXRP80Uoq5G3Cn5HiZuDfLI9LxR5qMSVw2s5knzETA1r3jNc+7u2Ng1q1ZUqSizUaGaR1WeeH88fOAzfmOIrwdP5DiKnMRrjlu1yQFryx8hb7cd9N0iqls20BvAj1QcxNt/82yucgy/uHUFctGSNORFfvbKD6MntRQ6p4hG9P3DoVKf4BrKi7pnA7mGXMEz1YwcwMJCilnV853ZJbqSotebaVvxXu5lr6patInvxXVTYYUbfzQPKDjS0y7vU7EBr9Ce6Yv0r98yvrUfixLUJxIwxYeNzoHRfjXuz/cYcyhocKOKa2829kgmWC1pWNpML4599g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBPLthZ08S7/23MJpAax8WwuwKJgyyB4G+XRQg+JtZU=;
 b=R35BrQijt+iYEPcGIs4CgSGVpOgX2Zu+0o+Y9o0qW5Xp702ncvFcg+hew2Lxtp6yPU/Dl6ouwSSnfVEJxYHNwY5owGfT0S9ZbBmiv4i3N11LIlU0vWhlkN3vYV5nys8MfugMsjE8E37QAbQU8XNltp71p63qnFOap9QVvjyVedg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:34:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:34:31 +0000
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mesh: Stop using struct scsi_pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y21v7m8h.fsf@ca-mkp.ca.oracle.com>
References: <fbf930e64af5b15ca028dfe25b00fe933951f19b.1645484982.git.fthain@linux-m68k.org>
Date:   Sun, 27 Feb 2022 21:34:29 -0500
In-Reply-To: <fbf930e64af5b15ca028dfe25b00fe933951f19b.1645484982.git.fthain@linux-m68k.org>
        (Finn Thain's message of "Tue, 22 Feb 2022 10:09:42 +1100")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:806:27::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b52f8054-e06b-4ddc-da30-08d9fa62d9d1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3717:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37170E547BDC73512ECC4BF78E019@BYAPR10MB3717.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtIbLb6lIJpFhcn1bGZWamwlBV7p2czFN74DO4yTERpsrRhmz8sOs1tGEYxmX6/VEruBwtn7KDkRNpHwUE+vV7CuFpmdM42+bdQYCwXueaDkknaEEPEVK/P4qWgdBzC8PgSDnIsiMiMqm5j3d1aylYZrcvS71XhPy/Fv90JWwaHD4NM2Ws8td5BUI9w5Zv7GIaNngmhNzePCNQiBFGtvui4z4Ql8BGws5J3pfxlRBOj8GaN+zgdcP72lumRZ6H9irLKgFce5eIhcGvlW32c/CbecHc3h4wkoX9iPBUsv/e7I0F+3KYfyFg+G9WoDsW8/L8PcBvOi5s4BgmgE/wXKZy35VYi3nhN9blG+Gq3ZOkqyaxEYH8qugSIxzydUbE6zz6APyBpYVuTcMKpU5itfxdOE/bYwHVcRgT+hT12nXK4Kgpv4FNAduYh5uaoSz3F0bJYEHgrSM2OpXYyoc8zngXba1YIVPYWr9GR9pUtVhn8Ot2hX4fTtZNtXeAaU6RmpPAyLH+p1iLvUgeb3ot5KKLdN5JtZUwszj7wivev+ooczVldFAJAktSArWaMQVtkfQM4PJxM/MlrdSVxvbNX20ssO9bo9iQoesrq3mszdOQazL1suk1vrRLDFAxNnQ9F5pae76nYoHnJAc1YQ0FIZqvQYSmR4x/Q4UUtaNNycIBTQY8LQhTixyDrTLZuNybeTn8aJYCWm9gkCGgDoLze5eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(36916002)(26005)(52116002)(6506007)(86362001)(508600001)(6486002)(186003)(66946007)(66476007)(66556008)(316002)(54906003)(6916009)(6512007)(38100700002)(2906002)(38350700002)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/VD53dV0heJ98D4zs/6mokALnSHVTKtoDY6/Zl2s25VzCSiR0FaywrEFtPp?=
 =?us-ascii?Q?ERyC0vdvpibXeJArROfmW+9GxMcq9uBzBc6cKPi/cy3aAOK2+FwiW95V5nw8?=
 =?us-ascii?Q?KDL46B1Hsnl1Kj/uehxegLDbHNpuzHW9ucL60KF+gAReFhsysJ7lhLMjtJAL?=
 =?us-ascii?Q?/HmZmFrHtGnuIbqKKeiOvxXuN7pxdu8t8PryBLOB9GJvAaDArzKzY6HltDBJ?=
 =?us-ascii?Q?pCATYudMbPnLJi/vulPKeLAxDORtz8AKPQYDCZ80E0WntSoSWvASxiE8TBdV?=
 =?us-ascii?Q?IcUSIO3mHlBwiVFNDfrJyYKZwfuLO7lLt75PhG+OQU9Aie/NMC2mrPc4xOEl?=
 =?us-ascii?Q?7gxQpawMKA/WEvJeos5gJZS1zr7aJI5qE5vU/mzFENvpkTo3fIoK8FQdicxI?=
 =?us-ascii?Q?lVeKah+6KqIfl4JcIAFNJMhONFm/7Rdu4kS7GD4COONtlCoqIGZEc2S7PKdj?=
 =?us-ascii?Q?MA7ExxAe2d5xZEytmXvhtd+0CixztFu20W04VQoUGAm3PXWeiS/4vnhSdGZQ?=
 =?us-ascii?Q?z+QJ/O2mfS+1GZuYXtcC9JSEPnX2zk5nNchLpekOuDSJrJwG54vyM2gfPDgF?=
 =?us-ascii?Q?epAgUUkglUIhcpkHa5OpeFoXQZoMlj+8+OUhAswdMrzWjDWUXjKqZB4QoY/n?=
 =?us-ascii?Q?E6NoQ4MdxykbzusBWxECEwg7+P4q2N0aeyQl7tTo2bwJ/f1FkzLqkuGvqgUL?=
 =?us-ascii?Q?mV8r9P124CZPSFdo33waZHK9YucKYySq0+6CV7N889YIpeDCmI3BWzHsO9+z?=
 =?us-ascii?Q?hnZPYPyQRZXHUEu3MS/4gJJbKXFJmG2zHtHTieBKbUXQri/0PupJhMCRckS3?=
 =?us-ascii?Q?l6MgELpNF3zFC9xKYOKyDa6ywLAdGwIYm6T09xAsQtr8yf+4a6cQrwaV0RLE?=
 =?us-ascii?Q?9PTdMt+5jRgGVj8BD5WiUjEaZU+kXwA27nrAo7DeuifYsgvB9pnDUDzap+L2?=
 =?us-ascii?Q?5XgxsiRf8HQsDXu9krdAj622tjp8Mj2E5J25PrNAUELEd7oECDQpmrIat3jD?=
 =?us-ascii?Q?FmKQ+OzpBCpeXbbrEQth+j6S7DJHiOyK/2c0qpCM2+WU1kHg+6Y9EiAdt0jz?=
 =?us-ascii?Q?xM+OgrdnTxuwDXNI/EkvEoq9E6Im6rJhpAvtNkm2UHxLboO55uXLLqph7AtA?=
 =?us-ascii?Q?YDFjZmsfkUYyH6tB8QerfWt5dMjbyeBbHwI2UXuSgNU+IWgKbyxLD28oZoEP?=
 =?us-ascii?Q?eokm2qcLy5eU8dKvxQ4TV0kqsDU/B3XRzHcYe5Aul3F+fKS8doeg4IPd54qR?=
 =?us-ascii?Q?iqEZze4dxWJlKz+FWlrULGFGQqhUNrNozsUTOX4lNGy72rxoNUz7qz0FBkud?=
 =?us-ascii?Q?1jy4vCRGV+BkApeRYNekV9xIzpNTPffMF0ZzDGD2ewKGPs6j+oaGs9aZL16a?=
 =?us-ascii?Q?TunnB7ccNveJs/a7LyNvmIlHEU+iJ8RsVVJyPXI52JbLrmD4XOB663hWqQfS?=
 =?us-ascii?Q?Ca8ASw+05J93mbungOmXjUcscOVrRDYqC3pmnM/b1bI82WE7Xi6sPWUCVyUc?=
 =?us-ascii?Q?SQUiqdn7JJpUv8tTTJ5X36yKWvVeDwEAXg7gHPoFcsV49glV+2g7fQx3/q3r?=
 =?us-ascii?Q?mGSEsa3yf23mP4biCDMgAwIgs+Hss7qiKRKlCNhhh2/Rlw6r3a8FLhc2pufR?=
 =?us-ascii?Q?Qcr5LO8OZbx5GIFEJgLy+9247wNDJWeHqJ6ZHxjdOyMSdY7DjEfxhuzxq3Wk?=
 =?us-ascii?Q?sA8Yrw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52f8054-e06b-4ddc-da30-08d9fa62d9d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:34:31.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv8D07q7WVJZ8BajpHYT3weRom8XcBEnc1fiELCRt76mGW15rywga6+g/SPy/VIOfd+AXVj9NzO7jH2W/hTOC6ehNFBeXVH7RiWVWJp9r6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280013
X-Proofpoint-GUID: _5xxhhPbzbr76gDUfZrPaX4UhZWY8bsZ
X-Proofpoint-ORIG-GUID: _5xxhhPbzbr76gDUfZrPaX4UhZWY8bsZ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> This driver doesn't use SCp.ptr to save a SCSI command data pointer
> which means "scsi pointer" is a complete misnomer here. Only a few
> members of struct scsi_pointer are used and the rest waste memory.
> Avoid the "struct foo { struct bar; };" silliness.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
