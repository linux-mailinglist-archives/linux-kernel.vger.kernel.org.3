Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7B46D652
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhLHPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhLHPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:03:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jgCvwvBLxBj0XGij3D6WvN7slZ7rVf4ti8R9qgLF2XU=; b=TgBV/AzgLF3d+phdOY++rqp+fa
        ZzylsQfcARw/Od7W023AInIJvHapGRO1TUqoggS/U4pbcjBhRpO1ra54aiCKtcP8vyqY9bJgqaIi+
        FVUtDpWI+U1nLgCkxy1f/ffQXCoTH20ZxDpLfKlW76xzymAqck4UB4w2MiCOt653mvPN9UOskjLP6
        /IBRjcM/6/0SL6texcbFrR4y3rNvW8hHFAUKAMPcdsdaohHwUZgL+Qb90J5SGPAW3JnwDsyfPvrrH
        WDOazY+6uGrunMkDThQ8WeGS9BqCdk/QgxvBozmUq2NNiB0K/xk8XxogrykZ+Ip0u4qg1h/QYZmgX
        3fqGicbQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muyQD-008Vue-Vv; Wed, 08 Dec 2021 14:59:54 +0000
Message-ID: <1605c37e-4a6b-002e-e70c-eddb979f18ec@infradead.org>
Date:   Wed, 8 Dec 2021 06:59:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] binder: fix pointer cast warning
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
References: <20211207122448.1185769-1-arnd@kernel.org>
 <20211208100930.undojzgd7ylmnz3i@wittgenstein>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211208100930.undojzgd7ylmnz3i@wittgenstein>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/21 02:09, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 01:24:42PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> binder_uintptr_t is not the same as uintptr_t, so converting it into a
>> pointer requires a second cast:
>>
>> drivers/android/binder.c: In function 'binder_translate_fd_array':
>> drivers/android/binder.c:2511:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>  2511 |         sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
>>       |                            ^
>>
>> Fixes: 656e01f3ab54 ("binder: read pre-translated fds from sender buffer")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
> 
> Looks good.
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

-- 
~Randy
