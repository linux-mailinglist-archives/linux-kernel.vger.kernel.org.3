Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B4C48AB58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbiAKK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbiAKK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:26:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C5C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:26:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x6so54554740lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oxDy4AfZby7z8LawjYmWoPECv5wh3m5ItoNbPc6qdR8=;
        b=FSClFJ4BfYN+77rYV5CMD22uLs3EJrNE5XMNfBpOEtZJMa6YYFgPqpvY0nNrqlkCc7
         uZ1dHkmJ7hG+o0Z9/PKiusmeQo6PIzbB5Vk6Se4xTr3IAi1N2JwdwmJS6lkMd6tB1lS/
         MO1+MfPNvnOEgh2bdrtGWWjM6CItlC5L7m8GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxDy4AfZby7z8LawjYmWoPECv5wh3m5ItoNbPc6qdR8=;
        b=KxoEOyfMPucpsnCrIBHkuy17rfjGUOit2x1tB8UifpF8UDh1isW1x/x0bV0BxtxlVU
         wueEQb1ToPq+RLfOaXzxeEmyYowgT2nXN+HRfbsGRtrw3dcZscMpgRKHEIoGGb4+0O0I
         MAw8rySMBeMqEk81rwIpY0RA/hnYv+c9+u1cexqQkYf1UlWSgwGZrgI2/rb74Wi7fsuw
         Se5ZIQrhVFoBn1foNmcakBZA3UQEM/6mHLgSa8k/WhMMwpIw0M11d/tEDCD2cBPJnj/i
         jPe8nPy1ueEcB2GfKmzSmT80GbEoPZ2FvPY1TFbmMCoMmxz9bcC7Flz2CObbDfjwqVzh
         pGuw==
X-Gm-Message-State: AOAM531lHeCVXggclNlch7r3bxVENsZ7ooNfPpE9ROedecIQW7l0uUpI
        n2y2Moy3CfODp23PZrCGqR6uKg==
X-Google-Smtp-Source: ABdhPJxzEVHZAveN2IC75KEDOzvjD5PoV6F4haj9fivsKqLK5+eK68IpdqkWQSNN3fe7I0ck64Puew==
X-Received: by 2002:a05:651c:1508:: with SMTP id e8mr2480253ljf.313.1641896782629;
        Tue, 11 Jan 2022 02:26:22 -0800 (PST)
Received: from [172.16.11.17] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a6sm1291916lff.59.2022.01.11.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 02:26:22 -0800 (PST)
Subject: Re: [PATCH v1 1/1] vsprintf: Move space out of string literals in
 fourcc_string()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <308b7158-7c2a-cc98-6091-14dae2b2cbba@rasmusvillemoes.dk>
Date:   Tue, 11 Jan 2022 11:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2022 21.55, Andy Shevchenko wrote:
> The literals "big-endian" and "little-endian" may be potentially
> occurred in other places. Dropping space allows compiler to
> "compress" them by using only a single copy.

Nit: it's not the compiler which does that, but the linker.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b02f01366acb..5818856d5626 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1780,7 +1780,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
>  		*p++ = isascii(c) && isprint(c) ? c : '.';
>  	}
>  
> -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
> +	*p++ = ' ';
> +	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
>  	p += strlen(p);

Hm, ok, those two strings do occur a lot with of_property_read_bool()
and friends. But if you're micro-optimizing anyway, why not drop the
strlen() and say p = stpcpy(...) instead?
Rasmus
