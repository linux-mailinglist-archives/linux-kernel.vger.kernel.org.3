Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6155E14A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbiF1MRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbiF1MRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:17:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936423BCA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:17:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r9so9351536ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rw6va/7L57T3p13AIKdB4F5YJGoZKuh6/QVdTAin9AI=;
        b=dbwD8jT6RRdxFSmSqRwlY656jiYz+RUTi6/5228PLWnLgkuw3sYfoE5CXzDaeMPUGC
         gHusMOTQsEMwHi4wzfDa/l80IZYdU4oUn/lvXoqfkPFSjA/fCWtKMD4BWcgrUrPJjPq1
         FVXnGWWTa5w0SB0ENRLMLJK15VUNcH2cuctTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rw6va/7L57T3p13AIKdB4F5YJGoZKuh6/QVdTAin9AI=;
        b=hLNx2eGGz+efyqkAD8nv7xnNee9LAODY2+YdvmDh5cmDwqgY4L1wkVmpP3G0ICMq7C
         1tRongFxmkK0qIxXIBS48pmlW57IpdqmzkrDhIIaTX243kqBbaJWyB0EZ0rf4nL/wpKK
         u1/5QzWmPWC+fDc28/7rFty/FK1rqMCaGtNACfmpJ/kLPqHpy7pDy5cT4A4u4j1km/p/
         VP64V38olD6bIP/5mTHUEOXwGppZoxcHHqYD+BW7zyqdC/8oMPWmyJ7Q1iGoPONzPX8C
         4ml2TwxWYxFeZENtq/5oQbMqAm9SeShaQQaLzrELlRnx+7SQm6vgZEWUI3N/7VpMC+Lv
         IUlQ==
X-Gm-Message-State: AJIora9JqHOfFp1YGKxE5T+eUQ2iB3vm2PY1NDe7pTARzNDJirubuCP0
        6l2Pg56cn3dhLGiyEqRVlA7wAg==
X-Google-Smtp-Source: AGRyM1s4tufBx3IClbV/t88j4noTsoPlWVW6ACJd2F3gfPsR+8sLOj8f5HN/svpfSg2oNVgp2I1NtQ==
X-Received: by 2002:a2e:8ec9:0:b0:25a:754d:db39 with SMTP id e9-20020a2e8ec9000000b0025a754ddb39mr9529582ljl.4.1656418626995;
        Tue, 28 Jun 2022 05:17:06 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d2111csm2191486lft.75.2022.06.28.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:17:06 -0700 (PDT)
Message-ID: <3741c271-51a7-ed99-673e-18a7356df971@rasmusvillemoes.dk>
Date:   Tue, 28 Jun 2022 14:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to IS_ENABLED()
 and co
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, mmarek@suse.cz,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
 <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAK8P3a2XfzQo6emT4pXXxAjWewdP2LiAe2fOskFf-0suSmBJQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 13.19, Arnd Bergmann wrote:
> On Tue, Jun 28, 2022 at 11:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Since IS_ENABLED() (and friends) are clearly meant to be used on
>> CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
>> tautology, allow the more compact usage of: IS_ENABLED(foo).
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I'd prefer to keep the more verbose usage, mainly because it makes it easier
> to grep for a symbol. If today you do 'git grep CONFIG_PM_SLEEP', you find
> all instances in Makefile, in #ifdef and in IS_ENABLED(), though not the
> references in Kconfig language, which leave out the prefix.

Agreed.

Also, having CONFIG_ added implicitly requires updating fixdep, and that
will probably make the fixdep step somewhat more expensive - because one
would still have to find all explicit CONFIG_SOMETHING (they'd still be
used in ifdefs, and the int and string options directly in code), but in
addition also grep for IS_ENABLED, IS_BUILTIN, IS_MODULE.

Rasmus
