Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD56058B4B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiHFI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiHFI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:59:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AB16593
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:59:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so5934538edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3871ruND0nqZUe2qICGzGQqrskPExm04SE4C1XZsJ8o=;
        b=ZY+zRK3kKzOlXDBqE7+YeZFTpnrXzUt3GkZXVTtB5iU6c8286dqfKaxJNbUKlkpB7Z
         CQsa+yAKydvH6CKwZTMwSEhN5a6jgyRq9L3qg3YvVekqOSNgAYkXkjSAQpOGL8tpI6FV
         RIJJL7N4P4OHVJQTtV9yD1hvEQ5qmbzq7kSpHDvpqDzSk0COfcKtVu+GKNG5mWoF59M6
         fqSxVIzb+thLLBFMn9YuRV6mJ9pKpU4kYQGonoch1YtcllOtGiwOE0J/7HJc1ZW55GZK
         CbflHra272yreW0uICNNYLC0Ne7ynT9K19IeSB7IkNXEm6YasI7f+zW3GUpIwG7TbdLm
         ThSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3871ruND0nqZUe2qICGzGQqrskPExm04SE4C1XZsJ8o=;
        b=awTnZPasO7XxIPXbH78S8i4tdsCYDwsoJJZtT4/KliFUM+xlxyy/onVBX3Nuw9fhKt
         up+UfWeg1mU7axkZ1D4iu/UMFVducRJ94UZnbb8KDU52/oklfebHX5IKLAExJNOI8KUO
         JO+tUJ7igQ9sRl2BJ4OelWEJwsI4XQ1Deg4HMQ6KhIAiAqk66wDdgOrt3ZIV/Si0zxzq
         +c7f3viWJufdOf7xobVqoCcnl5HZsnJm5sbpM2V0Cnj8Y61kvZMeKKWijgrpOtegeCie
         P7X6KyxP1fKCgXRLqQIqwpfGlBZ4ERm0wdBzrN/s4OsU4UKG+MZIPpnryQ0rJbxUQ68s
         3ccA==
X-Gm-Message-State: ACgBeo3kZIhD/kyub5yPu/phYV30s5CFrHwt+KOV4uJS2yQStP/1yxYP
        vfL/6hMM33WOYJ4kp7kwKTo=
X-Google-Smtp-Source: AA6agR6zzMXGg7/Rm6mSBvH9lCwN98uU6d62QJ7mGE2xoiMZPRaPzYmQtya3LzUp5RsTXnSUYPc0xA==
X-Received: by 2002:a05:6402:2b8f:b0:43a:66d4:a025 with SMTP id fj15-20020a0564022b8f00b0043a66d4a025mr9990648edb.121.1659776345408;
        Sat, 06 Aug 2022 01:59:05 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072f5fa11d19sm2412559ejh.202.2022.08.06.01.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 01:59:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 10:59:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <Yu4tV9FmEQmbB4AU@gmail.com>
References: <20220805101644.2e674553@imladris.surriel.com>
 <Yu0o3J2T5QwKtoan@zn.tnic>
 <20220805104007.115359b5@imladris.surriel.com>
 <Yu4qja8L2ulHaqVt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu4qja8L2ulHaqVt@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> >  	instrumentation_begin();
> > -	handle_page_fault(regs, error_code, address);
> > +	handle_page_fault(regs, error_code, address, cpu);
> 
> Not convinced that this is a good change: this will bloat all the 
> affected code by a couple of dozen instructions - for no good reason in 
> the context of this patch.
> 
> Boris, why should we do this? Extracting a parameter at higher levels and 
> passing it down to lower levels is almost always a bad idea from a code 
> generation POV, unless the majority of lower levels needs this 
> information anyway (which isn't the case here).

Oh, I just got to this series in my mbox:

  [RFC PATCH 0/5] Print CPU at segfault time
  ...
  [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry

With that basis, printing the segfault CPU becomes a 'free' feature.

At the cost of putting ~2 new instructions into the hotpath of every 
exception though. :-/

Thanks,

	Ingo
