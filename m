Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063E570343
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiGKMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiGKMsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:48:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98480103A;
        Mon, 11 Jul 2022 05:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c40vKG4zFatzovLnsmQ70TPkJ8q0iEyRp1vKfryGm3fodKjgmDihsxaIvP/nvh6p+gH7WBTRgJxtHz0VTW4MUulj02Z4atLvDnkajPhZccoY7gvgagBIlmPULCkZlcrBKyZyQ2Z0IfqPxtSviNnCRWFe/wJMd/8Yd21x/8mJHgQJlSz6nzy+4eOnd4Tl9yR4tZ+vW9ql2Gl+xeFIU6eEg4+d8lSPEn7S1J5YiWm5vBN/0GmDH4WUT4xtsIq/fcSPvo2mUCvs4YJlJt2LTiLgJCjjTtqWeXQIEmDxAYEFDokHgyBEyf4tuay9i6nEd/cylBLWZxEgpWRfN9USuv7bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEUpOOvAF9l0FyGizId1fTlvlFuzdGKvdO+gXyY6vgI=;
 b=O7z76l9MajwpPLC5/1dmVNL2j8JrL7W8PSI0Q81QsMM8om6zWjVBFhD6PGYmbCR/uyq+NKuRpNolZX4vg8Oc6cGqmbLYF0a3xCvGmN2MRKLDoSttKtmynVRpT8mCfqbsFpQDjTLpVzZ4kQBAto4/5YAtqr/MOkM3Xqd5bW3EbB6H13BXvEaJw3B0xMUv4xquKGRdHqQAKgN5ErjADcwPJg4kmCEpJRmyoBhwF4KvtDMqAATumJF1+FBkxDANRIFWkDUfXG0J8XiFpQuqDKHZ6E+dl0Qsk4PR1pLEDJsVkjbiCDj9uK/C0solvtQINGIJKPPGYIW0tndrB+Vn4tGr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEUpOOvAF9l0FyGizId1fTlvlFuzdGKvdO+gXyY6vgI=;
 b=oK0gnS5Zk5GcXUnvcGC4m/ZoKnJJm9bmVySRL94JtRiDpcjd5UwmsWDeA7gv7J6olCkjh+2tUwuUTmh1qu148ZZ9N8Vx3lcqw2UZj6TqT57+QjCVrwjuMJL7s9h9vlauTgAT69pF9YYYJAoyykzD1iVrFuD5qo4uf2oHInjFWHQ=
Received: from SN6PR01CA0015.prod.exchangelabs.com (2603:10b6:805:b6::28) by
 SA2PR02MB7802.namprd02.prod.outlook.com (2603:10b6:806:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 12:48:00 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::82) by SN6PR01CA0015.outlook.office365.com
 (2603:10b6:805:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Mon, 11 Jul 2022 12:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 12:48:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Jul 2022 05:47:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Jul 2022 05:47:58 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 p.yadav@ti.com,
 miquel.raynal@bootlin.com,
 richard@nod.at,
 vigneshr@ti.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 michael@walle.cc,
 linux-mtd@lists.infradead.org
Received: from [10.254.241.52] (port=55252)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1oAspR-0006KT-UA; Mon, 11 Jul 2022 05:47:58 -0700
Message-ID: <40110ff8-5c19-bc54-759b-a51a919788eb@xilinx.com>
Date:   Mon, 11 Jul 2022 14:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YqHfccvhy7e5Bc6m@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec0abc3c-580c-4568-be08-08da633b963f
X-MS-TrafficTypeDiagnostic: SA2PR02MB7802:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBHZIgrsSvrtimosOA+HbniuIWFCnGWUDf6Vx2oOCOJ1RPbt/0VA0xUArAMqav5nOMPEj4B1lAVZB2YgQwTMkuJPn6tnBy9x0zJVp0Bvy+dUiRlYeYubOXS03qINuPYV73BFvklkRYwqXe+jeAbVuAsYGFieMpjO9G9WZ3F2Kn5XptiZ4S5SOJTsNQFdlmHrDqZuvCcjVrf+c6StKU+xBpjRemI1L+IMWzCf5bZS9rj/Ml3Bx9u9fBQm5vLNfJ+UcmTLVLWI62ObKgKWzXYmoDtWVCcX5u6gRuPj02RdC8yZsJI/LT7QahwU/+yrAMGGxyMTivhY77GcXTt+fqp4vqCVqiuIYUq647emgCUcJRU1VCv78cQy2i4PMlP6OV44yOl7aopAU6kTtxz4uHySEIkAIrq1DcIt4W0p8TZVOMSnP/uRteMTNG8b1+ZNhLS8yMX4uB0M18qiC5vWDxxBcv1B8BBaP+XPgJnNVccTHs85hJeg7Nj22o6U38qBJUK5Z5kO8pJL89DE5rBuy/Ut0TAKYjCQoqfD1pqPAdlP5PH4F9LH3EmQV91WIISlJuUmI8xsfCv1yWJ7rTQWYbvPGne0WnVhcRDh2aZfdB81OcfsPHI/Bof4Cn9nZHcydsNQYJeoWAj1sj/VhE1ENRI2DjzVpufoMBLE4XIdZrN1mr3r7u4iouyZDQlxrI6BOi/z3EeEvZz4UaQkJodtpE20fxQigmUmqOzSrC54BWhwFqEcyUvr6uEnOIF7gT2T5ft5HxdfBm1Qz37dK9SSfRDw/6k4tjMDqqkXCz+ZoO/irLbSONI84bwZ6A9fgzFojSWx9pnF2WVTG+GVMEx9mxHLiudbLvMzLOkYgy5sLgF8hqaJJgk0UhXdvEsROm4l5ceB
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(478600001)(6666004)(40480700001)(41300700001)(2906002)(82310400005)(8676002)(36756003)(54906003)(110136005)(4326008)(31696002)(70206006)(53546011)(70586007)(26005)(316002)(31686004)(7636003)(83380400001)(2616005)(356005)(82740400003)(5660300002)(9786002)(44832011)(7416002)(8936002)(40460700003)(186003)(336012)(426003)(47076005)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 12:48:00.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0abc3c-580c-4568-be08-08da633b963f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7802
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 6/9/22 13:54, Mark Brown wrote:
> On Mon, Jun 06, 2022 at 04:56:06PM +0530, Amit Kumar Mahapatra wrote:
> 
>> ---
>>   drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++++++++----
>>   drivers/spi/spi.c              | 10 +++++++---
>>   include/linux/spi/spi.h        | 10 +++++++++-
>>   3 files changed, 42 insertions(+), 8 deletions(-)
> 
> Please split the core and driver support into separate patches, they are
> separate things.
> 
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -2082,6 +2082,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>   {
>>   	u32 value;
>>   	int rc;
>> +	u32 cs[SPI_CS_CNT_MAX];
>> +	u8 idx;
>>   
>>   	/* Mode (clock phase/polarity/etc.) */
>>   	if (of_property_read_bool(nc, "spi-cpha"))
> 
> This is changing the DT binding but doesn't have any updates to the
> binding document.  The binding code also doesn't validate that we don't
> have too many chip selects.

I would like to better understand your request here in connection to change in 
the binding code for validation.
What exactly do you want to validate?
That child reg property is not bigger than num-cs in controller node?

Adding also Krzysztof because I was talking to him over IRC about this.

Thanks,
Michal
