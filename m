Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358650FB62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbiDZKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiDZKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:49:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBA2AC5E;
        Tue, 26 Apr 2022 03:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9fxgtbx2G5rjJKEAAJ4HXzd0go+kIpoYAzKqLswSEtGbxvTejM8iN2ZdoMFzsE6cvDUWoSAtc6jFnArlLoHVncLjsa5eG64yhBPBEp/TfnlJzIX/nmVaptsZ/7J/rGiaTOazrc7hLsiLVwpNa6fv/rHOEydE6uGSA7H9qHoIH31ix3sn/aaXr/ZWMh1/2p31ZpXEzFZE6PjuUJ1tAi1ALm4vzCPpdCGDDV1rWpie5bTsLKfe5h0JWiY8ozGvrC6G8BRoz1swe+Lc7++c3zf6X+ftbMq/XS8SlaSWZIWnox5MCMm07nkZadn7PJ9gn0e1aAHzahEpcQQOEXqXYHJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9utICEedl47QlQv5XGMQWa9ymmCMkG4s9q0nw9Ruc0=;
 b=WEVJWYOOyWuCKgeAkmybSmtQ224WGBq+7ZSJIa4NnsQjFZsuYVYXw7KwNojy6axVXTIaNYHD6pJpiPqp+PIP9fsFRHAnPtijAW5VGMn4kPJYoKDZwNlmvfJcvvQq++YIVMoxzUcEYH06w9deDpqDZHgB4RpD9UpxP59cUeRZkQ5NAOrsXAAkEX0bzc2pXVb2iRJ+l2TpptCdkWQdrxG9i80C1XDPSbfCS4Zt8Um53CB44G8Q5fGoIBC2q/vmybPegRwKt1uOQsFKjWysVWxYeaQtor94ei9zQphIspbybVwc7Ue/Wnht33U8TPRuQYMsQuq+nhul0Mo5N/KZxm4Hyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9utICEedl47QlQv5XGMQWa9ymmCMkG4s9q0nw9Ruc0=;
 b=NPNcqnfkN2H4Bb277X2QcSvOVm2T6yljz9hQ6WF8alhsxfhCRlBsUZLwKArcBeWsMRAPcpnwI+KW19m+ox1YiWoqAEqtjZmLLwL0Ovptm6Cf70+ofYO8GaAGzC9i7zVgqouJ0XS6WWnGnZhF8mRinfC3hiBSTbZTrsja5+xN4rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PU1PR06MB2200.apcprd06.prod.outlook.com (2603:1096:803:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.18; Tue, 26 Apr 2022 10:45:28 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 10:45:28 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scsi: ufs: Remove duplicate include in ufshcd
Date:   Tue, 26 Apr 2022 18:45:07 +0800
Message-Id: <20220426104509.621394-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c51568-2648-4cf7-49d0-08da2771e0e9
X-MS-TrafficTypeDiagnostic: PU1PR06MB2200:EE_
X-Microsoft-Antispam-PRVS: <PU1PR06MB22001D03BFF83F84A7B5CB01ABFB9@PU1PR06MB2200.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N8Dxqd45TKgFlb2rMiNrfFHB5Y3+VDNLTWY99dmOK048Jc5WSEGKqJeepJ45WhKosqIj1jx2FabFn8nkbOyj2w1Y9H5IQRBWeJuFKtEmMo0+62ZQVuLmctURfajpUwRnWW1iI2xFy1uvf8ZsE4NCc7D7kTTPwmG2rLKqh9yhAyV318bOR/XgiD0Dh7CM6qXROdHa+Tw9rSZPAc0mBksgxfBlSsvs8ZM7ZHbo1p/DnHdjGv9kVDQiXYpeQX0ESdSXSweRgl3XW/lxe9nNhjExjl1Ef3c5sbMu36bTDj2UeuALFbVBFnfsOgYZSNxfslri0+pxEXhBcDTQxswapW7qp+m7DUXkCiiip+33Zh+5xCNYC4YpKX80BAe6I+Rj66fl2bn1YIlF4n8QoeYdyKGYfDaLfA8s3U4Rg8+2rTSoU/tOJVkbyywtdibQPCrjXf6fpMfN9jO1zueaXSVYsSDg6v2xlb2guTFi/+0GI3cNPl1b1K4a/XG5SAY7qepo9r/picOzzIy3PuhkJABDuxjenIO7tKJAHUH9q5GN+VX713dtmcjjcjQet/msqUt1WE6R1w+XjVj2YUjm8edTgtDlcAX0BNpMQ0Lv85TIF6kl/E8NBNhM933gJkhzvjBPx0spC1ottKyfrLOuW0Z0slH4U7Fm7U1el+we5mi5UHtWS7R9VktMdH381IeYsxcVeyuQh5Sbz1B1zGLTooquYXQxO0N1+b5YELFPcgGeRHIXLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2906002)(6506007)(83380400001)(36756003)(38100700002)(52116002)(107886003)(2616005)(1076003)(921005)(8936002)(186003)(6666004)(7416002)(5660300002)(6512007)(26005)(4744005)(508600001)(110136005)(86362001)(66946007)(6486002)(66556008)(66476007)(316002)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QAPlz+9Dmo/vTKCLMPKBXWPDiZuzmfMh9sziS+nLgbajXGEJaY9AJmkNIyD5?=
 =?us-ascii?Q?6mJzL8iDbiyVXiOUFisMvGkVD61K0/FTNaGcJBVldkGkcekfW9W08MWbkiCq?=
 =?us-ascii?Q?1gtYp2ntRYFlwwfXWl7Rt5dKEDuk0YE+kgFQIKunUMTjBk4E+SstVCtnMlom?=
 =?us-ascii?Q?/HDJ0+Hma20fdTYVsDNjjT2MH9L8zPiBMEBByc/1UODPPporsolt3Bb+WWOk?=
 =?us-ascii?Q?1mSCh3Hu/LpGbO6er7FwdKxPc4AFVdjwhi6KntoDYY8HGyhaW/ML4PjoOkbT?=
 =?us-ascii?Q?unyYn4lt3+7rhbFlodaDump5aAd7ATMovbnBEpnCoQikv/59KZ5nNsBiTfcU?=
 =?us-ascii?Q?dnPziGjDboOQJSXve8vMNMt5Z7RyoSoifi+yrrTWkCUL2ffOVxi3FZtBL86j?=
 =?us-ascii?Q?HQEdUpdxN+oeojeCHW0J2QOi46KzxMrBm+JS8P7OS6Q5ZZIJGIylrC4EE3ty?=
 =?us-ascii?Q?gIzl55Vfxb/tVUhXOZ3N+1xSngOyp4Xcprqew4xaBggI3AYpqD+hnwe3Poql?=
 =?us-ascii?Q?+zrRdKaHwvdyVwpXDCvUorfnVEk8+AEobJxy8aLRwiqO9drkKvKnd3vuZ+E7?=
 =?us-ascii?Q?jtodBeM+YmdGYAZY7T7CPC6l+C+I6KQYkYhUm0OyBSYsBEbQ6rAa/7ZuUaI1?=
 =?us-ascii?Q?mIYpDxAN/k6EPBOhfWMSVTxmywZNKFBGBK7dxThNGsce/qBTQ1MK8tOjalEo?=
 =?us-ascii?Q?IE7RLZkoXHlJ72vEDxuRoZ9UBKQWR9aevapUxIn1+86ADJfZBtpxhytqSzRN?=
 =?us-ascii?Q?KcQmzl40y298LY93WyhhJv+BvnTKLO3aUlKavEKXHlYLaou+iw0Cx03Yt83o?=
 =?us-ascii?Q?epGx695Me5n1lAFbEG+l/U/RpApW7waut/gjlSFxmUsnfjrbj8RiMPbIGyCY?=
 =?us-ascii?Q?GzLpaOqMVjcFc+ueW8p8xnsuJKvrITXOtlP1wQSU1Mef6mhXwGQGfOVcv8wT?=
 =?us-ascii?Q?kRU7z0qhATS3E4hsszHPaIhlr57MotQxjrgABGTiNF4jG4joofQkhUMFGaFq?=
 =?us-ascii?Q?q3al/HSigk+zRGevrrSWBUzRD8gEaQWtjp6xLJ9sRx8UPvGCHqoD7ZtONMZG?=
 =?us-ascii?Q?oYc2f7zVgMTL3uPAMfqWM6UMV9A+Hufw2kFBOAdlEn9U2ZJYuGl9BQM8XkuS?=
 =?us-ascii?Q?ma/yfvXsr8GSRI29G1BjoQNlLGzZHQ/BrF2upep5UpWau2dwy+KgMiqWGx+i?=
 =?us-ascii?Q?KYDii8ubE6N4ahSo/11E+XoAW5Zg8jLbWnKrFutIqp/nT2uikeoikerkRLle?=
 =?us-ascii?Q?anDsxplkeTD2OJm96CZDEk38GixyBsjbxyQbEXopPxChWwukK9LCcmttaX5p?=
 =?us-ascii?Q?l+TppqZuXroB64DkhGjm4m3gyleexAHBjZZbZjEMoYa67333PuCMfnaGXxL6?=
 =?us-ascii?Q?+/QruLaGCD7eO7F0ptKgfrqHdYGGTHnUsVqRGLF+2BgjF2/km/LuvQcT7qKO?=
 =?us-ascii?Q?l6rVg/0Eru0Bv5yuFPm3wrvRCb3ZOe84/erqHtztUngHjOqZHB95w7MHj3Op?=
 =?us-ascii?Q?NArCDgTdkY95bxyqvxsDNF3jUUzzNlXfG+MG4AXacKSJOHcORlBIIy6SVAyh?=
 =?us-ascii?Q?oV2+/40h/2WIThUUcv7mVGexYr8TItyG+IiM2ZEtsVyc+5v75l7lzC/JZql5?=
 =?us-ascii?Q?7i47wRbTg+rgIt700q9tYqhd9y33wvt1UMcWf0SIebXS6UB4ARAbIO+3AaQ+?=
 =?us-ascii?Q?zUtcalUD1YkpCzQxzAUVSkK9AipwtMGgYcQNCliXmWr+pbEwpU9VPgMSdzdq?=
 =?us-ascii?Q?ArfakiNUVQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c51568-2648-4cf7-49d0-08da2771e0e9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:45:28.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDgL57ko6To1oz1ACYiRlJZcmhTy/OKqxM2I0HMo9nmxrCR+cITgInMNT3rNWq18pcXa8yhgKuKCgo+2KSXbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2200
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkincludes warning:
drivers/scsi/ufs/ufshcd.c: linux/nls.h is included more than once.

The include is in line 14. Remove the duplicated here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/ufs/ufshcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 1b87f26b5193..73b3dfffabaa 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -20,7 +20,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/nls.h>
 #include <linux/regulator/consumer.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
-- 
2.35.3

