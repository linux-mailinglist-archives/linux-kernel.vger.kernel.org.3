Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51E6524072
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbiEKW6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbiEKW6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:58:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EA59976
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:57:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652309877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdeReNTQu3w1wW6UHfmVSMZkbFrD67zySL7zMBb8xMQ=;
        b=uWCA76a7wTK/ZXfsrxpngC/jOSLLUlw9uenY3ijmhl8Nxuh/g7PAxx1VxtitXvPCRXyDH5
        IzvjliNKTI31tC5fXUVse1kVDmWevznK6YI34S2G6vAYt4cLwqjIVYxMSD84sZS1R76wZV
        eoGFW71ScrYY762ApsNmh1NmDZp/NbDlF3vOSAK3sDXKK8hNo6inhCBZDjWiISis07Mb1Z
        V6gi8vrLQr0ZlYUwKW8cvfYgTZ49aCuVDIxvGAJlYYxQs+WN+UCMTWswsZRGH2cH/042Pn
        Vkpe5OAa2YuT2DNVfrKfphBTKpVHOekvKwS3wSsR0KQ5ZwZ1xDI2VVEmeKzsHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652309877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdeReNTQu3w1wW6UHfmVSMZkbFrD67zySL7zMBb8xMQ=;
        b=oU/j3S9dg6gmCpOLEWoOKuwst9AD4kLGAnpG+4DY/iSKLosgUu6DXkfpLu5nCP/wN9zQwk
        nsUfOTJFsIEyzyAg==
To:     Stephen Boyd <swboyd@chromium.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] timers: Provide a better debugobjects hint for delayed
 works
In-Reply-To: <CAE-0n51KTiQjVqJgFe3S9qCiTM+2jdqyVZ1trNO1KanbQJccyA@mail.gmail.com>
References: <20220504223148.644228-1-swboyd@chromium.org>
 <87sfphpwvy.ffs@tglx>
 <CAE-0n51KTiQjVqJgFe3S9qCiTM+2jdqyVZ1trNO1KanbQJccyA@mail.gmail.com>
Date:   Thu, 12 May 2022 00:57:57 +0200
Message-ID: <878rr7y8wa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 13:02, Stephen Boyd wrote:
> Quoting Thomas Gleixner (2022-05-10 02:20:01)
>>  static void *timer_debug_hint(void *addr)
>>  {
>> -       return ((struct timer_list *) addr)->function;
>> +       struct timer_list *timer = addr;
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(timer_hints); i++) {
>> +               if (timer_hints[i].function == timer->function)
>> +                       return addr + timer_hints[i].offset;
>
> This locates the correct address of the function pointer 'work.func' but
> it needs to be dereferenced to return the function's address instead of
> the pointer to the function. We don't really care about the function
> signature so we could cast it to a void function pointer and deref:
>
>                       void (**fn)(void) = addr + timer_hints[i].offset;

That's why I said: "So maybe something like the uncompiled/untested
below."

I was pretty sure that I missed some nasty detail.

> I'll send this version of the patch.

Appreciated.

Thanks,

        tglx
