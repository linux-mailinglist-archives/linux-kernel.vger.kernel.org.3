Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F152B1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiERFCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiERFCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:02:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E213F4B;
        Tue, 17 May 2022 22:02:17 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZDziEMz4JUU6Jw68apwI+KYvAuLC7M1Vb6k+K264+9GOSk/k0Bl/myAGNps28nR5oL8BYtnYGSuIeSMITGuSNDMUZCfYDJ2zED6FJuv+3vv0ulIgBg8mJPlxQNagb7COj2ATbtLuQO8GDbqhndq+TqSQKaIjnCLvqzX1vt/SbjLGPzz3siSpBjYVu/FiyT8WvD+A4QxnizTxSrIyDmhYEoaD5voCe5OIdI18L9rbIs3sDJAoMSDUGCtkfBvr1es9jW3F2ysKzRU1wkRR9pnQyD6l0hGkucaGsS8FCJgsRe1StLYiZz6aTeK3uP0XucZi7uL4immXgB+a4/ydXaw3uA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPiq7Yn2XJRTbBj2HAf6REOe6SoLkVcO2Js/LBC9YVU=;
 b=h1egGHXZT74NqSBgr4HHo/M7/1RUVj/NcPKW0MAG28FRTbmSb8b7obcRl+L0dpyNaO7TUext90YujIOEra//koWwC08CSkdbenAglypUFb0KNinpRXt3pgjQfm+IuUF1k4nlisHp36SeMnAWGc24CfOLMgarPZuVj+0F0HIF+IZxNhUNjVCsd7rghni3x8uhwNlodXfxQgYpfXX08L0NZ8pQaSv7viPM+uNaE52Kmym6olj1J0eZYTAblZ/mMxfwNO1X82cN0EPHwZC6BIICBikoxKxwAFI7RUdSnYQG42SoG5xkcPKtXM0IAc7SUnMyjDNQ+9UrDp7hOzwTsDqtmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPiq7Yn2XJRTbBj2HAf6REOe6SoLkVcO2Js/LBC9YVU=;
 b=Xw7FGPRFO4ZAxNalIkdoOLauvNC93aGjSdLhvN/FR5zBQPhIE6uIt11Hhb7qT+vKpQnrP8mfSDkoxHl5EZ03IKC/S/6a4djeIDnvibW1f1zKGfXGoPBGm9NsegY56rQmiydoe8HcomMhmk5vU4tZLRFYT2WCuOt+ww+VQjuHHkI=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by SN6PR02MB5598.namprd02.prod.outlook.com (2603:10b6:805:f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 05:02:15 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:130:cafe::4c) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.12 via Frontend
 Transport; Wed, 18 May 2022 05:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 05:02:14 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id 4D06441D66;
        Wed, 18 May 2022 05:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCdYq4qqd/h+mFzPNEfuWmFWctJcG3ruYQitgTHM9UhLVN4Omp3SL9BMxtRPowoXX9qQRennxw515E+p/+Kj+kelqbtm3Df/Lj8pJuMDswv0ohmHNQKU3dU/LK89bequc/kdM0CKQfzc2fMUfRJdJXOsx/Yqws/GKkfr7vRi8dbNmPDB7z210y+DtTo+LZzTKAasbWrPtDpLzeafDNhNvndj8zY6OGI3plsuPwsgHwvA0ycStqDZ9dWeEhB50zCSeH7X9Vm4QfDUhOmAGdvgi2hnGWHvXxJmSNZxGZUOq7GW17A5/UHmoSxbo4L5ywO3pJi8iPN+1xboLWFSsxnE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPiq7Yn2XJRTbBj2HAf6REOe6SoLkVcO2Js/LBC9YVU=;
 b=EDKh5+lMQPs+ewFs9iQqS76AtQl303l75D3yxm6CLiA3zOD5gcKebh2XvSxElg4qihY2ZUpguZiNhmpTqTnYxdQO1l6q+64Js5FESEq1A/xMxp/M0Zklzn/sWJ5Y/CLsF1M6xYm784HqSsb801HY3M2Z7UsvGjP1sfQ/4HJQgEvsqQcwCk70n9b4jLsSmhS+M5TGEdPWVumQbX9YAe0sPbLEd/3RCcio2l9kbW/mZFKsGyW4AuULmb/oQyHNGBI8Hfunt0mupscJGGB1ziIKzEDb13wtAukXOYeUtH7w2wfbB4wfl5xnVUBdA7M5MHDwvN/YT57q2EJpq6yD7JcoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from SN7PR04CA0155.namprd04.prod.outlook.com (2603:10b6:806:125::10)
 by SN6PR02MB4413.namprd02.prod.outlook.com (2603:10b6:805:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 05:02:12 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::e3) by SN7PR04CA0155.outlook.office365.com
 (2603:10b6:806:125::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 05:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 05:02:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 17 May 2022 22:02:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 17 May 2022 22:02:10 -0700
Envelope-to: frowand.list@gmail.com,
 devicetree@vger.kernel.org,
 robh@kernel.org,
 linux-kernel@vger.kernel.org,
 yilun.xu@intel.com,
 trix@redhat.com,
 mdf@kernel.org,
 dwmw2@infradead.org
Received: from [172.19.74.144] (port=42736)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nrBp1-00058b-5c; Tue, 17 May 2022 22:02:07 -0700
Message-ID: <c7e4e7b9-c5e8-9af9-6c16-2a8e0e7e61f7@xilinx.com>
Date:   Tue, 17 May 2022 22:02:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2 Create empty OF root 1/1] of: create empty of root
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <larryliu@amd.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20220216050056.311496-1-lizhi.hou@xilinx.com>
 <20220216050056.311496-2-lizhi.hou@xilinx.com>
 <48b43291-b65a-0939-16ee-95b342e46377@gmail.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
In-Reply-To: <48b43291-b65a-0939-16ee-95b342e46377@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 198ab51e-bb9d-4101-25a6-08da388b9358
X-MS-TrafficTypeDiagnostic: SN6PR02MB4413:EE_|SN1NAM02FT0041:EE_|SN6PR02MB5598:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB55982303198C474954A1858FA1D19@SN6PR02MB5598.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fctt5Pzn1vT6O5mw1rsE0o1XMpwOJWF6kvkOoSA4zp4Vn+QPSibq+tHELdit4SNwBgJGJib4Rms9lVpU0KD9b6vb3aXsBiadgNGHHjtwp67RqZ2X1hc7ldIueBlX/ID0OsLVBT01XoXs0ZZGqeIvKI1ROypx5UEbk/PmLB/BTNCkOCK7o2wQyBJMrfifTQhLPtzhBXn+3lApwWvXXKXJVou5ejGEVzfuJoSMfKFxobeyAqY+cMP1oCmU4rYnbjjaQcQywmBp3BQRBlrhsd/VHRCYJu4H3R7mbxwOT/Nz1HsvoZLds/iNXjIUvc2dWr7/qNVYStD4df/VwzStOOLOCMzZJWdl+GkmpBFzr9SOLdi923GOo19kpfffvOv5rR9wNyZR5cV27PVc5y5P9MMm6vZlYXcCpGSmCrnN8IQ0J5tIfOVD+a7QddsfSycvvA2/GuqqZ5rs52k4DucByW3onffh5hvq4YspOO65i23P0D+/v5yOR/1swX9lxSrXojcoBjPwgYnNUTXV/qNUxPG1/Wnotzr2s0Yy6ribbAF/2U3KDm7pkPWcjWj/E10ZL8q3ifISrddtlFQ5GFduXk4KSMOiIU70MTMLmYfzMISzwg7dauvbFZLz0uaUHHr5hENP0fQS/Pv7Sl0Y1M68ybzcuKMFy5GTRUigsyM+Q6EgJVXCKuL+slH+TtpgND2IBVZkSyUEKFiaBlaU+XQRD+3WSbllijkUIMsjOXLhHK75TCHQ8SC67aRR1H4//zDSvzPv4HdlxeJD+xgJykSEV4RQ5Uk5pIHNSTDi+JNE9G84e8qzoOoxjT9D2Z5fCSGoV4TO3Y1KZDhaYCr0XufyN2D6lu8wplCZgBxqIauEK1gcatY=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(107886003)(83380400001)(5660300002)(31686004)(186003)(2616005)(508600001)(8676002)(44832011)(966005)(8936002)(36756003)(9786002)(40460700003)(336012)(316002)(426003)(6666004)(82310400005)(54906003)(31696002)(4326008)(26005)(110136005)(70586007)(47076005)(7636003)(356005)(53546011)(70206006)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4413
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0fdb807f-7629-4e69-03f7-08da388b91ab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYfFTSWQOoKwBi/usKqcg/EzXzj7CQR9TKmB2FV13cfzPJctNz1XIRcVqKCb6yveRZh1s8pL3wnuFuNO1iqE8m3ei1WtAUYx0x9F7xDrVadfjnx+LsYxW6buaPxFfYVA5VBvYTLY0bkKGY10/HJafH3S2Z849F6YdM6u4OAvzSW0ZBSKPtVU/Q3ZRZS8+angAnLMjd0d/SvGQpP1xWwmCmlPTM/TDOHRnwE8EQsU/q3k4yYyn6d+zhkGVfEklutp2u/3OtMQNEuXUX+VdXm7r06VgMQKtBtJ4lPhcip6mOxDDGv93K59zvMUc+p7xGo/twYW3HqfbM2JkiFL3duJUKIcOT0OjcsOAJ95l2Mh/Hpx7skY3fTGi0JgWjPGJnuOMPSQFuujuWf4cH/2YXszJX+VU0fbn4bEt5dr7Sq8WUML6kQ2ElzuJcPBBEfEro13WQahIQYPfk+USqTPKU0F0CP7Csjv/qC89dgsbA9KPuflkEPfGAGjydYiuYGv2r1IudlRv3cv8AvCoqcVdgRVgDdQJzSNp+X3K36eWsekqGS3xkBYT9HoKUMBwYaGMCRXfp1dUVGRRqNWKrJ1Xvt4MncpV7IWXR//sqJzBMFEMHirRdrKjq/HpHLLCBLaM40PtwpiBTP/jB+wVZrjMe7PdYSQMVW20RzwlnPkABAy4YC+keMt9uWmmFmtTmKSCC+HiPZOhCQCC3NmuuhfE4kJ1YcEsvgVoUum4eulsvu6VmrDjR9nb5aE2UFmvnZnxgy7XMcTNXzOXa/baura3af/waw/qzdk2DTVF8BcBaFhv+SR5v1vlXp8i0+3MdX297Dyuc6kT27x5ViaZBNC0MboWW04OXsmOjoXp7+gvnrIOS1vzxuEnTW58hygiTgs5hMFYV6cgFXdaWagWKd8DVeKLQ==
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(8676002)(9786002)(8936002)(70206006)(508600001)(5660300002)(107886003)(36756003)(40460700003)(966005)(54906003)(2616005)(4326008)(26005)(53546011)(336012)(426003)(47076005)(81166007)(6666004)(2906002)(36860700001)(110136005)(186003)(83380400001)(31696002)(82310400005)(31686004)(316002)(50156003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 05:02:14.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198ab51e-bb9d-4101-25a6-08da388b9358
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5598
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/22 20:22, Frank Rowand wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 2/16/22 23:00, Lizhi Hou wrote:
>> Xilinx Alveo PCIe accelerator cards use flattened device tree to describe
>> describe apertures in its PCIe BARs. Each device tree node represents an
>> aperture and each aperture is an hardware unit which requires a driver.
>> The product detail:
>>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>>
>> Thus a base device tree is required. Then the Alveo card driver can load
>> its flattened device tree and overlay it to the base tree. However device
>> tree does not always exist. To resolve this, add OF_EMPTY_ROOT config.
>> When it is selected and there is not a device tree, create an empty device
>> tree root node.
>>
> Please run scripts/get_maintainer on your patches to see who to put in
> the distribution list.
>
> I recently stumbled across this patch series and the previous related
> patch series (currently up to
> "[PATCH V3 XRT Alveo Infrastructure 0/8] XRT Alveo driver infrastructure overview")
> when I noticed it in an email archive.
Sorry about this. We will use scripts/get_maintainer to make sure the 
required maintainers are included next time.
>
> A similar need of creating an of_root if otherwise empty is being discussed
> in the thread "[PATCH 0/3] add dynamic PCI device of_node creation for overlay"
> at https://lore.kernel.org/r/20220427094502.456111-1-clement.leger@bootlin.com

Thanks a lot for your information. We investigated on adding dt node for 
PCI device as well and got some questions.

https://lore.kernel.org/lkml/79e4c876-e5a4-861f-cfbc-c75ed1a07ddd@xilinx.com/#t


Thanks,

Lizhi

>
> -Frank
>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/Kconfig         |  5 ++++
>>   drivers/of/Makefile        |  1 +
>>   drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 57 insertions(+)
>>   create mode 100644 drivers/of/of_empty_root.c
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 80b5fd44ab1c..452d2316b47b 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -94,4 +94,9 @@ config OF_DMA_DEFAULT_COHERENT
>>        # arches should select this if DMA is coherent by default for OF devices
>>        bool
>>
>> +config OF_EMPTY_ROOT
>> +     # driver which requires at least the empty base device tree to
>> +     # overlay its own device nodes should select this.
>> +     bool
>> +
>>   endif # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index e0360a44306e..c65364f32935 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>   obj-$(CONFIG_OF_NUMA) += of_numa.o
>> +obj-$(CONFIG_OF_EMPTY_ROOT) += of_empty_root.o
>>
>>   ifdef CONFIG_KEXEC_FILE
>>   ifdef CONFIG_OF_FLATTREE
>> diff --git a/drivers/of/of_empty_root.c b/drivers/of/of_empty_root.c
>> new file mode 100644
>> index 000000000000..5c429c7a27bd
>> --- /dev/null
>> +++ b/drivers/of/of_empty_root.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2022 Xilinx, Inc.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +
>> +#include "of_private.h"
>> +
>> +static int __init of_root_init(void)
>> +{
>> +     struct property *prop = NULL;
>> +     struct device_node *node;
>> +     __be32 *val = NULL;
>> +
>> +     if (of_root)
>> +             return 0;
>> +
>> +     pr_info("Create empty OF root node\n");
>> +     node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +     if (!node)
>> +             return -ENOMEM;
>> +     of_node_init(node);
>> +     node->full_name = "/";
>> +
>> +     prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
>> +     if (!prop)
>> +             return -ENOMEM;
>> +
>> +     val = kzalloc(sizeof(*val), GFP_KERNEL);
>> +     if (!val)
>> +             return -ENOMEM;
>> +     *val = cpu_to_be32(sizeof(void *) / sizeof(u32));
>> +
>> +     prop->name = "#address-cells";
>> +     prop->value = val;
>> +     prop->length = sizeof(u32);
>> +     of_add_property(node, prop);
>> +     prop++;
>> +     prop->name = "#size-cells";
>> +     prop->value = val;
>> +     prop->length = sizeof(u32);
>> +     of_add_property(node, prop);
>> +     of_root = node;
>> +     for_each_of_allnodes(node)
>> +             __of_attach_node_sysfs(node);
>> +
>> +     return 0;
>> +}
>> +pure_initcall(of_root_init);
