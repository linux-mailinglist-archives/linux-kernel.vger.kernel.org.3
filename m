Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960B350BC3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352711AbiDVP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiDVP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:59:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2022.outbound.protection.outlook.com [40.92.18.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B255BE4C;
        Fri, 22 Apr 2022 08:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwaQDXjdfW/TXCVREHMJleNslYRWkXBCc93jqHvobgHRlQ2EcTDxOV7minzOYZU42vt51tTCZtDfcfYw/UUD2IeP1zJpqS+Dm0K7X5zxU4aNwAuq0nmkZ3QoIQ4+5cD+P3PLP0PtbzIU/z/XlRvH50Ar1b0IJ9+PXqE+/QcwnNyJNCVHelGLi8iPUGwAbj00VZwsyiZaHUEpvKzVXzBnQ775/kG2Wph2sCVoG5p4ye24QIX4liUeRqN/GjeakyJLUG90XZCBBeHVAjlkAO3rcg7ddXd1CI1jExkGzym17WrV8japOVmAuJ5RPhLqSrnpuyDyC/MwZbjzQ3G3KldH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSOvOVo4owsPTCe7z/6UpT+MQ9CHNqBsLlT+gV0Zy5s=;
 b=dQNk8K0mjGfDHXC+UTGwukHsQ5S6FduzVRUe4sTfuEBRh5M900m40NE5Ev3Z+LhigvyhKp4dITx/EvrV10oJ4jIaZ7ga2tjBWvDfJfVP0T86kugjqcZmhNvAxIVhZxnTn1w564nx0t9Ffg9tZXBAfH9WYRBeaOo3ePJBC5D9HcBLVuyLmk9lxg/J4gRmP/XOnnH7BpUl8rHZpoBx34HFeh6XMYM7mQzSTOeoJBsgiVo/rJXj3OBwg7cKBlpg6y12b0fr3eq9GyljZMFf66VSD8ueJaU7OTsZGYoS8DYJTlPSWatvay120uMHgWsc95VJmcu1I5+rYONtBiC9yOmrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSOvOVo4owsPTCe7z/6UpT+MQ9CHNqBsLlT+gV0Zy5s=;
 b=lFdDhvazA5DZ9Uny99tyIYmA5ywI3Fux/YZQ7TLr76SsMGWbU27hKr30OdkZ0kJHzydj9wro5CF3SLYyS+Y29tirZXbRXYPF7/F6iZ3GXyo+XOa77js34alj5yk7E3lV952Sr4GOMwLoBr8r2l1DI4b8N3GMUZNgdoGi5uCgp4iTY851pWAmtM0ux0Yj3e+UTxd9UmfcTNlvyLoErcHWDXmMlO48lnZ6x3v9KN52XGTgKlYayWZFhZYzzLwQYKZKq5aW2PG9QTeokNgXrUo1brW1KqD+xdJqOdSgoqbzySwMhQVA+NgfR6c8MBbalq4lFxNu67Aookhq90IapqknEg==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB0917.namprd20.prod.outlook.com (2603:10b6:903:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:56:56 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:56:56 +0000
From:   icenowy@outlook.com
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/4] Allwinner R329 SPI support
Date:   Fri, 22 Apr 2022 23:56:35 +0800
Message-ID: <BYAPR20MB2472A0C29FAA2782487BD1E8BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gAaQJSZX2fxmAp1fh/5i678WGTo0aEVE]
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422155639.1071645-1-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5de612f3-2986-462a-b397-08da2478ba24
X-MS-TrafficTypeDiagnostic: CY4PR2001MB0917:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz0y/445Jq+EcEgoHtthQLiJLnhJ9i6JRQ3CHuxMOKtP7FTzyLRdfmRDF7K7cRo/n/UtejHHzSIdemVIRaXFmAlOlJDbkVHBz/v5U9X030Q9pOsDraVeeu95CEfRis3p4T7WwVEWdrRpecR8qloP8SUQk+FezI6OmRtx/1ucPnxOCMkGe01mTKLJZdgNuSsMK7iRg6LFoslkKS1L0F/v7QZFawwmuXdoS1B4SFtRKSwmrxLgKoVP6BUWrgDL+BjfBuN2S90ogslTlUx8DGN9DQ1Y1wker8XDUqs+kFVkakT6e2XjnWZ1G1bGGTk7/4KM4ZdcQYK8Iwv1023famdLr6zW6l0npcl9dWniUqvUFMSh3OBvWQyivPyZhhHNu8Ce/Zjy2M2Ix0UCPzCtLfnn1d8ezRXHf3AFEUprj1cElyGWagvWIiuhuXvdye4tjDOf3cFTaalwApliVALAZ7yKyZjXWQNFA2L+Tf0yU9vao6RhoYrW63iFd/VCQ27tYnHapPUhVvYpVF53bJHnvqkFmBxkWFOPQc0Zn9zsbMUyxpO9gF/o1Qs82vEPYowJiGhCLblXRhjz5mRWsKv3RmgCCQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0CIyfk3nTGAGkPeWzFdlecINvrc6863Goa5ngK4kbL7gvtL7k2eIEOia0UF8?=
 =?us-ascii?Q?LFIeHkIXhsfC5eQO1AOg6RLpBuH0BL3rr/u7juyvoF2JVowkBEvOiPQ68C/a?=
 =?us-ascii?Q?S2BrseFuhIwYMrX83WZlXaNHfcaT62rp+RcZUUaLtEFBtKJh+t+ZpnLbnGGr?=
 =?us-ascii?Q?BqhECXASEC/5+y+WHhj+uqdAuGknoXWBhhSpZ53eDZQSaR8pLR952xEkcuRY?=
 =?us-ascii?Q?fRM46g5ZZzjHaOoqgPzIA67b6ya88xeGFeiOPclLr5854LHKYgChAaZ/LDd5?=
 =?us-ascii?Q?ppKr8+nJXP60gn/AC7uKtzCTtXAjJUmBzppA4fcwqQyh0ukwFtMYDCBvoivn?=
 =?us-ascii?Q?9XK1hWEIofhbNu1xoXmLlrJV0f/C76Kars4rtuHRV+yHhjM9iohQTCv+TUlM?=
 =?us-ascii?Q?vgkz2bP05914Q/s7pCmmxKxrO5ZH4j1nYtaLkBrK8CADPDG7qpXM/S6MQrGZ?=
 =?us-ascii?Q?LaR6DfDWjPBY85vClgAFfdq+t45xxvOpn5zH369qNyg8uxyqJO0RlMZkoxX2?=
 =?us-ascii?Q?1pqqIwZucXdflK3WD/ylCSwSejNaDZLdlsIfxo0UY+OEmAetA5chdQzKLOLU?=
 =?us-ascii?Q?gEmF+DKVRTg+4skwcnufgJlm1pZeDRTszEukfdVlB+196izm06AFSkNXjU7L?=
 =?us-ascii?Q?fJJl1DyVac46vplvVKXYCUquHqsNsHPsLORJgFZ3l1rjnTa1yczNojkqoSaY?=
 =?us-ascii?Q?mgBLhY6mjaFaNEVoRVIcEFCCo3yAx28JZiqstzINkMlSDjZqxPIJKnyBtM3L?=
 =?us-ascii?Q?UodS3j7SR8ZTZlDHiA6TqbcSNgx0SojyoMQ4UT5sugCbQh37waJzeq2i0JN8?=
 =?us-ascii?Q?ltFR0lcziJAxsZBchAiK1Y72fZg7n+Guul7iWzroUfkZQv4g7FDJt4NCHQar?=
 =?us-ascii?Q?4A0ujUZaJY//nWas6OTE0nZXzeZJBWRXP01FxXvuGPvVIBysUXh/HLH3LJtx?=
 =?us-ascii?Q?tJLErvGnGB2p111mbq5G/RdOyoZLl3QL1Tmeged0nvIVqYDR1MPBRhuPqxOZ?=
 =?us-ascii?Q?xLBw3og5WfGiSPbmgoPbjlAwbvE5UgEvXECvjPqd7j3dbMtR0pwOMDG4+Q67?=
 =?us-ascii?Q?LO0eK3kEDjDuVfNgnuxQPlcyy1uhQmE5/5NXf59mJktN3XXoJNk2tJeoXp5u?=
 =?us-ascii?Q?bAhQ44fwKB/Xn6+tT8XZ4yWaBwkd90Sga+2We8eyZ4k8/FqwTMUF9W3yGzyh?=
 =?us-ascii?Q?GGD10S1+70dTHLSu7hou/Ls8njKP7usYHv7YdNMMEoRE82mxhbMHu3aMAAJO?=
 =?us-ascii?Q?o0EiDw/lrDcEiKO+3nRdHFZJgtcAAxn9mUnKVzcog1jTCuMrReIb2CC/xaBu?=
 =?us-ascii?Q?Y+uQsc7JJuMTSkRSoVzDkckGb9psm/2kKdU8pO0mFaNyRq2JTxgm1T/Iv5kc?=
 =?us-ascii?Q?kVR2Z6pcvOr2sFQMbHSH153NTnOpQWTW7iFTh1e+bHm+w0HskrgRrOLlZ9XI?=
 =?us-ascii?Q?WB4yt5qG4t0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de612f3-2986-462a-b397-08da2478ba24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:56:56.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB0917
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

This patchset introduces support for Allwinner R329 SPI controllers,
which removed in-controller clock divider.

Icenowy Zheng (4):
  dt-bindings: spi: sun6i: add DT bindings for Allwinner R329 SPI
  spi: sun6i: change OF match data to a struct
  spi: sun6i: add quirk for in-controller clock divider
  spi: sun6i: add support for R329 SPI controllers

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |   2 +
 drivers/spi/spi-sun6i.c                       | 112 +++++++++++-------
 2 files changed, 74 insertions(+), 40 deletions(-)

-- 
2.35.1

