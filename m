Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F229467554
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379918AbhLCKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:46:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39518 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351878AbhLCKq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:46:27 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B39kWuE004600;
        Fri, 3 Dec 2021 10:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DNqSD55Palia7X3DMKI21JvRXxqU2ZXtasbpyO0hTIw=;
 b=EkNeuJMw+vMnQZXXnduRBGMwylzt5E88CJPvVIUlZqCX1EO/yFGdhUTuI6MFjDOBiCT7
 ad7ucXiU6mK1ku9ptTPJAicTtPsKV8OIhYSEgxTAT7U8k4ztbtZ62uXMtx2Ab2ozPgrN
 UEH37z+/mJb2r+9AXaLlYdKt++LQoIRoeagHs/LNMFn41cJ0HOzF5F5dpqKxIrr/DlpK
 XZ048AvWwqx9Dv2FMn3KAJ81pl+rJ3fg3Rn3Dec8ZvTO79/+O0qXiBsGZtRB7sMy0sy3
 FIfbKA9pu5Rj65NIpldcA9VO6RHDOo3QTHI+kZk5bXF9E9mDwjwwuqKvAN9U22AljyIT Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqgwdr81q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 10:42:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3APmxs086541;
        Fri, 3 Dec 2021 10:42:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3ckaqm3bd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 10:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncd7FRs41YPl1zyqVEHgKZ+pgO6ZZYjnb+PGQOiybC/1MYmYbrFLbRMfrT6mBdHtOIraMldm/ZJHczhNhfeoRLwtlAPZNrILIKW2ijcaJqre3uWEHAYGjWCqKbcSJKnmqea0tgYQa9o4f78+VnA2UVpy99sGLMgkO/7pAsEXUbQYym4WpBOFfTH9uilbnx9eSbBtx4hlhqyHKCAack9zts9pD6Fh3KTnmqLvPm31gYh1IIajEuRiaKQpR9YvXReFNNYuWIADGP8RIejp6XHDjkMS6HyE1vOJ96WYpaxgIRerC9aV6IuP1NvLWqGONaUiQWvzcn8hY1ILY7VFh3g5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNqSD55Palia7X3DMKI21JvRXxqU2ZXtasbpyO0hTIw=;
 b=XXhaXMu0zYrvNY2UW5REssebkcast362sXJ7U6ybDWjBErQOb15KRCgbXZ+6IldJwerDQtDNcUMI9kvWoXIW52vL0AAhtiEtxEwGZypUhVBQ/isS74XXlRDmKn6QP04F7RmMWt/uIltJlTwO7+Dd7SXMQvTECR49KJUMULtoV0Zc9SG73DvYUAxpbukptsWtGI2wU+FqPXUVQKMzNPWjqT9bdlnOqRKkU972j8IRoqEPHlx6hPhk2bOT+PMv+89ChjzPVo8F1UzkeQW0CY4x6FWwEWmFBbkeNYIST9ZXVmL1zUjm7q+Lh6PWoIn0q5X2Am1FEOAGoafwdkh+aEDioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNqSD55Palia7X3DMKI21JvRXxqU2ZXtasbpyO0hTIw=;
 b=bpG8D8s6mj3lH01DcWORfK0OXwg7KOcem1hdQhDa1nJ1ShloSWFyoXvW48rSsp5esmheRz0lT45DQaFWD2t/kCL8AJGX9ECAQoaDZ+GIlvKR3El3MhwXTkXN9XNTdZ3ua/5SeAln/wDlDJ34rCFr9Gv5O96A0oA3YnqI0nuO7H8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4417.namprd10.prod.outlook.com
 (2603:10b6:303:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 10:42:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 10:42:49 +0000
Date:   Fri, 3 Dec 2021 13:42:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, LUU HOAI <hoai.luu.ub@renesas.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [kbuild] [pinchartl-media:drm/du/v3u/sn65dsi86 7/11]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:223 rcar_mipi_dsi_parameters_calc()
 error: buffer overflow 'hsfreqrange_table' 64 <= 64
Message-ID: <202112031631.Op5iw0OJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: AGVJNI5SO3MXMCAI3CWB3HRQBDB6NXPJ
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 3 Dec 2021 10:42:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4df4b0-481e-49de-1160-08d9b649a6c4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:
X-Microsoft-Antispam-PRVS: <CO1PR10MB441707DF27781E1FA2A33FF98E6A9@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS3JbvR7fAhLwy+6eTq5iI7pfn6C4ejBRq3haZzgGnHvZNZagi/qf+ho5rUBMwesEq4GBChyPEgXfkY53e0/6w1alyW+yQLTIsuygyvMfxc3C0UHwj4PrcHFwAf7ugg1btR5LttqhZBOp9pd/yry2ajBz9l/FE535Kj3DUtOydZ+sDU136WjoA/VcMm526K5sF6mg9f1oGSlQz1eQacXtMKJbpnu4OeSpyE+7oqiq1PC5DjS7Yv/WBIL6fL2HR9775slsfUrbAj+eQFA44OY19xd5Camj01t/zRVD3vnE9WRI2fSkPqzE+XaXN2MmXj973iNcTx19Jr52KvFqeElQjtjImlm/TcsjfhZpMXFr6DlwsVu6u1u3lt7UZNRr6LWQ8rf8FOtP3ErTcoD7ybjXe+vZWcsgPAOk2CEu+dYVsILGRuNHAlTxLsrKe3I4Ops59AIVsz8xXXGlmWxmfaOjK1PD1rkvAVQFBJAn38mubNX/gN/kkaC8FMjIx9wGUnJtG6oQcacrPiHFy80Kd77Sisx8P6Lpe5tW+Zj/bn0bzf2thu4Z5LRBuAxN3xC38UM5g50b40qkciIF2EQdN0J1C6/Moq2G0FJG0kznAGF5PMOIA3j8/LhgSmGffUqjFZw7sqEJIvH4ERzxFFmBAMInx/mRTqSmpGFlYEG2VRSXADbyKCzSYbPb2IkktaaHaQSwR4bSgix/G3OZ9fWULj5KezoOE1mKb7ix/jaWLkYWRFgWURlE/bv7s8BDoqMEsnZEXbIxGP124duRRXH7+MbKSy5euyO2SOQxLG1hugdnDo7wAO9dJDSeJ0MyHIPMW6ax+SNsC4rG0MLu2V4qrrj1WHkCgavXlpQjjLhuFfvmD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(86362001)(38350700002)(9686003)(52116002)(54906003)(966005)(6486002)(5660300002)(8676002)(26005)(2906002)(6916009)(44832011)(66946007)(956004)(186003)(8936002)(1076003)(36756003)(6496006)(316002)(83380400001)(66476007)(6666004)(508600001)(66556008)(4326008)(127773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehoizb8sw6Gu0AJZVY4DG85mK8QlHriKE0VtG+QPVJCQcfi0d3/OymwA92Y1?=
 =?us-ascii?Q?jFbOo99c1r5V0a+m3Dq1OZX+nxERCOBAu9hly2wo3RXtgBPf4GsPTTj9aycn?=
 =?us-ascii?Q?F1kzfq5swas2LXMaY42yZdgHgtHcM0mc+pLLYHQvvtmfcUPafDXjAe1/xmve?=
 =?us-ascii?Q?Bz55bUSw6sK+FcFoRJd9ARtjPGuczfn4DvhhUmLfU8kaGmITJjJb3LaAHcpS?=
 =?us-ascii?Q?/xDCM7UE8vQfkpLyZ4TnsCGmOQTI8FDOcvfpo8O8QmbK84OvFQ4W+1ETASla?=
 =?us-ascii?Q?haTO61awtG3enUzKNS29+B3yFxj7lE81p77YH9Jr0hUPQpSyNpNa+uYvcVHP?=
 =?us-ascii?Q?Wh9Qb+D456JH6Qf3FYE+TyCE8tVDp2KqIkwXK7fKK4VePkNBYcHvpIqWuQvF?=
 =?us-ascii?Q?OWF46DOPsvxMs9GxuSAMl7nMxoU51dxoyt2gfGnsoLVlyo8mk+C5kbRQ+MtP?=
 =?us-ascii?Q?m0TrJiaKRvB78a0LtpEtRZwRiuZnv6dP+24fRXgad1hFjnRRumo9cOIEwZHZ?=
 =?us-ascii?Q?4eYAC0UK2x/+Bkh8TyVY+IVs9PjsLFFTLqGV8qafAh6/Ofpn3J7g27FL1nPs?=
 =?us-ascii?Q?T8uJc5gHdg0kibK1xImeqed6JQRZyfI9IclTw5YzCg8nnhFZ2c63IH0TNmAZ?=
 =?us-ascii?Q?p57yyF+s5TwB1Ba5il1353BiR9vwqpJ6wgxgMlON09MhFNXPxk4QkrHknydc?=
 =?us-ascii?Q?XdMqrYY9VVibL7LZpcl3QAhj4+Bq06pYPeegTro6QdrJJ0KIltucW8gRJjbY?=
 =?us-ascii?Q?vYU9aqDdpX1ixMRBkViXFihy/u6C/fLKbvxzm6EUnFGcEPw43Osb71fu/CfN?=
 =?us-ascii?Q?ZHe1mGuWt3yhpfLDoy1lOW3ooGNxstXnvs+5qtt1ydy2YGQwPNK6nzpMqLz7?=
 =?us-ascii?Q?gIZKSjQuXWknWvZSFt7mFTCK2FN1rnqBgNoFrc1Yymwdv9pTK8/FZb5fClzQ?=
 =?us-ascii?Q?eNVZCA2W+gUHJ50MhY/2ID/DIA/WnOMWZMtXGao3im91h6PPOqbNrRmGosb/?=
 =?us-ascii?Q?Uu+l+Mxf9aAs3HCpTDaFggRV4TEl+pvjfLGsJC8F4kT7StofzAGuLZdGpX+w?=
 =?us-ascii?Q?A2U/34ABXXjQ9OD3reCxMICuOGV4sMR9zhFOZsigY6qs5zGZmNQaTDRjxHj4?=
 =?us-ascii?Q?XJ/fRTg8MWmCqHkhCogd0V4OKzhNb7mNbSMxyTFJKzQwKBKfdJp3UTAkh/7r?=
 =?us-ascii?Q?0MnIXaO5GE9MBpmYUTMQgb9l+DMTG++hTEIrhQsydfCVQSbjmWgS1IF3isd7?=
 =?us-ascii?Q?N73qeLVAseEk7DQ6JDp4fCbP7YukKsFWyd0oc6WzOLrzyiA7TGd+03GcSj0h?=
 =?us-ascii?Q?jAHWjfdI2Cg4MfUck8g8X1GKG6Ai2nJazrizZjHrunwdFqB2c41IKH+c91VN?=
 =?us-ascii?Q?SgkCZjJE6nr7UPvMMi3ifBC4paIusTJ7StiGRwAu/L1XG4T+EkmevYDUUR+F?=
 =?us-ascii?Q?bPgnjZLHd6O1vjHjff2Trcoz9cpzStcnu8FFhp8SIOsJB8r2Cgg6foBbGyv8?=
 =?us-ascii?Q?wc/uhmtzjvsZr1jSGzNA5kLfhQVs+TBTYrKAPrlgFqstApK1pFAmHDpD6jEe?=
 =?us-ascii?Q?LCaLqi0SxBF9DgF/Wbs0PaBVzKEh1/DEmAgUT2ujFScJ8WsQAuMig4fJ2YgS?=
 =?us-ascii?Q?2xcvmB+fxPopFHBzQXjrWGV5pVt7YqVRtHIYf62jAsYMzT7kKHjiXZaiV0oj?=
 =?us-ascii?Q?1PnFR5YR4+gQIgoE32y6QRk77Oc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4df4b0-481e-49de-1160-08d9b649a6c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 10:42:49.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYkouaEGKldfp96ZVg5nxa6jYwGGZtGK+T2Y74DyAHzjneyOUNsVrmdjjn/+qCja3o0hjp3DEQSkIqwalHu0rkYjoxzVmm3P+Q/nWEh2i4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030064
X-Proofpoint-GUID: aBPKhH-tUTZVwg5tbqC5nOg5PaBpgZtB
X-Proofpoint-ORIG-GUID: aBPKhH-tUTZVwg5tbqC5nOg5PaBpgZtB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git drm/du/v3u/sn65dsi86
head:   b24450a25b8c342e517f8c5804755b060cd6e7dc
commit: 9315788ce032979d6b3affb603891ec69090be72 [7/11] drm: rcar-du: Add R-Car DSI driver
config: nios2-randconfig-m031-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031631.Op5iw0OJ-lkp@intel.com/config )
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:223 rcar_mipi_dsi_parameters_calc() error: buffer overflow 'hsfreqrange_table' 64 <= 64

Old smatch warnings:
drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:224 rcar_mipi_dsi_parameters_calc() error: buffer overflow 'hsfreqrange_table' 64 <= 64

vim +/hsfreqrange_table +223 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c

9315788ce03297 LUU HOAI 2020-02-25  184  	const struct vco_cntrl_value *vco_cntrl;
9315788ce03297 LUU HOAI 2020-02-25  185  	unsigned long fout_target;
9315788ce03297 LUU HOAI 2020-02-25  186  	unsigned long fin, fout;
9315788ce03297 LUU HOAI 2020-02-25  187  	unsigned long hsfreq;
9315788ce03297 LUU HOAI 2020-02-25  188  	unsigned int best_err = -1;
9315788ce03297 LUU HOAI 2020-02-25  189  	unsigned int divider;
9315788ce03297 LUU HOAI 2020-02-25  190  	unsigned int n;
9315788ce03297 LUU HOAI 2020-02-25  191  	unsigned int i;
9315788ce03297 LUU HOAI 2020-02-25  192  	unsigned int err;
9315788ce03297 LUU HOAI 2020-02-25  193  
9315788ce03297 LUU HOAI 2020-02-25  194  	/*
9315788ce03297 LUU HOAI 2020-02-25  195  	 * Calculate Fout = dot clock * ColorDepth / (2 * Lane Count)
9315788ce03297 LUU HOAI 2020-02-25  196  	 * The range out Fout is [40 - 1250] Mhz
9315788ce03297 LUU HOAI 2020-02-25  197  	 */
9315788ce03297 LUU HOAI 2020-02-25  198  	fout_target = target * mipi_dsi_pixel_format_to_bpp(dsi->format)
9315788ce03297 LUU HOAI 2020-02-25  199  		    / (2 * dsi->lanes);
9315788ce03297 LUU HOAI 2020-02-25  200  	if (fout_target < 40000000 || fout_target > 1250000000)
9315788ce03297 LUU HOAI 2020-02-25  201  		return;
9315788ce03297 LUU HOAI 2020-02-25  202  
9315788ce03297 LUU HOAI 2020-02-25  203  	/* Find vco_cntrl */
9315788ce03297 LUU HOAI 2020-02-25  204  	for (vco_cntrl = vco_cntrl_table; vco_cntrl->min_freq != 0; vco_cntrl++) {
9315788ce03297 LUU HOAI 2020-02-25  205  		if (fout_target > vco_cntrl->min_freq &&
9315788ce03297 LUU HOAI 2020-02-25  206  		    fout_target <= vco_cntrl->max_freq) {
9315788ce03297 LUU HOAI 2020-02-25  207  			setup_info->vco_cntrl = vco_cntrl->value;
9315788ce03297 LUU HOAI 2020-02-25  208  			if (fout_target >= 1150000000)
9315788ce03297 LUU HOAI 2020-02-25  209  				setup_info->prop_cntrl = 0x0c;
9315788ce03297 LUU HOAI 2020-02-25  210  			else
9315788ce03297 LUU HOAI 2020-02-25  211  				setup_info->prop_cntrl = 0x0b;
9315788ce03297 LUU HOAI 2020-02-25  212  			break;
9315788ce03297 LUU HOAI 2020-02-25  213  		}
9315788ce03297 LUU HOAI 2020-02-25  214  	}
9315788ce03297 LUU HOAI 2020-02-25  215  
9315788ce03297 LUU HOAI 2020-02-25  216  	/* Add divider */
9315788ce03297 LUU HOAI 2020-02-25  217  	setup_info->div = (setup_info->vco_cntrl & 0x30) >> 4;
9315788ce03297 LUU HOAI 2020-02-25  218  
9315788ce03297 LUU HOAI 2020-02-25  219  	/* Find hsfreqrange */
9315788ce03297 LUU HOAI 2020-02-25  220  	hsfreq = fout_target * 2;
9315788ce03297 LUU HOAI 2020-02-25  221  	for (i = 0; i < ARRAY_SIZE(hsfreqrange_table); i++) {
9315788ce03297 LUU HOAI 2020-02-25  222  		if (hsfreq > hsfreqrange_table[i][0] &&
9315788ce03297 LUU HOAI 2020-02-25 @223  			hsfreq <= hsfreqrange_table[i+1][0]) {

i+1 can read outside the array bounds.  The hsfreqrange_table[] array
has a sentinal but it's not ever used.  Maybe there was supposed to be
an "if (!hsfreqrange_table[i][0]) break;"?

9315788ce03297 LUU HOAI 2020-02-25  224  			setup_info->hsfreqrange = hsfreqrange_table[i+1][1];
9315788ce03297 LUU HOAI 2020-02-25  225  			break;
9315788ce03297 LUU HOAI 2020-02-25  226  		}
9315788ce03297 LUU HOAI 2020-02-25  227  	}
9315788ce03297 LUU HOAI 2020-02-25  228  
9315788ce03297 LUU HOAI 2020-02-25  229  	/*
9315788ce03297 LUU HOAI 2020-02-25  230  	 * Calculate n and m for PLL clock
9315788ce03297 LUU HOAI 2020-02-25  231  	 * Following the HW manual the ranges of n and m are
9315788ce03297 LUU HOAI 2020-02-25  232  	 * n = [3-8] and m = [64-625]
9315788ce03297 LUU HOAI 2020-02-25  233  	 */
9315788ce03297 LUU HOAI 2020-02-25  234  	fin = clk_get_rate(clk);
9315788ce03297 LUU HOAI 2020-02-25  235  	divider = 1 << setup_info->div;
9315788ce03297 LUU HOAI 2020-02-25  236  	for (n = 3; n < 9; n++) {
9315788ce03297 LUU HOAI 2020-02-25  237  		unsigned long fpfd;
9315788ce03297 LUU HOAI 2020-02-25  238  		unsigned int m;
9315788ce03297 LUU HOAI 2020-02-25  239  
9315788ce03297 LUU HOAI 2020-02-25  240  		fpfd = fin / n;
9315788ce03297 LUU HOAI 2020-02-25  241  
9315788ce03297 LUU HOAI 2020-02-25  242  		for (m = 64; m < 626; m++) {
9315788ce03297 LUU HOAI 2020-02-25  243  			fout = fpfd * m / divider;
9315788ce03297 LUU HOAI 2020-02-25  244  			err = abs((long)(fout - fout_target) * 10000 /
9315788ce03297 LUU HOAI 2020-02-25  245  				  (long)fout_target);
9315788ce03297 LUU HOAI 2020-02-25  246  			if (err < best_err) {
9315788ce03297 LUU HOAI 2020-02-25  247  				setup_info->m = m - 2;
9315788ce03297 LUU HOAI 2020-02-25  248  				setup_info->n = n - 1;
9315788ce03297 LUU HOAI 2020-02-25  249  				setup_info->fout = fout;
9315788ce03297 LUU HOAI 2020-02-25  250  				best_err = err;
9315788ce03297 LUU HOAI 2020-02-25  251  				if (err == 0)
9315788ce03297 LUU HOAI 2020-02-25  252  					goto done;
9315788ce03297 LUU HOAI 2020-02-25  253  			}
9315788ce03297 LUU HOAI 2020-02-25  254  		}
9315788ce03297 LUU HOAI 2020-02-25  255  	}
9315788ce03297 LUU HOAI 2020-02-25  256  
9315788ce03297 LUU HOAI 2020-02-25  257  done:
9315788ce03297 LUU HOAI 2020-02-25  258  	dev_dbg(dsi->dev,
9315788ce03297 LUU HOAI 2020-02-25  259  		"%pC %lu Hz -> Fout %lu Hz (target %lu Hz, error %d.%02u%%), PLL M/N/DIV %u/%u/%u\n",
9315788ce03297 LUU HOAI 2020-02-25  260  		clk, fin, setup_info->fout, fout_target, best_err / 100,
9315788ce03297 LUU HOAI 2020-02-25  261  		best_err % 100, setup_info->m, setup_info->n, setup_info->div);
9315788ce03297 LUU HOAI 2020-02-25  262  	dev_dbg(dsi->dev,
9315788ce03297 LUU HOAI 2020-02-25  263  		"vco_cntrl = 0x%x\tprop_cntrl = 0x%x\thsfreqrange = 0x%x\n",
9315788ce03297 LUU HOAI 2020-02-25  264  		setup_info->vco_cntrl, setup_info->prop_cntrl,
9315788ce03297 LUU HOAI 2020-02-25  265  		setup_info->hsfreqrange);
9315788ce03297 LUU HOAI 2020-02-25  266  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

