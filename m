Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7F53D11B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbiFCSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbiFCSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:00:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7559315
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx614IHoCt5cZT3Y7zL0FRkeOyUOxn3bxc1rIWbzZFq7mIjBfW7ewTLM2wN9E5Phoo5fipvwOPmYGwnnwp+G8/B9/oUG0N6cimewAhYr8UK7YsBmZ6kuOuu4ugHgHiaXSBC+4qHLMOZx1WhpV5BOiPHf9rSeV7thP+HgL0u8gY4N0Gn6onUxiHFYKWy1169yj7WRQumC0QoecDV0Ca/GPVdml5TfO476C2x2/XqXDyQcFBwys9uwnFWQNAV1Ly+2n3497KNpgV5YJyYxQED+671drJSkKWl4k+NfHRSWfl4+qANlwYERMAsdt6hBDM8Mw90Gt9Jgp7c633IwjmfCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rth+v5buyK7I6CCxR/0dKIfzlO2MBo0uJVIEu/fatJs=;
 b=STT1/xDt88Ad3sM85/pJCi5H1C4rP7i1EiYSMft6foPY0dSz2Q2OrROjaDwAPmM7BIyfrjxOEY5krEW1l8ptSw6CSYqmMLGyARbodazUQccSJM7AJ4O/roHCL7PIKcID1mFeVmbh0oSTnIILyCXbIImyHSkuqYELD0HQn3WeubdTFFWxhxKYTp9xnNqy3YiWS0eRXyqcDYf9hhIRNDasPc9qIeH9G5EEHt9wW+gTyxmdvQb5t583ILczdiWhT4BAu0MihBmS/ETQ4gQW1ug7lgZsTNwlZflStJOpMrl2/sL8sxsikwMZ9Na0axD2KsZGYfrR4Uo/cwrImCFi8fE2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rth+v5buyK7I6CCxR/0dKIfzlO2MBo0uJVIEu/fatJs=;
 b=BD0qYKsxOlQ+lNhbW7ZBYx9SYnVH2tBwIGbPGVUmQjb7hwgHIKHltFThBs/1+NSlnAc6ykamS4RY5Ix8cUnVd+8N6gZQ8rYdI7MuixMwCAoe/Gd59W4Rn013DOvXkovcq19RxXN0Nx3O9buYEQOQIujqFp0qe5vBUllPu4DQG0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3535.namprd21.prod.outlook.com (2603:10b6:208:3d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.7; Fri, 3 Jun
 2022 17:56:36 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%9]) with mapi id 15.20.5332.006; Fri, 3 Jun 2022
 17:56:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH v2 2/2] nvme: handle persistent internal error AER from NVMe controller
Date:   Fri,  3 Jun 2022 10:56:01 -0700
Message-Id: <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:303:6a::35) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cfb5de-06db-495c-9f0a-08da458a66d0
X-MS-TrafficTypeDiagnostic: MN0PR21MB3535:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB3535D8421A0FDA9CDF65D7A2D7A19@MN0PR21MB3535.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhWLA/JPe1bnExiym2kTeLjxk5foIcT+0tD9DiJoixnlyEehAOuwvaEKxOm9UybpWWQXHaBwZ3VuBIc/d4VVzsf9EgeGFjmqUkfHIqWC73xEn7H6MqNFAKBPOCUYVPeBwtqv3wiYX8rfryyOyLM4LukxNnDFvECa0lgMjs8L1Unxky2iVy0uJGYnL7YKiVTThHjAWvPyhIvozbeUk8OM/ufqymibzZ9lk7NCYvNzjjeHMiI74oazieBXcmLCqKV/QFK/i0sXlr1Tx2+6BmD1n/Xj4qL35hyvpyeKK34LM69pCr0f8yu20cLRNXdyRwx3ZZ3bMd1gbauXJpddOxoV3m890+Cs0hFC7BgjJGrZMSZFwFyBkRxBu+zbuJrmlQk+fMwR1VWIO6DW8V1p6jfqZgKrIr0t4xwxh0VHwT33cX7Wy5zTcRqqAqHQKktieNShT5sCdeFQdgD2sG3p5SemXl/42DWcS3FBJ3HT7GXL+9XLGHDviM4N5TxmMFC9ZCwTILYSWjjkXjoiZ6l9uISvcvY5cJ2akbTAr7IRr3+sjz9iq8MxCum8L3GMRlGsa/967DbPMtblUyD2NIy73jnocu/AoWbv+3wxeUvFtyc/RHHEqgzGTy8gDVWxVEh28ATZhcycqRhmIpVpWzzcpSYjfRXIq16hG7lJLZtX8XOn0RNFKLOyqIh/wxTC7Tnj2rybkq40wRSNsclWhrnq/E4ApeQrs5oS1LtYTnUS1GMPcN/2Hjjq90R24krgk+tDM97W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6506007)(6666004)(82950400001)(82960400001)(26005)(6512007)(36756003)(52116002)(5660300002)(508600001)(6486002)(2906002)(8936002)(186003)(38100700002)(83380400001)(38350700002)(10290500003)(316002)(107886003)(86362001)(2616005)(66946007)(66556008)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ebQU9ozdMoaVu9wjG+dc6mhQpmGz3PVCd+3A/qvHkpSsgi3pvnoRIb74VCN?=
 =?us-ascii?Q?90ujkwSvWagwEo5EJ51bIpmkV35+1wzRayJ+A679Fb8pp/kix7wPMFzrSJLn?=
 =?us-ascii?Q?91pkJpW01dLShZ3bNBa3ThJECpbTaugLAYMAkAe70udHIqExHRa5rceWgD4+?=
 =?us-ascii?Q?J2MTyK77Ig2HHMxNE+dVR4ngIMU8Dm99SGO8Mef9aEc8KpE0Vm90DbOFRSFr?=
 =?us-ascii?Q?D+oyeH61I63cptqcSmHLOLj8eQakuP6/uTlKb21gusvLDzRQ8Bd9cKfoeMXL?=
 =?us-ascii?Q?NlN1KitGFnYuYY+oCKIJDycj204/nkO4V/VMOdkk4j7x5pltPi4KN9bNiq+2?=
 =?us-ascii?Q?8dWPVJgQBsujK82zpM4sVyhBtp2C/xWlQK19i80VBFo9wdXD4va9BhWWirOe?=
 =?us-ascii?Q?MEZrBvuQbIqPPOM80sDI26oUOAqTnTq/J+wRRKh3cd/Hv/+2bS8NRW8pA7qw?=
 =?us-ascii?Q?MycM10epHlOmUCOdSYYntX8Ma5/rjrUXFC4+UJT8mUV7sXjijbGTgsjXt5Ch?=
 =?us-ascii?Q?3BONx6Jcz/x8WSTPWf531TNupUlg5NNcPNFTsUZtXAMV3xP0+slnm08yKnT0?=
 =?us-ascii?Q?CuiW2g6L1HzXmnlvhs68AdloupUVIxVGm7n3IU5s2Ka234750N0sdsZBP1ki?=
 =?us-ascii?Q?Hftgb/UpZO4oyqiny3rAV4UFoa5TW+UBctfOBMpgrNN8GO16NG0Vg5aUc7pY?=
 =?us-ascii?Q?VHxTs50ykT4dsFndy/WCzanAWpKhaA3Fs00c7fqsgTLHIUBQ6OIhPKl4A850?=
 =?us-ascii?Q?VmukLRCTkQ48h1m8fkRWfJhkTfIUNCMpn8QWb+UssiIT9s+JO2lS14tJawMb?=
 =?us-ascii?Q?sJiZRGldG5LE6Oil8ZE5yri7DdOHO9ObrCTkDkohXisdgi4qRvRJnx2bwQ/W?=
 =?us-ascii?Q?yKV79OucJcXJxfnw5VTAOy/PNfAvAea8UBtsxkMDFCK0FWDkiFs1w+gl7ztx?=
 =?us-ascii?Q?rEnaoZ4e0R9sAkXlDw00zFPwk+kX0VPgk7lp1OQMGWqv8mFSvZv9Xx1yrlQi?=
 =?us-ascii?Q?NSnBexabjOxijHovYOn+JR2Tzy05VoxOU3JnCK8irjDyt81qvTyADzA1oLJq?=
 =?us-ascii?Q?K3rhyQtEFrMOYbsqlqYbRDp5X7pKKZ1nEn/3UP4yH6NIr4EGaSNuK6iFyP5B?=
 =?us-ascii?Q?yGRvA58+0dyvNTC9eLm5mepScru2bu51a+iTThc7jk1O0qO/tje9R4pqXfvl?=
 =?us-ascii?Q?GJ4kiSQlJ0UqKR/T3WAgwg2G7NeEfh7vRHoqXEKSuyLBMf4ig7cG8OBypdDJ?=
 =?us-ascii?Q?EJQrNBdKYjBzOK6+l3+FGzGFbs/sOF4o8b1VlxhXrKQYP586tiqV7fmAvS8/?=
 =?us-ascii?Q?Hw33eZaZ55AUetE7k6TxfSelAr884CyMzxhl+aP6sQTD7O8/x3g/VgAuUtEi?=
 =?us-ascii?Q?lnqApdwmuzynraX59krubusdCd4dgB+c5Rj+zMfx3nAxFWVX595mUawbhbEc?=
 =?us-ascii?Q?GTPH5y6npwFHG5nOdYAlE6KzQftqZpBLU62ayVINl1L807kLgwr7G7h4JCc2?=
 =?us-ascii?Q?c1JHIyujCSenlSF8wrdobM5wTJlNhRYF5/D9bLv6TBAe+6EuuvYlunO59aT2?=
 =?us-ascii?Q?6YHJ10jYofWjIy5GHuhUoM3Ftt0bcaDMDqqviB0ytFBjS2heT93/9jk9xaym?=
 =?us-ascii?Q?e30yTrWsKZfyATzqN0B1gb6HA3etOLW+a67OB20JolNa506PSjUSEQe55K9z?=
 =?us-ascii?Q?aJFag4q/mYCSoy7z2xp8p3m5oMy7DxSPxFvS4FOgFmdG58XQ2QBD3Hbgsei3?=
 =?us-ascii?Q?8++l1ax5t46Xy4Q/mwDYtYiFI3abuWU=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cfb5de-06db-495c-9f0a-08da458a66d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 17:56:35.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmB15UMlXr1E8D/czo8btVDz4yY7DcZ8xEnIgZhxtY6DhrKgVU7Rz1lF/smrdAwfvMiO5OX0kZBXYyPl9q3J8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3535
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
doing a controller reset in response to a request timeout.

This new support was tested in a lab environment where we can
generate the persistent internal error on demand, and observe
both the Linux side and NVMe controller side to see that the
controller reset has been done.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/nvme.h     |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea9ed04..1169583 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4556,11 +4556,25 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	u32 csts;
+
+	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) != 0 ||
+	    nvme_should_reset(ctrl, csts)) {
+		dev_warn(ctrl->device, "resetting controller due to AER\n");
+		nvme_reset_ctrl(ctrl);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
 	u32 aer_type = result & 0x07;
+	u32 aer_subtype = (result & 0xff00) >> 8;
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
@@ -4570,6 +4584,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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

