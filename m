Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F858C2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiHHF2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiHHF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:27:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80109EE39;
        Sun,  7 Aug 2022 22:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+YCiIGHtPRwJwrN6ngTT4MvGrtziCtl80eB+gw+m4+VcPtMneaWRsebSkMp0809ET3CGcIv0r9Iia/PGdo4MFD4bgNMfHIOtULHvAoQ/AQD5qHQk2tsDAltnNzBRlnNhyHMDCcDsyzyvcv00Ef2EnE/0qO59DZDtoE9+8RbZ8VIOjJrs1iI3R37cKCJKXj0kdKDyPg8NRMWKcjLNmpdym38EdT5/RyqD2cSkCTMMEWMEN1Jqd4tWm5eVuupy2LZCRCLxT9LlSgrqhdkAvQNV4kCyyDbKCmj2xpxqlfg9V2Eq/Po+Ck3JFPO/LZ4a9zx9mb0nNBmFSMSOn9hhn0h3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vecqqKtJTuJrIxOYGwWPuDyc4axCHzdCS6gyTQOEWqg=;
 b=Hu5wiVl+YfETdG/5ahCEaJ2fityXiJSD5Icne5uiOU/Hq86f0dkIDUSeW+ofw76Y8bVxDqbEj2HYE9/np0Q0w/kSdQF45zjV2x22ZauJLQhSKF+0ohdMVQnaQG77HcbqSDic718pxqYHBwfoDOfLe1J/gO6SX55hvqQQV6dtF8qXiRvhIV5sexsmdEPt2Anj7K1h2AU0ccW4FWZg66WnEvAbAGcQNCuncGn85/h/BKdVv44U7KkA/q1zau/OE3Xzu2MTILymufw+t+rzlCetgNzIEV4ZGO6O2CMz5SaWPSha7k/bdbOA6Vb5srJaTW4FZV+Mq39oXLbhnooQlx0rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vecqqKtJTuJrIxOYGwWPuDyc4axCHzdCS6gyTQOEWqg=;
 b=LOkzQbhfy13B+mStQG5SQmJDMWaoV4sWW14z+4LioFBdcWJtsQC+fzVzaa6vy8VZvVlSR98MYSfDqcdWUSfa7cXTo23y+nZu7QK2p1qXjXY68iTlQO1PfWiVvOUGygqnQVg1JF04ePlPWwHsejcqPe85spLrtY2AajN22EdD4rxJ4ez1bRGJCdqRIzVmKkzVWj5k7UymeuasNWzRPEDfNs8wXJNRkUjB3XbZ1gRGCEvUkb0IUF9rC8avM6qotyYB9YpeNs+3l4nH2LW87J/Nat6/fH1aYCsOfDo6YJ/X0i7K+oWuL+WdBwJR+vVIR8uGw6wyNjqAK4jqewgB7jIsqg==
Received: from DM6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:5:120::32)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 8 Aug
 2022 05:27:43 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::73) by DM6PR06CA0019.outlook.office365.com
 (2603:10b6:5:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Mon, 8 Aug 2022 05:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 05:27:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 8 Aug
 2022 05:27:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 7 Aug 2022
 22:27:41 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.26 via Frontend Transport; Sun, 7 Aug
 2022 22:27:38 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 0/3] DT binding for sample format conversion
Date:   Mon, 8 Aug 2022 10:57:29 +0530
Message-ID: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 531895a8-f1e3-4fd2-7cfa-08da78feb833
X-MS-TrafficTypeDiagnostic: BL0PR12MB4883:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhLLpfrTRlL/6jcL3BiyymA3ih3hx1LA0omJa5rKU70B2oNbIPitgY9Re+jY3juC7i5j01lcp7fbbfhpeSfZtAG22iPguIPOwbDOmctoW3tFTZ0BZi3c/JZlacBomSNsel8qHpazH7qGtF5G2SW2laZpArpayBB1sQg9iXX8wMTfpBabXFls7/+soucsyzL2l9ouNWvjoodL1ao/1xWH3iTVlkCMQ265SJPHsOs36FCySDM4fPR7VeTRZL3yGocSuYg6X9LKnh9wTFnDCfSC5vBnOoS1ANi+B//RRfQM6k9r0nm9isJPMEa/UVa70z03RIRzJ907SatISLmPWU5q3FEU7xBsgJJXUH305EkT8XUdjT7UJDkWqGe9IcFUn+PBDk0HMRNu/naSfTT8v6KIk1ObTjoetILtL4DV8IIci3zb6+U+7qJzVHCbWMk61etIZNj3mo7Xe56V6tpuLKHWpmP1NazBIcmMa06KgHZpy5+WtTGNb145hwXvARlFgw7banTxglX/5ISti/PUP2IAZ73p3zi70OVuSWBC+5RIHKRv6UKtMppksIKLOURT8sZc1NlTXIm+OnsxR7y4YeyW1lxEud7NEM4fW+DrO1M75wqEbysYYHgFRLhrQepawG0It92tu45/7s68TTHIRTkuEYYPvqPFx3c+OnSSdVGNd0SrrrNy8rBnajdhuOKeK6k4VvSbSSsvsCwWoXd6pvAEZd069S1/7WrOGgx5sdSV1yehfv4nXq4bsHpZ8be8ge0jW/txgbdL43WNX6wfpyepVnaBNhAAjMufWaUB5hKlGTduxZBqfi+WYMJBlMQ9Vrtk7Z1AZuIQin4d1iHejwCApQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(40470700004)(70206006)(40480700001)(54906003)(40460700003)(316002)(70586007)(82740400003)(110136005)(7416002)(36756003)(81166007)(5660300002)(2616005)(8676002)(8936002)(107886003)(4326008)(356005)(47076005)(478600001)(426003)(86362001)(36860700001)(336012)(83380400001)(7696005)(186003)(2906002)(82310400005)(26005)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 05:27:43.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531895a8-f1e3-4fd2-7cfa-08da78feb833
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding properties are available to fixup rate and channel
parameters of a DAI. This series extends this to sample format
conversion as well. With this now DAI PCM parameters (channels,
sample rate and sample format) can be fixed up as necessary in
an audio path.

Changelog:
==========
  v2->v3:
  -------
    * Fix DT binding errors in simple-card.yaml
    * Drop simple-card binding changes from the series since
      there is no usage requirement. It can be extended later
      when necessary.
    * Use definitions instead of properties in the common schema
      and re-use this in audio-graph related bindings.

  v1->v2:
  -------
    * Move DAI params properties to a new schema and re-use this
      for simple-card and audio-graph-card.
    * Use string type for DAI format binding as suggested by
      Krzysztof.


Sameer Pujar (3):
  ASoC: dt-bindings: Definitions for DAI params
  ASoC: dt-bindings: Add sample format conversion
  ASoC: simple-card-utils: Fixup DAI sample format

 .../bindings/sound/audio-graph-port.yaml           | 17 ++++-----
 .../devicetree/bindings/sound/audio-graph.yaml     |  9 ++---
 .../devicetree/bindings/sound/dai-params.yaml      | 40 ++++++++++++++++++++++
 include/sound/simple_card_utils.h                  |  1 +
 sound/soc/generic/simple-card-utils.c              | 34 ++++++++++++++++++
 5 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/dai-params.yaml

-- 
2.7.4

