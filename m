Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455AE564E64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiGDHKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiGDHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:10:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2103.outbound.protection.outlook.com [40.92.52.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FC3B482;
        Mon,  4 Jul 2022 00:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXW+FZnKNaQRM0N8ISYwMfI7Ttpw+IXZ7P6kVg4Nq2YkWa8B/nyMgpxN6LSjml9RRQJEPsvTFWBPV2cmkfREoNBV88Wlt9OMudkrm/W5BeQTgodR3l1z2eiio56V4AiWMLhfM7tACwZvuwMV2Y81aoPHx53W13OsBauispuHTgfYa7NqxXnJZyEOpDzFq1kBD7L7c+sBvES1vyoyKI6c1HVtweB+ouYTBIs403+zdbppcBa2EJ7cZypAiwphiLC2mTS4Sy1TUWLwSXhVtYiIzeKJDxFlfVOhLKJKmuI6+J8mKNawPdpTgzIB5F6QEAn0yOhWhZYiZIIqQZKmxufq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8wYao++s4eDVfvjgMy50880h7EQadQEQKiiPd8rsbo=;
 b=eefKiCJkxqM81IS9iBE0hNnWqth28tZrT3HIuqvX/OKnGUbpSK+r+Mh17Yc9Ry+c3rLCvLpyBNZzN4/L0jNeUiYciYox/xfInHomGuq+0vennqV/XC+R9yR1RX/Nb0VQv4P10H/TYMFUXarVMFh6ZfKKc6xQz1neFh9dHTARA4PhjwMsBOJSu0zwoD8SqBAr1DeZMdhs9wCJut9XTbLtDE5/WfSnnrikdyfagzw141TF49ymmlpi0QnmWaQE4DjrAbtKCi7fbrjKDcELbr9d3iiNn0A145dJ6McJ34UnfCtxD8/g84d379xuVCZdFjLLrkYSyuEGtNsr8SYUJKSVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8wYao++s4eDVfvjgMy50880h7EQadQEQKiiPd8rsbo=;
 b=oLlnSyQ8I9y74LuhcxD1kJvgfkMDUQK3G4xY7C1z9+1uIVD/M3jIOLhFWzQWj/1LDBBf8nYr2P0kCP68QPHxUvmW0UQrE80KsTPd3DjZdikichQTT6hjDmrzrG+bzqxUEqLoWISL9rnH2VQZ45TUMrOn/DoLtxIjjdidtmOH7w4NV06Q9D86SqeiZZna+WxcUPKfgNX72kzoPXQlIrnPaqnHFuxE0Pw1XiR+PlKZ+n5YIR926HZ7bhi/52P1Zbc1KGgkEwsu5TcDUHpiVnEfLft9IzVQVNMd2W53R0hL5zBYZ3EwxF2qlkfNaYeqnKt6dYcfEBkdomA0APtUfX67hQ==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 PS1PR03MB4844.apcprd03.prod.outlook.com (2603:1096:300:87::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.12; Mon, 4 Jul 2022 07:09:39 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::b96f:3a3b:5eef:e796%5]) with mapi id 15.20.5417.012; Mon, 4 Jul 2022
 07:09:39 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] [V1,1/2] arm64: dts: qcom: Add LTE SKUs for sc7280-villager family
Date:   Mon,  4 Jul 2022 15:09:24 +0800
Message-ID: <SG2PR03MB50068F2314F65CAE43A9594ECCBE9@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8p0iK/RgiPntaNRYGABZFt+fD23XWVpZ]
X-ClientProxiedBy: TYCPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:1::30) To SG2PR03MB5006.apcprd03.prod.outlook.com
 (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220704150825.1.Ib53c25c4a4fe2dce6531d56d64398bd5c13632ed@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efe634fd-fdcd-4867-bfd5-08da5d8c27df
X-MS-TrafficTypeDiagnostic: PS1PR03MB4844:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJx0OKup8nPs6KPkraYNrLPvwAD1+MDSWctkvspY2Urs0UXv4bUoV4MOcQE3eSCQj0iJ2R199xqu/73J2jgSdJ3GyNrCBFspyVC9/45NQdGup+GQAQ7hW4IdhHX53CKuHjwqq+7AQC03f64VoGztHFVU/c3hPtuKfEDs0M+59mIZweJbaDICHCxonQC4Q7zsqB9xgRlD0wGYBfubzbITGZh/uTNNgNyHLZamH8b7Hd6jUZlGw+c96qJw7AVYLzjFhhNw/Qgq80bg7VSTy9Xp9fMABxDCWXuC15DPbuAZ2Y1r0gSW0m/Rd0HkywmNvct3XcCZ84HLK9VM3+wMJwPPaZMyWIfjupxKNWlj6SIbt8NEdfT6NqNPkot1nyjkvO2/nnGai/+kad3FldnVE6sUxAm0Nyx6ohlBPvcI2TVxmYZedR0FULsY6lolNxc0b5C0Z4QwvwAX1oqbj7lqpCKRqOTqrG6J6VSB1dgmk7bejYkklVuqjhmREWOWvB+SoSpZsCH9CzGHsER1O0EwVgxUuv2T6f9KEzn5K4vtjd6kFBl8jazHQ86EMShdJRlnmCMc5Ftajv3Kn/APiC0DZ2dH4itaD2lfsXQ2FsKmhVUovf487h97HnVR2A7y2e7fou0Q03ArYqL4E+riT+D8v0PXRQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZFhrYfe4Xi5dy1V4h8nC2t/Bm3o4O/ki21afO+SF6esCFx0+hIasHfQVxOAK?=
 =?us-ascii?Q?RQiJiKCHsEs9sL9QEWIm3DFnI4Kul69Tu0728YFipQaCM0tLMz3rwQZ/9cCz?=
 =?us-ascii?Q?v+hpQmeg30O7HR2AF3tgHEcZ7Q9nTtyyxCz2TV6ARPUPtr70Kbp2uRGwCKBO?=
 =?us-ascii?Q?Jz8BXR4Dd22uvy5luiBMFnFEBU5n7da/8uYeYDcne/b90h7N28ozo7hUxlZm?=
 =?us-ascii?Q?oLb0t+b4UIau5h6ttEbTqmGSQmb2vA6REdnpYb5NQkKvRMU9kDClOwLigpm/?=
 =?us-ascii?Q?oLLzibNfOL3zSkMVimf37Ysg+tRKjpGvtDNBYEIT826JFEEag+6k9frKHzGW?=
 =?us-ascii?Q?8OeXtyXc64GTvDK/c7+OZnGkiaaT+WjIblkAbfBPjpNd1MiHeeL2ll9rTGWN?=
 =?us-ascii?Q?uemVZPY0G/fzX9Ld4HVHFVgYDmbWRC4y1gCoYzd3Vo+jFuKdHWqxlDfvn7/X?=
 =?us-ascii?Q?Z4ruenCTL948XR6Fyop61JmPJY6gTheQQ+i4D/ZisIZW7oF0IB9g14QO09wa?=
 =?us-ascii?Q?reslrKHKHJMxDUUxTGacUFDSzHzDaSTxI+A3cHxRTGLXeT2uwNxbPShEnfyL?=
 =?us-ascii?Q?/WiRZBlNLlTiz+z1MiQ84dpaRTPXYt5qVAo8hCrlSo/iArv88ghL1iQ0jNnA?=
 =?us-ascii?Q?usJHEx1FKhMjC9HN8QXK49z0pvL4719PauC0P/stewHNlxvxfNo+zFCtHvia?=
 =?us-ascii?Q?A7b4cYxdQ/fp+cm9dOjqZYdBXPUawNVoKtGG5dxDfFoJHqX9Av4igqKe3Rrg?=
 =?us-ascii?Q?ls13KdeJNE5rnEo8dup17e7x69RRw3gtt5oiDbHo00S0iZN77UMUl83X0udj?=
 =?us-ascii?Q?eiN2dpsK00dToJqYA84PaZ6dkiJyfndCPCbqrPQ48+frQv/ISxO5udxw0PPp?=
 =?us-ascii?Q?SDIPvb+bArHWJgIBM8O+59DqookqmCqaY+7okxF8ZOD9l3z1FzVu6WUnvJig?=
 =?us-ascii?Q?IFTh6uiHlEzXa0jZPGsv7uQ5tJ95TAthLRMEzKYxdVIYrm2W0FfmnybsLHn2?=
 =?us-ascii?Q?LwFBGRV7n5miAI1+UgboAH+uwVoKqG8QSUlnZZrRE54Q7fbmv03OimZBrpmU?=
 =?us-ascii?Q?mcyLjSXwtxJqj9CBBLVwXMGhxMToG4y6WW4ulHjzYlHFD2+EAO9hwArRLNfH?=
 =?us-ascii?Q?XWqK1oa1zVpCZWKdyRnHIynjRc3TyPwPKTCyWCF9N5Wx7sqJtjcFFwcpoUwH?=
 =?us-ascii?Q?0MSYY/Jfe22btv7rqhEjF0909HvFq7Omok3KdDfhQJ/vTG2afMW0ammJdW6J?=
 =?us-ascii?Q?cdVyF3ki3uZ2NKyTsoJhUjTlx+1UjbtH2h9zalwmUw=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: efe634fd-fdcd-4867-bfd5-08da5d8c27df
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 07:09:39.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR03MB4844
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds yaml file for new a LTE skus for villager device.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
---

 Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b68..a136b1389c2ac 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -529,11 +529,26 @@ properties:
           - const: google,herobrine
           - const: qcom,sc7280
 
+      - description: Google Villager (rev0)
+        items:
+          - const: google,villager-rev0
+          - const: qcom,sc7280
+
       - description: Google Villager (newest rev)
         items:
           - const: google,villager
           - const: qcom,sc7280
 
+      - description: Google Villager with LTE (rev0)
+        items:
+          - const: google,villager-rev0-sku0
+          - const: qcom,sc7280
+
+      - description: Google Villager with LTE (newest rev)
+        items:
+          - const: google,villager-sku0
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.25.1

