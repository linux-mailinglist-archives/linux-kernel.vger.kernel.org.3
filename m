Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D05618A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiF3K7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiF3K7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:59:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55343AE4;
        Thu, 30 Jun 2022 03:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfh3fUQEK74Hh2NbKYxeKZrWxgrxqfaV71qNzJULzUEJQfVsjQqR1RM9s61r5HS/CtewoaKKl8rFPA4FbzRWVtBpLMucQHJyP9gEIe0wHErpXiHYeYfCkvwycUdvyph7KyeO4LACm8qY4fAMqnZ2CBKleH2K+64r5aH9KrAzjUihrSNGwj4XlehmQUCcUT0IE1mwtQDyET0p4J2OnAqB10QI7KcD3If0IaejQOZ7mCPUljkw/LhWRXe8CIESEruud25y/6R8UhySZKru+w8FAYQ0XdZw009XmZgp3ric+fidy89bqIJjyut7T+yDKKcIgh60BySCDxN2pjMeZ3bHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DpJsO/EAn8CAL8r9oA5Qdir8QT5OzodIFbFo5vJt3E=;
 b=JEioEk2DBdmNfy3r18HMJwSrTlV2nbtJ+2fjKabFHIie27jLxqn9s/8o1u/efqiEQOVs4jhakS6fzExO+j4wwIDYMkyol4by6zzGoNYw3wBTmwByseZ/YcAooyuL0NixDhXyQBflQCHRNzwvHLJ7nRPJKhe99d9HlPRJpi3w1WC3X7DsRt3qo/COfpDc7ImHuD9ruoTkKMkahbvVXoxU03Kd9jzbaLLRzvuIWwZgkUEfHUzXeKazB6t536xQAJIqld3+JnE+ugyPzQV7iyAanOxsaZzI29NBD9fV7jgY5PFL6rCakyUvZARHaFUcOh3g3eyuwDeCkA3ko9gzGJIuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DpJsO/EAn8CAL8r9oA5Qdir8QT5OzodIFbFo5vJt3E=;
 b=c6hlTSzCDtMV1pYjBzZrMMYIHUr832iqzt5w5nwchJyrW2ISgP5/9ykY/i4PDuWwUxU7CVVQlIxo36sv3Jhe8TKJ3v+4cZPJN5DzGEi26qrYNMF3HwQmLKKvN9fokIoZoY5894KW/HzZpJL25x3/8IDl5dp1YeH7pa6/ta9u4Ds=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 10:59:17 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::c8) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 10:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 10:59:17 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 05:59:11 -0500
Message-ID: <454ed57c-1482-b7dc-9434-1ca5888c8b66@amd.com>
Date:   Thu, 30 Jun 2022 12:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree
 binding for TMR Manager
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rao, Appana Durga Kedareswara" 
        <appana.durga.kedareswara.rao@amd.com>,
        "Appana Durga Kedareswara rao" <appana.durga.rao@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>, "git@xilinx.com" <git@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
 <fc685f00-41e5-e64c-09b8-662b01a46f6c@linaro.org>
 <6f5a1b1e-b484-3a15-00be-2c1ddc09468e@amd.com>
 <e43bede7-2a0a-5114-e9ec-9e1449bf4e47@linaro.org>
 <a653cb16-4aa9-693a-ac32-cc7b1b999b92@amd.com>
 <dd709b5a-1cd8-0343-028a-5d134a9de81a@amd.com>
 <6fafbed8-9c6d-ae1b-c613-44982b681276@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <6fafbed8-9c6d-ae1b-c613-44982b681276@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60951ae4-785a-47ae-7e3e-08da5a8793ba
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAvicOxENrF94PJQk/xIQpvfblgXqhry3TleOBVDXu0US6Qs9gtwz3Lz1xunt+IV9bQngqCNhEAcBqf6qhLHEcGtXm5ZaKt5FmByJiT97ldbppp9yz4XnXfYqyNEVZrfNi3ShxjOT+0/aV1y5cznsWhbxECGGNrh7TkTWZhTtFct1ULfhfiwq9dtCrw2e3iS96SnMhLKI0Np/r7/hxQIS9/RkbphU6vAXDVbTN7nZ+7DBBOpNIIR5DTQMnyTEfNXGgb2gAKH9ajywzvezqs5dgXrrMg5SmjbCgJfTj81YGY6hZXpSAftdkerNKXIa4zIzw3q7iNFYb3lQGqNY2XyQ3dAqixbRnAa/B5vUHrhPbmXba+tXkCCW5Rd3LF2wFsYcdStc+cKABIMlAQXAglmHGz/yvp7nRAEsZKYnpim3QyOlJ9OSTL5vdxkZzNBhZjzNx0sb4c1qJ+M99Ocbo4biewugBn3PXc8XjsLUgXm9rRy+5qfcB5oncgdmrM2RfHihaWI76dy2idmL7sRdVFQfbVR6CklZsD+tuz6RjQP9weMhdRMejEYAqPAzbl5OogWGDx9F3Wvrb2yk6WgRnWffydTDwvoWZdmFeOG8M3fLfmhhQg17//YUTIE1cXVz0P9tQlJZvL6vUA/hqWG6LyCxzTlKv5s+++O5lOLFBISd6sZ7RgYNKubIyP9axXvLt3IzDw1xLfwipz+VA9sKEyompouXp3sKeB5wao6YeXPxgvrxwsWHj7nQEvyQKddTFN/lzTEyoKrTsSzmO5SDc/MhV85N8akP2cj3TXaOXN/tcybYgwzxjIjZdkKw0JJ8oZicWlUJr0U0yYiq6OxXKYqgBGsuTHzzNLRm+5+SXAf7h0toGgkHw8JqajQsnvL0oVqmDtfgSlPt9aN6j/1FEoH+GrDZ3dba4qwPT1u6LRo8/W4zu5LTpnRIjhEaP2XzdPh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(31696002)(82310400005)(16576012)(36756003)(316002)(81166007)(40460700003)(83380400001)(107886003)(40480700001)(2616005)(5660300002)(53546011)(2906002)(41300700001)(44832011)(31686004)(966005)(82740400003)(921005)(356005)(8936002)(8676002)(70206006)(70586007)(16526019)(4326008)(26005)(186003)(36860700001)(54906003)(110136005)(478600001)(86362001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:59:17.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60951ae4-785a-47ae-7e3e-08da5a8793ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 12:07, Krzysztof Kozlowski wrote:
> On 29/06/2022 14:37, Rao, Appana Durga Kedareswara wrote:
>> Hi,
>>
>>
>> On 29/06/22 5:29 pm, Michal Simek wrote:
>>>
>>>
>>> On 6/29/22 13:45, Krzysztof Kozlowski wrote:
>>>> On 29/06/2022 13:23, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 6/29/22 12:07, Krzysztof Kozlowski wrote:
>>>>>> On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:
>>>>>>> This commit adds documentation for Triple Modular Redundancy(TMR)
>>>>>>> Manager
>>>>>>> IP. The Triple Modular Redundancy(TMR) Manager is responsible for
>>>>>>> handling
>>>>>>> the TMR subsystem state, including fault detection and error recovery
>>>>>>> provides soft error detection, correction and recovery features.
>>>>>>>
>>>>>>> Signed-off-by: Appana Durga Kedareswara rao
>>>>>>> <appana.durga.rao@xilinx.com>
>>>>>>> ---
>>>>>>>     .../bindings/misc/xlnx,tmr-manager.yaml       | 48
>>>>>>> +++++++++++++++++++
>>>>>>
>>>>>> This is not a misc device. Find appropriate subsystem for it. It's not
>>>>>> EDAC, right?
>>>>>
>>>>> We were thinking where to put it but it is not EDAC driver.
>>>>> If you have better suggestion for subsystem please let us know.
>>>>
>>>> I don't know what's the device about. The description does not help:
>>>>
>>>> "TMR Manager is responsible for TMR subsystem state..."
>>>
>>> ok. let's improve commit message in v2.
>>
>> Sure will improve the commit message in v2.
>>>
>>> TMR - triple module redundancy.
>>>
>>> You design the system with one CPU which is default microblaze
>>> configuration with interrupt controller, timer and other IPs.
>>>
>>> And then say I want to do it triple redundant with all that voting, etc.
>>> If you want to get all details you can take a look at this guide
>>>
>>> https://www.xilinx.com/content/dam/xilinx/support/documents/ip_documentation/tmr/v1_0/pg268-tmr.pdf
>>>
>>>
>>> In short TMR manager is servicing all that 3 cores and making sure that
>>> they are all running in sync. If not it has capability recover the
>>> system. It means cpu gets to break handler (it is the part of microblaze
>>> series) and it restarts all cpus.
>>>
>>> And TMR inject driver is module which is capable to inject error to
>>> internal memory to cause the exception to exercise that recovery code.
>>>
>>> Kedar: Feel free to correct me or add more details.
>>
>> Thanks Michal for the detailed explanation.
>>
>> The Triple Modular Redundancy(TMR) subsystem has three Microblaze
>> processor instances, If any one of the Microblaze processors goes to an
>> unknown state due to fault injection break handler will get called,
>> which in turn calls the tmr manager driver API to perform recovery.
>> like Michal said TMR inject driver is capable of inject error to
>> internal memory to cause fault in one the Microblaze processor
>>
>> @Krzysztof : please let me know if more information required about
>> this TMR subsystem will provide.
> 
> Some features sound like watchdog. 

watchdog needs to be keep alive which is not the case here. These systems are 
designed for safety or space applications and I am quite sure that there are 
going to be couple or regular watchdogs wired too.

> If it was ARM, I would suggest to put
> it under "soc". Is a term System-on-Chip applicable to Microblaze? 

I have never seen microblaze in connection to SOC. You can make SOC based on 
microblaze cpu (using hard cores) but in most cases microblaze as soft cpu is 
loaded to fpga or to programmable logic.

> Other
> option is to store it under microblaze (although for ARM and RISC-V this
> is actually discouraged in favor of soc).

Exactly. That was my main concern too that adding to microblaze is likely not 
the best location that's why we wanted to add it to different location.

Thanks,
Michal


