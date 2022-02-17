Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98224BA1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiBQNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:44:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbiBQNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:43:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF92B1001
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:42:54 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HCgvrX010825;
        Thu, 17 Feb 2022 13:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=F/QebsczXSN5hMlqRcyzwIoUJKBZ9aMValQe6XZe7IY=;
 b=wfrBR+CaOa37fx8bnpCirZT5rCaV9bCF7DgepU1wOPRH4JJQxqM5WAMpr6QgWtOjpktG
 9p8aomstInBFF3gHauVPKjjUUT/1+OJLKw87B8/oJ8qsFEzS2OgCMS+0abRQkzjcjlHV
 +9bZMmk+JKS0mK3ePXcR6/H/DANsgINUK0cPFjdz77nVXUpgUa8wwb3oWzl9GxGUSHxm
 NllwBdFddutKX7p38nYdw8R7pX8YIrVLfmTFXBFVI93SVf0O5kk4BzYbjVEKbktILk3J
 uEmRsG3/l+JA063L+lgzoLrxlxIZXbKmmaifG/RolryfmhCUa84SkFg9E8Cp5GNabQs6 Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdnw55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:42:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HDehcL074288;
        Thu, 17 Feb 2022 13:42:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by aserp3030.oracle.com with ESMTP id 3e9brce0s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQpKNglRQL+/mFExwmyacMkjzexXwBqHYHmQZFngLs0fTbtNFXtUN8QBp98gvg4HMoa2VfLxe6eaU4ygQWhoTDI3ThQaC3xmJ+WV+xOlw5/3OvHUrwQBr7emcysJuFvHpZBdqvK8IfioTH3c5DwTXGcgn72qHcqR6vZz0w/+ivcBHA+s8PoDhSw7L4LGiDBVEZJC9tc7eHcb4AXp1k5Lj8gdhNYZutyi4gbm/yK0uUFLwXC0hLXtFIOr7ey5ngexEdj/2pwHNVcct4Z3qiFKjaiF25cUl6U9I/2fLVxEXm6aDSXgnV5xDs02POm34o2ttQd3wszvEKViQLosFkGDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/QebsczXSN5hMlqRcyzwIoUJKBZ9aMValQe6XZe7IY=;
 b=GFJsJxFh+rYmZgqVqEMkg8IZ4+R7jDfKFkFkjgER/RUYORK0i/PbBDd125oDbzH6TMAaHGREZz/0V9A1Y7ZkGr7ojdQXqsTT4+M3o7rD8pl52ycGZ2ivtrdNrBLqqhWhNbt/FreznsHlIMwRFNGp+/Gr+eSD1d8Fh8zCjlUXMN/dSUg3KPavewWq2mbLA9aADJFEdQ1XM0ks4cYtC0XBjLBFLJv0U2nINJO/lFqdoZdmIi/ptcpSHOpwDvwHl8HaumrxpXcjGNTcdl1h6nmZbrxQLPbk181rCDDJJZsBmLKcCIhGVfX0lzH/TCW0LyzaBxHJuvgzc1t36dMtLW4KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/QebsczXSN5hMlqRcyzwIoUJKBZ9aMValQe6XZe7IY=;
 b=Z0bI+fPELcdCeHvXdO14C3kanfVSVebI48lb4HdiOe3VxPdX1CYFuX5yUq2d/6tfBZe04QMNp7ecMnMkVC6lmX1DHK5HDQnrnmvAUR7rI/h9R6dxqXz3UlX8nlp7C+yemeNqH+h9hvK+4p3cl27MijraF3zE3aTpCsQrk8xxHJM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3240.namprd10.prod.outlook.com
 (2603:10b6:a03:155::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 13:42:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 13:42:48 +0000
Date:   Thu, 17 Feb 2022 16:42:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zack Rusin <zackr@vmware.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Martin Krastev <krastevm@vmware.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:1177 vmw_translate_mob_ptr()
 warn: passing zero to 'PTR_ERR'
Message-ID: <202202151635.DiGY2FPj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f4a002-d915-4cbf-77b0-08d9f21b62cb
X-MS-TrafficTypeDiagnostic: BYAPR10MB3240:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3240F1105B883E2B615CC6698E369@BYAPR10MB3240.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAdW3uVUg6u9PJSO73Sn3ShpMJCzAHW8RMoWistHSWZplWYGZI8qG/1TKHi/wJ0JJ2v2G/JqtCXIan7LzLBw+mpWmUbQPmmfd8yn8tHfKqEP5tebZKyTk9r7bjTktrxt0ayIFrZO0RX6cdIpinnPDB0cmwJVni4uxu+FKMxT+rH+Ycmi2hkFecRL4rxqCBWxzCPGrcN/hxNt6yyCrVLM4w8JKvOurllg7Qn+CdHFQtq8tKXJO9MlgBMYqWyZ88aud7bl9VNy7HNm4T8c69rbaXXKYLKpvabbRY2v9q1m63xxrA0dR+D/yIbG7YNrVdrAAzDCgTupCZ/uPUXHYw7mipvtTX689AnHWpDTR6gAAEjqVcQoqIPN/Rd0d5/5ahmOaW11w4SRbeihQqKwQ1th11I0S2KNRgc1j8efEhAx/XD3sJ1r02fa/6BvmQSjI6RZbbGllMHuF2kuKwnuGNejffbK8l3CADfjz/5+ft1zcsPOydguogihMhVL39K5HTUlgp8NNtCCKzHoMawl7ZmRMx2HXGpQUti+mr3zEGgIaw8YWs4c15XRndET9uwg1j32X2WayxQ8v91hWhp5Qc0bQ/XsKM2pW9d1PMUlch+s/MPDzQuv4Kjnz3XCD3Ob97LZsbmvGQ21NIHpll1kKVpaBEmNTG1ED5pwwxGxNVZvAw1qcObfUkfq5THmEwF+PZO7k5rHqJy4mYyZvXIESD+S6hElRIuUr3G6GaMYdnv6E9Of01WwkuuzzuSqiYMPr+uzDkXU64L5vFZJW/NNi8ecVaVk8fUb/t3emZEcR8PlEQrBsuO0lMS44OLooPqq7RX0CnNxnhfpCLBgq9wmC2uIVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(5660300002)(36756003)(66476007)(66946007)(86362001)(66556008)(4326008)(8936002)(2906002)(1076003)(6506007)(6512007)(6666004)(8676002)(9686003)(26005)(38350700002)(186003)(6486002)(38100700002)(966005)(508600001)(316002)(83380400001)(6916009)(44832011)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6blRAgS1rAzVo+8LKqOSuzd0UWrNdnZOWX27yQ51etN/mYsR61nI7J5Qn4l?=
 =?us-ascii?Q?gbIeNNnfiQqo1Rl6xFyKGrKE6fZj+eefQVntvr86iVu/EBdTv8KJ2wSKv9sx?=
 =?us-ascii?Q?Vbz1iwJ9ygqrSW9Jvupl0CbVoJYFZqUV7l6LZKgQXbeK+wkUIzId+KNM9Zx5?=
 =?us-ascii?Q?TCzQIECnSJIUZ0ThYEiC8qFhb4fWDhQZbjjW3HygiqNW4jjXR7/mZe3Ok3lI?=
 =?us-ascii?Q?lsBs3BwucotbsRvDygL5ZVU35zd++R/VUGOC0bcIdnqG2lZBfMkP8POTNkJX?=
 =?us-ascii?Q?Wx7l/RlttUKgWuBPcE3wYbGzXu48ncxXd4hdJND8fXV3mxTC0QKOSuO3ymaJ?=
 =?us-ascii?Q?1nwFs6CmmlMSpfEvom0Jr3rvdeUNCaK4hx1i7+VqEn9BivT5v8W55hRlhpLB?=
 =?us-ascii?Q?9ux+PcpmidM3MbiAwgEZFSvqLowha0wBWP3O/Cuy6QqYd7BF8kVhzNFYlmyZ?=
 =?us-ascii?Q?sdwtiVWO3p2P54zivzo2xIaFIiApR/ety4bhpVAJS1LpUmxDstlo895Z4KHJ?=
 =?us-ascii?Q?wjDCOV3YXqC5lW47kjAIT4QRgwF5Q4FqJmoHdionwRGzx4H6tXZWlt0X7RTc?=
 =?us-ascii?Q?klCvc7yZbxpqQHEiogeUgkSOjL5fMc0pc/Kgi34i3DBaSswfJ5/goRZtjCDj?=
 =?us-ascii?Q?iDfhhyQ7XEpmE6HkdUdNMcBEtbm4/c6tDNp7zEvwT8d8y2I7L5TsMinKkGsb?=
 =?us-ascii?Q?0ByWz0VoJdEULPrXYRbLP/GAnAA8HAVRJtKGy9r4KLEqRpJYD7GwqCq8Wr7a?=
 =?us-ascii?Q?6anAI17yE2O5FHUKN4kUEJlKHLCGwRnv12Yi3IqyFouoqPwHxYUptglKbHY1?=
 =?us-ascii?Q?JmWHGIQeARLcA15CqXLvtXQVTtxlnekAtMBFi/8kUQWqgKgcF8OYQGUwtZCO?=
 =?us-ascii?Q?9JfXoj2UMEGw4jim+0b2fqZX23yhgjtvNfLhTEwXPQdsRhE4rgVZJa3hCYSz?=
 =?us-ascii?Q?fci4i6XrpHReKpPeVT4Q0AYWepn8ZmEhF1q5D0K1MLLOg2SE/m2AkILXDo5X?=
 =?us-ascii?Q?O3HaRSOjBVFIuQNvRhxJZ069Mn0bDfRE6mCy75Oe++iUwvkG2egc827utSs7?=
 =?us-ascii?Q?B5twD/1XaWbgenzH9SVt+fk7tpOY5WWOb79L3g6up+6Z8BKHiEGShs3S5U6M?=
 =?us-ascii?Q?JH++86PLdeBTTbYJdraHtT/3kB5AbRbOSJHdz7N8+zRxhb2tqgAg6AjgOjYf?=
 =?us-ascii?Q?Tw8P03EW8BnD+vBjHOyJmUbdgc4TD3wsXPzM0ZRGnPOp7NZqlWfKFOCU4Wrl?=
 =?us-ascii?Q?EdQS3T1hHW2W8T8jwYJGYel5JHCux6vY0/o42go3aRwoZ+a4YeLoWC4JEAgn?=
 =?us-ascii?Q?WH/NAuiWlvh5STejVTLYyulkAR/z2yNRuM5ucMHazJaqO5Znc59G0z9llxgc?=
 =?us-ascii?Q?nBr1sdgxtix+Jn3KA5j/Y0oYGoioOOjnOvNgLfbTO+zOiQijdNUn62Z6YP0l?=
 =?us-ascii?Q?zma1C1lU5IN/cnCR28IG8EYjRcM/qIXy50UUeFY65gSFP4+ZvEKN4sOzOgQA?=
 =?us-ascii?Q?4i/LyHzJWsS4KRhntFEDjNt+DjDL8NizzGPhLtJ3Qat1DGPUg18m9diOL648?=
 =?us-ascii?Q?NjweH6Sv8aMBgxmYgbXHR9HT9rESursizQ/PepxDasr7Fi14Yy/xi75y/Skx?=
 =?us-ascii?Q?WDSekQWJD6vFS5/9M6IKSMwKrXfhXq5UoHh/kOx0d7XosfrBbXlPH7CoPHNf?=
 =?us-ascii?Q?zYwwlQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f4a002-d915-4cbf-77b0-08d9f21b62cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:42:48.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gOoy001O8B5UoyblhgDRICiR4O6WXe2ePKYLAv4nwXAbcmVLtF5O3VLWfLIEldGBgRwgdYnpD/EOOUOUoa7nejNrOI6bQVTUInoQuQM9Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3240
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170062
X-Proofpoint-ORIG-GUID: 8se6gzxDkBTulXpEPDLsc51kP4tfiW62
X-Proofpoint-GUID: 8se6gzxDkBTulXpEPDLsc51kP4tfiW62
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d567f5db412ed52de0b3b3efca4a451263de6108
commit: 8afa13a0583f94c14607e3041c02f068ac8fb628 drm/vmwgfx: Implement DRIVER_GEM
config: i386-randconfig-m021-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151635.DiGY2FPj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:1177 vmw_translate_mob_ptr() warn: passing zero to 'PTR_ERR'
drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:1231 vmw_translate_guest_ptr() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +1177 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c

ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1163  static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1164  				 struct vmw_sw_context *sw_context,
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1165  				 SVGAMobId *id,
f1d34bfd70b1b4 Thomas Hellstrom  2018-06-19  1166  				 struct vmw_buffer_object **vmw_bo_p)
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1167  {
b139d43dacef68 Thomas Hellstrom  2018-09-26  1168  	struct vmw_buffer_object *vmw_bo;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1169  	uint32_t handle = *id;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1170  	struct vmw_relocation *reloc;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1171  	int ret;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1172  
b139d43dacef68 Thomas Hellstrom  2018-09-26  1173  	vmw_validation_preload_bo(sw_context->ctx);
8afa13a0583f94 Zack Rusin        2021-12-06  1174  	vmw_bo = vmw_user_bo_noref_lookup(sw_context->filp, handle);
8afa13a0583f94 Zack Rusin        2021-12-06  1175  	if (IS_ERR_OR_NULL(vmw_bo)) {

Originally this was just IS_ERR(vmw_bo) and that's the correct check.
When a function returns both error pointers and NULL the NULL means that
there isn't an error but the feature is optional and has been
deliberately disabled.

vmw_user_bo_noref_lookup() is not optional.

5724f899ed8265 Deepak Rawat      2019-02-11  1176  		VMW_DEBUG_USER("Could not find or use MOB buffer.\n");
b139d43dacef68 Thomas Hellstrom  2018-09-26 @1177  		return PTR_ERR(vmw_bo);

If vmw_user_bo_noref_lookup() were optional then this returns
PTR_ERR(NULL) which is success.  Returning success here leads to a crash
in the caller because *vmw_bo_p is not initialized.

ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1178  	}
b139d43dacef68 Thomas Hellstrom  2018-09-26  1179  	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo, true, false);
8afa13a0583f94 Zack Rusin        2021-12-06  1180  	ttm_bo_put(&vmw_bo->base);
b139d43dacef68 Thomas Hellstrom  2018-09-26  1181  	if (unlikely(ret != 0))
b139d43dacef68 Thomas Hellstrom  2018-09-26  1182  		return ret;
b139d43dacef68 Thomas Hellstrom  2018-09-26  1183  
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1184  	reloc = vmw_validation_mem_alloc(sw_context->ctx, sizeof(*reloc));
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1185  	if (!reloc)
b139d43dacef68 Thomas Hellstrom  2018-09-26  1186  		return -ENOMEM;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1187  
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1188  	reloc->mob_loc = id;
9c079b8ce8bf8e Thomas Hellstrom  2018-09-26  1189  	reloc->vbo = vmw_bo;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1190  
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1191  	*vmw_bo_p = vmw_bo;
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1192  	list_add_tail(&reloc->head, &sw_context->bo_relocations);
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1193  
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1194  	return 0;
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1195  }
ddcda24e3bec1d Thomas Hellstrom  2012-11-21  1196  
e2fa3a76839ada Thomas Hellstrom  2011-10-04  1197  /**
2cd80dbd35518d Zack Rusin        2021-05-05  1198   * vmw_translate_guest_ptr - Prepare to translate a user-space buffer handle
680360a4d3f695 Deepak Rawat      2019-02-13  1199   * to a valid SVGAGuestPtr
e2fa3a76839ada Thomas Hellstrom  2011-10-04  1200   *
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1201   * @dev_priv: Pointer to a device private structure.
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1202   * @sw_context: The software context used for this command batch validation.
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1203   * @ptr: Pointer to the user-space handle to be translated.
680360a4d3f695 Deepak Rawat      2019-02-13  1204   * @vmw_bo_p: Points to a location that, on successful return will carry a
680360a4d3f695 Deepak Rawat      2019-02-13  1205   * non-reference-counted pointer to the DMA buffer identified by the user-space
680360a4d3f695 Deepak Rawat      2019-02-13  1206   * handle in @id.
e2fa3a76839ada Thomas Hellstrom  2011-10-04  1207   *
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1208   * This function saves information needed to translate a user-space buffer
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1209   * handle to a valid SVGAGuestPtr. The translation does not take place
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1210   * immediately, but during a call to vmw_apply_relocations().
680360a4d3f695 Deepak Rawat      2019-02-13  1211   *
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1212   * This function builds a relocation list and a list of buffers to validate.
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1213   * The former needs to be freed using either vmw_apply_relocations() or
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1214   * vmw_free_relocations(). The latter needs to be freed using
c0951b797e7d0f Thomas Hellstrom  2012-11-20  1215   * vmw_clear_validations.
e2fa3a76839ada Thomas Hellstrom  2011-10-04  1216   */
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1217  static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1218  				   struct vmw_sw_context *sw_context,
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1219  				   SVGAGuestPtr *ptr,
f1d34bfd70b1b4 Thomas Hellstrom  2018-06-19  1220  				   struct vmw_buffer_object **vmw_bo_p)
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1221  {
b139d43dacef68 Thomas Hellstrom  2018-09-26  1222  	struct vmw_buffer_object *vmw_bo;
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1223  	uint32_t handle = ptr->gmrId;
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1224  	struct vmw_relocation *reloc;
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1225  	int ret;
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1226  
b139d43dacef68 Thomas Hellstrom  2018-09-26  1227  	vmw_validation_preload_bo(sw_context->ctx);
8afa13a0583f94 Zack Rusin        2021-12-06  1228  	vmw_bo = vmw_user_bo_noref_lookup(sw_context->filp, handle);
8afa13a0583f94 Zack Rusin        2021-12-06  1229  	if (IS_ERR_OR_NULL(vmw_bo)) {

Same.

5724f899ed8265 Deepak Rawat      2019-02-11  1230  		VMW_DEBUG_USER("Could not find or use GMR region.\n");
b139d43dacef68 Thomas Hellstrom  2018-09-26 @1231  		return PTR_ERR(vmw_bo);
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1232  	}
b139d43dacef68 Thomas Hellstrom  2018-09-26  1233  	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo, false, false);
8afa13a0583f94 Zack Rusin        2021-12-06  1234  	ttm_bo_put(&vmw_bo->base);
b139d43dacef68 Thomas Hellstrom  2018-09-26  1235  	if (unlikely(ret != 0))
b139d43dacef68 Thomas Hellstrom  2018-09-26  1236  		return ret;
b139d43dacef68 Thomas Hellstrom  2018-09-26  1237  
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1238  	reloc = vmw_validation_mem_alloc(sw_context->ctx, sizeof(*reloc));
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1239  	if (!reloc)
b139d43dacef68 Thomas Hellstrom  2018-09-26  1240  		return -ENOMEM;
fb1d9738ca053e Jakob Bornecrantz 2009-12-10  1241  
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1242  	reloc->location = ptr;
9c079b8ce8bf8e Thomas Hellstrom  2018-09-26  1243  	reloc->vbo = vmw_bo;
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1244  	*vmw_bo_p = vmw_bo;
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1245  	list_add_tail(&reloc->head, &sw_context->bo_relocations);
fc18afcf5fb2d8 Thomas Hellstrom  2018-09-26  1246  
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1247  	return 0;
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1248  }
4e4ddd47774313 Thomas Hellstrom  2010-02-21  1249  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

