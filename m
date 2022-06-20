Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE64551FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiFTPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbiFTPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:10:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE491054A;
        Mon, 20 Jun 2022 07:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRVrjutxj/V7WN36SGmhYY0pgF8WS3OmlLvZrSPhQNcsZBTtjFW8WT8n2KkEg/iEgNIhfKAAoR9nNyU/ks0q/GISY+MIWQQxxqKtvMO+FkFOw5qEEAGR5oIgeW4CLCdcyinqWuY3VlhALEbjTazOlobWaGjo4XAk4v1iVc9aB6PPSGu1NIeJ3jBdfquz668wV5L+ZfdZQisqWsXuWHK7/8sCLVUczEX+os3Bg+yo3s7PBtybw1FYlc6BDTrlzgtRaIOUBMxQKhg2Q0YwKNQjCrW3hoFXziytg/2jktGdT4Brd08NVcX41C+3LCMtJoEAoXL45hE+cUyDnA/gyM768w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1Bp7GOZxwBbDUtpAwfv6MzXH4Kbeff1s3as5/qpj80=;
 b=NigQwk9MXMc4tYt9BjjJcJA4nTiZeEHasNTL1w9hblx+hEYT0ZT2wPBIb8X2FTJtEd3xg6oXWMUPm6Xh1emWGLPfE9/UOsFh8KU4wKqF0E3cp9ZPfhHyFksLniEgWWckIp68ZPlpDKapobrl7rvSGbAkW2k371Fw+8NsQdDBT8Y4A05fhFNcvVv9h118rXv3JOinh1IRewxA0cUUrkdwrIRyE2B8p0Yzs0xdOS9QqATLLS33jmVx2UcbQzf+Zuks7hkmmY60uQiipUn9kbBN/1XjPH5Qsc84c3uTzUDc6CYe64kmrulMVs+DV4RnNUtup6I6zrpmONeG+QdtrfRJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1Bp7GOZxwBbDUtpAwfv6MzXH4Kbeff1s3as5/qpj80=;
 b=NKQa8VJpnTdfLPARP1M4bSSxW9mI/5xLr1EyDqYjSJXHkKEJ43TLZLJZCqry8y3ujThZmjvsth+jh6+BV+fp7c4AXB/S6vUmrPr588/Zuu2vFxUU/IxZiBg6GCRjIzpGBm8xwdJltuuJ20/mRX0qYUL8jAFWHiaYnPJSmZqDq3U=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 MWHPR12MB1758.namprd12.prod.outlook.com (2603:10b6:300:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 14:58:11 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::73) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Mon, 20 Jun 2022 14:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 14:58:10 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 09:58:07 -0500
Message-ID: <e2efcf6d-ed85-dc6e-64e1-f0efedd4a673@amd.com>
Date:   Mon, 20 Jun 2022 16:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conall O'Griofa <conall.o'griofa@xilinx.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
 <20220603183224.540b3808@jic23-huawei>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220603183224.540b3808@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b329db6-43c8-48f1-8f82-08da52cd4b1e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1758:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17588DA7A9F0DD0D65C6807F88B09@MWHPR12MB1758.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxpH8w9alO/JTnqcKvuwksRnrldRry8SH+Pp4HVXea3wtcdYz9YH3NXNB7jsUzOIezCaS8FCLiUFNOO7Q+Z0PcCK39WvobZA4MdkG9G/6okd6qXTYOaWsVNmQTfS3TS3qcl3oK+z1qwR2WrIf8h4CUinasLL9cdhimYpo5p1nCPUf0G0LPBFuWYKjWC6grDGEu4F0IK0wE3Gh6lckGnTTnUud7qI9/yykp8RqDl+qpa2OWJdsn0qsydJREv8VJUJ7m2GoztzSlrxhAqO5DknVF6PVknyfZf8k4D6pW42+R9E4hK2QhLvK1kslovM60HSVqyHwn01seSBolvkAjgigpSzvISFn8xm0X9L7vBhL01OYmSZz50VJqrFTYr0VaC6IFWbJ6iGhLLKXwp2lM8MOYK/p8MpQ5Ja6A4wosBwm5gQWyGydwwlXgQPrrnfmZaDhB9Hbnct1Uqztuusnsy3AtEnQNHDvBjgFKOAbG84LHmHBlrhXQT7o1LxE6l2Ho4zdSgLspj4Reuy3Tdpg2LECJXNlgAbJ+x2KUQZjEAXrMyrK1NLZ5mOzazt9DM7y3FzKMmVlefUc55Rj4EZ5ml7K0ORJ3apylqFT+DHRLyenJvYWQd3uQb4eUL0ua869sx6apf+8a8iRKGFOEjXHp3EGWqaMsRtuTZNB9uKTlV69RmweHGMkWakrb98Ssee6qz7/FtY/qEPa0pz2opaXe3bWHqhK7QABttfkeNLLja76OMAs5O3St41EKezfJgqaSj5hzYkBn8lkXSvJOzhq/2QNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(40470700004)(36840700001)(82740400003)(82310400005)(36756003)(4744005)(31686004)(44832011)(40460700003)(356005)(316002)(36860700001)(81166007)(16576012)(110136005)(40480700001)(54906003)(16526019)(8676002)(26005)(426003)(186003)(4326008)(70206006)(47076005)(336012)(70586007)(2906002)(8936002)(5660300002)(86362001)(2616005)(107886003)(478600001)(41300700001)(31696002)(6666004)(53546011)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 14:58:10.7476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b329db6-43c8-48f1-8f82-08da52cd4b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/22 19:32, Jonathan Cameron wrote:
> On Tue, 31 May 2022 17:11:17 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> Convert the module to be property provider agnostic and allow
>> it to be used on non-OF platforms.
>>
>> Add mod_devicetable.h include.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> These both seem good to me, but as the driver is fairly actively maintained,
> I'll let this one sit on the list for a while so others can take a look.
> 
> Whilst it 'seems' unlikely anyone will ever use this driver with other firmware
> I am keen to reduce the number of of-specific drivers in IIO just to avoid
> any chance of cut and paste.
> 
> Who knows, I'm trying to run an aspeed-i2c driver with ACPI at the moment
> because it's handy for a emulated setup, so maybe the same will one day happen
> with this device :)  Weirder things have happened.

Conall: Can you please test these changes and provide your feedback?

Thanks,
Michal
