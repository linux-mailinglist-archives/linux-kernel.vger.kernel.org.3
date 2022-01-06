Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3A4861B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiAFIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:55:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57340 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236914AbiAFIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:55:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xus4020279;
        Thu, 6 Jan 2022 08:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=s5olR0n7HWhSZWig4BgSwGzr0fYiNLA8ASHUApAf/As=;
 b=TAdSxxJA/cj2XEpZkdURCWGPfvG+j6fY1epfhthEHWgSuqC5CDOf4mkheDczGMeoRY6M
 KDLP/KafAb5mLHJXWBVpffsEtqFGR6dh9KrNG5h8FhVkoNe2fZ+J2alhhKm8OLwyRibR
 PiSpuh5ttSgwNbgolU6uWcY6Gm7CK36/1uQ1oWbe+wX0tBe9J5OHHhv6u9AhyRK8yPnr
 //QEjeX7JT1LYp88JSbzHyUW+zkJxxfRpDWnbks6Q9zsnJ3+STXe1SmoF8f/JOuPf0dP
 88ZhiP2FvX+ZjCyqPYgWrrnqHYsGVIYwgWaMBvcG5RyYdufcTxibuQODpiV9VCRj0vWu 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpdh541-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:55:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2068jpRG062783;
        Thu, 6 Jan 2022 08:55:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 3ddmqce73k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ancl8OAZj3hq58uD5qyW5dLm+tKgTb+va8aaO/dEH9LksDibYc8a5JxhYZnpxLmuZ5c9aXHAkVDdMXCu6MbpK6meyQYChfHSVWXcVMxfvz6C5ynhXRGkOoAFaHGkqykZLaqNof1mQOJnJepNse5ATgJIBes+SFnhlu8YyxtgZfUnSki7n6vXPcv83j2ASJ6LKVUH1dZ0Zef72qjM2Jif6YY0oCKmOP6a2xo4UKRzPUzWK91m2TRNL2VwZDTAMjRI2MNh1H1Bl29J9aArwfJyr06QzSMQj9soN+ERg7Va/84AM0Bll5MeHLL3TX8yDTuS3PG42BjWBrbEgfrQ3kMcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5olR0n7HWhSZWig4BgSwGzr0fYiNLA8ASHUApAf/As=;
 b=NB89Ncx9HH1PP9HyDL6pLPr/hhROBULtaJgjX+b845b2+RRtA+Z+pj0Fb59eTSVQv3K8QV7z4kVVmAmRXUkn92jzp8lPz8WbYdWanKAdjU3hgVnbWvnClHSaSv9o+N4reQ8DMvfSFw0DWa/bC+JqZf6l5+nnrTOtgr5IQa/xF9eEkBclZzVoi94ISQb7QscyHYZyInu0HmP2VQmPS+8WkxrlyU7EyQTILKmLi3GBYTNxBy4cOudYRqr5a5+j7AmPomMMNo9oUNe9NaE+iXoQxcdMwkmSyzNUJClm1AnIGr7TGN9lDzXWS37/sPQKRDwIXTh4BcPmuC2B9Fqt/4GfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5olR0n7HWhSZWig4BgSwGzr0fYiNLA8ASHUApAf/As=;
 b=TCCwMpRnT8mNvQdeTTcqkm7MbKdKx3qHfQyoKCVp8mD0GstYVlJCLIuEUfrF96fNLSsPufAvyH8ffHwtfJ03jsxHZ9dqwMgr4+1hV0Man9OcggiX3i6IM7blZ5HakSQVlzXsbqXLCQ9W3xf0hkFxaf4renCtQncyrBYtLu1UXFs=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5713.namprd10.prod.outlook.com
 (2603:10b6:303:19a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 6 Jan
 2022 08:55:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 08:55:11 +0000
Date:   Thu, 6 Jan 2022 11:54:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mtd:spi-mem-ecc 14/16] drivers/mtd/nand/ecc-mxic.c:395
 mxic_ecc_data_xfer_wait_for_completion() error: uninitialized symbol 'val'.
Message-ID: <202112271621.cNxEVvN6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66087b98-ee07-4dc4-19ca-08d9d0f23f13
X-MS-TrafficTypeDiagnostic: MW5PR10MB5713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB571355A2602AAF13F4D82C538E4C9@MW5PR10MB5713.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqAd4nLSD7+MtunMf1Ay7aVhfMDPKeND9zAN0L6urHPvijRi2HCFq1LgalfY9T8b2xhkmkDRJhXHt+I9/ql0BSxjp0ANw6DjjMZQkKIAL2TsFGCwyIOZrz45N7UralOISNgUXypgNapDk5XbfCMEKuZFnXJD33Go2CxCgvZj2AQz7A6wkThayJANDxaYnf5MKCvQdjNaRTgH5I2oOz4jXettDMBLvi+ed4xHnBfzzIkVcdC3XbbypOvyS+i7SBW76QIG4EsE0k1MudXp19hyK1R/EKsP85xxNDK8HK8GB6UP0gfIjMNbAeEiRWUwfA8KItKSXCKYYQVwkeWFhzWzFZECxy/SXEwRpLScYUMQZGXdTw05N4494O//8+UkVAx7Hrge8RsQb8ECc6KX8cWxf9STFaTiGTT7sH+KDEsQ/QGNf06fo8H1MJC1erS5rTiS/EeRsLEjC6xb9JhWAJBvMPh7iWEZMOwh82lQyizJ5qK7oyA3poqWpK2b8ZvJL2u+SYpJQyXB3Rn2yI6rKll5eUtDtl4BjNgBeB3Uph9jPQVAJd9+e5bV4DDrUgEqu0oIGS3eb7Vr3JV8pDpgQj6cqWn931DLpDPO3+WGarVl68e/Z0hywFMdXveohx2txfXiS4zF0K5vg6oBxFYwMvmt0LkZNfCYEc03xxRBlpE1FA3RncnKBcQzdfCvqCMtNcAZT1vpA99LwVpbsQiCneSaEfdxKh2Bn8V7eiHlZU+wT/m0PCFLYaEr5cibN75A6Bsutfac/XoZq6mehUz9qRhvsYJMZkt/EDLk07lJhUP+G+NvFM4wjOaylBH9ZqdlCFFrx2XBnrHXSTUJPwwCVPBVzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(9686003)(38100700002)(1076003)(6512007)(38350700002)(4326008)(6486002)(6666004)(52116002)(508600001)(83380400001)(26005)(66946007)(6506007)(186003)(4001150100001)(66476007)(8936002)(8676002)(86362001)(66556008)(6916009)(5660300002)(316002)(44832011)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMEc3u2/vtS1tVMfEVMFo4io9DHIwBkWlaGlKBQWiwldjEN/RZhVUnaBgnTT?=
 =?us-ascii?Q?/3WjTcmVGfnUSJxkeG2mBqheOVFlm9VGy7BY5Xni29/yj8oWm56iKhTxKyhb?=
 =?us-ascii?Q?Skqm6oXrpbRMWBJLGRDL1Zl5LiJCy3CKTY6bJjO7qO9LxWx+59Kg/z4CdBdG?=
 =?us-ascii?Q?KI4ebeotiKscgsCdObPpDe0hH7/ljS971segA1Xmi5C99fYoESbq5EpcPx+t?=
 =?us-ascii?Q?tRLETFKBhpf3B3PdP44wBPKzpYkdJZt4UyjE3YbSKXzdqaEL+VimVjbaFMfK?=
 =?us-ascii?Q?Fz3BMVcc5+SfwueUikMUKJJC9CzzJ9x+jkAa+sqLFf3xnCaEEjN6yKw/CXFY?=
 =?us-ascii?Q?u1Ko2bBPeCJY27oHeaYXZi0y4DLhFAV+Oju8RuLsO9U+Yfz0j3GS9zfz7Ohr?=
 =?us-ascii?Q?uh0cx7bbsP+YVKPTIK0TgWkhIZkcxPi/zsyUZNtu50j//foimyKrI+SOVu+J?=
 =?us-ascii?Q?hZ/DM8B0E01i337T/SA/znU9n1orBbmdY/tdMA1NSAZkVfuIuIhDhVCHvvUx?=
 =?us-ascii?Q?zKqef5rUhDIybEPaF19Q3kl27v7TSoIeY82RzPyLvy2sUASOtwmHfcBZCvwi?=
 =?us-ascii?Q?zk8KPL4GT4ML4s0CdCXkkdo/ZucfQ0y+IjmIIHJrRC1Ed0girYCVGvpVfQBs?=
 =?us-ascii?Q?6FjzMoscd1AnphseHvYl/OaqkXuPmjT0viXQKQT0JeQl4y+APrHtnMLQCUIy?=
 =?us-ascii?Q?iQrQvizY+I5kZyWjNkhN3BS+7/0Q8jpAgXRzFaZVv1Ty6i/maOQMHLSVZ32P?=
 =?us-ascii?Q?JmkJ1tnXwPbOD0o9oixfVEQ3mFYDOmGDruAWxJD/OWeyxHfWo4Rj7kGqnw30?=
 =?us-ascii?Q?OLE91AIev8J+vYQA2vOE5k/SKfb8jusvFlFuqJOOb0Xa8WjMXgbyA5DjIkbW?=
 =?us-ascii?Q?zlhX7UnttQ2KvJqDJ9Q8JpbMIimKX/b3/2Sdy+dITFo3Zx9cwBdJXsHnc+SK?=
 =?us-ascii?Q?U6NWCHUGjF3pKLHjoOY/fWFyhxDKjLvfxXfp30KltAEloypnFu2CrtcYQvYo?=
 =?us-ascii?Q?+I0t+cJ8tdu98o5PN8lZsOObn90wEzySFC22pHLW1AcaB9lg/7MbrG3n94T5?=
 =?us-ascii?Q?aCXinPI7BZ9OWuw5xTGZXQwYbSZOLc21/gD7n6HvWomTejNGixbtTY/2vv0u?=
 =?us-ascii?Q?x666YiVzJqwndrww+xgRZrOoilkxjou9YUAbWYxA5Nc+NDIo5g8zX8ltev6o?=
 =?us-ascii?Q?iFEJgsYRDNqCSAdxRa3O2b+Pju8ZzG+Ohq9HQSF3+ip81UPzix2sNhMpu3BZ?=
 =?us-ascii?Q?MUuUvM+zyg97tUeQjWdOTDR4G3zhB5iXEQzsOaKmTUI8VFxa4akSyTcUX22c?=
 =?us-ascii?Q?mv4LR4WlH1lmvSs70ppoPvNm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66087b98-ee07-4dc4-19ca-08d9d0f23f13
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:55:10.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGDoOfcg+DrvNg9o9iP7ijtHeGbQ5KM3RTawF4MvFxZ21YT6BoqwM80SoOpgGJdOnwyzRfOoxT2jtp1R+GtPOf7m5tv7IwIagO5E+3L0qm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060062
X-Proofpoint-ORIG-GUID: KPK_U81MHrh_4A9Qt5vzZvAzzD4Mtpot
X-Proofpoint-GUID: KPK_U81MHrh_4A9Qt5vzZvAzzD4Mtpot
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
head:   5966bd4f59edbbe5873b1b4637ed50f258ced0b2
commit: b78baf1891f0b7c3f0e2e3e6022eab38ee6c871f [14/16] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
config: i386-randconfig-m021-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271621.cNxEVvN6-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/nand/ecc-mxic.c:395 mxic_ecc_data_xfer_wait_for_completion() error: uninitialized symbol 'val'.
drivers/mtd/nand/ecc-mxic.c:548 mxic_ecc_prepare_io_req_external() error: uninitialized symbol 'ret'.

vim +/val +395 drivers/mtd/nand/ecc-mxic.c

b78baf1891f0b7 Miquel Raynal 2021-12-16  377  static int mxic_ecc_data_xfer_wait_for_completion(struct mxic_ecc_engine *mxic)
b78baf1891f0b7 Miquel Raynal 2021-12-16  378  {
b78baf1891f0b7 Miquel Raynal 2021-12-16  379  	u32 val;
b78baf1891f0b7 Miquel Raynal 2021-12-16  380  	int ret;
b78baf1891f0b7 Miquel Raynal 2021-12-16  381  
b78baf1891f0b7 Miquel Raynal 2021-12-16  382  	if (mxic->irq) {
b78baf1891f0b7 Miquel Raynal 2021-12-16  383  		reinit_completion(&mxic->complete);
b78baf1891f0b7 Miquel Raynal 2021-12-16  384  		mxic_ecc_enable_int(mxic);
b78baf1891f0b7 Miquel Raynal 2021-12-16  385  		ret = wait_for_completion_timeout(&mxic->complete,
b78baf1891f0b7 Miquel Raynal 2021-12-16  386  						  msecs_to_jiffies(1000));
b78baf1891f0b7 Miquel Raynal 2021-12-16  387  		mxic_ecc_disable_int(mxic);

"val" not set on this path.

b78baf1891f0b7 Miquel Raynal 2021-12-16  388  	} else {
b78baf1891f0b7 Miquel Raynal 2021-12-16  389  		ret = readl_poll_timeout(mxic->regs + INTRPT_STS, val,
b78baf1891f0b7 Miquel Raynal 2021-12-16  390  					 val & TRANS_CMPLT, 10, USEC_PER_SEC);
b78baf1891f0b7 Miquel Raynal 2021-12-16  391  		writel(val, mxic->regs + INTRPT_STS);
b78baf1891f0b7 Miquel Raynal 2021-12-16  392  	}
b78baf1891f0b7 Miquel Raynal 2021-12-16  393  
b78baf1891f0b7 Miquel Raynal 2021-12-16  394  	if (ret) {
b78baf1891f0b7 Miquel Raynal 2021-12-16 @395  		dev_err(mxic->dev, "Timeout on data xfer completion (sts 0x%08x)\n", val);
                                                                                                                             ^^^

b78baf1891f0b7 Miquel Raynal 2021-12-16  396  		return -ETIMEDOUT;
b78baf1891f0b7 Miquel Raynal 2021-12-16  397  	}
b78baf1891f0b7 Miquel Raynal 2021-12-16  398  
b78baf1891f0b7 Miquel Raynal 2021-12-16  399  	return 0;
b78baf1891f0b7 Miquel Raynal 2021-12-16  400  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

