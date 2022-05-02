Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C3516D99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384348AbiEBJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384402AbiEBJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:43:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A03A111D;
        Mon,  2 May 2022 02:40:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651484429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYGGwnXeFPcIOHQmhzSCBgH4HMwEO9aRAXTxvIySbxU=;
        b=xRWWMcx6q1hFZvKKcNEOiGEFpsCUiKlY3VDrrJdA8NHIq54CXy7UgGxYIgzdrLUKPVauf0
        WSQlkGf1n6FdJbu4X74JyfeuhB9d+ZwAQNEmSxp1+MyX+kkH3q6zKnRPbOXiXjYoth8uDD
        sAV576M4VAGOoMYcjo1+6PVJVxCvHQQjHZRYBES853/sY3GVU3pFSbI3f72cKVIgGsmGDn
        mMFdpXX/e5b6df01EgTZSHHQ8LHWsWKsp2Az2u5dChqNNJqNiJQOLKM/DTSUJGZvrooQgX
        9Xr8hWfvLEUOC5/+pUe9Sso7X7doWNQiKXxg4xKte2TWxeElwlW3ZCQBQout0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651484429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYGGwnXeFPcIOHQmhzSCBgH4HMwEO9aRAXTxvIySbxU=;
        b=dOSkoFARma2uJzbg6ynhp4U13J6hLMTQeSZWPMHb9PQQCFgpLOuL3PitpqCpKJt9Ievkw+
        VKQ03GE9hEn4MmBw==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        bp@alien8.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org
Subject: Re: [PATCH v7 13/17] x86/asm: use fallback for random_get_entropy()
 instead of zero
In-Reply-To: <20220426083301.816458-1-Jason@zx2c4.com>
References: <YmbZZwXxaC+S863+@zx2c4.com>
 <20220426083301.816458-1-Jason@zx2c4.com>
Date:   Mon, 02 May 2022 11:40:28 +0200
Message-ID: <87v8uomfw3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26 2022 at 10:33, Jason A. Donenfeld wrote:

Subject: x86/tsc: Use .....

This has absolutely nothing to do with ASM and the sentence after the
colon starts with an uppercase letter.

> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is suboptimal. Instead, fallback
> to calling random_get_entropy_fallback(), which isn't extremely high
> precision or guaranteed to be entropic, but is certainly better than
> returning zero all the time.
>
> If CONFIG_X86_TSC=n, then it's possible for the kernel to run on systems
> without RDTSC, such as 486 and certain 586, so the fallback code is only
> required for that case.
>
> As well, fix up both the new function and the get_cycles() function from
> which it was derived to use cpu_feature_enabled() rather than
> boot_cpu_has(), and use !IS_ENABLED() instead of #ifndef.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org

Same comments vs. Cc's

> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v6->v7:
> - Adjust commit subject and body to match tip commit style.

Mostly ... :)

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
