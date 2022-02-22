Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD94BF455
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiBVJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBVJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:07:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3C91ADD;
        Tue, 22 Feb 2022 01:06:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 50FD21F399;
        Tue, 22 Feb 2022 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645520800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/LVQSPM0+gRMDi2FOUGYqJgSwskl7j6aSDk/opAFqC0=;
        b=VCYKjD0IROJSMzsv6khIE/RrtY9lMiVibJHbTUcNyLUtQVMhbBj7LeKjuRouYBg4kOdfnx
        qgwvcZEsn2ZI5Rw0aF50c80UPO2wvs1YRRGTnrF8eVOjTJuU6wRl8b8EgSO/m4gFgkFczS
        mL3wyiZUXeh/hfiefIEsOQrfQtUHveg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA392A3B85;
        Tue, 22 Feb 2022 09:06:37 +0000 (UTC)
Date:   Tue, 22 Feb 2022 10:06:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 10/20] rust: add `kernel` crate
Message-ID: <YhSnnHpIeDReK/eL@alley>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-11-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212130410.6901-11-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-02-12 14:03:36, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> The `kernel` crate currently includes all the abstractions that wrap
> kernel features written in C.
> 
> These abstractions call the C side of the kernel via the generated
> bindings with the `bindgen` tool. Modules developed in Rust should
> never call the bindings themselves.
> 
> In the future, as the abstractions grow in number, we may need
> to split this crate into several, possibly following a similar
> subdivision in subsystems as the kernel itself and/or moving
> the code to the actual subsystems.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 82abfaf3c2aa..c042386667f2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -392,7 +392,10 @@ static struct latched_seq clear_seq = {
>  /* the maximum size of a formatted record (i.e. with prefix added per line) */
>  #define CONSOLE_LOG_MAX		1024
>  
> -/* the maximum size allowed to be reserved for a record */
> +/*
> + * The maximum size allowed to be reserved for a record.
> + * Keep in sync with rust/kernel/print.rs.
> + */
>  #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)

What exactly should we keep in sync, please?

I see only handling of KERN_* prefix in print.rs. I do not see there
any counter part of LOG_LINE_MAX, CONSOLE_LOG_MAX, or PREFIX_MAX.

Also note that PREFIX_MAX is the maximal lenght of the prefix printed
on console. It is log level + time stamp + caller id. For example:

<12>[  123.632345][ T3260]

It seems that print.rs defines max size of the prefix in the printk
format where the log level is defined using KERN_* pair of characters.

>  
>  #define LOG_LEVEL(v)		((v) & 0x07)
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> new file mode 100644
> index 000000000000..dba4ef10c722
> --- /dev/null
> +++ b/rust/kernel/print.rs
> @@ -0,0 +1,417 @@
> +/// Format strings.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +#[doc(hidden)]
> +pub mod format_strings {
> +    use crate::bindings;
> +
> +    /// The length we copy from the `KERN_*` kernel prefixes.
> +    const LENGTH_PREFIX: usize = 2;
> +
> +    /// The length of the fixed format strings.
> +    pub const LENGTH: usize = 10;

I am sorry but I am not familiar with rust. What are these limits
2 and 10 used for, please?

I guess that 2 is the size of a single KERN_* identifier.
But what is 10?

Note that printk() format prefix is typically just a single KERN_*
identifier. But there might be more. Well, in practice only the
following combination makes sense: KERN_CONT + KERN_<LEVEL>.


> +    /// Generates a fixed format string for the kernel's [`_printk`].
> +    ///
> +    /// The format string is always the same for a given level, i.e. for a
> +    /// given `prefix`, which are the kernel's `KERN_*` constants.
> +    ///
> +    /// [`_printk`]: ../../../../include/linux/printk.h
> +    const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
> +        // Ensure the `KERN_*` macros are what we expect.
> +        assert!(prefix[0] == b'\x01');
> +        if is_cont {
> +            assert!(prefix[1] == b'c');
> +        } else {
> +            assert!(prefix[1] >= b'0' && prefix[1] <= b'7');
> +        }
> +        assert!(prefix[2] == b'\x00');
> +
> +        let suffix: &[u8; LENGTH - LENGTH_PREFIX] = if is_cont {
> +            b"%pA\0\0\0\0\0"
> +        } else {
> +            b"%s: %pA\0"
> +        };
> +
> +        [
> +            prefix[0], prefix[1], suffix[0], suffix[1], suffix[2], suffix[3], suffix[4], suffix[5],
> +            suffix[6], suffix[7],
> +        ]
> +    }

Finally, is there any way to test whether any change in the printk
code breaks the rust support?

Best Regards,
Petr
