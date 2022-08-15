Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC25932B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiHOQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHOQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:03:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E688183A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:03:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660579404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+AsJV3flOno2NrQgxHNdsQYlCfJKACvrXjTxeqHxHxU=;
        b=B7viINiX+34MR5eDqmTZDXUtWlqD0xG7HDPJk7p391fzBfs/JIGI64o4fm3E4aAS72foes
        X8q9oIoae5i2Cxnt89+NoUCrKQ+2T655XatAHVQguI48DpBSELktBrFIl9gtqoBHUXTT1b
        Y8izRo9hMwniEBUedb2ysIdD28II8sGFD/Z0aEJ0LYYb8THbQQysh13uB8P6htrawc2W7g
        LG+jCH2Bjcn9+hQygD0qRgGPinMjzKvf0QaHSU5ktj06A9agWFwP3n9+FhSm9YgCd9PDY/
        zuk+vV0bg4EnF8HhqVleYPypdnbvxm7XOyKV4mYjHSXVKXpm6hcGRTs8bZdUWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660579404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+AsJV3flOno2NrQgxHNdsQYlCfJKACvrXjTxeqHxHxU=;
        b=OQXtv4OUlirT7VzL6ONHU2E3vdelqsHMZ87e/ACiWWO3b/Tq9SJP3beadK+L1mmFRjLx/p
        RzbSMf602dwDQmAQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marc =?utf-8?Q?Aur?= =?utf-8?Q?=C3=A8le?= La France 
        <tsi@tuyoix.net>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: Export log_buf_len to userland
In-Reply-To: <YvmsNEYPtdOUsaxy@google.com>
References: <a41b5ad3-d052-49b8-e038-b020c1dc6788@tuyoix.net>
 <YvmsNEYPtdOUsaxy@google.com>
Date:   Mon, 15 Aug 2022 18:09:23 +0206
Message-ID: <87wnb9pk8k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-15, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> On (22/08/10 14:25), Marc Aur=C3=A8le La France wrote:
>>=20
>> Make the kernel log's buffer size available to userland so it can be
>> used with `dmesg -s`.

This information is already available via:

    klogctl(SYSLOG_ACTION_SIZE_BUFFER, NULL, 0)

And dmesg already uses this with "dmesg -S".

John Ogness
