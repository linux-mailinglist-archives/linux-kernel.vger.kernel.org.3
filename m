Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3908847858E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhLQHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:25:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhLQHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:25:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2bMCf014954;
        Fri, 17 Dec 2021 07:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/ZUviQPbAXPr2DLmWulw3iZUfqa7K3bQGyiBbAkCqVo=;
 b=Y9FqxWDy0LbA6HQZ/qYyjIa8ZhP3XVLN+EvJdyKGhSe8SSAWEB+vk9363NIYH0nnUSlb
 iPv/3L/XH7yikqq59E094wcF6WTan/O52fNb19qJ4qzjQ2yBjroTaoG/S8LEbCnJ9mgF
 5G5jB/wcUtKrsg5bgxLczKMRRLHSMVQXUx6KQYW8zlGDcr8/eFQquliULBbx2Dn33fmu
 sM64SGR+H9rBWWeIcxLrRCtXRyOcOvZah9NwadMIAyrvR1P1cALQ5neJZ69+6rODfaBw
 lZC3311S9HZzFkfjKLdOi94TteG67HnxVxr5+CkogMcpq7y5oVPk28nFsIWXKhIGODIO nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5d348-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:25:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH79sut133057;
        Fri, 17 Dec 2021 07:25:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3cvnev5v80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 07:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNS1mam4f2EKQLEJvhcLja3Rb+4HNLysEBxDVBPFbuMmGJi3jHrDnSBJaus97GWyidEdYn3LgFK1MzbJc/Np2MTcZvBaiuBjLXdNTFkh/Alii5y26Q7MoXpaOWeIX93YUbiy+BfB3C1sLX1StizwkgIRJYYSEwZpmlN78LPZsnJRhysyXHW9D5wAkCmykkSAkdkC2lB4nZPcJ9A3V3NUc8jZYwk8q1dnU0p2Ss45rjaLTNrPnr8zmIRou7wt+dvrL1XTov8LwOwKskAvHYXG16jemGlWkpff4MS2eh5ERTrPewAx5ZJJ34p9LKmf+zIQDaphxAXEKCo6KHEQJq1TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZUviQPbAXPr2DLmWulw3iZUfqa7K3bQGyiBbAkCqVo=;
 b=jvd/BsBIsh39dFXz7hJBlXKHajWQK21u/95+JZNq5v/WM4JPnPlDFt8u/ZLPCHD05whbZ+36anlhaL0KKMn3GS1NVMzblydzAsIvV+G8Bfdq0yj/xmvV+Nd5tSUJaHrdtPpiL9R0RZbeI+eUGs/yWAtYLsp+OwqiVgGR4ZSSXomEUZAvq1I52zqK/f1tXyv96fVKdhEOLWSWkImgo0f9kfZDSEvai6zYv3uJz3maK/5gGfOPBZAlspoEi26qjKEWj+j/ILbgaCzHY5TrFx1aqqiZd5lC+6DLbV/JN5URInuE8QzIffJUG2O+oARJC/U7aZ8ljeTjJUhVAVcE0n98sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZUviQPbAXPr2DLmWulw3iZUfqa7K3bQGyiBbAkCqVo=;
 b=VL2HJUpXxJEudJ6nRbTYNMizxU3kR4S9MSVYTdaaA6GAhhqTdtqHABpgTPYgLfMXzbPgWOAi6chrTM7axaFsSBqJTHIhVWaOg82ucKkqJIjEFmLcsJXy/513PxdswFQtIOnqd94twkFQyaDamaM0Ma11PdqYJaAQQnQRFGznp+o=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR1001MB2360.namprd10.prod.outlook.com
 (2603:10b6:910:48::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 07:25:43 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 07:25:42 +0000
Date:   Fri, 17 Dec 2021 10:25:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:765
 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream'
 could be null (see line 749)
Message-ID: <202112161717.aP6FA32v-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf885588-27ae-471e-8e2a-08d9c12e6f30
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2360:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2360FB3DAA61E64B40DB607F8E789@CY4PR1001MB2360.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:30;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfUA2jVaSamBza1pddbZ9pihGpNYOwHnu7AFKJJtHYJ4Vim/Wseqz14YcsZFE5Ak54pIMxbP3Xs0yhlKPo5jTdzea6iGr1783MkVvCyhaJfXKbZRs89eGluBjq+GzkFkaxuK4qUYct2V1jHCMMK59nm6QjwVnsxVcDe315uqu19N/JttjxPf+/UiqFJ1UPMYe3NfkH3TCiVMukj83o8sdMllMkvjhLtPwDaZT/QMg+oCGwk8mMMCLJZ85iG3063YC/wQOoN3+9K5kht2TkKc6RL4KrWNIp75wb6UOVN7frbA6lHQEBx/k24w8wj6UdgtteM/DMo3szqcNkmB49lE6Kb2PJKwRK7QP4SzjLhpNvL1X+0MXBi++ZEPK0EKFYTpn9Z5rPQ4pW1oofpW63uW+RF3m+Icdq2tPj53a4Cq/xUr2MTxh3LHUmd89N+/1ZLfthlwQmssIwdAYyE3GgQESxhBqGPY7pEbxXNMIdtX8LInkojN9cZI3cLyW6cyeYaQMrGc6+619CGcUuK7vVG4OYVnvLLzVE+7wZ4ds6jmdJmyWdFvp2BavfVIQvq7eLlB73mkaGBzbMfspbwHkmXW7FF2GlZB+OpksZ8EbIkX7yhI3XgKNn++FANbmD6+DJdkn7wh/Mx6Z3g5P82Kq9jSseEV+twxIziVlJkj7gjxdqSbTYZZ2rIi7/E9Q7R2S/qk8yRJjjhkXKlNKwN8UbAUIynOJvvZ9Kz0SSDXoSQGlQzKvR+vIZ6bZUVtTLzvAx4I/LWzlCHnN4X6Yup9ZmBJYDveNg566gzHRTNPLu8p2o6HZrcnlh+XdlAvqx4uGpdv6zrZi/GwNRvjsGiF2OikdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(4001150100001)(86362001)(52116002)(6486002)(66556008)(2906002)(8936002)(38350700002)(186003)(36756003)(508600001)(316002)(6506007)(5660300002)(44832011)(38100700002)(6916009)(4326008)(1076003)(6512007)(6666004)(8676002)(54906003)(9686003)(66946007)(26005)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFfr+25uiefy0A0DXv0U+bVFGN/mHJzp5J0TJrSmGolKD8u7OVVCGSsLswJg?=
 =?us-ascii?Q?N0nkjwJFjARtX4418O79N7Osy/U7ekNDXfJot0iTSuwUx2ccLhtsJPiTkqPJ?=
 =?us-ascii?Q?VK0NckTTFdYA+g0mDsH68UdAQniAGG6AlJLB8xwPD2B4h1FFPFNqSD6FV9ii?=
 =?us-ascii?Q?huEawocak8NKeVnztOsz7otYz1M35v2yMU1M/DhmDdU2pGjI6mBL4LYSEVgu?=
 =?us-ascii?Q?L5Mp5AWml9UIvgbl8s77ow7gICiCTfn9cokZEUGV10EfnowrUnbC2Y4XIcdo?=
 =?us-ascii?Q?YQ1CeGfu0tegFXb2UeLv0ym24Gsh5QO+pqOp9SIsFM9K00A2kF0p47IRFRAa?=
 =?us-ascii?Q?oGTz19gbr55aT3jmk9PbhvaRwG4kPm+UArNoZ/DBvFgE9O+GyOqenQeSTNEe?=
 =?us-ascii?Q?JShnNoyAK7AYZ4opHYFAHy4NIZK7ZxrkTuIDP+Mq8s2lk72mTldqquSOyLyv?=
 =?us-ascii?Q?TYIVaXUkR4eQ3n6Ltd3kqhyXuWKImDKmqhzZUjtup9EV4M0dUtbdve8lKID5?=
 =?us-ascii?Q?lfUsOqgifqB8pl774Fz9ANlMAlppPCNJzniY+yOaGQuXtOGF936bJxCJOk45?=
 =?us-ascii?Q?Y6KI/tK30SmWgfuSc43GUvE4jZ4uG0nuNSiLxDLCvDB4mj+pkC+SG6cSu26g?=
 =?us-ascii?Q?lSVP7KEy4MJyVQijhtFNd4oBw+85CtTiDF1DCLkdjYikZnU9hXJ7K+iuIZaO?=
 =?us-ascii?Q?VdFSSBBHcfr9PsOAiKbffEt0Ql4vGnAeGZpSNSonur0uEF9z2DqUXVHt8fVv?=
 =?us-ascii?Q?ISDROxgRZzisNrxNAo48dKouw14d1m6ZfAb9Kp1a3tDRnyfHqh3ceEipjSR0?=
 =?us-ascii?Q?Xp9oaQ6+ax0P5ySyxw5kDScQftX2pDQWteAx933/LUW9ovzgnIOTtNw5XH5L?=
 =?us-ascii?Q?B6SAEmaTCYeDsWEs6f6zHJPq1QRKZRgzGk+Q6MHUk4yt7TxNp+LmoDKp/s6f?=
 =?us-ascii?Q?ar/m3buj3+OWeOnXVhgiRAGSOPvSAH4bqVzkbXzQUK3l8G3MuOwq8ruHJoCM?=
 =?us-ascii?Q?xP0aFn4x1OkH2crHlp2C+8ukZvbNxEMvSY/aBnfj5jCg/w1gTKYLd9Ad3qor?=
 =?us-ascii?Q?ZNseqx1YUqYus+vlJKHNxBnADbNjUkjIp21wkEPweku/YxxJlczjHmYIZnSv?=
 =?us-ascii?Q?Xr4qApXR4xIKjUk8WP52nDJHOpPRM3m/865N5Q6XRz9rTG/dG37+iM1HIBW4?=
 =?us-ascii?Q?IGwwMPcNrfALYg35cBhU56pt1HLenkk6bfR4u77xZCTvRLUp1UFeyCpnK3PD?=
 =?us-ascii?Q?oxI8F4m570/U2qYeLmJ6d2JY6oMPUF4ud20Z9KnSZUABT140IeMjCOmN5Rmf?=
 =?us-ascii?Q?F7J0mbghFty9kzDABU9K4vSXzYDqYWzokCLUMAWjGLHK7LbMjlNFDlhsSFB5?=
 =?us-ascii?Q?t7ePTJYnsUq6l8ffBpK1XwKjwWlXVX2RglNqRxalpgKu83LtVdBQb7CGRw+B?=
 =?us-ascii?Q?RHPz2/GNFxSHLHR79XmbLK50Wfa9adr/jaVh5JPdRLfWniYznXYN5J678bXL?=
 =?us-ascii?Q?gslu+s8R8pjCPBMf3SfH+/uZ+eiDc6FLh9ppgoHcg/YK1dr49o1SHl/1AipV?=
 =?us-ascii?Q?WeVlV+Do/o6TQSS61GVnRFz9G89GQI/GRHXlZkgQuJSIIFfug1Zl753BWgCv?=
 =?us-ascii?Q?2ftYb8lQerWvjWzD9Np5AVzHAd/oK24012B6xOcGaLansNigRiSBKtKvwkyO?=
 =?us-ascii?Q?FgHfw9fm/auHhKGliPLVzjGExhs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf885588-27ae-471e-8e2a-08d9c12e6f30
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:25:42.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujCvwC3J2wEQNayuh7j/1uhQOsGdLPVtjWXJDLxWkCG8CQmW1SA+M67MZzDkoaxKJi6+ZE/qqWcoc6NEQ7E2fVgitrA2DJrLiF5VD8jDkxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2360
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170040
X-Proofpoint-GUID: 07xZrLXHoBn5eOyn8844FR6AZU6ywxt2
X-Proofpoint-ORIG-GUID: 07xZrLXHoBn5eOyn8844FR6AZU6ywxt2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: ea7154d8d9fb26129f51e4d763febe97a13228a5 drm/amd/display: Update dcn30_apply_idle_power_optimizations() code
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211216/202112161717.aP6FA32v-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:765 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 749)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:767 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 749)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:483 dcn30_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 435)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:636 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 431)

vim +/stream +765 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c

d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  710  bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  711  {
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  712  	union dmub_rb_cmd cmd;
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  713  	uint32_t tmr_delay = 0, tmr_scale = 0;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  714  	struct dc_cursor_attributes cursor_attr;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  715  	bool cursor_cache_enable = false;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  716  	struct dc_stream_state *stream = NULL;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  717  	struct dc_plane_state *plane = NULL;
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  718  
d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  719  	if (!dc->ctx->dmub_srv)
d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  720  		return false;
d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  721  
d99f13878d6f9c Bhawanpreet Lakha 2020-05-21  722  	if (enable) {
48e48e59847821 Zhan Liu          2020-08-28  723  		if (dc->current_state) {
48e48e59847821 Zhan Liu          2020-08-28  724  			int i;
48e48e59847821 Zhan Liu          2020-08-28  725  
48e48e59847821 Zhan Liu          2020-08-28  726  			/* First, check no-memory-requests case */
48e48e59847821 Zhan Liu          2020-08-28  727  			for (i = 0; i < dc->current_state->stream_count; i++) {
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  728  				if (dc->current_state->stream_status[i].plane_count)
48e48e59847821 Zhan Liu          2020-08-28  729  					/* Fail eligibility on a visible stream */
48e48e59847821 Zhan Liu          2020-08-28  730  					break;
48e48e59847821 Zhan Liu          2020-08-28  731  			}
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  732  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  733  			if (i == dc->current_state->stream_count) {
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  734  				/* Enable no-memory-requests case */
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  735  				memset(&cmd, 0, sizeof(cmd));
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  736  				cmd.mall.header.type = DMUB_CMD__MALL;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  737  				cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_NO_DF_REQ;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  738  				cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  739  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  740  				dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  741  				dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  742  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  743  				return true;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  744  			}
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  745  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  746  			stream = dc->current_state->streams[0];
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  747  			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  748  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19 @749  			if (stream && plane) {
                                                                            ^^^^^^^^^^^^^^^
Checks for NULL

ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  750  				cursor_cache_enable = stream->cursor_position.enable &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  751  						plane->address.grph.cursor_cache_addr.quad_part;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  752  				cursor_attr = stream->cursor_attributes;
a87a9a73d0e283 Alex Deucher      2020-10-26  753  			}
a87a9a73d0e283 Alex Deucher      2020-10-26  754  
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  755  			/*
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  756  			 * Second, check MALL eligibility
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  757  			 *
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  758  			 * single display only, single surface only, 8 and 16 bit formats only, no VM,
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  759  			 * do not use MALL for displays that support PSR as they use D0i3.2 in DMCUB FW
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  760  			 *
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  761  			 * TODO: When we implement multi-display, PSR displays will be allowed if there is
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  762  			 * a non-PSR display present, since in that case we can't do D0i3.2
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  763  			 */
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  764  			if (dc->current_state->stream_count == 1 &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19 @765  					stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
                                                                                        ^^^^^^^^
Unchecked dereferences.

ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  766  					dc->current_state->stream_status[0].plane_count == 1 &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19 @767  					plane->format <= SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F &&
                                                                                        ^^^^^^^^^^^^^

ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  768  					plane->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  769  					plane->address.page_table_base.quad_part == 0 &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  770  					dc->hwss.does_plane_fit_in_mall &&
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  771  					dc->hwss.does_plane_fit_in_mall(dc, plane,
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  772  							cursor_cache_enable ? &cursor_attr : NULL)) {
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  773  				unsigned int v_total = stream->adjust.v_total_max ?
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  774  						stream->adjust.v_total_max : stream->timing.v_total;
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  775  				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  776  						100LL /	(v_total * stream->timing.h_total);
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  777  
52f2e83e2fe559 Bhawanpreet Lakha 2020-05-29  778  				/*
ea7154d8d9fb26 Bhawanpreet Lakha 2021-01-19  779  				 * one frame time in microsec:

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

