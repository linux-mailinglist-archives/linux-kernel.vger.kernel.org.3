Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C734BDDA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357877AbiBUMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:18:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358226AbiBUMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:16:50 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60117.outbound.protection.outlook.com [40.107.6.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22E275C2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:12:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSVf9W627+tB+qxWrnWffHmFit7Be+vLNjmjJSYE9ZbWzFfHhlCBG1hQsTkEC+DuF381E4HQqmZtDmPmKv3VUMw8Iln2rrj3U2+4dlYo1ppSbEsXNq9u0NvsfygyrVTfhSBEOvhNNV41sZsj9S4hxOuDdIvgNiBYX1C522KTbsRANHTFnAEd5xMYQbkepyg8LjJ8m0yfngUGW/0J4WlNGQw47Nxz4xe0zp1OVCuVOT4t2hJBbiqhsO84FOD/vesFiDbCqnMo88zc0SIOme/W14iaDfjYfQadCDVv7jC1ho2qRKwHzssRarm1N0E6JCyCQ+vMZGsfWdGwHhs6NqA2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9q19MsdBwzaIFaFAvKPVLdZTQngOWacJywV389jJQM=;
 b=ZnKIMmNWvo+ZEcrX4ZjOX1Vxm+Zn5Derx6ryph/mXPc2lepPgim8DNgaih3zaUjtmsD/LwVFuJyE3kessPhC8SUsEwurcYHLdSWze0kGS9b5v6pnRuoFWOHlqwVkFGudHpP8XTvDFXchzGdSqf9tLD/a6YvvHZUb6g6I2TCyocyckZBPyAp1l/TV/t1+nnOVhjjy47NwZEjZjXDmx0YplY6BF9P6yC80K8hyPuPSFBYI6hTjxkAvBDr5deSuXOBEld7yiUiueX5Vu8OF/kPBbO2iMfrfxX5DlOjaxRJwWs817SGEZPPzpBhO7vhKGO/nyFhuXRiV45rj2a3R4oC2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9q19MsdBwzaIFaFAvKPVLdZTQngOWacJywV389jJQM=;
 b=w2n0mpRYZdPxALFtch54UQVlbpeo6nF6lqIgW3W0GoecYJDvthUuSnFtzhsJFkRQAkT+pwIWyq/wnaQkVyNJE+I4GP/SkE6tF12ocXiIB97N042GINPiXAt00CeatcoICC2d6fLG01xSa7lLlOvzrMKx+BTw8JsPeoGIQt+G2a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com (2603:10a6:803:30::15)
 by VI1PR03MB4381.eurprd03.prod.outlook.com (2603:10a6:803:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 12:12:41 +0000
Received: from VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::4c4c:16e9:4c39:b97e]) by VI1PR03MB3503.eurprd03.prod.outlook.com
 ([fe80::4c4c:16e9:4c39:b97e%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:12:41 +0000
From:   Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com,
        elver@google.com
Subject: [PATCH V3] mips-next: Enable KCSAN
Date:   Mon, 21 Feb 2022 13:12:25 +0100
Message-Id: <20220221121225.8699-1-nemanja.rakovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0268.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::41) To VI1PR03MB3503.eurprd03.prod.outlook.com
 (2603:10a6:803:30::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8451c37c-a77f-4729-e754-08d9f533754a
X-MS-TrafficTypeDiagnostic: VI1PR03MB4381:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB43819B40704AB5C08C021ED18F3A9@VI1PR03MB4381.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQJy731BksSVuxgT3okhetQtFmhFHeob8ZBI3JVIqay7Ck9CSt/wlaTNzJrEZ6CpcFkAMlFxZ5kWo1kS69EHjvepJ6tjBKz3jt9ahLTBlDJttKcQwb6H5ynE5dUhJCmBy5PWHbIbFqGPTxNbi3K7Me6PjEDYuW83mPhnjdCSPota18xrUHhhSNPfFyJieheY2m+SRvH6QUKv0M2RLqCmSq+Zsfsud8DR45TKoyfOcW7lZqhwRRCW1KcybDs2zQ6YyIl8ETLIAEDoCqNNYzdQ752zpF0qea8Thix/Q0D+nDoNHr8PDCZN3epyTTxxaoB42lmFaAubxx4Tq8N2328FycvRD3OMzFw/5oxbqw2hc+64zfN6aiuIleIUxyIGFcNy+f8rmEFIVn54cXpXl8I+eHJc2idfkr9548OEu3GU7+zRmK6Y58KTw2DDlaCB7Lqr5V8xHkRAv6sLDZbfxMArIX7KlaxXl/yqCrOHes1R1j08g+FE/FEw6yr33rolDi/R5mz/AHgpzlXB7V1+jokKweDmnv89Gpsu5KlxCj0tPCqHs0uMMCP8OH+YzzO6+P42Rl8/rTlsEUu9tm3x0kZf3hqNy922i0zRmMPPzyFv+K7HjPUT6jr12iYC9DPVWDaMTIc8AG58+ecqRxIeEkmXEElpjK3y0TbryEqWzh5UwIge46+gyKGIaV3rLGo1VlX8PHWuMD6pFcyVp5vGU/tOjvgeo+SXvAwVUyOevNdCvAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3503.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(36756003)(6506007)(2616005)(1076003)(66946007)(6512007)(5660300002)(4326008)(316002)(109986005)(508600001)(66556008)(66476007)(6486002)(83380400001)(26005)(186003)(44832011)(8676002)(4744005)(8936002)(38100700002)(38350700002)(2906002)(52116002)(54906003)(86362001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFfyXMvjTa8bBXHYQMi3pV7Z4h8S0wpUavox9mIviRU64c72O258blFw+3i9?=
 =?us-ascii?Q?IuUT3qbkiExEaD3+KWYD9enm+BnBI48TG9ipm09TIrE46hyV191lZBkZM7cz?=
 =?us-ascii?Q?DNm9ObGisjz7e6RxqjksRWprIFw5NloVu4X6a9pWLjubaN4U6YfkXeuragX3?=
 =?us-ascii?Q?91HUefiaIOuGHZTcCUL72eFQ/A/UusJ8vobQyOi8yX3EqVzZUf7VIBuAX0nT?=
 =?us-ascii?Q?qJAV2knnFwULv750nKGbmS99SjbxFHj/s98PRHKqYLuKog/se4WTYT+ze5eX?=
 =?us-ascii?Q?ZPKSJ4DUOOjNCKRF3Le3BDVJfDztNTD6dKAbW3wOA4eowLELWB34gc96s1RU?=
 =?us-ascii?Q?DmTwhUtzioHRDP3t9t/xnOZd75c3ZiGry+RG3kR+sMYbIB5RKHzpwaHIppEm?=
 =?us-ascii?Q?zWEXaZPoMNVNkgOwJ4LGn+aiUJTfmzkglPJ7CzyjLE4khNsRjkGWhMl4Wd6V?=
 =?us-ascii?Q?BjG5QQtOb2GVoGvQ3S/uhTkvc+hLA3VmX1ZOtCFNFE6cP+UFJBaSgvoXFY3z?=
 =?us-ascii?Q?6R8bF8kZ04OSSna3+fX65zF4yPsEuVKD8hdcH/S1cj3uxboLYVum17EVo0Ak?=
 =?us-ascii?Q?csfk4luh2PN7c4i1hRPx+1HJluiniScaf8t2TFvag+KwxYAXMv/elpyetYVP?=
 =?us-ascii?Q?+ikByLtZgl9vCoXAxJemdXla/kJK2rsEYSU0GvITBiZ+zQAJjSps+7I8LBlk?=
 =?us-ascii?Q?gepDSDZTdWTk0oyeWBsULqYRjnAe41deknbnI0qHgRX/C1wLMHf6bU/EITwc?=
 =?us-ascii?Q?8TnP6DbWYgLDZraB3KbLgbyv3Qe1+nE5+Qfc2GAtfc3ErRf2AyBfHTP1/lZX?=
 =?us-ascii?Q?8UkSq0reP7y19lvNKBah39cEo+nSgCDz/TCCXq6nVpBw+X9oWBDkVgWYrwSF?=
 =?us-ascii?Q?kuWxBir+PMeOofAVJVHKwGtF1rEKpnW/CSGLltUVTC4ycmbhRCRobHZfbNc8?=
 =?us-ascii?Q?BBxC/Mu6rO46Vx42ID4X2P3e+1OPjTjHQGJ0LNMFaC9267fK30wtvqLW7tCk?=
 =?us-ascii?Q?V8FKcWFGeOebMx0QUBN8Fr9P0rdBP7dOaxqlY8/Mb3ClwdNJ0R0gr0TatzT6?=
 =?us-ascii?Q?UUFLKSJMz+2xmC1sdGNq0o9Udf+OROUBw9BqW5aq1P87n5Vr8OuND0RuWrqY?=
 =?us-ascii?Q?EhUW97Ijn0OkkWerqFO1cSZw/X/K3EefagvQ0BGFag+XxNmLu+bUNY1l7k/O?=
 =?us-ascii?Q?Gg0DA2FTy2Jn3PR20LsTaK/6+bKWeGT+foV2SaUneC7FSSm4J1izQKfQ+KHq?=
 =?us-ascii?Q?9inOubZ1OIlZnHeEn6fmIVsCOapMQabmQ3WbSPP1HsSY7tU43zXg2nJB26uf?=
 =?us-ascii?Q?62myMefWuE+s8sFQ9IfYXN9Xd+M4u9WZSOUvVZiTgBIMR+jZL0LRE2B0nTPp?=
 =?us-ascii?Q?JxH9xHEfD61ldz/VQtGT7QMPrIqzXzT9fD9y4MoWQ872rA7hIozBo8zFFBs/?=
 =?us-ascii?Q?Rw2J29CGvWwRoLzVFxr8MjDgTV/EcgNWpt2Hh4R+dXw3MRCZ8Dbg03aTXdfc?=
 =?us-ascii?Q?irMEGOTZptGDCR4rEjZCR+Vpd0hOtaP6kfJxtiKbLjEEa1/KEK0CiNe03Mjm?=
 =?us-ascii?Q?S82rCF1qhiCFri4kjP9IMIqIuuDv0VM6SbGhmV3pQpNfXSJRx5PeeBKlP83J?=
 =?us-ascii?Q?mE6DwTRmcgM1tHEonBpHM2lJcjcKohIP5WKxOyHD/PF5JWpwFgA2dG+MXdMb?=
 =?us-ascii?Q?xCEp6juJ1EuLR4qk6pHxVUzrYKU=3D?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8451c37c-a77f-4729-e754-08d9f533754a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3503.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:12:41.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mmkaU4TvT7iicG5ZDmWu73NE9Pef/K2ECO4P+12WuHWRJ/a/3LFKHkDYXssqdYxZp9X2X078FnSR7RXbk9fSuKgrjSWyq1uE1gfEWcegmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces KASAN_SANITIZE with KCSAN_SANITIZE in
boot/compressed/Makefile.

Fixes: e0a8b93efa23 mips: Enable KCSAN
Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
---
 arch/mips/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index a35f78212ea9..6cc28173bee8 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -38,7 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 KCOV_INSTRUMENT		:= n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
-KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 
 # decompressor objects (linked with vmlinuz)
 vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
-- 
2.17.1

