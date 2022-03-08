Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F534D2332
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350414AbiCHVU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350357AbiCHVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:20:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028B64AE01;
        Tue,  8 Mar 2022 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=j5ZN+IAAztFuJh5l3U8Vq4bOu5JLU5wwE3OHp1I+9yI=; b=HwyoKhKApYaXBedHXnuWl0gtXV
        eKn/R+yVkngBQ2GQPnCK/wuZdfEfRp2ViEuojc2qjuYB+9CGS2pd14fXjEq6UotWssFPLjMO/w+xp
        DILk4bcdfsIg2zPevmsQXAqfW7scXXPS0zklQG9SykPjdPLeD+y6xZEGxmqeQMXCLah07iQrq+C76
        y2LN1lB/dGn1AutHT0oj/F3k1M/ybqYO/sHC9gB8RXZ0J0/YmyLgcEk0KRT7PMUCCj/TP8sFsfdsI
        P9327bWYcE3i3cg5h54TsD/NMnjiy/0kYwJ+qv7zeomvgqxRhPeBw//zKS2dTxEmd0E+giXlDcyYn
        Naj0D4sg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRhFB-00GXvJ-IX; Tue, 08 Mar 2022 21:19:46 +0000
Message-ID: <2c693cb8-f4b8-a723-c804-9492d9cc4881@infradead.org>
Date:   Tue, 8 Mar 2022 13:19:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] kgdboc: fix return value of __setup handler
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org
References: <20220308033241.22099-1-rdunlap@infradead.org>
 <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 3/8/22 08:04, Doug Anderson wrote:
> Hi,
> 
> On Mon, Mar 7, 2022 at 7:32 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> __setup() handlers should return 1 to indicate that the boot option
>> has been handled. A return of 0 causes the boot option/value to be
>> listed as an Unknown kernel parameter and added to init's (limited)
>> environment strings. So return 1 from kgdboc_option_setup().
> 
> This took me about 20 minutes to trace through the code to confirm,
> but it appears you're correct. It's pretty twisted that early_param()
> and __setup(), both of which add things to the same list, work exactly
> opposite here. :( Any chance I could convince you to:
> 
> 1. Add a comment before the definition of __setup_param() explaining
> that 0 means error and 1 means no error. There's a comment next to
> early_param() that _implies_ that setup is the opposite(), but it'd be
> nice to see documentation of __setup(). I know __setup() is supposed
> to be "only for core code", but still seems like we could document it.

I have already done this. The patch is in Andrew's mmotm tree (patch queue).

> 2. Add something to your commit message helping someone find the place
> where the return value is checked. Basically just mention
> obsolete_checksetup() to give people a hint.
> 

Sure, no problem. Good idea.

> 
>> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
>>   kgdboc=kbd kgdbts=", will be passed to user space.
>>
>>  Run /sbin/init as init process
>>    with arguments:
>>      /sbin/init
>>    with environment:
>>      HOME=/
>>      TERM=linux
>>      BOOT_IMAGE=/boot/bzImage-517rc7
>>      kgdboc=kbd
>>      kgdbts=
>>
>> Fixes: 1cd25cbb2fed ("kgdboc: Fix warning with module build")
> 
> Are you certain about this "Fixes" line? That commit was just code
> motion to move the code inside the #ifdef. It sure looks like it was
> broken even before this.
> 

Yes, but I am not enough of a git user to be able to backtrack
to see where this code was added. :(
(help?)

> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
>> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
>> Cc: Laura Abbott <labbott@redhat.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: kgdb-bugreport@lists.sourceforge.net
>> Cc: Jason Wessel <jason.wessel@windriver.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Cc: linux-serial@vger.kernel.org
>> ---
>>  drivers/tty/serial/kgdboc.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> --- lnx-517-rc7.orig/drivers/tty/serial/kgdboc.c
>> +++ lnx-517-rc7/drivers/tty/serial/kgdboc.c
>> @@ -403,16 +403,16 @@ static int kgdboc_option_setup(char *opt
>>  {
>>         if (!opt) {
>>                 pr_err("config string not provided\n");
>> -               return -EINVAL;
>> +               return 1;
> 
> Shouldn't it return 0 in the error cases? If __setup() functions are
> supposed to return "1" no matter what then what was the purpose of
> having a return value in the first place?

It should return 0 if the string(s) should be added to init's arg or env
strings, which is probably very rare. I don't know why it has a return
value in the first place. Someone else has already suggested that __setup()
functions should be void. Maybe they should one day, but that's a much
larger patch.

I'll send a v2.

thanks.
-- 
~Randy
