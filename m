Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D85A2CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiHZQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345121AbiHZQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:51:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39884D26C;
        Fri, 26 Aug 2022 09:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKDrf0lQMGGt/1fLyoD06kHjIshkaZpoTxUpypq3KxCxID3bBrbiYOM9hWCQ0dAgKGjm4JO1BlHu6tfOhILB5VmnQ3PL2pYJ8/v4bD8s0ORm/NpeZrO+opa8YKXqIUl4PN2fS0AlflSyKMQIEu+DZf+58lSfn3XW0dzfqxAa/sG5dhE93zKA1WyYF4Pi3ovagxGE3eBH007ZBnu9+iVF5kTLYn7qlRENagiv+KLUBB3HvEhYNGwibkqB9zms2iDZEXuk8Ylmj+tv1OYF7T9vcdc8ggJlJw3hx+yF0SvzIOOOGJwTk9/mDKi9YVGoCfc+GBVzzjI4qnbTNDMWGWJazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv5FKjBadbroyUuZs5U8nqIblyVXyQ9ePKTrnegAdpA=;
 b=nK1qNrra8DdlLa/7Pq/paaEEP4GxU0IxiK4di9/0coU0avg165bcQzThg2W3TRA+6t7Em4tYoOad5i067smFECGZUOubkTDnNkqc5Jyq1db1fDCkTci9jNivISN2F8jhLK6T8n4XSzbZrRM+gFeZ2fiYABMmrfungQOgDJrGcCOmnUaG5yNVQdApHrJFR905ebm6uUGXsJvrBNlCY2QKdjS4/y2JEh69tu+oTGXQBr8Vd3XQgGVYx8fpMlXIKV4We44hUI24266xiqoMp58SQHOXGvLck9bMPw07IL8WFewQRflY7pWbmj3S1NG+X4d/SqNFxi1uY3Tfj/Gco+f0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv5FKjBadbroyUuZs5U8nqIblyVXyQ9ePKTrnegAdpA=;
 b=eEqxldMymMeNclDciPwVJiLPiU5UfHc/gkY0bQFib/cEOwXy7prgzid488Ie9hNR8tfyRD2hZux7c/vDgvfOKgZvFG+WdVFdVQrZ+GTmC1nffuE1cYQTZm0OzCcQtt/qjMXh/OzmowfQT9nxWd610s9y5Ii1ZZc8hI45BzGuRk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 16:49:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 16:49:23 +0000
Message-ID: <d6f5affa-1f7d-7944-70a3-6d2c99863fad@amd.com>
Date:   Fri, 26 Aug 2022 11:49:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
 <654433c3-2980-41a0-503f-f888d60310e8@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <654433c3-2980-41a0-503f-f888d60310e8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d887be-3565-456d-000d-08da8782edf0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RHo2q6wStJYgVFPrk4EQAvcs8sePHL80Olu+3p1a3c5ioMu/kvJp8eAOdbW4+3ur1Bv05olNViWbG+jl7aRyBTx8uwyXhERoewpxmTV6knLZIYJ3xuVnyphThbPlQdDa+QU2Jzp+bosTEqOVdtWu/IDrKFoLZ4LEIWiY1iRt/awYWRF1H27jg5qBzzWjLpMtLUf0lmZIXb5qKZux4EC5WOpWNeKcZ4QBxBqoKnleg4gPky8L/Zqw9R/Z6UF0WLSoam+2y7V7l9eSv02lPTh/eh56x9g0dkFEmGjzzGwytBVM0sSXR3IfYrUsAe2kKyl1PcR6Lg4EoVoIsdYQSKOK1pWM+y54MvFsamsy93d+8P9Eh9fqXNZR35JrQv0gYkrVLDVNCsZj3IM9kKPDe1sAMzz1hdSqWbvEyyLCuj97Y7ReNyzoaA4tbiscoC03hvI7IdueFa1ORFh/jX6X685PZkBVm25NpTN6tDhqWMV8pww3ceVwNS4YmLngODcSytiq2yxs3Pdy22/kZfuL2GRl4NT1r3WIjsDm4b0GOO5ycREzragRMe4meXkQpC86t1lNj66t2pIMy024NwBxjsaM3vuwTS01RUOuuR5rDAxmk2Or2w0yqlcHcomNuJtzEE86DWiMG2ti35C36gBD/r5UUE0RUhHkVEpnzTpVuuDrLKq76O1PuQOv/xRJbXby3jWTRkC/0lGhMSNhGBqvY/o1V5OSq1kBMCNyCzgtt6k57CWjgasWxuovmZzV5r8Rp/wLACGtwJnojoIIZGfCBRVKYrI9ZrHFg+Lgz29PYoqxQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(38100700002)(6506007)(66574015)(6486002)(186003)(2616005)(53546011)(36756003)(5660300002)(2906002)(7416002)(6666004)(3450700001)(41300700001)(478600001)(31686004)(8936002)(4326008)(86362001)(31696002)(6512007)(66476007)(26005)(83380400001)(66946007)(8676002)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNrN1dGbW9PNDZyTEx0cm1xWFY1enZDMWRHTVdCUlA2aHgzT3FEOEpURTZ1?=
 =?utf-8?B?UGVDVG1QT1lBNHU3aVRJcnpacGl5ZkZlNjMwYm5IMnhkQndBLzVkUDVFenMv?=
 =?utf-8?B?cEpYODUwK3V6MHA0NktwbW9KNVp4b3dOdFAyMWRPYzYxdDdyQ0NoUjhKK1RL?=
 =?utf-8?B?ZlR6QTNBaDk1K0xITkpTMHc3Vk5ZNGlQODVKNHdHN3NzejF5ZmlGRCtHR3ox?=
 =?utf-8?B?QnNiZW9uNXVKNkpGdGNRQ0hqM2RuTjA5UlM4UGh5aFJBY2NDSXlmNm9pbHJ0?=
 =?utf-8?B?aGgvMjdMYUFtRUh0cktsRGVRRUpNUTdZbjN4eEQxY0krTkhzOWFQYVdLVjAy?=
 =?utf-8?B?ekNUMFFmRE5PYzR0K1RuL2JsRTZyS0YwdXZnUWV0UlR0QlpzLy9Va3ZtZDdG?=
 =?utf-8?B?WjdXT09QVkpldmt4UUh4cHF2R21LekljUS9JS1dDbG52eVhlQTZ3T0orbk1t?=
 =?utf-8?B?MmVLYXVhbUgzZ1dqcnhGQWtTTk9WdjJzWk95a3hUbDVSL2NTdkVpdzNWTkZN?=
 =?utf-8?B?cVk2cHo0SXc4U0RQMnBoZWlORURJSzFZVks0KzcvUFlOU2VDNTM4SHRyeEdZ?=
 =?utf-8?B?dHlieGp4bk1jQTNZZm5aQjlDTHg5YzBLcmg1RmVDa3NJSysvV3p3Q3B4NTRZ?=
 =?utf-8?B?WVdDd3RDUTUxclI3Qk02d0NvL3FtSEE5ak93THhwUEp6Wk1tN2U2bDZFQk9i?=
 =?utf-8?B?ZjJiaW0vOTh6ODN6V1VWZDZ5a1hvUkIwQjZKLzI3UXVWckZ6MmpyOWQ0KzBq?=
 =?utf-8?B?eE9RQlQ1azJnV2dUaWtNYWlCb2wzOXhnQ1loYW5WM1p4ZStsVWVETklCT1JF?=
 =?utf-8?B?Zm9MSWVzZDY5dWlOTU9pUjZrN1hvZjVVajFuNUM5OXpvRHJpcmw0eHl1L1JW?=
 =?utf-8?B?dGFWcEhySE9tVmcwL3V2UkFMMW5vdEVCK1hWS0d3TTlZaG9GZUlrdk9tb3Zi?=
 =?utf-8?B?cXg0MjlOSXV6YUc5b3h6U1hGWHFiNDhCYnEyYmg0Ukw5TXBCS1BUT1J5Mi9R?=
 =?utf-8?B?cTVmcXI4cEFYWE1vdmFXSHZrRUtQakdHRi9ISUNZWU5xKzYyNmFZZkFCMmpI?=
 =?utf-8?B?bmVqTjF1Zk5LTWFlem1QcTVBVC9KTlFmSkRTNGNNREU0VmlxMElqVmE4U0pi?=
 =?utf-8?B?V05EVWs2YlhkNFo3UlNGSWlHemp2VVpnaDdYdlZXdkJDZUlyditpZFFpRnMx?=
 =?utf-8?B?U1g2WmlwTGZDYWhaWms1ZVM4OGVsU2lQb0ROeGtCYm9vZjBVK0dIQlI0Y0Z4?=
 =?utf-8?B?aXd1UHhDWWl5SUd4Vk83aG1Uc05tV0tVR1REYXJwbk94Sm9ueHMwNnZkMXZI?=
 =?utf-8?B?eFBwS3U4Zk16VEJrYkNsSFB6SXlqaUp0V01qUndSQnpMbld1TERteUwwTHBo?=
 =?utf-8?B?RTEvWWNkMTAxeUlhdVlpcVFocmJzYjRaRGhsUGIxcU1lSkFQWUJKRkZzNDkw?=
 =?utf-8?B?V1pnVytSUFhJUUxUQWErMDQxd0R3bnF0YVVFWGpaNWw1U0Z0SkptTkxIbEZS?=
 =?utf-8?B?encydEcvbUI3U3JnTDRwbEt4T3JkR3NXOStYTXpEY0JhNW8yVm5RczZGMVB3?=
 =?utf-8?B?aFZZREdXTHowUWRBa1VvNHpGQXV4Znk2NWZDRnFDR1lSK3hXWjRWT29ZZFox?=
 =?utf-8?B?b2orTTVOTStsOXMyTGwyTkNZUkpsQmxXK1JKSkJmbnV2WFVLS1RuVWZ4U1Zz?=
 =?utf-8?B?TlY5TzIvbUQwNUZHSTB3ZkkvdjlBckt6U3FuZ0JCQ2xUcmw2bnZoVDVLQWdS?=
 =?utf-8?B?QjRuZ216WXpVd3YrVGVwUFNxdU9xSnRPemM4Qmd6czdJaXdIVS9FVUFZaG9Q?=
 =?utf-8?B?SWd6WVRuNGp5UHpMN1dUVUF2TzF2MFVUdFJaQWNwb0tUb0FPb2xna2xROXFG?=
 =?utf-8?B?NTFVL0w2TGlBbjJTU2QxMFE5c1kvQlc2UHE5UG1yQTZJSjl6VmxCTFhEd0Ri?=
 =?utf-8?B?cDRwa1ltVkdXOW1zL2J1blBCL1ZySDRMMFQveEtQSjhHeVI5cWhOeG9xK1ZK?=
 =?utf-8?B?eWFzbGFzTGVUQjdvdExsMXR3U3cxaHFFWWZTdWs4cjR6SGZKb2lvamVYU3BO?=
 =?utf-8?B?SE9nUmN1b2lXZWFmZ0x4OVRIdDZGN21NRXcxQVJQZnZHb1c4SXdSN0tqcy9B?=
 =?utf-8?Q?Jz7jzfMbDC5Zp8utrxbCMUKMY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d887be-3565-456d-000d-08da8782edf0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:49:23.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y31S8JgEiopLYFYb0OF6hQeH+7r3vLflhJLgdWHJOMr5zR0xcVNrvuNfgU0x3Vyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/24/22 16:16, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:44 AM, Babu Moger wrote:
>> The current event configuration can be viewed by the user by reading
>> the sysfs configuration file.
>>
>> Following are the types of events supported.
>> ====================================================================
>> Bits    Description
>> 6       Dirty Victims from the QOS domain to all types of memory
>> 5       Reads to slow memory in the non-local NUMA domain
>> 4       Reads to slow memory in the local NUMA domain
>> 3       Non-temporal writes to non-local NUMA domain
>> 2       Non-temporal writes to local NUMA domain
>> 1       Reads to memory in the non-local NUMA domain
>> 0       Reads to memory in the local NUMA domain
>>
>> By default the mbm_total_bytes configuration is set to 0x7f to count
>> all the types of events and mbm_local_bytes configuration is set to
>> 0x15 to count all the local memory events.
>>
>> $cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>> 0x7f
>>
>> $cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>> 0x15
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |   21 ++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   70 ++++++++++++++++++++++++++++++++
>>  2 files changed, 91 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index fc725f5e9024..457666709386 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -15,6 +15,7 @@
>>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>>  
>>  #define MSR_IA32_QM_CTR			0x0c8e
>>  #define MSR_IA32_QM_EVTSEL		0x0c8d
>> @@ -50,6 +51,26 @@
>>   */
>>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>  
>> +/* Reads to Local DRAM Memory */
>> +#define READS_TO_LOCAL_MEM		BIT(0)
>> +
>> +/* Reads to Remote DRAM Memory */
>> +#define READS_TO_REMOTE_MEM		BIT(1)
>> +
>> +/* Non-Temporal Writes to Local Memory */
>> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
>> +
>> +/* Non-Temporal Writes to Remote Memory */
>> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
>> +
>> +/* Reads to Local Memory the system identiﬁes as "Slow Memory" */
> Seems unexpected character slipped into "identifies".
Sure. Will fix it
>
>> +#define READS_TO_LOCAL_S_MEM		BIT(4)
>> +
>> +/* Reads to Remote Memory the system identiﬁes as "Slow Memory" */
> here also
sure. Will fix it.
>
>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>> +
>> +/* Dirty Victims to All Types of Memory */
>> +#define  DIRTY_VICTIS_TO_ALL_MEM	BIT(6)
> Is this intended to be "DIRTY_VICTIMS_TO_ALL_MEM" ?
Yes. that is what spec says.
>
>>  
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 30d2182d4fda..e1847d49fa15 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -254,8 +254,78 @@ static const struct kernfs_ops kf_mondata_ops = {
>>  	.seq_show		= rdtgroup_mondata_show,
>>  };
>>  
>> +/*
>> + * This is called via IPI to read the CQM/MBM counters
>> + * in a domain.
>> + */
>> +void mon_event_config_read(void *info)
>> +{
>> +	union mon_data_bits *md = info;
>> +	u32 evtid = md->u.evtid;
>> +	u32 h, msr_index;
>> +
>> +	switch (evtid) {
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		msr_index = 0;
>> +		break;
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		msr_index = 1;
>> +		break;
>> +	default:
>> +		return; /* Not expected to come here */
> Please no inline comments.

Ok


>
>> +	}
>> +
>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, h);
>> +}
>> +
>> +void mondata_config_read(struct rdt_domain *d, union mon_data_bits *md)
>> +{
>> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, md, 1);
>> +}
>> +
>> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>> +{
>> +	struct kernfs_open_file *of = m->private;
>> +	struct rdt_hw_resource *hw_res;
>> +	u32 resid, evtid, domid;
>> +	struct rdtgroup *rdtgrp;
>> +	struct rdt_resource *r;
>> +	union mon_data_bits md;
>> +	struct rdt_domain *d;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (!rdtgrp) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	md.priv = of->kn->priv;
>> +	resid = md.u.rid;
>> +	domid = md.u.domid;
>> +	evtid = md.u.evtid;
>> +
>> +	hw_res = &rdt_resources_all[resid];
>> +	r = &hw_res->r_resctrl;
>> +
>> +	d = rdt_find_domain(r, domid, NULL);
>> +	if (IS_ERR_OR_NULL(d)) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	mondata_config_read(d, &md);
>> +
>> +	seq_printf(m, "0x%x\n", md.u.mon_config);
> Looking at this patch and the next, the sysfs files are introduced to read
> from and write to the configuration register. From what I can tell the
> data is never used internally (what did I miss?). Why is the value of the
> configuration register stored? 

You didn't miss anything. We don't need to store it.  But we need it as
part of mon_data_bits structure because, it need to be passed to
mon_event_config_read and rdtgroup_mondata_config_write.

In these functions we need evtid and also config value (mon_config).

Thanks

Babu

>
>> +
>> +out:
>> +	rdtgroup_kn_unlock(of->kn);
>> +	return ret;
>> +}
>> +
>>  static const struct kernfs_ops kf_mondata_config_ops = {
>>  	.atomic_write_len       = PAGE_SIZE,
>> +	.seq_show               = rdtgroup_mondata_config_show,
>>  };
>>  
>>  static bool is_cpu_list(struct kernfs_open_file *of)
>>
>>
>
> Reinette

-- 
Thanks
Babu Moger

