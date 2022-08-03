Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217AC588771
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiHCGgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCGgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:36:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF42B19A;
        Tue,  2 Aug 2022 23:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax0bpjY3MeqIkirUMZbyIL53QHEE1yczjMN0RDp12JbTn7APmX/o1C27OPquBtUQ+aHOI/w91c+NLPQCqphBL8V6ADL87oI5HcLdPIHBfVOz0C/h3fOv/1zptALfGbiXv9an4YLCkJnYrFqRjsJSDMqJm+yn6jZFv/vuQgHGv3UV57wViBJN90GNy+bSzsxBB35cIOmEifNbZbr2fNEEDq/l42bGG0n7nlelW6HfAYhYsq1QIhqYjnJZ505mllg6Hh2Yd3DzHAik05J3aCgZkmGk5REVhvq1sG7xYNKCm6iAOKHjuIyMwy3TzFwHqGkTpK/5hNk8P+JOWkJ88ZWQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8MWzBaTBwM6BzXnC7mHOdOauIHSvlWZZuI3wUknr+k=;
 b=EzkHtaNc7kFgdm8swpROs2ouAkhKjngqP7vcrSz+bjhZ3QeZDnQL/26EXmG0pcSi518pWxyP9f1N/6tjEmL5igUIAJEOvSeSvp03q7oQ9Ko9un/PDQtNCM7RYojoHBymLEhKA7/ASYHI+OIEiSEBbSlJPgfTEVKSPz5URcFBtYWWZvIuXJp0BoLve67f3Wkuz4d5z9OglVMd5UxI91hoxKdJokzxjRM+m5hwK8h2GYyyoZKOOomLiHFfbkpdFTWSv+6BRlBHsc9i+658+GJ/eq+0gloKvJ1W/gb9ror+7CEDH6EDF6IkxEsHgGRwQVDTlqiFuX4Ss/f8Ca6NMKPLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8MWzBaTBwM6BzXnC7mHOdOauIHSvlWZZuI3wUknr+k=;
 b=FHgEx9VhitWqojMhqCDwdStYtJ77iTHwPGhNoFrZIyITpk9OG713NKozwT09LHTIpDxto4TBeSZMOOPLltMBKEt9+m3qBEj9qtuoFXwHcNTyS/v3RFGG1oH+daBs9QeUzKvat/K4nefg35oYXK6N/AWR0Vsg+t9/Cln72AN90FQ=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 06:35:56 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::86) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Wed, 3 Aug 2022 06:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 06:35:55 +0000
Received: from [10.143.120.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 01:35:49 -0500
Message-ID: <ee2f6680-5dbf-665f-a5aa-d607262c3365@amd.com>
Date:   Wed, 3 Aug 2022 12:05:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] drivers: misc: Add Support for TMR Inject IP
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
 <YuKcBO5JatwRYQJ3@kroah.com> <f0ea25fe-782b-ed35-d977-3fe16724193c@amd.com>
 <YuOiHGBaVOSGzD7V@kroah.com>
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
In-Reply-To: <YuOiHGBaVOSGzD7V@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee5965a3-2d5e-487c-f715-08da751a6b6a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdRJZ2UyW7yrv6I7X7WNbpKs70wMeQyCCIScA7mTlp1ZZ3yuOPeuWFP6w2TKKWMDCSpOt/6cjcEj2t5XDUw05L91QgqSJmAcpZgCgyoJtSbHink1Efn25G8WbYFDduVTGhHvrSqVWDSySnLA+4yVTLxeZ9qMMvVVhyL0HC2bM7+HSIKFhmI+hHvEOt8KDt0D6m0nag5ZKsbU4jzm02eIqR+t7ss51VK1ls9JRNODxZtgvZHqfp+onna97Xl1w3cOHPcKU6a3IUFs/YQ2SbtrWF48I/bHJOj1nOxeezD5k/cAdc9kSwDTTtA2AdVwLSdO9wDSKkSQH0Q2WYOPuecTV2zGwmcIZ/dbiTfAWIZ/Zp904cy/EYm5fLOT/CVzvrIr1A6Px4syHWLBxl3/o9l1L4d4fY0QufntjswCaNu5rMMLnWViVEPFYN9aXUh8d1x4mdlrRZ8POaoyP5NzDJE9Ble27uAQyHnKhj9D3CiQmX7rvxyDFwl7x2arCWwjJI3W21ILjEEpzmgN5hSfRMQ1UTi60v7gCYLH+jbxg8yetmV13+gMdDVa2eaAvZJWc1vNppZJPcRxJRzhu40ZZLDWsKUl3S4fQdNA0FWsW7PVLv3FzBFowYeffgGWlZy+KPNgYSLyEJpopEiZWnFidW6Iz9MYAXv35uaoZl6/Aty7ZflYRFV0pU17PggQjUNxKetw6FQmNPOiu4QZvfV1DmsPbRE72kmGtS339Zv1KFlxZmIa2NjDkFlteOCdaUFrpWW3QuCquVeDaE3W2EJrNPkYZJrPjkxAuD2A6EFkjpdlzqILjHgH9zvdxRClxAu1D1iuwfC91KqVsD9yszYRL40SBQ1UlEIgQkhFkYK6r/sCNBVJ3zqFL4U+b4KvP6RG8AOT2UxqrDnv0FN4tvyjBF/9Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(2906002)(6916009)(47076005)(40480700001)(8676002)(356005)(81166007)(5660300002)(107886003)(82310400005)(36860700001)(4326008)(70206006)(70586007)(316002)(82740400003)(31696002)(16526019)(26005)(16576012)(478600001)(31686004)(40460700003)(8936002)(83380400001)(53546011)(41300700001)(966005)(36756003)(54906003)(186003)(2616005)(426003)(6666004)(336012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 06:35:55.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5965a3-2d5e-487c-f715-08da751a6b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 29/07/22 2:32 pm, Greg KH wrote:
> On Fri, Jul 29, 2022 at 01:43:47PM +0530, Rao, Appana Durga Kedareswara wrote:
>> Hi Greg,
>>
>> Thanks for the review.
>>
>> On 28/07/22 7:54 pm, Greg KH wrote:
>>> On Wed, Jul 20, 2022 at 11:30:16AM +0530, Appana Durga Kedareswara rao wrote:
>>>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>>>
>>>> The Triple Modular Redundancy(TMR) provides functional fault injection by
>>>> changing selected MicroBlaze instructions, which provides the possibility
>>>> to verify that the TMR subsystem error detection and fault recovery logic
>>>> is working properly, provided sysfs entries which allow the user to inject
>>>> a fault.
>>>
>>> We already have a fault-injection api, why are you not using that?
>>>
>>
>> Inorder to inject the error using TMR inject IP, The API
>> which injects the error should be executed from Processor LMB,
>> below sysfs entry calls microblaze core API xmb_inject_err()
>> which switches the processor to real mode and injects the error,
>> Please find the code corresponds to xmb_inject_err() API here:
>> https://www.spinics.net/lists/arm-kernel/msg991888.html
> 
> You did not answer the question.  Why are you not using the in-kernel
> fault injection userspace api and why have you created your own?

will update the driver to use fault injection user space API in next 
version.

> 
> Also, please use lore.kernel.org links when possible.

Sure

Regards,
Kedar.
> 
> thanks,
> 
> greg k-h
