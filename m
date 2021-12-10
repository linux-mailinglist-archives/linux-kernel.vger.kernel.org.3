Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3A4709CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbhLJTJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:09:34 -0500
Received: from mx-out.tlen.pl ([193.222.135.158]:43080 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245697AbhLJTJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:09:32 -0500
Received: (wp-smtpd smtp.tlen.pl 36088 invoked from network); 10 Dec 2021 20:05:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1639163151; bh=XlxCGbBCaxE7x41aV4Afh/rZ2qOx8kmOLzHrK+2sw5Q=;
          h=Subject:To:Cc:From;
          b=fCiwlsDadw8GKJjLL15QfPeP+pcSYHChot/2emwu+LCoQXlIxAAGCGUpfcFjurX2k
           BfR3DUVR7hhJIxUbEUD3eunGXKbNb7AHcSAodCs2Pt/pdlpCHx/Ok3O+D3nvZIa2lN
           0uxP1tDY33gmHHQJo1orHfYJmZxgaadqsRQxZe1M=
Received: from aaff136.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.135.136])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <alexandre.belloni@bootlin.com>; 10 Dec 2021 20:05:51 +0100
Message-ID: <5efcbdad-972d-2159-34ea-97eb6e29c613@o2.pl>
Date:   Fri, 10 Dec 2021 20:05:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH RESEND v3 2/7] rtc-mc146818-lib: fix RTC presence check
Content-Language: en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20211119204221.66918-1-mat.jonczyk@o2.pl>
 <20211119204221.66918-3-mat.jonczyk@o2.pl> <YZ69RB0ePgaHcqVm@piout.net>
 <277177e7-46a0-522c-297c-ad3ee0c15793@o2.pl> <YbNxum2SgyW97dyB@piout.net>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <YbNxum2SgyW97dyB@piout.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: d1c25c1f610b53f62f5903bfd35bf89c
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [8SOU]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 10.12.2021 o 16:26, Alexandre Belloni pisze:
> Hi,
>
> On 25/11/2021 23:12:42+0100, Mateusz Jończyk wrote:
>> W dniu 24.11.2021 o 23:31, Alexandre Belloni pisze:
>>> Hello,
>>>
>>> By moving this patch later on in the series, you'd avoid the subsequent
>>> refactor. I think this would be better for bisection later on.
>> Hi,
>>
>> There are three issues I'm trying to fix in this series:
>>
>> 1. (less important) Insufficient locking in cmos_set_alarm()
>> 2. misdetection of the RTC CMOS as broken on some motherboards,
>> 3. reading / writing of the RTC alarm time during RTC update-in-progress.
>>
>> Do you mean I should drop the patch
>>     nr 2. ("rtc-mc146818-lib: fix RTC presence check")
>> and instead straight away introduce mc146818_avoid_UIP() with the new approach (as in patch 3 in the series),
>> then modify mc146818_get_time() to use it (as in patch 4 - fixing issue nr 2),
>> then modify cmos_read_alarm / cmos_set_alarm to use mc146818_avoid_UIP() (patches 5-6, fixing issue no. 3)?
>>
>> I was afraid this risks some confusion what is being fixed when.
> I realize I never replied to this. This is fine, I'm planning to apply
> the whole series once the few comments are fixed.

Great!

I've got other things mostly sorted out and tested, so I'll send a v4 shortly after some last-minute checks.

> We'll probably get some breakage later on because many RTCs using this
> driver are not adhering to the spec.
>
Thanks,

Mateusz
