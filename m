Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217C34CBD13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiCCLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:47:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE15F5422
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:47:02 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2238WAYY007646;
        Thu, 3 Mar 2022 11:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=t0pvtl+VXYVvB8Lmp29HF8SUUu+y/EbBciwSmyDOW1w=;
 b=TlgZNKnvHk+yjyG6Unb/PP+DgreCNYGYoYq9SK43xNYKdNMRHSN/VJzGvTc4rv93yMIY
 xkXeqOi09xyoAHCo6DhX1Z5WT/+3e4HpBnCAhiRMmB3Z1xHhUw6MRyu9BYqTrN4RysKG
 0rQP+oRAXjAhrbQM9RDBn4h2WkyMv9JZIebIXN1n65Swfz6G4/31hDTE9b43FToUryOJ
 GOHAsrxXfmyYTMWv50FZ8Iyb7D1G8qPFCUDw17KIlNtRswQw7yMkDTy8XV/aDRT0hdPG
 haN5VjjaEm2ldimib0GaZVsD/f+j+6AmNx0Ewu22X3V5i6YSRYoUjSodXJ/9+AXQhJQF 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15aravw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:46:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223BfcpM154389;
        Thu, 3 Mar 2022 11:46:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3efa8hxmsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3rs5mGmeHe4rb8ZFsIsEw0Y1yw6VUnbGUCU+/KK8gVAJQLX6pcqoexNAJx4xEn4ByCL0ixe53seRwgHPLkg4SWWss3be/3veXXUwHceqew7nNVQQy/7CQ5LayQOauxV3D4Vd1VqMqPXOLcEcSjEHv3rIgKFY82ZqWO4cwmZlbmUHoSc3BoG6/AnyQQwN+nYMA+i3cvQZ97nbXloetSDDB0ggmn+FWDp0lS54HAClR405ju3tba/3PjcFKkDnYc0A3dXkkvZBcyEzeHRG4xAwA/VVsVLv6QpKV927Hrobs81ZphSqiJMoWPYkH+U878biwOZXZSAKFvBtWb/Dv/IrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0pvtl+VXYVvB8Lmp29HF8SUUu+y/EbBciwSmyDOW1w=;
 b=EK5zLTKOJa90hHQA7AN/XDwzoMZVy/6tfp4WBtllCDNbGs+Dgo5B570WSgyiNfUsvaPedexpUXwUZuVMm8L6lhSFeclc3oqLaShWcAz1ZAEUGdcCF9Omc/V/pyEyPbjqrmrByOvkLR9ShO1llieBtRpRsxeI69wjwTpcGdACAd/X2iY20I9nRxM59pBhZGHR/W2rDnQKlmvp0kgWHcAdY26fb9RmibXm/2jsM2lENfS6sgOB4Mzd3wJGv0/EG0nPOIstSevtmIagqbiU3KPe24JmvszzrEdTO6fA8JXQqfEwCS9haU5jEujsdeAI1SkJoflTVJpory1h1nQYBwHXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0pvtl+VXYVvB8Lmp29HF8SUUu+y/EbBciwSmyDOW1w=;
 b=D8RkYzCWJMoPcgr9CcusByolD5w+V3EtghcRKe7iQz8z3g5YHAQyjn3t/5DcVkocIzceNMWpu6e4ZGRGKmkFTsJ8SNDd85LXke0z7xO7JTi4PSii5GszGgV40O3/gVy1JcsgfYSWzCUwJF7fmbYfRd3KfEjo54Iw0YNp6E2fhtE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2646.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 11:46:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 11:46:55 +0000
Date:   Thu, 3 Mar 2022 14:46:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jake Wang <haonan.wang2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1018
 dce110_edp_backlight_control() error: we previously assumed
 'link->panel_cntl' could be null (see line 977)
Message-ID: <202203020137.M32nCNIJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CTXP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:100::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1109883d-f91e-4ce6-d1d4-08d9fd0b83d3
X-MS-TrafficTypeDiagnostic: BYAPR10MB2646:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB26466F451543FAEF58C559B18E049@BYAPR10MB2646.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjiQZDV62OYDrEEqdq2GLbndyKgERAGRQ+GEA3IaC5JBCdJ2p9XjMbCkOTv2c9ylhow1lbGVZwYEdo/HTPYITN4YlLSusXw/YUwEezvRh22VcqJ8E2IkUgCL+NqfTJUKiL1zePJjkNvA2OEt6FPHafKDp0Kpew8Zml/jCFVN48sUcEX3QwDrJjHxoxRMbBvU6lonY6lwlGNfd6iOS0IWKLUG33rs/mtJ2jHxSz9T+c4jVHtL1jR/lD+0tg7vIHMzWntW2aRNr+Jxogf7TLwDdZf+YU5O3rSOY9RgYb9m44zqlH4fOpjc7gKE5r/IwNKwnGG/FKm/45iPYVByAhedZPmOo8BtnRFI1Q1mbMpT3Ub601261H671vQw8XyNPhMuzUUSU0icAP3fsQdhn9sQUMniCuennu6ylyi+2pC/d5cLeNNW15Z93ZvYVNB+ntKNjl7qxPzPkKUY1MymGs6kV2v2VTr5THfWeiyCcLidjYGGB9bssXzY/mP//0R9JQdmgxbLZyGtbZ2wxxY1+luTd6e/tbTNA8viRPv0w8LyZEqxq5nzqFvVpLqc+y3CfEoJTFNltTzMYpFMgAzM5v+hvSvZXZEJoNlUrkb9d+w/wrworsQt6MLbbxiJKszncykw/kqlir47I/J0zo3nBjJpbMxvmDSrduxw/6+LELH9fH/Y8O4UBDqLQruxmtQcjC19SmG/tjvt7Mus88ZYTHG26k1fAznlFstYfH5C92vNls++csiHsIJ+8Awyp8f5PQ2jboWEbR+Qyggl8CbcLBRhEsdTvx0Ln0sY4Sskn/FZ1d4ol7/nahvcfIT+uV3yFvJ0aYT5cC8eyhFPw259wj7SLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(6512007)(2906002)(5660300002)(8936002)(1076003)(8676002)(66946007)(66476007)(44832011)(26005)(4326008)(186003)(4001150100001)(86362001)(6666004)(38350700002)(38100700002)(6506007)(6486002)(316002)(66556008)(966005)(508600001)(83380400001)(54906003)(52116002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AGcWzGBf3LR3lRcgeYtznO1DyHbpInbIatLaFTw7Ff4noosg3j9DQfqHI5Bd?=
 =?us-ascii?Q?BoPHGPN27475VMQ5zWCpgTcvHYJc2NoE/bAVfuNVPv1JtuV8DkNJtuzd3jqN?=
 =?us-ascii?Q?ycjm4tARXXYGJb8R4XOG/R9kx7Z3KEv9oWCpg//Lv993Zpwc5Qviq+Nec74v?=
 =?us-ascii?Q?0KuFQnuRmcJd26/uTCPLVVnq1Xz0iKST9VAqYsh/4tJ5RUh1rDge4qdlj8Ol?=
 =?us-ascii?Q?hYRMIYbWUkMhHq7k2CM0edtNtHfhV0NOvn3KwX1k/hqAVlTrXX0Rgas7LHsG?=
 =?us-ascii?Q?KF8YlQmjdzqhbw8Y1h0njPfgxFUB+ItaW1YZKdYjeesWupFYYN3GUPQDfNgH?=
 =?us-ascii?Q?vSwxb/OX19ietqoAAWnvsY1qWcDvhIrsfYr+sSAfx8lhFEk6ldIZsU/dKbBr?=
 =?us-ascii?Q?f8KGEHTlhdvgbcT9/OdWC6Wzp6ooqHff1snyzhplb1SBxny5N1aM5PXyjXZ+?=
 =?us-ascii?Q?B5VMnfQbma3SxE4Ytr+AIsYOeZRBRBWYk9XJbRFgGIXW6RfapZl8rIzVbQz0?=
 =?us-ascii?Q?mGMVrhsWrlc3r0IIvbykPpRoCQLh7vEksP0jeZ6Tm/JjuKb0hndjIxMGy6tx?=
 =?us-ascii?Q?kDXu1j+DWxxR0ty2u/I2LPX31MYH2sGDFypyUvWFLPJkbq1oUkP7FROFpteq?=
 =?us-ascii?Q?yr/BFdMtTQtZ1Oiek+U2vHMjN1FxzxVnNDa7arRge/MsOzVapNB4T02lWqDr?=
 =?us-ascii?Q?w/zvs6hhaI+rFGxU7RaiYpl3QobeMHkAc+fivhYaQyAa3ApHIt6RzAhjBpxi?=
 =?us-ascii?Q?f0aQQenDyki0Ce7bx55ACMp7K5EZ0vGD60Y3AAGNNKAFP0qfOSLRG0rdy/+F?=
 =?us-ascii?Q?x0TziDjH4mSLD+H+z58LIL3czEthdU+bsJMN6N+3v9MBZISTkEw/Ofw90chv?=
 =?us-ascii?Q?UqBn4ZPJEjNDQL5Zdeb7KBaoNoC2/empDO3KqhVj6xUzR8tE0cc4j/kXL4ia?=
 =?us-ascii?Q?UOEAgD7iOvOfbZU7twI1HGeNl8NEEgjeyAsPfDBy9sJqKkCXYbg4dSObj1au?=
 =?us-ascii?Q?lbHwD+Om25tlniZwgu+2BKf8QpzTlqbhQ2EL06+9Iec5qKzNXuoOMbdgqnJ8?=
 =?us-ascii?Q?qi6Q414FvGkocurcR/HiVrRKyyWB1fMNbuEFj67ZbOUl24LfuacGkrejLpqn?=
 =?us-ascii?Q?FyJyBTs8g/8phjuMKP2JPZFltsndA6QNNH35Jq01uABwmrpPUs/2aG+5OvFF?=
 =?us-ascii?Q?RsQQLg8MaEOECV6icIjdLPm6DRQxpMyhKCJZkz4n1lSR4RRXCUM59RrKPGJh?=
 =?us-ascii?Q?uObdq5a/eqYV89TacsCozy+DgSHSLkNShj8NFaVVLP10uxjvtkzBTQ7CPPo9?=
 =?us-ascii?Q?n43jWki65gkwaiMLNa1lMHn6lGkihxQHYZ21c2UOJAF21VUSaalKbMl7uKv9?=
 =?us-ascii?Q?I6RFGGO4kph7gOJjB9HW7F7jFu2A+zbxzHuBgelKzxB36Ylt25/NsBTlG+fC?=
 =?us-ascii?Q?6rq8nYERF2swXYGiXeLq+R66iK2cyjx+dErAj2d0QLQn2dbpWyLa8nm/cKzG?=
 =?us-ascii?Q?gOYBAOpQ6128F3h2iQ3eW1d9G0rRAf34CnQQe037B5H1t46xiH+zFqyFlnmN?=
 =?us-ascii?Q?e9JNLILcm1FrTAo7ZeO7wM4wGRHiJJ3QWENdNzap2cOFTeES54MmF9mkAy8e?=
 =?us-ascii?Q?kQ5nfkl5jDWQxHgrgVLA1sRSroljeZiPhXpgXMeBNNg3SqcdHL5j+sLUlrv5?=
 =?us-ascii?Q?KGaO6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109883d-f91e-4ce6-d1d4-08d9fd0b83d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 11:46:55.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIlw0Udaz96xSaEBaEi3nWDofcl9zFPYikOJZI77mUgvoZT85y3MDwmYyngQVah95UsYbE54sHII+H3V1pFO7B4a4rsCUnFx/Y0rRYYvLOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2646
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030056
X-Proofpoint-ORIG-GUID: yLOxGqsoOEgT9dmGT_3vLhRzZAw4xN2I
X-Proofpoint-GUID: yLOxGqsoOEgT9dmGT_3vLhRzZAw4xN2I
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
head:   719fce7539cd3e186598e2aed36325fe892150cf
commit: 06ddcee49a35981835e04910bef462a09f108984 drm/amd/display: Added multi instance support for panel control
config: powerpc-randconfig-m031-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020137.M32nCNIJ-lkp@intel.com/config)
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
                                                                         ^^^^^^^^^^^^^^^^^^
Unchecked dereference.

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

