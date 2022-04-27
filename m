Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38877511A69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiD0N2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiD0N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:28:17 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B36C38BE3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:25:04 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCPLrZ017559;
        Wed, 27 Apr 2022 13:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=JRJCZtH6qMeSKa7OLSmp8K7hCK5bTbzmASvapFFflaM=;
 b=dwTXYEHxoF4Z2bKwxvQLKY9nFG2/g6IitdSmRUQbTb8SRiG3cJo2GOfFWgHePEMlQSOK
 lXXfwfQ3yjRn8MWAvZnhfVgO2NlYdV1Y4oNhdCbvjji44Xo7cL1KI30dF5hcDcMASc5T
 IqRGxwY3tK050nR/zQHx4jCFkSojkgLKfkvfl1O0BLT0siJ3P965bsqAOxUm0Lp+38y4
 kwDp9XWXwXhfK5XmJW03hmIbgDUd4T4AWMQLUMpC6DaobXmlQWLe57BdVM6InJFinuvS
 gLzf0QE72YSSXAmPp8Sawc8aRA+lndeP7IuGNCXg0bq/ZcWfUfAI8jNtWiR8CowOukPZ TA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fprtcrgym-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 13:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAhE55iXcF3LSotgEEtLNusFdHLupBLPHLAqGzEmaC2kw58MSjmYNJsAIkM+7f+6CrxU2M9PX2YaOFTVAdScL8SE9CbyyY0M/o31NrpFoukgN+2aB8IZ583AAmeqpZ4oqXjnL8KmcQn1sU4hEsOI75viJ7eDT9IMqiqlZbjgtnF22zuN8FhtJmYtOHx24sRm/89QEHUFG/wfD6Sr9NB4D1AzJ4rqsdgI/NJRC3YVRuoSNahpqipyVWuVf+lp8rD/rwSwUnOVDdRzZsF9BT/IeAqL8y8rfHTpqlck7+SkA1SDFKAPefP0kbCaGbmI3uzhAWDh9MCsIBZ+52m3/V0Y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRJCZtH6qMeSKa7OLSmp8K7hCK5bTbzmASvapFFflaM=;
 b=SH4QJnFGQDLGua+sv98MNFI3A7wHPd81vG94joxOadAA9flooCwDzhUqDOR+mY4GlY8VBMzt6TRs7CUH5KziH+ykGBRXVRvzmd8qGfV8krV1pHs5WHgNDc91umRr4BwQUpspTo6CBIKbdYsHHkxY9AdBjclny3nH9D8Qj5gXvQj2RN872k0I1rzplBJ0CHNvCKhR8Po512X2dec6boDGjgrv4Xnv3uPfLL07wC6qPLtIRdMMOj6Pj5gRKZOQAgrk1hzEwRBUj87DkrZ6yO5/lvTUdKksCK4310szC5XKxM5kQZliHZy5Q7DAcxG0Mq/sk1ER2TsuZRTIGD1fNknyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 13:24:58 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:24:58 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>
Subject: [PATCH 2/3] cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
Date:   Wed, 27 Apr 2022 09:24:34 -0400
Message-Id: <20220427132436.12795-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220427132436.12795-1-paul.gortmaker@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7837869-b888-4459-2d83-08da28515365
X-MS-TrafficTypeDiagnostic: BN8PR11MB3650:EE_
X-Microsoft-Antispam-PRVS: <BN8PR11MB3650213625DBA465E0758B3483FA9@BN8PR11MB3650.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRLwtPRLDkNfFfxF6E1v+sSGW0QhAqR92/ggjIAIJapNEuCeJkGnu10ePfWOeQzHVK0n/9rC908RbMrQMh2kIMua0fKoVEbFHDKfGE275HSOC8cJ+RUfj2vBGOJ21rIoslM7mvAMIzy18Cu2rrksZkTPcLsF3zJq5SGfUe83eAzRQIuvkAB89q/9yQEw1zxw4SMrkGitSu3JN8h7znTNVecJSIQVeQ4xmlBXmvhTxTasML9Gyc4PaWFLM4SnJ/lDbYEbPmbL8joyenTZSTgn3bx1U5SZbX3oqgEBQ7L5k8NeIc9gcQZKS5ptkaCia56m95OBq9bQTpDUDNz8wCoF0FvhPiJeiamv8PvyhfYpenmsbWLTNh2LsKGERPpq51szwE3jyPVBhZuiF2UUtiFRIRSX2Kpa9FllEQC4v/HYyUkX8eOmpXN3eDVfwzHNcPIl9JYob2fSB+Oeolq7T3aTDRsCkHXxqNObHjaQuRcdtMmkGGrbtixvmlk5W8Xg6J7V4e5h6vVNMYl6MYoFxfSuKalqf8jsfNhq7MeZ9G+94+AeGANo4ViC7zvJ6YYjJ3IlqMX3xowusSaNIkmcLQ3YiSlZnp3t+OAQO8woXdc50OHaKPYS0m64VQzEY6RKVk2Lc4WXNh2corQ0jCDsU7xbWPypCpQefhlKWyr6ulE/5donfaJqnTyX3Cz9Tj/SBIdULWvxyx8lxmwSZy1DpEXRfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(1076003)(186003)(83380400001)(5660300002)(8936002)(4326008)(8676002)(36756003)(44832011)(2906002)(54906003)(6512007)(6486002)(52116002)(6666004)(6506007)(66476007)(66946007)(26005)(2616005)(66556008)(508600001)(6916009)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmENG6nRcUuz2M9q4kTik1EywmRH2RNlKh61y5R8vMlaeYIgjKS4L77QFxgR?=
 =?us-ascii?Q?d0ATEYE7/2eG9PHJsmrC3C0DKBRdsIiq+1Kzcu6yuRMRg/rVRxGM7Z5+ji22?=
 =?us-ascii?Q?ovbWVL7IpkDWu972PlnyNHQOv5bMCV7TPFuFCjqbqMOaJWNIsuTG+s6ArNDe?=
 =?us-ascii?Q?mAmnWgRsjZ55xqEiJs8KiDs8OhAL7KtDk3zIOeoZorss0GJJ9E/MWMRzSE+U?=
 =?us-ascii?Q?ZvAL7ybxpcBvSLw0nhx0ANSz+C7AiztlIdkA51s7tWlPoh+l5ZG/ACbmAocL?=
 =?us-ascii?Q?38CiffF91GTseGmCPJVDYoOAIaW75BIlSdkrYo5C/NgNYBfwNDnIGTAItVTi?=
 =?us-ascii?Q?ccOOq24hHkDkz4qpHB2IBBlcfvmaAqRSVRcs+7CAKkleG6ZfuzuVhVUGN7iN?=
 =?us-ascii?Q?sv62PEq7EdxZXAqleJD1bWMj6jhyhYboyc6w220SwDi32q7aqGV6qlnwwQQj?=
 =?us-ascii?Q?TFttiugYiCkkhHOZPOqPtxGTw2xy3YOKRbnEW5onONc5FNJdfGolWwue9s9w?=
 =?us-ascii?Q?DB9TICWN4qLhRtsXw952iDMIdCmxPDw9hWhJITiCMoAuGtdKRjg7fPC1KBz7?=
 =?us-ascii?Q?vqtC/IeSQ22yD6i5eJH76F+RCb5K6O0bBEnXZGcaXSWHxYzbXfGWYLryWVdK?=
 =?us-ascii?Q?UczDuQrQSi4sbQVu7q/wsrjd+VmRvE+EVAAD6maHmQPxkdr8jsQiggl4AeSX?=
 =?us-ascii?Q?fvdqGquD5hJvTal3JLEx3VBypZHacjpEwAtUqEjIuAkEO23XEwy4UxBQhEep?=
 =?us-ascii?Q?DpagJHczGJPkg6oXlDPQMBFdzF6NkTlimyaHpWpwseq2wF/PKlhvM6tkDH9N?=
 =?us-ascii?Q?OjV0yI6FoaKuvb3Iy/imcEds1Hbllvdz+QNJkL1/4ztS3EIxjT0X4QuB9zQF?=
 =?us-ascii?Q?Bsqnuw6o26vhn7ocEffzZJAyHrSV3vMt6xDSY2vA13Px+3HkUKyFZpzKuR4x?=
 =?us-ascii?Q?t3MRlyxcoTqgi7ju4tlb8FIZfvt5IypECXlbe8J7ZkvpKMwQrxxxzkwtezt8?=
 =?us-ascii?Q?U5LLphbkX6eV+5VNhyHEyedBkv6rX3GCNgHa4/dQVcBHV2S4aNKsGuVFE+9J?=
 =?us-ascii?Q?GZS7OGGKu/CsnNzUVzTRWvxmys2oXA+IsDx1BcoZAF9SsSv8kT4RlVF/9Ga8?=
 =?us-ascii?Q?DbDp07kamTwqoxudmpxDA3xhwgr49/zhNxehyPfVt8i97E9OtprNVtFntp+G?=
 =?us-ascii?Q?2sdz9ax90uMItOOVVfvvniUvii0pesfEwEnvfIHqUvPox0ZkplR+TqtMpIRD?=
 =?us-ascii?Q?aeFmlKKEqRs64oJ6Daaos+hAOJhjMZWN8VKxy2uvqN84R22QeIuoPQk5wzIe?=
 =?us-ascii?Q?vh89kgWkE/4Uf1Q5M5Zl1lzT0T7y2jCFxgexkWMtrELysgHkE0DaFaFKPwoV?=
 =?us-ascii?Q?YLn52VpvOi9x7aCLToA8mFQy37NVoVsVpKeTbmTfGYEzAlmZu9/cv9WYKCG5?=
 =?us-ascii?Q?uxn3RihPej/e/008CSJIkO+WBkdJMxoKQuH4AeXhB0kkRgc/wPSNi2s0Dfee?=
 =?us-ascii?Q?9+dHRVw46MPrJXPftcNkEyQmXiWvzqhrcCMGGxId2qsIQVvMeFWOvHHQgGST?=
 =?us-ascii?Q?VAon3uGP4gt7XPH/tBzHGj4TqzF0casmIdAQKDU2uYyDilVpr3t1SMy7aUA6?=
 =?us-ascii?Q?n7d6z15H8daHSpvmJz/R6c2PfqPbkQp958xZBWfN3j3frkHueVlIl5B508oC?=
 =?us-ascii?Q?nmt3hElr7r/g1XG0n4/vJ7iznfasVvKTwqgANTv/xDoDY4H6sSL80IOh4OmQ?=
 =?us-ascii?Q?tosm4qFxRCd2Uh8JNHUXCEnQ8Rk7Ud8=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7837869-b888-4459-2d83-08da28515365
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:24:58.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jsyQ0537jnAx+t2HKF9M05th+0emQQLhJmDVZFmoIqIVy6GwwaamuAzSYtLu4OJS6Kki0b+jUNbwI3h+UDjG0pXDEjpuZPsL52RgYMm0U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3650
X-Proofpoint-GUID: zQ-90LG54PYMID2kS9bXZWnjjkgB1ASU
X-Proofpoint-ORIG-GUID: zQ-90LG54PYMID2kS9bXZWnjjkgB1ASU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=698 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were only implemented by the IDE CD driver, which has since
been removed.  Given that nobody is likely to create new CD/DVD
hardware (and associated drivers) we can mark these appropriately.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Phillip Potter <phil@philpotter.co.uk>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/userspace-api/ioctl/cdrom.rst | 6 ++++++
 include/uapi/linux/cdrom.h                  | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
index 682948fc88a3..2ad91dbebd7c 100644
--- a/Documentation/userspace-api/ioctl/cdrom.rst
+++ b/Documentation/userspace-api/ioctl/cdrom.rst
@@ -718,6 +718,9 @@ CDROMPLAYBLK
 
 
 CDROMGETSPINDOWN
+	Obsolete, was ide-cd only
+
+
 	usage::
 
 	  char spindown;
@@ -736,6 +739,9 @@ CDROMGETSPINDOWN
 
 
 CDROMSETSPINDOWN
+	Obsolete, was ide-cd only
+
+
 	usage::
 
 	  char spindown
diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
index 804ff8d98f71..011e594e4a0d 100644
--- a/include/uapi/linux/cdrom.h
+++ b/include/uapi/linux/cdrom.h
@@ -103,7 +103,7 @@
 #define CDROMREADALL		0x5318	/* read all 2646 bytes */
 
 /* 
- * These ioctls are (now) only in ide-cd.c for controlling 
+ * These ioctls were only in (now removed) ide-cd.c for controlling
  * drive spindown time.  They should be implemented in the
  * Uniform driver, via generic packet commands, GPCMD_MODE_SELECT_10,
  * GPCMD_MODE_SENSE_10 and the GPMODE_POWER_PAGE...
-- 
2.33.0

