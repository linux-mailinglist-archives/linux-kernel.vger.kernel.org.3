Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA856464B18
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbhLAKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:02:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38646 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232736AbhLAKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:02:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1960MT015131;
        Wed, 1 Dec 2021 09:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=yIsevU+oS1i0VH+Gt0NRuUKAHNlKO58ygyj28YNLpN8=;
 b=DH6tDiW+tvPBqxho0w0Q0EUHR7nfyv4pN+eAD6P3aYTHhmU/m0+l1BKmtmjfRs0fr6Z4
 BZws0hEiRS4nXYmJ+NtJAolrt9+BHgE0mkG7rt2Gf9KdPDMmAu7izEdHjpK+yx0qEpee
 IqaoYor96evaCWLO5NWBFK+dZpvcoXv17BJpU4RIIxER3vBS3l/3Aw6BmNyyAv06s52H
 PoI5eb6enb4bcbUewSdbzp1g+o5uSzsC6AAlOblhMs8CVkBKCaHDbqBbpTVqBS3xSgtn
 nkWkO+vt5MRqf4tLfDMBsEn5hgNnkbzX8w0Wri9CsRI6etQLdMLRgOelHgrSYuv6hFqV /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8cf8wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 09:58:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B19wWOH066296;
        Wed, 1 Dec 2021 09:58:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 3cke4rgmy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 09:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7URaDFCdTBx7N/+BpvvFsfhf1VwmYj3xw0e5uG5/HIpDmf9qkwLGLWwKnbPTcl1OULrDmDDCygFnIAv4QdKQABhnf75Xp9qeUU8CmY0Jn8JGkE4465eq0BMdfFkqSpiLM2ElTr2Ns5sWWavZ0LbwL2aJaL8+tSAiCqoHVYCl/fGDHyX9BLwqVObSkfjJ5XRTzJz3DGwrAy2jveO8+3pxNW6am9Q8tX/khGRZ9NHcsZTsftf+mk4TVjLJnSVlfHxzR+jNzxK2yDJU1cv2VUdWVPZy5YLSA3rXdbUVRQPpHFFPtG5iuosgDMT5Etqay98WRRWuL2zTNADla/gw5KfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIsevU+oS1i0VH+Gt0NRuUKAHNlKO58ygyj28YNLpN8=;
 b=fkBgOPO1QSLf89SULmRDpzXjc6dWtUnaV6LRlw0BmtiXuSvX/YM1A1157AvvQ0XL+Lf1tVp5lPpG0GuGyqYEUIeBfPOsSbX4BunB3tmtb37kHQVZDvdxfo/GouksAMVusIbEbkV4BC8NUY4IzpiRy8zpkL9Y8PHt+I75SdHUgJuSDgy2lWxXrNT3FcrdH5T+AT+ad7qWhaEu3Xjjukb8aDlDo2Qtn1OgZpC1lDXNdWFfl4DWM3DxJxKILyeGTxe33kyxA/z2LV15nyFr6jO7ZHjZxhpKyv9F5JqR5udNt5/xpTXdz5rGsr6esmrSFSusaGtjHZh8ke32u++n9YY8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIsevU+oS1i0VH+Gt0NRuUKAHNlKO58ygyj28YNLpN8=;
 b=X5wnQDpowfNl+xzBJe0jufbRbFnxkugdDh7UmEy+KQR9dPRAkQPgX5+wd3imMUzGNoLPYqZi+ljFDwojkdKgUTTdvcz4l/UwtYJEDI/MLJ52iNtlT3ou6A5tm6xUzV460Trj6gQlC9Tl3/UwkgIWcNiFNSqLMexbzywCFfUZbns=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1773.namprd10.prod.outlook.com
 (2603:10b6:301:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 09:58:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 09:58:49 +0000
Date:   Wed, 1 Dec 2021 12:58:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Alexei Starovoitov <ast@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] [ast-bpf:relo_core 14/23] kernel/bpf/btf.c:6646
 bpf_core_find_cands() error: uninitialized symbol 'main_btf'.
Message-ID: <202112011647.lhISTWxn-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 7SMMVPJYNODGGCS4R5HLZV7Z2HPJABJC
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 09:58:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad82169b-4028-46d0-aad0-08d9b4b12c62
X-MS-TrafficTypeDiagnostic: MWHPR10MB1773:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1773917F4629E4EC632C0FD78E689@MWHPR10MB1773.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2leYq3t3wNgSo/lGzZFJqtbQg0YLpgbZLIwpzOrUQr54vJYKywyMjaXvSK3Xx3jPUlYEDenZyLCsrs8ITZE49DiSc7wsw3jpLkrR13KfJGaFelTrdf4xKAdq+62ZRJEtrjqXKEIg/ciIMBKJZtcIHf/FpFnjhV0XxKZu42BlBM3TXRQynBB01bkStGzlODTly5ph+iqBffXXSeJQszkvokU739A8qXNZbUgkd+1mDW0kUJdC4qlN2RCy0DiFBbCkdaSWye2Y3rnxkh9DzsGC3e3NK0YMP601r70Lv00hyX75ftENVSuxQSffiX3IBalNuoOmc0LudkfEN/0RcY/IVfryD5RXRUFPJfiZSayMfAMQl77dLQ/ogEkQpnhcNz/uhD60Xvr6oigtG9xD3bK5dZYNuPI0I+IPDdiC9hX3Uip1gKX2eu6Jx/cQS9tlQFyJWnCX4kWnsuYNYYnDu4TxBe8cSop/BcDHdaIYZnHY/e5DQm3yR1lZRs7vZgygBaUCCNeST78ilYw2IPzSvr5ogz+neGchOWfZSweejMTqp91CnFdU5pwwrvwRJYFiJduX2CCpQ2uZXyX40lBYRHvU46k3jLVjUYGCKho/cdr/0stCLTx9jWa7GQ2GKx9IpQxRPYB7xEtgXvBYDHtArDu8W/qD/nRYe+J8mUBgDhe48HzBIaGiRZEEh1ye7G1GVBvckRVRH9AF3BhoDbcoWJCbijpjNyt2qKe8yOOzKCoRv2U85hRhlicdfeC3cD8q84IiCriV+quKo0A8+81NXEebWP1iHR8XpO/WnXfSxhtwXrHH0Z7kaxtpaXbLVeEtvsfb22NzraGTcLmur5zFlOVtkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(44832011)(956004)(66946007)(66556008)(6916009)(6666004)(186003)(508600001)(966005)(86362001)(4326008)(83380400001)(66476007)(52116002)(316002)(8936002)(6486002)(38100700002)(26005)(6496006)(2906002)(9686003)(1076003)(38350700002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZoiuDMs9V/GAr9V5j8zV8+8a+ChJHsIjnO7NCecFM2yJm9b7V/YJDAJopz8p?=
 =?us-ascii?Q?3N3yjo1SPAvBhlZJi4K6EPdGafDWBnNxFn4Uh7al0CghM64nPKbhBZ1wdLSY?=
 =?us-ascii?Q?kbWY6CNdhSqmXFlZpBPqaku2ZPgiA2SWXp8aSqYnT3GzsYOFjW8of1ym1Gos?=
 =?us-ascii?Q?4nL+pm2tB2ilKAxLunUYgWjhxyZhyjaiSB/A5IajK1bFQbROC7hvek14GWXv?=
 =?us-ascii?Q?5F6jmRQuedIC5N3ze3zt/JNAc1lrrnQF2iX2GgWJueNVsk/3oNYpqzvUgQG1?=
 =?us-ascii?Q?K8A0kgOXItS+4G14USp8HM9hiV3GhStIIJIv2/CqMfpdNFDmWANtDzW4+3mi?=
 =?us-ascii?Q?+RmCZ57MgrGnDUso72ove6xQl6wp+6uiGAZw4UeDtXdrvtnQ+MeKG3Kicyes?=
 =?us-ascii?Q?BIq3mwf4d/+ho1uUVKbxV4huyZtsE+LJ4gq2CeqjLXhe5WkBpHk9Qu0hkyUC?=
 =?us-ascii?Q?epwQ9yprieICTTgQcmZolENaBQnKPSJCHmYDgSJ4IE84/NRzFt7xllaTwKxi?=
 =?us-ascii?Q?dYn8rSAwmZRcHl2HsRTiMOfpLQbLfFENspMREDsrt6TsTvEZ+cYO0bVD1+3C?=
 =?us-ascii?Q?4zJ6PZUVT3a2S9zNOK26TEsPflvaDWH079qhJW4WJr6kGf9df9nVovB1irNo?=
 =?us-ascii?Q?R9KoWLSyU4sM7HgXy4Wn1gGp0K2t+Ai8C/y2a6Ml7HdXkdzpVw5m8fJDwJW+?=
 =?us-ascii?Q?rBAqHPobSirI9EPDvdqTrA79S8UXIHEj5oKKH/mL7crBmfumtcjt/FBespbN?=
 =?us-ascii?Q?B/herx5bQjc58GVsxwz8+mRmoJGsl32YOeZerrWcPDt0zD5pqoJ9YSHaL0VV?=
 =?us-ascii?Q?TFUUMBbRYHVUrMjgE/CcBIq+MTQvJuTui0jcu/Sb76Y0zTObZKpjdRvt1wCz?=
 =?us-ascii?Q?vuXJyNkoPsp/Q2ZxShfFyhAXxhGE/s8de6WUwCds7e4ORTXn1ShlCAxNKnKp?=
 =?us-ascii?Q?lF+80IrQDsVdU0kmZdT+cbh4BCw5diU+5ud6SgMcZFGrEpwsSL/1kDdm1+dH?=
 =?us-ascii?Q?6IowfLtWIq4jjt6+r62/mj49aSUIkBmK/M28oawmfFD6yq9+CzsWZ52IRwnT?=
 =?us-ascii?Q?VKWPXX7zxwpAMKRf3gtk11Wo3k5hc634W0Y9sksxaNE7vH9/SYCp+bm67qHr?=
 =?us-ascii?Q?KZZfnqh1uUCNXYBwZUN5FPJlHG9H7vP5c3zPrfYbrXgerPo/xTIyKcs1oQHI?=
 =?us-ascii?Q?h7eqAXGFxCHaDLlWq/8hLNNA6jS1z+L5p9XqUE1vtvahC7hG9EerifxcSCTR?=
 =?us-ascii?Q?Xiw4IUNIWekeoipfBs3gkrTHHFjXYEilsyJ2S9MdJjoGJfF4auyxGLPYe5TO?=
 =?us-ascii?Q?aY9SCXnACeB7QXsDDdSLw3dUIA3v6QtPN8NpDU4DMmTmYiWanpxlPOBUY+Kk?=
 =?us-ascii?Q?V/4c5aOn5QeZEXGhFUgOjjDm9xO0c6BybfHEIXG2l584F+vMquZnJWXX/ul7?=
 =?us-ascii?Q?ER1V+4KrDbWUQTxinLy0sZbABVSaG7WvReWoyFp7GKmLaek8n48+DHB9Ye1c?=
 =?us-ascii?Q?E4wc/LTA+8WEYu5ogp8zkRFPOvYjfN8jUWLBOup+uZobDY6tvCTLwub17G/Y?=
 =?us-ascii?Q?zfOGp3nHfU12P/+OYVHzTTzud1b8Db0OdJHLww3V74r6/SlUTDR95yHRxdww?=
 =?us-ascii?Q?PkWF/0pXSRh/e/Of7VHpLAazFoIgEdls2/JFwcy/TqufOqb0lUTbTPZTtZ+U?=
 =?us-ascii?Q?6cNzuptVKgIyc00I0r5OHrxdYN4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad82169b-4028-46d0-aad0-08d9b4b12c62
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 09:58:49.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIkVFpH+oGCFlyZLIZHmAsh5DAVEkEVX2s4LQ7Zcxj4zZWCGhk146rxlGqJ2ZYR5ARV5eqyZXPsEO8IbotQv1c7NQPaqXA4dZV17SX3SEhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010058
X-Proofpoint-ORIG-GUID: MBuoBlDVJL9zqNqfq8pcBqvNxrzrrAhw
X-Proofpoint-GUID: MBuoBlDVJL9zqNqfq8pcBqvNxrzrrAhw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git  relo_core
head:   65afd07f07d266a2b060ab282d72a8d49e0f9eaf
commit: 11b37572bb5db757ca09de550c38471c995d0f50 [14/23] bpf: Add bpf_core_add_cands() and wire it into bpf_core_apply_relo_insn().
config: i386-randconfig-m021-20211128 (https://download.01.org/0day-ci/archive/20211201/202112011647.lhISTWxn-lkp@intel.com/config )
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/bpf/btf.c:6646 bpf_core_find_cands() error: uninitialized symbol 'main_btf'.

vim +/main_btf +6646 kernel/bpf/btf.c

11b37572bb5db7 Alexei Starovoitov 2021-09-16  6574  static struct bpf_cand_cache *
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6575  bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6576  {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6577  	const struct btf *local_btf = ctx->btf;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6578  	const struct btf_type *local_type;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6579  	const struct btf *main_btf;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6580  	size_t local_essent_len;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6581  	struct bpf_cand_cache *cands, *cc;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6582  	struct btf *mod_btf;
                                                        ^^^^^^^^^^^^^^^^^^^^

11b37572bb5db7 Alexei Starovoitov 2021-09-16  6583  	const char *name;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6584  	int id;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6585  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6586  	local_type = btf_type_by_id(local_btf, local_type_id);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6587  	if (!local_type)
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6588  		return ERR_PTR(-EINVAL);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6589  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6590  	name = btf_name_by_offset(local_btf, local_type->name_off);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6591  	if (str_is_empty(name))
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6592  		return ERR_PTR(-EINVAL);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6593  	local_essent_len = bpf_core_essential_name_len(name);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6594  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6595  	cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6596  	if (!cands)
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6597  		return ERR_PTR(-ENOMEM);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6598  	cands->name = kmemdup_nul(name, local_essent_len, GFP_KERNEL);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6599  	if (!cands->name) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6600  		kfree(cands);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6601  		return ERR_PTR(-ENOMEM);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6602  	}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6603  	cands->kind = btf_kind(local_type);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6604  	cands->name_len = local_essent_len;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6605  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6606  	cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6607  	if (cc) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6608  		if (cc->cnt) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6609  			bpf_free_cands(cands);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6610  			return cc;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6611  		}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6612  		goto check_modules;
                                                                ^^^^^^^^^^^^^^^^^^^

11b37572bb5db7 Alexei Starovoitov 2021-09-16  6613  	}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6614  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6615  	/* Attempt to find target candidates in vmlinux BTF first */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6616  	main_btf = bpf_get_btf_vmlinux();
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6617  	cands = bpf_core_add_cands(cands, main_btf, 1);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6618  	if (IS_ERR(cands))
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6619  		return cands;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6620  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6621  	/* populate cache even when cands->cnt == 0 */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6622  	populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6623  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6624  	/* if vmlinux BTF has any candidate, don't go for module BTFs */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6625  	if (cands->cnt)
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6626  		return cands;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6627  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6628  check_modules:
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6629  	cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6630  	if (cc) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6631  		bpf_free_cands(cands);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6632  		/* if cache has it return it even if cc->cnt == 0 */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6633  		return cc;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6634  	}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6635  
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6636  	/* If candidate is not found in vmlinux's BTF then search in module's BTFs */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6637  	spin_lock_bh(&btf_idr_lock);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6638  	idr_for_each_entry(&btf_idr, mod_btf, id) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6639  		if (!btf_is_module(mod_btf))
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6640  			continue;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6641  		/* linear search could be slow hence unlock/lock
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6642  		 * the IDR to avoiding holding it for too long
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6643  		 */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6644  		btf_get(mod_btf);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6645  		spin_unlock_bh(&btf_idr_lock);
11b37572bb5db7 Alexei Starovoitov 2021-09-16 @6646  		cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
                                                                                                                        ^^^^^^^^

11b37572bb5db7 Alexei Starovoitov 2021-09-16  6647  		if (IS_ERR(cands)) {
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6648  			btf_put(mod_btf);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6649  			return cands;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6650  		}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6651  		spin_lock_bh(&btf_idr_lock);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6652  		btf_put(mod_btf);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6653  	}
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6654  	spin_unlock_bh(&btf_idr_lock);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6655  	/* populate cache even when cands->cnt == 0 */
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6656  	populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6657  	return cands;
11b37572bb5db7 Alexei Starovoitov 2021-09-16  6658  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

