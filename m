Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E94AB3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiBGFuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiBGCz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:55:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0839C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:55:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 192so10593291pfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 18:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Pa0V6uNmqfY1ryqz8Euha/wH0C0Ls7fitkB4Pk5MqA=;
        b=gRAy4PoGc6tworsSuNdh30bSZQIj9aWCyJMXg0AshOgRXWF3uHuOAwnvny2SfX5X9L
         kZ0MQf0StanDgY9gtsakTJJlP0m+u6Klf4IYOPKO1rIjoD10FJjy9pjQaW7ROoUUrOC6
         NPztgeTkHnfAGYppVDGgBG/GOze2NmDg+3Enw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Pa0V6uNmqfY1ryqz8Euha/wH0C0Ls7fitkB4Pk5MqA=;
        b=XGpKP2AvD60u+N0MhONkP5jAB4rDDLEJDlYkI2k848EAX6+jp1alaNUNzKrQVQ/Dwi
         yuS7FLOgrHGWy9Kwyy06pzxa0au57O/8RHWMRXXtFuVR9n6UlFs/e6c6NhJlNGBqjTcp
         9ji30bTuDFO0AbcZ0pt9HFEIibbFou4COTgIniHZ/wTZbj5dwGWIvbUpFl5lV5LsuOI+
         QAOcZGbueMIx/Dre8HD6RcoeK5sPoeG6YifShiv7i0uC2QpsQkgjRfFN8m1+FoFIEhrf
         IBvl1TTFvVEyzahqWA4p30uePee1aRhdeRST3/lbLPqxm+dcflM26Pri91UNs8L0uHrK
         jhuQ==
X-Gm-Message-State: AOAM530636lwtB751KRB0F+M4y7UgEzlpvJuZp6locdtpNtIC63+jqy1
        5Je3RFlxcC9jNgOTVrsEgpIL3w==
X-Google-Smtp-Source: ABdhPJwHPVPoUNs7X6rVF0qEiMM2Yz+rYinp0zhxBkrnP/OdvFlTr0vh4/W4vp+6BQZPaSJE/nM/WA==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr7729001pgs.284.1644202557293;
        Sun, 06 Feb 2022 18:55:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nv13sm9221650pjb.17.2022.02.06.18.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 18:55:56 -0800 (PST)
Date:   Sun, 6 Feb 2022 18:55:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <202202061854.B5B11282@keescook>
References: <20211111020738.2512932-1-seanjc@google.com>
 <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
 <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
 <202202061011.A255DE55B@keescook>
 <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 09:28:52PM +0100, Peter Zijlstra wrote:
> On Sun, Feb 06, 2022 at 10:45:15AM -0800, Kees Cook wrote:
> 
> > I'm digging through the macros to sort this out, but IIUC, an example of
> > the problem is:
> > 
> 
> > so the caller is expecting "unsigned int (*)(void)" but the prototype
> > of __static_call_return0 is "long (*)(void)":
> > 
> > long __static_call_return0(void);
> > 
> > Could we simply declare a type-matched ret0 trampoline too?
> 
> That'll work for this case, but the next case the function will have
> arguments we'll need even more nonsense...

Shouldn't the typeof() work there too, though? I.e. as long as the
return value can hold a "0", it'd work.

> And as stated in that other email, there's tb_stub_func() having the
> exact same problem as well.

Yeah, I'd need to go look at that again.

> The x86_64 CFI patches had a work-around for this, that could trivially
> be lifted I suppose.

Yeah, I think it'd be similar. I haven't had a chance to go look at that
again...

-- 
Kees Cook
