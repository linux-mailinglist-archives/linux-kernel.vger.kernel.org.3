Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D382478589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhLQHUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:20:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13214 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231258AbhLQHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:20:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2UZUb009316;
        Fri, 17 Dec 2021 07:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1c04O0f3S+robIFFf9ymcomTwQIVMsbESNtwRZLQaWI=;
 b=APHLy5QhO1O4rzaGtZ8E/8XtYguOwARvIlo2+4zxUzzbf9h4PCy/o/TPxxS1eLGle9Xr
 rcVrAnF05ZvvZzwwFV9bUe8pEgrj9JmRLZr0tNnPYIIgmWHI0NCcgC30SmmOCNf7vljT
 L+qKCX593bx4pqU5HJuwu24P5/lLFpawGTcRHnwJ6XJcWPaxR6qk3pYu/kF+xu5VXwrn
 WVXDTHDwGWjAZ65up8PKBtqo9bbUBwFVFB35nam1ssyz5g7VMCRJCV4HDIi19wvETfPO
 xgWYQQlHPNo8/Zrfc8CIbjNzh8urjXRlTrKu2Nt2MXVmebHFVllxJn+SRdtYYWf+wniZ 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp50eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:20:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH79tM8133137;
        Fri, 17 Dec 2021 07:20:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by userp3020.oracle.com with ESMTP id 3cvnev5pum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdfAudUouSlm2eaQ4PpP8Db1QDrsdUf5gESSmTzNbQG5WCkmT9fAZbPs4QYJEwt01qx0VcsYZ710woTmywBCTT58V2O/IXALUIzxhtfMLInSquhDuhurMCtd9s7bYxT+mVf0cWAuwCglQIR4U/7R2PneDIt7MrwQWR/nk0ohkrddkSwZOh7ydtZRf6aBWgx72Z1TCNT803qMhOl6DTeDggFlbQpW+paPtv/SyEIlMcjjh8n3GzxwbipD4yr3gFQHef3f2blUo9qnMHZBbCWKIAZAnqYOsDlchd/QlBw6MQiWu2Wi2VOiSpVLEirU9Gj7qSEaxCnoc6/AgGtIiAGGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c04O0f3S+robIFFf9ymcomTwQIVMsbESNtwRZLQaWI=;
 b=LAAGXzmyHIVMfv7kdBzD/FZGC7B94WiAqD6oNOZYpQ+2C18BFs6MRrBLhMpcNkD6GRuuUUZRWha7oul9HUlkJbTnU1FDXuQzn5KC2mZjQzgC/RLqfP70cwSabhnk6mPoyZ8J0KHXPHC5nfCwDdbkhulDL+/Qp/7UaXTZg0UQxd9EeJRMtfVFNQvbXcqoL5s3V+3CojRU6YoYjxGrZhddfysKDYo6zyNukcIniFdfXAD7hbbSlPrtGwBDo1kn5peuUHH+KeqrcouaFH13OFSWjSaXN52FCtlYzdd5E24MJ1t+PCVqmB+xqtmmiABuS5FRejU2T/4IjjXfAut6N2yGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c04O0f3S+robIFFf9ymcomTwQIVMsbESNtwRZLQaWI=;
 b=hIFeljk88mAnASfygO9yMowfTeNA8xhNNt8U4yUu5GomGgN/RFsYzz4af4jdCHeY9CDvOApliTTDulYunIGjsNJy9YJcz4WKaIDTZc7ueXt3/u9+PPL3wi+WlRt8UyTdIjTMw17usHQgPB8i6nJCJGhYfColappFrnfalOYvJ2I=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1528.namprd10.prod.outlook.com
 (2603:10b6:903:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 07:20:37 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 07:20:36 +0000
Date:   Fri, 17 Dec 2021 10:20:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn: 'mbase'
 not released on lines: 249.
Message-ID: <202112161000.15tF7PTx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::24)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12aae996-29a8-42a2-2663-08d9c12db8c4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1528:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1528493B268621D44AB105868E789@CY4PR10MB1528.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4dLKwd0Gcq2TZ5OKqN1qNZR3a0/mPt5ybh+cfsoda0aJY686P4INzSdVw+NpKqSjExgxWCFGHn2Z4d/TWO81Z/r3ktImH2DCkyWcUKQ3qg2zBcFlVoK2fe2aFDtZhMypX2GSA7xmvpPCDVAy0qQ5qSI0hWNnzuXAORfXyAB+ja26MBQFK7nU3rKbs7f2vxGbrXwKCXTSAe37eLUWDO5vHNJfNpPMVgrgKafayTma3q5nJQ+8dM1tL8KxlqXKAFUqwisbMyp6JHPmvQ7QiIAY0yWNdqzh/lHi1XOjxBaAqCzD+1pO2ecI8eD8RQC9VGPACXFIcWsFHoFPll4PzE1LuYsXm/NGF4fmFrxHCfXC1xWoWpjCNkKvrTHi1NWKs2tbYIDMc3MZf0cfEnkXbCHFX2PhqrP1U4tbWM8l9ggEGiKMqQMPRr7m3fbZAizXu5DNZg8vXDp/O1jM2dv+j7tAXp9TMsCb/uggcDIX9zJ3hmEzuFYigg2fBiTHQUPixbX9ueceEKidtzVcR8PwM0A1PA1q8fvID87VXPItg1wXVH07gZpMGvAfNhAG34SzFNwOAy/bguzDyKwFLO/ViMgCMII2BI5VUcqRaZCz+KViSYUrxYVPp/cCpP/vsiOdmd/5rOIJqWLX2gTnVzfor0gmUzJKnEXVgSHnZU7c9DMTSq+cICqldBdn8W9LcQ957jcHksggRYesj8BqeFhhM84q24Xwes2mGMfl2d36Z/nFNJoBjb6l7Vrzbu7eYTe+tSre/Kmp9PpxzfhOIfYyiRW+hQMR87+T3m71DhxrEqRYq7FT2vh6Flz9e6Q5KdDPe60oc9shhe3nj6yifejjeT8yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66476007)(44832011)(83380400001)(38350700002)(26005)(8676002)(316002)(6486002)(38100700002)(5660300002)(37006003)(6506007)(36756003)(8936002)(52116002)(4326008)(508600001)(6916009)(6666004)(1076003)(66946007)(2906002)(66556008)(9686003)(86362001)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzrdUXDGiOpT6cadDqBLZXHmzVar1zThitMTq96ccjLTd4t2A4UUcXwGRXph?=
 =?us-ascii?Q?QiKzE+avLwaUsIXYRefMXsy1doe6pme1S0Ad0AHDvsvVgzOoZnrzSl5qk9U1?=
 =?us-ascii?Q?xCZTFfrj7TuQof6VUxW+A5sYnEIcRbtVGSL8mK6DGjiVWYnsmTyT9pKOjcOC?=
 =?us-ascii?Q?5S4O9m/YXwmK7zeoEDiyKbvDVRuFdaH2iM8zGfsnpOvsII5l3FRq7bRlsVT4?=
 =?us-ascii?Q?iAJKA+eee0CdbOuJH1d5OY3D4XCuUwKRJyXMfhT8cMDk8hYp4dPIe8IijGAs?=
 =?us-ascii?Q?B040sMQGmZL/gNiZ3dXOXRyo+IsQrPK+7qHsSAQ+HmQlH3AitVJ4ppNRdVKf?=
 =?us-ascii?Q?Cpz2shUApMWHTpaHy5eqjKjjDsIyf+kWUwWq29wqx8uDCCKlCRbttYxr1oxk?=
 =?us-ascii?Q?yYNPiLyIM86ll7BKkscZuz+7ir+gXYauEWMLvM/U93mmJcAWRvQir+fGctK+?=
 =?us-ascii?Q?OYJ2+3eaqJpkOrBPsslSb8I2Sqh5+09NcBcDJBWyMFaWneAl89vC+o5q1GJe?=
 =?us-ascii?Q?gd67dTdjUp55xCQUgkYek8xUTzlfLIwh5t+7+LMvvY6PgwH3hdGxenFAu2fS?=
 =?us-ascii?Q?HoBkUNfH5Myj0UhhOOv0s5Rv71oGUmLN62a4K7MntWLtU5BGy1+MVESINZvy?=
 =?us-ascii?Q?XJ7UWiHgs6A1tYhCfR/zlUwOO1oppaGEz3hiwRvsLxLVN0OdQhHEjJDeujer?=
 =?us-ascii?Q?rhGrZhmMUnGkZdaEjt/VweJSw7yg7Ohp0TuJT2ywSDbw5+frMFnV11NJzjCG?=
 =?us-ascii?Q?wVD2YUA0BkdEP42jPuO4NXu+FjrfFjE6NW4GZpQGGh8VLSkMPWihGS93Vlmu?=
 =?us-ascii?Q?3JIHZxgPFvKStxlH2NZkFhPinkGMWjRShCTIXY9byByI8ygq1mNf17BSYUyl?=
 =?us-ascii?Q?j0TzJOato/WZqrpvZYIGr1mAtZXQN5YJtAShbjvlSjcH9tu321oCHWKGbZlq?=
 =?us-ascii?Q?nuHaVVWLP3ftvoDj7Gqzs5qdUqlSbFsscVUoZjD/pqsi1JsPHkNhTT+2TQq5?=
 =?us-ascii?Q?yKEoXgYT/BymK9/X8xeSPN8dfgp3QJzMafLKzQxuvSFq8C9bemKHS/hxlI0A?=
 =?us-ascii?Q?Yxtw9xHxW/Qr+Z/SYDzkPVNUR+bMJeH1AExKJ/42PiJ/tY6alPB/d2HGe8NB?=
 =?us-ascii?Q?WTa+x7swz8hIaf2TzyFnfzxWVmAuzWAOeo69oYKFdmQHzb/AQXl+FDG0DCRu?=
 =?us-ascii?Q?fl1wsEUEOAKpLj1rMgIP29ZOvkvuMxpK2yZs56hzl6z8Pt1QNC3fWEu3lKjy?=
 =?us-ascii?Q?Sz1Z8veRARhf04ctp8umXWOGviUXDU+TskPsW/b6v6Abhk2XhDk1afFe8eWc?=
 =?us-ascii?Q?HIR9PvCxwvZHoSiseRosKIFAeB+bH2/kjEplxS/ISBOlHV11Ud/txj3Colit?=
 =?us-ascii?Q?z4tc80Od6r8gE24/B3qEzo/wYlNcd6McSStZGB2H4SCyx85i5eELFbFEhLAC?=
 =?us-ascii?Q?QEmc3AjFdbeV7XcIzmprrChA7LeyzRqGF4V3osOKnRs3w33KPcbc2H1DXBsN?=
 =?us-ascii?Q?lyRbYr4b8rqEneezHjKhK8LrItVKgFgq/LhYFI9UTDSsEalcQ3qqzmd47tCa?=
 =?us-ascii?Q?gvkSa9xrxahtH/g32FYaxtPrSjRC4XZhS8HNsrHySqbXrozJ8rDonmgTvh6C?=
 =?us-ascii?Q?sVFQOhQ40vSCfwaUnIN2jkIbUj+ZwvI/Nhq7xk86pH/Q7hbbItX9qifHFGxC?=
 =?us-ascii?Q?rAsU4lO+eiho0wcB9nHV5PRGqbM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aae996-29a8-42a2-2663-08d9c12db8c4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:20:36.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSwmscdxowrdSFXfpPptDu9UFZoVmCA1KUrcqu3mYPurghC6esAK6a/qo7ksvWePfCN2pO79Y7AHQXNGvIEGmG1FNMuqdLzA8Z0c8f5UeeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1528
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170040
X-Proofpoint-ORIG-GUID: tOrJbsRpOVRmGMu1Obq05_dJ_lDcagto
X-Proofpoint-GUID: tOrJbsRpOVRmGMu1Obq05_dJ_lDcagto
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: c945088384d00e6eb61535cc4ba25bc062090909 EDAC/i10nm: Add support for high bandwidth memory
config: x86_64-randconfig-m001-20211215 (https://download.01.org/0day-ci/archive/20211216/202112161000.15tF7PTx-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn: 'mbase' not released on lines: 249.

vim +/mbase +256 drivers/edac/i10nm_base.c

c945088384d00e Qiuxu Zhuo 2021-06-11  187  static int i10nm_get_hbm_munits(void)
c945088384d00e Qiuxu Zhuo 2021-06-11  188  {
c945088384d00e Qiuxu Zhuo 2021-06-11  189  	struct pci_dev *mdev;
c945088384d00e Qiuxu Zhuo 2021-06-11  190  	void __iomem *mbase;
c945088384d00e Qiuxu Zhuo 2021-06-11  191  	u32 reg, off, mcmtr;
c945088384d00e Qiuxu Zhuo 2021-06-11  192  	struct skx_dev *d;
c945088384d00e Qiuxu Zhuo 2021-06-11  193  	int i, lmc;
c945088384d00e Qiuxu Zhuo 2021-06-11  194  	u64 base;
c945088384d00e Qiuxu Zhuo 2021-06-11  195  
c945088384d00e Qiuxu Zhuo 2021-06-11  196  	list_for_each_entry(d, i10nm_edac_list, list) {
c945088384d00e Qiuxu Zhuo 2021-06-11  197  		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[1], 30, 3);
c945088384d00e Qiuxu Zhuo 2021-06-11  198  		if (!d->pcu_cr3)
c945088384d00e Qiuxu Zhuo 2021-06-11  199  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  200  
c945088384d00e Qiuxu Zhuo 2021-06-11  201  		if (!i10nm_check_hbm_imc(d)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  202  			i10nm_printk(KERN_DEBUG, "No hbm memory\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  203  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  204  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  205  
c945088384d00e Qiuxu Zhuo 2021-06-11  206  		if (I10NM_GET_SCK_BAR(d, reg)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  207  			i10nm_printk(KERN_ERR, "Failed to get socket bar\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  208  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  209  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  210  		base = I10NM_GET_SCK_MMIO_BASE(reg);
c945088384d00e Qiuxu Zhuo 2021-06-11  211  
c945088384d00e Qiuxu Zhuo 2021-06-11  212  		if (I10NM_GET_HBM_IMC_BAR(d, reg)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  213  			i10nm_printk(KERN_ERR, "Failed to get hbm mc bar\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  214  			return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  215  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  216  		base += I10NM_GET_HBM_IMC_MMIO_OFFSET(reg);
c945088384d00e Qiuxu Zhuo 2021-06-11  217  
c945088384d00e Qiuxu Zhuo 2021-06-11  218  		lmc = I10NM_NUM_DDR_IMC;
c945088384d00e Qiuxu Zhuo 2021-06-11  219  
c945088384d00e Qiuxu Zhuo 2021-06-11  220  		for (i = 0; i < I10NM_NUM_HBM_IMC; i++) {
c945088384d00e Qiuxu Zhuo 2021-06-11  221  			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
c945088384d00e Qiuxu Zhuo 2021-06-11  222  						   12 + i / 4, 1 + i % 4);
c945088384d00e Qiuxu Zhuo 2021-06-11  223  			if (i == 0 && !mdev) {
c945088384d00e Qiuxu Zhuo 2021-06-11  224  				i10nm_printk(KERN_ERR, "No hbm mc found\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  225  				return -ENODEV;
c945088384d00e Qiuxu Zhuo 2021-06-11  226  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  227  			if (!mdev)
c945088384d00e Qiuxu Zhuo 2021-06-11  228  				continue;
c945088384d00e Qiuxu Zhuo 2021-06-11  229  
c945088384d00e Qiuxu Zhuo 2021-06-11  230  			d->imc[lmc].mdev = mdev;
c945088384d00e Qiuxu Zhuo 2021-06-11  231  			off = i * I10NM_HBM_IMC_MMIO_SIZE;
c945088384d00e Qiuxu Zhuo 2021-06-11  232  
c945088384d00e Qiuxu Zhuo 2021-06-11  233  			edac_dbg(2, "hbm mc%d mmio base 0x%llx size 0x%x\n",
c945088384d00e Qiuxu Zhuo 2021-06-11  234  				 lmc, base + off, I10NM_HBM_IMC_MMIO_SIZE);
c945088384d00e Qiuxu Zhuo 2021-06-11  235  
c945088384d00e Qiuxu Zhuo 2021-06-11  236  			mbase = ioremap(base + off, I10NM_HBM_IMC_MMIO_SIZE);
                                                                ^^^^^^^^^^^^^^^^

c945088384d00e Qiuxu Zhuo 2021-06-11  237  			if (!mbase) {
c945088384d00e Qiuxu Zhuo 2021-06-11  238  				i10nm_printk(KERN_ERR, "Failed to ioremap for hbm mc 0x%llx\n",
c945088384d00e Qiuxu Zhuo 2021-06-11  239  					     base + off);
c945088384d00e Qiuxu Zhuo 2021-06-11  240  				return -ENOMEM;
c945088384d00e Qiuxu Zhuo 2021-06-11  241  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  242  
c945088384d00e Qiuxu Zhuo 2021-06-11  243  			d->imc[lmc].mbase = mbase;
c945088384d00e Qiuxu Zhuo 2021-06-11  244  			d->imc[lmc].hbm_mc = true;
c945088384d00e Qiuxu Zhuo 2021-06-11  245  
c945088384d00e Qiuxu Zhuo 2021-06-11  246  			mcmtr = I10NM_GET_MCMTR(&d->imc[lmc], 0);
c945088384d00e Qiuxu Zhuo 2021-06-11  247  			if (!I10NM_IS_HBM_IMC(mcmtr)) {
c945088384d00e Qiuxu Zhuo 2021-06-11  248  				i10nm_printk(KERN_ERR, "This isn't an hbm mc!\n");
c945088384d00e Qiuxu Zhuo 2021-06-11  249  				return -ENODEV;

No clean up before the return.

c945088384d00e Qiuxu Zhuo 2021-06-11  250  			}
c945088384d00e Qiuxu Zhuo 2021-06-11  251  
c945088384d00e Qiuxu Zhuo 2021-06-11  252  			lmc++;
c945088384d00e Qiuxu Zhuo 2021-06-11  253  		}
c945088384d00e Qiuxu Zhuo 2021-06-11  254  	}
c945088384d00e Qiuxu Zhuo 2021-06-11  255  
c945088384d00e Qiuxu Zhuo 2021-06-11 @256  	return 0;
c945088384d00e Qiuxu Zhuo 2021-06-11  257  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

