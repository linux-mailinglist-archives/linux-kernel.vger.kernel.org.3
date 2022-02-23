Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D064C18E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiBWQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiBWQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:39:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8790B91CF;
        Wed, 23 Feb 2022 08:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpIx2G8WKt9iq973VTy+9CHhyTV75mB+2+gsBBKfoGDi3vzM+WrnOYrHG43VeD9sIP+2nLapMmSdYhFlfybhlUVJ/2Yat94LvhUu9mLb8m7Txik0xccmIcfMdKFD6JZqF15KF4JJbGrfH38EB2Vq037TPQRLYwD+2Wg8Wvfv07qYLBOFG17mRFdsGFqj53ZZfr7RbMHumNau7Z62jeguWv09NdArz5qGzUzvG3KOtpeDVsD5OT0sXGa208+xy6hGN4CNT+L0Ec7A3BvbF2Vx60Vk6sBaf+yNJS50TsFDhFuZn5vcLp8o/eomBr2j3Dx+luss+Bp8BfOwYAB0+Pq9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/0gIZG7+YciRgoRA1fMf6PicAE4HT92JknzHSYqlU8=;
 b=E+u/6n4AYoX+Lr/qk7idAKJjk3/zMf7jNtV0JBhF9pCHtzEQjY9DSIFDYt4wwHnBqWcN87cmRmLsckaV/blTX2oUxKf28IfEC4ggPvWipBgM/Xp+t78Nb62T6wO1/lW3b6X9KOzEV+DSj1+5TJ7U8aIbd075JtwoWlYlcguCu1cPJufrOQ49qodF33uTp939X9s0dEkAsqh+DtgsHBV6Sx2T6315Z5URbTew+0I0AprgSSJ13enSl3WNf8uqGDZS1avWlQdgQlCrQMcGZlDSdbwXywaSyw1THbor25KUz4VVYx9i7Uk17Mes/VTONpZ3vU2Qk1LfAlEKeoTdOmk6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/0gIZG7+YciRgoRA1fMf6PicAE4HT92JknzHSYqlU8=;
 b=vCiaIlETGH5cFJW+OWuP5fbcjfwf58zyVv/uc+tdjh9+DDKxnRMoIjSijG1kGYC+Qgmu0wZheZ8ONOkwKadIiCZCZaEc01je7w/iUlcVh7wDo02cuB84Pe7GpwIuUvlLzOOknMO50o3RE6f4Z3yrJ7v/8S+wVdXd6n9tOJSrjPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3456.apcprd04.prod.outlook.com (2603:1096:404:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 16:38:33 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 16:38:33 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 2/2] dt-bindings: hwmon: Add sample averaging property for ADM1275
Date:   Thu, 24 Feb 2022 00:38:17 +0800
Message-Id: <20220223163817.30583-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163817.30583-1-potin.lai@quantatw.com>
References: <20220223163817.30583-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c81b200-ff5f-4e62-7c9c-08d9f6eaee06
X-MS-TrafficTypeDiagnostic: TY2PR04MB3456:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB345613662EA41001E92C7F408E3C9@TY2PR04MB3456.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOa7KJA/iDsPGcRKgXPLCTNrBUSfZEh9dI3MjIbPl5r6DSvMcD7qNxVFLr8FerAmzUJniU8AsouZbLd5hfhyRUVUu9sKBeia68ms97p3QqzSFNtuW7IRfjMpHszjS3Gl/wThuqHLIQ7rkw70bdeQxxZuYBk+xZv3vepqroezZNTLZCHP+vRkJ44MhRWhWyCYhL/O4htX9MQ9BZNtGMdcCj8z5eRFKclaKosEhtN48DhobaOktjytGnJk6174ndJ7u9tKd4IoHzfTyZFmzkX1gYLMa11XLYMsxFZ7T7H0Y/uQbMkidzPJzyNyVQYM1eIz/i8TYtqvLruIdg4qOEumTmIqfPdxt5LlmJ3F/i//QXx9wl6U2MhdAa5pIAG0rXpWyTx0chLJenAam4J9Xk96cE/AjrH8u6JaZcFW4YaCL1WRO2U0j5XWW++9QdYjzD0Pv3JHFbIKB/xlc98KFvJAqDMQhRdmGWEGXDH5iiuQ6HzyPvsEDxIGU/BhI2FwwKz0mNtWOJC8QB/vTTatZtq56TzaYD2yw9m1P/E4vvcqHHV+5XgKZjHJc7OFd8s7Cg+FNpRuY1M7G9dWtIIg7e0pcg0vvjFnFN+8qulhA8pEkSsiWHjagtzwcWUS9hNlFtD4F54AYSW9tQ+vDdH4s2xYEqsF2ZTCoSkqbJvDPg6FSMQ589JG3WFuSW/+zvmtGKDIT0ZTZmxeDXaQT3svVpNbJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(38350700002)(86362001)(52116002)(54906003)(36756003)(6666004)(4326008)(6486002)(2616005)(8676002)(508600001)(5660300002)(26005)(1076003)(4744005)(44832011)(8936002)(186003)(6506007)(316002)(66946007)(66556008)(66476007)(6512007)(110136005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMAzb2MZmGMpVP9qzgfY55Y8yr+zqdP0rbepvjuEIA1mYJ6jvX0EnmIMKTl8?=
 =?us-ascii?Q?0M1MEwxmx1MCEJpQU5KeRkM3b9ALUGIXAlBfJnLChYmXDEu+54yMI74gPB+X?=
 =?us-ascii?Q?1CbXgnV+p5KSRfo6qRyxK+u/5qvGCdY9EuteRS5S0FWwf+9o9XJ7ABpoCfb2?=
 =?us-ascii?Q?J0ifMagWFBbRRRZEmcm2vKaFIW6wC/33mgRB70TMhby01z08nFFnsKOZ7CUf?=
 =?us-ascii?Q?bjUJlZ6vJvuDXo6/Y5S0owKdnNP7xv7TnNbYN1XBarnBKibJYDxPMJULkG8H?=
 =?us-ascii?Q?KfcSbJuv4rkPcN59xgPLh5hpLxo9s4wMOodyegIe9jBFAuAtdM6zRnUs717K?=
 =?us-ascii?Q?0mJajcImRlFg2tlLdwLvyu8x2lYyw7dE57U7r+cWvdZ9Y3UFVOJkv/pKOoD4?=
 =?us-ascii?Q?l+NOnX9FkCmtZeInp8RUnDqmSK5nWlTUbU7nU1Z3V9gtDYoR8oSzP9XvNcqV?=
 =?us-ascii?Q?c0emzksdQQpgJssoanWC4YJ4pwIJl9EUw1jjfCdQF+LdpOOR1eGOtAQODYQq?=
 =?us-ascii?Q?GxgeVlaX0UOEkyyLgc7kphJWMisggeeX5X3dlsvVFOgr03a/Hwchw6x2f5iT?=
 =?us-ascii?Q?WzIcY+oLn+7rdblvPLi2N4iuQA7DPMr/RjxJVIOqYIr8PJkKlhTcpJzZ06NF?=
 =?us-ascii?Q?G/63C6EpAVDDkFsRRXw8gqN7VW5r8NqeBIJSYlKMRxnZjzikydPX/OqxJAeQ?=
 =?us-ascii?Q?F98jFzFYV3W/3sC1K9KFbsP/Z41yo7duIrSFVKdgNMG02pqXOLXOUf4+Ki5t?=
 =?us-ascii?Q?wCUKI7I/Xupqjrc/gF3GMAFb079MmrXFAP5Ef2+jdlv+6vtdP7u5Sv3Bse16?=
 =?us-ascii?Q?RNhPeaF5nKsDe3DFSIR38nu+5JV4agSAfjXMyXA91EcGzkcn021qLqNg6mpV?=
 =?us-ascii?Q?1I/QR/fTY3Is3dXNTobSQyvN5QWFvexYT4MbwL4OWbmrFmHvwKafPktcGYeM?=
 =?us-ascii?Q?3Kt733GxsQqf1tnTKPNYm+qMuJLsFGgYPWiwYn1Sy2CW5tq8xuh7kmYIV46Z?=
 =?us-ascii?Q?hYcKe4eZuHp4IIVlnYfeKG0+Wok2gzYTqcVVqqUA9pW8vNae/8Z7bhzqGPYk?=
 =?us-ascii?Q?w3kifBjfC2Nrh2BzFrQLz2CGFEBNMRI+BOQ/kTlZjDBDJ7Sny6D9ti7gWFrT?=
 =?us-ascii?Q?GJEf5JOpoFUB65QiKbAY9iCWJD/NyEnK3/61mNNTqOUOOpD5KjUeRn+kjIBs?=
 =?us-ascii?Q?4ipLa6fNzB+jORRsBPQsgI4usN4ArANmjDGntSbZPL5RpcNLHtXxp2SeMmxG?=
 =?us-ascii?Q?LszOngPULLHvwkVSSaVvHTMT4Gbl89leUUOZF40UN29CjEy9QRqaYYBdoasc?=
 =?us-ascii?Q?AvdbtKRpZvItNjO/fzDcbntMmzyjytd7Kq/AUGg4WKGrFDeNxO7KiA7T0/gn?=
 =?us-ascii?Q?rYQIg1G8kTk2RDUR8Fm4tpRFSiFF5ew7Uu8MShviUxBYBuXcNeph1O4sWOdT?=
 =?us-ascii?Q?/C5fVzKJjeC98OmfWrprwwKA1jF2GhPSwAI8/dGQ+BvaQHOZwv/uEFt+zSvt?=
 =?us-ascii?Q?scj7+swShALKsD4HSvlomzEsL48Dov23ubB4QGbojm+h7OKl4twp67hlpoFy?=
 =?us-ascii?Q?QfG6joUtKkx7covOn5kvKVhZjQ/EE93y3MSBdQkdmPmFcttgzwQcduZEfviM?=
 =?us-ascii?Q?uUzCPpLa97pTGIDcMPRm1iw=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c81b200-ff5f-4e62-7c9c-08d9f6eaee06
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 16:38:32.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVDod9AcQMn5df/liJak4UAPopvbabrabagVCUvWdJZVyRXgOw5Vd9u2WZ4VsSevMb8d5vXSRY+axL7W4iMt5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding information for "pwr-avg" and "vi-avg" properties

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../devicetree/bindings/hwmon/adi,adm1275.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index 223393d7cafd..2525a67a880e 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -37,6 +37,14 @@ properties:
     description:
       Shunt resistor value in micro-Ohm.
 
+  vi-avg:
+    description:
+      Sample averaging for current and voltage.
+
+  pwr-avg:
+    description:
+      Sample averaging for power.
+
 required:
   - compatible
   - reg
@@ -53,5 +61,7 @@ examples:
             compatible = "adi,adm1272";
             reg = <0x10>;
             shunt-resistor-micro-ohms = <500>;
+            vi-avg = <128>;
+            pwr-avg = <128>;
         };
     };
-- 
2.17.1

