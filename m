Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BE54F0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380235AbiFQGCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFQGCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:02:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F56C18;
        Thu, 16 Jun 2022 23:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWMxH1OF5Uu5ACHLtc0rAIzHyQ6E8uOZuic0W1RDjjGyKAsEcpM5s0xVlK9PbazyZ9luM5NpT9TtU3/E9Ros9mp/vaqsEwv9HspGpuKfg9HwREPlWqHK446V4tT+O6RTlz0lzedgRXpKawP1LOmC4sBZMchVaf6eedJIuj6dv8qWfW2MelE485rYOIDxSQcXmeLqeOjiR0EQxjjVrjhOwt7WcxsGqFNrMQc6Cs227CoxKkNGXdnAZF12bpxsEugbhk4ojmReXKEFzWYILtshdyh5GF76by9vmr8gP1kE4vuExImXCKvNroDpMm7Mwk+kNHhZkSa3DOO/XYyv2i5/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sso5BhLUKAh5h6hTwztgvRld6QgrOMqjKdzm8txWki0=;
 b=mklEh3HwcrtyGzRs0iepTIPGN31ZWl35C7Jld0MV/gzVi67Maz8LsjI0epRgil8+fTmWqjTqh5+vRavEMFoH8Qmd3dniLNJ0r9fJ1z/nBIs6XN/djHSmPlEFL4QTPEZcoRbDQmuDfTZ89fLlo+SiIxByIdemegRY1m6QgsQC/7Pk6VTqFj0JCCYr7i3VLXevp7XDV3mXSl8D3D/vjZgL7pOBksFhWdprM5Vbq8Ap1A0Vjzcyui3em6Is83bwKHyQtmBLrxkKQdkx6S15HVcbBMmEYpbkn0ASNUtCGvl6wRVKByEJum+Bu9dcxBShkHTtfC+BBE2/QzBfTd7iLnQO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sso5BhLUKAh5h6hTwztgvRld6QgrOMqjKdzm8txWki0=;
 b=afpilT2dQwFlasQR4Bw0e+ichMMMg0bJ1T2CMCaY+ysVDVjb/CFjrKhN6xJjDlaqGaWmvqNWgIl9HQSrXP+af+NvKFBL5gu67qD20jE8zXea3QRp1gOc6OV5liTRiP/2UWrfx7HmlFRlkpP61AE3HiIz/i7ASiFHrWAU5orHR70=
Received: from DM5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:3:c0::16) by
 DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Fri, 17 Jun 2022 06:02:33 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::97) by DM5PR16CA0006.outlook.office365.com
 (2603:10b6:3:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 06:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 06:02:33 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 01:02:29 -0500
Message-ID: <bd4ff961-37b8-607b-e801-bff37d0eb452@amd.com>
Date:   Fri, 17 Jun 2022 08:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] gpio: gpio-xilinx: Check return value of
 of_property_read_u32
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bgolaszewski@baylibre.com>, <michal.simek@xilinx.com>,
        <neelisrinivas18@gmail.com>, <shubhrajyoti.datta@xilinx.com>,
        <srinivas.neeli@amd.com>, <sgoud@xilinx.com>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
References: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deaaf07d-c803-41ec-595b-08da5026f89b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541521155E06FB23ADF9407888AF9@DM8PR12MB5415.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U00XSGcfacRNtytoiS+MPkXLL/Kjkb/NJVKOLPsPSKmRBeQdTVq23nrtWlHzwR8PjN6NyuWWT++NKjGhxLnFz5+Q7xgn80trEVrlywNV5OvkfPd2JNpF4ZHlHIjvlxYNqRRt+ZXjV3iQG+gXFTgYsJnmTPlMH3wCdqV2G6nwawxyMLTTpdTaW6RFNAq0lbmRvf8wKSFIEoCYNKE2puU+FZ0VVz9UKW3t6UiUhJSxRRoDv50ltAdwNeE+lYED/bChf1+ObknZIv1A1mt2K3oeIbCcq8r3mG6YIuMArEu6OsbAcNGxxbXdbG8bdogvF1W+ilyqLgmMpiucMCP0S7FakN5qtmAYCzdWXPjg8YOY1Btv7SW1eLjFaQWmP1dUOUphmKiUrl0RJdw9SRtdlSomJ/SNBQH1vgAGh8LhcXfQ5jJU8ic8p31vcrO/3sLVcNSRrBxpykwMDbX7a8QtdcExqP9vQQIBHA2MP9oF24joy1vRpiajCMfJ3C05Tp06Svq3ZNY/5OAvvoW3ch9caaC4VyrvkuoglPNwAUTXwdegMVzPmbzLlp+RWwlMlz9iyQ9JBu6/RDfovgG6abB3foiZzM07Di+6TZF+DYNf5GG+W6ZZs4qs7YmsPQWTKvS+AQLzMgXTbpbJd66nh3Pip2r7dD7pZHRIwJLNz2zCChnSXt+lXsb0JXcw92Ma+bE/79X8kG5CzfYfiK/ksQ7Oz8dTtWtCDOg/J6Dz8v2XT3C2Es0re1gs3HvvNs71UZy2t5prmAUKa5ib+Fy/44Y7A3F8Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(31696002)(26005)(70206006)(8936002)(70586007)(86362001)(44832011)(4326008)(8676002)(5660300002)(498600001)(16526019)(186003)(82310400005)(53546011)(40460700003)(336012)(426003)(110136005)(47076005)(54906003)(316002)(6666004)(81166007)(356005)(16576012)(83380400001)(31686004)(2906002)(36860700001)(107886003)(36756003)(2616005)(2101003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 06:02:33.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deaaf07d-c803-41ec-595b-08da5026f89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/22 07:19, Srinivas Neeli wrote:
> In five different instances the return value of "of_property_read_u32"
> API was neither captured nor checked.
> 
> Fixed it by capturing the return value and then checking for any error.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Addresses-Coverity: "check_return"
> ---
>   drivers/gpio/gpio-xilinx.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index b6d3a57e27ed..268c7b0e481d 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -570,7 +570,8 @@ static int xgpio_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, chip);
>   
>   	/* First, check if the device is dual-channel */
> -	of_property_read_u32(np, "xlnx,is-dual", &is_dual);
> +	if (of_property_read_u32(np, "xlnx,is-dual", &is_dual))
> +		is_dual = 0;

All these values are initialized already.
Isn't it enough to just ignore return value like this to make coverity happy?

(void)of_property_read_u32(np, "xlnx,is-dual", &is_dual)

Thanks,
Michal
