Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA051AF85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiEDUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378446AbiEDUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:44:12 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13F2CE2B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:40:32 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 63FAF4076248;
        Wed,  4 May 2022 20:40:26 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 04 May 2022 23:40:26 +0300
From:   baskov@ispras.ru
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Parse CONFIG_CMDLINE in compressed kernel
In-Reply-To: <YnJAYOHBjipBfdm3@zn.tnic>
References: <20220407024014.6916-1-baskov@ispras.ru>
 <YnJAYOHBjipBfdm3@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3d0a8b229544ef879d05fee74849619d@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-04 11:59, Borislav Petkov wrote:
> On Thu, Apr 07, 2022 at 05:40:14AM +0300, Baskov Evgeniy wrote:
>> CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE was ignored
>> during options lookup in compressed kernel, including
>> earlyprintk option, so it was impossible to get earlyprintk
>> messages from that stage of boot process via command line
>> provided at compile time. Being able to enable earlyprintk
>> via compile-time option might be desirable for booting
>> on systems with broken UEFI command line arguments via EFISTUB.
>> 
>> Parse CONFIG_CMDLINE-related options correctly in compressed
>> kernel code.
>> 
>> Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
>> 
>> diff --git a/arch/x86/boot/compressed/cmdline.c 
>> b/arch/x86/boot/compressed/cmdline.c
>> index f1add5d85da9..dd8cbbe61dff 100644
>> --- a/arch/x86/boot/compressed/cmdline.c
>> +++ b/arch/x86/boot/compressed/cmdline.c
>> @@ -22,9 +22,49 @@ unsigned long get_cmd_line_ptr(void)
>>  }
>>  int cmdline_find_option(const char *option, char *buffer, int 
>> bufsize)
>>  {
>> -	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, 
>> bufsize);
>> +	int len = -1;
>> +	unsigned long cmdline_ptr;
>> +
>> +	/*
>> +	 * First try command line string provided by user,
>> +	 * then try command line string configured at comple time.
>> +	 * Skip first step if CONFIG_CMDLINE_OVERRIDE is enabled
>> +	 * and parse only compile time command line.
>> +	 */
>> +
>> +	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
>> +		cmdline_ptr = get_cmd_line_ptr();
>> +		len = __cmdline_find_option(cmdline_ptr, option,
>> +					    buffer, bufsize);
>> +	}
>> +
>> +#ifdef CONFIG_CMDLINE_BOOL
>> +	if (len < 0) {
>> +		cmdline_ptr = (unsigned long)CONFIG_CMDLINE;
>> +		len = __cmdline_find_option(cmdline_ptr, option,
>> +					    buffer, bufsize);
>> +	}
>> +#endif
> 
> Do I see it correctly that all this logic boils down to returning the
> proper cmdline ptr and so you can do that once in get_cmd_line_ptr()
> instead of duplicating the ifdeffery?

Yes, it can be done by returning either concatenation of build-time
and run-time command line strings or only the build-time one,
depending on the kernel configuration.

Actually, it is implemented this way in arch/x86/kernel/setup.c.
I thought it's better to avoid imposing restrictions on kernel
command line length, but since it is already done, I guess,
I will do the same way in v2.

Thanks,
Baskov Evgeniy
