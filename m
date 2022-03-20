Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CC4E1C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiCTPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbiCTPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:10:30 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72B22514
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 08:09:07 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.4])
        by gnuweeb.org (Postfix) with ESMTPSA id E05F07E2C4;
        Sun, 20 Mar 2022 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647788946;
        bh=RI2pkVzqveOuxBvWu4F+M+4HsSWEh++MgqMXUyJVxAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SlHIXPUJv10qRdUSpDIrnBebOXtYKTB7PW7pS788CWApSybPqObMyCQLgooiENeyU
         eG7btVKoK70FC5a9oKEoc0JANIh/RBi3MFvMyPsPy6JfHJxHPXXe364cgYxWsaa8je
         ZdnrKtul2psQvyXeOLTKRUYLZIten7J/rn61AwixHNPZoE36oR5FDO/AtM2+G6UvLF
         AZIGhlzshtTcpobPbeOf6fyTkWxwQlBQ9YUtFy5T3IE4MxMuxFt3beD72P7Axh5h2/
         R5keyd7OCg02CvBW5u4fr65q6ekM8FN5wWLwSgS6wkOO6sQcaNvMREy6I8cbr0Xc3M
         pzrNDHEntGM2Q==
Message-ID: <9ba9c8bd-d4e1-a9c5-9269-4cecb1b109f6@gnuweeb.org>
Date:   Sun, 20 Mar 2022 22:09:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6
 arguments
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        x86@kernel.org, llvm@lists.linux.dev,
        David Laight <David.Laight@ACULAB.COM>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
 <CAOG64qO5b30GjyYxoRj9QLJpfaa-o40W1oYL0XuZ8C5QX17bww@mail.gmail.com>
 <CAOG64qPyXS-NVE6wV2fs8ho5B88ziZrO9mL3cgZrLRqf6tmmQA@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAOG64qPyXS-NVE6wV2fs8ho5B88ziZrO9mL3cgZrLRqf6tmmQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/22 5:42 PM, Alviro Iskandar Setiawan wrote:
> On Sun, Mar 20, 2022 at 5:33 PM Alviro Iskandar Setiawan wrote:
[...]
>> I don't think you can safely use redzone from inline Assembly. The
>> compiler may also use redzone for a leaf function. In case the syscall
>> is done at the same time, your %ebp saving will clobber the redzone
>> that the compiler uses.

It turned out we don't have a redzone for 32-bit.

>>
>> -4(%esp) may be used by the compiler on a leaf call, you can't clobber that.

Yeah, this is still wrong even with a redzone.

> Using xchgl to preserve %ebp in the same place where the arg6 is
> stored in memory is a better solution and doesn't clobber anything.
> 
>      xchgl %ebp, %[arg6]
>      int    $0x80
>      xchgl %ebp, %[arg6]

Addressed your review in my response to David.

Thanks!

-- 
Ammar Faizi
