Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8904C632A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiB1GjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiB1Gi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:38:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74453AA43
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:38:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfNef382o3Zlr7scyuCYoifKvJZ0VP5ajnL6X0pSUYlQpYtQ9dlZAc0bcbd1cbLVOuMGmR6jk+CqeCvHk6nZpodsC0PSHodlNGflIJMzGFL7cBqW4enL4CsWCKmqbdkOsNwOuEfab7MRFUV2wBVB4pbZ8JwBL17s1v2UH0AAb/Jo065N2Lc8G1TDCf8pPZHCUOmtp45/VWJeypfgIjpRBh4YT28e1Ek2HG/Fx7czyalNoJN5djJg482uPFml/YpvZRo9OLFxaWJ8lwB0i5pWCzup5XSH4tm+z1M6jueL+uNmgaLLr3hshQS4D1+0Jz+EeOBw0aBw3HMY4SUkLf684w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZBBo8r7oa47n2bX5ETp0kHgP/eGD6zLEUHw17LflOY=;
 b=WZkQQjpZYD5nymuLJt3SGngGq6PGm5O9rLNrTUrszbDeLsdtEdX+e1CVytxAJUJW6ELTPfS/H+990lV2CSK6JnJk6+RyKFOJNcleoNg2rEtrm6ZuPE/rHEvYjMdckenoWKMASC9MNminz5/BdUTMcLc7aZ/qLFVywKE5d4Am3RoIdR0j8fwZrcxWf4YtyipBEeEJ0r5CIAJdYwmD+OHeGtw8Tghzk2c4HH9B1apraeIas5YhLJZkCEozY9Kn/Nm7UKPa1XM3aZMZD7yf3etAZaYFNlYXkglfz+ndzI2NKNeJ+bVlK3r4+515PO2h5VGlWZKFIXe1tsyh12cke7RvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=aculab.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZBBo8r7oa47n2bX5ETp0kHgP/eGD6zLEUHw17LflOY=;
 b=IpzzcoV4uf4/rHnSJZDSYPzgqR4CnDbQADidBA0sgKgtR+uJH685y1rUkgH2d8QFUPZUz5NPfyXfsdJVugynm+JCxBTa3OkttuVD0lV4BynbcXXwsb0KktWCnjYhE0dIRDTO7IOsIm0qCD/m07zLgf4uAUeZ21qrR1rJJoea7/g=
Received: from BN6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:404:11::16)
 by DM6PR02MB6588.namprd02.prod.outlook.com (2603:10b6:5:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 06:38:19 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::9f) by BN6PR13CA0054.outlook.office365.com
 (2603:10b6:404:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10 via Frontend
 Transport; Mon, 28 Feb 2022 06:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 06:38:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 27 Feb 2022 22:38:17 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 27 Feb 2022 22:38:17 -0800
Envelope-to: git@xilinx.com,
 David.Laight@ACULAB.COM,
 linux-kernel@vger.kernel.org,
 monstr@monstr.eu,
 rdunlap@infradead.org
Received: from [10.254.241.50] (port=33782)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nOZfl-000Di2-DQ; Sun, 27 Feb 2022 22:38:17 -0800
Message-ID: <9e6f88c2-a868-71fe-227f-054bab0429d8@xilinx.com>
Date:   Mon, 28 Feb 2022 07:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/3] microblaze: Do loop unrolling for optimized memset
 implementation
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Michal Simek' <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "git@xilinx.com" <git@xilinx.com>
CC:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <cover.1645797329.git.michal.simek@xilinx.com>
 <10a432e269a6d3349cf458e4f5792522779cba0d.1645797329.git.michal.simek@xilinx.com>
 <a3621a76457646b58a9deef3e861d362@AcuMS.aculab.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <a3621a76457646b58a9deef3e861d362@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b73c482-bbba-4126-0c17-08d9fa84e867
X-MS-TrafficTypeDiagnostic: DM6PR02MB6588:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6588746874971866984910B5C6019@DM6PR02MB6588.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRb0NLVFExPe3QXvGqDk1dy664D2iGI0m4fij8khzYrBvXkyynWhyZ1a5V28wT83N3Yf/033Le71NYgM2FpmS2HyidPPYLXL0Ayp7AfLVv1N8cCuG15/p98mV9hlO85ybR5UyhMe7fGCMAm6wwPRtOqFaHpI/qhe6l7Cykkg5lf58ZdIR8TXiwKWVYqIMha9pQ/L5IsIQU2vblN+osAJ7UPJ1z/SUwOsL2kr4yzeZi8Ui2lMLR/R2CR90Q2TQRCJJ3gM9MPlJ79SYGGJa1KOTD8SD3KU3C3ltkbwB9F6HbEvbADUEWpQwgMs82aZJvqfYq0esKqHi+6qFq9SZ696H3tKBylCLkN4+bBPj5/yDU1ZtrQMe7TYPwmjPznPUrvBe/e5lUfpugGW8vrfMWjAq6OQ+op/zAubj9JZTQ5K0jGvjzQjUXqfzdUbINqB8RWVcvtmKYTLVP3lQFkKas3+VBBZ3jsHOVHIy00gJphg4KlufjAcljlgpfhf5qtrhyOZqI12r9gMKSOheGU77UUFwOZNjXbOSfE4sz+4bpOyGIFNzaIGeFGv68wWEMENoAbOEQbIZdqSyAMObT70gEtJY2DlSEvtXRC4URPWWc9uEls//ESMjVUrUFCb2AlcE03Ubu5chLgHoZHpIvCPdqou6woVrY9hKmAWdxezGMnIAIyIzNcn+SYJtHeNdIgHKK69
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(53546011)(9786002)(8936002)(336012)(31696002)(426003)(36756003)(7636003)(44832011)(5660300002)(54906003)(110136005)(6636002)(26005)(356005)(8676002)(186003)(31686004)(82310400004)(2906002)(47076005)(4326008)(2616005)(36860700001)(70586007)(316002)(70206006)(508600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:38:18.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b73c482-bbba-4126-0c17-08d9fa84e867
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6588
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 22:50, David Laight wrote:
> From: Michal Simek
>> Sent: 25 February 2022 13:56
>>
>> Align implementation with memcpy and memmove where also remaining bytes are
>> copied via final switch case instead of using simple implementations which
>> loop. But this alignment has much stronger reason and definitely aligning
>> implementation is not the key point here. It is just good to have in mind
>> that the same technique is used already there.
>>
>> In GCC 10, now -ftree-loop-distribute-patterns optimization is on at O2.
>> This optimization causes GCC to convert the while loop in memset.c into a
>> call to memset.
> 
> Gah...
> That is nearly as brain dead as another compiler that would convert
> any byte copy loop (on x86) into 'rep movsb'.
> 
> If I want to call memcpy() I'll call memcpy.
> If I'm copying a few bytes I might write the loop to avoid
> the cost of the call and all the conditional tests for
> buffer length and alignment.
> 
> Don't the compiler writers have better things to do?

Not sure what you want me to say about it. It is current gcc behavior and I 
can't see the way back. I don't think doing loop unrolling here is a big deal 
for me because the same technique is used for years in memcpy and memmove.

Thanks,
Michal

