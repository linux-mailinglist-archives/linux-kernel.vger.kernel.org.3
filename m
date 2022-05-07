Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6910051E941
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386917AbiEGStH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEGStF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DBB1E3CC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 11:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3CF261423
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 18:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC31C385A6;
        Sat,  7 May 2022 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651949117;
        bh=uWrdHQqQJD2SDQCKl60JJdflwuAaux0Sd1WGRTkjd8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IUKT7ejxpl5oJbVly9oY1vtdapHU0Rj/nmk7LHMI2JfBEZJut+DQucMr6dOtO8jcl
         E6HbXTcHVkavJHC5UFcSXPrx7UaRIpiCPUb77/edE/RxUqV2jyuPGXSxkdUL2H0rNs
         w4TYZEJLN94FsiYC4iT11gq8pZpFewiiir9g4ok0=
Date:   Sat, 7 May 2022 11:45:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Puyou Lu <puyou.lu@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/string_helpers: fix not adding strarray to
 device's resource list.
Message-Id: <20220507114516.5de49b46cf5349db7121eff8@linux-foundation.org>
In-Reply-To: <20220506073623.2679-1-puyou.lu@gmail.com>
References: <20220506073623.2679-1-puyou.lu@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 May 2022 15:36:22 +0800 Puyou Lu <puyou.lu@gmail.com> wrote:

> Add allocated strarray to device's resource list. This is a must to
> automatically release strarray when the device disappears.

So at present we have a memory leak?

Is this likely to be serious enough to justify backporting the fix into
-stable kernels?

> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -757,6 +757,9 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	ptr->n = n;
> +	devres_add(dev, ptr);
> +
>  	return ptr->array;
>  }
>  EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);

