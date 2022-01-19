Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB3493438
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiASFNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:13:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30634 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbiASFNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:13:37 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx5YG018370;
        Wed, 19 Jan 2022 05:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+guqF+6aCcf4XZwH1ziO4FKdQ4YSTUuJlNk0KGUhgiM=;
 b=BcnFc9IQ8O/jS/p9agWt9YYO5jGAHZmaaFqTcH2wcxb+spBEZmiz8Co4c1SHknv2CGli
 ltr4lwLvI9j/YBb7iBZJHHwvb8tdb7zxQ/LqcQVW+DjSQoOT02y2/ocdXXBpTUHUSS0o
 5GcggNc1FTkAgVdMewI+uyZV2ik1P54GVnF8BTjfN2SsxthoF6sgnPfJHgmofQ8GD+IZ
 Ur2YaUHadV8VrSPhZL8uvNYDoiDCLSQCfzA+4hveoJgVwv1R/Ittdbyt7iu7JsRUk7zE
 yWK2QWgPS/rABC2jXX5CqRyKwYXlk6SP+eaDQq7FF3D1kLWTCcyA8r+/Tsc4XqRlLXAc lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51btah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:13:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J5AsMp127374;
        Wed, 19 Jan 2022 05:13:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3dkmad338c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvmbrz7CRj4PiCQhuKBXAzFPYz9u0zG+CADUz83T19Q/5s4aN38maCUqyMguB+AZaBbkFcdTq85tqoDVy8lEePcTl4iMC9ZkvxjoV/o6UBwiJDuPuNKqnd+es7HJzkBNSrrU10T53vymZ14aGHJKCmjd3r5/XD+oUhs2a7fYo2/QXpzSYVG8l2wOi2+Qwx4vBKHQK0urrKf/cADlynIb8hp3pSNvuyGyGBTwJQkYllsEd8no/k/MV7Onit/CtzjqfuFusLGT9evr1WOPiR60veaHnaCyBefbiPkWK24gU8Hd92M1mmHWYkPkl29XvCVW52j9DIYTRbxCq5zSE5Ty2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+guqF+6aCcf4XZwH1ziO4FKdQ4YSTUuJlNk0KGUhgiM=;
 b=Lrij00QCdq3p8GeyAj8lC7aFXGXtSnZcKkmUT5wawq0lYMCV/59rSdb9xI5x+vj7fi/jMGKNwwbYmdFShVmT3GawZEBM3LMwCLyEOvJ/omfYL5l7dJlRdsCZ/NcWoAgIt5IbBwILEVbkqRPtWIfKx0atILeLhziURJWwaj5BLcypnXSHGPewv//VnePseD8MJgMM9dYpDoIUA30RsG36d54indpvjnIexlemO2oo+HVV0+Yx3brxJ5jTpIn7i4KgkcTE9WT8vzQo0fSqqJU3+hNLdUGCJpviuumS/BtqDMDd3+6YjunO60eLPpbbV8YNGmRNsgsoH+gv6I16xhtPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+guqF+6aCcf4XZwH1ziO4FKdQ4YSTUuJlNk0KGUhgiM=;
 b=mobCKiNVtsOW70u/yiEjImSml5zbg3bGod3SZ6Tn9Kh4QeF9Sp/mnkJGclwgdsJu5flWxsyqPRbO1E9gOBDPbty3q4NSk1Z+CDcFytW39LeO0k0HoQGLhdizw4lOMBf0tmlKzkQ6poURlJtnmsiZypI//qfizxDzl9QDIfvtbSM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4111.namprd10.prod.outlook.com
 (2603:10b6:208:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 05:13:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:13:22 +0000
Date:   Wed, 19 Jan 2022 08:13:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/qcom/sc7180.c:163 sc7180_snd_startup() error:
 uninitialized symbol 'pll_id'.
Message-ID: <202201181744.zq89wXU1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457b6700-10a1-4525-d470-08d9db0a69d2
X-MS-TrafficTypeDiagnostic: MN2PR10MB4111:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB41113E4051E14808A84724FB8E599@MN2PR10MB4111.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goO+bmpK1q7eaooQRdIZjhciPs878QMEUrVo3dvxFXr326GBVw0PMDIqi5fsIIZo8/JTk5e9thRjQ0e9zAm7MPZP1uZtgCaDA+T8yiWsX5fF5WSV966a0yDg6FQpV8/lj0S1MMaqFlkgkoBj5e/P3PrlACr8Ga8zHXX8DDQN8RTruVvXq2eurrRkDOKi2ycx688IeDJWVNI0uCse/Dedr/l02voaROdGMjUao+fPO/l/X3TYfRc/78oHmkOC6N4JXgbsbMCbS7FCkT9f9ja4F8vYmzKkSJEdg6jbdz3iVMZQRoBms1PfJRzmkxZhIs8ZffzmWjUXXY+20rqY8qfB04fQBbR1l2aGOLHuPax289svoC8eOQI5XjP/1w+1UhQQAs+c63VqdL7RD7BxUFJnyfbMvZ/Xww2SGt8m0RSh3jyynqFhrRJjk4tJcNo4H+xVRTXHBMzoALjMEh6Kq+1YNc/hl7yxm2MikeLNzD5CsKsRiw5CV6G4sLFHhswEPv24YXWnFDvTYwPWJh0ztX1CDfECN11euA2WojibwkvaHNWNeojBPmck3oOWupwsgi4mgaeFgiucKBjgF1rQ9y7Q1izrh/czxvIciIpOVv5Cm5LYUaS6kepCEhHOCGEYlzbccPFKcfIfLQm9kTVdcFZZytpO26NunCik2n6FxJzrO4h6BpU1ZKKPVzPbUmMRpFNjY6HCSPv6Po7T+QMYkODBqiOZ76SWelK2GR6H+GTnCTr7OEcAF2rsUA21GxRHWym6d9v5ynBmXewNzoAly1HOYELUJo1PMe7KSiu/jlzjStXt0duQKjy18jL/ceCiRg3f9VKdHX9LEWdJ2Nx9IGsThQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(83380400001)(52116002)(508600001)(38350700002)(966005)(6916009)(38100700002)(6506007)(26005)(5660300002)(4326008)(8936002)(6486002)(6666004)(8676002)(36756003)(66946007)(66556008)(66476007)(4001150100001)(316002)(186003)(6512007)(9686003)(1076003)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isXHRv9+jkfSLP87cF+wIsU5ehCQeWTPX1PkiuAdpkzRK+wLfkwQF6zpsKpB?=
 =?us-ascii?Q?LipcQauKNiWs/e+4DFLwtQboi/SWPEmPXmCWAAlD+HaaGDyYoc3WJbLKLsjg?=
 =?us-ascii?Q?f/9SVOCf+lxqsr87dI2UMqRXxKvu8+9Hqd3NHj4idyTx6roMKfHksU8J0A7a?=
 =?us-ascii?Q?XM+aUPIoS2ObeHSd9DE35Zh7Um+VPTlWp2qQtMzgLRGpyqTo2yFMGk6IBZ2h?=
 =?us-ascii?Q?TluCtjezpads27RdNhftkcJbt5iSCjv1KpyVPlREoCHqJOr1fEwsEYcras5V?=
 =?us-ascii?Q?Yu5v43P6ZOTSIGi6mJa7RhJaKPl/PMBJmI2IYONmDJRtvAg11hVSLox61x5+?=
 =?us-ascii?Q?iaSJzv/8YkdEF5ngxgCRbNGyuEiMqkF4mEsK6jr9rVaIKRWIr3jfsC4KCyJH?=
 =?us-ascii?Q?SOeNtfCEUl6RLA3OzysB0L6NxCgiQWHlzga6haxxGmh0A93QNde52IR+faGq?=
 =?us-ascii?Q?OZxnhSNOPJSCdKLZNVSJmylDH/dIf4YFCBOqFdwiqY5RSIZy+JeH0qzVBJDB?=
 =?us-ascii?Q?p/7YI4FyBkE6HVz3jO7Oj/muQ42CoR5AjmD40ulPavluhnfteUs/I0bFhz1e?=
 =?us-ascii?Q?yN+AaAS1Dnc9fC8t5d0lsqfhBMkUDsDj0u4NmDFdULr1wfe0TdfRs7+RRvVC?=
 =?us-ascii?Q?QC2m3xBkJQBbv9cvJHSetat4oHB/EZ5dCW9Bc1f4yQ++w17yapFjYkC7jLUZ?=
 =?us-ascii?Q?VQKeNV1mJcAQfMl1vfAJ4ntCIyoqgf2Hro7rznt/eRXwCAH3e0tFl/7yin4G?=
 =?us-ascii?Q?kWYELio+UcvMQi3e52Ymqm6ITf9M3Z53n1pxqjA5JDqDe8kGtqKj0woXVmwC?=
 =?us-ascii?Q?7VRBix1gOL4ctE1TTu4CC0oET3d8lm4usu2tJnplQf8JRVoza2sX9jeWLLz0?=
 =?us-ascii?Q?JFGX1xg93rszgC8R+8IzjF6+Tuf6V+IMEpUA4iTVPyuw+OoIXa5Lki3Fpitc?=
 =?us-ascii?Q?ZyOSenTOWlesxQUzu7aQXbugv43FfSaWNHwpC7euoGvak6aznCmrIyL/mn9J?=
 =?us-ascii?Q?KAzvLSxgmCJayUZjwsrFcQ1dhS6bGFMxa8PyebVvx/UXKX0mH8JJA+reDfyz?=
 =?us-ascii?Q?75cr84TrHeGUyrA7l2B3VC9A6+4QNjM1WpU9QQ9NTXkT1PZk7GklcYJUe86S?=
 =?us-ascii?Q?DFnBZKSxSGMRFwFs+/ERiWqBunmLKWb57rsWnf9K85X9iWW+X9AiO745i0pD?=
 =?us-ascii?Q?EFeuTIOa02KDRMnBEjXOMJgzmj9xVYE2dePWHOLR+vkIxe/fdqZdCtneaLVS?=
 =?us-ascii?Q?gbUaSMK3P5FO3wggQNv8QG/dyAzLThLrfkN4fpJnJJ5YnlbcU3XwbFbdkUxQ?=
 =?us-ascii?Q?zBP0DHAqPRUVwsNt4qfjSPzV4QE1FKFMCg1M40Bumgv/+iLjM4kRb8HN1QCR?=
 =?us-ascii?Q?+GEBx7NmAxqyXQrig0l351KfZH9yOdF/w/Twta1ffmXwRlvECpdF+WU7xjRT?=
 =?us-ascii?Q?/6haYva94lZCi0w1mIUehbqWb1gfUQroJByOlTBrPEa/KK+JL0Ezl1UW/Jmq?=
 =?us-ascii?Q?rUoHfhfBrCuKHpGdnc8XBRL2XD4LHUTSPkM6wWTZu6TUmkLlB4iVIztBmDso?=
 =?us-ascii?Q?oYNyoQVTl2hY6IVOSQZgByacuBnhwyW7iUmkmyttciwXoYJIF9fLwyt0UCnr?=
 =?us-ascii?Q?inPVxKnrPIkQ5uV6Qm3eWuOU0eB9NCR8JrT9xzZYrWOpnu6yHMpzWbzU+W49?=
 =?us-ascii?Q?J+OJSQ6oi9SyLby442DlR9jKtQ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457b6700-10a1-4525-d470-08d9db0a69d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:13:22.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI5veI4Zezu5OVO15S+AdDaBwrhh8s5b+xMWAQudPPB63mapCNAYMCBMCPotGIui9gUpfuYQMOYX0ufXP6NYWWghsi4VnzE+RjGY8l5hV14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4111
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190027
X-Proofpoint-GUID: WOsWzGTcb_mkbP2Z1K8tRoAo05YK9aS9
X-Proofpoint-ORIG-GUID: WOsWzGTcb_mkbP2Z1K8tRoAo05YK9aS9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
commit: 425c5fce8a03c9da70a4c763cd7db22fbb422dcf ASoC: qcom: Add support for ALC5682I-VS codec
config: openrisc-randconfig-m031-20220117 (https://download.01.org/0day-ci/archive/20220118/202201181744.zq89wXU1-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/qcom/sc7180.c:163 sc7180_snd_startup() error: uninitialized symbol 'pll_id'.
sound/soc/qcom/sc7180.c:163 sc7180_snd_startup() error: uninitialized symbol 'pll_source'.
sound/soc/qcom/sc7180.c:164 sc7180_snd_startup() error: uninitialized symbol 'pll_in'.
sound/soc/qcom/sc7180.c:164 sc7180_snd_startup() error: uninitialized symbol 'pll_out'.
sound/soc/qcom/sc7180.c:171 sc7180_snd_startup() error: uninitialized symbol 'clk_id'.

vim +/pll_id +163 sound/soc/qcom/sc7180.c

9e3ecb5b16818a Ajit Pandey 2020-10-27  125  static int sc7180_snd_startup(struct snd_pcm_substream *substream)
9e3ecb5b16818a Ajit Pandey 2020-10-27  126  {
9e3ecb5b16818a Ajit Pandey 2020-10-27  127  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
9e3ecb5b16818a Ajit Pandey 2020-10-27  128  	struct snd_soc_card *card = rtd->card;
9e3ecb5b16818a Ajit Pandey 2020-10-27  129  	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
9e3ecb5b16818a Ajit Pandey 2020-10-27  130  	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
9e3ecb5b16818a Ajit Pandey 2020-10-27  131  	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
425c5fce8a03c9 lvzhaoxiong 2021-11-23  132  	int pll_id, pll_source, pll_in, pll_out, clk_id, ret;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  133  
425c5fce8a03c9 lvzhaoxiong 2021-11-23  134  	if (!(strcmp(card->name, "sc7180-rt5682-max98357a-1mic"))) {
425c5fce8a03c9 lvzhaoxiong 2021-11-23  135  		pll_source = RT5682_PLL1_S_MCLK;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  136  		pll_id = 0;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  137  		clk_id = RT5682_SCLK_S_PLL1;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  138  		pll_out = RT5682_PLL1_FREQ;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  139  		pll_in = DEFAULT_MCLK_RATE;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  140  	} else if (!(strcmp(card->name, "sc7180-rt5682s-max98357a-1mic"))) {
425c5fce8a03c9 lvzhaoxiong 2021-11-23  141  		pll_source = RT5682S_PLL_S_MCLK;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  142  		pll_id = RT5682S_PLL2;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  143  		clk_id = RT5682S_SCLK_S_PLL2;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  144  		pll_out = RT5682_PLL1_FREQ;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  145  		pll_in = DEFAULT_MCLK_RATE;
425c5fce8a03c9 lvzhaoxiong 2021-11-23  146  	}

No else statement.

9e3ecb5b16818a Ajit Pandey 2020-10-27  147  
9e3ecb5b16818a Ajit Pandey 2020-10-27  148  	switch (cpu_dai->id) {
9e3ecb5b16818a Ajit Pandey 2020-10-27  149  	case MI2S_PRIMARY:
9e3ecb5b16818a Ajit Pandey 2020-10-27  150  		if (++data->pri_mi2s_clk_count == 1) {
9e3ecb5b16818a Ajit Pandey 2020-10-27  151  			snd_soc_dai_set_sysclk(cpu_dai,
9e3ecb5b16818a Ajit Pandey 2020-10-27  152  					       LPASS_MCLK0,
9e3ecb5b16818a Ajit Pandey 2020-10-27  153  					       DEFAULT_MCLK_RATE,
9e3ecb5b16818a Ajit Pandey 2020-10-27  154  					       SNDRV_PCM_STREAM_PLAYBACK);
9e3ecb5b16818a Ajit Pandey 2020-10-27  155  		}
9e3ecb5b16818a Ajit Pandey 2020-10-27  156  
9e3ecb5b16818a Ajit Pandey 2020-10-27  157  		snd_soc_dai_set_fmt(codec_dai,
9e3ecb5b16818a Ajit Pandey 2020-10-27  158  				    SND_SOC_DAIFMT_CBS_CFS |
9e3ecb5b16818a Ajit Pandey 2020-10-27  159  				    SND_SOC_DAIFMT_NB_NF |
9e3ecb5b16818a Ajit Pandey 2020-10-27  160  				    SND_SOC_DAIFMT_I2S);
9e3ecb5b16818a Ajit Pandey 2020-10-27  161  
9e3ecb5b16818a Ajit Pandey 2020-10-27  162  		/* Configure PLL1 for codec */
425c5fce8a03c9 lvzhaoxiong 2021-11-23 @163  		ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source,
425c5fce8a03c9 lvzhaoxiong 2021-11-23 @164  					  pll_in, pll_out);
9e3ecb5b16818a Ajit Pandey 2020-10-27  165  		if (ret) {
9e3ecb5b16818a Ajit Pandey 2020-10-27  166  			dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
9e3ecb5b16818a Ajit Pandey 2020-10-27  167  			return ret;
9e3ecb5b16818a Ajit Pandey 2020-10-27  168  		}
9e3ecb5b16818a Ajit Pandey 2020-10-27  169  
9e3ecb5b16818a Ajit Pandey 2020-10-27  170  		/* Configure sysclk for codec */
425c5fce8a03c9 lvzhaoxiong 2021-11-23 @171  		ret = snd_soc_dai_set_sysclk(codec_dai, clk_id, pll_out,
9e3ecb5b16818a Ajit Pandey 2020-10-27  172  					     SND_SOC_CLOCK_IN);
9e3ecb5b16818a Ajit Pandey 2020-10-27  173  		if (ret)
9e3ecb5b16818a Ajit Pandey 2020-10-27  174  			dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
9e3ecb5b16818a Ajit Pandey 2020-10-27  175  				ret);
9e3ecb5b16818a Ajit Pandey 2020-10-27  176  
9e3ecb5b16818a Ajit Pandey 2020-10-27  177  		break;
9e3ecb5b16818a Ajit Pandey 2020-10-27  178  	case MI2S_SECONDARY:
9e3ecb5b16818a Ajit Pandey 2020-10-27  179  		break;
9e3ecb5b16818a Ajit Pandey 2020-10-27  180  	case LPASS_DP_RX:
9e3ecb5b16818a Ajit Pandey 2020-10-27  181  		break;
9e3ecb5b16818a Ajit Pandey 2020-10-27  182  	default:
9e3ecb5b16818a Ajit Pandey 2020-10-27  183  		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
9e3ecb5b16818a Ajit Pandey 2020-10-27  184  			cpu_dai->id);
9e3ecb5b16818a Ajit Pandey 2020-10-27  185  		return -EINVAL;
9e3ecb5b16818a Ajit Pandey 2020-10-27  186  	}
9e3ecb5b16818a Ajit Pandey 2020-10-27  187  	return 0;
9e3ecb5b16818a Ajit Pandey 2020-10-27  188  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

