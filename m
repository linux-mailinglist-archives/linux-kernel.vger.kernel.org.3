Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0455886DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiHCFrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHCFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:46:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F845275F3;
        Tue,  2 Aug 2022 22:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMZO78/EdUyUq3ixlW6Y7t/6ago6w+oGZ6mn+g8bHB+FcFd80LF9KLP8ttNjJbi3y3CsDWGZwPU4qheo1ePHDCmSZHAOXTqhg4WUNaAP2Nr/TzCe5SII0CViZtBWoItBV3+RrmeIElf96EaogokHRn4/rf774Ch+1/gafCs+1q/96vclaVAyR12ulBJQkBe4TrzgrYHZWamTTPNgaWcJ5DJmQEMXobtoexHKG3Fb1+lZHgxiOQ38bz2ICJz+nPmkVumFMVtVZ5OgkTcb7vdm58zQBjV7Ak7qJ2HAuywQFnbKIVYphNeOivcYcbrzTtutdB1Kbwv+ZUk54Aic2xDa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7rkEl0UmuDcWeKsLDlHoUSmhMAU36/KNbdOMdKgYBk=;
 b=iAzDF6qS5NaNVyV7mm7tDRSqNAXxZSzUm3cV9xheE+U/6ypXybn0J0lriF2mGylp6wpmPszboY57dhdkW4VQex9hTeeGR/M11d4eLmOWOYc3fOn3OlweaoDTXS4q7TtztRpCVirzalkiKCCdIpkjrKMoQINYTeq1su+k4D6zZP8l2zMuLykMGWGPhBR4Fl8XOZwoQ0uutYQGeeElQxsjiAvaGgfotJ7WSln/Sh9AAYJmuqaSh0bYsjHKCrOoHeooi1EuD8WsCrpJ5bXffuJWZL3onTdjjYXEX+SM3YjlJ5g4V+v3g3O18Hvyxu/OiDDAk6TflvbceeXctkqhMPmfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7rkEl0UmuDcWeKsLDlHoUSmhMAU36/KNbdOMdKgYBk=;
 b=Z6f4ThUlUAa6dGi4Mrtr2hOsGWLG6+gy1uEA4Sy/2+qtGRu+chjXyUl8az31XmNvzCpic7ux0nI/lM6A+iMHOXXwxZAuFN4dFS06B/s4MnQN2CGXsG1/yI0YP30zgi0hTUQ+/Miebd10wiXzYZba3tPevkzbvL/G8B+Yu54/h40=
Received: from DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 05:46:53 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::a5) by DM6PR02CA0127.outlook.office365.com
 (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 3 Aug 2022 05:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 05:46:53 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 00:46:47 -0500
Message-ID: <6795ab10-8e8a-977d-e767-31282fa6a312@amd.com>
Date:   Wed, 3 Aug 2022 07:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] rtc: synqmp: uninitialized variable error
Content-Language: en-US
To:     Sebin Sebastian <mailmesebin00@gmail.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220803013117.318611-1-mailmesebin00@gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220803013117.318611-1-mailmesebin00@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db24709-27ef-4313-e73f-08da751391ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6drEJlWrX3NJom9LxEKji5Y0D/zS+HdvA1xvWNskX20SBl6YpGSa8IphrgTHXy93wJG8aaBbCncNLreL/tXb60dDbVNK+YsUidm+zdoo4hjcDG96dN+r+hIfoF9cnsoEryGuKE2Dhy/Fu9r5oDAyAw6SnJSi+tTXzfL7qxjmIFyRbCFYpG/G44NhkhoGhHF8xThkXG8YDS5UjRVMcqqWykoK/KL9J+aI5FB4WU0qtcA0jOXrdIApLBtUs9wnKp8yA/ZxV3e00ABjM7xI79Beblk3Zk2xrIbvPayHb3kOOjzPlIhsHX+WQtZEWKv5KYmSMA5AOo4B526F/T51UiL82eJIMUKc/h2KR0wdm0ruTWiKofJ/8FBwOqbIMytuWnJxYOEOkk878dotB4yBZNfKMD3dxA+ClT/+rfwz/OITcWm7Kiq/gqN/oDHXyGFvCaMAcCCN7lYtqSSdUdhU744yaVPtkQoo4oMGq5VbnJvpNOHIwTnC8jkRBw0N4sV3CAZ98wvPZ5d9cfphNEfGQnqjNvzyIW3V9E+tpu6JXg1syCg2U4P903ZtrS8yJKtFbAFq+PcnwLaqJ377Pd5yw48G+kE+kpZMnsYy8eJKi+DqGmFtgmV9Ha1ANMcaxkSUCG0DH+JOx9F173Lhp4nlD+oEo0EUmIABSqFtTH6DJ2mEbxGXkhr1iSo0yeonRzg08nubi7a6TDlSXi4BGVfg2g27Mx5SXdCPbWVkvXnAIkljXm6FFKd7t7yf5L9Yg4tJdb+L4oIQ6qU8XNKBhu1FBd63egiPx1TJJ/Kzun+oOcl5fOb4TooYoCUuZubbuysz6bm+4ypa4WafPz+c+UDehpCbSAYJqxhBJ6NY2fqPqUmMWI6dzxsGkoGr5R8zl/JMe3/q7+7l6bXjjBwa/2n1kYeeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(40470700004)(36840700001)(6666004)(83380400001)(47076005)(40460700003)(70206006)(44832011)(70586007)(8936002)(4326008)(8676002)(966005)(2616005)(5660300002)(426003)(26005)(478600001)(186003)(336012)(16526019)(82740400003)(86362001)(356005)(40480700001)(31686004)(316002)(54906003)(16576012)(6916009)(82310400005)(36756003)(31696002)(2906002)(53546011)(41300700001)(36860700001)(81166007)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 05:46:53.6337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db24709-27ef-4313-e73f-08da751391ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/22 03:31, Sebin Sebastian wrote:
> 
> fract_tick is uninitialized and can lead to uninitialized read which can
> result in any arbitrary value from previous computations. If the code
> flow doesnt execute the `if (fract_offset > (tick_mult /
> RTC_FR_MAX_TICKS)) { ` block, fract_tick is left uninitialized.
> Initializing with zero fixes the issue.
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> ---
>   drivers/rtc/rtc-zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 1dd389b891fe..c9b85c838ebe 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -203,7 +203,7 @@ static int xlnx_rtc_set_offset(struct device *dev, long offset)
>          struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>          unsigned long long rtc_ppb = RTC_PPB;
>          unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
> -       unsigned char fract_tick;
> +       unsigned char fract_tick = 0;
>          unsigned int calibval;
>          short int  max_tick;
>          int fract_offset;
> --
> 2.34.1
> 

Alexandre already send the patch for it here.

https://lore.kernel.org/r/20220727100018.3301470-1-alexandre.belloni@bootlin.com

Thanks,
Michal
