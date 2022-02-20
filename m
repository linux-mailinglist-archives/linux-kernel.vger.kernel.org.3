Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24414BCB85
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiBTBig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBTBif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:38:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807C541627;
        Sat, 19 Feb 2022 17:38:15 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JNtvlD006723;
        Sun, 20 Feb 2022 01:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1BX489wB2gko5GLoIZzbk8tTd3ba/A9UG99dLe2SuXI=;
 b=qcNAhfL2a7hTPlMUhbkGHcrfxw4kTGUpJfiA0m35jpZvx2PmBKPSJcHRm7zllyWIde5l
 Quy0S8kN24bh7TJV8cTfSVMWReHV5Q5yHdiuY/uZCsll/M3KY67naSBpJaS1clxti1zh
 XHHTZDzeOgwQS2RhDmnL+PuK0gTBahVrJsIrR/+k0p0RC3Qzmg1jS52yRuLWDXTdbxHH
 3/Nf6EmXWS6Yka7wMqllLn2cx0YFO61kDEBp6CDSle+b97dgGiOCSrYxn9k0eooMpiZk
 3cYBLKvroizcqRdOr1gL8P9fPJy+aMe1QJbG+iR/cKIixLwnRzxD/3YexNqvEx+D40eD xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eas3v13ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Feb 2022 01:38:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21K1aHPa013402;
        Sun, 20 Feb 2022 01:38:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 3eat0hwb99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Feb 2022 01:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbHp8+ckxf4txlWP9O6Ru3rzPKK1zzqQ4HdeZFTdORmBws/CaLFaJ0fIyjG0f2K+qqJ0MWDtOIHZs1iTeTHQrG9UK52/tADpxfvvkPH2bSAz/6o9p+FBYUBX0WvMpZTwEBq/RzuZHrPvSwCT4S2Drn5Fiud9CBS7xdzc9+WgwZ3R5EW4pSMUwuHI2B1U6W0wKjU0dVivnsHPHf0ny7yT5fYMrBbjrchS0L8xmI3oPHcCjTnHRFHiQNBrlO57eLqZrzp4BseGEExBiJPh7E/skWklqiHdyzfgM2MPw+euYH11DS3s9TWcB1May8xJH8JqZdLun4b+Nh8ClCDZcNYPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BX489wB2gko5GLoIZzbk8tTd3ba/A9UG99dLe2SuXI=;
 b=S3aj31Xoujz4jpnvmTeK7dnuAnpkN69I9E5x5R27z6LHiHcStqICNxx4KLJUG4/JTfMSP6TM4me0VHrgRM73CkjFrEhJSoKwZVLSJqqUv7E6cTFY9EgfFear/j5DeISMmmGly3cvkgFjfFyt97CadeikDUULisGqf13lLPbIYR7B2cINJoZ3YDlrjT/Jy0rz7GDLMXq6lzvWs4+riVPZcWKl4dZ4jWqHA0rLBXRxmVeB1b2kpjq4zOv6+tqfuNL2wGt0P9MBPRyqYvzI3njx1NaR1WzTyRWlGAI4zuGoYPt1xLVu4nK476q9GAh0crlAFXd/sy3jvLrMTTSIrKgw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BX489wB2gko5GLoIZzbk8tTd3ba/A9UG99dLe2SuXI=;
 b=O5wumbDZoZn+oLj+jwaXayjraSSOBNihIaUpthFDKBcOaGT8/Knm+6UFZWunRXlIeMtDqXbzb/qpWBt3WU5oww+X+o43rszLrTkbnjO8bh0GTNnbIY1HLCYyl0+g4aGV/SFqijQyuiu1UxDh5ku1h5bjTuPcPF4fIcIVDju9EX8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sun, 20 Feb
 2022 01:38:03 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 01:38:03 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.garry@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: hisi_sas: Remove unnecessary print function
 dev_err()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18ru6fhcd.fsf@ca-mkp.ca.oracle.com>
References: <20220215020524.44268-1-yang.lee@linux.alibaba.com>
Date:   Sat, 19 Feb 2022 20:38:01 -0500
In-Reply-To: <20220215020524.44268-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 15 Feb 2022 10:05:24 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:806:24::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 741a08d8-214d-45a4-19c3-08d9f411a2ad
X-MS-TrafficTypeDiagnostic: PH0PR10MB4502:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4502E48E013F0A0BEFB16D388E399@PH0PR10MB4502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLvWdtB80ksdarep0iySyWwce+R12oLqTktOoeR+N1S/4uDGD0O4tbdkAAhLXrFmFvnTLV6JRP2tHZeWTck4vIVxTya63gAa7QAmNUThgPGzvB19Eyth+rTxFuyBB4xPoXwQlaSySkQ0e2+Nxzpq/yBCMAHIrq5BMBs8fozGE5PYj4WmhTZT9DnqPbMWTlSnq6XYFhTiY4iXCS3RmEZVmyBZVz7e7wex3pWk5+Ccit0UltSs4QxOugSFiJvMTgucp4MMBvxtw5/liKiPE6XQLlDi4EoT9DDGCSSnxC89lH+Znycx/5cY9z8lE9iDZ4J4eckL1f+y9L0tLKdLccRGG84F1bvuDTsjAnggEEo86DO19HspM3t+Rua0xUh2s8jAttOmo6mVF0jHQfFXBjLeq5ccNraUVnrCg4hl+HgCRsupw5XpRIbVm++u0ctRcq2WbN7rwumotxZnhdDwonmRS1ZW9Kvppq/qsra64+FnFpxOUsSVjmmJaM2nM1MzpYi9ZGb46uwEI2sQ6T37mdFPYIVwx+/JCY+4joB7TTDnPJOzTTSBdMH5fTyaEqo2PIFhkYLK5YZ9rZeWR3UqPxf04/BMDZX6eSSrXVZIMZjUNuMgKKW9g1FD9zY/6B2j8n7xEshRYrjkfaLysAq0ueQ2SmqzoqgNMrgdIrpB3p1D319ZH4LxnaIcwQODEtLfli9edfsn9vr1yHrFNsvHsFFaxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38100700002)(38350700002)(6486002)(2906002)(558084003)(6512007)(86362001)(316002)(8936002)(6916009)(5660300002)(52116002)(66946007)(508600001)(8676002)(4326008)(66556008)(66476007)(6506007)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JE8v7/+aXyCE3EF3qOB7oANMDqMAKBfGbtHS6VAzfSO4DXt/TaimqTiRZD6+?=
 =?us-ascii?Q?duqorZ+tdz1i2o5xDSbiFrNUEsp2/lhlj7h22zo3+Qq4+OUjl5jJNntbdqEJ?=
 =?us-ascii?Q?hGjZBJ7Px2to178QTryRntkDun7zutAT0EZXKYTgwmXhG/+ht5RUxcF3I1SD?=
 =?us-ascii?Q?pHmhDlbsQUy1azILm2MHjV41Dvh4pjelkIWI4fVVtOM2aWBGrl0RlEkNgves?=
 =?us-ascii?Q?DmWYhZDNcYbbTvdkjshVvqSfP2jP1pL1th7Xupes7DoHmoaCNMQR6ZdCK2U6?=
 =?us-ascii?Q?r3HeDSvksJ0KTsocZ5jnClHiEp6li0KSBTmUh/5UPUWsDUMCS4f8Ll1U9Z2l?=
 =?us-ascii?Q?r2naOkpilufo2vA9evOlgH/iq8PCBxIWPHEgvMvk05yzeAMfdKPoMhb2Vke6?=
 =?us-ascii?Q?GU+ZhamdYzbCjJxuciTE6Ib4yfpLWOmm6PGMEoqoL5+TDty1jZyMq654PO+3?=
 =?us-ascii?Q?3OTodnABnzClBdanGkDE2FLuI/fUPAiWGSascpTsSxauoUUJp/IdScKqFpCy?=
 =?us-ascii?Q?rShwTEm2oiE0INaghlE+H8ciXKKOKzIZOi2GnmAYTjmL4RusQF3YJWZWyPSA?=
 =?us-ascii?Q?KLUsRKdmqNq1OqZ3fUVHR+PyPwNcLKJ9fYQwkUnyrv2bPkIJJ4bpBuEwJGJN?=
 =?us-ascii?Q?WeR5TOl3+V9hK/XU4LeCPGh3HS9DXawHCn654Mndqen1VS62O0obqJ9G/FIn?=
 =?us-ascii?Q?5DZx2j/pzuSI3LsEkjbPhA2EUACPSBAyKZpQCG7hntMzh7X/E2a3VD+IajG6?=
 =?us-ascii?Q?QmE8F4bmal6QSmCjlMMS+VxqmBTaSjSzHfiNahFJJGFIn12/wxucFuXnMzyu?=
 =?us-ascii?Q?CLf6+Nqrr+Dd8ymvX3DxVjaqkZrP6pVP7KgNm7NwQVO8av6qv4RZhRJ8EhA+?=
 =?us-ascii?Q?y1nG58DpnYMRuRPP8vZem7+YXdchmt96CGw2qojbvigDHqevbd+UD76pdcBN?=
 =?us-ascii?Q?l73myNGx7IjAm7gVMmAZctDMqbo1GgZhljk5yquzivc6x0OuEpff26y2lFCn?=
 =?us-ascii?Q?nlMwAbqSlP/ZYzZDt3c+zGy0Z3zLPN9o66I+/4vX2gZ/y7VTd3c2Tm8VwMzM?=
 =?us-ascii?Q?Uh8KsaQ3tvbknXYMAChJIyJKeTJyKLjxxnpyNAuqlJDJtqD+11+RWyDMfJAv?=
 =?us-ascii?Q?Pz/ttTg3MuSZDS/Np8U1JJ09qHSbzvgehn+HcdVwwLAP/UPPRMkGW0eSupgm?=
 =?us-ascii?Q?nC5x62VTF8/bztoa33ljSQX+eVcsCAqHI+0DMHCj8v0m0fWrulO3wY4hPnyU?=
 =?us-ascii?Q?mH7IGm6u683PZ86/eTM4tQJyqhZdJbSxkx2EyQJzN5YwS1Ve3uxzsLpSZLnx?=
 =?us-ascii?Q?V4/cctiWlP036B+WkivvCOzgClnR1aKcElQw5uBJ+BRMpC7xcgFbV5YJyMo+?=
 =?us-ascii?Q?Keciwb+jugAzf5kWPyGSLhs3ZTudsrz7n704xKxYpU7GlUsMLNyCvRUF+43Y?=
 =?us-ascii?Q?v+kwK7/7gx/aDbxeQnM8jw5zGnqYf48rDNqz3EsJc25c4S6tud4VI/t+kCbW?=
 =?us-ascii?Q?AP8cLgSFBFkGcXqjI5TOvZYDI96J/Na7jq7snmyjo2IlFFLtgtTgW3rqPVjQ?=
 =?us-ascii?Q?+b8n4SozNJSUmQaE0m9xCqTvPH4t+t4UAH+A5/K5kkaQ/8qtgoxVRWgnLzzL?=
 =?us-ascii?Q?XNRiUcrHDl7DKpkJe9icCKRE+zAuOe1wiVMRtjVPT5VJDbxcfZSsrA8JXJuM?=
 =?us-ascii?Q?oIJPNKRYVd3yEiYbBWfQmceUJL0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741a08d8-214d-45a4-19c3-08d9f411a2ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 01:38:03.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vkfTx/Wt41LY3+ZRKvb0g5jG3gbI4OalSwF0jXne34psxhHnwQN2R5ex2JoeVzdEphRskWTrlwd4u/+YKoc5M9Jia3XpCLqpKf4FZRbSIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202200008
X-Proofpoint-GUID: gEQuD9QcCx_cl3-P0cAY7cYPnaB1o4Mh
X-Proofpoint-ORIG-GUID: gEQuD9QcCx_cl3-P0cAY7cYPnaB1o4Mh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
