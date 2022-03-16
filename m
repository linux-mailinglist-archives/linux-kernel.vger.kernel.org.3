Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6471B4DB026
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355883AbiCPM4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350067AbiCPM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:56:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985805EBEF;
        Wed, 16 Mar 2022 05:55:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCo7WN003420;
        Wed, 16 Mar 2022 12:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7UmLtQow+fBjrjX5iP2DU5nne3ADcsZqgJA6IKVOKdY=;
 b=inHT6YnEQoAXzPZ322pGBtIVLz0S0dCP8kcxIK0fQw/ufee0zrbaDS/5vBqc7JaNfZYd
 SEqgPnLnaQ9E4uxa9D7SYmV7cQyW5T7vYHbd7YXOgwyucuDuga/8p2vW/2AOVsQcNpuC
 u8z19POh6u/+F+V8Kl7/iR56rMPykO5X0wn2wHsplSGf9lEVdfMSZCdRFtcCY1Cn5z5D
 4uNAdeOpzU5/6a1kazw09pWkpVMoac1dZFoZY9K05W8EKJz1uXEKhkqptLoXQcWM2g7E
 6N/dRrreOwFyaIniV8G0zL3TP1LU4UBMPQvk+fVqhDn7skaXcPNki732oGmLs5o5bwHk /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwnv4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 12:55:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GCovHb134489;
        Wed, 16 Mar 2022 12:55:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3030.oracle.com with ESMTP id 3et65pxt03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 12:55:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0HxEoJcyo5YoAw+KSh24Wlpf4ORjdmtFsO6DWHRHSbAnxsxu67eRZY+G2YoYofO8NH0ANhCxzf6TfFbf/Bb3QfLs5izeaEWpX/XeWZWCV6NxqnJp/Ob1EAGsoVahmWcIViXXoWE1IAVegvrCUQphaDDC/WfmafsoMa9+m36dP0vsFt1/f1N/04BSbt2q4hr7DQhtai16uxou7NB1z6xWUt8CTp3mfT6wOIVlwinYg4Smr7mntgYuukNnX8NwoFkqgtZYAcPMyO2vtJ1DsT3bFh3rK97v6vsagxDv93AcFMNa+fRBDHxaS0b8/3LOvF+PmQwFdgSnB4DeaIq/LIEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UmLtQow+fBjrjX5iP2DU5nne3ADcsZqgJA6IKVOKdY=;
 b=kmH7fnB76RTr7f4eBHknKFijiPYmFFOlyfALpg6TX+8CduG1WDYXxpdOCr4+3UfR/ppAfDKeGchjMJkMUa2bHupVIQAGnEeQ2oGqjDqLaMQ9/DElIMfcInyyb1puen78CHA+OmfSKTfnf07cl+lN79LOgcx59uombkaEeZ1L8DEAMx/SQyrD6hlOnXqnrETMF7gHTL/7ek9uYSiA/rx45+xSpr/Pq6oneoapQoyhIhvGoS4XAwEHC9y9FLPMy+ZlLqHkmMtRiVibKlqdDf+B/8CKmoY2J0CINhI09YN0O77dmwTQbswkyG0rEh/vRR4q39OeZ+af3M8Lv78/jf9jeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UmLtQow+fBjrjX5iP2DU5nne3ADcsZqgJA6IKVOKdY=;
 b=IUEFrElrnEygnK0spQmgWYa7DKpkJ3SaMxpE8iBIAX9C0Xnt9aPvFq2i3VqKIvGrSyqTRGoqDj105v79qRzRHrGIakaHclRBw7BeSt8uDvpDuobVblq4PyO+ErDGEWuk2MKapbZDvAkYxlDTwy9HuYQD5kErXmoMKNk8BQVCjkQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4701.namprd10.prod.outlook.com
 (2603:10b6:a03:2dc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 12:55:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 12:55:10 +0000
Date:   Wed, 16 Mar 2022 15:54:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove the obsolete file entry for staging
 in ANDROID DRIVERS
Message-ID: <20220316125456.GW3293@kadam>
References: <20220316124802.372-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316124802.372-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0004.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae6b3f80-3d3f-4ea6-694f-08da074c33ff
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4701:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4701326839E27FDDE5E7DF9B8E119@SJ0PR10MB4701.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwlM+j7j77xwqsFR3HqfRxH2P7QSuVwuPLI1qHv+FZLFzGNnOdQgg6ESfzVO818vBm1t6q9MPGOwerNQzqgDEiIZ4HFTHzwPzWPqUZQHkaAwocL4iH7drA/8/Urv2SAbwkIB74ASyGe8WbxMJfzOMdntuOB/gInJG0ts/QWZvdkzqz12ks5NDeiAJlOFXJJl3ncq9nHiDVYmebAxlRjkRGyu4Vhux7rYwD7/KuZTUJF7xpN0/4Rc808HXH0bJ70aUGmb16FBvL/kpngpdrQN0prLUPz47WrZiSH4XhSnPsOv+46UWjK5nijzRcyB02k0vX5e75by9Ly76OtzO9ZL9ocEXVMBTLRz01MyXNfWarP8HqMEnAUN/Oj7r7aV71dBDCq6h+u8cMFNvqsftAmyma/oKon+k3FY83dZYNM+O6l78EzQTgh4Hc8P3Yzps0SGK9zwNABS0fECoHHrC+bp6fOYR/+BlM1BXt09gW8FdLuJ6OTbMVUyfEK3J1f+9GVF5KbV3B1KkKAkXE6+c6BL4A2NexSITEBebLG1i9dn407F6Je2bdnfEz1ArtfjnV3RK7Xc+o/BGHh3sVrEC3paXKNCNEUVZHr+6FMO8vWVkOMwAkA5HnYG0YyJLZfGwFp7PjP/Ye0JMghyuBbj72Lewo6rPtvMjrWxyndtOy9x9SzIB34Kcawfu4UbyLLiIS3IakWiGAlx8cuvRd7D/jmMcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(44832011)(558084003)(66946007)(38350700002)(4326008)(8676002)(6916009)(316002)(5660300002)(38100700002)(33716001)(186003)(54906003)(26005)(86362001)(1076003)(2906002)(7416002)(6486002)(8936002)(33656002)(508600001)(52116002)(6512007)(6666004)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1FlusbroSkLISh6RZY5IBghVj4O6Yc4kEY+ECCTBT/d2CEbRpWxxGftBFK8?=
 =?us-ascii?Q?LS/ohJsJhFHHhblxUL8kHiiWWCIv3TSE9OXuOmTCLIuSmvQiskhgvFD2Ea9C?=
 =?us-ascii?Q?qSXbl6OeOyq/851Ooq5bJVatPSpEdRrCQerJrtfJ8xEIeKT5SWrIJ8HExXcv?=
 =?us-ascii?Q?57QX5E9pvshEXlr1F/OLKbC503c1L8UymKkt4sNgq0Uyx554XeaxGQOCrFKu?=
 =?us-ascii?Q?6uxX0UbGIBNDS9C6hJ0joXR2zPE9mP+VSgK6skvMrHhtLZB7kYiTWPs45/P7?=
 =?us-ascii?Q?VviZhDJ+939eIdHMtZIbKW7LGfEG4v0beKFljrRdGt/fyhHARRw4EU/anscO?=
 =?us-ascii?Q?rZLhEtD7l1Vu3kQ8QqLH55UTfpnnQwFfEKEpAhijI35W1s7xyq4yEWnRg1BK?=
 =?us-ascii?Q?Fv5XmX+x770TdKj576ZLqkQzKk3d9TBlIIKKRb8MTbiSppZMCg4CA/eF/Ca9?=
 =?us-ascii?Q?UKLfKhcrEHolFClc08CA5uK8VynaLwghOZkQKNj32TmOhd7C37ehZU4XG0Ft?=
 =?us-ascii?Q?N1i7l0TmvqWSUu50B2KA8+znJSlr6i4ucHW5oHHJ4NvAdSd0lNDoWhnLPR3r?=
 =?us-ascii?Q?CuhqWOKEpjUuq6ebhvsMCkO4QoAnLhzQgW1YtTB2B0Q95GZVE94AWMuUlrk2?=
 =?us-ascii?Q?h/3vSmdRdR0zspnJdIBHs21qiZp1gLjpsK39GfH0Nmh1WTu0amYH4FfDIPio?=
 =?us-ascii?Q?O8meDUeAdFXIM2yH58NKGuMCcVWiMOQmIzf65o8apaCmOA/GBPAB+EfR5u5a?=
 =?us-ascii?Q?GZKrF24ut8TA/EpxS+zhwm/i9B7BZAPAwUVGYvU128MyPLLZ4t1NcCwIHSPG?=
 =?us-ascii?Q?xlyVcm67dmoffgNLOVf5N/bBvyH+RBlOD7BKC7U2cmZITwrafF0S+4Bcncpx?=
 =?us-ascii?Q?LvDMbQCesid4LaoxdAhhMc4lsy29NlodY2eIQNABOm3+3S+54XOsuG5UIbI9?=
 =?us-ascii?Q?XbBaetVNfWKBiFZuLcwrIxdrr+L9z2JkeDyk36pSpZlWdk5NW29fclmx1qi6?=
 =?us-ascii?Q?yxZw4UyekJAdmKRpTT8wUN16qPBrH5T3MOT7Q+PXJiQgCLFne8fiiFEHAAgn?=
 =?us-ascii?Q?DOhL0qT3WXvz47as8KwGeV8YWaBFv4b+4NgRDrOxmTGv962OrCV5O7RAWCiU?=
 =?us-ascii?Q?RyC24gwLgM4GemMYou+SnwNvHX4ZFxT20DeO7aLo1/swuAO+qkkATMlwaTXa?=
 =?us-ascii?Q?3LyAywMlUyaWpcNYWem5Uzy8jQyww8EiGE+XtzQKbaaB14YwekloHeG86NSq?=
 =?us-ascii?Q?VQyzt0l2aqoLHG2hdR7KPLPjQY7+J9qqWXfp4lfXk9hu52zUoVl3cfDRmYQ6?=
 =?us-ascii?Q?u5qVMIv17htdQaoXoY//yETaRe1xvhrAxbV4UfM8PZVb3+ovkeIlfp431y1b?=
 =?us-ascii?Q?1nx5WfeXi2S1EkBgL8KoKOaKbTpBVXW5O95nDMgsxVICjI1ukGThCL0FFEHl?=
 =?us-ascii?Q?ApfNvtaltkSidwO1mXlbHrhrnp5h4D8c5wfZuk0p3SO5RhzvcVEJPg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6b3f80-3d3f-4ea6-694f-08da074c33ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 12:55:10.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvOKxedm3LBpsfpgdjOsbnT1os02kiR4PIMp0J6Gg+fkdUQkb5XGnG/rXsiwPvKU00+QuCRD30J81W2bejqBVSZMVEuqi2/MTcHypFl2Jkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=734 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160080
X-Proofpoint-GUID: r0jhZQMkrEx9b-Rtc_okM27LatgVEqvs
X-Proofpoint-ORIG-GUID: r0jhZQMkrEx9b-Rtc_okM27LatgVEqvs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:48:02PM +0100, Lukas Bulwahn wrote:
> Commit 721412ed3d81 ("staging: remove ashmem") removes the last android
> driver from staging

Hooray!  Well done @android.com folks!  :)

regards,
dan carpenter

