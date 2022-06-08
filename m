Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D257E543BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiFHSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiFHSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:53:04 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064016.outbound.protection.outlook.com [52.101.64.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED0194BD0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RestS3k63GLGj1zUerjoBnu1T4NudHWwqxsLHTld29/x/X+kb4eCOIrTNjlh7OwBaHpr0mSlBwK9L699LYdG5ZSl//1RAtHYvHQBv1tnHVi4citwEV/Fghc4N20UWaGaVQzzzh/SbL3Q0rA52WCp9WMGqKnQ2zaFfzhI9Tb3Gwbf79T8kiUoPAw+LhKPDNCQxSp/dFVP4dmLzjPGuEzq8Db5RzjQPuu95V0ssaT1acDw+hkCXWRqtI/hUuQQiX9o9JOIJTDNC6HseyMTs+4GpyVUQxeSP5Vm783jfhpLiZwTQ65RQ8fBa2acfmrWZgOchD8DaJ9NPthLEoR4z4xDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWn5ynMvbMgwxKoegzYYTqXbBIzZAh+q2o5xooYuJyk=;
 b=KW8UG0CXrxx4T+c+eOxD/uX1rYrPwS6bQOKv6cz5qAqSR02jqHKdso8yU2iyG1OzBUO91FCW0ejI2JMWynyAlDBEoEaiUWfOhTuDGasleqYF9uNWRzEgvH3z2ozBZMOFwq06e3CMMiN3AR28gOtAofdIeAy7KcKWvviK8DhCesjuWNdPc95UABuPIdCqhjVF4IYOrNFtPVPqavibqzsjVGCr9c6hj57G0+si8LMqvaMRJ6tamNJGU9sCQLeXVehQk+zAYkz0M8ZSjEpSrrX6j5ddfSdUqp9HaYl4ytWjq2eVV3bHTCNfoBLrGg/DlOl0LilKGAQYUHu1yQrQxOPiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWn5ynMvbMgwxKoegzYYTqXbBIzZAh+q2o5xooYuJyk=;
 b=BKJJ99IJxOxXLViUtywou5GqUuHscMuQJqUSThnReXsGG3u7xcB/zmiUBvMYAOsBrJGCLzxW4TSwxYKGh6NnIrs0wao1ZLUb3aA/bQwwJYxmMMXTFPyckq352TjyP4U/ke5Lmu9TDqFWBj1WuOSvL4FEwzVBbQx92khVs7JFiZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by IA1PR21MB3474.namprd21.prod.outlook.com (2603:10b6:208:3e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5; Wed, 8 Jun
 2022 18:53:00 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%8]) with mapi id 15.20.5353.001; Wed, 8 Jun 2022
 18:53:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH v4 1/1] nvme: handle persistent internal error AER from NVMe controller
Date:   Wed,  8 Jun 2022 11:52:21 -0700
Message-Id: <1654714341-41189-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:300:117::29) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4b90cd9-876f-4d50-9170-08da49801be9
X-MS-TrafficTypeDiagnostic: IA1PR21MB3474:EE_
X-Microsoft-Antispam-PRVS: <IA1PR21MB347439D5FB94915ECAA8989ED7A49@IA1PR21MB3474.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s33KYAq7wvQHHNki7cGu0dtN5ftkjm24+smqZmm51SyiKaUJX5+JpuE5SDmZU9UbPrwdDJUadB1nz2PQP4D0T9nJN5De0IC/NZ/cpJBh06g2LfBNLSlUAXAArJx1VnxgBYEm1mrPrR+mOndQ6fxynlsSdZ94zKPmVewYhHl9aZPqZ5+k+jUG8Y2gQc6QvZlGq3R+gzpMTvtaHOneWREbBNpCvjHmCZMjYAp/rVJEhxR4Q0MT8V4uByShhBxudPtP9e9HjnMtNBTRst22DWYB49TI+XwIR+4SwFd3Of9Y/079vyKhO0VAAzjXGWVtadGf3YiBHGvHaDuNOPFKxewtie7LJlPLjYqtx8mkmM+1j4pH5VfPvp5802bFrBXLIf2iKq9042qUFXjCUXr7BtmPuAqSSnZKpKZKbB8lJDp55OCq4iKZihT5QNwmvN/TfYzrTWDJfjlj8tVDE2WYOvaqqg80RtcIa2fEw7ISaSSQHqbDfR9e1kjtvm0Lb4StUn09gfXyCyTmKTEPZTV5duWLmciAq1Ga6vDOwucBK9nkcP2UA21jfwmRu0LJcd4QSOipMSY7TAGbeOCm4J6WZ13+nWF+BnzlTTgMm4RplDOuTfsSJB85K20BhtNtS7bZSk2bpF9FJlZswexDvNbKjlGlziN7hPIblKqQgVxX33c7PqXBi39L11ybYYkNXdMa2vSxJ07SXxVFpgf3GGON2pDv5Q02DoLYfcxpam3ySiuzFCi3sBlMdEiJOiY11PBxkKFH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66556008)(66476007)(107886003)(8676002)(186003)(4326008)(66946007)(10290500003)(2616005)(36756003)(6512007)(26005)(6666004)(83380400001)(6506007)(52116002)(38100700002)(86362001)(38350700002)(2906002)(6486002)(316002)(82960400001)(82950400001)(8936002)(508600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYHMxl1AEZyL7SJ/dHr/v1DPd0ndLQjk7B1DaiARAg+pIuiDybPpJ2k0x5nN?=
 =?us-ascii?Q?RfTxeZ7SEY5TcW/87p5AGB/djxpDXLRORfApthl9F6fsoIfnaIP108mN+YeO?=
 =?us-ascii?Q?1dRGGdD+A0Ger7HOrfbw7OPhQKUBtpqQ6NTaHQXxwlF3XymULaWi59/wDDOq?=
 =?us-ascii?Q?emci0MiYKgghhCSZ79mSG9Ov4Iiruw6O5tgjrSjOMpzI7c11w4y/wWteg+Po?=
 =?us-ascii?Q?FshhojpnKX7bsDjaYzn/QOWN8o6sjM4gDblzwynqTod4G+aPvvsgQOciSKAV?=
 =?us-ascii?Q?CC1Fd3xmh3EWBI+Yf1jXYKz6KitnMiDSw/M8XodF5S83C34qLJn5yi8+Kyi8?=
 =?us-ascii?Q?nRXL7rw1P61ARucxkaqXMMSt1/k/Xb1xPJl68A/o39JP8npy1WrfbY6Yq8ZG?=
 =?us-ascii?Q?Kj1CZ2OsaNvcuEviVuQPVmV710VaK/rK7OYFxSxBw084WzHO3Cmo0mdduPdf?=
 =?us-ascii?Q?RB+4zBAzsJLAmC8x4S/xCHO/oK6W88Tl9yjrbOI2RQFmqyfQueNYdv/Nj+Mg?=
 =?us-ascii?Q?elw33JLRZ0VirxNQQpuEGEmX93sLcba9zwj0xiH+SB9kGU9p9qJ0P0RNPhfh?=
 =?us-ascii?Q?P0QsWuTM166eCtPKvaARSv1m10+/Ewc0ILcaoZkKSE7KZvc/2RfBaLJbjZDz?=
 =?us-ascii?Q?jSumxuUUMiSdVOWpR9TbEexEnC1QjTtrAqPj8OEOvLs2BlMafX7buRINzfi1?=
 =?us-ascii?Q?zWMF1XkRJpc/1qpGHkI6yT/nke4YfE6A3iqMiMSqWl3A7FrswvGvEfVYqpQF?=
 =?us-ascii?Q?DxR/dyNY213o9wuAX05ux4ppoEUB46B8AO/mzdmWjF1lsNR6VSKR1pamrj4r?=
 =?us-ascii?Q?QdAhqGN/9ni6FYnH7U5kG9TonX2O31zkgH+htdrmtBqLtoeHsK0Zwlh9Lnqd?=
 =?us-ascii?Q?i0nV4Vz59PCzcocyO6ITHF0MRZzlTCjd4Dq8sklQBjGiksBXiCwC2X9Zuk6s?=
 =?us-ascii?Q?okIDdoxJYNxa/PwWR+DR/NU7MvGT+1h5QH7BWViCck5/b26FKIbUZTTtBhX2?=
 =?us-ascii?Q?2C8/EGUaUPL+WHThrJ02V/WWQSybztoI5+TDEpC7RBB068cPZEqcvvtqpo1x?=
 =?us-ascii?Q?OORHn0iPiQno9FEAwEF/InWUW9XTuiBNaGkCpI+tomwbse7/hFlBTlNz84ls?=
 =?us-ascii?Q?iOOwqYsi79+0CFMIyzfthP+wbKo4/hZCBilL79WNbWm0vlwrLhHQZORxC+CU?=
 =?us-ascii?Q?ngH5n5skrcASf3L5XQXtaavgQwxfbi7kn07Xp6qn4JCA+qaGkOx0pOzayxlf?=
 =?us-ascii?Q?wlk+ledmqIF3s4XQ4h+OPW261FBf3t4RX1BqBMxS6DWkAXU6BGj7aB5VU4m4?=
 =?us-ascii?Q?N5B9scfJJvSopgYxsNhG6/BwgjPUTYwtTEQSYXdR1H+KAOGk5SwNwbMG+Poh?=
 =?us-ascii?Q?q5mjzIOkYphDN/+CVcDCntM1jU/2o0xycaz4IlTQCgwq4SmgDS2LY4IIXnbZ?=
 =?us-ascii?Q?+ANZghaP/0fTjfIgUZV9vCDDz+FRs542wO2b2znD7+a/IQIQFGzTwPBpeE/6?=
 =?us-ascii?Q?Z+sETHJOwPStoHkqk8x0+NKsa9tPaB9FfqppInSUrakOp0ld5MRZrc13tVlj?=
 =?us-ascii?Q?rVdlJu6KItQTiEIUs7yIc967DPj4tw/YZTfS4GDfGGy5PVHzPHY9AFO1GnHQ?=
 =?us-ascii?Q?yjtrexK8H10UOKhXVqTdobNERIAIBeuFDjoRpk35wMXDMp6q/sUHn5FkQs0i?=
 =?us-ascii?Q?PK3UyqZi3N8YaCKv5LR6ZUkwlayJbnp8vIFGqThxmsy2r0mWykGA3lKPOp9p?=
 =?us-ascii?Q?PNAxD+DSIqBJK5UbySz6cacfccrYGMU=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b90cd9-876f-4d50-9170-08da49801be9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 18:53:00.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLQfjoylytCGn6PuIjtZ8KNcxMYWXObw9F/ltX34Vyl5AivUHjdXZV1XBtxJRMKpMMUR77XVVNd20yi+QZtJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3474
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the NVM Express Revision 1.4 spec, Figure 145 describes possible
values for an AER with event type "Error" (value 000b). For a
Persistent Internal Error (value 03h), the host should perform a
controller reset.

Add support for this error using code that already exists for
doing a controller reset. As part of this support, introduce
two utility functions for parsing the AER type and subtype.

This new support was tested in a lab environment where we can
generate the persistent internal error on demand, and observe
both the Linux side and NVMe controller side to see that the
controller reset has been done.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
Changes since v3:
* Removed call to nvme_should_reset() and dropped the original
  patch 1/2 that moved nvme_should_reset() from pci.c to core.c
  [Christoph Hellwig]

Changes since v2:
* Instead of reading CSTS, use a constant value as input to
  nvme_should_reset() [Keith Busch]
* Introduce helper functions for parsing the AER result fields
  [Keith Busch]

 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++--
 include/linux/nvme.h     |  4 ++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c95..bb8c91e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4502,9 +4502,19 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
+static u32 nvme_aer_type(u32 result)
+{
+	return result & 0x7;
+}
+
+static u32 nvme_aer_subtype(u32 result)
+{
+	return (result & 0xff00) >> 8;
+}
+
 static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 {
-	u32 aer_notice_type = (result & 0xff00) >> 8;
+	u32 aer_notice_type = nvme_aer_subtype(result);
 
 	trace_nvme_async_event(ctrl, aer_notice_type);
 
@@ -4537,11 +4547,19 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
+	dev_warn(ctrl->device, "resetting controller due to AER\n");
+	nvme_reset_ctrl(ctrl);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aer_type = nvme_aer_type(result);
+	u32 aer_subtype = nvme_aer_subtype(result);
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
@@ -4551,6 +4569,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		/*
+		 * For a persistent internal error, don't run async_event_work
+		 * to submit a new AER. The controller reset will do it.
+		 */
+		if (aer_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aer_persistent_error(ctrl);
+			return;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3..8ced243 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -712,6 +712,10 @@ enum {
 };
 
 enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
+enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
-- 
1.8.3.1

