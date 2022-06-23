Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190E155750A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiFWIKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiFWIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:10:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F054756E;
        Thu, 23 Jun 2022 01:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+LIF6vhEeybo7qlbLLuy2HbXHld6oL/WiBqmMadzQjL9RB3Dwr+aPqtXKy7OqBO+ypFqAs56PyRdPR6KcbgB+0NunttDg7AFRMJE4LN9oehwebn4hGMEbpAg93FwrifnbWSfen876QeVTdvWexdWQsEZ87kuHntV5NGshbjM3OhiUiHq8Z+oYg2N655clxbWGKPpaA4Q6J/u3dpYOy3ltzNXcpkuwhiWB4vMiefoICkTUorLgHHXz/s/Et3jW4xm1cbIkcxbz1/J7bFaY1I5oz/fyGwRGqpEfrCcMSRnnkPGSMMaGxA9C9IDMH1QvccEgcWAgNrGWHveDsxZiau3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTmSSQzSGzYM9x7B5tDaQnit5ZNgYzzYzF7/Kf1XcSg=;
 b=K4PD6KNS8h5ugkUmDAfaXkgqo/kG6UnvkGOcdDmD4+kGAiSR6AoPXFTOWzrMEfvXrEfM8oUYSg0rlevhMfgZYYUtBHF3/ibkcv0V7DFhI6GUeUezoM/EOj5i2SZiMG4KHe+PhL3OftEDzAPHxrG0pwCtiarKM7Sg17wovMOVzGIUFIqLhKnPxeGWchMt9J6/H/gq7wBPBbUoAVZtthKCxSobl3JJJ4wfqZwdzUXd9D7pOsh8DkLLEUqzzoEnspoqmKUJ2hYva6DI0tBHBLeXNoY09QMqb4GFKCwBIqJtE/u9ct8TlepTeqPfO2YMCMIu4wu5xsdQQiSrKXcqt9EL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTmSSQzSGzYM9x7B5tDaQnit5ZNgYzzYzF7/Kf1XcSg=;
 b=F3uHkDnirvsHp0cdV9GwSLEgYWsJ3jovc9v+TOHYqhPu6HV6oX8whmd0GK+Nw2HvTpBMX7vAgUOyPPqOjKY5Pi/O6/TiwJz2Rq8bB9mbxt3qnv9mUstEEFhlNIlNzRDHkZ5NcCjBnQ3p84A/gAjsP472ey5Yncy1tw0Uhou9YGI=
Received: from CO1PR15CA0107.namprd15.prod.outlook.com (2603:10b6:101:21::27)
 by MN2PR12MB3728.namprd12.prod.outlook.com (2603:10b6:208:167::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 08:10:39 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::38) by CO1PR15CA0107.outlook.office365.com
 (2603:10b6:101:21::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 08:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 08:10:38 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 03:10:34 -0500
Message-ID: <01afe939-162b-0e8f-9f7f-87740cdc0a59@amd.com>
Date:   Thu, 23 Jun 2022 10:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 31/40] ARM: dts: xilinx: align gpio-key node names with
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <arm@kernel.org>, <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-31-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220616005333.18491-31-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68bc2c6-faed-4f60-8f02-08da54efdba5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3728:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3728168C4D4CA72E1BBE5A2E88B59@MN2PR12MB3728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1akhwrdao1SIDRc+xzP3fK50JxP24hC47Fl8ER0idnyJkwzD8Z7Wc063KFUIJ4yQROqFnhcW6kpLrXoIAXNtbI8oQ99EDBpE1Y7WHOPNY23NNP5XjM/Q5GILnPKMmKxx2CxuctHnJt6ux0Pq3F0BfIKF9B/hbMeP4JW4DlbwO1cnBC2sJtZZrcwIPpnW26+ZVayjq5qXJhCJYg+OAQJZIDDJVgl0pnok2gDBPLTKNRws+83jgHaLLG73/+NIUv2bgL8NpcTcds6iop0YoknQgkCj5ZkqDImJCeYj+8GYSdjhmoROs0pLZNwSYTrPcrmzySnF9wUBHtHj8HPYAycDqhQtT1H/nTSwQ0/5SmHDfAcgTNBP/w2jkwsgO9QInJEEQgZNgxHoihIflGUtA4Y7Ma/BgKZr9ZX1jaBXxFCDzt4H481JsELtAfjSLeJl7h+JMEhn9g2weOed2qp72LHSzm0J0bs3aW/KYazDK30VMYtsc5/lyJVGa7NoJVKkqWrJdmYph+vbe5ulev8P7M9zlYjMtxbwec5KwfVEWd2eeJ7mQw/KqvyYlQvNnJOgzbkxoYJpt6gKK482RUfCSx1EefLDfJYfLsXOptEiYxFtIuiD6dG/Rn3iWJLdQxYWOIucORhZ5Tpwa/hIpDsbTnLC9avVv3EhI+eBtLGRbfxq/+s8aS1vNUVGr/r9D31sAUaaA0wtwFyQ++j71bfWz6GyABfiQrGP2Jxo/J6RSeRnfXYWXYAJhZCU7RiJ1v9PrQUjyY6jT4pqlqoZhPm1fG3w0YJe6LB/8ipmavx+7E1RWS45RSu6Xw4sJSAQPfodsnHPxB5LtwWcG5/n14WUT7QDzuBvkznNlemf5huvqaOGNsB1tl0eCOOsVpAPunDkZJt1Gmw7QO82wWoLjP7oeBMjzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(2616005)(82310400005)(40480700001)(16526019)(426003)(16576012)(110136005)(31686004)(41300700001)(186003)(336012)(47076005)(83380400001)(70586007)(36756003)(8676002)(82740400003)(316002)(921005)(31696002)(44832011)(40460700003)(70206006)(5660300002)(26005)(478600001)(36860700001)(86362001)(8936002)(53546011)(356005)(2906002)(81166007)(7416002)(4744005)(2101003)(83996005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:10:38.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68bc2c6-faed-4f60-8f02-08da54efdba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 02:53, Krzysztof Kozlowski wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/zynq-zc702.dts         | 4 ++--
>   arch/arm/boot/dts/zynq-zturn-common.dtsi | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Applied.
M
