Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA449212B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbiARI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiARI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:27:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E73B80932
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 08:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F0C00446;
        Tue, 18 Jan 2022 08:26:59 +0000 (UTC)
Subject: Re: [PATCH v2 RESEND] m68k/kernel: array out of bound access in
 process_uboot_commandline
To:     Hangyu Hua <hbh25y@gmail.com>
References: <9775e266-5fee-b0e9-7fa3-b602ec4b7796 () gmail ! com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <a7483172-09dc-21ad-d674-25b7015156fd@linux-m68k.org>
Date:   Tue, 18 Jan 2022 18:26:56 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9775e266-5fee-b0e9-7fa3-b602ec4b7796 () gmail ! com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

On 18/1/22 12:18 pm, Hangyu Hua wrote:
> Hi Greg,
> 
> On 2022/1/17 下午12:03, Greg Ungerer wrote:
>> Hi Hangyu,
>>
>> On 13/1/22 11:58 am, Hangyu Hua wrote:
>>> When the size of commandp >= size, array out of bound write occurs
>>> because
>>> len == 0.
>>>
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> ---
>>>    arch/m68k/kernel/uboot.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
>>> index 928dbd33fc4a..63eaf3c3ddcd 100644
>>> --- a/arch/m68k/kernel/uboot.c
>>> +++ b/arch/m68k/kernel/uboot.c
>>> @@ -101,5 +101,6 @@ __init void process_uboot_commandline(char
>>> *commandp, int size)
>>>        }
>>>        parse_uboot_commandline(commandp, len);
>>> -    commandp[len - 1] = 0;
>>> +    if (len > 0)
>>> +        commandp[len - 1] = 0;
>>>    }
>>>
>>
>> I am not convinced this is wrong for the reason you think it is.
>> Looking at the code in its entirety:
>>
>> __init void process_uboot_commandline(char *commandp, int size)
>> {
>>           int len, n;
>>
>>           n = strnlen(commandp, size);
>>           commandp += n;
>>           len = size - n;
>>           if (len) {
>>                   /* Add the whitespace separator */
>>                   *commandp++ = ' ';
>>                   len--;
>>           }
>>
>>           parse_uboot_commandline(commandp, len);
>>           commandp[len - 1] = 0;
>> }
>>
>>
>> "commandp" is moved based on the return of the strnlen(). So in the
>> case of commandp actually being full of valid characters (so n == size,
>> and thus len == 0) the commandp technically points outside of its
>> real size at that point. But "command[[len - 1]" would actually be
>> pointing to the last char in the original commandp array (so the original
>> commandp[size - 1]). Well at least if you are happy with the use of
>> negative array indexes.
>>
> 
> You mean this is a friendly out of bound beacause "command[[len - 1]"
> pointing to the last char in the original commandp array. I used to
> think command[[len - 1] = 0 may be a zero-terminated for command. You
> can see my discussion with Andreas Schwab and my patch v1 in
> 
> https://lore.kernel.org/all/CAOo-nLJG71QqqD0-cJDyH0rY2VTx1eO9nHVQ5MCe8J0iiME_vw@mail.gmail.com/
> 
> But this still be a out of bound write because "commandp" is a macro
> definition with a fixed size.

No, "commandp" is not a macro, it is a parameter to this function, is a char pointer.
It points into a char array of size "size" (which will be non-zero).
It is modified during execution of this function.
I don't see an out-of-bound write here.


>> Clearly this could be structured better. There is no point in calling
>> parse_uboot_commandline() if len == 0, or even if len == 1, since you
>> cannot add anymore to the command line, it is full.
>>
> I think it is no point too. But the caller (setup_arch()) don't check
> the size of "commandp" before call parse_uboot_commandline(). Instead we
> do this in parse_uboot_commandline(). So it may be better to move these
> checks to the caller ?

No, I don't think so. The caller doesn't care if it is already full.
And the common case is that process_uboot_commandline() is empty
when CONFIG_UBOOT is not enabled.

Regards
Greg


