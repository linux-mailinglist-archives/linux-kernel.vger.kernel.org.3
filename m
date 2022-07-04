Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBB756554A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiGDM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiGDM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:27:41 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038212777
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL1xD+RgkzZ3N5+eq+xJew5Y35dDxHHs0BMZXYRQnETQMBIZhJvxwrlgDYisroRauafd1kzbNUUlANPGmG4ohOPJOUmAazWtOwmnc6Qziory3zOe2fAAICIjubN85rLKoPDUvXe9UipmzeT3IP2HL6HN1zOKLMmKGBRm0K202L1Mb9cMWCz9xr23OJ1jvRqrzW9LifRYlNL5GhV6YRP0L2tkaySCo3tJiXawAF9qZRoZ1Of0Q0DWxA1IM2oBeEj36N9JmFzfnHHPI4XRMtZXbPwNZwm3fZmiGQvBAJfjy8pr4ew3K7YWodiYXAZEEVEDJQ/EB4g74dz6smceSaXLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kid1033QQrIthfLb7SVwuwoG4BCUlo5GogjFjDjme+4=;
 b=QBWdECX+akZ4JNLrWeGHunsUkWHJGG7hbnXCRFuIhL44M3VtiLEWg7hPGd2ramT174Q2nzHvgHa0RW1/KkD3rYx7x9pxu4LVbOWJfeVuKdHPGjTi0cAuD9YhvADNYanCS3xEnpPRPPARytyVimbxksq5y12B6ss1L4OCtVCbVnk4sCAUEviTcIM3PCIIu6MpZrJL7BuuMmtECmoFqrNYCEBUGRoQ90QXUgHtFnXlf+0dGr4FfDxdpCUFLWijSMmktMBmAJtwV54Mp8b0c70XAz6MJJqyMrqcQabda3L2HImL97LJd+G/MK5lYgQ0AV/oRJw4a79z0GvSjtSWNuEoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kid1033QQrIthfLb7SVwuwoG4BCUlo5GogjFjDjme+4=;
 b=oVqO3VhEQMRnZzoJNQ1v6dIK96o2GjWkCKRx5jneWLaTKYovLVfmxO/UHI6WCO/6m6DVqwGIRmY//B9DzS444t10aEmmPi7WNVF28w9j8lHrn5ZAfbelkRNqXkywv+VLvtk0r1J6JliwSaFVNSILnG9vYaqBGqTaCJ/AfPD0rJeFdR0LxQkWR2znXDkuIIbGNLsCsPpCCQuox1HSc3gVC2rHVkmYkjV0QgUDXZKG0sdSw4LwoB4lj/qq/6LTGItBg7+O7DTgpX05qsY23nFMxE/uKOwHKnwOAsg7CDa4mbG68/Tq0zdx3aDojrBMDLmXlLAYBojglc7I9+8iZbm1/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DB8PR04MB6587.eurprd04.prod.outlook.com (2603:10a6:10:102::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 12:27:00 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 12:27:00 +0000
Message-ID: <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
Date:   Mon, 4 Jul 2022 14:26:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
 <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0108.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::49) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa361a88-6d63-4155-58e0-08da5db87e5c
X-MS-TrafficTypeDiagnostic: DB8PR04MB6587:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7+jQA4Kqs7FHuygTeG5wXoS1wo64rzJkLwn9zetbVAEbo/VWOXc4HwTgXUc1bjV53rXsUBU6qAqBDPGbPWI8Rt1nUV/MB/VSbROaqlAuXSjBt2n33S+Psq/FvI8fmsaSix7w7BXs0+3Xm+EPLkZfIoUYQtW5vjH4Wc69N//nMBiF83gZH6fKewawjrwEXvel+u9te8XQVAuH9LWzQ0ViH4tHySvPwZMnqlYBruN3rMC3vjAyErwcFRhLHlvCxvRhTPTSuFIW/dyaG1Nm4TxDcDfCx/33fNWdFYz02faEDs/MkuIX5axvrT9oivVpw02kN075qLlA6wfD8Ycu8Zaaf+E8zC9lOHRUkJj2bbGdvoS1sSLFOnbcHULZWT6owoHQJ+4iIXhyf4V6LHbS8QFr7NA6E5xZZDeyDarVIKO4Ji5ZJiE/zpJmAV6b6dCHzUiCPKuQExq+xDOyOPKzOxn9bSuNx726QTl8vLfsYQ1rJFsYegJEScCDWT64lzPRqNhd2jpwZJsWPac7DvAQkjxW+3UhliG6yYq9UlvFCEieLAj2bzwPCkNNVVaKCitj2GfD+63WO6blAqEhWmDUGYpZ5tkWhc9sN3r/WAUIifHOEbCDLA/Z/2gBGqK8H2c+63jRB9CqeDXVp/nwx9Rn87Vz5YhEXm/QL3oIcyXyN6uP3HNT2jiE7gEEAu6EmjEKWRPamgRcls99dC9dKVDSdl0QyKTTN/9362Jep3jzVMFHyS6kaZ1vIKFhHTjZ2C9b7HDfMzIcUtlOpubGCQRvjrK0sua/uXGgeFBLdLHkCD5N8wJVwFDZylwgee6Gvf/peyFM1RxbfKVr9Pp/VmLGQZgiIS3lETVnMcknCdRChl6wKEEvrc7tDTEI4z4AFAaBUu+jqYOX6QCMHJmkAjo9hP6LlOGbWqikYOta8mIEgQsd8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(39860400002)(376002)(83380400001)(478600001)(2906002)(6486002)(31696002)(38100700002)(86362001)(966005)(6506007)(2616005)(6512007)(41300700001)(53546011)(66946007)(26005)(316002)(36756003)(8676002)(5660300002)(8936002)(6916009)(31686004)(66476007)(54906003)(4326008)(66556008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFEyTjRJNVBKTDZZamo2RTE4QTBrZnRxcmw3M2dWenJuZ016d25JZzBQa0Yz?=
 =?utf-8?B?M2c0dXBiQndYUVphWlB1bk5PQ2UwN09zTGQrbG9RWVJPMnRFTWNUUTUweVpo?=
 =?utf-8?B?azgxSjNsQldBRWFtL3pXenhBei94Z1N3YzZoaklHcVRtNkhMZEYxUXlvZE5I?=
 =?utf-8?B?TDc4VE5VOUd0V0tNZjRxSTVWZStyRWU5d2JzTlhyZjU5blducTJKRmVrQk53?=
 =?utf-8?B?cjNyUTJBRzBDWXUzSmlGOU5rMVE3SVRPdU1pcHIzUXRYdE1mQWJxVUdybGl0?=
 =?utf-8?B?NTVaYUx6OGQySUdjODNXV2FReXJuelRoWlQvYnlWK3lVRDZxalVMZHBXZy9N?=
 =?utf-8?B?anZTMGNYd3dBNDBxSjBrRHBPVVJObk5IeHN2V0I2bkFsUUdqc0xUMTNrYXU2?=
 =?utf-8?B?Q1ZIdkdHRVNlZlg0NCtkTzB5WFoyclRjSjROSjhHZ1ExT3JHbFVPSXBRQk9s?=
 =?utf-8?B?amR6U2VpUGhlSERnK3hpNkVNWm9saGVxN0RCWXFCa1h5ZnZRalIybTJ6OWR0?=
 =?utf-8?B?eS84UXhwYktibTh0L3FmL3RxeWtSOEV0S0ZJUk82SGg2OUw3ZVZ4Q3R5SkVm?=
 =?utf-8?B?eWpwN2F2OXBZVFk1U1ZYZ1ppUFFDWmJmOG9lOHNNby9CWFM1YWpQMzRKSlVP?=
 =?utf-8?B?Tll5VUt1bjJzL1NWcWNDZlVnU2pIeU5hL0QvTWMzMytvRWlNUzdWVjlMdU1X?=
 =?utf-8?B?aWpFVW40UmZGMDVnbm5OS0VraTJ5THZCRkpoQmw5MlVHVExyRENLNXlYeDl2?=
 =?utf-8?B?NEJUd3JrV2JXRHFlMDE2cHZEd2NDdWxIUmJrWE5IS09qUHdUSEJxNmVWdVFz?=
 =?utf-8?B?dG10R0s3aXdvUXpQSDBlUElBQ09pV3VWN25MaWxQVEhJQUY1OWNLNjJjUFdE?=
 =?utf-8?B?cExqUjBRY2NFak1qcnY0TEFTSlVFaDk5eXVCcXowOVlHSXVBNS9xM2RZVEJi?=
 =?utf-8?B?K0hNWFluWVRhU1VabDd2VXQvOWx6UmR4cjZzdUpVb2VXU2FRTHdQYVI1SWt6?=
 =?utf-8?B?d0VDdHNQUjhPb1kxL2lJVXI2QkgvM3pxSDl2MzMxWXFzQ29aRExHTjVab2Vi?=
 =?utf-8?B?MmFIM0JtdlVuZHVVY2F4ZFFMbmdKSHZTMmhOK2F2aHFYT0lDeDhoMjB5K2wv?=
 =?utf-8?B?VEJzK0xIZmYwd2hZY1JvTktya3dyekZqRU96cFVENEtQOHFwMEdUSmFGL0Jr?=
 =?utf-8?B?SFFXWkdPNmhqbnBsK2o5djJSR2g2Rk91d3cyK3R2SlJZQ1JvOHlRdktoY0ZX?=
 =?utf-8?B?WG83bHZqWEdWbTdBSlBtcVFnNnI5b3k3R2FiZXpPSmlxSEdsc2VNMW5FQ3dL?=
 =?utf-8?B?RENxUEdTSUppcEp4T3l2cEl5YTZURlBQc1VxK3hDai9JTGFpWkdNUXdmcVFH?=
 =?utf-8?B?TGUzUllHbWNQOTl3Skl3Y0FKa05raUhhQ25pM2pUWkxEN092RTlpRGlHcWZT?=
 =?utf-8?B?cDVub2cyNkdSQXB3OVJURU9wZnRKYTJ2RzhxRlUrNWJyVUhKMEdzVFA1SVl6?=
 =?utf-8?B?NHRxazNDSlZxTGhSTFQvcG9YZkdPRFY0KzBsUzhWeVRnRDc2ZGM4T2lRREZ2?=
 =?utf-8?B?bnVwUW5yN09Ya1FmMWtUdWFQWENwZlBnYTNScFA5eWJqUFBJN3dTS0llQTRY?=
 =?utf-8?B?OXZiU3BET0l5dDMwRXJUam1wYVJvMTRjWGU3WXZ3bzZzT0prRHQvREo5RFp6?=
 =?utf-8?B?SytJQjlvc0Q3bXlmTmhQSGFiZUcvMWNKOTVPd2tuVDB1c0MzRllnd2tBU3N6?=
 =?utf-8?B?bEIzd0VQb2dJOUFlNDcyNi9Rci9yd1Z1OW5Ua29Rc2hvNStOMmZXL1U1QXA0?=
 =?utf-8?B?ZFAyMnhtNTcwc1k0ZC9FYlhoWTJPTURwQ083ZHhCbUlIbFlhYlg5d0VZWWtQ?=
 =?utf-8?B?K014eUs4WHRJUFpJWmhQSEFxVGwrQXZBRjZ5Qi9UbjFqZjhJSlBxeEdIVnV2?=
 =?utf-8?B?TXJ4WmdRZWtaNm96akE0Tm9OK09SV2FPRlhJdVlKYjcwamRWdkU4V3RZdW1m?=
 =?utf-8?B?UmJGZmZRTVNzQm9ER1FHY2RSMGxETSt0RkgwRWZlVzFvRjhGSDdpZWlxd3Aw?=
 =?utf-8?B?Um8rUWpYS0hBcm5Pc0lndW9PdXRzc3dQQ3k3enJUc0tockNlYURqRS9UTEFl?=
 =?utf-8?Q?juQ7EtSFTefjb+Ko2KhIcfoN0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa361a88-6d63-4155-58e0-08da5db87e5c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 12:27:00.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haOWeRXVee4Efk5OtpaTgf7Qj4vIzhEe45l7hOVWZnbgl9jpoNWrBMcHJ9+MotlMwL0yRLqDR7SZyPAmCajwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6587
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.2022 13:58, Thorsten Leemhuis wrote:
> On 25.05.22 10:55, Jan Beulich wrote:
>> On 28.04.2022 16:50, Jan Beulich wrote:
>>> The latest with commit bdd8b6c98239 ("drm/i915: replace X86_FEATURE_PAT
>>> with pat_enabled()") pat_enabled() returning false (because of PAT
>>> initialization being suppressed in the absence of MTRRs being announced
>>> to be available) has become a problem: The i915 driver now fails to
>>> initialize when running PV on Xen (i915_gem_object_pin_map() is where I
>>> located the induced failure), and its error handling is flaky enough to
>>> (at least sometimes) result in a hung system.
>>>
>>> Yet even beyond that problem the keying of the use of WC mappings to
>>> pat_enabled() (see arch_can_pci_mmap_wc()) means that in particular
>>> graphics frame buffer accesses would have been quite a bit less
>>> performant than possible.
>>>
>>> Arrange for the function to return true in such environments, without
>>> undermining the rest of PAT MSR management logic considering PAT to be
>>> disabled: Specifically, no writes to the PAT MSR should occur.
>>>
>>> For the new boolean to live in .init.data, init_cache_modes() also needs
>>> moving to .init.text (where it could/should have lived already before).
>>>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>
>> The Linux kernel regression tracker is pestering me because things are
>> taking so long (effectively quoting him), and alternative proposals
>> made so far look to have more severe downsides.
> 
> Has any progress been made with this patch? It afaics is meant to fix
> this regression, which ideally should have been fixed weeks ago (btw:
> adding a "Link:" tag pointing to it would be good):
> https://lore.kernel.org/regressions/YnHK1Z3o99eMXsVK@mail-itl/
> 
> According to Juergen it's still needed:
> https://lore.kernel.org/lkml/c5515533-29a9-9e91-5a36-45f00f25b37b@suse.com/
> 
> Or was a different solution found to fix that regression?

No progress and no alternatives I'm aware of.

Jan
