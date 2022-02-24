Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E94C2F36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiBXPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiBXPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:16:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0FB3BBE2;
        Thu, 24 Feb 2022 07:15:34 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21OCYSId023288;
        Thu, 24 Feb 2022 15:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=rjwaHU6R2QCwvWQnjNi/nMx9sc//CEuY7x+tJq9H7KA=;
 b=hljkHzUPDIw1CmTkMs1yzY7MXk33/Z5waim8UuIhsACzH7cbtLGQhBj2zi1q2GMDIVqD
 1IsNjpjUYepLtA9400m+gvQbLhVNI+f/1S1fQxP6d40u0S6IZEsZ6xedGpAjin+N6fHA
 RDCc4CFeu8i9q23eeL6qXdipyiYT5FYZpNAkwGBMQ49p6KWQyBDel/TZfUNXWwVwaDUt
 qwj81iDydQduKrnB1neYqNzXoMsBrxrsSqlg9j2UwPTAzRbUuBn7pYQjJCVKhLweEOci
 QzqvWSv1iGrXzhgs9sSd7fx3Y9HAQj2rR3MiH3EmU9fgjWT61f3oqcPCLrog2KhDAIrG ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfay0n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:15:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21OF6uvm026947;
        Thu, 24 Feb 2022 15:15:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3eat0qx0p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 15:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgTTsHQQpmhCNIstuoWMXORJOWgAanPsh53xS/NHzv3cyzOZk3r/Ldw1+GzuagFH7T3sphlMOST8gp3miR1wsXQeupWH/Eg4nIpcoAvtj5pPCjTbxtfygBYoGyB4EZnGRUZ7Fy902cpZqS7hYNUvvLd9ejDhpHuN03uvcRQ52iYlIyiZqtpifWvBjKJSrEcLoJNKT+fsfKqAKSW5Jipqyb2+JFcMEz342B0nxJXfDJU62fELTrk+XSaIcPcdghJB+XevlZSMKsjTR+7B6fLNSacvaZni59MkNccMXmCt4J1nzzmh6PqyykLOq5g6IihPivZ+B33hOOKbfpVj/wuEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjwaHU6R2QCwvWQnjNi/nMx9sc//CEuY7x+tJq9H7KA=;
 b=SgnEPzp2hsH2soD1lW4ouqNQ55C/5trAx+tGYYUu6YpbeCn8xhqFf0tNH5X45RqXSbSF2HpdAsIViduhGl2nZ0fv5ZhxkVI1iVN5W30Cmixh36EHBJxEaxAdpAUsmQksfT+wGZ0pNG4IXqubzp9o6G0UWsGmPKZbRILxOiti0zUjp85Q5JrF0+XatANJwFRUrZSJ3ABCT9JzHhg0C1JXuTyS33xGlow5IObxvOpWB/dS+DGfNQr6kQjIIrS7ZznUMGEW6hqdegkufrFvsXnf/s2sTzw8vNdRe2/ci5PgicQl5ulHLZPdyQq0ANmW54tTbmXjZkQv+T93V6yf0j4J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjwaHU6R2QCwvWQnjNi/nMx9sc//CEuY7x+tJq9H7KA=;
 b=orMt2PwRVHEuCbOIrdXRBSW/k4+/dVEq9LwKblKvypfka6CqfaW+xEB0W5REmqeU21ZWqrHZARKIhWjKHH8UYuT52FxwBydJ+HVwwwi5pInAvp57x2PESn1wv18PYUcO1QaBh04A7WemBnR+BobPabRyzL9c8mT9BbGlQKOoBEw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1635.namprd10.prod.outlook.com
 (2603:10b6:405:3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 15:14:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 15:14:58 +0000
Date:   Thu, 24 Feb 2022 18:14:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, skomatineni@nvidia.com,
        ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Message-ID: <202202241115.MFFaDVz5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222175611.58051-6-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140256a4-b42c-4ca2-4816-08d9f7a86bd3
X-MS-TrafficTypeDiagnostic: BN6PR10MB1635:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1635D5E8455CDC692A93985A8E3D9@BN6PR10MB1635.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIc3Y2CVmrxfXvFG52SWCr4cO+kC0HdLhNzwgrxDrRpM5l13dPQuFlTBdd8Mr6MYqnLjSZWgeCMKZ4Yvo3Ouh+97/LI14S/A4I5wCJe4Ash583qrH+FR+A30JzEtTpNZQyT8t+Q4GyllSzpfWQNIB93dGNE26ZupnbPQZYhng+zF4B8gyBGKne66LUUMpHhCIlAbH9agLhVO1VwSzPCW09CmFbSR37pCZ1zk6FnoB4HnUrBClhgBO5OFATbAAi7GefjR41WG4wW/Gqj4PbOySiWOagaauyf4D5ejj4Bx7/vhUiZ+foLFIz0GN0S5pKttRoWLNffviIBwiPkaOyVbxGIxwXBSMBOd1L9OpM/HocCS1BIp58OWJLAguz7twhPsxCytYBGi/ZuJqj0IOQavixY55Rf6WeloA9esRvF+EdFmh+qkNbqRDoi8g76qS759KOadz2XO2Fu0NtzT7K+WKsiK91mXAqyrTPEiKUIFeQhcbfKhv2iqbCV49IyIQZ+J6DrMLgZSsM4UBc+BYEOWrAuJQB/AIqoZTxk3zJRAtGybCHghDiZusbc764ODaAarGqaMFTU9rnRkViKpqi14VPSbbzMNzjNjCrbnRSyNeI+bIWe5s/uEuPytY0mVwUkHW+po4wJopBwx4cj6mSWVhB3FsMipO1/QD5hAI9p1gKDfzYWTAg4metke94d8/hAKV3B1k4wLnBtEQEKBbPuBodKkxAk25A9+TadL5KSAzyI8MVaOi36UvYHbnclcZEywEZtYSEX2sxyNt22hjBHOjA7dmVbRvX++21BhE4fbSBvQnVmObC1fMjq610wuA5Hi3+4blz0JIMUWf3HHUo0dFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(26005)(1076003)(36756003)(38100700002)(38350700002)(83380400001)(186003)(9686003)(6486002)(508600001)(52116002)(8676002)(966005)(6666004)(6506007)(2906002)(316002)(4326008)(66476007)(66946007)(66556008)(5660300002)(44832011)(7416002)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOKl4GnYEoxIy8JAY4zrHsgaysEhYUWbmbgcKBNc+1PXLQ8+v1KnJDnZrpiE?=
 =?us-ascii?Q?ocOgcqi87H/oQn4KZkEhtuyQGdpPb2Phf6I48YRnnEfUZ0/u2ssOjeW1WQh4?=
 =?us-ascii?Q?Sk8kmEoi/JsZlesodXQSzL/0OJyOBXdGwR+YqJsZ+VjCqRgm8IGT7WNR1LnP?=
 =?us-ascii?Q?GD7M4EDbFyqZz8p63DaNBaLSANezzZ7sBfir36Pl+ja2DJgX4VR2Accm/cam?=
 =?us-ascii?Q?QBdKqN8/oOgYRoZQeNMYkx4nTKDZ9OqXggOYZAeE41z0OizGf/7mY+8SCd3T?=
 =?us-ascii?Q?wd00Cpufr140u2aXuZEqKVHR+o+a9IsWJLqmU5B7s84NUhQmJAsUaIos0BOk?=
 =?us-ascii?Q?pkIjT2Pj0c1nzzDxFf8RqaNd4SMkHXM8SiWX3OTZuzHLzuAePuXBJH2hOUit?=
 =?us-ascii?Q?cDMAkvD2D8HQmB4SLiFTThTgqr2096Ko71qX7L3nlmpQqZVVF1uSGeSOrKiP?=
 =?us-ascii?Q?sR2rrCGudZU5/mCj9w0yawjIk+fHekupNyzn1mFurP4JCfiR/L89iM6FE0r1?=
 =?us-ascii?Q?LxD1cXQdzi5VMVRCXvtf8Sarg4H3Pd0BuE5s6pkzqRnMpPrFSCUBSMBbbxMn?=
 =?us-ascii?Q?0UtaWveGKMkB2WFHh/zO89XdyKXWNbuTK1IkBVI/RT2eagOFy25vI4xFLGyR?=
 =?us-ascii?Q?CYskTUU7oZ4sfOBi17qh6Z5qXDTerE5NOn8FDNQnzKLYXDOtWN6DcnPPVAq/?=
 =?us-ascii?Q?gP2jLLkCuDm1qX/61FtyL+/6Brqj9N2Beuw8TVigwLduFe/vNurfKnszUEeN?=
 =?us-ascii?Q?Vc+Hjwdw2q01U2/ARjrpuJM2TslcVJF5Mizf3zFE6Dyl0WotkFHfkEnUgRVn?=
 =?us-ascii?Q?fHYbgvIZ8mj3c8JXhXqQ7/X8Rwpd4iy3y7mgOGxEhDpq8vHwHOgzaGuDmeRY?=
 =?us-ascii?Q?i6oN/4u0IkWui+N/OG/KBDtr2YTTislRmvI0zb+XtrwRvWO2/45OP5XhGwpq?=
 =?us-ascii?Q?E2/iffT6HmXicmRMtl8fQqp4gBDwmQSnEF1OBCN7L6bQUMRiU0rs6mwE/xyx?=
 =?us-ascii?Q?L5BCd5z6bUh/KBgOo/U+fLdQA6pl9uViCCmFsKM8fbdA6TFAIsmjjr/7im6v?=
 =?us-ascii?Q?tNVk+TZspEnuSQQYIbRbLf+27aNShIo7dgUgVqmYvTMLMvXZE7f2EFsT8pVt?=
 =?us-ascii?Q?MqZDvliAnv5YZ8drIM888XOKJ4Y0ry9oyWqC/3s1ms/GRb7sES8IxHfCtTTi?=
 =?us-ascii?Q?t5E9Zm9QGCtFzejSCeDKDRya6eUwxHF4hE2bcyfxpK/PmCOISRJfGQFMd0ou?=
 =?us-ascii?Q?Jv1mGWcE9nF/ZKMPOOTaFBwKm24/y/n2Q5ba3zX8KPDYbSyCpw5cqbisixxp?=
 =?us-ascii?Q?7AL7gUhEUzGomnhFuyvwTTUQ/H2LhYs3cidhFHxmR2mHhUnQ4hzAqQuLLh3r?=
 =?us-ascii?Q?egWZODDKvWiVwi5z2LwXfu1WvWWGKXvD3R59hHp+75LAB/IEj8pP0gxp8zS2?=
 =?us-ascii?Q?CmilrAGb2meDacZ41fYI1GjFj3pB7HNyZXnKTEac8+y4m2MZp3jPMERJWuCf?=
 =?us-ascii?Q?C8SUdfJxaD3nfh+gTyuXm61weM6IcmlnhBvCSiAcx2iWbP1JTZm4gdtf1eJ1?=
 =?us-ascii?Q?HcHOvP5Iv1a6F0KnW/eRcFlgYBWwE8lfSamryDu38z0kWOKGFp7y0CGb/A/A?=
 =?us-ascii?Q?n8YldCwY1DdQbdKEDJrrzu1bRtlNeeKw6WoJYY3T15E8POKcECcDOXNPjQR0?=
 =?us-ascii?Q?Ne75zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140256a4-b42c-4ca2-4816-08d9f7a86bd3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 15:14:58.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iJQxVB/deY+u3rKyVjArbeTrHpBo6RCBpDNY+C884fO3nKFz/OtnABnbW+p6/P8YSabY09jWaNeBMeWk89YnI/mPiQJUQESCRmE6f7X6OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1635
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240091
X-Proofpoint-GUID: D1o4UFh6bCpVhlOdqsg9nRysEavYhVRP
X-Proofpoint-ORIG-GUID: D1o4UFh6bCpVhlOdqsg9nRysEavYhVRP
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

url:    https://github.com/0day-ci/linux/commits/Krishna-Yarlagadda/Tegra-QUAD-SPI-combined-sequence-mode/20220223-015906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: riscv-randconfig-m031-20220222 (https://download.01.org/0day-ci/archive/20220224/202202241115.MFFaDVz5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/spi/spi-tegra210-quad.c:1148 tegra_qspi_combined_seq_xfer() error: uninitialized symbol 'ret'.

vim +/ret +1148 drivers/spi/spi-tegra210-quad.c

3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1032  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1033  static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1034  					struct spi_message *msg)
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1035  {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1036  	bool is_first_msg = true;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1037  	struct spi_transfer *xfer;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1038  	struct spi_device *spi = msg->spi;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1039  	u8 transfer_phase = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1040  	u32 cmd1 = 0, dma_ctl = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1041  	int ret;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1042  	u32 address_value = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1043  	u32 cmd_config = 0, addr_config = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1044  	u8 cmd_value = 0, len = 0, val = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1045  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1046  	/* Enable Combined sequence mode */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1047  	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1048  	val |= QSPI_CMB_SEQ_EN;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1049  	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1050  	/* Process individual transfer list */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1051  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1052  		switch (transfer_phase) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1053  		case CMD_TRANSFER:
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1054  			/* X1 SDR mode */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1055  			cmd_config = tegra_qspi_cmd_config(false, 0,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1056  							   xfer->len);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1057  			cmd_value = *((const u8 *)(xfer->tx_buf));
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1058  			break;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1059  		case ADDR_TRANSFER:
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1060  			len = xfer->len;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1061  			/* X1 SDR mode */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1062  			addr_config = tegra_qspi_addr_config(false, 0,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1063  							     xfer->len);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1064  			address_value = *((const u32 *)(xfer->tx_buf));
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1065  			break;

It's easy to imagine paths like this where ret is not set.

3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1066  		case DATA_TRANSFER:
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1067  			/* Program Command, Address value in register */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1068  			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1069  			tegra_qspi_writel(tqspi, address_value,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1070  					  QSPI_CMB_SEQ_ADDR);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1071  			/* Program Command and Address config in register */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1072  			tegra_qspi_writel(tqspi, cmd_config,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1073  					  QSPI_CMB_SEQ_CMD_CFG);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1074  			tegra_qspi_writel(tqspi, addr_config,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1075  					  QSPI_CMB_SEQ_ADDR_CFG);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1076  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1077  			reinit_completion(&tqspi->xfer_completion);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1078  			cmd1 = tegra_qspi_setup_transfer_one(spi, xfer,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1079  							     is_first_msg);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1080  			ret = tegra_qspi_start_transfer_one(spi, xfer,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1081  							    cmd1);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1082  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1083  			if (ret < 0) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1084  				dev_err(tqspi->dev, "Failed to start transfer-one: %d\n",
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1085  					ret);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1086  				return ret;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1087  			}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1088  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1089  			is_first_msg = false;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1090  			ret = wait_for_completion_timeout
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1091  					(&tqspi->xfer_completion,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1092  					QSPI_DMA_TIMEOUT);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1093  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1094  			if (WARN_ON(ret == 0)) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1095  				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1096  					ret);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1097  				if (tqspi->is_curr_dma_xfer &&
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1098  				    (tqspi->cur_direction & DATA_DIR_TX))
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1099  					dmaengine_terminate_all
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1100  						(tqspi->tx_dma_chan);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1101  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1102  				if (tqspi->is_curr_dma_xfer &&
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1103  				    (tqspi->cur_direction & DATA_DIR_RX))
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1104  					dmaengine_terminate_all
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1105  						(tqspi->rx_dma_chan);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1106  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1107  				/* Abort transfer by resetting pio/dma bit */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1108  				if (!tqspi->is_curr_dma_xfer) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1109  					cmd1 = tegra_qspi_readl
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1110  							(tqspi,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1111  							 QSPI_COMMAND1);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1112  					cmd1 &= ~QSPI_PIO;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1113  					tegra_qspi_writel
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1114  							(tqspi, cmd1,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1115  							 QSPI_COMMAND1);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1116  				} else {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1117  					dma_ctl = tegra_qspi_readl
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1118  							(tqspi,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1119  							 QSPI_DMA_CTL);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1120  					dma_ctl &= ~QSPI_DMA_EN;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1121  					tegra_qspi_writel(tqspi, dma_ctl,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1122  							  QSPI_DMA_CTL);
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1123  				}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1124  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1125  				/* Reset controller if timeout happens */
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1126  				if (device_reset(tqspi->dev) < 0)
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1127  					dev_warn_once(tqspi->dev,
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1128  						      "device reset failed\n");
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1129  				ret = -EIO;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1130  				goto exit;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1131  			}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1132  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1133  			if (tqspi->tx_status ||  tqspi->rx_status) {
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1134  				dev_err(tqspi->dev, "QSPI Transfer failed\n");
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1135  				tqspi->tx_status = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1136  				tqspi->rx_status = 0;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1137  				ret = -EIO;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1138  				goto exit;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1139  			}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1140  		default:
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1141  			goto exit;

Or here

3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1142  		}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1143  		msg->actual_length += xfer->len;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1144  		transfer_phase++;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1145  	}
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1146  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1147  exit:
3b852b330b0b83 Krishna Yarlagadda 2022-02-22 @1148  	msg->status = ret;
                                                                      ^^^

3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1149  
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1150  	return ret;
3b852b330b0b83 Krishna Yarlagadda 2022-02-22  1151  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

