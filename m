Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E185609D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiF2S4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiF2S4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:56:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108782EA23;
        Wed, 29 Jun 2022 11:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6n5n6BVHv7o2Vk/xivboXPzOF2bP8GKhjJqH5tE0wH+ILbe+hnSuowiikzd9i/b4mNWafQCRs5OshTSAk9xpEHxQuzGFg6+SCy7hlb/CgGnT74a4hFBMJGvMjpJLIJqAarD705s0ypHxFzRLOYYjeefl7GPgsGy+AIk/wIAFdc6MWcc40/WdoxF82ztSMGWAr2SOZ9oGR3wV0ZMWNtH4dQRn5bu1EBexGnu8YS+mIsCzfncTGDqMNDO2U0NEtMDXZjLZFaOBpq6XckG/VP4ZVhGgJOS5hktNiDriaTM4P3lwwrJMmDPnDut270tKj7x0UShVS5Orj98tCCUCCVvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3/nMgJrfZFM0ecEUSpS74BkPx5P6JQVHbMu4dmlRrw=;
 b=MBc2tJSiB4Xde7f1Qzsl66dDAfP+q+x/30605f2/4xdx3fnzGG1wEpzswtvdAKDYFzuPfpimFcejjbEoRcSyEYauEeYpb7uD5zezi5CIus1n37k/knVV6zIdCV5m9sDWma/yH9rfaeNZ7MZIqylUubzs33YWeSJzDxDu+8kWLs/E47ETatNDhC0li25aR1VNSxXQ9av6lxfSnOTKZ1dFmXiKsQoJLXWHTAeZkiFfbKDbKC8Od1xrGiXiJcy9rzedSX03ZPJcjia88OWjuqgyYNhJSOoSgcUNeBcM8nvg5+ZIlfCjoUDnCRzN0pQkINyus+Jzc4Vp8W6KifjXXMS64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3/nMgJrfZFM0ecEUSpS74BkPx5P6JQVHbMu4dmlRrw=;
 b=dHKqh+wXD2AGXhKCfm1QHgZExisucHLN8TgQag4bncoPguwKyI31L9R0sDwf8qdb8nSR/yqAomT1x02aCjMNuAdkps7wQOcw8MO7twS7n8Q31HoNCpFy5v2puURz5kfXog7OMcu61jxadkD0b7uXvvZUtcAgSZyKwlaLLU6UJfmvcNxoVIjczY9kzDyV9x95iflaRIhL+eFvX+vXyF/xSziTYlhyeVM5TchpJoYUnNqKyVK4C23w8sGRoscnABBENXUa3SmPQYc3rHhjjjAZhoIFryigd0Nd214jZ1PkdlRgVErzeMBWkMmqZ/FsT21684K0otoV7fLE9k4jWA+YZA==
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 18:56:35 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::22) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Wed, 29 Jun 2022 18:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.14) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:56:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:56:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:56:30 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:56:28 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jassisinghbrar@gmail.com>
CC:     <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <kkartik@nvidia.com>
Subject: Re: [PATCH 0/3] Add 128-bit support mailbox for Tegra234 chips
Date:   Thu, 30 Jun 2022 00:26:27 +0530
Message-ID: <1656528987-29280-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a01bd4-0585-405c-195f-08da5a0116f3
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/oTTVvcRFJPa6vrQldTxvEeGyAnnMp4tBkk9H9udfxrRIzJNVhMVlAKi9RRwvUAcwJTbL5bPwDJ69kM/9eJlppG0eb60so+Nb/uaGFrXkZ7r41fXWnF/JpmHtxtcQbbSlLTmh/aWwZBZDFssJ/qHAtZ5ylgw+xmHsHJmqFHH9ftVgxdmYueJ+dfzQY63G5ul50k95kaW0iEIs4d4o9HNwUsYPds44Tav5SkePh10yW4U1nJeAid/KW+7nPASMxm4kOE4kyHAau8Jzvw+9J8Zw4t+eggrrKUhjJIGe2dEQCukWVxl1wVau6i01wY9+7j6WHJXbEo/OBlpLmj9AzEWfz+80NyR0epWp/kcxv3lCpArzClA7yQC9ydIqpTEmUvXPfgxEU2rNPe8iRI88SnVRP+wJWRZi8t6gn9HmjZ86HMe4Bd5HyaascaSVrAlavpp3G0eaH2x7VD12HznZAeiiJJkl8pUyLU99b/QFAvve0XwuERnAnzKY0ghhLJs3DucEioWmIHloVs0U3ieNgRRWGF6sT9YpivLW0zIImP8Hmc6VRA+ELLDQV34VIwg1YI7Fru2iooZ/1hH5khVP3kxWcUu1VxHpVQ9y+id/eUTRYOmhosqLQZceRinJ3WyKAhiT4+PQImbbbi1iLplL27ZZtW+ESiFVb3+8q33nNkN1SN6xcdj4JnM0Nskv8cND7rcNb5o9BuMgnCFTjPx46zjaO8j7fchckDqvVfHZto8wE5QJjKBC5rV/DTHz1alaKvib1DW3AiuHaqU4iOmnOpSYAbtWEvaSU0FHDLjwU3CYeDM0+HFvOny2lQjx6w+04/
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(7696005)(41300700001)(2906002)(336012)(15650500001)(426003)(83380400001)(40480700001)(186003)(2616005)(82310400005)(36860700001)(478600001)(107886003)(4326008)(70586007)(356005)(8676002)(47076005)(36756003)(70206006)(26005)(8936002)(82740400003)(86362001)(6916009)(54906003)(40460700003)(4744005)(7636003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:56:34.8000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a01bd4-0585-405c-195f-08da5a0116f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 13:05 +530, Kartik Wrote:
> This series of patches adds support for 128-bit shared mailbox found
> on Tegra234 chips. It also introduce tegra_hsp_sm_ops to abstract
> send & receive APIs for 32-bit and 128-bit shared mailboxes.
> 
> Kartik (3):
>   mailbox: tegra-hsp: Add tegra_hsp_sm_ops
>   dt-bindings: tegra186-hsp: add type for shared mailboxes
>   mailbox: tegra-hsp: Add 128-bit shared mailbox support
> 
>  .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   9 ++
>  drivers/mailbox/tegra-hsp.c                   | 149 ++++++++++++++----
>  include/dt-bindings/mailbox/tegra186-hsp.h    |   5 +
>  3 files changed, 134 insertions(+), 29 deletions(-)

Hi Jassi,

Any comments on this from the mailbox side?

Regards,
Kartik
