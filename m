Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18154546B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbiFISvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbiFISu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:50:56 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-oln040092065080.outbound.protection.outlook.com [40.92.65.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525387A18
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/U1k+ocvFadfcuMcHAQTE64Er3aA2eKtWHm7Tbsirm/55BOHYrKRGQoJI/qBGM8aT7pSVACh7rCPAfE++N8UNZc9SE/vv3HUI1isObhyMNe1rGQvBrXMn03xjvqRxF0jiG43q94iBiYyQ5xnN5dyeN4tCT60HdFbKNvAnwkiHLKtwLc4JddIXzSQ9Qd9e3OVPe+S3sVXgoFDcTBtgdt/cByimNdi9tYaSch1a3tlqpHjayY/Q3E4BmzZYQbdraCK7E0TDyJdmQPRbK+RVkh23/95rb6SPSz1j1JRbn6ILNHLSqjFfpi/KxEFXCTTIcOK/wT8rVSDLqpIMVunDaVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YZpG014oFJ+pMggv6gDxuHyDI8q0SkeapmeW8x8Tp4=;
 b=LTELKKeXd2wceYKqsZ1Sv8x8QnXyErylqVzbS/sRB68xQr//06YG6TfLppvo8sjn4SuFUdavyfExpQd5DpcerF0aRtva/61/6MovvNLNrtkxV6KYugUlHPIsL5a3O8HMloOOrp7RmgBp9Iy07GgFrfBuTVyi4KsVsnObYjNj3A+cLlp7gfH3uJtiaTsLb4SiNbpIHaNGGvehtb8XXNFnuwjdmbNzKFKBrlGo6vT2MXQWbc3XY/ysR8r+3f3mL7tZVBUMqNY4XcRnYDm1Yjh9obwHYhqzsUe2lqvNe0yFuLvNR5G/3Pyz35FtF7P6YUKz8/C97wdI1SdF4c3rY08aMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YZpG014oFJ+pMggv6gDxuHyDI8q0SkeapmeW8x8Tp4=;
 b=SP3ap3dyEIOw4Yz6i5tEQZdgjLU7JFdiS9w+wS5i43wsipoay2IzDaAD3Lp2rF1GcUdRtyT+zjIdg1yRS7kZNl/f4tKCa2URcrmnGb+utitEyYg7ciFguDVDwE5fgWEyK64OStA3/xcV62TLYPdxhP0pfi2JJm4Lj3AZF6KruE8g9TmXQdMd7Ni/XW3KMSH1UquN0tZ62VjrhnB6/TrsNqRiRYzOMlnx2M/Xw5ZoaX93K1OX2nWva1fpc3ok2p8KU41XJO+xsPqvUyzncwAzuPBPS8aIT84+N60CqhC+a1NWfWv7NUNOi+YOx5GEk01fwYv/gjlelhxxWx2D/NNi4g==
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::10)
 by GV2P189MB2283.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 18:50:52 +0000
Received: from PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d]) by PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 ([fe80::5ae:1a99:f05c:b75d%5]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 18:50:52 +0000
From:   Saud Farooqui <farooqui_saud@hotmail.com>
To:     emma@anholt.net, mripard@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saud Farooqui <farooqui_saud@hotmail.com>
Subject: [PATCH] drm/vc4: hdmi: Fixed possible integer overflow
Date:   Thu,  9 Jun 2022 23:50:31 +0500
Message-ID: <PA4P189MB1421E63C0FF3EBF234A80AB38BA79@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [E/wOZ4BXRHu1nex+rOgwLFsP7G9Lzk+c]
X-ClientProxiedBy: MN2PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:208:a8::45) To PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:c2::10)
X-Microsoft-Original-Message-ID: <20220609185031.1218731-1-farooqui_saud@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a9a49f4-549e-49e4-e899-08da4a48fa15
X-MS-Exchange-SLBlob-MailProps: 3UeWkQkuiJMknb89wdP9bRejgndTi7hZQntzzyKwHa0oqL9lY+96MloLhFSvix5OvZbpJmWBEOcAd98zoMJWIrrd14PPiN62RCmHP/4P/Wj7RuQyQnvBeIqvTm9OChxCld8pXcU4VseBm+zMirwCoWLLicx5TuTlMzeLjCrVxS2ZTphEoPq7V6UyHz2JP2SSFhfyy+PdNhquCdZqZZVMEzL22bp0QzjNZDdo1ajMVGy0xVO8KSWAhfogtEhZ3cIdASV67HocaicIdjJUCWphiH5+Ov8iZhNUvokJvFG+sd3rgSTxZbrUvP1g4jv1AyO8HW2aXugw9m1OTbHGVRqgA6OXazOKn1hU8IsDTBbqQ+osJk6Zy6nlWAMlmognIOdx/Tk5pSxRZ671IH+MtU8ve2gAFnZHHmgz5LUEaVGaPBvxkWe3yvo6wzpzcNthG3UmlWk1Km+wSXBxB4lVy9IENwWBtPQs4wlt+aOqtbRLII+rfXzLV3VmP+6aRtUIwLmdyaJpLzjbDcWF4WQXtEBAqD0j5S22o6li17bXZobaDuzspFdyjKiaDMo5bhXnsdOln0QKexJGwVAgbb/FEIizuK/df85UOyEhdBb+QRx0uyGxTwBkO1CmRcL8/p2xp0EF74jan2Hv0qX0m14EWSoPlcWwfJoZsxLRrdQZjwe5c5KDjUm3t+d3v1tL2tgoAq/jU9CC6BD/xRgdowGlnIKCfttYO3RAEqpjZRF8dGlrPauCf/xN+smwwA==
X-MS-TrafficTypeDiagnostic: GV2P189MB2283:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pman93e0BuXIsDqzB/MfiNfyBuL/7QhHDSTWVnn1ksa8Mi2UwpZipmVvJd/c09CSNOcJGw3cKQODxY/5bW62p3QOdFJsJgI6lAteGaBvSMFBfVxi0J0z5m+qXTkk6EOPFrQPZ0FvY9OguRqaaaczpNHSxXgtnnDvU9YWr4nQ4/EuOnTUx5FKiukRNHSxheGOMdDZB+3LunYzH0GdWA/SB5rm0h2SA+MNRWYAp/UJYdDgY4GT+lnGM9AonKxSO+wEXAAlP9RpCH1L9CNDWHgo+YmorB2ntp8JVm22w42Gt2Cuel3eeKnZ+L5YRLo2Z/Yl+V52303xRqpyx/4rCuK+z4fcgiOyUDg7lc0md0fEV2fQP+Z1XLRbXAmjEolugWTT0FR/0ARMjOjr2x5v3O9wZoIiEoMr4woFxnq/G/yjA/BYavmht0De5KKQ8sEyta3yCBWmvsO7Y9wFIVaLpPXmjb21mHp1DyXEmHdgTxLXV/YdvkZpMdfmJvxw6cioN4+DQlMbQAlrDw7pKGRbwJT3G7f+NpSIUxhIdR+4KwigNU5Hpeu1YrYDKf5jDfLv8Q+pUTbbw+fS4idu2CspbQbVTA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avYrv98hrjTOONCJlsTWePzkrdKYHPhP/XYVBYpN5ZfpVChpbMCOey81OTyV?=
 =?us-ascii?Q?q9F69jgdGI33jS++xYMhHorGAk0eQbkwh7Lh+RcOZGGaOQ2OZ5OoXBbYKfsF?=
 =?us-ascii?Q?rbuMTV3QH9JsEiM/S6qqMCnfJ8RE4q2ooZS/1RaP/vHVxKocfIy+tizIcbiR?=
 =?us-ascii?Q?9sQ8HmQ0ol8XI2FJejUWsfq0x+mZMChNHWAvi9kjnnrcIH9M5i7r8j+PRlBg?=
 =?us-ascii?Q?iEKN9+E7OQn5BUokGm1lFYWPx16y0WuiIm/rIhIMad+N/aw7mNidU2Iwdjft?=
 =?us-ascii?Q?Gm0MxnZc/Pn8yKaBY8fY/d9ipXmabPWITphfbVlp/w3uWVBKCgfUYOEOCTDT?=
 =?us-ascii?Q?eri1+rvRza2UyHbCTwB07hMVdmsVZjwJFces7FVmS9VUNYsYHybQGqh00YLS?=
 =?us-ascii?Q?4xK9bf52FpFPcP/wH/JDMASjZg50P7WtVu+PPEjpQxSUloPCEw334HalYJl4?=
 =?us-ascii?Q?dF7XKLz5e0ktIMI0JcaWYAj59od1uTJ1P7I5I8ji7e/FZopXtuXkR5IMordL?=
 =?us-ascii?Q?nW0X4S3nlhwS0JEFf5M/MB/8P2YSlLalX32/ehX5Vx1g16N4hGKx7J7kpoWH?=
 =?us-ascii?Q?EJvhPlbcsyMIJIakX2jDlmuLWPan8jnCcf3IQp9K4FYkuVvgoyxTEf0RaKBB?=
 =?us-ascii?Q?VIMABMwqLRJmivmUmWcvAMQ9lwpehP9PlNYOXn64TljSqWdHvrwxMEp4OhQ4?=
 =?us-ascii?Q?X1YIl/UZrwxPmTBGZB2GtRYwQpIH5dwnIk1guSuxdNe+G467Xk17lFiGQT5c?=
 =?us-ascii?Q?hozj6r3UcUIvx1WT6rU31L39dCoFnY4JdRXohaiJOLQlYzX4Kas+7acTbtj5?=
 =?us-ascii?Q?gbMsoH7tgvI68ZCbKra/Jb1XiZI2joMzOlUCj6vVrjge1UbCvLn1DCtfA+yi?=
 =?us-ascii?Q?Smd5eEPq8fcC0tL/iGsJRExLQ4KqQRKXWryCykCfsUUVhO04DhhtwczxO+yZ?=
 =?us-ascii?Q?vJMkbbkm+mn6jWiinv6MPPA6TfkMiGsG4Q/0lesDOLRI4+BC2/+7F4RmCcQ+?=
 =?us-ascii?Q?5ok4xzvY4mjN4cL7Rujh0F61rELdn3s35BTOQxng9wJ8H95cfByf2aXl8JCX?=
 =?us-ascii?Q?v+cfiFMJxVNMyBVZJZkcI6nakmZFTUhTecEAhi8ogNc7OIPG+fhdFVw64uBN?=
 =?us-ascii?Q?7274WaSsfqKj42TxPW1letF3XchnEvCXy1mAxbKjIg9Nt17Fc+uXHKZitReY?=
 =?us-ascii?Q?Fl05xmqQ+Omr0LT0CgM7vyLlhAPpeJxbU8g+Re9VFZrOiB2mIs7bSFgGsrTV?=
 =?us-ascii?Q?s2CXYDK0I6zGLUGjxQJy9W1INDJMyBJCcfz8daF07eIvLRYBWRpACqlkCXnZ?=
 =?us-ascii?Q?mPCWgUUNfn/u69dxtoJQBM9y4VQcARqs1rU1TLzRkbZSbygoH38TViopw9Dx?=
 =?us-ascii?Q?XUJ08ojERluTF2Ztmf8HgTw5BLHH7okxmUwxxxEQXeh9Bc1e531ql3DjF4pH?=
 =?us-ascii?Q?tpFfXQDzBjI=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9a49f4-549e-49e4-e899-08da4a48fa15
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1421.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 18:50:52.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiplying ints and saving it in unsigned long long
could lead to integer overflow before being type casted to
unsigned long long.

Addresses-Coverity:  1505113: Unintentional integer overflow.

Signed-off-by: Saud Farooqui <farooqui_saud@hotmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 823d812f4982..ce9d16666d91 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1481,7 +1481,7 @@ vc4_hdmi_encoder_compute_mode_clock(const struct drm_display_mode *mode,
 				    unsigned int bpc,
 				    enum vc4_hdmi_output_format fmt)
 {
-	unsigned long long clock = mode->clock * 1000;
+	unsigned long long clock = mode->clock * 1000ULL;
 
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		clock = clock * 2;
-- 
2.25.1

