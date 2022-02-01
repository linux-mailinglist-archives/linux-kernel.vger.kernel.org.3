Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE75D4A579A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiBAHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:18:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19224 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232736AbiBAHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:18:50 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2114xJJh020858;
        Tue, 1 Feb 2022 07:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=7tipMR03g1v4pQlDXC01HJPiz+kew+DJughxaVM6fEs=;
 b=nj6ysAdTJ/d4/9eRcEaKTEfV/HzFltYEySXvW099GaMscN1Feu3wG32FQLEv8j+TuwfI
 K8OmxzakuD88xihrAg0HEEWPKTZJ27MYTQLxUGY5cG3AftDv370vr4DUMPqLyktuAuIr
 hqbvTCfsF6Zm/Xdur2Oj5RoY4NjBc6t7Kf9QShHuqS37m3lcEAWd4iGcLiqMsjubc7No
 jgSXZO43NUAFHZk2pK0O78zLevjlAWRZ6z4rfRHPiqAEeA4YUUCYGVTFs0dOAfZQNROv
 QWfG5KrHkmFUdZRsfwrdIzL1ygIfkOiIyDRjkxOuzVbe0vx11je8YzrENlvAYZY/0+6G 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wa0nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 07:18:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2117F83V087823;
        Tue, 1 Feb 2022 07:18:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by aserp3020.oracle.com with ESMTP id 3dvwd5mn9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 07:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sa992MMBob0icRKcbGsZI7yy+3D/NRSD+62LqAdUtnQs/LXykkkgq53nFA+DGo4gkabD602RJIaEZZKqKS/xGQ3C2Oaz3JhgtnKoACF+5rCULroxlqbSxEjzovo4sfUTrXDijnY+1OC5cxJERwRMNaI4f4ynuus+4hWiCCB/oek8IuQ1hZVLlktGvqrnUSjE6ew2wLmZ3ku6v7pk3wlcQ5iF7iwx3dBGOKVMO1M5WNYEwDlyWZetC5TSFyc/NeYcOPTMl9w33Pn09zoQllTIn4MIPCojkxDrhTTdfp4A5+P+iihusJud4pjDB2PzcEyoFwK6kmM+5/m0s34ObSYJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tipMR03g1v4pQlDXC01HJPiz+kew+DJughxaVM6fEs=;
 b=RAnBEetxX87zMcnnmIv+jzr3wQ2/5aUln1gCYdgFE2Y/36a1GZaJZ/Fzd5GFL6pxR+apd/6hSteBrjnGRedjSTDla/gtgAipVfn0hJJOkhxj+n/uZ91JNizRYwzkDzPqg8FtkwR1J5BgzwOdCRRCDBq6nPvbGa6TSPw5DxACBPPV3RpvyT2Zqa342nox6fcjqmIs01ucv7kJPLnBD5OvheZYd4QX5I9slKrbtWv2gLrp4itCVh4uBH8BdoRuhgYsPDgPfvEpz4d/5Xhur7stDfloys9b9FA9WoDEHV3SZ5DWaPLMVk8BYcd6MITV9SGhGdoy1A5N6D+A5CcoVKcDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tipMR03g1v4pQlDXC01HJPiz+kew+DJughxaVM6fEs=;
 b=WIWOcOZKjqj9rbhxG6j0eYj94Ij74C0S2efr6L0P4I7rmTCMSY2NhjxUC3kklRECAE5X1G2FlFQQTK4OTCjdvH85hOcWGq4TYEj7Vim1Hg6NT62TkPPj0ZDLQVsKdhCE1u7CV5251nPKO2rJUfez0qJh8Vi6c1b0cgAJNq+4zok=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB4102.namprd10.prod.outlook.com
 (2603:10b6:a03:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 07:18:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 07:18:38 +0000
Date:   Tue, 1 Feb 2022 10:18:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-gamecube.c:247 gamecube_rtc_read_offset_from_sram()
 warn: 'hw_srnprot' not released on lines: 239.
Message-ID: <202202011339.oPwRPmNf-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c56e6f-8c8b-42ac-a213-08d9e5531150
X-MS-TrafficTypeDiagnostic: BYAPR10MB4102:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB41025F2F98D3AD59A1A33DEB8E269@BYAPR10MB4102.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN3IyyTvoywFWf+hmZ8ZTtbtmuA7cOVYZ3jlMzY3aEcYB01F3hTFmS8ZJ5EcxhiHGsKS3Uld7DrXApHiY2dlWsCoUeVZ0oujnX+m4pyDY8bWQLOmoiRGCk8jNqpoU+6tW1svdu0QvFjL4wFfqxIXnOj28hWFFpkU+OncXNUXqE0Bg+K6g/1V0if1qWZzgZyqg7si/fVzt15RCjFv4WsUws2SB68Ib25nMLXeUDn1/BewBGWyukyjIDrYs15dZyGLWiPySTqIncwrxKSNaeQb9rdNHLDM7xXKmn60jkI52I7KmblP400zSQsGFUfu0c0j2IGzwhBilir7Hus+s7BIVigilQKGbYUiFtFRzsjn29Y+dM04DBbnnwtQFS/95Q78Kvle5M7DTGkIOmBy328msU0xz3Bw8ZgtaljPuQms/b2t5nI5FFJ57JqHCZPIuEn5kMlOBoo22Yswc3UfTKUx/XS6GS7ehO0v3oLrIl/mzU0cmG4qR1SG99+Hc4Td0x1YxVSX3XM+DnVVvbplJ/zzfCNk65ay6ioOhXImEI+nFZTsTw/jyPr7czrow+O+pLifcl8OYGfHdILgGwkJkSQ7bacLahl+Wjsl8LDTv8pTPfX19Z4189+TfDKYzjEhp/FBtJe8c1WDuyw2tfdGNdz76r+hx1u3Zp1GFxMp9Zq95Kld/Vf4gZwCDZJA7tXag/ae7YHRhiuRuTbZII82H2BMquzf/aXVtgyBEI/UV77cQTY+3Y/SqJNpB0swFN+qqktrzoAjmTXMc9lB1mOLnERt3v7bgV+iP5ndS7Z3HrWaPSVvQxOeReeWFp88Xazkc3+Jd+82Wm9Il8vk1SaY3Y1zag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66556008)(2906002)(66946007)(66476007)(8676002)(8936002)(4326008)(36756003)(5660300002)(508600001)(38100700002)(6666004)(966005)(26005)(1076003)(186003)(38350700002)(6486002)(83380400001)(4001150100001)(316002)(44832011)(9686003)(86362001)(6506007)(52116002)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hJbkJNVzlTc2tpUDdKTit0LzRoQ21NNmo5bmEzcHB5MTU1RzBnUGFDdFVM?=
 =?utf-8?B?SW4yUTBXNEZVYUh1djRhd3RJcnBBK1dJWThCZkRoS1M5Z3lPc2tmRERUWGdj?=
 =?utf-8?B?L0JwQTJGTHdaQ0k5emgwKzZGWG9HQXVOaWNmWkJWQWg0Ti9FOUVuVnMzNkpy?=
 =?utf-8?B?RFluZzZRSU8rUVoxS1B3SmFWSHlLWU5vVEZtN1VkWEhKeVBqM0dqaUpEZU1i?=
 =?utf-8?B?K2NKYWVhRVIvUGtpMURDS2VneVllQ2t4dXhxSGdwUEFGcWlZdHNnWjJiUm81?=
 =?utf-8?B?cy8zcjVrK1hiWFBUTCs2VVBNUnhpWGVBajRNd1licE43RjdmcVY4L3VLSWFG?=
 =?utf-8?B?Z2FPYVA4ZXJ1V2xIdXAxUSs5NUswSGh4VVEwRERiQitzUjljLzUycXo1bmtk?=
 =?utf-8?B?ZGFyMU94N00rNjdEdnQ3cGdEL1VBTm5ZWHNPcmd5OUhpcEorZ0VDN3J4STMw?=
 =?utf-8?B?eFhkdmVmeUxjVCtDM2dVcVU4Uk1WVmUzdHBNZmZvOHB6WHpMZDZIcEovdTgv?=
 =?utf-8?B?amJFSUs2dTdiWG5CQ2JNMDZ1RkdTb0t6SGRaQUphZmJKaTVZZE9jVW85QVVJ?=
 =?utf-8?B?OWpYN3NmQmZTVGhqNnVxZFBTZmVRNXlvRDBvSmQ5Z0xwT21Gb29Ycm01NnYr?=
 =?utf-8?B?WHlhK09ac1hqUHQwSXRCaVZQOTdoSjRuRllwZ1RSbmc5L1dadEIxNXBMNEc1?=
 =?utf-8?B?U1JROWtkTXJYSHMvakFZamFLdzBpM1I3bnR6K0VKOVl2M1E1TnhLVUV2MVM1?=
 =?utf-8?B?b0ovdng1SVRuRnA3V0xSWXR3T1QzZzVIL3l0dGlzUnNvUzNRL0VUY2thRHRh?=
 =?utf-8?B?ajlVeE5MTFU1ejhXMUIwOGFhd2JXcTUrdVE5VklsNW1NVG9xVzRmOHV2alRT?=
 =?utf-8?B?Ry9VVU1hdkdraVBsMmdZYW11UFR2d25BcHBRZkhhZmxtMHAvakgraVlkekRB?=
 =?utf-8?B?UmZHWG5zbHJvQkdqSGh0N1lyc1h3ckhScmY1cld0bXA5cTkvUFMybTB1NG0x?=
 =?utf-8?B?enQxZXFtNis2ZzlTNUg3TFB2clg3NFd4QU1DUXduZmZLTlNWc2ttcjVWdFFm?=
 =?utf-8?B?c1pUWk9KMFZDTFlVeko4UE5pWm9hUFZmYTc4VWpicCsxbmFjVUhNbEZUYW8z?=
 =?utf-8?B?WDF4TWJYRjhST0hXYnRESDZESG9VWXNMTC84dDRhd3hLc1VjZ2hBZjZLbEh3?=
 =?utf-8?B?ejdoZVRETEo0Q3lPbFA4a1BvMzRWakJUTVYwVnN4Q2N4a1hnTHZoUlllcTls?=
 =?utf-8?B?VlU1c1Q1ZU1BL0ZaVnNUMUo5TEJjYkx4RFVldVh0NjhONVhIcXRPRU5jVWls?=
 =?utf-8?B?YnVjTXoyRkR5U080ajg1Ulp2YmIyMkZ6Y21sS2RscFBnRy90V1NoTm9YVC9W?=
 =?utf-8?B?VnljampRSXJUTXRxWjYwMlh3M3p2YUg3ajZDSTh1a2dKZzRQL056NGtxcjVE?=
 =?utf-8?B?QjFhL2tKRkUwaXNuWit1RHFiMDdPTFhuNXRaSVZ0Qlc4ckY2Y1MrTnlIV0la?=
 =?utf-8?B?bldiaHNGNHFEb2laUEs0OXFQTjRpL3l3TGxESWpVSFBiZ3lWN0xRQjRsMjlm?=
 =?utf-8?B?Ym5mTENBVk5oYkNzRGw5QkNOUlNoL1dpdzhHUE5JNTZoWEtDamJKUWxhRHlz?=
 =?utf-8?B?N0s2UXB3TExCTlgwb0VlMTA5bUF1TUZUSDVBcHBtNmVrYXBNdno4Rmk0R2hl?=
 =?utf-8?B?TkNvSHlnVmt1YUUwU2RYekRkMzkyRG1VTjZ0QmtOa1lodnlNSHQvMjZvT3F3?=
 =?utf-8?B?enNISTQ2cnhyM2FTd21jbG1MRUR3WHEzYXNndVlKclZxdEVCOWQ3ekRWTWpY?=
 =?utf-8?B?dFFVeWUreFc3MHgwMEFJa1NwRWVRQmFoc0dZQnMwR2ZHUjM3RWNoYzR0azda?=
 =?utf-8?B?Wlo0eWpscXRaM1BJNjdrejdsZ2pRdkgwL2NtbEZ3N3EvT1VmT2pjc0E2Y1ZK?=
 =?utf-8?B?R2w1SndhOVhhaVVNejJsSmp0ZDhiNVRGUTJiNi85bysxeTJFdFc3QUlxbGNP?=
 =?utf-8?B?Zm9iL3U1ZjVDZXZFTGx1d01EU1JLTVdwanhYNThvV1JvL2hOMGtxTENoV3hn?=
 =?utf-8?B?S3Y0OEhBMzhBUkVHbEVaVEpvNkNNMHF1dzlqeVBvRWVmZkNTZ2hqVXMrdzVF?=
 =?utf-8?B?aXAwWDlMY0tCcWNJS0FOQXpHVGdxNzg5bVNNaDJtK0VmZzdWcHpGS1FMaDhK?=
 =?utf-8?B?YlN4WElQaTBmbkRXckRFeXFjM3NNUjB4ZWxjRVBqdk43UEd0YXFOYTdDeVBw?=
 =?utf-8?Q?sMPfvxmC7GlidXzkaJU0ebl8pcGv0hiwcTngP+cnBc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c56e6f-8c8b-42ac-a213-08d9e5531150
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 07:18:38.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NjBoeA+t/WtYVJeMCvqO5cjpHPBpoaOLwbTdahUfW8q1zT7hZ0PEPxXdEX7Z2nnjWSXMtOlPPam6FrgDf0Ay4yfzuXolrrnsZvPHCGwmNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4102
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010037
X-Proofpoint-ORIG-GUID: U8FJGe5RBp4f8OCW4CT-0tSHYbZ-VSXI
X-Proofpoint-GUID: U8FJGe5RBp4f8OCW4CT-0tSHYbZ-VSXI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 86559400b3ef9de93ba50523cffe767c35cd531a rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
config: nios2-randconfig-m031-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011339.oPwRPmNf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/rtc/rtc-gamecube.c:247 gamecube_rtc_read_offset_from_sram() warn: 'hw_srnprot' not released on lines: 239.

vim +/hw_srnprot +247 drivers/rtc/rtc-gamecube.c

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  190  static int gamecube_rtc_read_offset_from_sram(struct priv *d)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  191  {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  192  	struct device_node *np;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  193  	int ret;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  194  	struct resource res;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  195  	void __iomem *hw_srnprot;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  196  	u32 old;
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  197  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  198  	np = of_find_compatible_node(NULL, NULL, "nintendo,latte-srnprot");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  199  	if (!np)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  200  		np = of_find_compatible_node(NULL, NULL,
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  201  					     "nintendo,hollywood-srnprot");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  202  	if (!np) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  203  		pr_info("HW_SRNPROT not found, assuming a GameCube\n");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  204  		return regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  205  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  206  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  207  	ret = of_address_to_resource(np, 0, &res);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  208  	if (ret) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  209  		pr_err("no io memory range found\n");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  210  		return -1;

Need to of_node_put(np);

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  211  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  212  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  213  	hw_srnprot = ioremap(res.start, resource_size(&res));
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  214  	old = ioread32be(hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  215  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  216  	/* TODO: figure out why we use this magic constant.  I obtained it by
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  217  	 * reading the leftover value after boot, after IOSU already ran.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  218  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  219  	 * On my Wii U, setting this register to 1 prevents the console from
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  220  	 * rebooting properly, so wiiubrew.org must be missing something.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  221  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  222  	 * See https://wiiubrew.org/wiki/Hardware/Latte_registers
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  223  	 */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  224  	if (old != 0x7bf)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  225  		iowrite32be(0x7bf, hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  226  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  227  	/* Get the offset from RTC SRAM.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  228  	 *
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  229  	 * Its default location on the GameCube and on the Wii is in the SRAM,
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  230  	 * while on the Wii U the bootloader needs to fill it with the contents
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  231  	 * of /config/rtc.xml on the SLC (the eMMC).  We don’t do that from
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  232  	 * Linux since it requires implementing a proprietary filesystem and do
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  233  	 * file decryption, instead we require the bootloader to fill the same
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  234  	 * SRAM address as on previous consoles.
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  235  	 */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  236  	ret = regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  237  	if (ret) {
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  238  		pr_err("failed to get the RTC bias\n");
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  239  		return -1;

No clean up on this error path.

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  240  	}
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  241  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  242  	/* Reset SRAM access to how it was before, our job here is done. */
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  243  	if (old != 0x7bf)
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  244  		iowrite32be(old, hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  245  	iounmap(hw_srnprot);
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  246  
86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15 @247  	return 0;

You probably want to of_node_put(np) on the success path as well?
Otherwise if you do more than INT_MAX reads it will crash.

86559400b3ef9d Emmanuel Gil Peyrot 2021-12-15  248  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

