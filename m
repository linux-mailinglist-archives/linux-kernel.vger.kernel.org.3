Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5146E9FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhLIOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:35:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9382 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232090AbhLIOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:34:56 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DtwWT015256;
        Thu, 9 Dec 2021 14:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yiYSzeESQu0tGZK9qHjsQK/qz8p+ptt6QlT2kMFcbtg=;
 b=lx/T4+K6RUtwi81zATaWH5YC8FfKZXN8FUPMFiQCxOPaOhlvt6IdJr5hoLhFn97wK9Q7
 sQaSm03b4XVEAgV6TkDHxBoQdaBAw7BKiE1tWvvqC5qzbUn6aDV+D5QeunmW1NEYbFEe
 FXLS7hLpKyKA4oYGUs9qSXMTbt4vPozUrVr2NORMBteXGmYIQ1PhYllZz4vreTTEGsPV
 tmWuErd3r3h5r0Jl2KrhW945W17/pR8zytqnDvh6EdCT0Nfr84//ctQ2pwxVzl7FUXkL
 ecbNWwumj8G+HGHNAHB2TnbjG6ZbztMgCn0A4wHalbYiT+plwJlS7oyNk7h2f61hDc71 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mubh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:31:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9EBVqr163604;
        Thu, 9 Dec 2021 14:31:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3csc4w9k4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIWTp1S6tToh/cumfM4AP4Ofb5+YenpdfOMbFg8r3YEgllliEweIxc7CetqPB02C6ABBGhKUcAgbwpvXNoM7EpfmmTyh9X1aLXoJj76j0i7+C7GJSiU/TJh5Fr2S5QsunOX9dnA52lNjjzCnkl1081XUeVthBrtnxWFTY4nuHwkU581OgA1+DNxkh9xOOB5xY9loOPIFYp0TAuxMmDt24zbl968o3ELTo2IpjWWor2bG8m8VAH0SaAKkx+5C1F8RevOYnjCsmuggDFkJwCDDBX1gZGhZq5UvZz1lQFRKf920DRLGFSWN7gKVxgCqyk6gN3/+GgE2VIVMfAooWIZMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiYSzeESQu0tGZK9qHjsQK/qz8p+ptt6QlT2kMFcbtg=;
 b=SON5oOAL8hAWg1MHj+kHl2Lg+dOQvljK1DXGDzyeP4QAPn9pnFWo5w33MABGdIVkXUu2tXi8LU9baLLkcl1fMZW4oAqYc9uFOy2R20s2W6EFEar/+MgdCw1l0zC3qvNFSW9+g2MtozIzd1aPZmbtM5kswkdgaC3Ka9Rr50j2g0ZELk0/aJBz4IovUp68u+unLRh/hEqmJHeexvc9erevSWjzb9s0JIJhHchLiawNxAI2kz1LwQQUdr7J+h+1+8LxD5VksUV4GLawtoMsnLEOpRoryP7l23q9opz2Gq3y577EZShNXaiH+RCYVIIP1vKkG+l76/6BnoLKeEO1fVYcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiYSzeESQu0tGZK9qHjsQK/qz8p+ptt6QlT2kMFcbtg=;
 b=rznZMmKMJxR1DesevBHUJkMNV7fq1OrIjw6iMN0vielMinrZiHl0Q19/kV6QTYb1Gx1pet0IW7PC/eeG+UTvQH/YvX4HAHd9ndUau4Jfjp0KwSt2axTfXNN5oqttcRYVEVh9l6rrS+E6B1tHl/FQr7BZdTVI/O617rXS1BNW8Q4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 14:31:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 14:31:07 +0000
Date:   Thu, 9 Dec 2021 17:30:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_QueryDrv()
Message-ID: <20211209143053.GL1956@kadam>
References: <20211209132516.8387-1-niejianglei2021@163.com>
 <20211209132516.8387-2-niejianglei2021@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209132516.8387-2-niejianglei2021@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 14:31:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b21d0a-1556-451c-8651-08d9bb208963
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB13573D76A9EC7A4E8A642EDC8E709@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2ELNSTBSJOfjBzlF7wFhTh0Oh9YMkkKjd+nvzsvEf4XpGJU8W9KWAmedTW2a3L6dPQaGwF5oqUZxnnHPNSqpFYzENII6KGYot8Yp8Ns/GjXDuGDwZ2Ff02NRvTo2zf0C8Ec1/rnjtGH4CvYb3r4Q0kRNalf1HzWpZy2lgjnpvxxh7JuH/Rs031+zEgxnhiVHnRcATo5Gr92iaSTXxoNaDh3r5LyS6qWftVjNIIeXqOqBU6qlNtLlKAE4qG22mp6BnxLd5DzvjsFfnQ11ruChcyVH/VhRYM0FSpUwA8Eo9zqTwM8f61rCnyF6bEyRz9W1yphNtsAy3PGP007XADJu/SZfKYYF0viI3pCKtviS1pZ48n1bUx2++p1KcpcEZvvds3rLWp/sSG9N62GKgwxZf4x00rLCY+O0BKs/ce9dkOse/kS9eQVlYkZy+SdmfRfCVUT2iJ8hhNmECu98dHcOloKlfn4ga9GHWCXf6EsIDyaBRaEBt4Bf4MrC7MRL2B0aofcNZFlRRY3XYzRzXLuI2ghtSSJM2ObCFAH/ehXXRyCAl7aVSQK9xFrB2Berk2upm+/zLPdmziLJkhlu1n5Gqzzp/6FD6pW3QibKKGVwmczYPpySffKUKOkARFwkf06NZuFIAiTJg9dnrshAUsN4DafaJKi435wQ+5OCrM/Hb6ChrNiURgPMRM/P6zZVZGlJt8LI0uzfjQZCxsyE8K+XA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(9686003)(2906002)(508600001)(558084003)(66556008)(4326008)(316002)(38100700002)(9576002)(66476007)(33716001)(1076003)(38350700002)(33656002)(66946007)(8936002)(5660300002)(52116002)(6916009)(4270600006)(6496006)(44832011)(6666004)(86362001)(26005)(19618925003)(55016003)(186003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30si3f8JqnUzRHO7dtnGCeEA/yoeWfodkU7SCeEhve6ZlIS7HS0J1EvBPBqq?=
 =?us-ascii?Q?GbJuY7eOn+PiVaQiY3h2xeLISxwGoIfCkmIE7bfTxabiZRkxO9YZkIHPX0Xe?=
 =?us-ascii?Q?JbQE77ayKfQMo/yAXjo7Xe4kzI/K3poPCmw9RBVebORVpoTrHHkgcWwNBgrA?=
 =?us-ascii?Q?4s1ENxXXkDaakbO63mjoQ+6Pk6q/wh2Pfx5EAjQmSiqY7wHLPH9xFl5XlKlE?=
 =?us-ascii?Q?f5VC92dEjYTf1OALdUaMJklaCRsy9eKwTzvKh9K6HmY2eStROVchdfrbURiZ?=
 =?us-ascii?Q?BHMDHSjDaBGVPnvaAanxYCwJCWR1SiBYDqchXN9czXXQKLMoo3/YgF4Bvkbn?=
 =?us-ascii?Q?PuPjYqYoDv+Pm3/IsBAvZvRma/yOf0zYNWeUfKBKNlfoCwDhPfmBmZrzLznX?=
 =?us-ascii?Q?rdieLEuB7MLPibq9W18UMNxEIAdfq4BlK+Kso7wC3GgTOJKzcBuWohNkohQm?=
 =?us-ascii?Q?X0EcnRmjLNY2f9UNG/TpQH3bPAgmLRzuu+2yiAD7mvnrSzho+3GOvfCMRUhc?=
 =?us-ascii?Q?M6AyDLTpJrtE1vZDaUIPAgfylrA+VrJYG9G39lvfTLdSv6//x4Y74CVNUgdI?=
 =?us-ascii?Q?XW73C9P/HDT05+mbw4frKrnFABfD/QseSGFrXI+nJeI6kUEBKiQypxlKYRQB?=
 =?us-ascii?Q?iJgFWYKkIJ/caI3yV71MriASVJtRj81vveAbRWLFt9qQN7gb/18njUFbsDEc?=
 =?us-ascii?Q?J1HQHnrNNG/gNNwxjuXpMIYdzEutnfOdXmyL4nVmn4Dea31gJ0nE0pUsmBQh?=
 =?us-ascii?Q?abX1+eJmtJwQcNxghLHJUn4FS2hnrxHgUQfDfWYAIY3J9fEw8j/XGW33ThQe?=
 =?us-ascii?Q?azhcKQG4dO+ZrIz092zNLm0wgnxfjz+B2de8Ghz8K4ZqnHbDre6R8vmF1Hsj?=
 =?us-ascii?Q?fRaODf9Va8oVNF84/RnIo0CfzYbqC8/9GgQ570814WCKKaHXdraT0VSpZbuH?=
 =?us-ascii?Q?l6BFQAKXps8zatJHlbeiatuuGWnCM6F/OGo4bXPro4n31NqSmVNHji9Iq6zK?=
 =?us-ascii?Q?ansVXYH819aKnhwyax2y38kX/rwmqsGuXwd9HZOqrih649YWj21hEezr+GMe?=
 =?us-ascii?Q?km4Ym3VocFQW6KbRsuZ8oc1+uytb+h5BYl+uq8P/YbPz2Qo3MwjoB+r7QO6h?=
 =?us-ascii?Q?cl7YxrMtBCeYfBg2FoOHL7CMvCux+jMe0R5o05Lq1U8torD/Ix3oBHBGlDyK?=
 =?us-ascii?Q?JtRo9CtTxt+xOq3cymMwXVVr2V68zJ+8WmQFUbpsRxFzVzfaEg5Zkt7L4WoL?=
 =?us-ascii?Q?Qy/XHZmyw7/7NfJMUwy2N8CQqHP/YXil7vLWpObKbg9cWJo9DxrsCmZfYqrV?=
 =?us-ascii?Q?ttbBLX1wTS8mFugkFjcvPYs61HeVLZOWEq6oTMFRIJ7VfGxWJT3B5vW0wWA7?=
 =?us-ascii?Q?A4yVBnkcydrla/T8mnoE85b4ph4/zpJnk1Eap+Y/920EPCyqyUnQsSg4yHYI?=
 =?us-ascii?Q?VjOmPW6ccg6JsIhYnwT8iyVmR2evkmg+m8Vn8Ef8BTDEzH6LZdPk6f7zsyAK?=
 =?us-ascii?Q?ymtjuEElMxWtWuL//Vj9v9dFzYq7Tcre4Y9GYjJcEYiAPhoM7zQOfAo6b9/d?=
 =?us-ascii?Q?dNMPRceaD8M/RsNEM917XdjRSEyrFGTVYjHTNntF6CNd91TkafrURZlddIZm?=
 =?us-ascii?Q?M+SJOSP9BCZ0Wq15CUHucRLuuZAt8N1TlFHmYinRoxCq8Ry3xl592n/KKTXc?=
 =?us-ascii?Q?qpRjSj2TNVbQLG3M0K2y6MAozfE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b21d0a-1556-451c-8651-08d9bb208963
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:31:07.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv1isPC+gg38jehPJh6PFXX/uypsgBJ9SZATsp2asby+mHiT8hH1Irtm8Ai7rqAJtZbTWj3Ov1wQY0UE4qyW8Pz1qQJ8rFArGlBeROnlQjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=723
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090078
X-Proofpoint-GUID: BmcGw6OSUOWsZl-vax1ElKJeNEiYlcL9
X-Proofpoint-ORIG-GUID: BmcGw6OSUOWsZl-vax1ElKJeNEiYlcL9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is obsolete as well.

regards,
dan carpenter

