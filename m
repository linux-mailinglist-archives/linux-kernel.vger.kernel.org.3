Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E601577C90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiGRHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiGRHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:31:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2076.outbound.protection.outlook.com [40.92.53.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E313CD5;
        Mon, 18 Jul 2022 00:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOFELUl4bOfUMq96WjfjYd4ghcFADo3VGOAC3oOEDKqbp8UImVufkUcNBrACGh+T4tQ7VdRgj5/qQk4BhU5PXkc7KOjksWKhUmWa3JLnV6HqJ+sv3xd4JXgOykYjkYIDrS1wj68nzKOH5+mkkE6WezpMSlNAdvdibwKQ7bkMzU2f+jA9H3viiWU8O+iSNrxzogXbYn4Fi+v094gaPTlTmLAe+0x66Evzhlly185TRPqGaA6Iv0kho8q/R8Hkt8GAyJPZ5bDmEOAgygwgIWwKfFmh7WWLGMAD9R0KSUMhHu2eAVOHz9WykqsInzNhoCQE/Y3o4WPZ9F2/cSKZMVlsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZGHHEpjKcRStabovgp1m3x5N23/PIcMuuLcLtdnCdo=;
 b=WUXvN7XevLqjBxshBSjMCnjarpXg4UIpbsywPm9c113GjhYSpe6cIlo6Vnedr5ASSbiCQpsa0Yi0csSz7tdHon3KZjBiLWpuQMfi0BqCw72DgTDoBhu23ByxmTvBMBFZp8GqKq3RXuqnPjFqrwMEYgi+HW578M7NraOY9cqvOMNRWUCKYcOqGeZiFLYbKuA5B1acWoVqamMDxWIVKj7QkB0L+CFdLaJkheSEHVWF5jagsJojUFcege0dzUScJVUZ8v7VLe0RqiSoQGxP3RIvangOi51z/WXC7xdC1wMbNhYr/IXpa7MqQy1v8/OXDTopW+7vXe41DpR/vnsiFHKZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZGHHEpjKcRStabovgp1m3x5N23/PIcMuuLcLtdnCdo=;
 b=KZuQZjYSle573sFnzi7tnLmX+klnqBm0EMAHwz2+thaXhwR00nIEJIlxxuQJqpesmHYI72NkKOn2AAqJNcThhEOCHBiKV1a3+ti4B5Jxhki5Qqy963aZXaDNw8WGLIB1CaX4MR/YCDz0h+OpVPtqD+bTK5auNJWD/rIfygPqd7+UcTFVMc+WWpUr5VIIDUtQb0m2YRilRIghezv8137pVo/eTFPL8cRqUYdSY/2b1TAY3zUiV+E0smSMkwTJ5IuP8QDePDNF6Ws0setpND2SCRMMNg9N0aJaNKDZkzhruulyGi33qL6CgHKg1I6evXAk23r07n8Kw47h5zFW+y1ACA==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.11; Mon, 18 Jul 2022 07:31:16 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5458.015; Mon, 18 Jul 2022
 07:31:16 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 0/3] Add new board revision and LTE SKUs for sc7280-villager family
Date:   Mon, 18 Jul 2022 15:31:01 +0800
Message-ID: <SG2PR03MB50061E88D1F7F5141CF9168FCC8C9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EEbjUkpjZ2/sAH5O9bTWesTLTr2m/Hcm]
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220718073104.146985-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12300ddb-82da-4de0-b3bd-08da688f7fae
X-MS-TrafficTypeDiagnostic: SI2PR03MB5468:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQp/qYcdHpxbqjK+YRssu3rGNa+fM5bTwtDWto4eFvqU8zX/qK4+AHJRgdLZG5AsFFpSvkn4NtG6SahK4hh9G+sFqiaIfLm4r7fYB0x/PinnbKfShh+9MOp9gpjdgVzZQZHJ5rAgORCQyqXi+Hq+v8wZa+HCIMrvMoXr/nOfHdaOjMc2GrQ60HHbFlDfVxo19WvlPQr1ebwxdewQ2MargcLziTozfRA91ZebzRsHzTWaQDMXiks9kb+q6eF/mAoNaemz0eKj6WEkH0VVlD8t9yuUeSk80sxp1GOtO9xF29NCXlM6YtIibFY/ecAbYBlE5zdbpjPyPyT5qd6ASGssF6PuFb3sCnsr6KJk5jSNPPu08DIwSrdBtITM75YKWuKkLGpra1pfEzXlpzwmFLctsUqjbF7XgWx3B2CcNLXijHD1goN25r1NWrt0fUP1zNq9qr5+l5WsrBI/Jd+QRoBB9qlGJUzMcH0pe8V7vrnp0/uIwK0L3Dj6KMPs48riLoCXo/qLx7F+ywo+1IF4Ars4D2iCCRqfgTyC/6tNBa+CquuE4/rCtJ80oDn+fIW+ANDuJDeM3mqrJP07PBI379hpekoCjarxY4esjeayNsfuvl80pOQP58mc2WnmlpasPEeKdj1WxJnHKeXjD4sB9oQqhoto4ICgOND+D4LPeEYekb4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3B1BIGTEkfz4vlMzlyq+uUhg+Bls+Ism1iCBZCQdWRkowivh/g655MSju6M?=
 =?us-ascii?Q?wyXqnSWnIuulW312N3GeFj3l1Uy8CI2lzvG+XDClRUgjwuifZULd01JPCmtH?=
 =?us-ascii?Q?LaBvDItCSKYTCFYEO1gAFH7UVGLIeJdPq3JLU1SS8BRKxfy9bzVUeMnsrBBV?=
 =?us-ascii?Q?MJrV4+hsQLPi6LAcm3RGKlxveSz94nzYk/pNADsjOlE8kAzFdq5w8N6F3afU?=
 =?us-ascii?Q?pkPLFt4eN7wJ0Qp5jSuZrRfC2yTGP6IKu0S9WzFyehsnWNjcmqt76b+cZR2B?=
 =?us-ascii?Q?jn7ZfPNSIUZ15uP+Y4DFotKLyzN5FnfxkrOQLA5ld6cvon8N634FmmNMMy1l?=
 =?us-ascii?Q?HSS/i/a2wvLyxvr0BWmedwke9l9CJukcuSp58vLFbUkIqwhBSfuOQdN6EDdd?=
 =?us-ascii?Q?QTiAVhIXv0+pmZblISIf/D3tH3JOvULDB8rSQb2yk4gk2uPLq+xvehRQAUnW?=
 =?us-ascii?Q?eT3bZfXMSV3fXWHkU13Ya/HEPY1Ybjfk/qRp8YijRTTnLSv0KGomXJLhTv3u?=
 =?us-ascii?Q?K/ArEsUuNm1UjgfzGUQ3S77/AlADOQlVFqJrQEDQd7enERxHwQ/orAPVomyC?=
 =?us-ascii?Q?SyQPcDkdsmXyMMwpljmPPIGO1w+O4afiTj5E4uJJue/UMRZQiSIuDQk09eHH?=
 =?us-ascii?Q?1Ee5QD/qzFKK+S/pJKLqlioMhoH3CzxZT+BkxVpXC579Cmvqn8MCfBfkf2OJ?=
 =?us-ascii?Q?Auz6ybf/xEhon5hk6uHN4Rl2SGGOWEWYwgIol/pZaTQw7ScHpY9Sy5kxAm26?=
 =?us-ascii?Q?iAJnBfJfsZa1tVcZ6dpZ05q6gcD1kYO09U37OA2j4396t42Oib2ETJAwPWkf?=
 =?us-ascii?Q?ldxo4hl512Yv9lYi5B2Oh+IYVS8kbyPJ3G1Efk9Q1ynwAi3JAt7oj7V9TG+q?=
 =?us-ascii?Q?TBWWvUAP+HuvQXH2HiAyEeMReyaxuX4ANB9p4hf3VLHUg5ScsE4ThVLzpKko?=
 =?us-ascii?Q?+pqAgZ/AFCuEQlcFy5FuWd5HK+yKU4P/GnvY4HKqLQMORnyizN0zYnku9vM7?=
 =?us-ascii?Q?LUJ9NAuiPFXTUVZipYa8ZcWUYOVonkidBcxnHTFBCG3btIDWZQvVOQIualJd?=
 =?us-ascii?Q?rlQ3NHv9n0Bx0Inztd3G9DuseWjYMdbO8ouAlEqO+uVcBcAHdXvWv1GKrJ0c?=
 =?us-ascii?Q?VlkIaj4PcuptcmlU5LGiMULBb7jB6EZK1nKmUISTdzJTo9k9zAq5ZjKWGqSl?=
 =?us-ascii?Q?hjgcpKII8fBDFuPDbgINK1oy5iVSCHomxji7kD60gC3mON9eDj/kTTjywSDE?=
 =?us-ascii?Q?vRjm+bZHOWPlwr5URi8xW0kJV6RO0cJp+QJg16FOOQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 12300ddb-82da-4de0-b3bd-08da688f7fae
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 07:31:16.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add a new board revision for device Villager, and add
new LTE sku for both board revisions.

yaml issue has been clarified in [1] and [2], and 'status' has been
reordeded last since v4.

[1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
[2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/

Changes in v6:
-remove v5 accidentally added sc7280-herobrine-herobrine-r1-lte.dts in patch3/3

Changes in v5:
-Update subject and revise Makefile

Changes in v4:
- Add patch 1/3 and update patch 3/3

Changes in v3:
- Update patch format

Changes in v2:
- Add patch 1/2

Jimmy Chen (3):
  dt-bindings: arm: qcom: document sc7280 and villager board
  arm64: dts: qcom: sc7280: Add herobrine-villager-r1
  arm64: dts: qcom: Add LTE SKUs for sc7280-villager family

 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/Makefile               |  3 +++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi     | 11 -----------
 .../boot/dts/qcom/sc7280-herobrine-crd.dts      |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts  |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 17 +++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0.dts   |  4 ++--
 .../qcom/sc7280-herobrine-villager-r1-lte.dts   | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1.dts   | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts         |  1 +
 11 files changed, 82 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

-- 
2.25.1

