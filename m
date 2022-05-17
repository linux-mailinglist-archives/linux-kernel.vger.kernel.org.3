Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AA529844
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiEQDdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiEQDd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:33:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E2403E3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:33:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q76so15828675pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6lMCmhAYh+FvKYdNdXdz6Z38uBA0dGxW92CXeTkkVHI=;
        b=n8WjxB3Nj3gvAFxKXFL3OrDnlrBoacgytSGaFjMBE9s/LFRzUKHHXob4w0r2AQ5IKo
         tYNienYmpEVD+bM3YbFEIiV4sn8Fq5tT0DySB7eaGNheP3Py6K6yd2pAok543L01wiLt
         LywDoZZuJfuDt8WNiy39SM1tTXRASndm+9/Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6lMCmhAYh+FvKYdNdXdz6Z38uBA0dGxW92CXeTkkVHI=;
        b=QK9nU2QZ8aaJJKBO5onyFGfQ0ZGDrkBLRRrjPAMLz7VdPD5JJ2du2ho/vW+VwDc4EF
         eh+HlkQHF4vD111f7JHwq2/hssiApw1QAr+T92r/u+P541XZf3fXDH35W8SCaa3SAUUx
         XbOH4nRjqC9cY31r4nYXgSxiZPPhT6dUdhJEwt/6dXxXoYvL3d/mVZDaQsvQFo1ncgRO
         WJP6tlWuS77vlCRG85i6q06mPKPIenqwF0u/l65fHLa3j1I/xCjEJk5iwWopyn1xkljJ
         ojlbWCKKhhqDgDT6k7wrro6LDmGl7OonyYzRXoqhgh9VlWc+eqWtG7Z7c0tZsjv3vvoz
         nM9Q==
X-Gm-Message-State: AOAM531itHFMG8//H747MoxhtGuw1+9nEOlG9ZaKrg/dXR+18XR0bCKE
        Fb6hCPQMloF6MMauvxHJoSzZDA==
X-Google-Smtp-Source: ABdhPJwiDhEUG94kRJnu4hhVriBlgTIp0ehSqJnWQZzKxaKBO/5HlPva5aRc7j6KHroEmoc3T9Io9w==
X-Received: by 2002:a63:8ac1:0:b0:3db:515d:76d2 with SMTP id y184-20020a638ac1000000b003db515d76d2mr18315027pgd.152.1652758406602;
        Mon, 16 May 2022 20:33:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b0015e8d4eb281sm5995338plm.203.2022.05.16.20.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:33:26 -0700 (PDT)
Date:   Mon, 16 May 2022 20:33:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <202205162032.5161269A45@keescook>
References: <20220517030024.3388355-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517030024.3388355-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:00:23PM -0700, Kees Cook wrote:
> GCC 12 is very sensitive about array checking, and views all negative
> array accesses as unsafe (a not unreasonable position). Redefine
> sched_class_highest in terms of its location from __begin_sched_classes,
> and redefine sched_class_lowest to the actual lowest sched class instead
> of one lower. This also means the for_class_range() must be redefined to
> be inclusive, which means its 1 caller must be adjusted to have its
> "lowest" argument bumped up one position. Silences this warning:
> 
> In file included from kernel/sched/core.c:81:
> kernel/sched/core.c: In function ‘set_rq_online.part.0’:
> kernel/sched/sched.h:2197:52: error: array subscript -1 is outside array bounds of ‘struct sched_class[44343134792571037]’
>  [-Werror=array-bounds]
>  2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
>       |                                                    ^
> kernel/sched/sched.h:2200:41: note: in definition of macro ‘for_class_range’
>  2200 |         for (class = (_from); class != (_to); class--)
>       |                                         ^~~
> kernel/sched/sched.h:2203:53: note: in expansion of macro ‘sched_class_lowest’
>  2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
>       |                                            ^~~~~~~~~~~~~~~~~~
> kernel/sched/core.c:9115:17: note: in expansion of macro ‘for_each_class’
>  9115 |                 for_each_class(class) {
>       |                 ^~~~~~~~~~~~~~
> kernel/sched/sched.h:2193:27: note: at offset -208 into object ‘__begin_sched_classes’ of size [0, 9223372036854775807]
>  2193 | extern struct sched_class __begin_sched_classes[];
>       |                           ^~~~~~~~~~~~~~~~~~~~~
> 
> The introduce and use of sched_class_higher() could just be a bare "+ 1",
> but this code's backwards walking and non-inclusive for loop was weird
> enough, it seemed back to explicitly describe the manipulation
> happening.

I just need to start today over. This should read:

 The introduction and use of sched_class_higher() could just be a bare
 "+ 1", but this code's backwards-walking and non-inclusive for loop was
 weird enough, it seemed best to explicitly describe the manipulation
 happening.

-- 
Kees Cook
