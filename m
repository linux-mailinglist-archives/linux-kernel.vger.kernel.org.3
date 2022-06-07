Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0D53F2E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiFGAQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFGAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:15:57 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4472494C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFVTY2idADCTP9PB/J+ymqPDE/veoIhjZqMU1Ny72q+ZJ7H2C/4QwKQtZrffApTnbe5EW80TQASC1jwi3mOxoWiS09lIuvkjgp5wvX5agsvNJfB7O4Gbr0c4Kwd0cXKqgxfZgNz+KwjdkAFezK8UizLpHN+SkMtUWcBz4oxIf5ALFmBPQxCrD0nBeaWDpG/mwEyfJ/c6JWel8AjrWh7UMEBwjFsA7XZrnqRnKj3qFGchxz+i9C0xaP1QTtEzM9eXS6e/hvK44l8XyCRjreGg0LoLwgzlE2caxwiLV5ks95t/uKw2ggicCFQyKkR7xGoDw9gk0jihTXAWe25Lzkp9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFySTNDh1JtrVRAvdwiSI5NiV8GpJDlribV4iyb85DY=;
 b=Z8WwMiy26TjZ9l5QAQefccZ+i/GuDJ1D9SXMuvE5Ucg8bvUTdX2AOzAxvBFlXhfS5yWxiLcYsOk9jYqzKPrWZYHcL892qvtjq2azECaGIYiAZQpo20apqFkb03mnwdoQjL64pntqOyHFTi/daAuvLT0R2FH6TvurRxSuNGDW1dpacOr4K815vXP2XsffiHsSpC82wx84JA4RWE4O/zfJQVmnZmRf+Lq8gZ8Kt/oeGs2ZTEV0MGfaw3ziY8zptREtS9kMd+pLtlOA2LCdiN7H3bggx1HJO6UiQfAUYcmN8w1hZupqo5+EnnJD28ExkKQrQSUAq+7GF58NjgWWldq4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFySTNDh1JtrVRAvdwiSI5NiV8GpJDlribV4iyb85DY=;
 b=Zkr6MrBp/mp7secaK2kW3O3DKdqe0dX3ajT+InlAelaVj+d47IvSatEMY5b/9xUblkRpcVSczeRSOmjksi8G2Ln7T8oFAxPzAsdwIAtt3grUq4K/SG7opNuk54+MgVchqNI6KoQ7M6n7WwhKfn2DgPwljotTNHXkx3K7fUiGmEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3415.namprd21.prod.outlook.com (2603:10b6:208:3d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1; Tue, 7 Jun
 2022 00:15:53 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::810e:942d:9455:26f8%8]) with mapi id 15.20.5353.001; Tue, 7 Jun 2022
 00:15:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mikelley@microsoft.com, caroline.subramoney@microsoft.com,
        riwurd@microsoft.com, nathan.obr@microsoft.com
Subject: [PATCH v3 2/2] nvme: handle persistent internal error AER from NVMe controller
Date:   Mon,  6 Jun 2022 17:15:15 -0700
Message-Id: <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654560915-22449-1-git-send-email-mikelley@microsoft.com>
References: <1654560915-22449-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b4ba29-75a4-4e28-0375-08da481ae228
X-MS-TrafficTypeDiagnostic: MN0PR21MB3415:EE_
X-Microsoft-Antispam-PRVS: <MN0PR21MB3415B646708203F4181F0637D7A59@MN0PR21MB3415.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +r3nswAdqZjSh+ZKy9U4ABk/EVmY3jupgN0uFJytcafVwZFed82bc0D/2fPxqNniJ2q/bNKlroCUPNu8tikE3fWKXzZKPXtFRe1xEgY+o6NtDzpwXxnnmLcKsZ/W851EMvtd0LAtXY0JqKRDYmTQEHdXTFrirtZkE5PxI3P8FtM5a8ls01/O1eg2qT2eL2xmeb/3YC5fCedkbrrSBpSGWe5UDkofGe59ublrUjBaWXwtdAb6kNocieIFsqmIIKzCEsWLTC4rpTS1m5+pbCWdL7oeoByD1XDCZ8+hDhmRFy4hiSrcBhAiADpUhejWYnDCXAD/njJoSfUlO+eRB0wSlNpAhHz8UBsMvX3FC8Mumm6W0GfWi++YkHA4/HmaEwvo87ROK9P6Sxi9yuO/Zoed+S66rniHDrNUZ9xm8Skx3c9fKV3oXq8jeVUtJfavKmR1Q6PgaTvKdggwyr81+h5eOiVi9ktXasyrHv1+MwQvIo/aOIZRCkRC+TSjNNJZYcgAueR+xyFoEij0JawccwE1l2wZyVJ72drtrGCUYnpDs0m99kH03NExlPr6U0//3ljNPaiLfFK3nW9e75UbSHwpa6pcvwCeuIkObxzVzKI+QbAtsjUOnZR/61oWajq3stUlRd4iHQtBIMgVwYD3iumTJaElfiaqWFxKI36O52BBbLEhm398KybbN6MuxpTmZT9Z9fO44DJ8rFk+H+aEgylEiCKCH/OyMiOKLOAkyR8a1O3ZDa40hXizCA6zN0dJGjSd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(66556008)(8676002)(83380400001)(6666004)(66946007)(82950400001)(66476007)(82960400001)(2906002)(4326008)(52116002)(316002)(10290500003)(26005)(508600001)(6506007)(36756003)(6486002)(186003)(107886003)(2616005)(86362001)(5660300002)(6512007)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5J9CmlRS2xMLB/T/Com7WuH796mgqsTSP6V6zvNtoqflIHPzlu/2RrQLJVo?=
 =?us-ascii?Q?1Se6gvPCwnJGHnfCTMrTEubxiDrH6iJbuGiYsJSW6PB3BMkJATPx1qYQN1/2?=
 =?us-ascii?Q?LTAW4paAJKy1Uk/bmJVqFwxRW/+byEPxBgch0638JKZSKgKXhqt8puCfBZjH?=
 =?us-ascii?Q?Up7RlgWwJpVlmo9zuka5EhLMWfei/HKdb3y8bJwedOORsOV+C88MKCOXa7yr?=
 =?us-ascii?Q?beUV+DMDAcwSwI0gwh0SqiV1akihAcNsKCCkhQ0G9zLuOthlj5KLF7xjedO1?=
 =?us-ascii?Q?x04vH30ypxzpzrJE7BRX7F0F5SiPM8IyncQdQwsEyp8FKZBshqfVYedUZUlw?=
 =?us-ascii?Q?uA0gKW13V/8CNqC9Famypr9NUeXSi5VzSpv9Iz5eUF5M4ZWZK2L4lu5HVAhH?=
 =?us-ascii?Q?0kQZTF5kvDpXyFnIAfGAeXdJg3Eha4SIcHqEBtIWTf5lRVxsBzmEHE1h+2Hc?=
 =?us-ascii?Q?BYyuAmqCe5Ckbe8Kn6cToTft6tL9PUVx2lY8QoRgle9q9vmMltpiy04CaTzs?=
 =?us-ascii?Q?SZXpLB7CfyGkjq5tADJ4ivyLo5rNqM+rnnP8JPWPQQPjciXjQChRlTK0Jtv+?=
 =?us-ascii?Q?9HAVhx4jAKVDF0P6AX85lxQAXPijEyjxCpXKNYNwIn8Vpa727koSR901AAf3?=
 =?us-ascii?Q?lWIii7BicxF0p0S0cz1V/k+e7mPshJQKEWoIIa3EddfOayFgMkr32/CWVVWQ?=
 =?us-ascii?Q?brfsWUJ36u4dn1AQQaQix6mFFHDkKpze6wksU5OPuMmJQRVl5nnRtC4G6oay?=
 =?us-ascii?Q?BWk6iuHdaJFbsCIWLWnjueu+aTPQ8tX7FoTK1ZflPZosFvV3x+W0eJpx8E6s?=
 =?us-ascii?Q?CkD5YQdR6dbvYmWvF7CCAZ/JEqb+XJpu2KUHcJ1yG76h9cqmYdzDzbZjT4fL?=
 =?us-ascii?Q?GoYPEJSKowa1my2ExxMUiNG9v5+eI2yhI2pWqdaoseR9pJ2+IJwuXkAy+IAj?=
 =?us-ascii?Q?dcUQRRlVOwj7A+Ap00g0vyxFbg2CcIzAQuptQu6t1P/Y+pMUI0qIKpZJzU5L?=
 =?us-ascii?Q?VbXYsNlpjA87vI6u3CLQwUferXemQQBvaF5blpKEL+xl0GftzhwcgH2fGUfn?=
 =?us-ascii?Q?bVp0hj3mQJUQMwTGwO8YUrwDjernQfgdLIUXWWQT7SOhsm0lWxgailLoUCpT?=
 =?us-ascii?Q?ECIBqmmTf/WDbNhr01WtrflcOnhmzjUCEcJ4JSWrdFeieMS8X18ANvLL0Irs?=
 =?us-ascii?Q?pWAyhFBoWoBQwuUDf8Oji5qXFwhAEkRQbJor9sdv6JFLZKqYOLVj/CsX1D93?=
 =?us-ascii?Q?ptdOge3jznotYCTBXDRumrp2d/vTnOOzuM7axNiA/aXCxaoju7CRGCqGnecX?=
 =?us-ascii?Q?Cf6EbfaqBA++kgy26PriIbZJZpJTTzyOGlZ8qzm/6RHKkU9A1qtvN9V3r4P1?=
 =?us-ascii?Q?u2+U4CJTHtfCYJJ+jCO/aaQ4P+mmpwksQVXBKrcdrCJXFkX4MhPPXA45wDqy?=
 =?us-ascii?Q?Z4qIBFXwpw2UVRqa85aY0ETjwM9kNglOYt8ei3JcsW0Bg7QU1lL6xBAPAgEA?=
 =?us-ascii?Q?CmeE5CFVLQqiK96/d9iTUikcG+CIGaaDQxDo52aneXl0WdaxYRedwwiP1F4X?=
 =?us-ascii?Q?0lMcZVx8SdxjeAx+H+HC9LtUCFxuW9jEU2dV4YfHxSYn3JAqbg9kQpjFI5nn?=
 =?us-ascii?Q?58w29AIrv+9prpwUl50ums/8W/dvpEUCpdKqeB0rSaSXQ7k57XHMzSEToLpu?=
 =?us-ascii?Q?M8fasxrsYRZpXF7waB84bEwX/qqiysGkKV94Dyn80D8mYGaxWgf7dsomLUV+?=
 =?us-ascii?Q?aLFS0exjK7JuaPUXt8xZnoTjMfC5YsI=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4ba29-75a4-4e28-0375-08da481ae228
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 00:15:52.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bo7wtnnFjyqHto0a1VKrz4qaICl40lUsYbOcWFFLMbV+oTpOjDQL5Dou7SRo53U1lWkjB7G3rAbcSSBQ+jDRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3415
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v2:
* Instead of reading CSTS, use a constant value as input to
  nvme_should_reset() [Keith Busch]
* Introduce helper functions for parsing the AER result fields
  [Keith Busch]


 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h     |  4 ++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea9ed04..1ca8e1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4521,9 +4521,19 @@ static void nvme_fw_act_work(struct work_struct *work)
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
 
@@ -4556,11 +4566,29 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
+
+	/*
+	 * We can't read the CSTS here because we're in an atomic context on
+	 * some transports and the read may require submitting a request to the
+	 * to the controller and getting a response. Such a sequence isn't
+	 * likely to be successful anyway if the controller is reporting a
+	 * persistent internal error. So assume CSTS.CFS is set.
+	 */
+	if (nvme_should_reset(ctrl, NVME_CSTS_CFS)) {
+		dev_warn(ctrl->device, "resetting controller due to AER\n");
+		nvme_reset_ctrl(ctrl);
+	}
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
@@ -4570,6 +4598,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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

