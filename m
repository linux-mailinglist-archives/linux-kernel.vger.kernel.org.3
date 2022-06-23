Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD75574F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiFWIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiFWIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:09:18 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8E47565
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJhFpq7OKKJxV1imeH6+lddhdA1Wa5NX9r/GalrKdbhMgV+BvnQscGOAS8cIdfV+MI9hdfNmQKBclr7ZNjIHJuFTzqSBlEsX/z9C2FjHUb1ygGIrEs7tKKenJeC/5j+gjepXV3nJ/2aeUfBXlDbHQJX+6/8UAmPJMvJSwNh0GSpWGd6hlSEUVhOuRZNBcDSRkfYkOmPw2F5ohLKxJA5Nprr+bREq9MTdzbuQvl/CDxk08gtki4SAtnus38vU2ByYOlIZrmAZMX0k0dpYbNkGJD9EfkZVpa9tLJHH8ZekdirWZUxIJXDg2DjecfC8y9TFRGGESKRoJyEX7CvdoozYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJ2EBGK9IpOyjiMtgo2Xldv69VXYF9fFvP/n00ISXz0=;
 b=bxEQp9oQwaPlneqw3PVwqXrZd+Zdbv9LESGy9A9FQsgjP1GGPGR7gJq4pvTLyxJodCitupWGqeXFFpqJ21o8ITf2RnMd9ouiRjOl4opHqRPcTzUiQD8QPqtyKDekIM8QuYk6TaoikdTPalfdKc+pM/4yMfTpEvU1Q35uHKTkIUqI0xbHsj+aoWuQ5TBsQXfB440c9UtpRK11LDJVl2Pzn/FS9VttUqjcHYW+Yt4NS+M2SPQLmrhdlJ1ZWF/JFkMZ1M3tjfVIIuWxFWG9/o+fU1NlYFWl6kvWxDYO7UNYkmenVP/jKdMWb8KshxinoNyiKri+NUPEo01zSg2Jzk8cDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJ2EBGK9IpOyjiMtgo2Xldv69VXYF9fFvP/n00ISXz0=;
 b=gB126O64gmNLgxpxXdB32bDn5oYUFKShn3fKAfujJGNFWOiMi77db2MbIkkvdXUHPBjgzCWurhRXFYRIZIxcfAZPCqZpDhi6gpmM0DSWPmxmMesdPShHC6wZ+3q4NTj58vkur4PK+Ue9fOMOyWnD+i7cUVV34cbCzLM9Ydk8+GyatK95cxFrOVwo8aTA0TdY+m+YJxwL7ebXkc0YP3iTmuxM5w2S9andp16WnXulUlBdOA07mGR/Gpj3cug1FofCvneMrnTjSzBEI+mDw1rebpgacEbJAHkEeHo0GQziNu1RH6ysyf8vexU7vPmanZ/noOg75nxwUMePpOE27mp9tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM6PR04MB5462.eurprd04.prod.outlook.com (2603:10a6:20b:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Thu, 23 Jun
 2022 08:09:11 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::dfa:a64a:432f:e26b%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:09:11 +0000
Message-ID: <b210d5c7-26cc-df6f-fa37-56fe04c8d0dc@suse.com>
Date:   Thu, 23 Jun 2022 10:09:09 +0200
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
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20220622161048.4483-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0110.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::29) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0832061-a9d2-4ef4-e581-08da54efa7d1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5462:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6PR04MB5462DB7AE73AEBA21BC50F7BB3B59@AM6PR04MB5462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6gTYhVqCWgOD/Jq/oLmDPMz6qoAqfJJK4swhhCHCMYZKlPqaf1bYM7nG3Bh7UBRP7PJMefrtyI8Jw8/nx87jSS+lvgeV8DMnmRt9RnykSj4OTtae68sqSotWzz6mZI1GK+775aSlNP5Qbp4FHgpqCCvjyviFhb14x5qLPxzSYXl3k9T4C17Sm+jK1fD6+y2TF/EtdmhTk9mXYdnrv7a1tyqA8QVI4tCB6Vy6eSTcxfnskSEq6RfghtSj1yfoNgcI7/GvOnV5SQ0OwHF89jjTSo1t4wZv3YSjhhzC3yrssWWMO6oE/kbkK0i9f0rUmpVEkWkpvV4fR+M29yaNccg09PmDEa1Z/sNarTUNm3oDG6r9CIAH436aROu8wOwFT+USvnpFMq3asiv5ZTHJ9Q6ZU4q+wu9IOrYYq4nCokSvwvzawJz3l8EC6r5AZYcs9pJ5NeJJzaeroWwpWvTjsg6K4NUzyuiR/A8s+jMJUUfJFOm+TM6NKOz9qUR7tA713p9a370adGokyf+cWkup8TOFG/kGj/cdWzCiPE4JhCrbdSRyg7KzT40UacR4ncY20LrxriRkMM+Jtxb81Z3Wjq1eWQpb69VMcmNoYXM5QcJoFG4lqVPnGunohThPuPu54m1e0fWyWvF0Gp1OoGqFjF+akncjlde3My1I3qseNx5cMpFiFCHwbaVsxYyL1PMyfgvx0KmzBc4PEmipS3g0ndzHyemcXcLLh07vj1sPaPV3tJGnrr7TKZfxEq9atOM4VrUdSUZNX1D79O+4GsR0yCZZ3oQdNtmYgHlaNknuJatRRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(366004)(346002)(478600001)(53546011)(6636002)(2906002)(6512007)(6862004)(38100700002)(4744005)(2616005)(41300700001)(6506007)(31686004)(8936002)(36756003)(66556008)(5660300002)(37006003)(26005)(8676002)(66946007)(31696002)(6486002)(186003)(4326008)(316002)(54906003)(66476007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFrQXkzcUlPTFFVQmNoYWYvaFVWTjM5V2lhR0hRM3hQd3p1RkJ6NTgza2Rr?=
 =?utf-8?B?bWkxbHRRNzVkWXFveWM0RkcraWJCcjREYndrY3loWlB3L0NFMW9oalF4YUFT?=
 =?utf-8?B?ZTFDelFPQXhRUVVJeFYwT3FGUUFIWlprL24wMlBiU2pPN0wzNTVwTUp3OVdB?=
 =?utf-8?B?NlVONUlDTllEOVpwM0cyUmZnUU01VS9UNDdHM1dJOXNwUmhyZEQ2N3RGZjVk?=
 =?utf-8?B?YVBsNGVVbWhYOFM5WUVCZXlIQ1YzQTd5M0EvMkpzWjZiUlRhK1dLNVV2ZzNo?=
 =?utf-8?B?SkVHTjQxVng3WGJKaS9kZkViYk0vUmM3TWJZS2NwUzl4Q2haOFN3amRSMUlh?=
 =?utf-8?B?TjFjU3d4V0o1Y1RBMXQ0cWVHZSs0amVSWkh1OEtzT3BhTHZJTkJ1WTVTOU1q?=
 =?utf-8?B?eGF4NjlnZlYyYVkrZjRaTW1MZlJVcElJZVlXMTUyeUNtYWdpREdDTFVMYlVp?=
 =?utf-8?B?ZEhzMHZHRVFvTlZVckI3TXlQc2pMWW5hM3BvTXNIVmJ3OVhudHZxMG12NW95?=
 =?utf-8?B?Q3BDczBlMUZaSzB3WkNhb3o4RDJxZU5hVVFqZE51Y2EvZEJwc2ZsSHU1UWlZ?=
 =?utf-8?B?K09mN2E4eGt4ekdIdkJ5YjE2R2NZUlkxbnZaT05sZFFhOFNXZ3NmK0FlcFJw?=
 =?utf-8?B?b1drdW5ESG9DMHREWlI2a0ZjTkk3aXU4UG1BM1lJM3JzNUp5dEp6aWo5Tm1U?=
 =?utf-8?B?eUxWZzB0MzNlbmRNWGN5SExFZ0tZTXJOUUQweHRmZ1dMUXJuK0xETTNpVnBO?=
 =?utf-8?B?RHVlMytlYjhtbm5GUTU0UzJNVkd5amFRRndyb1JmUDZKNkJTTCtHdk5pYjJU?=
 =?utf-8?B?bGcxZ2ZvVGZBRUR4UVI2SjdhMTU0K3ZjUGVNcStidEFMTUxLeUp6Rm9IdVdj?=
 =?utf-8?B?Z2FreXhXYUd1YVR4WVZwTnFneW4yYTUrT1dDUkNreVdEdDIwQjM1T0RMM1hX?=
 =?utf-8?B?b1ZKdDRFM1d3VlZBQkNUTGJvZE5yNzJpTElwVjFaTlNzMExqVkpiVTdSMHNp?=
 =?utf-8?B?NEN4L2wwb0MvSlh3bzQwL204b0JUbHAxQlM4QU1YKzlDTCtiRldZYUduU0NY?=
 =?utf-8?B?bjJEbkdpYmxjMlFFekIvOVlnNm4wSDkya2NQZVJNSkZucnI0a3hMaFFBSnAx?=
 =?utf-8?B?eHFJY0d5QjVvcTl6NWtacWxKSlo1Ynp3MzJGTlB2RFdlRUl5UmhSU0lCQ1pX?=
 =?utf-8?B?bXhmOFdpd2cyYmo4MFh3UFZNa2o0S0VaOWp0UVZFUXh4UHA3OFdGMjN5Ny9z?=
 =?utf-8?B?STZxU2h4Rm1YbHZadjNpd2FBQUZPdmhlY2t0bWpacFJ1QzFtcklueUsrRHNC?=
 =?utf-8?B?UmpWeTk5NkVoSGsrZ09UOGZ4YmY5SVEzeUowZXVIYlZnN1dGUzRwd043UnB4?=
 =?utf-8?B?YkZvazgxeDZ3UWpOM0tqWnFJSDkrVXBWZ2ViUnU2cFdyVXZHU2ROZ2cwbTIw?=
 =?utf-8?B?YW5NbThvQThGMk1WbG40V3lMN3Zxc250aHBLMXdrcFI5WThXTXFKcGJQRURL?=
 =?utf-8?B?VnNWSGZia01YYUJYOFZsYnhkTWRkMEQ2K2hab2xndVRTU1ZGR1RYS1ZQZitE?=
 =?utf-8?B?aFA4K0wzb1c0R1lwZEN6a29pY2ladWR2Y25YYmYyYjYwbXFSZWE1VGVGN3hs?=
 =?utf-8?B?Q05obDhFdVo5YTVlNVUxNy9jRjBvaGRrT09RaVB0M0tLV21XWDJ5RkJBOEtt?=
 =?utf-8?B?bkFNVCtIaDhrRGpyc0I3cjlZZ3VGT2JMdG9YWWtQZXlaWDhleGdHdHFraEZB?=
 =?utf-8?B?ZVFIWENuWTh3bW4rYTNUUExRUTdjUFBzdmdDYXFtKzJVZUM1QVNJZmMybDNh?=
 =?utf-8?B?Z3l3bEQ3d0swbkNZSU04NEJVajVjN1hzRDdqbjJpMkJXWEEyZlpGTnhicmJr?=
 =?utf-8?B?NDJYOTREVjZ4VTZFV3lIUjArQzE1Q1AvS0o3YjJXV1F5WDIyY0JDcWJHMmxU?=
 =?utf-8?B?cEdIN1Vscy9ZT3dsSW9ZSWFtQjkvNE55dkZXZFQ5a1hoNU0ramFWc3ZRZ1F3?=
 =?utf-8?B?cGFlNUNhTEJMaWtPS0NrbFd2aGhMbklacWdKdC9tZy9kekM0NkR1ekRYWUtP?=
 =?utf-8?B?dUozb0RvN1lyS3lyTk4rYmVaQUJvSUErS0NkRTQ4MEgwWmlUeVk4Tmx6ZjNj?=
 =?utf-8?Q?h7xfqpCAl9sDb6W9dmX+001nn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0832061-a9d2-4ef4-e581-08da54efa7d1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:09:11.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgGyemEK2+WSMskD2quSzIT+b3OFqPMooCFfkJmhapV6VIVs9TJ3/GsEIss8Lw1tQZN7NhAYp32Tk1va56v6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2022 18:10, Juergen Gross wrote:
> Commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
> put the brk area into the .bss segment, causing it not to be cleared
> initially.

This reads contradictively: If the area was put in .bss, it would be
cleared. Thing is it is put in .bss..brk in the object files, while
the linker script puts it in .brk (i.e. outside of .bss).

> As the brk area is used to allocate early page tables, these
> might contain garbage in not explicitly written entries.

I'm surprised this lack of zero-initialization didn't cause any issue
outside of PV Xen. Unless of course there never was the intention for
users of the facility to assume blank pages coming from there, in
which case Xen's use for early page tables would have been wrong (in
not explicitly zeroing the space first).

Jan
