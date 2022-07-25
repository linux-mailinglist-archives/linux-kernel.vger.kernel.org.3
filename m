Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177F580019
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiGYNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGYNqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:46:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CDBF5B2;
        Mon, 25 Jul 2022 06:46:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7039D2023D;
        Mon, 25 Jul 2022 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658756801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWg1dNIhhKKeM/ZSg5hAzZXqdnTzD1UVa31cpsoSSq4=;
        b=SQ48r1r+JWht5928b2Ar6Uz5vJJzxMnT5Io/z7g4K7/llpT2wtqEjkWLgl/qApcQXugSXb
        ZeCxQr39rxPcodlVPHFW5c6fkxrFX2vzn3ADMX+fq5n9+SnB5V6Dd8HflMFh1w+P5iWxjR
        hGZAkDxxp8DlVFbF56tG7J2gB5tSqpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658756801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWg1dNIhhKKeM/ZSg5hAzZXqdnTzD1UVa31cpsoSSq4=;
        b=gZVZBo+MfWbc2oWAcUgAhvJx8Z2uEwDGQXKQvGyBt5XvnZE/jyr4a4zmNx+b6335v6lK/Q
        FsDkk9BjosyslkAQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 651FB2C153;
        Mon, 25 Jul 2022 13:46:40 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 48CD9444B2F; Mon, 25 Jul 2022 15:46:40 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: fix double free
References: <mvmzggxl4n1.fsf@suse.de>
        <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org>
X-Yow:  Th' PINK SOCK... soaking... soaking... soaking...
 Th' PINK SOCK... washing... washing... washing...
 Th' PINK SOCK... rinsing... rinsing... rinsing...
Date:   Mon, 25 Jul 2022 15:46:40 +0200
In-Reply-To: <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org> (Daniel Bristot
        de Oliveira's message of "Mon, 25 Jul 2022 15:34:56 +0200")
Message-ID: <mvmv8rll2yn.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25 2022, Daniel Bristot de Oliveira wrote:

> Hi Andreas
>
> On 7/25/22 15:10, Andreas Schwab wrote:
>> Don't call trace_instance_destroy in trace_instance_init when it fails,
>> this is done by the caller.
>
> Regarding the Subject, are you seeing a double-free error, or it is just an
> optimization?

A double free nowadays is almost always an error, due to better malloc
checking.

> AFAICS, trace_instance_destroy() checks the pointers before calling free().

That doesn't help when the pointer is not cleared afterwards.  Do you
prefer that?

> Why am I asking? because if it is a double-free bug, we need to add the "Fixes:"
> tag,

It's the first time I tried running rtla, so I don't know whether it is
a regression, but from looking at the history it appears to have been
introduced already in commit 0605bf009f18 ("rtla: Add osnoise tool")

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
