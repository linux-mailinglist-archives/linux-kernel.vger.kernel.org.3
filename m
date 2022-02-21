Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E024BE67D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbiBURWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:22:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiBURWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:22:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CA6149
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:22:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LH5thD027339;
        Mon, 21 Feb 2022 17:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3GNZ4l9TmfPZUZnhOT9GVjWiefur+TzHB9VDLKPC/0Y=;
 b=PuNo0Nq0EPT2E3kU7hDxkQh2eGhSutvvHHr9EIyTnzUM+WepSOOmoiX5y+dfKRn0ILI2
 pzfRTh588tJX/nDznv5ZfgISV7ub/8N2h0uG0lCRKYAx8S3P/vcYAS5cYXJ25mMa/Vih
 jr/Vgg0uwiO82+AZJgqkquKHqlpHXdPHqMKIw+nWQm+f1ZMOcxte45/89FrzzKnchNE0
 8eQhv4HA1zNzaYI0GOf1NLmMQEw5L+Y8ubqVgAhYGA4NypGLc2cWz2CPqr/T7hDgssKc
 KWrHxG4Udx/Xo4Jg3FDzu/fKpG4RaAFiNUD4RVxeV/nfSf9QeWp21QlwDm/VpaOlDAyM aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eapye4pkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 17:22:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LHAnVt182016;
        Mon, 21 Feb 2022 17:22:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3eapkewd8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 17:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB+TUb6soRb7CpHY2d3wASpdObXMDrEaIXjIZzmQo4F+wr4+qR2Gs9ANaA129b8dThP9JVXH1fimFay9zt6H7yRX++RWFquE5myzxlXYSYPG7YQrhquU08c++zmUoYKjDGFSbc8ZDmIy43Adq7jwYpTx71GEq8UyL5usxLE1BD8tOZ6cJsrAbUiyEcMFiE3gcTjiQOvBr2mseigAukeDbwA0eVX7Bqu5+aXvj69Lw8AcIdvo4yNGxzDtVNoGXdI5mCFpbLEyxCP3JkTr5aatCekgriib/rA9DpoKYHk7Cxm2Q4HN6juA28hD57lgjfYeu2osofoxfcvEHBF1PrUOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GNZ4l9TmfPZUZnhOT9GVjWiefur+TzHB9VDLKPC/0Y=;
 b=PF04wRwB223wgSt3D2zatX4pqcitr1BatUk5LwmvlrO6/VSyIJnP9/cs1DtxW1+/FEk1FR2fUswjouvkZwIVMl9t5NOHjwWCsyVs/NLI6nfMqzxUzu7yDbzCAUAFmx1AlSqUcULOeGXN0HxIemJmccUMZuRNsMExcx/RlsV9Y3Z6WhZwAcwgb9Mn8RRGLB+pLlDRLWbU0yOksBoHkKaOeNQgrTbPWUsUeYJmPZX3RgiKNgoBhYxGVJYauvYDdB1RppAfD1rM6/6abbgtiAneP5ngKBYEwcmPR9zts4Be1o17NS/dMIs/S87R++yF3IO+qGRtKWZr+ykKHMW9qehL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GNZ4l9TmfPZUZnhOT9GVjWiefur+TzHB9VDLKPC/0Y=;
 b=yJCWEICBj9wZj1aGgaA85wf+V5VyR1NVLGzolXcGmlacIgGK3FlqGrR8xLkXfB/W3xISy2i2azztXqNaxdu+ZXFyiozp6fQG+ZI3Jkmi+A3nfZZy8xh2dc3GgeIMDKN+1e7SCHQF5LX2D0JUC4P0+cctlzJ5AWfMd9oWwDbf5Ig=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4620.namprd10.prod.outlook.com
 (2603:10b6:806:fb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 17:22:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 17:22:07 +0000
Date:   Mon, 21 Feb 2022 20:21:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jens Axboe <axboe@kernel.dk>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/perf-wip 5/17]
 drivers/md/bcache/util.c:256 bch_bio_map() error: uninitialized symbol
 'page'.
Message-ID: <202202212347.2BTScWAC-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0dd5697-3fd7-44ac-4baa-08d9f55eafc6
X-MS-TrafficTypeDiagnostic: SA2PR10MB4620:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46205B1918214878C58DD7648E3A9@SA2PR10MB4620.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvSnoquIcnTDx82ha7DPXQenTt2ua05mAhY6FbSSP96iXKAi9/m180O2cg+vxOWDxUj6SjlbzHfTfE+f3upSDphGhXScArzGCoK31aC1mcszPIKBzEwhYCEKCXexuSpOmWp17bPf8IN3YAexrDhHp9wKv49/ZHmLhlmdlp0tGsiPG+Eq8BKsYjZzjL4LriYPHzOAKECkMX/2tl0fJ4PgMz0on4iEDTeOm1WZABLwa9r6nIKDoOWvkuodhAcUKJ6fiJ0zpN8cItKtWiXKn5LHmjUfsp9P1O/X5blriz6L2WIog00eITih/8+duT6KYFlPCYlf5TNfeoKTTyOnllBPI+mKqdXG8GrqoVOZrmON8BvNuLibmqLMHpTJVo9Nb8Zq4M0FAVIsSkRtbQ2BfNfm4OXUIb39zglxVRvpHU3xRsR5RIxL8dJhzv7WzfpWAJr0ZzRbJWB/HGQL1az/R0HJFuFTkt6r1qk5GH47VYRNnfCXcYh8TfB8XhQzC2UUL1HPwrO7xXJePUCuvLoGCHjaqjkFQ8CBN4fonC1++9OpArwFN4azMAdrlUhz5EX0Yvg3Q4NmEFC0WBjHUhvl5ouK5TRJTogwXx75Bmu8+5pLkcw67kNqM1XS+Z4/yGSZSIRaB98iv+gfbbhXX1MmQyqkLgDRQgA0Y3D6hxD+QuJ7PH6JqekZS8twhI/2Yh2JHTZhkuk/IK6t9wf0btEtvEhKq3VaCjCeBvAyuCyXyE6PzVsJ3OefAnjLMqYFPmEPe1ZbKWyfPM//VZeTg4ZVEC9jmKMNYgTqXe6fDfZqvwrPJVTgirMJmR3b9wVhy1efneL8yggD3qmo4D0JtwUPp0v9NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(8676002)(4326008)(9686003)(6512007)(66476007)(6506007)(6916009)(966005)(66946007)(66556008)(508600001)(6486002)(316002)(52116002)(83380400001)(86362001)(1076003)(38100700002)(38350700002)(2906002)(186003)(26005)(5660300002)(44832011)(8936002)(4001150100001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Vn3xp8ZQdnIEqbG9+DGT43G40ii1E/DSn6QSjqNl/FhAhpt6OIQfpId4Y6/?=
 =?us-ascii?Q?FR3HLx/Z/P2qHySE826CNMCWg+/+J8JvMhONaY79iMTLv0BSPUPqWh5zExW9?=
 =?us-ascii?Q?ySqPz1xhFezMzCZLW+ccCuvLY72i6mLjQ5SGlpPYWh6M9A264Ag6vhnCmSgR?=
 =?us-ascii?Q?Ol0E3TbXfaI9IXKd3xSHRJGKg9ebJvbqmRTHIFcejCfP6R40Ub8byV7fgGVH?=
 =?us-ascii?Q?3f2Fo06i4wGUUCMmdFekvYEUTwbMcRGD0/vYaCNNz6bzo28uwjOU2pJrB3Pp?=
 =?us-ascii?Q?x88pdqBrH4y0G7L0+qnnTqbRJRvFH/RkH5Q7IVYDJJEd2kEbN7gEWIH4kyjq?=
 =?us-ascii?Q?ecSliHxcaRdTJ/wQMI5Np8AOD78YqTDW74I26JTXSJT3oWXZ02J5g/oQyMpg?=
 =?us-ascii?Q?MTayi1lqF/cVwyCS8lP+TLmHkxuuCdQ6KN3QeCcZiJ4WZTShqSrOE0afupra?=
 =?us-ascii?Q?ui6VMENZiV9PnRIboDBJXqGQX9k8ijbelTPMGKg2u7eNHyddyCFpIPt6Q50d?=
 =?us-ascii?Q?Dy5ItL0WZUNy5T6HnS0oWEPI4o5ztjquBZL+tMG1AagEOPkdCtY15Xuz4B3U?=
 =?us-ascii?Q?JsmWsfgxpdfnpLXHTxB8+NbrK2wgMDrC5MYqvZIaTQbAcNGt0WgSxbxTeBT0?=
 =?us-ascii?Q?LGM6XxShVheUbRyJVFfDfEELWHaBcLv9hBpX3bG4eTLtGWYbfOM+4cX20qVE?=
 =?us-ascii?Q?LRznQIQMNO/3NAmIhIidLULSSBYmH4VLpXZ1JoxpXerVxWhJBymynsFmZrAJ?=
 =?us-ascii?Q?Rjhf0QglxFdiGiAikrhc6jNbGHkAuG3nyDORKQ1MA5cI4itvT/PeXOpGh617?=
 =?us-ascii?Q?/wP/AqkRuFLE1yxfMbKQWfL2EBT34Pu/v6uFxBwfl3gTkvDEabluFoNCfuyj?=
 =?us-ascii?Q?2tyT7IM+nyV1F8tzaGl2+qq07DzVnZ0OgA6Mjg6+HFYji3p++jS2GZ8HfZ5j?=
 =?us-ascii?Q?AJG5MiiNIPMyi1AA4vNIwM5B1my6Um0FQCfWUXRtl1fzp75A4/G97NyOvq7V?=
 =?us-ascii?Q?vqG3dlAYU8wNw3ZbkhngNjloGW+SDDkJhSvjEdRxQorX9sHVU3ygVdEpgXUm?=
 =?us-ascii?Q?BB93i2cYtfeJWI8pqQlIwCijaSnfOk0NagIK1khk0ehNzb6eT+5Ko7THo+jm?=
 =?us-ascii?Q?gVa1FccktaFAgxjWMv9O5eSiiHLn+mE+QxRIQ8U0J38bcbR9XGVIaW46ILa9?=
 =?us-ascii?Q?T8tZYOpBk4vDSJpL+hjJhEVboDGfLGx4/zhqFWYNgKHZv7xc/yXXtmCM8bKH?=
 =?us-ascii?Q?hMgnl3lA2R3ya6EGAuSpDUXQd0FylOT1CX+fzyYACKGdrpywybeoYVLjyLDI?=
 =?us-ascii?Q?s8ALoAnGGgqS8+m5hRwH7vYglJflvPT1uQJP5r8YEPgeo4No5/uHskeOROyB?=
 =?us-ascii?Q?6JFkgmSocDtcnjw+Q/fewiX3Wx1VbWkyPFcMvh5K9zmwJflRMqrp8Q6MZPsf?=
 =?us-ascii?Q?CYIByJbdKohD9TZ/BKpcoHrodxog18ukNcL5l4ZMGnSuBJJr6blsFz2JJycu?=
 =?us-ascii?Q?tr8kFl7yFaXd2DQlQN0QD+/1Deikos3F3Iq4e1bSk/GBATMwQLmP+69JIrOD?=
 =?us-ascii?Q?S5jjBguyzvK+LAYMzPNBhlAu2cU0fF1BmLAsy5WRsY3E+GB5BYG3UdEishFH?=
 =?us-ascii?Q?ip62lb5Xa6A2d1O8WmZ5Eto/Ibqksp7W2fUJdGrYeZQQAc/oNacMFGX7sNJZ?=
 =?us-ascii?Q?IZrHWw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dd5697-3fd7-44ac-4baa-08d9f55eafc6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 17:22:07.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkCRxm5H2N99U0aVZ3bBx0WmW0ZJpywiZ43wxX2xNHAR3LT2E15uiIs3zyQy+5gWCVmrjj3fUfnKKvt8BE67VpxAKnRQb9hDQn7G2QGf8rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4620
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210102
X-Proofpoint-ORIG-GUID: eM9yw8dxz9yWJGlRHoZx3sVCe8fwrP9_
X-Proofpoint-GUID: eM9yw8dxz9yWJGlRHoZx3sVCe8fwrP9_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/perf-wip
head:   653193284c45da1c727d45de716d9b48b1019e66
commit: 97f573494a3c088d6e249ddccdbb238b3ea267e0 [5/17] block: add bvec_set_page() helper
config: arm-randconfig-m031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202212347.2BTScWAC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/md/bcache/util.c:256 bch_bio_map() error: uninitialized symbol 'page'.

vim +/page +256 drivers/md/bcache/util.c

169ef1cf6171d3 Kent Overstreet 2013-03-28  231  void bch_bio_map(struct bio *bio, void *base)
cafe563591446c Kent Overstreet 2013-03-23  232  {
4f024f3797c43c Kent Overstreet 2013-10-11  233  	size_t size = bio->bi_iter.bi_size;
cafe563591446c Kent Overstreet 2013-03-23  234  	struct bio_vec *bv = bio->bi_io_vec;
97f573494a3c08 Jens Axboe      2021-10-12  235  	unsigned int len, offset;
97f573494a3c08 Jens Axboe      2021-10-12  236  	struct page *page;
cafe563591446c Kent Overstreet 2013-03-23  237  
4f024f3797c43c Kent Overstreet 2013-10-11  238  	BUG_ON(!bio->bi_iter.bi_size);
cafe563591446c Kent Overstreet 2013-03-23  239  	BUG_ON(bio->bi_vcnt);
cafe563591446c Kent Overstreet 2013-03-23  240  
97f573494a3c08 Jens Axboe      2021-10-12  241  	offset = base ? offset_in_page(base) : 0;
cafe563591446c Kent Overstreet 2013-03-23  242  	goto start;
cafe563591446c Kent Overstreet 2013-03-23  243  
cafe563591446c Kent Overstreet 2013-03-23  244  	for (; size; bio->bi_vcnt++, bv++) {
97f573494a3c08 Jens Axboe      2021-10-12  245  		offset		= 0;
97f573494a3c08 Jens Axboe      2021-10-12  246  start:
97f573494a3c08 Jens Axboe      2021-10-12  247  		len		= min_t(size_t, PAGE_SIZE - offset, size);
cafe563591446c Kent Overstreet 2013-03-23  248  		if (base) {
97f573494a3c08 Jens Axboe      2021-10-12  249  			page = is_vmalloc_addr(base)
cafe563591446c Kent Overstreet 2013-03-23  250  				? vmalloc_to_page(base)
cafe563591446c Kent Overstreet 2013-03-23  251  				: virt_to_page(base);
cafe563591446c Kent Overstreet 2013-03-23  252  
97f573494a3c08 Jens Axboe      2021-10-12  253  			base += len;
cafe563591446c Kent Overstreet 2013-03-23  254  		}

No else path.

cafe563591446c Kent Overstreet 2013-03-23  255  
97f573494a3c08 Jens Axboe      2021-10-12 @256  		bvec_set_page(bv, page, len, offset);
                                                                                  ^^^^

97f573494a3c08 Jens Axboe      2021-10-12  257  		size -= len;
cafe563591446c Kent Overstreet 2013-03-23  258  	}
cafe563591446c Kent Overstreet 2013-03-23  259  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

