Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0650BBF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449552AbiDVPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449250AbiDVPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:46:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2010.outbound.protection.outlook.com [40.92.22.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3835DA76;
        Fri, 22 Apr 2022 08:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4RNgQ1OdYJOYlPuGc8SSt2WGlne5GG4iquKeQyQlXMXRTsy5eRPMGy/RWIAWnSr0CQ881dPwuAhgsfsbaeSziwCvhJK9FM7JYe5a96Vkk5GjjfGorQYEoMLjhJzf3y/cHP8l9XoHYadMw/n3ZN72v64mdmw+G1K1K6+L06kwDSY0U6lXFZ5TjMxUBh2pZpcq2OfICZ+nevDCtOvX5UV1HiT6QEhnnq/GAW+uGMOvmQTX1NCDA30Us7XVWfzR/hEgPoSYOcXmItFxlExywZkhRVvtLfS0F4QfYIQ6moKP4IZn9/Gl6AnYwHbsonx46rRlYgoZvhmyjjMK4qFx7F9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4IdfLF1F/iMR6oDKVQFXBezvZASV53CJFH2QS+1sn4=;
 b=PmW54zVpPEg5sIM0/nuWY+s55iRCH1MksMI/YF2FG8yaPJuEqYHocn6wQHjWMEB9CJqKN5mJiAS0eMw8gFn4LKyQnrQ3pXU4lrfMjTXcee0h8M5Vy8t6TJvKDnGla4QRAGzbbxRvWwTMxcln3sG2Qus/LgL1JsW73I6k4yg1BxbOPNl5uXBCaZ6UL2U0QF9I8bh6+9n8BETH/c4E2VhjDhEswlzDJaU655I4fV3zbjaThdEQ0cSVFCC/EzprF3Buk/YMxG7fBcH/+J3abkuvH9JTHfYLv76ZJAM3PYf0U17SpYKOvqWUPl+WxbCoLMsziEpgcKsTBZCBF2XEs+NZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4IdfLF1F/iMR6oDKVQFXBezvZASV53CJFH2QS+1sn4=;
 b=FGSs5IYvd+wcY7ELC76a+4mH/0/IMrOCXOv82NQHpq7/INo4macNlN2u1FMJs0BzALnkLh/A7+SNXafiq4MfPcMNLSMH8827TsppFn2U/KFHmKxLqskOaCzfmGPrK0tZ5NyIdXHCrcr2UbnB8pq6BELl1lCxjkAsCJfLDjtvpfp1DAwWrbjDkWyGKogEqFJ5VquRS+Xj0uAPUbbDhKlNNN8XDkJAODtaS49D87WrP/ONrbrXnk8kUvYpcysnCJwkLKBT5Y4xk3REc9s0rfounTQPFJbHNDz+npSxiXx/EN+asvCDg5Sbzp3XggW/6QzMqDPgZXiDF5xPMgjMHXfjkw==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by DM5PR2001MB1836.namprd20.prod.outlook.com (2603:10b6:4:17::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:42:53 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:42:53 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 09/12] dt-bindings: arm: sunxi: add compatible strings for Sipeed MaixSense
Date:   Fri, 22 Apr 2022 23:41:12 +0800
Message-ID: <BYAPR20MB24723FAF3BE29BB7CD8341CCBCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wOiU5AE8OcHpBFUxV2xp5vs+woZsLn1O]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-7-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1d3bdd-faaf-4f49-d8d9-08da2476c35d
X-MS-TrafficTypeDiagnostic: DM5PR2001MB1836:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr9hRhRR/HWB1BLqXXUAAN0W2ja9c9raZxrJLuwtLujoCWqY7lWwmMRypbXCNWY9Yhqnb/aW8lpAS2jhOsJnWarg6tR2wmnXCBHLFpkW3M1K36oC7dRP6mbokMri1WWOGkEr7cMl04Kv4idGsSOpXvQMPfo0tWRQaB4GYQHSaMSn/7v04pQm7VePtd5qNgVQut5O8Hab9T7prwtoOaq2NzP574cCHYn3b2EhtM73GGjbqyDV/jQqIfQ/wVovBKxoD9m7FyXbEiV6LJGl9mK6OZAAgsNOGJc0pcQe7/HJ/TBBg0DIefy4ypPrS/b3gis00No1y1ACJD2vSqp1BAnpOFoeBX88A3P1rf7ipB/oEgdBWh2CtDERN4xu9t8XggANZRFbtBaHcVpv3PxvSL8bjLdt5vb++3M9bUQOVNu1ffEckigTNhZa+qRSPJGeWwDwlAxLtkD2KYt2GQSiKcM4ReSWDQC8BosOF8F7KTOVa8FC0U6DCja/R12byevywT/tCpaomoqgS9sximYD6r2WYeDZrrJ+G8DnduVhNEeyuLXGZas6U09c6A6mPYvs3fLNee02iIKotzUTNSu3bUeCaA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huReC6j75tooEXicbNuMr11sz95d+6WnZGvGYIhHNt6XR3hL4ZjE8HpYV/NF?=
 =?us-ascii?Q?cyM3izh5m8jRMOC5QUdVjHDrXDao8DLm2b8KjXH/HRFZyddZI6qnucC6MDBf?=
 =?us-ascii?Q?eoL6OiPW6j21I9deF3QS5IIouufgTldNuJpfsHJ+yF9CQPsJB/gqvyii8PaE?=
 =?us-ascii?Q?BgL5scqxZQG1iv3HVNOqvHPRfpa4TZ2MkMF3aSpQGwIsBlz85LtN0XBHU+qv?=
 =?us-ascii?Q?MtxRw6HqJTZWEH5f50JQp6JkelRJwnsZvHkSFZ4RvCNnhQGQWDbl6o46nOB5?=
 =?us-ascii?Q?UyMYeAGjaLGCWLmMGECABFgc3kHx/Uj8ecCQk2QjfHhd/F5IzFh+VhciZAf4?=
 =?us-ascii?Q?Fpqdh4djXAjU+rEClJ5Ra9H1i+5kbrTl48MZvfUFSdBG66OumDkEQhl3Dh+E?=
 =?us-ascii?Q?RDeyb3+UzuON+HeF5DfY5OzphIl0GZf9c7z09+KNheJegPfdKKJgIdmKrrrF?=
 =?us-ascii?Q?wvmnbgsWtMcxC2/fOLEgxAgS5T2i/au6qFbW9UZq/Pmkj+1VIV1jOw0QD42u?=
 =?us-ascii?Q?Hkk0eWNNk3DJkTBpucp/n40Ne8w6SUE9K9XrI+YL0cIyORo9gc4UQGrO9e7X?=
 =?us-ascii?Q?WRM0PD/lUiCITxzN0aLpTruEWCSWkeHyQj3VX+5m8AQlhCW/RwhFQwPpvFGA?=
 =?us-ascii?Q?eRbUv3UffmjLSsXpReSC/Rs50W/DeRt1fEWNdD5HSdphsAeDmgP4j0R16xit?=
 =?us-ascii?Q?V4KOP6YnAtmN6mFda4E14W5L46GiekyOePIfTQJ24Thmsx/lPChg5o0cvfkZ?=
 =?us-ascii?Q?8nyyP8y3MbobLGc5DHACot+cVOFyazkR0pN3AYkLBFbozGg4m59nQgFNihTk?=
 =?us-ascii?Q?ZtXgzZ8O41fMcwCSO+ngXJNnrnelMIhLtj+kUWfvXy+3Jcy4LfjzKMWSUIct?=
 =?us-ascii?Q?spWcnBZuAToX3COAJZZC6lBPc5hjay+62PmMyRfL4S83mRia2FkXs/F1TEoV?=
 =?us-ascii?Q?zpxLtREaE9MAY159fBettRLvK0vY+02jf1nmWpsvISZuWXRJibJXZoKcIrSz?=
 =?us-ascii?Q?JKOW6d35k68nBvkef4GDZz7hsvHuiVxna5CluxC+Od76alVlMXQ/aa1o60L1?=
 =?us-ascii?Q?Pf1axw7hgeLzturv/ocMRgF9ra8dWB/1iVYWUDMpb84YI0hPbkHoD+dXP9Eo?=
 =?us-ascii?Q?cRpPqZTumcU8LpPrKabh2SqWhfi260J5OAPMTV8bxi8PCLsb34aMqapUDR4o?=
 =?us-ascii?Q?jJpAoFhke24Z7N9GKzEbmsOL4G/FmUkKIwp0ra69gBbZd4qgQNnUmcFtGUhk?=
 =?us-ascii?Q?QK9WeKqLywTJDxd7QCSbEtov7C/0zYp4NTgztkEujLPKc6YJxLWVVVzHG0hj?=
 =?us-ascii?Q?m4HcPq8rQ1fhJYhQQzau2XvKe4d52DhoW3WOsrJ9FGrQAV01h4OAf4cFN21e?=
 =?us-ascii?Q?y89ZFA3gd4uBGMNDmSJlwEGts4c7oMgk/PgcKgeo+SLKEZdahVxdqmgStDAI?=
 =?us-ascii?Q?TCCzErOEoCc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d3bdd-faaf-4f49-d8d9-08da2476c35d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:42:53.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2001MB1836
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Sipeed MaixSense is an Allwinner R329 development kit based on Maix IIA
SoM.

Add compatible strings for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 95278a6a9a8e..d2f5bb1ab136 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -454,6 +454,12 @@ properties:
           - const: haoyu,a20-marsboard
           - const: allwinner,sun7i-a20
 
+      - description: Sipeed MaixSense
+        items:
+          - const: sipeed,maixsense
+          - const: sipeed,maix-iia
+          - const: allwinner,sun50i-r329
+
       - description: MapleBoard MP130
         items:
           - const: mapleboard,mp130
-- 
2.35.1

