Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AC4DB4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357261AbiCPPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351190AbiCPPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:32:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5ED6D18C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:31:24 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GFCCZV024098;
        Wed, 16 Mar 2022 15:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=F6rzgUmWTI9zDWNVHclXqn4ERpksEFcLR6iebidxwa8=;
 b=mG0ODiWNwyvKRpvyhf8tkN1wFfy4V7+vDZvzhfyXuXnJton2i3CnBYvupHnS32XR5+vL
 BUKLbt+RPtl0URGxVBKiVgz3zK+8rQVytBAFOhLc56e841v8KIPsbwpGd8Mnvp7zp4uK
 zEwy9TwF/u/Q2yeHB+WCCYQIeAzPaLIk0wip4OIbW2kQupazsr/f0g6p9a4IvhhpLojO
 5l2+fHuyaM0t4BLLZQo9NycTbpQ5nZ/lnI1M9XGMFvwl0Og4nFK1J+rIjQpHQ8Uwizqa
 O4EZx0Xrys9gWkX+S5R+gcf71dOfd0VbA4AgNumm/F9UgCXWBJA6BMwO8TDbDV8NUG3g 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6pkws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:31:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GFVAE9168569;
        Wed, 16 Mar 2022 15:31:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 3et65pyxmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 15:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM1LlO+ynZUEUo5sNzvk2iH5rFhr5x2xP/1AIf739ojt63BwyhsknAiv5BP13lnQfyzwnMO47nlGgVxbddI20P+FertPvAstxzkWS5wJhgxnHIT9Oda2mDPX75FAyQGlaYjZl5ljAvPVaj0nG6qAj9b8pUygQxEQ3PYT8Dpudh+T/OIbUfgqX3Anx5NHgVKqy6/6o7vZnaqsYddrWUm+eTsQE1fFMcQErdO78gcdWdEGPip2xFqx6pvB6ch+82lnPfzuZ5Mcb0VvXeMw3ixJBNB/bNQv3p9F6BFhMB1hL0Zn6mtPYEinJoTszONANEh4lZJPkwRPN7u/nqCm+WNy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6rzgUmWTI9zDWNVHclXqn4ERpksEFcLR6iebidxwa8=;
 b=k25mymUobPAAIsy6eeXE3m6LkGaeg7wKI+SyTL1+9K9HVt1tElqwOFTWazY4qWDH0KYSjDO+ispPL+haC8mbIhW4FTpno3GtIlZjxvMS9jhC9CWxviM6E/PT1ODDNIGUXntGkWt03Ua1SKnK5NJpY4KWKKCLAIJO21EGgtJ3BkG2+74Gd9FOF+C1KMgZ0n1paowGoWL801sIKziWoX3vImdU1FQ7f9mb9/6rceGBTYlvoQY+zVEZsLf6S7s5geZeFhk3m82Dk15hFlhCi4Ckz4C4JUFgwjEcAxO50AIhRFuO2+ktFwqxlucsGQNPmQneJCNd4pzH/khJXvoE/+dGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6rzgUmWTI9zDWNVHclXqn4ERpksEFcLR6iebidxwa8=;
 b=gQKh2iSC/Nlh49MuJdNrlywMPYo+nz9uFDt334nsgCs9PhdXeVHSZJ86rBWGsCJwGTed6lnXv4JT+bUnGHcpw5bGlUoqJxA2mL4C0IRb5nrG53X0QB5BgpR27SpHrhW4kQb27HLKAyEgTELdsxryPr/lrKFd8rvvOi9B1uVnKi4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3781.namprd10.prod.outlook.com
 (2603:10b6:610:a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 15:30:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 15:30:51 +0000
Date:   Wed, 16 Mar 2022 18:30:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-rebased 120/129] drivers/acpi/svkl.c:164
 acpi_svkl_init() warn: '&acpi_svkl_dev' not released on lines: 157.
Message-ID: <202203162327.0MHKaQED-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9a5d817-7b77-4f31-1dab-08da0761f434
X-MS-TrafficTypeDiagnostic: CH2PR10MB3781:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3781DA8EB1EF1DB01C7BFA938E119@CH2PR10MB3781.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F30elGOn/7is/vcOhMxtTlrtKOCtrNxcgybG1kYurgKn4ZYc6QfU4AS56GcxUIbOga8ppGOhFhQ8ceTS89zmG90jQdO0BYCSG3JeyliO+AT1/HvUB65zYvAeDkmLT3o9xEJ/32NVjl6OuoLl0ezloNKRbhQyMcx0BdAokAvy3bAo10ETb1kW5ZFLL27uXRjGFTmz0F1KsKAhZAZnMu6XbUJz6EeNSHoVN1aZI6q9a2O6y9AWXl4yBVr21cNyfDdelt90rKBmtyiF4stz9KCN3p8segre3uhObc+zP8uRGAyn8K/ZmLQWW8mBx9ffvgqH864xG2zMCIT2v1iBQuNZPfyJsK2ARK64eQG/5Z1WIfYlX1vAxLqqJ93g4a+LPpZo1cCOKbX+SucZGEMHwrtP9+pEeM0DWU0wbTZprtdZ0imyiy/xLaqYO+0TRGGPCMlcETqm/zlHPul4zymCajnd51Ib0ReniDI8f2mIYQKc+uVd1Q/tYa028k0E7Uu1FT49oRnExR1lEORBwiO03LOJaLduKL0/I2k4eDHqOAFkZnAasFx2DcXuxNnHPaDiGcNeIMu089K5SGpDRVV9viJH+8qGkJsA+KEeNPNfPMr5oZ/e0X5FrMj6tovbRXAphCC8mhk4TlKEvBT9YzO4RG4Qz9MPKsjfUcSV8W1KhQK5e/i7GYk9yn4ZgYjKujCVO4w5+FXJhPo7R168Bso2BtSMkD8YDZCtQLdcjJtsaAfLNyAw6hUy6rwUHmsN5dZcgbxPrmQ/EgUT2VnYgRY/ffV/v4Bn6UiUCB4OqV0bCl6spgn59k5j8Lj5b6sugkbLto4AkBAlL69fSZFOI47qsk2X1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(5660300002)(8936002)(26005)(38100700002)(1076003)(186003)(2906002)(38350700002)(86362001)(83380400001)(316002)(6916009)(966005)(6666004)(508600001)(36756003)(6512007)(6486002)(9686003)(66476007)(66556008)(66946007)(4326008)(6506007)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yZQnT0aklmEq4DbhN8mILRB75u75JRA8UddCxkml2Kwtrq80SKohs+gKxyq?=
 =?us-ascii?Q?5TjULubkFK1bZKek64K9snRwV5tDY4CQmbc0hOuLMYsiGNATd5/QyrtWdR2K?=
 =?us-ascii?Q?VG4r4npVEOP6yrRGGtBGvW/JHFzjv0McLkxedF0lClmX4G/ICW5pRJo1HTzy?=
 =?us-ascii?Q?os2iHQnI//PAqEe4FokRyXLE9W8/066CV9GJk9rc1Ix/WscYET2N9TziuLgZ?=
 =?us-ascii?Q?6owRMd7RqcXELSzeXsSoTVcU1haFTcFMZJDNk5yqUFwgdbYmayL7t3xAIGn/?=
 =?us-ascii?Q?aX0MUMK4KuTJ35dMw/jQd7QiWb3OEJ5BoO3wN8OEScgqyKiZgS5acPA3A0Ep?=
 =?us-ascii?Q?0SMa7PhT0pjXZrCcRaJPMQafYEotz6RW6nsksCi4eHYizHmHuopQxDZ/+edi?=
 =?us-ascii?Q?muuX8Rss0uPHbLQlpYMB+dxA1ucQ/L6YWyKEGGuFfNDjhpyeb083580WnNvb?=
 =?us-ascii?Q?bqVgUC3vl9h59lC7mTDQ3CyNZ8ILRRlcHZ7gmKy+Maafn9x52788N+9TFDc5?=
 =?us-ascii?Q?o5Wfox64gdN/GQnUmNo7QkKDHhDp9YiYyFho70NEWcmExY7w1W0HQsfy08eQ?=
 =?us-ascii?Q?UJJEZfW0hEbRtXBkKAByKtLpafda+VcmmWMXg65o29WX4g80kDZM5hs5vuDe?=
 =?us-ascii?Q?0WaLB41CGZDiuUCcjEG7R8Kbq9JV40L21hIRQebNqzIcbjEAC0vCGWcIpTVW?=
 =?us-ascii?Q?H5KQBz29EN46Zsm5V1Mh7SEcn5svfjEz02u/8mMa0bmM/zB8UdruupJ82C3E?=
 =?us-ascii?Q?DTZBZVWjEVWz+Wa26X2dQTuR0v09+a9Y9JUHa+lws8ntv/GdF2jJLZ6+C8e8?=
 =?us-ascii?Q?rg5rKVXjOYrTqjhCfx48/FT3lZhcPrWLQiZ0Q774KyFlyBKlMCO8F2zJDrNP?=
 =?us-ascii?Q?ICrWnbFFi+h0seKjs/yQZs7LhMdvePxs+dePjTlifnJ6t4u66ruhYZa/Gj8R?=
 =?us-ascii?Q?uHlnmDxSNYtn8BLmv24r/j1N8a8X7O3HYnq3HrzadFxbRccyGhEfyTrr7Lqb?=
 =?us-ascii?Q?Aw7EkGacvyQ/KELD+K65Yp6HnMw3yC1KeyjgqQ20Br5NBpYxJT8MTagycr+q?=
 =?us-ascii?Q?lZNhjqdJsPmQJswxe2hy0PvCLevjVqjFZBEO7oBkqjo2lthLRHTeINv40Nyc?=
 =?us-ascii?Q?oMNJCDrTqBM3LEQJMHGZ7cTx6sFam6jxmvqbnyvyYBB9mYSxMqonbne5cPCJ?=
 =?us-ascii?Q?OM/mfHVYa5B6PwSDQ1hGJvJ4ojoPw1hvtFYUZCF2n9WEiICw/0bD/xyaFPAa?=
 =?us-ascii?Q?vkmMkPZAHDVwHKAIORonQ/5u/G6IBwJZ3csWwEkVNIlcR6rGoUdtgIxmBJJ0?=
 =?us-ascii?Q?dcEQV7un9JpCOHfKBPe++o2Y7ZMgIumIlVvzuMKgQTTekHvS6oJ9HHr4EG+x?=
 =?us-ascii?Q?GhUQQPC6vTbA24V7DRy4CAgWW9z8MaiP04r96BkJ3joSFAaWKPSLLcVBhegN?=
 =?us-ascii?Q?gFvqXc7EONSy/weQlsG44Us2IIrMFjJYzUcaHZO7hWTgb3tGp7sZhw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a5d817-7b77-4f31-1dab-08da0761f434
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 15:30:51.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8JC9TQ62DY3XOtJUuVencu2kZwQ4JkJI5p0En4KaRq2GGbSqCTeZnAJcmMbU7dbbacNSopDY3GL6MrBvlWz5ULt4ZSBRJ84JCtuE6efO84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160097
X-Proofpoint-GUID: CD-UV_081I0emqIpTdMxwo0xoo4ksdp-
X-Proofpoint-ORIG-GUID: CD-UV_081I0emqIpTdMxwo0xoo4ksdp-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   6d6cab7288e23cfe0084bd1c214e3649146eb159
commit: 370c68664d53ff13dbd36847e140df02364387a5 [120/129] ACPI: Add SVKL table support
config: x86_64-randconfig-m001-20220314 (https://download.01.org/0day-ci/archive/20220316/202203162327.0MHKaQED-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/svkl.c:164 acpi_svkl_init() warn: '&acpi_svkl_dev' not released on lines: 157.

vim +164 drivers/acpi/svkl.c

370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  140  static int __init acpi_svkl_init(void)
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  141  {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  142  	acpi_status status = AE_OK;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  143  	int ret;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  144  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  145  	ret = misc_register(&acpi_svkl_dev);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  146  	if (ret) {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  147  		pr_err("SVKL: can't misc_register on minor=%d\n",
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  148  		       MISC_DYNAMIC_MINOR);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  149  		return ret;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  150  	}
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  151  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  152  	mutex_init(&svkl_lock);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  153  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  154  	status = acpi_get_table(ACPI_SIG_SVKL, 0, &svkl_tbl_hdr);
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  155  	if (ACPI_FAILURE(status) || !svkl_tbl_hdr) {
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  156  		pr_err("get table failed\n");

misc_unregister()?

370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  157  		return -ENODEV;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  158  	}
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  159  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  160  	dump_svkl_header();
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  161  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  162  	pr_info("ACPI: SVKL module loaded\n");
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  163  
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19 @164  	return 0;
370c68664d53ff Kuppuswamy Sathyanarayanan 2020-06-19  165  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

