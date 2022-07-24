Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3525C57F35B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiGXFXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 01:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiGXFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 01:23:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F50518E28
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 22:23:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y15so7712230plp.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVcGMUg63ZuyRPGB+ax8hjQYbRon/AMmT/KHY/uYZvM=;
        b=N44XlBThF9hr0YdMwSqE/Y8pqxRR0qN7YJASl4rflgM929JO2OHiZZC3Tt9eG//5Mr
         bksL1BeskWKeL5+tl9ML0hAeD7Let4DHvVZSj7JFppsP/flZNhp6Da/GQWkoLVAXSh8s
         82e7TBIoe4GdJG6yXOEIHcpmNUlm7f/fn9WNB3cKy4tk+dM61JaL7pv9BDmkhR3Hg+4d
         t7kXbus2/xDk2L+LnvvVhOq8HahOafa68USNdYtJbENOlK4n63nPvYYam3OSv1utrz74
         p/zGFwbWqP/wO/YM7ylhCE6XkzL3+7D5gDaAhDM83sP/Q4tSMfEOZittVPXU3zMjOyfg
         wRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVcGMUg63ZuyRPGB+ax8hjQYbRon/AMmT/KHY/uYZvM=;
        b=k3wXXlC8SaOHnlnjkMGwN8qCeVp2LLaCGqNrOxWdQZ6ncuIxIkC+RHCZ315jX9EBvH
         s5EFJ4+BEb1cGe5sGDntVianjt39fWnVwjXv/y2KJmoieelsB3gys9rQk081arNP69AY
         qroa/tfKj+mbcc7o2GCSlr6sSi6YKTMlJTcrTPAx4xmOHD4IzvoXRdUEUewUq33ur7++
         wJP3AMmJy1eoOC4+8LiDyeZXVTkzX2iBelPXZVVyYnxLHdmSnFt5jnWhDM5sCN9n77SU
         a13bHtgW32f/9LWqbQCDdvvJh4hhn499CXKAaLUHVdw3lGQwTnx95rKSzqxQVaVqhNnq
         yrlw==
X-Gm-Message-State: AJIora8WvkXFbomeAn6jEqc2VI/RkFP7jPzrinRTWRa8XzMIbXRYekfN
        b//CGxoLS+IGa6Q+4HKmPNkB5w==
X-Google-Smtp-Source: AGRyM1t3x6rRtN3QukoCbgl9JRd33Dij9jGSlDj01WFH5DH93wV4aRi8wtun5sMyW9geJeJSJAFQSw==
X-Received: by 2002:a17:90a:17e1:b0:1f2:2ff2:6cae with SMTP id q88-20020a17090a17e100b001f22ff26caemr17913677pja.196.1658640214217;
        Sat, 23 Jul 2022 22:23:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b0052b9351737fsm7036475pfp.92.2022.07.23.22.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 22:23:33 -0700 (PDT)
Date:   Sun, 24 Jul 2022 13:23:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf symbol: Skip recording symbols in
 '.gnu.warning.*' sections
Message-ID: <20220724052327.GB82137@leoy-ThinkPad-X240s>
References: <20220724022857.2621520-1-leo.yan@linaro.org>
 <20220724022857.2621520-3-leo.yan@linaro.org>
 <CAFP8O3LJq1rt6i0_rAW5pShUiA=FJ38ceb4Ps0KmLdCNzC9xbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3LJq1rt6i0_rAW5pShUiA=FJ38ceb4Ps0KmLdCNzC9xbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 08:42:20PM -0700, Fangrui Song wrote:
> On Sat, Jul 23, 2022 at 7:29 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Some symbols are observed their 'st_value' field are zeros.  E.g.
> > libc.so.6 in Ubuntu contains a symbol '__evoke_link_warning_getwd' which
> > resides in the '.gnu.warning.getwd' section, unlike normal symbols, this
> > kind of symbols are only used for linker warning.
> >
> > This patch skips to record symbols from '.gnu.warning.*' sections by
> > detecting the sub string '.gnu.warning' is contained in section name.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Presumably __evoke_link_warning_getwd is due to `clang -fuse-ld=lld
> -static ...` on a file calling the deprecated getwd.
> GNU ld and gold implement a .gnu.warning.* feature which removes the
> section. ld.lld just ignores this section as the usefulness of the
> functionality is unclear.
> 
> The section .gnu.warning.getwd does not have the SHF_ALLOC flag. Such
> sections are not part of memory images and I think it is more generic
> ignoring all symbols residing in a non-SHF_ALLOC section.

Good point!  Will refine the patch for this and send out soon.

Thanks a lot, Fangrui.
