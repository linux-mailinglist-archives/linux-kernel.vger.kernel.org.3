Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9016D560055
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiF2Mnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiF2Mne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:43:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5EE80
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH068eBuo6uBuSp0d2Lbuto/fWGXFcj1iYU2dRiy/uen29ug19dB/ONFdV7HeyeqHuZNKie7Ce7EPGfTp+3JS6Qh03Ns6Y3RfTY+63Chl0dfr+RNMji0bNUtK0IU3RTN6BGfMPfgl4b+mObtCRrhN7m8hsNadAWe8Pp+MMo+fDkGMEW9iMs11P1fuza+7WF5xFqB89sRUcF2XN7mqZ0yteOJ42XZRQWgD+gfV9fGz420Tb8ZddD7m8PnfE4T3RaNkYQ5fGmEhbovOZKzpO0sRJYfFt96+AZ1jQzURTOAkJG8Qrcs5kxA64RYfnK/gznyJDOkfztzJUDRr9nbsQnNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Jucn7t20nAsQto3/Z1brLurLMtaqmvmXgVS5KLGyI=;
 b=OeJqm95XBSGPe7HsBDgPCjkJsGeT2SW5USChl5OusfXYx7mUmU8GcZt4O0yTXNqoFK2vD5cn8uUq98fMFsaZhDIzZG42O89Pg+95Kn0uNjY4fumf9lVHbQLXCHpjnVjaw6Mxwb5jjIa3V/dJKPl1+TggU9tDQ4TPcruDSGRXHC6HjuwVrFxxWUc9gyXlZpv5o4xH4YNdKcaDBnG6KcIF7HBoEKVChC8YPwGzBsBLbjf5RYX4OqOi8kWCnj3DMz+JJ0A5hU41MU5pRC6K1m0xppsgA8SrGo4UxPJ8NvrzzHndYpjR2Eo9SNTo7wxQxDDSMbLMIzDApLMGYMwOTyO4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Jucn7t20nAsQto3/Z1brLurLMtaqmvmXgVS5KLGyI=;
 b=xEpJzR8JvNWQdhej8fNYnhE5lrRu8F4ATP2SikMZid62H+NzBEn0i1gMPr6X9/93qrSJIVttdW4DbiSDCtiN9sjkk8OFHP3vIm16O4r96buNKCsHD8F92XXAIlwz8Qzx6k+mqDcDiQ8tHd3Lii2Pv6ADrEFTftG5zoUktGekRdo=
Received: from DM6PR14CA0053.namprd14.prod.outlook.com (2603:10b6:5:18f::30)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 12:43:31 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::16) by DM6PR14CA0053.outlook.office365.com
 (2603:10b6:5:18f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 12:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 12:43:31 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 07:43:28 -0500
Message-ID: <859b3e14-27ee-2dba-9876-1389927b4cb4@amd.com>
Date:   Wed, 29 Jun 2022 14:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] cpufreq: zynq: Fix refcount leak in zynq_get_revision
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220605082807.21526-1-linmq006@gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220605082807.21526-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57319f4-3408-4192-d8f0-08da59ccf905
X-MS-TrafficTypeDiagnostic: MW3PR12MB4505:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ouHuuhR6yTUOEk7JFjgHqtT8ESLpsFWrQDxs2YusIUgHJxSXAZTY0/PlqMYGd4JQDuZwG65lZ3QqQDzy7BQQ+DMO36GjqcTupL22FwDhZoI5IPVuS0SFyurq0rHUB+iZSbOdT+y9WpLuhWnx6c+NExXhxINS1GqANu9b6SiyVL0otv1GCjwtL5LnutbQnVctoFUdeXP9EGmj2TaTR9KemXwu3Y7O/CawgI+kMmfywgJnnLub+DeqIzS5KGSvbsHH3urudkNxLWvZ/eKcF+F6cWg6qmde8NtLrHXCSQnfTTr2nh0ursdZHw0twKEk3x6ge4TZgafvgRCDtbk+LXT+jaqbqYADoGAglPrB6mtRSgS0cuNmkw10Ex0HY2mVfGnOx0A08XNjprlBFLFReIjDgm9/eP7K8wnU8jao8qhthPznMPbeFuw3Z760RvKwtok7wpeM2RMfYUf9560MTHpMiRT0vRgMKx1+/EufYZCv8eGp30EE0Bk955AtspHVduQM5pYkms0F/KliMwfBHnQsTdInUQo+HIt3JDLckkDQp8aY4ytNM7b2IB52c/s5y+TAny7AhtOHnP8JKF4nwfce5O0DghfTlk42V4J/+KlbnhlEFPRjCd2QSAoQbjUAX/2L291O8xgQEzz8kFo56DnwhRRauhe6gIFsndVtHxpGsLJzpKthMXkk0HsuCUDedcFPc0n147znZ7TKp5F9mUWCrkUDYSawFqnDiVEg53H2xEvhYt4mhJnAV9kxUcrbNZfIdbelfvgWCuj9aCtZhK3hIzlgPFLjxuecfacu4tDDb4zib+5wgvIsucX/UFEu9l8rwNnJH9Qwtym6fdVEmmupPvQQY0Xjut0B/xVy8UIzVqgefWUy+KWwGeYUTnnDRjir1gjeBoGHZALHFi+pchCGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(41300700001)(2616005)(4744005)(5660300002)(44832011)(53546011)(26005)(426003)(336012)(86362001)(16526019)(40480700001)(81166007)(2906002)(36756003)(40460700003)(478600001)(316002)(8936002)(356005)(31686004)(82740400003)(82310400005)(70586007)(16576012)(31696002)(110136005)(70206006)(36860700001)(47076005)(186003)(8676002)(2101003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 12:43:31.1363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57319f4-3408-4192-d8f0-08da59ccf905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/22 10:28, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 00f7dc636366 ("ARM: zynq: Add support for SOC_BUS")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   arch/arm/mach-zynq/common.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index e1ca6a5732d2..15e8a321a713 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -77,6 +77,7 @@ static int __init zynq_get_revision(void)
>   	}
>   
>   	zynq_devcfg_base = of_iomap(np, 0);
> +	of_node_put(np);
>   	if (!zynq_devcfg_base) {
>   		pr_err("%s: Unable to map I/O memory\n", __func__);
>   		return -1;

Applied.
M
