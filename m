Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547405843E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiG1QOR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Jul 2022 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiG1QNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:13:49 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 09:13:48 PDT
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDB06E8AD;
        Thu, 28 Jul 2022 09:13:48 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 7D45FC14FE;
        Thu, 28 Jul 2022 16:07:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 59FCD60017;
        Thu, 28 Jul 2022 16:07:17 +0000 (UTC)
Date:   Thu, 28 Jul 2022 09:07:13 -0700
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sedat.dilek@gmail.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V2] rtla: Fix Makefile when called from -C tools/
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+icZUX2v-u8tL-U73hZJ0nNHXJ6XQYPupTRBV9QaQN88OF2bw@mail.gmail.com>
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org> <CA+icZUV9waE16ZW4RNEDeiemv6eRd=MetzdGbF-vpfT_u1N4_w@mail.gmail.com> <CA+icZUX2v-u8tL-U73hZJ0nNHXJ6XQYPupTRBV9QaQN88OF2bw@mail.gmail.com>
Message-ID: <8F70EC88-7DCD-43DB-9C59-55CD13D3141C@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Queue-Id: 59FCD60017
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: maijx8rq4potqe19ekdjge7anws66qej
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+5Eq7VH7nYvxWpVY8RUXyydhWNv7z1uUI=
X-HE-Tag: 1659024437-418652
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 28, 2022 1:15:34 AM PDT, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>On Thu, Jul 28, 2022 at 10:01 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> Hi,
>>
>> what is the status of this patch?
>>
>> Is it missing some ACKs e.g. from Steven?
>>
>> Can this go directly to Linus tree as I wanted to see it in Linux v5.19 FINAL?
>>
>> Thanks.
>>
>
>INFO:
>
>Steven's autoresponder says:
>
>I'm currently traveling and may be slow to respond (and may not at all).
>I'll be back at my normal hours on Tuesday, Aug 2nd.


Yes, I'm currently at the SCaLE 19x conference, but I plan on pulling in rtla and rv work while I'm here.

-- Steve

>
>Here the lore-link to v2:
>
>[1] https://lore.kernel.org/all/870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org/
>
>-Sedat-
>
>>
>> > ---
>> >  tools/tracing/rtla/Makefile | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
>> > index 3822f4ea5f49..1bea2d16d4c1 100644
>> > --- a/tools/tracing/rtla/Makefile
>> > +++ b/tools/tracing/rtla/Makefile
>> > @@ -1,6 +1,6 @@
>> >  NAME   :=      rtla
>> >  # Follow the kernel version
>> > -VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
>> > +VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
>> >
>> >  # From libtracefs:
>> >  # Makefiles suck: This macro sets a default value of $(2) for the
>> > --
>> > 2.32.0
>> >

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
