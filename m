Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42B44DAD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354767AbiCPJD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354663AbiCPJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573086516D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:02:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G830V2018383;
        Wed, 16 Mar 2022 09:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lnoOubGI8FbwChubuVrmu9N2Prl3bb8e3fIetzMkQDA=;
 b=YgN/FNx1uvEbvkESL/kmiDfI/ce3U3Xy0B8AjlldEk2bSyEJKCwdxp4uTk3Ks2+s8oUn
 ZHS0EJMPRFO1YCvY9XK/Cog9B911gCRugpLbc5w62v4YTkU413sUFt+W92FVR95Qg6rB
 8uU/2iDutDtWVQodiLloUSPuFI6XiGf0r/3MhlBEoXl86bipTpiUIb4MQnWBTji0MT7Y
 Cncx2P6uwWE1BfaSQcgoLVDRBNw0I02l9HNi6gKDLaAjsatbIdS0ssvh2yzv/IQ8CQ3p
 9/I8r5KwdUlk2+7ofYbhpVAm3iv0OaKyFBFIbAiJBosyAD1Hi/ISWS5dBwVeaBBS0GGP sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwnb1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:01:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G8u2HY183004;
        Wed, 16 Mar 2022 09:01:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3et64khtga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nun+iMMY1QUXtU1SItdJPvV+e5TiSbjehfsKe6gKaULZQ7ygK9E3EogqK+8DQz/xTUq+3H4EHFvWJwXeUI7hIHQO7MDVaG4zLc79oEYHWqhSWDr9hny+zwm5tISY57UwqswbHrtyjbYAA+rTT72cw/AVyzrFbrtjPgphI/mH/yRpL7KunOVRpgz/YEMqkIFgWZIka2fLxzBqnGo+VEoAnZDDToRRzai5nMpCrxFePVPgADzox8RsH5Y1a1XeRfLiKNaGPAGpIFTLa+iUycFACQODNXzWcAVicjlhCWn8BdCZ8BSj3nUv7qAMErD4QyPfbjDwtxYNavLnuwpvVlanZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnoOubGI8FbwChubuVrmu9N2Prl3bb8e3fIetzMkQDA=;
 b=DMythwqAavlBATCI1apA0qIMJLVEW35AKkINGpqJ/+bF2qDOD045vur2BzTmMuyNMk9K8mUfe8YtxpDSVLf3aTXmoe4t5tTI2vHIxO0Oo/dKnQd/MVG4XEH3zJD4ARPiNHBSyaZt3Kf3s9o+51Qq+aqZ92ox2pdP2bV020uVxZiKINiwV957+GiFLU7zRxgxDIHS7lnzlGUBXlugFi/+vNqDGJKhzFPDVvldo9uKmO5QtPIDGc7JESk1Kfait7g15tUI4oUTN49yhj6GW7UraDHR6q62mZ/UQNVqTWTRtiI+S0pzowbZwZimoIfVooNX1yydJZB8hrZRR0mNTp1dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnoOubGI8FbwChubuVrmu9N2Prl3bb8e3fIetzMkQDA=;
 b=ZLEfIIJgHd/biNiMK7bvrKwY1eFi62s3PgADyvB6ykx0WaTQMh2YOgiR/+eMjoqg2423modtdVeGUQ5S4hTK0wzBz/wUyUT8l3Fa76zYMXTGc+tSmMZkai2YlEMR9+rd0QYxKrgR8m1kdQ3BG+Pl0prhcpLGvGAfl8cJdlQ6PFI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3217.namprd10.prod.outlook.com
 (2603:10b6:408:d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:01:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 09:01:48 +0000
Date:   Wed, 16 Mar 2022 12:01:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: r8188eu: remove local BIT macro
Message-ID: <20220316090128.GT3293@kadam>
References: <20220315205041.2714168-1-martin@kaiser.cx>
 <20220315205041.2714168-7-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315205041.2714168-7-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a6fcabe-4625-4d12-efbb-08da072b9a6d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3217:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3217BF529D1C933EB561CE1D8E119@BN8PR10MB3217.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDZOlvBinQRZmgvKqu4ndbyfhyn3MHbaAySsNZajqSM0wVRjDzruzCSpmgAdLQAuDgJRNJWtNu1UB8IK9B0mZXc8uIREa56rZH2aSVGtoOhxiyZMo1IIj0un9SHAD5BOVLYb7JFp+TAVd+W2NJcZ11mXzY2QkLkDHquvesdmjPiJWqPOjaLYS8XeMTo9iOGJ1m1iKmKfvnWVEKplfjayGSSyeR+8CA71LJf3fG1bQCHEZ5Ap/TCgCfqArGC938dxGdQrRDIIQzZPFsVvj51hqz2g1abkn19jbtUk3ANPdQIfILQOJYe71x83RpH/HPzYGL3rEmCcj3qCc/BGPcYn/gMUbq03FJlAb96G/H41Pe9i1hO3pE7DaXLN6rKUYa2tUUK6lqZKYqGkoDHM+/7uT9/fLPDOLB+8okcfOughFGDizMldEZ6Rp3G2HRpu+aAXagQIlGI7/51/1jmAUEPKXN/jBmhtqHNdmcqXK5mSZp0ZzBZQCDHDkA6kJEhWSKACyH8T2I6bSjKEbonr5LKLGZCynVjoR6MbIlqYs734lSy2jnqCEpoLIDkfGg6eIHGLk9YKbasVo0MxfUlgsr6zOILTZT8FW3S0fbAeTmkL5h4vJ7hWB3mh+AHViEGq7nSugZAie17uUVdhqLC17ne0lKG5rLVpv9A17LryyAYrltyyYujAEAIoPpTT6z4bL8/DXhsCBaIsvtfhQyskf/JUkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(2906002)(6506007)(52116002)(9686003)(6512007)(186003)(26005)(33716001)(508600001)(6486002)(86362001)(6666004)(1076003)(5660300002)(4744005)(44832011)(8936002)(316002)(33656002)(54906003)(6916009)(4326008)(66476007)(66556008)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?11m62bvdt1PMAfrnkVaWSsi53VrE7QyAJoVSDrdTXgi1urLyn8qjFwP9zEno?=
 =?us-ascii?Q?8cAszpE+d3OICYdrMpGAylfK83ly09I7rg511pCYHXuM0jr7acCB47qwyOrg?=
 =?us-ascii?Q?BHHsSPRl61UT8c9+x3EeK1f4lETrUr9jyEu91BJolMhj46qqo/IpC65cTA1j?=
 =?us-ascii?Q?+5FOM2x77WsGfr6+iEkfR/P+L2dsggLEcSx/QAy0rfk09WEEZGuvcQm1JuxJ?=
 =?us-ascii?Q?HEXj91rwcobQUE8/unjJJ1tzxWCDcn8y6xbjEraeV6OBNMBe4oG7rdnKY13M?=
 =?us-ascii?Q?yHf8tbav9qBGQqgfliEf/0usrkywOw9Q+kGMg7byHyaaPn8GpnOcEqDAsuSk?=
 =?us-ascii?Q?SyZHaEIJWbFWJmOmNTVowcnABZj1uO+qRkdLXz5ueWHOIObMoT2gCeZJ3xYG?=
 =?us-ascii?Q?nCKE7Sg1ZLpORa1/14k8osm/8VuRkEgGw0gCEuAeLS8/TzMWUBVghI3/vbB1?=
 =?us-ascii?Q?xZKiWFaZObz5jSo69/GuzUQwvNweNQRYOVcwCLJdqAVowVQ5XPHfDvxS2O7J?=
 =?us-ascii?Q?idyIhJtGgmevg44v5gp4XWtyfAAOwyEkHGbrAy34F7fXKVpoRs6IZSQllNTS?=
 =?us-ascii?Q?H+Dhe/01GnrJIjWo1bLtQgvTSNKA0N3EtJIlDjYRUcY1RNCXtDjrPKxxEYsQ?=
 =?us-ascii?Q?IJsGldviEkjq2Ocj9135m0phHspM0e+bRIJG9gj3dKbWA1ZIkZ8iaUtCokiF?=
 =?us-ascii?Q?QoMwoyAK5OWpdYaMMJsNwUSwJ4HzabREaQnBLH9y3U4JtIV2ouSoUe5+6nQw?=
 =?us-ascii?Q?U6gdfFVOaZaoY7hQRcpFb2C+hjf7SlUJj5GCd/EMwwb988thjoOEGrap9hR+?=
 =?us-ascii?Q?UW7EVqQd5Y05J/tMvxpdxIc3mRrP5hG9vd6Tbe0vT2vRGb3LFS8N2G+cjPXM?=
 =?us-ascii?Q?beHYI2NxK73NSZcwwebXK2q+5ROrTfynO0ubMmDEFE7FIiC3Dbff7pnzzKq6?=
 =?us-ascii?Q?rvfJrcE6k5/xfoQIZFhKQK5bkqHCeqvMuNyIzbFhW+soZpMxUahVdIDlR5mr?=
 =?us-ascii?Q?HYEPaAyE+TVjk9TD5pPlmTdcPn2gbQl1v5khrxXiWxc2cuX5KVr/R+lrDYpa?=
 =?us-ascii?Q?9emowbb3aR/TutOKr0Zo0bN1KiOUrvZ/UwyQjbwslzkH1IGJxREtt9Uam4Ph?=
 =?us-ascii?Q?tinReCXjjI7ZtPYl0UHBN6HhyOMxMlmpg3PzqWTpkm9c5YTcMANVImjJEmA4?=
 =?us-ascii?Q?Iog4kiuvkkK4xdV42JhwN5UbgKliR2xhl2qAp4/L/ap2ozNrJH5MIfXt+AQe?=
 =?us-ascii?Q?aGZPd3/vAOBJHz4U1Guy7QChnp0GQM6pjHGwVl/jwXRtwqMBWyeANDIIaUX2?=
 =?us-ascii?Q?6MabGAdexZp4V+veFvkuGCu+yMEqpISWZxD44sO/u2v7yPZJcpghiYAJU1HF?=
 =?us-ascii?Q?QC/NvMHxpTSbhP7P3EFhf2FHlHYUj8y11vx+zLnNkAP5uiL5OViQPm4XuRXV?=
 =?us-ascii?Q?Rzsp49C8bKCX2kfnHO2vBAYSiZzXoiOhtf1vm5w42nNjS+MM/kE7Mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6fcabe-4625-4d12-efbb-08da072b9a6d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:01:48.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8xj+rFC1YEtFaUCIxlhVBEo8PFstxmlVx7SLhrfKJFiGfwQ3cJEzl8zp4fu+eI3XfDF4+W2EpHTLindwZdla7d1ND22SLKvUE1c4sXraMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3217
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=782 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160055
X-Proofpoint-GUID: H_j9JupF5NF67cacGYzKBk_waTcnchPD
X-Proofpoint-ORIG-GUID: H_j9JupF5NF67cacGYzKBk_waTcnchPD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:50:41PM +0100, Martin Kaiser wrote:
> The r8188eu driver defines a local BIT(x) macro. Remove this local macro
> and use the one from include/linux/bits.h.
> 
> The global BIT macro returns an unsigned long value. Therefore, we have to
> cast DYNAMIC_BB_DYNAMIC_TXPWR to u32 explicitly. This define is used with
> the bitwise not operator.

It doesn't change run time at all if you leave it as unsigned long.
I don't know if there are static checkers which care, but if there are
then those checkers are wrong.  It's nicer to not have the unnecesary
cast.

Also in the original code the type was int so the negative bit would
have been sign extended if we cast it to unsigned long.

regards,
dan carpenter

