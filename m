Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D84850BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiAEKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:09:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41548 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiAEKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:09:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50733B81964
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7424BC36AEB;
        Wed,  5 Jan 2022 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641377384;
        bh=D0+qyRmDko+O3mn6+d0pVvsip0kFrK7s/RqQWhXS+oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUESPgrChmBJ759mlrX5FZop/jACBWVlP0LVXyMC2U6GrUHV4PI8qdAXeA3JhwquQ
         vVgo3KK2PjUryXUTjSdZF9IQ2Ka7FGSrFxz0qWaSXxcsALUUvuQvWH6kbHQXAp3MiY
         wQPaUGB+dp6EE5BO1MIog3tPZAGT0vzTaGw4qwoo=
Date:   Wed, 5 Jan 2022 11:09:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     arve@android.com, chi.minghao@zte.com.cn, christian@brauner.io,
        hridya@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, zealci@zte.com.cn
Subject: Re: 'Re: [PATCH] drivers/android: remove redundant ret variable'
Message-ID: <YdVuZRps9HP0Udmc@kroah.com>
References: <YdQzNX77nT2OIh7W@kroah.com>
 <20220105091942.616961-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105091942.616961-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:19:42AM +0000, cgel.zte@gmail.com wrote:
> I found that there are indeed some optimizations
> after removing the redundancy.

You stripped off all context, making this impossible to remember what
you are responding to :(

> 
> For example:
> 
> int foo(int a, int b)
> {
>         int ret;
>         ret = a>b ? a: b;
>         return ret;
> }
> int main()
> {
>         int val;
>         val = foo(7,2);
>         return 0;
> }
> 
> and
> 
> int foo(int a, int b)
> {
>         return a>b ? a: b;
> }
> int main()
> {
>         int val;
>         val = foo(7,2);
>         return 0;
> }
> 
> The corresponding disassembly code is as follows：
> 
>     1129:       f3 0f 1e fa             endbr64 
>     112d:       55                      push   %rbp
>     112e:       48 89 e5                mov    %rsp,%rbp
>     1131:       89 7d fc                mov    %edi,-0x4(%rbp)
>     1134:       89 75 f8                mov    %esi,-0x8(%rbp)
>     1137:       8b 45 fc                mov    -0x4(%rbp),%eax
>     113a:       39 45 f8                cmp    %eax,-0x8(%rbp)
>     113d:       0f 4d 45 f8             cmovge -0x8(%rbp),%eax
>     1141:       5d                      pop    %rbp
>     1142:       c3                      retq
> 
> and
> 
>     1129:       f3 0f 1e fa             endbr64 
>     112d:       55                      push   %rbp
>     112e:       48 89 e5                mov    %rsp,%rbp
>     1131:       89 7d ec                mov    %edi,-0x14(%rbp)
>     1134:       89 75 e8                mov    %esi,-0x18(%rbp)
>     1137:       8b 45 ec                mov    -0x14(%rbp),%eax
>     113a:       39 45 e8                cmp    %eax,-0x18(%rbp)
>     113d:       0f 4d 45 e8             cmovge -0x18(%rbp),%eax
>     1141:       89 45 fc                mov    %eax,-0x4(%rbp)
>     1144:       8b 45 fc                mov    -0x4(%rbp),%eax
>     1147:       5d                      pop    %rbp
>     1148:       c3                      retq
> 
> After removing the redundancy, the compiler does
> have some optimizations

As I said on your other email, look at the kernel built files please,
they should be much different from your tiny example above.

thanks,

greg k-h
