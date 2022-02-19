Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB194BCAFE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiBSWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 17:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBSWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 17:14:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4295246140;
        Sat, 19 Feb 2022 14:14:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21JBDbTw022629;
        Sat, 19 Feb 2022 22:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ig8NSsR/NtDzrm2PLAQTA9lzQTodu+iSm8YrbUALJ2M=;
 b=iMml0W9OboBOtkx3EpAar7hIkp54mmciPxmExUMqxgxuXnpBcX4CRiUxFER67b46UPlX
 no2gymQKbAXcMUZfIKtPMWH84ZlUavL5IS+UjniWQksvk4mHNMg3jys+SnpS3GEuQS0i
 jcb9/XGhRDiP/NjjV7580IwLanEYWkBGRnxLTBcN97VJF7ZfaeonS5WawLRaS2t9nc4w
 QSB/iIUCY1l1Qp/U6IPfOKKB+olS0zzfyFavhWej+w8Box1CdEWYsmZyp/qOYIzBq7QX
 jJQR0gWRFBVlixnwt4SQPeLN1jCVJjcf3tLy7XjO6jlc38owsKWu6F2UdTaG94wd3ing PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ear5t10h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 22:13:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21JMAKOf156166;
        Sat, 19 Feb 2022 22:13:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3eb47x5gfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 22:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkcRn8LG/UfheofoaEAaneP97yeobZBtgPmiBArK/5mCElvI8kuHTXrAsNKuO9a1Fu4+SQEXPAehczTIn8JB14dp2kAZGFhsMdjC1YaV+N8yBGJSYKcLvcDfMRP26IEBeEoQUJYl5futJUEwpVnzGjU/rZhKU+wLiL1wrvo64ETmMvKQj/wMf7Erv6kKcWyYr3HHAkDnk7JovyDzDwdLHMGTfLUYUvkz80qqB8a+X7VMLsLm/8hWR8x4AuGIPgSAdhI4lbGdmsEPpD9BAQnCJt12WwX2D2YD1re02SrcXcGvfezWGgxc4oCHpf1Uz8/3ZzvEc+z75HEuBhdLz4Gbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig8NSsR/NtDzrm2PLAQTA9lzQTodu+iSm8YrbUALJ2M=;
 b=LNCN/3a/Lwchy9Dh/gKAvpiywc56TzwKD6BhSoXTO/r9FQV8dNr2LIIHyQfFce5pZ1hUhHcOzzw9WH7qSCKgUDfG6iGQpIjsaIX0957PTATN+YwYiWPTPyeUBaya2ilN+1Ot5REQ4EUsRpOPtATfm0WRlZ9Byc92CmcrU7luw+oLsswcfbOqTEPQuhqI7Jh3hE+16YaxQkuIMBSVlJl9wWLxHy3rUwDqaIi7MxiCbO2d422R00hWO4+Bq1OSdkNr7V/WG9WRt4TChZ9JtaZtT/8/E5XCtnxEjWYivscizsdmaV+WrzELS1Pfb56P94Z+TasDBQyIyYDscwmzO6KsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig8NSsR/NtDzrm2PLAQTA9lzQTodu+iSm8YrbUALJ2M=;
 b=N5R9+Fzdu6EzI5g5aalm5diGxChAfs9wg3eWk5zRUjHBTSOjgeprS7eYY56TZiz4uFm5csv8DQvdzPaTGutEViCuxXoiRTnyrAs9ncZIS7Bhobx5ortCh11nhYDEWoUB9xJqU2iZWRMeDiw49lL3SsTKlfXmeX45o2DiqEXBl9w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sat, 19 Feb
 2022 22:13:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.026; Sat, 19 Feb 2022
 22:13:50 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: Remove wlun_dev_to_hba()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o832h5d8.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220215114002epcms2p1eb4e53507c96e0f24770af16aedcf5c6@epcms2p1>
        <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
Date:   Sat, 19 Feb 2022 17:13:48 -0500
In-Reply-To: <1891546521.01644927481711.JavaMail.epsvc@epcpadp4> (Keoseong
        Park's message of "Tue, 15 Feb 2022 20:40:02 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a37868-0c04-419e-8453-08d9f3f51bab
X-MS-TrafficTypeDiagnostic: CY4PR10MB1381:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB13814A39F659CCBBC636AB748E389@CY4PR10MB1381.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OlkrnD8zG8396JZ0cxp7nKb1qpI8fL9IshrDMzq6de1zX3jhy3pprhdycck09gKIuQ+JVMUylKouWgSEYSIhGGCSPT1SEehDQR+PNYo5b9J8ZiypZwNWb/lTN8EKAQ2PaVqGNg99cQLZjkWnAQRhPP0CwWmGuV0M6sd0sQ1aBKjwOjFR/VrJ/KI7wPC/PG6bEOUz7QJPFfpSb+ih50qoP4epgQg3bOTJyDNV2SJEuj3qzq5BxGt5SsayzJwmfpkwq7YvOaOiPJek0wGy/j1scU6QastxQQFemSdAqfjZDl4Ow4P68K8gebhKr/n6TvdREXcxLVmeEX2JeepZ9p50ZYwv5Xjl/yMUMRMTnzc+nL4hfsvmiIV9JhIdrsXdZ+tejncc+X42eGlUjxsirx/9mhUI4xPK03LaMI7l6stLG6RnV/aEPw8G1dsdh5CmG+g+5uEp7gd8w1CUqvBuhUs/HoAnBrVp7J6nvHto6/ebAYOM0ilY92g7xqVSOdP++sjJLW/Q9786nR6jcc44mCnFkbOAR5QKDnBvZXrcpgoYQ+5GZ31ucVx5fJ5F82i+7T0hki75NmYz7FnVPuBjhQ/VpVVglz8bWuHjfuVxSiAMx36mtGTXWisRpxRMBFPzBU8qVcK639K739nlbarF3qzoyLSpI7r5mkBP9epWha5kG6AGQuHmjCvIkcKnCfEXA7rxZTHEUmpmkD5l5YUTTK0qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(558084003)(86362001)(2906002)(38350700002)(5660300002)(7416002)(6512007)(186003)(26005)(508600001)(36916002)(52116002)(6916009)(54906003)(6506007)(316002)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASdtrdHRAOHJh1p6LG2HzjRLwcxr7CfMHkgIoN4lPFkkgIwAUED/8KS8ggJM?=
 =?us-ascii?Q?tScOQP4/dPbbVq29qSL1i4dWV9TjcjAe+pBFM8J9aMi09TbcW+hlWmX5z2ja?=
 =?us-ascii?Q?AlSVePQZNliCxo84HF0/OvSJm0hin3StGkIyFSMkB35yZA1SeP+KCdA7bk1W?=
 =?us-ascii?Q?polX+7iNaAhYgqdAHUJike7jgR6B1WVPztV190/CNiBgaxtkYj/AtLiG/2qD?=
 =?us-ascii?Q?e+8MQtLUS1DvJHzeOwzntl+Ickl1L+w5oEV+tOgyOEiLlugKdHVMxqsHAjN+?=
 =?us-ascii?Q?EIUTxARgTnaE0ShihdUWb9cCoi8tgPiZ18QPuZdntyWlrFNeEjn751zHkpJE?=
 =?us-ascii?Q?onCzOnqKRqL70zjM9eMpNxnO5tiuMc8x5aSyfPQDGZ8kCmWMjDvcpqL6DX4i?=
 =?us-ascii?Q?hwXj/JPNscF+/GSbsV9hF4iRcPbIc+ukHp7wLfuDM0U2tMPG9LfnxbwANQ0v?=
 =?us-ascii?Q?RP2ik/vayIGHJsTVT4Qp5l22w74ryexbVd0Ol4Vl46rsyxsR8L7n60Zi9F9H?=
 =?us-ascii?Q?pKeZycPkmbnUvHVjxrvRgXjSS860wngCe0wB2yUGpvGoxjdS+vi9I/fSVA5g?=
 =?us-ascii?Q?37HUXI/ZeDnsZzUR9Tuiw9Mf4ot88925+0lzHbUEAQ2FDlG7qAriPsNkHM0T?=
 =?us-ascii?Q?IZz1vSlx71p1+Vk8kARzKwUz8YGqjkfs7aI0Yst/zLvlTXRTBfH4A9ayO4bb?=
 =?us-ascii?Q?ahB808QyAKFfTjPEfsRWGY5lyJt0jfX9Ua8lG/YVFXo/tNL1Bw587i33igcG?=
 =?us-ascii?Q?kYg/FEaT5CEdyGN7BqcC1dYNbAZ7V1V/7Qei9SRa8n0FmqmqOlq61YScX/q/?=
 =?us-ascii?Q?h6u5eiGnfP+BkTbPRQKHHoEKxwewCWe5UbySjwbsNbQqlR0Ud2pmNVKnKxEE?=
 =?us-ascii?Q?SmnbbmBBolFunk+5H03P0mT2vVo4kMKNKyYu0PcjABeVTP1DwExTJwLTLQsY?=
 =?us-ascii?Q?NQpC+Ktgu2ECchtIWjxyS5w6Fd0/LFZjrYBhqdkz0o/dYW6uikSYEgzHLi6g?=
 =?us-ascii?Q?+HyPLlihe+eKLKJ3U7rP7u5S/CRnM7McRJPB6Sd5m5HCnsrZC4DAYWp3VGhy?=
 =?us-ascii?Q?r0s1nhBF36RShPmgUVDJa2h2MHCUBy1uEvth4dhekAkx2iGktyxSuLTPKBCo?=
 =?us-ascii?Q?ZtQvPcjOx+zqrpahSmCs/9hy2dT5/WqsJuNnhORMayRCPc40f0rCUYCDVpWs?=
 =?us-ascii?Q?BkMkKuMbVLaaO52z1Ganlv3lk1yog5eDcSfZ4wkUyDPLUepafGScme9S1rK1?=
 =?us-ascii?Q?hG76WKuHNBAtap0f06EJ3vewArcL0/GgjmuSkbZBKsKB8cZxxaiK+gO9mAH0?=
 =?us-ascii?Q?1yWk/fFQ19+HCuf35UHVYf5YZcjMl0vBkl7MIatWxcXi2615tSKGnV9LPZHI?=
 =?us-ascii?Q?Es00dznkJX8ZDxpic6p6IbT1ZVEBTJA03iKMAHfA/TnaUleeO2rVKSj3cvK5?=
 =?us-ascii?Q?LTtgGlQeCLHw2QWabDnS6605h+dhB6+r41NnVEj1f53VkGpHBq2KQdGz4sER?=
 =?us-ascii?Q?ZpMM5M1A+V2gCthfrTxPf4MC77kGMZ788jBuaSeRX5J4RhHkCWlRNhSFM0D/?=
 =?us-ascii?Q?N4Mg96C+QccgoLoCqVeUchS4pfbpx7cyjbusgQiuP3IFbrGXgCxwCiUkcPyc?=
 =?us-ascii?Q?Kz10ukOIvmOI2HyAqSrOMPB6snuoIcpcTRB9L2IJkPyQ6MrnJVHlfgUwJAHy?=
 =?us-ascii?Q?0jZ59g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a37868-0c04-419e-8453-08d9f3f51bab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 22:13:50.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5dtYiWYvjet4Nw0n2Sjwv3VZeuUhE1dMC7CKOt2cdqGL8gaqDziMWmyel6QkDUgubmZ+LdCPb8Qq293IiWSz+fT4kdQT9ghKl0uNnsvDZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10263 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=934 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202190143
X-Proofpoint-GUID: jJOuIukd_0eRBwChN2C9Ru-evVCc8Qjq
X-Proofpoint-ORIG-GUID: jJOuIukd_0eRBwChN2C9Ru-evVCc8Qjq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> Commit edc0596cc04b ("scsi: ufs: core: Stop clearing UNIT ATTENTIONS")
> removed all callers of wlun_dev_to_hba(). Hence also remove the macro
> itself.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
