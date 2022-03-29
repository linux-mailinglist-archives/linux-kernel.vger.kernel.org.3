Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073E4EA8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiC2IGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiC2IGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:06:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4013EBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:04:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T63Tcg016044;
        Tue, 29 Mar 2022 08:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Z05oSwppDk50XtZwIGWtldUQ3ZNxXxOSgG4+jlQMld0=;
 b=gxcAqomVNbY/RG+F/VxnzTfOmYo9SNiqmQJ71Vm9tJKbk6AwRpK4e8HwIp1Z2eduCWqv
 tW6krL+hweMFD19LcA1xMJyN7wNbB2geqEnX6K8tVIN8StZYUckjZr/JiSUCtThilSpx
 lHtC/Mk+gCZ7ApZe2SXoOGdY6Fyjzi98IGm0jtncFM6LCtZNroIK4shiDK89sn/ThCt6
 w4iL9ccL4SqhQgHeaJHi6QVvt+J1yFo6GZfLFYviVBRFznj+eR8UZ34KgkhuVBg9eoHV
 YRyAIzXdeapfbsvKx/qUHXDzd/8tRCnfDFJBaNIVT+e8+5121cdK7qBY9Hbqiikf3y91 VQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1terwswr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 08:04:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T82F8I109100;
        Tue, 29 Mar 2022 08:04:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3f1rv8c44b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 08:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpaZNfR7i+2goBNZNTlN82xl5MY6sVThQY6/CrbmgXchU+eBo3BG/pomy5xj3k/FixeDgOLCGK7jaGNounDJQKe2ILELSPp6lSP4no4gRvvv+6VwZynnXqshJfTCQYtb8BGpNL+xfWxjC6g3aLoHt/cRgHXuHEoA6T9kGMxkTco9zu42iIL0i4eYj/fqHkjNiG47oaPJHdzcLSAGXOuhnFhYTku1Guya1WtGeX/9Yg/3b121z3zQJDvGYuy/7D+ImQpJ2H8r2+7bCZ0m60BSYthPJKLh1585D5+2erfCciRm/RmgvZ/LQE59wQ12uH10hviBachvAjtAWWCdRW3MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z05oSwppDk50XtZwIGWtldUQ3ZNxXxOSgG4+jlQMld0=;
 b=TkyxA/APeobSH+PokZvD1M5xMhWr29M2GAUd7Ail8rlIl5NwSdNNSajTXIezQKiwH36j0ZC5/xTfqePRgDHkhofHhSYzwGDjO+kmDzZqb8AUj6dV3DGOm3VY8lriLgVjZA1nNFRrmiM1nckgZQeBuWCvdekqdjHY1wJ12xdAQxb9enCdALk3lO4zEoxpRW2WtK3xdKytXOUeUH3JgHdKeqGdrqQUlyHBGGv8lreQpz1YLl+8VQFgfvyGD+GcApX+exstyJJs8gsjKbccbjEO2Fx/Lo/0imFx/TlO0SMe0dkVpihNeyf7yonHs0h2HYqnCNRWBYjMHSX0r+teM4dAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z05oSwppDk50XtZwIGWtldUQ3ZNxXxOSgG4+jlQMld0=;
 b=TUkUwxC0SYros/DagkRIc4+jXQcQbU8qo6tZ15C9O4LVguUVxD6EnrbXQ36DLXTVmpF3aqOFOyZZ+HUHuIQeWTernHmCL8EkaLeaW9DnhHZU+bvTA7S+l8jC3VFbW2vnUB2Tai3z+Zqm8VS9jWavcZW3+/EsUgVesru7+5/hvLk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4522.namprd10.prod.outlook.com
 (2603:10b6:806:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 08:04:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 08:04:37 +0000
Date:   Tue, 29 Mar 2022 11:04:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/generic/simple-card-utils.c:367 asoc_simple_set_tdm()
 warn: variable dereferenced before check 'simple_dai' (see line 363)
Message-ID: <202203290343.9cbKTLxo-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0052.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7016c559-3f17-48b5-3f2e-08da115ac4d1
X-MS-TrafficTypeDiagnostic: SA2PR10MB4522:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB45221BD28A606DCF9058B4EF8E1E9@SA2PR10MB4522.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7y0HKCsZZZ1SEpaQaffzQHODT2L6gKzpvOANPOzSljB6WlCts/GmqjM86YfoXDbBiRqI+cJaDC3O8OcPpLQoO3EdHR+1y0FkWFqtknaEEvNSC1JtjENBdwOrbDTDFh2G2+lfoZjdc/fwT3xSjNK7aPf5SVQvmETogq48ZtGo1O+r3ve6MrodSLL32vB5a1y0AM0TJ+SQorudhrZ5gsoEKq92qVtg+2K3BsoQx8x8n5D7ZPC37x1FktKCPjh2qbGdQjPcAATc3T+8cqz3He18kon+AtdxuIN9Rn2Oxu7g01hDD7Yk0XOm0NnsVkRPDpwmT0tNoYWUm8FogiXtZpXoJi19iFIYJXEg2I+p6vwopw7g7DEiDNFj8c2LeN2NLR/8VV6I20GY9zA+e8A90gtedDwuREZG1Lqc2Bk0MyXpvLImXinF7AyzFQZHqQCSAVl73ancK3J4MptQWehrVGc4l7Ijzx2taDGbQGg9d+s/lIM0M/VIWxLciogqAeYLyi3klo0A1A7g7XeZJYUYM+NknsqEeE/kKac+HFWXr6paXMkv4Xf8GawptyQXNpdyFUEJpoVZS5xbp4sFnexfFKq2L6kWDdrQsW9LhzBBf3IPqpvD0ixyCdQ8LTHeFpECGTUcnGQL452vPhdrU67IzHhFD39gXawP0WHjAdjobshyVQnm3ctpdmhLm4LELFEk696cf99KCa4labUDG8MOSCdxBqPiadxB68ggniAJN1M6qbCjYAUjfL7oHeuY21kWHjkmZqJHTbXmb/NlYg2gCR5culV4H7O+bvisNj+kl3i9wWH858nlvHKfiRyumzGg1A2YrakUyupEEnophQltaKTSagfhol0PYudDoNJ6sEBc3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(4326008)(966005)(38100700002)(66946007)(38350700002)(86362001)(8676002)(6666004)(6512007)(6506007)(9686003)(52116002)(44832011)(8936002)(66476007)(66556008)(508600001)(6916009)(36756003)(83380400001)(186003)(316002)(26005)(1076003)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqBkRC18j/fyA7pfbosCQHAORh1Wy8/ENJKJaoz0rtWIcv6gickFbOATDFeA?=
 =?us-ascii?Q?lN7OXw1jfbiOFJcNc6HBTIoXfAwvgyXfcV9c5c8CGE/22Zdl0+4pmg8i0mT3?=
 =?us-ascii?Q?xnsF/9KC5qUsLsQZAsvwtONHw3SFqU2Q23QwfxFgvm9x7py/jbhO9ygoqaEm?=
 =?us-ascii?Q?roEkcNriSXrihLpikpHLSHE1mAlfo8b2MmzbTO04mzTHdYiCXu2Sg2Ix19PO?=
 =?us-ascii?Q?UgZOImGqGcVHYHwXD86NtmdG1zrTw69/rJyyLLqhi3ndIdIQ3el5+87goVXq?=
 =?us-ascii?Q?Od8Odp01piRdCtt2jCQ4F6P13SFBRogOQp4TyT3foGgdLlwyXCyo5+t4DpKf?=
 =?us-ascii?Q?XetSm4a7NrF8guZKqUnc1niF7Q0RESMcWLVrbmK/n8UL0AhPlr1X9RurWGaz?=
 =?us-ascii?Q?XvvGjUtJFRIgQEpij8Kke9B6bFTxoengU76WzSwutxkrNUj6A32jc4YJfTl6?=
 =?us-ascii?Q?db8oMsSmr2FqM5zcBrnd7lIybOcuTr8Gd+sJhZ2BtPb/9Pv+0jbdtSRUiWpU?=
 =?us-ascii?Q?lP4VCmoURn+BS87+3mDeAzEOibxlZcxttNKaEpG8kUM8ncoq6xJ58vreuW+C?=
 =?us-ascii?Q?PCd3Cjl3KPefpAI6n3qRtAWv7wNQG6hCgokQAc7dOT5+fOu68o7X0UFpiKOh?=
 =?us-ascii?Q?tdfrsIflBa76kpGVPZgy0+vCyKJhD92T41l8f+yYPlN0XJRViQMKQSojRlT0?=
 =?us-ascii?Q?X6e12wo0068Z6vQRYS0lQx3dkj/FOiI4T2WmyhsXxNjsX7/Oey7r57N8iEXB?=
 =?us-ascii?Q?S6olznCAQobDm4n/aC3tZB1AlVZ/jDXvBqYXIBo3+54nT0iYrgZ0tPZfiSu1?=
 =?us-ascii?Q?ZgUq4zjKm/pynpAU601bYlq14Nc5FypZjudswv5d+TIMOnxeu2C/M5jmfcac?=
 =?us-ascii?Q?VVTl+97LUOLSjedgOtKIF6poRwiPXROKsYJcPSvBydmcT479vy+OuFw7BqC8?=
 =?us-ascii?Q?1pHwPXbmV7imdC/Z57OtzQrA3RiZ+sZP+DuJf0IjsYdWRHDtwo+OJE3IYtC9?=
 =?us-ascii?Q?QtarSmpaoc5UW65lDmsQDi7RB4fLPIHAdkZ7K6kE3EdN9TyAg7R+6sJCTTu7?=
 =?us-ascii?Q?VUeh7juUG9OO0akwy5QrEAdm0ScwhorT5L71TfyAez/ChGXPXvlxHZy39Z23?=
 =?us-ascii?Q?eWdoYXLRTasJzoYuzxgF0OUcWPlUTNGm06KOClUoSjWNjr6OcRSMomfTv/As?=
 =?us-ascii?Q?5Y+mRSIST3wDAB8AP+lb6gG2TOavdVAPX2DcbWuig7V8yBLx9nmHEFx/ZGO2?=
 =?us-ascii?Q?V83472cb779eTJpnawaVryYAju9q5EXVwgjzbI6rCWMdIDL4qSbkF/6I4pCZ?=
 =?us-ascii?Q?r1PZJWSLanpRX4JsgID/ipKhBA3V0BhpSre+MW9rPw9vk53MLVZ3uiQFs9jJ?=
 =?us-ascii?Q?ZSOHlB2pQp6AQzNC18gZwAM1x/z1DY+OCedtWiCv8yj6sLtm9Z2Szk6kKAN2?=
 =?us-ascii?Q?cja69K1u0QyR8OeGNV2l4mFmJsRCnhzUvKz0oK0r5ZYt+mpNs5PatrJCdi9y?=
 =?us-ascii?Q?JNUcRRN8V/pKAWn6T9HMlpPVulujyvEYAjzecLAreCGZUjA3nLBXSS262UK8?=
 =?us-ascii?Q?J71jlYUJRuL7rJU7xnYinZm1sobS79juYfEiPONm8s5NsLSW8etK2nxmcrTn?=
 =?us-ascii?Q?7vA7XQFFxaGV1j5OvymOoW2cTz9n5LTLWkrWg5vwo33fn8nm4jDJQhAKdY1Y?=
 =?us-ascii?Q?NTCtg07d8zcm0YL6UWR3o/rulpBB9tMS1d5RP+TM8L1HoPZhrSfLsJy+AjlO?=
 =?us-ascii?Q?r60ugFq3DTPji5zYCuCPBPP8r+XpgN4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016c559-3f17-48b5-3f2e-08da115ac4d1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:04:37.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQMPfp8DxXdZBVl4tzWifK2bGlWrrYbcgdTLpUlQxvTppD8L7PdVd6jRSalvApuBgf+pyn4qN8cfMz3jTi1A8SBUe82Bs1PuIIliLmtNz4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290047
X-Proofpoint-GUID: Z2rocmVwrTYvjoGGQg4bbc2FvxAt6G5x
X-Proofpoint-ORIG-GUID: Z2rocmVwrTYvjoGGQg4bbc2FvxAt6G5x
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I reported some related bugs earlier but not this exact one. -dan ]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: 1e974e5b82b3d75069b50445cd248cee0199654e ASoC: audio_graph_card2: Add support for variable slot widths
config: riscv-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220329/202203290343.9cbKTLxo-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/generic/simple-card-utils.c:367 asoc_simple_set_tdm() warn: variable dereferenced before check 'simple_dai' (see line 363)

vim +/simple_dai +367 sound/soc/generic/simple-card-utils.c

1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  358  static int asoc_simple_set_tdm(struct snd_soc_dai *dai,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  359  				struct asoc_simple_dai *simple_dai,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  360  				struct snd_pcm_hw_params *params)
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  361  {
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  362  	int sample_bits = params_width(params);
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28 @363  	int slot_width = simple_dai->slot_width;
                                                                         ^^^^^^^^^^^^^^^^^^^^^^
Dereference

1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  364  	int slot_count = simple_dai->slots;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  365  	int i, ret;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  366  
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28 @367  	if (!simple_dai || !simple_dai->tdm_width_map)
                                                             ^^^^^^^^^^
Checked too late.

1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  368  		return 0;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  369  
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  370  	if (slot_width == 0)
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  371  		slot_width = sample_bits;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  372  
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  373  	for (i = 0; i < simple_dai->n_tdm_widths; ++i) {
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  374  		if (simple_dai->tdm_width_map[i].sample_bits == sample_bits) {
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  375  			slot_width = simple_dai->tdm_width_map[i].slot_width;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  376  			slot_count = simple_dai->tdm_width_map[i].slot_count;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  377  			break;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  378  		}
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  379  	}
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  380  
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  381  	ret = snd_soc_dai_set_tdm_slot(dai,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  382  				       simple_dai->tx_slot_mask,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  383  				       simple_dai->rx_slot_mask,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  384  				       slot_count,
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  385  				       slot_width);
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  386  	if (ret && ret != -ENOTSUPP) {
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  387  		dev_err(dai->dev, "simple-card: set_tdm_slot error: %d\n", ret);
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  388  		return ret;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  389  	}
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  390  
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  391  	return 0;
1e974e5b82b3d7 Richard Fitzgerald 2022-02-28  392  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

