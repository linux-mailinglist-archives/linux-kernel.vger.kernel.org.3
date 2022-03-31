Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F44EE240
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbiCaUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiCaUEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:04:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B88234044;
        Thu, 31 Mar 2022 13:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnyQ9PfgbrXD1fOkTXT/fKexSh1vHxx69TnVy9XCLZJFdH7F7xlnONTDMbu59rH1qdeF6dM81ube7wDZ2s4QG8ZeKSZsqzgAkNBAcZtohxtKKLrFqfjQ4y+SzylUqp+Q46Tdnh6N08/VLuwJ4X5uy9jwNtOaGq3RaRIimpIF4UIdwvnB4nrzIkkiu/hRU9T1dfbujkmYZnEZXtD5V1rXNlapBtKcfdP3sOlEX495ud9aamonEUeHKB8Lpl0t+5ONm9cl9SASPcuPU8AJld5AL5M7w3EZj1MrwMOl9hBQWpkgOM8c5AIcG+JcgfMzYLI9bFVq5wLMszVoSS9J18GAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA7S4jSEz05vsejs9f28DqhJxYwKkhp5V33UuGTDol0=;
 b=loVWVu1jMDqlh6SDrSlvtgh+wiyqRmE5hVouxkfMyNlA4dyYT9FymJ7JwVhXDT9OatXnIpi/M0+rx6r5iBqNgF/sQgKbavPTuA6erxSYOxX+yUVtEYMTBBWyrK1vhsS/DR7Jjcup4Rsw3OhezHCJIkEZA5aTZHUhHKbKDy/Res7OCh83Q414Q0rSU8+KAmx7vVnj0u55PEbx8A+ahOjEbDUngKMbCKOplNWRAW1jE8QWZpprY3k8miEspgcyS3H46guVZdmVhAxBR9Qxs3XVWY1NM5mL3WGh9tpfT4JUsjnumKx1jqUQlX7aILnAROeyBni8cLZE554NqKdODeaOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA7S4jSEz05vsejs9f28DqhJxYwKkhp5V33UuGTDol0=;
 b=thMgKUEm/gk/OfgE7Xq9iVx3ojq/lWQHHfxLIa6s797ltRW0qU3y1aNbbMudcTB+Gr9xUBUIq69SUlHt8SYlQfaKRMLC4YMwZKMLaeZM2Xkp86Et48PR3JucQny5TE9CNg0UnOIO+Butyv85wZgaB7MI4zhPltBUUMZyqOyp+64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 20:02:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 20:02:59 +0000
Message-ID: <fef8a6d1-8491-c62e-c718-299d0063ddd8@amd.com>
Date:   Thu, 31 Mar 2022 15:02:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] crypto: ccp: cache capability into psp device
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
References: <20220329164117.1449-1-mario.limonciello@amd.com>
 <20220329164117.1449-2-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220329164117.1449-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af581d8-9265-4568-e37d-08da13517497
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31770CF6F4BEAFA53A9F21F6ECE19@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEvH4FXbkdduynFZpiVQ2F9c2ACC/xz7g1kyswzRtGI8sxnRM5KTlyWjOyoM15uiY/s6GiCai+fm4KuhnNoczwPOAaSbfxE2aIYbFQTol0610D6x+NjmNIwjnUJkmHlzG4SVAW4qSS/KCEIf0ybXeSvlPIZruwQpPcDx2oyXHxWmRRp0ckHEsVlAxXVHvxneLJRSCGlGw2q6QEgpue9ZM0BFBqhxjXEvJYE1bn2cbWLWNLn4o5i0DKQG6iKRXjpHgAbMVfv2pglFBhhXJF3di1gkb0irDjUCWGuTuaCO1AXo7mkSdi7SJy/VwEJW98hckdy1dzEkb0itsZe10FobJLMEZPOGhFKm7+erefT2TKot/PpJfN7vvMiyDgBC6NAKxdZTtFBu/wJHLT9aFB3lP7lbFlZrnTWgE/IEPtvMpw3yu942Y8Ob72oQ0Y4RBO8OE5xWmeybphkeGqg35Uo/A63Tb8t/I8aEcMxtg15n2a3kW4gyon2ewhSOWUFeqXOhQ9cpE5O0UwnKicPWKsIcOEulhIS4rdM1ZLKru8UcrFCL0u+3ckJ9WSzJAN75jQwXcOXghqZY/FxlPRGfxryNTwCtz9PqrYicHZJuovOjEjLXHBvKS6KizuTLyRJbfqGolMk6w0ceJ29YPztwlDdVHkFViC6xIS3FxfcUJ6U+D2Btd0o8f6qfTaFvPfs5Z833CKZwVh7cgSrP1aT5zdDU946alBDtKgMaJ3sq+Vc8lT7WWVrqZu0o9EAfVybMmuqY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(31686004)(38100700002)(4744005)(83380400001)(36756003)(8936002)(2906002)(31696002)(6506007)(8676002)(53546011)(4326008)(26005)(110136005)(186003)(86362001)(2616005)(66946007)(54906003)(66476007)(66556008)(508600001)(6512007)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1A0VG5xTHVDTzJxckw3SEg5em1DY0xzTEhWdzk4aTJWSmpYdFhxNnZWWjlQ?=
 =?utf-8?B?Z2daOUtYV1VCUEMvTEcwUWMzamYzSDRsT0tNdnc4dU4zNWdqZkFURC9Pd3Nk?=
 =?utf-8?B?VFRuRTArK1pkSlBLRWZ1K1NhM0t2V25LRmE3cnBERWxkTVZ4dmJsUWdLUVlC?=
 =?utf-8?B?MmRPWTdtZGt2akJTODArM1FxZjZoUU5CSnJ3M0FrVHE5NjVGbytsNHppSlNn?=
 =?utf-8?B?dWg4bEZvMEs1NWZtUFJva3F2R3NXWno0N3hieDJDN01MbWRIaHAxdTRPcUNY?=
 =?utf-8?B?SnhVTUpML1RnS2VpbkdvWVVNb3A1cklQOXhjOHkvSEZCZE9pOWV1bXZoc2J4?=
 =?utf-8?B?VExIN2JtSGZFQWh2dEJ5SVlVYUp6NzJIejJJZUhwZ0NOZmpQMVRpS2lrUW1U?=
 =?utf-8?B?Q2xYSU5teWdHaFduanU1V0ZYMi9mTXI2WW52d3dIczQ0TmRRQXl6enY1WmRC?=
 =?utf-8?B?UzhUMHpCbHR2TkFIZ1RjQ01KbXdnNGVvQ3ZBamN5MW1aR0RUbzBLV001bitn?=
 =?utf-8?B?YlRJTXd4RUNYeGJJc2hhQTdTT0lZWTdDRVJqSXAwVDBSc09CSnRpSW9hVTBC?=
 =?utf-8?B?alRGMUQ3M0tlZkRVZUduMzlpcTdLTjZFV2xNWnAwWlhmWlRnTHl1VEF0b1dE?=
 =?utf-8?B?OE5qSUQ3bjdsREtKdlI5NWpQb3VVdHN1cjJNWnFEUUxlMFZEdmZuYW8rSVEv?=
 =?utf-8?B?UmJjbFVJUmJjSGdaM0tjS3NIREJFb1pqSnhmQy9LdlRSZFpmT1BmSFp5TTRV?=
 =?utf-8?B?ZGFGNW5ta0V2SUhLelo5YnNmZkY5Y1NoakJTcVJtT3Noa1pCWmRsMUdTSEZH?=
 =?utf-8?B?aXZ2eTdFUEpUckFLN05MQjMzaWpJMkhzdmZPMnU1SHNIMlVLZ2o0c3VSK3Jy?=
 =?utf-8?B?eHMwdlc3SmVNWVplMmlBRU1EdDJsUGJiM2VaRUcwa2NQZEpOVUdRUER2R2hk?=
 =?utf-8?B?T3N5OFA4aUxUdVpIYmlnTExHbXpndUFrcGFvNnUxQzN5MFJSaHI0QkdwbmFq?=
 =?utf-8?B?aGk4NXJKaUdncUtJZC9NbWJsNEorMjQ5STY5Q0JCYU5RRlhML0FzbjBqQVlZ?=
 =?utf-8?B?b3RXSjVJR0NFYXYySlR0ZTZyUERpM2FJUHRTOXRLYXBHT1kyZ0ZVTnlGMThR?=
 =?utf-8?B?aEJ0WWhkWURNS0tTL0doSzNuZmd5ZDdNajlna0tock5QU05NVVp0LzJtL0Ri?=
 =?utf-8?B?em01NSs4VDI0VzNwVFZoUjF6aU5rNDZhNWFqcm52aW4wSzcxVFAvdCtRR2Zh?=
 =?utf-8?B?czQvMWVoVlRFNFp0OW9ySnYwQTJpeWRzQ3VhTkREdWVIc2Fha28wVWl6YkNS?=
 =?utf-8?B?RjNPcVF3a29LQlc5cUhocitkVHVjdUpqWlpUWVp3Q3NwV0NjeXJ4bDNUOFJY?=
 =?utf-8?B?S05kQjJNeTE1RW9uUVpjaXg5eHNTTkZOZWZmaFA5ODJlMTcxTVA1dWZmOEt6?=
 =?utf-8?B?TUlBTTNObUxRVjExSjVaK0g2Z1hRMGNINXFldUxQNFA5MWZUcVNGcXJtR09I?=
 =?utf-8?B?eWVhQlNTRGNvWUdMYmYvOUhCZ0Ntbk53NmVuNWlRdXNwTXQvcGx4ZWROcWVn?=
 =?utf-8?B?anBZNElHaUM5SWc4ZlFLNUFnMXNGRVlJKzJ0R0JVYTB3U3NCQmw4bXBRY1dT?=
 =?utf-8?B?NUlhQTAxd0VBamRMNWRTMU1YWGhGV1E1eGhhUER6WEdKU3hQVlVXSDFTYzUv?=
 =?utf-8?B?Y1VsbFhFSVcxQXFYSmxIUE9rUzZSUjB0WmMxWVNHWHQ2eVBraDZBKzIwRG5S?=
 =?utf-8?B?VkVFS3BHK2dWeGoxZXJzLzBSZTNzSk80ZUl4cmV5SkcwV2xJZC9hZCtWSS9p?=
 =?utf-8?B?eVNKTWVzUWtXRkRUby96VDBSZUw3VkRqWk9Bd3ZYdHY1TFFKYjZsSWwvUzdZ?=
 =?utf-8?B?akVDNmhrdDlQVXZWZW55Kzh6L3c4SVdmOHgvUmNZc2RrNGVkU3FVVi9vQ3dP?=
 =?utf-8?B?VGs4UnR3dnZXNWVxS0wyd3NGR3VFZHJ5TGZ3eTRVQ2F4eUlUUmNSazN5M0wz?=
 =?utf-8?B?NmdiU3E4MncranNGMDFvNm15M052Y2NXcGNVTTI2RGpHa0haY1V0MURSUGhU?=
 =?utf-8?B?OWZhbld3cy8xaG53SVdXMEdOanM3SzZBa0RCcGU4OURyaWkrbEZsNGZLQldz?=
 =?utf-8?B?QVJkQmhUR2Jra3d3OHRaeVRNd3JlRkRzWmVZbVhzajJ5b2MzT1pHdno3RnBr?=
 =?utf-8?B?RjBqSmVSSjQ4R1BJNVVCWkFlZlZUd2RnWjR6ZlE0OG5icmtSQjlnbldFdEIr?=
 =?utf-8?B?T2ZwNUJpWXdsbkw2M0YzK2M0bnJwNkd1TVVtaVZFTWpZNW9NcGNmaUp0ZWFJ?=
 =?utf-8?B?aVptYUtKWkEveDQrVkljcjB5QlJ5STZTdUlRck5ldVdsRVpEbGhPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af581d8-9265-4568-e37d-08da13517497
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 20:02:59.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Zt5RAbruS3315wHOz2pi0afTcXTPSRwg/RekJbnkbxfI1aV34cDCD1BX5kZxyGGliwxOpyYuoWdjT+6+RlwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 11:41, Mario Limonciello wrote:
> The results of the capability register will be used by future
> code at runtime rather than just initialization.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/psp-dev.c | 37 +++++++++++++++++-------------------
>   drivers/crypto/ccp/psp-dev.h |  5 +++++
>   2 files changed, 22 insertions(+), 20 deletions(-)
> 
