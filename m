Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210A24C2EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiBXPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiBXPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:03:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BCFBF16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:02:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYSaF023283;
        Thu, 24 Feb 2022 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=omkiWqk0YOTsAK/TyrypUvF07kYdifYWcfSFDpFclSI=;
 b=VCR+AM0HcSGigoy1akKswHdT88WmFLQxfOOduK+kTgFquQTpMw/z7A8Ye70D9jDNx7jc
 klvrmCLUjU1ME92UF0E3lbUbTic6rYI9FYNqgj+DU5QKzGfmCr2hXX5Yjw/uqf0bI+IZ
 ocqiAMy41T1q4nHWNk9wTYewzv/puMCkeaO4FDy2aBUh1/JimjtCP2/5ipxi6vipiAib
 AtRX8mjdUsxzI4hp1WxfG50tBcYZ4Xap8mDJ1j6k2aeEepC7rJZH9IeyGIW3iYJcPybj
 nBakDlwFm0EaHwtW0K7FarNj6V9BGuaKwdfWMdK20ShMjsEU950Up757sHzJSiPkOtho JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfaxyd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:02:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF1gk1180542;
        Thu, 24 Feb 2022 15:02:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3eannxk2qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdfgKnUjoYwfFOCzV6NZBPKG8CzCaCXT2LQ6kx9rtFzfYt/MjSExAJmTxo4JL/4cQzmCnDN+YHF6UCPa5DIfqCRDJcFnUKFcCu+z/VfcBmOBWzK+ldoubYTpat1oj/ih04vBh7jl8nmPDFCZxH1VwkGt8I8F8FJHIKlB8lH0vQE9Vj4sgoLjDAojQkUd528UusAUEYPVLflgbF9Yos5cfqBNxo/mhScRYKIWRdReVxPst2zhZfUaVBqrJ0XZVSqcPxjSah9dx/dbsog6xBvk0EBZSfJd9U6TbUHPPLOOK6UO9uGsmsVG9FBEETMUTVC0R4/FekBqvCKNzWS0PpGckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omkiWqk0YOTsAK/TyrypUvF07kYdifYWcfSFDpFclSI=;
 b=gCTHLdRahzT/+GESL3yEYJBlwW8ObJ1a+zZpJhSfs0+K9Aq0DMVFhiEZ3QPMd4mS6l/M/FCKUydhIqWJRjXyyepHTR/fU/fMpdYHc4arn5+4T9xyUkZDf7kpRx2Rht+WqqUkAERT/do8THrPxRu+kcEsiFtblbZ4gr/sCe0nu7oRgETRjDTlSKdxX0ctp9eOFzh8JSD+wMHC5CicXNW3NPFmHssgube1rsDCjbtsvMxAGYGH56aWQsxJQtdrHho9W7eFSc7BbgaD8cjoJJC+siTxr06OGuyzWhOnyk+DpImZHRx3mZg6HXLsJfoxwtQRYHm+9ILPnew8zS2L0lsGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omkiWqk0YOTsAK/TyrypUvF07kYdifYWcfSFDpFclSI=;
 b=KAtAC9sQsJVCDppQAx//a902cQj2MgItfVXOMSaWncxeBzFMwgW7wQ4dP1eaCpnjSzkc+NbfNZSbJKOa71XtII6NhDmM7VBJnt48OlrZc1YbewsJpS4TO5162oxaJd5oQL4qPX2IftUkl5MB7AfBUwdjSiYABXtzcXic7kDuuSY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3790.namprd10.prod.outlook.com
 (2603:10b6:208:1b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 15:02:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:02:49 +0000
Date:   Thu, 24 Feb 2022 18:02:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Palmer <daniel@0x0f.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 46/93] drivers/gpio/gpiolib.c:1166
 gpiochip_hierarchy_irq_domain_alloc() warn: variable dereferenced before
 check 'd->parent' (see line 1155)
Message-ID: <202202240817.tUm7FhAK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db5bcdee-0b4f-48bb-a6ba-08d9f7a6b938
X-MS-TrafficTypeDiagnostic: MN2PR10MB3790:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB37909B2A0D442AD65B3E595E8E3D9@MN2PR10MB3790.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMu97EY/AFbCoXqOft/QOXsjDWznLs0Ov5a6JOpMC3eE33HhCXjI0w7aD2dlbFFe8nHtDjydlQEQq/ZPN8Vx/22P1hgwBpR5rfR6hmyJ9jWhi5GLurELWPDe7HIlQl2NbW5AcMcO//k4sCQol0YM6U5B7PWtr6q1Knio10d93qEP1/7m1T5zsCRoLyiFQwHq74d6rRcWisNEHXZ6z62fVVVyyeq17BHkxmaovNNQGkGDDCfhFBoWHeLa2zQt6fxOaxAcPAARFuhX1720pgReuef0EPZzDsdN15jFQgblN8w1quUYbvurpOiwCRg57sbOJIEblumQQiAIOfOVbWkT7Gz+snezQVd3pnS1Y7CS13dMKvynaStpbAdvChFijIJ1bcJw57GYq3U2W9aDnSTXUgp6lla4iuzwFk1RE13V2G47OSiZJnBDxQ5H1M/PPTFj28tYiUzGiolUWxa+Tj7ItWZ3FpcDo6QnM6bFtY+24s67/whJLzcQJhk/U+M4A73gEbFUeadGPQC1He1NqHIlKKxLbv/IczR+Mm9ytk0ce8Sa/Kt5cm0G06bFePNx42TxIRSzFiLs2kx3kC8koGAPB7Q3fNIcHNWOnqEPxSFHDKXmgVzx5xA5oNAKN+j3stPMLNVgSlAK2xo14BDTuUHxtOeCKk2HamCHE+hTMoKSd5Ba/QQNZqeZqtNcOEVDfIuOUQVmXm1j9Hzljp2mfJ+h7vGN0A6tc07gvM6oo7GWXz8igc3+h6j7N7jpYxCVvhWyfAyQF5UBRZ9HS3O07LPiXebkwXegkFgM7pMhLe5N4M2QpjLGtsrQKdgYSDwjHvohiPK7bVW2IS6l5QBPA/ZBww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(316002)(8936002)(52116002)(1076003)(508600001)(83380400001)(966005)(6486002)(6916009)(36756003)(4326008)(8676002)(9686003)(6512007)(26005)(186003)(5660300002)(44832011)(6506007)(38350700002)(66946007)(66556008)(66476007)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbJgQojl9pzOEAcq2+RQCKBzL/aPTEJblf0w9StVv1FirecT8Blrqzc1tVoS?=
 =?us-ascii?Q?wwonVrGNVJjveK2NiIF0abIswDg9enF39btGYgZjdoue2zowuRlwlZgcCy7h?=
 =?us-ascii?Q?U0KfKyRO6cOXL0fQpIDp+QGSGXLJjIs0NLiwgxLD746kSoZujs4rCX2YT1q5?=
 =?us-ascii?Q?TdhsHJ9vSn9bHTMgZSDUF1BudzXCc9Lh8RVhyCWPxSmA3ZhjlSjDQ+tyxOPw?=
 =?us-ascii?Q?p1nr2y43pIBm7kRdeN3ehlTGqa8ixYiPU6RR0AodH0jnJljLhaFHFqC2UfdL?=
 =?us-ascii?Q?Usrei9MsL3EB8kwoZuN6wJNei1yDO8AihmPHGtnM8gY3hF/ozHfRkjr+mbsu?=
 =?us-ascii?Q?NEpIUlkwMwJ549gShC0Me4RNPOyxMeZC8etei45YVA4SzkmQQRpr8S3Shqx2?=
 =?us-ascii?Q?lAAEqpAff00KrPwRl9zzDE3Cnzvb8nFu/WOmgx/jITYhUTP1UTRQIay+jKec?=
 =?us-ascii?Q?Lp4qFZLpQcbGrvFFTIB4EDmcetyPJxxfXuftiYNi0Z9Xojw3bI588g8k4Cwq?=
 =?us-ascii?Q?/jC02mdAQt+Wmd/G8KWzxKy9DzDwhghwtwdIWigNLfLev6AEzN97srJ2i5zH?=
 =?us-ascii?Q?XlvSTHRG0J8db8+x/HSQOJ+HoFVJPjxLPo0dXfpKvV8S51AC2nY/ycRofo9t?=
 =?us-ascii?Q?c9UWMMuTzmFRogDDjJLWiSNemSQEKfdOlVJESZ06/yP3UsPsElPvpYJ8IRaK?=
 =?us-ascii?Q?DirRnsssgDTT1r5UZgSZXQWrESpRmsvplrjYD8DeTbWJD4iqyEFjektqetAT?=
 =?us-ascii?Q?lUWrmp35zgnbtMywJ1mnLhLm/j4M/U1o6w9syij1Vsw/FaeLdVSOV6iJxh+6?=
 =?us-ascii?Q?vxmdxqSJ4OQ2sp/u0M+OoVYcrSoI+IgjK8flgTyGLFihPhNEpILDUBe6CC/G?=
 =?us-ascii?Q?kKBr8F8C9sck6x0m5+T0kYPDaBDHfjmwVS2jZiTrBSpkKRarE7DEU4TeJhtR?=
 =?us-ascii?Q?lfWifqmATdpn3n2rdi3HdIx9ybajQkVgPVLPVt2vCNg8R+SwGXJyt3k+tWqO?=
 =?us-ascii?Q?uS0uYYaNeXoHjuw9pVcpkIEDQuStk/YgGmCcbnqJx09w4oyEGaYSvKpg+MDm?=
 =?us-ascii?Q?nGYbsJL87mDefdiZeG4I6YRqWUB37YRh+e4pj/kMAahyMZGmED00TeU42Svn?=
 =?us-ascii?Q?4C0Jqb7Oo6/UCvUb0thOkk/wNnVTY9T0phbvxY5lO2CTblYIfEGE4B/NZO28?=
 =?us-ascii?Q?zX4hGvToeh3g8lI9keGYN3RxKhin1ntTqkwr1Ae+SB+A7tWqb1jFLN9W6+yq?=
 =?us-ascii?Q?/c+RAEFfxZvrzNRBl6lgP0Zwr2mp37V8yA1+1iWQhRcPx/BvXFLqNCEix8xK?=
 =?us-ascii?Q?UMMjTwYW/BdWnY8+fh4ShtdN9ZRXFwKEMA4FcFLgGEGyXTLZzv+H1K5Too9v?=
 =?us-ascii?Q?6lstH2+uGHeW3u+XDpLHThRcNOMLZ+P5Tc56O7HA52XAjR+PC6f4S64adwfk?=
 =?us-ascii?Q?WrlFuxP6yBAHJFPP+9uExydPwlqBjaVZtRCF7TbNZcxLxbzb9a2SdbNKjWUA?=
 =?us-ascii?Q?InkMglKKUYQg9ws7IzFtVXFDxUW4nGHs84/ZYX3iyH61tMkrX2t1m+/GD7l4?=
 =?us-ascii?Q?5jr4DVvy8CSj+T0d9dVzHXuaZJG4QehWkwwFfUhZe/Nt2VWE9SECpsK9F6V5?=
 =?us-ascii?Q?YxprcRZQ/0OrkkVUHpJDMDoQYE/btphL2J5D2q3cS580FXa9Bx+7q7+8tZXn?=
 =?us-ascii?Q?Crk55A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5bcdee-0b4f-48bb-a6ba-08d9f7a6b938
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:02:49.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pokB+x6so/yO5o/UOzQN1UjsG+T7u0wcLlItJmVoUAP1vILMcHvT92g2kpV5SjZDreIK5iWUufhcuJFAEor/NF09ruoCAzq0lycn3r9DuWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240090
X-Proofpoint-GUID: 4ZN-RCb-5DlGWjG9BLGZi9bY3UQtNKrG
X-Proofpoint-ORIG-GUID: 4ZN-RCb-5DlGWjG9BLGZi9bY3UQtNKrG
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   99a396728dcff78ca3eddcbd2085f11eeb8a01b8
commit: b1c18474d73ad17638f8369a7e8be6582a12c1ee [46/93] gpiolib: Move setting the flow handler and don't set it at all if there is a parent domain
config: x86_64-randconfig-m001-20220221 (https://download.01.org/0day-ci/archive/20220224/202202240817.tUm7FhAK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpio/gpiolib.c:1166 gpiochip_hierarchy_irq_domain_alloc() warn: variable dereferenced before check 'd->parent' (see line 1155)

vim +1166 drivers/gpio/gpiolib.c

fdd61a013a24f2 Linus Walleij 2019-08-08  1107  static int gpiochip_hierarchy_irq_domain_alloc(struct irq_domain *d,
fdd61a013a24f2 Linus Walleij 2019-08-08  1108  					       unsigned int irq,
fdd61a013a24f2 Linus Walleij 2019-08-08  1109  					       unsigned int nr_irqs,
fdd61a013a24f2 Linus Walleij 2019-08-08  1110  					       void *data)
fdd61a013a24f2 Linus Walleij 2019-08-08  1111  {
fdd61a013a24f2 Linus Walleij 2019-08-08  1112  	struct gpio_chip *gc = d->host_data;
fdd61a013a24f2 Linus Walleij 2019-08-08  1113  	irq_hw_number_t hwirq;
fdd61a013a24f2 Linus Walleij 2019-08-08  1114  	unsigned int type = IRQ_TYPE_NONE;
fdd61a013a24f2 Linus Walleij 2019-08-08  1115  	struct irq_fwspec *fwspec = data;
24258761671057 Kevin Hao     2020-01-14  1116  	void *parent_arg;
fdd61a013a24f2 Linus Walleij 2019-08-08  1117  	unsigned int parent_hwirq;
fdd61a013a24f2 Linus Walleij 2019-08-08  1118  	unsigned int parent_type;
fdd61a013a24f2 Linus Walleij 2019-08-08  1119  	struct gpio_irq_chip *girq = &gc->irq;
fdd61a013a24f2 Linus Walleij 2019-08-08  1120  	int ret;
fdd61a013a24f2 Linus Walleij 2019-08-08  1121  
fdd61a013a24f2 Linus Walleij 2019-08-08  1122  	/*
fdd61a013a24f2 Linus Walleij 2019-08-08  1123  	 * The nr_irqs parameter is always one except for PCI multi-MSI
fdd61a013a24f2 Linus Walleij 2019-08-08  1124  	 * so this should not happen.
fdd61a013a24f2 Linus Walleij 2019-08-08  1125  	 */
fdd61a013a24f2 Linus Walleij 2019-08-08  1126  	WARN_ON(nr_irqs != 1);
fdd61a013a24f2 Linus Walleij 2019-08-08  1127  
fdd61a013a24f2 Linus Walleij 2019-08-08  1128  	ret = gc->irq.child_irq_domain_ops.translate(d, fwspec, &hwirq, &type);
fdd61a013a24f2 Linus Walleij 2019-08-08  1129  	if (ret)
fdd61a013a24f2 Linus Walleij 2019-08-08  1130  		return ret;
fdd61a013a24f2 Linus Walleij 2019-08-08  1131  
366950eeb6ee7b Kevin Hao     2020-01-20  1132  	chip_dbg(gc, "allocate IRQ %d, hwirq %lu\n", irq,  hwirq);
fdd61a013a24f2 Linus Walleij 2019-08-08  1133  
fdd61a013a24f2 Linus Walleij 2019-08-08  1134  	ret = girq->child_to_parent_hwirq(gc, hwirq, type,
fdd61a013a24f2 Linus Walleij 2019-08-08  1135  					  &parent_hwirq, &parent_type);
fdd61a013a24f2 Linus Walleij 2019-08-08  1136  	if (ret) {
fdd61a013a24f2 Linus Walleij 2019-08-08  1137  		chip_err(gc, "can't look up hwirq %lu\n", hwirq);
fdd61a013a24f2 Linus Walleij 2019-08-08  1138  		return ret;
fdd61a013a24f2 Linus Walleij 2019-08-08  1139  	}
366950eeb6ee7b Kevin Hao     2020-01-20  1140  	chip_dbg(gc, "found parent hwirq %u\n", parent_hwirq);
fdd61a013a24f2 Linus Walleij 2019-08-08  1141  
fdd61a013a24f2 Linus Walleij 2019-08-08  1142  	/* This parent only handles asserted level IRQs */
24258761671057 Kevin Hao     2020-01-14  1143  	parent_arg = girq->populate_parent_alloc_arg(gc, parent_hwirq, parent_type);
24258761671057 Kevin Hao     2020-01-14  1144  	if (!parent_arg)
24258761671057 Kevin Hao     2020-01-14  1145  		return -ENOMEM;
24258761671057 Kevin Hao     2020-01-14  1146  
366950eeb6ee7b Kevin Hao     2020-01-20  1147  	chip_dbg(gc, "alloc_irqs_parent for %d parent hwirq %d\n",
fdd61a013a24f2 Linus Walleij 2019-08-08  1148  		  irq, parent_hwirq);
c34f6dc8c9e6bb Stephen Boyd  2020-01-14  1149  	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
24258761671057 Kevin Hao     2020-01-14  1150  	ret = irq_domain_alloc_irqs_parent(d, irq, 1, parent_arg);
880b7cf22e8ca0 Kevin Hao     2020-01-14  1151  	/*
880b7cf22e8ca0 Kevin Hao     2020-01-14  1152  	 * If the parent irqdomain is msi, the interrupts have already
880b7cf22e8ca0 Kevin Hao     2020-01-14  1153  	 * been allocated, so the EEXIST is good.
880b7cf22e8ca0 Kevin Hao     2020-01-14  1154  	 */
880b7cf22e8ca0 Kevin Hao     2020-01-14 @1155  	if (irq_domain_is_msi(d->parent) && (ret == -EEXIST))
                                                                      ^^^^^^^^^
Unchecked dereference


880b7cf22e8ca0 Kevin Hao     2020-01-14  1156  		ret = 0;
fdd61a013a24f2 Linus Walleij 2019-08-08  1157  	if (ret)
fdd61a013a24f2 Linus Walleij 2019-08-08  1158  		chip_err(gc,
fdd61a013a24f2 Linus Walleij 2019-08-08  1159  			 "failed to allocate parent hwirq %d for hwirq %lu\n",
fdd61a013a24f2 Linus Walleij 2019-08-08  1160  			 parent_hwirq, hwirq);
fdd61a013a24f2 Linus Walleij 2019-08-08  1161  
24258761671057 Kevin Hao     2020-01-14  1162  	kfree(parent_arg);
b1c18474d73ad1 Daniel Palmer 2021-09-30  1163  
b1c18474d73ad1 Daniel Palmer 2021-09-30  1164  	if (!ret) {
b1c18474d73ad1 Daniel Palmer 2021-09-30  1165  		/* If there is a parent domain leave the flow handler alone */
b1c18474d73ad1 Daniel Palmer 2021-09-30 @1166  		if (d->parent)
                                                            ^^^^^^^^^
Checked too late

b1c18474d73ad1 Daniel Palmer 2021-09-30  1167  			irq_domain_set_hwirq_and_chip(d,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1168  						      irq,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1169  						      hwirq,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1170  						      gc->irq.chip,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1171  						      gc);
b1c18474d73ad1 Daniel Palmer 2021-09-30  1172  		/* Otherwise set the flow handler supplied by the gpio driver */
b1c18474d73ad1 Daniel Palmer 2021-09-30  1173  		else
b1c18474d73ad1 Daniel Palmer 2021-09-30  1174  			irq_domain_set_info(d,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1175  					    irq,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1176  					    hwirq,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1177  					    gc->irq.chip,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1178  					    gc,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1179  					    girq->handler,
b1c18474d73ad1 Daniel Palmer 2021-09-30  1180  					    NULL, NULL);
b1c18474d73ad1 Daniel Palmer 2021-09-30  1181  		irq_set_probe(irq);
b1c18474d73ad1 Daniel Palmer 2021-09-30  1182  	}
b1c18474d73ad1 Daniel Palmer 2021-09-30  1183  
fdd61a013a24f2 Linus Walleij 2019-08-08  1184  	return ret;
fdd61a013a24f2 Linus Walleij 2019-08-08  1185  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

