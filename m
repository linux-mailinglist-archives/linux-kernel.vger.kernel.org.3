Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C157462A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiGNHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiGNHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:52:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2057.outbound.protection.outlook.com [40.92.52.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A13A4AF;
        Thu, 14 Jul 2022 00:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN5XY1jyKb9BRevINqo5nkpsaK+JPIO2XepmKMzQHP5wLYozeZREhubvr10xujMlVTvVKy0iFfStcpAKD9J7cGKI2ixykvbB08QjZdJG+yFWbfaS4rxF1Y4FKc8VBCuLt0/Kgb6DQkn/U674apebUaJ0XI061bEZ6yEb4C3FFAsdMtYm5PneSGeNV2WH1KzULVD9kmXxGXkFtjuk3q0dcFaD0Y2WyjDRo4YgMbpFV2qZma5o7x4UObI0Y5+5rdAe3Ol8UX4q1uQPou09VlWsIvH57iQG18LCi+Ba1WkIIkpJZ0ItLuT3O16be7ZJYZlk1CaSc7i7rFadnJScnZBIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nE1rwig87uoIKAW7PaNkbmK3SjrWH9OVDgFTr7V6No=;
 b=LUwwbcUFT7L8EUfFvwXvVfqsoXcWvhvWajoLUIT1iDhbBZP5DM/xnDwjPiXuw8A0fukg+rNhge0YzdF1kOld48xmWF7DHVWGAhOW9/1dKMbDnVLjyEEOEldUjNjKVm5EYbVpb6tD8sroaIRyKbXgGCNfVXGysEoPirROSZu/LHPG7DM3yjzHuVvkIx5BEqgLMnFnJ6P/6GhGhkUEC3g6CBqXSfQOd2J54TO6p/uF0R0ou3xO6NGq/ds7GxDmDwadFtpR0319KoaBX6wGdLCShzXtc4QcKuLQALeA8yiU/JE7npHTLsYdtcyceuFTmgFlRw2tLcV5gHXjJ0pSUkBqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nE1rwig87uoIKAW7PaNkbmK3SjrWH9OVDgFTr7V6No=;
 b=OwplzuqAvryEkJOAqQtv7wJ6p+Nev7fBJq+52NJMT3HoUBVOpPzDIrF8fdlXHP8bhxC88r8V7qKt0jcf1Sy/kqfP0ShAwSiOp7L82Xe3IWFbVmot5WqDr2uXLHi8S6hxXw7LPHp5ydLeIw5efPJMsaeOMvZqkxxORUGRWrIriF157q5rZWtqMG1jN6EhOel2KC1r4eOgeo2Gwul04Y5s1knEXTAsC58BxSE27JezC1fFe7X8a5VXP9/jw/QsBDTDMzlMz+NsjdpCpM3Us1nC8+IJNQtySa4zG5jbQYSCIyUplabcHN8ztNPGkQlYZ6nkOlcNatJwpm0wHN+5w24O8w==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 HK0PR03MB4868.apcprd03.prod.outlook.com (2603:1096:203:bb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.11; Thu, 14 Jul 2022 07:50:25 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 07:50:25 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/3] Add new board revision and LTE SKUs for sc7280-villager family
Date:   Thu, 14 Jul 2022 15:49:55 +0800
Message-ID: <SG2PR03MB5006DCDF0A9AAF023BF402E6CC889@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [CSfB5tkpiRF4gNfF7thWFUi3HmpA9wMQ]
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220714074958.86721-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718a2f16-a095-42f4-fa09-08da656d8261
X-MS-TrafficTypeDiagnostic: HK0PR03MB4868:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ai8PWlNxd9FzlxaRdFJL981vGD3lwgP9ixyZmg74m0fob87TwMzOQUyAoMPthjvW3oiXwQqrAXwSEobuC3qwLgpBzhSddmaGWmrMJljwxce0AM7zKY44WAar3aIEQFK77z9DEyu7cYlUTaq5EoyJu0e4PPyQGmHO8mxHBRV1rxYLFzPTOWVAGRW63wPACfuUWhmAlzoZNm8nvbUkp936or2w4SSmlnhEO1OiMrxMTGqN6vLoviExsK/cuRQebc/wLM1z4FooKXnKGMUWOuHPRDYL9P6CHoDXbYsWWiJ4V6p85QH7Ei/HRh6o5aNk3evww/E3mD729GVXz/VKxcSzI4jbXkehxWhL41aY9OAWKfDnMrnwDol8JmfmGoERD+CKrzuJFTAI0H7WOdpVZhGybXkLBA6OA7Jko0FJZOQmqlNQ64gCs6MkTIgoIrQRuVBIGEaU2M+1Ll9FRzX9uSuVtJ42KS1EObFbWzi/caFZI3/DTmFmx0JZlOAfxtGgeSPiRUJVPh3HS6PRTvVsoQyJoSIhqX48pomsc1hM7qHbLJgq7kZjpT9eoUTS2Wqj8lVHYv+NrB2STDnL3QNGhwgoAEerDgDFLZtvoauHy+ETAqnCcghDgJ4ywwNqpMQAs2gVhUFwcWUBcdGo8kVyAXFCadGG0y+6KGpUvX6DD8u2AtQsFeXWQKAaN1UMLHIVhngKv6GDsYPwVyA5jApRiVHHXYqBblQo1WIIA+qjxy7c60=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUcd+aHzI+6lY4bsqm03hIpLaThIoKmgfSTk1rFjMKkUP8GJmcRa/Y2v495V?=
 =?us-ascii?Q?qz6bmITk/d8HFhHEItqNAPo6/w5Du7IdXKfiCdXtMPgmhJvF+Oso9qNqcn2q?=
 =?us-ascii?Q?rPVmw/dBicJwBC2X7P2bPk4DtnDeWsVeQfigDkO/z3ubbQm1lvoPqFCvGmmY?=
 =?us-ascii?Q?nYOCTEyKIL9Ofqo8VBE1PpHlKj8yWTqp5XJajEG502sapcP23k7iVhVE6I04?=
 =?us-ascii?Q?a2YBsRUDuwvu5ITNAkvst19LnedRYyNP2OrhhXGDFPX3bWlNZQP0QjOaM4qs?=
 =?us-ascii?Q?ny45NPpxN1RB1t4VFxW9FS/jyf++iFFsvD9M3XOpPafyk7IMmAs4EpGt5fWa?=
 =?us-ascii?Q?GehE+Qwv/mcf72wmdkFq0btm7qQ/A1F1ZhZ1w1UqRkH/Il9JMytGF7XqFCi7?=
 =?us-ascii?Q?x6m6nZ9Wb/QjigKqRJ3T7NceNGFMu2oPCeWfj07E8ouzAvJJ4Lcy/DgYlLzw?=
 =?us-ascii?Q?ZX3vQG8CXPXeSNG/JexKdR30KPd8QXWM9+oCvVH0iIeo8ddD0CiDhnPI7PSw?=
 =?us-ascii?Q?F0ZrDFs+AJopukGZbSDvJUsGA8J7GWjZpy9dr1Oc2pgsldd1WTM2UIbsQgQw?=
 =?us-ascii?Q?Y0Net9n1Nk04ZqFbm+mpSZUIasNLKCTNuJwMNRI5whZsnRaO6ISQW33BC940?=
 =?us-ascii?Q?CeDyf54cG859QtOe9aBwotMM02OktGBEPTJ8Fxe0lnm3Onawts+62btlMJsU?=
 =?us-ascii?Q?1KO3aKwArIuMk0JLxG6JvX9ej23icOs5/OpdixbaDywkst/oMGB+SsshkgAt?=
 =?us-ascii?Q?BrtqWtLDBK2DFx/dDnyrP1RfOyU9b6yYV1igkWRDWVqCJIrMoKzAqyLO5hGu?=
 =?us-ascii?Q?nLF7lvIiGK1ozo+ZTrf0z0631eZJ5bMKJt/ZmiYXd5dEJQioV2xKwFmy+eIl?=
 =?us-ascii?Q?hR3xznHLjVAG/dehLGQhsNSYc4WRCUHqWhFP4+l4oC+Cw/K4P3phexxsW2i7?=
 =?us-ascii?Q?S0eIEWMkvxqXNApM2ibd5fcQu4N0QmHREusFyUUNGewKHurhsXL4HWSvfxzp?=
 =?us-ascii?Q?qPxxy6V7PD1N2JouV873pCtnHVy8L01ySnrZveocv+vFxFBQe/YVZPLdmOXZ?=
 =?us-ascii?Q?RlIL8yYVnSyEamhxc21tJyBO9XJ4gY+sb7ZARPamJTinb1HFfRC4tH+fvm6H?=
 =?us-ascii?Q?74NQ7ik6tMDZFAbdOuG0HpXKtrrhEJ2IfiXqmpCenhw0cztSK0ghK5JPbGSq?=
 =?us-ascii?Q?nmX25bb2d9hiDgqapy8Pt/v07wtd3kPePpi1Kvyy62bpz0IkmL5Oua9bji/y?=
 =?us-ascii?Q?A0WtjMqQiygeUThDrgBOEq6tQOvp4hv4RkcFkwGCKA=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 718a2f16-a095-42f4-fa09-08da656d8261
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:50:25.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4868
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add a new board revision for device Villager, and add
new LTE sku for both board revisions.

yaml issue has been clarified in [1] and [2], and 'status' has been
reordeded last in this version.

[1] https://lore.kernel.org/all/CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com/
[2] https://lore.kernel.org/all/d3d4d90b-85b5-5ad9-78e6-5a074c21af4f@linaro.org/

Changes in v4:
 - Add patch 1/3 and update patch 3/3

Changes in v3:
 - Update patch format

Changes in v2:
 - Add patch 1/2

Jimmy Chen (3):
  dt-bindings: arm: qcom: document sc7280 and villager board
  arm64: dts: qcom: Add sc7280-herobrine-villager-r1.dts file for LTE
    sku in sc7280-villager family
  arm64: dts: qcom: Add LTE SKUs for sc7280-villager family

 Documentation/devicetree/bindings/arm/qcom.yaml  | 15 +++++++++++++++
 arch/arm64/boot/dts/qcom/Makefile                |  3 +++
 .../boot/dts/qcom/sc7280-chrome-common.dtsi      | 11 -----------
 .../arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
 .../dts/qcom/sc7280-herobrine-herobrine-r1.dts   |  1 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi  | 16 ++++++++++++++++
 .../qcom/sc7280-herobrine-villager-r0-lte.dts    | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-villager-r1-lte.dts    | 14 ++++++++++++++
 .../dts/qcom/sc7280-herobrine-villager-r1.dts    | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dts          |  1 +
 10 files changed, 79 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts

-- 
2.25.1

