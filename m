Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF324BDC34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358131AbiBUMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358086AbiBUMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:38:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03219291
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:38:13 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9YEda022589;
        Mon, 21 Feb 2022 12:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=J6akeg/cCDABU6xZTo1p3EcQyAzg2MCZ9jh5Rl6dlac=;
 b=kc6p5+UfWnaNFDK9GZH2ITb2M7wNlcIx94v1625/qQcI1VMr/EACooirg31mFHrVOP4X
 dRtz17sEWsyAVw2pfLv3U6GRIWn6pxd5SJ/9aLu5+PRJyKmWO4W0UJM/pszyXKHfpfqw
 5anLJeNZ0we6GAQ1u0kSdOagDaTwvZwNneVLQT7KBLoJSyiHJYWI5v1zPDu3tNCF4tDl
 mnqnEAruSEMm632A2L4O0QlpfyTbj+u8O12pkFs9nn16QNXrmvFlJwoqWzaSSWmet8Ny
 JGIdT8opk+JL8ibtRyXEnDX480vpgZlgRU9VawtFZJcf4VgaD+swUinYXL41pLtl5oGP 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eaqb3c4n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:38:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCaog5079589;
        Mon, 21 Feb 2022 12:38:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3eapkengk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3DKEvxq9WufJnPo6jgEBqiG/KaM0Ru1PqJjY/sdSdARkB2zR4xDQOfDnhKKFI07PtZbIBWZXsjSICITxnGsi69SktWJKPVMTGjEcbwTtDvJdkvbi3XiEvENzkJstk4RCJpA1pPh8Tn5AzzVMkOQ2c/YZK13PTn+IMKRas6OP63BRfzFBckjxf5c1aU5N2hG2AEf/fxEpXPGl3ybShJrv5d/OqqqRklicTn+O2pWQuxhRenI0TE4iczKpCEwWW0tix6sQeAURgroATDBr3gTTEgECd4g5uhkxB/MDw0LtTOno8Uw7+FRsahohmErnbrAqUivH3PkehrWQu3mbFVQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6akeg/cCDABU6xZTo1p3EcQyAzg2MCZ9jh5Rl6dlac=;
 b=FiI3UwIz6RkDnRNLNlYJS2vzpK/Tt0u8H52o4rxfTraqqy/EEAHzy/7SdWvpnE+3A7Au4Hb09sMU7vJzB2WGj6GpKE24whesf5kO8Hs4O8w43nMr7u8DwzCI3yEq2McGT32wu0J6SZCxrh/JpZZKLxu5L7qIFw8kFmfaHgwvn3rVLflY08OqpzB6WDzG24izOc720LlA74JGhZZlLZYteR0D2EaOuOtBxIxaMaIgO4eilgvTSyr1Bp4PqPA/wOhzygpW3LBK9a9Ewah/8UTRxhW+y8SP4XUq5KxTsiK/BSyoSIpkC6t5OZzXWr+qrMAD6ZxKmeNGWHqRclrId+T59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6akeg/cCDABU6xZTo1p3EcQyAzg2MCZ9jh5Rl6dlac=;
 b=ZVqwsmIX7w641D8TmuocuN7LVKFiLdLBm0shRb+abofMgI+kA8czl2nM00g5nPb9iAWiOeBaTz5nn+N8E1u/u8IP2ncESGHD9kTWmkBt9r7np/3Vcx40IAfL1oTCTGbSDXxxrH5m44D2IIapkdfSnwFz1tXIBTN5sNLn0kkdFik=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1655.namprd10.prod.outlook.com
 (2603:10b6:910:7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:38:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:38:02 +0000
Date:   Mon, 21 Feb 2022 15:37:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Maxime Ripard <maxime@cerno.tech>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/gpu/drm/armada/armada_plane.c:124
 armada_drm_plane_atomic_check() warn: variable dereferenced before check
 'state' (see line 111)
Message-ID: <202202210558.AzkWUCZf-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0097.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10cfcda-47d6-4853-f9d0-08d9f536fff8
X-MS-TrafficTypeDiagnostic: CY4PR10MB1655:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB16551CB93C518870D6B670878E3A9@CY4PR10MB1655.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fV09+2T+YS37V388X3zoCRJcRPv/gB0ZNKQLNZwryYiTuwWNKi5ayHKUAF3jyUgrQQmHsb7t4Mxvdh+lphOuwp+VuBmNqG3K1/5VGtJFWbFe4klfNoxup8iPW2z1i3iABXaB+Ay1qMzOAUPkojggZ98fH9NqYlEi/4IdaLNi8vzVG0oJSqogOwloBS+KLmROeaZcIgktzLCDU3mqkPf1qWDwvgfn5Ao06UIOtFg1KEx+A6r/6SilHBowV7zJE7Wm06rhJTsNHGjNXCd9fyWv9Vm5ea9YWBYOILG3jT+yB5i6az31VLjP6ySqkMHf6yjBdh7/+K6Yr85jRI/Q5EGqk6RAtCT/otIdzUmMQCk4/Z2WYHvCUJaxMplVw72JRB4Lor+e57LiGRM37oYQObuS8M6/CGzu8Qri04moOB/Y1ompNPUH7KOC0YlE2YCZFb8ZClMH7PuuQhsGOSuHIkolwhyJ2IUIrO2VPI5N4HiCjg54Z2bnuV2vCwwajknrPucInFGu/G9VP8PBPuPL5StypEfGY7P5Dt2ddCcy+cXocrjOlXQUQ6P98vhl4vHa/eTA4eHqKFRF8+TbXfTpVgZDD/qo4TBJYBGUvfhB8xE6hxSaDfmdj1FGlL7QlS+tjQ9TxZBePlFwjpF/tFEQmGFW0W+t2J4PoeOJnROIfxV5lp8RmKlLoh+APX9A1exNk/9k6cI0oyhLiHukWtU0204gg7prbvRfmQhEmWMsX71ZZHB302z1Zkqc51vP0strEkN7kImczRWs4LvfEkxWxoY91KePvJWoQpWEIr/9gY/Wp4booWuooPNPdor5s3BYqJfexz+ABXAyn5vjKUFiJx5qmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(186003)(26005)(6506007)(66556008)(6512007)(9686003)(66946007)(8676002)(6916009)(1076003)(6486002)(966005)(66476007)(6666004)(86362001)(316002)(508600001)(83380400001)(38350700002)(4326008)(38100700002)(5660300002)(8936002)(2906002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeQljx1/cBuEtxoQv9Y/N1bJUFqcQA46Rd1nH58TmQPUnRoizUYFjB9V1ZwE?=
 =?us-ascii?Q?yN0egPqad3zX6hjN/pA1VVV8PUkweH+/w+hcR+w6Oy2NmU4u0l5DmdQtlXiv?=
 =?us-ascii?Q?p3oW2pDEAu2x2vbPczdRDvXLcuA9uTr9T3vT8VhptnF16daVKoWvZSVK0aTB?=
 =?us-ascii?Q?GAVpWlwiI1ZNylYImQLDu0sEfeAwXTc55VL5AX/NamTfSKq9PkS6tUIqdRE9?=
 =?us-ascii?Q?H+WmJSx8T7DPupA+Mi+5punkW7axcFoF3gKXuTbcRpb3A3mC6sjP6p0FnY1v?=
 =?us-ascii?Q?CxFszHPgMqEcOS95TShADbyHu4J//8UmBn8dJfRt9Q65nA0LYXRSdOPSa10O?=
 =?us-ascii?Q?EEMUY1h6yaawmuAYcDhfOHmqKkKE63t7rV8pcgjdmTMProLSJhNRDs8jjf8l?=
 =?us-ascii?Q?/ELHsFPQx0M89bZGS+XsmrHRgu6jPDhA0miHmNGrSyCfuXMm+8yZvtaySifp?=
 =?us-ascii?Q?eC0LiKqIMZro2vLNW9U708Z6z6Lb9AGRdzhiVLB55ZVtVuIugF5Bs+o1nPqp?=
 =?us-ascii?Q?1vOo+Yq05U8Ixbgh9G3v+iArfTfIh61aivyZs5wAj9CRYrvo4369tUPlXhkx?=
 =?us-ascii?Q?jMK/OCDXdU4ZNJAFj63wrpDnVHcippfblLNfUvSPWgm3Uzj6lTnp57nWVFtv?=
 =?us-ascii?Q?jpCOQyDvmaoIFsKHiRGf+FQA3SjvO5AYvgultjHYmEdyXEiZyRywXcnXaRO+?=
 =?us-ascii?Q?8Pxh6HjAkMfF49uzEtAThMEX0SLcccnXnh8zNxdTcO4vo9x2rSNeKdwmfIRE?=
 =?us-ascii?Q?16GQxqOktUgaPkXV6/w+aBrAyBQVaUlP1D7FqKJD2ta9KsNlJanbcgBUJGKj?=
 =?us-ascii?Q?JdHOOjDvb+bz3fsRcT99ej3EjE7kBkmCHtm9pL/6wxd4b8h464hC6FUQYU/W?=
 =?us-ascii?Q?beRXC2ulyo8BZ3g/dytL4YQs87kCLBdezBBItRR3k/4vN/ga2+9ebxzQHd0y?=
 =?us-ascii?Q?QTambA7ZcNppRm+U05A13EOADAEZUSb0GVfQcssPd3lCJII98FbBBeAUgA4O?=
 =?us-ascii?Q?WHQEjIbwH/qPku0oSWtjxldzUnTn8IPPC0IixADECNntQbBZbEmkEU4Wn6BD?=
 =?us-ascii?Q?4y9VRkOj6AqPkwbzcPpv4/py0w8N3vvJQtLq8raNWSkW9y8oLwR2Lew2990V?=
 =?us-ascii?Q?4tnUcWGQJ79o9048qu7SLsEvDKFObL3+kb/KlALaQaNERWc4OLqiANM5+UUC?=
 =?us-ascii?Q?YbSQF5W7V55BY/RNv2T5dtg67i2QMc2yTFI4MHL3QJvEiyeWE8dTRwQ8vD61?=
 =?us-ascii?Q?u9NuYIrD+y0NzVlDgKrITIWVhxrTROjdfJ9SMNLgZUk/se4dbIE/6tvE0ECt?=
 =?us-ascii?Q?/NZNwpSQCRiwNGac+VygXiEFPGMbWpgxLqUjMH8iHFFd95XioonKF75zNz7J?=
 =?us-ascii?Q?Z77waEZA/fQQ2oPrOq/Yq2ObaGgGdOnhOsslc+BB1Zxl9F/Htg8Md6af9P8z?=
 =?us-ascii?Q?IxqABqddsHxLMJjTxKtvOmszd81Q8BXuW2IW5AN0LWbY8xfuEnAOtOzr6ZNW?=
 =?us-ascii?Q?zcTx2EkcH2F+QUuU5Ojh1lHmGfuwrBgDP9kndsbg+JYecEQdRDVhDsevV7CF?=
 =?us-ascii?Q?mOltakH8rNYVIyd9HrE7XWcv0PER0oPVvMfzzxl3CBDGlIvcDkZiSJ8Vx148?=
 =?us-ascii?Q?eV++iUx5vEu3kO6LC1uUyhHi3cCHkOwD4kAtgWSmQwsw7Ua3qQFNw9G5L30B?=
 =?us-ascii?Q?dX9OZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10cfcda-47d6-4853-f9d0-08d9f536fff8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:38:02.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp2+kVa1E94OHul0mKL8PkIS3Bkcyyt9VPi4m0eiLQWjizMJurBFoxNB82RKlBfrT4dC6OAypmqvxplp3lWQOPL4Eo4LWjPGm/MBWzsLs9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1655
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=913 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210075
X-Proofpoint-ORIG-GUID: UetfUPz_CRH_9DH_StKcfe04AvPzEg4R
X-Proofpoint-GUID: UetfUPz_CRH_9DH_StKcfe04AvPzEg4R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: dec92020671c48da231189eb06a5f755f492f87f drm: Use the state pointer directly in planes atomic_check
config: arm-randconfig-m031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210558.AzkWUCZf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/armada/armada_plane.c:124 armada_drm_plane_atomic_check() warn: variable dereferenced before check 'state' (see line 111)

vim +/state +124 drivers/gpu/drm/armada/armada_plane.c

d40af7b1ae23da Russell King  2018-07-30  107  
d40af7b1ae23da Russell King  2018-07-30  108  int armada_drm_plane_atomic_check(struct drm_plane *plane,
7c11b99a8e58c0 Maxime Ripard 2021-02-19  109  	struct drm_atomic_state *state)
d40af7b1ae23da Russell King  2018-07-30  110  {
7c11b99a8e58c0 Maxime Ripard 2021-02-19 @111  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
                                                                                                                         ^^^^^
Dereference.

7c11b99a8e58c0 Maxime Ripard 2021-02-19  112  										 plane);
ba5c1649465d40 Maxime Ripard 2021-02-19  113  	struct armada_plane_state *st = to_armada_plane_state(new_plane_state);
ba5c1649465d40 Maxime Ripard 2021-02-19  114  	struct drm_crtc *crtc = new_plane_state->crtc;
d40af7b1ae23da Russell King  2018-07-30  115  	struct drm_crtc_state *crtc_state;
1d1547ec12bc7d Russell King  2019-01-25  116  	bool interlace;
1d1547ec12bc7d Russell King  2019-01-25  117  	int ret;
1d1547ec12bc7d Russell King  2019-01-25  118  
ba5c1649465d40 Maxime Ripard 2021-02-19  119  	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc)) {
ba5c1649465d40 Maxime Ripard 2021-02-19  120  		new_plane_state->visible = false;
1d1547ec12bc7d Russell King  2019-01-25  121  		return 0;
1d1547ec12bc7d Russell King  2019-01-25  122  	}
d40af7b1ae23da Russell King  2018-07-30  123  
dec92020671c48 Maxime Ripard 2021-02-19 @124  	if (state)
                                                    ^^^^^
Checked too late.

dec92020671c48 Maxime Ripard 2021-02-19  125  		crtc_state = drm_atomic_get_existing_crtc_state(state,
ba5c1649465d40 Maxime Ripard 2021-02-19  126  								crtc);
d40af7b1ae23da Russell King  2018-07-30  127  	else
d40af7b1ae23da Russell King  2018-07-30  128  		crtc_state = crtc->state;
1d1547ec12bc7d Russell King  2019-01-25  129  
ba5c1649465d40 Maxime Ripard 2021-02-19  130  	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
ba5c1649465d40 Maxime Ripard 2021-02-19  131  						  0,
1d1547ec12bc7d Russell King  2019-01-25  132  						  INT_MAX, true, false);
1d1547ec12bc7d Russell King  2019-01-25  133  	if (ret)
1d1547ec12bc7d Russell King  2019-01-25  134  		return ret;
1d1547ec12bc7d Russell King  2019-01-25  135  
1d1547ec12bc7d Russell King  2019-01-25  136  	interlace = crtc_state->adjusted_mode.flags & DRM_MODE_FLAG_INTERLACE;
---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

