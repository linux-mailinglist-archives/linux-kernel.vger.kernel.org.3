Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFA48E8B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiANK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:58:16 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:4932
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232895AbiANK6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsfMuTfQ4aLtLwfjaOtc3jQ5GMfF77iFO09k01tbKjW0ZUWaZK/Ia0LvyvqkzvnMRAi6gNNQnJ0GHJkx0oYhJKIYkfI77Z3nmywmDdlhWhPTiG/Na9oqfDCOb72NVIuGTAK8MJ/9TkA53Ei7ZytDf7ZHWTJh0h7CsKEkSaWD6u5qucLSyPrvfhO64o6OwcD3wBX0k+83tdm70izc5UZPiZws9ojKyII/fcc00H8ArEZr+65Km+nkhrAR23ZASCY31EWjpzFPY3j8VMdu0fS8eowOpKPZdfUT8ksaVMMmNkB465X3+EX792IDjuxlxVJM0a6ax1y16HU5aaje9iQcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuzfrNmYPm+B6YuFUOeBq08KDgxQLLiksMglEVSKzNY=;
 b=dHpTLfEYwIqXqGj68GwbJNhZf2xte8Hc6ryHGVKz/ZYlreeF2QnOc6Dt6nht40S7c/LmHMJKTKmkeFMCayP00woMhT6hRhd987Dltj0zq+F981ehhgz6Qq6Hyh/tlyspVKWzX4buIQPIa3NPALiMLv9+t16NEmZhYjX1G0iKtoMp+i8zr+Yfdy03yDpw/Usdv9B83aKjeWgIvEc4UEIBjGpeeJrGW9KNpRNSxxy7hGfyaARLGHMNAKJPdtimba8dHt+IeNY0GSf9L69zIVUT5fPFvY8yMTJqVIxUu9A4jbmaDKqbry+vYzO99+U0niXKBwfrWWY8dsGavS68R93l3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuzfrNmYPm+B6YuFUOeBq08KDgxQLLiksMglEVSKzNY=;
 b=y4BpaDZjqwrcN5Yr4BHommobslf5Itr3an+w0X6EXBKZiWyZ/uABvXGRHtXLyt4DC4ryKsz6O2RTUCWoF3J7hNMFH7kxyv1tCcmQaEasoUzvfRyi0qjWTJd2fm8NGr1O8hJ3JpUytVRdIJsdtD6QnMPs/WQXQvTqV2Wq51NqbVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by HE1PR0802MB2282.eurprd08.prod.outlook.com (2603:10a6:3:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:58:09 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::809:72af:1fb6:1294%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 10:58:09 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 1/2] dt-bindings: media: video-interfaces: add support for dual edge sampling
Date:   Fri, 14 Jan 2022 11:57:54 +0100
Message-Id: <20220114105755.730200-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114105755.730200-1-michael.riesch@wolfvision.net>
References: <20220114105755.730200-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d225679-5cd3-420a-df32-08d9d74cc038
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2282:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2282A8E57AEC60D226DA851EF2549@HE1PR0802MB2282.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elNCMEu8BZFAHXo3raBx6fr2df6hV+3s/DnKPvZaEsCg56rmArNXgwOjHIxrKb57ZCMs7eEoCpshJJbmk5xL7uJ6/cMHwVODqkodQtr9JpANS4E/4zRcTeTfuIctjGzMvWkdMxWorZ04Lvq5VURVflPxMWx4edoMY5vkUqXe3gPJDWvEM2/RG7KxP9VbgL0n2mKvK7tvER0N/n37M5mXM0SPODyEoYJ2ImqHPcF+dUYTjqWHw5uem4O1XLa7iI4LTDYTkuec8ixFyQntK8Tl91BvVW5GQg/UhFbiSmmqhOtcdCTiX0FjHoz6YSo4nVEdt5nS0GLYZpp2so4Hb8iWAktNZrhyxNlbOR+Eo0sN0B6ps5f1Xzu5xpfo/dJWNiD1QASDV+/87H6LUNEfKe4DKnVc+WzClJ7k09wMF0B6n653g6dqkXqRA/4DFtzxvitFkAs6vlYLNCXTF/5WV4DcsUOJVdRTL/m8FaJ3ySIlmqvIwt7kSt9zFaYI5ADS5nJDHw7DrLd31bZr18Aij3WP1M8RhwO996zaBe+2JENvfVjUsBnN9fIwLG7p9ozvggaa6aKyV/ViWVphdZNdMvS/lqKHAyYxZwnKLjXvQ8RvS/VWH+dClQxBitVdGie+eLex0HiTPCYBjWrRqez9MqU8jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(366004)(346002)(316002)(66946007)(6512007)(8936002)(6486002)(8676002)(508600001)(52116002)(86362001)(5660300002)(4326008)(2906002)(107886003)(66476007)(54906003)(36756003)(6506007)(186003)(1076003)(38100700002)(6666004)(2616005)(66556008)(44832011)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rY9D8Xz+cUEZNlvtRmusHmJG/fwxtU/fevWcaAqO9rZAbcmbv9BCQ1hA1U1j?=
 =?us-ascii?Q?X/S3dARnbbXF6iHMZbU+utvtJnP9tTmHWxru6CLyj0jCEBzpNNAvhY+l+CIX?=
 =?us-ascii?Q?AEQmTjbJk3VCgVfERITpqeO7tg4YAIdz1dMz+AxlxDi/P5ml7jQNtCvogv/9?=
 =?us-ascii?Q?sb+xD25BO4ujG7eCtF3wvBDG+mGb13h5dTLnhL2ctUINUbN0OhkZp1MKly7i?=
 =?us-ascii?Q?rAvMxo9e8lVbS+W5ZaIuA55xIUnW8o4E20Cgy0f/R0f24sybLuV1ux/RdRfn?=
 =?us-ascii?Q?uFSL54SD2sMd2AsQlcZXIhbrtiV+9qZ5tHr+skSn6VHaOHqQoHTjULYcu2kj?=
 =?us-ascii?Q?+G2GBbD1xy2F+rG1TEQAr/qP2jjHT3MbhJx53JrgxZZpgo2aFa8RBWhbRUwq?=
 =?us-ascii?Q?h8EmzcyhnSX4zBTWOzY3bC0pkKpFrLco2/40UAsuHMGGpumPbWlMsHkj4Jwo?=
 =?us-ascii?Q?RwgIrph4AG80/N6zHy3i0Cz76D5b+2oZ1csZ2+sVmoemzyFFzZmm5PkN2nRH?=
 =?us-ascii?Q?cIQxx/f9Ph0ToXqJcwhi5XUv9NPJcuy2LaGg8cFm0M+7m44toUC9O6MFWnNJ?=
 =?us-ascii?Q?jk6VGor6349rjRmqF83dkv248DKQGSOMa+xdvpWD9s/XG2c4wsKYMifiwa7f?=
 =?us-ascii?Q?guad46vuEQMo+omI4JefvjNk8+Eg3245E8j8ylt0WI71ULr+trpuCZA3Eyok?=
 =?us-ascii?Q?OrypjNzVA1GwaIfR+symP7QxRdr6LFx0F9dwAbtINsLpzmfxlrcV6aGYql6e?=
 =?us-ascii?Q?rO0Qbcb76uHFxxVbw16yhcaK1vGq6X2TpY6omyryJEDbEQPYc6lG03XvdrM0?=
 =?us-ascii?Q?N1329p4M3Ksq24wWS2GDw08nKABf4cBMRS7kcNZiFWk6mjHBE+o1n1ZWX8YR?=
 =?us-ascii?Q?1hGle4dLOOc9NxUs2TN66e8XZxM5ZbDBEYhMASLJXXIxvuKOngqyM9BKiEyE?=
 =?us-ascii?Q?jqHHoY/GW/YtM8UOREhxwLBbCo0em4K/w7AmdyJLNKi/+yzSyWFj/zUZ4FkM?=
 =?us-ascii?Q?aFAnR3r6iBDe+cNN/WnJH47ZlCPEFoai1MUww6skAj2xrgx4A9CMh1zzlcfi?=
 =?us-ascii?Q?6dSexQSc7xbhvR6M77PL7OTrDZiKyAgM58uCyKFBGEBRTma+rGE+TKr3HJGG?=
 =?us-ascii?Q?jivB1yWv5baSdLlStzEV78a97hgWlWlAlmy9cO4YoOcKz0hsOB/ea4yLcTHI?=
 =?us-ascii?Q?bzLA5eK+OJM61peVAExyZF691QAUqeaollcKyIxd/x6B1fnRI4ucdTD1sSgx?=
 =?us-ascii?Q?IWOryE5OXSfjcyBVEHdYk86K82ZP4o1qTNwa+gqWXPmwbr6AQ3dtd45uevY0?=
 =?us-ascii?Q?NEhamIcDezkyTBPcyGVUUHoMer1TkYTTc5BfeWMprLDFO72P1Ri5sES9Z0E6?=
 =?us-ascii?Q?XLfMuWOtBsTkh9d+grjWJ6G0iH8NqpRH+VkjQkiMs5Xad0Gg0nQ3lFU/RvVV?=
 =?us-ascii?Q?CgrtTVi6aV/HE593MFVPpFfqm1g7KO7WiDU4iFk86NTel5Jps8wpbc1JgnoL?=
 =?us-ascii?Q?YHkmQ298Dft3qugxLGfaIVn92DkTKQxWSE7LQz1iK29VPTBhANKf8X/FWqss?=
 =?us-ascii?Q?Sw5ObVtj+z0g9gkKp4Wr6bqkCD8BUNQ/sfeuujbjkY8E+CPwLSnFF5HKprxp?=
 =?us-ascii?Q?BdoBU3BnyJ8yGxx6V/0QPhtY9z1ShIYWjApMUW/84tVbfB8C2mGiWUqp4RVK?=
 =?us-ascii?Q?EdCywxs4sFy5q9tjyZriJW+4c0NQHsw9LJtAGNGLdo0JZFI71rvdSIuItgeY?=
 =?us-ascii?Q?YG7zHq1E1g=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d225679-5cd3-420a-df32-08d9d74cc038
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:58:09.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKVBSY9btYs/gilFvKiJlJ4v0GnQLRlCcgozSAYbbRKYao8f09gsyf3xuYG0PkBAcyxKnYZPjD2gt2Wfj1rzHqqOsykZr05apm5zEmfdAz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices support sampling of the parallel data at both edges of the
interface pixel clock in order to reduce the pixel clock by two.
Use the pclk-sample property to reflect this feature in the device tree.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../devicetree/bindings/media/video-interfaces.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index 4391dce2caee..b7f77a255778 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -144,9 +144,10 @@ properties:
 
   pclk-sample:
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 0, 1 ]
+    enum: [ 0, 1, 2 ]
     description:
-      Sample data on rising (1) or falling (0) edge of the pixel clock signal.
+      Sample data on falling (0), rising (1) or both (2) edges of the pixel
+      clock signal.
 
   sync-on-green-active:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.30.2

