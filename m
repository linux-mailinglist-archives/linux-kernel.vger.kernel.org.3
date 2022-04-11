Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF34FB171
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiDKBlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiDKBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:41:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D444A04
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 18:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WskXYfvSCLld/WzWfkmZHXkpDfANnD66kISricmyTH3sFh+LGkn2xomAWzM9cC92vcT8uDax+HdW7Xq/eAclz92fIJ1pNb7fbr1QCDbxe8jleTMkf8p34d5Ft1wfTiM2DOvIC3ommt081WCd83opdfzgu4P714ZR8XE/mHGQ0gVO3vzGu7+0ekT7JA+fUOPUIhfwGUkRVfl5WmFYmplO5ZeZ5RvGIJJplOeESQJ+WRW9NuIKxTGnunanMCntoGjBuHb/o6uoct+R8UTGgK4IypC/79nXwzrt4/WrEkDmszQ4RN/rcvwHatgjLu6a5JYWSBLrtXrJPZjp47iXg5coGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg5ewruo7H99alC1cBgK7XYu5rj8HKuTQlXAPwKkHx4=;
 b=hs7uT2y4YLj93sZTLwOvtXFpgLBY/bH6Xm2sHeqQ4f6y0xYmvjeBfd8/F56tWnMjohXmqOG/a2s4al6SBdODmBetqrgAZdl4x3h+DniebVxgE99HSanVPoi0nZFW23IH7RpcwqYm49hVv8H/BPwpHqEX73hU9CdPiiZlJEb1rlkoI6W42yRPrv9VvxYmgBhXV0BNDMBdtfa1B8XdjPqisJFlqlVX5vmqSKk9i/MkdQvLM/W7przbzOTFmIX5TU1aRdKwb1SIWe3PiSyeDD/q5w4K/gYuMgf4bFWlKCkTIDDwjPazN7YjKB3ZPrryaIJi6QqEysGNDm62nwNI0cCU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg5ewruo7H99alC1cBgK7XYu5rj8HKuTQlXAPwKkHx4=;
 b=f7tetuE7zcpCvNvnzjmqyhrdzK1Yfikxn8oXOIOY/GV9Bgo/a6aHMPGxhS6tNjYY586Mu/HvlOboNyeiMCwwCp56YQ8IvA+8I1m7sKvDetrsEvP7jxI/Ys/AqLtoH+e60C1gJIgGVIOxTSYUFZa/tziun4AZ5hSNKL/7X0CthFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB3PR0402MB3785.eurprd04.prod.outlook.com (2603:10a6:8:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 01:38:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.028; Mon, 11 Apr 2022
 01:38:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] tools/virtio: drop phys_addr_t typedef
Date:   Mon, 11 Apr 2022 09:40:39 +0800
Message-Id: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1792fb-9a98-4dcd-ae10-08da1b5c06dc
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3785:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB37855B79A2670DE5A775B260C9EA9@DB3PR0402MB3785.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq6Yh1d0CJs7xPl906qGiRZWmeuhnZWzIs97sdoGvS14ImUGs8Lbh1uAvMDd94JqTVyxzVY60WKrT+Fzx+KIoUC81I5NEc6LxNa6K0UKK5bEF2bHOfkr5rNC+4gzq+sKkvA5X0m3JNUrpYI/n7ezSXJhukPilEowcmeSA8a0pkdq6thCc0JyVluThzo/kuJH1SYsyib3nYhmAQKhAFi5UmjPd1ZINJWwransSgAX66uGd2vw0L2LIMcWMl7olNrqw1ooiY33rTx8Ntrp7gE4TSL3rxtlVE9m6Jqn1jcOKkYUWhuWo7oN1ivnC521SJ5EtpmS2605bAqWHUCBBUW6yR06zDeKPE6avoX5ceYL5pVuBagdEPLCq1y+OONYhYRNVprHgI+feVt4INx+Qcqwo6pCF7vaddZ/8Y9S6nOfURAOjCxXB43uk4BWV9M0t0JJKPCAKVLhvOkP9wdp+X6QoCtA/VFB9xb8lxMaHb4KuUYNOE2M9Jn7ihnamdRDmpDcPJjHslM2i8LlWMTE3sKzlpNdUdseL3vktkfoHMYvyu+GHTCgbcAG8HpiTYETOhQj5uYN5oE76tAxqK9hC+wPetLMkHRmvENIf+g1hfmeByE7OoPZHa8NmcABoXwN5awK+KLZBLEeyDrmBqeAmHPuNkEkzoRWdEsXcS8DgpDKCvsybcZkkw06Vu4Kd3a3sdyTk3/KeSEAvHm2P/Dj8s7hNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(2616005)(4326008)(86362001)(66946007)(66476007)(66556008)(8676002)(316002)(38350700002)(6666004)(52116002)(6512007)(6506007)(508600001)(8936002)(6486002)(38100700002)(83380400001)(2906002)(26005)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhueXVoVnVSYm94RGZwZVlpQUN2bEJ0cUE0LytmSTJuWC9aVUN5RmZlc2ZL?=
 =?utf-8?B?emMvSnZ0dFlhdllMaFNEekcyVm5KVk8rRTRrbUxyNkprRFhiUGN0YUxCSDVV?=
 =?utf-8?B?Y2xJOEFrRXNVYis3VnJiaDhnMm9keFRMOU9JU2x6c2xnWWNBM1pTQ0ZHanpt?=
 =?utf-8?B?ckJldFp3Z2o2b3BKV1B4Z1dub3ZqSXFRR1IxM3VuWFdycnN0dmZrY0FJU2FC?=
 =?utf-8?B?QlMyb1AxeDlLV3pIWkpSNjR4U1VXNEJoZGtxbUtKNHp3NG1yelY1SXV3MlJ6?=
 =?utf-8?B?UXhkUWs4blExMjJNWTZCV05kVGp0ZHN0OGUwU2VKbkhORmQ4eGF3WHFZUUlO?=
 =?utf-8?B?UldSSFh3UWJqUDVtNVIvVFVCb2pCMmhESE5KME8zM2M2NzA4K1JDOGFsdXhj?=
 =?utf-8?B?OTJUcUxVd05OZlVNQWJQNFpvZ1k5R3RRYkZCcmJMUzBsU2UwWm9haFZvT3Bm?=
 =?utf-8?B?a2NUbWRic1dTRHBQUXRzZ3ZiQzBjemoxQXNyQWxaZ2toUjZLTDJqR1l2YXRq?=
 =?utf-8?B?Rmd6aG1TcjR4Y28zV2p4WWxsbGRNSExMSndvMkdwcXNQOWZaYTkwSkJEeEM2?=
 =?utf-8?B?eGlFMHZIRGNUSnIyWFI1MlZZMXdKbkpoOTRTQzI5V2NqWTZJOXZCRnFUT0ZE?=
 =?utf-8?B?SmJHdVdSNmVsQ1VRMjZZejdxRnFydjlRc3AzK0NqRm9LVnVsY0MvMUJVa28v?=
 =?utf-8?B?dVJvUjJ0S3dYeGFiNWg2ckxTZ09MSnM5M3M3QzJDaUNUaVNJQ09DU0ZrenZ4?=
 =?utf-8?B?bjBRZEYzaytXVVEvZWYrQjliWlNDRGJPL3J0YjRTWlF3alBpbnhBbjkxMTEz?=
 =?utf-8?B?S09sQ1RBQ01Kck53d1RWN0Z0YWN1d3pyT0RESjNDNDJCYlVHUk04VHZkdU51?=
 =?utf-8?B?OEF6RXBQR1Z4TjhJbW52QWFabndlYWxaQUNIaG9RUm5wZk9USHBvZkNPanlk?=
 =?utf-8?B?Z25GYm5qaUFoL2JITjVMdXdkdk9uZ1VzcmpraHRQZVNWekJnZG53NjdwNWVB?=
 =?utf-8?B?MzVoaEJPRDZmekJQRGVqeE1zRjE0OFM4SlM5enhtWFZXbFhRS1pzMXlmM0Zl?=
 =?utf-8?B?VTZadGNGbXVVYVBaOE81TjhNT2hhaWlsOE1rQnc3K1NkTUMzRm5zNHAxYktD?=
 =?utf-8?B?S0Rhb2V2eVdtTm1zTmFGaTNIeGlEQ2pWWkVFRkdVRnRTeUIrN1hPc1M2d0Jk?=
 =?utf-8?B?bjBnQ0dTZldmVGJvbVpNVEV3WkVkYzd4UWdSWkFNcjQ4ejdYSC82U3lJNTRS?=
 =?utf-8?B?VWNlRjJjVjRKMEtBUDBzcjI3ZW5HV0dYa2ZVbHRWM0R1R3RYd3BTQ1Z5TmlZ?=
 =?utf-8?B?QXNwcGRkZlA2Um5Ja3NwVjBDVUdjeWs1UWsrNFNJN3hTM2tldkNUQ1dmWHJV?=
 =?utf-8?B?bnRwdVFhdVY1dkNGYVFpVy9NZERrb3VJTzVScmg0RkZ1cnJ1VVZqTEpQejda?=
 =?utf-8?B?MW1xRXQrd1E2N1F2bWVUQ1hBUEpJalJVa2wwWDlyYUt3Y0dQK1dXZVZwdFdz?=
 =?utf-8?B?cDc3WEE3M0lYL2E1UWZ1SzIyNHNmOWtZY0dnK0lWQ1M4NjBkSlZ4MU5peXBt?=
 =?utf-8?B?Wmt0LzgrcXlUSmZVWUNQY1RiOHBqSEg0dnRFdVNJRFAzTkZPbWZSLzkxcnd0?=
 =?utf-8?B?QW8xaXpiM2dUWGdtRjNGeTF3RzJaWTZra042d1lHRkdOUWVBZDRxdkRwNlBG?=
 =?utf-8?B?RDM1ZjJEakk4akIveElBMEVLUkVYNFhtT0VCL1BoVmVhSXNuYUlNS0w4YUR6?=
 =?utf-8?B?cU41S01lUEtzWGRUYlJidjN0Z1g0VzZEdndkK0pmZUtYUHlDS0hQTEdtQ2o0?=
 =?utf-8?B?VjRsdjc1VytqWUVLQUFzeDZ2UGpEWWxWelhRRmlEVlBic1hXWE1lNmNMZXhN?=
 =?utf-8?B?VEVvc3pBWThTMmt0dDduQUpUMDg1ZEx5RnJCZnB1aHhqdzFBWXBCTHg2Wi9x?=
 =?utf-8?B?M3dHOUJjd2RLQ3l0MmRIVEh0eGIzZCsrN1RQcEx0NVhEcDRKN3kxaVo5K2JR?=
 =?utf-8?B?cW9LMlV1Tk9rT2FiQWxHNkxvRFAzZTcrN0ZKSU5BVHN1S0NQem9laXBOdElk?=
 =?utf-8?B?NHZrbU5aYWd5TDkya2xpZVlOMSt0K05QMUpUOUNsRGp0WU1RTzJrejFWRDds?=
 =?utf-8?B?cFFJOEJVSWxIZGt3dlFLZzF5RytNR2RsNUpVQk5kVHVHK2NHOWdreWlEUmRL?=
 =?utf-8?B?ZFhWYi9DK2FrZGJzME5vOUtYM3FjeXdrT2RFU2pSb2UyVXU5Ulh1NlFmM3JP?=
 =?utf-8?B?NVlzb01DSWVaQUtPL201Y215ZmxuZCtGN1UvUkJXMjJFeUZCSzlRS0lIcVVp?=
 =?utf-8?B?cE92WXZpNkd4K1NJbVpBZ1k4R0hXV3JuTHBBeFdVNG55Uk1ZVTlBZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1792fb-9a98-4dcd-ae10-08da1b5c06dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 01:38:49.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JijlAwBMW2x6uzM9n0yp1O4Ekv7dPOLITOFw3tM3Vs4aavVxWklN+JXkKMRxs4pbq4Iyr18rxc+72btRB1tM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

With commit 884ee1e585ca ("tools/include: Add phys_addr_t to types.h"),

When building virtio tools, there is a type conficting error:

"
./linux/kernel.h:32:28: error: conflicting types for ‘phys_addr_t’
   32 | typedef unsigned long long phys_addr_t;
      |                            ^~~~~~~~~~~
In file included from /usr/include/linux/virtio_blk.h:28,
                 from virtio-ivshmem-block.c:29:
../include/linux/types.h:69:13: note: previous declaration of ‘phys_addr_t’ was here
   69 | typedef u32 phys_addr_t;
      |             ^~~~~~~~~~~
"

Let's drop the typedef in tools/virtio/linux/kernel.h

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 tools/virtio/linux/kernel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0b493542e61a..1d3248e3f270 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -29,7 +29,6 @@
 #define READ                    0
 #define WRITE                   1
 
-typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
 typedef unsigned int __wsum;
-- 
2.25.1

