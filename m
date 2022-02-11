Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EF4B2EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353270AbiBKUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:42:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiBKUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:42:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B444CF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+eypSu4qmYQ5ZAbgz9PNTHhV97oK4+UU/QOrNmfLFCKydSPhDI6oUCXLAHN2lmWnI94noLrW73iO2LUZ+rq6wX8WrWpyNBnQFAK+uXeJ4iocH2N/lI7bstredv1qYSZSmA6Brrmdwnf5H0/0k3YOvQ7ZXxmYRv9c7xXp6S4A02TjWg6D7E4F6/NVSro15l5A19jm5puGYPaTrkNL8yf29e7jiXv36IyxRiQqpXbglDEY9a4Go9bp6LLbmYE+ORSBU34LqWKs3XssJuJfrqMI8AqDakiPO1P62ZCB6DkSXO6eza6nHDtkUTtttBZk2W5dNiPUjvyAJYP2WukzEYYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou6F0D8IWVQqdApr90r3U5gWxk/P2RYjPy3nT4iAzh0=;
 b=jZlfaXia9zbOreAArpRt0zYZakUqh60hc2wyDN6Fu4fm1bSqIG87DlZrtNAbM8gDjAwl8cOoBgWEY22odsobfIhjHSILbDrJ3ivyzyGadEJ1peA5T2kEAghRAJq3/MA7tey7QYOBpYk2+s+xNa9O7vX2EJc8yZYoQEgWgUt6YJXdrT8qaJT6SO5BGEXI0IVNiyHsyv+ulN2t/23ag9zd1FIEBGvIwFiVqhuRx2ebK7kXDz6LFIB2hKxBZOJWejif7vdREIiHjon8xvaajNQoUtK7/OjORj+NqAblFtXGSCW4Cy5w1NfDXcUVyQhOGuWrmBFunGUjK2ra4fVoz/PRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou6F0D8IWVQqdApr90r3U5gWxk/P2RYjPy3nT4iAzh0=;
 b=H6slFqH8AmtjU/oDnZToiO4IZNFLF4uC79QTMPt0Xs6oR9WY4pxS30nZkC8Chtmp3RWyqn/0y5ElOHL1OAAX/uZ1uaXfVmpT2HvH9NRI8yTT6NoGzlWrZqoj6Cf4TL6C07Na9/l/iIxeiWoD7kNrh66bxoEHuIdxFH0ZnID7Kbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 20:42:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 20:42:21 +0000
Message-ID: <470a6b50-9af5-b098-da52-4e3470be8e8f@amd.com>
Date:   Fri, 11 Feb 2022 14:42:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in
 use
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <20220211053652.64655-2-mario.limonciello@amd.com>
 <4035f596-651c-c167-372b-ffb8ce1a0ac7@amd.com>
 <d705b64d-2866-e2bf-2323-dfe0cfe73da8@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d705b64d-2866-e2bf-2323-dfe0cfe73da8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399526a9-225b-4ef5-d12e-08d9ed9f00a3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2918B0B519CF6AE24E7417BEEC309@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbtKZQU3w/FwyXhtXHRDJ2DemLSO9+jrf70RRxM1XWpho2m06nK79v3bD7c8/MYzBbqYLh9xzl+eZD4/48rM47FRR1WbVujnB7exoM2vO8ESaljcytEmKwO7MY7cHQ4cIMr2t7KWyqzFUTNICANlKoNGdL9wYxZ3UlAsbuXR+Mnx91CAmBgUnmzIcG12aEdFbbRB1GvmDK92ufLm+Kxg+ISJsWZlwqlL94YK7rPFWWOEDKIca4hIod2VbjmobKEvmINb7Es7u/wb05QMseQtrDsDWod65/vVwjWcYHrj8QEB1Q0z9tcuWkE9dv5/3bEyFsqPifeWmd1WhrGhdNyvDo8YUrhz9n4k16M2xFuVcAnvDctC8ojaS0SaLRDk9bzJ25pqCXgN+ry9mWn+RaVB+a+TTPMMNBvLmveOvYadp0sorUakmaKtMU+YIjp22BSXtYUS7NCxZaHrt+brEafLAwqlTN5/YTJ3nRdypK8ltY3ACLwwjni1q+SaveecOaiyr4IRn3NZJ2rnTFar6kzqBh9xQQimWkfXAF/yeqG/VADiFg+6ziKZ44DvuGa98ch7rkG/hujAo71xhoEXggTLyZ0JfDI2IJN0B+IRe/rV7yyVNMILVbeueEMF04El98UJF9VxBhQM6JOLoKJRv/hwwPoCisQtuoiraI/bkxlqSq4VUwKvmFl8xlgZoForep0gid2Uiw2S8CY4NjlEjZPbi7oEwtPS9sPTt+WfGQWN7CWNMcA0r3Q518wP4pmz8aSH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(4326008)(6486002)(316002)(8936002)(110136005)(86362001)(8676002)(508600001)(66556008)(66946007)(31686004)(36756003)(31696002)(38100700002)(53546011)(5660300002)(26005)(2616005)(6512007)(54906003)(2906002)(6506007)(83380400001)(186003)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFVYmNKQ2hkSHBnMGZvUWNudXk2QU5EbDM1Vk9aK05pT0p2ZGp2VjBOUTBa?=
 =?utf-8?B?VEdhS3pUWXZNNmswT0pObEJOa2VNbzV2OGgrZmJXZE9IdFp6NWRmTHBnYm52?=
 =?utf-8?B?bWxSVm1mSGk3bkF0WEk3N1NwNEhDVGo0OG55ZFdVcmlTZlB4U2NVMUhoSlRn?=
 =?utf-8?B?bmNDa3dSSEErWEEzR3JGWFVZRHliKzFKV3FoZ0xyZTJJcVFtTmJxcFdrNUla?=
 =?utf-8?B?THpnaVFaVVE5d2hKQ2xOYUZGUktkcWpXM2hnd1RJbDVHeVZlazE0TElRNEJa?=
 =?utf-8?B?RDVkVERKQTBYZm5xTzlOd09qakpGS1pkQUVSTkVCSFkySFVsYmpmd1ZtNDhW?=
 =?utf-8?B?ZnQ1blVWWWF3OXIwZDVEaU9abnhYK09VTlpXWXdvM2RsTGtBVG9qME9QaTFh?=
 =?utf-8?B?NFJCbkZ0clRtblRvTFpaeCtwL0tqa3hHdkcvUG5zaHBYK0Q4aVd3SjVMVmdv?=
 =?utf-8?B?VnhZSzVsSVFjdjhiQU1ncDJsb2svOVlINFRPSkhtdUwxQzBCN0EyTkRvK0gv?=
 =?utf-8?B?eDRSYkk1SHNNYUJhM09USWdQVVo3UzhOOHZuSURuSndyelR6VG9JbGh1d3dm?=
 =?utf-8?B?Q2Z4TTZ2YXRKOGhpZGxrd1d2aHpYTnlkNTZRZWNYK0RCZFNmdXRLSnZZNDI1?=
 =?utf-8?B?N0pMb3F1STNVYWc0SUlyQlE5TSsyVTRNTXhBWGR3YktXQXUxL0t1NThSSVJK?=
 =?utf-8?B?NUNYM3lueDNSWFhHNlpnK1c5NnUrV0szWmhWaWF5Z0pMTTZ0QnRGOGdFeHh6?=
 =?utf-8?B?OGJ6bEc5NjcyWlBSQ0IzSzVoYk5ySUtuT3NnUmdyRzZIa3d3bDg5UEZCVmZY?=
 =?utf-8?B?elJjMjhxcWtuZndSblBDeFViMHpJSGl2TldMZ3d3ejBxOVFHY0U5VG1mTU9G?=
 =?utf-8?B?eTJqVk9qTWVVWHhvQVlQdWgwUDF2aTJZemtmeVZ3VjRmRS9QSlNTT2RZM2Js?=
 =?utf-8?B?YnZhcENGOEx3czNLNFdRWlBCRkE2MUtVV1FzeHNFSVRuRm8wR3dPaXV3VjRW?=
 =?utf-8?B?RTNpQkkyZCtjdnBpWGFkMUd3SGRtSGovZ1dzaHBlazZvd2ZmS2FHNmtLZ3FG?=
 =?utf-8?B?QjBEQkVabmVPM1VKNVVSakptcm1JU0lKK29DYndGbStxeW5JWWV0R0xhdWJp?=
 =?utf-8?B?d2NLdUpnUTdXaTQ3dHhnM2Y1ZUFuYTA1NTZHT0VlNE96TkoxUzcvMUhoMkll?=
 =?utf-8?B?b2xiNHovZDVLZm02bGc0L2ZRTlFkd0RqL01PcGd0aVg1bzZNRTQxS2h3VVBM?=
 =?utf-8?B?T3VtQlpoM0p5RkJzMnpyVUVubmRuRTQ3R2ZBSlRoQmJXaTlTbE1KdTRwWHRa?=
 =?utf-8?B?Z3Y0VjZTVUwyemFrV1Bkc3JZZWVsZzJzVm51bkcrRUdmdUdGcnIyT0JDNnhq?=
 =?utf-8?B?QkVwSVNQUkVseFZEbkFZaHNoSjFHREhQRDFIVWw0aTJuTjZPWDVYWTRYaTEx?=
 =?utf-8?B?U2VxVzh3NlV3bDdMOG83SlFoTXVQQXd6bHUxQmJ6L2JpdkxjOFdrOTZWS3Y4?=
 =?utf-8?B?b2toZVJnVnoxUEN3cG5uWkgwbkM1WHdXSFlKYVBvTG1WTkpWVGVHdnhTYXN3?=
 =?utf-8?B?RWNEUWlPMmYzSmJkYytSN3FXT2ZUS0YzRTQreDE3YWdwMHhwenE5d2xkNHBF?=
 =?utf-8?B?V3RNNFl4RW5yNStkcFdxRExzTXRXV0JrYnNzM3l2UWVvSEJZb2tGeHNiMmVt?=
 =?utf-8?B?YURERndTb2krRDJBZHVFOUtyekNKUWpYS0pzOUFLU3RQdWVhYlE4d09VTXE5?=
 =?utf-8?B?cmJtb0Qyencyc1VmMUxQWWZWTFF2bHNscm1KNm56cEJjMmNLVE5nMXN4N1FF?=
 =?utf-8?B?aFFLdkFHeTJMZ3BiV3NuTTB1TUdlV2hyM1FtRm1ESG5odklKZThBVHIxclRX?=
 =?utf-8?B?eUxmWEd3Ri94M3BJWXh3dWNYdDBkYjhQWEFmT1M3R1JaSUVXbitzaTFkcmI0?=
 =?utf-8?B?RkpQMGVBMm9mWTNIUmVZTytiYk1BcGY1T2hJcmMzSVBRYWh6eElBR3BaUjdq?=
 =?utf-8?B?cFFnRE1tV1M5YzNDOWtpcUhRU2R6bDVvZ3d0MDRVeVphb3Nhd0t3OXp4WHlj?=
 =?utf-8?B?dU1HcUdJaW8wRjZhK3lUNUxMYTJsQXI0L3lxRzErMEh0NlFMYk1VZldjdDJx?=
 =?utf-8?B?SFVRWTlwUCtOcDZlLy83cG5LeFFrdGtvM3QxTTQ1RThwcmk1OEJSZkw5VlZF?=
 =?utf-8?Q?olPGokKMbb9cfYRv6xXqvQg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399526a9-225b-4ef5-d12e-08d9ed9f00a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:42:21.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNxDkEdHc4WCzAynXd8tu0pCh1I12GAiOVau9MYKF6/W+wL85R3jn+z9HsbTOzHJAc3QBSH55yX/77LlkUqiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 13:54, Limonciello, Mario wrote:
> On 2/11/2022 08:46, Tom Lendacky wrote:
>> +Brijesh (please copy him, too, on all SEV related things)
>>
>> On 2/10/22 23:36, Mario Limonciello wrote:
>>> Currently SME/SEV/SEV_ES features are reflective of whether the CPU
>>> supports the features but not whether they have been activated by the
>>> kernel.
>>>
>>> Change this around to clear the features if the kernel is not using
>>> them so userspace can determine if they are available and in use
>>> from `/proc/cpuinfo`.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> Maybe it's best then to just check for/clear the SME feature at this time 
> and let Brijesh handle plumbing the applicable removals/additions for 
> SEV/SEV_ES separately.
> 

Yes, probably SME only is good for now.

Thanks,
Tom

