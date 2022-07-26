Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084A58103A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiGZJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGZJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2039.outbound.protection.outlook.com [40.92.52.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EF31DC0;
        Tue, 26 Jul 2022 02:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuT6s0Xz58UlguQjiTfhc4D/vUZVzAc8IQcYzoLUMC8UHMcx3W0AUwa78MsAHfDeyOsZF/CgtmYVCWWen8eQKJJFfZk2eykH+MtdYKn1kZ6ANRPTVsmtwku2ltbcmNBmO6CTaxBIEH63Yq/BFw7tFghrXA/F+Xz+fi4MS334xxpZ1j83F4Jgc3q7kRv9gYXrHAzzLmc6pSoUjmmB3zfFfrbT+mr7DfVuF8SFftauRcioJbc8uUBZ11o9pkhgFLOm7YgR30ZdjhSmxPIpYPWIhtuucO0s4JFTZ6MfOYAoophxSyJka4De0nO8xFuk1xZpfIpyk/BacOmCtgBvL+ZUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXp8IoUVW33481YwgkHUSh2b8KFdtuUWOsIr8CQWs7w=;
 b=Y/P2zHtnXiPQGd/ZM3fKu+9wZUlaAMT9f+bV4BbfY8bh0xPZw5XJJwPC7pRjn0cD5LLBbJW4XIChbg33oozYvKrKRJLRZ5zzwItHb0+QFNsl13tZTnpYePuqH4NtR98dg3LlJiog/AEjLORQSlZ9+XvMIVqGZgwH/5spssrguxV9N+bzC0Cg88BG1HVgCkNjrGgGNTg789/wEHVEDAZyI7eA/Ug4fPi3JKRFhw2XSTDFug7xdoolAPWzmwhBePzOmYMeCLXvwzNSPE6s3fadGToGAU76TKCto2wUUFkRnZ9CbZvQ6NIZezk7qfI/dadiOSLQyQmmDrxEgOBny9H5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXp8IoUVW33481YwgkHUSh2b8KFdtuUWOsIr8CQWs7w=;
 b=D+iY97pKOEjDtf/imHth8iSF2zQrjFCB72TMAdxg4IagoSDLl6JhFj1tbbsYVwpUTjoTlwIpwE+/CGXupEr1XWG/3c9w5TuGEQJKE8jbavWnbUYmLcdNOXcV6WsRMAqANjO/vkJXtgv4v54zzcZ10e64dZXDzN8l1Trnmv+35ohw1RLMbHOKFh9yi7wpujn/M0IMkGfyyYr6pWLlTpYr7CvLqB/P9cSkdJOblR7kmzj4+OD60QEuUrt1f6VWY6t4jtnv86L17fegZqMBMg7IhEszykUvpiaS1zrvz//k/7gCg/HN4s1i0I70iKgtNNDfeXkgFRkEnk2wzT29Q/KDzw==
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10) by
 TYZPR03MB6669.apcprd03.prod.outlook.com (2603:1096:400:1f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 26 Jul
 2022 09:46:16 +0000
Received: from SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c]) by SG2PR03MB5006.apcprd03.prod.outlook.com
 ([fe80::40c7:5bd7:216c:fa4c%7]) with mapi id 15.20.5482.006; Tue, 26 Jul 2022
 09:46:16 +0000
From:   Jimmy Chen <jinghung.chen3@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 1/3] dt-bindings: arm: qcom: document sc7280 and villager board
Date:   Tue, 26 Jul 2022 17:45:47 +0800
Message-ID: <SG2PR03MB5006CE1EB9BFD95511133CA6CC949@SG2PR03MB5006.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
References: <20220726094549.263899-1-jinghung.chen3@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [UBXS+GhDZA0D8QOjWKEkuCdQVQKBFU3O]
X-ClientProxiedBy: TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22)
 To SG2PR03MB5006.apcprd03.prod.outlook.com (2603:1096:4:df::10)
X-Microsoft-Original-Message-ID: <20220726174436.v8.1.I338c337971904724a52c65641f601d3bcab7a990@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e123787-bf2d-487d-6cea-08da6eebaf51
X-MS-TrafficTypeDiagnostic: TYZPR03MB6669:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rEVOZ4d1oavhNeMGyP+xMA1eanBJoOrK7wfWn5HJrUgQ+D1sVbxEMXIu2g3lgnSVc7ep97SozT9lUCIDYDNBSIdECEVE8aiN1JISW/5nbk4amccuPsAw+rfgdLdmCw1pcjj0n49KlV9tYzYB2QnIUhxsVGuMQmCLeFv916Vg4IFCQRezz4fvF2Sqp4EwYFGyjRC5UuCR7bGcm+udYYTr09reQ/a6DcBdZFqyxFC2BelvyUIPHqDTzjSoHttGetsWhtlbHwKv7jOE0l380lf3eZ+Ip+W8Dq1jDUx6whU8DuMjYdgW3GWvAki5yMNM99OAJpR3SfdjMVlCjCOlZOzhE5PPJdMK8n+qjkX65f38lsClJCbF62aA6X9+fCanvH3jON6rcFAqOv3y20Wn5JWCltmJIdOL8qLFYYOg46Etqs2eMsGwHmTOED4NZ9IyEmEYsxbgoQr8dUkP56YwHWXY8ZYaphJsbzH1nB8zisKvhs2984bIp0VRVsdaFBU3kKgJOFenRABjPV7JFVC15XB3SRxXZ1rV0PCODp7YGhUjvWI1vpGQYpP1arCw6oAb2AvLie0sSG+4sC7hSmjzQPZFPSnDsLrDsrcmsLTtzxfbc9wNBQslEpw0V+JaTIyos6o
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqDHaHWRMrRBO8LOz1756baYwnMEZQPYaJ2xesGQLe15iId47z5o26huacmK?=
 =?us-ascii?Q?9zjIsqiRUPNvuLaBG9xZ7F/NXhXe08IRTF3Ky8fyu4K77CtPgBIXRH4aWRmP?=
 =?us-ascii?Q?6m/DP2wiuAXREJoOrNPirbcXrvCmec1FZL4FTnwN5590RnBVZsnoCgGUguXs?=
 =?us-ascii?Q?ebA5WDVTFGAUkzKkFwbRO7ua9QEGUciQnCyQ9v5NZHETRHrKR0w69iWcv1XO?=
 =?us-ascii?Q?JNzxHC9Sp2B7hzJ+tR7zUSrofnkVBs0PeixlUms5SKlS/2zoyWOF0e6mWVcA?=
 =?us-ascii?Q?Ojy6Mru5Pm2CbXbZAEZvrUk1RCbuaSvKpB++FQIYQT9KSis+a0QJRlNpvdMy?=
 =?us-ascii?Q?J9T7oh+CjS1MVMJ447fzNqWUeLh5LllTsVajUCY375OHwD3/l4gHEXKZGQO5?=
 =?us-ascii?Q?xQAe4TCkNJH/nvA8xoHPXPede7qM2//pCFpzEYAeg7qBCitujHIzyZtU9xYs?=
 =?us-ascii?Q?2fcrhWQ/yyc7pDVWIyZjQyCpv6qWqDCsyZNY3P8mQgZBZcHnUu59srjUjjlW?=
 =?us-ascii?Q?mWh7UG9YcmiSAbesbonoyGoS+z7rCyalxF4+d3krpvoXdz/zQanWvUm8FcT9?=
 =?us-ascii?Q?G/nHCOPFI/XZnebieAeiRGzUMReiMJQwPfCXjV8oslQbHB9i3ZlNyyDk2p/I?=
 =?us-ascii?Q?dagloRh0GDqZm6SXzBAAFHGyBuUTrQBOyEHhfqFdM08QvOw2or0J1mtFihmO?=
 =?us-ascii?Q?jlMDilHFaET+V7ErL4aj8jcZugUYL8+TnWk+kINaU9zs+rMPMH1AsdYnVU02?=
 =?us-ascii?Q?XX5NIhYJDgtFGWXXKaHuWYO9U40TdlHVGOQqfPxcufm26vouz4QSq7XFfZgo?=
 =?us-ascii?Q?d+i21JztMyDchO1HL8LGe/WFvpzyhO02XM+3i7zjV5A8cjaIaPRws3hpvHQ2?=
 =?us-ascii?Q?K/LNs0Hz5nD+qJXzG+6t514JNT34vfmf5yN3EUdSrftKG/bYDF7efsQ/WRSD?=
 =?us-ascii?Q?gWfz7iYYVEXv8koGqIP8VDsNo1jIPTIC3rRNB/FIcp3jw7vgOp0nOimnIC9C?=
 =?us-ascii?Q?CgkXFwfPMxheg8AuUz/RfTKf35p122PNkRskTstCrrMcmPK9n8Kd6N5M4RQJ?=
 =?us-ascii?Q?iquYFtH9NPYBZQnI5Uc5iKgU+0XbSy96u+HTu5xpAkVSwS2I5PepgGrMgvSL?=
 =?us-ascii?Q?R2BEqsnbr6PpV9Hmi17rj9qez2dYyLjCXPwkmivHTODDzILrMsz3KZWV9uaC?=
 =?us-ascii?Q?bHBhqG5ZO2sM4eyxED/3PY/lKV2PjZ68S4Tk9iaovFcMR1xIyUZIQQMwDhGH?=
 =?us-ascii?Q?REp3cxjuaA6kDULAzyPkZgI9b8UkvRsJ4SbUbnBdWg=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e123787-bf2d-487d-6cea-08da6eebaf51
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5006.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:46:16.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6669
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LTE skus for Chromebook Villager to the yaml.

Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v2)

Changes in v2:
-Add this patch

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

