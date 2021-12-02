Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45E465DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355588AbhLBFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:42:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48800 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355337AbhLBFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:42:46 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B255wWl032508;
        Thu, 2 Dec 2021 05:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=U//C0WTlgMccFUYBwXEFtPNOwqW1mcxsCpxGvDDuTPY=;
 b=dd+dvvhezXQikpJx7ZuZtJu7nzdm1p+sU73HXhPortbXVAJ3xZmO14QVFW0bymd0EcCM
 oIhJ3A6boieliQnTMMGrLLl4FArMlRVid3Fg0JHU8iYfB8+IKJS2G50FpRyaQsw7i8PZ
 kcZXk1xS4eG/2fsmRsqCsDaVxePRTSdBRgTtf57Yof/xX7/7NkUft1YIudpX3j6E6CJs
 br11fboHyeYNVxxcKlu/oL9bF9+0I3AxwfzHQ6c587xOJey5GyRe5rYXPifi+r7LwY0f
 wl2e5NeCEkgav+CgeTZllDG/Jkwuksme89ThWvplUKJcKfd0YB3WkRJ/yf3YRzHZKNtH Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpb704x2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 05:39:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B25Zncm164474;
        Thu, 2 Dec 2021 05:39:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3cnhvfu7np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 05:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYs2h9Y++7r0KFUQm06SS3SArDL8Lpp3eAT0M/Bnduf9UcWZIaLpqWDf4nQ7CGbhC99QnGdwbd3exuiDB3kempNGVtfybhmrd0mGVDexRY3EYRqS0MV3hv4G9GRti/rUkOZojOpcAHfndOoelqFPiAPmSe9N4AJ7Cxg/wbRwN36XVyTeYfOQTU94hzvWCbNZxernWDi4pN2sq956wO+sLUhsmiNo/gBNSHvmE4qs8dXkM6aKHDlhfCqndezuQ9HE1gXkq9qV+Vfrps/whvSgLhcVwQBOp112G6jcWEBH7Ce2uO9N2TkaT0ja1sWeo4EV3BabUJWJY3mGcFgJjiMMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U//C0WTlgMccFUYBwXEFtPNOwqW1mcxsCpxGvDDuTPY=;
 b=NIDfa8xxb1CcIP9O8nEhVPbfwxXEjV+eduUg2BFgmGH21eI4VNeE/r5sjKb5wlTdU3LeTU8pgwW0GAQovVHf8lpkZQCwB3TUx/gjDNyyoIHHikwJliZKqS1mJcTTwWyBXpTQkOL2apsM86jCyd+7G+hLTuRcIjXsotsdpiaf6EieLl648f3dDzP5eyjONjQnUGuQAY5EXsrgrv6JxrjQdPUdXDNrfAqjXpe2/+swZcN7GgcHFSVHllGkmOrKnPIBOrU5Tqcc/JxXIr523Uqc1S5M9nrkbHuLuxoPW5+hZyWmno1E67NWaiuKb/I9VwR3njW00lkwc4ZDWvLMhB14Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U//C0WTlgMccFUYBwXEFtPNOwqW1mcxsCpxGvDDuTPY=;
 b=BHSEBA366kLfrie3mjCPTCJty/dQp8wnQez/em9DICQaMCHDD8EGPMJUPV9MzM6CvW4C9MbdQHr+/kCOiu05EYuMuoiozPT1ubPfRKl+850/s8JRuFSaD3EIJUQF3MJbLJUOwDlhQXwsc/fC0RCQPxhM5AOS24CseWoPUy56FDc=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5715.namprd10.prod.outlook.com
 (2603:10b6:303:19c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 2 Dec
 2021 05:39:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 05:39:06 +0000
Date:   Thu, 2 Dec 2021 08:38:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, paskripkin@gmail.com
Subject: Re: [PATCH -next v4 0/3] some fix and cleanup for rtl8192e
Message-ID: <20211202053845.GF18178@kadam>
References: <20211202030704.2425621-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202030704.2425621-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Thu, 2 Dec 2021 05:39:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce75364f-c076-440f-58b3-08d9b5560e02
X-MS-TrafficTypeDiagnostic: MW5PR10MB5715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB5715ECA40A1ABF6D4B014FCA8E699@MW5PR10MB5715.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n27npp3k2pKekh/COK38On5UcAbGNsTT/n70NRDKPyXxdFt9W4E3nJrvCKwgEGjU6hi+NgOvA6K+/RdnXAqQk5z2FeLmq/QgP5ncBk3Ie+9nQWpZjs+zYiUoIX7cL3BAY5iPnyZwOHaGoRKYbeT09wVaL/7sxN/V2QyrxdCV2aPJKoCgU4GzLE5Mon5z1AIX84bo03/COuU++YnPggmFbERRdz1iiVZnd4ga/e6lMW6G0TUEDi6tlmHBlKp/8xkPlsJZpcDzVHMV4VtQ2Yqt+WkWf/9Rg7kJBdONzWJu/KaxqF/SqYB8MEDUaj6R86mWO8oilghPINF6a2Oj34HMyKqr/SG4snKDZU65lgcNoAk5f4vaGuKn4oUht5gYlopLSBWmS7Q5v5l4U5aBYmYputK4hN8BHHi2AiliPQvH8T5/fLNcm7gSXcJsD/gQnTQjMDvWf9KOozG5GBC6TMyanNEQkPWMdnxNNMkGa0IlvHESm4XZxNaqAZ09BkoGS/MbSg1K1/MjAmKtbRMasz8THIH/tUe23m6fDxhPOghRZs947hOJ4gLVv4gZJjcpvNoLGqkV82qDQcBRmCfKTxKnWtVoMtsmcWe6ERUujo4FrSjSVgbph8wj6zJxIoIwgL5su0c6MOSha0D6YKx9qe4y5ctfLVuUzDDBKjPoLBlbcg3wLr/MypdGKYOq+0BZYzuy5HYTaKR3Gp/9m2trr7bsfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(44832011)(86362001)(26005)(4744005)(5660300002)(2906002)(6916009)(9576002)(8676002)(508600001)(55016003)(6666004)(66476007)(956004)(1076003)(66556008)(66946007)(8936002)(38100700002)(38350700002)(52116002)(33716001)(33656002)(4326008)(9686003)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43uSHFIRxLPfJnI4eoeoBGPgpnFCBgo5etYW45a5GtZHYlz7599eV+cz5xMK?=
 =?us-ascii?Q?zTXU+VT4bcpoadwvHI2/VR8epIUxWB6ZylAAflFYi9mZRP67UOzCJsmtJc0H?=
 =?us-ascii?Q?/GxIaCFWY6YAnrfs61ECkwQNnupIbhgVBcB4sK+lFE96siAQgnbNqT7jDakr?=
 =?us-ascii?Q?o9cZ9nG9syJneWUdBBb6QiT/K/Ov4sKBlPxs52m4z1YTgkZ3K7Vsf5cvIflD?=
 =?us-ascii?Q?X41pRrQ4wtCrvMymu/GAh/tWpc1KbrfmiMkxZwEZI3pBH/Dh9gIm2GktGGxS?=
 =?us-ascii?Q?3sPNew5gLvPOOgKaF9KY24+tKFO1esDJkuK3wchNP6P9RTJRSctvLi1D9nml?=
 =?us-ascii?Q?MbS7xudyohJb4HnugokI4+gNX0FYZ/5oJ8iXtKwFO1+xcaXH15InhxYWE/Xt?=
 =?us-ascii?Q?36SphKZHM72FRSKrG3yAvYMHXOZnqI7W8WtPEarizD4H/VnVHRukFIKySJru?=
 =?us-ascii?Q?03x9khN+68EH08yVuWNRIk8D0UoGDiqKLjiLkZPF8wMGvwOYGxGwu3/3mszk?=
 =?us-ascii?Q?/JwxmvmZrolp8xT/c/w0+4EMR7Xb8xEmiJ50SdwbM5TKuTL0wCWAmxj4NfTy?=
 =?us-ascii?Q?KEkvvHCAlUNTKe1ikwKARQfDX5KIJ92aE7u29IAilvFYN0yBbEJ7sJemjD7Z?=
 =?us-ascii?Q?67HK8heTucBrmGKR63+jRBmPtUSH6Li08Ll6R9o3lijftrHhaxVX0lNds87w?=
 =?us-ascii?Q?ssj9a9TkBqzgTUE+cNtcKYjp1fx243xSfQIX0ZS0kC/Y1svrpuSIV/Jn3+d2?=
 =?us-ascii?Q?/23WcxDxv2RmnKw/oNyYPKfpzSHPUvVw+Elc5BuCCX6CP8iaJcvVzyDefuvg?=
 =?us-ascii?Q?OPbD+UlicDHaw1T9Jk3OOLv+gKT8A4f+wjgCHpkbFk29o+hiuRbUtIYgcu7G?=
 =?us-ascii?Q?uyj76j0Wndor07rVQNORbZu1ypCSW0Sb46iFiN0jJUOUWL1JXqH/23ocmFmn?=
 =?us-ascii?Q?SEIAjLvnr1fAwnR8r0+FMOinqM5JI+qrm1E8/Fkn1hwgAUG0CrFUXzkeIM2g?=
 =?us-ascii?Q?dUSfQxkVYmhWGVHoimxbGuhAuB4uHP6tqHLZ3KZjT4Jg15Ccl+xle/AXFyOS?=
 =?us-ascii?Q?Iha3FsfTMgSnmHvcHHOsuwgCjWQT6PP8EQ7jCyIV+m+HlzS+cg8BnlTpOAw5?=
 =?us-ascii?Q?Q9yhFIHQnJgcXx8ifAbt4QorXBzSTIttohEd2NYfAgS3zpj00vTPxb7iDEAK?=
 =?us-ascii?Q?t8WuRStCQKXS33d9epbpKM1XxGNsHGbmNeSAmz+uMuUj5gb1lVl7rvO0Ejgu?=
 =?us-ascii?Q?4f1sCrOh7JU6rSBlevcdJaZjgyF1Z/U/s7Xly9l/lMkFlEODyJ6Jg2YoVAW+?=
 =?us-ascii?Q?CpgRZf+K6NL+kq7qbIEELZ14?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce75364f-c076-440f-58b3-08d9b5560e02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 05:39:05.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zklBUyGKvkUlUfYDGXMEO5MsPmV1SKYNVo9VEuNHsHSCmZS9iLAgeL5J9mdA4MoQtrIsXsFGaLESwu/UHE0aezxbIE9x6cKSUaiLasm8p78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5715
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020032
X-Proofpoint-ORIG-GUID: ktsnbQNP3Y7KExujx8hBLiEmiGJu2RFw
X-Proofpoint-GUID: ktsnbQNP3Y7KExujx8hBLiEmiGJu2RFw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:07:01AM +0800, Yang Yingliang wrote:
> v4: Fix crypt_info leak. Add fix tags for patch #1 and #2.
> v3: Fix more leaks.  Break it up into multple patches.
> v2: Make rtllib_softmac_init() return error codes.

Looks good!  Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

