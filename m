Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90241470373
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhLJPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:06:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235206AbhLJPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:06:41 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAET2XD031407;
        Fri, 10 Dec 2021 15:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=x6urZ/eN5VtOJW2rZgI8C8eOErIVd6Imx2Ff/bpYIRY=;
 b=rHPLqcoUNUlhQXzsHQUfnMBXmWHzrWSZ3lX4JHQb1wi+fAjkRYRFEZHbEE57rxkPpFLj
 TmRUNnx664R9GcaJldaHLLXd22Hf+VBhsEKX7UC9NdyS8R1hz6wcpdsmBGN6GrH3f0Nr
 3QLUDO95VpFP9BV/2tH88PmrGNd3Lb+Wjh1qtbFaTPQTh+sLsU+m3fowbpR0Z5yH9+m6
 iooae+w9ucWrYM2sLDMGfBCqYhgy1FBmgbefv/gM05/CM20uyvd+/PJB8/nyQkc7JxCB
 HaMvpy5f2zS3V0iMrU8U+crN3jc7BDQzXzghXY1BBqbYUkvSYF0Szk57lYClcu52dy6C zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctup561m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 15:02:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAF0HXR039577;
        Fri, 10 Dec 2021 15:02:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3020.oracle.com with ESMTP id 3cr059cxnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 15:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daoVMtBZEk5EiW5Fxq1VXGcgcsq6jTOUTFAC9HS/TJKzGWZ0gu1jxCAzLHuZROWOqf/MQxBffheoCYmZgGNN3YB73LpB9ZpYr8fAykT3mhd7yH/kWgWo77HItbLwJnNJ6E9yIgLSREZMVx7NEi2zPpuKKgMpc+/II1NoVYfXQw3bspuyEf7m5Lb3HeSgIWjKKjuS9ergldp6FOB3vsLxEgJwsIKMkMTZGraHlt3nPJylDIw1fuuTDhCa3xVF2K6yjqFg8/0eVX5skWA/iKM7XgT7IGo5U0bseBWdKeTa9O2URhx0KO+H6Od/r6pUWJgCKUpHwICPL79136LFPYUVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6urZ/eN5VtOJW2rZgI8C8eOErIVd6Imx2Ff/bpYIRY=;
 b=T+BhuKQMGrMNjgsDMqchkLcDX219/uDEljOc5at5rlkXZT1jqO7oH+/sYZohSVHGv0kbwUwl3B0sdaykAwUGsgyUEef70MDgZ9uvRn6KMoBIY6eGZoFYmleL/yQLpKZfgdEcnYDOY6RXoUneIsTMgkjp/L5t9oLfNb/mTpv9HyovyJtkT4iib2uhXxm5CM+lctKr3hCd2x1oGTIcAZWPunxoRRCZrcP/OJ4o7ThTpwbnP+0vRpt1NbCCHaj0NcsbtghWwk4THPSrZk7xDwwhU2TmFZ7TREtXf+A6YX3ymJEekj/36m4T8ZAx+hHJp4y8YtLm4yr4kx+5jYfnRSaLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6urZ/eN5VtOJW2rZgI8C8eOErIVd6Imx2Ff/bpYIRY=;
 b=uYpIUoQ0755AzKAUpPJK95TN3gY8vrhVZkuJnNnU9kuP5ZGHH70Ipp0eugvTJ0sDPlRJbYRe9VE832/y5WY/aP230cQNBpIlb/hIn0XvF9OQe2/3s5NjRmN3HNCyau9Cm6ts3l3lGD8Z4FzGpdEKcq4yi/JLnqqxHsc5XuIzoLA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1421.namprd10.prod.outlook.com
 (2603:10b6:300:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:02:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 15:02:30 +0000
Date:   Fri, 10 Dec 2021 18:01:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: sound/soc/qcom/qdsp6/topology.c:336 audioreach_parse_sg_tokens()
 error: potentially dereferencing uninitialized 'sg'.
Message-ID: <202112102206.S7otMlhZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Fri, 10 Dec 2021 15:02:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279d7a4a-4d44-4377-a9a0-08d9bbee15ef
X-MS-TrafficTypeDiagnostic: MWHPR10MB1421:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB142102BFB39DF820B5C5AD608E719@MWHPR10MB1421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDwfwPgEYNmXaYU10VAYYfWzGAx0zyLyLRcA/O5AOSHbAZZp57ktO5VQwugRtsMjox9oXVf/q6GKytPAm5iJI513EDSDzXlIKGA4qkqS0ZCrWJj+pHTEN/MRjUMH8h5+EtCpsTj5vW7J9eJQILct5gnxfW20rLl7B4EX8g6uuKr1wtAjlx6tRnRUGuKxItMeTPAP0qEaqgX3opqUOPoiioMN1P/iN4KyGskOnciDepxsWUAC9Slre5sW0/nl3gqPqnZ5XkqPV4zT/S4+OISMzPtEkYNsab1k4/Ds/8t53im0P3YmJw+x1v98cFMwuKmXbiT6CQlf6702OyZK9xXWSDE46hj+8a9DBWYju3phY9t2VtIqpN3C0EOgja0xaybaUGTGuT4er8gRTsxKsUKeOqWdqzDwKifPyX1SjNXt9lE6Yle6izQXnp5/mS/Rj0H4svucJB3UM9mGtD5ZcpbGP04F/zTtFQWHq7lgIJedwzhRfB/0H7pH22xg1MgzF1g/3W9P1D8bvYvBA78VOBvjyeAb75ES//Gav7WNcGwjpfW2OARtwDxyF9mwPKB1FdBOu32fEao3c3W04saSnhlPsIVeXRQjXqhXCcnaV7uv2lD7k7LXGc5efdiTDDbzLMb36spZrBWuO5jAaOMJz8FLOUi9AlEmCZwebRclRba5CwPR+ZLBkZvr/5omFhSS/O31O7M9Pl8iMkyFbDGwZZYCiWqCGRdkJHze25Itiipd6fK5fj06gI8/9NuWFZu6UJQz6FFhMWjIJUZPmMpDHRmpJ/YDfT1AjM3+pTI1chvRGkKk/xIHSA9l3QeRgt7LLBK+6hsOSU4IotdQZB1TQHSBaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(86362001)(54906003)(52116002)(44832011)(1076003)(508600001)(186003)(66946007)(83380400001)(966005)(6486002)(5660300002)(6496006)(4001150100001)(2906002)(8676002)(8936002)(6666004)(956004)(66556008)(4326008)(66476007)(36756003)(38100700002)(38350700002)(316002)(26005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hu0ow+0jkaXpdrgMvjh5Xyhci+71dLvB5E+2KMMiYem4WPLCz3JdR8/7I2+A?=
 =?us-ascii?Q?3BPhatX7cst8mGZom7viTx+6mUViQn0Ka1zhpu1Wb60ZHpCTg4vwDZVmYuoH?=
 =?us-ascii?Q?hmyIPgtnN562d472WvsfykK/oDe/7JwXZuZ/o354F9JDUcGcOmyTHlcGzXh3?=
 =?us-ascii?Q?1KIs+wwzi/6y1g7uo4je8h6ZBvB8iX2FWh9T5JeVH97oJgrf53WDg0LrIdqI?=
 =?us-ascii?Q?Lj6k3TZU5QV0y6ppMnOuKVTM2mYpjp6gDPpm7Btn7XOJXK+WS7g7yiBQ6ZFv?=
 =?us-ascii?Q?AoAkYddi6Yk7u9xPqQgvy+VK1YknAWEi+lFDDLHL4yJxF5VDOjzsn+WQbNMp?=
 =?us-ascii?Q?kpn/mOYNW4ViEFaxwjxtm71Gk65Ic7VoQ99zxzw5MttiN1XKzmyUBlE3oVPV?=
 =?us-ascii?Q?IiEMKVmJPqq8wNPzZ9u8YQxLYVn5vle4uaJCybiEi7pbuA5slNwy0uvTwrUB?=
 =?us-ascii?Q?cq15DXcu+eQyoM9pLEUcbke741fvlzfGbV93sRI7WBC50VlAWCbfVlU19lSA?=
 =?us-ascii?Q?GQ/wrKlq6ZIfzJDtKukkk1+9AQ/Hzb3AZyCVAzDIPjfxUkimCvXiOPXPToJm?=
 =?us-ascii?Q?xaiZRCJqskYBoGBxpLCWHQKcZvYpE30XQjV+7L9QLpuomKxsxtFDHqm06831?=
 =?us-ascii?Q?3Dt3WQjlw8CR7iGR7O/X1tbn5WNMCCw6ZGQsGKBo2dVeUJrQ12PmRiOCrWxV?=
 =?us-ascii?Q?VWlauXcyIlWRkY7FFwU/hnYOFsafhluQmD9mBah2gnQesCNuSHh/5hci0IGl?=
 =?us-ascii?Q?r4C6+lC/ui03zMNTI9WCMm6FQNwlKgx7MlP8HvqsXKV6awnufGAOPUhGCUY8?=
 =?us-ascii?Q?DZUrbJRam+xfDYk396C/1RWe6f/A9lh5PRZ+8SZR5e1hP2XA/REQqPQEUVfr?=
 =?us-ascii?Q?JrXKSVn+8UkVyplJsQphYiZh90kkw77S5YinSx4lhqaJdOKvQ2JVHlmgrv88?=
 =?us-ascii?Q?DjZglF6D3PRJ+XrTr50tSrK5tw3R2OYWaar2uIRkeTH3HNqDtpAcE874D/NK?=
 =?us-ascii?Q?D97mHmHsxYJ8Oxy1toq6/MWdx1wgaL3VmG6a6rKJDWc3RI47bvBjA/gvXc6J?=
 =?us-ascii?Q?ko1X81u0oTpVNjm8B01SAZmHRBephLq1ZAeCj6ivpyBWkyfSrjWZqSU+2M2f?=
 =?us-ascii?Q?c3fr00D61QcZCDSQCIEjXnBIJeLO34wHApWC7k74pL9VEtO5hqoORt3HRteH?=
 =?us-ascii?Q?w6Bv/2d5fg4MBRd5bP5UDwyoF1g6TYk7+ctNm+iYaG8FOtGFpu8MK1xx2PZo?=
 =?us-ascii?Q?AdvND4pqE+Cl22oj4PC8smUIb9P6fShYfQFf78gF98hck9C9qTPPFQcNsOhn?=
 =?us-ascii?Q?UYdY6c8NdfyVg7Cq2T1UjBXlrhwyn8zu81KagRoF1Zr3EcYd8Bl8YG1T8x8w?=
 =?us-ascii?Q?s21Q4Cd+sk8wRcouJrnah86u6QQbmlpvNmpIRX3Owi72YgpGNwB7E82sPwip?=
 =?us-ascii?Q?YpmG380pBoKtHp4HrVU9Ol1vn2bCuqmGQjw0AbM1Dt2+utiJ3ARpuUeQH4fr?=
 =?us-ascii?Q?oHhqWxijtQ2TwmJFCas1qmhPm1i2g8yTg1clDXL00E6pMG1EUZBo+ZWw1d2V?=
 =?us-ascii?Q?1LGBDIeWZV6yTQmOvoCTJErHTu8+Bl5TKooSeLj/9M8B6vSS0zvkkSGhzXoM?=
 =?us-ascii?Q?ATgDG2/3tPtEGwnp7opfBn1fCudGR/KD23RXspDWJbJ8/zkR4WO3yL+h4x4H?=
 =?us-ascii?Q?WD89GR8LE0UFSdPeV9B5TvvndrQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d7a4a-4d44-4377-a9a0-08d9bbee15ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:02:30.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y6qYCUNywUaVVw7ag8kDGTXYRgLlERWNv0XbPo+u7p5V7Olct2rvV9Mc/HwX2wXnOvgzmUqdscBT6SqR+8zPyMA4ARAF4lw42b9eM1O4O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100086
X-Proofpoint-GUID: FK7jdU88dimNI3tZUxvppqfCuWxbJ7wo
X-Proofpoint-ORIG-GUID: FK7jdU88dimNI3tZUxvppqfCuWxbJ7wo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c741e49150dbb0c0aebe234389f4aa8b47958fa8
commit: 36ad9bf1d93d66b901342eab9f8ed6c1537655a6 ASoC: qdsp6: audioreach: add topology support
date:   6 weeks ago
config: riscv-randconfig-m031-20211210 (https://download.01.org/0day-ci/archive/20211210/202112102206.S7otMlhZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
sound/soc/qcom/qdsp6/topology.c:336 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:355 audioreach_parse_sg_tokens() error: uninitialized symbol 'sg'.
sound/soc/qcom/qdsp6/topology.c:382 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:402 audioreach_parse_cont_tokens() error: uninitialized symbol 'cont'.

Old smatch warnings:
sound/soc/qcom/qdsp6/topology.c:339 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:342 audioreach_parse_sg_tokens() error: potentially dereferencing uninitialized 'sg'.
sound/soc/qcom/qdsp6/topology.c:357 audioreach_parse_sg_tokens() error: uninitialized symbol 'sg'.
sound/soc/qcom/qdsp6/topology.c:385 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:388 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.
sound/soc/qcom/qdsp6/topology.c:391 audioreach_parse_cont_tokens() error: potentially dereferencing uninitialized 'cont'.

vim +/sg +336 sound/soc/qcom/qdsp6/topology.c

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  303  static struct audioreach_sub_graph *audioreach_parse_sg_tokens(struct q6apm *apm,
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  304  						       struct snd_soc_tplg_private *private)
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  305  {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  306  	struct snd_soc_tplg_vendor_value_elem *sg_elem;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  307  	struct snd_soc_tplg_vendor_array *sg_array;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  308  	struct audioreach_graph_info *info = NULL;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  309  	int graph_id, sub_graph_id, tkn_count = 0;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  310  	struct audioreach_sub_graph *sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  311  	bool found;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  312  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  313  	sg_array = audioreach_get_sg_array(private);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  314  	sg_elem = sg_array->value;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  315  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  316  	while (tkn_count <= (le32_to_cpu(sg_array->num_elems) - 1)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  317  		switch (le32_to_cpu(sg_elem->token)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  318  		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  319  			sub_graph_id = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  320  			sg = audioreach_tplg_alloc_sub_graph(apm, sub_graph_id, &found);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  321  			if (IS_ERR(sg)) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  322  				return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  323  			} else if (found) {
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  324  				/* Already parsed data for this sub-graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  325  				return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  326  			}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  327  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  328  		case AR_TKN_DAI_INDEX:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  329  			/* Sub graph is associated with predefined graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  330  			graph_id = le32_to_cpu(sg_elem->value);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  331  			info = audioreach_tplg_alloc_graph_info(apm, graph_id, &found);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  332  			if (IS_ERR(info))
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  333  				return ERR_CAST(info);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  334  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  335  		case AR_TKN_U32_SUB_GRAPH_PERF_MODE:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @336  			sg->perf_mode = le32_to_cpu(sg_elem->value);
                                                                        ^^^^
Static checkers don't like that we assume the first element of the
array is AR_TKN_U32_SUB_GRAPH_INSTANCE_ID.

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  337  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  338  		case AR_TKN_U32_SUB_GRAPH_DIRECTION:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  339  			sg->direction = le32_to_cpu(sg_elem->value);
                                                                        ^^^^

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  340  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  341  		case AR_TKN_U32_SUB_GRAPH_SCENARIO_ID:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  342  			sg->scenario_id = le32_to_cpu(sg_elem->value);
                                                                        ^^^^

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  343  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  344  		default:
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  345  			dev_err(apm->dev, "Not a valid token %d for graph\n", sg_elem->token);
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  346  			break;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  347  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  348  		}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  349  		tkn_count++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  350  		sg_elem++;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  351  	}
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  352  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  353  	/* Sub graph is associated with predefined graph */
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  354  	if (info)
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26 @355  		audioreach_tplg_add_sub_graph(sg, info);
                                                                                              ^^

36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  356  
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  357  	return sg;
36ad9bf1d93d66 Srinivas Kandagatla 2021-10-26  358  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

