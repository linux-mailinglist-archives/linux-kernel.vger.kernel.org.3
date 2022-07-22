Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE357DC27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiGVISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:18:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CF9DEE3;
        Fri, 22 Jul 2022 01:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEfUgRt92qzWAbF5kdguedH1w1THpTacr77TB/bfi5JNaDv/hJxeHJTC3l5507L/M+eGBjcQX/JXSI96BXL0K7oR7Zo4Dw8mBED71NMr3Gn3O+Kqyey1t4Y2rLEyA629yn0P5tWKwBmjLv8kyvwrqHrNvawZ0dSxNF1DI4+h59MPUBhVU7ec9YKQ4/rjXAI+q6Qenz7qTsCRFLNtlqFxjwPSGkIaj3Fw+Qynl5qoN+DsCMOjktUX3F1SO5+URi9haPRpBikSn/jYktT6E0CWut240rkiD2ugvTzw4jzpLnp21ERUx70fKjlh0MRXTOSPUURNMIXa4NsTH1OZMFDljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PII8ZTfTSFW1bBpp4hMzebR9TmVODZU7ENQ4BBYEwW8=;
 b=Axe3Hkjwww9z3LxqVaam52EFnFeOKV+uGbzt76G2uxepIy59R0OxZ6mT06VIMKWvQICK8zijHP4SnH8deSYJrSo3SeTTsaCLRA/4zYcBEURuopvBSmR0Yd4vHLRZpmwY72KgvF587taG0g7j1s4AUxHx25Q5IKdOEsirrNxbBLw9ivucT49ThX0yp78Un0emSk+qb378HRUSyVCl8B6tEgY1RFWqGvWcY+p5ZweegT3B+RohhnF2rp6RIy9xsvIpPrnM+HS+GoV0HkwRbRYQnr5OXxzPgqyPwQ11PSN+A9e/YsVArMEm0+9tfL7xlq/26yHJ/JiR6rfwcbR3++ZYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PII8ZTfTSFW1bBpp4hMzebR9TmVODZU7ENQ4BBYEwW8=;
 b=oJ2hh3SN4z/Txfd21VWW2WznAbtzzSx9w1pCYB9Q3KE+geGXBMJW5qIOgTmtZydYeztdTm4OL6d4R7RE5zLl6k+TdLkUzR4rK88WmY3iNPVgkyLBQIObjTJ3jVsIhgWRYjeSVVcmGSsEe9tJOo28Srgkk2yBUtSrzKY+4y3GBAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BN8PR04MB5986.namprd04.prod.outlook.com (2603:10b6:408:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:18:48 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 08:18:48 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: typec: anx7411: fix passing zero to 'PTR_ERR'
Date:   Fri, 22 Jul 2022 16:18:34 +0800
Message-Id: <20220722081836.3380885-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51444700-8089-4749-1bf5-08da6bbacda1
X-MS-TrafficTypeDiagnostic: BN8PR04MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WMzWBUJbX3YzhiQpofiQGmw4oDeLJVffHrfREL6+DcUJ0RZX8tbPQ3OZonSm+FYP9oQG9d1Wmsf3AGCAnEKsVD24dGF+qasqMI/8IIph2t6oI6DrNuq0t8wkBsBh41jRgxVLCJClNHhjYdBx3WyfnxEL6dwMYqiizdxT5ZXNSwE58wn4GEyEbDXfcivUV4LG6uH+uwPUyWVblINeY1Vd+j7Yb87a0ovuw4euSEME4nlczFOpmbSaW+A/vfLN2OA9fulRfvLFieh6kxnrTBG824gR/VWqVT5oDII6pk082JdFOZuyXgGxRbNkgddTWchKfLue+G4rRb9mHLLuFdgYsrdsLV2AksaD2b33ogOQm6sSVhxz1ETE31KEOjACRDFnGUhIcBFuNmoSn4XmgmVTVmnUWj7pzmRvLBg4vJ/yKJj14blhlaJ4ZQBrQGNHeoS1b/JHWLxk22TYRU3JpSaP2Ta/GCoDqfBAWo9Rf7sDVgYuUOBr4gVHSiJIFiQ0oNOZdOfIrx7Izc9OxJI7A8bMaZpYYO0vAtgxiqWLZKPhvlU5COjAPfjhg9b4xJhYiSFPbRza4gRxny8wdsoK1XiXP2IM2juf4Sgn2dcpElMpCy8Y+ulRQjpP4fCEgjgMqQmwOS55Bxi4gkfT5WfCmkYMB+HeCgt4f5TJN4UtKWvVFyUfkJfzh3wBSCTPz1+2W0OfmAlS6AETji9Qo5ASnlVZ/t1s0e5nO+APusea0nqMsbwql0Wg1xy/OV0Uz8B3uXDyB6+9UbSxGIIFKsJb4xCo19CJ0XSiMVsRSxBA05ECg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39840400004)(366004)(396003)(4326008)(8676002)(66476007)(66556008)(83380400001)(7049001)(66946007)(6512007)(41300700001)(6666004)(2906002)(26005)(478600001)(8936002)(5660300002)(6506007)(86362001)(52116002)(6486002)(38350700002)(38100700002)(110136005)(186003)(36756003)(316002)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U8x8+7gDKBUVQPhvRRnIh+/G0nQJXfWjCiMXZsa0mglyFpjrZbGAGukAVPM9?=
 =?us-ascii?Q?EG4Mvqkbc4A6azIkzbGhVgLLe70AU5Qmj63iVwrm+QO9LYzfKpJVR9lMRUOe?=
 =?us-ascii?Q?sRNIBa8EU8XSUGhpXMk9uSVGlfYucru9EIZk9hUa9ZXAuqRaIFcZUXsCWq3g?=
 =?us-ascii?Q?od6eMy2oV4mQJW/gSdfhdrGZZrqPu/g5QbXlk++06P2ijgdIf4yfDsNhrGpu?=
 =?us-ascii?Q?UBrwlQ6FJ2amC+hc7V8Hlm324FMQr2+r+BH3DquiJ8MAfTY2XC2T39HjKnfz?=
 =?us-ascii?Q?WSnXT5hL/FCPPXIsw8BX1fclM/n4ML1KzHcRq8iArdXcQuXhpMNgEn0MRuSR?=
 =?us-ascii?Q?OSBWShPKoVCqnfNRZsdjzEEHu5c2CygDQT0M5VMH6JzsdX+zQ7Dwne+R6rUH?=
 =?us-ascii?Q?NTnXKqGr8Qqtbz6XVHr1ZKw555ZS1xgqK+QbmgqihGhcHJO+W0wJYkbt9j7k?=
 =?us-ascii?Q?4fCSU6QDnzGPF5S8ovuBUM+Xk/KK5rPrfhS67qYu1r66GPNJIHj5PFYemmcs?=
 =?us-ascii?Q?kA1SLEEAvhzYAN0Cwm6oQo1nX012qVSRYw57cth84UAOyZS9/dLG94uq+76K?=
 =?us-ascii?Q?gUP/U5z/zl3zkotV+9+fnKUzKvk3OiAnhdzUW8FI49Gd4pznsFSS4pMrxOIv?=
 =?us-ascii?Q?1Gh0flof/z9Mp3RuAJPpSjsWZiE3hue4KG5busG+jbn3MyewhlFAozCLJ5Ud?=
 =?us-ascii?Q?2Hov7yiuHFB/2Uzdz5sng3y2/QxzyCWYsCxwgSQSHcNYjOdigD+sEWynbkBd?=
 =?us-ascii?Q?25PTRa85kSRXM5HU+jl1CZDRzaJu1qBmIL3ewZd5CiGBq6EQh+7o0b8SLDkS?=
 =?us-ascii?Q?mIlnCQuBlsDjcxEqb6F14jMAEj6rE0p5tIj7I7NdaajzcvpEZnmNPxGZkRtk?=
 =?us-ascii?Q?AbQs/508HWZllPF3zEKnTgNMzSh1OaavuobVkKrXEX3UofjKMSjqXMVmhQoi?=
 =?us-ascii?Q?ycuQL3ZIR0NDyi7y87gcYvEmIHUV+QimqcG2OZ5Ey2CYkav0ehvPgqbrBRLH?=
 =?us-ascii?Q?lV371uiMnuXZtvb2u5jtIHxKcKqgk5bAPNTNp4P1b5y02zMxUta/cWFEcjxg?=
 =?us-ascii?Q?+6B0Uyz6I7VmcQydVWi5JvJFUyJtMjc1uZ/GEKbhOysjkHBm7TbROgV/AgPC?=
 =?us-ascii?Q?le0nWE49PUYkLDjlstkjt2JBRIjIKgDymqIqoZfVWZe7jREJtawBLRwZj0kz?=
 =?us-ascii?Q?zO8nsrKYgwWXzvN4mLqHXJi25u39QkLY9970PCNfrsaGlxZQIAej6J5V7Wr6?=
 =?us-ascii?Q?GnjasoAjLWfm3GXrpofcSps6VT219h0uM5FP5GPTvEb+C6ERTUSdvhn02jeT?=
 =?us-ascii?Q?dzmCnn6DOZVRhmevX47eJ73ytQ8bHVSXIb7BzvatjL6+7fg7//EWMwzWKY6j?=
 =?us-ascii?Q?rL/CBjEWczKopA3LdaCQRFN88u7y6U/9TF6+j+xqIqJIF9598MXQpS0fzRYI?=
 =?us-ascii?Q?craePx+qi/W/38hOjp0ubHtydme66JZHPGEq82YTzHZ4DCXZIc3O33SUM2Q2?=
 =?us-ascii?Q?5HC9NxN9Y5DS6StfWUoAOM0bydhA2/YSoVW5yP5Qm7rGBbuK/4o6RbstR607?=
 =?us-ascii?Q?FSXLLFnh/u3ILvBs9vLoa94mlSpq/GcQ+MFP4W94?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51444700-8089-4749-1bf5-08da6bbacda1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 08:18:48.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go6vw5LucQ2GynlV8c4MQkMsPyf2+437A60aJ5JPa7egkz8QcM7MZzQ0N749uvz3+P8AaH0E7XA3FAUMgVWFXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5986
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix anx7411_register_partner() warn: passing zero to 'PTR_ERR'

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/usb/typec/anx7411.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index b990376991f8..7b45d7440a9d 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -374,6 +374,7 @@ static int anx7411_register_partner(struct anx7411_data *ctx,
 				    int pd, int accessory)
 {
 	struct typec_partner_desc desc;
+	struct typec_partner *partner;
 
 	if (ctx->typec.partner)
 		return 0;
@@ -381,11 +382,11 @@ static int anx7411_register_partner(struct anx7411_data *ctx,
 	desc.usb_pd = pd;
 	desc.accessory = accessory;
 	desc.identity = NULL;
-	ctx->typec.partner = typec_register_partner(ctx->typec.port, &desc);
-	if (IS_ERR(ctx->typec.partner)) {
-		ctx->typec.partner = NULL;
-		return PTR_ERR(ctx->typec.partner);
-	}
+	partner = typec_register_partner(ctx->typec.port, &desc);
+	if (IS_ERR(partner))
+		return PTR_ERR(partner);
+
+	ctx->typec.partner = partner;
 
 	return 0;
 }
-- 
2.25.1

