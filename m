Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F5527D64
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiEPGJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiEPGJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:09:54 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2141.outbound.protection.outlook.com [40.92.62.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EEC20F42;
        Sun, 15 May 2022 23:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkkSUJa9m47LcTryhDz9IXW45hN/KUiszu1xz7M5QrSUbCmFXdd+qS1wjAP8BovWelE6mrOxVJfroXTZA0M8U2vfZpqQv+d9LT+VLKf0BZLBycvf4bSOjjvBH7LX1BoHoLOOHdyxuo/WoDeVsjc18eEVN4nCfgYH/Jzd4tXBDGrIRkG4yHTrf2x2WnX173Ffje4Pc6kybnmPW1je0GtHBG2i9gKwWy1W017fCr36bVdmn2BsGxNfvrVRBWt/8TSSRekN+/j4PGN14/c1I5QZRcvyG/FCt1CCDEEbt/4RDClAStKBJYMwU3l19HAH/ykpFftgCvhj4t80SFqEm9EnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy943hCSy4FQOnWDMdvBXvZgX8/9Zlqga1eR1JW5QEs=;
 b=SIYf6ov8fxsWhhA0vVLmgGyLRNYxm8e0QNepkYmnHrYXG3fkKzxI1nPbo32CLqcZoIXigfRk1NcuDuQ83GlOUmfx98oJxbIKwnVNVEixr+Biit8KaPdDqcFZbiLlDcPDkYUB5JTNszVLihifptzgiNFHL4fVegRAx6xwwHKHwKjB8E6SD9LhuaXfDp2zh2qtAutk6xEwvRF0rG2wo4lWy7so+zL5gIJMuzCqsVpDqA5xZJNpiGCi+u5hcufBR1wm7LdVyc8NesLbSAJFI2SqzNwwBASMb9QEkjNUWutjln6gSBbGRN/sB5Ioi1EP8yUIKu0bsOJ7BpkXBas+s1YwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy943hCSy4FQOnWDMdvBXvZgX8/9Zlqga1eR1JW5QEs=;
 b=DtaT7P1oV4bUAFnbv5smknDb5L5+yV/tVH9QpKySN00cN34XMQkHT4vJdMStm71dstSPdHyuRX9HU6nxgUngVlKfHlsOMLDGw8qwuXtNuhaiZFAlbzIJ4P6fvjvPrvneoSBGVZdOZ8Y4TulTNTUE/4tM9Fz6l2GfjOFD1BAoKOgbevzR7FCR/7a3Hh74ZnrfuHzWB8qQqwSOxIqhf00ZqDTJw43Efptq/LspLgLh8UCHrffuPY7GK9maO+JFwFjaPoyUB9URjfVaVT3mrlGkqBeRo66K887YKLKzn4PlhY0DjSYV6kY9vsSH3SDT2pMRrFTLBGYWJINXNJ8WGxycMA==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SYCP282MB0158.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Mon, 16 May
 2022 06:09:49 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 06:09:49 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     mani@kernel.org, loic.poulain@linaro.org,
        gregkh@linuxfoundation.org, quic_hemantk@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Date:   Mon, 16 May 2022 14:09:34 +0800
Message-ID: <MEYP282MB2374B1DA0004F6E5821A2FB5FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [5tX4mgCJHl4UWKCUYmoen6FtcWSNpkhV]
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1652681374-5086-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07797aa3-c684-406b-bce0-08da3702aeee
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNWdKAFq52I1YRrlMZv+xx8wbnqnrhAr/ueyzdY1/b6SeS71lJ1AKz1mZDOUYjsxjg1P+syCTlWjHEK+K4jnZWeqOK1xbYMy90iydJo2qI5Z8wFlhwuULQWsdXv2TNbxbZZhx09bSM049r7Vb7+RvnXwOBEKcjXBHIKhLDtS9VpCTVuFm39qN1OKoNlTL5ZlGsG98nqI/UgfWKTsIgTwNLjVy9njQnrM+rco0d1dcD5Y61/Y0ESCFj9REe7aJa3JFnGswV48xwnYROmcsFLqmT8ywn5XvrR9GQDIkjsy88hUHf5L3jsG76L0nILGddXlxdO8K5ZtiivTFW7y1rmUOHRcJ2xCPo7S3PZ+GqepRzBLyGV/DHWxdSMFGI0HZik1a4wg4lINkDgssDOiaPlplt1ZbbK2BuGL6MDFel5rhsEb3YyZ957BdWEgENzNY/H4uboOe6DKH7yBp99LzOtQcU8YPWQmooik+7j5GMsqDO20duA6iICpkNkdA/G477L7LUOFoLonShZuKV/an1b7uuTPB9ZVuiP6idIJj9kvB7sQA9BIS/5imlYK7yOhJ5y6fZECDJ7G7qjfPpWxMfcUwAx1kEllpyKfsTKCXHSTyxoPIME9Opq7rCj9SV9KjqUMvT1zcxsOr/nz2BfWr2lmiLP9zG99FLS0vyJkdDbuzIEnwV4avlG1foo2vLEAPJeLMtrpJnSFcdWjnvzpqzRcOlPzRpk4T3JoCcE=
X-MS-TrafficTypeDiagnostic: SYCP282MB0158:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deWk6JD9CgnjMJHDZh/+fm/7ei0UKyFLcwc9b4LjjWL/PMsIEpiUWFoORM9XJcmm8cl31KDwFYL/YE/ARWKSaQ8aRw5iYhtDOjI4uGtsRzCfY4MbFYtSb33/qfwNzUw15X1nfPIohW1GzpWKn8zxyO70t9PC6J/OXtZgmsRV4Ss363hcpErugiUoEt5/eqv2wTRC8YQrxgV/zVdPnO3Fa6uhXLHNVlse21KyH4Vm289tgne82CVZ1wYOTB/IkPxVYAgtZ/B8X0BC2MqGyTcFcbw5xFMCxuqAksqdY99J0oqcPU7dNqH43oCHvyA1vv1ZsDohgxEvLwCfXfjBxTZhBEF9CLEPszI4uLANJgunZFozxKMal/td7W0ypxhOBE2HIYTi9Icy0kp2mtZ3Xfy+lvL9Mg4le4ZLpraXsc/f7RSqLmc80FFXwNKMiT3R9Gfw4hjDCHX3itKTQB6RmCMD4r301ABw7GP+jW7+yrgp5Zx+tXis8qqUU6oRn/JpCxmAPtDM+MG6/FQq/BViF0q04+qNYr0C9Q9e1P89af+RHIzUuQ+fx7ihqoDN4WkWPsgREHVJM7RyBUpbw0fkAt38pQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vi0CUgqDi2re5dh3MLfAKRwJ9TS6gzQP5R48ur0hDcuVxKRQriJk4A0eAPqC?=
 =?us-ascii?Q?BpHgt/D+6m9NaKTde7Z4CQlTuTZhwMEGL7tcQWZQB9PnKRpG7Lr7cORn+gJQ?=
 =?us-ascii?Q?gLcPttaLvHj51qa+mvH1Sq+of5nQ2swWAjzP8pGwNXzP704RKtw4YRFCPBCN?=
 =?us-ascii?Q?GB1adOzOO+YK8OK1fq2E7751x1UYAKWrwdUSRJb6Da1oslIldIUgHlRV/+Qu?=
 =?us-ascii?Q?gYA5l8Vef46gKL2eIzE5jOooqihe4+jG4OfL8cU7nl1TsxXRt/FQBfKKtTvO?=
 =?us-ascii?Q?EpzsiOojV3AEcuoo9s0KQzsJY1mXlUhZxyC38EqPdanZpDgCS1WhnoCYQqDi?=
 =?us-ascii?Q?LoLsNniek5WfChUw9RtzDGr10/nMmE8YP0Pc1ZQVOvm/kIA8uokah6zCYa2b?=
 =?us-ascii?Q?7dY7xg1bdUYB9WyeA16ad8QvbHrENa8/ivaNuiCmxrrEhRiNiy7L/KWvxfGq?=
 =?us-ascii?Q?/cOx+PmyjnX1psB+icDd/glaAzUuX7417lyTaG4PaLUKZvDQ3AsNdO1MGKrU?=
 =?us-ascii?Q?NTcyumtVGsqSsK3inZ+RrL94N7pM6BOYzgl7auHqGz574v3aDsnPDcOhmcDl?=
 =?us-ascii?Q?0hzSX+EYtcC77DCU7O0QlspS9lAnhug2uKpd/Lhz5Qjod3vMqEaVucgONQw5?=
 =?us-ascii?Q?5BnL5r+5or5n6S/tmWhG9YShWAQHn1UQs6FsVHurohF0MrWkLcn7HCOK1N0Z?=
 =?us-ascii?Q?0rCCiR97DC0WgZ/So0jS7dO9cMT+KJ5UFu9WZhlFCAXNqDje99XHpeejl989?=
 =?us-ascii?Q?O98ZyemAMzxw9eFqkUKYxvcmpmrCtPyGTEZw3K6/Wu4NFDkMd1MsSjvi8h8C?=
 =?us-ascii?Q?mcQkwcavLdZniJG3wSYt+g0zCHCnIQTel62mZVq0ezPWpfIhA43kAilD0VEh?=
 =?us-ascii?Q?7DE7TWpPqdr7U6F9kBNPXa9Eb2994YLrdWSlw0BoCY2n+BOEDOFJPIQw8y1a?=
 =?us-ascii?Q?X0VcoMc+59yw7wbD+0JGk9RRVWu5yoD5pBDC1+UwCh9QapJ3VlPXBV/UaijZ?=
 =?us-ascii?Q?wFIH6RQupc753MTuFmhBWYCYxmYgZpQCPg18SEdo0qzOb5OZUBOhSFMUpSOD?=
 =?us-ascii?Q?UzqG4F19CUgUBxmWniydPTvEkEZZnAd4ju636Y/qFB/04IOZAydodjZcXIfR?=
 =?us-ascii?Q?tCwiIpXK3zXUvJ4NSgie4jd7ro6VaVozaXK/qzUwn2KaqW2nZjuNLsqfPYKR?=
 =?us-ascii?Q?msAgVOScM7U2TePJ+Y5wjOfuvfxPP1/cjfWV3aY1ZFRwsd6sAY2hbPWgFxvv?=
 =?us-ascii?Q?Pc+ESonPM4nmA/z3SPsGXISENT7sHkEVUWqhPC4DdgDtDuzFzIZEAhQotIek?=
 =?us-ascii?Q?n/vUH3IwjhQwVpcdrTYnw+MvLqhcmgtGyJKoaBrUhzuTObzKJnqkhx0v1kSJ?=
 =?us-ascii?Q?0c3md3JIemPgnSeYDSuDaUxhGgPm6Q9ButMGXjtPhsD5XVIGlfU1g1zyoa6l?=
 =?us-ascii?Q?iR4IFSG3bgg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07797aa3-c684-406b-bce0-08da3702aeee
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 06:09:49.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCP282MB0158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The product's enumeration align with previous 
Quectel EM120R-GL, so the EM120 FCCL would use 
the same config as Quectel EM120R-GL. 

Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---
 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 8416267..0a6469c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-- 
2.7.4

