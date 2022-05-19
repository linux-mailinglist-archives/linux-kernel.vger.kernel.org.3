Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AB52CC98
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiESHLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiESHLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:11:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908A27FE2;
        Thu, 19 May 2022 00:10:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEC231F9F4;
        Thu, 19 May 2022 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652944256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7THzLll8eKXBdQTV/BzshDjJ4CbuTPvZ2Drio0SjPa0=;
        b=iNV002yTnGws18wkL+wjwzCUiOQbFnIBzCvzuQ9zC6j/XT6HQQUbg2cKg66scEl5N8L8FM
        n+XvVSOVMWgXm+ruBU4gtupg0QOVbq17mdJJ0943BsdgRgjFk9aNlQN2NQIMKOBCrmw+u5
        a5ne6GRDqf0DnkXzE4Uki5Oltbo2kD8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CB1E62C141;
        Thu, 19 May 2022 07:10:56 +0000 (UTC)
Date:   Thu, 19 May 2022 09:10:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] random: remove mostly unused async readiness notifier
Message-ID: <YoXtgLc+jtgPrUAM@alley>
References: <YoTB2OlwQq4J4/2D@zx2c4.com>
 <20220518095658.24085-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518095658.24085-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-05-18 11:56:58, Jason A. Donenfeld wrote:
> The register_random_ready_notifier() notifier is somewhat complicated,
> and was already recently rewritten to use notifier blocks. It is only
> used now by one consumer in the kernel, vsprintf.c, for which the async
> mechanism is really overly complex for what it actually needs. This
> commit removes register_random_ready_notifier() and unregister_random_
> ready_notifier(), because it just adds complication with little utility,
> and changes vsprintf.c to just check on `!rng_is_initialized() &&
> !rng_has_arch_random()`, which will eventually be true. Performance-
> wise, that code was already using a static branch, so there's basically
> no overhead at all to this change.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Petr Mladek <pmladek@suse.com> # for vsprintf.c
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v1->v2:
> - Use a trylock instead of a spinlock to be NMI safe.

Looks good to me. My ack is already there. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

if you would prefer it.

Thanks a lot for updating the patch.

Best Regards,
Petr
