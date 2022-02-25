Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDAA4C46FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiBYN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiBYN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:56:53 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743D21BC5B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2gp6X8b7NsuTYkI1siWx7MtwcmA2zF3HCH5B/mVRtz5arL6JfvGQ9NOExvy1f3P8o+KViHoL/BGMn3cm8phDcZQY7iJ4CSo8J8uKSgCvYSTtLW9olW1giPZjY45iHCDkCMAHb/IS7AHg+imsEGZAC0ayEvI1auOuoMM+Gv01wWa/V16vouneYE9mbxOZ5sgLTyhqTjw9lcujTB8nBUeIlwSgY5GAN+IVLE+W8kdOqd14QHxMPHYsq7AQntlOfzoiJWancKgAoOORbKg/ap6rmLGCfcNMIpEFUqFuGKjarhfZnbFnhtrFEEraqt0Q1m5DUEFflX29M11hM0LqA0Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPEhMnZRQ9eer1i3qXNg5xBxWFFjpdpn6dnlbsheAXk=;
 b=fvJ8E42qhj3JNBgfVyICgykHeOVEm5aLkvy2nTz1lS1dNEHdzYVLGjDoDt83zj2b7Pfb6iaum2fZTBILCDwb5MBnr/u1r2D3qGLxMlZztStTSL2XNVRRQ8gLISDwZBRS5ojw2xBAlSezfY4BMifxV/0obdUxobHwUAY+FzS0g58y/Pi1moB64QQQgWuRgJH2rTst4yyUYKoC+kgRz/wnU2jC4OJpwq1O4Ud+5TpR5ehSeFdg5aREqAM89JYdQ0TdQHjRU/DhnrVZYgPrVxqlC2003rnldWMVoASO+/pg8ncCG7XoIP8wKDNLykF6ilkRBEDC/OyFTshfXBKeiRhqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPEhMnZRQ9eer1i3qXNg5xBxWFFjpdpn6dnlbsheAXk=;
 b=VuiXSeZ7IXC28X9CqmflUhinj7tsiiXHdqC1dcXDP6dmzdl/TtUhe4A7gVv4f7Fuwl2h0cD5BT/NR7HefMdSEM+4Uyia/EPgnCD6tTLPK1Z+4VXgkEgbqJUa4Xd8/RVJPfoZyOacBBi6NYHukEpqtRGr4znBVWOwkPaMr7ILW50=
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by PH0PR02MB7637.namprd02.prod.outlook.com (2603:10b6:510:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 13:56:15 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::53) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 13:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 13:56:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 25 Feb 2022 05:56:13 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 25 Feb 2022 05:56:13 -0800
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 monstr@monstr.eu,
 rdunlap@infradead.org
Received: from [10.254.241.50] (port=59384)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nNb4v-000CI7-06; Fri, 25 Feb 2022 05:56:13 -0800
Message-ID: <ce6cf9f3-0543-c9af-b5cf-bf166c974ad7@xilinx.com>
Date:   Fri, 25 Feb 2022 14:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/1] microblaze: Fix issues with freestanding
Content-Language: en-US
To:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>
CC:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <cover.1645797022.git.michal.simek@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <cover.1645797022.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2293cf66-96ea-49bb-19c6-08d9f8669710
X-MS-TrafficTypeDiagnostic: PH0PR02MB7637:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB763711527888750D48BC41FEC63E9@PH0PR02MB7637.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VN1bxdgB2Nkk/m6R8nw4xKT1OORTGVRDFGe4CULtPShBVGDErRXI36howP0GN0gEherYzGfc4SVb51+9k0jxSu+sFyJJjj4ObZNqIXC61cH4/QbMPgo/FywjGZBOynZ77cC2Q38vDywUbiuZ0IWP1ODbvHAcjIpPzYnqlyDwkj7J13PPOEyTXno8u/BQFS5v3lYFCQ93Y10k0DINXuirTcfA2NA8h+Vv5bNJE/nrHe6fSIOf7+aHVZJ/wnvS/0FnulPML5b6E+OXrgKUPz9yfj4g7iFx0N1K+citpUwDT4t8SH7mL5Xr3RAFjDvHAnbqv8EMMNhAVyPti2lbrr9KJIib3n8qVevRtMpKlGHpUE1RSOanamMNAXgU0N+IUf9+hyMhaFtrznjCPskLI4EWeNqNl78nZZDP6yoKnEomwQNbA1NcIky6Gqpcj8/x/f1ulkWYff/Fq8tWfyIVc9lY51X72Yi/Ac56bBOjfpElGEu6wBvOss7IszIyDxGRgwgTn71jimFIdgOUbuUppkrf32ROXVX5Tn8Af9CR5NhFjiYSRGm3K61i8Bf4ROWe18fOgsMZRCLvDkYgBTT//tYk2iffqacR+PDQfHB13mtlqNbkqZRHlVQqhviZi9L+S/tJNyAAVuLlkrUxYUlApHcVQIZjcv70hoJkUTmgORUHpZMg6ZKl5vq8ymiqHRSq78DCJ0vnFPyQdQfS+ELFQFdlrqFeWK2/Qv+zbcT12ZGQ1j4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(31696002)(70206006)(4744005)(8676002)(4326008)(9786002)(44832011)(36756003)(40460700003)(47076005)(2616005)(8936002)(82310400004)(53546011)(36860700001)(2906002)(5660300002)(83380400001)(7636003)(54906003)(110136005)(6636002)(26005)(186003)(508600001)(31686004)(356005)(426003)(336012)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:56:15.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2293cf66-96ea-49bb-19c6-08d9f8669710
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7637
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 14:50, Michal Simek wrote:
> Hi,
> 
> with GCC 10 there is issue with simple memset implementation which is
> called recursively. There are couple of discussions about it and the first
> two patches are trying to workaround this.
> The third patch only removes simple implementations from arch code and use
> generic one which is the same.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (1):
>    microblaze: Use simple memmove/memcpy implementation from lib/string.c
> 
>   arch/microblaze/include/asm/string.h |  2 +-
>   arch/microblaze/lib/memcpy.c         | 18 ++---------------
>   arch/microblaze/lib/memmove.c        | 29 ++--------------------------
>   3 files changed, 5 insertions(+), 44 deletions(-)
> 

I didn't send all 3 patches. Sorry about it. V2 has all required changes.

Thanks,
Michal
