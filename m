Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD754BB511
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiBRJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiBRJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:10:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0B2B2E3F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:10:07 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21I7pX4n020934;
        Fri, 18 Feb 2022 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=hIY1+gX7kwjTIXcUZ7pMtenJG+0pIUXO7095R7qDFpE=;
 b=sHu1L/95RVyOUdMO1d5l8DUwPXdZP0BV4Ov8f/Suv+E7yuk14nT+QJoZ9LwEOfP9E3FV
 +Zq0sB2NH5Kn2oYSExKqcVXigQN6egMuzRIq6YmOhYahuwPwDYuQ7EESiwCbWsBBoKWT
 mTqrdf6o6GnnyV7ShmH6cx/Haqh71rC7pTqBW0Wo67s+WSUGKFWuZcSL2OuucYiP17Ld
 v02vVEOXRcABDMT6nENJHJhiF1oF4NGfhgEqqlkSeOPwmKnr75maKlKPyIigMpgy41qK
 +M/kCwD5bicqKag2hRxIbKN1YzxhFbKDanZH9CXS7XnsocsN5ztm25OQDM90VjLNEl7D mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr98xtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 09:10:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I90HRX187002;
        Fri, 18 Feb 2022 09:09:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3e8nvuxsj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 09:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZGlS9XZJvFDmlSLevjX5NdOIzezI9yghL96eRtC0NxZF6WppdJjzddz1Fjw2S5wT27cVqcniAkdQhpMG+s1zlqi03rh5PNOCauLNwb91gp220VdPCtg/M++3baEN/pCjjydrghBgXLnTM2QXrerOY4ioE6BJF7KWq7ooI87TRCSXlxk5U3bWYnWh2wBnr5OqWw+wRzHzLke3/iy3hR1QPKNLU+3X7NBjgtfT7n8Us2rHeHAQ9JaBO2uhyqndAUja92Otc18PiFjuBcsTG4l4uOHOOobFzImNwDOYBk2X3Tn3u0WzsjZzViVe2FHEW401DwzfuV3l255PGpveq3NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlHq6KPliqtp2Xw61kF3SaW429E1AaxUlveoAQY7SJg=;
 b=f4lrgixMFWyG068k6DH0KV5XwvpiyoZUgiaLmIzTpLnLxyGy832TxZ+/w5ZzvwhylOnlf9kNT9GMBDptvmGcoXmKtI2ymAyf/AdPGhoHCLI5kCwnNwdlGg1Z2dojiJWfRHPMw6BgATfrAwmKfK2SQUt57/Kjd90IahFkZb2mEDuXLAQxIRhzoB9bxK3P7R9HzTrzuUrnp4iI4sWVVVeCeOi3NizOVjnc/TFfCMV78W1j6lkoBVKWXPJxxKvzW1LZG8yjkHC/yXp/6axqaEG2EU+eeBMkqzIUyyB0s7aAT0Mtd4Be+TrdKaRZbgEQZhm4sokn0V+3D1v26Bm8LbQIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlHq6KPliqtp2Xw61kF3SaW429E1AaxUlveoAQY7SJg=;
 b=wzPJO3W6oJP1OQWWo1r6kyUMzbWHAt4Q34cXnpQJIWdj2tAF8UsKAhDnUr2tHqt57Mm06QtpEjYYTHmtHBPxbkZ4IhsykWBvfeTmyJlMlPAmH9e1jtgEfb6HooCo79CbaCD86CBiemB9okIRBw8UtTyATfIY53TRz+qEZlEj4Ok=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2076.namprd10.prod.outlook.com
 (2603:10b6:4:2c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 18 Feb
 2022 09:09:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 09:09:56 +0000
Date:   Fri, 18 Feb 2022 12:09:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/irqchip/irq-nvic.c:131 nvic_of_init() warn: 'nvic_base' not
 released on lines: 97.
Message-ID: <202202172219.xHulCgzu-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fbbdf5-e423-4df3-dc7b-08d9f2be6e55
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2076:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2076CCC545405B3D9A3F300D8E379@DM5PR1001MB2076.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71Fse1g6I0u8rSTVon6HcerjIjvqt7vv2kWb46I5QQhVt/7rXXM4OhPydA/pq45kBmFRvYnyJbcW8WtOEz5AUXzu2oLayeyq21s+w9cp0t8xDZ0REqN1C15hs1E+hv8rGZh6BVKUj92PfXwML3oYavUqBcL5vNgY2e2gqTcd1mrFgLcTT9mZd/ZdjZgIgPl6wz1rMFKFCnMPh34p/ExxbyZ8p9ivNcHrGBMbsX46tO5dD7Zy7vu3TbXt2AuH5Z9b0DemercJzzoHre1EELbAXgQIO3J44bIzQzo9rBaH/as+PssAKuXyYORy4kfJLE0f+Ff4eI6zXriBnUDs9ULxyyUJI+jrdO+JTwsM3Kkv4QKttC9ZkoVXEax0HDMapcb82HL474pmd8FjTDSZj+y+Q68InhmlfQ0Cbriloeh7lW5F6yYRHrgVoPhGyO8WTcoH4aY4RNAwYlen4Ooyu85FCd9D17n/NReLbd5fgCHjsWisXRe1IeFOr1TAAjFSFe1jz5wfi6qdtdJClkIiCkGrLS52fyVN5BKMYHHYlD54o+jztYbEqxAvFeL8mP50vciWH5UtPnaktp5yRg1C3kOfWgls58Ie5ZwKSrzwrtc1XSRkdZj3d0AU2wJ1IwJZe4gc+7RhaImHEUGGP3RLRPtzDkBO8qtlR5ENJETyxuAhu0xplnc9umvjKL011QKRqwrBBYtdA+Sv6R6bkz6VXPOfSk7Haj2zZio0QJfPxGzE+Rp8c3m8LdNv8Ue04EtXiZ5HR7C9TQpFDTc82DbsU8weVN9GYBm6eesyMsruqSJCt2yMebHaB/ZBjND601p6Ox+Cuz+ppW8kIV+tBVkzVxXhPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(1076003)(38350700002)(9686003)(6506007)(6916009)(54906003)(6486002)(86362001)(4326008)(6512007)(6666004)(316002)(8676002)(186003)(508600001)(966005)(5660300002)(44832011)(26005)(38100700002)(2906002)(66556008)(66946007)(8936002)(66574015)(66476007)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5+FLqM7R7NUhFgzEBsO3Y7/PoTqNBnavHCb0AaT34hfxtCYt8Yvm9t5b8I?=
 =?iso-8859-1?Q?M9wZUgSjgfmiVO8jvKOUr7YpMaZ6AAui61HJxbmO3rezBuvZs2m/j/v7fR?=
 =?iso-8859-1?Q?FVTS7ytAiteHIzdnXgQEVj1RViqUUqw5sZJNM+lo8jv+7avsCf4yjMAUSg?=
 =?iso-8859-1?Q?qVjfAw9Co28V+VXB4rU5wTm2/p6NRk2miX7P3t67rPW9vUilVT27nHxZ1Q?=
 =?iso-8859-1?Q?0yPVd0Cpp7IlBzIzb3EmoSletIJNtXaolatiE2gdl7alRu5KOBBdgmK8LH?=
 =?iso-8859-1?Q?xX960BkOMvTbcNB9GPUofSEqrnXpIgrl4SwRsM1oJ+eIt1S8XHQebntsUL?=
 =?iso-8859-1?Q?kIUVaqefV6is1v9A03MYKvPs07/93MRDgr/qPPau/QkHz7QD1Z5yKFshvO?=
 =?iso-8859-1?Q?yFWGjdr+MdGzLhvRnsJtfRB3gvo7rHMjieR1SxcEaGI+3s/1a589RlWUti?=
 =?iso-8859-1?Q?l1GOH1ApLHVe+7iHweA/Vjjd5tN/NMPpsK+UtM7eiHwlP+P9fM/yQfWIKy?=
 =?iso-8859-1?Q?XELMVlhOGd/HZs+0nihSDYKqOZnmdTw/QMkjjl55S+1d5kKA/TqllY3Dd6?=
 =?iso-8859-1?Q?sJTEOacljWj5It2STgdjeHR1xE5DM3R+5rxpaaBJHrmxYBTO+Wutldh/nI?=
 =?iso-8859-1?Q?lUo78L6ukrZtzWuaKssw3z3n3eVBDidhqIOdcnwDhqxhEnn+q7g4wZH82+?=
 =?iso-8859-1?Q?FdSpmAEdANSD1PKw/MInmicmRrcHd1KYxfTg6pc/68m0edydNZjYRehyJ8?=
 =?iso-8859-1?Q?a3zbwx42YrnUd4GlTAubyqR/zWNMv7u+Khm7uQRgpjpMLgCWJ+aXeew/s0?=
 =?iso-8859-1?Q?YGWssmVf/LweJudInIO4b/GbKCsRRg3pQQB5T9mNqWC5+rmzYCS5YGcHeC?=
 =?iso-8859-1?Q?6LjkAJac/njxVGrKElAwWvpfZ9WLt9UyjzxQ8AWD1EB/3RRlSZ6TgQuSLq?=
 =?iso-8859-1?Q?9h97VgIDIuj1mvfOnTb8h+aTD2zz+ZwF1cvx2MfHw8E3a4QhSm5/s/bqGE?=
 =?iso-8859-1?Q?oFMMjsxwVNb4xUIQht2/xKmQGUY8JrgcdgygHjGuTe9tIhKEw2aURiDZeh?=
 =?iso-8859-1?Q?aBC+hV8Vc563BAsqoNG0WSnz7SAQsmJjW2cl+LtBM8Ndm8SB/+eQJVLL0+?=
 =?iso-8859-1?Q?0xyLU17ZHLyz0NWPqdeRjwbYHqThdTwb43VaHLGm7bJk6tYnVp3yrD1qyF?=
 =?iso-8859-1?Q?5qFUjQu57FEQ+i/Wgu1E3sLWbCyslvforE+XhPoZSaLGyagiDJWDJuenpf?=
 =?iso-8859-1?Q?6r13ypYPsp0EQ5m9g2KrnnEA60/7i/QIvoW8C8p7eqk8hvRYCSjakygI2g?=
 =?iso-8859-1?Q?G1538qV/BdPS/Djtzrp4yXs1gLcwJesQ4VmmxhGWjI3mVFIoYycT3OzmHg?=
 =?iso-8859-1?Q?oQj6K7hLEAmHfxd2jUJmigaNls4OnnOMYLTIxwh100709wgoJj+6WFGlqN?=
 =?iso-8859-1?Q?aJpGBvwUVQ4gBf1yIoorg64x2PV0+w3mDffbY986pXNJs7EZ/3XZ/v8k3l?=
 =?iso-8859-1?Q?3e09nFKecrLOWgElk4U4GpyXwY+ihf3jN4ickwnzWYO6gsL3yf1DEQYqMs?=
 =?iso-8859-1?Q?h313uCw/Xw9c2zQg/ibAf1VoAhTfrKDG0nABNft7XCdF2r2flMne0Qenhw?=
 =?iso-8859-1?Q?NeTCUTmAP7T/5HLXeUw+rdkKlvLooF9vI29kjN27p6Y4AiaQz2RDxCn0RI?=
 =?iso-8859-1?Q?lS2WRK1KnjF3Eu6bCXHvGdb3e4pDvka1+/7fwSmJjwSVU+VK1cl5nHW1iT?=
 =?iso-8859-1?Q?UaMA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fbbdf5-e423-4df3-dc7b-08d9f2be6e55
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 09:09:56.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otxL6kFGG792VBZv0KP/qd2S9VhSMm4kQkAyuST3zYg8cE5cmLhhqCYO+P6qTLhwzk21tWlFSt1yBW4RwziY2YuMpCIx6cWHDOfC9rkXpvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2076
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180058
X-Proofpoint-GUID: GokBJ3vESj-bIXlaJkBxjeOG18JxpWPo
X-Proofpoint-ORIG-GUID: GokBJ3vESj-bIXlaJkBxjeOG18JxpWPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
config: arm-randconfig-m031-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172219.xHulCgzu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/irqchip/irq-nvic.c:131 nvic_of_init() warn: 'nvic_base' not released on lines: 97.

vim +/nvic_base +131 drivers/irqchip/irq-nvic.c

292ec080491d87 Uwe Kleine-König 2013-06-26   72  static int __init nvic_of_init(struct device_node *node,
292ec080491d87 Uwe Kleine-König 2013-06-26   73  			       struct device_node *parent)
292ec080491d87 Uwe Kleine-König 2013-06-26   74  {
292ec080491d87 Uwe Kleine-König 2013-06-26   75  	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
292ec080491d87 Uwe Kleine-König 2013-06-26   76  	unsigned int irqs, i, ret, numbanks;
292ec080491d87 Uwe Kleine-König 2013-06-26   77  	void __iomem *nvic_base;
292ec080491d87 Uwe Kleine-König 2013-06-26   78  
292ec080491d87 Uwe Kleine-König 2013-06-26   79  	numbanks = (readl_relaxed(V7M_SCS_ICTR) &
292ec080491d87 Uwe Kleine-König 2013-06-26   80  		    V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
292ec080491d87 Uwe Kleine-König 2013-06-26   81  
292ec080491d87 Uwe Kleine-König 2013-06-26   82  	nvic_base = of_iomap(node, 0);
292ec080491d87 Uwe Kleine-König 2013-06-26   83  	if (!nvic_base) {
292ec080491d87 Uwe Kleine-König 2013-06-26   84  		pr_warn("unable to map nvic registers\n");
292ec080491d87 Uwe Kleine-König 2013-06-26   85  		return -ENOMEM;
292ec080491d87 Uwe Kleine-König 2013-06-26   86  	}
292ec080491d87 Uwe Kleine-König 2013-06-26   87  
292ec080491d87 Uwe Kleine-König 2013-06-26   88  	irqs = numbanks * 32;
292ec080491d87 Uwe Kleine-König 2013-06-26   89  	if (irqs > NVIC_MAX_IRQ)
292ec080491d87 Uwe Kleine-König 2013-06-26   90  		irqs = NVIC_MAX_IRQ;
292ec080491d87 Uwe Kleine-König 2013-06-26   91  
292ec080491d87 Uwe Kleine-König 2013-06-26   92  	nvic_irq_domain =
2d9f59f7bf8ef5 Stefan Agner     2015-05-16   93  		irq_domain_add_linear(node, irqs, &nvic_irq_domain_ops, NULL);
2d9f59f7bf8ef5 Stefan Agner     2015-05-16   94  
292ec080491d87 Uwe Kleine-König 2013-06-26   95  	if (!nvic_irq_domain) {
292ec080491d87 Uwe Kleine-König 2013-06-26   96  		pr_warn("Failed to allocate irq domain\n");
292ec080491d87 Uwe Kleine-König 2013-06-26   97  		return -ENOMEM;

of_iounmap(nvic_base);

292ec080491d87 Uwe Kleine-König 2013-06-26   98  	}
292ec080491d87 Uwe Kleine-König 2013-06-26   99  
5b8aae489a07ac Axel Lin         2013-07-05  100  	ret = irq_alloc_domain_generic_chips(nvic_irq_domain, 32, 1,
292ec080491d87 Uwe Kleine-König 2013-06-26  101  					     "nvic_irq", handle_fasteoi_irq,
292ec080491d87 Uwe Kleine-König 2013-06-26  102  					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
292ec080491d87 Uwe Kleine-König 2013-06-26  103  	if (ret) {
292ec080491d87 Uwe Kleine-König 2013-06-26  104  		pr_warn("Failed to allocate irq chips\n");
292ec080491d87 Uwe Kleine-König 2013-06-26  105  		irq_domain_remove(nvic_irq_domain);
292ec080491d87 Uwe Kleine-König 2013-06-26  106  		return ret;
292ec080491d87 Uwe Kleine-König 2013-06-26  107  	}
292ec080491d87 Uwe Kleine-König 2013-06-26  108  
292ec080491d87 Uwe Kleine-König 2013-06-26  109  	for (i = 0; i < numbanks; ++i) {
292ec080491d87 Uwe Kleine-König 2013-06-26  110  		struct irq_chip_generic *gc;
292ec080491d87 Uwe Kleine-König 2013-06-26  111  
292ec080491d87 Uwe Kleine-König 2013-06-26  112  		gc = irq_get_domain_generic_chip(nvic_irq_domain, 32 * i);
292ec080491d87 Uwe Kleine-König 2013-06-26  113  		gc->reg_base = nvic_base + 4 * i;
292ec080491d87 Uwe Kleine-König 2013-06-26  114  		gc->chip_types[0].regs.enable = NVIC_ISER;
292ec080491d87 Uwe Kleine-König 2013-06-26  115  		gc->chip_types[0].regs.disable = NVIC_ICER;
292ec080491d87 Uwe Kleine-König 2013-06-26  116  		gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
292ec080491d87 Uwe Kleine-König 2013-06-26  117  		gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
8b53ec260e601d Daniel Thompson  2014-06-04  118  		/* This is a no-op as end of interrupt is signaled by the
8b53ec260e601d Daniel Thompson  2014-06-04  119  		 * exception return sequence.
8b53ec260e601d Daniel Thompson  2014-06-04  120  		 */
8b53ec260e601d Daniel Thompson  2014-06-04  121  		gc->chip_types[0].chip.irq_eoi = irq_gc_noop;
292ec080491d87 Uwe Kleine-König 2013-06-26  122  
292ec080491d87 Uwe Kleine-König 2013-06-26  123  		/* disable interrupts */
292ec080491d87 Uwe Kleine-König 2013-06-26  124  		writel_relaxed(~0, gc->reg_base + NVIC_ICER);
292ec080491d87 Uwe Kleine-König 2013-06-26  125  	}
292ec080491d87 Uwe Kleine-König 2013-06-26  126  
292ec080491d87 Uwe Kleine-König 2013-06-26  127  	/* Set priority on all interrupts */
292ec080491d87 Uwe Kleine-König 2013-06-26  128  	for (i = 0; i < irqs; i += 4)
292ec080491d87 Uwe Kleine-König 2013-06-26  129  		writel_relaxed(0, nvic_base + NVIC_IPR + i);
292ec080491d87 Uwe Kleine-König 2013-06-26  130  
292ec080491d87 Uwe Kleine-König 2013-06-26 @131  	return 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

