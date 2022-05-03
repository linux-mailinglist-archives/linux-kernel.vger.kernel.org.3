Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BAB518B09
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiECR3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240340AbiECR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78621E29
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KPMWPhYqEQF1ltoFBxRxCax/s1QZtZqIo48r/AMIaYE=; b=hCsPe0mEC+Saf+/kwAxM1SrY7L
        3rQm3LYAinl9ekWKGZREBvFneuZKpGWFaD4RLGs9XHKu+wKqHw4r2QcDAeWpWEVM8l+eUe9e37hS7
        30eufNmZa2F6HkniML8ldHeuvkqXQcQ409DrAwMcI5AzLQBh9+DuvcBSjXMq25HvaqoPwPFzUm32d
        Tix0oIb2dHwwxpGgUfW6Qd1OhdVgcxooI5epN3T5YA1gETn6s0EgYNoC3uPuSwdR65ajusY2HD9vE
        5FifMB6xq9h0ridcn4B46Z/wdcc95NMFb2K5wxYwQXK+jUHMXDSrJgIjO6HSTEp/u91cR5kTO6NSh
        ZVzs8QZA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlwHo-00FpVI-ID; Tue, 03 May 2022 17:26:08 +0000
Message-ID: <dcb534d5-e9b7-74b3-4088-eb498adb9ec2@infradead.org>
Date:   Tue, 3 May 2022 10:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: BUG: vfork() returns EINVAL after unshare(CLONE_NEWTIME)
Content-Language: en-US
To:     =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <CAEmTpZGJxtTuq8LDTLDK4V8to_Z30WEmo=p_2umboHvZaDr=Xg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEmTpZGJxtTuq8LDTLDK4V8to_Z30WEmo=p_2umboHvZaDr=Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add some readers:]

On 3/31/22 01:36, Марк Коренберг wrote:
> test:
> ----------------------------------------
> #define _GNU_SOURCE 1
> #include <stdio.h>
> #include <sched.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <err.h>
> 
> #ifndef CLONE_NEWTIME
> #define CLONE_NEWTIME   0x00000080
> #endif
> 
> int main (void)
> {
>   if (unshare (CLONE_NEWTIME))  err (EXIT_FAILURE, "UNSHARE_NEWTIME");
> 
>   pid_t pid;
>   switch (pid=vfork ())
>   {
>   case 0:
>     _exit(0);
>   case -1:
>     err(EXIT_FAILURE, "vfork BUG");
>   default:
>     waitpid(pid, NULL, 0);
>   }
>   return 0;
> }
> -----------------------------------------------
> 
> Seems the bug in kernel/fork.c. It does not check for CLONE_VFORK
> 
> if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
>     if (nsp->time_ns != nsp->time_ns_for_children)
>         return ERR_PTR(-EINVAL);
> }
> 
> -----------------------------------
> Changing vfork() to fork() in the program works ok.
> The bug has been found during regression in our system because Python
> 3.10 runs subprocesses using vfork()+execve().
> 

-- 
~Randy
