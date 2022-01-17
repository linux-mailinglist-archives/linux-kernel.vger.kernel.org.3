Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A12490C33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiAQQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:11:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41750 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbiAQQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:11:05 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Jcxj127Sfz1qxHZ;
        Mon, 17 Jan 2022 17:11:01 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Jcxj11LGyz1qqkB;
        Mon, 17 Jan 2022 17:11:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Q6HIU5Zbaqg4; Mon, 17 Jan 2022 17:11:00 +0100 (CET)
X-Auth-Info: WBIdWVkrdSiGmO+QDBQxoTmVr79e6qe1UsEYV5yN1imGIbBKMcVHNSoaZeLM3kUt
Received: from igel.home (ppp-46-244-183-111.dynamic.mnet-online.de [46.244.183.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Jan 2022 17:11:00 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 1E58D2C3ABC; Mon, 17 Jan 2022 17:10:59 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
References: <20220117154433.3124-1-changbin.du@gmail.com>
X-Yow:  Where's the Coke machine?  Tell me a joke!!
Date:   Mon, 17 Jan 2022 17:10:59 +0100
In-Reply-To: <20220117154433.3124-1-changbin.du@gmail.com> (Changbin Du's
        message of "Mon, 17 Jan 2022 23:44:33 +0800")
Message-ID: <87czkq7370.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17 2022, Changbin Du wrote:

> I tried different pieces of code which uses __builtin_frame_address(1)
> (with both gcc version 7.5.0 and 10.3.0) to verify whether it works as
> expected on riscv64. The result is negative.
>
> What the compiler had generated is as below:
> 31                      fp = (unsigned long)__builtin_frame_address(1);
>    0xffffffff80006024 <+200>:   ld      s1,0(s0)
>
> It takes '0(s0)' as the address of frame 1 (caller), but the actual address
> should be '-16(s0)'.
>
>           |       ...       | <-+
>           +-----------------+   |
>           | return address  |   |
>           | previous fp     |   |
>           | saved registers |   |
>           | local variables |   |
>   $fp --> |       ...       |   |
>           +-----------------+   |
>           | return address  |   |
>           | previous fp --------+
>           | saved registers |
>   $sp --> | local variables |
>           +-----------------+
>
> This leads the kernel can not dump the full stack trace on riscv.
>
> [    7.222126][    T1] Call Trace:
> [    7.222804][    T1] [<ffffffff80006058>] dump_backtrace+0x2c/0x3a
>
> This problem is not exposed on most riscv builds just because the '0(s0)'
> occasionally is the address frame 2 (caller's caller), if only ra and fp
> are stored in frame 1 (caller).
>
>           |       ...       | <-+
>           +-----------------+   |
>           | return address  |   |
>   $fp --> | previous fp     |   |
>           +-----------------+   |
>           | return address  |   |
>           | previous fp --------+
>           | saved registers |
>   $sp --> | local variables |
>           +-----------------+
>
> This could be a *bug* of gcc that should be fixed.

Yes, it would be nice to get this fixed.  The riscv target does not
override DYNAMIC_CHAIN_ADDRESS, thus the default is used, which has the
noted effect.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
