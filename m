Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2F49EC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbiA0UGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:06:55 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231156AbiA0UGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHbV+wkSox5XfEXJgmgzH/KS3zKsQ0Z3/xxEdKWVDD+/avvNYE/Dt5UeT7VW1KBKyt9Nx4ojrHj6mWqMVinR0X+37hsnpQmpFwPnPYsI5Z0Ez+5rglkhAI8NBDQeUutMFxkkG+ggFxqsof1pCR7G59/mNsfoJz8OdU0kUdptAFCMUAnUSRc4nBUl1liqUd5+kJaX++uFneYwm9VsPBky9t3zD+hMDx8v0bP5UBqc1Vgfn1OY8KXtideGyAkS+9wrxW5TkYUbtQE7cLJcAXfeLpiVTGwvAJeYPU4Ymh8h59nh8sedsWUTW/y4vTR/Ei1vKtANoss43DOwnDE+VCKLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46Vm8bIeJhU1m0VRjX/9XSG/qzVTA39GNLwzLHVb1Mw=;
 b=GnROZ6WQ5IT+JTzgKFXNS3sd9hvU1Kl+zsz7m2W0A6d5K3EGcBYCbigdezd6BBqxUeieyn8gTWA3Xr+JAZ5TRZB2dWGJd+padYe/l8xflF4KfKo3EgQ8RN+CEzR4Yg6RLr/8Nkoldp2ZnL5jEmXG4zaXlHr6owUqEG3kQHPzsGVVDEjJyu6ic/6VwKi7weZVkUtvBaCLFbaP9WkTVslZphSN2Y/e5uO1QI6sUah0g+T9lB/55R3be3y8n/liQONUKLnoTDIwc69HNlx2ZXr3siM1RIsD8C0Bn/44gK73GcR2mrwaeG1/7jnCrvxXmf7DHdvMpg5jaHJLbHBHiTlD6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46Vm8bIeJhU1m0VRjX/9XSG/qzVTA39GNLwzLHVb1Mw=;
 b=bNkvicjWjMVBrqoDv8hKoAzOrNbuCApT8vKOV4GHiSTibzrv22AdURYafFf0Zr+LwzKBvIN/o6B/dUkjABMDV/J5bpJ4sBADh63CIqtaruHN5OGUgEDtZeEzfowM6gndeXVeRJCVAh6KJtoxHtjkVZgIZHybDk6s69n9vjx15VJh3HzpTbD9t1KMufJoTAx+CwwL65dKtKNTJEg0Dsend/1I5qYFQPh39L2I5Kt1po2X5mHFvFEHhPKOlsIWxgHsCvmv91Msk5pA5dJw1bvLWIb+qoluxsVFodMEvgDy9o1qErqYBNjnN5ikzUea3SiZZVQyqfHzhro505ksP12bOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:49 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:49 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
Date:   Thu, 27 Jan 2022 15:06:30 -0500
Message-Id: <20220127200636.1456175-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127200636.1456175-1-sean.anderson@seco.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c9f9522-0ada-4588-7550-08d9e1d08dac
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB3747BA80C206F66251852EEB96219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kCFidDosfHvSufI4Mbb+mrlcsk8bwiKCvO9f/a6l9b5/otLequub6XnKwr8zBuCKiw6s+dK5/NEBh8FFJMUM5WwFJoVbDbl7FSHBdwwIyhCDxL4NAEQpnbz2ydmZ/9jgDPKW2k/pQoK6OVRHSB3WrpK7IOyWDzM3nqU8Fb6RTTsTPzVx30eQATjjKB3bhz12j7T93piPtkr5G61iaBPkK/y5JEfwnJX6OxOPYfSkQGwk1RF7UepUT7yTpIfCt+D+6llG6x/Qp7JDmoPTW8Ld9s3UQhn8Cup34QC1THNu2xOvUsEetry7MKhXfJBHEU88KTldcYtSLRerdJCNao7ovFGm91VN4fMIScX+6YQcrNDn1MC9A71tM970Q2D+CIFOlWrNOMyaVAEbnU9Y7sUDLxxDLU9//FvaLWIxIbJYHoZh0yqGDLP3PR8KcroJVxUTDKV4WQj6icqwFNSqyrJQJywUBuwRwSr5uwj9u5GF3bLE0+PvKw4OfcXGXuNSKX4ra4gmFwskwwKQmU4gTpR4MdVrEBneud6N0KocKm8fXIjCnKuiGdaL9xnUxYpXbc41geKdpawErgdNDZA6To6hDq6rrd7GOshP7nwPFn2JZwILzZbcnl5KtmhU+BQqJH6g7HS9D8OZPEH4MqNVu2+HUPYGqeuGSXjTFHaNDMElJNv+A0wp9QRBmB9nda5MjtL5iU0PLOigJNbmoHJDbQFXL/JcrCsHvJj4+TWclDLs+f2dzKobN4Wd2ATaM/UZsfUmC8X16E6ee5IzeC+YTaSm3p9wI899MiYtWLXfamv1XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(7416002)(54906003)(86362001)(966005)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dg9i1cwKlWCGlGmv34bjA7XuhivQWRO5eFDzaamrkKP4sIt48NR8FpYNZ+Dw?=
 =?us-ascii?Q?dY2HmIbhth/oP21rs9zMOV6yviqQwfriiJedH7mS2DWeBwtDlQSxzkWyFDXk?=
 =?us-ascii?Q?8zRt6lTmXp+a++XeNY8CypwsD6bEyZkeiptJ4slQrky4QC1iVWforFBdzDUZ?=
 =?us-ascii?Q?wunMT3vYhzT93UsUsyvGudR48KIltEb2EIAGvTrVt5g9rwF0v+pyY6WxUT+V?=
 =?us-ascii?Q?UcCJlAP5nkukpLjwouutMJLCdB7uoaITag4YfMarS8ewEfIFXdwY817puIQE?=
 =?us-ascii?Q?AAOK5QoZSAe5exc8lh4XNqDVqmHKeUltEjLmiailwRMRdJQIdW0IAp1E+jvs?=
 =?us-ascii?Q?X9+/1qcB3Hmw40czHG6ujnqmBYme04jcfH43A2IXUS6Gb3dykdTUFuIIFXNH?=
 =?us-ascii?Q?1SstcVapYwLwJlW+UmcvUcTP6Zshljyb5FZNxb/IVbdWF7+t7DVZ4kvTnFGF?=
 =?us-ascii?Q?ufZjovEIfbEuQTOwc2B3mloJaUNqUy19eaf6F4lTpIvmnfA/35Z7W9+Sc53L?=
 =?us-ascii?Q?cc2G5E0Y2I15N9kokJgoZtvdnsBZWsg4w78lRa3y90ewZQB+REmo+w1mQqkZ?=
 =?us-ascii?Q?NM2GaqLyXTYne7vQBijwvzYr2s3Pqgphz2QEKhD3jmvNfwzDtugFvD5PVJME?=
 =?us-ascii?Q?vvh0xQ9p4kXU0l4YZQZquJaxLGfvrmyRlaj+OTOZDrA5ASPd4wwG1ANXj2/4?=
 =?us-ascii?Q?8h8QnOCwF0hTXGD/QqYifPss2KeHrJp915UXAflj6mtNDWT3Bq9HCsm5FCnO?=
 =?us-ascii?Q?RdYSMIl4xCKQpAe2Kb45Y7rxJDJz4aoN/XCh+SrVBU48zVgoF41MryCabmvW?=
 =?us-ascii?Q?O92mub2U9f9+/A1jSzrdpujKKpy4I4FgN0dUK3/uPsvXLW0XEDQuC5dwGfBg?=
 =?us-ascii?Q?9D+EjNMWM3CluMN1DMQ97KIjfOrzr24eOmDu9r91KgDPxoP0WNz1Oh9h6rVB?=
 =?us-ascii?Q?nRhaLCJrGOz2jWb7MzZK2QkTXxFobavI3F/9YHwqMBR88oHaB6MFyGjHxV2N?=
 =?us-ascii?Q?3KcSNwHUOw+mNDy8JuObwxG32i8qbNxlVvn/rSVJagfzpoEONFXDEgDvq+cA?=
 =?us-ascii?Q?eIZD/FO+6Bnbq0+R3tkyyhVXNMrECYrvuS7UDuGAfGTJXzpsafgTFkk5/opL?=
 =?us-ascii?Q?0LUHrsySOO7MuL/Ec7vQc+spzjbZ9bPcRiX196xEMVtufh5SbomT/tjTxd5+?=
 =?us-ascii?Q?wPQBx4FTsW+Hff4ddXJMbj7RMRBTh3M0wETiWeinqj+AXuvdtCA3017WwqR8?=
 =?us-ascii?Q?YxYpl2NZO2r/64Y/7XCQPS+k0Vjq9rPhCLX66kXybxof0Cy+3IFMeTJf4hzS?=
 =?us-ascii?Q?NNv8wtLlK2mt2RkngRolT8gQLzj0Y8at+hrYldBO551rGAvf2zVEr3Ua3XqB?=
 =?us-ascii?Q?7XzMgBVra5i0GYAHWNEviX6qb0g/yBjncvLrX42Td2kVI45u4LCpxqM6w3Qx?=
 =?us-ascii?Q?uhREOpe6SO3mQhLerPPTYUq+O0+deNwr+3bQ5EKF7Mw9f9h2cRvY8S6m3cWo?=
 =?us-ascii?Q?gFM879zmvsNnu+U2MY7vilVtcXDd98tdEAg2jKYnG5NBR6j2ZZ/f0ub0uYAr?=
 =?us-ascii?Q?QgSs6iATLRQX4HDGe9NMcTCsXMyvldL3YisWB15ESthn6MH6FB4t2mFpGr3E?=
 =?us-ascii?Q?1x2ccpoB49GG8x1tra/eLg8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9f9522-0ada-4588-7550-08d9e1d08dac
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:49.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKUlRb58TOkKAs59Umczkh0Q1xOwojRx/g+Una0+EGVprL9GORLhwF9vN7CK9/yh+nD/jSpRKggYTOeH+5b7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is redundant because we can determine the correct value for
REFCLKPER based on the "ref" clock. Deprecate it, and encourage users to
provide a clock instead. This also restricts the minimum and maximum to the
values documented in the register reference [1].

[1] https://www.xilinx.com/html_docs/registers/ug1087/usb3_xhci___guctl.html

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d29ffcd27472..4f2b0913ad9f 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -263,8 +263,11 @@ properties:
       Value for REFCLKPER field of GUCTL register for reference clock period in
       nanoseconds, when the hardware set default does not match the actual
       clock.
-    minimum: 1
-    maximum: 0x3ff
+
+      This binding is deprecated. Instead, provide an appropriate reference clock.
+    minimum: 8
+    maximum: 62
+    deprecated: true
 
   snps,rx-thr-num-pkt-prd:
     description:
-- 
2.25.1

