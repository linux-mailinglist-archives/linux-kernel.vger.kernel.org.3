Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0655F905
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiF2Hbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2Hbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:31:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB133EBA;
        Wed, 29 Jun 2022 00:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ+hHmp4e0gswN+QWPNzlDStTH+H4MmcsXe5iRpDYuA+YN6xkpfxIW5QIKwHSGFI63zhqZ5CZJBf6+hWCWFiV3i89XGXXyridpkdRmg3ZfQ1vJwFLHF5ZpoGydyTPtDHEXQMrZawso4yLwgYpBk+p0LY+i1g4vlxZ+oFooehU54tq4cNasdQTDDzWpU2x81kNfGSYt0qP1brO/Ca3o4ERHcq1ZvUPFtBzYkgkYCd6mY4gVG6ct+cUz/YS0UjArA1XZ2HY3D2NB/rvONCYpjWVaXTCKyRmFBOmIyNhl7Tmfv1tYoOeZZ2AzJCWZbGPLj1WAIjGPbVm2tuuBhuNlgWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eZGA27mL8OtqSYn4Cwpw2fHa0n06FLX5M1Yx5nVgZY=;
 b=lPELeqDpWfQH3jR7ZrK8t13ublLYzbLeNyLs9yvX0vJe8Y+bLik1SpS7/uBXyK/yzTLdv/gDJPOcVHv4iWSE3lFXcFoA7Zi1kmzeta1TUknhWnGW+hxkds9pjNOPE8IxpPGfjhE/aSCaqMtdyuw2GdrR029ExJqgNYaePGyY/q32hRCLEY5ukYAdbpvHEgONis80PMngCcCXysZ1qApJwiqEOwGO1/rS/f6lJqx/vjm9utE8VwKnP4YDvURLhrj83XU1LElwzaXLgZ0GrqgMBGABGKCEc2uFQrIUZh27kuZuvu/kGYb1/SQ0OLGDZkktV4z1EYxQWs5Bfozeo3KZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eZGA27mL8OtqSYn4Cwpw2fHa0n06FLX5M1Yx5nVgZY=;
 b=Em5JzH883RMZB93/YIol3uvYBmsTOZwAq0F4dD2ufWFi6XQ8qg1Cu0PLGTChK5sS5UpuNDLC8T/VcLmq1F9JKHX3iB2tm5alqFsrMnCSH2SPD/IjyqjPMbGo/ifNQy724OOyW3ZVShf7JzjnNAMdRsI11HgyEv86hLzr6XgMlGA=
Received: from BN6PR19CA0115.namprd19.prod.outlook.com (2603:10b6:404:a0::29)
 by BN6PR1201MB0049.namprd12.prod.outlook.com (2603:10b6:405:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 07:31:40 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::29) by BN6PR19CA0115.outlook.office365.com
 (2603:10b6:404:a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 07:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 07:31:40 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 02:31:24 -0500
Message-ID: <501a8539-cfe1-3fd4-65db-fabf509cebc4@amd.com>
Date:   Wed, 29 Jun 2022 09:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] gpio: gpio-xilinx: Check return value of
 of_property_read_u32
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <neelisrinivas18@gmail.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <srinivas.neeli@amd.com>, Srinivas Goud <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
References: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
 <CAHp75VfREw2F3bXDeS8O1jm0r1Ksj923jZDne9UE5vaHM+V17w@mail.gmail.com>
 <d780076d-ed24-f656-46b1-4d78cd0a17c1@amd.com>
 <CACRpkdbkm0C=GUvafi-ZzoqCk6k5fbNQ76GtvRtn_izcKWrVPA@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CACRpkdbkm0C=GUvafi-ZzoqCk6k5fbNQ76GtvRtn_izcKWrVPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bdb10e7-5491-4270-7d62-08da59a16857
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0049:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMJgIjR2UZe6CDAuabJ4Sb5+trmIzMlm7qCB0kVmC9Ab8T0kDGEEDoZyS4ZhaU2rjPDO1tGJzeulA9cBCrxLParaBPfHRILkiGvKrgGsnqMf4w7FvzwYzsNp0AK1uLzcelqxIDbvMwOqyeytvixU5bODJK5D3c6TNWHcvoj72+DPQyUVDkTuiyBwwZFOpjIJknwQEvOsnE0kQmEe1Msso79x9g1OhnI2bKOZNbsdfXJdZEOmaDqYmXSdQoskhkKo6Q8UJCmby8B5UKVXjxj3annFtmdatii/q4BZ6yZEzYEwSukoKcENymqX23Te5SK3/+x9zzoAlfcRL6+AHs6/udDiDUDK5wkt4xcIryiByNYa53IH7DGT8EsuEXeW8YnnnNXdaTXc4VX4RI/6U2UE5xVcwIKPzfJ4cYqGvTEduFgpiqzBU7yp9t/U0xyAGVqD6ci2HiWGzpK3Fs4gQmu31LEtBThr42mcq1tVyElPmzWWazk2qfo9nqrVQgu552Ftsr6UkmKr1hhAstzjkATqFBAkWFtHLxy/qrQ2q0K8b0Vk3yGvAa5A0AhrdJXAVhjlsBtkTqjn03donDFZrfHT3/A+t5N0ONTTsrCBm+/VLMIonmlDblRkqOIWz2BRgy5knkuUSNxzlUHFo83M70neVbIN5QH6Y5wSEPzE/oQ4C+4Cm2QUrCZQwcfZCDRCbkBKkqrb+Tpz0Id3hAJQGjgfSx7RsB7toz+nCtJ77DI3ihdf9dcteOrIba1Tfi7Na4yg12B+4X05S8riLq6yvpYkStRcMT12vAYj4jfGqyfUt4sLRaSLUTMfEn3mPioowy/XSc+VMKV7BEeGNC4rFwFHdaOqljh/CBbJOTLpEe1neoNWva2+6LIKhOewfXIap8h7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(40470700004)(46966006)(5660300002)(16526019)(426003)(336012)(36756003)(356005)(47076005)(82310400005)(86362001)(26005)(40480700001)(31686004)(82740400003)(2616005)(44832011)(36860700001)(8936002)(70586007)(70206006)(83380400001)(8676002)(6916009)(478600001)(2906002)(81166007)(31696002)(186003)(40460700003)(41300700001)(316002)(4326008)(6666004)(16576012)(54906003)(53546011)(107886003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 07:31:40.0892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb10e7-5491-4270-7d62-08da59a16857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/22 14:27, Linus Walleij wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On Mon, Jun 20, 2022 at 8:26 AM Michal Simek <michal.simek@amd.com> wrote:
>> On 6/17/22 18:02, Andy Shevchenko wrote:
>>> On Fri, Jun 17, 2022 at 7:20 AM Srinivas Neeli
>>> <srinivas.neeli@xilinx.com> wrote:
>>>>
>>>> In five different instances the return value of "of_property_read_u32"
>>>> API was neither captured nor checked.
>>>>
>>>> Fixed it by capturing the return value and then checking for any error.
>>>>
>>>> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
>>>> Addresses-Coverity: "check_return"
>>>
>>> I think the best course of action here is to go and fix Coverity while
>>> marking these as false positives.
>>>
>>> To the idea of castings -- this is not good style and (many?)
>>> maintainers in kernel do not accept such "workaround" for fixing
>>> broken tool.
>>
>> Let's wait for Linus what he will say about it.
>> I can't see nothing wrong about declaring that I am intentionally ignoring
>> return code.
> 
> I don't think this patch should be applied.
> 
> The problem with static analysis is that such tools have no feeling
> for context at all, and in this case the context makes it pretty
> clear why it is safe to ignore these return values.
> 
> But we need to adopt the tool to the code not adopt the code to
> the tool.

ok. No problem. Thanks for discussion.

Thanks,
Michal
