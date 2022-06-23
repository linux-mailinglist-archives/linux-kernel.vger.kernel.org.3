Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C252D557509
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiFWIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiFWIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:10:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A593747AC6;
        Thu, 23 Jun 2022 01:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMKRf/y2wKD9ROdcPPdpeIBsE7zRfTOzNl42tyxVGUrLTHg+qZ2W216kcHKSBcpeioxTvJM40E3ybdszE7oXVUO9hDR8IpmQoolv3fwjOMzrQC9V4GnuIg6+ZZTb0FB/dSjzw2oHt/6BqLlu1Rg6bcJNc78LyOs8y+xz9aV98loS/TypUd/j8NEcJwCP71UrzE8heiLy3gAzyjicJlsyuepdNqPTHpgUQPM6mu8L+G0cDWLYlDFt2mnzqIt+LPQvjAaaUY1WT7ZtDjBy3nbtvI3BEIyYpnWj5Z8R6t7KTiyQFNwQnrCQzlwurKrGKUi1TtoAXCTCy951CeYhhci6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoOy9yiPzj3OCKIHNjLWoRcFQL/iqbRq7WWtueqn6Fw=;
 b=fVqow5uRlBGtDbG1ydR3RiPXcvfyulfvc0xWTY0R1/AbvhMI7ucoa+4CatHHkyZCkefTyTzhWQoqm5P8l1ipA++BemCKQemkzLKZa3XzWmR8uLo8snelODhovnZiKQe5r8dMz6s2MMCvUo2hmMXoQ8Plwk7T8syy/D7YMAYEFuKdpEeKGmWylfhwVeCs+G4iHkeAYQsExuhl58nY8WyBx5byJJt9qIU8xVhuK7pKfd3BBVFjsuHBbmyJxYWXCtCFX4CqHcXue+p5yZEaBhdcKipj8XvnrMC+vBvjL7XvSHHfM96jd1gANrZhUrgSNZbGcQ8vrKFzL+qkcYyiJagNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoOy9yiPzj3OCKIHNjLWoRcFQL/iqbRq7WWtueqn6Fw=;
 b=dZ+0Pladw/DNKh9AEZGUH0J4CRNjjy0k7Ig3IEX0DLgEJoG7CqHDi1Kk4AQ+Di+22G0yuiSU0OHz40durcVOU9F50jHcbCfHhxepcmOKYwFl8iTvKITvpqIoJhQA6+UVIFOLYZpoftm0lMUHZ8K123XN78vJ+pq16/T5hShzfR8=
Received: from MWHPR01CA0031.prod.exchangelabs.com (2603:10b6:300:101::17) by
 BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 08:10:49 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::8e) by MWHPR01CA0031.outlook.office365.com
 (2603:10b6:300:101::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 23 Jun 2022 08:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 08:10:48 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 03:10:44 -0500
Message-ID: <d931f674-1a36-d98d-5ddc-434e1e1c4e27@amd.com>
Date:   Thu, 23 Jun 2022 10:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 30/40] arm64: dts: xilinx: align gpio-key node names
 with dtschema
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
 <20220616005333.18491-30-krzysztof.kozlowski@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220616005333.18491-30-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42378de2-f8f5-4257-83cf-08da54efe1b6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507964C2465EBB97D1A2CB988B59@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhQnkgCQMoD29BsquWmEiMwoOmNtSm3rqGXd0R6dUqSnT8NyHGZAAIs0/FGdepnqd/qoKtT/V1KO2GBXoDHlaoaZPVvKoeFR3Pgbc/ajlqv80zjGAA29TBemJyPb3tkJ49nF2iOPi9AmO738I+6wvgEKvcXOK9Rxv9irmY9wT+tLe3JBz7G2Szrk47tEp5/EyjykNibnjPOvjEZny0UmPni0Dw0symB1Nkf139001eIbPnhbeRI97OnMlMRbkx8QbsFD2ezlFsi87kNwSyFsC++nB3D8MepDsXNnXUEyUrJ9TTZHASyvpVc43MQ4KFRwt2vF5bN7fB/+kjwztA4uu8cMp++t04ieGCtLkcSKRscQ1R0PISgKmjYvgxUxd/bOwFVHij2id73wfkcDps6PY/KTxFX7oNZdxvSbfutE6fNjzk7RS4Bpkux0FfS5Yu7bQxMwt90RZkeAhQ09J08sFIwD40hIXLE83TfKlQV7YOAnWzGHpjA+5iVMpdCY6b4wFuogNOQ1YTQ6FXB2keoaXbiPDbc3+xN+C/eEg+EWzlCjtZIkoyf8lEI/sEo/3ucKCYHulI0sOgbHBFY9yQSFLZStJKZfJIvG+yPKEjfetzzOFcD3+AIeybesMnHmNR/iuBQmg/FIVD30x2kJVdNx5GxUZLHhl3LNxr9p+P/qi9AO+Qns+oaDLtMxVrABRleDQ7jjffHdwuVFaWVkZHC1D5chpzhPc2Iy56vkOVv2gLIVsPYC5A74hptANgMBmW+LPk+6qrnqAGEuA2ONU9mwvyse3OtypZS8Y/VNbMxLPxfxfvE6t8b3U3fzpGkDUqb/Z9VIMzEs7ofGj46+abstfdcr7tTehzXOnoY9iIq0gyWAynOnGCygLDINIc+Uu9YONVDKrSr314eIoCGc6smGMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(40470700004)(478600001)(44832011)(4744005)(2906002)(36860700001)(316002)(70586007)(16576012)(110136005)(7416002)(36756003)(31696002)(26005)(86362001)(53546011)(5660300002)(31686004)(41300700001)(2616005)(70206006)(8676002)(8936002)(47076005)(40480700001)(40460700003)(83380400001)(186003)(336012)(82310400005)(82740400003)(16526019)(81166007)(426003)(921005)(356005)(36900700001)(83996005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:10:48.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42378de2-f8f5-4257-83cf-08da54efe1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Applied.
M
