Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5560E50BA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448755AbiDVOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiDVOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:40:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6B5BD1A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:37:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MDiJJt009531;
        Fri, 22 Apr 2022 14:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1ag4/55sBYeshsTuAQxEQUis9Wroe372uaM8V/sqiMA=;
 b=OVSBWpSnLouI0KSt9EKY+FNZLpVszZe8LiRH0LwAQl3PLQzybd3w37mCN3gxSmbUgMam
 sYaEzKLpiz4eIv1LTjCmJHgpXRs2vegBuyHJGrp3MRuHeJYiXqLrx8d5V+GbyhwIMQN3
 998MCeXRaCKnimxrCNVClIsb74rLreyf48PNQlhevOvr4YL/iMPLZP7r7arKwB5G92BB
 YIFGSDzyWLL3lqNVSr49hYwetg9Oirhu2refo3ea7cl3kMIGVTOSArHD808NztEyXimX
 8Ll9HcORtXTDKs0xcGpHK2Q4z+1jZmbShAeczcI+GZMK8yjnjXJB6eRrNVw3OSLbTxe/ vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2xvwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:37:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MEa70o027992;
        Fri, 22 Apr 2022 14:37:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8arueu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 14:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI4T0G076j6zHAh2pmnnLkPNkPRByPoQ7PmaNPF2OFtbQ8N7kxV0YW7LBr5rOzSGkJp9+C7U++dcgjisjUmDNWH28mqA7c88/opv2qotoqzT/FR1lAbQoy25Vp/Qp3jXLMWyrdzhCAlo1csX+42vPhViIy+/5L/79xPb7NLpbPIQW5tohovs42t4L/XVMxrI35GMxsyFefJ1BbMEoYWlYTUzIqF1E7GOeNidG0b8dSuPPXVvf4c1MoaG8MMgUmNMdnHr3oezHBPvy6wkjOmKBPqwMAfMUTYIzfDFq92hRBW0YRCiFZkzhBhw1qEAKlH12OqDxLl2OyBgoz8U5OSpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ag4/55sBYeshsTuAQxEQUis9Wroe372uaM8V/sqiMA=;
 b=MwcxUClG87w6gaTJl6+w0Ew66HoIa/+H1BhqkjLNrrNMd11yBxxArQd5J0CyCYLggE8luAzEMogc8eowPlCPaKeEFOVqIjGSlckFn2MwSrbqMiGjtEnrvGVsDFZbxHFE1lkJE0H6pPPyDqOJipPtXYrcDom5vA6rt11eqA2ZsKCiEZTl/e5mzaBGSQaOoxs1o6f73fHdPo79zIs73Y7ajwokfjBWYvGkG2x6awSQNEU7GdFEU/syWzoQwfoqBMEv/En8yaPMWx8axuQ0d6i+Pu9Ev9eZqBddgHFBjXVYGYPquI2pxXasblZPYD8vUeztgLOQhj9b2iSemHdvO2m9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ag4/55sBYeshsTuAQxEQUis9Wroe372uaM8V/sqiMA=;
 b=URzN/6qsjQsw9T/83nnv//wszRJkh3KV+lLtfWjddfNQeIFKeZD5Pr3IB4IJRUcXx57kiwxnJbt+nDvqlXzO5G7isCLPgCNjqR7SGVNU4aLvPBJ6ZVJyx1Q2mH/Co9KtyTtCAh/LBudT47ruxN2+Cp4QvcdsVvg52YWheHg2ylE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2079.namprd10.prod.outlook.com
 (2603:10b6:301:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:37:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 14:37:47 +0000
Date:   Fri, 22 Apr 2022 17:37:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/pending 36/40]
 drivers/net/wireless/ath/ath11k/mac.c:8293
 ath11k_mac_op_set_bios_sar_specs() warn: variable dereferenced before check
 'sar' (see line 8280)
Message-ID: <202204182315.h96VPgso-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86959420-a075-4ae0-8740-08da246dab4a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2079:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2079D7C6C1BB7977142558D68EF79@MWHPR1001MB2079.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hu0stRDQi7wo9GO9AiNGUMS3ejTTuagcLTa5DKbGEzAidxmrkBTlRSH3z4ov1k2UW/tG5L0yxxty12vZ57ji+hyBhSI/8pIakHZe0LhxL7Is9z2FAlGwPB2l99bjQgfcYigzlysQKs52c0agY/enN87wVmvtTbVWuIvelb9ZQoXLk40n3f+BUGgkOkX+J8Sd516Lt5Xjg9QBr6lPdt6xUDXSihLPf8GQS6T1NPXjsYR+5qgt9x0fwbODYCSAD9Qg7O9qjpgOVKRChMPCkgowGPQPOcEOoDeHU8K8hfrwyWXOtfEFNePDu4Blu6rGDWMSqzQx296JMGT5lJUdn6RDFRWtkwi/tj3r3iEZh36il38sjAb0lJdkcdR5to3richW4nxs31cE7rCxoyYoaUXzpMe16kI7xxRiasDKncqwa5ePHq/0tdzrzwprQGSyGrnxHqev9p77lzRHBc8OMl+ckwyUQhgQK0A5v3E4IqmIItcvdc7zSZDSK6M8d090vI/rYi54EbnU797liOKiMKnw9I+WH0bkJHmuB9IBvWhCNCScWBPmlGa4fzL68/ToUOqezheHmYvxTXCsw5XWTfTda3y48RtnXMYDgbx6ToYilGjpMNzSxfh5bAPx8KG4DQBtNZL+TNhKFsSrCTu9doRqzFT+WkRxv4RL1gSYIwWy9z3VoxJWzDsYvDl4nJbkkz/rL59ki84JdkPk15XMJ4Y+AuV6/W7CezpS9ghQQya8hMcNBKaNuuFHh9ZNUoPduow1GTvaUH6UthF1HNjNVKzjFLAPqVwwg+ssuZhMfbVurzv6fm2Pt5vRzetpJ6X71ge4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6916009)(83380400001)(66476007)(66556008)(4326008)(5660300002)(8676002)(66946007)(9686003)(6512007)(26005)(6666004)(2906002)(44832011)(36756003)(86362001)(6506007)(1076003)(52116002)(966005)(316002)(8936002)(38100700002)(186003)(38350700002)(508600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKi8X+llXwqysY+frLI2wkGEkrtvoGtnR5mNB9Edba6h9E6MjUFbb1UtkXcV?=
 =?us-ascii?Q?0EgyyfKEOXB02AvX3Bc1F8Hmm15+uPDylOn5RUUbCK1qAeKdimxVyK2XfdVf?=
 =?us-ascii?Q?I6jKX0Jr7GJPnAa8ZjJUhIvml8Isk00NvIAcf5AqDvO3bWMWPLAg45DOlsWS?=
 =?us-ascii?Q?Tts8ml3t/aTQFB6qZjc7iYYiuvuH2Js1D0YZkyJ6CzEPEq9nUHtyZrnU/mmT?=
 =?us-ascii?Q?eU8WWOy7jD0iRJ8aiEajmsF7E+tEAwFXhyKhQvHJVC03koWpkqbmHmtDaJbd?=
 =?us-ascii?Q?awvVcYgq7YjKSIHcDChT8AKD1XcLnuatT4yL10yTCQz4RffCERkaiVR4Wytx?=
 =?us-ascii?Q?e3SvI+dS2efEpKpLkHVIXj5oFzunN8ujQP5iWAGMG/gOmGwb7xTh6tn0b26E?=
 =?us-ascii?Q?Ks6pfywZlbP5/31xHWsPuQtUzycoFbQ2SFFHJokbz5Sc2TTLozio44Yj08Zm?=
 =?us-ascii?Q?rsm+yDDg0BasZr1MY+7rGVgK2rwj8zCvqso3J512Num4tS3wsga17XGd+EVw?=
 =?us-ascii?Q?i6bsahbGqmNNL58b6kmAqTm3WYzTP/3L4FMXtVmjNF1BlDBkKGsWJGYWtl/u?=
 =?us-ascii?Q?YvIp8GIbXUDr5B2jyYW8Pp7hg08sX8BhaSrUJPUrVHY6QIsL/i4Iq4ksLY8u?=
 =?us-ascii?Q?G774LP5WJZRPQTIfANN4cHu+a0bwh6hB75348d0HTl+dMHwwK22uODzAVliN?=
 =?us-ascii?Q?RqPkp5LZjM0eCfP9u+hWrNqxjZgd7ryVRw7TiHhKK5Yf0XbS4xfjB3eT5u+h?=
 =?us-ascii?Q?jcrW76FUuw3VfbXgFrqgUdPuL/w/0s0spm+qB3kHp0QMHXefxkG2RVStO2tf?=
 =?us-ascii?Q?GdopYElaqAnDqmfFC2KGzvuw5B6PZVGT/Bo6+vajItXkKS3Q/X9kqO7xFuK+?=
 =?us-ascii?Q?VeiULcaKS/r6FSru7ro7S+g+s6hZdnXfHpUAXd7w0kag9fD/jLL2puLsnDTU?=
 =?us-ascii?Q?4UnSR/wKUG/uWIu+jpx8OtdGmpRLdu5UNtdWzLRSmSDYR0wVE2e1naAzAMXu?=
 =?us-ascii?Q?/VdlK7Y3OUCJkAjTnTiDUoWbHhK6P9/V28TN4AOZIxrnJn3yo/PLFD+azELG?=
 =?us-ascii?Q?w2lJ0hK3hewnHtiaeTIMj0kGuRFWEE5I+vY/kyWmQUbyuYi+S7bih5QU7mfP?=
 =?us-ascii?Q?RMNEX5ZbppSIsjHSbQ982eZDizz0N3E/QdXlqUaWiA15dsE29X8JnMK3ufQy?=
 =?us-ascii?Q?k2yHp/nuDSeGaS/sUpA/lQyViMqYllCIgnf065TXUVoVpPsCKu0WH3v2J2PJ?=
 =?us-ascii?Q?hcnczX8k2LpZTbvrgbmgZ5pAvnmLt7BUIaSJUK60+pgphRXVvhI+lome2l1V?=
 =?us-ascii?Q?RI3YMYdF/a2qO64clQJrIH+ZhQ6dH3FQQU1qRXDwVd2GArt3HIfCDGHMTq8h?=
 =?us-ascii?Q?5vrnQcqepxQhoicfxlSKWN/+E+0+DSk5EzxytdVVbxJP3UMWePhe1eWLePxw?=
 =?us-ascii?Q?F/NLLpETQWlOwV9sOu6l5AcH5wJKWcjSexHZ7N66N8UUNHyMMsphEGWjUUSV?=
 =?us-ascii?Q?qQ7a/5jNPSeqotLK8e88XqpE89Dl37IcSualNsnJ1GSGggoBBb3xTjyoB6kf?=
 =?us-ascii?Q?OVj9TDiaZmZqwGbZuEny3Yche4R0uTzjzsadgIHRd9YmcbV1Ndd2H4+abg5t?=
 =?us-ascii?Q?DDa9tZ2SJyhtLaAE1q6MrFfjaJ/Qb+3uewU1eH2+KMSeoPYOqfm0d0r0vimo?=
 =?us-ascii?Q?WgzRUbLCEejOlEsRphY4zrH/sFAIIhMClizgQ7ewoIRxuEVUGZViGAGafpAW?=
 =?us-ascii?Q?hEGBKgTQ5MyWXo5kxxY3D8C5kc54KXU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86959420-a075-4ae0-8740-08da246dab4a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:47.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRrGJDvi/npMHsIVBxrUumPoFCLscSKTi9OjGVWuKAg5NTv5oSDkm4kW/sDU0cmmjD6kQddA7wlrVJQl9ig9iCNvzV6P/EP8SnaGmRqpa+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2079
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220064
X-Proofpoint-GUID: dsBeZn6zn1rG6dss9sn8iYcG-09YKEEa
X-Proofpoint-ORIG-GUID: dsBeZn6zn1rG6dss9sn8iYcG-09YKEEa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/pending
head:   c9a8efc35304a89fc0751649945909caf03eeb29
commit: 5ad5b356e75f402fec930cf0d77b6c7862850b55 [36/40] ath11k: Add support for SAR
config: x86_64-randconfig-m001-20220418 (https://download.01.org/0day-ci/archive/20220418/202204182315.h96VPgso-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/wireless/ath/ath11k/mac.c:8293 ath11k_mac_op_set_bios_sar_specs() warn: variable dereferenced before check 'sar' (see line 8280)

vim +/sar +8293 drivers/net/wireless/ath/ath11k/mac.c

5ad5b356e75f40 Baochen Qiang 2022-04-12  8276  static int ath11k_mac_op_set_bios_sar_specs(struct ieee80211_hw *hw,
5ad5b356e75f40 Baochen Qiang 2022-04-12  8277  					    const struct cfg80211_sar_specs *sar)
5ad5b356e75f40 Baochen Qiang 2022-04-12  8278  {
5ad5b356e75f40 Baochen Qiang 2022-04-12  8279  	struct ath11k *ar = hw->priv;
5ad5b356e75f40 Baochen Qiang 2022-04-12 @8280  	const struct cfg80211_sar_sub_specs *sspec = sar->sub_specs;
                                                                                             ^^^^^^^^^^^^^^
Dereference

5ad5b356e75f40 Baochen Qiang 2022-04-12  8281  	int ret, index;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8282  	u8 *sar_tbl;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8283  	u32 i;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8284  
5ad5b356e75f40 Baochen Qiang 2022-04-12  8285  	mutex_lock(&ar->conf_mutex);
5ad5b356e75f40 Baochen Qiang 2022-04-12  8286  
5ad5b356e75f40 Baochen Qiang 2022-04-12  8287  	if (!test_bit(WMI_TLV_SERVICE_BIOS_SAR_SUPPORT, ar->ab->wmi_ab.svc_map) ||
5ad5b356e75f40 Baochen Qiang 2022-04-12  8288  	    !ar->ab->hw_params.bios_sar_capa) {
5ad5b356e75f40 Baochen Qiang 2022-04-12  8289  		ret = -EOPNOTSUPP;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8290  		goto exit;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8291  	}
5ad5b356e75f40 Baochen Qiang 2022-04-12  8292  
5ad5b356e75f40 Baochen Qiang 2022-04-12 @8293  	if (!sar || sar->type != NL80211_SAR_TYPE_POWER ||
                                                     ^^^
Checked too late

5ad5b356e75f40 Baochen Qiang 2022-04-12  8294  	    sar->num_sub_specs == 0) {
5ad5b356e75f40 Baochen Qiang 2022-04-12  8295  		ret = -EINVAL;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8296  		goto exit;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8297  	}
5ad5b356e75f40 Baochen Qiang 2022-04-12  8298  
5ad5b356e75f40 Baochen Qiang 2022-04-12  8299  	ret = ath11k_wmi_pdev_set_bios_geo_table_param(ar);
5ad5b356e75f40 Baochen Qiang 2022-04-12  8300  	if (ret) {
5ad5b356e75f40 Baochen Qiang 2022-04-12  8301  		ath11k_warn(ar->ab, "failed to set geo table: %d\n", ret);
5ad5b356e75f40 Baochen Qiang 2022-04-12  8302  		goto exit;
5ad5b356e75f40 Baochen Qiang 2022-04-12  8303  	}
5ad5b356e75f40 Baochen Qiang 2022-04-12  8304  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

