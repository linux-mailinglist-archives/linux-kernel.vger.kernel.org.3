Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47B48B1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbiAKQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349860AbiAKQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:14:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C7C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:14:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u13so57997929lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CS4Jw/Xn06/wu//cyV8SWXzS8vbEuTMpgDVD2LPfy2w=;
        b=dLREZhqAJmuhvauZUPkW/nmtPTHXnFlaAL4LZbiE2QxrSoX/zSo0kZrBwk34uQiUg0
         w5nbMpCNesoJA2i4K2qpOllaXxXkQ23CBwLvxFdZ+e0+ZhGUZiQGq1kt7QR/Y5XL3yfA
         mMKfHTQ+iyB6xhXpEAaFB5gXgoL71TmkuQlYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CS4Jw/Xn06/wu//cyV8SWXzS8vbEuTMpgDVD2LPfy2w=;
        b=5WXa+/osr3YIYW3l4EYAp0z4Kpxy8S86tUOGT9sbfYA0+jICDH8PV8Y89g2JYK/8bj
         ikMz/h0GY3+21elQmFCMBdYFEW7YOxp32rn/heLNZXWW8AQA6JyrAyHVbyomZaCj8D4k
         rozzTJW9dUktH8FeVpmVpOOY1YrDDiHXHt+eKWq5FPlUX1p4kaOF3nbdIPHp0Q4ogD7U
         cxP1m2DJPrw/zk/pXKwD1fNUgXLLuOih03SrNira3phdcYS30X9B4GuLP+iRwdLqWmPp
         vBTc1UBu1HeLURl95D9F2nNxYXcyHmEyV8eQ3IFGbEfSdorSs94UcniNavIZgx6o1MIA
         7xag==
X-Gm-Message-State: AOAM5316xR9YyMx82ZAtKCjj3DydLcoy2R2u2YMRHqn49NvybureZ1RP
        dj5G8SUW7w1AF6oU6T7qX/LWZg==
X-Google-Smtp-Source: ABdhPJxk35YAuB+f+0SX7NCfKoEy2/Xgwpp9AXBBoQ4wDR8h/dnxi8IHaYa+vPwThcKEtYYXKFaSpg==
X-Received: by 2002:a2e:b0d7:: with SMTP id g23mr2292307ljl.486.1641917681433;
        Tue, 11 Jan 2022 08:14:41 -0800 (PST)
Received: from [172.16.11.17] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e4sm1375708lfr.221.2022.01.11.08.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:14:40 -0800 (PST)
Subject: Re: [PATCH v1 1/1] vsprintf: Move space out of string literals in
 fourcc_string()
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
 <308b7158-7c2a-cc98-6091-14dae2b2cbba@rasmusvillemoes.dk>
 <Yd1p1XckKtdPyKSr@smile.fi.intel.com> <Yd2d4damgW2Xa8Sd@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <01d4b250-77b7-2534-b350-e8d2ba9b58bd@rasmusvillemoes.dk>
Date:   Tue, 11 Jan 2022 17:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd2d4damgW2Xa8Sd@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 16.10, Petr Mladek wrote:
> On Tue 2022-01-11 13:28:21, Andy Shevchenko wrote:

>>>> -	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
>>>> +	*p++ = ' ';
>>>> +	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
>>>>  	p += strlen(p);
>>>
>>> Hm, ok, those two strings do occur a lot with of_property_read_bool()
>>> and friends. But if you're micro-optimizing anyway, why not drop the
>>> strlen() and say p = stpcpy(...) instead?
>>
>> Why not? I'll do it for v2.
> 
> It is safe here. I just hope that it will not trigger reports from
> some tools looking for potential security issues ;-)
> 

strcpy() and stpcpy() have exactly the same preconditions and are safe
in exactly the same circumstances, they only differ in their return
value, so I don't see how any tool would warn about a use of (the
only-recently-standardized) stpcpy if it didn't already warn about strcpy.

Rasmus
