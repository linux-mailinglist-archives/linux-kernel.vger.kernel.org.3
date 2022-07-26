Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC3581038
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiGZJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGZJqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2082.outbound.protection.outlook.com [40.92.52.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8D2E9E1;
        Tue, 26 Jul 2022 02:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsb1UvPs/0ynhpl7rhD8p4XdjKOaoCxz+GqqJcdjAiqEiJJl5fTJxO4jfDZoQJLKRdlyq8Hdngc/qxZpQ4tUA7GpYN6yVXdFNnrkZyKSthVEUwfywdy3JoaD0VDvP7H+OkGyGl5Wuw63QzqvXx1WCxk+527cOnaeiUGv/hlDVT47Bm/31webaURG1Egoeci2A2L1q8mbXXYRa19n0+ivU76YJCPlNm5MvsvlF7QjGQnYqiCpA3230rbwDQozwgz35zbLsOfjBQDhl3GZScB8twKA5gMkvqUCHRqVjqP8k4Cb0wkLTIeBc/T47CwQeL8sIwmZ1Z9Rpkm9I3a7SY6Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPwelE+2MDEHCaQexv4Ngteiw9PnxsTonWtEyzpBqjI=;
 b=AhiFqhS4mzmG7glNhLzSBu7u6n/LTah6cHfVmVDPTl3FyWZv7UAtYpNFZkhKYCc+1L3WC+zNvhmiAaTTEGaJV4RE6DJll7lHeu45O6UOFntXcGtNTg24lgHjmxCYFtOGlSbGGCvDA6gI+1b3nVsVl3GWFsgG/YcEIm7e8rpicjMGnN2YbWSqt+01i6UcISTTNncYRyalrMHCoonXQoq1F0DN0iMLzCebc3AkjtTPtIcLO5mCn5ZWqu1QMQPWif8hnl+KOwGLvz9Fvlj+wDegDy+B2yIDixDKhrLyRXxJZdYU9cJkXXDt6/RtSch+hbjeAAyrR062sSUfvcNP/Z0j+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPwelE+2MDEHCaQexv4Ngteiw9PnxsTonWtEyzpBqjI=;
 b=hGhsRJ+ETHF3+D+hZGnnKsKM+GUQk3VKlb7M77/pXbI7dJDG2k03mnpiiajvo4e/kOuX3cLhuMyfdcObTDCDQcolhiv6csSD7YEaVB1gI0loBUhMvdCfM1Y/LMps9ulfT7AJnKTGAM9mCDpfp7NSuUI9FMDbKA1wYF5PSvXtCcdjp1gp1xnnxARZMSlyiLX2UEhsOLdjGS0wbJnLgP3T+r6iF703upPyxvUKKBxlbvGkLW/KHSCEy/YSHUKNpGweataZ+Ov8/rxMe1LDE1b4bbhqpe3YnFHMnfOJ4is/tybSeV0Uq1OQY/cF386069qlsAT3fRvlExOLSJWHtwD7Cw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TYZPR03MB6669.apcprd03.prod.outlook.com (2603:1096:400:1f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 26 Jul
 2022 09:46:07 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c%7]) with mapi id 15.20.5482.006; Tue, 26 Jul 2022
 09:46:07 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 0/3] Add new board revision and LTE SKUs for sc7280-villager family
Date:   Tue, 26 Jul 2022 17:45:46 +0800
Message-ID: <SG2PR03MB5006FF0B380CD702D28460B5CC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [5uvgLGLTY56lDuHPqaIccCWsghh6uItX]
X-ClientProxiedBy: TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127573e9-f2ba-4322-1cad-08da6eeba990
X-MS-TrafficTypeDiagnostic: TYZPR03MB6669:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0mjkTJnnKfYTMzPBfCir8Dr4sx0ZYuybi3MSi/Tr68WfH07rOGdG3J5onzDxRY0fOPo79X+UOPyEAqKpzwgPx+LTHt2EzM8v3GHpeYvsqF8YBTgUCkDXq9YFXjLp5jqX1QNp1N4zMH3CQ7qbDfkie8iKxaqCXQRILmRdG/VBC2S5HFRD2H9hpcX0lw76wgS0zYE5EY2gmJRnIx9q4VYo1i/EfMlySff1tY1pkp2zcaaqdiH1hWf3jubFnckyflIXVPWN32Epp7W5NQGBdBv4h44M+N//SR89+jtBiXh0He7g0Fl5dPlnmT8i4Cj/Jyw2FWWSyKfG5Vc3QxV/dIawBcImenVFGm/Xqhg78oEwRzdX2wDGv4H3PVN/o2IedYg04XbG8pad40w8RnGqljKCJaw90tOO+BmnikhfcxBwHRlA3gt9YLr49h2loOlREqyaCfY0Na0Xk9dfc0KRmTVwnc8OwKIvyn/nt2w4+EFDQ+j0ljBiBh/sPiSMdSYsAzydfEmZWbmC/9Bo3WcQjQuu3+AksgYsDskze+mB30no7A20aCc9YWPyzMvIHooVDTUQz46fQ6ASbv5WPG2e/hZfOJgsX3Kg4NQWH2UNFhra5LvMeXI0LboJaHwOC6kXRhRmFUbvNL9uv5PP+ZRM9GQjGLFSfuOrOxEAWzf0KtmiP0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q7v0TS+s7vmJe/e9gk01Qoc6y1U16TPKJ45vYjVyf5Wsd9vE1BcPHOFC0Z9t?=
 =?us-ascii?Q?mewKUGfqbO04DTRzyGDY0Pu/8yE4Adwtym8fVfL9WEeJIFWnCu7qgTpGy2Rb?=
 =?us-ascii?Q?auMHoWffXUlyBrcGt2JHqplDLc/XB+m3VjSofNZgz+RZdym5uBW+OnBU3+wX?=
 =?us-ascii?Q?FOcuxxrB+yUyLhIAH0b3domzQHgkrFEUc0QgK+U7iroOowV8IrbizyNCVbOV?=
 =?us-ascii?Q?OwOPZStruU2PiL5K6E24VXJtukyooKwbH5jxOdKGZk+9q+vVud0TU2Cjxye4?=
 =?us-ascii?Q?TBgrivKAL7xG5tOti33UB/AHBIQ8GJGM5bR9V5ej13TFSg2gT2Z5SsLLCBn+?=
 =?us-ascii?Q?gSOzJRM4CdANYcz4wp3KiNvxvXjNDLT2VwBx8S43JvdM8nvUfQj1Qc69cZDZ?=
 =?us-ascii?Q?3+a9Jyld2OHzrmJ0Py4q5IhAXdHF1mr1IS5/3u6sPWwSwaK9AL/aAyJD3HAi?=
 =?us-ascii?Q?49kPpu2QiG+q1oblZDbHdpn+ffKEAjGWs18wXNgZFLDpgDbKXvmiteZGXttx?=
 =?us-ascii?Q?w+XWgDx0ekFzT+vFKv3TZAcNYTa834NVFZ37lKAtrpbc3RvjvyhmlBLvvFiX?=
 =?us-ascii?Q?s0m8B1AciJ8c9bUx2Mg5fi0hTy1qzFX9YtRtTj9DyK3RLrz17pclGrWfJmoS?=
 =?us-ascii?Q?tu9tA+qjvf8NyHjXVDneO5Z3Mm5wXpMkDuUJI5gpO8o8D3nYgEhY1yZcSs8M?=
 =?us-ascii?Q?6q72grTpAqz0VQcG97YSPCAsqr+cwTtVHvijhRfWiVcl7MyORRCXLsg7/BD+?=
 =?us-ascii?Q?3MKVeJQ4+kGNMEKkyyQuCUByMyJl81Nl5HDqxxFbtijmJ0S6fFscZ5PJbR3x?=
 =?us-ascii?Q?j2RX1p3l9QB80s7lNThSGazIKo5Kss99OJ4wDsWJ6ocFA2zw2H61jFtam9yk?=
 =?us-ascii?Q?O9IHWcFlW0D97LCaVPhxkqf+T/Fl3HV4ZUhNIKybRzqGoQodW43pyuQno0v0?=
 =?us-ascii?Q?okIw42DqpnOFnkyKD7/1QP/l9jx7lsPgeGKURcaOA6qrf3xUvIKQm+mLgylT?=
 =?us-ascii?Q?FkK4duTkUNAqJo3YwwW0+E+TQFVF7BXfQ4F4ZgnlJwAfe9Duvu2fOy0EbIGy?=
 =?us-ascii?Q?IgznOafrH/4F9wThVGADpOPFePOt2dH4lneKykLVZvvfxIdMLeTVGwdE5Hpv?=
 =?us-ascii?Q?XKR9APCwXhWd/GuHvoGfXOoploaE2v7gPVtKCNf7ziGsdJQAKsQzW6rdvAK+?=
 =?us-ascii?Q?AGS86hHOi4OF7AlhcknMblHFYLx6q5mN0ljbbsCS42G4O9fOCNtroGfT6MaE?=
 =?us-ascii?Q?x9IqzkITxVp/I8RruDCuXKtTuC4Tu3EFJUT9t3Svbw=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 127573e9-f2ba-4322-1cad-08da6eeba990
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:46:07.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6669
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v8:
-no changes

Changes in v7:
-Revise typo in Makefile in ptch 2/3

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

