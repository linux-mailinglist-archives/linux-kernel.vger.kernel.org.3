Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7074D2D24
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiCIKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiCIKcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:32:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0616DACD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:31:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298KOWE028053;
        Wed, 9 Mar 2022 10:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=uEHm+OeHFCHKo+7sB0RLAVU/bLm5mMOQF1bkFsncQBc=;
 b=Z1Sgsq6VmN4SGnrWBOyzTPU6ECfeKPS3HnmJT5P3a+FaiVdNx6B6gPh+ygmTDIkBoHgm
 sN6ogGhYhZonNQ9X67S0Jgvymfc44x6hSsbeorFkOI9MWdhpxTHjNe52tbLte92ShqSw
 labnwS9pDZwkHpvqwSBsGn4UQ5BOhE8zLx3YhIxm6Vpg0he4JIkyfg5guiB0JzfluCXl
 sr7NyRNNN7XU3lkkSGxaA+KpT9WPREm+KNbMMUJ7urTk2Lwuy61C88k0Zoad7W0+MP+Z
 AylBPHBeX40fZi76vme4ULtPm1xhwtcWTM3/s8VQxdnIPSwNhnSocKiKEPAHWMazqeWC 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2hs2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 10:31:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229AFfkY035087;
        Wed, 9 Mar 2022 10:31:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3ekwwcr290-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 10:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZg8a6fKYBfX/vMTOUMDhOMccNcxST8K9cLQWRaeIt8Q6xDGXgVDMaIj/PyMhbL+d2ztuhI/KV81LIY0JGkpXAAdNafGaU07x8SDGqZgasCN9iMVAhc0TJLxgMWBB9roVKBvZIJYaXha4cLR51eGl5sVWmNGv+7vedPaeodvVcQzNi7ukFzFCehJSUD38SuwBNGJwnEPqL+xhJcEt3xggyneHEBIrtMt1yPURs5IC0PihJN+lMo8bg9FIBFKzte2KebmTZRVLauqxe+gb+aweGvdWcxEJoKTsize4JAsagaKEilQfl+rWztKAxMnpGfnZoC8CV2oImWAnTrAmaK0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEHm+OeHFCHKo+7sB0RLAVU/bLm5mMOQF1bkFsncQBc=;
 b=k5bck9p7woJUv4lqdwAY8trA6Q+YEDISkGhgAJTpxAAZaxRrz5HP0XqrwlMm3JKDS1n0KBwgc+QP+fM3B2V+dLT2aXBvStmy8MAuOtMuwtC01VXMmfZ8M3BD9DP8+p1gEav6QdUnHNa1lOK0vWnuhGsciw6WkRKMUKx+9iL7DHNPa2lW21G2bvr3Nt+zBOVn3sT6comi2Q2W3gAzyxUYUawFRQxw3F7J0jC3EVtyAuFPGUTCUE5RxR8z97fw2hPrR6pYnYEnLkW3A+YlU4ZhVcu7ny/7wgoAWFFxkZ/0473/7QxOLPRweUB1p4bvmDTPSnl7cX6CAvPJgnvuP9+RXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEHm+OeHFCHKo+7sB0RLAVU/bLm5mMOQF1bkFsncQBc=;
 b=wUERcWe0p1IYm8RFDKisMmLlCT+shu9tuqj4V4V1NaS2bWsJcW5MIBYC/hI/S/dgrsVPyWe8HF1Zqq0HbG9puD+DNf1P5XlGnXIbPdTLCeGZvILgI7LktohVjW0NA1k+V/3jHQt81pd6YdBpTwPSZrXc5IBTgW6vBG0L6lorGZY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB3895.namprd10.prod.outlook.com
 (2603:10b6:610:9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 10:31:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 10:31:34 +0000
Date:   Wed, 9 Mar 2022 13:31:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jake Wang <haonan.wang2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1018
 dce110_edp_backlight_control() error: we previously assumed
 'link->panel_cntl' could be null (see line 977)
Message-ID: <202203091542.wWXRk9o1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0083.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa7e4c0a-c80f-4f39-7cfe-08da01b7fb7b
X-MS-TrafficTypeDiagnostic: CH2PR10MB3895:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB3895DB3F07744315A33FF5928E0A9@CH2PR10MB3895.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssRzv8NFuRWmoln3I6a2c2OxosujdgRvVhMhjlW0+4pUM9SWhETVWC2ergiNDqwN85gH2x/MVsrCqJKZCpzL1bNat630fnepI/qP25AtDqXrabEfHjuPSyJylpbYYnwwRCIsCD9wqJB83mOJQX4Lg7C0um5N/UR2CDmtBXOrN2DElt+Kbajo7xGaqJYce2cDJho3QWLE53AGcj5mGIPsAAgNr80QT3LTFUxZ2piNanpV7JE+5NWMOb37if5YNyCrpAWgZZzitsXFIeEUg3PbVCa5FCcidSLvIoFpYAi/Hza7NGGKyLvmBiZvy+eLdtwAn7OqEfLAIMhmU9iloxkBU7BxRaVCwS6iheoDVZY/d8ULaqTPgeu3tRdHcwijiKUtYL1+uxfNNXASbJ829jVmsW+a2LJ7/NSvH6NkNIrkleUA9+NP+R9iZDaAQWynWlN8EXh+G2QjOQgbPmv7nKa1vplyaMQqaJCyac/bieI6GKdJhCgZRGOBm/xqXAxAf2hs3vPTT427yz9f+duZfwZKJV45QKa/5sYvZV2ZpqJ9BkXpknhWyvZQw8BXUwLmG9c++02i9ZIr3D/vnIuHg0ktVUsOt3YiMSbQfSYhSoWsivwjWQyUGUAWI73I50oZa/UyurZW2yN+Ojzj3LP1/HCY75lD1DVvERlcbftm3tiVnhC0QCMnZ/9s/EoINIp9ZxP9TtBTkQELifd4ZQB3Xid7BMFaRAff5AM3LwjKzBqA/sI4syUvGbsS3q/b+mJIgLyRfZIIC+TsiBMpdJqtlFJ523IoSNDhsbryACK5ZyzlGnJ13GFQ6FEtOaCcNokmMoD44d5IDkXcs3EvRAVHXz0Q7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(966005)(6486002)(6916009)(54906003)(316002)(38100700002)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(6506007)(5660300002)(26005)(186003)(1076003)(83380400001)(52116002)(4001150100001)(6512007)(9686003)(6666004)(36756003)(44832011)(86362001)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APq+k4W7IvPIydRGi+3KNPR7AnoiEScex1q0ZycPxQl4K6Ji6mo6RyeRbIiu?=
 =?us-ascii?Q?xmVabE6M0uznNTkE0lrb+6cMvAxei6dl++eyGJGGROTHbbj+0PHfYesmRBwc?=
 =?us-ascii?Q?GuDu9fem/Y09GQNYNUeyw2bHXGSVMljYEtW005I79zqnLqWukKZB27RjuOgi?=
 =?us-ascii?Q?skEjTxzFJ5Ay125L6BS4A/3OpJ4MGsplRK8PoUnsBAeHkzADzFXeFzTdrfm9?=
 =?us-ascii?Q?vCSypDLbXbuPaTKw2ooL4bQYRko1IBJ/xR7XcCTFmcvVpFH1cYiZ9yh2QpZj?=
 =?us-ascii?Q?PNfInTtCVaVFIKJb3eLq+joegBPbhcmCrIRbOebpUYAk84vgfMUYAagUXwXB?=
 =?us-ascii?Q?I+d+GGL4kXRlXVee+y7MSEjhrHdVx9rEhOfEV+K2DZR9A31YBPHVk4QACY+c?=
 =?us-ascii?Q?iFYVPQC9rhJhhzraooy/PTZ1Nrfpumpq6S57dGeusoO3aggWxY3NaJ0zVC30?=
 =?us-ascii?Q?sV+HQrUJhjZt64kwHoM1rl5eqAoDFELlVsQGr65EXDGjnlCEAy6iBvg6YP3W?=
 =?us-ascii?Q?iRqAcFjVzVTYnqVjBT7ZtL3J0ecjb/gHRcxAKwh6KOurzrrjkL4xgGOE4baF?=
 =?us-ascii?Q?3gU2fVdTMlqgcGWn98jnI3svop0uGUE7vSnsheHXHygMyjo/iypnJm1O5SgN?=
 =?us-ascii?Q?qQ2i6BYV0x/YanAXT6bYno+tiWlGW1u3y4LyWiu9kXaw6ifU9pdh5r4LJ9Qt?=
 =?us-ascii?Q?sNxmpP6IAwIiRlgzhdU6oRHi2GaPSaunYaybpddGoKAabxG5xX1KsHiUkM74?=
 =?us-ascii?Q?jtAm+wEa+Y7LApDowuwYN5AhnLSsnrSSyMSw7DGq0y6R/J8YES4W9BxDh+1k?=
 =?us-ascii?Q?p1fm9ZZmynuHJKAND9v/Y0mDKiv9NESK/SYETLHfS4IKSl69Md/GR+lMbxNW?=
 =?us-ascii?Q?4LjGruP1JonL516UrPtgXfsrifjdA56mBgxV+d3cFbrElMPpD2goOOhwso7A?=
 =?us-ascii?Q?AS/jYwQSLDr6q2icfKf3Ir8e7g48Gwumwy4B/2h1HFJwgoXkJlMLB2ha02jZ?=
 =?us-ascii?Q?WaSYXySfKlgMft17enaQ/7c4BoIv5S0QktlXd6NoHgy/oX9EnXkeq+0TVfkl?=
 =?us-ascii?Q?o7hSjb6ZzZWBVHuWAlE9mNlrWHJ/b/lnzexMkjNd5Y7+MpEcZPXRBTLT68o4?=
 =?us-ascii?Q?8Rkk1pGcBBvqcW0ou7drzCSPcFNyVvtDseZl4vPpS22SzgvokQU0nsufP+At?=
 =?us-ascii?Q?08qidRnsXhcBcBlDpHz3mPTyg+BwxJRhqK7jgJ5CMS9oNqxN+RcV6T0Mng/i?=
 =?us-ascii?Q?eaoHcFzoai1CRJKpHCsAj71r8DRQRDP1HfGD7NJlKQxlsKwGzi4CiO1HQqKK?=
 =?us-ascii?Q?tT+l46aP3g0Xj+dk+en12Cqvi4NdmKEtusenUsJAkDXhpWRl7I/lrO+/GAOr?=
 =?us-ascii?Q?pemYDtQ+YbUAcR6WJ5bQG6yd80fkN+NXb689TMBnnw0QoTPnn4UjSL0klGMv?=
 =?us-ascii?Q?WOaIKYluUF/Vn5kRJkmE8vMgKP64i/A9IXV1rnmc3FsVngMe9dbfhuk+FJCI?=
 =?us-ascii?Q?fLhIbgw9f0jFSoLPc5QF50BHQeMTkQHgDWh+FbysQu3xzDKZGw8r/Iy6vg4W?=
 =?us-ascii?Q?Uhqr5u8G6HrLiHytFDhHEb/83XepVFzbioGu7abHjQkQ3CD9QeF0a3xKnBJU?=
 =?us-ascii?Q?DI2lI/eEtcNYE9UlY+t6N15YqjRg80+AZ9eaTW/Flupg/GksBi+RSAlSjYcm?=
 =?us-ascii?Q?uSLD/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7e4c0a-c80f-4f39-7cfe-08da01b7fb7b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:31:34.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6CHNpQxLr+ZimfMs/f6oC0w9psTXUlMgVr41V4NzpvojeSxADImLSgLnlN8x3MvfkafThMvXP9t6li4y4bwz/6M+InAKF/f0NGGvsX7T5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3895
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090056
X-Proofpoint-ORIG-GUID: EckuCU1pjPMEpA29crQoLHdSd-kHEr6k
X-Proofpoint-GUID: EckuCU1pjPMEpA29crQoLHdSd-kHEr6k
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 06ddcee49a35981835e04910bef462a09f108984 drm/amd/display: Added multi instance support for panel control
config: powerpc-randconfig-m031-20220301 (https://download.01.org/0day-ci/archive/20220309/202203091542.wWXRk9o1-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1018 dce110_edp_backlight_control() error: we previously assumed 'link->panel_cntl' could be null (see line 977)

vim +1018 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c

8a31820b12187c7 Martin Leung      2019-07-09   963  void dce110_edp_backlight_control(
5eefbc40173644b Yue Hin Lau       2017-09-15   964  		struct dc_link *link,
5eefbc40173644b Yue Hin Lau       2017-09-15   965  		bool enable)
5eefbc40173644b Yue Hin Lau       2017-09-15   966  {
069d418f412ec4b Andrew Jiang      2017-09-26   967  	struct dc_context *ctx = link->ctx;
5eefbc40173644b Yue Hin Lau       2017-09-15   968  	struct bp_transmitter_control cntl = { 0 };
06ddcee49a35981 Jake Wang         2021-02-23   969  	uint8_t panel_instance;
5eefbc40173644b Yue Hin Lau       2017-09-15   970  
069d418f412ec4b Andrew Jiang      2017-09-26   971  	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
5eefbc40173644b Yue Hin Lau       2017-09-15   972  		!= CONNECTOR_ID_EDP) {
5eefbc40173644b Yue Hin Lau       2017-09-15   973  		BREAK_TO_DEBUGGER();
5eefbc40173644b Yue Hin Lau       2017-09-15   974  		return;
5eefbc40173644b Yue Hin Lau       2017-09-15   975  	}
5eefbc40173644b Yue Hin Lau       2017-09-15   976  
014427adc5565a0 Sherry            2020-11-11  @977  	if (link->panel_cntl) {
                                                            ^^^^^^^^^^^^^^^^
This code assumes "link->panel_cntl" can be NULL

014427adc5565a0 Sherry            2020-11-11   978  		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
014427adc5565a0 Sherry            2020-11-11   979  
014427adc5565a0 Sherry            2020-11-11   980  		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
1296423bf23c7a5 Bhawanpreet Lakha 2018-02-20   981  			DC_LOG_HW_RESUME_S3(
014427adc5565a0 Sherry            2020-11-11   982  				"%s: panel already powered up/off. Do nothing.\n",
5eefbc40173644b Yue Hin Lau       2017-09-15   983  				__func__);
5eefbc40173644b Yue Hin Lau       2017-09-15   984  			return;
5eefbc40173644b Yue Hin Lau       2017-09-15   985  		}
014427adc5565a0 Sherry            2020-11-11   986  	}
5eefbc40173644b Yue Hin Lau       2017-09-15   987  
5eefbc40173644b Yue Hin Lau       2017-09-15   988  	/* Send VBIOS command to control eDP panel backlight */
5eefbc40173644b Yue Hin Lau       2017-09-15   989  
1296423bf23c7a5 Bhawanpreet Lakha 2018-02-20   990  	DC_LOG_HW_RESUME_S3(
5eefbc40173644b Yue Hin Lau       2017-09-15   991  			"%s: backlight action: %s\n",
5eefbc40173644b Yue Hin Lau       2017-09-15   992  			__func__, (enable ? "On":"Off"));
5eefbc40173644b Yue Hin Lau       2017-09-15   993  
5eefbc40173644b Yue Hin Lau       2017-09-15   994  	cntl.action = enable ?
5eefbc40173644b Yue Hin Lau       2017-09-15   995  		TRANSMITTER_CONTROL_BACKLIGHT_ON :
5eefbc40173644b Yue Hin Lau       2017-09-15   996  		TRANSMITTER_CONTROL_BACKLIGHT_OFF;
8740196935625df Andrew Jiang      2017-09-25   997  
5eefbc40173644b Yue Hin Lau       2017-09-15   998  	/*cntl.engine_id = ctx->engine;*/
5eefbc40173644b Yue Hin Lau       2017-09-15   999  	cntl.transmitter = link->link_enc->transmitter;
5eefbc40173644b Yue Hin Lau       2017-09-15  1000  	cntl.connector_obj_id = link->link_enc->connector;
5eefbc40173644b Yue Hin Lau       2017-09-15  1001  	/*todo: unhardcode*/
5eefbc40173644b Yue Hin Lau       2017-09-15  1002  	cntl.lanes_number = LANE_COUNT_FOUR;
5eefbc40173644b Yue Hin Lau       2017-09-15  1003  	cntl.hpd_sel = link->link_enc->hpd_source;
cf1835f03ffb3b5 Charlene Liu      2018-01-08  1004  	cntl.signal = SIGNAL_TYPE_EDP;
5eefbc40173644b Yue Hin Lau       2017-09-15  1005  
5eefbc40173644b Yue Hin Lau       2017-09-15  1006  	/* For eDP, the following delays might need to be considered
5eefbc40173644b Yue Hin Lau       2017-09-15  1007  	 * after link training completed:
5eefbc40173644b Yue Hin Lau       2017-09-15  1008  	 * idle period - min. accounts for required BS-Idle pattern,
5eefbc40173644b Yue Hin Lau       2017-09-15  1009  	 * max. allows for source frame synchronization);
5eefbc40173644b Yue Hin Lau       2017-09-15  1010  	 * 50 msec max. delay from valid video data from source
5eefbc40173644b Yue Hin Lau       2017-09-15  1011  	 * to video on dislpay or backlight enable.
5eefbc40173644b Yue Hin Lau       2017-09-15  1012  	 *
5eefbc40173644b Yue Hin Lau       2017-09-15  1013  	 * Disable the delay for now.
5eefbc40173644b Yue Hin Lau       2017-09-15  1014  	 * Enable it in the future if necessary.
5eefbc40173644b Yue Hin Lau       2017-09-15  1015  	 */
5eefbc40173644b Yue Hin Lau       2017-09-15  1016  	/* dc_service_sleep_in_milliseconds(50); */
5180d4a4766d7df Charlene Liu      2018-01-18  1017  		/*edp 1.2*/
06ddcee49a35981 Jake Wang         2021-02-23 @1018  	panel_instance = link->panel_cntl->inst;
                                                                         ^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference

5180d4a4766d7df Charlene Liu      2018-01-18  1019  	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
5180d4a4766d7df Charlene Liu      2018-01-18  1020  		edp_receiver_ready_T7(link);
8a0e210c048e97f Chris Park        2020-08-05  1021  
8a0e210c048e97f Chris Park        2020-08-05  1022  	if (ctx->dc->ctx->dmub_srv &&
8a0e210c048e97f Chris Park        2020-08-05  1023  			ctx->dc->debug.dmub_command_table) {
8a0e210c048e97f Chris Park        2020-08-05  1024  		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
8a0e210c048e97f Chris Park        2020-08-05  1025  			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
06ddcee49a35981 Jake Wang         2021-02-23  1026  					LVTMA_CONTROL_LCD_BLON,
06ddcee49a35981 Jake Wang         2021-02-23  1027  					panel_instance);
8a0e210c048e97f Chris Park        2020-08-05  1028  		else
8a0e210c048e97f Chris Park        2020-08-05  1029  			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
06ddcee49a35981 Jake Wang         2021-02-23  1030  					LVTMA_CONTROL_LCD_BLOFF,
06ddcee49a35981 Jake Wang         2021-02-23  1031  					panel_instance);
8a0e210c048e97f Chris Park        2020-08-05  1032  	}
8a0e210c048e97f Chris Park        2020-08-05  1033  
069d418f412ec4b Andrew Jiang      2017-09-26  1034  	link_transmitter_control(ctx->dc_bios, &cntl);
96577cf82a13317 Hersen Wu         2020-01-14  1035  
96577cf82a13317 Hersen Wu         2020-01-14  1036  	if (enable && link->dpcd_sink_ext_caps.bits.oled)
96577cf82a13317 Hersen Wu         2020-01-14  1037  		msleep(OLED_POST_T7_DELAY);
96577cf82a13317 Hersen Wu         2020-01-14  1038  
96577cf82a13317 Hersen Wu         2020-01-14  1039  	if (link->dpcd_sink_ext_caps.bits.oled ||
96577cf82a13317 Hersen Wu         2020-01-14  1040  		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
96577cf82a13317 Hersen Wu         2020-01-14  1041  		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
96577cf82a13317 Hersen Wu         2020-01-14  1042  		dc_link_backlight_enable_aux(link, enable);
96577cf82a13317 Hersen Wu         2020-01-14  1043  
69b9723a81e74e5 Charlene Liu      2018-01-18  1044  	/*edp 1.2*/
5180d4a4766d7df Charlene Liu      2018-01-18  1045  	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF)
3a372bed1e337ef Hugo Hu           2020-10-06  1046  		edp_add_delay_for_T9(link);
96577cf82a13317 Hersen Wu         2020-01-14  1047  
96577cf82a13317 Hersen Wu         2020-01-14  1048  	if (!enable && link->dpcd_sink_ext_caps.bits.oled)
96577cf82a13317 Hersen Wu         2020-01-14  1049  		msleep(OLED_PRE_T11_DELAY);
5eefbc40173644b Yue Hin Lau       2017-09-15  1050  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

