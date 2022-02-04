Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA64A9DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376895AbiBDRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376900AbiBDRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:36:01 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A9C061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:36:00 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 124so20204116ybw.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyLfy4Dxm37OlH/M49r+dDaiFcR/y+/lQ3SW4Qp9TQg=;
        b=jOwooElC3fQwQWVC3MwtgG1xiGKscZ3GouURpYpw9onOil65CqRD+3AcEPPJEibimA
         u8AEVUs5rz5Wz6BHwti9PQXpcfLI99IyGB6W6iwskCt6ZonRllyvZMdBOF2l0xMFJKDB
         6DSpLCYGSBI45i/y4eRzSgv4LLw7GEkocNoWI9+OVAKZSjqH/1CloMYCyYL4chL3trz1
         fMSS9d3oAHMUy5GyN4u2BvbDtnZTcGdUwHj97p9ljekfc29gShtw2SPPRfolTAGQXZdg
         z7jm0rMn4mKXjtsmxvlFMwxOmSDtqGC0LffclclC9WMAk0HsuNMHRkxlmn/O7/X5JzQy
         Cnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyLfy4Dxm37OlH/M49r+dDaiFcR/y+/lQ3SW4Qp9TQg=;
        b=416Xj3m3BG9go83mfJ+tsBUKiMUi52DiArZ+X5NE8BFV/s5qwLoz1hk3WbRXrPvmm/
         c8fVfyrSoYLMnwirCfSTliHYrTjU5NOlZLotxwg2Wy3MG3WXjm9JDrsFeatzDZ4Dty/X
         lnApGPU3NoGeA691DoxF8cbvSz7f9NGQQB3xJa8KYv9bhYnxmPxejtcuu8xCo+YTVlJI
         iFCxi82JnwhnDzcYGOycidFrAxYw/J5RQKKGmcYSMnPgOM3BcQRSDXOdli0v/83l9V4c
         2gZ01XorsXBnO9w9Q8B92j/A9Hul6PJn4M8+HwS4snA0vXtGkvuK0/5CSY2NFAwfUALs
         mopQ==
X-Gm-Message-State: AOAM530G2MOwHqryfIXToIR6wtl5wbCydo39dKpgUHjMw4R4t7v45GUs
        IehxRRe0ECh8QDKSjo8rSgH2yDIzPzWri0ZQnlITuA==
X-Google-Smtp-Source: ABdhPJyOuH/xsfHATqvWwkAHVOssf+KzvqDIGJLV+nRclvMzKT1C9hxOlnyCwYh8reroGVnT571LCyViKkMZtG6Mb0U=
X-Received: by 2002:a81:9f08:: with SMTP id s8mr3434556ywn.291.1643996159883;
 Fri, 04 Feb 2022 09:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20211111020738.2512932-1-seanjc@google.com> <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
In-Reply-To: <YfrQzoIWyv9lNljh@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 4 Feb 2022 09:35:49 -0800
Message-ID: <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize perf_guest_info_callbacks
To:     Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:43 AM Sean Christopherson <seanjc@google.com> wrote:
> > +DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
> > +DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
> > +DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
>
> Using __static_call_return0() makes clang's CFI sad on arm64 due to the resulting
> function prototype mistmatch, which IIUC, is verified by clang's __cfi_check()
> for indirect calls, i.e. architectures without CONFIG_HAVE_STATIC_CALL.
>
> We could fudge around the issue by using stubs, massaging prototypes, etc..., but
> that means doing that for every arch-agnostic user of __static_call_return0().
>
> Any clever ideas?  Can we do something like generate a unique function for every
> DEFINE_STATIC_CALL_RET0 for CONFIG_HAVE_STATIC_CALL=n, e.g. using typeof() to
> get the prototype?

I'm not sure there's a clever fix for this. On architectures without
HAVE_STATIC_CALL, this is an indirect call to a function with a
mismatching type, which CFI is intended to catch.

The obvious way to solve the problem would be to use a stub function
with the correct type, which I agree, isn't going to scale. You can
alternatively check if .func points to __static_call_return0 and not
make the indirect call if it does. If neither of these options are
feasible, you can disable CFI checking in the functions that have
these static calls using the __nocfi attribute.

Kees, any thoughts?

Sami
