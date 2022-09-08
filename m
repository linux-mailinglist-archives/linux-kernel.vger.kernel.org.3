Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E555B155C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIHHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIHHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:07:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ABBA0320;
        Thu,  8 Sep 2022 00:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Le9WofKvuhQutIv+q6U4RAutGKIE7MbZTlswn4PNR9dMIMqEsDO7ZPecRYbOESDOHIvCU1eLvXm/jBedRi5p754jF+Ft/rhaD8pRLeIY1viY0bLlAF5ypDKflFPSCYiTd7atzcdswMn0wVnmwJq6ZE17/I8FJNAbUXI2296JWuyz3lAPG3AEwDeqO24weyLMNr1fH6TBLm5VSUoGqyrp0uNfUg0BRloNskOTrMEcBhaVUcft1TyTlf26D+tDvhhavgROua3SLjKSgmiX4shVVCZEj8CXIb2WbaK0vmxgJZaNKMCVW1V06Rz+iH/j4AjENXMz4rQP2tRMexH1kd6TBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUOZQVGR319S3Jjc5EjCCSNf825/2OjvalxuAVfxzc4=;
 b=XHdyvHsqWiKcdRs+LDDjpdJNVns1niZqZlhvJnGA4e5gQzYsKxflTEgj0fKXmSNUKdi5NE+WLc39inG6S7CbLxcebMVpaI6qJEWfFLWKyeNC7hB9yQOmQjIM4iXaLYZITbnbWDH5JRvCbI5j6FalE+ujq1z0+awzwczqzk50Ms7EprVKdO8qLep+F9NNPVBFkTibSDZUQEhFxTHvoCZcaEqS/FyFDOPSdVxDBieOYh5fjMivO6zEODFWUs7KSgwNYeToyv9ESo5o1Gfhz3dLMOuar5NdvRm6nduWVrUcQQBYIqxvbXQBwlGtjeF750v1itVjXxpXfdfkRFbRpsYeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUOZQVGR319S3Jjc5EjCCSNf825/2OjvalxuAVfxzc4=;
 b=QAhZ+ABT+Khy9Ti5OwV9Ab6MRFlk0onyNVCQVBBe0ZeHodxzpgW2OpRIG4JXOmGUQCRufYOKmBlqB2MmWNZNJCBrZ8UnLELwWLqxiFyn5ipbpmhikG0JJimdKDqPFDrQKoZEEMbR6bAtfcE7/Xpa2JBLg1lyWuSM1zbiXlZ1BNg=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 07:07:16 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::80) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Thu, 8 Sep 2022 07:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 07:07:15 +0000
Received: from [172.23.95.183] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 02:05:59 -0500
Message-ID: <2ba61271-8d3f-cbd2-164e-8f4968e5dcad@amd.com>
Date:   Thu, 8 Sep 2022 12:35:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v3 4/4] drivers: misc: Add Support for TMR Inject IP
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
References: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
 <20220908042444.2866731-5-appana.durga.kedareswara.rao@amd.com>
 <YxmFgblww9VfySnv@kroah.com>
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
In-Reply-To: <YxmFgblww9VfySnv@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d31fca-2193-4e81-2dd4-08da9168c2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: la3ium067RRS988QwkrUqC5jkqWtISEY+brYWcJhGMMZ2P61yg2bM5KhJ02mzYht0xrS3iBwWTsxkjslxDPd9MGOQ7w0O+oIsiG2qYisawEzhHqhGRiGFj1c5sekJ4UsaaBaDhnwwYH5+CnGRyS76ikMiTcZSPYxY9U5JcLDV75kwhqDp0byjjbIU3JARCsSWYZFO8yyJbwsn6ulAqMeSZHhT8v8AfD4SGgmL8isCJ7YVgEGYiR2Zsgb03nimqI5SIEwsm2K8KVZuq+YSA4JSbhsBp/UPcUo1c7F4hv4DtJwyP2Akl1br8c+IShw1VKzVgR7+E2plG7VEc3ldP7tWE6VD21Yp+xszA1m24VF8WJGxQ6g0y13aIKzTRVdYGMMMa/tjYPpo5LsflMGTV9p41Ub2/bHzHUQoSxRg1O65Ut284irhJCTAlY4WXFPHaVqbKK3UHmvjtHNnYGA2S/vIElmFbMz7sREhTMN29Qd92PMbVMPNinouC6ROH32S1OtaZCwE5o5kplwcYXq3YQobq2qzx4Qf5yC2FSFoaO/YhAyyy6Pmra9j2ELvRBq8yAC1JH6jquQy+ZSL3+zYEZIyXq05lliOckyHq4nUsrMij2Qbb19/co8FjeF4mnpndsh5akBAUM6J/i76ZLNcwkc3PYgNrLiA8kuvFFCICCSa8bwnO1H7Fh8bWI/+BWf6ElBUwaHLiyhvdgL3MnYDtYu2Nv4WId1iTcnaTndCso4gno+TNCEVX9bmGW0TCNbaJ2NCsIF/hq8j86GJXzMHHyLMAa7rKtPMmbhm85Y0AHhDvIpsRnP4fXGptALvT5AwmUzyWZENgxtxTroziLSWhLCEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(41300700001)(36860700001)(40460700003)(81166007)(356005)(31696002)(54906003)(16576012)(110136005)(316002)(6636002)(5660300002)(2906002)(8936002)(70586007)(70206006)(336012)(4326008)(8676002)(186003)(82740400003)(2616005)(426003)(47076005)(16526019)(6666004)(83380400001)(478600001)(40480700001)(82310400005)(53546011)(31686004)(26005)(36756003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 07:07:15.9523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d31fca-2193-4e81-2dd4-08da9168c2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review.

On 08/09/22 11:32 am, Greg KH wrote:
> On Thu, Sep 08, 2022 at 09:54:44AM +0530, Appana Durga Kedareswara rao wrote:
>> The Triple Modular Redundancy(TMR) provides functional fault injection by
>> changing selected MicroBlaze instructions, which provides the possibility
>> to verify that the TMR subsystem error detection and fault recovery logic
>> is working properly, provided sysfs entries which allow the user to inject
>> a fault.
>>
>> Usage:
>> echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> ---
>> Changes for v3:
>> --> Updated the driver to use fault-injection api as suggested by Greg.
>> --> Updated the Kconfig to compile the driver as a module.
>> Changes for v2:
>> --> Fixed Month in the sysfs description.
>> --> Fixed line over 80 char in driver.
>> --> Replaced kstrtol with kstrtoul as suggested by Michal.
>> --> Added error check for xlnx,magic value.
>>
>>   MAINTAINERS                      |   6 +
>>   drivers/misc/Kconfig             |  10 ++
>>   drivers/misc/Makefile            |   1 +
>>   drivers/misc/xilinx_tmr_inject.c | 181 +++++++++++++++++++++++++++++++
>>   4 files changed, 198 insertions(+)
>>   create mode 100644 drivers/misc/xilinx_tmr_inject.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5fc5ec13985e..1207effa8e15 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13284,6 +13284,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
>>   F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
>>   F:	drivers/misc/xilinx_tmr_manager.c
>>   
>> +MICROBLAZE TMR INJECT
>> +M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
>> +F:	drivers/misc/xilinx_tmr_inject.c
>> +
>>   MICROCHIP AT91 DMA DRIVERS
>>   M:	Ludovic Desroches <ludovic.desroches@microchip.com>
>>   M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 1508cc29b05a..7b1930a7f18a 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -506,6 +506,16 @@ config TMR_MANAGER
>>   
>>   	  Say N here unless you know what you are doing.
>>   
>> +config TMR_INJECT
>> +	tristate "Select TMR Inject"
>> +	depends on TMR_MANAGER && FAULT_INJECTION
> 
> But if CONFIG_FAULT_INJECTION_DEBUG_FS is not enabled, does this driver
> actually do anything?  Why not just depend on that option?
> 

Sure will fix and will post v4.

Regards,
Kedar.

> thanks,
> 
> greg k-h
