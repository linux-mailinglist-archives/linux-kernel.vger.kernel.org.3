Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA09B4974DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiAWTBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:01:53 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:33152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234869AbiAWTBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:01:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GikFaHX/Qdu7ewNGq5Ld44RMWMeopHqtbIQdHGHrFalaH2wtuOQlMmxSeK4KRYNyPY3vgLRrHENKKs2bP2ghJegGqmMl10DAElYGIyNTHx2LOlAzRFQibiTKrf3F1hoUqA605zJCHE3k19FF34XcdIPmtdOe1KspxSpPlrn//S5veHZWGeB+jiZ9mXIs4ztdSOQb22So+WL5ZoxwUb9lJ4AidPkoEIA6LlTvD2yrb0bU02pANwZuI4ir0V7H/1PHIi55KuKnymDMe8VKXJC1RaKCOvsZVa2I/tpra9UsP4q4DWudPR6UVnvRciTRnPA1s4GaLq9UVSnLrd18yqM1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCotiCMVgLUr41O+wynPGLKGrJ3fIgEseIl8rU+u2oA=;
 b=KyrB/hJqPlBNJv9Qoyv8n2euxDVqUzmpxho/2b/DNY+yxff2yhL0oNCCCXYzrG1l0snxn6bXWOiaS3e1BoVCe/GU8O6BdVtINf1E9z36NIAjFvu2tHIjiSrthvMBevYXlX9lEUTVFv6VDVqHXBzY4u9cKOrnxuy3KAbhfeRFyX0dT0zFrRWKcqUzAjBpxL/FqzYffw1sXiPNjQ6qA5jWL2D8tJX5p3OpONBcupEuH8SrFXniw/yGILofkWb/TdqJEjB05V+G0VSjVuKWVdP3S3n5QK/Oo1dlGurIjfSs1f2fIdsuaWFbHbmANNVDaCNPw2ufycXYmRBcKfNALzlmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCotiCMVgLUr41O+wynPGLKGrJ3fIgEseIl8rU+u2oA=;
 b=WKwsKBjL52rw09V8yturvUGAmpjmZycy6+deeBH06vmz8E+d3BrSq6vZL7MmmZ9HUg47QSCqrKzTdZX/GHpiHlCNu+RvpBoAWp50apNfpWjc87txd3nj//IeKJyyHLAh/Gq8PYWtFl9aDM52rNlNgb+Z/To2NILhj3+SdmmUPuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BN7PR08MB3892.namprd08.prod.outlook.com (2603:10b6:406:84::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 19:01:36 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba%5]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 19:01:36 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 2/2] iio: temperature: iqs620at-temp: Add support for V3 silicon
Date:   Sun, 23 Jan 2022 13:01:06 -0600
Message-Id: <20220123190106.80591-3-jeff@labundy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123190106.80591-1-jeff@labundy.com>
References: <20220123190106.80591-1-jeff@labundy.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b270ad-661a-49c2-ccb2-08d9dea2c761
X-MS-TrafficTypeDiagnostic: BN7PR08MB3892:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB3892101F58F13625A81EAFD4D35D9@BN7PR08MB3892.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAgDfwCUF1sYMT861Zn0FG/i81tcpbxu41MHByPvnpi83frPvC3FWD7vD7SDNQdYl0FjwqgIW4apSomcaePMSEtGH7hLyJX+M2TVMyXdoslA0AQPhncX0WeKcxaVhkksh8v8DueSoPPNgeSr4pNg1GyyBgT0i/7K+z/twRoeNE2I6FbVyuod8L2PRhqEWxW2PymlCnnZURdn3DpyxmDyPBnKI+9tnt9O1Rltol3sUSob4JvslQZtnLnsbXJJ8F/Bjk7amJkBpmtRF5X+FalMQhFe2C2GgwYYwX3nqIB0wJodo8/DftgxWklv43PtaeaT3Xk5xGJJdrrD8E+0/hAB5ppHVAxZ74o0LOCiFGl7vlwYLCGimHPwY+J6wnl3ygkV1F9GBdBQ4cZdK0InIxWhT2meI5n7rra76MwsXoeSWQTd3j7RtnUHRDDrZ+lUNpBqef2SimYPdeYQ6aBMtkwJPlMhFTojOWz4XDhwcimZdQ3h18BnIAFYvB3PCn/q+SHADEjaCSYFinEomG5Ujd2mWur/ObzlOBbiURH+K1lbLCX+9cEFwacr8fnfkh0kSa4gi6r+6IqFYiLKJHsaWnujMy5k2yDyWSqF/Cjumc92/+3GkXJdH2rzC7U3C4oc4qcPJb6NBiUPlTMrKFmUAxdbF2cOuZKcf1hnmqPiSzAYgtXM4awBliSkYckPYhpIYw9ctmCFH6nnQ8ChUn6xMUVxBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39830400003)(376002)(396003)(66476007)(8676002)(66556008)(186003)(1076003)(508600001)(107886003)(6486002)(38100700002)(66946007)(52116002)(5660300002)(38350700002)(6506007)(2906002)(36756003)(83380400001)(6666004)(6512007)(2616005)(86362001)(4326008)(26005)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8FI8v5G1Kwe0c5MPgdtBNrwiHdBnE3uZ891cC5SetSfjBZFOU5EHPTRwskd?=
 =?us-ascii?Q?XM8jfiKvPxapV5Aaki1pN2Ws5+lfCVBu0QzaWNjgG82gzTzj7gBfTsQaBP6p?=
 =?us-ascii?Q?cNGMNe951wVSnphSp2pOCKHEM6Fo1oSv29LMaaMIlKDN4U3chDisKlurpDrb?=
 =?us-ascii?Q?9qT7TM8MLhibkwVjCFKhgz42egwhtmNdXClMvC4vVrYIJMHFh+YXEBWYa3nb?=
 =?us-ascii?Q?pPC4mQXmyYL75H4UANBnpLKzDz2FjeVNI15y8APWZvl6GNeVG+xpyZUDVATG?=
 =?us-ascii?Q?wE2NU1rGOYAdMeb5fMPCbqH4euV2PQnc5h+EAvOdS9fKk/6apUB5ZYtJleiX?=
 =?us-ascii?Q?2sqYN7yKfSfxSeDbLEsh77j6v4urzN3eQ5QZn+CqGwjgWb5FJ4QxckmK2QAC?=
 =?us-ascii?Q?Qn5HB7blCEgIuZp5BUee60HpXppIUo8KOSQkr4xlCnjekkrr37ylmuDgw+Ii?=
 =?us-ascii?Q?eNekHi3vUFN8oI8tEoDl216arrtYTFPPBtr+LHHO9a3TFnnXIWgsFk9Ump0m?=
 =?us-ascii?Q?AuCMtKedHeCrq3JpCRKdp4aq0CPm+YHGX/qWSzswviaT89UGL+cufMEg/SG+?=
 =?us-ascii?Q?9cYxDqEVOF9lgsE3OVlQHo+kmilKKeOT+ygzyApmK5c70ug5Q+6hasRvCVQW?=
 =?us-ascii?Q?Y/8tuRDWwWwkQWqAAxVsk80ttT+Dp2A/VtJ+ch0OnCjjaeXf4sI/DJQV3TOX?=
 =?us-ascii?Q?hhpmaoFrQ3ivAI4olK3oho77W/8cFjmq5W5qJunR6cHObcCcH48Vyaou5sEr?=
 =?us-ascii?Q?TbmM8pGefGL/qoC+lsD4HgNGSCoZQF2N5rkxvE9dV1XHhU9S11gmyZ6wAMjU?=
 =?us-ascii?Q?sm6GP2WtFDOKFcy0hzz7aUU5rw9hpCcpv5OR1Gkr28Zj8MttlArOqCU442N/?=
 =?us-ascii?Q?p7zrwpiyB0xHZiEB4mSp8T0XAZEUd6RGnTzrmlFyTdUVnD7Nb2JIRc2sqTZc?=
 =?us-ascii?Q?i9arYcvIkjafsobOVdB6mUUuvmeV2YjDVRiGE3TBUJ6olUI928+qsI4zE7r/?=
 =?us-ascii?Q?bLSDts5XwoHQO1F6aE55VGmePVdoT1hS+zCwKEMjb+uURtkG0JKQH4WqHHyN?=
 =?us-ascii?Q?8NWUMhcN4NlmDOV5nQVkL4SfpkVV2K2IVHVbiY8nMGNgckGayMyfD1WqzH1X?=
 =?us-ascii?Q?REvw3nrhiqQOOpwyMBrym2u+h1iiY14/FI0VnQwIWEjHZwe5qf4V6IysjIjl?=
 =?us-ascii?Q?jF1y6mASLiWLDvUwgtBsQMzGlVJT866uydk2HTpUezU73lZj96xL8cwTWBaf?=
 =?us-ascii?Q?ER3goUmF2Xt80B1l51s6t+UUV8CYYmeYk3S9zMM0fX7QesTxgUdtljjo6wgG?=
 =?us-ascii?Q?Fc69jT4lwz8yMYPVReD33WjmzT5MlNTWe1bs1/G7lLotrYGPPofYCI0lnUy9?=
 =?us-ascii?Q?t4Xba5EMIJULArRWtzJZt2IHsjZnpm8nei7nNYNKysKlFqCsvc1M8rHD5BUw?=
 =?us-ascii?Q?iPNtMb8GjfwDD6s2JnPqNqGfyk2jzx3qiGrUFinUaUyvkV9jLeCzOzIoDLuk?=
 =?us-ascii?Q?WDaXDNR9IjzLBtSEysOvrL301/LsWnL246ugySNSw7HBd3mP2qhlOP5dYhNh?=
 =?us-ascii?Q?nLpbXHbL6sIswmVZkUc4YdNeIgpdN5Ji1rB6GqR5a5B7/vIo39rOnaR8P176?=
 =?us-ascii?Q?rjQU+cYXPUectc7H6yrEtRA=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b270ad-661a-49c2-ccb2-08d9dea2c761
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 19:01:36.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKmfLil3SapFy84D6saqSZXbOIi5xoVUba3LYZTegPLKjvi0I1JiFE5NtUFKEX+lQnLhWSNxTYVsXosoMTKtQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB3892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor introduced an updated revision of IQS620A(T) silicon
which is backwards-compatible with previous revisions, the only
exception being the offset used to derive temperature.

Enable this new revision by returning the appropriate offset as
a function of the hardware number provided by the parent MFD.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/iio/temperature/iqs620at-temp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
index fe126e1fb783..e2f878d57af7 100644
--- a/drivers/iio/temperature/iqs620at-temp.c
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -17,6 +17,7 @@
 
 #define IQS620_TEMP_SCALE			1000
 #define IQS620_TEMP_OFFSET			(-100)
+#define IQS620_TEMP_OFFSET_V3			(-40)
 
 static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
@@ -41,7 +42,8 @@ static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OFFSET:
-		*val = IQS620_TEMP_OFFSET;
+		*val = iqs62x->hw_num < IQS620_HW_NUM_V3 ? IQS620_TEMP_OFFSET
+							 : IQS620_TEMP_OFFSET_V3;
 		return IIO_VAL_INT;
 
 	default:
-- 
2.25.1

