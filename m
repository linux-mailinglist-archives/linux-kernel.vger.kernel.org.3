Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938195575E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiFWIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiFWIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:50:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0F49265
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7+wIYL73JutarJJhDTigzhedtuJVKfCooNHDPP1cUcWSNR35bta/YolXXYmNkZDx9WaWuGZ9fgrnFZgB5/9MnWjnqzxr/WT2EWso/CVSczIZ6NDOskyyo1mjXTj3GJaq8kT9kr9wz8HUfCliW+ia34fZiMqdGetVULAE0WkFCtRadze6jBdcBWO1BnkTyvt+fwczFDaP064R1vIgJTN4BrA0alRC9VVFXUJeACy5b2qv4Y9wkGRxEOkdKDijQn/WpWH7wofIxkFiWEcpRZoPTh1O72kwIP6/E/mqNUOZMJux0QvUHj3e9VmScxrjL8JFY7mSXAx9JV65IoNsC188g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJntYUc7/9EMUW5ebl5CjETPcg+UXjq6Lx4oGSxkdEw=;
 b=YpEYbv13R/CphFyBtNDy87sGfkyqDitCdRxSwT2jqG509m7Temk/gCvm4b+lJqRRj/7XbVfdOW3h1pcT/KDaY7ofdMtWgP+gzvQ27awnp8eLe3vU/DYY3iXcPWvXlY0P+rE1W27G96zU4Smv3ZhWQknapwgBsfuCLl9BKP8ablHdDTE58cJ1+LVQcuyGYOhAM9IikkvsE+nIQ/fXN7t1lZ35BhgikeKfZvto5DdZY4l+RzH+7ir/GGsgKK2XkogGtu3tQxFQce4vnNslWMTU0/rGmzfqGh60YC9X2e5CQ3gR9sv2sPUDOMsbwCLQhXTy2RE4qlXfRtbHjteze1/pPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJntYUc7/9EMUW5ebl5CjETPcg+UXjq6Lx4oGSxkdEw=;
 b=VFb+Jehfd0DgU17a40xjZbvMl8Jry0nVvXIfWNZ9JQP4I/WhYkq39ssONfOBErK9eHv+FFOofA7yTRw+UnSlN7G1rFEOeosIh7ENYeQ49pLVKpq8FccU9ECUxvDCkp4gDEO35lOOj/r5GQ8W1r97Bwhtt4+WaXT4jYVLs14fv9K3IrRQXKAZqUoZjn8Oz1fbEhKnEocB8LPskJu7u5jsXG1BJaBlclS4v9WhT2BJGkU+61aAjNQFlqV4gnw9vcPUTJUcM5ZvXvE85ehRSUTSpqSHB6lyDsvzwwv/ViYgOAmumkX0z4i2OkdxRx7hhWvEIU2Xd7L1yyCeXBIjCZfaSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB8861.eurprd04.prod.outlook.com (2603:10a6:102:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 08:50:19 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:50:19 +0000
Message-ID: <bba2828b-0649-3a93-16a4-eb3b35214af0@suse.com>
Date:   Thu, 23 Jun 2022 10:50:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] x86: fix setup of brk area
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220622161048.4483-1-jgross@suse.com>
 <20220622161048.4483-3-jgross@suse.com>
 <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
 <594866df-ef56-055f-c13c-64fac5797164@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <594866df-ef56-055f-c13c-64fac5797164@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0038.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::26) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2eb37b4-4247-4f80-dd23-08da54f56699
X-MS-TrafficTypeDiagnostic: PAXPR04MB8861:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <PAXPR04MB886151B7EBC9DF52D3FDE3C2B3B59@PAXPR04MB8861.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjTJUnsRuEjzKxndfdmS3/amHNqxXsmN7bNcStQZ9EMHLhyV1UnP+XZfDISXPQ1efI8IsMah5B5fNAv38axhEJ+RlZnP264f+bZte9+K8D76YdsfEW+zsrEer/o/9qpi3pAmp6Vxe2tQb/BvlD1Z8AabTJddgzSx4n5DD+HtPkjKZ14RWBFCXu6kJmbNRvGURwKTKrTB3JgMqxRESmGrpAEftkcK7oIwbh6oEC+KdXtN2/1zbKPQEJLctp37YlLh1nnj7MpVCYeqY84rxhAJr0nzU5PbsrsmsAr1W8vLZT1IQSrCPhlIA+a5M5L0Ajz/pB7XOFtE0nAbB5SMvJTFw/rqNfU4uDUzUGWx78i3M+/QZ4IXb+j6oiUb5pYVXHMvIjnAnPi2TUdYE05fU02EMkD+hJO13hg521reJ1CF3BfrcgEADyMFjomQ9yp4aVHiWB7cjAC76q+lknAyp22fYRf2gGaO/pBq1ZKTy50C7nDkkcSKgXM6TxakjWFq37M6k+D8UK9uHEGQ5A6wP2t05M00qHx2kySt4c4Cw7F4UFHPyhFAy0bIlPyNsIhAXFmzqUsB9p3ttrKYCOKbrOA/lswQH5PWqC1QjsqP1mYaH8Cu2YhZsV4+008nmr9xIE3rSEP4nGy4Uch6g7+lfYSpJ59AhEmjw91X2EpuTyPNSDo+NyxZO959H+IQ5GOhMEFP7/hLyQPhv1CuPzLrB/sufeGWPE20XWtArvqWtZpr/9jmDqm6InLoe++mN+bsbuatvOZgofShe1PlRmFg+0w1iMUkJaOjfEywM0ysBzxgiIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(6486002)(66946007)(2906002)(478600001)(41300700001)(4326008)(66476007)(54906003)(6636002)(86362001)(8676002)(36756003)(66556008)(31696002)(31686004)(53546011)(6506007)(26005)(6512007)(316002)(38100700002)(83380400001)(2616005)(186003)(37006003)(5660300002)(8936002)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ErbXByNmJ3ZjFoMktlVTI1MGpwRXBvSlI5cXZIbUxzRllZZWJsVVZxM0Vs?=
 =?utf-8?B?OE1tWmhSa3FZS1lNTVZ6TWt2WjdBVUlHUHBlN2kzbFQ1ZTdQVDFHL3MzU2Rx?=
 =?utf-8?B?NEFpYXIrVzBNN05xVDg4d01sR0VxaDV3aSszcXBpMWs2S0lCY3NqYVBXNWVu?=
 =?utf-8?B?ZXlZQzBiam95V0V5UnZvUEwza2F5M09jNHVrMkp6Q0EyUXNhZDlDVTk4a3Aw?=
 =?utf-8?B?M3FoT3N1MGd5aTFUS3I1YkhRemM4SG9JQmFFbUVxZGRzbmczdm1RV0FzTmVC?=
 =?utf-8?B?K3Rld2taOGxzUDd5U21lbTJmMTVkWkxGMW4yem81enJEN0VsTzRhNkxoZTNi?=
 =?utf-8?B?ZmRRM09qSWw0THBHaFNVMnlmVThaaDhyRFJ2SU1tczlDVjdaREZVTG9EU3BT?=
 =?utf-8?B?eVFFSEllcVF5cklBVE5yU05OdzBVeGd5OW1qelIrVWlrZlVCaWFOR2VqcWFo?=
 =?utf-8?B?TGpuZHRMaVhOUjQ1cWU1a2Z3czZvcks5U0VVUEF3YnkxOTEvbklVS29FOG5s?=
 =?utf-8?B?c0xmY25mRy9BRWZqc3JZWmtSTGlUa1JpTk1lRzRpWHd4SGJYRE9QN05jMGI4?=
 =?utf-8?B?TW1Fdk45SzhseGxBa0F6cndvNVpvZHo4U3o3cVYzVklFQ0phelZYbVBrckdL?=
 =?utf-8?B?Z1RCWUVuaDUzRzhmc2U4ZnBPNGFDVW13NHhwOHJCOTlLNzFOWUFPM2tWbVY3?=
 =?utf-8?B?azFBWWFxeWRTVk51Y3ovOHloVFNnTGtlMG44d0Z1bWNzZlQ5Q01mTkZUSTA4?=
 =?utf-8?B?MlV2VXpqT0J5dUVLSFZoeHRVWnNUSGVYTWFFQWR0TmdIL0QzZkE5a2IwSWpO?=
 =?utf-8?B?MDNCNGtEa2tTRHBRRmR3TkF1d2JCVDZLMTNmSHY5dWdMZEgyUndFMGx6Ujgy?=
 =?utf-8?B?TmExVUpUMURQMHdpekdYemo1WDNDV2l3UW5KWU1kUmFLNjFDOWxWbnFHQlZE?=
 =?utf-8?B?UDdMQzY1TXI3WHNBd3VYaUxFUGNVdGRMQjVaVW01Yjd3OUd0dENaN0ZoeHZG?=
 =?utf-8?B?aFl0NFFuT2szYXMxU2dWbFFYdEVUanVHR1VTRzBVd0d2VTdEYTFHOFBLQzMx?=
 =?utf-8?B?S0RicVVZdDVpVWNLYlZ3M1JvbHQ4SEc0d2I0c1I4WmJaSUhnVjhjTWdZdnkw?=
 =?utf-8?B?VUxiU2VFQ2VPSGxDR3BmVVFkUUZaWjFDV0hpYUJYSEFDdThVWWF1ZjduZDJR?=
 =?utf-8?B?NFZUcmVNSnlEbWdSVzFUUVJ1N1lZZk9QVE5tNDJ3ODMxMStsTFVXU0l4Y21U?=
 =?utf-8?B?QzZIZmFhdUJtazJDT0k1UWNYSlpiVFRUdm91QW1hZmZtd1NKK3B1eDZWRFlF?=
 =?utf-8?B?Uyt0Nm83eXJlUU1jcEVSUTJ0MG9nSFllS0swZC9YcjlkcWswWldNejZjeTJK?=
 =?utf-8?B?aVo0cVc5akxnczBFejNlcFBFMEcvNWdVL1RZd0VxZXB0U3p0SDdOd2J5MVRP?=
 =?utf-8?B?WnRyM1dUWDFYUElnRWlBeVJGeEdRY0JNN0E2YkhIUEsxV2Z1cXBjcHJFNVY4?=
 =?utf-8?B?NmpJUzlLLzlDSnJrbWZlM2IzSXVwT3NUbDRsSUFNbjJyYnpoV1dSUm1QWkZo?=
 =?utf-8?B?dkFnTDAvdDdCamY3WjJrRFRRSjRUdTNMalJ5djBXaC9OMmZINndldk80a0k4?=
 =?utf-8?B?ZzBJSnZFdW9qNHFnaHY4ZlFRRThBRFpGNGxTS0dsWmFCT3d5eWZicmN6WDBL?=
 =?utf-8?B?NG0wZC9rVTBZT3JhMVEzR0RMZHVSVkxOWC9ac3BIT3NiZWRLUzV4Tk5UY21n?=
 =?utf-8?B?UHZIOHVuRmlMdVhqNUQ0MHY2STQ1dWpGaTBnenhCNUUzYmRTMnFzSFZnREgy?=
 =?utf-8?B?NzRoZlNEVWdiSEQrMmlmdXBVYnNWUGVLZGhQb2RYaFVoK2lmVEw1RXplN3Ar?=
 =?utf-8?B?Q24vaEd4K2paQnB2d1pmOXRsNUR4cUJEcjJVUVpJZ1RsR0NJd3ZRSkRTOEZO?=
 =?utf-8?B?U3BRNHVudkRYL2ZMMElPZHFobU00dlBQU2FSWXA4VDAyOUpIV09KaUJOcHc0?=
 =?utf-8?B?M29FZFdPdDRjOVhYekR1S3ZpUXV2bmx2ODhJZE0ybkVPazdaSXNMWkVxbHRn?=
 =?utf-8?B?WG5uU05xSTF5LzRyZjhFK1ZIeHBVa1NzcGhCb29TUHIwWTFjTmROVXJzOEEr?=
 =?utf-8?Q?O39ntoBPMV33DECEdJKT9MW3x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eb37b4-4247-4f80-dd23-08da54f56699
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:50:19.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0rXk9th8nDlKt2bRpgHLp5uv4UYmfM9CGwe2dWxjsY+hOG8lY6NN7f2REBcC26MFdLrfNyxOSRN1tQ3uGFPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.2022 10:14, Juergen Gross wrote:
> On 23.06.22 10:09, Jan Beulich wrote:
>> On 22.06.2022 18:10, Juergen Gross wrote:
>>> Commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
>>> put the brk area into the .bss segment, causing it not to be cleared
>>> initially.
>>
>> This reads contradictively: If the area was put in .bss, it would be
>> cleared. Thing is it is put in .bss..brk in the object files, while
>> the linker script puts it in .brk (i.e. outside of .bss).
> 
> Hmm, yes, this should be reworded.
> 
>>
>>> As the brk area is used to allocate early page tables, these
>>> might contain garbage in not explicitly written entries.
>>
>> I'm surprised this lack of zero-initialization didn't cause any issue
>> outside of PV Xen. Unless of course there never was the intention for
>> users of the facility to assume blank pages coming from there, in
>> which case Xen's use for early page tables would have been wrong (in
>> not explicitly zeroing the space first).
> 
> Fun fact: Its not Xen's use for early page tables, but the kernel's
> init code. It is used for bare metal, too.
> 
> The use case for initial page tables is the problematic one. Only the
> needed page table entries are written by the kernel, so the other ones
> keep their initial garbage values. As normally no uninitialized entries
> are ever referenced, this will have no real impact.

Are you sure there couldn't surface user-mode accessible page table
entries pointing at random pages?

Jan
