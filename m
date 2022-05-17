Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F27529B83
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbiEQHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242075AbiEQHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:54:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861A843493;
        Tue, 17 May 2022 00:54:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3EA501FA28;
        Tue, 17 May 2022 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652774044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM6+QSZRHkWYQj7ZDxS87+VGKnwouDbU7UOR2z+jDzQ=;
        b=EBIyXdc9T7dDorW4UVURkxVTqDSjpxwEz/CpWN8lG+b0VkzkHtTASq4AjBx0DAieDpRghc
        O3nEzT7ifP9YGRI01Sgw8XXnpvhunk9uNXATO1w3wvOCwtGjO2tHTQKyX3KK1XA2t3ZKI6
        9RmKkU8mo3SLEha0RseWSnMKwDj+T2U=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2A092C141;
        Tue, 17 May 2022 07:54:03 +0000 (UTC)
Date:   Tue, 17 May 2022 09:54:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove get_random_bytes_arch() and add
 rng_has_arch_random()
Message-ID: <YoNUmF3+lVxIjoik@alley>
References: <20220514112307.349599-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514112307.349599-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-05-14 13:23:07, Jason A. Donenfeld wrote:
> The RNG incorporates RDRAND into its state at boot and every time it
> reseeds, so there's no reason for callers to use it directly. The
> hashing that the RNG does on it is preferable to using the bytes raw.
> 
> The only current use case of it is vsprintf's siphash key for pointer
> hashing, which uses it to initialize the pointer secret earlier than
> usual if RDRAND is available. In order to replace this narrow use case,
> just expose whether RDRAND is available. With that taken care of, there
> are no users of get_random_bytes_arch() left, so the function can be
> removed.
> 
> Later if trust_cpu gets turned on by default (as most distros are
> doing), this one use of rng_has_arch_random() can probably go away as
> well.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Looks good to me. Thanks for the clean up.

Acked-by: Petr Mladek <pmladek@suse.com>	# for vsprintf.c

Best Regards,
Petr
