Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3915241D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbiELBHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiELBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:07:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1D24096
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq95eZ56fL7to2lWWkq2M/nkkehXvWZRCUJAbDd2N42NUbOQzhqOBDbVSv1c+Og/oEOyD6gVJ8qcVS4rK3ZEbBMocliUuHzdXGV/UkDbSkX40i3mU9VKFh7JzUZKtno9Dk9TUgRbGGErkE1C6S2404ICaUjJ+brzFo9A3YtOHxvDh+TuI8VJnRXZ+9TDkluP5axHIKOtb+dbyzt7QOed+Yhb6zpaQxMNoXMq3nx1I8yWQerx8hIq9p06hheWBMg/ZeWRyyg39xx9lr5yxSG+fA6RnEh9BT6WjnaxxeM1n8T5aEGBcb8du8zs9cdddrQlOByNFvTMVU1NU854YSIgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt8TuhWViULvk2OoFSHG1PSSeIIuK3dX5A+ATA1I0cc=;
 b=cuh0ps+JMcsZiYQzq1tZZQgrwFHapd3x9cBiaTsmS5rafN4xQK+v7lPXBlq5DmAsIaj4lL67NT9RQg7vaL8Z77At5SdfU5ffxBaupE8kzzTDPtU/cwoBIFzBZ2BNZIMlscRL9oh+g3WHBNoVPHbUHa/kl5LcKOXTjXPR/lPBiRjNBXzdeaHuh+HcE/YMufCUeDXO0Uxb6QDNqYRulIGlP0FOkTeYsSObeS4vMrFWEgLJKEmAq8oXkHMYneqQ6GXQe4GOvM6x5UpxyLegPxUl12w4qFZn03BplHqjoZGRXrhCMO0IW7TYk5QwwoEenTe5wWj1sl6c+EPGlPjW73pE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt8TuhWViULvk2OoFSHG1PSSeIIuK3dX5A+ATA1I0cc=;
 b=IkmLzJG42P1oqvB0yOrJFdZSfLgcRa2jePq5QoPO3oEjugyeXIUFceTjapzT0JVaWVuBmYzzx5IoBlO6v53m2x58keaa4+ADhxbogKREzMAv0v3VyOjtdpoA5WDTsgPcmxkjc2NNu/0zVAP1kVwgqu16+GVI11D5hZ2gni5QjF2uK8lPuu+0kI0OPZUbgry43YS2lQEzlwIbvicvLQ/Z45UgyPWkDF2uh1kwp9OD9TU09teYBB8Uy9Bn+gEOxrtHkxwApCCipKQgWlUgv5axpT3H0u//7zjW3RXd2I0M17xbcbAKGMhqLPzec3qCoPGIChcg5ezetUQICWxJgBfXbQ==
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 01:07:33 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::4c) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 01:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 01:07:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 01:07:33 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 18:07:32 -0700
Message-ID: <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
Date:   Wed, 11 May 2022 18:08:02 -0700
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
References: <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnxczoehQJ+x6m9Y@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b04ba5-8fd8-4281-1a39-08da33b3cbc1
X-MS-TrafficTypeDiagnostic: DM4PR12MB6661:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB666191C1F45328171629A8EFA8CB9@DM4PR12MB6661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjFwwgxDjaURPzeS6NH0cfoRYZlou7QnW27rzduRWsiIGNcvcnURgnr9PPBVwpqq7eJ/xXuBSDjuhj+TYYsOTNQxkNCZM9gIQG4TWYMmtNnvqhPj1TfcuKBNNsGNijiNqN5sCGBGxZ1D+14WUoNvr4QIRTP8g7/Zzbll1a9zPNMij4v36hZ7hOAZPdj7rY1/ICvwmlCjr/wD1uaH9PbEWnL2RNlQdC99lRHXQcdbfUe1/Aaa+B5CVAlVQgPFrJB4m4M83AYbsXWV0Ss9vddSDQ3migUKGbim165hn5a6v3sUXeJSQdcjSeIWwAH7lg4lVv9iHnu8vShJN1gyiqC/TCBWVmlYPThkH+gIvyBQAiaT/pq4OSE/Oqcdgmm2Mmfy0W6c9vyRI/8unokpkuHlTxE9iXHqIRWXSAFdat52JeWIQTdysUPNrpo0eXwGe2oOAM8NpB/E+9aDfzVW+cefuHTZNCmfwOobrdccW3y4cwAYilza5mE0kOISlV/2jEj3oxPBC8wENs0mcfpETFbtsVgwpjrUfqbUm/IczEhncrooho3xFS8xAEMm0mtipyTgT7hyaDPMYGjeGaiWXHmQaCeKPNtHUivHtNvzYnFyf+vXDOnyd/fuM2EVRhFyqpOuc7A7JGVmd1FgzigNbi96rV3kvHOpo9zYZvnqAJ8YXAyVoUGuH5fQhMRr9S8mfUzIZSEk6hdZQFm0z69LMZfizKk8jHGf4LvevjKS4BCQ1TZC4Jy7rMXq/Z8ntYJCGz93
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(36860700001)(2616005)(16576012)(316002)(2906002)(53546011)(54906003)(508600001)(26005)(40460700003)(81166007)(110136005)(82310400005)(426003)(83380400001)(336012)(5660300002)(47076005)(36756003)(4744005)(8936002)(31686004)(70586007)(16526019)(70206006)(8676002)(86362001)(356005)(31696002)(4326008)(186003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 01:07:33.6001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b04ba5-8fd8-4281-1a39-08da33b3cbc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

On 5/11/22 18:03, Minchan Kim wrote:
>>
>> Or there might be some code path that really hates a READ_ONCE() in
>> that place.
> 
> My worry about chaning __get_pfnblock_flags_mask is it's called
> multiple hot places in mm codes so I didn't want to add overhead
> to them.

...unless it really does generate the same code as is already there,
right? Let me check that real quick.

thanks,
-- 
John Hubbard
NVIDIA
