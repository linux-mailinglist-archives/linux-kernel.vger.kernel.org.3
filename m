Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80D5B1239
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIHBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIHBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:55:43 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDB53000
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSnTPbqAumrsYtkpR/kPgySTzqGYYsN7GlKG1bxPT3rvqL/5Ek1EHk6qzebL+O0z3Ok8zNp0qTE2wex3FxqYPaaMAExMY5/G8Ah/xG7hpEGUIa8ss0Lx+wDHOS0EqzUyrR9P7r6tufMOZI2HUo6xy6KtZOSuef4aFQzpDb8HRN2oBvID2T7XIxRK/zUDaZ6Eela/oCjUiiwmrxVplyWrQRteeKKLBjTRPIcphBLkNk6prNyHah+kjDMN3Uqur8c9VrIFy+DkwdvuoYUIs5Hg338nsV3gIbcgo6w0YCmg6ZPBkoieU4vlO7ExE6ZAmYUmxkSNRSUx4I0ICyiDxJiDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq/bpeg8tDWKR+NcspZOy+u7n2WvOpQMEGj1oAkqrO4=;
 b=kkDZt1QmTD7fpRarZenXoOlEjnUNUziuDdFXZhGe0LdpcdykQykPM3RAb/OWq1ic2+dw2TGRtlzRJOjGyQQcyTL0w3pIhxjxs2aFn/GC76Awv/yinAlrJjBM5+MqbsUOcAxi3S+DCHxUO/rPwd55q8kl64UtG6dAf1CRC3VHbSwH78rJ8DJvemVNiGN7Lx9CfbogDFYBF+7IIUWnhQ0oHegcDRC2SqplETEptApR43zThM3rD2cDFFVtJNNqO6p2TYq54EWzl2MNmlxdh2jmnb2m/idbYnuqI3wTvmn/eIW6nIfHxNvZcINYMsdVZH2cjjKrisjCo5QOrP8IWYxBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq/bpeg8tDWKR+NcspZOy+u7n2WvOpQMEGj1oAkqrO4=;
 b=P8GkI94X//sIWvYqaa6Rv3vOLtryQhD0PgsIqyj7dJTAKFF73qrYK9A0Y96z/lv8N4djgsp1y9mm5ZfFbBcyvOM1RwyOlvawQYw9Hk1fBJfBg0bwJ8+h/D1Pn8uwtZaZSGKPZFgbUpMcbzZLgs5Jo3/lL/QFmnQS8Ajmj/jq7OUG0H7sXYs2AfGu3l7npQOA8HaZ+QD2IZD420fnzEFKPtVBsSuCR3jlwJjUG2xMSE2mGcYX/GH9uV/8h2zeejzDwQckQNnbbYREi6tfwzJuEjEBj9YtsOJELTTj0lg2MdP3zu0GrDcuEVnBD1kfvECjrsleS1Ec5nhwLSVWy08QlQ==
Received: from MW4PR03CA0220.namprd03.prod.outlook.com (2603:10b6:303:b9::15)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 01:55:38 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::50) by MW4PR03CA0220.outlook.office365.com
 (2603:10b6:303:b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.13 via Frontend
 Transport; Thu, 8 Sep 2022 01:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 01:55:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 01:55:37 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 18:55:36 -0700
Message-ID: <afa4392a-01e1-5daf-4cdb-e92d708b85e1@nvidia.com>
Date:   Wed, 7 Sep 2022 18:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: avoid unnecessary page table walk for
 __get_user_pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chen Wandun <chenwandun@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
References: <20220906024401.133336-1-chenwandun@huawei.com>
 <20220907163408.f9a9152314d33afc74cb1f0c@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220907163408.f9a9152314d33afc74cb1f0c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a30307-5ef6-435f-7541-08da913d3a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H959C0hlGbEjKzt3LpNngy8oVyvEQ4wQIDN6kxGOe4aCvDfRc2tkwIiAJ/PiWhmT927r9EMexOJ/DTsOalhjmnfnzzVeEqKvMhpyxv6UfUFFGcYO+/uXKaMgrAR9SOFlE0KKfrD6U6ie/XZ5BV4HWIiqhg6fNrVraaTJpIOvAR7loccDAzkFuwabz60WjhuXeQjBUmQYQJGwB0goWMVrN8j7rE/NfiQcr01zQqS6HU7lKZm9ZXqlNQEX+/dU2XiH2rNs1x/TY+IHcLUMM9JobdiaqKN3FjIzeTZm8idfBTTiVEYaKWlCXUpYGsKOUO9o7gS6ndPmMoy8DZRtmx0Anc7+P2PCmNXK5nXADGgumfwSgFUtzXuXXlQufDFhLSXkTESm3KM7gePN52JA/YCeHjYknDwDstnwsoPsV1nty2AAa+AO/yOTI/MtrkFk9k95VLqx1jLlLQxKoPEyDZkC818PJWeXiUuWg/pY9ygnDE6Qcxj/6ikuh52KRSXF9+e+sOX8Z4A9VDM0G1dxqhGGH0urntZ6d2rqoh5erCTDdRhNbubEeabat2Imhij9woUtM2HeMaog4bpIhhzbBSN+M/NqEUZR14mF9CIFF6x14nxlS8JfRbJp/0eYa4ZR0uW4tpUIyPnb5VO8oI1cHfytBTYwtIL79loQ14jan8eG5EuBM+opdSsWdHZzfq3Q2UwbmgnHDIs5gMuYw6YNj9oF6kx5tNQNGGgIOC0+Yql23WSIsaHs1pT6uu8U2pQy3FrlVwl3fPE6N2VE677C+7V383osP8ojEpjBkS4x/PW1BuFnYy2lw0Dthuq1bM1ijn+udkVwEBM1EJ0w+b3V07HcPA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(31696002)(110136005)(26005)(86362001)(426003)(83380400001)(16526019)(356005)(186003)(336012)(47076005)(36860700001)(82740400003)(81166007)(2616005)(40460700003)(54906003)(82310400005)(2906002)(8936002)(40480700001)(31686004)(70206006)(4326008)(8676002)(36756003)(5660300002)(41300700001)(6666004)(16576012)(53546011)(316002)(70586007)(478600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 01:55:38.1678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a30307-5ef6-435f-7541-08da913d3a3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 16:34, Andrew Morton wrote:
> On Tue, 6 Sep 2022 10:44:01 +0800 Chen Wandun <chenwandun@huawei.com> wrote:
> 
>> It is no need to walk page table and find pages if faultin_page success
>> and __get_user_pages does't care pages at all, so directly handle next
>> page.
>>
>> ...
>>
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1198,7 +1198,10 @@ static long __get_user_pages(struct mm_struct *mm,
>>   					   PTR_ERR(page) == -EMLINK, locked);
>>   			switch (ret) {
>>   			case 0:
>> -				goto retry;
>> +				if (pages)
>> +					goto retry;
>> +				else
>> +					goto next_page;

Wow, good point. And it's been doing that for a *long* time!

>>   			case -EBUSY:
>>   			case -EAGAIN:
>>   				ret = 0;
> 
> Looks right to me.  I redid the changelog somewhat:
> 
> : There is no need to walk page tables and find pages if faultin_page)_
> : succeeds and __get_user_pages)_ doesn't care about populating the pages[]
> : array.  So directly go on to handle the next page.
> 
> 

With that re-worded commit description, please feel to add

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

