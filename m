Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5394B27E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348718AbiBKO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:29:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiBKO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:29:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0F2C7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:29:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BB6SCW023170;
        Fri, 11 Feb 2022 14:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lCQJkgYmoqyNT7OuWclsqfWTGSoPpKUEsQ8N1o0cRoc=;
 b=CfykCDGecBVqj9E5jnXeUko9qjxk2x0Gx7YwIKqsJmNVQ6uYqr4Mp+n/UjHshPxTYjQk
 fP4eLrDmvrZszP15GzkuU/WAt+Ip2XRkN2tY1gvByQc+3GNdgrN2i7VAq2lTubpFtMYS
 tStwClL8mh9VBP47mDWg1jdOhfoR6YLhMurS0wnxqdcaDZs6RoPBKePTS7gDgAvDO27B
 rD2AGg4Ij6fI8HzkX4K6KnuM2jqADWFm83DFu1KVkuaeSLR3TCBfE4aH4k5cJN4m7jC5
 QJ7eMY0EFLmloYk0dqu/DX47wnNeNnSIZOYFk3txCC4l8ItO8BKZ/kDhQFeEJEavNiBT bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5pmv8c35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:29:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BEFhMu128883;
        Fri, 11 Feb 2022 14:29:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3e1h2cdmb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUUfSeg86KluaB9/XTrrVso0qHMWQW2z1XxvYahL5VsuNJFQAH49kAn2Jtk7zU+NlG6bLazCMj8ynD3HrIm7/9lkTSeTQlkkrfFTzatEXPAQwQYKed4H7GeM9hBsSd0GQOUi+iJZfwnw6cgBV4Bdz1N3d3AfzPRp2Of5/H+IUOPQU15T1Mmpqj7nnSKM4VdZ8FlRIVPyVxkF/EBBTjfTgmOF8Fab9jCFdoJL7Tw59n95Z8JoV3XE/08ikKe3XHQ0hFjdgpVpAa6HZ4y72kNmE23mnh6/ESMTB04W0FmU+dyeTqBglarulBctbRRLcLQZhytTRUmm8IY3MIUSd4ovfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQJkgYmoqyNT7OuWclsqfWTGSoPpKUEsQ8N1o0cRoc=;
 b=IyV4m9GuIa0z00Y7YpW3P1C2iTuA7OH1yMqyZXPz93THq9dIYbrDE0vonhflOmqDWUt0Svdy82BhAE9gDDtLqcTyBD1f0vm/jltXqrcGnjNgjdF30GOiugLUTzMPEa61o6gO4ApCdlIjSTNs33Zxm0zdjSTwrNzlmO/AgIK0O8dqNSipoNhqB33v93+gDlETDxr3+aVTKyPZ03UBmpqRDSPoYDR1TmpkjvAheKcmHjIyGPJDkyq2CS2vRz3hpxRSpqnbiM9euvuxW94W76yVnAZ9MMgJ/4wKvBuwo+WwcjZA2oKyAXtcRO7G+QRXpEeFxSVXfZ3jc8L2eZ05VfzqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCQJkgYmoqyNT7OuWclsqfWTGSoPpKUEsQ8N1o0cRoc=;
 b=QLGMAl6t62bMzHTG2eHXmLjO32URY8nPmO6vZLFFKO7pfsTIje4yv8MPsBbPQRwDsvMlwosv89du2W7rxpWpQtukNzgD3anuGTmP4zpF8mzdqoIRlb/jGGPOm7Vq5S2bIwoUv3lRnb26gWXhJitrP8ZcGintYa6TKz9IyfH9xqs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4114.namprd10.prod.outlook.com
 (2603:10b6:a03:211::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 14:29:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 14:29:42 +0000
Date:   Fri, 11 Feb 2022 17:29:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tsukasa OI <research_trasio@irq.a4lg.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [atishp04:isa_framework 3/8] arch/riscv/kernel/cpufeature.c:153
 riscv_fill_hwcap() error: uninitialized symbol 'ext_long'.
Message-ID: <202202111616.z7nZoKYj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc63b11d-55d0-42d0-26ea-08d9ed6af144
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41149A8A43F0832BC0BC769C8E309@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:217;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZluhZrIFJhoS0dUvVWjYL+q7TGQPKXisx3yEmoNeM7epv9RQ+haCQaTcvJaRn6ZLOuka3xxbRXkta0eo+fOROWsPiQDjUzSsOpGLCyplfB9bwClNmQ/O3akLgUgrH8Xmkogg3YRlECLBfVEwxQjf+v4RIP/XM+u2fyvjjykwfWAutsRztbZlG8UTocQL0/MMUMjki9l6qmzDS2Lnhz3hLXpP5Y+GhIPuBPSqVy8DBRc6/Jey/9zwwLFlUcuqe3hblyi74z2qeqWiZbsntytAHdzTYnQu+4n5pgcaOVQMiGMfw6h5IWITuIwE9hDBXieAMZbBHwqVXUeA8QqLK2LT1FTuC5Att0F0SObfOGuuchCa8lq/6GakG96jK+e+57SDwItNh0NGCFdCLyHPOoyLhusoZMtLGp7QHS4tn8QFtEv6rVGVByqmzyusJfk7S4TKCossH2+N/DXaytT60vyfPhMqlLLvaK/Cr/17TKKXhBQC1mI9ll5aX6WxgqtnPcGQRTam7cRiaX6RLYaZDDdTYAwf1//ZGQFhUehLMu9gdPNk5JIWyWbtUzzjU18SIVuiP2XR/Kunw8QpKlghj125DMZRpYllZhUI/SwU/izLylTrACjXHJprEkfnbZFzdU3D6lVUpcTaCQWUyzQuI8LolbSWTFyL3xgS1ZBxRx2yFsVBWWjyL1xQWgKIoA/i3nA1je3wL4NqKqDGo0GAIpwZZrHAjStZ2ZZCLjVeUOjYrfT+XcgMFhB/7xaiFn1JMFOWOxCj1+YsIN/jNLfpNkzn8BwbETyS897B41dkvxH+4wkGaj4HWM2+wQuUi4YExEUz/I/AzLEphBdUIruwBImAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(44832011)(36756003)(966005)(508600001)(1076003)(6486002)(6666004)(5660300002)(2906002)(9686003)(26005)(66946007)(4326008)(8676002)(54906003)(66556008)(6916009)(8936002)(6512007)(186003)(66476007)(316002)(38350700002)(38100700002)(86362001)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m570GlOTgjWCPfi7MfAvuABx0tFqj2Zrd2+stP6cKpkz7ZT5dMUFsvytdlZr?=
 =?us-ascii?Q?XlNF5e8UlaEoXZIEzYTswkSwYEASmCZcXtbPOKlA02bXyR7Ag5fh3Ef7Z6PS?=
 =?us-ascii?Q?Szfsl/PnQkUgduUxhPiY7hhPusypaPVu0rzB2IhZIHZk0Kfz073q8gh4V3Gn?=
 =?us-ascii?Q?QslAPF2dB7xw9IlVUD7rVeT8Ht1EyBcPDw4a3E6H6av1bAktk3GETPKWxDkh?=
 =?us-ascii?Q?XJlGWR9MFJmM+73QMitsDsij9eEy8nUTyd5vZTQLjVsN8MKQrYm7ZuOj4DdV?=
 =?us-ascii?Q?WKJmpt4PNQ1Qd46R2/PKpKpI5YdQ2jAh9EyYtvCjzMM7mrF5prbvKE0Sp3FV?=
 =?us-ascii?Q?LGRYpndyQpzy/luWmOpg4Gj1d6GxFXqRNj/KpeKhJcTDRQJd/nhYHjR3GAw+?=
 =?us-ascii?Q?VIEgCehcSY0QUlFfp75j+x6Y1Hq+T3eTepHVzN6JDYVBNEI/yyb0l8i2pAHL?=
 =?us-ascii?Q?H19DN16VSOnYVAQ738Hm1oQVEHpfcl+Nr5Nte/yVFWIA2Ohv0E1eP21pYVZU?=
 =?us-ascii?Q?5AnaS4sBxJjb31KtVSTeAQb2dJWbbzY3IPgOh7KMJj6vD0Rf5sYRse1b+oHB?=
 =?us-ascii?Q?21FCVICQfpu9XzxpUw0crzG15VqEea/y4KdIw5Nj2Bv0F+hu1W9xX2Nebq+m?=
 =?us-ascii?Q?aGNctJooWFEmslZS8dtNehge5CuFwywWzvnrxhlDVa739mbleke6Ve2hzOK3?=
 =?us-ascii?Q?i/oJYlxf9Iws8TNOHZoP1N2tkgpIBCUaS59U7yKDqeyiRB6BIH8WR1aea27Z?=
 =?us-ascii?Q?EiySDeLlI/oi/p94Gq5STV/23KrpVQj3DNCOC1DG5+Yubqe6GtiDwUFCBPpz?=
 =?us-ascii?Q?jYtSLPr/AwbZs4PZi/nstuU3cbh0tldPvXLtDd8GtiNv9IuHMMgRuEydnfEA?=
 =?us-ascii?Q?4aoN1d91xF1MFkGlhVVqZfyaeHfq4fYV6SDQ0ax+6Gd4x1wyN5MZ0wQ8zZjW?=
 =?us-ascii?Q?hvsp2JL0DlGwqStcfeAT/EPr9/GqqFQ1455xlJH418YD72iZLOTdASQxKiOm?=
 =?us-ascii?Q?HIZ7uYhAc0EQxIgyRwSeH6rTqERVJ592QfilqhYCqJ2n9xpuh3TljQHOWTr2?=
 =?us-ascii?Q?zY7BrV8a3ZTLn5U9l5G8SaPvRPzo6DYvA+WKuOvBsJvR9DpmDwsQr2LukjGg?=
 =?us-ascii?Q?BKc9nmohlnZca+Sqzkx+ymheEI5s3kzKYCknrsFbj79U+tgkuBzvbiB1AslA?=
 =?us-ascii?Q?1IhCVktGJ7/PU5/PR/gU4h6Ltx018T46PGmtFT5jB7GJiIbaog1mMrtZpf4t?=
 =?us-ascii?Q?7G9XPJG7RvDiBoVeL3SN2nScBmbrlYYpoiPJfA14IWetW4ZiW21yj1G3STus?=
 =?us-ascii?Q?LUbdyaNGQBLwRXyLD8TDyNCo85+7XSaB5PT+ca94TbFdfFdyXnEM1v4w7Mnb?=
 =?us-ascii?Q?JNKcfWn2+zWD7zI1muq39msfU1cy9D38ihRnQGEHNyLcuAAXXp//U62fu3e7?=
 =?us-ascii?Q?K9cIENH37ZNXFgmpwOe+lJR76Na5MNUHrbkZyXtrVsmd1xD7lebNxsbTx3KT?=
 =?us-ascii?Q?l9Ay/Qbe76VOAKfv4h+fWWFoC5iFg6SXIBezxx7OF7264xvIEpDsG3t8TqXR?=
 =?us-ascii?Q?JW8hcGb5DHCWxnFJuAkA5JD6wRVNiQM4tQFrp/skmEvk8WUSZN1kKpaivlDh?=
 =?us-ascii?Q?hg7Qnm8i9H/mx9DgC8Aei+sefbpazevq3r19dtaXPaopyYUYPPOqrXPv4wiW?=
 =?us-ascii?Q?h0wQTA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc63b11d-55d0-42d0-26ea-08d9ed6af144
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:29:42.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V1TEHuP8AffZPrWUwCPXbD+gJP7OvRh/Cer7SJIjp8uVu1M3JiCZwnOf7LhvMOj2MprH40iOaj4JEZomHYJ517krkD0Yfj6dQQ8KGsKAfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110079
X-Proofpoint-GUID: bWAtFJAAaPn0IFdBSaXUiAel4FfKMwls
X-Proofpoint-ORIG-GUID: bWAtFJAAaPn0IFdBSaXUiAel4FfKMwls
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux isa_framework
head:   db6ba78ead62e927c2057ba750765b070c8af8a6
commit: f4fd878dfb479e6db102addfdf545a32b76fbecd [3/8] RISC-V: Minimal parser for "riscv, isa" strings
config: riscv-randconfig-m031-20220211 (https://download.01.org/0day-ci/archive/20220211/202202111616.z7nZoKYj-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/riscv/kernel/cpufeature.c:153 riscv_fill_hwcap() error: uninitialized symbol 'ext_long'.

vim +/ext_long +153 arch/riscv/kernel/cpufeature.c

df952ae2ac81fb Jisheng Zhang  2021-05-16   65  void __init riscv_fill_hwcap(void)
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   66  {
dd81c8ab819d360 Johan Hovold   2019-01-18   67  	struct device_node *node;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   68  	const char *isa;
d4d5a22e24d477a Tsukasa OI     2021-12-02   69  	char print_str[NUM_ALPHA_EXTS + 1];
f4fd878dfb479e6 Tsukasa OI     2021-12-02   70  	int i, j;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   71  	static unsigned long isa2hwcap[256] = {0};
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   72  
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   73  	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   74  	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   75  	isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   76  	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   77  	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   78  	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   79  
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   80  	elf_hwcap = 0;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   81  
6bcff51539ccae5 Anup Patel     2020-04-24   82  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
6bcff51539ccae5 Anup Patel     2020-04-24   83  
dd81c8ab819d360 Johan Hovold   2019-01-18   84  	for_each_of_cpu_node(node) {
fbdc6193dc706c8 Atish Patra    2019-02-22   85  		unsigned long this_hwcap = 0;
6bcff51539ccae5 Anup Patel     2020-04-24   86  		unsigned long this_isa = 0;
fbdc6193dc706c8 Atish Patra    2019-02-22   87  
fbdc6193dc706c8 Atish Patra    2019-02-22   88  		if (riscv_of_processor_hartid(node) < 0)
fbdc6193dc706c8 Atish Patra    2019-02-22   89  			continue;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   90  
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   91  		if (of_property_read_string(node, "riscv,isa", &isa)) {
7265d103902c0bc Johan Hovold   2019-01-18   92  			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
fbdc6193dc706c8 Atish Patra    2019-02-22   93  			continue;
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   94  		}
e2c0cdfba7f6992 Palmer Dabbelt 2017-07-10   95  
6bcff51539ccae5 Anup Patel     2020-04-24   96  #if IS_ENABLED(CONFIG_32BIT)
6bcff51539ccae5 Anup Patel     2020-04-24   97  		if (!strncmp(isa, "rv32", 4))
f4fd878dfb479e6 Tsukasa OI     2021-12-02   98  			isa += 4;
6bcff51539ccae5 Anup Patel     2020-04-24   99  #elif IS_ENABLED(CONFIG_64BIT)
6bcff51539ccae5 Anup Patel     2020-04-24  100  		if (!strncmp(isa, "rv64", 4))
f4fd878dfb479e6 Tsukasa OI     2021-12-02  101  			isa += 4;
6bcff51539ccae5 Anup Patel     2020-04-24  102  #endif
f4fd878dfb479e6 Tsukasa OI     2021-12-02  103  		for (; *isa; ++isa) {
f4fd878dfb479e6 Tsukasa OI     2021-12-02  104  			const char *ext = isa++;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  105  			bool ext_long, ext_err = false;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  106  
f4fd878dfb479e6 Tsukasa OI     2021-12-02  107  			switch (*ext) {
f4fd878dfb479e6 Tsukasa OI     2021-12-02  108  			case 's':
f4fd878dfb479e6 Tsukasa OI     2021-12-02  109  			case 'x':
f4fd878dfb479e6 Tsukasa OI     2021-12-02  110  			case 'z':
f4fd878dfb479e6 Tsukasa OI     2021-12-02  111  				/**
f4fd878dfb479e6 Tsukasa OI     2021-12-02  112  				 * 's' is a special case because:
f4fd878dfb479e6 Tsukasa OI     2021-12-02  113  				 * It can be present in base extension for supervisor
f4fd878dfb479e6 Tsukasa OI     2021-12-02  114  				 * Multi-letter extensions can start with 's' as well for
f4fd878dfb479e6 Tsukasa OI     2021-12-02  115  				 * Supervisor extensions (i.e. sstc, sscofpmf, svinval)
f4fd878dfb479e6 Tsukasa OI     2021-12-02  116  				 */
f4fd878dfb479e6 Tsukasa OI     2021-12-02  117  				if (*ext == 's' && ext[-1] != '_')
f4fd878dfb479e6 Tsukasa OI     2021-12-02  118  					break;
                                                                                        ^^^^^^
ext_err is false.  ext_long is uninitialized.

f4fd878dfb479e6 Tsukasa OI     2021-12-02  119  				ext_long = true;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  120  				/* Multi-letter extension must be delimited */
f4fd878dfb479e6 Tsukasa OI     2021-12-02  121  				for (; *isa && *isa != '_'; ++isa)
f4fd878dfb479e6 Tsukasa OI     2021-12-02  122  					if (!islower(*isa) && !isdigit(*isa))
f4fd878dfb479e6 Tsukasa OI     2021-12-02  123  						ext_err = true;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  124  				/* ... but must be ignored. */
f4fd878dfb479e6 Tsukasa OI     2021-12-02  125  				break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  126  			default:
f4fd878dfb479e6 Tsukasa OI     2021-12-02  127  				ext_long = false;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  128  				if (!islower(*ext)) {
f4fd878dfb479e6 Tsukasa OI     2021-12-02  129  					ext_err = true;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  130  					break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  131  				}
f4fd878dfb479e6 Tsukasa OI     2021-12-02  132  				/* Find next extension */
f4fd878dfb479e6 Tsukasa OI     2021-12-02  133  				if (!isdigit(*isa))
f4fd878dfb479e6 Tsukasa OI     2021-12-02  134  					break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  135  				while (isdigit(*++isa))
f4fd878dfb479e6 Tsukasa OI     2021-12-02  136  					;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  137  				if (*isa != 'p')
f4fd878dfb479e6 Tsukasa OI     2021-12-02  138  					break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  139  				if (!isdigit(*++isa)) {
f4fd878dfb479e6 Tsukasa OI     2021-12-02  140  					--isa;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  141  					break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  142  				}
f4fd878dfb479e6 Tsukasa OI     2021-12-02  143  				while (isdigit(*++isa))
f4fd878dfb479e6 Tsukasa OI     2021-12-02  144  					;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  145  				break;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  146  			}
f4fd878dfb479e6 Tsukasa OI     2021-12-02  147  			if (*isa != '_')
f4fd878dfb479e6 Tsukasa OI     2021-12-02  148  				--isa;
6bcff51539ccae5 Anup Patel     2020-04-24  149  			/*
f4fd878dfb479e6 Tsukasa OI     2021-12-02  150  			 * TODO: Full version-aware handling including
f4fd878dfb479e6 Tsukasa OI     2021-12-02  151  			 * multi-letter extensions will be added in-future.
6bcff51539ccae5 Anup Patel     2020-04-24  152  			 */
f4fd878dfb479e6 Tsukasa OI     2021-12-02 @153  			if (ext_err || ext_long)
                                                                                       ^^^^^^^^
Uninitialized

f4fd878dfb479e6 Tsukasa OI     2021-12-02  154  				continue;
f4fd878dfb479e6 Tsukasa OI     2021-12-02  155  			this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
f4fd878dfb479e6 Tsukasa OI     2021-12-02  156  			this_isa |= (1UL << (*ext - 'a'));
6bcff51539ccae5 Anup Patel     2020-04-24  157  		}
fbdc6193dc706c8 Atish Patra    2019-02-22  158  
fbdc6193dc706c8 Atish Patra    2019-02-22  159  		/*
fbdc6193dc706c8 Atish Patra    2019-02-22  160  		 * All "okay" hart should have same isa. Set HWCAP based on
fbdc6193dc706c8 Atish Patra    2019-02-22  161  		 * common capabilities of every "okay" hart, in case they don't
fbdc6193dc706c8 Atish Patra    2019-02-22  162  		 * have.
fbdc6193dc706c8 Atish Patra    2019-02-22  163  		 */
fbdc6193dc706c8 Atish Patra    2019-02-22  164  		if (elf_hwcap)
fbdc6193dc706c8 Atish Patra    2019-02-22  165  			elf_hwcap &= this_hwcap;
fbdc6193dc706c8 Atish Patra    2019-02-22  166  		else
fbdc6193dc706c8 Atish Patra    2019-02-22  167  			elf_hwcap = this_hwcap;
6bcff51539ccae5 Anup Patel     2020-04-24  168  
6bcff51539ccae5 Anup Patel     2020-04-24  169  		if (riscv_isa[0])
6bcff51539ccae5 Anup Patel     2020-04-24  170  			riscv_isa[0] &= this_isa;
6bcff51539ccae5 Anup Patel     2020-04-24  171  		else
6bcff51539ccae5 Anup Patel     2020-04-24  172  			riscv_isa[0] = this_isa;
fbdc6193dc706c8 Atish Patra    2019-02-22  173  	}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

