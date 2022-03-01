Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB44C8077
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiCABtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCABtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:49:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4F5B3F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:48:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so3755802ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdaEKJNXyehKmI6OZeRutyAexvnsM0OhIQCRJEZlx28=;
        b=hk62M/2R3BtupGl5Pb4JIGG6SEHCrWhREvCKfHTYpMBQ4qyhyY+4bK5b+KJJU+prb9
         jw2/VkjB829+5rxjhC8YKv2FW83z6j482i2qwn1Sq0qRLTW3HOGlTLaPuCIa64sdQ81F
         6HHA+4u8A39L+cEhNKhWdNpr6HcBlGxPaSH4+wuVJU/yiAvPZT1x+P19RzP0NJiTSqqd
         HTvyvR1g9rOPUbgaKmcGVAAIMAxR6leD35by1icaadxC09XUfXdMOykTBR0JUJDXqzKP
         V6NnInEOsPCBEJBhms88PsDL+DOV7tlECL4waxonwf7rH2nwCSmbrvFe6JU9fiKYefHu
         I4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdaEKJNXyehKmI6OZeRutyAexvnsM0OhIQCRJEZlx28=;
        b=gtSkQnA/C/4XavNd2CDxphlS+SrK4HdxlCw2+0HcAXeM2fXDXqWH6bUX0McMBxgbsK
         e4wZIJn/j4idvXKIkvKTmqSqBWcjyQYxVV6Gl2Y3kNZXvwlGDzHMSKnKPmR53bxdWfCw
         +lHN5r67Hs0COTE/1/DpbxZTT38dOpiQbI17zg0DeYMSuVyAu0/Uu5oEI8e8gEHYWgLM
         k3GmNy0WQUk4WJznlHD2ies/DbOWAq+VqOqJM1oCc3kiqfGAyBEucgFmJf4RuIKzpY24
         A4u4AptBixDIqqC/6yWc9RpvHM42d/+O1oNpXq0VzKf5k+iq6i11/LHqPxOY29bBzb/0
         dxyA==
X-Gm-Message-State: AOAM531xfiQFMUFSBZoxQH3ztoyeZZO/yYRODVEEkLa5Vg2XlvL04Af1
        VmomRFxImZEZsRMvFrQFykee+Aqx47rR87cxhDM22g==
X-Google-Smtp-Source: ABdhPJyJnxStim8LcjtJqPLQfafGeXLVGaK+Vyh2JMgcZlT8OZOQfzz8aTwShCHtjtoXEwTHtyCJSy/5UpDO1v71xzI=
X-Received: by 2002:a17:906:6d0b:b0:6d1:d64e:3142 with SMTP id
 m11-20020a1709066d0b00b006d1d64e3142mr17304749ejr.631.1646099318663; Mon, 28
 Feb 2022 17:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
 <202202232208.B416701@keescook> <20220224091550.2b7e8784@gandalf.local.home>
In-Reply-To: <20220224091550.2b7e8784@gandalf.local.home>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Feb 2022 17:48:27 -0800
Message-ID: <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 6:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 23 Feb 2022 22:13:25 -0800
> Kees Cook <keescook@chromium.org> wrote:
>
> > Steven, I want to do fancy live-patch kind or things to replace functions,
> > but it doesn't need to be particularly fancy because KUnit tests (usually)
> > run single-threaded, etc. It looks like kprobes could almost do it, but
> > I don't see a way to have it _avoid_ making a function call.
>
>
> // This is called just before the hijacked function is called
> static void notrace my_tramp(unsigned long ip, unsigned long parent_ip,
>                              struct ftrace_ops *ops,
>                              struct ftrace_regs *fregs)
> {
>         int bit;
>
>         bit = ftrace_test_recursion_trylock(ip, parent_ip);
>         if (WARN_ON_ONCE(bit < 0))
>                 return;
>
>         /*
>          * This uses the live kernel patching arch code to now return
>          * to new_function() instead of the one that was called.
>          * If you want to do a lookup, you can look at the "ip"
>          * which will give you the function you are about to replace.
>          * Note, it may not be equal to the function address,
>          * but for that, you can have this:
>          *   ip = ftrace_location(function_ip);
>          * which will give the ip that is passed here.
>          */
>         klp_arch_set_pc(fregs, new_function);

Ahah!
This was the missing bit.

David and I both got so excited by this we prototyped experimental
APIs around this over the weekend.
He also prototyped a more intrusive alternative to using ftrace and
kernel livepatch since they don't work on all arches, like UML.

We're splitting up responsibility and will each submit RFCs to the
list in the coming days.
I'll send the ftrace one based on this.
He'll send his alternative one as well.
I think we'll end up having both approaches as they both have their usecases.

It'll take some iteration to bikeshed stuff like names and make them
more consistent with each other.
I've posted my working copy on Gerrit for now, if people want to take
a look: https://kunit-review.googlesource.com/c/linux/+/5109

It should be visible publicly, but it will prompt you to sign in if
you try to post comments ;(
If anyone has comments before we send out the RFCs, feel free to email
me directly and CC kunit-dev@.

Thanks,
Daniel
