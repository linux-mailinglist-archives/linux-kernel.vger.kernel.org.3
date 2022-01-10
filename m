Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF548987D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbiAJMUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:20:50 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:56103 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245373AbiAJMUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641817209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVUbIB2L53AjkwFtuybR25BEwaucMwZetB21Q+Lx9uk=;
        b=A6+SnLoedQ0Mz2JuRiz5r57Qo2m9WbtJl57zkEQiYbueMx31FgY1CWm6FVX8n9p7aBVmkp
        Oax04Y7R7ONAyYcCoq1Y/DbHSQP9bqYKx/X6kpsAFZQo/52/6DFcqLdArfT4LU4kLTeIZA
        Xo4XUmfSj0W2LcRFcuiYdjfcQ91qHr8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-Z1TlwIG_MoSngZLuZl1TEQ-1; Mon, 10 Jan 2022 13:20:08 +0100
X-MC-Unique: Z1TlwIG_MoSngZLuZl1TEQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4G6YWyomV7q63vH2WbODY8himZb+id7j0kZsFsl2FVjGs3NV1FK2vbRCkFSvUxpLpGZr9Mt6O1qpbyvPuPWQeZXxAx0o53Ukm4v27vHINeSXWqTNKSSClQeAQoBGQHdVzyHXvtrkCAoHtrf4dUovdgRqVa7GWBlCg7qZz5XlycUXBPNxQiGDGwfHQWrS2rvDbTISckb3aaROqYNjeynM6hoIZbtsrw8s6nCqZR0eGdNWDTa2JhR9392943IZgLyAkefAfGvyS1VTfM0s0sBO/v6alJHpdkPfV1Vx5Z3CoDrQCGbDRrSMgCx3p5Cx7lLHGlIb9LXNbCfuW81B/eqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVUbIB2L53AjkwFtuybR25BEwaucMwZetB21Q+Lx9uk=;
 b=D2+k6L2KDCMhnQgXr+ZmhfhrCCfRGNcFz9ww4ryPPUhc3E95ZpQmdYxCcltSi3MsU9YHHlV3UILAAWJzuUqaa4dXrhaUfBkmNyJl7xWMhRHP+rbn2qAT9O54C3LTv/azSSb5wlIEn6qC/b/cgFD5Q1h+Uhl+qW8SzOm69Qu+B4phUl7JPkIQ+xE3aN09BaNq8ZumE4WNqaTZMICJO0g2UH8EZqMIXzcgmI+B5YrbzwGjfBPBE0S5ptbdXMjqPpUs55tN4bAOS8BPEq5V9Y1BAoJgEW73sGgckZF6zknrqcO4T+El6cPnmuP7H5+g1TjbbWL36WWycaCq9oBIlAPelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM5PR04MB3233.eurprd04.prod.outlook.com (2603:10a6:206:11::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 12:20:06 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::20b0:37b8:c5a:b186%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 12:20:06 +0000
Message-ID: <986e9dcd-06a5-0fa2-16e7-1f2c6268238c@suse.com>
Date:   Mon, 10 Jan 2022 13:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] docs: add a document about regression handling
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
 <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
 <1126ce91-f22b-c397-4d1e-13d290a424a5@leemhuis.info>
 <8e6f07ef-10fe-381c-3a8d-db497492036c@suse.com>
 <4398ddfe-9db4-bf67-902d-e0416b815878@leemhuis.info>
From:   "Matthias Brugger (SUSE)" <mbrugger@suse.com>
In-Reply-To: <4398ddfe-9db4-bf67-902d-e0416b815878@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0110.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::7) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac14009d-9068-492a-3221-08d9d4338965
X-MS-TrafficTypeDiagnostic: AM5PR04MB3233:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB3233894E881D95F6437229E9BA509@AM5PR04MB3233.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuUrdcaFxfrre0+8gkEuhN2nSV4bQ2sB37m12PFJ+AVkFaNc0PsnnUk9LEjJ+h0mEC05ghbp/nBopwec/AQQbp+uoWIgOehfjb2VKejamuzriw/l9plZeVcZQJ6SsuVMUka7xm28mz6KyrWHBf8ZrBtJs3nhIk78RpL4k5nLFe66N6L7gmMKEwnnv7kh7kU27XowYSmzK0vYlACCqDbvBKiFor/sxyCMjiXZzqYzj4Q/+0Sq3KipOcK9+6HzOcEvzwzH9/SoNp4W1/+Ko07F6lEU9CGQJucdKADYliEPW4QpZPD9tJ1w6VmW2kZ6wqRaOZt4xOzdu2KKLKKmOH0Y6DHHbN5JUgwRmbAy3MTWZATq2cxMrpXicXDEZAAD4bfQRmdlBZHd4H+9khT84C1whRB6x5K6ZYeFAxM95HCUEeFQKrGRsJi4v1HUvnEY3uGWboxU/vZ+VbtR5ntSAVZfHBAQDEQxLDfN7BIMPzuZYhzisT6osBerFsZHVDNhFFbn5ogxxlsOWylRaswPbw//0ZpOCGsYS4NgPAK3ciySlExfrdQnIaJr97/rhqWzG+RM74bY70igugQ3y/pNF/yHZ6EK1198K0+it2K+WApeAiHgrLlKBCuBp4m9P76PMDfoN3dM586ykcEq9+c0myIl60p8xmuu4K/uAfLS+n11N2jxjIpTGNXYIZvGLFSdZ3kGtbkSLWDSsXvVGZycELygX0rgjxOf2zfFeZAsSYgVdRobOfdZCWkUlXS9AKtsD8zXYmrDOEPQL1EU3iX3in0jdsfEc2pIWFrGBgOpUwcyYxhbfOSs5Wix1ZnB77ShSFAVcD1RFFPECBZCjAqf1IeaDZyq7QcuyEm1QwDW2v6MzVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(83380400001)(5660300002)(31696002)(36756003)(2906002)(31686004)(8936002)(8676002)(54906003)(6512007)(53546011)(6506007)(4326008)(66476007)(6486002)(86362001)(66946007)(186003)(26005)(2616005)(66556008)(6666004)(316002)(966005)(508600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1YvbjVLa1VPaWdqQS9obmFlbmZjZHNweE1WOEdHODZjd0lXRjZxcVJ0Uk1F?=
 =?utf-8?B?bFlHeHprc2MrU2t4c25VK1ZFaUdMM3NKTkg2UHR0Qm5heHFHU0hqQWFUWlBG?=
 =?utf-8?B?STA2bU5vNWZzU1YrSk9GTERiVUhjYldFZkdqSVd1YmJKWnJaVlNaRm1RWWJV?=
 =?utf-8?B?VkJqci82M05LYmNQTDdrckVXZ1hzdEo1Q3FiTWx4Rm4rb2xPUTFHTjZxVHRx?=
 =?utf-8?B?NTZlREpFUmRGczVKTkJ3YVVoajZuRUxVTXp6ZEt4ek5qYTk0aG1uQi82bnh1?=
 =?utf-8?B?Z1NtU1pFUDl3YnpZVktZYW84ckgyTWxUZDZqTzJycTdiK3JRUUoyM1hJa2F2?=
 =?utf-8?B?SmQ1dU9YMjUxRGF5eFZTS0VzeG1CYk9EVHlvNEhYaGVmOXJESVNvTGROSW82?=
 =?utf-8?B?aCtqUU5kYktuTGJHY3NwbnIxUTZLS0s5Q1ptTEhGVnltdXMySkhRQUI3TGlp?=
 =?utf-8?B?dGdlVDBlUUpqQk9ESkdmS2YzeFFxWWFaeDRhV24yQXpUdGNUcDZoVHVTZUtl?=
 =?utf-8?B?MUZyTmpsOEhkTFFNcVIvTjA0T1NMZXgyelppSFU3cEJGcmJYS1A0c0E1SnZP?=
 =?utf-8?B?WmJDbEpEc2RONzJIck4wSGNIb0hBdTZvaFRRdU9YMTlHR0ptTjlOemNSd25N?=
 =?utf-8?B?eXVQTnd0N3VlM0k5TXZjYUxxd29FZHZVYXFrdncrd1ZzTDB3ZFdUYmcrc1FB?=
 =?utf-8?B?MGFnOW5NNThKeTVNTENrNStZT0ovekhheDM2Y0RZYzg4SnYvZUVYRlBQSzBh?=
 =?utf-8?B?dUU1Vmw1cXhhSkpjNTBCUU1KK0JoMzJQUVBwY3VwVEdJRzFMKzV6Sy9hMXIw?=
 =?utf-8?B?TTFhNDFlbjV4MEVKK2pHaktSUU8xTXM1SDVvalRmTXJqaFYyOVNlOTdWZDgv?=
 =?utf-8?B?U2FWTUo3WEJEbG1EeitDT2xaVGlCQTQrd3V6T1R3S1ZZT2NTV1pSS0RRRzEz?=
 =?utf-8?B?MG0vNjF6eklVYzJ3djZBTzVRV0FZTnY0MG5FTW4yZkM2L3Y3Zm85RnRyK0hK?=
 =?utf-8?B?QkJycTdYcVdWdlRQSUdOdmFtV1RlcTBUTW1lUkFZUC95NmxwOW1BM1ZMWHJX?=
 =?utf-8?B?WFlidExjME01cHFhUUQ5enhTalVvZk9SN2xrUDlYZW05cU04a2lXNm5TRlhq?=
 =?utf-8?B?b0RYMGtSWXZORllQU2FJMW5TdXBBb254emxtN290MVlPaEJGRjh4NzBBT3M4?=
 =?utf-8?B?cGFhRE9kQjhZYjlZQ05xdnNIM3h5c25KTitvQmczS2hGVVRvTDQ5Nk9YYU5k?=
 =?utf-8?B?emR5cmg5R0EwbzFjaXludUFaS1Nmdm1LUFUwYjUvZVRoU3Z1dGVWUU13dFBE?=
 =?utf-8?B?UTJJRm5iOU9oNWJLNlJqZDUzNEJwRmJleTcxY05qdUVCUHZuQ1NRaWp6NVkx?=
 =?utf-8?B?VHJIOVhMeGEyUU5CQmZ6dGtES09kVXlBeU9jVU42OVRaNVAzUVNFR2tkREcx?=
 =?utf-8?B?a09LeW11c0lVek9NY3NRem1qNkFZTG5QNGlia0I3ZUEwQUFCcmtuUHJKSGpZ?=
 =?utf-8?B?M2tqN2tyL0JMNDBSMHI1eWxta3Awc2lOYVZaYVFHWFFjeDFUdXlMblZPZFBO?=
 =?utf-8?B?ekI2WDVzbldzNXNzNkZ1M0JKd3FBN3k0U2lkbGN1cDVqWmtWUUY3WWs4aTlC?=
 =?utf-8?B?QmFuNUJpRG8wOVliUEN3TkZUU0ordjczbzdHR3J1TFNvazNMU3RwWTVwNElR?=
 =?utf-8?B?UTF3V3hLZFhxSm9VTkNJRDFqSjMvSGZHOTRNaWhGRE1KVzJUT3puTlpiaEl3?=
 =?utf-8?B?U3RFUDBvQVJvUGNxSUZMLy9VTzh3OWwrdDZkMnA2YkxYRUY0bUV2YWdMMTNX?=
 =?utf-8?B?Ti9GQ25Jc3hKSGJ5bXJ0MUFySXh0alZaVnJmVnI3REFMemtzbXJWakxIckN5?=
 =?utf-8?B?NXRGdVlhaU0yVnhYUS9mOHh0Lzd6KzVPMnQ0VXl2ck9SQ1grMDdUSGxJT3FI?=
 =?utf-8?B?V1Rpcm5Ia05vdGd1ZUVybVM4RVR1bi9aRlFTbVpGdnpDdktwM0EvYWhkT0F3?=
 =?utf-8?B?b0xwc0Y5UXRTc0NVNHVaZXZjRU05NXA4cXJDUmJucFVISWZFY25seGU5M1hZ?=
 =?utf-8?B?bFViV1BLQm9DenBTQU1wNllydzRBOGIyS01tK0NsL0ZsSE0wNW1Za0k4dFlu?=
 =?utf-8?B?bXBGM3hMalhETm9lUE52aFpabU5ZK3c5L1NNUncyZ0Z3M1NGRjRzb0g0TFhJ?=
 =?utf-8?Q?zbKabaU6uD16EuNIMfQcF8k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac14009d-9068-492a-3221-08d9d4338965
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 12:20:06.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjXOgCzo7+JcVUamoNEMe2uchI6HoYdDRi94h6JSvckVDKqE0p1Q5ON3A85uAy1WydcRMWVdPCjBG2/KKD1M7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3233
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/22 12:40, Thorsten Leemhuis wrote:
> On 07.01.22 18:44, Matthias Brugger wrote:
>> On 07/01/2022 17:51, Thorsten Leemhuis wrote:
>>> On 07.01.22 16:37, Matthias Brugger wrote:
>>>> On 07/01/2022 15:21, Thorsten Leemhuis wrote:
>>>>> Create a document explaining various aspects around regression handling
>>>>> and tracking both for users and developers. Among others describe the
>>>>> first rule of Linux kernel development and what it means in practice.
>>>>> Also explain what a regression actually is and how to report one
>>>>> properly. The text additionally provides a brief introduction to the
>>>>> bot
>>>>> the kernel's regression tracker uses to facilitate his work. To sum
>>>>> things up, provide a few quotes from Linus to show how serious he takes
>>>>> regressions.
>>>>>
>>>>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>>>> [...]
>>>>> +The important bits for people fixing regressions
>>>>> +================================================
>>>>> +
>>>>> +When receiving regression reports by mail, check if the reporter CCed
>>>>> `the
>>>>> +regression mailing list <https://lore.kernel.org/regressions/>`_
>>>>> +(regressions@lists.linux.dev). If not, forward or bounce the report
>>>>> to the Linux
>>>>> +kernel's regression tracker (regressions@leemhuis.info), unless you
>>>>> plan on
>>>>
>>>> I would have expected it to be the same mailing list
>>>> (regressions@lists.linux.dev), is this a typo maybe?
>>>
>>> Thx for taking a look. Hmm. That's possible, but I (and the grep call I
>>> just ran) fail to spot the typo.
>>>

I think that structure is much better, thanks!

Regards,
Matthias

>>> Maybe the wording is to confusing: regressions@lists.linux.dev is the
>>> list, regressions@leemhuis.info is a dedicated email address I (the
>>> kernel's regression tracker) use for regression tracking (which reminds
>>> me: maybe I should ask for a alias like regressions@kernel.org or
>>> regression-tracker@kernel.org).
>>
>> Yes it's the wording then :)
>> Anyway I just wonder why you we should send the regression to the
>> regressions email list, but only to the tracker email address. For me
>> that's the confusing part. I'd expect to send it to the list as well and
>> the tracker takes it from there. If for any reason someone does not want
>> to send a regression to the list, then he can send it to the tracker
>> directly. That's my understanding of how this works. If that's correct
>> then I'd say we should just explain the difference.
> 
> You comments made be revisit the section and made me spot a few other
> issues I found less than ideal. So I rewrote it over the weekend (more
> than once, to be precise...). I hope this clears things up.
> 
> ```
> The important bits for people fixing regressions
> ================================================
> 
> When submitting fixes for regressions, add "Link:" tags pointing to all
> places where the issue was reported, as tools like the Linux kernel
> regression bot 'regzbot' heavily rely on these; these pointers are also
> of great value for people looking into the issue some time in the
> future, as explained in `Documentation/process/submitting-patches.rst`
> and :ref:`Documentation/process/5.Posting.rst <development_posting>`::
> 
>         Link:
> https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
>         Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
> 
> Let the Linux kernel's regression tracker and all other subscribers of
> the `regression mailing list <https://lore.kernel.org/regressions/>`_
> (regressions@lists.linux.dev) quickly known about newly reported
> regressions:
> 
>   * When receiving a mailed report that did not CC the list, immediately
> send at least a brief "Reply-all" with the list CCed to get it into the
> loop; also ensure its CCed on all future replies, in case it got lost.
> 
>   * If you receive a report from a bug tracker, forward or bounce the
> report to the list, unless the reporter followed
> `Documentation/admin-guide/reporting-issues.rst` instructions and did it
> already.
> 
> [Optional] Ensure the Linux kernel regression bot 'regzbot' tracks the
> issue:
> 
>   * For mailed reports, check if the reporter included a 'regzbot
> command' like the ``#regzbot introduced v5.13..v5.14-rc1`` described
> above. If not, send a reply with the regressions list in CC, which
> includes a paragraph like the following:
> 
>         #regzbot ^introduced v5.13..v5.14-rc1
> 
>    Note, in this case there is a caret (^) before the `introduced` to
> make regzbot treat the parent mail (the one you reply to) as the report
> for the regression you want to see tracked.
> 
>    Instead of specifying a version range you can also state a commit-id,
> in case the reporter identified the culprit.
> 
>   * When receiving a report from a bug tracker and forwarding it to the
> regressions list (see above), include a paragraph like this:
> 
>         #regzbot introduced: v5.13..v5.14-rc1
>         #regzbot from: Some N. Ice Human <some.human@example.com>
>         #regzbot monitor:
> http://some.bugtracker.example.com/ticket?id=123456789
> ```
> 
> Note, regzbot does not yet support "#regzbot from" and "#regzbot monitor
> <bugtracker>", but I wanted to work on that soon anyway -- and this text
> will likely take weeks before it hits mailine, so this shouldn't be a
> problem.
> 
> Ciao, Thorsten
> 

