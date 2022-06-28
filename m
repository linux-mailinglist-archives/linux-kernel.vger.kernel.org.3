Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895555D720
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbiF1JZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbiF1JYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63732720;
        Tue, 28 Jun 2022 02:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1DmFnQtPBZ2FWKlEXOw7FlfkclwTglfw7N5NN8NTO76sR4T3aH3aGGI/JwK4Unr6fPzR+PJEkLVv5fqr1+CgVrMTvQDiaymHtlcZ5vRlEUlImWMmFFgxfoQH5eh7LYjCOOuPw2p5cglkzVtbHYADlzdU1eTxduNF1fYRP/IsnT1S/KgjQ8bKRXWVCIM4Ld+nTOHg8364V50Kx22VfqT1W0JsLzQTqffYg2SxqB4Ju9Po0Eq/zib2bpMdc2NzHVqSsFPjG4hMgeNCxw1+RPTV5gYl60OPbJ2VaiZSrkyWlnHcpPA56V2GhbrlBeQwgQkkzqdB3wzDU7wOqkeyFQk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ij2SnExPyD/dYwS6WJPhp8Z82lioqHAqdcTJyMDSxY=;
 b=FTEvHwHsNFC2h5ZTc3bTW2A0UUMblcyFaUdpmUt3CCLpPiPpyUkkJHCtM1RsmFvGXRwc5aKIbFxfU5wZgXr7rLbwRqVlH+HXi6uh4R/CpH1lzmscj/ZYbYGhlSJp225daQ9nqM7/3Q/n1Y6UUjnmZJck4vtqS40flKFygDTgzhnlb7Gjh7AZx3Wrak/6FNn7e6LAJKQfFy3DvFKbuzvFHSaFIYKVFgtRtm0Xn1wQvQWbySp2f4zVuiqJ+fbLqTrlHromC+58J9Qp103OLwP18yYLQEAWqUJbWg59M05oCUGJJ9oPpWDLmM+sJYVH/16TY4aV51gxMpL1YcyrSZ88zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ij2SnExPyD/dYwS6WJPhp8Z82lioqHAqdcTJyMDSxY=;
 b=knCvM768Qy0kUBxCJbHR5Be56zskPPxwOxu2UNQHhLw7dw3YTKQAq+D2xGRVSuTwaxJGVs0/yic0bgrxSmPKZhP27AUwR/nS4QOOnv31B7VJNhGfiMKcCPww+2Hotw+QON8fI1Aut6Hz71RgYPDzi81HN3fneZORxiyuCD5X4rx3fLO++TsoBIkihPU1DX1g+99bd8PxhlkHcavYFX2YtSjrGloECGfyRjwEqfVsbzP1HY8K1FbzKGOlKOYl87i9QCIhrqz/LXmh1ERXvvtmFXpXbOwDQTmIGeqQyqvCQVN0C7C+GR82HjQDfsjvlOxoEg0XSbYwswn/lbZYsJZc2g==
Received: from DM6PR02CA0134.namprd02.prod.outlook.com (2603:10b6:5:1b4::36)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 09:24:30 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::1e) by DM6PR02CA0134.outlook.office365.com
 (2603:10b6:5:1b4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 09:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 09:24:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 28 Jun
 2022 09:24:29 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 02:24:26 -0700
Message-ID: <07382a5d-24c0-e83d-4de8-309e697cc0e6@nvidia.com>
Date:   Tue, 28 Jun 2022 14:54:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Patch v6 0/9] CBB driver for Tegra194, Tegra234 & Tegra-Grace
Content-Language: en-US
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <bbasu@nvidia.com>, <vsethi@nvidia.com>, <jsequeira@nvidia.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
 <20220511201651.30695-2-sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20220511201651.30695-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64e728a9-e154-403d-19e8-08da58e80100
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/dEOLhg+zhsaI+GxTTHqI+6ml6nUfwhHH16JjYlLGm1y9jzE/hoeCvuMMlxv1APlXpTZyonlGBHJqU/2eKBzZUiQ+G089xzj8/AeD/F+yCFjSK4F29CY/6VOoTxulNwQp8L/TX46/I6tjmKfv26Spg1Slai6/H1K3XtDHysZ0lA91wDTZQMqD7FPd1ytWINsYycqJ19lssWuo80h7yfE4IsiOFzfKO54O5CHxAnKR+VTtI4eldoKNxhvkNOTN1eMYgFUDH1KzutjyQ05s4tUVGsBi1S0R/wMBIcE/u8rM83BNVnVVt5p0l+paVtzKGy7vAZ03M6shEQ4dYBWI9XhPPjAJIWrvzse84CHlTqMuyDzAy0BFg7bZJ/+hw8iW0kLbmDivC8kJ9KjYjQZeVe4keAdziSV/+BAGXmgh/GRXbhrMRTsp7EYmp00+wIVSkLnaxlvB7Rmvj8xUaewtJ/cdaRibWZsNbk8cB4s9w/B0/FqXJJUsZdMemkzwLtUjQelY3Qet4/XufCiKa+FFWHy5VpKpFgrFLr4XODWx/m+pZT+AIRXapIP2Ivh+7ObolWktWkSuoFh1siEvvLGN+FpYJiHq99v9cr/fW8C1VfF7ye2WLaA6Dbz1szff5B93QG0GVyA7Vfg5UjnHhw8FvDcblw6hcQwWZ7AZI//0D37enhxOijHX4+SOvwLFqYe/XlLIlOuyxowcSLubJ2lBqcVh/PVGp3PyHQQOqi+JZU1EZWMEYMBS2bKN8ILJwaDpjxdjVMs8W2rc7wUF76OZq4rWTwS7wswnNk4olMrNyezcGNUm8d1+mF49gJVgTtG1EfjUOvwenNXNWzUPb2TluM7z63r1PXomk6mXx1R1QNzwk=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(26005)(70206006)(6666004)(316002)(53546011)(70586007)(54906003)(16576012)(4326008)(8676002)(110136005)(82310400005)(478600001)(36860700001)(41300700001)(31696002)(40460700003)(86362001)(2616005)(107886003)(426003)(83380400001)(186003)(16526019)(356005)(81166007)(47076005)(336012)(8936002)(2906002)(5660300002)(31686004)(40480700001)(36756003)(82740400003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 09:24:29.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e728a9-e154-403d-19e8-08da58e80100
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Gentle Ping.

As we have ACK from Rob for DT changes, Can we please queue the patch 
series for 5.20.

Best Regards,
Sumit Gupta


On 12/05/22 01:46, Sumit Gupta wrote:
> The patch series adds Control BackBone(CBB) error handling
> driver for Tegra194, Tegra234 and Tegra-Grace SOC's.
> Tegra194 is using CBB version 1.0. Tegra234 and Tegra-Grace
> are using CBB version 2.0. Both CBB1.0 and CBB2.0 have
> different internal architecture. So, separate drivers are
> required.
> Tegra194 and Tegra234 are using Device Tree. Tegra-Grace is
> using ACPI.
> 
> Request to queue the patch series for 5.19.
> 
> ---
> v5 -> v6:
> - Minor changes in yaml files in patch number 2 and 6.
> 
> v4 -> v5:
> - fix warnings on diabling CONFIG_ACPI reported by kernel test robot.
> 
> v3 -> v4:
> - rebased patches on 5.18-rc5.
> 
> v2 -> v3:
> - fixed warnings with GCC 11.2 and W=1 reported by kernel test robot.
> - changed some function names to make consistent with tegra_cbb_*.
> 
> v1 -> v2:
> - moved err-notifier-base and off-mask-erd from DT to driver.
> - yaml fixes by Thierry.
> 
> Sumit Gupta (9):
>    soc: tegra: set ERD bit to mask inband errors
>    dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
>    dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
>    arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
>    soc: tegra: cbb: Add CBB1.0 driver for Tegra194
>    dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
>    arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
>    soc: tegra: cbb: Add driver for Tegra234 CBB2.0
>    soc: tegra: cbb: Add support for tegra-grace SOC
> 
>   .../arm/tegra/nvidia,tegra194-axi2apb.yaml    |   40 +
>   .../arm/tegra/nvidia,tegra194-cbb.yaml        |   98 +
>   .../arm/tegra/nvidia,tegra234-cbb.yaml        |   74 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      |   62 +-
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   42 +
>   drivers/soc/tegra/Kconfig                     |    9 +
>   drivers/soc/tegra/Makefile                    |    1 +
>   drivers/soc/tegra/cbb/Makefile                |    9 +
>   drivers/soc/tegra/cbb/tegra-cbb.c             |  198 ++
>   drivers/soc/tegra/cbb/tegra194-cbb.c          | 2261 +++++++++++++++++
>   drivers/soc/tegra/cbb/tegra234-cbb.c          |  833 ++++++
>   drivers/soc/tegra/fuse/tegra-apbmisc.c        |   29 +-
>   include/soc/tegra/fuse.h                      |    6 +
>   include/soc/tegra/tegra-cbb.h                 |   43 +
>   include/soc/tegra/tegra-grace-cbb.h           |  219 ++
>   include/soc/tegra/tegra194-cbb.h              |  158 ++
>   include/soc/tegra/tegra234-cbb.h              |  342 +++
>   17 files changed, 4421 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>   create mode 100644 drivers/soc/tegra/cbb/Makefile
>   create mode 100644 drivers/soc/tegra/cbb/tegra-cbb.c
>   create mode 100644 drivers/soc/tegra/cbb/tegra194-cbb.c
>   create mode 100644 drivers/soc/tegra/cbb/tegra234-cbb.c
>   create mode 100644 include/soc/tegra/tegra-cbb.h
>   create mode 100644 include/soc/tegra/tegra-grace-cbb.h
>   create mode 100644 include/soc/tegra/tegra194-cbb.h
>   create mode 100644 include/soc/tegra/tegra234-cbb.h
> 
