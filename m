Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8C463510
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhK3NHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:07:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49676 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhK3NHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:07:47 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUBmbGW000937;
        Tue, 30 Nov 2021 13:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4yF4zjlXqO4RAmJ0OvNWm1h+F7oUQOrE+OKSR10R4ZI=;
 b=LzL7wY5HP+KzpZFGBl4NjvBS5mFQti09ybIZD/NUPsLf6aAqY+uXA8L4JB/mCgYQXuhs
 ZM8bEMAHyjNhnhdIIRw/UKaPyFM0Rc7V/LP1E9E4Do6SqljkMdZPbPbp0MbST76PQZFf
 aAmk5J9fyjPMK4B4eVnNhlrNHnTnKEYSOP2AJHeCisQ5mtjERhRzm+6FRORKTc0rewI3
 Z5IPk6/VPETnx17vXeTrNNADfuoVz02cNy1XTYp8BE3QE0TGs1w0LU9vjtVv6pCEGZLe
 rgk7Eps3iS/ewTRqdRgbqFtveF4RXxLmjExvX2W2e+gEu0d6EcQStJs5yqwdIaw6uBSk +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt81fpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 13:04:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUD1klR005408;
        Tue, 30 Nov 2021 13:04:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3ck9syfce7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 13:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNFbNT8k2P2bUdRR2KFIbiw4Ug58dXubHjOc26XAqyoyba6DRZ74VBDGO93BG8IwDIILRJJhI12MzqamvILso6uKKqXYbNyJVFIEEWZUODQMVkxs1m3vPnKn1SOPMWorYFxDhSMuomzTXi8LLk8U/D8hc2KpUyclAPHuGjXVQbAC6DsdOEvE+w8ebl/CwF6HKbdOp+hh0OBdBubdqiHZyaIXE3+JH/DmpOR92g+ILKG/H8zlZak07wpcQsLuszAUdRKiyNHxYOppyKaU6T+katPXvssGiOvad5YA+SoX/imrTv8jupzR5iysQrU5LUpnWR6RoZi6yt2rdqIvQZGmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yF4zjlXqO4RAmJ0OvNWm1h+F7oUQOrE+OKSR10R4ZI=;
 b=LH3108SLBTBaicix/McASIv9gaPojdtes54dbrS0KFiQX0ENrNi96Oq+AvZrK7OomUJMpCLin1HG9Z110AnKi23Ia+2oiqOXG3ngZF1y5dAoXanxLgqAygY2VhGebD2hlWa4uyqXcDH80b6YQX4U0uCRHpszQmaHyIjpjgBzTV/+0I0MTdOQs1mk4VP1b4RaMhfTelBBdKpcE618mtPVUBktuIAjt8zHCZG8nBoEGPpsLW8zG+WYTFGy3L9J9f5hLYhaFlGl7eN0HicsBAmhqrXLLTdDcFXUW/t6ZVrFh+MeNTvjOm0N+2csLffJDaM6OlznyEUEekm+r2bnGR6iWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yF4zjlXqO4RAmJ0OvNWm1h+F7oUQOrE+OKSR10R4ZI=;
 b=WoKQeelHCX3ZE+rXPdB4vozj6Hhdj4oJ1Q2VFyKfdh2eHYlk149E0GDbGiKoPhPTDbrKDKTem1pWUnyNC4AdkLbbgJTMYuLvBgqf90zMrzqhQ1cYrqvYzumbYxshs9OPfenfcrPZRj3f0N2RzDvyrij6infvd0ws17LpVqiaSNc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5677.namprd10.prod.outlook.com
 (2603:10b6:303:18b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 13:04:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 13:04:22 +0000
Date:   Tue, 30 Nov 2021 16:04:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Rao Shoaib <rao.shoaib@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: net/unix/af_unix.c:2471 manage_oob() warn: returning freed memory
 'skb'
Message-ID: <202111261743.2W1C2ZA9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 13:04:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2749ac43-5170-4b0a-937e-08d9b401ed83
X-MS-TrafficTypeDiagnostic: MW4PR10MB5677:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5677D61E1C32552B750078F38E679@MW4PR10MB5677.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:92;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yvz45KL73P/q68rdGmG2wb6cRU0HdocQNH3E3IFEzp+ETu6hbXEDz5Kc+ps0rDgGvXKzJiT8y0oBHgjOjn7d2cl7tvvTh6vTMXjMVevoRvE/jjo9IAwio4ub/6xODccSB4F5t9RS9sD/5EAn2QcKsDB3XWlOCcgPrHJC1l2lGlAOaB87xkLkoAi7Gy9WJsnuunVvEe6k35adWLNBMd0ns7Q8PPC8/wMNhxpWnuq7ITq/Y2VAYx72d2K9qY3/SgxZIUq5GKSLyoYRlfrRB+smdDO3muVJHNHcyftFqLLYg4UVwtLk2QTKVd2XN0/2d4JwnsAKvBREufGKOs0jntyo8pFhbba71Zf49slgNXOzYLlpA4YZNygp+arUHKyr5i2clvrPJg3mUweS1fhYDr2zjeqwGnNZuUWUELQ+ZXANIp6ftcGj//brVvFRYSmJZiqQPhWdlfr16oYJnnsE1Z3u22OaIYyUaW1DhO7JOur83in/cSfVRwKGn4i5hmp6RxJVMkVyRvRIURSfpAcwKaptIda+osBYQmW/ZmTn27qT/hpw4EwrNFASSQHQ0pPD6jQOhAAm9xYqkWm7J/lxHBNxn06uL04LwPXP/vw/p7ZU9qx6LOIkcsnPKix/nd5D5YXqf3Zsi/9wfHb/z9FjJQ1L3zhVTf8OPSsZU+cO58aGX9yZufbpxl/bk7fruVpffFbv8/VwpISGG5e3mxZl5xuHm2pxhXFM5fn8CEr82Q+3f7X0WNc/xuJJ5P2KFu6amrp309zFYrlXWyImvZa6YdqvDJXZ8k31BSJZqg9Bo4MMrusL4BQ2rmWfrX1IlW0uloxiRdQu/4lSc5KJLCe8vhDRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(9686003)(966005)(1076003)(6486002)(66556008)(4326008)(36756003)(83380400001)(6636002)(6862004)(8936002)(8676002)(66946007)(6666004)(66476007)(38100700002)(38350700002)(5660300002)(44832011)(2906002)(186003)(6496006)(956004)(316002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QCPGDdD3O0Yc2C3U77n7e5W9+Y4uHXdPweVBN/qL+EWcPu4w4VBbdLejJR0d?=
 =?us-ascii?Q?Dzwp6kc9c6y8O89ItzkpOSZVyVqqySZ7zUFayg29t/y07nnvqIg5LLLBUMGl?=
 =?us-ascii?Q?OZiUDOX5gGX4ksaxuqO3WV9vWyRvsd2wyyRfOvId3OrwoH+CTNdKjAlle7XA?=
 =?us-ascii?Q?DbWSVn3J3lHFAJSDgIxnnEaSSVUGDcp7ubXOdmA+uHZej+S2O37AMZHQ0676?=
 =?us-ascii?Q?fIVpUqRr9qArtUqO0HdzuGF62hKfbe8xyx25y4vnvioJ368GqfKg8LG3eWRc?=
 =?us-ascii?Q?gpZcs/lznkpcbAH9XPm4TLQe0WfIwoQNnFHRVYjR/iMD+4zcvMNdw1i42yln?=
 =?us-ascii?Q?mpMJM8q60g/pQo3s67LnZCIVn3sEKVMSycGdDasE2jnGIrdBQanB2eBnw4ad?=
 =?us-ascii?Q?oLnYrgCfwqzFGDG7KUYd+kU0KGHZYW8aC/xSAMi80RISdBV+8mEH1guBl8q4?=
 =?us-ascii?Q?jNSV6rCIHzTppY0Yk6ciYpq/KI5b+rs0R3FpmZWidjbeevsBYYWHaEiQqSdM?=
 =?us-ascii?Q?eHicwIIfXkhVuemVnF7yFfgFN+bMPCHbnQ/z/NxZ+gPQvb7Ss410jrKtruXr?=
 =?us-ascii?Q?Ecoe2gdPjuezkLSeX22eNwGwi3GFf2F1+788fc3zy2Cc0+hd4N46trBtGbKb?=
 =?us-ascii?Q?n5b40qd9g4Z9vyIzBkFhPguHj91hc1y/N0FduiQYQW59icsuzH6JnIZUjY2a?=
 =?us-ascii?Q?AQk8bk0BaXjmsS+4+xqHxoijZ9UM8n5u5l9mVK1pb+H41sC4BtZzGblghge0?=
 =?us-ascii?Q?y3TeIyuDsnxg66oEcOSRjqIqeTEMaSVcRCi0pS2dvk22sLlldnZMtwyW2H/5?=
 =?us-ascii?Q?qtRa+Dt1c9B8hWxPZSjGcM7YtURaHRPNg4V+1IXzNet9xEAcm5g2sNdyC/n0?=
 =?us-ascii?Q?49BHoFkZ9fTH75pvulF41TsyBn07aF3DPRWBhtUYlCHVpkrBIxbgLgfi6sxD?=
 =?us-ascii?Q?mM2oekVAyFl5JibvEr0QYF9CvuQ7rzDy94H8TT0jsqmH+3BV/0WzTiVUqkZo?=
 =?us-ascii?Q?mKhCnvbxcQ1W4dVY9OCMtizdGN6op/sUm15+HzND+pn+yT6/8z2i9trxHw0B?=
 =?us-ascii?Q?pL9BwHLIfVKZbpuIBGlhOFxnsRD243UfUR8YBfk3pAWfsWEZjuq8OlhNJK32?=
 =?us-ascii?Q?wDgc3fbsajoE1K8TpL2sHSlLwy0DzFgrcR0RLAVJaguIkV6QPCKlMk9OkTa5?=
 =?us-ascii?Q?tZGHfAXF8t0/1gtDlioFvqU5meH+1UPs5sQIwyiqRmaCtwXQrocdCjaLsuqw?=
 =?us-ascii?Q?fDpAQXTQvfPdl7O+1hSKgTclMAymYfjgWJk7u+beyvBmY/y09vOFZSbvMfiV?=
 =?us-ascii?Q?+eG+lilVQgSBcohU4y6kkZfeAkgWe74ZP4eq+2B2SZ8c92N1wdX86vKI7zXV?=
 =?us-ascii?Q?D5ZwyN/2qjZ+IaoPaHqPpoe3PBhY6YNrIv3vFBUuNhzEcVu0QVvJP9Rnilc8?=
 =?us-ascii?Q?nDFiddpaBd40aCn7o52lIKLa6gHhxzTocPrq1k4a2XVYFFx0dW/jQ1ij1LAU?=
 =?us-ascii?Q?Dh8K5/N8vLZtdxK3fPEQp3GEeeq41FHEmN1FR3l/YjfmI+h33DLS/l++Ijd9?=
 =?us-ascii?Q?obh+XyPKSJ1XrbWKEOyW1DvboSzJaqwg2595cEuj7Q2Lc/I+zIKoGV0v6e6z?=
 =?us-ascii?Q?EqIS+HQXSyDlrG/y+aCv9nAug9NvPQza7MuZWlqQ903Q0IRHqBUF8HvTXRgA?=
 =?us-ascii?Q?Md6MM7XccmAMgOh7Mio0SwVXG2g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2749ac43-5170-4b0a-937e-08d9b401ed83
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 13:04:22.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUomTZW/WGlcnf82Ybw3hvbe6Qzj9c3M7CtuyN48J+bJZNek7g/+YA5xCluYp+oPa7LjpTbn03SauJwsAe8jUArlp0zImF7jH3D5YeA2ouA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300075
X-Proofpoint-ORIG-GUID: P2cRWBxaZBNe-uaw-LhVCqG5LhISn-Ol
X-Proofpoint-GUID: P2cRWBxaZBNe-uaw-LhVCqG5LhISn-Ol
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 314001f0bf927015e459c9d387d62a231fe93af3 af_unix: Add OOB support
config: openrisc-randconfig-m031-20211123 (https://download.01.org/0day-ci/archive/20211126/202111261743.2W1C2ZA9-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/unix/af_unix.c:2471 manage_oob() warn: returning freed memory 'skb'

vim +/skb +2471 net/unix/af_unix.c

314001f0bf92701 Rao Shoaib 2021-08-01  2446  static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
314001f0bf92701 Rao Shoaib 2021-08-01  2447  				  int flags, int copied)
314001f0bf92701 Rao Shoaib 2021-08-01  2448  {
314001f0bf92701 Rao Shoaib 2021-08-01  2449  	struct unix_sock *u = unix_sk(sk);
314001f0bf92701 Rao Shoaib 2021-08-01  2450  
314001f0bf92701 Rao Shoaib 2021-08-01  2451  	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
314001f0bf92701 Rao Shoaib 2021-08-01  2452  		skb_unlink(skb, &sk->sk_receive_queue);
314001f0bf92701 Rao Shoaib 2021-08-01  2453  		consume_skb(skb);
314001f0bf92701 Rao Shoaib 2021-08-01  2454  		skb = NULL;
314001f0bf92701 Rao Shoaib 2021-08-01  2455  	} else {
314001f0bf92701 Rao Shoaib 2021-08-01  2456  		if (skb == u->oob_skb) {
314001f0bf92701 Rao Shoaib 2021-08-01  2457  			if (copied) {
314001f0bf92701 Rao Shoaib 2021-08-01  2458  				skb = NULL;
314001f0bf92701 Rao Shoaib 2021-08-01  2459  			} else if (sock_flag(sk, SOCK_URGINLINE)) {
314001f0bf92701 Rao Shoaib 2021-08-01  2460  				if (!(flags & MSG_PEEK)) {
314001f0bf92701 Rao Shoaib 2021-08-01  2461  					u->oob_skb = NULL;
314001f0bf92701 Rao Shoaib 2021-08-01  2462  					consume_skb(skb);

skb = NULL?

314001f0bf92701 Rao Shoaib 2021-08-01  2463  				}
314001f0bf92701 Rao Shoaib 2021-08-01  2464  			} else if (!(flags & MSG_PEEK)) {
314001f0bf92701 Rao Shoaib 2021-08-01  2465  				skb_unlink(skb, &sk->sk_receive_queue);
314001f0bf92701 Rao Shoaib 2021-08-01  2466  				consume_skb(skb);
314001f0bf92701 Rao Shoaib 2021-08-01  2467  				skb = skb_peek(&sk->sk_receive_queue);
314001f0bf92701 Rao Shoaib 2021-08-01  2468  			}
314001f0bf92701 Rao Shoaib 2021-08-01  2469  		}
314001f0bf92701 Rao Shoaib 2021-08-01  2470  	}
314001f0bf92701 Rao Shoaib 2021-08-01 @2471  	return skb;
314001f0bf92701 Rao Shoaib 2021-08-01  2472  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

