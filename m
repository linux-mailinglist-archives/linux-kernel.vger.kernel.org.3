Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A794AEAF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiBIHWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBIHW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:22:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E9FC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:22:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2196HLro013064;
        Wed, 9 Feb 2022 07:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=g4t2psBSd2U54mMKUtwwF3eA0jlgIfCIIdGMj8TlU8A=;
 b=tYxTTWwdcCdpf53yohxJ6/vLL3KcsBGHkpDWpbmyyoiBEgRI3RkGeicXtyTvnIT4tJoq
 jvLtnVdToT8c7ikD8bhAjlkrLolsha219Jz8771Asasyf8exyEIgbnpigHQV0CywBibj
 VtQIU6mByxazFvRucqnd6TwMffmAni1UuWAUA7zh3NW4Uv56BGm8q/2tBb+kDRv77zQv
 59DlQFASJgT3UmKWSjDHWtF4YLk63814RRumDs0gOty3XXZ5rXRWAEd+iY+g0VZqCwYW
 6FkyvaytnW0aJ2RFFCtLBw5tujc/FtyexGl+ojQiqfdV37ER6XO2WV2b0/MmzuVvGofH kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgkwyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:22:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2197LGXv140150;
        Wed, 9 Feb 2022 07:22:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3e1ec1vwn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:22:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+K/jOTmQxnF5FXieAyf7i3C8y5cI2O9mR7Ekfh+aZB3/MpPgrSeMRtQmX4KOl9skEah57vChGANPrhqsMpLimvTqvLxlGh2CML26I2Z8gXu3OntwYaVCMjCmNS9mYuusNJlarIndcP5NYO9YtISZcYZwHAuiOOmkYr8r04c+VQwL+iUeIlyVvB859wISYk8x7TzFIqy/cY4eDVF268pARxF999X9dAZ7bBVuA/4CFDE0cblv+CT+uCMUHeh6gUOCv9P4sYBR1bNd5HAj4Fd3YMnL/fzBj18PMbNYbbGJZq/0r1nuobLfCpP6SPd9x9sEAzhRzwen/cfE6yWSWCvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4t2psBSd2U54mMKUtwwF3eA0jlgIfCIIdGMj8TlU8A=;
 b=mOhfuqvMlxtWyd0ZylKC7Oe8zn/tSl9eZrlOpmga83l/aGr+plifHLss/A1gEs0E+qBvqKF/UR8GQnpeWoJLExXETS1Ndmd9P410Oa2/SlRK1d72lyStg+1Z+RpZudtL02wx76dyre+gtI2a5O53aQCz3Mfpq1cOZmMtu9M4wgxA+VJYZ3XK7UcGSGzcbGye6EpkGc0Dtlr836zQPBuKi+oSe9cEuzxrthAtpRrIDXdLKaZsivaOIXP/06hrqkI9c6y9EClwhjbz1Nt+5fx4Ubn0mWogI7YDScuJ55ae9wiUAHJ5/lTnn4rgvgpgCDs/Bj9BqQ5N7xBeKBmQv4hz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4t2psBSd2U54mMKUtwwF3eA0jlgIfCIIdGMj8TlU8A=;
 b=iK7Yk/HvR+/2YKi0FscS0T1gXhQF9xrLTQH7BbWCHaJ2Dk+Uv6DdnFTbVcR2GlWhWm+Lap9skSKrgGgup9Fd4uQITQ+GbKFXGuBZ0P3DY9obHy+AYVqvOJrIDPpdHHGcmxLXZaPfDHEzVIIZOkO8dphPBEmbKrDAElOpjD31k64=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3194.namprd10.prod.outlook.com
 (2603:10b6:5:1b0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 07:22:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 07:22:23 +0000
Date:   Wed, 9 Feb 2022 10:22:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mtd:spi-mem-ecc 14/29] drivers/mtd/nand/ecc-mxic.c:548
 mxic_ecc_prepare_io_req_external() error: uninitialized symbol 'ret'.
Message-ID: <202202090415.SS8TwwHj-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b297af22-700e-46d8-d41c-08d9eb9ceaa0
X-MS-TrafficTypeDiagnostic: DM6PR10MB3194:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB319484D4085A339A7446626D8E2E9@DM6PR10MB3194.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00RP7dg+wpBtmWbTCfpAuIj1dXaI57fZkb2PSTNlEWU/QYa3oJ7tXexcpsF0Q9jhMl4eeLeYAtRLFfiNgOvSLxRi5kAcdtTO/sYCd2OktsthH3cye+igINKsqsn6TgLIXaLgU8GpyxpcfGwW0Kn+qCk8xUOqgj1kiuIdG4h0ZD9TffToad5KUag1UlJFmu5s1jTJ/c9Fow01vio2hQ60cmaFTw16ppTprQRD2nh/CFJZpkW8DbpN+GFBnS6JjmVKCIdEfripkn7/pbhQKQhizZWMzsnejuE1hQ+3X4oQB4nMRHYiIr9mLv/qipC7pHr/COBAkCLkxgijkGQcdwmpn+uThwwzjH0O+OUrhkECgHgUYc7OtWEKxEvO2paezvT+xR0IA/7DzxOHZJmBfMmcRvtj5JnOpNjDVHHfHaoa147i5tm1KT+lleQTf9yOvLoM0j6d7MGZDoeGL5wZxpdB/7V0Ax3kRSzaiVhmy/rSTQ9xx2rbia7LMqJ+/T8V1VHNWCDta+5Qe5uByq7RUWe83UH9rYM3hFgPps1Wk7vsyE1GzX2vPCnDz8PZ6Oux12NBWkGjYT0ZgSZNTKUrAITjzh32UHA4vzeNqhGs1BV3TMosU6C3Q/OQzoC4RuZwTMg0k9jQG4VmHiP0QCWKHwFUzh4PfLbtiyKDobxNTzU9E4diCeASvi/72/nea4SEwZ7iTXLP2A5CpLO333ax3evdCtl0ZVOLJY/r1E/u+Gpr3LFxXlLRqi30k/0/Fr89RaF/X/G7WVmTldLzCcEY1xYrYkza18IsuCjedznfHG72taGUg7Ec0Oijvcdtj0yG6JfuvXfamjy6WhVgtNNuldrkNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(52116002)(5660300002)(44832011)(6486002)(508600001)(4326008)(36756003)(6666004)(6512007)(83380400001)(86362001)(2906002)(4001150100001)(6506007)(38100700002)(8936002)(6916009)(66476007)(316002)(8676002)(66556008)(66946007)(966005)(38350700002)(1076003)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcINlA32ELAPMjgF+66oxlRsDCqQxdYul3gx9swWkPVGHjM7dTIezuq2IvUm?=
 =?us-ascii?Q?gXZnlHX/Vhvj/CMAUe7q/drXZFSl5axkkmJbC94qD1u+i3Hqacl/apIFVGW+?=
 =?us-ascii?Q?P+semAww9HMJ27o8q4oScc3UU68gFh4564JxMFMj7VnupEZ9Lfz8lfcN8yBa?=
 =?us-ascii?Q?aJpUG4JAHbPG3k0QsoZ99Hny2/QdB503lH4PRyyFi/vuFekt9yikYr44Uhvx?=
 =?us-ascii?Q?UV9ZB5a6VbKzXfa9fBTSlqPsmahePPVxAYa/YsBGFDlawWMjlWGtSPluoUOm?=
 =?us-ascii?Q?GU66OzZCR6gOBXuK8ca6zWdco2kAyHbpPWzZiyKn8JsV0atgmgUOl4fCEC6R?=
 =?us-ascii?Q?2Vok368zG2YdBAg4MdR4VzAiFCDyEUQZqobqx6qFisleINNBqJtxwi9AXpTx?=
 =?us-ascii?Q?kM++TlH3WZtdFQgUjmu0I+NEW7u9J9RJnyMBmNoM2IbXUSOPf6sDf9NLeJKl?=
 =?us-ascii?Q?EcJdd7UXO3yzGGNyjr8y8Xoq+XzA2C8yFRZM5fdcLjPDP9qbPSppR9lN4bfH?=
 =?us-ascii?Q?Ze6qswNp57pUct8bz0sfQ0ysxMfh4poxyM5iDE4q/KIqOeY0SGJalHb99yu+?=
 =?us-ascii?Q?Qh/DSe4jE+R574jzGUrPvggquGX3E/RjkVELyRm0mswup3jC8Ow+t3KtoTEY?=
 =?us-ascii?Q?6WJx1FA938W5ch+6ecdXBAPBWual2Bh/dMa17HGaVplo2y/qD9fAonsaJqn+?=
 =?us-ascii?Q?PLzVw/yD9w8il4a642q+Oy1tg2cM89OlJ4GlkzSv9KzNObcOKKAwLCKGjbbm?=
 =?us-ascii?Q?KyPXIIvHQt/Vt2sJeBCdb6HwfF88imDWUCWvp+4mNjpvwyUKlB0o8EhXdJde?=
 =?us-ascii?Q?A2KpEYd3SbDAsKU98a7OizQp9KkJRyQY4wHM6bWKscBPWw6ho7nn3U2Ibixg?=
 =?us-ascii?Q?V99PzLP4x0MddoxjwL9XsgRx+qVqr8m/E5iNVR+P79rJJ7fiMM8MzFuC+CqQ?=
 =?us-ascii?Q?pnrvTL8KR/OwQI+K3kHt0rt7UVWC+dIroHg6t8mwJIFC82zp/GtvnBMNm6x/?=
 =?us-ascii?Q?lqSso8FcwfO4zQZtLsyq54nDEbc8v0L9o680cW8xUJj98SaON+izKJ/v89ln?=
 =?us-ascii?Q?CwoGfnJOUCoa/4IbhTv51hD5mlp05b+EmbQtxC44Cpb6U9bsf8RyQ5N9GEYt?=
 =?us-ascii?Q?FHIEtcWKVH2yNaaM/URqB3PU0qaEM7GoFnaFKSJwxqClQuoZqzHYAAlDSyqM?=
 =?us-ascii?Q?NOAC+x7i7z+1iInxzFcrxLcxwQ+Uhyd7/3BN+YWQBas2sR5JQW+rANtqwTav?=
 =?us-ascii?Q?4mkbnFiekN3/eyiovy26c0sdBakEGSQ5xYFrNg8faeglG4ja7mAvA0Rtz5us?=
 =?us-ascii?Q?sbEwuUXCwrwg4ro3hWiz63ETAYPaCoB51sVVovfJADrngB5yVHal90HJU8fN?=
 =?us-ascii?Q?Qxv0FM2kaGfmOphD3nKh1L/eBFEBRbGOLiBYPefOYC+zpFlaU5/quhAjlnKL?=
 =?us-ascii?Q?/wAdinUGiECK7niFQONSz1r5UERbuiTNNORVXr3GjOMvh3P8df950c9uXzj+?=
 =?us-ascii?Q?RP+LXWpxtn1WTk6Ocr9HjsEuFxq4kGnp2bj5HrzNz4Exl8Qid0uRhKCpoW5m?=
 =?us-ascii?Q?NCp4oDBEOKFUu89XBg5BgPY9TtMJrQhl5en75iu4J5qGltpRjSJHbwlzYaAo?=
 =?us-ascii?Q?5imhZMcbyKDTKv08ow/Zjhedx78fs862kig4VS0DIYGMJuuMXDfBC1pSr81y?=
 =?us-ascii?Q?4cB8rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b297af22-700e-46d8-d41c-08d9eb9ceaa0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:22:23.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTJesNTRtkKxlywlyT2IvVtU3W8iitz7H9kdbA5HqfWpnJirqKWnFjxDzfc1LNjHGbukN11B+NofbUSJtNS7bDiGxVvBSYqoQ+h8ZfJm9aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3194
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090050
X-Proofpoint-GUID: VRKn-IN-nsn62MvTP8NW8is-SmN8ZUCd
X-Proofpoint-ORIG-GUID: VRKn-IN-nsn62MvTP8NW8is-SmN8ZUCd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
head:   d6986e74ec6ee6a48ce9ee1d8051b2988d747558
commit: cfe5cf69e97267e9d1de65cc894b7a2310644a15 [14/29] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
config: x86_64-randconfig-m001-20220207 (https://download.01.org/0day-ci/archive/20220209/202202090415.SS8TwwHj-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/nand/ecc-mxic.c:548 mxic_ecc_prepare_io_req_external() error: uninitialized symbol 'ret'.

vim +/ret +548 drivers/mtd/nand/ecc-mxic.c

cfe5cf69e97267 Miquel Raynal 2021-12-16  494  static int mxic_ecc_prepare_io_req_external(struct nand_device *nand,
cfe5cf69e97267 Miquel Raynal 2021-12-16  495  					    struct nand_page_io_req *req)
cfe5cf69e97267 Miquel Raynal 2021-12-16  496  {
cfe5cf69e97267 Miquel Raynal 2021-12-16  497  	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
cfe5cf69e97267 Miquel Raynal 2021-12-16  498  	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
cfe5cf69e97267 Miquel Raynal 2021-12-16  499  	struct mtd_info *mtd = nanddev_to_mtd(nand);
cfe5cf69e97267 Miquel Raynal 2021-12-16  500  	int offset, nents, step, ret;
cfe5cf69e97267 Miquel Raynal 2021-12-16  501  
cfe5cf69e97267 Miquel Raynal 2021-12-16  502  	if (req->mode == MTD_OPS_RAW)
cfe5cf69e97267 Miquel Raynal 2021-12-16  503  		return 0;
cfe5cf69e97267 Miquel Raynal 2021-12-16  504  
cfe5cf69e97267 Miquel Raynal 2021-12-16  505  	nand_ecc_tweak_req(&ctx->req_ctx, req);
cfe5cf69e97267 Miquel Raynal 2021-12-16  506  	ctx->req = req;
cfe5cf69e97267 Miquel Raynal 2021-12-16  507  
cfe5cf69e97267 Miquel Raynal 2021-12-16  508  	if (req->type == NAND_PAGE_READ)
cfe5cf69e97267 Miquel Raynal 2021-12-16  509  		return 0;
cfe5cf69e97267 Miquel Raynal 2021-12-16  510  
cfe5cf69e97267 Miquel Raynal 2021-12-16  511  	mxic_ecc_add_room_in_oobbuf(ctx, ctx->oobwithstat,
cfe5cf69e97267 Miquel Raynal 2021-12-16  512  				    ctx->req->oobbuf.out);
cfe5cf69e97267 Miquel Raynal 2021-12-16  513  
cfe5cf69e97267 Miquel Raynal 2021-12-16  514  	sg_set_buf(&ctx->sg[0], req->databuf.out, req->datalen);
cfe5cf69e97267 Miquel Raynal 2021-12-16  515  	sg_set_buf(&ctx->sg[1], ctx->oobwithstat,
cfe5cf69e97267 Miquel Raynal 2021-12-16  516  		   req->ooblen + (ctx->steps * STAT_BYTES));
cfe5cf69e97267 Miquel Raynal 2021-12-16  517  
cfe5cf69e97267 Miquel Raynal 2021-12-16  518  	nents = dma_map_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
cfe5cf69e97267 Miquel Raynal 2021-12-16  519  	if (!nents)
cfe5cf69e97267 Miquel Raynal 2021-12-16  520  		return -EINVAL;
cfe5cf69e97267 Miquel Raynal 2021-12-16  521  
cfe5cf69e97267 Miquel Raynal 2021-12-16  522  	mutex_lock(&mxic->lock);
cfe5cf69e97267 Miquel Raynal 2021-12-16  523  
cfe5cf69e97267 Miquel Raynal 2021-12-16  524  	for (step = 0; step < ctx->steps; step++) {
cfe5cf69e97267 Miquel Raynal 2021-12-16  525  		writel(sg_dma_address(&ctx->sg[0]) + (step * ctx->data_step_sz),
cfe5cf69e97267 Miquel Raynal 2021-12-16  526  		       mxic->regs + SDMA_MAIN_ADDR);
cfe5cf69e97267 Miquel Raynal 2021-12-16  527  		writel(sg_dma_address(&ctx->sg[1]) + (step * (ctx->oob_step_sz + STAT_BYTES)),
cfe5cf69e97267 Miquel Raynal 2021-12-16  528  		       mxic->regs + SDMA_SPARE_ADDR);
cfe5cf69e97267 Miquel Raynal 2021-12-16  529  		ret = mxic_ecc_process_data(mxic, ctx->req->type);
cfe5cf69e97267 Miquel Raynal 2021-12-16  530  		if (ret)
cfe5cf69e97267 Miquel Raynal 2021-12-16  531  			break;
cfe5cf69e97267 Miquel Raynal 2021-12-16  532  	}
cfe5cf69e97267 Miquel Raynal 2021-12-16  533  
cfe5cf69e97267 Miquel Raynal 2021-12-16  534  	mutex_unlock(&mxic->lock);
cfe5cf69e97267 Miquel Raynal 2021-12-16  535  
cfe5cf69e97267 Miquel Raynal 2021-12-16  536  	dma_unmap_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
cfe5cf69e97267 Miquel Raynal 2021-12-16  537  

Smatch is complaining that ctx->steps might be zero.  I should probably
try to silence that kind of warning if the cross function DB has not
been built.  It tends to have false positives.

But shouldn't we have an if (ret) return ret; after this dma_unmap_sg()?
Can we really retrieve the calculated ECC bytes when processing the data
failed?

cfe5cf69e97267 Miquel Raynal 2021-12-16  538  	/* Retrieve the calculated ECC bytes */
cfe5cf69e97267 Miquel Raynal 2021-12-16  539  	for (step = 0; step < ctx->steps; step++) {
cfe5cf69e97267 Miquel Raynal 2021-12-16  540  		offset = ctx->meta_sz + (step * ctx->oob_step_sz);
cfe5cf69e97267 Miquel Raynal 2021-12-16  541  		mtd_ooblayout_get_eccbytes(mtd,
cfe5cf69e97267 Miquel Raynal 2021-12-16  542  					   (u8 *)ctx->req->oobbuf.out + offset,
cfe5cf69e97267 Miquel Raynal 2021-12-16  543  					   ctx->oobwithstat + (step * STAT_BYTES),
cfe5cf69e97267 Miquel Raynal 2021-12-16  544  					   step * ctx->parity_sz,
cfe5cf69e97267 Miquel Raynal 2021-12-16  545  					   ctx->parity_sz);
cfe5cf69e97267 Miquel Raynal 2021-12-16  546  	}
cfe5cf69e97267 Miquel Raynal 2021-12-16  547  
cfe5cf69e97267 Miquel Raynal 2021-12-16 @548  	return ret;
cfe5cf69e97267 Miquel Raynal 2021-12-16  549  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

