Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B447D63B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbhLVSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbhLVSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:06:46 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C71C06173F;
        Wed, 22 Dec 2021 10:06:46 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 131so3133178qkk.2;
        Wed, 22 Dec 2021 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BaCXnb6DD2UD5cDhT0tNZDyFrPpED9Mp5n3o9Laa4Q=;
        b=bCSeyy9Pub1PN+k5TH447nsrbvmRALWyfVaKt9AQU6YRFQC+2CgdqMt/J6d35a03MC
         s1UVEUuDZv3DF+fukafCnViUvhTnt94ig9+x+2YtzY9cE9vJt/CbNoQmwAoffa876svJ
         CwJuTvVzlznC+6uq4JviLzz+PeTu5SqcYeAoSHz6JU4KYtHtXXx+boOz5lIPxCcuM4NT
         CaG1koIIV5B5DUO4V1zN7OVn9xRcVpXYZSQ252JCLIWnRbDY4lvYvfS9BdRqWZPrPAj/
         cB+6TbO0yAtXZhiPcS0WIEj70LwyhuPzymTaRe/3UskkR9U9TkZP0OYhJWTL9JQEKLmw
         h0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BaCXnb6DD2UD5cDhT0tNZDyFrPpED9Mp5n3o9Laa4Q=;
        b=bSBnGxI9BsrFvZN0C4UmxboLLzJxq9oBA9LRFkapIPEo1bjoDVtLCeJiMjwG1ui8MC
         CHdffILy16FKz3nEPAzCugIQiC0Mxy6BeosJCIOKys+M8fFhBkl1+jm2t6c6RrEbC62F
         dBijT5dcCtPyZuw3p8NwF9fWcKEwr0xZtl815YiHe7VN58Lh4oX4rhcOrg0BjaEab+hE
         tIO2/JleO0wouKCZRC3jS5hWTYNo3m+r7U+GhIWRNVXrQDsLO1hGe1lHRGl1/KssHilu
         4UtsNWz/AdG3zBEsKfA0bd6bM4Nc670F/k+XCwx+TKj2A6SJRAStFdZdxXQrwCJnb/UN
         QFeg==
X-Gm-Message-State: AOAM532TTb31WtZp0LLo3cX5o6jiZUfcL6WBBN5FARXyGMeq3Uw4nnxo
        HlkKkEJ24j5XMjtd2HexFY0=
X-Google-Smtp-Source: ABdhPJzSlcMzCk3/qVcDEU/40RqIBCS0oxfIqUXjbfspsSFHT06zAp/QPCyk759nWNE1B+utEH32oQ==
X-Received: by 2002:a05:620a:1a95:: with SMTP id bl21mr2756738qkb.529.1640196405592;
        Wed, 22 Dec 2021 10:06:45 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h16sm2409121qtx.20.2021.12.22.10.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 10:06:45 -0800 (PST)
Subject: Re: [PATCH] of: unittest: Fix out of bounds array access when id < 0
To:     Rob Herring <robh+dt@kernel.org>,
        Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
 <CAL_JsqLtQanbiC4egB8d5quQRZNq0V6q2s+=qhBeypBqLH-pgA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cadd5cd5-d2d7-ccbd-50af-deca7b6afd80@gmail.com>
Date:   Wed, 22 Dec 2021 12:06:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLtQanbiC4egB8d5quQRZNq0V6q2s+=qhBeypBqLH-pgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 6:20 AM, Rob Herring wrote:
> On Tue, Dec 21, 2021 at 5:34 AM Yin Xiujiang <yinxiujiang@kylinos.cn> wrote:
>>
>> In of_unittest_untrack_overlay if id is less than 0 then
>> overlay_id_bits will be out of bounds. And it is also mentioned
>> in bugzilla as a bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214867
>>
>> Fix this bug by tiggering WARN_ON()
> 
> If id shouldn't be less than 0, can we make it unsigned instead as
> discussed here[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/all/c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com/
> 

There are problems with changing to unsigned (fixable, but more extensive
code changes).

I think that the implementation of id tracking in unittest.c is overly
fragile, and I would prefer to just re-implement it (see also my reply
to the proposed patch).

Let me take a look at whether I can create an alternate
implementation of id tracking.

-Frank
