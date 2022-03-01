Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24A4C8F70
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiCAPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiCAPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:51:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9252B1D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Qk4S7BOXRaMh0OMC5LegIqh9bUrHyssgynnaD0BtCZY=; b=CvML4zN3tzI1rj/6KC35cM5EXT
        dfymMHDNX8oU71VsMB1M1qkJNp2Y+doMMyuLxtIm7at6Colg0tpgHyAhGp0tBX2EygjkrUr67tMES
        iMUMNiEY0nHQZ5RBqbiKstEeisDejk35l9EhHlm6jRqqd6jOYWdoLuP+7ep5pEZqYNZvVJ3UOVNS+
        urtFzIOciCFdNtGozo07F+0AJRua4da69Y9AZrPMZ/AiWBXOaDrAmEm81f9v8k6d8bdMG6WLfYHdo
        nS9MXPKevOf/Mw3ap2Rs/AOxE/THN4FsQdluRyC21vxpZoRs0JOkUUOUPwMPVOGIZBEp99fPn5wBz
        ZJfF9D+Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP4lN-00EIyG-Cb; Tue, 01 Mar 2022 15:50:09 +0000
Message-ID: <1bd8ef12-3770-5075-6fe1-a3f0ceed1b39@infradead.org>
Date:   Tue, 1 Mar 2022 07:50:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] printk: fix return value of printk.devkmsg __setup
 handler
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220228220556.23484-1-rdunlap@infradead.org>
 <87sfs17rsu.fsf@jogness.linutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87sfs17rsu.fsf@jogness.linutronix.de>
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



On 3/1/22 04:58, John Ogness wrote:
> On 2022-02-28, Randy Dunlap <rdunlap@infradead.org> wrote:
>> If an invalid option value is used with "printk.devkmsg=<value>",
>> it is silently ignored.
>> If a valid option value is used, it is honored but the wrong return
>> value (0) is used, indicating that the command line option had an
>> error and was not handled. This string is not added to init's
>> environment strings due to init/main.c::unknown_bootoption()
>> checking for a '.' in the boot option string and then considering
>> that string to be an "Unused module parameter".
>>
>> Print a warning message if a bad option string is used.
>> Always return 1 from the __setup handler to indicate that the command
>> line option has been handled.
>>
>> Fixes: 750afe7babd1 ("printk: add kernel parameter to control writes to /dev/kmsg")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
>> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
> 
> The message at this link is very helpful in explaining the state of
> declaring kernel parameters. Hopefully someday someone will document
> and/or comment this stuff.

I have added some docs to include/linux/init.h.
Andrew has it in his mmotm queue.

-- 
~Randy
