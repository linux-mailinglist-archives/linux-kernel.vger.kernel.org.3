Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DD56A332
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiGGNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGGNNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:13:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692D220E1;
        Thu,  7 Jul 2022 06:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMsmvK0um10+egVhzBs2SOQ5p/lGQGDQV43PhkV/+ZHprOAfRtGSjdEDkZf+0FoPb4Ream59fNEgcUs0dJf+MVmttoE6homtSSmQEF+v0rQwki/SRP0Wa8NUVM5JMDheQ//oAPZGiXSbwVkqVkojWWn4v0byrVaS91v8N6JJ+tdmISV2CotxTL9c4YkcL31zhcZGGxpr5/4oCBU/ARdSwdrkdg09cYgAAVPNkQ75EO8gG2eQsDyjM7HtYzFEySlHRtnORmZM0vp49IOVyYNQcDqWFsZ9Bshie+uhvkxuzYnQ6DPHJrgi3lTfCo4yYFrS1cxgSP3nTHX81k++fEfX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKPylHrBOwaxCAkPgXc+ZVw0PpiWgi4WwzzmmMdl5MY=;
 b=a9mMbAZXDZQ60dsMv/QlycKhTaS+ON9dpRp8OcrrWcOwKjCMRtyGDWqWPzRGYRHM7iKEHX5soQ5KWcocurlRInqj4v/qflXa8bt+8CmKQDEKEbA8C8Fam5nDJxsrJHGEWcrdEA/SljLIpWTEhQpwMNAoah3NmEAdpfBX/nF94VNe9ab4jP745/qMXdQPmhkb3STwrTQBKHXdom/sgsM90UqiVE62M248L2enRBgesc3BBB1oj4SGy5DmPJZRw5oSY35+KS84zXDLYk6RVHmsdAvJ/HPRWsyuI3jPccXUZBKvaCuyXp444PI17lhMSr5iua2SidrS4yc4O4MDU2AoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKPylHrBOwaxCAkPgXc+ZVw0PpiWgi4WwzzmmMdl5MY=;
 b=rY1GWJb94p0j874vo+o/3KV+Cfl/tumKo1k257CniTBpNB0CbzXhCZNo+jYpMmlnqOXqRS6WVqWrRZQUAFkHHB3KhpOOAEjPCUmDiZNYtJYvgyGW4D/2Sd0JHQmRIh0qWwW07JqbE8jyWG5YBruc9hCKxh9tQP6bqTYbgRqi9Uc=
Received: from DM6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:5:bc::49) by
 MN2PR02MB5981.namprd02.prod.outlook.com (2603:10b6:208:11e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 13:12:55 +0000
Received: from DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::74) by DM6PR13CA0036.outlook.office365.com
 (2603:10b6:5:bc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Thu, 7 Jul 2022 13:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT054.mail.protection.outlook.com (10.13.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 13:12:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Jul 2022 06:12:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Jul 2022 06:12:53 -0700
Envelope-to: git@xilinx.com,
 linux-gpio@vger.kernel.org,
 bgolaszewski@baylibre.com,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.52] (port=58456)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1o9RJN-0000kv-3U; Thu, 07 Jul 2022 06:12:53 -0700
Message-ID: <b78d9a15-5933-5965-edc6-7a050eb1bc0f@xilinx.com>
Date:   Thu, 7 Jul 2022 15:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] gpio: xilinx: add missing blank line after
 declarations
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     <michal.simek@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
References: <20220502110040.12225-1-shubhrajyoti.datta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220502110040.12225-1-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2edcbbc4-81d8-4d9e-54af-08da601a679d
X-MS-TrafficTypeDiagnostic: MN2PR02MB5981:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQpROhCKQMorcqiKuevupkAqHGuoLr+X22ed7VMltz+q2Um8B3pFkpumbQlBL5jsK9aRusdBq0nV0aFcWh/3URuMlvVDcwNsOb8cy9NgHPTBAWFQWXC6Enjvh+3QqgQm9UAtOnpeegJs2vDbgu1JrzrKoUtJKhlmXvLqCaDKEReG5c6hZ/3TiN5l89zsSmNvctaGeL6eeizivVJraONHIIQBLt63+UR9ZVv39w4wzyvteb2EUsoICrmPEc1xD7wzO9n62oBcNTPpldsKV5o9s9otFIXbO86ZoUfDvKFYTjQaXX4BtfCY02uVINJowD5amRHgD9XMoedzdwEMfPaOwptdMDPloUTA/af3d1wDQwNJtFj8qiHGo5YrWBehFROMYcMMpCSfyZRkOWYSFLW6nS5uENboExIZVlxJ/J7MvYzsIV5rMiWF7PSYRakCMkjXZtnefymGYLlmKZI9nWVk5w0/o5/PmNgvxrW/SyRbfFYTfG0KNTtk9wcxB99xfeR42SJnhjYcRvf5Dq8Sh4Zs9w1v3RI/IxjztEIKpnjdaRcFnjXdHXM17VYj50E8g5nBlL6tKprovGrhEPElW7KhdueR8yYYvep2TzWQHGnVSjXjfB9/SRkqUWXsk3njmDPjM9rQ5tTMIeNFJWWrEKg3MYsFXd32O0hzZqHqf5C791gaL3a6KzW4nQKGSQ04/c4KmyFjWo3HO56l8QRCiRzAxYNfl+GiXaKkf6fwOkdFUFoWm3vxEVGuYTmBYaXJo4hV6Dt41oNX4W8t10/sNkCTHMzBaiw0zq3e94Of40O04U3scVvFr0Th6MztmuPXg7ddfClAcxOECkYcQB1RejDrcIEiyzoqClO+HQwSd4Cj70Qw17QajuGvwK01sF9hCHJ8
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(2906002)(41300700001)(82310400005)(478600001)(31696002)(356005)(82740400003)(7636003)(70206006)(70586007)(83380400001)(2616005)(107886003)(4326008)(336012)(8676002)(426003)(47076005)(53546011)(26005)(36860700001)(40460700003)(44832011)(40480700001)(8936002)(9786002)(110136005)(36756003)(31686004)(316002)(54906003)(186003)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 13:12:54.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edcbbc4-81d8-4d9e-54af-08da601a679d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5981
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 13:00, Shubhrajyoti Datta wrote:
> Add a missing blank line. No functional changes.
> 
> WARNING: Missing a blank line after declarations
> 128: FILE: drivers/gpio/gpio-xilinx.c:120:
> +       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
> +       xgpio_set_value32(a, bit, xgpio_readreg(addr));
> 
> WARNING: Missing a blank line after declarations
> 136: FILE: drivers/gpio/gpio-xilinx.c:126:
> +       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
> +       xgpio_writereg(addr, xgpio_get_value32(a, bit));
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2: Update commit message
> 
>   drivers/gpio/gpio-xilinx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index b6d3a57e27ed..7f129e7eae78 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -117,12 +117,14 @@ static inline int xgpio_regoffset(struct xgpio_instance *chip, int ch)
>   static void xgpio_read_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
>   {
>   	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
> +
>   	xgpio_set_value32(a, bit, xgpio_readreg(addr));
>   }
>   
>   static void xgpio_write_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
>   {
>   	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
> +
>   	xgpio_writereg(addr, xgpio_get_value32(a, bit));
>   }
>   


Fixes: 02b3f84d9080 ("gpio: xilinx: Switch to use bitmap APIs")

Reviewed-by: Michal Simek <michal.simek@amd.com>

Bartosz: Can you please apply it?

Thanks,
Michal
