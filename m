Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106D4610B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhK2JDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:03:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33180 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233185AbhK2JBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:01:01 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT7XRhS007914;
        Mon, 29 Nov 2021 08:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=yU2OUaT3yByxwUP1TOpdGoyvOOS5RwmBkoviPVYRUgE=;
 b=bnt4UNUQ1rwcWcXq0/P6ZVsyujdXtJ0dHzzH8KbHu3EMnQycn857mdYw9Yhi6MleW9Nz
 KNPHw11ticj2+1UIxn0znyXMwBeDJXyMlEzcPOLx0H6bJWxARgvjikr8xjwvzzUCMQVZ
 vD+t/DfYuHTX5OFYyBUgAeY4iSZlmUkWr4LLd54TFkHTfjltRYZuAcD2VahcmH9DZcj+
 GzWVeKVqn1gPYmhGAGylcxGFI95UlPS100M/bXkaqbQCbuhZ/U76NFg+9aDqSwys6PpT
 Y1OY+EgYgMOY2Fy0HozqEy2LSlXfgrpkqp0Rikl8yjwgKizBppXKWwooYTZKQ2PX4XBR nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7rsed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 08:54:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT8jxKn118363;
        Mon, 29 Nov 2021 08:54:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3cke4kw5e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 08:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhRogCC1SuwGwf7fAstszs6wPuDsU0pt6bh8j9xvyuDHbj/N+u2GdMqE8nODUGrl9TGt/y+nl05Yo85wM9dSjr0fmw+BMsQaoHgsE1rhq00XRmlAfpPKRx9oMNhb52zRLXbOXrYQN5B0C3MjluHSt6ByCZxyEGVqdFWjyOUzE0DJQdgFYG6+xyWauO/5yDoV6m53lPOsB2zhHqz37O4fXxuWzJoi1EV23xn9JjcLG16qpoRC3Zf8fue41V5NbY0OgWsEQ6OHysoW7rWfewXas/KbmI8bFFMYcKfOv+Lk4AcuSX8b1N+fBkLbxQkyo/O5fOeJCg3PhLd18ItELKNt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml/LPRzVw57To+8mciQ6NXkIAeanyF7HObqhne1e6kM=;
 b=NFVYK0ELuRcfbHGxBMg32jy8NleELYphytL15UWcuQFIZRH5N5d8TWIwaN0K4o9EgF6dMOO+qpOtOvQMw5Krf2XotUt+QuzJxo6g/WsVoklIDD4WdTJCshSUT1SOf6eqx2H9TVqyTGfY8h7w4TA/LYjDtAREp9OdAvhXjIuiZjtnGOa0CH1R53xVQy/EUsnnVAhA4LfyyN6J7ieFEKKzZlpGia/W9UoHVOgs2N2ZMKoKx8uErve1fpcbEwSIOwujPOq7W2tCac+fEuEfh4KIwXKZ+QKpTUUAa3uG+WQ328Bfmrx7EFfJfhFbIdq2LGhCL06UZ3QdRKXV+Fx+R0cUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml/LPRzVw57To+8mciQ6NXkIAeanyF7HObqhne1e6kM=;
 b=oR/lmAHyr+yOWVWhgDNsOi33pqgVF5W9wUmSH6cojy4f357gmk/Xnk4ZeYGtuUaTYWHEL2FSBMATPnWHOeKdX89wuN014e5GOsg9KUTaXyRhDySoD+9glZvkmdDiLkAGNKWXyqAxLQ4fK9m+TJ9fU9au4KcU8cUN6pTxPk82MxA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4578.namprd10.prod.outlook.com
 (2603:10b6:303:9e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 08:54:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:54:28 +0000
Date:   Mon, 29 Nov 2021 11:54:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     994605959 <994605959@qq.com>
Cc:     "Rijo-john.Thomas@amd.com" <Rijo-john.Thomas@amd.com>,
        "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "Devaraj.Rangasamy@amd.com" <Devaraj.Rangasamy@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH] tee: amdtee: fix an IS_ERR() vs NULL bug
Message-ID: <20211129085404.GQ18178@kadam>
References: <20211124145404.GE13656@kili>
 <CH0PR12MB5346CA4DBE99A795A1B6CA48CF669@CH0PR12MB5346.namprd12.prod.outlook.com>
 <tencent_F4542B974E00912E031D1999D6D98F8C9006@qq.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_F4542B974E00912E031D1999D6D98F8C9006@qq.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 08:54:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77dfa7aa-2a03-4521-2393-08d9b315da41
X-MS-TrafficTypeDiagnostic: CO1PR10MB4578:
X-Microsoft-Antispam-PRVS: <CO1PR10MB45782B87412F6B8003C8F9748E669@CO1PR10MB4578.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKfxM4XRpE4gQ22ob+f0knBsAglRev3wX+uPQhx37Sg6DuK8B6s48JCcbcl+p0dh+0TOPDl/ehofX86y4lTr87Ct1KS+tOQP4hGOEUqj4K83G9gPXR+JiJovruCQhNU64zZEgbH4cphlzHSdENzoemIPLpRaOX1M4kHdkbWntX24ddP+oMD4JIl090SzyLm3kbD0niM6b/B42XGz8VuRWMWWrAJcik2EVBIet7htyUgg94n3K1YFosRzCcqRTBLAzJVATcy8ZBDTwsZHRUc+097UVgobc1fUOr81YqB0fkQZtOQsizJC9wBs96JHPrLEJG2qgJRpa5ZQ7n0/qjLWCsb+S+prhAeX/0cQVnlhj2/mfdSzSmJrIJGBVEf1cOV88QJcqgXNqp13Kl+p+GHVQy8/m7Yqk0Le3MggpV8lGAUq+X6dTO6ZWEIFUjALoel70EMqaZUMvo8E8qTTXBWamk+MT8tOY88UnOxWW2+rFC48qLAJ51hMpyEbuRK0WPjXuTOKVrJPUXuqH/7TixzblBmrlJNlBSzhatrvgbly5Tk/asceDAhjJvvz7HLcUn/9sriD3/UmVYg/PXafeWFVmQFD8KNibIn2PmV28PWzqj83rrOQpPslitpdBQD4pztyhO+7Xtj2x+35qbhDR5H7Qgi6giuw3fLwtOakEpiAJGZVdfWtoSCDSinrRfq+h5C9sBqOgp5rxeNyqrKMuPPwzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(5660300002)(6496006)(8936002)(55016003)(33656002)(26005)(6916009)(2906002)(66476007)(66556008)(9686003)(66946007)(54906003)(86362001)(186003)(1076003)(6666004)(9576002)(52116002)(4744005)(4326008)(316002)(44832011)(956004)(508600001)(33716001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XOXAbS0z8B9XqdsoJq7mma8hhZILnSVcFOSJ4kC+kT+6qM9MfXxU/HzLI7?=
 =?iso-8859-1?Q?7AbLy1ZzK1po6OpZbP45oaM4hC0zsO6Nt2G/WvHMZZpGmBOc0y5yF4M/CP?=
 =?iso-8859-1?Q?jz7IIB4TszGPXf2p321HTOIQjvnve7fii5IfHmcoEWBzEF5YQVlVLh1pJ0?=
 =?iso-8859-1?Q?Rf+hfRzVCAwn7ZRuSLVpyfZqXI0FWcvckC5eO1YYbyA0aDnns41Bv5jm2m?=
 =?iso-8859-1?Q?+Xr0+t3tdnd/roz78XfQoCszTXaa6HTFJicnkcl3N6CFgxt+gXBAV26Hne?=
 =?iso-8859-1?Q?spcHYYL38DSlBMwa2hPt8zvnZmVZaBRd240rxtVfJR/E9bHO3Xf2EUtseL?=
 =?iso-8859-1?Q?a9Fy+f6NTAfGUZfP90peiWDBCfoTElP9Ahj9c/ph+jOdqjol3kjbhUF9tN?=
 =?iso-8859-1?Q?+9hpRe4opwy9ieI8NU5kwa+YOrEq9EUGByi8Q82Cx9CQ2Wlgpt2t73QSwU?=
 =?iso-8859-1?Q?h2ewcbJf235ZpVx21gT0qpDVUM9/LmARheAgOtUbB4Hm+TukknDhKcWbaE?=
 =?iso-8859-1?Q?5NZnR7LXrTiE9YdtN1slBrRUQ9VgjUMq8B020fkBi3mYCfQ/dZ3TgkmVXX?=
 =?iso-8859-1?Q?5CM8H1yxrAaTgQuibTomlxDeAs0AP+BtAU25gAjS5FBRimPCokS9KrUVfr?=
 =?iso-8859-1?Q?DCRBpBzWqHjPhYQDQWFWrzVpoZTaJ4h3uI65wmEVtE7Vo/FMX3LM60ee9b?=
 =?iso-8859-1?Q?qvyHXo1DYGpIGqtKQ3CtSLC9cJXvzps4/8RhADF44IAzTMB312dy3BfA5H?=
 =?iso-8859-1?Q?cDpLxXkOi9vnBIs1m2Xf0Kwb0Z+RWqknyENGtJ+RnEtIdoHhZisW7Kq7od?=
 =?iso-8859-1?Q?nRZ5lFDxToDPi8Gj4YnhuTNQ97htauwaUWmAPC0KAP8Keq3EXn2F19LkEE?=
 =?iso-8859-1?Q?Rm+9SMfRg0wZzjJyMNKMIrm/h3kXGlLtNMFu1AyDsRsGiSdvuP0EMZm/nH?=
 =?iso-8859-1?Q?imiF07qsORUC7OXEPNIyyteEksjUSkAd4zhZqXfjsoDCKPc70sVTzLYS9R?=
 =?iso-8859-1?Q?csn97TcDZeMRlvdAQq3XbSQEhOaeLmdVEC4E00QGviy7vn9uHU3LvpbMf2?=
 =?iso-8859-1?Q?qOgetxBvOdY75iJMPlVmLAJJ5REhjHE6vM5hGpuGRsOOFWm8D5FDbEuwHp?=
 =?iso-8859-1?Q?8csed3YauaQhE7XojpHHsNtvnKI0fTROF2Bi8jBn8wnsMW25xtU+YOclAz?=
 =?iso-8859-1?Q?pkmm0CMDwKWp771CfPkHa2/QQGfkiqVX12gu/mFDOIzIrjaTc0SZp7skRc?=
 =?iso-8859-1?Q?e3UsnFGeRwwZqaNVcakHY/6gRvjPG0QCTHplyCjETA1VtlR+6ai26coeF7?=
 =?iso-8859-1?Q?Q6z3ZjFIqukvkz4SSoHEH5PPn4/bXJXtPd39EvbySfRuKsSMjjzWzXCFBO?=
 =?iso-8859-1?Q?tBQ0MejEDBueMRt4Hbk00CLYuC2PSLA8PGW/GXXXzA+HIxDM68ao8nqqcU?=
 =?iso-8859-1?Q?aMsZwr8M4FhKveaclDmW3r9Q6z77LxIaDtvOA+D9gIabW8voL/HsCwIclP?=
 =?iso-8859-1?Q?y6crnM1ci/RQxWsAvGJfHzonG0RbOK3fYusoCs4t/a8Kf0Y8E0UMnXIBZp?=
 =?iso-8859-1?Q?ijX0g7oChtESdFc6+3icsuHZMeml/7t/GBnwdkx3Zx3crDcUbwAi2RBeQh?=
 =?iso-8859-1?Q?xTkEHgUosbVGOhW8UYI7QWHlvUJOff1tVlOWYgXn84XnFHDctpgWyL4XC5?=
 =?iso-8859-1?Q?0PzQr1Y8TT9spJovP3SwBfvZGfA2G9NHeAA6kRy3qnlz/r9GnencpzG2Ok?=
 =?iso-8859-1?Q?IMKOjPhyvbin7YY6QvH0Mnogs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dfa7aa-2a03-4521-2393-08d9b315da41
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:54:28.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEmdAUdP63mHeb39tFSlEbKK8D6z7RtQD9seHT7gUr4VZNBTgSVbbJmExRuvLVlzt+mVpTGTBv11juRRH1z5NGOJdFvg5uzhxH9QPBgOJIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290043
X-Proofpoint-ORIG-GUID: eriJz-8fgWuUOZ8M1Wn4s-7_9hS9_GqN
X-Proofpoint-GUID: eriJz-8fgWuUOZ8M1Wn4s-7_9hS9_GqN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 04:31:51PM +0800, 994605959 wrote:
>    maybe try this?
>    -  if (IS_ERR(*ta)) {
>    -    pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
>    -           (u64)*ta);
>    +  if (IS_ERR(ta)) {
>    +    pr_err("%s: get_free_pages failed %p\n", __func__, ta);


No, what you are suggesting is totally wrong.  You are checking the
wrong variable for the wrong thing.

regards,
dan carpenter

