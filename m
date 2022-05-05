Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1204851C880
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384755AbiEES7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385059AbiEES7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:59:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3837027
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqemDgtBsHOaGH1Hm2kcUdpLcgsouK0WCjgJE2ODqVy9biYppUrJ+jv27VkzryRc82htjnGudu1+iNGmu6o1Se59O+LydsumcToQSWh3qKyjsX2Vpjk6qBy46FG0rKw4k2SDBqeGenIPjlOIed7bEkn6VvEXc9nFyc8XM5rSaOimfQoU1VdrUGdyw8kAK/JLKSV6Ea8X2yix4HwOOEjSEbiugjBwkysvV9AHKg5nVK34O1xIyX0fizAwegIcveDcZ3X+dp8xspG5SQWyRWlVsA8xd4n+HnuqMwSXON6mZFj8kiWV1qTixuRerr4/lyPzZ2IeOy8KU5JWLTs1DSSEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBlzsLxesuOIbm7qzftlNpKCSDPhx5/wZVDuqzaYy8Y=;
 b=L8cI45PNlJG6/axk3URvsgpTQNh6MQ2dUS+QB80Ay9rT9pdU69SVFhc2Bp3PEEtnpm8RGO0dX15vExPSois0S8XH4DigYQnpjD8DUf8UknR/cdVN7eMkExNeTRfMPfHK6JUUbQl1yp91G87EKozqSvhaBIqbwWYLBrBezfAx23Hy47KPI7mNek2vRBueJJM1gf90/vg3e7/6bPIN1kmM+RDWY3lRuKCXdBn7JI2f3Wj/BttZi8x+CPCn2CQgdOUvKZ09gObufFl5ODGdzL/DGXOFgWXu1iZljt8mbnXpdELhJiN73Fv+QXb5iB5/Wx2RhxnIJUP8fdhq5gwNA5A03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBlzsLxesuOIbm7qzftlNpKCSDPhx5/wZVDuqzaYy8Y=;
 b=XVHsdB0hnH1vi3dbjYMyWM7QDVezva5u6y3X6JFg49SrR+FbezBULE1XrEk/cBOS0W4zH2hLHaaPPrrqjnWsbzwfGfbibbEIdtDazZifmFKSZMGCVTUQXgDv51TrVUC/CY7e7hJ5zB3fE8pp66L6EQG3cUN/wEpN41jYaoYCyFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 18:55:48 +0000
Received: from BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d]) by BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d%7]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 18:55:48 +0000
Message-ID: <e2eef6eb-30eb-8d18-a24a-a66c5023302f@amd.com>
Date:   Fri, 6 May 2022 00:25:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] x86: Fix comment for X86_FEATURE_ZEN
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110429.453279-1-wyes.karny@amd.com>
 <ce377229-06ee-7f68-ca55-361a8986a7e7@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <ce377229-06ee-7f68-ca55-361a8986a7e7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::17) To BYAPR12MB3368.namprd12.prod.outlook.com
 (2603:10b6:a03:dc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1948b9-12a1-438d-15f9-08da2ec8ddaa
X-MS-TrafficTypeDiagnostic: BY5PR12MB3875:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38757EB2D2A290815CD3A4F484C29@BY5PR12MB3875.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTpgEJ41AXFIPfLJMbkkwjSiAo6jlcA2zzbpWKGZWGNM5bJI/N/Ytjx3WLELxCbSJAHE9C5eia5qCIvxo05T/oEmRvkTi06KbT4EzwhIA+V0XOxihgEigfXX3C3AgQ60eSyWUza2rvA3I7/bBRUKp9VsL/zPbGU0pzeK0ShuaeUfmJ8ywoLX1kxC0F04SIVwxlXnYU2w2c/2mIg3QejWt1SuBEW/mtMnnvHdHfcN0Ox6ea30LANLUXPjwdmiKjZPKj0Lmt8Pd+Rw41s9egDWCrsXl+T6q1FlSQJEdyK9Z3TPrsOMQ1Ljq6L3ZvATEgBQx+fFW30WUL9teUTrOHsXxO3ogM0DZiMFjgpk/k6KVVCDDmsFz1zIhx/uTb6PTqTwEhwDCbg4dywEz/flj90ijyd0dLJPk13Br3aR/j+Ng1YnMpANwkOhFRcxeXYryBYmNXdy87yC60BomZMXJXbJ3Su91/B5aVriVYBIyqGz5sIb6rk8KEWgxu8j/Wtj1of2UbvkqUWhfWoBC3zQYHvOPWBp1Wp6nyhlb3iR8Fpm4AaYbbsivWmtqUtVa4reiAoEiLOAq/tMOya16VELY3HxNaFxr+gUFVBKmDI4Klu1myENOgtC6RbjqJUxRQplSTIQjUCw7HpLuWk6Sph7BKw+7uBVPLocL3vh1LzN5uqggOXTIYKT/7UDW/AOWTHo8u2RmQ0hKhHJ/A3NGWMA+fA330FLPMx+MUIzRqJybzc8p4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3368.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(53546011)(66476007)(8676002)(26005)(31686004)(66556008)(4326008)(66946007)(83380400001)(6512007)(31696002)(6666004)(186003)(508600001)(316002)(36756003)(2906002)(38100700002)(6486002)(8936002)(5660300002)(7416002)(2616005)(4744005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEx4NjBNNFB0M01oaXNPOWh0THczZEljQ0VCV00yYWpGVVkxY2xtRFZlQWty?=
 =?utf-8?B?UjRDMk11T25uYVFZMXpLVlptV0lqZmNpRW0xTncrZk1CNlJKZzhoam5zUGNx?=
 =?utf-8?B?RitXakVCTmtLMllWVHAwd1hzUnBMbHhmM3pNSjZHOC8yd1dtR2xnKzBZNkZJ?=
 =?utf-8?B?ZXdQVXVodm1GS2I3QkFzVzV3ZFFSUWtsZ0JqcWdYell6RlZSWEJtaHlpK2tu?=
 =?utf-8?B?dVNBWWw2eHVuaE5ReTlxY1Y5S0NFZWJQVnR6UWRCMWltbjJRV0grN3c0OSto?=
 =?utf-8?B?YVJYbVZBOXhCUE0yWk5jaFNjcytLYzlvN1dHa0NOQ0xraWZtcmc4dWhrMTVv?=
 =?utf-8?B?NUV6RzVVcGtLSmxyb0J0MDlRTEtOZTExbkF6dGI5dmpKUU9XVVlaeklrTjdp?=
 =?utf-8?B?VlJVcmZiU05LNHZGcmJJU0tZUlN6Z0w4cFhydUtTQUcrTVhqWU9ZY0o1eG40?=
 =?utf-8?B?ZWE3SENBVmorLy9vbVJQeHlmeHI5N25UOHNjSFkwQ3BaQmxpaU9MdVZiR2FK?=
 =?utf-8?B?d0Zxc1VXVlExV09RVUhyYkFMckdUcHprU2JreWRHSGg1bTlLaE5YdFVjZXI2?=
 =?utf-8?B?VjFUb2pIM0czN0dDVExObkxaZGE5b2VzUXNhTFZCMTZZWXB3K1VsVjV4Mkpq?=
 =?utf-8?B?ZmQ0bGZ0YjcrS2FBN1ZOclhsUHB0R0V3RnF5a2duU1FQeXNNMHF4Nmc1c3lZ?=
 =?utf-8?B?QkJPeEVGUnhlVUxmZUFiTEpneTNSQi9saWIxeER3TytaNkhzN3ZtRk50Tm0r?=
 =?utf-8?B?dlZNZmFXN3JCREJwNXUrR2R2dXQvNmhpN1NjRG5ERG5lb2cyNVBGNTBXRWlF?=
 =?utf-8?B?TFBEQTM1bTlISHJvS0JqQWg5c2VpMjVucDZJQXRaNnZsZGdNYXArenBXOTFK?=
 =?utf-8?B?V3hZUnZ0VXJJV1N2T01pMVRKNlVPNzkwRnVqUDlGNzMxRnEwUjB6NXhweEtV?=
 =?utf-8?B?TUJsWmdabHVZbmV2SkliUjlabjdZWUNRNEYvNlZtald4TGxadGtkWmYwRWMz?=
 =?utf-8?B?SEJmeGpnOU5VWVowZU9peExrMFg4R3k0QTdtcWJpQ1NZRFZGQ3RiYlRPOUkx?=
 =?utf-8?B?YmdzZFU1TnE3aGptZ2F4MHM0UFpheHM3RUZuWUROWTVldk95bWNRUnU1c3Fr?=
 =?utf-8?B?TlJLSmhLdmhzdEhqNGUwNHJNcXBJSUFZa0JkWXhZNWgwNHEycndPMkVyRHhs?=
 =?utf-8?B?UzdHVE9HYkxmTUNONlNRYnFLU0NYSHZpUG5BQ1E0MzR2QkluOFNyR0dMYWNx?=
 =?utf-8?B?K0Y2bCtQN3RtckVGS3c0d2R6bUQ5Z0cxcjhyaGtxYXJ0NlNQSXZpYjlSYVZV?=
 =?utf-8?B?UG9UWUVudkxoeDVuNlVZRkV2K2JiQkFMM2xWOFZRbVZWay8zVStBTGZ1Q2Jv?=
 =?utf-8?B?Um9lM1VxKzh4c2JPRFQvNWZ1N1c2Mzhqb2MvSWFkTjUxaUlvczBYay8wNWV1?=
 =?utf-8?B?QXBLOXpsTkZwS2dzT0g2d3FXUkpURU5jYk5EbUpBWnBxWVdmYzVuOWR5ay9X?=
 =?utf-8?B?Zm4rQnJ2UFh2RFpkcWtPL1JRWm9jKzBZUDNvRmQwWTVRNXVyQzhKZE1zaG5o?=
 =?utf-8?B?UFY5TUE5cGE4dlAxSms3enNLTmg2YkdtZEVjSDcwNGFTckQvaUhwM2dEcFlQ?=
 =?utf-8?B?cFBVNDlaQVhTVzdPSUtHVnNDZW5oVGlPTXQ2Y1gxQnZ6NmYzUGJGUEFCSXRW?=
 =?utf-8?B?d2J4VFk5MlpjalVYZFFzSDh2ZFlGUUNvOEtZZEY2VkRsTnFzSXZENFFWcjFW?=
 =?utf-8?B?RU83dHpJNWR5VGRpejM0Qi9MaE15elordTZ3UlQ0c3d3N29iTE81Z3EzaHo2?=
 =?utf-8?B?dUJWK3hYajYwL1crV2lpeDM3VGFiaTR3cmdXeXpBSEoybzVrUUhIYS9YSjNa?=
 =?utf-8?B?ZFk4U2RvbDZpWTN5OCtxT1pPNHFQaHZ3UlV5L05yTmNKbUxrSVFnWUN1NG9V?=
 =?utf-8?B?Rm1RUFlPZDVYdDhwQWFCZWk1VDJ1SEpaeVk3OWh5UU1HMldaaWNZNllickhG?=
 =?utf-8?B?N1I4U3JVM3BUNk9Zb2xQVU9ibHZ5YjRHUTlvYzZTQ1FLOHBQdW1jM3pWbkda?=
 =?utf-8?B?RWpDU3YvU3piN1hvdXA2ZkhTZlZWYnlocEYyTTA1OStKbjR6a3lOQ3NxN0sr?=
 =?utf-8?B?aHBnRE9IV01lWXRsbVdSQnVGVENpTFVrWng1anovWjJYUzA0MWthbXNpR1oy?=
 =?utf-8?B?Ynd2Uk5BQ281ZWQ0MEswZEZtZ3VPditIRzFaMFZoNEVUN1dOT3RTYWpWUnM1?=
 =?utf-8?B?L0dWTVFxMC8wTnNERjJRY2RNR0t5MHJxZnVoMGx5QldmdFJteFNsOUlHVDFI?=
 =?utf-8?B?RDYxd0Q0UUhJYlFPM2V5S0FxbFdZS2N6UTlWVmwyNStBZ085Mmo5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1948b9-12a1-438d-15f9-08da2ec8ddaa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:55:47.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt59OjYgHYY0eK307Iy3Cydj/STFX7NI1109jzcbLldSZ5iS9ep3xLzCiyFwq40S2jQ+nh7rtN7VHlsu2TtPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On 5/5/2022 10:40 PM, Dave Hansen wrote:
> On 5/5/22 04:04, Wyes Karny wrote:
>> The feature X86_FEATURE_ZEN implies that the CPU supports Zen
>> microarchitecture. Call this out explicitly in the comment.
> 
> Is "supports" the best word here?
> 
> A CPU is based on a microarchitecture, it doesn't really support it.  I
> guess we could say the CPU supports a microarchitecture's *features*,
> but that's a bit wordy for a tiny comment.
> 
> Maybe:
> 
> #define X86_FEATURE_ZEN			(7*32+28) /* "" CPU based on Zen uarch */

Thank you, Dave. Yes, "based on" could be a better choice here. I'll update this.

> 
> or spell out "microarchitecture" if there's room.

Thanks,
Wyes
