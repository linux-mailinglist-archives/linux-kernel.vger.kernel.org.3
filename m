Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825D84D4394
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbiCJJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiCJJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:33:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AF0AB45D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:32:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A7TLUH022893;
        Thu, 10 Mar 2022 09:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=4vxFgs0kjsuiznmAdUXj9tWYvSypGFQJ1xkg5Ja5mZw=;
 b=0OiIhGbTJ0TfpkbnCaFcLr96kWcNNJHCZ7uNEm99l46XYKzvwBGWfKcNYXx6jmUg/Au4
 Umh1VJrZ4DHRKUEDxtz3d0bdGQi6h7qHz+qcMKOLvLVTE9c2QXqXi7f1SoB3vDnCWd++
 zdqZg3dY8yPWX5fhENkMDmTwRFiniOImHEKIJdXT6lc1sgM4tBu0LIzqZM0xDI5vbAeg
 NbxE45FJlxjCKQ0xrD5Uj7atzF1n8SiV5Kov4pZsWJosQNz3wgjzFDzi4tFfvnnCbpZa
 757kcXZlg6SHuIfvWElvLWrN1qvjePqdRN5Z0fWPDBMoI54KuMmjvyILNVPFAJoHO9II wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyrav3w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 09:32:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A9GRIF165837;
        Thu, 10 Mar 2022 09:32:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3030.oracle.com with ESMTP id 3ekvywkcqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 09:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll1C7PeME1HH2/R/l8X0P1b3O6GHZ5U4xjC05Mwv19YZ7p9Yx++KG7huPTpSnoCntgvki+YE0UpOsv7BDyeeWQlw+05OLFuGImpSZOEquN66bQw9BIVht0a/gmBvOtijXumavkWHygAblTw3Nhz2yIhSjrSJAvSttry7VKC+tMAhJPxpV9IXtBqnD4hTvyaTyi4ywyMRUBDeT/y4QmKFquMqyT2zIegVLKb+oYbr85fccoc9dRoclnXyFN+C1CJCJ2Re3TfFIZDzjVSqLiJJKIVnklEQnWNCR6dsAS+eEqe3ZVd08RyAWMXztNQV9w9WBox4mdaS2TALZfT437t2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5RHQ6qb66WBBIiTfKrrSgIW62vI9UlFZEuvHcU+Eyk=;
 b=l0xrEbHjIQThuiqHPhA5SkhMgNo+DdI449Utb6np9+AI3uAEpJWkH04BaEOpSSNDaePG6hc6kXw//Vk52BQI7aPiA0dSbPtbWvYG8O0z4Az/KBQMOLJ/nifJZf9oXXfvpdYPZF/hxZBvuWGtgAYQP96ZrUK9Wb6HibsJeBZQOYiBEXl/b/QE+xyTYkQtSnm9/Gd9BiIKosZ4qq4zBHl3NxV+8tN9eIV4CBd7Npoktd1FN/IPJigmwCOKS2MuJ3oeEmMosZ056uR1p0BY59o+L6ftUMCWrL84SCxLUcRlNh8XACmtWXM1nRN07CjiqZIbjzj02MrRCnjLOpRRhBw73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5RHQ6qb66WBBIiTfKrrSgIW62vI9UlFZEuvHcU+Eyk=;
 b=ufsovkdYrZYvzwOyXu7m8VW74jl9Z1dRUvBPfvYrokSvjFOWCDHLGYXHNdGcQM9j3h1eychjLQCOKNyAHptNsiB+u4QKXyhAS/1HPaKTNub2FePuUvlUoRNbU3qsMcuxy754nipK/ECa/LK4cRb1ad++zqg1k57DUzU8SAdPqNg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4536.namprd10.prod.outlook.com
 (2603:10b6:510:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 09:32:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 09:32:42 +0000
Date:   Thu, 10 Mar 2022 12:32:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
        lkp@intel.com
Cc:     rajur@chelsio.com, kbuild@lists.01.org, lkp@intel.com,
        kbuild-all@lists.01.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: drivers/net/ethernet/chelsio/cxgb4/sge.c:2571
 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'
Message-ID: <20220310093230.GC3315@kadam>
References: <202107070458.FO35EqwU-lkp@intel.com>
 <CACT4ouey2QXf=PJThXG8adrLmCet4Ptu+VDDKBy2hOARqsghXQ@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4ouey2QXf=PJThXG8adrLmCet4Ptu+VDDKBy2hOARqsghXQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9efd8f67-ac2d-4dd3-0fe5-08da0278ed0e
X-MS-TrafficTypeDiagnostic: PH0PR10MB4536:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4536833DF046B81A2E710C8F8E0B9@PH0PR10MB4536.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtiuBQY7rqqMCMb4WHwWQCLb4eD5TzXA8QYTWg+yn3qFetqX11puWKiwYkNW0OiDpxUVBJPYxg3SATsPt7eeu5wglawa/ApXwwzmF6RMpk/Q6HFfhyhsuog0uMcIEobGfNJzMy9Zbhm3Mbwt/sRODlI4iV00PspzDVR7JO4nKq7RPUG8XlM/fkSztLyXr/tHDLBdhmQcaRIP/CmLjweXYeRJjqcEiPrl6qrVSIF9DDDAoWUHa4UH5goX1sxj2GX5zBQbkTbnFNuQNE5Jp3Tbdnz6Zpv8IFuqlSO9toPp+1K45pdzbcdBmnDdhby76PTvbWzUowJHN4sYer9VLMIBx60vlns/PsoN9QKlZmIHeQcT9OJtqHwMesI9i8PhmUGLGkBN358OwK4N0vc96Sh35HiLJ9zlYQ50RIQwPN6BzCatYxTCEKWWE1CXtrJSzEH7xytriPWo/hoNKDDoM2Ie7cM9acqRKguKVGrXsBkwQzzM2f6dqc4FVmJcoMOTKf3YcplnzWTGITNrqJ5VRLkfuUcNw37Bjj3pFCLGnaEFj7hMhXaTorXpmuA9RZCJU2+CWoJ+3Y90nYZbX4yU6MhVUaVQnWvEvAqisQ7vDJHoknGV1h8l9GgtrFj6ufn3rJLaqgEioagTKUOjmHb94SordK+z0jLKU72V3AIBgVQ7pDNmVw6dtzhPqJKiXYg5whrqfD7iQ30qqAXdSXwksoxufR9s12bkg1l2LkAhJnbV7QsSGdC7ypNZW6r3+r6ux6EPfwslWJsdKgiSg+LjUw+JA+r0+KEGP3LZtRr3BhfBrKmUMo2dOuTuipIhumX2RvvLX8rlD+0uaTAwRjjIctKSYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(966005)(186003)(83380400001)(26005)(6486002)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(33716001)(38100700002)(38350700002)(53546011)(6506007)(52116002)(6512007)(9686003)(44832011)(33656002)(2906002)(1076003)(508600001)(5660300002)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2fArtcKwqpmeujC40Z6Kez38cTZl7JCy3yigypDd/FFgi1fflS4kExbARM?=
 =?iso-8859-1?Q?9zv5tProRpgtiSnlex5GSeTvtU43jHUdbQ9fscU/GLjJTmyeQCK9b9hpHs?=
 =?iso-8859-1?Q?NSZEeAcQP4VEXGb/UbqG2VjE9FXJT9TpKztJ6OHrAVX9nSafjZCN5zqYAN?=
 =?iso-8859-1?Q?GZpA/xy9WCwSAcFnrKIP+qCmWYHe8Vh6KxpXG9moe0lnJyv+rGx5vVrhaN?=
 =?iso-8859-1?Q?a4i+aPCl5xpoOEv3A6n9QFqTqzv0tsVgYyB6et5KrZHdal/vvPEuiRbi2Z?=
 =?iso-8859-1?Q?Pic6h3coYnT6wW09cnds9Qg37vv9/+v1r+QehicJ41T2mkydnPXYZ6ZoAI?=
 =?iso-8859-1?Q?GKaR+Hpw/NDtN69Zz0sdh5wOrB6noO9LlW4O/4J3qXuk+tnLsOqDNIaqO1?=
 =?iso-8859-1?Q?SJ8F3QQzvUBUBkyuyNOo3HJ4+cGeJ134KlGyhNOitPg9DldXWDBFdUSkrs?=
 =?iso-8859-1?Q?8G542fPo1SUogbOyX8+NTyvhm7+B5TpRSs1dkpfnGMLglZtnzpTTmTAYya?=
 =?iso-8859-1?Q?yR/VV7ZZc1kbloEC5twRjEDVdb8xgoOtOV+upulejVF6crVSLFCv4/H2yW?=
 =?iso-8859-1?Q?CdLWpw0x15fSchIyc4m+N/4l8LoKQJioX8SsyAqkd6P4i5oNldYTHeEtpU?=
 =?iso-8859-1?Q?VaIKsVt5kFGiglp652nnoAcbfa9NG3Xikvd63/2ROuhVOarX/V3I+vucVa?=
 =?iso-8859-1?Q?XbT/H01hAzY4HDN8SvRFSnq+H5XzCdH3p73fxZ07F8dCHEp1xVdvn4G+2O?=
 =?iso-8859-1?Q?D7T0DKV+ekDWn/tM6LW8YqcvSuRJUBr84u1/xHSNKCcpVViOpMxya9p68w?=
 =?iso-8859-1?Q?v1xMrCDSJhD59DHx4magVXht3D0Dz6D96/+7X0L67ij2hkDvn1uVsHTOYC?=
 =?iso-8859-1?Q?K/dLtVjHkqfzwOWiXnBeHA63aTWI6nBsiR+Ipa64D78JGas9YVDquRfj0Q?=
 =?iso-8859-1?Q?q9jVGS6Lsdx5GeTkMqy8rqUsueyrt7ve6PiXcCWDeGACf1nLquJpMyLstp?=
 =?iso-8859-1?Q?WkwAjgoLpKhl4Eq0qw983QYQVzkFom4jZYXjBuR3uti4YNpnEdqZPOpWKj?=
 =?iso-8859-1?Q?LWtnf1yMk2LFZebRfej0TLBWAx+OiHXbaUSY/9wb2xbMaMcGkLx7CYhrmz?=
 =?iso-8859-1?Q?YATT6JbfUrHVKbt4r1zUqHsvieBpTjxnG63CPwoydoXTvZjvZG/WIzaoju?=
 =?iso-8859-1?Q?iMw8GbqkgE9BV1m1uVJzai/rPBL5sJdwQA9QPmCb8SvjtLvKZrAnTO4l+2?=
 =?iso-8859-1?Q?WBMCH3DychkeL/UQar3qoIyO6FJSu+ec59ejuw94FEcLbvXesZdY+aWOrM?=
 =?iso-8859-1?Q?cVR4TACklYuifSx8nHMdrgUSJjX3Dehk5HhetaMrkX91frP3wcj0N+3Qm2?=
 =?iso-8859-1?Q?3ItGN44GuSCkQfTvb72URdjGyOtdZTQgRqJxeZxt4kGFYvPzwmogzh3V5j?=
 =?iso-8859-1?Q?58kUy9R7kY+GqYQJP9k52ECeXyonXgldx6W+GCY9Y1TXlcC5BOHPEV2WHT?=
 =?iso-8859-1?Q?xR8ld54LurbXlQkwnA5hD0+4FEoxO4sObvIG/BgjN8aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd8f67-ac2d-4dd3-0fe5-08da0278ed0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:32:42.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5MGig8s+wJGJXgXfrGSauE2Xlc2hzbKI5H9XMGLhz3HrmUI4Op2NNu68BY2mwCI6Kkf5oZyLj4YStoER66H23U3nt8ZyqUyYZvWtQWnp1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100049
X-Proofpoint-GUID: tX_6dNe9mvBeboQZYcvibXV22sKNDu_G
X-Proofpoint-ORIG-GUID: tX_6dNe9mvBeboQZYcvibXV22sKNDu_G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:00:58AM +0100, Íñigo Huguet wrote:
> On Wed, Jul 7, 2021 at 9:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   79160a603bdb51916226caf4a6616cc4e1c58a58
> > commit: 52bfcdd87e83d9e69d22da5f26b1512ffc81deed net:CXGB4: fix leak if sk_buff is not used
> > config: x86_64-randconfig-m001-20210706 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > New smatch warnings:
> > drivers/net/ethernet/chelsio/cxgb4/sge.c:2571 cxgb4_ethofld_send_flowc() warn: missing error code 'ret'
> 
> This was already reported here:
> https://lore.kernel.org/all/202107070458.FO35EqwU-lkp@intel.com/ 

To be honest, I saw that it was old, and I did wonder why the kbuild bot
was sending warnings from ancient code.

But at the same time, the code looked suspicious enough that I just
resent instead of investigating.  :P

With kbuild warnings, I always solemnly promise everyone that "These are
a one time email.  Feel free to ignore false positives."  Unfortunately
those promises are just lies to make people happy.

regards,
dan carpenter

