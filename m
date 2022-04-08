Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153984F9675
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiDHNOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiDHNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:13:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174722E940;
        Fri,  8 Apr 2022 06:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWsjOBzZSDqTPi1amDTj3ocDFeO2waHxfEJ9Ys8BDxcN/gKxMD4xi4Lqoncu812VsQsJzIX7fDwM3SQMrZJ7B2l6yKh/vQr8euXcpPRAIEEzoRmoKpKYfL3XHF1KzhQEEjT66jbOISTKNBv/qA3DA65UJHPDRtd5NpRP9FLqGkFzpv4q57LK94Av9xc/CCJwhi+QwfMMCvleUtlElec1/43ZiWcRRg4dEGfXfGU9ph7sEygPghGs/sAYvJnJl/DwPc//yQWcbw3C6tCmmMvDvM3U2ocY28g45VACgti5YUyn9Fwh4yHvW8/nF3r1ks/g+uuF437OIZHRW9FZIm3a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+k6waTZ5YOSZw9H7v/SifDNhBaEa4TB4WwExJMJtBk=;
 b=WQpAp4vzw0ItoNp6bPDPXlo1T7Y1g4OlfVreu0jWhzyUF0/pD1ZvPbthi2r9/ckfHAxek1sdGOL0EP+PRJK+LsanRyQr7sGhlyH3+f2pibPqmTdwf8p76Ves2lI2Ii0P45TvF039xoYE91wDv/7uRDnnRDlPT+H3di1asuo0KHdi9FQTT0PwFkCuxlc02HM3TYd7EJ4LjmVz2b8hvTQp2LQ393BGQQSvS6a666xk5wtAgE1iQ7l23CZlJXEYPZxbRHUDgggTyJBKn6cbWMqeg1d+OdazxoksvJtYdqQwXiIZtY4uug8wvCacVwaE3UxcVSV6diIfqFHzXlZWzRrh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+k6waTZ5YOSZw9H7v/SifDNhBaEa4TB4WwExJMJtBk=;
 b=SDUhd6Qfr+k6YZuCOAU1rR3o2GmzUe4lL07Tx9FKqL7BlNP51yWKBHaRi3TtvbXhAjVcQBM8Uoc+M2fV7J9mIOKj6bzY3V5EQNFvPfEO66iRPBJf00z066v2myTuogxD1Y9iVByvq9OKIZHtWfeTcwkCAB9H1+JSGHnq5Z0xOx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SL2PR06MB3083.apcprd06.prod.outlook.com (2603:1096:100:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 13:06:35 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 13:06:35 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] clk: clk-xgene: simplify if-if to if-else
Date:   Fri,  8 Apr 2022 06:06:09 -0700
Message-Id: <20220408130617.14963-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19dbbd20-70b5-4366-d1b5-08da19609c14
X-MS-TrafficTypeDiagnostic: SL2PR06MB3083:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3083030514A8D7588562C253A2E99@SL2PR06MB3083.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01AuCZH+t6PPGrANYUSz0pwW4Hf6nJdNfS6nUBgJSxPtR3aABgm2gJYUDR4P3jJwHCtiA7S93BfIfMjLJWYCMXnISPnLXN9MS48Q1ts+Gbv8XO9PEunUA9LLDG/v51HctFzpibBkHluDHsi4vU4ByJWt5VwjbIPQm8jdsYIGA9xYUhMm1oNAJpx1lGxhdrYo2/zn/BlsizGUepWw7GfPk/gaPkUHLlpQ/lP4FCiSA9EDgi05pTik5UAOrhk1LXFgh4Z14T2hb3DB2y9jdXDFtwmIoqp7pMsVLbVMMtTkO0jtShRYNCj4coCxb3c6LXitO4A+RHqJ42bSgy8VlcP6emGlOAk7ATj5QThp8yz1nAZasWeaxII1dOV5FRIqdJmjbFvqTZ+FtYmHOKz4k7gkN2r9UuVTE3imBHUDcEUyrfsl/kRpaJOEM/T2H3WNTC8W+bZpQoiqOLjddwqpARZBpO6vg2uVBH+55wVBV9ndbV1JMlq6Abi3McL0dBi5Pgjnd5hPwT1ehyUKpBoFbx4tP5GpN+odCAJGVXITWhcMFNWUPfMs+aPmcGxKfgZQ4JTmFj2q3aURh//wdaVCtkA2Oo2I2ll0NXz1xHf+qG6ZxhT+pSzdqpR5t/UVq2qRmdm6qRr5NzXirP1Cd5EtsX9P0K+LV8i+rs0dySVDG+XKKAl6ZNFqbRzWW2EM99Sp89yETDPJoK/DSoushUvVRg+jwES5qQpetra7PWhXjoYyEbToZpJNOzdNLFgFaRt6RaabLkA5JdFQsxmDSsl9mzM05zhxIMGKdJbe1V/WfXg0MTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(4326008)(8676002)(1076003)(2616005)(8936002)(107886003)(6666004)(6512007)(6506007)(86362001)(26005)(52116002)(316002)(186003)(5660300002)(966005)(6486002)(508600001)(2906002)(66946007)(66556008)(66476007)(36756003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhReKgBT8iHcjMSX+HD/Z6C2nBj5ZaMCs3MjhksBCoMUBNdTFtTLbe2lWWwi?=
 =?us-ascii?Q?XuXFZ0n3FLDl3L8zB4eZKpxc7/OdC/h2YKpfhQVeBAKIYyBXwonMXqP2EHQ3?=
 =?us-ascii?Q?P5fKEoEf3l3n2H9/tcrTK+8PMF0nkw1wNSDT+021C36DhL2ECkqNLrya9WBD?=
 =?us-ascii?Q?vQGllpnY+xU5JVEY/q7+aKAZVg57UI9EyGZzOWCwmLq7RfYX0ow3JGpkUKWA?=
 =?us-ascii?Q?BPHhMLbgotJ7P2/L79gqavao+93Gi3LfRFt5bEJHA7i4xKg8LRNyKIr+mOHS?=
 =?us-ascii?Q?TPO6P5uh9ahxB2JJCPv8mDB3FhtsrS/5uNHiyE8z2/qw9bElwZ+2Hm7h0R/0?=
 =?us-ascii?Q?B3+GlUIBTUowUbh6L8EzkAEF81+Jrv/8pF55gabjWjrxxeNqmwZeY/D6vJKn?=
 =?us-ascii?Q?7Gtj+KaisD3TT2ojzzDeCwfTFF+yQgsjxLiY5wDu7KlaraqyhoqU39RfHdPx?=
 =?us-ascii?Q?UZ7bupEK+Hq+NldTCz2XMxzdZECV5RtGnyMHrDX7pZoVVOe3STicm6LDTE7/?=
 =?us-ascii?Q?r2GdaAtHi0c0zjISm3I8Kdlq2szOUQjPFHnpvCb2FEC3IDJkqDsrQgRFjOW4?=
 =?us-ascii?Q?UNKC0yT4xfhwh4fpXypdl7axHEyC7BiOuGuyhqfbxNwreosjhSXlnCkw1TmH?=
 =?us-ascii?Q?FQUkRNH458XB4LVX+tj/vbOoy0Qwp+bu7NyhBKKjEqLmDxJjsmjjgx86Hm7X?=
 =?us-ascii?Q?Oip+ekEz3cU9xqSwAbNKNcp4P+hMDbsavdHMBP5wFEJ7Ej/exjBQXchNaD/I?=
 =?us-ascii?Q?zSQX1yXYhtrmtbYsFS4C6maRLtheruNupBcyJ7Ybmo5Q2FnL5Q9QMo26Jpwp?=
 =?us-ascii?Q?xiGl9MItOaw2FwkKhtYr4aX++gVo//TWqGz3aaBTIFbo21ZUAa1/z74F7HY9?=
 =?us-ascii?Q?ZbOoiLIhzy/NlQih5EWgE73nPzb4WjkElg3SYVVORPtFww1zSa53zY3J1aFk?=
 =?us-ascii?Q?nCRSYPiVpm19YCOqC+xnNOm7KbVV0xG73rBpyT7NvWzPCPd7VFhGQyxuMB1x?=
 =?us-ascii?Q?Y0O5X4midEAanNZ9IzQK2LkcrGsRWqFxav+WaTOHprrNKoXGzOloYOPvEvfL?=
 =?us-ascii?Q?Oh5uv6wWvy8qyOxZLVrO6pD3dYtPs3D/pXXAdpN4jgcm7MvbVeTSGnzK5vxY?=
 =?us-ascii?Q?g7YDI5mHyJphDsdGN2e8/8oCHbEEcug+4ep+Al2+2kB3D76BH7Ag6pohzJ0E?=
 =?us-ascii?Q?6mAF4YagJm6SvvvVHQB7vAf0cKIY593J51H5QiSegl1+WMrLYtca5SnbLHov?=
 =?us-ascii?Q?bh5c8g3F9K4rv4sBVcM5b7MeEQBPJ3xHS8Ym3uiOVXd+Ft11WCXAwQ8CNKSM?=
 =?us-ascii?Q?DjtOBRV6Ri854ToU20FqiALTowOQbhUIjPo6BM+T0W7TQJjxfgQcShwTB5c3?=
 =?us-ascii?Q?Dlh0BK+kUZ4PCJCtWHb1kK73piLz9084mIcCOrvTNopuiKckW/d/X6jVz8n4?=
 =?us-ascii?Q?O1L9oiq/aDFH3JlPeuIBBjmRol+G0knM+6f3OEjIdPyIM1ITld6pdAVcIlWK?=
 =?us-ascii?Q?QfZjVzdptrj3gYTnfvG0Ld83GlR1NA3CPBeHYDhTjh8v7OXiess/wETigL4x?=
 =?us-ascii?Q?icXn5P6F4R7Ddt7iavW2DRVdY1yyGGQr0Ox5M0O2XFHQQFxISlfx2QSfI2eg?=
 =?us-ascii?Q?r8LKCbg37/sPaGUywN3xZZfgkpggFarWTZ/U4BHjPHy0g3HuF2vDTgIkzgSa?=
 =?us-ascii?Q?GUp9ns8+bBGxzT+BRuycgcw1ze4Tcx8/et8DTrLSsPi1/UaydhghBpAHtWnt?=
 =?us-ascii?Q?6tt9zd950w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dbbd20-70b5-4366-d1b5-08da19609c14
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 13:06:35.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJhCg68lg8eg/aDFZlnonKs4pL3x6Gr3CQpbTmmvFwt+dORAP/WpsJCsKSA8rgYv7ijvtr75n6cHmmTe/7CnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `if (!pclk->param.csr_reg)` with `else` for simplification
and add curly brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/clk/clk-xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 857217cbcef8..0c3d0cee98c8 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -522,10 +522,10 @@ static int xgene_clk_is_enabled(struct clk_hw *hw)
 		pr_debug("%s clock is %s\n", clk_hw_get_name(hw),
 			data & pclk->param.reg_clk_mask ? "enabled" :
 							"disabled");
+	} else {
+		return 1;
 	}
 
-	if (!pclk->param.csr_reg)
-		return 1;
 	return data & pclk->param.reg_clk_mask ? 1 : 0;
 }
 
-- 
2.17.1

