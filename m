Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F84F1DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387247AbiDDVm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380477AbiDDUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:16:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572E33A3A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:14:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so22295218ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUUk7OFCSPCB5GyGNVhqhstLIqQ+gg7+gCRlD8LRTzg=;
        b=evtN5Ymd6TUeFnb88vq4kB2tzMaxcWuJAb0Z1RzjYNSPtsqBwLoL2ReibbsSubwZyZ
         lh1S9mxuRJa2tblZsu2gXft4+zXX74RF/J+IiGBdnVpqMF4NzbaQyS4cxq/11TcFZXL+
         fToGIqANbKUxPohGySwdFySUlPUZSa5IiDn2uZ0VcjA4hIFUo+VblH3bPSIo00pHUuWW
         WtTQ0wJVAdur1KpycS//D20rhKZwZKRypoYyW2agHq6ha1kieGsIh9S8z5iqvRaUaTSP
         wUEc2kvqdCfPnSWQpcKLV3HcVjtKVgt8hye6T6WvE2yff24mDnIjgOR6FCfh3x311VTQ
         UWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUUk7OFCSPCB5GyGNVhqhstLIqQ+gg7+gCRlD8LRTzg=;
        b=Yj/4Eth9eznt1/CPkwsYgyevAai7uuKxjw+xuyyccG4NWgEjxag1Hi4DXGWm+Y2PVU
         /hJg0XfWUPDjmVnS4hH24aTz6y0RgPkwH6t6qpuo8Hrq1wNF6JR6T06yCrjmKtSt8DS+
         jxFpqCF7X//+rjEdlMsyyqHADGjagDg/uaOwqa02LcINccu5nA/RfAbAvaM5nRxDm3KH
         TepxIIUk7OhoShC2g5EkIJM6PeObjQ7zPhDpmwlTr6z1oixKlPQwKmEk+ugzKdc+OBNv
         8VSejrj4eEENGEEpFUaJGRZIw4dtyb/EsDmuTvcGk1w2FRADCd6VvO2ETQ9eOa6VV/B4
         CthA==
X-Gm-Message-State: AOAM5322V3gzs6n4O9zR4QFocKa81YqscW6glQhLqqMM97YZClbwFfqO
        icW1CGSXaYHPI+NKCleFR5NZq5idzvw0BnznV5QySg==
X-Google-Smtp-Source: ABdhPJxJWvLMKxuKPIlv4rL1p5904YgP+ll/m5WadMWg254EBW9hdE6W6p2VGRA3U7JM9nJJvG6svwFW7XSdYsrfFLw=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr1803033ejc.668.1649103270301; Mon, 04
 Apr 2022 13:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Apr 2022 16:14:19 -0400
Message-ID: <CAFd5g47p-1OAM8fgUdTCUTJ+5Tj0+wPfTgiNVQ_VccbLjUYyWg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] kunit: Support redirecting function calls
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Steve Muckle - since I think this might affect things he is working on.

On Thu, Mar 17, 2022 at 10:13 PM David Gow <davidgow@google.com> wrote:
>
> When writing tests, it'd often be very useful to be able to intercept
> calls to a function in the code being tested and replace it with a
> test-specific stub. This has always been an obviously missing piece of
> KUnit, and the solutions always involve some tradeoffs with cleanliness,
> performance, or impact on non-test code. See the folowing document for
> some of the challenges:
> https://kunit.dev/mocking.html
>
> This series consists of two prototype patches which add support for this
> sort of redirection to KUnit tests:
>
> 1: static_stub: Any function which might want to be intercepted adds a
> call to a macro which checks if a test has redirected calls to it, and
> calls the corresponding replacement.
>
> 2: ftrace_stub: Functions are intercepted using ftrace and livepatch.
> This doesn't require adding a new prologue to each function being
> replaced, but does have more dependencies (which restricts it to a small
> number of architectures, not including UML), and doesn't work well with
> inline functions.
>
> The API for both implementations is very similar, so it should be easy
> to migrate from one to the other if necessary.  Both of these
> implementations restrict the redirection to the test context: it is
> automatically undone after the KUnit test completes, and does not affect
> calls in other threads. If CONFIG_KUNIT is not enabled, there should be
> no overhead in either implementation.
>
> Does either (or both) of these features sound useful, and is this
> sort-of API the right model? (Personally, I think there's a reasonable
> scope for both.) Is anything obviously missing or wrong? Do the names,
> descriptions etc. make any sense?
>
> Note that these patches are definitely still at the "prototype" level,
> and things like error-handling, documentation, and testing are still
> pretty sparse. There is also quite a bit of room for optimisation.
> These'll all be improved for v1 if the concept seems good.
>
> Cheers,
> -- David
>
> Daniel Latypov (1):
>   kunit: expose ftrace-based API for stubbing out functions during tests
>
> David Gow (1):
>   kunit: Expose 'static stub' API to redirect functions
>
>  include/kunit/ftrace_stub.h         |  84 +++++++++++++++++
>  include/kunit/static_stub.h         | 106 +++++++++++++++++++++
>  lib/kunit/Kconfig                   |  11 +++
>  lib/kunit/Makefile                  |   5 +
>  lib/kunit/ftrace_stub.c             | 138 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-example-test.c      |  64 +++++++++++++
>  lib/kunit/static_stub.c             | 125 +++++++++++++++++++++++++
>  lib/kunit/stubs_example.kunitconfig |  11 +++
>  8 files changed, 544 insertions(+)
>  create mode 100644 include/kunit/ftrace_stub.h
>  create mode 100644 include/kunit/static_stub.h
>  create mode 100644 lib/kunit/ftrace_stub.c
>  create mode 100644 lib/kunit/static_stub.c
>  create mode 100644 lib/kunit/stubs_example.kunitconfig
>
> --
> 2.35.1.894.gb6a874cedc-goog
>
