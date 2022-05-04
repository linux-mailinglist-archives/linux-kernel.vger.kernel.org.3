Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B2519B02
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiEDJCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347197AbiEDJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:01:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4C275C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:57:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2445BMuE025194;
        Wed, 4 May 2022 08:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hF5yqn9xT5LAF7i65/ntZBh7sDKOL6GC+z7djXgIyvw=;
 b=JuVN7NENGOy0erpmK0gVRvWEYZRbr2azGmNl7N8ioG7O7HcrqMGByr5lf/KDjpW9Albl
 wavm8uvZhkevsjTrs7ATj/Vt1V5nDGrgQVpmhQFoczR92BIia0jbbubdiQ/Vr3FZ+iij
 lvi5B1mr6Mza2H4ycUdEl5xyK4ajV6Xtcdrsp+8PswQ2opSmEXTaNOhCvoHO5vMIUTcj
 tKkgYL5rYvclJ+GeUNhZZDCiOTLs2dAU9tMAZFaTNk8n9CRoxTR8UKmCwsXVhZmwWBhX
 oqU0wyPueqwrGAURh6bd3Dav+kIR3rLprQO6rsnqzuce3rKmP9s6o80SFucjsp0lU7KG bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2fuy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:57:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2448tRGf012312;
        Wed, 4 May 2022 08:57:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbn5dv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7IjAZP82/bF8j0Mwe0Hnl7G0lXPSF/mBkQMtAbbBkQ2a8Z97zF39bBdWsrzeXZ+VDloKjBULN292tAG6tNAbrj6Zqx8p1lvdDuwF9Vz4EPlrhkR88RffuwcC5EPJeUmRCwnkp3t/PBHq15BrvQn7St6xCoyhxV1LI35cSanywQCHd5EETGzv9cXef/vM+FVGk+bUEpY8z3QyIMBxfxMpZUx7/r5siZSahGgTRc/pz8lUEx9hfK5cJTPA29bhnpo9rdxXaEcEQLfm6fB4zESRa6nHL7EzxJzhiEyNj0dSQwtmbQEkSTowgHVr+Ro0TC5GfzfYvdL5mQlL7KtEJkfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF5yqn9xT5LAF7i65/ntZBh7sDKOL6GC+z7djXgIyvw=;
 b=WI28nSQxqSUt425mNkwki32RIsOqZ9LDrxAOfJSUihrkF4X8GOWvZOtSpAGiUKqcljwqfe/PgIqZxJtv+ivBljSJvjKTfrMEnQ21bwpbxYaoINHGdVTu+5C5Jh47JCQtXlQl6xuWheSHtGoFNH6cAxqv0t4r0xqAdX/hMOuiURsRAlZNp/IMmliymWSPZZmbEuWYpGFnQPHe0LKMix/cYrn2651m4wbdd3z4zAHU97iWk4vyBJsW2lig7m7EjS5TSfyZBn9OYZzLT8NNzKgDAny+Ulp3W/rNKMnPUjRs0iHOOcuuRerJutXlWiBi8CB3vdrN5iI6AHfBwOqK4jbDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF5yqn9xT5LAF7i65/ntZBh7sDKOL6GC+z7djXgIyvw=;
 b=aniMCbcgIYuv1HNXgFCVEgATyDpKcM80U0acq8yugpXsnIwi+KDdqDF+yMQ4NUpbCC9uYld8ZSFNH79SGskpHo3weV6sSs4NTa4/mpca6UkYPP5/WcYUcQNe0pOUj8nP5DHVnGYoHmt7GtL1HhepnEGZXZKstCu7UbX0Kx5JSMw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4772.namprd10.prod.outlook.com
 (2603:10b6:303:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Wed, 4 May
 2022 08:56:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 08:56:58 +0000
Date:   Wed, 4 May 2022 11:56:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@foss.st.com>
Subject: drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn:
 variable dereferenced before check 'crtc' (see line 1119)
Message-ID: <202205040556.P3wNmO1e-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6657b0a1-66bd-44a4-2a17-08da2dac0b73
X-MS-TrafficTypeDiagnostic: CO1PR10MB4772:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4772ADE9985D6ABD0811C7048EC39@CO1PR10MB4772.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9Q4I13g9CirjbS10i+xdD3f5TPqNSeKqx+1F1PpFF2hQ82cO6UavvyN0PsH+Gjqvspwt6A2i3BckWFiceSE63uV6HjbreqPv0fLKD/IuFDubvIw4YY4xLosbvIDtzaJKU6z4bSfC/D2Zcf49OCByjBW+jZiD9vHrNtb/8qoxA07YKSZByAvZg62doOV0Ko4yi4b7JsmPBnPRDGrOyU9YfMdpb8jKjRCXJhVk6Uf/35v+LgqIsVxpcg4MPq3B7d61o1dbQwfXj6AzkyN0zL+26D7xXPX/TQacnobqB0n0Svq9jXM1gzPc56SxADy5/LQWwlL1PYFfACdT9FjDM5hPlDZdqx0hxrbZwz7ShaeQpLa7J8OhLKN4Af+AvAHjQa6bCaiakBbkEc5z2rsI3sub+/XlRWJVr9m9bLI0/+nLwKDfk1X9Lbcr8H7AkoXY1gU6sGOaO9DyN2VZ0QqXlBEoX9NFisRM1Vvo8Q18IewX+CAv4YhZrLrE2kjTqv6HsKAX3mqX35m2cOKe09jVL8+wLuSiDpih8Acldk1M5/d2IPuLS7FYLMfAwpud5Mo4Bk5hHoOxb1dhE2PTIiD1kVt+LICyh/U8iiswTO96ChEwN5FB/+PpyrKpQBPeOqINniQHB0hueMfcJkVFdw5wdH7g/7q08wxc25PTRk6OeglJqAmvFcFfW9L4F//kihGBIIScY24Lhtx0/PJnD55dzaRe0K7AZZrH5rOtWwKpOR/ErQ96HR9doccpbBHhSnmgwRXinrEcRK4JrBOV62bXwi9uEU97wfR4IqLCBQbM8JlMmtCLkzFlHqxjwskBeZB6HtIfco3XbKGbHv+QDFX8F0+lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(2906002)(6666004)(966005)(86362001)(6506007)(6486002)(508600001)(8936002)(5660300002)(9686003)(6512007)(44832011)(83380400001)(26005)(36756003)(186003)(4326008)(38100700002)(38350700002)(8676002)(66946007)(66476007)(66556008)(6916009)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lha2+pDitSBi1BbcUQac+0UcIRglCUs6+l0+T1ql7yBL+ONE4BYAB0abt2Tr?=
 =?us-ascii?Q?WmB8nM72/s66HYECbgDR5hmb9/CDB4MsQOT+m7hxOGmCS8P89MuaVLBHH4R/?=
 =?us-ascii?Q?10osOkiDCCrmwYAg67ZJ08SiCa45F29ngCx+bGhMAFPoJ0rtLJBkyHnafPdh?=
 =?us-ascii?Q?ObWlNLpWKKzT2g/B1jiQZjz3vsiNeQA3Bv4/4n8mPZLGlwoN92YDrK/L6BBa?=
 =?us-ascii?Q?95uQzOo0ZIV8B1mpgrCuumKn4xMdjV+yH8mfHOhpSRfWHrfgZGx7xJM+L2I7?=
 =?us-ascii?Q?xrfZkjROS08EvGLVZnYNs4Shb2RF3fmXOz5bnSNILAvDZVLtY3CHHdtixGYz?=
 =?us-ascii?Q?2e4oZ6s3XWfcnlpb5yJdK0whBeLd48oVCsC9y4ZG2HriIxk/JdDNOr5JslGO?=
 =?us-ascii?Q?aLbPuSFWsOccSV6l/36q3CVe1G/1fVamCJzoLrFG69hYmO/bVmxTDqb923mK?=
 =?us-ascii?Q?ylVR9E6q37uoi+E5GvnXCgfdHlOZ89A6QejXfRDE8k1A+XeCwqMvxbJr6R78?=
 =?us-ascii?Q?Q4IMbA3DT9osHmHd0o35R37csyuok2Jy6mdRjUSeg+z5AZKo2oCVr5RadOGo?=
 =?us-ascii?Q?1ZuJuYjFPezlG3GGs2jyIqe7lCp6/ZZmrEPG97XHCgCOqu3xsDr0duxFTRYn?=
 =?us-ascii?Q?RhuKmSO+G6NF76SNtDzayyGacAmvN0W/xNcbBlCi3+vZ0SmB3ser0Pe+9JzH?=
 =?us-ascii?Q?O26Gfom84UGVHCIEZ6CE1w4Fzp+1qozyn/BUg84Knaizi8NgkdPcSHDILqyy?=
 =?us-ascii?Q?trixsm/HZkRtDgrwQKm0ZpOfaw7iUuhaX1jJq9NGmp0VjHoRHdUYwk3XcvbR?=
 =?us-ascii?Q?Z9faPzxUupCyaRYSFRdWMO1Xrv+9q5JJCnqQtz6l+IuUOKXisMzQAwkWYQRN?=
 =?us-ascii?Q?jN77DOFUisA8lSzcD+5tWJIkpEthtecTbwIa40v5CViZaQTjpDuK0l2S1PO1?=
 =?us-ascii?Q?wuUcs2vWh5mEhPHzWROWkIjeWJXhzbCCBo569wKCPPCWxK1CPodUMehnFigX?=
 =?us-ascii?Q?6uSZDch4zaWSpo4S4u/LaEcrdAjg/WTwl/3HZ3EO+mAaQ6SG4oJ61rGqv8kB?=
 =?us-ascii?Q?RUqrAthlxFIUiA/6d6nlyVgj31FjcVxV5S7lw8lwhrFdNSWFWTzJZnbixfux?=
 =?us-ascii?Q?d2AZ0UxU/Rqk38I/sULJRHZPgS8Xkd9mOf5hWxWmrN8G8BT2P2dYnjs2xVDh?=
 =?us-ascii?Q?oNEV45I5N1kckAPCJZSnzRCcH1wL9Zvz0O4/i91h5Lkk+z6qkXTwiyLpIiR/?=
 =?us-ascii?Q?YKihs7AkM+Sxa/eX8M8Wco6RqiPUxniC18QO4mx2P+Lk7KIdSAU/YoZ8muW5?=
 =?us-ascii?Q?rRkeBHoi6ycm0ILbnJm7jVQApnFtGRZyNd0QSeXJe+hDLTdOINdzOioa6vA3?=
 =?us-ascii?Q?uf9kttntWuj1igYd96G8WfCn3SzUYk5f+RvO1FcYEgXBFsU4hOHPj6jUCoTq?=
 =?us-ascii?Q?CHTpc4TFgX59YyyalWjqu20piHuOdYPxafnruVApLn5ffwwosDiWn10wJQ06?=
 =?us-ascii?Q?eB190EF0E+yXgr/m6KpKghf+yQPBXnK8N6EuI2T7ZpeAOdimJ7+3QRkDdPa1?=
 =?us-ascii?Q?rJKJKF+UUz/GrWm7qBpdEf08cMJRzQ260FsZqi2GLqczUNU/sipLAkUFJ4hq?=
 =?us-ascii?Q?F7nmX4KtyvGMyMwjW9WKe9u/aaaO9whmH60/DIw/dU8Ao+/6DIccBDp6w15k?=
 =?us-ascii?Q?NsirfVnLxnD6NSVulsSbgrQzY3LG78tcJCO3KilieAmSb+H1vBQakNPxPn4e?=
 =?us-ascii?Q?+GBXG1chKGlARkn6bh5sgcwB7WBtTUU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6657b0a1-66bd-44a4-2a17-08da2dac0b73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 08:56:58.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSgR9aesGhNb8nY/2xsmKaGladpRHLTCAfTfCcG1PmjqzyPMSpUbxPdq0uzvFutbaMcXSmwo9mrw3i+RyhPfUVnYe1cLhzLmowyPhYAOzjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040060
X-Proofpoint-GUID: Lf8oDkxK6bKRV_kDc7KWz6ooZZ9tl9_u
X-Proofpoint-ORIG-GUID: Lf8oDkxK6bKRV_kDc7KWz6ooZZ9tl9_u
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef8e4d3c2ab1f47f63b6c7e578266b7e5cc9cd1b
commit: 79b44684a14e363d24c299b772f037344ad8c8dc drm/stm: ltdc: add support for CRC hashing feature
config: arm-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220504/202205040556.P3wNmO1e-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/stm/ltdc.c:1124 ltdc_crtc_set_crc_source() warn: variable dereferenced before check 'crtc' (see line 1119)

Old smatch warnings:
drivers/gpu/drm/stm/ltdc.c:911 ltdc_crtc_mode_set_nofb() warn: pm_runtime_get_sync() also returns 1 on success

vim +/crtc +1124 drivers/gpu/drm/stm/ltdc.c

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1117  static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1118  {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1119  	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
                                                                                   ^^^^^^^^^^^^^^^^^^^
Dereferenced inside function

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1120  	int ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1121  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1122  	DRM_DEBUG_DRIVER("\n");
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1123  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11 @1124  	if (!crtc)
                                                            ^^^^^
Checked too late

79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1125  		return -ENODEV;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1126  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1127  	if (source && strcmp(source, "auto") == 0) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1128  		ldev->crc_active = true;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1129  		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1130  	} else if (!source) {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1131  		ldev->crc_active = false;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1132  		ret = regmap_clear_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1133  	} else {
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1134  		ret = -EINVAL;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1135  	}
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1136  
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1137  	ldev->crc_skip_count = 0;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1138  	return ret;
79b44684a14e36 Raphael Gallais-Pou 2022-02-11  1139  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

