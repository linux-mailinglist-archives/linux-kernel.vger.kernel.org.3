Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CF4C8C17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiCAM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCAM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:59:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17C01EACF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:58:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646139522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJ7r/RygoFcdcvKuLBfkNBw/GzSsqEbxSHChl9KJjpc=;
        b=Rn/oBB6JoXJ440HePA4KoE7SHyv9x3/0QwXplchDUyIPvLGR0wyOHY0KC4JGrEFXQarxmO
        7cB5PmhuTxi7gmcwKQc4QKY1Y9MOsZGGfogoVS62Fi16v248ShkFUTWpB/EAm+67DROtwS
        khNZu3VIB4tcNYDI/V6DbtxRafiVfAi+HEPqSVmCt0l/Wlwo687urb6Stm5YbgCWc0ncsn
        SQx835d77Uk3foWzXS6gbSoRSUR2Hkgau9zKUJtm9SeRhBoEKjHs9L0hQxxrroQ+dFg2hM
        jSlZRDb8TM7aT+rG1wXhnSzh9EAySxgpX2obVeDtmPSAD1ymZUwqo4GJF5nq8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646139522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJ7r/RygoFcdcvKuLBfkNBw/GzSsqEbxSHChl9KJjpc=;
        b=hkLRwiQ9m7dg/zWDnINxgKSwU0jz3bacT2AsWanzJVIch0Ut+uWwnWyu3GqyHEn6CBaJw3
        rFi4WoR2fESEheBw==
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: fix return value of printk.devkmsg __setup handler
In-Reply-To: <20220228220556.23484-1-rdunlap@infradead.org>
References: <20220228220556.23484-1-rdunlap@infradead.org>
Date:   Tue, 01 Mar 2022 14:04:41 +0106
Message-ID: <87sfs17rsu.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28, Randy Dunlap <rdunlap@infradead.org> wrote:
> If an invalid option value is used with "printk.devkmsg=<value>",
> it is silently ignored.
> If a valid option value is used, it is honored but the wrong return
> value (0) is used, indicating that the command line option had an
> error and was not handled. This string is not added to init's
> environment strings due to init/main.c::unknown_bootoption()
> checking for a '.' in the boot option string and then considering
> that string to be an "Unused module parameter".
>
> Print a warning message if a bad option string is used.
> Always return 1 from the __setup handler to indicate that the command
> line option has been handled.
>
> Fixes: 750afe7babd1 ("printk: add kernel parameter to control writes to /dev/kmsg")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru

The message at this link is very helpful in explaining the state of
declaring kernel parameters. Hopefully someday someone will document
and/or comment this stuff.

John Ogness
