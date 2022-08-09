Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6458D50D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiHIH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiHIH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:59:22 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159D2183B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:59:13 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2797qMMh002087;
        Tue, 9 Aug 2022 00:58:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=0K1inhF9ritGrD6x0lZ5qSU5/vKqpuG+OcJP7dvH6h4=;
 b=jtryNhB4sPbPhlbW2UPR7xfjHybFKJpQTBbBhP4sVguFpjDXEy240cR46rp5Z+JFrroY
 KfNTywwbYbIqpvxsGI5zII8eG3EI/LTsy+iD/iJpKKpzRqTm3O8tpkQs/KPYWb+UYZJ+
 VxJv6cI1QmHgytjjPSiXGwTJufgOaJbcQLeJ7nme16+TqiH77yqsNfTqycHp1v9GmRng
 U3aMCT4mJ6+H9dKIK+0+IWlA2K8C7qlaDkkCNZyfoMk/sSoDeyt4Bb2qyIk6E7F6ATQF
 WRXi6zazqM4ldcgsW+RR1RR9EgvwMCT1h5z6TrEOh3mTauTJWiylBLiEyjUcG3THeJ6x xQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hsqtka3e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 00:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP6l+siI+k+FcCAX0ldRxRm+tGY68+wUPgapRb5Kj6o77k2X/tTHwC+JeLv5IQN2PLodK3h+aaBejX3Yl0CVzUSYO4WuNlYwWLyILUp/CV1sGL5ZfjTTUrdY/yZZ38Wx4bWhwPiT4Hyp2kkP1zRM4NdWX/S/3HkDOzI0RTo6KQtOpQ8YSZZqMVWtja0rox2hdGoVDZC1u4ugysSSkpPtYKFyG73rJqOzkci/2x7DAWqwVV36W2dAEqZDMmzXx8ZlFAfhmQh/YCmJ9jPRhZ9oUUuOX5+lYrodCq2beG3AO5iBZPBLtoaUBVC4AnF1aqSRAuMMDHoe45YJakVNIpTONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K1inhF9ritGrD6x0lZ5qSU5/vKqpuG+OcJP7dvH6h4=;
 b=hXHaFA5wKDYgwa/iME8v8GxPkM+7qDc4N4sEay43t1iCWt9LtF58tzXIKkzXd4MGMpzfYYcHbr8zcBKTIRiopXI+m3Ar644z5A2zopet1lDzzcKOhAH+PCvI2ma8BYLiL1Qx+6mSH4qOXdQiPgrBsXIvFe07gZ+OUDJa1TLD6n5jotJZZicgfmTtqq1HGYXjaEIF8jxfSE+kHYiCqaSYDgwAa45QxcfCcf9+l2Td7VWue2n8OqM+hNRn59jcWpaEJcuApN/Xwh5Qupx3LIs0NG+TuypGM4rObH+v9LGRSJm+r4NkRJ4BXPXMnj+zfvAMN089tWArIDWF0Bh4BliC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by DM5PR11MB2044.namprd11.prod.outlook.com (2603:10b6:3:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 9 Aug
 2022 07:58:10 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::d504:d329:815b:10ba%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 07:58:10 +0000
From:   Liwei Song <liwei.song@windriver.com>
To:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        ChristophHellwig <hch@lst.de>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei.song@windriver.com
Subject: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to blktrans_{open, release} to avoid race condition
Date:   Tue,  9 Aug 2022 15:57:53 +0800
Message-Id: <20220809075753.21950-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::9) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6b7d2c-f45e-4b30-0fee-08da79dce6be
X-MS-TrafficTypeDiagnostic: DM5PR11MB2044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9caTbQzD4qqbIE0axhkhWgnc9+JGQg5dGQ2BYTbjA0WpHvol/K0XnhgUJ3Gb8BD4/1w00iQ+O612FzsiNYTrlo0KhOgk8e0eHmMSfDFsci7YBW2/RfYJY/xseSsPyTquShSFX3dC7dsC0BYxbW5aPrAsuP5WI3fgk+EU+MO03WJ1SkGsO5pz6kd7dYjdXDrD3TvGKCyiCKeVaZztB5nyCQKJpwn/jstEmovMFHCqQxIrkArv+VKSaaf0MSJT5UbW6i3pSHUaNIIzYZGWWz75oW0g7slOKbxnHAkxJcFzIPe83CeivEiPtvZv8+1oYZn6gjF0WIVTlCxNS3DPAlSDisqS6ydc2B7viRKvBZqcZ7NsGGNut2Kk8v4+Le7XaNK75HIf2MW9Ld+IJA9mik4Y+bSiowMn8Z6s11+59mxztfp0basiiYyMGWf2qX4Q+xPL2b3Zl8oE5HaKCSIW2J6/4MF4ve3tnpZUDdJjjE+0w48OmnERUnnO991QWXMGzy/r9jQtBNQfFJuOd7MRcSS8gpLExwn0slYaCmkBzqDHI8mMtYpk2bgOPUB6bee/PAxAEs/QkzNCoWCVjXYI0r4scVlaFoJCPNv5ZOjFCt3nZ7e055gkP8sO/Te0EjUvIzw2BlAiEBX/UJ5y9JM3eyHpbWgBqvvMF89usP86/V4nK3dpb03be/zRwUYARawxQDpvvaygcTUNVM1SRaag/DVc/49RfNikTSZe4cdZy9jpUya+Z7Doa8e5WDQxzO+HTJVoe8tckY8rj7HF9Sh6jV2GJHWMtiGPfPTgPSRZnQzHdLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(396003)(346002)(366004)(376002)(107886003)(186003)(41300700001)(36756003)(8936002)(5660300002)(44832011)(1076003)(2616005)(83380400001)(4326008)(2906002)(86362001)(66556008)(66476007)(66946007)(38100700002)(38350700002)(6486002)(478600001)(316002)(52116002)(6506007)(110136005)(8676002)(6666004)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RqSMUoXLIhyQkRrINVuh0Y0mcCrPNAilHkqQvUfj8cABrTuOaWEPl0npDBl?=
 =?us-ascii?Q?PvRjtROO+8f4ylzclJEkpsrZtmuh2JFJLBYr1nkFi25ZiiUguOIiWV9AEXq2?=
 =?us-ascii?Q?18/PiXOZ9QbaSK90xukRi6XgRsaG3sf8LeStQxJ+UAib5+pSH9qbkNL0nogc?=
 =?us-ascii?Q?+ThXNjD/BoXkYXkSal/OwDip3NxjZaP3Waeo9tNmCNCbgAgnS6SjquW6Gz2w?=
 =?us-ascii?Q?c9QYhmdyK8SuKNUSaZvsrmDTBxF7B3JVuytl9EdxeSXOJT+5XruTvTxtdVNI?=
 =?us-ascii?Q?er1MQwl3OWI64Ox1prznt19WroAzLKGF/6NKlfdVpx1GXW4tD46WFFHTLv4k?=
 =?us-ascii?Q?3iHh5mWU6adYg3MNXY2NTpy5tCLYU340rczm74EcyD+9uI6MFTuFevMEmXLw?=
 =?us-ascii?Q?PWfsv79d8UqbMihTI+QLybw+xLisSP12P5VZ8G2Fi1UbWEhb4tFIywOhS8iY?=
 =?us-ascii?Q?JIjbh5Vqk+1AihcYHr5Uky7yoxCyLcsmvzEZzUqGzFOJyRllKzIPXr6Tk+RD?=
 =?us-ascii?Q?U4aiwo0X1mIjL2wB2ivUpLWojpgJkgEK4Pbpi7QsSnz10EwMpXLGQRgNoZMK?=
 =?us-ascii?Q?QGGwRyw9GyEUMLqNg7xQ33DwWla/wdbE3Qc5foBlMdtOIBfseoKTbhIXVFP3?=
 =?us-ascii?Q?t0CN5QTqlPndP4MkFNBRlkglevz/YIjYngicj5+jfjlLyuGDnu3qmp4fISlF?=
 =?us-ascii?Q?ZG6QwJzD4txFEqWjeX6iVoowGPvD+zxeDE6hVUzzTRMUCnZtV7+espvmrVo7?=
 =?us-ascii?Q?dKCEQJy+aQaM5XqhoHofn8qyJmo8gSa+QJ9cKBrkfm/pY1eWm6UCfYKuDc13?=
 =?us-ascii?Q?2TrjSz4uocY/nB32yGz5dxPEH0B1YZb35G6f7HRjKQGkfG6bXFrcOOjFljoE?=
 =?us-ascii?Q?IKOXYGs8tgCsW40gJXi143BTpIscPhQcRvB8CDF3NlS57pBcVq+8UtlswCOv?=
 =?us-ascii?Q?A2XrflQpcRz7qwsh34J/T4kIyrtG3Im026Ba6duMXeTHEugNwDydT+xvr0IB?=
 =?us-ascii?Q?7ONXciXpV6yCI4zdX/rNQaQzm59C1p5d+8Y16dwy/LVsPwcsYE9aDupUOvgd?=
 =?us-ascii?Q?1dXRbKMSU6grXHhgciOxMn+cVBxk2OmQbTpn6Zh2HMnbVBlgV0KyDTmjRr47?=
 =?us-ascii?Q?fU0gGeHV0QPqPmGE7hKfzn01YClaB7cYOEeDmi9Bl2BshoEIBKafEmEqxvhO?=
 =?us-ascii?Q?Vkm2alYZTWkQSkaV5AASVG8WZofV0VcEHibiJGhqdXSgeKw8HPo86ZcPc4zd?=
 =?us-ascii?Q?zkEUtI2dPu+dJxYe9a2eB1sh8FNLzHZvmh5duXxLWBTt5LXWHHBYzKM5+8vv?=
 =?us-ascii?Q?M4VxzKTcyvldkswNpnNy48Lt4RlhnpxlQq7UCBlW2mlvWJZY81eq7advkcmo?=
 =?us-ascii?Q?NUIbmrSWvzEppKU/x8HuwpNImQydSPqVbrUWUirJ6CAq5BdE5dqNG364FTIk?=
 =?us-ascii?Q?nLvUq4AbMMtiWuN1HFxNvCSZNfXTJGk7KtbHw3yiXLNQG4Ep2CeCaw+fBWx5?=
 =?us-ascii?Q?4XbWcW/9JlaYR+Uqp6lTq1diRLoe1zEkVTAX7l1oJbktkPKSzd6GnzInFnpF?=
 =?us-ascii?Q?3Lsr9xLr3Th/ToIU4/xYrQl9cYGZE/3BjoKjOG/5hFBjA8thBS+diPQH1sBN?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6b7d2c-f45e-4b30-0fee-08da79dce6be
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 07:58:10.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP9WHtLTnoPv159ZLutuc+xEV9GidR8DOGwai5xt5feuk/VNE55zGwU3YonsACE2joM54bfk0scoq1nyJx+CHiuo9YiFPN2MBkcgbcA5n8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2044
X-Proofpoint-GUID: MyUqBHXSJRrQF9pRy3WK0D8G5ICyPNbj
X-Proofpoint-ORIG-GUID: MyUqBHXSJRrQF9pRy3WK0D8G5ICyPNbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208090036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

without lock mtd_table_mutex in blktrans_{open, release}, there will
be a race condition when access devices /dev/mtd1 and /dev/mtdblock1
at the same time with a high frequency open and close test:

kernel BUG at drivers/mtd/mtdcore.c:1221!
lr : blktrans_release+0xb0/0x120
Call trace:
__put_mtd_device+0x4c/0x84
blktrans_release+0xb0/0x120
blkdev_put+0xd4/0x210
blkdev_close+0x34/0x50
__fput+0x8c/0x240
____fput+0x1c/0x30
task_work_run+0x98/00t_64_sync_handler+0xa4/0x130
el0t_64_sync+0x1a0/0x1a4

since the original purpose of commit 799ae31c58ae ("mtd_blkdevs:
don't hold del_mtd_blktrans_dev in blktrans_{open, release}") is
to fix a DEADLOCK issue, here convert mutex_lock to mutex_trylock
and return immediately if failed acquire mtd_table_mutex, then
both race condition and DEADLOCK can be avoided.

Fixes: 799ae31c58ae ("mtd_blkdevs: don't hold del_mtd_blktrans_dev in blktrans_{open, release}")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 drivers/mtd/mtd_blkdevs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index b8ae1ec14e17..147e4a11dfe4 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -188,6 +188,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 
 	kref_get(&dev->ref);
 
+	if (!mutex_trylock(&mtd_table_mutex))
+		return ret;
 	mutex_lock(&dev->lock);
 
 	if (dev->open)
@@ -212,6 +214,7 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 unlock:
 	dev->open++;
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	return ret;
 
 error_release:
@@ -220,6 +223,7 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 error_put:
 	module_put(dev->tr->owner);
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 }
@@ -228,6 +232,8 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 {
 	struct mtd_blktrans_dev *dev = disk->private_data;
 
+	if (!mutex_trylock(&mtd_table_mutex))
+		return;
 	mutex_lock(&dev->lock);
 
 	if (--dev->open)
@@ -242,6 +248,7 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	}
 unlock:
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 }
 
-- 
2.32.0

