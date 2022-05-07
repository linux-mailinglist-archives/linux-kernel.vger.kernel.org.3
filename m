Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6751E8D9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383159AbiEGRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiEGRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:13:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD8220D9
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:09:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fv2so9662303pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yGDqiI6M0oNMw7HcvJNQVYcC7hsIU1lzszoW5YElTJg=;
        b=eMV+DSLNLZf3b1Jb6raZ9+YgZKg7GiSqUHxO5oTBQnhokBZ0WeRIyeeMzRLwlPNvJ1
         MN3b49gABY42OqTjEkiu0l+ikc+oXBj/VR2fI/a+4140XunBdYht74kU+pjkhj1ZTfiN
         fqNViDC14RlGXowyTsUjmChwjvv2wDSabU2uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yGDqiI6M0oNMw7HcvJNQVYcC7hsIU1lzszoW5YElTJg=;
        b=YvphaHubxCDttMEQyCW8PzHyU26TOc9ASlAXN7eyd3XkBvdsrj7T8LLbQYKDfseHuj
         w5EetRXikaA3vLFdJcGLgibZBCZMnQSrbg7IJBr6p9r+N7AhKten9CPpxE403/fGAxPo
         DQj/1+GZ3JjvBrZJrt7s5A2J2DxdDYgJ7ObYyg8zO/PP/YSVnfApxjfJeVw6yoMk02UX
         E0MqgHJLgFd4OFJIze7YbLkihPJ8ZBh0dtuz3/Bm5DHpidI8gev/S7iAvKbwRj6Ct1IA
         yOGKwNU7GmS/RKGOLbdRrXWEriRAJeID/Qm4Joy+w7I8qMVptt0glnPf1SgblH+VJ4LK
         beaA==
X-Gm-Message-State: AOAM533qHfxv4AqYIPHbT3wr6YEevVojl5dsuJeePcPImkPWhWnRXoqx
        IburD03wQY3GOuJTZQNfYjOrAQ==
X-Google-Smtp-Source: ABdhPJwYmw4MfCde7OfxjDOFYVMapchpHrCsIuXx1ab8QtGgj0AF/ndogJu9y+u+yuDEhruEnM9VrA==
X-Received: by 2002:a17:90b:610:b0:1d9:4008:cfee with SMTP id gb16-20020a17090b061000b001d94008cfeemr10304083pjb.71.1651943367413;
        Sat, 07 May 2022 10:09:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e30-20020a631e1e000000b003c14af5060asm5283963pge.34.2022.05.07.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 10:09:27 -0700 (PDT)
Date:   Sat, 7 May 2022 10:09:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v6 17/23] scripts: decode_stacktrace: demangle Rust
 symbols
Message-ID: <202205071006.6F651F6A@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-18-ojeda@kernel.org>
 <202205070122.B240F989@keescook>
 <CANiq72m6MaaH-o9McMuDwicosA2xgpU5ZEw0OduR0JT3w7p_fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m6MaaH-o9McMuDwicosA2xgpU5ZEw0OduR0JT3w7p_fQ@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 12:21:14PM +0200, Miguel Ojeda wrote:
>   - If we replace the mangled symbol, then some tools may not expect
> e.g. whitespace or other characters (which Rust demangled symbols
> have); or if they handle them, they may be expecting actual symbols
> (like in the case above) because they use them later on to correlate
> them to some other data.

Yeah. I think this is the fundamental issue, and it requires just
leaving it up to userspace. I don't see any significant benefits to any
of the other solutions.

Maybe some day we'll want demangling visible in traces, etc, but it
doesn't make sense to try to design that now. The mangled version is
existing-parser-safe.

-- 
Kees Cook
