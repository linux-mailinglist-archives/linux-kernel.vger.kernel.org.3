Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73514A97ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbiBDKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:37:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44034 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234577AbiBDKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:37:41 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214ASYh2028752;
        Fri, 4 Feb 2022 10:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Htu0CgXdH2vHirjnLMrZp7OMUyy8HOhGXHkuE8Wq19c=;
 b=Y5OWEGIR/yx5ZkyEqJnw3Oulqn222SQAUpOVh/Cgui+pp2PSaV7A8VfgZGZNl5dgaQLx
 Z1Q/dp0YMTfz1N4HAkdm1Rqj9PmgJ7y6+hQGlnmGoNw8pqKFrr1wj/L5/BM0euRcK9rD
 suW/U/N8h0AytUoalEPipkPb0LcBAhvHjGvScfbcAJZODa8UAbM8GridtFVOIQYStyHj
 cQWVjF1qztMMhuVaKLAGGGX05m2QRAIiQZZGH2l70Yp3B+mCxtorSl8luZDfZGIneQeX
 TO4NwBDkIEBByNGEl39qvDl4sxajclUCzUxdcS3X7BibALN+U8+7wim0Hwz7esR+lFD2 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hetad7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 10:37:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214AZpC0136286;
        Fri, 4 Feb 2022 10:37:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3dvumn98uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 10:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YorjR361fZbDf5RHFvOcUEKoveXvoVRe9WjHhQba+pfiCXD4oSCzMJNL+rV1Z8Q6mX25/1Qtui/haGelxN5W7GE7JQj+K2jUsCeRg2/ld9jFGawlgpX7G8GmUDI8jBeKfa5NuZbMvPRz8gPMFByJ7PByWd3TRrSlYc7gaCH7gwThwIsBGj94CPqHvdB1a+UB+qYdWT+tWdxGYZXY7Q0KLrjkIPhD9T+mwyJh3puTYrA6q8hWRS3J7ohqeCxKM/7UiJvssQS3kRX+00ZviFfn1A4guOnWpNRsmkHoShosPWNnbBS4UN9TfycZsPWa3l8ToK4pYS9sMVph13GXbgW/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htu0CgXdH2vHirjnLMrZp7OMUyy8HOhGXHkuE8Wq19c=;
 b=oQ9S7xiUmI04W930iZyW8vZa7SBhQaFFgLXxm60mILsHnqosZP2T/DDM1i49WdwwcOUSGbLtYCnul/mlmYGyIfDrKe8K2XmS6er/hKJ4lYcIJhOmrXI8pn/ToipOOCR8vQKTWcf/IdX0LcKN97Z6X5hde4+PwywcTTui8pMQ0ufu5OxQB+HWuP8mCOcByF3oa2PQH1Tz+bVwfgUDVkpffH0aBY4+o5aMhKbbYFNem5HFVEQJofL+ZXn2CURDC/7rrgRP9FAJDbMSYDuXfno9f+by4oqCMS4OEwCDmcPB3WdljLk9HGdiC9Sml0RDsbZilOzYgbkJD2CSjKy8riXOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htu0CgXdH2vHirjnLMrZp7OMUyy8HOhGXHkuE8Wq19c=;
 b=sNpiytYhca7l/FhK81ORZKvgYFGm0p2dsmiBPlXQrk9SR8oR0HN6/uU+3bPG/8irTt7Zeul1uq+NELPxcRValxeaYR75v4f8GobTuUlDuC/wmPzEY+evfYlcXNv5PFpdKmzEYnMwAG0OkFyRHUO1SCZQQj4bRylD8PSTOJw3/lY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5578.namprd10.prod.outlook.com
 (2603:10b6:510:f1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 4 Feb
 2022 10:37:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 10:37:22 +0000
Date:   Fri, 4 Feb 2022 13:37:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [kbuild] arch/powerpc/net/bpf_jit_comp.c:225 bpf_int_jit_compile()
 error: uninitialized symbol 'pass'.
Message-ID: <202202040124.7MMKaXXV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: NRTNSSHTCMVBAFEYGHLHVCHGLZEKA2EC
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ab7ed5-06be-48b0-e61f-08d9e7ca53ab
X-MS-TrafficTypeDiagnostic: PH0PR10MB5578:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB55783217A870DBD2D251CF7E8E299@PH0PR10MB5578.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgmWMAE32y+hedwspiMyijkgLv06sQabpqKq0Tku1J1aDF+EIhzBuj/ROSBmsbh2UbBjPMFCJo7SCdbQouxE9Etdn0cxw6jt4QbsCmgf3MJaIfzfiHOKGdXGJqCCskVrvj8xigsSF7Z4uQhgnfNFJHnKcqhxdjm2/ewMqo4xYOMxMJjjyUzJmJdY1J8IiIiRTvxPgHrmJrfzlUNQul1Bqi8mYzyJfTPI66ci62lpuUZHeZL7dQZXZxRh0T7mLt6SxwfC5dG99/pM2Aq07C+M+0wq8PfeV/oE6AnCzkvTsDd+DsC6noV+dOzte7QA5XCttjCjueApf6xENxoHnw9ASnlMxTh3PG5Txzm24Mcd8O8MybQUk2pU6ILK1FU4+hLzUL6sTHQouL+BZDE/b4sXV4Nyk1I+nsISp47ino8T+yLFJ6UyosJph+t5ERXapn9vcgcetvL4TFMvWbHeuJNZFJpGtEDq/90orkpVHRHsksXyYYXHTAnDksM0/J23NzRTNZTwEjgb+6HxbijvH7Do4WWmJviexK6XtX7LBMjyW9Ijn8/030YOQaLk5gYILEuL9jRG9g6V3D/Nzh+oiwhKa+AitedFWhsqJVmAq3O1xkt+QGZc3IpxRyi6Gh+Kk+TtcjxW1IGDO3U+U5vAi6MhNCRWe3mDRbyP89rWrJSHQcnKKDeexXCv5Pyg6XRo6wA/SygRcbA+cPpafKJ+9u9mX8MIHr/rqSEiIV10SmNMYrFjMrjw/zXF9gp16a6ScaTJlF7TeMK3RVD8R7OkElxIKDlJY/Cv/HgWjPsSav7wSRn6VlAHsqQ/hVvnmB/P1RgOHUwUrlCzRoU4FXTLXsmvfI8RqFUGXwsfWzHGgXW1f3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66946007)(4326008)(1076003)(26005)(186003)(86362001)(6916009)(966005)(6506007)(508600001)(2906002)(8936002)(44832011)(66476007)(6666004)(66556008)(316002)(8676002)(30864003)(52116002)(38350700002)(38100700002)(6486002)(36756003)(5660300002)(6512007)(9686003)(5716014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQeyEFuz0I0A2+Py38nQZLPJ7VGmfPN3L19appHPyFGvb4UkL0cpnBatP37m?=
 =?us-ascii?Q?yVSSUNZ6pq+OauLwk7imWg/KqquUc+igPcJvQlcPijxnMsVJx+7iBTwM3Eok?=
 =?us-ascii?Q?0zLBa6Z4hw/yjfBSYyGYBWTr4cVAepGTwhqW/3QjyEAcm4sxvc8PkkrgcZbh?=
 =?us-ascii?Q?ZzLpd6oYEhsfI+AnDWdTiyxfKJUuP9Q6xG7Nwji6nd9oU0Tpqep5H/bMZ8Tv?=
 =?us-ascii?Q?dL30MRR2imNwvmkkBbHbKxmLQVFzi9h6hTDnLXo+NhTZBGXxx7Tx55067y0N?=
 =?us-ascii?Q?jYnK/0kEGZR+2T6Wo3YUGHa+Oy67c1Kcv9ODzKIw3dYtrhoOR+2pOFDX4rh7?=
 =?us-ascii?Q?ai/BL+XFJ117xNdLili3XAOJTF19GmLUWFSVe6iT4/He6vxl/pjIo1VJJsL+?=
 =?us-ascii?Q?dbBC+YRqgO0NCdcyr6zzaMyp2VpTcMsm2xwvnL4fKYV8xtP+vPJC+xoCBMZw?=
 =?us-ascii?Q?Y45ikBifISzJzgQ6L2vS72xxfJKpDzQM4HpZYOd7pRf1Bhh1KjRR9DjEOpqP?=
 =?us-ascii?Q?iBoY5dr++h/O739OIzjqvX5LSQN+CZY8egX3PEcK9uNjchu+OXrniAiH10aS?=
 =?us-ascii?Q?K+tZ7eokVmRyEufnaLaoflnneXBh74F9kF2H2/iF0p4fbyntZGF6nJjm1bLs?=
 =?us-ascii?Q?YMA3O4eIhCMAfS/vtUwDiNWE+JxjkTOS7o1s+Z6pCRtUSW/KNWAm93o1+0Er?=
 =?us-ascii?Q?ojhWwEgMOcuVYsg2sF8xaeXke+yVjjr+pTXoj8gxgJA3lO1+aiXpIBikr59V?=
 =?us-ascii?Q?Je7wNTojSgCaW78vEdRkI1+7DMOC1EuprQkqqhzGMzjBI/VN6j0bijPgYWfY?=
 =?us-ascii?Q?nJm7t9Zq6r5hYDcgGtQDI99CApLzM3jqo+3AbvXHMMEePUgM8XbFHcxzdGtr?=
 =?us-ascii?Q?klP37ICoIM44KDBy+plCqdrvOEmYkhK0OYrLQUJIZNwiC9VIztuJ013YPg1d?=
 =?us-ascii?Q?AW/Ud7TI36UbNTPcstGBV7rWYAz1So9KOFb5NY+kog3mzK3eJ5q8Fig9v3uB?=
 =?us-ascii?Q?NhQqO+Wnw84eF0cmtyDdvPgbeycSM/ROANh2NouQqtf5NC8Pbz2+2wiB/LcE?=
 =?us-ascii?Q?Z9eCcu62tUDm0+AabL2jL0C4V8UXjY1p2iyNwASzGRoqpRx4EOJFglfdjnKp?=
 =?us-ascii?Q?VKdeuF38JMKrG2a9VERGF8JXEdH1EHgbtA7UdHfI0EFMe14e/+Z2tJXDhvQb?=
 =?us-ascii?Q?BnwDm/alnJb7EQRlNz1IXrwml3Iaw83MYkVTpRgV/HjrXsQgyg5JrwFGVH9N?=
 =?us-ascii?Q?/pmXvTWBSVL7AlpO0LBlyFe9+aM3y43Yxsk4V4eByMcI2D6Hdp/7L8miUT4v?=
 =?us-ascii?Q?jUGQf5eL58RAoNROIJ1X/5pE+rB152WG1isUD32eTRKPpN6/KdGJGArAbyiU?=
 =?us-ascii?Q?NboW8dDGJLNbiQnDlkxPJPjPbQKuqwIQ2aqIK4Ah/0kQboXlZpWMal8DLl8m?=
 =?us-ascii?Q?OE/afAmt0OG7cAx8kl/5E8D5QWduo+qVyWX747JheoEFMvgAEpSuZJvk5jDi?=
 =?us-ascii?Q?sAnDADFsEFx86ibvM+yeyQrD96vbXgs5e5qJvCnsHYy78lwy2kAdoBlXyw2w?=
 =?us-ascii?Q?L3u9ecLVlREXDFviJF8kxuaVaArMrBBW1buO2PKgdNMCPOvMKDW0SbhguP5r?=
 =?us-ascii?Q?pjumKnPyMASm0yYTAQQfNL9tSV7/QUJ9urpS4cLlNFMRENJiP0J9fzUCytCM?=
 =?us-ascii?Q?9qftbHUQ8svHUjNDUfyjhJQNhz4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ab7ed5-06be-48b0-e61f-08d9e7ca53ab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:37:22.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxSuta+HGaldqY46h02AmwYD1m72wCsyhExiO35R3TsblT/LQXy/lylt4LuKJ4IZ3g+wnNn4Bz8ux0crUcaici25jhMO4CX5vb1b/C8Q6iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040057
X-Proofpoint-ORIG-GUID: OlHq1FRquhkYXdWyZeV1kKdSyDXIYEaf
X-Proofpoint-GUID: OlHq1FRquhkYXdWyZeV1kKdSyDXIYEaf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   88808fbbead481aedb46640a5ace69c58287f56a
commit: 51c66ad849a703d9bbfd7704c941827aed0fd9fd powerpc/bpf: Implement extended BPF on PPC32
config: powerpc-randconfig-m031-20220130 (https://download.01.org/0day-ci/archive/20220204/202202040124.7MMKaXXV-lkp@intel.com/config )
compiler: powerpc-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/powerpc/net/bpf_jit_comp.c:225 bpf_int_jit_compile() error: uninitialized symbol 'pass'.

vim +/pass +225 arch/powerpc/net/bpf_jit_comp.c

4ea76e90a97d22 Christophe Leroy 2021-03-22   88  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
4ea76e90a97d22 Christophe Leroy 2021-03-22   89  {
4ea76e90a97d22 Christophe Leroy 2021-03-22   90  	u32 proglen;
4ea76e90a97d22 Christophe Leroy 2021-03-22   91  	u32 alloclen;
4ea76e90a97d22 Christophe Leroy 2021-03-22   92  	u8 *image = NULL;
4ea76e90a97d22 Christophe Leroy 2021-03-22   93  	u32 *code_base;
4ea76e90a97d22 Christophe Leroy 2021-03-22   94  	u32 *addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22   95  	struct powerpc64_jit_data *jit_data;
4ea76e90a97d22 Christophe Leroy 2021-03-22   96  	struct codegen_context cgctx;
4ea76e90a97d22 Christophe Leroy 2021-03-22   97  	int pass;
                                                        ^^^^^^^^

4ea76e90a97d22 Christophe Leroy 2021-03-22   98  	int flen;
4ea76e90a97d22 Christophe Leroy 2021-03-22   99  	struct bpf_binary_header *bpf_hdr;
4ea76e90a97d22 Christophe Leroy 2021-03-22  100  	struct bpf_prog *org_fp = fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  101  	struct bpf_prog *tmp_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  102  	bool bpf_blinded = false;
4ea76e90a97d22 Christophe Leroy 2021-03-22  103  	bool extra_pass = false;
4ea76e90a97d22 Christophe Leroy 2021-03-22  104  
4ea76e90a97d22 Christophe Leroy 2021-03-22  105  	if (!fp->jit_requested)
4ea76e90a97d22 Christophe Leroy 2021-03-22  106  		return org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  107  
4ea76e90a97d22 Christophe Leroy 2021-03-22  108  	tmp_fp = bpf_jit_blind_constants(org_fp);
4ea76e90a97d22 Christophe Leroy 2021-03-22  109  	if (IS_ERR(tmp_fp))
4ea76e90a97d22 Christophe Leroy 2021-03-22  110  		return org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  111  
4ea76e90a97d22 Christophe Leroy 2021-03-22  112  	if (tmp_fp != org_fp) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  113  		bpf_blinded = true;
4ea76e90a97d22 Christophe Leroy 2021-03-22  114  		fp = tmp_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  115  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  116  
4ea76e90a97d22 Christophe Leroy 2021-03-22  117  	jit_data = fp->aux->jit_data;
4ea76e90a97d22 Christophe Leroy 2021-03-22  118  	if (!jit_data) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  119  		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
4ea76e90a97d22 Christophe Leroy 2021-03-22  120  		if (!jit_data) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  121  			fp = org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  122  			goto out;
4ea76e90a97d22 Christophe Leroy 2021-03-22  123  		}
4ea76e90a97d22 Christophe Leroy 2021-03-22  124  		fp->aux->jit_data = jit_data;
4ea76e90a97d22 Christophe Leroy 2021-03-22  125  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  126  
4ea76e90a97d22 Christophe Leroy 2021-03-22  127  	flen = fp->len;
4ea76e90a97d22 Christophe Leroy 2021-03-22  128  	addrs = jit_data->addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  129  	if (addrs) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  130  		cgctx = jit_data->ctx;
4ea76e90a97d22 Christophe Leroy 2021-03-22  131  		image = jit_data->image;
4ea76e90a97d22 Christophe Leroy 2021-03-22  132  		bpf_hdr = jit_data->header;
4ea76e90a97d22 Christophe Leroy 2021-03-22  133  		proglen = jit_data->proglen;
4ea76e90a97d22 Christophe Leroy 2021-03-22  134  		alloclen = proglen + FUNCTION_DESCR_SIZE;
4ea76e90a97d22 Christophe Leroy 2021-03-22  135  		extra_pass = true;
4ea76e90a97d22 Christophe Leroy 2021-03-22  136  		goto skip_init_ctx;

Assume we hit this goto

4ea76e90a97d22 Christophe Leroy 2021-03-22  137  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  138  
4ea76e90a97d22 Christophe Leroy 2021-03-22  139  	addrs = kcalloc(flen + 1, sizeof(*addrs), GFP_KERNEL);
4ea76e90a97d22 Christophe Leroy 2021-03-22  140  	if (addrs == NULL) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  141  		fp = org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  142  		goto out_addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  143  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  144  
4ea76e90a97d22 Christophe Leroy 2021-03-22  145  	memset(&cgctx, 0, sizeof(struct codegen_context));
4ea76e90a97d22 Christophe Leroy 2021-03-22  146  
4ea76e90a97d22 Christophe Leroy 2021-03-22  147  	/* Make sure that the stack is quadword aligned. */
4ea76e90a97d22 Christophe Leroy 2021-03-22  148  	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
4ea76e90a97d22 Christophe Leroy 2021-03-22  149  
4ea76e90a97d22 Christophe Leroy 2021-03-22  150  	/* Scouting faux-generate pass 0 */
4ea76e90a97d22 Christophe Leroy 2021-03-22  151  	if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  152  		/* We hit something illegal or unsupported. */
4ea76e90a97d22 Christophe Leroy 2021-03-22  153  		fp = org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  154  		goto out_addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  155  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  156  
4ea76e90a97d22 Christophe Leroy 2021-03-22  157  	/*
4ea76e90a97d22 Christophe Leroy 2021-03-22  158  	 * If we have seen a tail call, we need a second pass.
4ea76e90a97d22 Christophe Leroy 2021-03-22  159  	 * This is because bpf_jit_emit_common_epilogue() is called
4ea76e90a97d22 Christophe Leroy 2021-03-22  160  	 * from bpf_jit_emit_tail_call() with a not yet stable ctx->seen.
4ea76e90a97d22 Christophe Leroy 2021-03-22  161  	 */
4ea76e90a97d22 Christophe Leroy 2021-03-22  162  	if (cgctx.seen & SEEN_TAILCALL) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  163  		cgctx.idx = 0;
4ea76e90a97d22 Christophe Leroy 2021-03-22  164  		if (bpf_jit_build_body(fp, 0, &cgctx, addrs, false)) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  165  			fp = org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  166  			goto out_addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  167  		}
4ea76e90a97d22 Christophe Leroy 2021-03-22  168  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  169  
4ea76e90a97d22 Christophe Leroy 2021-03-22  170  	/*
4ea76e90a97d22 Christophe Leroy 2021-03-22  171  	 * Pretend to build prologue, given the features we've seen.  This will
4ea76e90a97d22 Christophe Leroy 2021-03-22  172  	 * update ctgtx.idx as it pretends to output instructions, then we can
4ea76e90a97d22 Christophe Leroy 2021-03-22  173  	 * calculate total size from idx.
4ea76e90a97d22 Christophe Leroy 2021-03-22  174  	 */
4ea76e90a97d22 Christophe Leroy 2021-03-22  175  	bpf_jit_build_prologue(0, &cgctx);
4ea76e90a97d22 Christophe Leroy 2021-03-22  176  	bpf_jit_build_epilogue(0, &cgctx);
4ea76e90a97d22 Christophe Leroy 2021-03-22  177  
4ea76e90a97d22 Christophe Leroy 2021-03-22  178  	proglen = cgctx.idx * 4;
4ea76e90a97d22 Christophe Leroy 2021-03-22  179  	alloclen = proglen + FUNCTION_DESCR_SIZE;
4ea76e90a97d22 Christophe Leroy 2021-03-22  180  
4ea76e90a97d22 Christophe Leroy 2021-03-22  181  	bpf_hdr = bpf_jit_binary_alloc(alloclen, &image, 4, bpf_jit_fill_ill_insns);
4ea76e90a97d22 Christophe Leroy 2021-03-22  182  	if (!bpf_hdr) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  183  		fp = org_fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  184  		goto out_addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  185  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  186  
4ea76e90a97d22 Christophe Leroy 2021-03-22  187  skip_init_ctx:
4ea76e90a97d22 Christophe Leroy 2021-03-22  188  	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
4ea76e90a97d22 Christophe Leroy 2021-03-22  189  
4ea76e90a97d22 Christophe Leroy 2021-03-22  190  	if (extra_pass) {
4ea76e90a97d22 Christophe Leroy 2021-03-22  191  		/*
4ea76e90a97d22 Christophe Leroy 2021-03-22  192  		 * Do not touch the prologue and epilogue as they will remain
4ea76e90a97d22 Christophe Leroy 2021-03-22  193  		 * unchanged. Only fix the branch target address for subprog
4ea76e90a97d22 Christophe Leroy 2021-03-22  194  		 * calls in the body.
4ea76e90a97d22 Christophe Leroy 2021-03-22  195  		 *
4ea76e90a97d22 Christophe Leroy 2021-03-22  196  		 * This does not change the offsets and lengths of the subprog
4ea76e90a97d22 Christophe Leroy 2021-03-22  197  		 * call instruction sequences and hence, the size of the JITed
4ea76e90a97d22 Christophe Leroy 2021-03-22  198  		 * image as well.
4ea76e90a97d22 Christophe Leroy 2021-03-22  199  		 */
4ea76e90a97d22 Christophe Leroy 2021-03-22  200  		bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
4ea76e90a97d22 Christophe Leroy 2021-03-22  201  
4ea76e90a97d22 Christophe Leroy 2021-03-22  202  		/* There is no need to perform the usual passes. */
4ea76e90a97d22 Christophe Leroy 2021-03-22  203  		goto skip_codegen_passes;

Goto before pass is inintialized

4ea76e90a97d22 Christophe Leroy 2021-03-22  204  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  205  
4ea76e90a97d22 Christophe Leroy 2021-03-22  206  	/* Code generation passes 1-2 */
4ea76e90a97d22 Christophe Leroy 2021-03-22  207  	for (pass = 1; pass < 3; pass++) {
                                                             ^^^^^^^^
Here

4ea76e90a97d22 Christophe Leroy 2021-03-22  208  		/* Now build the prologue, body code & epilogue for real. */
4ea76e90a97d22 Christophe Leroy 2021-03-22  209  		cgctx.idx = 0;
4ea76e90a97d22 Christophe Leroy 2021-03-22  210  		bpf_jit_build_prologue(code_base, &cgctx);
4ea76e90a97d22 Christophe Leroy 2021-03-22  211  		bpf_jit_build_body(fp, code_base, &cgctx, addrs, extra_pass);
4ea76e90a97d22 Christophe Leroy 2021-03-22  212  		bpf_jit_build_epilogue(code_base, &cgctx);
4ea76e90a97d22 Christophe Leroy 2021-03-22  213  
4ea76e90a97d22 Christophe Leroy 2021-03-22  214  		if (bpf_jit_enable > 1)
4ea76e90a97d22 Christophe Leroy 2021-03-22  215  			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
4ea76e90a97d22 Christophe Leroy 2021-03-22  216  				proglen - (cgctx.idx * 4), cgctx.seen);
4ea76e90a97d22 Christophe Leroy 2021-03-22  217  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  218  
4ea76e90a97d22 Christophe Leroy 2021-03-22  219  skip_codegen_passes:
4ea76e90a97d22 Christophe Leroy 2021-03-22  220  	if (bpf_jit_enable > 1)
4ea76e90a97d22 Christophe Leroy 2021-03-22  221  		/*
4ea76e90a97d22 Christophe Leroy 2021-03-22  222  		 * Note that we output the base address of the code_base
4ea76e90a97d22 Christophe Leroy 2021-03-22  223  		 * rather than image, since opcodes are in code_base.
4ea76e90a97d22 Christophe Leroy 2021-03-22  224  		 */
4ea76e90a97d22 Christophe Leroy 2021-03-22 @225  		bpf_jit_dump(flen, proglen, pass, code_base);
                                                                                            ^^^^
Uninitialized.

4ea76e90a97d22 Christophe Leroy 2021-03-22  226  


---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

