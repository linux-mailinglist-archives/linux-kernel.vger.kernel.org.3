Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D6507F02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358974AbiDTCpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348743AbiDTCp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:45:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DB37BE5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:42:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so520915plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vfe+Bo823sceHSMTTMCrGjAFXbrqNJngyy3/uN1hL1I=;
        b=MUANZlDdci93YXmyvk7nXE97lb09WlyFylCgklEfOHlREsE5OkC7hfuVnPnuyPpKjC
         JzLygb+5F8nGWablsLdvHDn2ZTpGPyEeVR1Zxa38DsbCW+NLeNn1i3vKMvvZqoEcpDtT
         MvpgTGV40uu+7drFOoCFkbwuFa7nqFXT+o7TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vfe+Bo823sceHSMTTMCrGjAFXbrqNJngyy3/uN1hL1I=;
        b=fjWB8mj0yGOpvAD1RouCMr5Qf+C1SzQguFLgBn/6wVB8LQlo+g/249keTWGb5dPl7j
         bBxGX9Sxf96ariByr78tzHK4FZndrmZkKqKnel4lRUB9TFvCewRuPaEIUFacaAYvRZbm
         XFgvbFDTAaNfjbKW/InUWqa7wddpSFSzrM3O30bf+IPhAIAor0/31FISXvoFHMGLODjg
         nz5+nuaFdAumqSXds8yxAJ2u1Bmsk+xtdhjMjUlH6CW841RLYFfKIPTjm04/2Lp81iWh
         WGRWFODk5jujgLg5Og/ysKL6sHm/g62C7yFCJxymm8Z+jiML/BWLv6k7jpsA+70TMm6O
         Ixaw==
X-Gm-Message-State: AOAM533CE4Y6bmDPiAvxrx9Rl4O24MUUTsOS0dBDCj+Zd8UOhYacbDjc
        aGu5HYKlIKwgrLn0AQEGx1xSrg==
X-Google-Smtp-Source: ABdhPJwcbF3zvvNRv1yktmDfMhCKXAAAPtr8AO3e++qx5yZz54gLhHTMNEUZXAV+ruHi2jGCY5n6tQ==
X-Received: by 2002:a17:902:7489:b0:158:8868:5030 with SMTP id h9-20020a170902748900b0015888685030mr19057499pll.132.1650422563800;
        Tue, 19 Apr 2022 19:42:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm19763951pfh.58.2022.04.19.19.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:42:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:42:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <202204191937.2720E7E@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> I'm considering detaching the prototype fixes from this series and reworking
> them to submit actual fixes (patches 10 and 11). Any specific suggestions for
> these specific patches? Maybe you want to take a look and help in co-authorship
> as we did with the void*-in-x86-crypto patches in the past? I guess these are
> useful for whatever CFI scheme is in place.

Yeah, if 10 and 11 are general prototype-based fixes, let's get them in.
I would expect regular CFI and kCFI to trip over those too. I'll comment
on those patches directly.

> Any other major concerns, ideas, or suggestions? :)

I think it'd be good to get kCFI landed in Clang first (since it is
effectively architecture agnostic), and then get FineIBT landed. But
that doesn't mean we can't be working on the kernel side of things at
the same time.

And just thinking generally, for other architecture-specific stuff,
I do wonder what an arm64 PAC-based CFI might look like. I prefer things
be hard-coded as kCFI is doing, but it'd be nice to be able to directly
measure performance and size overheads comparing the various methods.

-- 
Kees Cook
