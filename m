Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EB50A0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384057AbiDUN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359745AbiDUN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA836E35;
        Thu, 21 Apr 2022 06:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krAgmGB6tS/ACII5aRc8GvW1sTPNtyXGuJ4bUvONV3a5z26lXbEVGIWWMwhHOegVW3ljAMvZ5Xc3syIDxmtVukEfGO7JKmx/e5Y3YaabXnb0xy4jJgaylPeBvDlbqPrawuz8TKk0+l5lHJg9DlmOlZoG35BRpTg51EULyim5ic0ZK5KMKyNvyq07XzIXQAWwg+7H9emwMq7gI/WMfSSOHigvK3ktOGsEV/HsLeC6qg9L4uhu0wIeJY5F0dMrDeJLP47oAV8ftVaxvI2eJKMo23CgGblVKbEeXAVrdjFSvltwfGpDReX/ByJzYshnHrM8mM6z/3wMRB/55EXuRx/OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR1b/YDdHaKOPhHtPSe2DrRiZ8Y1XuiVNuHYr/kE2P8=;
 b=hfGVm+18dBy7oj3TBRNXdWK7H4/gE30XK9gA9kEZOBi1ows/gu3AItBlZaFqr2+IphwPkVEvQpE99QRXrxB5i/qo9yhIbUe3Vmdcujm5c4KghclED7GwajGkfXe+JZ/JQbdZBCEWsPMPa2t7K7stjuqLbj+OuVwuhWtW3MWY/nu2cwtBYERf0j8zHkgJz7EA3P4mQ01T9wGs90tTYvUPB+xCbVE0LirqPJKhWWpdfDvE06pEszNmSvKMZJ6JucxNB/2usSgyRRhFKZ7eRvzL1m0QsR3KFF9eMb86AyhCjJp9tP3pfTLVwWkWuUIoSL/EBYH7YcbQ4W+/KQIu+XFhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR1b/YDdHaKOPhHtPSe2DrRiZ8Y1XuiVNuHYr/kE2P8=;
 b=mK2UQOeoOI1RmY6vlfSN/XrXKeG1rm8beWc0tZDKu6a0wOWHdi/MzJ/hrjvkzAlo0hz0cdb3Bc8M+GGeDq55b4gge1jMMs85tECWTu7O3rGYBX+HWHtJBBfmxvRX871I4voNC7PJY8kPXZ2cNtqCkpqf4dwaqvbONzM/NuTpg+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Thu, 21 Apr 2022 13:26:41 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::e4fe:e7c1:736c:d792]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::e4fe:e7c1:736c:d792%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 13:26:41 +0000
Message-ID: <bcc2850f-f74b-1e5f-84d0-e860ffe6876e@amd.com>
Date:   Thu, 21 Apr 2022 08:26:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] crypto: ccp - Fix the INIT_EX data file open failure
Content-Language: en-US
To:     Jacky Li <jackyli@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414162325.1830014-1-jackyli@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220414162325.1830014-1-jackyli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:806:d0::16) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06c43dd-62df-4a16-9e18-08da239a927b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1596A53C2AE0A5F117BA3920ECF49@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zw3tsiSzjIwE1PDtV+Y4K60pmeKSiuJRkJEPECM0g5K1xQu1hffrvynfvX+1IsfIS1oIYtJbev/EK0j1evCvAHHek5Njkht0g6t06J++1nhDXRG5qTdm/swLbvgZsYz+iVqwBtao+toMZdMXVyIPcrv0sogVDPhCpdbkyZyEhOpuyRQB1XfeSBFzkt5XYcphmq5riECOsaCGYnaKrwWl4id+r+v0EknLOZJjizhg/IrWOuLaYEGlKuiPlu1zyGyYDVqAguP5qLKhB5oo3677kHq03UPc5RO1l6GEC3gsYvP5kRNL8CTfz9NGA84Adu1T5nWBkLy1pSsEXL7YLURgWqiB3orS4nxjcbYanMnEFuFd+SXn6HzHPyWFh5eRG/V2hqoGI+QZRhGYd/NOtpddJiZGBvzhtiGDs2BPt2N7AKBqAFg3n3gw4VZQYeMH/xacwopiurfS3CWNpZ4g67FNVx+KmzSkBSyDLKPOp8nf4wrXGTA4aWXcsfQ7NRBRK/85bP+VQzHm3AUF94sSHIK1WTVWeLUbX3epFIO3eX4SrIRa2heZuCONZ7isy3XEZByC7Aev3jfQu+monGVH8cPyUXSS7synXlXVnQmp5aMOdpdTYlh4tAPurf/z4nsyIPvywioTnjfgNE0pYssj2zWQikJ/4zfogSs7PhA3PDmifZ5cfmmottimLI9ofhqqgsVAzGgB0Lxo9+/Ab5dNPRj0LvqwhMAMbTXz3lz0Y1+kdpO5Xhdi5K7j9bEsL/A2MkN7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(26005)(508600001)(2616005)(2906002)(186003)(53546011)(31686004)(36756003)(5660300002)(6486002)(6506007)(8936002)(6512007)(316002)(66556008)(66946007)(8676002)(66476007)(110136005)(4326008)(38100700002)(86362001)(6636002)(54906003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlUUzhFa2QwcHc5ZnIvUW5raVpPWENmbmwyWjR4QVI5RUtYSXUxajJIeXlB?=
 =?utf-8?B?U1VJTWMrdFkrRHJVWC9aSGw4Y3NTRklBNUhLMFpybXJFMkNQVHU0RVhWekVL?=
 =?utf-8?B?MW5VeEsrZXIrWTE3bjVrMU1tR29tOS9QU05jYlMwd2NjYUgyZjR5eVUwblhD?=
 =?utf-8?B?Wm9KODdFVVYyV08rL3hQbkVkQU1RUzE5WG54cTB5WXhqb3Vqa2FSZ3pkRjRk?=
 =?utf-8?B?aFF3di90NW1ja2hLYlJPUHdzL21GZzkzNUF2cDIwalNLczlCR3FKdlRmS2lr?=
 =?utf-8?B?WGpISEdwOXpITWp2NW1QMlV2eGZJY3JHRHlUSWVnVkxqL3E1Q29aeXRQWHds?=
 =?utf-8?B?TklwVXI2NGVSaHhkWks1WFd5eGhqbWVOaXdvSDNYVW1jUFlHa2kvbmVmNDhp?=
 =?utf-8?B?YVdjWWtuM21XTzhpQXR0amRVb0pCQnVFdnhSS21hVkdTRzFqMmVwOCtXVTdO?=
 =?utf-8?B?UlBDTUxpOU5iaUkxdEdqY1o1RHVvaFRNWFRuc253b3dia1l6c05wbUFzYVNi?=
 =?utf-8?B?ZGZXTndmVXJGTHltd3c1UmM1SXZBRkNubWtmYS9qVWxFNDc5OFUwRGxPamlX?=
 =?utf-8?B?T3ZJc1IvamNjTituYzJXZEdSM2dtNGJjcnZILzhrNXN6UTlHME96MUVFYmtN?=
 =?utf-8?B?YmhxZHI2QnVMcVdidDlyY3pnQWg5akFNRkhra1diYUtPTTlwdkw3SkRvZVh6?=
 =?utf-8?B?cTZFQVdJano1MTczNnAxeFAydVhNQk9pYUJ4R0ltSFZNZHY0Zk5IQTI3Q2tm?=
 =?utf-8?B?Z2VTUS9pSVVmN2FTZ0xNNUE3Vk1lVTNvN3VsZ29qZ2pWdkxoamd0SHpPaWo1?=
 =?utf-8?B?OHE0ZmZab3FFRE1HWHBrWEpmK0JFRTVvb21MZGo2blJUQ3lia1pqajN3ZzdW?=
 =?utf-8?B?S24xd1dhZk5VcHJYWW1GcGRzMURvUHlXN1JVTTlCWStkQ21XOXBudUN0ekQz?=
 =?utf-8?B?OWpKQ20ranV0TUFaalpHUy9SUC9KbTZ3OUoxc3ZpOXN5TVNFTHlmd2NPdm9K?=
 =?utf-8?B?a2ZZR3JzQzJ0RlIyYjFYSW5MQ3I5QWIrWlNXbUtjOG9oMU41QWJJbE1Ld1p6?=
 =?utf-8?B?cXIxU3N3cXQrUU1qSSsvWXlzUzFDU1BUMFI1TG1MOEl2TytvTXNrYU5vamhr?=
 =?utf-8?B?RnlRYllJd0JxQXRFczBSWFJBTkljczNQd2ZEWW5UVkhtMmR6MlZuS09yamJh?=
 =?utf-8?B?VDMzQ0Y5QStFNkZabjc1SWZGeC9IMXR0eUJtazY4RlJ6T3VwV1NJK1crVTFR?=
 =?utf-8?B?dVM0dDI3akorT1dGdHVDVFVLcXFiekZRQnFJTCtpcGNYMUR1d2FpZ1lGQlpw?=
 =?utf-8?B?YjArdUgrVHN2NGN4SnIzdDdETTQvUVh4clBYRjFudjd0QmV3c3hLdStxTGpi?=
 =?utf-8?B?VElHTzZQVUZ1N1lIL05BeHRBUlNsVXNjdC9jeElDTndhSVdNUVNpejNJZVBh?=
 =?utf-8?B?eUFrZi9xMUJMb3EySFdScTBsdWM1UmdNUitVcWt6aTFENU44RXNXTzdJeVFK?=
 =?utf-8?B?dkxxVmlnSGZIUEhodkh1Z1p3NDRFb3JoY0x1cVNTOE4yYk5lUlpWazRYVFJk?=
 =?utf-8?B?bC9vUkl0cXBaK2FnN0lVS1g1cWFFazY1NUdYaVRxOGw2Ui9EMEE1bk4xQSti?=
 =?utf-8?B?YlRNQ1oweUI2eHNhczUyQi9zOHNwd0FicmRCY00vQXpLU3dOcTIvUzd2RG92?=
 =?utf-8?B?NVB5QkxJLzJWaW1CUThianpBSnpQZFBoVUh0UUlZVmdobHc2SmtPSkEwSi82?=
 =?utf-8?B?TkJxWmZtbXJwYUp3aGNtVkZVVHJpemZqa3JMMDdsejlHRis5YmlsR0hLckNn?=
 =?utf-8?B?eUNuVXVNUFJCQXRUVmpuRmsyUHRSNFNOcFZPTkpyUkZtSjBhQ3MxN3ovK2NO?=
 =?utf-8?B?aTVXeHJxQTJFZlMzaDIyTkZHanJaZHNUWnlMekdRb0xDZm11QmFuaEk4cFlt?=
 =?utf-8?B?dmVJRlRIeko0aGpVZUYrUjUyZnA1VXNvUTk3Wk1NelorOXNJSzdaL3hUYlZs?=
 =?utf-8?B?SmVjckpHbWI5QS85YW5XUnB6clBZdE9VRm9iVWdQRmgza1dJb1VKMnh5UXkv?=
 =?utf-8?B?Z05EaVVlQTFUclkreklCWnZyRUF3bzdKYWQzSWw2dlIrbzRDMGZ6Mlhqb0Za?=
 =?utf-8?B?NGtjRFJBRkFKRjV2SkJZK2xaekl1ZW5VZGVhZktaRzBDRjVQVGFJbTAwQ0dG?=
 =?utf-8?B?YituRThITUJuYzRrWndOQ21xOGxHampyTGdQeVpFQi80VWNWWFJKcFhjM0VP?=
 =?utf-8?B?N2IydmpjTU14djEyOUYvc2dYc2RZOFZNTEQyMStkQkZiRUM5K085b2R6Y1NY?=
 =?utf-8?B?WFFFMXZTZTNYYXZ3Z1p5OVNmam9QS1hrd1dHdGR0UkVpK1E5cVVpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06c43dd-62df-4a16-9e18-08da239a927b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 13:26:41.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7gGVmL+qcjgl3avRmslvvSLuz3p9YmdOsVDBjqdmXWeNiPwoU1VOOBdEaZ9jCSrUzh3IdqPZE30sdL6BlBAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 11:23, Jacky Li wrote:
> There are 2 common cases when INIT_EX data file might not be
> opened successfully and fail the sev initialization:
> 
> 1. In user namespaces, normal user tasks (e.g. VMM) can change their
>     current->fs->root to point to arbitrary directories. While
>     init_ex_path is provided as a module param related to root file
>     system. Solution: use the root directory of init_task to avoid
>     accessing the wrong file.
> 
> 2. Normal user tasks (e.g. VMM) don't have the privilege to access
>     the INIT_EX data file. Solution: open the file as root and
>     restore permissions immediately.
> 
> Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> Signed-off-by: Jacky Li <jackyli@google.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> Changelog since v1:
> - Added Fixes tag and Reviewed-By tag.
> 
>   drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++++++++++++++--
>   1 file changed, 28 insertions(+), 2 deletions(-)
> 
