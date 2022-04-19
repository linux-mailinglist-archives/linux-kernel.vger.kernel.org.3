Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7E506252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiDSC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDSC4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:56:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1FC24BDC;
        Mon, 18 Apr 2022 19:53:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23ING5tq019340;
        Tue, 19 Apr 2022 02:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=X49+mi+o58Ab5G6qfvdH9SAXj+fC7BTVIJoMmfD0K2g=;
 b=ssMeUdHPE7B4pFfjo2jodXWQ88yM2NFu6nOpFgqNjZd9WL4VbnfBcxfZDH4AWpN0u8h2
 qEAFh9p2PjJufObyo17i+yVnLgKrGE8JJhxz/HplpRbZIJyf3PML8eIYA+iQgYl2NSo1
 3VyQW4ItVKoDXJgBv8U/x09RXqIu+UACvmHEbODI7EUYLXkrYgR4rrQjKBXcGltTLC8N
 yfxrSXs0kqZ6IrzQ42f9Vof8+VWeYmtgR0SQLJOJGztaM3X1YnbXYR92iu1eUOY+IRmb
 d5MVw9BgIP0URKaImg3s8EZdDYgq4RxttU7qgoTEP5ZkRkeFMbY8wz2dsIvK1yYFnI7n Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cmqye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 02:53:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23J2qdlX006089;
        Tue, 19 Apr 2022 02:53:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8205x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 02:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3DfEexHpf4K53RyfMFRbPQdLEmGqRCHTGh7xV1LRypt1XiVG/mTJg82cxCd1JijNK+Oj+ioEd0G4v1aUGBktMBtevJGOVefM0hnNXL/SqEVQBF/SznOQMyCvTJscsUUyYcm9LvPaU2T8tJcMxoUE9g0m8qVxpu8uCw3BAj0OP/fDrSaGZw/ywcbbss/Cp5OEMjKZWi/4GFPJjSHCSq0IlPkotsmCYPMZkNCno/WdQl0mzl/uV2Rjrq3UN0OTXXmOU4Ln2Je/aa+XfVQFxNVqoKOj/Oeb6gS1IiiDkrv9TK5JS2ImtEsAyIx1j/xMBivrxVrVCq1C8471aVF56+DGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X49+mi+o58Ab5G6qfvdH9SAXj+fC7BTVIJoMmfD0K2g=;
 b=R2bUkLdLFooodH6jQLoY8VEH6mavUoU2agU3F7TH7f0Fci6wws9MwpiLzO0WCOQA2GmFjJkAcRa6hC7CH1OCEyVeLJqxkrR4SoWvIwXxbLDCeAH0DNrGZCtHArROg7xo4jtyjLTUcdY23xalCe+4AEtxXFbDjt2sWKnZ6tLllq4OQsninxk8OffAYqkg3RHwnQ4uzMHWx7mOdEf5gpcohhY3NubyGzK1Ytb0maf2Rl4QHFr8YlvFRgfBXhoOncwUqFcx5VI6IProsARFEIX7fPbYHmOa1jdDLYBsACpjEfI3mh/uNPWTTnjlcr0c/AGoYx0sRfErK5NcVsDRm9zOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X49+mi+o58Ab5G6qfvdH9SAXj+fC7BTVIJoMmfD0K2g=;
 b=nW4EZioC+z/7JF46Q33AJIv8sp46e/3q0m5jhN9QQaTao0eb4YKlGJDHuqxOY1JSlSvHogt++iF5B2/hLYUNJePkcCnugkGr2atswav2aA5PFmHxXrjlwIAX2bEmsklW7HBqeUPTPQzl8pJFSMTK14vvEN/Ygqiv1Xpfj0UFETo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM5PR10MB1755.namprd10.prod.outlook.com (2603:10b6:4:d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 02:53:11 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%7]) with mapi id 15.20.5164.018; Tue, 19 Apr 2022
 02:53:10 +0000
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] scsi: pmcraid: Remove unneeded semicolon
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rs1ains.fsf@ca-mkp.ca.oracle.com>
References: <20220401030640.28246-1-jiapeng.chong@linux.alibaba.com>
Date:   Mon, 18 Apr 2022 22:53:08 -0400
In-Reply-To: <20220401030640.28246-1-jiapeng.chong@linux.alibaba.com> (Jiapeng
        Chong's message of "Fri, 1 Apr 2022 11:06:40 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccb667b-5850-4135-0ccf-08da21afbd71
X-MS-TrafficTypeDiagnostic: DM5PR10MB1755:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB17557FFE2A21602C175F9DFE8EF29@DM5PR10MB1755.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYRSd+l0zBbiIwU3izfPAhCT5pxZ30jajb1CyQ3uDCIxv2k16F5woUfemJ0LI5BeKHXlP4WooJGhpTdwGwFXf5gVyCtOCnUAGKLV4raW2bjl3G97Pfw5mCYA2lgmnYkal+xwfVQANqcrRqE+X8sTtkSi1a0gUY/uE92JVk8x1wahKmVbQELkOFhxLu9Mkp3kxEUR1pLI4R/eNp1adT5VCnhEYn6q9IpZe3Yxb1gXgRgNfnCktm80a2BlkB19LYveF0CsKCfNBqARKNXjjPBXCBKU5jAA40ldm60R9+Rl+kDu1NRWn2lsbQJloLBzSzaTSZblmX79bVidkM2XFDd0/wXGhcB/IMnHHV7SqcP6mmBOV9g26RMbG5hj5lwiYS/PETdUB5U2D88SAv480frnKfjZkIGBqtzL2AuMvo1sycpHuyt4K4hvnYrD4KCaiu3H7q6GmBMRMgYLepUvXl15z4nB0Pn2kajD6BiL3yiD2JbrvUangOQfVzAxojiJjNBg6JY+pnF7OeKopvFv2EIdVuNhCbkASe3u+aWJbKzQLDOAurnQrkoEiQW8v7n1Pqg/folFwKg2FwQI2hQ0WOYKMc/IO9ec885DC70lWIIi6h6h4czN62OCIGIz5TOXZF708RAJS28wtgEV3gQh1Q2XCm1cPM1DGb3htEYm+5ZoBKXnLXw4CXGL3NvzAbDVJUODZLX4iide/DA/SrykMrUZFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(5660300002)(6512007)(186003)(316002)(8936002)(38100700002)(4326008)(38350700002)(8676002)(66556008)(66946007)(66476007)(26005)(6506007)(6916009)(6486002)(508600001)(83380400001)(36916002)(52116002)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGA2U2WIzIpW4Q/GcRx1hAWi2cV+Qh5FHV/DnIuRmCzz1dJJSnwXE2y2jiAN?=
 =?us-ascii?Q?fQ15gVsxdc2lV8EjMG96CR07Pwlvt1h5QMx13M6oayTviWQYI/pMTQYP+rEl?=
 =?us-ascii?Q?HmLXt3xuZXNR7gUBLGWC9SSpA/paSx+5Cj6Z9/ZQ2ODofCvnOMuWRrQ2V757?=
 =?us-ascii?Q?unj/z0tPtHXVqgWjGKRCQ0ExrnbyHl3XulLhgQT8lVP17Rd6IxMgJ5J2e77Z?=
 =?us-ascii?Q?AJH9jAFwlB3GsfelQQNbaKhffG4NZNAQYCqrV4sXMqLvZB1grHvHpFWsALUk?=
 =?us-ascii?Q?C01NJJWYc4SGn+yzYMbyLxfujxTsfvz8Vm0IUVmB65wqVSyprG3Yq89BYJya?=
 =?us-ascii?Q?SkhSsqLfKWJcjsQY00lvoVpuqcblsAAV15xiLnZ8uCoNqHyNUuohyKqv0lvM?=
 =?us-ascii?Q?Avh6LgMtsGoIkin1rWzME2LLm+1n/HOQswlQHOyqqAue/qPqYHr3vo6n8Xe5?=
 =?us-ascii?Q?1CFvtpn5SkVxSOIRUut7inyRq21TmERhtW8fd4DiMW0y26YNDPzikh118Zui?=
 =?us-ascii?Q?XY06IoSKkHu7WRszOlcO2gxIZ+akwe2O+uOGp2PInep0bSsibUyoamvBOUy9?=
 =?us-ascii?Q?CKtqz/hbBbrcte7AdDmutWv7Y1PeNo6BbFMVa3AQfJ/9bGbCWnCMEjIBVD4M?=
 =?us-ascii?Q?YLSXHszSHvIcbNAKAa65NjWfHgPSK1aoLpr3kYbmqweXmyK+cW4zfP3F/MPY?=
 =?us-ascii?Q?j32D9wpAZufClF4o0laV4JEKtPeAAkUk5I4xq3yh5ZJR5zJ8v8KVN/4FtwoH?=
 =?us-ascii?Q?QhlvI6OfIzDijlvuhW+pdxzr7CfnbdW4lzo1mNKfQeQiJ7hD5AcytPrHcrtw?=
 =?us-ascii?Q?I66kYC2L4oveg99jHKhBnVVM3WAXQl0Lpqw1UnHyuuAd+ydSGg6PNYt/9G/K?=
 =?us-ascii?Q?5G23JKISXE2g2024iA73ZrfIaeLw2/nW+EBvJHyu5CjI+tx6uhZzGw0sPJs+?=
 =?us-ascii?Q?H37my2TW0Uox4YdTCkdsjB/3ReSgDCMnV8IUPIgz1MhV811PoRcuG2biYRbe?=
 =?us-ascii?Q?6ZxHAqPqb9ii1+w+7vn6FY8V0FXkIRG471dg4X69tvh0trZhjp72oFT+mCpL?=
 =?us-ascii?Q?igmkD8N7mc1AEIxvWtrGUbXT9G0XM7YEr42R8w9jUH3/g/TOhzza2MsVX+/e?=
 =?us-ascii?Q?CTQWZznGWsPr0203ML9FejDwIQz1Ab7iuPhqe5R65pPXcngKvpsfxdfOkoOT?=
 =?us-ascii?Q?QtcnMD/pxT7EX8Axg+s7VsaVucnqQd+xmnSpMMJHjbwLxSK+2/edtcRqAIph?=
 =?us-ascii?Q?+ECut0BGMjvVNAtDo8rKfOkgjFAxFhMx7zJqh8c6gmKWygMpXMFHFqGkufQ9?=
 =?us-ascii?Q?Ef7k5NQEZLKyMbuPPVPTTinPtC9wvcPEk/qfSFdnBNz3FYwQzQiyIwWHutVk?=
 =?us-ascii?Q?+klrPggMm776qUX3FP2sFy4wBmrDzhwvms8InI9fYjrW7sZdFWivbGCMKZSa?=
 =?us-ascii?Q?WuQoZZ2UqJUheG5JiYNtLm4OrC3L5WfrBImzxFwmC5Z+Zq6i2jEbQTg4gjJ4?=
 =?us-ascii?Q?9sgGwC8rv6U7sGICZD25Z3B6B30tFengobZdg0CPHPT3YXeH7ajmxJh7ti2F?=
 =?us-ascii?Q?Gx6f84zaUmfHOhrwbYK7UQZZhltov5lhBUqxS1XF8nmYmjnsk4yeGbwiwHsi?=
 =?us-ascii?Q?p2dTK4tocZ52iiVY1KGS92F3phWvhjHLLrrPPMLrbCQiBEsCbhhPgSjKSZaN?=
 =?us-ascii?Q?Fb76b9i5KZc2uPx5LqpRBjSaAqdLcitQUO8tK9wRJMzFsq7qh7OjXnyXdUjn?=
 =?us-ascii?Q?OKen8VHrztIYWySXPyMEy/1pJEPdCSY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccb667b-5850-4135-0ccf-08da21afbd71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 02:53:10.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0YldSEg0KG1AhGv52hYHqThYATJv4N/3pfSC+8xDsAyAro4uttDYqF6shnEr1uy97cCHQAZ4sD/Og9/9ZEIe1LXj5Z4Ux1ARcVhfE1GAwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1755
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-18_10:2022-04-15,2022-04-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=873 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190012
X-Proofpoint-GUID: uhx4oSaGAXKrxcipaYz6OyGuWOX3vAOq
X-Proofpoint-ORIG-GUID: uhx4oSaGAXKrxcipaYz6OyGuWOX3vAOq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiapeng,

> Fix the following coccicheck warnings:
>
> ./drivers/scsi/pmcraid.c:4593:2-3: Unneeded semicolon.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
