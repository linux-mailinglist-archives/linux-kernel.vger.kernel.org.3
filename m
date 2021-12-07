Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4641446B45F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLGHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:50:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20330 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhLGHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:50:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B75BJIk007611;
        Tue, 7 Dec 2021 07:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=NCR/S8zW3WhNDP9XPWyz8NkemWoYQLgsxsWMEzARkXY=;
 b=UzIbtEMhddiWs55Gy2Xn5Hrkxl6kL7GcHpy1S+kVcp+Vhq0mXvrD6XP4Gw+hNlVk0Tn3
 078YCSHxfpVrE5+Tk2EiRjUopa4W0WCzjEHuhAndzKnkxUsRkjolhk8qkINQqRmn7hUz
 13Qufj3MiPpQ8cki3M+bFhxGtouR+Tqtff+IMyJoyaVTFp0QuZwOYhtPDBHG2RVXGwt3
 q2ijU0Rl9ZcsuVH2k9Zw+UOZlLtQnYpWdpuWpgDxVzwf0EOsBnf1oQjZYFubfjDXPyoK
 ow0GPjYEVmpHcEpda8kPEQGf9NZKl6n/MFBxGwvS3idqu6uLvC8kDagXcFPW4TwvuRqt 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ycaum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 07:47:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B77f9nt066818;
        Tue, 7 Dec 2021 07:47:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 3cqwex8sa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 07:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL5JPhYemAXAr91Vq94chi13PovcFKzKbQeGcNCbQTHc8A+RSTk3Syf5XH+agBLRZtOCphDrQ7+XFM2lJnrZQpzFCkiOTJc1zNeEpoCIouUCBqTzoEPJNpK6dzcc7b5k4RgP89gNnQkKkBuJWXjdkRT2EuAwaxp0J1BNvCM2F/+pnUHU2L5Aq+lK0IlR1Fb+kMPN5vu8fgQGvhHNtHZVJ20FSHHNBtEkLhCJKpNs2V1wZ5c7BZlmmQ1mUb7Y1wT5KCcvb8ilTE1D5vq8kJCGS+FBAUfVH18n1T7BnukrE57cs8VAMbCrWiSVXZ5LAqTusJ7XOsQ46tGwn1oaHr/9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCR/S8zW3WhNDP9XPWyz8NkemWoYQLgsxsWMEzARkXY=;
 b=FjpBeYb/1O+SYbSc9Nr76/D4eKwmJfCeX5i8GRNeafIuLquRizVCu5e+pdtGq8NvCNJ4BnBEQaPVwQzxHOXkjnnvMejrorrK8HQWZtlSaoz+IwEt9OdShTp9dyPHtDuL3k3zJXzTvWQcpS39p7VhytCndQdjQHWjD0nOBxIL5W3SNw6OE+G7lcPSKleFL3PlmFKqy1CWJqrSn2UETxLVlwyjllnklypFI3NrCh26C1x1vW9dd2tUJLNKDzHSJrrHVrco9B4AfegmXADkZf/pAj9xJa0dcsjiRpaETMO+91GxrnB5SeX/vyQnAbZYawRhK+Le6ypNGOdFAxALi+NSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCR/S8zW3WhNDP9XPWyz8NkemWoYQLgsxsWMEzARkXY=;
 b=yZIpE1blg+bEmPzgAVF6EUhyn/GBpzNDvhiL6O7AzMoLhpzousj32pVMtK65oJdKapczqd3muvLC5fKh2UuZ50XDM/zGPhFiwi0zxoBWnHf28eXqja3Yyn+tairSfMyTaflEkdhAarlZLDG2CepCU8zGM2WtWJ6mBYaQu1KrfyQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 07:47:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:47:05 +0000
Date:   Tue, 7 Dec 2021 10:46:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ambarus:spi-nor/next-clean-v5 20/25]
 drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn:
 should this be a bitwise op?
Message-ID: <202112062341.u7kBv9Hp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 07:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13627a7d-81ef-48d6-a9c0-08d9b955c33f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46439EED681DF76A9EE107488E6E9@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB/JMbOqGqbRzopv0qWCVsy5WerFW7R+LPnXEE50Aw4ddIzseRebP78pIxZSQ09VP75k38oCm7Cm2gxF0qVwwQThhcno2f6T1IzDcBEo0TDidbjJHQAyGf7uSKBsgH7xeqtrn2MGI/arUh+ijvTxbiWYGp1dbKFGkaIOTlYv/e7SEXi1xVrdx6EFVcG9mczoMxAMBvdgfDuRTC5P1Mprn4seeVXD7JnoF9yWf0p8FD3gzszXFQHib0gAZHx5Wrz9ZMZEbmEjecdrmBMHPhUrEd5JgAkPOTyvtGOHBiZCobeTn1yb6DB++0DY/tkP4I+fH79PsHExigjTgRFiYG7cn+Xkvuqh+MtaFLnB8WZW9mAuhzzVRM9Ex+GEyV3Pe7fZONgiZFJWubqfMUVHU5OGoGjwZwC3p9CM3Vkf1QMRDPsjeMUQBtoJ2amSMA9Idsd29zlfgQzZAxGU/Ug4XmaRDR8s6RQcpXXwEw8rzY2r4fCpVDAT5yF3tdeEUdJHocDaatMM3vEQc+bDMhuDRoS6lPXEDVKm6APNJe7o40bhiVYWAUhvwMnn+hg5s+097cloB9MoYmYQsAUCTH0xONrza1ms3I2tbb8AXenwuSgFjaRF15izX9KV0NmnCVF6eAoSyTjqDU0isMCmx1WQ5sOqxH3YYJy1WdU+GPyecggVmwK/VMp6z0tktId6SUODls4mKo9LFMnW01Thwb85RqosTcFQ2+SWTKI1IgqtvqzXP2uEtD1iqJEg/nyhhPcd+ly+/hLn7rHeYuVXPHA4VxOTNfw4Hg+4cvwU62o4ry+Ke004xErVAFrWpE37+rp7Ff+hRt85OqSMoZFq1wk2sV/diA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(4326008)(66476007)(6916009)(6666004)(5660300002)(2906002)(8676002)(956004)(66946007)(1076003)(8936002)(44832011)(316002)(186003)(83380400001)(86362001)(6496006)(26005)(4001150100001)(52116002)(6486002)(38100700002)(9686003)(966005)(38350700002)(508600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3RpB6wGZbdI0lKISyVSaU//0IXAS6xvKO93/gQtlxdt7X4VWBVI5YWi+ay/?=
 =?us-ascii?Q?m6MBTIiuUpSshzqLCbGfqewh45WfzaEPdYA1VAz2nza0hlbWdzvLTcDwrjDs?=
 =?us-ascii?Q?hvXPmnHX6rN3kSv2gq7h4Jq0V03A8XeX0pbQW8q2xtpbhlZtc1T5yOtPf7qY?=
 =?us-ascii?Q?N1CRwaHr255hylIJfTF+ZQTcmR7N1S6g2CY/C4W4iyiKQwYWB/l0YR+SbShz?=
 =?us-ascii?Q?gtkdGL8e/C9AxSxVTkYwt1xQkRYM7NpLZIB6V+LVQm9RVbg7tyihf33GfklY?=
 =?us-ascii?Q?HfMvecVN1ODWFNCPTxpCQ7apICpDHeRV9IL72CDXF/4SpsMNVv6UWQ5sSQwb?=
 =?us-ascii?Q?8HvlLrkGGa+ZW0t+52KHwW1V4MEv3lddHP5r4Czo3q7paQaYDYMCQ1FGKZzh?=
 =?us-ascii?Q?LyJDJSuvmOPQYO5u9/FDRgn74FUWUD+Vau5q40dVABoJuoWwHJDbhDmoxKl7?=
 =?us-ascii?Q?gJU1nl9t2F9UvlmU6JFJg3ZMUQIec0zx1sKBvmQit+bCKxy/YIP/7O3Y0M0h?=
 =?us-ascii?Q?O2MsWSZBSa4vF+DGcs0t/NVNOFUZP2aWQVWCd2eFGUWhozHfXrKsn9TJFNI7?=
 =?us-ascii?Q?bxrdBBaa1NWxK43q/cTMepQoYJTijbLnenvixt0Rc652Vy/hZIgixGxOvg3u?=
 =?us-ascii?Q?SRFIEMwYNwJQ1ASJ7SeZWwoenloGgej/6XHHpePOkD4U4XfBHgHQWp8rYJEk?=
 =?us-ascii?Q?rECHmgVLSP2e4lHNc+SdU5Z1rOeGQVlu2ocRwulHsrbIDc8yzZTe5IY+Z30r?=
 =?us-ascii?Q?6rtBP2aD49f0cSisxpQ0qkzu8zmqp3X84rgSUCU/FsvMjsF9BcICuv/liAW0?=
 =?us-ascii?Q?zrPU0OakdRai1JUJBfhIgfKm9Y/Ee1lt24gVWMQoJ96IeUQ9vwWwdC/f+DZb?=
 =?us-ascii?Q?3C+OPNpWcIN/s8zwcYETNI104tEIkw5Fmq4A1xOUgVpvuhNKly8n2WQc/paU?=
 =?us-ascii?Q?JJePXNF61JASlgnRrl/xS4QZCCBZfnNKZvUy21brBwGu+j4WJN8aQymxv8im?=
 =?us-ascii?Q?6swvDmApag8mgQ0GeMGXurz/RRxGk3/ypN8XVFfOpgM/jExHRWHuUOEIF0cC?=
 =?us-ascii?Q?wZ9XDakRlYl5uFm/psE6/RUC91DyjnLtJ9Ij4Q9aUyWXxvuXnmBtq7NPjaWH?=
 =?us-ascii?Q?ssaFTLVG49neikyshsniXrD2OtuoEfyPrLAumJ917eiY5hkVuzy1EZfduqON?=
 =?us-ascii?Q?2xIgqeczCQ1b54WE6p2IPH1b5bySkPsW/xS0qpGCbJmq67+Yj5qBRrlpj1FE?=
 =?us-ascii?Q?8Zcwn9kt2iSfDX5lxF4jW89r3TNIAqm8HmBZDbJt3ECbEG7JBuEOK3Cz7HlL?=
 =?us-ascii?Q?ZbNC43tPsAmOgmoPnTmKrKVq+AMX5qGxHIrRpJ2q7yRBesGi9/PzDpn7xbzV?=
 =?us-ascii?Q?k6Xgyc/q4mthc0eFf+bWb/05kBr6KWjKCzi0TtPt2PQuEecSQoHyp2gHa6qD?=
 =?us-ascii?Q?KM7zrnROTsfXuYXcpjZFZLlhSblB5/230iBSeXmo4COHAhM9Vcfhtoyda7Ri?=
 =?us-ascii?Q?eRPpyPwYGbwBUtpx+z0GUT7lU9CgkUNU679PXIil2phEqY2Ax3my/fpMojEY?=
 =?us-ascii?Q?nCX92kEKEKfQ6ew9kXODNUPSFb+AtvYeW4u7QzV/FSHa97B07HFyFVCcLTF9?=
 =?us-ascii?Q?Q9k9NkbpwCuu0vlp6bSILAw6Ie0FODcQydDPM8I0Yb1GcZwoiOmEIXnVndEQ?=
 =?us-ascii?Q?yBKM/+IlKgppK7t+xHMR7gHGjnc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13627a7d-81ef-48d6-a9c0-08d9b955c33f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 07:47:05.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb6He5MtYz6WRJvbJiyaWuMmvIw5d26CEcDNUvaGHk4Z5nLZGGTBIxUPxjuzah4yeedZHwTSTUxSdSXb2knAPkpUfc2JVCDpWpeaS5792FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070044
X-Proofpoint-GUID: hgwuIrgDtu1Dt0yfVRcwG_muwi8pbFiw
X-Proofpoint-ORIG-GUID: hgwuIrgDtu1Dt0yfVRcwG_muwi8pbFiw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day spi-nor/next-clean-v5
head:   d643e0f7de527f4ccf909025478949a961440ac8
commit: d3c97258de8777fd69e982ff804b97a4fc3372a9 [20/25] mtd: spi-nor: core: Init all flash parameters based on SFDP where possible
config: i386-randconfig-m021-20211206 (https://download.01.org/0day-ci/archive/20211206/202112062341.u7kBv9Hp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/mtd/spi-nor/core.c:2720 spi_nor_init_params_deprecated() warn: should this be a bitwise op?

vim +2720 drivers/mtd/spi-nor/core.c

d3c97258de8777 Tudor Ambarus 2021-11-22  2714  static void spi_nor_init_params_deprecated(struct spi_nor *nor)
d3c97258de8777 Tudor Ambarus 2021-11-22  2715  {
d3c97258de8777 Tudor Ambarus 2021-11-22  2716  	spi_nor_no_sfdp_init_params(nor);
d3c97258de8777 Tudor Ambarus 2021-11-22  2717  
d3c97258de8777 Tudor Ambarus 2021-11-22  2718  	spi_nor_manufacturer_init_params(nor);
d3c97258de8777 Tudor Ambarus 2021-11-22  2719  
d3c97258de8777 Tudor Ambarus 2021-11-22 @2720  	if ((SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_OCTAL_READ |
d3c97258de8777 Tudor Ambarus 2021-11-22  2721  	     SPI_NOR_OCTAL_DTR_READ) &&

Missing variable?

d3c97258de8777 Tudor Ambarus 2021-11-22  2722  	    !(nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP))
d3c97258de8777 Tudor Ambarus 2021-11-22  2723  		spi_nor_sfdp_init_params_deprecated(nor);
d3c97258de8777 Tudor Ambarus 2021-11-22  2724  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

