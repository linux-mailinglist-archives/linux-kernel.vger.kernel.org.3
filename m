Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCAA4C5077
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiBYVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiBYVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:18:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5571F0385
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:18:22 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PIijME015749;
        Fri, 25 Feb 2022 21:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dCYL29Z0ovkaiwMJ3i9u9CbYv4M/AeOHSvmjYEwDCWQ=;
 b=Hr/nWM/yF3CcId/zl9kerkM5IYCqDup3lKqLQhPlZ0RJeL+Erwg8v+nWJ8gu83I7RVsF
 JFAlyXvIrL1tbKcuXV6/JTSqKucmILx5DlNEmpUufhPXBjen3wlsK475LKPY14Dn4Wxi
 C+rZ4kUGU47WRHfv/DNvqrvlBHps/o8hsuUCvbp284XHYLkOltZ95ZTeJ9P2oEOBibAY
 bF4b/eHCAj/WM9Zttr4ekyQ4qVIHaa6NpgeFp+EPoWGsfd7oEUMtIn77jMRtKsZ7nLUI
 cIxc8N0L2h+sGOtY4xVY+n/YoNvTjE5aEMo3M8kqHRnX5Lmbm32Hk6loCmT9Xys3jFOb fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef06b1e4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 21:17:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PLG0AM083195;
        Fri, 25 Feb 2022 21:17:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3eanp0qntm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 21:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQTAsjKS9nEFXtIMZQ7mDOuLf2Th0i4agE5C328fMsf957G5rxlgr539RsE4hTcQ4rIu6JH+E4+mJVrwoJQ64MyuJeCACwatCBFgx5OtXJYdGP9z4q5vz2jjk+J0u0Y5vpHtyRUTen9/BWWE7gTm7NoAw9AAOjfui8hWMkYHIUlnAXrmPYR/IbJ64kdrH6vvJHsK3VFjGl5uTj4ONxurS8GKZLVSXhfxpBT7xFK97sjZ1p2sDefXPKRQGO5kdvio9nufsTebMaFGk0wTsl6Sff3OpxGYY8Ma3miFJVnZFSqtZJUODOnpRrUudHwCygofwWnGLnb6O9Ls1IjxbiTVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCYL29Z0ovkaiwMJ3i9u9CbYv4M/AeOHSvmjYEwDCWQ=;
 b=UyMqw/GOG0GwDUjcu1y2t71VQVSXnonF/1cqyfO0VRF4z2Bk3uw5u2ZnD0NsXjqRxUuV4kz2NxwsBaze2MhL67fS/kAuog0L6l5x5LvXru+MdqZix+AWI18fAVRxQK7STS2A4s7PWJbMoDkuooX7MFPHOhKQRZGICd9NjnUpxVt8P/ceacLoXciJXhSBj4yqtj6DnmsMuzaEZ+anJOE6CDC9iiac4/ejR05q1tSEHrQ9Kq/Fk8A07yE2TjkMa/BwSGHqew/LLyiHvs+DcAnPLafLtwJjtt9m1m48Ojsrmw+6bqPF8aEo8x72X4sajF3hgwaZUXC3QSfWgE1NjfaUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCYL29Z0ovkaiwMJ3i9u9CbYv4M/AeOHSvmjYEwDCWQ=;
 b=mOIdKF3VBeR4qyIq/WbX9c2psks1KSpOKXiQ3y7FVtrBTwN67mpBSZNsZ796/ruZonRHF3SlVOXDHTju7ei0Lx0Xs1SxyMdPYtzX51s2bK/oms14UDQeXaRQ0/Z+80c+k0KhKcOVDNaypW4CssjtPdMd05QDz2cJcgqCBFv9Qec=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by MN2PR10MB3920.namprd10.prod.outlook.com (2603:10b6:208:1bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 21:17:44 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::2934:d61e:32ea:5152]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::2934:d61e:32ea:5152%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 21:17:44 +0000
Date:   Fri, 25 Feb 2022 22:17:30 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v2 0/2] x86/boot: Fix setup_indirect support
Message-ID: <20220225211730.2oxumw7ixfe7cyoz@tomti.i.net-space.pl>
References: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645668456-22036-1-git-send-email-ross.philipson@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM6P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::26) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f7b911-4572-4980-7f8b-08d9f8a44388
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB39208A152482E7C72738942EE33E9@MN2PR10MB3920.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCN40aa6e3hGOaw26UPm72aGH4E6xt1L+BCT5GzrIWnmKo5VOSSEZ1hbeKBjg26L2BLDq7nqRd8Rig3bQN2BKx9kHpYIoqZKoQW00ylGUDECtThUHPWfnHpOlBpWJVU76bzekBDuyuXonRYZPiVqY4a8hPMrS9DnRR+Fpo0RLvXNqUz13iYJdSxIsWgrirDdLNhLkphZDXt1OdKA8vbFE6LmizLDvsCjhVysWntA1kn0v3g1/hrEGaV9r4mbNyUCe2Aopo2ES3JNmgVDPsnJtj3eizTShGorYRKXNRebhW310ThR60USPODQnr8/ibAtQcNzMf2GuCdMHuCzQ/itV9TJAxHiD78aXz76UO+5kOCsAopSAV8tFl3yHhglmrWwWZwp1Xzep6O6jzD6YrX+T2VzZeGpyIrIYMx9YE0NyUKaJvVlpaaLQCYqvC2rKtorO0Mb5FFsDujSybkJJ0VZsASHM5g9oRSW6Dyw2A+YrK3G7xHb5DUWdJrVpcgVhsUblSXhhQ35wbqgQXdropavdxeCUmya3m/Em3VKdTyeEsc0tMHg1xZEB6CPGsebQMaO2J2OgTLyI/DjoKv7s43Q/R0YIKHOOQ2vOPflwiy+D3uQAN2wibSg4CWzxs5Y2gpTX3jEbOgchNaQCnVxA0ZSH9Ck5K2woVnxes3uDUVn+HUZWYdydqzJG/PnaPBxvOgzzZIavDF5RmLPCGmGMDpaaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6636002)(6512007)(6506007)(316002)(26005)(6666004)(83380400001)(86362001)(9686003)(52116002)(1076003)(508600001)(6862004)(66476007)(66556008)(7416002)(5660300002)(8936002)(38100700002)(44832011)(2906002)(8676002)(6486002)(4326008)(66946007)(4744005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBiIo5C/46TnS7KnqzOciBBkNXT7hS2LwajRTZMqV60BNN08nKb6/TJG96ca?=
 =?us-ascii?Q?kzdxdrtzD608snxQaDsm8etx945f5a780gVnPQliNK2FvRj0BE5ORvsBAayS?=
 =?us-ascii?Q?THmDUmJBPUYSCNxSXUFBdySArKm1bmK4HpogwDdMdzlnotr0Dxa6ITY8d/zK?=
 =?us-ascii?Q?NVlu/tq8gSNYjUK8/KIuSSlr8G8OBwgp5eMhjSWUm2kAlcXB671IWKHnidlL?=
 =?us-ascii?Q?nUzok6IESQ38qapoDWPjG19b8hnABExGnpdQrFvhxakl+8IMGUude+T0w/zO?=
 =?us-ascii?Q?+Q54PGM3o583bZwY5u6ufA15v5O7Upxqoy1ERwXZzFbaOFDZPat9J1sfGypc?=
 =?us-ascii?Q?q/B2a62ObH1JlxU33ExbOhFTJ25Q1uW75EmcwcX4k9ys7ztD5Zw234uSHroM?=
 =?us-ascii?Q?woqMTZk0/vkjcz2dDxHSAppXG0iPPEXZ5OiQUHlL/F19DuDGMPWveSJdkIwI?=
 =?us-ascii?Q?480M8t58EFWBVk2Izh1ktK2d1rmzZXyxZqq3p6AnfvSWv6vzLteMHWuE+AE5?=
 =?us-ascii?Q?Llr/H3xjNzw14UWMHIg3l5unbhduf/ChKKzd68ZxsukS+dkiR6DOiBfmQhWG?=
 =?us-ascii?Q?47iyLTYlBlbro9VsjRLrQe9FERMnwa6AWOoUbvMh3QCwnutUclcHjHNkCwix?=
 =?us-ascii?Q?0c+zgnuqjm0dpmfMCa9aRGvgb0XlugDU9rH8FT12CSl7711SkDD3JAXmgLeY?=
 =?us-ascii?Q?2YUgdtlya3wHBviIoOcTrqhL4qAZXtsMurpI0rnDBeYEf8nG28wmA32UZ0Ws?=
 =?us-ascii?Q?Pgk1yVsdHFjicqlDxDXpCT0TwWOuNDh/yix8K0QXyJ80RvWMn4bg2WPElffN?=
 =?us-ascii?Q?hTQZf13Acamdmw1RMnYsqxybxLGUGSk4AQk5fg9LjJQc22IbJ9GGusZzCMJb?=
 =?us-ascii?Q?nBmJUZaY+dj1v9XPLRhDtYEFDNLx8IXec/dUcPqIFE6hyX1oHnHfgK5HybZ0?=
 =?us-ascii?Q?aCE43aC+qxOaxVFVOEsa3VTEE7PLlZV2/mLozIn5NaUvZUON71dc7CDkx3T3?=
 =?us-ascii?Q?RiyAlzDzcZJf+S2+4zTEKuKUQlLsvy+pZ+9teisIsaiFCljjuoAG3D51x3Sl?=
 =?us-ascii?Q?xFQAEKzg+SjctQegm2r60xkj72YDHrLAXx4qz706iBr6s9WVkA2MFA3cPKSf?=
 =?us-ascii?Q?MHDakxp6vnORGkFKju1Xm5QBVOt0LuqOgZnMnk8pRujf7LxNfely3tqcsJjD?=
 =?us-ascii?Q?C80J7Zcw46bFIi7cNfTFXGmzVrbwx0VK2V4z3OL7jATeIN/Uoztv6BPDf4wX?=
 =?us-ascii?Q?VUbqtG8CTe9uBn3b+o8eKhoZWHd7IzBzMCehdP9wYhhTlKBWrysoGPaK27ua?=
 =?us-ascii?Q?w1Pa5jKmA9CjTMkcIRLoI+Eu/y4+qitAVCiGHZmNi2AJpkZpk1lF3sKg4OWh?=
 =?us-ascii?Q?zxcazYrR9Ka7Fmxb4kGTsjwcwDIKxBAZQ2YY6JLT4cCRiYnyIgucCEWmvaUy?=
 =?us-ascii?Q?Yxw4MtYb8gua83b+8z1Rm8RKtfxyujcrjXdwdE0R/cX2algzjmgeQ/PaLBat?=
 =?us-ascii?Q?IajJlFjwSRrGXw98UNHHnup7VpqeSnmBQMCRcc1dT2BVZSZOySUxUdNF73DM?=
 =?us-ascii?Q?Igk4IoHhI7VYywVE9ej8C4cNdAtUy8+d3M2eSX/tMoiXBrXEY0e/POYco8SB?=
 =?us-ascii?Q?gYd56AcHNjIABMS65FvIiSo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f7b911-4572-4980-7f8b-08d9f8a44388
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 21:17:44.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr9hbTE4pk76hgopmOoUNxWOtTs8E0209aZtlf8y0isT1tPOKE2VVoIwMxh5XR+bX7UEJWbJyL52x8ShkCY6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10269 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250116
X-Proofpoint-ORIG-GUID: l46smzsTFE6efGV3wjR_w9RfbG5A7rY_
X-Proofpoint-GUID: l46smzsTFE6efGV3wjR_w9RfbG5A7rY_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:07:34PM -0500, Ross Philipson wrote:
> The setup_indirect support for x86 setup_data was added in November
> of 2019. Several issues were found in the implementation and these
> two patches were created to address those issues.
>
> These patches were originally posted as part of the larger TrenchBoot
> patch set but are now being posted separately since they can be merged
> independently of the TrenchBoot work.
>
> Changes in v2:
>  - Add checks and failure modes for when early_memremap and memremap
>    fail.
>  - Fix variable declarations to use reverse fir tree format.
>  - Use local indirect variable and remove all the inline casts.
>  - Misc. fixes to the commit messages.
>
> Ross Philipson (2):
>   x86/boot: Fix memremap of setup_indirect structures
>   x86/boot: Add setup_indirect support in early_memremap_is_setup_data

For both Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>...

Daniel
