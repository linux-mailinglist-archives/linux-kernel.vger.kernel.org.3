Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84849298D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiARPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:20:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19456 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345401AbiARPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:20:06 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4UvV004811;
        Tue, 18 Jan 2022 15:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sh6Jm90NbcOJBmBqUkv/KhnTfcqbgHaRj7y7A887qqI=;
 b=fnW2gbizocKBmXG4DOE/fNjKQB3Lbflggfy04wbzb4rUUfttF7UAOu/Dp8UTaKENny96
 saxgAQ4gN4rdOzYWBgrCOr2YaMHmzlrW3gQXpKsN/8VTlGxj8DdQqmN2j0MTGbMf3B7T
 6LKqe9G0zrbCGr+Zotci1lJbkxNTbckcts0zhAV/peP67YeUTLh3mtx6MruUnDP09a16
 v72Nd5Kop2n4P9pNml8jPoPTiTra0woX7QkAv8Zqx+1/wiG9z8oSEpGRnQ1E7NkxuXX9
 z6+O+1TOpWwo0nuKexZSiNxDuBGEHi+5RAVxAHuxMmwnsMZR6fExYpjBNjxlT6Iz85oO 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnt6pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:19:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IFGMMq136354;
        Tue, 18 Jan 2022 15:19:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3dkp34bacj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 15:19:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxlZ8oCHK98Gv1OOyz4SH7sJvEggp6hTyC4JIp0MZkAJLWze6/i4b/iAWyGmwTLbw55GagY7VHHCo82GaLI6MkeocPGWxlGC7QflbcC/LRNC0TUeJKJ3D8JbyMwCYAWaofNvsaroIINskkQr3DS8GAIE/mTnLtD/6CzlaV3p+sAG7e09HkWCpqPMcXKivSVaaxmTiI7OpImDvIRjIZFrwYzTJIvwdf/cZrL8naqHU+INEPZr+XmG1QzybKJWudUQyBRg0CI37fW1JWmMscWy2ouN7Xyali8Nm74GCkQQKPb5hODkPxLvYqfTFZyBdp8tEnW3nndpoqywWhNFiwnagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh6Jm90NbcOJBmBqUkv/KhnTfcqbgHaRj7y7A887qqI=;
 b=nNNGgzQcde2rzJtAz5fleGHB+LQss6Mxcx/+WDvXS78wt8HEBSOeXhZKTsWwbveNaDk0W88H31ffJaW9hWXrcmYFDV9Ihd4yokrxFS5H8rUwmCWlCBOtysQvgc6JqOrSvC+TidxBObeseNkhGQsYwrOyKTDr/3+uv92W2fkTk7T3Q0XzJD1dFhQNHbElHmqDRzmjr4MzULV6MuuGft/ODjShQ7f4SYznPmRHYuh6qyi+iG9kwKGI7qPZqnG8gS745N8WhB4mydof5OptF2CRvlR8ieKv+ZSYmph7JRpRERTCAJO9uWd5zJFpcvz+axAwPy1TXdlZm1f87GxowuMuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh6Jm90NbcOJBmBqUkv/KhnTfcqbgHaRj7y7A887qqI=;
 b=Sijlcg0TH+ZwrqrBkmWMxdsWUkX+7Zr2GtxlDs8wOYUDTUSHVVREmkJfKJMiOIeGs83vJ1OEEBK5TSxPB/cGJMbtk/i5pmHxBn1YTIk6elj4hZy7fsNIdVrus8GBac5fTo0E+SqScrCYFcDVUghkJWYWtqHYVmhRxduxGtIHjbc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2189.namprd10.prod.outlook.com
 (2603:10b6:301:36::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Tue, 18 Jan
 2022 15:19:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:19:45 +0000
Date:   Tue, 18 Jan 2022 18:18:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Maxime Ripard <maxime@cerno.tech>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/gpu/drm/armada/armada_plane.c:124
 armada_drm_plane_atomic_check() warn: variable dereferenced before check
 'state' (see line 111)
Message-ID: <202201170744.uress2oV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d724a35f-e4e8-451e-9511-08d9da95f579
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB218964E0BBA866476F4308EE8E589@MWHPR1001MB2189.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pDi7vu3JW9n4mmyJ/UqQeAcYKMBNrw3T6xcR+92WODz9Tn3WnyoC83tVNuWAmXrpZ9QDz50lIftBZ1m6WY9eEo82AlbowcUjnoay1MgQfMuq1ZPM54vXBpu9LQuoMR7x5zS0/DUnrdviRQ6HEc1RCeHLo8fBCKNlzpBYbVWRjq349ilfxtAkqnOcuJVx0wkKvjTccqfB2gfYq9JyTyUpC8OxpRL2l9Qwo3HM5tTFDXgKPGuUWXI9TkG3E6L6Cuv0h1+svS/RUvuhC1pS0xXmCO5HsG6IPBLRpYwPyJqZTn1VlNyKR9BqKQVFlLUJstO367bpkn68pFJ0ElzBveM3DUa3vccE8fplm4WxIz3+KpUkUqLh+yX83rWczPpOD4wJBux9RCmmykG2tQ0+GMV75xlLyBckdEYEtFEMjjyF60Z2gqLTOEj8h9XOnkWPIFEYzYp9OrtDlFcSZ6FmvMlXowMqLNXIEgwR4+Jm+ibfDT6F2kw6/MSphoFWGFs2zGmpUFnmmTOuG5QLjnW3yGJofB0lGx6ok0AfIiTQwVmXkfSTFZI0Lle1Rf5yWaXn9S0ZDM+BvxX/L6/LZL1hRlKSTWqOlSG3dM+/cW6rkxm/qa4FZxGNZiZRl3bZNrClFDolsbiX1/5J5owlJ1WjR94F/VVoqga8GlwrbK0BznpP1J/T7/l09fnvgE/3VSIxh2dVzGJbtrnFPVbzJZjzNK5QqWM8tZzLuznlJDlUX8KTHZrgnxgDHnJ2t2HgH8CrQm5k/rC9hEBLBtj+9pRuuu2tsgV1nWgKnOppVfVryrcoHsKTUwGwKXgw7igTS12b6r6t2TNL8/e4H22zMkJvt6Uhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(6512007)(316002)(8676002)(5660300002)(6916009)(6666004)(8936002)(966005)(186003)(38100700002)(38350700002)(4326008)(86362001)(508600001)(83380400001)(36756003)(6486002)(6506007)(52116002)(26005)(1076003)(66476007)(66946007)(66556008)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJq7tfidSkXXWGyt9K0QVZm4i+ns4Sc0OW+BbANFIbyEbrsb8+ZqTTY8pQp8?=
 =?us-ascii?Q?cx6G8lXyvkjMr4IYwnuF5bkdxCkChB7F1Q5V9F3Bq7QNLwvE5Nng+eyXdDxg?=
 =?us-ascii?Q?YQxJ3tmaSHglfnXtK+hMZIbLslqJPaiJ9H5ZWJkQuEgqN/IHI+cjz4gBbNId?=
 =?us-ascii?Q?967yQM7ys1zwqrK7LHbnzVxZY0exensg/cHDH4PFhhWvhxxUzx27aA1/1nEa?=
 =?us-ascii?Q?zoEvX+jaQKLehl2oN/DmC71b4Nb3ia2+6WPtwFSjImD80Wk/ZrAPCWDU4jvY?=
 =?us-ascii?Q?slxCiGjggAcx3yU4zhMOtLV6KlbocOYMrzB553E8Ws04pezw8ZixnsAkhaMP?=
 =?us-ascii?Q?S57sycJCYhhKIvOgBA39tFY2T6GGReekhvv06DQkFG09f+pArT8odWAGcImo?=
 =?us-ascii?Q?TDx8wWCvBNnpp//KKm1cg2/qHqlartMS+Cy40Z8s4SjnI3slVNocr96EcXMu?=
 =?us-ascii?Q?FsZoQc2JI4hvcoKY/Hc+EaHbRfZxsyp5NpWXroTMccPDu70jV/kTJadcbWdt?=
 =?us-ascii?Q?H9Quy6Jp95Cbje2SYv2O4WPZsHZynwRQMTBfmYuoWhw89ApwKd3O3TdlpUYf?=
 =?us-ascii?Q?Aoa1XRlrGCSx2kTW/yWCJV7S0hZubMLL5gSftInVsmLUaGH2M5znGSJKwCVG?=
 =?us-ascii?Q?JJbLV48Kz+1mwO0MG3G7oGgCpM0hpxSMXWTZQ9/dXh2PH4HzG9qSrRTLnzCc?=
 =?us-ascii?Q?gcWag81LXTJ1ysIfkvWYkQsI20npamGpWjNX5mPiII+S7IyfO7IrT4TXxf0/?=
 =?us-ascii?Q?l9VGAtpqvp/RjnNrmJfwEmBBdELfb+no+nIgweR99xTMrruTpEV1PtLwcr34?=
 =?us-ascii?Q?z9Yf96PfMyZ3djaFu+6NzZU8S72AehRaQTf8xDauQteow6WALFyzcr7KohwP?=
 =?us-ascii?Q?wFdq+S0ZJ/befkcFv//lrqKqY+Yoe2tZURL/Gtm15Hp5KBZhTZxy602pZVsD?=
 =?us-ascii?Q?BkyP8hytB6oL8eiHrVu0t23S5uyvPuLyopW6tbbFt8aaDiFMVYfb5/vYLg6l?=
 =?us-ascii?Q?x/aIvEqOMceSN+wYpeaJuOOQGuiVovC1hXgmW+qGJ606jgl8M/B8KofbAG79?=
 =?us-ascii?Q?graPNiDDNGgIGX4GVrIOjG3FZSn6NMhbtXRg/cIy8W756G3kLREUGVKQvN5o?=
 =?us-ascii?Q?hZSqHoyKPDPAu+VYOVGKXfCW/KFkwZbY5toKJh/db7dBAPJuWiiYSKFTGbrm?=
 =?us-ascii?Q?AM0qhtLoIY4OFbwA/JSi2mSC3ouusaHBCnB7pnbq7SbejR8ELQoAuWBIX4Zz?=
 =?us-ascii?Q?NH5IPEhO2BCEEc+ZIOcRk382hUts/um/FJ+UEQGOYLegJ9ldvoKGbecqXUVm?=
 =?us-ascii?Q?jeABwPnXxQwtK2YPtT8Usp4IcMG0FwLNhj3QpyFJ3oSYFb6K9WnRprJUxSWS?=
 =?us-ascii?Q?W5oH1fpj+q3qY6wgQUi2f70EsRaF6PV2jcIq26KMtztYY/F643d2+hSsjJ8L?=
 =?us-ascii?Q?Nk2uhQeeHcmFxqMJE7FUUAdnJK03KyLmSNv1dlBpj6vqWJ6SU5vhpO8+lj1h?=
 =?us-ascii?Q?xA7PkaOCuexMKUnoIMQCk/B8fSBZI1BqaXP6ll7ZRqfB1zNnnDxRLQ34k+tY?=
 =?us-ascii?Q?IRX0LIsgUDf0l/8iKgMC3V70zwb7hjlygavVesSDKdcGDiALox7xIKTdvvFi?=
 =?us-ascii?Q?nrd+onplzNg5sRgTHY2Fxr/pCnJRR0gsOABQl83EXVXwcQ8QTnwliuowbQlo?=
 =?us-ascii?Q?91jgdN97IKEqOxwf19b1jnEiXO8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d724a35f-e4e8-451e-9511-08d9da95f579
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:19:45.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akBp+7tsffgvgcWdZlOYkYJwnS4do/n14LwJBNgi/0MAxH0irF6pLnOWHPHqMm0sRa/zh+obAhHy/HdDN8EGY0QlyTrFAssfwA9p6i3AmsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2189
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180094
X-Proofpoint-GUID: FxODOfF59W9lo6CfMaeNpBFsO6tNa_l-
X-Proofpoint-ORIG-GUID: FxODOfF59W9lo6CfMaeNpBFsO6tNa_l-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: dec92020671c48da231189eb06a5f755f492f87f drm: Use the state pointer directly in planes atomic_check
config: arm-randconfig-m031-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170744.uress2oV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/armada/armada_plane.c:124 armada_drm_plane_atomic_check() warn: variable dereferenced before check 'state' (see line 111)

vim +/state +124 drivers/gpu/drm/armada/armada_plane.c

d40af7b1ae23da Russell King  2018-07-30  108  int armada_drm_plane_atomic_check(struct drm_plane *plane,
7c11b99a8e58c0 Maxime Ripard 2021-02-19  109  	struct drm_atomic_state *state)
d40af7b1ae23da Russell King  2018-07-30  110  {
7c11b99a8e58c0 Maxime Ripard 2021-02-19 @111  	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
                                                                                                                         ^^^^^^
Dereference

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
Checked too late

dec92020671c48 Maxime Ripard 2021-02-19  125  		crtc_state = drm_atomic_get_existing_crtc_state(state,
ba5c1649465d40 Maxime Ripard 2021-02-19  126  								crtc);
d40af7b1ae23da Russell King  2018-07-30  127  	else
d40af7b1ae23da Russell King  2018-07-30  128  		crtc_state = crtc->state;
1d1547ec12bc7d Russell King  2019-01-25  129  
ba5c1649465d40 Maxime Ripard 2021-02-19  130  	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
ba5c1649465d40 Maxime Ripard 2021-02-19  131  						  0,
1d1547ec12bc7d Russell King  2019-01-25  132  						  INT_MAX, true, false);
1d1547ec12bc7d Russell King  2019-01-25  133  	if (ret)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

