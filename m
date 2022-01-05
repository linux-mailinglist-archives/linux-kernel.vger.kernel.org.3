Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420544850B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiAEKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiAEKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:09:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43258C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:09:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25659616AE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63228C36AEB;
        Wed,  5 Jan 2022 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641377338;
        bh=vszags4f61XmoqMHQ0WsiGlgt8KGGLOuKDImhaLeyTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU0JUlYlesjtlv2BlLOmFSW5M8+4Az9HLihf6DKSpCkSLoZxrrJ2SoVfqYHGc2Ets
         jZzBWTvCSiLZikJDJkWgH+q5TBZS3S0OXurxX0d8F9aNaSqkN4DwOsNYTb+lXmWKcW
         jOFEfpjnkw1GBRyFbOGn175FDrwGnlr8ZGNN4sfQ=
Date:   Wed, 5 Jan 2022 11:08:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     arnd@arndb.de, chi.minghao@zte.com.cn, fkassabri@habana.ai,
        linux-kernel@vger.kernel.org, obitton@habana.ai,
        ogabbay@kernel.org, osharabi@habana.ai, ynudelman@habana.ai,
        zealci@zte.com.cn
Subject: Re: [PATCH misc-next] drivers/misc: remove redundant rc variable
Message-ID: <YdVuNiJZ7oJDkVL/@kroah.com>
References: <YdQzUPW5FI0yIi0P@kroah.com>
 <20220105092229.617027-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105092229.617027-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:22:29AM +0000, cgel.zte@gmail.com wrote:
> I found that there are indeed some optimizations
> after removing the redundancy.
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

Please look at the actual output of the kernel files, the build options
that the kernel enforces should not cause a difference here.

thanks,

greg k-h
