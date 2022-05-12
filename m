Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F252418F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349685AbiELAei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbiELAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:34:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C3B227837
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjJWH+6UMfScaSCrlF3qpCHNPneD/kTzHrjjtptdS4luX/vpycQGVhtswObqd9gnZsyKPYq1+m6IoyyIysImmNV291J51Mz3FXE8mlWowAHzj4w5Iy70eiz3EY4mdzc2JqrY2Z6+xGvK/fOEsAClUAUpUvC9y5pesDYZcwBGbRfaFnVJyN0xh1e7QHQREwPMmLeRhsVOFGb6bWtitgzKtJk3F9lU+ZczCAFlaKVGlQM0dvNFt6RM3BBAz033FGDtiLU+y0ec7ZlSJbzeDViMGMAcG6gVwLqKnLC6gVSDgpTJFjjUJ69SBiIixpVOR7WHiyMaqE99hi/doDtTvNY1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAhz2tqGsUSOfUTLpoM+oqHOFlt4m3drnvMf9Byqy04=;
 b=MdV7IpyAf0EG6kejG48KQ25OmTyHmGIc6bTeROFjCP522z8lWIDFQ2eJ7HlVpN6rOvFC56GwC+BZRQuRD1bAqpMFIyZ+iOxFTt3ONu3etDhQAst9zCNUbisdmll/I9U/ACj+ChyO/MWBMzFCurvhw01itiGBZF04aXpeQAsgMDJzYPhubvpiPZ50X2vYPfhZNnD0NpDo7vKb/E/WFt8UkIvn4hVY/miOwmZPI3Nyzt9sWbgknittyX5PRP4FAVlvya3EQvmY3+XPfJE93fgNFb32fXAyQmwOUv4tOEPBqefWzFFXRx3H7d7SpjZaztBfvRSYz/NBcvEumMAkuCM6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAhz2tqGsUSOfUTLpoM+oqHOFlt4m3drnvMf9Byqy04=;
 b=X9gtLlIvRbIWdoB0BfeyXTgskDIKuVP039bTpsUwIyoqCNoeS5sgEsvhSPskfYoa00pJh8+3oHCY0ltteVuLhtwxlR8+gOFD+uT05YlfN19NcNmRAl6Jc4DszhcgqLmDKzWjeRZGj+WoB0fzt8JpuZ3K2zTxJxMr9E/G+W3mjGeey0WhbKkM6WsJf59IAABxF642DAl3+GOZynE4Bcy+Yzw58oalOYNnrJAVLMipmlQj4a3VOmnUnlwUo/QpXq8Q1/vfgXMuKMgOCZOrTeXpHsN3bLEq87h/IPzJ97GujWNMeT6jhsF44LlEXKbQnqnRmhNpXFdpHxHMCY7pgrcq/w==
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by BY5PR12MB5511.namprd12.prod.outlook.com (2603:10b6:a03:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 00:34:32 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::80) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 00:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 00:34:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 00:34:23 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 17:34:22 -0700
Message-ID: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
Date:   Wed, 11 May 2022 17:34:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnxUTxnCJ6EsmjEi@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71fb31b7-8743-4e34-49e3-08da33af2e57
X-MS-TrafficTypeDiagnostic: BY5PR12MB5511:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5511C3C2C688BAF7827C3701A8CB9@BY5PR12MB5511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWyCEXxq//vw6Z0WAZq5zTMkowkCnRzZRHii0DMKMalCNaqZ4Pk1bJKtkoT70DM7CKUaXleNZoB+MoJckw+pv8KVJ0sFELz/vN+ZOkZsRNN8Iz/pjBJkhW+tTMIwPev60QYo5poPJ26tLKuGEIlEL0ylVKi+T7BNfkSKfzRBMbi0KbEvz5x2t2ShmGV4DFCU/lUjLpG0buxvieGcXHzRwe290KDYTetz6bvYhspusSO0R1Tx74LehiC8PGRPaVYm7ci1qaDfdI709UHio3pMp44dTDYm8h1pu6yTnQFiyuufjR7e1XlIugXFb4hsGiqL0648ulczUF3p+pY2bQt3+qio9ewtMIO3lGIjH9MDwQ5/lFYiTyDv0W7LHVjP/ltC08vnjBOcTZ8bFh62CDJtGGu7DcFDgQ4fAoRk8NZylPjP6zTHOC7btQRqOeM/vwzA3IDPvlApjkBEwE3jscRtKS/oTGrBV9YCL9JpDPQGRL5bYdanrZODXiKFQgGZgA/HjrSYIle/T1NY+WMwrbbyCGROVwbNorqfF8Xi9JRQG/dcEolVWUjU6H638+/z6DID8CrLTP9Qkilu/C/aHl52CJkIn8EYG2mlmn3izUVWopcZlCTlLa9Zbxvu+0M7EcJ6Pmg9tD7WswIzoqDF24wKdttpUQjGuNZxpUYLt/wscGxHLXEISlK1jRNASzHcxZ7ahLS1tdjYSJJNmhFBOStr4WyRmnzyLQKhy+3BdR/2atz32DA7t/azt4HdSrWA/Yg5
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(40460700003)(16576012)(2616005)(16526019)(83380400001)(186003)(8936002)(54906003)(86362001)(356005)(508600001)(336012)(53546011)(26005)(6666004)(426003)(81166007)(47076005)(316002)(2906002)(36756003)(82310400005)(36860700001)(70206006)(8676002)(70586007)(4326008)(31686004)(5660300002)(31696002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 00:34:31.4393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb31b7-8743-4e34-49e3-08da33af2e57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5511
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 17:26, Minchan Kim wrote:
>>> Let me try to say this more clearly: I don't think that the following
>>> __READ_ONCE() statement can actually help anything, given that
>>> get_pageblock_migratetype() is non-inlined:
>>>
>>> +	int __mt = get_pageblock_migratetype(page);
>>> +	int mt = __READ_ONCE(__mt);
>>> +
>>> +	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
>>> +		return false;
>>>
>>>
>>> Am I missing anything here?
>>
>> In the absence of future aggression from link-time optimizations (LTO),
>> you are missing nothing.
> 
> A thing I want to note is Android kernel uses LTO full mode.

Thanks Paul for explaining the state of things.

Minchan, how about something like very close to your original draft,
then, but with a little note, and the "&" as well:

int __mt = get_pageblock_migratetype(page);

/*
  * Defend against future compiler LTO features, or code refactoring
  * that inlines the above function, by forcing a single read. Because, this
  * routine races with set_pageblock_migratetype(), and we want to avoid
  * reading zero, when actually one or the other flags was set.
  */
int mt = __READ_ONCE(__mt);

if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
     return false;


...which should make everyone comfortable and protected from the
future sins of the compiler and linker teams? :)


thanks,
-- 
John Hubbard
NVIDIA
