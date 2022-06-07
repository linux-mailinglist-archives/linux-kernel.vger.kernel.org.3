Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3453F96B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbiFGJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiFGJTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:19:21 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E2E5294
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O01sjIr7LZTV3INR2a7yvijPlvHTKSdQBxs2BuQdH/4GifMe3kXQTcB2SAnc/U9tSoqtUU7Wpgyyj4ksjILkjI1fvQ4nxAfXWUjLpow30mx8jjwJLBjomvMRHrWEyfjtAjtUl2NZ1xjaYJ3OikGSsxMSomwKHqcFmyHCHryxuM54TA0Ltp6KH0kp5IaTiqIttEnYqmAuLMq+495p5B7BCVYEXgby3ZaQcjXDJz2Uca9qI5e1tyoWvgU7k/hgDNbWxtwSy89akkQinONlvDkj/BwKfTz7w/CllCbawtDpuo9feVQKO/UlDxilkoUS5GmEjBl4nv1P6XMOWXnH9QECIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaBBxVHoEkjBMlRYIh8TVYWOvZvYwcuVrIHDGOAwumw=;
 b=b66j2cKIAJ+hIAutgRo3d0rztAvWq3Zv1z5BE6QLdD57onLY0mq2a7w7Bt4deydA1z6FgiYQcttvf6kDzydL0O7MjfPXYIQLcXUmEKncTTvF78y0uB8X2Xzk0zuMb0Ae31BANFxkrhO4aDzK6ds/r7TR+s8ce4eLpMq8Vt+wIkn+BE+hlPA3udZQ6ndHBo/+fMGSCuWj8YDcLWoLl4eSw5QIjTPALNOhslnX9eNEurSEonZVVxMxcWhjLAaX2+7E4s0bNp3if7XXbv1JSEOjYzoYA2iz9C39ZLohNkzkhRqMXLgisrNcZa9wgU1OVLEGIogk2rA9xKtB3KUWY7pLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaBBxVHoEkjBMlRYIh8TVYWOvZvYwcuVrIHDGOAwumw=;
 b=ZCuNlI4spj/2O4jDscCuloU/F4txWFksPaH/MsyeSZwRqt258EH6P9o+F/+c3vkZTVRpxSQ7692E6zsH4TrsNJ/AG/8XkawyTmeCRpigPY/CdwghuXYkexWGl3ynq+sNm8GqcCAT8WE3oNGuMSm8T5Hh9wCH4vFohLGMyNi5T5Y=
Received: from SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17)
 by DM6PR02MB7034.namprd02.prod.outlook.com (2603:10b6:5:257::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 09:19:10 +0000
Received: from SN1NAM02FT0056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::44) by SA0PR11CA0102.outlook.office365.com
 (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Tue, 7 Jun 2022 09:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0056.mail.protection.outlook.com (10.97.4.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 09:19:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Jun 2022 02:19:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Jun 2022 02:19:10 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.50] (port=53740)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nyVMj-000152-Sr; Tue, 07 Jun 2022 02:19:10 -0700
Message-ID: <deee3dfe-0488-0dc0-f651-0fbf46851619@xilinx.com>
Date:   Tue, 7 Jun 2022 11:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] firmware: xilinx: Add TF_A_PM_REGISTER_SGI SMC call
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@xilinx.com>, <michal.simek@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220526193928.3033286-1-tanmay.shah@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220526193928.3033286-1-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65cd587a-cbde-4ed8-8a3e-08da4866c81a
X-MS-TrafficTypeDiagnostic: DM6PR02MB7034:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB703472DB503A14A0D73C6552C6A59@DM6PR02MB7034.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDjbw0SURJOtIHnqunha6ZcBvifGYOby4OHDDFr2dzb+pAcFme9kS3lfQedrfD2KkpFt6BYpabbaN/BlrXNy0oNkDvWhYFYxAxuAPIG/vJ2JXbMlQ1AlOQDysQ6OibK+YTwd/8uVrjQKs+Atr+NctN/Zk3kKvVK57XxGA1A3zWl7or0Wz9sn4xkmdLGB5e4T5YWnNCllppbgoObI7inXazGt0DSfVva60ca1DkdaWObIM7+jkX/iv3f2hkVFwVvxw3ehge50QoNDlTuMp7TDbsXveivSKlKbrEWSUXKXqcZuX9kYTi8NO0GCPmS6w0YxSrqZLYj98lDCu1M2mhHq3wpCozFkENe/UOnAoHQw2NAVHW488sF0U1X23jsW/Nh/ckGZa0LCBj4hJhAZNPOd+eQEV9j/UxQmgyLv1KiGQfRouR/qTxzRFIFDz3GLDq1rHAfIboTp5yXV7ouT+iDkC1Xg98uEx0E5oBePbNk+eXCj37xB75UbCxu+GfVFp9ltpfdTqOfUyJHtaf0BfvmYpTE7LR1UD3ARrzM8iA9z++TK7HnNI3Z1uOS75kxKADfR7e/hmMVbm1R9pP6j4WKpW5fCAHiJdkmbguu3oNDLAo00NUmnDft7HMa6vZfLaTwUIo1MNodwyUQNDESr2sMInD4G/O9/iyDtJy3xA0V1/ugaP9ODc2kAk1CyaxKE647Tx7YFg9XcvCyV9iMgVNFm6DYj6SX/t3TIkRQl4daavUc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(5660300002)(36756003)(2906002)(44832011)(40460700003)(70206006)(9786002)(2616005)(8936002)(8676002)(508600001)(186003)(26005)(316002)(336012)(356005)(110136005)(7636003)(6636002)(31686004)(54906003)(426003)(4744005)(70586007)(31696002)(53546011)(47076005)(4326008)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 09:19:10.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cd587a-cbde-4ed8-8a3e-08da4866c81a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7034
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 21:39, Tanmay Shah wrote:
> SGI interrupt register and reset is performed by EEMI ioctl
> IOCTL_REGISTER_SGI. However, this is not correct use of EEMI call.
> SGI registration functionality does not qualify as energy management
> activity and so shouldn't be mapped to EEMI call.
> 
> This new call will replace IOCTL_REGISTER_SGI and will  be handled by TF-A
> specific handler in TF-A. To maintain backward compatibility for a while
> firmware driver will still use IOCTL_REGISTER_SGI as fallback strategy if
> new call fails or is not supported by TF-A.
> 
> This new design also helps to make TF-A as pass through layer for EEMI
> calls. So we don't have to maintain PM_IOCTL as EEMI API ID in TF-A.

here should be newline.

> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>

Other then this:
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
