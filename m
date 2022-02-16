Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4B4B8C02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiBPPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:05:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiBPPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:05:23 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7027AA0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC8SI5OwqWNLrJ1cdTUeAVCqWszj5g4HoxrkDKxw+vLak/V1LG5/oJXNIMxTDU59c/5gShYlNKWFJh4n09+Ftf/1J/IB/NyovXv/3qvOhMqkl3fCefZxAwGMHItQrgPmDJK5IeNYQOYmzJaREaGe+UutsSSU/fVsFWhbsZ3y+jik9AtKYa8+144ZWBJq0Uwiqjpu57r5H9FjA5kq1yEcDCaoPGW0jfVYTuzIofZ14Q5NksVbI4pnLKlOlfTz40AoYGMbmuww4ls+NqdEp0L9OgxuNMgEOZPZmRVgW+5SsoGOL9ugo1+ctYGtDQ5Owo6ajNv/NLmdKgFVhFIOTfPMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3JL7iFN1rHny9RnHp/km1zNI0hJcF2mDvOBlJlI+us=;
 b=iXdaxT12lBIcRAUkSk4puhuZZ8rftPWckAAYvOeUAZ3Qebk9Mqqwb6m+TGlagUaA8+1aVgKi6+VOsI77o2qE6y6kx/B73FnLHtNR881kkS4JZKJ5eon+3IE2GDag+1J+irjbt+eSw289kX32hhVAQ/sZn5sQxXecNG9wX/BaG/f7ajSu5Soiy4jVytRfZXOsqheJTVuPF1c3pv1YLzb+tfIEolPpVjoMBmsinjEYfzgpm1Gm37hG9fEdTfCSxjExELOZ8ePASrlTov78cMOlh4AnTcjMoC/J0SGL8LuKW95EUm0EBJ1D5GsM8+PgrbjoBsOiq6DMu19229J9WhduXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3JL7iFN1rHny9RnHp/km1zNI0hJcF2mDvOBlJlI+us=;
 b=PDeTfFqTc4IwIhZbAjV5yzgbitFqoiI2lDBLDvill6XPscTCgJdIr5jdqXTyJUqy4fmz/3X6jhXqN5W5IM/9Gz1QJBm956+GjuqPPXuiBhxlXdDNSUEeuSt5Qk/R+rPebwcX4s5auXUpu/IBTiLY66LHoouxM7GUXwGFcFicIrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 15:05:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6146:8d09:4503:cb49%3]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 15:05:09 +0000
Message-ID: <9fb62811-799a-0df8-2f5e-b6b6990d26e3@amd.com>
Date:   Wed, 16 Feb 2022 09:05:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] x86/cpu: clear SME feature flag when not in use
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220216034446.2430634-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220216034446.2430634-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:610:b1::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e11218c-e409-4731-84f3-08d9f15db92f
X-MS-TrafficTypeDiagnostic: MN0PR12MB5883:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB58831022CA90B7A4D54AA95EEC359@MN0PR12MB5883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/3j/XAdhx9OOUvik77DRTKqN+Vh80p0vGPLZbQ8Fegx9pQZE8M58WFmaL7YoLgrAI/Lc6d3Pj1ZNCVA32Ky7ZwHXGYb2Kz8Y+ZwEEEdiIEeoN8jZpcLpFoqq/SMLWDb47sRALmk1o3jjI4+NQCYIN9ExW9oeILEYwaJHgZmq26BZwnmDAP2AgYtbqbXtsl2dQvG9LV4/kRPQ65agkRk1h3oXWHbq5eRN9zB6/sQrUe3SEStnWcEaOoejJhJun9wZg+Op/eV796+VOYcYp/ZIhh2t/UEb99qW7w3PGKXwZ1A0gvQ9mCj/Q3+B3ru5gz5gFCRPoUkh7CQRNGE2dxuXSfhcrbBiepb0CErIvyg366O0OT5TrFMGPJ49gNVxKOZ/o/+VcZAs1Qw2EPwZnwsLtHrxPfv5K/4kUA48pHS1lqg2kbfwOwpATGIj1cQHePLwaK3hPx/lxGTIwLRwYfCRB2wtFN7NPqlaC5ddB7NB4N9S/lrHm2FUqgFvQ3FirjnebdsipgM3kk4Z9M9xwL0RN0Q+pJN7y/HmdQOLasV8ert84X4V4x2dC8zpj8/02UITF9kjbvuKbi1db1XlD5m5y/1qjQeEPIiATtzUr/20gDmy7EeoIiB93aBHWG6D/hgu8H3s3L69IXxvDxrnT58hS7VrC9AUoTay7jwETNzS536qEivhqo4KSRRG24MZgiYW48oOelxmgiZkKxSU9FjPXSqoDSKGSKum3BD+ZxBfpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31696002)(86362001)(4744005)(508600001)(26005)(186003)(53546011)(66476007)(66946007)(6512007)(4326008)(38100700002)(2906002)(6506007)(8676002)(8936002)(31686004)(316002)(54906003)(110136005)(2616005)(66556008)(83380400001)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktHNFR1cjBsdU81enZxYzdjekQvSWtKK2ZXWjdXSkF0SWhhcHZjR0xuZWc3?=
 =?utf-8?B?bjFWNnhuY0ZaZlA4L2gvRGJweitrOUdaa0lDTTFnOGR5VXlyOXY5cElsb2Vt?=
 =?utf-8?B?dGt1Z1hWYi9DdHJ6bjM1RldKV1pKVXQybTZLTEFmd0NkVG9Vd1EyT1JzZE1x?=
 =?utf-8?B?VDF4QTM5NkxEMGJEZnFkSmQ2VUlhaUd1VjNyTjVBN0dvY0NtazZyeGx3SDBa?=
 =?utf-8?B?RWI2QmNWUVNnRWg4dEh1OS9lb2kwUGhzeGJ5Qmd0Z2g5MGpnV3d4dTkzU0xl?=
 =?utf-8?B?ajBkVGQ5cEhoOGZtZFJmUVdxTlFHNmJPZmN3aUJldEhZZDF0N0tWenVBL1Ni?=
 =?utf-8?B?cG03d2czNTZ3NkViZFJpS0RRYXpWMWU3NzBCT1V4QkJocy9jakFXNjZ5NnZL?=
 =?utf-8?B?TlJ3bXQwUHJUaHkrMlZJd0laeFF2MG13V2QzdU84Z3o4eStWaTlVNHR4Ui95?=
 =?utf-8?B?ajFhbEdzR1g3ZDR2amM5eEc0eEswdWFLS3EzODVXT2VmZU9yamJaWXdUeE5s?=
 =?utf-8?B?TzYzU09xNHp5RFlvbnJNK25lMXhSOUpKKzZXTWcyeVVuVC8vNzZIRlpqSitC?=
 =?utf-8?B?T0NzQUZYY2lVSW5uakFNNUVEYkd4NUlITFMzcXNwZ0JTK3ZhK0duOU9ldURD?=
 =?utf-8?B?TlpVajFUaVF3cWYwbW5yM0hYM2krT0VUZjh0SlVwM2xLZWsrY1BQM051QXc0?=
 =?utf-8?B?RU82d1lnVEZJQVZ5V1RKMHkvcnlxMWF2bHV6aUFLZXluZVdkMVZtV25GN3dE?=
 =?utf-8?B?ajBqUWQ2bFIyRTJxZjNHZlZxSVZaRUYyUFp3V1Q1NWYzOXNDMU9TYXRyWnB2?=
 =?utf-8?B?S2JjS0lVNWJSWDZORzdScGJ0VmpUaXN2aDRHTkRadUMzWDJvb09aYkwrdFJ4?=
 =?utf-8?B?ZWE1d2djeW51WXZKLzJiMkZ2K1FBYzlQd2w5dXRWbml0R2lsNHkxa2F5ZVJG?=
 =?utf-8?B?cUs3WklsZWtpTjFib1VVa0hWbTRvczlXYXBwM1VtOFZjSExuOWRRN2pYVFhx?=
 =?utf-8?B?Q09OSWNtVys3eFllZXBkQktHaW9janRVYnNKbDJxNlo4M2g5bTZ4MFRoV01M?=
 =?utf-8?B?bnZtVkRiNEtnTWEwRFlRTkFYd3FPc2JVMFYyQlF0YXRWOEdpNkdSR1AvaXRW?=
 =?utf-8?B?MUFFUWR0cDBwVW5UMXVHR1JWeTlnaGlocFVOVUFuUlpzai9SRTlqdXRTSjFX?=
 =?utf-8?B?TTNKNnFwaWJUcm9Fd1Nzc0RBTFlRRzRjb3kxanNvVXFJb2tKZjZXRWJKaERh?=
 =?utf-8?B?czNGNTZ6R3ArZElBYlBzMUV6TTBMVDdURkNZQ1htNlkyNWZiNUlWUk1LR1BK?=
 =?utf-8?B?bFM0YUJnTTNadysyVnplbHlVOStaM1BDRGd1NFlRQjBya05mc0FxcUdsSDVT?=
 =?utf-8?B?TlJNb1UvSDllRzdYM0xEMTR4bEZ4NzVpWkZJdEdlSHhXdzVYM2xpN0hmSWdk?=
 =?utf-8?B?ZTkrMGZKTXlQU0lLSXdVRkNBaFI1RGU5THIwYkNkemFLNVIxVkduanFGUTlM?=
 =?utf-8?B?c2dydFpNTTdlalJGZm15eHVMalY3UldEb2lHQnRSRHhjcWpoRTI4WklNREw4?=
 =?utf-8?B?RFhQeWs1V1ZnOEhQbUd4UFRNNVIzbzZSdWpIbEY1d295eVZOTlBwMWxHRjQy?=
 =?utf-8?B?R0l6anlHakpjbllWditSai85bjFaOTBGbjdFR2VMamN4TWdSSVNEUGpBSEM4?=
 =?utf-8?B?Z0hpdnZUbjM3cFpLdmdPMVhZdXdsbHhnL3lpVVRmK3ZqaUVDMytVRWZGbFlU?=
 =?utf-8?B?UzlkTHZDNzVZTmdZYzVQSzhnT3NFMUdHZWltS0FLY2trWnIreTg3KzRwa2JK?=
 =?utf-8?B?Zzc1TElnV2N2ZC9pb09ZTnBmUzVsRXpldkJYR2M0WHFVZG9JZjdkWm9sSEdI?=
 =?utf-8?B?cVdHTTRmbXZFdG1GK0FyOHhCNE14YjlSM3htODBxU2hEbDlvamZ2ellPZjJQ?=
 =?utf-8?B?dVpQNTV3RURxUERmc3FvWHpIZ0RpMWhibXdnTG9yV1orNFZFamQyRC9qcGc4?=
 =?utf-8?B?ekliK0RQL1E4dzZIV0FxWUQvRENlaWhubXh3TWhVaUtrY3FyRmwzTC9Ya2to?=
 =?utf-8?B?QVdnb0dkMXRNU3ZJVEJnYmZnQlBKRStnZ010UTIvOG1EQnY1bUNtRy9mbHlx?=
 =?utf-8?B?aG9iSFU4Z2wzTjE0c2RES1liMVhLZE5xTTJwRk9iRWVLcTRhSjdCREZ5OHlM?=
 =?utf-8?Q?71OpEBYxegodU6tNWBsRIsY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e11218c-e409-4731-84f3-08d9f15db92f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:05:09.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdutObGN6xxghuGZLZfkUIEYGKq6+6Fj9Ackm/zIDX5InBCLIk0X8+FHzmguGa57h+OfNZUvTt8louTzr57FkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 21:44, Mario Limonciello wrote:
> Currently the SME CPU feature flag is reflective of whether the CPU
> supports the feature but not whether is has been activated by the
> kernel.
> 
> Change this around to clear the SME feature flag if the kernel is not
> using it so userspace can determine if it is available and in use
> from `/proc/cpuinfo`.
> 
> As the feature flag is cleared on systems where SME isn't active use
> CPUID 0x8000001f to confirm SME availability before calling
> `native_wbinvd`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
