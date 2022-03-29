Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCE4EAA91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiC2Jaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiC2Ja2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:30:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B559D053
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:28:46 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oVAG028622;
        Tue, 29 Mar 2022 09:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SaG+MLP+RT/iNav0p+pat1HqwxrV+XL7uW+rsWsZhxI=;
 b=ooS0PLvP4lJ/AK/4iT6EoKzhQ8r2s/sr5QkFVmhAfrinQO7GPiamrGFQOHs3+E3zszHN
 JFJFtV8L2c8vEaRqZ3vRy1hLXVZDyU/BqA+pjN7FywMd5pPWw4DyfYIZyd+8fX029GaP
 gTZFaDNmF2g6ws27tBTfIDYAKRWHr66O4T1q+rsRtF89lLoExjGO179uxEsXcYXTGjH9
 dU4ophK/WV1LuT3Q3HOFAqOtwQGes0smanauH1gDrDNTckR17tTVsyZpkqRqVPEHT28y
 fqMtsMjAms+4vVCkhnjEAlbUkyWEZihCHG3N/Dc7RY4yb7C387MfmLGcacozBbT5RW7m xg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb606g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:28:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T9B9ES179358;
        Tue, 29 Mar 2022 09:28:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3030.oracle.com with ESMTP id 3f1rv8c8fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 09:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4aF5wqoij7Cqcdi8UQuKVAwDZDwgOf+wa26a6bAc/6D1S+Uwr2UZXR1bvWHHydmq9sLF5ZSXG/JtWJSVsVOcdbhl2k9c2zZ6IibKTs5ScqCCPF0YCiC8tGjOxHVjfNeQQx7Fe1oh7R4ggKn8Jd+4bO/LtZft3xrv6YFHd3ekzUC1ywUi+EmUmJIhF4s2QEMXJ7UZ6AWQASg2y1+pIeS71y33Nht77B1VIS3BufBZ+dJg6tX8FcWwgtxF6aBFiiSdaaQp2GSXkfZ0l0bFC8nF1sRn80irsZ2r+vVlo1bgUgkKPgD5izT/xAEjdRqDF43+N9nkvbjB+SIioJrRVrVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaG+MLP+RT/iNav0p+pat1HqwxrV+XL7uW+rsWsZhxI=;
 b=QHMTwIGIE8u56ykyZo+p2gLujuASt0bKKsMdma+voL1RswsxPMNqIKMdiSVjmaPDRwMZYQcD6eHHYbYQTK+moQS7KTJbkrl4EoQCBRM+yEIqA2eH9w7cPT3SWKUJUjWjdM9TkqXSzL9uIKjrJ+40oVcrUWEynTQwJYTbr1gAkpiNILmBHlpoBvVdDhEgTU2pxBcDcijecFco7/9snrL0un3tyOG+kPK6zFbTK9LW6swfa3l3/0F6uvHG1wlCHHNLyHLqkdVBm6SG65wzKrRIQljt6RdrEC6VPzG6qslWTPzQPafEQiRmBxMQZixi2+go0RhZMFugWo+2bTswan+ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaG+MLP+RT/iNav0p+pat1HqwxrV+XL7uW+rsWsZhxI=;
 b=xbD27vPpVPhUFTTHr47/7A2fI1Juluwd7+K4sSw4nI5KF8LopfOsxDcfQcaT6y/8/vrOIgTRyAmAwoKKwQ+sBIiUIpj3wue6YDNi6jGyGOz8dZQwfzgZGiWgtUuE33YXlQq/JLVIgMuK/+MtD05ag6b6IWbq/QU3/GrFz6dyxP0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2913.namprd10.prod.outlook.com
 (2603:10b6:208:31::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 09:28:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 09:28:28 +0000
Date:   Tue, 29 Mar 2022 12:28:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/kspp-stringop-overflow 5/5]
 arch/x86/mm/pgtable.c:442 pgd_alloc() error: uninitialized symbol 'pmds'.
Message-ID: <202203291451.bKVdLfSv-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5817d856-b296-425b-1be1-08da11667b9b
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB29134D232C703D8BF83D83FE8E1E9@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRc7sjiazkzjIoBkOGqSzFW0Za2xvgdYx7FwlGAbEcbtCeA6+iXadEPMN/8Fo1VKJC/J1xDDn5f0vTU10fI18FjR/utR1X9oyGZxoJCbmiVQAHXr0OyMq9SPfFXARU7JiNZx+s6cRYP5Z3ixP6wkK1SLazPV/3Jtp9hBd0M/7k0tEhnjwDubAcCAlRD1k2gBSmG1r7WaTGvoUflQDAkHMmArcPC8ZKQjUaMA1GJJk2UC3fuFZHN42ftOSBFtRRS6sTPfbebN/ecmvLlY31IJoadpymNmTKV7tXP9HxWq2z4bbewxU7oshR1C5ALVG7M6E89w9LZiC02HQwHyFzdRYpH0AQgQDs1gl2wsbsXrOvKfr9V4Gyg+XxV/HSeOt1FRw2MHeDCWw4TPEfScRU2BhFmuxCkiGpH6oxcZpLmVmAG5iVRMLzk8oKnk8QVe2iKz4Ne4HjZ3t+D3KhUQUqoSg69Rk/yG3kRQDwpRFvqqWlxBQjpi4HRfF5jBUg6sExOxgzv7ofAc8j/hUSFLykmX5sbdTjpprbPK+JmO00ISfrHfWQd/JeX3JMQ6TeU6xpf+o/Iktwgs6a50qxlG+0c0k7gM8wyM6xGE+ERrHkJW2MTjl5FC7/EkdqtIytbtVQSziVH4ECMIpi/4YhrwuUhjT5AFiH1jr6YNIXZFbcra2tD1Oj+bY8DhvZcTLgdXYSGlOWi3UuhjwApAvgDsmSy+PyY09YK5dyXWr90FOp/e/W9fXikIZhNgXFBMNRdbGm/WI0bQI/Wyqf7lqxyIXQVWnZhScP7uZR6ZRkj8TO9xHhWTnA7j9QDmA7Z4HocXRaaXiWOfQz3zl/CxnafbFRdUoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(66946007)(4326008)(6486002)(316002)(966005)(54906003)(6916009)(36756003)(66476007)(8676002)(66556008)(38100700002)(186003)(26005)(508600001)(6506007)(6666004)(38350700002)(52116002)(5660300002)(6512007)(9686003)(1076003)(8936002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sN7TlPQRYDw59IDXF5FTCX2tf8dyaL9yD/AUmlzGTXC5hgKjG6d5uLr89nO+?=
 =?us-ascii?Q?3YhFpBMYmSE/e6/4qziT/7o4qhWIjZ7S3fVOQYK8gzmjRJDXS8GyFmKsUtyJ?=
 =?us-ascii?Q?UT0NhGeLDEPNTQgoM14re6EQezpgDHnGH0PkuNElr9HjHQyu+uDg+kosOHrD?=
 =?us-ascii?Q?Eg92aVdW2Bb2TjQkg8KHXvDtisSYAih/C4jFD92U5VQkgzHo6c/ZlStNLbC7?=
 =?us-ascii?Q?YPEkZccGb2KD+waNURfOhDWnPLBdBWzzD5cASm5VESyfEdzbEUbopBGnZ4QK?=
 =?us-ascii?Q?8uGz6jdJGoemynvg/AXsfElsKBy0YwVnz2JPavQi6tin3fYHjypE/2UcWFo7?=
 =?us-ascii?Q?pSlVANvRHwVtYqKt7HCdRUqpi9a2yZijIgQHptZtCnI9NmdHePDZ+MKh72x1?=
 =?us-ascii?Q?YlacWY9xJTLngVVfHU6WjIQm4y22ZZSQn1liv0HZ508x7cF/xhjdgcqr8jFu?=
 =?us-ascii?Q?EPmIxESCYQb+MrwikXlPbJ9V8QNdeEcVFdlaVw8JU3BNPH3WCCK1Gxfl3SSd?=
 =?us-ascii?Q?1Cx7Bg8s926ZlUCJRX9WeQpr8W84wHJO3wY79c3wuvll30V3CyBzMBOEtrGX?=
 =?us-ascii?Q?J4JRbI50K1WvLgks4z2MwPt4oT4neJgWZ0d7Y5k9g9YnJBSpXtKO7EQTQ1gh?=
 =?us-ascii?Q?v5QFdrAhwKL6VyZxihJyxF5C60oR1NQfGg13Gl1GWv1+rJ2Aeh1Nmc8XniOD?=
 =?us-ascii?Q?jdrONNP7T0KCcDIC3vifnjCfOO88q4DDyGjipls373l6hW4iIDGguMbDJSzv?=
 =?us-ascii?Q?vL5VtV4ptFnSM+TMRLAYCZmIpcxkDQo8Ob2p05LETdGeMptzJwJfZCoCMRvv?=
 =?us-ascii?Q?5gqJMV9J3BCet47Yc8hSsSk/df8wXIOn7p29xL9UyqQbU6vzN4nNC0AVsQdg?=
 =?us-ascii?Q?XwsAOvb+iGSQ6AD+tdhPvxANxNuhGx1k3Ft4Gxso3qai6CGjRr2I+FTCv2nu?=
 =?us-ascii?Q?IP6VBV9zKbk1rDnmH2qt9xjOE43eTl6wGFjDIQl6YhCDVOisKeHQC/LFpJii?=
 =?us-ascii?Q?iTR+x02hsLFHLOS2VD+TK+FfN0oUaEvA8nziYBOSR+1NaeQDthuAnUM1nylC?=
 =?us-ascii?Q?m5vmt2OtNE/eLb3EPgf1BIFw9UIOX9CqWFkNYntA+p7guJaZi7IRdeK1SIXp?=
 =?us-ascii?Q?lFSK9AK2f636UTlV+gIkFo56CoGz6jQVmn2RKAa49rCKQ2gg2R/XDGx1mwfM?=
 =?us-ascii?Q?/NPc3gZZJ8QC2sIDtEHVzlEjFLEawM8plqJ6Hnie6wE2GekrSmQ/JIuP1wlA?=
 =?us-ascii?Q?LMZykhiogrtdxNTw2spQzUXJ5KZavVgY9rDGZ1V+K0Qyv0aChfmt6678vjYu?=
 =?us-ascii?Q?f0RAyJIzKszW1LBUF652u7NjSyYxNvH3UvNVHMQYXyraf2XnuT0A/bbMIcFh?=
 =?us-ascii?Q?aVjuSRQn/h7/tm0COvp1ij/oBKM1PnQweVm3/GS5EgKm/90VZd9vrl6tF0fs?=
 =?us-ascii?Q?Hb/Aco/FPZhzjcpmAzoc2xbtcrOWI9wqKQNIznhwrwr6TFkvb8Eo8iMKSbm3?=
 =?us-ascii?Q?VPexZlIhhZnIrFniMy6pfMrAj98rctFcRzFSbKNqrYvxlx+UCkPp3dm4y9Wt?=
 =?us-ascii?Q?m3VrkIOvdhNOBmEkufDvW7iZnK54GydN+zdA3P/uNQvlDhZspJdaMB/0kC+P?=
 =?us-ascii?Q?yvrBbyMiQB8l8Z352fKzNwV19Jzu7nYcFzCFf2ho7Xu0qdeVTWIaU2pLWJx1?=
 =?us-ascii?Q?AvhWq74NB7YyAAasbdB7+GYyNnV7GQHx7NFWjYhAhpqg+OLxyZG6Qb1ID8Xq?=
 =?us-ascii?Q?0S3KhcY8qLHxJDcr6qFSFMyrkSNU3s8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5817d856-b296-425b-1be1-08da11667b9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 09:28:28.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRIsnaxf99nwpwJ5QKvSdhNvLG30hzuNZ0SIqfE3YmasjMsEzRSMYrgfIc6+Qv7cBGY1vfI9o882PrUllxonVJr0ZDfGvVvFrMnQxXUrJuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203290055
X-Proofpoint-GUID: _iQkfpyF0Hdo1c3LdYt71e_WAX-TKnBc
X-Proofpoint-ORIG-GUID: _iQkfpyF0Hdo1c3LdYt71e_WAX-TKnBc
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/kspp-stringop-overflow
head:   d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a
commit: d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a [5/5] mm/pgtable: Fix Wstringop-overflow warnings in pgd_alloc()
config: i386-randconfig-m021-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291451.bKVdLfSv-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
arch/x86/mm/pgtable.c:442 pgd_alloc() error: uninitialized symbol 'pmds'.
arch/x86/mm/pgtable.c:445 pgd_alloc() error: uninitialized symbol 'u_pmds'.

Old smatch warnings:
arch/x86/mm/pgtable.c:281 pgd_mop_up_pmds() warn: we never enter this loop

vim +/pmds +442 arch/x86/mm/pgtable.c

1ec1fe73dfb711 Ingo Molnar         2008-03-19  434  
1db491f77b6ed0 Fenghua Yu          2015-01-15  435  	pgd = _pgd_alloc();
1ec1fe73dfb711 Ingo Molnar         2008-03-19  436  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  437  	if (pgd == NULL)
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  438  		goto out;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  439  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  440  	mm->pgd = pgd;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  441  
f59dbe9ca6707e Joerg Roedel        2018-07-18 @442  	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)

This can be either an array or a pointer depending on the .config

d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  443  		goto out_free_pgd;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  444  
f59dbe9ca6707e Joerg Roedel        2018-07-18 @445  	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  446  		goto out_free_pmds;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  447  
f59dbe9ca6707e Joerg Roedel        2018-07-18  448  	if (paravirt_pgd_alloc(mm) != 0)
f59dbe9ca6707e Joerg Roedel        2018-07-18  449  		goto out_free_user_pmds;
f59dbe9ca6707e Joerg Roedel        2018-07-18  450  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  451  	/*
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  452  	 * Make sure that pre-populating the pmds is atomic with
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  453  	 * respect to anything walking the pgd_list, so that they
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  454  	 * never see a partially populated pgd.
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  455  	 */
a79e53d85683c6 Andrea Arcangeli    2011-02-16  456  	spin_lock(&pgd_lock);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  457  
617d34d9e5d832 Jeremy Fitzhardinge 2010-09-21  458  	pgd_ctor(mm, pgd);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  459  	pgd_prepopulate_pmd(mm, pgd, pmds);
f59dbe9ca6707e Joerg Roedel        2018-07-18  460  	pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  461  
a79e53d85683c6 Andrea Arcangeli    2011-02-16  462  	spin_unlock(&pgd_lock);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  463  
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  464  	return pgd;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  465  
f59dbe9ca6707e Joerg Roedel        2018-07-18  466  out_free_user_pmds:
f59dbe9ca6707e Joerg Roedel        2018-07-18  467  	free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  468  out_free_pmds:
f59dbe9ca6707e Joerg Roedel        2018-07-18  469  	free_pmds(mm, pmds, PREALLOCATED_PMDS);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  470  out_free_pgd:
1db491f77b6ed0 Fenghua Yu          2015-01-15  471  	_pgd_free(pgd);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  472  out:
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  473  	return NULL;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  474  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

