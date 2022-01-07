Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF6A4879CB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiAGPhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:37:20 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:20244 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239665AbiAGPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641569836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=og7Ub2usdmxEMjclPmWVkGfSAVpOowB3iElidC6jFdQ=;
        b=ltI8lApRcsXPq3DHT0HGphkXCIj1B1z8IenNOS0/rvf3KQhV1Bdrg6LLomazj5sSwJQ1sm
        JMdSWoPlyXCNKL82VLKGOzB7pCMp2MwwUQTvxagzFIuNdbI1taDhzdWTgIh/NvUgVZOgyV
        nBMm25b1YeMPqJGLremzfV9OWg+WurY=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-CQCVGoZWOpGt-bbwCv_i1Q-1; Fri, 07 Jan 2022 16:37:15 +0100
X-MC-Unique: CQCVGoZWOpGt-bbwCv_i1Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDCf1oLVGREvRusONHqAm0leXujbiarwvxgVogzx2oRN/4VqLQl/hpX11K3QmIX6rot1qO5z+Cu8xSdaFMBiB/Kfv05Hpt08Gnx3UJzVNdmTjkx1lgwNk/4HlaGY5OsGsj56QHS6zZ4hDBf7XVA3mpnNmCTe039wOddLii92qeIvz8XN3613b26hMqKwBk4DGQwap5ZjU4opvy+9yqBYWr1rqaWUh1CvOZFbuJ2WQ8hvmYcnWAU96CDYThFjABBT2LP3FzIkZdvslZorvO5V591hYbf4ZQXOKpCLCbgnl5fwy4BpQ+qE81z22UOPX5FJnl1uN4U1YKK6mFkRmpPkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og7Ub2usdmxEMjclPmWVkGfSAVpOowB3iElidC6jFdQ=;
 b=TODQwS8OQe7UgGADGm/W/GMBQ0e/DWW0n+dPcoWSRlB7/EqRm13WrdVidnA+TTNmAM0EWS9HiLw6G4DZmZb0aNy78msJSVle5sVeeO/DiS/kqIjImgW+aGBateFUw0QsgnshdRMrjKojxqSPpLWjGnMi640Gwx+2jvEOUnrh6Lm4dCKSMHdOvdfZs9l3WE9OapqME+YGgvqRB5bkivbHVHnMx3nbxovyNEFgTxrIQkbpUobMOJBC4yHSrjgyXLSgBZHqU4zwqR5NyH6vNCu5sTBe0yDeOwPYan398kRqZCia7biob6kv3Rm37xdObYm2ZoQysRuVpS87/qOjljUA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR0402MB3317.eurprd04.prod.outlook.com (2603:10a6:209:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 15:37:13 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186%6]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 15:37:13 +0000
Message-ID: <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
Date:   Fri, 7 Jan 2022 16:37:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1641565030.git.linux@leemhuis.info>
 <f71246e0999520d681c7b35d24f7eed2f53ee2b4.1641565030.git.linux@leemhuis.info>
From:   Matthias Brugger <mbrugger@suse.com>
Subject: Re: [RFC PATCH v2 1/2] docs: add a document about regression handling
In-Reply-To: <f71246e0999520d681c7b35d24f7eed2f53ee2b4.1641565030.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR01CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::40) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3969731-4a5c-42ad-0e33-08d9d1f393a3
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3317:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3317EFF4446CAA46614EEE97BA4D9@AM6PR0402MB3317.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBg7vuG+iRcMMzEDy27/OYLYuWR7LgK/rHP5ltDTj1sW+LHZm3WldxEX3hKqdzvhf7Sm0HEgHnd4kzDGFA2y2bcSy4AuCVUrFu6wNbnEjGc1d/3/DVITum+rpGcPh1SkRLtJF4K2CEWDoLWucWvP+XHMwfcnNM6x386Bhyu7L4aZuw5x8z42AKz+rc9BqwzF5hCxB9pEo4j+FEFy+eUxlq4iPowJCbdPW7I0GMcwj13JTbXjHotmQmg5JVsce76kiiFN3Hn2i672cH/vOl7t93O35UZFVPUvgR/Ra9XvXZX+7K9srH/HIqSLjBmTXyb846iTZURE8rgDvZz+5TiYkB3YPX3f33Jc/61q03TKJUBCE/9eTMb19W0SGrn9OE1BwAjMtYPPiCB+9XN8aLB4/gLNoZ94dJJcizooQDN5TCDnL0Y6aufgEdF9tZ0ps9M1x4Fp8inh1dEzlmAyq+uCE+1T0P2YftBkFKx+ET+ivWPyW3MNa2mFfk7ddf3W+mcg+UD0XJLN7bUIDHtzHjJEaze27yDFctvHSEP+m0lLVcEdNrxAcJzoENkBRdOETqx5BMWNFJpixmh2kHPRNwchtDlNWZqLBu4+WSmzxQI0h6ZpCZJBQVw3J9mXGj3uhdByi/8a20lq37cEH9k2b8Z9A1lsYcHiObKg6iwPc3p8fsJ7uq3YkCxUZC+I8CH7kxMa+cdBPIw1wf8pHdOROeQYcRwJrDusAD14SFMSzEZUEk+0rueJVtkSoyQOgDjnqvUlR81nGP41Cm2DOqe+cL+lq1JChxOqFnGdv/V4uOEOGkcfm8+MoR706QtcCr9LbzB2bRkkoTHv7kRhOsclrzq+hk32iguh0f1nWrPEZeMo4GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(31686004)(66556008)(66946007)(66476007)(26005)(54906003)(2906002)(966005)(86362001)(110136005)(186003)(6512007)(8676002)(316002)(508600001)(83380400001)(36756003)(2616005)(53546011)(31696002)(6486002)(6506007)(38100700002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmF4bXVsc0hCS2l1bytFblpjUkxsVUhPT09aR1RqbjV4cVJEMFk3TTlJbXBB?=
 =?utf-8?B?d3hEVmNSWk9qT1BxZElYU3JqQXlyNWtiQzB6WTVOWHBIZTNoUkRUQVJHTUZh?=
 =?utf-8?B?VFZpSFg1VUF0cmtWb3laMmlXeFRwc2JhQjdzZHdjVjAraXAzZXR4MmgybUNn?=
 =?utf-8?B?NU92S2REZ3VyeWZPSUExbTBwcExhVUt6b3N1cklFanRUbGZUK1I2SnpQeFZC?=
 =?utf-8?B?MjQ1S1I5bnNhazd1cmhKdC9DZmJ0d0NINDJtcTNNR1B0RWVVd2RzN0VwYXNF?=
 =?utf-8?B?eHpORE5FVGt1bmJnZWVzNWRZMk8wVmNVaDdwUVBWblhLaHY2UVJKY29ZK0U0?=
 =?utf-8?B?ZTJrZUF2Y3Btd3Jwak95SkJFbXE3TVVJZHpzWEVwOXlRQWluRnZzZTVES1Fh?=
 =?utf-8?B?ekZITkRnR1gvRkpYV2g2TXNVUEErWm1INXNjU0RWbVUreFZRZ1puUWlBTktO?=
 =?utf-8?B?cDB6L0FLQXEwaU5PMTFqUklPbDFNa0FrN0RDMnF0K3N3bi8rcGxaQzUwMDd5?=
 =?utf-8?B?citJUXdYSDF6anN6Mk5UVVVyajVOTHp0QWlSVTlmanp4aG12eFhOdUpiakQz?=
 =?utf-8?B?VXNzWEtrU0QvRlE5Z0lhdG9jdVNpaXd3azllNlpRNmhxTHJudUVlM2RMeHBr?=
 =?utf-8?B?aTg3T083T1RyRzRBVE1LMGltMjVCM01sUUxCcVBzT3ZhVHpobTRmTngvazJv?=
 =?utf-8?B?a0hKelJ5OE1WL3ByVit2NHJvUlZyTFhBT1RCWUdVZkM4aHRoMXpXaE9semZ1?=
 =?utf-8?B?SDRIUlp6ck1TdVRhSTRYZXFJbVEzczVGb1pVWEFuL1NabXVDTjhQWWRUZGx2?=
 =?utf-8?B?NnVVWjRKZHpNM2xrOHBGZTZZM2tGcEM1Y3pMUDZnckdvU2YzQmRpVEpHcGZV?=
 =?utf-8?B?V3Y4cXZrdURoamNIZHVFVEgxZUFjMXhta3o0MVduZDBFVm5ZUHcxRDZtdjlu?=
 =?utf-8?B?QTZubjF4RlozVmRiSlRnQmJnODZsUWVvanFqOUJCUG91aHJ5Uk1mQ2NrVWh1?=
 =?utf-8?B?VGJJQkYxMmRsbU1tb3Z0SllqWnBEV2pKYWVtOEwwZU1CL1NuQjlxaEVOOTJm?=
 =?utf-8?B?SDZrNmFTdFBNVE9XRXcxSHJIT3VtV29STVFCelV1MWlxTFFlajZKNlFkVWtU?=
 =?utf-8?B?cmFQUmR0WkpMbUgrSzhzUGtsNUc0Z2R0RnRDSmZCYVZsUm9ITXREWkJrWktO?=
 =?utf-8?B?V0tVNU1YQWEvOHF0RGgrWGNONldPS1VxY2VRNmZtTmNkMWZzQ291Zzc4NEtC?=
 =?utf-8?B?NENhbHFxWDZ6SC9TaDZlZG5BdVIzUURFT1NYMTAwb2lTbzZQTWhNMnB6UThr?=
 =?utf-8?B?cHp0VWV6ZzdLcXEyMDJpVTNISmsrSEpXWGVxWTI1Rzk5bUlDR1pEQ2ZMREpR?=
 =?utf-8?B?U3pHMVlIdUlvVDEwalJQNDNGYyt6QmkvbTRKajViTFp5K2hnNjdSbWxxcG1h?=
 =?utf-8?B?SW1YbWFOQ2drQTIwaTE3Q2hVdUhoeHRtNm11ZG9uU20xSSthQXJyU3dqdmZL?=
 =?utf-8?B?cTJjWmxtTmtMbHJiRzdKbm9DZG9WK1ZLNjZwK2FzSHk0Q1FhNkUyK1U3Yll0?=
 =?utf-8?B?YWhQZ3M3S3htdVZWUFN3cE9hWkFBTUlhMXJwQVlFV0FWM1JsYThZaC9XdmdU?=
 =?utf-8?B?cmJubXFMMG1rakZscWNydVVlRWZvRXdSWjZPODh2VS9Va1pPWldoS2hmVVFj?=
 =?utf-8?B?d1lTTU1NY05TS281Y25MMkN2aDlsRWs2ZGprVVlVTE5leFV4V0MvTFUvT3dE?=
 =?utf-8?B?WXlibGUvY24yMGxIQTlqZmpLZHFoYnVIejRERmx6d3hPZHY3eERuUjdrazdo?=
 =?utf-8?B?ckg1bVJTbWpOeXFyZWhiNmVpaWlTaEI3S2h3aS9XYVdkeWRjd2YyVTExajFH?=
 =?utf-8?B?YVgvMFZwR1orNkpuYldTWHNSZGxXYnUzK3NCTjVsSC85OVJTY29aWXhtV0pC?=
 =?utf-8?B?c1lYaVh6U3RrU0FGaVp2VHdkK0N1WjAxRmhuRWlNdnhJT1hYdGVjNytJR3Nw?=
 =?utf-8?B?dXd4eW9OYXlabkxmK3lNbzRmUkFhRnZoa3l2cmVvY2l1QlFYRm9BK1Vxd0NI?=
 =?utf-8?B?WlNNRldDUUkvRzlYMlA1M29ZVjR0RS9jSy9wSjFFeGZ0Mm8rSVVTd3F0aUV0?=
 =?utf-8?B?ZVFLbmtET3kwcURCeXRHeU93NUZpWGF6bXprOThJR0JUTjhJZU1CN01pbytQ?=
 =?utf-8?Q?43K6vkzpTo9RZ4YvLY7JkxQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3969731-4a5c-42ad-0e33-08d9d1f393a3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 15:37:13.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9Lpua22hTq8lUC4VD4vtdW+vyiPjCKSrRdCLUaAgm7loMFbwM0qy0TuBYODiAx7nDEfwzQPVNHQ82e2UPLlXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3317
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2022 15:21, Thorsten Leemhuis wrote:
> Create a document explaining various aspects around regression handling
> and tracking both for users and developers. Among others describe the
> first rule of Linux kernel development and what it means in practice.
> Also explain what a regression actually is and how to report one
> properly. The text additionally provides a brief introduction to the bot
> the kernel's regression tracker uses to facilitate his work. To sum
> things up, provide a few quotes from Linus to show how serious he takes
> regressions.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>   Documentation/admin-guide/index.rst       |   1 +
>   Documentation/admin-guide/regressions.rst | 886 ++++++++++++++++++++++
>   MAINTAINERS                               |   1 +
>   3 files changed, 888 insertions(+)
>   create mode 100644 Documentation/admin-guide/regressions.rst
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 1bedab498104..17157ee5a416 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -36,6 +36,7 @@ problems and bugs in particular.
>   
>      reporting-issues
>      security-bugs
> +   regressions
>      bug-hunting
>      bug-bisect
>      tainted-kernels
> diff --git a/Documentation/admin-guide/regressions.rst b/Documentation/admin-guide/regressions.rst
> new file mode 100644
> index 000000000000..6eb8d9784a1f
> --- /dev/null
> +++ b/Documentation/admin-guide/regressions.rst
> @@ -0,0 +1,886 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +..
> +   If you want to distribute this text under CC-BY-4.0 only, please use 'The
> +   Linux kernel developers' for author attribution and link this as source:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/regressions.rst
> +..
> +   Note: Only the content of this RST file as found in the Linux kernel sources
> +   is available under CC-BY-4.0, as versions of this text that were processed
> +   (for example by the kernel's build system) might contain content taken from
> +   files which use a more restrictive license.
> +
> +
> +Regressions
> ++++++++++++
> +
> +The first rule of Linux kernel development: '*We don't cause regressions*'.
> +Linux founder and lead developer Linus Torvalds strictly enforces the rule
> +himself. This document describes what this means in practice and how the Linux
> +kernel's development model ensures all reported regressions are addressed; it
> +covers aspects relevant for both users and developers.
> +
> +The important bits for people affected by regressions
> +=====================================================
> +
> +It's a regression if something running fine with one Linux kernel works worse or
> +not at all with a newer version. Note, the newer kernel has to be compiled using
> +a similar configuration -- for this and other fine print, check out below
> +section "What is a 'regression' and what is the 'no regressions rule'?".
> +
> +Report your regression as outlined in
> +`Documentation/admin-guide/reporting-issues.rst`, it already covers all aspects
> +important for regressions. Below section "How do I report a regression?"
> +highlights them for convenience.
> +
> +The most important aspect: CC or forward the report to `the regression mailing
> +list <https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev).
> +When doing so, consider mentioning the version range where the regression
> +started using a paragraph like this::
> +
> +       #regzbot introduced v5.13..v5.14-rc1
> +
> +The Linux kernel regression tracking bot 'regzbot' will then add the report to
> +the list of tracked regressions. This is in your interest, as it brings the
> +report on the radar of people ensuring all regressions are acted upon in a
> +timely manner.
> +
> +The important bits for people fixing regressions
> +================================================
> +
> +When receiving regression reports by mail, check if the reporter CCed `the
> +regression mailing list <https://lore.kernel.org/regressions/>`_
> +(regressions@lists.linux.dev). If not, forward or bounce the report to the Linux
> +kernel's regression tracker (regressions@leemhuis.info), unless you plan on

I would have expected it to be the same mailing list 
(regressions@lists.linux.dev), is this a typo maybe?

Regards,
Matthias

