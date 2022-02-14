Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833E4B4DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiBNLTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:19:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350621AbiBNLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:19:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D3694B8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:52:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so36496556ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E/TT01vk+TwDTxyVO+CySmmufUASQrx6o6WcTn2zA6g=;
        b=LWvXIogIhqRUhxWeVG/UvEOK/9eOLM6ssOlZy/3RDNw9vDq2wBdtU6s7kREbP0cnJC
         gCEPNNbIxVz9Px1HgdnzYzXC8WZKL4MCivjZM5RrjKfgwDDuCtxB7G/SMndpEDk/2rfg
         0Pgi/XwsUUXLkr419KVcuHZS58QmtN1jYdlsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E/TT01vk+TwDTxyVO+CySmmufUASQrx6o6WcTn2zA6g=;
        b=JIWoOuLsWsCo6NSsAtb+EFWsGU6Bj9feEWZeuB8wHOsyujWL0hc8e14/DR6QyWjGBO
         SI5u9DgY7RBxEnhKRVsyQzzy8K9ZRJk1im6H4ySsYyfTXtWnoTOADJuy/CXYoyZ/zQzv
         7ZjZiK2Mf4AGzDHAXfHTHfA6x7v0hY3jz07Ffy4Gvumygr82bLmQNPP4UTGWgoIUbyh5
         zGB7isZyLI30+JWbZ20src/qe0WAElh/zieQp3eIqFxr9X9oa0Ch1fMmbfYndPlmp0/t
         cl6YSEv6jAF3qaqcZZWc5JbNGw1vIUDNBwIECBg7LA+SJ0+AQUnCMpM9nmgg8KB2OdcX
         2pzg==
X-Gm-Message-State: AOAM530En/AFK1yTeQu5UHewpFYs2n8OdOHSgHViBwnlkbnH7KKF6GBG
        v3Dt6FYpUExK7nvIRPzXzqyDnA==
X-Google-Smtp-Source: ABdhPJyRmRhJ+m6AufBMjvO+EAajLPaNwsbL28+VihphAK/HPcx1aafI2fcRcWVtS458a+Wge2rcZw==
X-Received: by 2002:a17:907:7204:: with SMTP id dr4mr10860530ejc.708.1644835959219;
        Mon, 14 Feb 2022 02:52:39 -0800 (PST)
Received: from [192.168.1.149] ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id q12sm14773393edv.99.2022.02.14.02.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:52:38 -0800 (PST)
Message-ID: <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
Date:   Mon, 14 Feb 2022 11:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YgosclY9ebD3t020@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 11.18, Andy Shevchenko wrote:
> On Sat, Feb 12, 2022 at 02:03:38PM +0100, Miguel Ojeda wrote:
> 
>> From: Gary Guo <gary@garyguo.net>
> 
> Not sure I understand this...
> 
>> This patch adds a format specifier `%pA` to `vsprintf` which formats
>> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
>> format to the internal buffer of `printf`, so we do not have to use
>> a temporary buffer on the stack to pre-assemble the message on
>> the Rust side.
>>
>> This specifier is intended only to be used from Rust and not for C, so
>> `checkpatch.pl` is intentionally unchanged to catch any misuse.
>>
>> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
>> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
>> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> 
>> Signed-off-by: Gary Guo <gary@garyguo.net>
> 
> ...together with this in the current SoB chain.
> 
>> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> I'm wondering if you considered to use %pV.
> 

I think the point is for vsnprintf() to call (back) into Rust code.

That said, I don't like the !CONFIG_RUST version to return NULL, that
will surely crash moments later.

So I prefer something like

[rust.h]
// no CONFIG_RUST conditional
+char *rust_fmt_argument(char* buf, char* end, void *ptr);

[vsprintf.c]
+	case 'A':
+               if (IS_ENABLED(CONFIG_RUST))
+		    return rust_fmt_argument(buf, end, ptr);
+               else
+                   return string_nocheck(buf, end, "[%pA in non-Rust
code?!]", default_str_spec);


Rasmus

