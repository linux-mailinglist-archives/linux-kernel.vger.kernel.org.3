Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E98492905
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiARO7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:59:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18036 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233365AbiARO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:58:59 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IEkcNp032650;
        Tue, 18 Jan 2022 14:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=NI10Owcg+aSbCi5ctkz1SMiUC8irF9Ub9oW7BIryJ8M=;
 b=NBKukZBCpP/nCJRkINoFzV4jJBFM7EriOpARFLGsSPQFTow1Vf8UcyONYTapF6qKeJPY
 7HtVPCvwSBTCaHoYkRnHomMlz4Wi/wSskKxiVnmmTQk9Frxl2cDb8nCPbISVQsgzTD12
 eGfJE0zBaDskNj8q4m9yBY+vVgMf6N2ZYxpNa/4Z+iUFXzO1qVqXJrnlkN8/Cja37FZI
 DHQY8kIHdtRLKcPaQj6R14XaPG6nKFRvTJgwPY/Wgq0+2HcznKHJgzbISxr4ogMDWpYF
 NfdrC+jEw8E4enymLZuQHKl9s4RGtvRpMjIsoMeADG7rkEelqdtJJC+VbMc6WcHpMsas +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc5f22pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 14:58:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IEortH178838;
        Tue, 18 Jan 2022 14:58:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3dkmac2x87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 14:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArlDfaoiS3JrdWq9wtAJeRpsFXtBRu0BVsF0IRRqZHHxiLdJhH+dMt0ANxir9L/c8yDhgLoaQdn2t6yOhFcq1HY4RNefmrYA5MWh6VkweRHSKspmJz4n60vQC8EH4tqAzOl2RwWakmaDFXMJT6qvjfUcGnXKxe1lySvgairMBCHrBpStuOxfWms6KYQuHCROfXMPqJxVkr5Txf5/gmcN6Q6YAuArfa9o+hNCniMuJXux/anaJEzi0aBbsD8N5sUeu+qOsymes+YJmBV74ho/yVA2hmZAJr4+VcghfC39i5O0BOg1m2ajIvWzVjqFB9jJGzcmX8jPK68+8XSZ233UvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI10Owcg+aSbCi5ctkz1SMiUC8irF9Ub9oW7BIryJ8M=;
 b=Matpv2P/cxACvZS6xtQQ2rgZiV1+BncXc4o62VCquYrVd0VTh2Fb9AGBDSkx/R6D7UkFtLvRY1ykeiQ97zg+bRlwNrQOGnsWghDW6rl8IYNT5xWJXmT3opuM7iBkewriKUVsr0jN7Uh9/62nSTaNSrumYu31zblcoFJL0xiUvauY2IuEs+uCrN18vEkhNeNWE6c8hWdCauxZ69gRpZZM7/roREDrklwhF+XU+o3YafdG9cIrMw8Rkkhcm6OZzAOVjWaiKR8BtX9AK6sJZWf4wFRHV73yiu4vH4oqwuZ8hg3JPu/B7Ofnn0FsjEm36HT7h7bOHJuJGB53ETcQ+PQecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI10Owcg+aSbCi5ctkz1SMiUC8irF9Ub9oW7BIryJ8M=;
 b=Bgmuj43j6qSKhBuw2SHSHWyt2U4CkAiw5DZVJP/x+3gSoAzwCCxsyjU6FsrKahHIhezigTBDgPD0nVw7yIRsLdLBZgSWYkFigChDueGMSQzs6bz6GMnNQuhIgwpLtgQJbfmRiJCfjT7HpPm5uTqlM6CdNS/ibsNk3PpRdiqSioY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2816.namprd10.prod.outlook.com
 (2603:10b6:805:d5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 14:58:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 14:58:45 +0000
Date:   Tue, 18 Jan 2022 17:58:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c:101
 visconti_eth_fix_mac_speed() error: uninitialized symbol 'clk_sel_val'.
Message-ID: <202201170216.Q8zMAmz9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62c31e7-6be3-4b41-c349-08d9da93064f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2816:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2816DC863063EE5BEC6DE5408E589@SN6PR10MB2816.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXI5Tuo43JCt5VKvwU14QWRvmdkC9VqHHNoa7N61psXdflBrMH5vFyfkz7xPe5s3tMwFe+GT9tIB0omOHIpXVBEsPPrRDGrW05cyA3dXS0OMiDialqqx+Dt4w9FJQdKbdwU3k6ykAeVGeBfwA53DNOos5oO3AcI0AxXyYxkK+wOXXi2jsA+xA/UbWtkk3nCkopu4j9HjVoRJkqSFTJhaJlKZt63j4gzK8u8XeNwCLs4slb6TBc4xe7SdHR3Q3C4ZHkepbArurow/sXopUgHyqzkz12O5gSjWdiWsiL3BfeXoUx124k0yrx1fqCIPGYEFUcjd3JYVHDwXlWZubYVhcm6WfaqCMNNr4eUBodsqLB6BwMeEc4oJaalQ1TtMvyqs7BM3DMI3Yxy9owAijtjwY7QVLmh1QnEeIhUIHDqujX/+fbrfHKg4RVtOt/RlQJKC3tfWiCaqkOD2pxcrTMs3Qm68QgJelAU7tPBdvfjO/jvJ8uSXNU8coJDe5xr9s0NTK8cbiUYWrfCO7/U8yxLWW3yApYWmYq2+sUChh6TIIuLkiNpFc2sXwItIOED44acJQSQtQeNifFlvqoq33Stq4XfUFDPyKw7BZ0KxuYN9yeb7bf/KCnymOyg+vH8j7af+Z5A1wRxPGyFEa53VHEwECHo/2tRMtDYjjyivgObkh82XJCL2VjXwAEEETYDml/bt1VKz9zquOC4qKgS8xaTAzyiSCPpu19KXjTmZir09Xi2nuWOSM/AmaYdtteWYCxL0e382W6dMHABeH8z3RyCW0Cd/1o5McUDpzVH2pj872B6Oo1laXRQSlztdPr0h3hMyZQh2NSCLhZ8oDKnw2tv89p9dIfU8BdGt9pCgkxlV6v0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(316002)(6666004)(6916009)(52116002)(38350700002)(38100700002)(26005)(2906002)(9686003)(508600001)(8676002)(6486002)(6506007)(966005)(186003)(1076003)(44832011)(4326008)(86362001)(66946007)(36756003)(66476007)(66556008)(6512007)(83380400001)(8936002)(352734003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8rwBla4uK4xTBxsgdTrQ5JBsq0OPD89zSa6iFeSt49Oo+8G4XSoNQi4Kctk?=
 =?us-ascii?Q?5yw1KNa755HAafd2TJbxp1ThmYRru2NvH8koRGqPN0odt0bEgENhlUN+3ayq?=
 =?us-ascii?Q?UOkG451to/2N6GYVOemlf6YaiSp6VrMw6BxcBkqAIGDZgL0n6ltjHeF856QM?=
 =?us-ascii?Q?6vWkcXKaRXfVym4mukoB2FX0H00WB+5rMGAiX5XqKmackQ2NH67RzEyNSjWX?=
 =?us-ascii?Q?fKPDvCWoe97nkfGpLYUB9i4JkoVRI5AVxSA+GHJjtpCrBd0Rak70Ez8h3Eut?=
 =?us-ascii?Q?TmsyhO/4W4vGpbHk10+WdOzCUsv+pUR1C4JU+xI+owZ4FSH3KwenvS1rY9KI?=
 =?us-ascii?Q?Zom4SUwJRQieBHvS/FlYHGJwj/jkJ0ODJxOmlpyGQ80ToL17BW7kwNMGuaPe?=
 =?us-ascii?Q?+yVPO496GYD34SGFhd3PbNe8MsPa8VcXgpMyNnU7OZr9s8k7gq91QNgBd9eq?=
 =?us-ascii?Q?m1PxDOSrC6z5tBcdmfdiLmJTgYGzcLoRON696KwpXVG4+TpRxUl5EjWj64t7?=
 =?us-ascii?Q?aJrK0CDxqiG6EOo2KLiDs+A/u7JDpO6EsugYMw1j0j6moaQIKkLTkUfiMkcI?=
 =?us-ascii?Q?5aBVhWkU2GIMyj1xFm+Gc1PzezERpxuKdX1kaMWWIbgpNPESDPfPhn2GCF9n?=
 =?us-ascii?Q?bTbMbZ+c9JqlVwkLKw3USLaoeYBkZ/U5AtovLeEGbTOHl+HdjqXj0LCgiOAD?=
 =?us-ascii?Q?SV6UAUULsmvTNbB+jbwecTpQ2nt1V4tyJJ96XxbE2xm83DqxZNI974xpK0R8?=
 =?us-ascii?Q?r8CajcnnnloJCPX7sNwdTTwNl8OibclFf8qRA1IL/aq6KHSvUcE2Z5p5F2QX?=
 =?us-ascii?Q?vJzK3FfFtEjUnwMd74lU5FLKsfyphgmUFecHT2kfErMdxrZXTq1K2MjhsofV?=
 =?us-ascii?Q?G5b4K5Ax5fV3iw53RNqBdBmDm0GVtZ/wFXjxqABOPflZfcorf/oqPC4D7Cgu?=
 =?us-ascii?Q?eMR1x0Gv4Zmf4xmicNHa3MHmHR+kezw1vxmvtcUW0YbaI9X4GW3jg+76+oUR?=
 =?us-ascii?Q?dSzoAIXI0UBvJlUssf2SMS3L1t7R5njLxnuuFxS1d2sjYDMqvJ+NuOSbdrU8?=
 =?us-ascii?Q?qjml+wRq41VmYcTfjziKhA8jmifEEt9GOSu5NfFuXhCwnkuL+Km2TD/dvc+o?=
 =?us-ascii?Q?XkN6Def5BuGPn1hpG0KAruETrV9cxp3MlUFnlTMD/VnAYZtZqUTGWF3pW09w?=
 =?us-ascii?Q?XwdU7t5000oewzzFqgvcJ2J8nXn0KQe6tQG6+kMZ4zvqzRFWXKEY8Z8V8Jl6?=
 =?us-ascii?Q?mgxw5k8fD7IBWBVyW8CYGk9AKWXZNNqlEBMbpoz8j0LjYMRGNYcpnILV0eC6?=
 =?us-ascii?Q?6vMXkNPL3CDQ/E6zI3hDe1bjRA5DJ2Gr+GQUQ6lyPh66HqyZCwGpMrSGrMpy?=
 =?us-ascii?Q?ufGody5kd7bXBZXkIjJyphEqyzOD2s3Kg1SOKe6ZE1v03m2fHG7IR50asncC?=
 =?us-ascii?Q?kNjfXX5bOxyJKSf7T4746biPzvRPsQYsun9YElgCZLXcBq8SzOlg9oiLvqgz?=
 =?us-ascii?Q?zkHyvIxHlCWfB0XUAnISiuLbNZH2tXaN2w24R/5mF5BPkYs6z9C07pQGSfao?=
 =?us-ascii?Q?vRoKleAMml4/OJ2E5EGMcSVmFT0+sSX1Iu/c/YQR26LpBZXzu5rtN58xml8P?=
 =?us-ascii?Q?kcjyod39ZdZ9OzJzuxhDsOnTq/b9g1KPdTfy9ICMjutD19TyywRDEgnIq//G?=
 =?us-ascii?Q?PjdWbw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c31e7-6be3-4b41-c349-08d9da93064f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:58:45.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6o5hTFDSpxwQ8i+CeLoxzAuoKw3s1l7AR/C0f5dasAh4M6wtMnA+xaMcDZFJ0Nd5btRUTisf1Iwga9KbnmB8zvkOPYjUc6mHyn/9UdFPFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2816
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180091
X-Proofpoint-GUID: dDEhDXVHQUF3j2NXMh67iNvVJIZLg_NE
X-Proofpoint-ORIG-GUID: dDEhDXVHQUF3j2NXMh67iNvVJIZLg_NE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4d66020dcef83314092f2c8c89152a8d122627e2
commit: b38dd98ff8d0d951770bffdca49b387dc63ba92b net: stmmac: Add Toshiba Visconti SoCs glue driver
config: nios2-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170216.Q8zMAmz9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c:101 visconti_eth_fix_mac_speed() error: uninitialized symbol 'clk_sel_val'.

vim +/clk_sel_val +101 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c

b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   55  static void visconti_eth_fix_mac_speed(void *priv, unsigned int speed)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   56  {
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   57  	struct visconti_eth *dwmac = priv;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   58  	unsigned int val, clk_sel_val;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   59  	unsigned long flags;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   60  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   61  	spin_lock_irqsave(&dwmac->lock, flags);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   62  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   63  	/* adjust link */
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   64  	val = readl(dwmac->reg + MAC_CTRL_REG);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   65  	val &= ~(GMAC_CONFIG_PS | GMAC_CONFIG_FES);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   66  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   67  	switch (speed) {
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   68  	case SPEED_1000:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   69  		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   70  			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_125M;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   71  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   72  	case SPEED_100:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   73  		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   74  			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_25M;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   75  		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   76  			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_2;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   77  		val |= GMAC_CONFIG_PS | GMAC_CONFIG_FES;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   78  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   79  	case SPEED_10:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   80  		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RGMII)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   81  			clk_sel_val = ETHER_CLK_SEL_FREQ_SEL_2P5M;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   82  		if (dwmac->phy_intf_sel == ETHER_CONFIG_INTF_RMII)
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   83  			clk_sel_val = ETHER_CLK_SEL_DIV_SEL_20;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   84  		val |= GMAC_CONFIG_PS;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   85  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   86  	default:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   87  		/* No bit control */

clk_sel_val is not set on the default path

b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   88  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   89  	}
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   90  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   91  	writel(val, dwmac->reg + MAC_CTRL_REG);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   92  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   93  	/* Stop internal clock */
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   94  	val = readl(dwmac->reg + REG_ETHER_CLOCK_SEL);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   95  	val &= ~(ETHER_CLK_SEL_RMII_CLK_EN | ETHER_CLK_SEL_RX_TX_CLK_EN);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   96  	val |= ETHER_CLK_SEL_TX_O_E_N_IN;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   97  	writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   98  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16   99  	switch (dwmac->phy_intf_sel) {
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  100  	case ETHER_CONFIG_INTF_RGMII:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16 @101  		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  102  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  103  	case ETHER_CONFIG_INTF_RMII:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  104  		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_DIV |
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  105  			ETHER_CLK_SEL_TX_CLK_EXT_SEL_TXC | ETHER_CLK_SEL_TX_O_E_N_IN |
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  106  			ETHER_CLK_SEL_RMII_CLK_SEL_RX_C;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  107  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  108  	case ETHER_CONFIG_INTF_MII:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  109  	default:
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  110  		val = clk_sel_val | ETHER_CLK_SEL_RX_CLK_EXT_SEL_RXC |
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  111  			ETHER_CLK_SEL_TX_CLK_EXT_SEL_DIV | ETHER_CLK_SEL_TX_O_E_N_IN |
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  112  			ETHER_CLK_SEL_RMII_CLK_EN;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  113  		break;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  114  	}
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  115  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  116  	/* Start clock */
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  117  	writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  118  	val |= ETHER_CLK_SEL_RX_TX_CLK_EN;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  119  	writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  120  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  121  	val &= ~ETHER_CLK_SEL_TX_O_E_N_IN;
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  122  	writel(val, dwmac->reg + REG_ETHER_CLOCK_SEL);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  123  
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  124  	spin_unlock_irqrestore(&dwmac->lock, flags);
b38dd98ff8d0d9 Nobuhiro Iwamatsu 2021-02-16  125  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

